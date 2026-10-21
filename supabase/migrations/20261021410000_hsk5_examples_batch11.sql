-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 11 (100 TỪ TIẾP THEO)
-- Phạm vi: #3002 [胜利] (shènglì) -> #3101 [台灯] (táidēng)
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
  -- [3002] [胜利] (shènglì) - thắng lợi, chiến thắng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '胜利' AND pinyin = 'shènglì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胜利' AND pinyin = 'shènglì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '胜利'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胜利'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shènglì',
      meaning_vi = 'thắng lợi, chiến thắng',
      example_hanzi = '经过顽强拼搏，校足球队在比赛最后一分钟攻入制胜进球并赢得了胜利。',
      example_pinyin = 'Jīngguò wánqiáng pīnbó, xiào zúqiúduì zài bǐsài zuìhòu yì fēnzhōng gōngrù zhìshèng jìnqiú bìng yíngdé le shènglì.',
      example_vi = 'Trải qua nỗ lực chiến đấu kiên cường, đội bóng đá của trường đã ghi bàn thắng quyết định ở phút cuối cùng của trận đấu và giành được thắng lợi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '胜利',
      'shènglì',
      'thắng lợi, chiến thắng',
      'Động từ / Danh từ',
      'HSK 5',
      '经过顽强拼搏，校足球队在比赛最后一分钟攻入制胜进球并赢得了胜利。',
      'Jīngguò wánqiáng pīnbó, xiào zúqiúduì zài bǐsài zuìhòu yì fēnzhōng gōngrù zhìshèng jìnqiú bìng yíngdé le shènglì.',
      'Trải qua nỗ lực chiến đấu kiên cường, đội bóng đá của trường đã ghi bàn thắng quyết định ở phút cuối cùng của trận đấu và giành được thắng lợi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过顽强拼搏，校足球队在比赛最后一分钟攻入制胜进球并赢得了胜利。', 'Jīngguò wánqiáng pīnbó, xiào zúqiúduì zài bǐsài zuìhòu yì fēnzhōng gōngrù zhìshèng jìnqiú bìng yíngdé le shènglì.', 'Trải qua nỗ lực chiến đấu kiên cường, đội bóng đá của trường đã ghi bàn thắng quyết định ở phút cuối cùng của trận đấu và giành được thắng lợi.', 'basic', 1),
      (v_id, '在抗击世纪疫情与恢复经济增长的复杂大考中，全体人民同舟共济赢得了决定性胜利。', 'Zài kàngjī shìjì yiqíng yǔ huīfù jīngjì zēngzhǎng de fùzá dàkǎo zhōng, quántǐ rénmín tóngzhōu-gòngjì yíngdé le juédìngxìng shènglì.', 'Trong cuộc sát hạch cam go phức tạp về đẩy lùi đại dịch thế kỷ và phục hồi tăng trưởng kinh tế, toàn thể nhân dân đồng lòng kề vai sát cánh đã giành được thắng lợi mang tính quyết định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3003] [诗] (shī) - thơ ca, bài thơ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '诗' AND pinyin = 'shī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '诗' AND pinyin = 'shī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '诗'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '诗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shī',
      meaning_vi = 'thơ ca, bài thơ',
      example_hanzi = '语文老师要求同学们有感情地朗诵唐代大诗人李白的经典诗篇。',
      example_pinyin = 'Yǔwén lǎoshī yāoqiú tóngxuémen yǒu gǎnqíng de lǎngsòng Tángdài dà shīrén Lǐ Bái de jīngdiǎn shīpiān.',
      example_vi = 'Thầy giáo dạy ngữ văn yêu cầu các bạn học sinh diễn cảm ngâm đọc các bài thơ kinh điển của đại thi hào Lý Bạch thời Đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '诗',
      'shī',
      'thơ ca, bài thơ',
      'Danh từ',
      'HSK 5',
      '语文老师要求同学们有感情地朗诵唐代大诗人李白的经典诗篇。',
      'Yǔwén lǎoshī yāoqiú tóngxuémen yǒu gǎnqíng de lǎngsòng Tángdài dà shīrén Lǐ Bái de jīngdiǎn shīpiān.',
      'Thầy giáo dạy ngữ văn yêu cầu các bạn học sinh diễn cảm ngâm đọc các bài thơ kinh điển của đại thi hào Lý Bạch thời Đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '语文老师要求同学们有感情地朗诵唐代大诗人李白的经典诗篇。', 'Yǔwén lǎoshī yāoqiú tóngxuémen yǒu gǎnqíng de lǎngsòng Tángdài dà shīrén Lǐ Bái de jīngdiǎn shīpiān.', 'Thầy giáo dạy ngữ văn yêu cầu các bạn học sinh diễn cảm ngâm đọc các bài thơ kinh điển của đại thi hào Lý Bạch thời Đường.', 'basic', 1),
      (v_id, '中国古典诗词以格律严谨、意象深邃与气象万千著称，是中华优秀传统文化中最璀璨的艺术瑰宝。', 'Zhōngguó gǔdiǎn shīcí yǐ gélǜ yánjǐn, yìxiàng shēnsuì yǔ qìxiàng-wànqiān zhùchēng, shì Zhōnghuá yōuxiù chuántǒng wénhuà zhōng zuì cuǐcàn de yìshù guībǎo.', 'Thơ từ cổ điển Trung Hoa nổi tiếng bởi cách luật nghiêm cẩn, hình tượng ý niệm thâm thúy và khí tượng muôn màu muôn vẻ, là viên ngọc quý nghệ thuật rực rỡ nhất trong nền văn hóa truyền thống xuất sắc của Trung Hoa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3004] [湿] (shī) - ẩm ướt, ướt át [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '湿' AND pinyin = 'shī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '湿' AND pinyin = 'shī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '湿'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '湿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shī',
      meaning_vi = 'ẩm ướt, ướt át',
      example_hanzi = '今天下了一整天暴雨，路面很湿，开车外出一定要减速慢行。',
      example_pinyin = 'Jīntiān xià le yì zhěng tiān bàoyǔ, lùmiàn hěn shī, kāichē wàichū yídìng yào jiǎnsù mànxíng.',
      example_vi = 'Hôm nay trời đổ mưa to suốt cả ngày, mặt đường rất ướt, lái xe ra ngoài nhất định phải giảm tốc độ đi chậm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '湿',
      'shī',
      'ẩm ướt, ướt át',
      'Tính từ',
      'HSK 5',
      '今天下了一整天暴雨，路面很湿，开车外出一定要减速慢行。',
      'Jīntiān xià le yì zhěng tiān bàoyǔ, lùmiàn hěn shī, kāichē wàichū yídìng yào jiǎnsù mànxíng.',
      'Hôm nay trời đổ mưa to suốt cả ngày, mặt đường rất ướt, lái xe ra ngoài nhất định phải giảm tốc độ đi chậm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天下了一整天暴雨，路面很湿，开车外出一定要减速慢行。', 'Jīntiān xià le yì zhěng tiān bàoyǔ, lùmiàn hěn shī, kāichē wàichū yídìng yào jiǎnsù mànxíng.', 'Hôm nay trời đổ mưa to suốt cả ngày, mặt đường rất ướt, lái xe ra ngoài nhất định phải giảm tốc độ đi chậm.', 'basic', 1),
      (v_id, '沿海地区夏秋季节气候湿热，工业仓储必须严格实施温湿度智能监控以防止高精密精密元器件受潮霉变。', 'Yánhǎi dìqū xiàqiū jìjié qìhòu shīrè, gōngyè cāngchǔ bìxū yángé shíshī wēn-shīdù zhìnéng jiānkòng yǐ fángzhǐ gāo-jīngmì jīngmì yuánqìjiàn shòucháo méibiàn.', 'Khu vực ven biển vào mùa hè thu khí hậu nóng ẩm, kho bãi công nghiệp bắt buộc phải thực thi giám sát thông minh nhiệt độ và độ ẩm nghiêm ngặt để chống các linh kiện siêu chính xác bị ẩm mốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3005] [失恋] (shīliàn) - thất tình, chia tay người yêu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '失恋' AND pinyin = 'shīliàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '失恋' AND pinyin = 'shīliàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '失恋'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '失恋'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shīliàn',
      meaning_vi = 'thất tình, chia tay người yêu',
      example_hanzi = '面对失恋的痛苦，朋友们纷纷陪在他身边给予温暖的开导和安慰。',
      example_pinyin = 'Miànduì shīliàn de tòngkǔ, péngyoumen fēnfēn péi zài tā shēnbiān jǐyǔ wēnnuǎn de kāidǎo hé ānwèi.',
      example_vi = 'Đối mặt với nỗi đau thất tình, bạn bè tới tấp ở bên cạnh anh ấy để sẻ chia khuyên nhủ và an ủi ấm áp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '失恋',
      'shīliàn',
      'thất tình, chia tay người yêu',
      'Động từ',
      'HSK 5',
      '面对失恋的痛苦，朋友们纷纷陪在他身边给予温暖的开导和安慰。',
      'Miànduì shīliàn de tòngkǔ, péngyoumen fēnfēn péi zài tā shēnbiān jǐyǔ wēnnuǎn de kāidǎo hé ānwèi.',
      'Đối mặt với nỗi đau thất tình, bạn bè tới tấp ở bên cạnh anh ấy để sẻ chia khuyên nhủ và an ủi ấm áp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对失恋的痛苦，朋友们纷纷陪在他身边给予温暖的开导和安慰。', 'Miànduì shīliàn de tòngkǔ, péngyoumen fēnfēn péi zài tā shēnbiān jǐyǔ wēnnuǎn de kāidǎo hé ānwèi.', 'Đối mặt với nỗi đau thất tình, bạn bè tới tấp ở bên cạnh anh ấy để sẻ chia khuyên nhủ và an ủi ấm áp.', 'basic', 1),
      (v_id, '青年心理健康咨询中心开设情绪辅导专线，引导年轻人理性看待失恋挫折并重塑健康的自我认同。', 'Qīngnián xīnlǐ jiànkāng zīxún zhōngxīn kāishè qíngxù fǔdǎo zhuānxiàn, yǐndǎo niánqīngrén lǐxìng kàndài shīliàn cuòzhé bìng chóngshù jiànkāng de zìwǒ rèntóng.', 'Trung tâm tư vấn sức khỏe tâm lý thanh niên mở đường dây nóng hướng dẫn cảm xúc, định hướng người trẻ nhìn nhận trắc trở thất tình một cách lý trí và tái định hình sự tự công nhận bản thân lành mạnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3006] [失眠] (shīmián) - mất ngủ, khó ngủ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '失眠' AND pinyin = 'shīmián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '失眠' AND pinyin = 'shīmián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '失眠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '失眠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shīmián',
      meaning_vi = 'mất ngủ, khó ngủ',
      example_hanzi = '最近由于期末备考压力较大，他连续好几天都处于失眠状态。',
      example_pinyin = 'Zuìjìn yóuyú qīmò bèikǎo yālì jiào dà, tā liánxù hǎo jǐ tiān dōu chǔyú shīmián zhuàngtài.',
      example_vi = 'Gần đây do áp lực ôn thi học kỳ khá lớn, anh ấy đã trải qua tình trạng mất ngủ suốt mấy ngày liền.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '失眠',
      'shīmián',
      'mất ngủ, khó ngủ',
      'Động từ',
      'HSK 5',
      '最近由于期末备考压力较大，他连续好几天都处于失眠状态。',
      'Zuìjìn yóuyú qīmò bèikǎo yālì jiào dà, tā liánxù hǎo jǐ tiān dōu chǔyú shīmián zhuàngtài.',
      'Gần đây do áp lực ôn thi học kỳ khá lớn, anh ấy đã trải qua tình trạng mất ngủ suốt mấy ngày liền.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '最近由于期末备考压力较大，他连续好几天都处于失眠状态。', 'Zuìjìn yóuyú qīmò bèikǎo yālì jiào dà, tā liánxù hǎo jǐ tiān dōu chǔyú shīmián zhuàngtài.', 'Gần đây do áp lực ôn thi học kỳ khá lớn, anh ấy đã trải qua tình trạng mất ngủ suốt mấy ngày liền.', 'basic', 1),
      (v_id, '现代快节奏高压职场环境引发慢性失眠群体比例攀升，医学专家建议通过睡眠卫生行为干预配合昼夜节律调节。', 'Xiàndài kuài-jiézòu gāoyā zhíchǎng huánjìng yǐnfā mànxìng shīmián qúntǐ bǐlì pānshēng, yīxué zhuānjiā jiànyì tōngguò shuìmián wèishēng xíngwéi gānyù pèihé zhòuyè jiélǜ tiáojié.', 'Môi trường nơi làm việc áp lực cao nhịp độ gấp gáp hiện đại khiến tỷ lệ nhóm người mất ngủ mãn tính tăng vọt, các chuyên gia y học khuyến nghị can thiệp hành vi vệ sinh giấc ngủ kết hợp điều hòa nhịp điệu sinh học ngày đêm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3007] [诗人] (shīrén) - nhà thơ, thi sĩ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '诗人' AND pinyin = 'shīrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '诗人' AND pinyin = 'shīrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '诗人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '诗人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shīrén',
      meaning_vi = 'nhà thơ, thi sĩ',
      example_hanzi = '这位当代诗人用质朴动人的语言，抒发了对故土乡村深沉的眷恋。',
      example_pinyin = 'Zhè wèi dāngdài shīrén yòng zhìpǔ dòngrén de yǔyán, shūfā le duì gùtǔ xiāngcūn shēnchén de juànliàn.',
      example_vi = 'Nhà thơ đương đại này đã dùng ngôn từ mộc mạc lay động lòng người để bày tỏ nỗi luyến lưu sâu nặng đối với mảnh đất quê hương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '诗人',
      'shīrén',
      'nhà thơ, thi sĩ',
      'Danh từ',
      'HSK 5',
      '这位当代诗人用质朴动人的语言，抒发了对故土乡村深沉的眷恋。',
      'Zhè wèi dāngdài shīrén yòng zhìpǔ dòngrén de yǔyán, shūfā le duì gùtǔ xiāngcūn shēnchén de juànliàn.',
      'Nhà thơ đương đại này đã dùng ngôn từ mộc mạc lay động lòng người để bày tỏ nỗi luyến lưu sâu nặng đối với mảnh đất quê hương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位当代诗人用质朴动人的语言，抒发了对故土乡村深沉的眷恋。', 'Zhè wèi dāngdài shīrén yòng zhìpǔ dòngrén de yǔyán, shūfā le duì gùtǔ xiāngcūn shēnchén de juànliàn.', 'Nhà thơ đương đại này đã dùng ngôn từ mộc mạc lay động lòng người để bày tỏ nỗi luyến lưu sâu nặng đối với mảnh đất quê hương.', 'basic', 1),
      (v_id, '古代爱国诗人屈原在《离骚》中展现的崇高人格追求与忧国忧民情怀，成为千百年来激励中华民族自强不息的精神图腾。', 'Gǔdài àiguó shīrén Qū Yuán zài 《Lí Sāo》 zhōng zhǎnxiàn de chónggāo réngé zhuīqiú yǔ yōuguó-yōumín qínghuái, chéngwéi qiānbǎinián lái jīlì Zhōnghuá mínzú zìqiáng-bùxī de jīngshén túténg.', 'Khát vọng nhân cách cao thượng cùng tấm lòng ưu quốc ưu dân mà nhà thơ yêu nước cổ đại Khuất Nguyên thể hiện trong tác phẩm "Ly Tao" đã trở thành biểu tượng tinh thần cổ vũ dân tộc Trung Hoa tự cường không ngừng nghỉ suốt hàng ngàn năm qua.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3008] [失误] (shīwù) - sai sót, sơ suất, lỗi lầm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '失误' AND pinyin = 'shīwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '失误' AND pinyin = 'shīwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '失误'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '失误'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shīwù',
      meaning_vi = 'sai sót, sơ suất, lỗi lầm',
      example_hanzi = '在正式提交财务报表之前，会计师反复核对数据以防出现计算失误。',
      example_pinyin = 'Zài zhèngshì tíjiāo cáiwù bàobiǎo zhīqián, kuàijìshī fǎnfù héduì shùjù yǐ fáng chūxiàn jìsuàn shīwù.',
      example_vi = 'Trước khi chính thức nộp báo cáo tài chính, kế toán viên đã kiểm tra đối chiếu dữ liệu nhiều lần để phòng ngừa sai sót tính toán.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '失误',
      'shīwù',
      'sai sót, sơ suất, lỗi lầm',
      'Động từ / Danh từ',
      'HSK 5',
      '在正式提交财务报表之前，会计师反复核对数据以防出现计算失误。',
      'Zài zhèngshì tíjiāo cáiwù bàobiǎo zhīqián, kuàijìshī fǎnfù héduì shùjù yǐ fáng chūxiàn jìsuàn shīwù.',
      'Trước khi chính thức nộp báo cáo tài chính, kế toán viên đã kiểm tra đối chiếu dữ liệu nhiều lần để phòng ngừa sai sót tính toán.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在正式提交财务报表之前，会计师反复核对数据以防出现计算失误。', 'Zài zhèngshì tíjiāo cáiwù bàobiǎo zhīqián, kuàijìshī fǎnfù héduì shùjù yǐ fáng chūxiàn jìsuàn shīwù.', 'Trước khi chính thức nộp báo cáo tài chính, kế toán viên đã kiểm tra đối chiếu dữ liệu nhiều lần để phòng ngừa sai sót tính toán.', 'basic', 1),
      (v_id, '大型化工与高风险轨道交通调度系统必须设立多重冗余容错机制，将人为操作失误带来的安全隐患降至零。', 'Dàxíng huàgōng yǔ gāo-fēngxiǎn guǐdào jiāotōng diàodù xìtǒng bìxū shèlì duōchóng rǒngyú róngcuò jīzhì, jiāng rénwéi cāozuò shīwù dài lái de ānquán yǐnhuàn jiàng zhì líng.', 'Hệ thống điều độ giao thông đường sắt rủi ro cao và hóa chất quy mô lớn bắt buộc phải thiết lập cơ chế chịu lỗi dự phòng đa tầng, hạ thấp nguy cơ mất an toàn do sơ suất thao tác con người gây ra về mức bằng không.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3009] [失业] (shīyè) - thất nghiệp, mất việc làm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '失业' AND pinyin = 'shīyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '失业' AND pinyin = 'shīyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '失业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '失业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shīyè',
      meaning_vi = 'thất nghiệp, mất việc làm',
      example_hanzi = '政府设立了专门的再就业服务中心，帮助失业人员免费参加技能培训。',
      example_pinyin = 'Zhèngfǔ shèlì le zhuānmén de zàijiùyè fúwù zhōngxīn, bāngzhù shīyè rényuán miǎnfèi cānjiā jìnéng péixùn.',
      example_vi = 'Chính quyền đã thành lập trung tâm dịch vụ tái tạo việc làm chuyên trách, hỗ trợ người thất nghiệp tham gia các khóa đào tạo kỹ năng nghề miễn phí.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '失业',
      'shīyè',
      'thất nghiệp, mất việc làm',
      'Động từ',
      'HSK 5',
      '政府设立了专门的再就业服务中心，帮助失业人员免费参加技能培训。',
      'Zhèngfǔ shèlì le zhuānmén de zàijiùyè fúwù zhōngxīn, bāngzhù shīyè rényuán miǎnfèi cānjiā jìnéng péixùn.',
      'Chính quyền đã thành lập trung tâm dịch vụ tái tạo việc làm chuyên trách, hỗ trợ người thất nghiệp tham gia các khóa đào tạo kỹ năng nghề miễn phí.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '政府设立了专门的再就业服务中心，帮助失业人员免费参加技能培训。', 'Zhèngfǔ shèlì le zhuānmén de zàijiùyè fúwù zhōngxīn, bāngzhù shīyè rényuán miǎnfèi cānjiā jìnéng péixùn.', 'Chính quyền đã thành lập trung tâm dịch vụ tái tạo việc làm chuyên trách, hỗ trợ người thất nghiệp tham gia các khóa đào tạo kỹ năng nghề miễn phí.', 'basic', 1),
      (v_id, '宏观经济政策强化就业优先导向，通过减税降费与援企稳岗等综合举措有效防范化解摩擦性与结构性失业风险。', 'Hóngguān jīngjì zhèngcè qiánghuà jiùyè yōuxiān dǎoxiàng, tōngguò jiǎnshuì-jiàngfèi yǔ yuánqǐ-wěngǎng děng zōnghé jǔcuò yǒuxiào fángfàn huàjiě mócāxìng yǔ jiégòuxìng shīyè fēngxiǎn.', 'Chính sách kinh tế vĩ mô củng cố định hướng ưu tiên việc làm, thông qua các giải pháp tổng hợp như giảm thuế giảm phí và hỗ trợ doanh nghiệp giữ việc làm để phòng ngừa và hóa giải hữu hiệu rủi ro thất nghiệp cơ cấu và thất nghiệp ma sát.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3010] [时差] (shíchā) - chênh lệch múi giờ, mệt mỏi do lệch múi giờ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '时差' AND pinyin = 'shíchā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时差' AND pinyin = 'shíchā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '时差'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时差'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shíchā',
      meaning_vi = 'chênh lệch múi giờ, mệt mỏi do lệch múi giờ',
      example_hanzi = '刚从欧洲坐长途飞机回国，这两天他一直在努力倒时差。',
      example_pinyin = 'Gāng cóng Ōuzhōu zuò chángtú fēijī huíguó, zhè liǎng tiān tā yìzhí zài nǔlì dǎo shíchā.',
      example_vi = 'Vừa đi chuyến bay đường dài từ châu Âu trở về nước, suốt hai ngày nay anh ấy luôn cố gắng thích nghi để đổi múi giờ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '时差',
      'shíchā',
      'chênh lệch múi giờ, mệt mỏi do lệch múi giờ',
      'Danh từ',
      'HSK 5',
      '刚从欧洲坐长途飞机回国，这两天他一直在努力倒时差。',
      'Gāng cóng Ōuzhōu zuò chángtú fēijī huíguó, zhè liǎng tiān tā yìzhí zài nǔlì dǎo shíchā.',
      'Vừa đi chuyến bay đường dài từ châu Âu trở về nước, suốt hai ngày nay anh ấy luôn cố gắng thích nghi để đổi múi giờ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '刚从欧洲坐长途飞机回国，这两天他一直在努力倒时差。', 'Gāng cóng Ōuzhōu zuò chángtú fēijī huíguó, zhè liǎng tiān tā yìzhí zài nǔlì dǎo shíchā.', 'Vừa đi chuyến bay đường dài từ châu Âu trở về nước, suốt hai ngày nay anh ấy luôn cố gắng thích nghi để đổi múi giờ.', 'basic', 1),
      (v_id, '跨大洲分布式跨国研发团队充分利用跨时区时差优势，构建了全天候二十四小时接力式的敏捷协作工作流。', 'Kuà dàzhōu fēnbùshì kuàguó yánfā tuánduì chōngfèn lìyòng kuà-shíqū shíchā yōushì, gòujiàn le quán-tiānhòu èrshísì xiǎoshí jiēlìshì de mǐnjié xiézuò gōngzuòliú.', 'Đội ngũ nghiên cứu phát triển xuyên quốc gia phân tán đa châu lục đã tận dụng triệt để lợi thế chênh lệch múi giờ liên múi giờ, xây dựng luồng công việc cộng tác linh hoạt dạng chạy tiếp sức suốt 24 giờ ngày đêm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3011] [时常] (shícháng) - thường thường, thỉnh thoảng, hay [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '时常' AND pinyin = 'shícháng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时常' AND pinyin = 'shícháng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '时常'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时常'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'shícháng',
      meaning_vi = 'thường thường, thỉnh thoảng, hay',
      example_hanzi = '离家在外工作的游子，心里时常惦记着家乡年迈的父母。',
      example_pinyin = 'Lí jiā zài wài gōngzuò de yóuzǐ, xīn lǐ shícháng diànjì zhe jiāxiāng niánmài de fùmǔ.',
      example_vi = 'Người con xa nhà đi làm nơi đất khách, trong lòng thường hay đau đáu nhớ về cha mẹ già nơi quê nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '时常',
      'shícháng',
      'thường thường, thỉnh thoảng, hay',
      'Phó từ',
      'HSK 5',
      '离家在外工作的游子，心里时常惦记着家乡年迈的父母。',
      'Lí jiā zài wài gōngzuò de yóuzǐ, xīn lǐ shícháng diànjì zhe jiāxiāng niánmài de fùmǔ.',
      'Người con xa nhà đi làm nơi đất khách, trong lòng thường hay đau đáu nhớ về cha mẹ già nơi quê nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '离家在外工作的游子，心里时常惦记着家乡年迈的父母。', 'Lí jiā zài wài gōngzuò de yóuzǐ, xīn lǐ shícháng diànjì zhe jiāxiāng niánmài de fùmǔ.', 'Người con xa nhà đi làm nơi đất khách, trong lòng thường hay đau đáu nhớ về cha mẹ già nơi quê nhà.', 'basic', 1),
      (v_id, '优秀的科研工作者时常反躬自问自己的研究方向是否真正面向国家重大战略需求与世界前沿难题。', 'Yōuxiù de kēyán gōngzuòzhě shícháng fǎngōng-zìwèn zìjǐ de yánjiū fāngxiàng shìfǒu zhēnzhèng miànxiàng guójiā zhòngdà zhànlüè xūqiú yǔ shìjiè qiányán nándiǎn.', 'Những nhà nghiên cứu khoa học xuất sắc thường xuyên tự vấn bản thân xem hướng nghiên cứu của mình liệu đã thực sự hướng tới các nhu cầu chiến lược trọng đại của quốc gia và bài toán hóc búa mũi nhọn của thế giới hay chưa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3012] [时代] (shídài) - thời đại, kỷ nguyên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '时代' AND pinyin = 'shídài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时代' AND pinyin = 'shídài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '时代'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时代'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shídài',
      meaning_vi = 'thời đại, kỷ nguyên',
      example_hanzi = '智能手机的普及标志着移动互联网时代已经全面到来。',
      example_pinyin = 'Zhìnéng shǒujī de pǔjí biāozhì zhe yídòng hùliánwǎng shídài yǐjīng quánmiàn dàolái.',
      example_vi = 'Sự phổ cập của điện thoại thông minh đánh dấu thời đại Internet di động đã hoàn toàn gõ cửa cuộc sống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '时代',
      'shídài',
      'thời đại, kỷ nguyên',
      'Danh từ',
      'HSK 5',
      '智能手机的普及标志着移动互联网时代已经全面到来。',
      'Zhìnéng shǒujī de pǔjí biāozhì zhe yídòng hùliánwǎng shídài yǐjīng quánmiàn dàolái.',
      'Sự phổ cập của điện thoại thông minh đánh dấu thời đại Internet di động đã hoàn toàn gõ cửa cuộc sống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '智能手机的普及标志着移动互联网时代已经全面到来。', 'Zhìnéng shǒujī de pǔjí biāozhì zhe yídòng hùliánwǎng shídài yǐjīng quánmiàn dàolái.', 'Sự phổ cập của điện thoại thông minh đánh dấu thời đại Internet di động đã hoàn toàn gõ cửa cuộc sống.', 'basic', 1),
      (v_id, '站在数字化与低碳化交织的全新历史时代节点，广大青年科技人员当勇立潮头担负起科技强国的历史重任。', 'Zhàn zài shùzìhuà yǔ dītànhuà jiāozhī de quánxīn lìshǐ shídài jiédiǎn, guǎngdà qīngnián kējì rényuán dāng yǒnglì-cháotóu dānfù qǐ kējì qiángguó de lìshǐ zhòngrèn.', 'Đứng tại nút giao thời đại lịch sử hoàn toàn mới đan xen giữa số hóa và ít carbon, đông đảo nhân sự khoa học công nghệ trẻ tuổi cần phải dũng cảm đứng đầu ngọn sóng gánh vác trọng trách lịch sử đưa đất nước hùng cường bằng khoa học công nghệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3013] [实践] (shíjiàn) - thực tiễn; thực hành, đem ra thực tế [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实践' AND pinyin = 'shíjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实践' AND pinyin = 'shíjiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实践'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实践'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shíjiàn',
      meaning_vi = 'thực tiễn; thực hành, đem ra thực tế',
      example_hanzi = '只有把书本上学到的理论知识运用到工作实践中，才能转化为真正的能力。',
      example_pinyin = 'Zhǐyǒu bǎ shūběn shang xué dào de lǐlùn zhīshi yùnyòng dào gōngzuò shíjiàn zhōng, cái néng zhuǎnhuà wèi zhēnzhèng de nénglì.',
      example_vi = 'Chỉ khi vận dụng kiến thức lý thuyết đã học trong sách vở vào thực tiễn công việc thì mới có thể chuyển hóa thành năng lực thực sự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实践',
      'shíjiàn',
      'thực tiễn; thực hành, đem ra thực tế',
      'Động từ / Danh từ',
      'HSK 5',
      '只有把书本上学到的理论知识运用到工作实践中，才能转化为真正的能力。',
      'Zhǐyǒu bǎ shūběn shang xué dào de lǐlùn zhīshi yùnyòng dào gōngzuò shíjiàn zhōng, cái néng zhuǎnhuà wèi zhēnzhèng de nénglì.',
      'Chỉ khi vận dụng kiến thức lý thuyết đã học trong sách vở vào thực tiễn công việc thì mới có thể chuyển hóa thành năng lực thực sự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只有把书本上学到的理论知识运用到工作实践中，才能转化为真正的能力。', 'Zhǐyǒu bǎ shūběn shang xué dào de lǐlùn zhīshi yùnyòng dào gōngzuò shíjiàn zhōng, cái néng zhuǎnhuà wèi zhēnzhèng de nénglì.', 'Chỉ khi vận dụng kiến thức lý thuyết đã học trong sách vở vào thực tiễn công việc thì mới có thể chuyển hóa thành năng lực thực sự.', 'basic', 1),
      (v_id, '实践是检验真理的唯一标准，任何宏观经济制度设计与重大改革举措都必须经过一线社会实践的实证检验。', 'Shíjiàn shì jiǎnyàn zhēnlǐ de wéiyī biāozhǔn, rènhé hóngguān jīngjì zhìdù shèjì yǔ zhòngdà gǎigé jǔcuò dōu bìxū jīngguò yíxiàn shèhuì shíjiàn de shízhèng jiǎnyàn.', 'Thực tiễn là tiêu chuẩn duy nhất để kiểm nghiệm chân lý, bất kỳ thiết kế thể chế kinh tế vĩ mô và biện pháp cải cách trọng đại nào cũng bắt buộc phải trải qua sự kiểm nghiệm thực chứng của thực tiễn xã hội tuyến đầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3014] [时刻] (shíkè) - thời khắc, thời điểm; luôn luôn, từng giờ từng phút [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '时刻' AND pinyin = 'shíkè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时刻' AND pinyin = 'shíkè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '时刻'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时刻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Phó từ',
      pinyin = 'shíkè',
      meaning_vi = 'thời khắc, thời điểm; luôn luôn, từng giờ từng phút',
      example_hanzi = '在比赛进入最后倒计时的关键时刻，队长沉着投中了压哨三分球。',
      example_pinyin = 'Zài bǐsài jìnrù zuìhòu dàojìshí de guānjiàn shíkè, duìzhǎng chénzhuó tóu zhòng le yāshào sānfēnqiú.',
      example_vi = 'Vào thời khắc then chốt khi trận đấu bước vào đếm ngược cuối cùng, đội trưởng đã điềm tĩnh ném trúng quả bóng ba điểm ấn định tỷ số.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '时刻',
      'shíkè',
      'thời khắc, thời điểm; luôn luôn, từng giờ từng phút',
      'Danh từ / Phó từ',
      'HSK 5',
      '在比赛进入最后倒计时的关键时刻，队长沉着投中了压哨三分球。',
      'Zài bǐsài jìnrù zuìhòu dàojìshí de guānjiàn shíkè, duìzhǎng chénzhuó tóu zhòng le yāshào sānfēnqiú.',
      'Vào thời khắc then chốt khi trận đấu bước vào đếm ngược cuối cùng, đội trưởng đã điềm tĩnh ném trúng quả bóng ba điểm ấn định tỷ số.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在比赛进入最后倒计时的关键时刻，队长沉着投中了压哨三分球。', 'Zài bǐsài jìnrù zuìhòu dàojìshí de guānjiàn shíkè, duìzhǎng chénzhuó tóu zhòng le yāshào sānfēnqiú.', 'Vào thời khắc then chốt khi trận đấu bước vào đếm ngược cuối cùng, đội trưởng đã điềm tĩnh ném trúng quả bóng ba điểm ấn định tỷ số.', 'basic', 1),
      (v_id, '重大基础设施工程建设必须时刻绷紧施工质量与生产安全这根弦，坚决杜绝任何侥幸麻痹心理。', 'Zhòngdà jīchǔ shèshī gōngchéng jiànshè bìxū shíkè bēngjǐn shīgōng zhìliàng yǔ shēngchǎn ānquán zhè gēn xián, jiānjué dùjué rènhé jiǎoxìng mábì xīnlǐ.', 'Xây dựng công trình cơ sở hạ tầng trọng điểm phải luôn luôn kéo căng sợi dây chất lượng thi công và an toàn sản xuất, kiên quyết bài trừ mọi tâm lý ỷ lại chủ quan lơ là.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3015] [实力] (shílì) - thực lực, sức mạnh thực sự [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实力' AND pinyin = 'shílì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实力' AND pinyin = 'shílì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shílì',
      meaning_vi = 'thực lực, sức mạnh thực sự',
      example_hanzi = '这两支决赛队伍整体实力相当，比赛过程异常激烈精彩。',
      example_pinyin = 'Zhè liǎng zhī juésài duìwu zhěngtǐ shílì xiāngdāng, bǐsài guòchéng yìcháng jīliè jīngcǎi.',
      example_vi = 'Hai đội tuyển vào chung kết này có thực lực tổng thể ngang tài ngang sức, diễn biến trận đấu vô cùng gay cấn đặc sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实力',
      'shílì',
      'thực lực, sức mạnh thực sự',
      'Danh từ',
      'HSK 5',
      '这两支决赛队伍整体实力相当，比赛过程异常激烈精彩。',
      'Zhè liǎng zhī juésài duìwu zhěngtǐ shílì xiāngdāng, bǐsài guòchéng yìcháng jīliè jīngcǎi.',
      'Hai đội tuyển vào chung kết này có thực lực tổng thể ngang tài ngang sức, diễn biến trận đấu vô cùng gay cấn đặc sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这两支决赛队伍整体实力相当，比赛过程异常激烈精彩。', 'Zhè liǎng zhī juésài duìwu zhěngtǐ shílì xiāngdāng, bǐsài guòchéng yìcháng jīliè jīngcǎi.', 'Hai đội tuyển vào chung kết này có thực lực tổng thể ngang tài ngang sức, diễn biến trận đấu vô cùng gay cấn đặc sắc.', 'basic', 1),
      (v_id, '强大的基础研究能力、完备的高端制造业门类与充沛的工程师红利，构成了国家综合科技实力的核心底盘。', 'Qiángdà de jīchǔ yánjiū nénglì, wánbèi de gāoduān zhìzàoyè ménlèi yǔ chōngpèi de gōngchéngshī hónglì, gòuchéng le guójiā zōnghé kējì shílì de héxīn dǐpán.', 'Năng lực nghiên cứu cơ bản hùng mạnh, danh mục ngành chế tạo cao cấp hoàn thiện và nguồn lợi tức kỹ sư dồi dào đã cấu thành nền tảng cốt lõi của thực lực khoa học công nghệ tổng hợp quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3016] [时期] (shíqī) - thời kỳ, giai đoạn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '时期' AND pinyin = 'shíqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时期' AND pinyin = 'shíqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '时期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '时期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shíqī',
      meaning_vi = 'thời kỳ, giai đoạn',
      example_hanzi = '中学时期是青少年世界观、人生观和价值观形成的关键阶段。',
      example_pinyin = 'Zhōngxué shíqī shì qīng-shàonián shìjièguān, rénshēngguān hé jiàzhíguān xíngchéng de guānjiàn jiēduàn.',
      example_vi = 'Thời kỳ học trung học là giai đoạn then chốt hình thành thế giới quan, nhân sinh quan và giá trị quan của thanh thiếu niên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '时期',
      'shíqī',
      'thời kỳ, giai đoạn',
      'Danh từ',
      'HSK 5',
      '中学时期是青少年世界观、人生观和价值观形成的关键阶段。',
      'Zhōngxué shíqī shì qīng-shàonián shìjièguān, rénshēngguān hé jiàzhíguān xíngchéng de guānjiàn jiēduàn.',
      'Thời kỳ học trung học là giai đoạn then chốt hình thành thế giới quan, nhân sinh quan và giá trị quan của thanh thiếu niên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中学时期是青少年世界观、人生观和价值观形成的关键阶段。', 'Zhōngxué shíqī shì qīng-shàonián shìjièguān, rénshēngguān hé jiàzhíguān xíngchéng de guānjiàn jiēduàn.', 'Thời kỳ học trung học là giai đoạn then chốt hình thành thế giới quan, nhân sinh quan và giá trị quan của thanh thiếu niên.', 'basic', 1),
      (v_id, '当前我国经济正处于转变发展方式、优化经济结构与转换增长动力的关键攻坚时期。', 'Dāngqián wǒguó jīngjì zhèng chǔyú zhuǎnbiàn fāzhǎn fāngshì, yōuhuà jīngjì jiégòu yǔ zhuǎnhuàn zēngzhǎng dònglì de guānjiàn gōngjiān shíqī.', 'Hiện nay nền kinh tế nước ta đang ở vào thời kỳ then chốt đột phá về chuyển đổi phương thức phát triển, tối ưu hóa cơ cấu kinh tế và hoán chuyển động lực tăng trưởng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3017] [实施] (shíshī) - thực thi, thực hiện, triển khai [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实施' AND pinyin = 'shíshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实施' AND pinyin = 'shíshī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实施'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实施'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shíshī',
      meaning_vi = 'thực thi, thực hiện, triển khai',
      example_hanzi = '新修订的城市生活垃圾分类管理条例自下月起正式实施。',
      example_pinyin = 'Xīn xiūdìng de chéngshì shēnghuó lājī fēnlèi guǎnlǐ tiáolì zì xiàyuè qǐ zhèngshì shíshī.',
      example_vi = 'Điều lệ quản lý phân loại rác thải sinh hoạt đô thị mới sửa đổi sẽ chính thức thực thi từ tháng sau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实施',
      'shíshī',
      'thực thi, thực hiện, triển khai',
      'Động từ',
      'HSK 5',
      '新修订的城市生活垃圾分类管理条例自下月起正式实施。',
      'Xīn xiūdìng de chéngshì shēnghuó lājī fēnlèi guǎnlǐ tiáolì zì xiàyuè qǐ zhèngshì shíshī.',
      'Điều lệ quản lý phân loại rác thải sinh hoạt đô thị mới sửa đổi sẽ chính thức thực thi từ tháng sau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新修订的城市生活垃圾分类管理条例自下月起正式实施。', 'Xīn xiūdìng de chéngshì shēnghuó lājī fēnlèi guǎnlǐ tiáolì zì xiàyuè qǐ zhèngshì shíshī.', 'Điều lệ quản lý phân loại rác thải sinh hoạt đô thị mới sửa đổi sẽ chính thức thực thi từ tháng sau.', 'basic', 1),
      (v_id, '全面实施自由贸易试验区提升战略，稳步扩大规则、规制、管理、标准等制度型开放。', 'Quánmiàn shíshī zìyóu màoyì shìyànqū tíshēng zhànlüè, wěnbù kuòdà guīzé, guīzhì, guǎnlǐ, biāozhǔn děng zhìdùxíng kāifàng.', 'Thực thi toàn diện chiến lược nâng cấp khu thí nghiệm thương mại tự do, mở rộng vững chắc độ mở cửa mang tính thể chế như quy tắc, quy chế, quản lý và tiêu chuẩn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3018] [石头] (shítou) - hòn đá, tảng đá [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '石头' AND pinyin = 'shítou'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '石头' AND pinyin = 'shítou'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '石头'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '石头'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shítou',
      meaning_vi = 'hòn đá, tảng đá',
      example_hanzi = '小河边铺满了一块块被流水冲刷得十分圆润光滑的鹅卵石石头。',
      example_pinyin = 'Xiǎohé biān pūmǎn le yí kuàikuài bèi liúshuǐ chōngshuā de shífēn yuánrùn guānghua de éluǎnshí shítou.',
      example_vi = 'Ven con suối nhỏ rải đầy những hòn đá cuội được dòng nước xối mòn vô cùng tròn trịa trơn nhẵn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '石头',
      'shítou',
      'hòn đá, tảng đá',
      'Danh từ',
      'HSK 5',
      '小河边铺满了一块块被流水冲刷得十分圆润光滑的鹅卵石石头。',
      'Xiǎohé biān pūmǎn le yí kuàikuài bèi liúshuǐ chōngshuā de shífēn yuánrùn guānghua de éluǎnshí shítou.',
      'Ven con suối nhỏ rải đầy những hòn đá cuội được dòng nước xối mòn vô cùng tròn trịa trơn nhẵn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小河边铺满了一块块被流水冲刷得十分圆润光滑的鹅卵石石头。', 'Xiǎohé biān pūmǎn le yí kuàikuài bèi liúshuǐ chōngshuā de shífēn yuánrùn guānghua de éluǎnshí shítou.', 'Ven con suối nhỏ rải đầy những hòn đá cuội được dòng nước xối mòn vô cùng tròn trịa trơn nhẵn.', 'basic', 1),
      (v_id, '地质科考队员深入高山峡谷，采集不同地质年代的典型沉积岩与变质岩石头岩心样本以解构板块构造演变史。', 'Dìzhì kēkǎo duìyuán shēnrù gāoshān xiágǔ, cǎijí bùtóng dìzhì niándài de diǎnxíng chénjīyán yǔ biànzhìyán shítou yánxīn yàngběn yǐ jiěgòu bǎnkuài gòuzào yǎnbiànshǐ.', 'Các thành viên đội khảo sát địa chất đi sâu vào các hẻm núi cao vút, thu thập các mẫu lõi đá trầm tích và đá biến chất điển hình thuộc các niên đại địa chất khác nhau nhằm giải mã lịch sử tiến hóa kiến tạo mảng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3019] [实习] (shíxí) - thực tập, đi thực tập [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实习' AND pinyin = 'shíxí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实习' AND pinyin = 'shíxí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实习'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实习'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shíxí',
      meaning_vi = 'thực tập, đi thực tập',
      example_hanzi = '大四上学期，许多同学都前往各家知名企事业单位进行为期半年的岗位实习。',
      example_pinyin = 'Dàsì shàngxuéqī, xǔduō tóngxué dōu qiánwǎng gè jiā zhīmíng qǐ-shìyè dānwèi jìnxíng wéiqī bàn nián de gǎngwèi shíxí.',
      example_vi = 'Học kỳ một năm thứ tư, nhiều bạn sinh viên đã đến các cơ quan doanh nghiệp danh tiếng để thực tập vị trí việc làm trong thời hạn nửa năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实习',
      'shíxí',
      'thực tập, đi thực tập',
      'Động từ',
      'HSK 5',
      '大四上学期，许多同学都前往各家知名企事业单位进行为期半年的岗位实习。',
      'Dàsì shàngxuéqī, xǔduō tóngxué dōu qiánwǎng gè jiā zhīmíng qǐ-shìyè dānwèi jìnxíng wéiqī bàn nián de gǎngwèi shíxí.',
      'Học kỳ một năm thứ tư, nhiều bạn sinh viên đã đến các cơ quan doanh nghiệp danh tiếng để thực tập vị trí việc làm trong thời hạn nửa năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大四上学期，许多同学都前往各家知名企事业单位进行为期半年的岗位实习。', 'Dàsì shàngxuéqī, xǔduō tóngxué dōu qiánwǎng gè jiā zhīmíng qǐ-shìyè dānwèi jìnxíng wéiqī bàn nián de gǎngwèi shíxí.', 'Học kỳ một năm thứ tư, nhiều bạn sinh viên đã đến các cơ quan doanh nghiệp danh tiếng để thực tập vị trí việc làm trong thời hạn nửa năm.', 'basic', 1),
      (v_id, '医学院临床医学专业学生在三甲教学医院接受系统规范的住院医师规范化培训与全科临床轮转实习。', 'Yīxuéyuàn línchuáng yīxué zhuānyè xuéshēng zài sānjiǎ jiàoxué yīyuàn jiēshòu xìtǒng guīfàn de zhùyuàn yīshī guīfànhuà péixùn yǔ quánkē línchuáng lúnzhuàn shíxí.', 'Sinh viên chuyên ngành y học lâm sàng của trường đại học y tiếp nhận chương trình đào tạo chuẩn hóa bác sĩ nội trú quy củ có hệ thống và thực tập luân khoa lâm sàng đa khoa tại bệnh viện thực hành tuyến một.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3020] [实现] (shíxiàn) - thực hiện, hiện thực hóa, đạt được [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实现' AND pinyin = 'shíxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实现' AND pinyin = 'shíxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实现'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实现'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shíxiàn',
      meaning_vi = 'thực hiện, hiện thực hóa, đạt được',
      example_hanzi = '只要付出坚持不懈的努力，每个人心中的理想都一定能够实现。',
      example_pinyin = 'Zhǐyào fùchū jiānchí-bùxiè de nǔlì, měi ge rén xīn zhōng de lǐxiǎng dōu yídìng nénggòu shíxiàn.',
      example_vi = 'Chỉ cần bỏ ra nỗ lực kiên trì bền bỉ, lý tưởng trong trái tim của mỗi người đều nhất định có thể trở thành hiện thực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实现',
      'shíxiàn',
      'thực hiện, hiện thực hóa, đạt được',
      'Động từ',
      'HSK 5',
      '只要付出坚持不懈的努力，每个人心中的理想都一定能够实现。',
      'Zhǐyào fùchū jiānchí-bùxiè de nǔlì, měi ge rén xīn zhōng de lǐxiǎng dōu yídìng nénggòu shíxiàn.',
      'Chỉ cần bỏ ra nỗ lực kiên trì bền bỉ, lý tưởng trong trái tim của mỗi người đều nhất định có thể trở thành hiện thực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只要付出坚持不懈的努力，每个人心中的理想都一定能够实现。', 'Zhǐyào fùchū jiānchí-bùxiè de nǔlì, měi ge rén xīn zhōng de lǐxiǎng dōu yídìng nénggòu shíxiàn.', 'Chỉ cần bỏ ra nỗ lực kiên trì bền bỉ, lý tưởng trong trái tim của mỗi người đều nhất định có thể trở thành hiện thực.', 'basic', 1),
      (v_id, '以科技自立自强支撑引领现代化产业体系建设，是全面实现高质量发展与中国式现代化的战略基石。', 'Yǐ kējì zìlì-zìqiáng zhīchēng yǐnlǐng xiàndàihuà chǎnyè tǐxì jiànshè, shì quánmiàn shíxiàn gāo-zhìliàng fāzhǎn yǔ Zhōngguóshì xiàndàihuà de zhànlüè jīshí.', 'Lấy tự lực tự cường khoa học công nghệ làm trụ cột dẫn dắt xây dựng hệ thống sản xuất hiện đại là nền tảng chiến lược để hiện thực hóa toàn diện phát triển chất lượng cao và hiện đại hóa kiểu Trung Quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3021] [实行] (shíxíng) - thực hành, áp dụng, thi hành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实行' AND pinyin = 'shíxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实行' AND pinyin = 'shíxíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实行'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shíxíng',
      meaning_vi = 'thực hành, áp dụng, thi hành',
      example_hanzi = '该图书馆实行周一至周日全天候无休开放政策，方便读者随时借还书籍。',
      example_pinyin = 'Gāi túshūguǎn shíxíng zhōuyī zhì zhōurì quán-tiānhòu wú xiū kāifàng zhèngcè, fāngbiàn dúzhě suíshí jiè-huán shūjí.',
      example_vi = 'Thư viện này áp dụng chính sách mở cửa suốt ngày đêm không ngày nghỉ từ thứ Hai đến Chủ Nhật, tạo thuận tiện cho bạn đọc mượn trả sách bất kỳ lúc nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实行',
      'shíxíng',
      'thực hành, áp dụng, thi hành',
      'Động từ',
      'HSK 5',
      '该图书馆实行周一至周日全天候无休开放政策，方便读者随时借还书籍。',
      'Gāi túshūguǎn shíxíng zhōuyī zhì zhōurì quán-tiānhòu wú xiū kāifàng zhèngcè, fāngbiàn dúzhě suíshí jiè-huán shūjí.',
      'Thư viện này áp dụng chính sách mở cửa suốt ngày đêm không ngày nghỉ từ thứ Hai đến Chủ Nhật, tạo thuận tiện cho bạn đọc mượn trả sách bất kỳ lúc nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '该图书馆实行周一至周日全天候无休开放政策，方便读者随时借还书籍。', 'Gāi túshūguǎn shíxíng zhōuyī zhì zhōurì quán-tiānhòu wú xiū kāifàng zhèngcè, fāngbiàn dúzhě suíshí jiè-huán shūjí.', 'Thư viện này áp dụng chính sách mở cửa suốt ngày đêm không ngày nghỉ từ thứ Hai đến Chủ Nhật, tạo thuận tiện cho bạn đọc mượn trả sách bất kỳ lúc nào.', 'basic', 1),
      (v_id, '资本市场全面实行股票发行注册制改革，强化以信息披露为核心的透明监管，推动市场资源配置功能高效发挥。', 'Zīběn shìchǎng quánmiàn shíxíng gǔpiào fāxíng zhùcèzhì gǎigé, qiánghuà yǐ xìnxī pīlù wéi héxīn de tòumíng jiānguǎn, tuīdòng shìchǎng zīyuán pèizhì gōngnéng gāoxiào fāhuī.', 'Thị trường vốn thực hiện toàn diện cải cách chế độ đăng ký phát hành cổ phiếu, củng cố sự giám sát minh bạch lấy công bố thông tin làm cốt lõi, thúc đẩy phát huy hiệu quả công năng phân bổ tài nguyên của thị trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3022] [实验] (shíyàn) - thí nghiệm, làm thí nghiệm; cuộc thí nghiệm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实验' AND pinyin = 'shíyàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实验' AND pinyin = 'shíyàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实验'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实验'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shíyàn',
      meaning_vi = 'thí nghiệm, làm thí nghiệm; cuộc thí nghiệm',
      example_hanzi = '化学课上，同学们在老师的指导下小心翼翼地完成了酸碱中和反应实验。',
      example_pinyin = 'Huàxuékè shang, tóngxuémen zài lǎoshī de zhǐdǎo xià xiǎoxīn-yìyì de wánchéng le suān-jiǎn zhōnghé fǎnyìng shíyàn.',
      example_vi = 'Trong giờ hóa học, các bạn học sinh dưới sự hướng dẫn của thầy giáo đã cẩn thận hoàn thành thí nghiệm phản ứng trung hòa axit - bazơ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实验',
      'shíyàn',
      'thí nghiệm, làm thí nghiệm; cuộc thí nghiệm',
      'Động từ / Danh từ',
      'HSK 5',
      '化学课上，同学们在老师的指导下小心翼翼地完成了酸碱中和反应实验。',
      'Huàxuékè shang, tóngxuémen zài lǎoshī de zhǐdǎo xià xiǎoxīn-yìyì de wánchéng le suān-jiǎn zhōnghé fǎnyìng shíyàn.',
      'Trong giờ hóa học, các bạn học sinh dưới sự hướng dẫn của thầy giáo đã cẩn thận hoàn thành thí nghiệm phản ứng trung hòa axit - bazơ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '化学课上，同学们在老师的指导下小心翼翼地完成了酸碱中和反应实验。', 'Huàxuékè shang, tóngxuémen zài lǎoshī de zhǐdǎo xià xiǎoxīn-yìyì de wánchéng le suān-jiǎn zhōnghé fǎnyìng shíyàn.', 'Trong giờ hóa học, các bạn học sinh dưới sự hướng dẫn của thầy giáo đã cẩn thận hoàn thành thí nghiệm phản ứng trung hòa axit - bazơ.', 'basic', 1),
      (v_id, '量子保密通信实验卫星成功完成千公里级星地双向量子纠缠分发实验，证实了爱因斯坦广义相对论下的量子纠缠非定域性。', 'Liàngzǐ bǎomì tōngxìn shíyàn wèixīng chénggōng wánchéng qiāngōnglǐ jí xīng-dì shuāngxiàng liàngzǐ jiūchán fēnfā shíyàn, zhèngshí le Àiyīnsītǎn guǎngyì xiāngduìlùn xià de liàngzǐ jiūchán fēi-dìngyùxìng.', 'Vệ tinh thí nghiệm truyền thông bảo mật lượng tử đã hoàn thành thành công thí nghiệm phân phối vướng víu lượng tử hai chiều sao - đất cấp nghìn kilomet, chứng minh tính phi định xứ của vướng víu lượng tử dưới thuyết tương đối rộng của Einstein.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3023] [实验室] (shíyànshì) - phòng thí nghiệm, phòng nghiên cứu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实验室' AND pinyin = 'shíyànshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实验室' AND pinyin = 'shíyànshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实验室'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实验室'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shíyànshì',
      meaning_vi = 'phòng thí nghiệm, phòng nghiên cứu',
      example_hanzi = '进入化学实验室前，所有人必须穿好白色实验服并戴好护目镜。',
      example_pinyin = 'Jìnrù huàxué shíyànshì qián, suǒyǒu rén bìxū chuān hǎo báisè shíyànfú bìng dài hǎo hùmùjìng.',
      example_vi = 'Trước khi bước vào phòng thí nghiệm hóa học, mọi người bắt buộc phải mặc áo blouse trắng và đeo kính bảo hộ cẩn thận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实验室',
      'shíyànshì',
      'phòng thí nghiệm, phòng nghiên cứu',
      'Danh từ',
      'HSK 5',
      '进入化学实验室前，所有人必须穿好白色实验服并戴好护目镜。',
      'Jìnrù huàxué shíyànshì qián, suǒyǒu rén bìxū chuān hǎo báisè shíyànfú bìng dài hǎo hùmùjìng.',
      'Trước khi bước vào phòng thí nghiệm hóa học, mọi người bắt buộc phải mặc áo blouse trắng và đeo kính bảo hộ cẩn thận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '进入化学实验室前，所有人必须穿好白色实验服并戴好护目镜。', 'Jìnrù huàxué shíyànshì qián, suǒyǒu rén bìxū chuān hǎo báisè shíyànfú bìng dài hǎo hùmùjìng.', 'Trước khi bước vào phòng thí nghiệm hóa học, mọi người bắt buộc phải mặc áo blouse trắng và đeo kính bảo hộ cẩn thận.', 'basic', 1),
      (v_id, '重组国家重点实验室体系并优化基础学科前沿交叉布局，旨在打造世界一流的战略科技力量国家队。', 'Chóngzǔ guójiā zhòngdiǎn shíyànshì tǐxì bìng yōuhuà jīchǔ xuékē qiányán jiāochā bùjú, zhǐ zài dǎzào shìjiè yīliú de zhànlüè kējì lìliàng guójiāduì.', 'Tái cơ cấu hệ thống phòng thí nghiệm trọng điểm quốc gia và tối ưu hóa bố trí giao thoa mũi nhọn các ngành khoa học cơ bản nhằm mục tiêu xây dựng đội tuyển quốc gia lực lượng khoa học công nghệ chiến lược đẳng cấp thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3024] [实用] (shíyòng) - thực dụng, có giá trị sử dụng cao, thiết thực [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '实用' AND pinyin = 'shíyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实用' AND pinyin = 'shíyòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '实用'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '实用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shíyòng',
      meaning_vi = 'thực dụng, có giá trị sử dụng cao, thiết thực',
      example_hanzi = '这本旅行指南不仅地图绘制得非常清晰，还包含许多实用的出行省钱小技巧。',
      example_pinyin = 'Zhè běn lǚxíng zhǐnán bùjǐn dìtú huìzhì de fēicháng qīngxī, hái bāohán xǔduō shíyòng de chūxíng shěngqián xiǎo jìqiǎo.',
      example_vi = 'Cuốn cẩm nang du lịch này không chỉ vẽ bản đồ rất rõ ràng mà còn chứa đựng rất nhiều mẹo nhỏ tiết kiệm chi phí đi lại vô cùng thiết thực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '实用',
      'shíyòng',
      'thực dụng, có giá trị sử dụng cao, thiết thực',
      'Tính từ',
      'HSK 5',
      '这本旅行指南不仅地图绘制得非常清晰，还包含许多实用的出行省钱小技巧。',
      'Zhè běn lǚxíng zhǐnán bùjǐn dìtú huìzhì de fēicháng qīngxī, hái bāohán xǔduō shíyòng de chūxíng shěngqián xiǎo jìqiǎo.',
      'Cuốn cẩm nang du lịch này không chỉ vẽ bản đồ rất rõ ràng mà còn chứa đựng rất nhiều mẹo nhỏ tiết kiệm chi phí đi lại vô cùng thiết thực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这本旅行指南不仅地图绘制得非常清晰，还包含许多实用的出行省钱小技巧。', 'Zhè běn lǚxíng zhǐnán bùjǐn dìtú huìzhì de fēicháng qīngxī, hái bāohán xǔduō shíyòng de chūxíng shěngqián xiǎo jìqiǎo.', 'Cuốn cẩm nang du lịch này không chỉ vẽ bản đồ rất rõ ràng mà còn chứa đựng rất nhiều mẹo nhỏ tiết kiệm chi phí đi lại vô cùng thiết thực.', 'basic', 1),
      (v_id, '科技研发评价体系要摒弃片面追求论文发表数量的倾向，更加注重成果的实际工程应用价值与产业转化实用性。', 'Kējì yánfā píngjià tǐxì yào bìngqì piànmiàn zhuīqiú lùnwén fābiǎo shùliàng de qīngxiàng, gèngjiā zhùzhòng chéngguǒ de shíjì gōngchéng yìngyòng jiàzhí yǔ chǎnyè zhuǎnhuà shíyòngxìng.', 'Hệ thống đánh giá nghiên cứu phát triển khoa học công nghệ cần loại bỏ khuynh hướng chạy theo số lượng bài báo công bố một cách phiến diện, coi trọng hơn giá trị ứng dụng công trình thực tế và tính thực dụng trong chuyển giao sản xuất của thành quả.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3025] [食用] (shíyòng) - ăn, dùng làm thực phẩm; thực phẩm ăn được [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '食用' AND pinyin = 'shíyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '食用' AND pinyin = 'shíyòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '食用'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '食用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shíyòng',
      meaning_vi = 'ăn, dùng làm thực phẩm; thực phẩm ăn được',
      example_hanzi = '这种野生蘑菇含有剧毒，严禁采摘或烹饪食用。',
      example_pinyin = 'Zhè zhǒng yěshēng mógu hán yǒu jùdú, yánjìn cǎizhāi huò pēngrèn shíyòng.',
      example_vi = 'Loại nấm mọc hoang này có chứa chất kịch độc, nghiêm cấm hái lượm hoặc chế biến đem ăn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '食用',
      'shíyòng',
      'ăn, dùng làm thực phẩm; thực phẩm ăn được',
      'Động từ / Danh từ',
      'HSK 5',
      '这种野生蘑菇含有剧毒，严禁采摘或烹饪食用。',
      'Zhè zhǒng yěshēng mógu hán yǒu jùdú, yánjìn cǎizhāi huò pēngrèn shíyòng.',
      'Loại nấm mọc hoang này có chứa chất kịch độc, nghiêm cấm hái lượm hoặc chế biến đem ăn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这种野生蘑菇含有剧毒，严禁采摘或烹饪食用。', 'Zhè zhǒng yěshēng mógu hán yǒu jùdú, yánjìn cǎizhāi huò pēngrèn shíyòng.', 'Loại nấm mọc hoang này có chứa chất kịch độc, nghiêm cấm hái lượm hoặc chế biến đem ăn.', 'basic', 1),
      (v_id, '国家食品安全标准严格界定食品级添加剂的安全残留限量，保障食用油、乳制品与婴幼儿配方食品的终极安全底线。', 'Guójiā shípǐn ānquán biāozhǔn yángé jièdìng shípǐnjí tiānjiājì de ānquán cánliú xiànliàng, bǎozhàng shíyòngyóu, rǔzhìpǐn yǔ yīng-yòu’ér pèifāng shípǐn de zhōngjí ānquán dǐxiàn.', 'Tiêu chuẩn an toàn thực phẩm quốc gia định rõ giới hạn dư lượng an toàn của các phụ gia cấp thực phẩm, bảo đảm giới hạn đỏ an toàn tuyệt đối cho dầu ăn, chế phẩm từ sữa và thực phẩm công thức cho trẻ sơ sinh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3026] [使得] (shǐde) - khiến cho, làm cho [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '使得' AND pinyin = 'shǐde'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '使得' AND pinyin = 'shǐde'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '使得'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '使得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shǐde',
      meaning_vi = 'khiến cho, làm cho',
      example_hanzi = '突如其来的一场大雪，使得整个城市的高速公路不得不全线封闭。',
      example_pinyin = 'Tūrúqílái de yì chǎng dàxuě, shǐde zhěng ge chéngshì de gāosù gōnglù bùdébù quánxiàn fēngbì.',
      example_vi = 'Trận tuyết lớn bất ngờ ập đến đã khiến cho toàn bộ các tuyến đường cao tốc của cả thành phố buộc phải phong tỏa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '使得',
      'shǐde',
      'khiến cho, làm cho',
      'Động từ',
      'HSK 5',
      '突如其来的一场大雪，使得整个城市的高速公路不得不全线封闭。',
      'Tūrúqílái de yì chǎng dàxuě, shǐde zhěng ge chéngshì de gāosù gōnglù bùdébù quánxiàn fēngbì.',
      'Trận tuyết lớn bất ngờ ập đến đã khiến cho toàn bộ các tuyến đường cao tốc của cả thành phố buộc phải phong tỏa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '突如其来的一场大雪，使得整个城市的高速公路不得不全线封闭。', 'Tūrúqílái de yì chǎng dàxuě, shǐde zhěng ge chéngshì de gāosù gōnglù bùdébù quánxiàn fēngbì.', 'Trận tuyết lớn bất ngờ ập đến đã khiến cho toàn bộ các tuyến đường cao tốc của cả thành phố buộc phải phong tỏa.', 'basic', 1),
      (v_id, '数字基础设施的持续完善与超算算力集群的普及，使得海量跨领域复杂科研数据的大规模并发模拟推演成为现实。', 'Shùzì jīchǔ shèshī de chíxù wánshàn yǔ chāosuàn suànlì jǐqún de pǔjí, shǐde hǎiliàng kuà-lǐngyù fùzá kēyán shùjù de dà-guīmó bīngfā mónǐ tuīyǎn chéngwéi xiànshí.', 'Sự hoàn thiện liên tục của cơ sở hạ tầng số cùng việc phổ cập cụm năng lực tính toán siêu máy tính đã khiến cho việc mô phỏng suy luận đồng thời quy mô lớn lượng dữ liệu nghiên cứu khoa học phức tạp liên lĩnh vực trở thành hiện thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3027] [始终] (shǐzhōng) - từ đầu đến cuối, luôn luôn, trước sau như một [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '始终' AND pinyin = 'shǐzhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '始终' AND pinyin = 'shǐzhōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '始终'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '始终'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'shǐzhōng',
      meaning_vi = 'từ đầu đến cuối, luôn luôn, trước sau như một',
      example_hanzi = '在求学深造的漫长道路上，他始终保持着对科学探索的纯粹热情。',
      example_pinyin = 'Zài qiúxué shēnzào de màncháng dàolù shang, tā shǐzhōng bǎochí zhe duì kēxué tànsuǒ de chúncuì rèqíng.',
      example_vi = 'Trên con đường dài đằng đẵng học tập nghiên cứu chuyên sâu, anh ấy từ đầu đến cuối luôn duy trì niềm đam mê thuần khiết đối với việc khám phá khoa học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '始终',
      'shǐzhōng',
      'từ đầu đến cuối, luôn luôn, trước sau như một',
      'Phó từ',
      'HSK 5',
      '在求学深造的漫长道路上，他始终保持着对科学探索的纯粹热情。',
      'Zài qiúxué shēnzào de màncháng dàolù shang, tā shǐzhōng bǎochí zhe duì kēxué tànsuǒ de chúncuì rèqíng.',
      'Trên con đường dài đằng đẵng học tập nghiên cứu chuyên sâu, anh ấy từ đầu đến cuối luôn duy trì niềm đam mê thuần khiết đối với việc khám phá khoa học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在求学深造的漫长道路上，他始终保持着对科学探索的纯粹热情。', 'Zài qiúxué shēnzào de màncháng dàolù shang, tā shǐzhōng bǎochí zhe duì kēxué tànsuǒ de chúncuì rèqíng.', 'Trên con đường dài đằng đẵng học tập nghiên cứu chuyên sâu, anh ấy từ đầu đến cuối luôn duy trì niềm đam mê thuần khiết đối với việc khám phá khoa học.', 'basic', 1),
      (v_id, '国家在对外经贸交往中始终坚定维护多边贸易体制，坚决反对单边主义与保护主义逆流。', 'Guójiā zài duìwài jīngmào jiāowǎng zhōng shǐzhōng jiāndìng wéihù duōbiān màoyì tǐxì, jiānjué fǎnduì dānbiānzhǔyì yǔ bǎohùzhǔyì nìliú.', 'Nhà nước trong bang giao kinh tế thương mại đối ngoại trước sau như một kiên định bảo vệ thể chế thương mại đa phương, kiên quyết phản đối làn sóng ngược của chủ nghĩa đơn phương và chủ nghĩa bảo hộ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3028] [式] (shì) - kiểu, mẫu, thức [Hậu tố / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '式' AND pinyin = 'shì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '式' AND pinyin = 'shì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '式'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '式'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Hậu tố / Danh từ',
      pinyin = 'shì',
      meaning_vi = 'kiểu, mẫu, thức',
      example_hanzi = '这种中西合璧式的新式民居建筑，既保留了传统庭院格局又兼具现代舒适功能。',
      example_pinyin = 'Zhè zhǒng zhōng-xī-hébì shì de xīnshì mínjū jiànzhù, jì bǎoliú le chuántǒng tíngyuàn géjú yòu jiānjù xiàndài shūshì gōngnéng.',
      example_vi = 'Kiến trúc nhà ở kiểu mới kết hợp hài hòa phong cách Đông Tây này vừa lưu giữ bố cục sân vườn truyền thống vừa sở hữu đầy đủ tiện nghi hiện đại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '式',
      'shì',
      'kiểu, mẫu, thức',
      'Hậu tố / Danh từ',
      'HSK 5',
      '这种中西合璧式的新式民居建筑，既保留了传统庭院格局又兼具现代舒适功能。',
      'Zhè zhǒng zhōng-xī-hébì shì de xīnshì mínjū jiànzhù, jì bǎoliú le chuántǒng tíngyuàn géjú yòu jiānjù xiàndài shūshì gōngnéng.',
      'Kiến trúc nhà ở kiểu mới kết hợp hài hòa phong cách Đông Tây này vừa lưu giữ bố cục sân vườn truyền thống vừa sở hữu đầy đủ tiện nghi hiện đại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这种中西合璧式的新式民居建筑，既保留了传统庭院格局又兼具现代舒适功能。', 'Zhè zhǒng zhōng-xī-hébì shì de xīnshì mínjū jiànzhù, jì bǎoliú le chuántǒng tíngyuàn géjú yòu jiānjù xiàndài shūshì gōngnéng.', 'Kiến trúc nhà ở kiểu mới kết hợp hài hòa phong cách Đông Tây này vừa lưu giữ bố cục sân vườn truyền thống vừa sở hữu đầy đủ tiện nghi hiện đại.', 'basic', 1),
      (v_id, '建立“揭榜挂帅”式关键核心技术攻关机制，打破资历门槛，最大限度激发领军人才的创新创造活力。', 'Jiànlì “jiēbǎng-guàshuài” shì guānjiàn héxīn jìshù gōngguān jīzhì, dǎpò zīlì ménkǎn, zuìdà xiàndù jīfā lǐngjūn réncái de chuàngxīn chuàngzào huólì.', 'Thiết lập cơ chế khắc phục công nghệ cốt lõi then chốt theo hình thức "nhận cờ lĩnh ấn", phá bỏ rào cản bằng cấp thâm niên, kích hoạt tối đa sức sống đổi mới sáng tạo của các nhân tài dẫn dắt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3029] [适当] (shìdàng) - thích đáng, phù hợp, vừa phải [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '适当' AND pinyin = 'shìdàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '适当' AND pinyin = 'shìdàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '适当'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '适当'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shìdàng',
      meaning_vi = 'thích đáng, phù hợp, vừa phải',
      example_hanzi = '长时间使用电脑工作后，应当站起来进行适当的肢体拉伸放松。',
      example_pinyin = 'Cháng shíjiān shǐyòng diànnǎo gōngzuò hòu, yīngdāng zhàn qǐlai jìnxíng shìdàng de zhītǐ lāshēn fàngsōng.',
      example_vi = 'Sau thời gian dài dùng máy tính làm việc, nên đứng dậy thực hiện giãn cơ thư giãn cơ thể một cách vừa phải thích hợp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '适当',
      'shìdàng',
      'thích đáng, phù hợp, vừa phải',
      'Tính từ',
      'HSK 5',
      '长时间使用电脑工作后，应当站起来进行适当的肢体拉伸放松。',
      'Cháng shíjiān shǐyòng diànnǎo gōngzuò hòu, yīngdāng zhàn qǐlai jìnxíng shìdàng de zhītǐ lāshēn fàngsōng.',
      'Sau thời gian dài dùng máy tính làm việc, nên đứng dậy thực hiện giãn cơ thư giãn cơ thể một cách vừa phải thích hợp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长时间使用电脑工作后，应当站起来进行适当的肢体拉伸放松。', 'Cháng shíjiān shǐyòng diànnǎo gōngzuò hòu, yīngdāng zhàn qǐlai jìnxíng shìdàng de zhītǐ lāshēn fàngsōng.', 'Sau thời gian dài dùng máy tính làm việc, nên đứng dậy thực hiện giãn cơ thư giãn cơ thể một cách vừa phải thích hợp.', 'basic', 1),
      (v_id, '宏观财政政策应把握好支出力度与节奏，适当提高地方政府专项债券资金使用效益与资产回报率。', 'Hóngguān cáizhèng zhèngcè yīng bǎwò hǎo zhīchū lìdù yǔ jiézòu, shìdàng tígāo dìfāng zhèngfǔ zhuānxiàng zhànduì zījīn shǐyòng xiàoyì yǔ zīchǎn huíbàolǜ.', 'Chính sách tài khóa vĩ mô cần nắm chắc mức độ và nhịp độ chi tiêu, nâng cao một cách thích đáng hiệu quả sử dụng nguồn vốn và tỷ suất sinh lời tài sản của trái phiếu chuyên dùng chính quyền địa phương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3030] [似的] (shìde) - như, tựa như, dường như [Trợ từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '似的' AND pinyin = 'shìde'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '似的' AND pinyin = 'shìde'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '似的'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '似的'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Trợ từ',
      pinyin = 'shìde',
      meaning_vi = 'như, tựa như, dường như',
      example_hanzi = '冬天的早晨推开窗户，屋顶上像铺了一层厚厚的白雪棉被似的。',
      example_pinyin = 'Dōngtiān de zǎochen tuī kāi chuānghu, wūdǐng shang xiàng pū le yì céng hòuhòu de báixuě miánbèi shìde.',
      example_vi = 'Buổi sáng mùa đông đẩy cửa sổ ra, trên mái nhà tựa như đang trải một lớp chăn bông tuyết trắng muốt dày cộm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '似的',
      'shìde',
      'như, tựa như, dường như',
      'Trợ từ',
      'HSK 5',
      '冬天的早晨推开窗户，屋顶上像铺了一层厚厚的白雪棉被似的。',
      'Dōngtiān de zǎochen tuī kāi chuānghu, wūdǐng shang xiàng pū le yì céng hòuhòu de báixuě miánbèi shìde.',
      'Buổi sáng mùa đông đẩy cửa sổ ra, trên mái nhà tựa như đang trải một lớp chăn bông tuyết trắng muốt dày cộm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬天的早晨推开窗户，屋顶上像铺了一层厚厚的白雪棉被似的。', 'Dōngtiān de zǎochen tuī kāi chuānghu, wūdǐng shang xiàng pū le yì céng hòuhòu de báixuě miánbèi shìde.', 'Buổi sáng mùa đông đẩy cửa sổ ra, trên mái nhà tựa như đang trải một lớp chăn bông tuyết trắng muốt dày cộm.', 'basic', 1),
      (v_id, '在百年未有之大变局的汹涌风浪中，国家战略定力如同定海神针似的稳固支撑着经济巨轮破浪前行。', 'Zài bǎinián wèiyǒu zhī dà biànjú de xiōngyǒng fēnglàng zhōng, guójiā zhànlüè dìnglì rútóng dìnghǎishénzhēn shìde wěngù zhīchēng zhe jīngjì jùlún pòlàng-qiánxíng.', 'Giữa sóng to gió lớn của cục diện biến chuyển lớn trăm năm chưa từng có, định lực chiến lược của quốc gia tựa như thanh định hải thần châm vững chãi nâng đỡ con tàu kinh tế khổng lồ rẽ sóng tiến bước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3031] [事故] (shìgù) - sự cố, tai nạn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '事故' AND pinyin = 'shìgù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事故' AND pinyin = 'shìgù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '事故'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事故'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shìgù',
      meaning_vi = 'sự cố, tai nạn',
      example_hanzi = '交警部门提醒广大市民，雨雪天气路面湿滑，极易引发追尾交通事故。',
      example_pinyin = 'Jiāojǐng bùmén tíxǐng guǎngdà shìmín, yǔxuě tiānqì lùmiàn shīhuá, jíyì yǐnfā zhuīwěi jiāotōng shìgù.',
      example_vi = 'Lực lượng cảnh sát giao thông nhắc nhở đông đảo người dân, thời tiết mưa tuyết mặt đường trơn trượt rất dễ dẫn tới sự cố tai nạn giao thông tông đuôi xe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '事故',
      'shìgù',
      'sự cố, tai nạn',
      'Danh từ',
      'HSK 5',
      '交警部门提醒广大市民，雨雪天气路面湿滑，极易引发追尾交通事故。',
      'Jiāojǐng bùmén tíxǐng guǎngdà shìmín, yǔxuě tiānqì lùmiàn shīhuá, jíyì yǐnfā zhuīwěi jiāotōng shìgù.',
      'Lực lượng cảnh sát giao thông nhắc nhở đông đảo người dân, thời tiết mưa tuyết mặt đường trơn trượt rất dễ dẫn tới sự cố tai nạn giao thông tông đuôi xe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '交警部门提醒广大市民，雨雪天气路面湿滑，极易引发追尾交通事故。', 'Jiāojǐng bùmén tíxǐng guǎngdà shìmín, yǔxuě tiānqì lùmiàn shīhuá, jíyì yǐnfā zhuīwěi jiāotōng shìgù.', 'Lực lượng cảnh sát giao thông nhắc nhở đông đảo người dân, thời tiết mưa tuyết mặt đường trơn trượt rất dễ dẫn tới sự cố tai nạn giao thông tông đuôi xe.', 'basic', 1),
      (v_id, '矿山与危化品仓储企业必须依法落实全员安全生产责任制，坚决遏制重特大安全生产事故的发生。', 'Kuàngshān yǔ wēihuàpǐn cāngchǔ qǐyè bìxū yīfǎ luòshí quányuán ānquán shēngchǎn zérènzhì, jiānjué èzhì zhòng-tèdà ānquán shēngchǎn shìgù de fāshēng.', 'Doanh nghiệp khai thác mỏ và kho chứa hóa chất nguy hiểm bắt buộc phải triển khai chế độ trách nhiệm an toàn sản xuất toàn diện theo luật định, kiên quyết ngăn chặn xảy ra sự cố tai nạn an toàn sản xuất đặc biệt nghiêm trọng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3032] [事件] (shìjiàn) - sự kiện, vụ việc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '事件' AND pinyin = 'shìjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事件' AND pinyin = 'shìjiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '事件'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事件'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shìjiàn',
      meaning_vi = 'sự kiện, vụ việc',
      example_hanzi = '这次大型文化节不仅是一场艺术盛宴，也是今年本市的一大文化事件。',
      example_pinyin = 'Zhè cì dàxíng wénhuàjié bùjǐn shì yì chǎng yìshù shèngyàn, yě shì jīnnián běn shì de yí dà wénhuà shìjiàn.',
      example_vi = 'Lễ hội văn hóa quy mô lớn lần này không chỉ là bữa tiệc nghệ thuật thịnh soạn mà còn là một sự kiện văn hóa lớn của thành phố năm nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '事件',
      'shìjiàn',
      'sự kiện, vụ việc',
      'Danh từ',
      'HSK 5',
      '这次大型文化节不仅是一场艺术盛宴，也是今年本市的一大文化事件。',
      'Zhè cì dàxíng wénhuàjié bùjǐn shì yì chǎng yìshù shèngyàn, yě shì jīnnián běn shì de yí dà wénhuà shìjiàn.',
      'Lễ hội văn hóa quy mô lớn lần này không chỉ là bữa tiệc nghệ thuật thịnh soạn mà còn là một sự kiện văn hóa lớn của thành phố năm nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这次大型文化节不仅是一场艺术盛宴，也是今年本市的一大文化事件。', 'Zhè cì dàxíng wénhuàjié bùjǐn shì yì chǎng yìshù shèngyàn, yě shì jīnnián běn shì de yí dà wénhuà shìjiàn.', 'Lễ hội văn hóa quy mô lớn lần này không chỉ là bữa tiệc nghệ thuật thịnh soạn mà còn là một sự kiện văn hóa lớn của thành phố năm nay.', 'basic', 1),
      (v_id, '建立健全重大突发公共卫生事件与网络安全事件应急预警与快速处置响应机制，是提升超大城市韧性治理能力的核心抓手。', 'Jiànlì jiànquán zhòngdà tūfā gōnggòng wèishēng shìjiàn yǔ wǎngluò ānquán shìjiàn yìngjí yùjǐng yǔ kuàisù chǔzhì xiǎngyìng jīzhì, shì tíshēng chāodà chéngshì rènxìng zhìlǐ nénglì de héxīn zhuāshǒu.', 'Xây dựng và hoàn thiện cơ chế ứng phó cảnh báo sớm và xử lý nhanh đối với các sự kiện an ninh mạng và sự kiện y tế công cộng bùng phát nghiêm trọng là khâu then chốt cốt lõi nâng cao năng lực quản trị phục hồi của các siêu đô thị.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3033] [试卷] (shìjuàn) - bài thi, đề thi, bài làm thi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '试卷' AND pinyin = 'shìjuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '试卷' AND pinyin = 'shìjuàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '试卷'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '试卷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shìjuàn',
      meaning_vi = 'bài thi, đề thi, bài làm thi',
      example_hanzi = '监考老师在考试结束哨声响起后，按学号顺序逐一收齐了考生的试卷。',
      example_pinyin = 'Jiānkǎo lǎoshī zài kǎoshì jiéshù shàoshēng xiǎngqǐ hòu, àn xuéhào shùnxù zhúyī shōuqí le kǎoshēng de shìjuàn.',
      example_vi = 'Giám thị phòng thi sau khi tiếng còi kết thúc giờ thi vang lên đã lần lượt thu đủ bài thi của thí sinh theo thứ tự số báo danh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '试卷',
      'shìjuàn',
      'bài thi, đề thi, bài làm thi',
      'Danh từ',
      'HSK 5',
      '监考老师在考试结束哨声响起后，按学号顺序逐一收齐了考生的试卷。',
      'Jiānkǎo lǎoshī zài kǎoshì jiéshù shàoshēng xiǎngqǐ hòu, àn xuéhào shùnxù zhúyī shōuqí le kǎoshēng de shìjuàn.',
      'Giám thị phòng thi sau khi tiếng còi kết thúc giờ thi vang lên đã lần lượt thu đủ bài thi của thí sinh theo thứ tự số báo danh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '监考老师在考试结束哨声响起后，按学号顺序逐一收齐了考生的试卷。', 'Jiānkǎo lǎoshī zài kǎoshì jiéshù shàoshēng xiǎngqǐ hòu, àn xuéhào shùnxù zhúyī shōuqí le kǎoshēng de shìjuàn.', 'Giám thị phòng thi sau khi tiếng còi kết thúc giờ thi vang lên đã lần lượt thu đủ bài thi của thí sinh theo thứ tự số báo danh.', 'basic', 1),
      (v_id, '国家级标准化资格认证考试全面启用智能电子试卷阅卷系统与双盲背靠背复核机制，切实保障评分公平公正。', 'Guójiājí biāozhǔnhuà zīgé rènzhèng kǎoshì quánmiàn qǐyòng zhìnéng diànzǐ shìjuàn yuèjuàn xìtǒng yǔ shuāngmáng bèikàobèi fùhé jīzhì, qièshí bǎozhàng píngfēn gōngpíng gōngzhèng.', 'Kỳ thi chứng chỉ nghề tiêu chuẩn hóa cấp quốc gia đã đưa vào vận hành toàn diện hệ thống chấm bài thi điện tử thông minh và cơ chế phúc tra độc lập hai chiều mù đôi, bảo đảm thiết thực tính công bằng công chính khi chấm điểm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3034] [市民] (shìmín) - thị dân, người dân thành phố, cư dân đô thị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '市民' AND pinyin = 'shìmín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '市民' AND pinyin = 'shìmín'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '市民'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '市民'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shìmín',
      meaning_vi = 'thị dân, người dân thành phố, cư dân đô thị',
      example_hanzi = '清晨的滨江公园绿道上，许多市民在欢快地慢跑和练习太极拳。',
      example_pinyin = 'Qīngchén de bīnjiāng gōngyuán lǜdào shang, xǔduō shìmín zài huānkuài de mànpǎo hé liànxí tàijíquán.',
      example_vi = 'Trên đường xanh công viên ven sông buổi sáng sớm, rất nhiều người dân thành phố đang vui vẻ chạy bộ chậm và luyện tập Thái Cực Quyền.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '市民',
      'shìmín',
      'thị dân, người dân thành phố, cư dân đô thị',
      'Danh từ',
      'HSK 5',
      '清晨的滨江公园绿道上，许多市民在欢快地慢跑和练习太极拳。',
      'Qīngchén de bīnjiāng gōngyuán lǜdào shang, xǔduō shìmín zài huānkuài de mànpǎo hé liànxí tàijíquán.',
      'Trên đường xanh công viên ven sông buổi sáng sớm, rất nhiều người dân thành phố đang vui vẻ chạy bộ chậm và luyện tập Thái Cực Quyền.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '清晨的滨江公园绿道上，许多市民在欢快地慢跑和练习太极拳。', 'Qīngchén de bīnjiāng gōngyuán lǜdào shang, xǔduō shìmín zài huānkuài de mànpǎo hé liànxí tàijíquán.', 'Trên đường xanh công viên ven sông buổi sáng sớm, rất nhiều người dân thành phố đang vui vẻ chạy bộ chậm và luyện tập Thái Cực Quyền.', 'basic', 1),
      (v_id, '城市数字化转型应当始终以市民急难愁盼需求为牵引，让数字技术真正惠及全体市民的高品质日常生活。', 'Chéngshì shùzìhuà zhuǎnxíng yīngdāng shǐzhōng yǐ shìmín jínán-chóupàn xūqiú wéi qiānyǐn, ràng shùzì jìshù zhēnzhèng huìjí quántǐ shìmín de gāo-pǐnzhì rìcháng shēnghuó.', 'Chuyển đổi số đô thị phải luôn lấy nhu cầu thiết thân cấp bách của người dân làm đầu tàu dẫn dắt, để công nghệ số thực sự đem lại lợi ích thiết thực cho đời sống sinh hoạt chất lượng cao của toàn thể cư dân đô thị.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3035] [事实] (shìshí) - sự thật, sự việc có thật, thực tế [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '事实' AND pinyin = 'shìshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事实' AND pinyin = 'shìshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '事实'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事实'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shìshí',
      meaning_vi = 'sự thật, sự việc có thật, thực tế',
      example_hanzi = '在确凿的科学客观事实面前，一切毫无依据的谣言都会不攻自破。',
      example_pinyin = 'Zài quèzáo de kēxué kèguān shìshí miànqián, yíqiè háowú yījù de yáoyán dōu huì bùgōng-zìpò.',
      example_vi = 'Trước những sự thật khách quan khoa học xác thực, mọi lời đồn đại vô căn cứ đều sẽ tự sụp đổ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '事实',
      'shìshí',
      'sự thật, sự việc có thật, thực tế',
      'Danh từ',
      'HSK 5',
      '在确凿的科学客观事实面前，一切毫无依据的谣言都会不攻自破。',
      'Zài quèzáo de kēxué kèguān shìshí miànqián, yíqiè háowú yījù de yáoyán dōu huì bùgōng-zìpò.',
      'Trước những sự thật khách quan khoa học xác thực, mọi lời đồn đại vô căn cứ đều sẽ tự sụp đổ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在确凿的科学客观事实面前，一切毫无依据的谣言都会不攻自破。', 'Zài quèzáo de kēxué kèguān shìshí miànqián, yíqiè háowú yījù de yáoyán dōu huì bùgōng-zìpò.', 'Trước những sự thật khách quan khoa học xác thực, mọi lời đồn đại vô căn cứ đều sẽ tự sụp đổ.', 'basic', 1),
      (v_id, '国际司法仲裁必须严格以法律为准绳、以客观事实为根据，公正妥善裁判当事各方跨国经贸权益争端。', 'Guójì sīfǎ zhòngcái bìxū yángé yǐ fǎlǜ wéi zhǔnshéng, yǐ kèguān shìshí wéi gēnjù, gōngzhèng tuǒshàn cáipàn dāngshì gèfāng kuàguó jīngmào quányì zhēngduān.', 'Trọng tài tư pháp quốc tế bắt buộc phải lấy pháp luật làm thước đo, lấy sự thật khách quan làm căn cứ, phán quyết công bằng thỏa đáng các tranh chấp quyền lợi kinh tế thương mại xuyên quốc gia giữa các bên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3036] [视为] (shìwéi) - coi là, xem như là, nhìn nhận như [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '视为' AND pinyin = 'shìwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '视为' AND pinyin = 'shìwéi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '视为'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '视为'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shìwéi',
      meaning_vi = 'coi là, xem như là, nhìn nhận như',
      example_hanzi = '在许多亚洲传统文化中，喜鹊一直被人们视为吉祥与喜事的象征。',
      example_pinyin = 'Zài xǔduō Yàzhōu chuántǒng wénhuà zhōng, xǐquè yìzhí bèi rénmen shìwéi jíxiáng yǔ xǐshì de xiàngzhēng.',
      example_vi = 'Trong nhiều nền văn hóa truyền thống châu Á, chim hỷ thước luôn được mọi người xem như là biểu tượng của điều lành và chuyện hỷ sự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '视为',
      'shìwéi',
      'coi là, xem như là, nhìn nhận như',
      'Động từ',
      'HSK 5',
      '在许多亚洲传统文化中，喜鹊一直被人们视为吉祥与喜事的象征。',
      'Zài xǔduō Yàzhōu chuántǒng wénhuà zhōng, xǐquè yìzhí bèi rénmen shìwéi jíxiáng yǔ xǐshì de xiàngzhēng.',
      'Trong nhiều nền văn hóa truyền thống châu Á, chim hỷ thước luôn được mọi người xem như là biểu tượng của điều lành và chuyện hỷ sự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在许多亚洲传统文化中，喜鹊一直被人们视为吉祥与喜事的象征。', 'Zài xǔduō Yàzhōu chuántǒng wénhuà zhōng, xǐquè yìzhí bèi rénmen shìwéi jíxiáng yǔ xǐshì de xiàngzhēng.', 'Trong nhiều nền văn hóa truyền thống châu Á, chim hỷ thước luôn được mọi người xem như là biểu tượng của điều lành và chuyện hỷ sự.', 'basic', 1),
      (v_id, '在国际法公约体系下，公海海底及其矿产资源被正式确立为全人类共同继承财产，不被视为任何国家的领土延伸。', 'Zài guójìfǎ gōngyuē tǐxì xià, gōnghǎi hǎidǐ jí qí kuàngchǎn zīyuán bèi zhèngshì quèlì wèi quán-rénlèi gòngtóng jìchéng cáichǎn, bù bèi shìwéi rènhé guójiā de lǐngtǔ yánshēn.', 'Dưới hệ thống công ước luật pháp quốc tế, đáy biển quốc tế và tài nguyên khoáng sản ở đó được chính thức xác lập là di sản chung của toàn nhân loại, không bị coi là phần lãnh thổ mở rộng của bất kỳ quốc gia nào.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3037] [事物] (shìwù) - sự vật, việc, hiện tượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '事物' AND pinyin = 'shìwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事物' AND pinyin = 'shìwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '事物'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shìwù',
      meaning_vi = 'sự vật, việc, hiện tượng',
      example_hanzi = '小孩子对周围的新鲜事物总是充满着强烈的好奇心与求知欲。',
      example_pinyin = 'Xiǎoháizi duì zhōuwéi de xīnxiān shìwù zǒngshì chōngmǎn zhe qiángliè de hàoqíxīn yǔ qiúzhīyù.',
      example_vi = 'Trẻ nhỏ đối với các sự vật mới mẻ xung quanh luôn tràn trề trí tò mò và lòng ham hiểu biết mãnh liệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '事物',
      'shìwù',
      'sự vật, việc, hiện tượng',
      'Danh từ',
      'HSK 5',
      '小孩子对周围的新鲜事物总是充满着强烈的好奇心与求知欲。',
      'Xiǎoháizi duì zhōuwéi de xīnxiān shìwù zǒngshì chōngmǎn zhe qiángliè de hàoqíxīn yǔ qiúzhīyù.',
      'Trẻ nhỏ đối với các sự vật mới mẻ xung quanh luôn tràn trề trí tò mò và lòng ham hiểu biết mãnh liệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小孩子对周围的新鲜事物总是充满着强烈的好奇心与求知欲。', 'Xiǎoháizi duì zhōuwéi de xīnxiān shìwù zǒngshì chōngmǎn zhe qiángliè de hàoqíxīn yǔ qiúzhīyù.', 'Trẻ nhỏ đối với các sự vật mới mẻ xung quanh luôn tràn trề trí tò mò và lòng ham hiểu biết mãnh liệt.', 'basic', 1),
      (v_id, '辩证唯物主义要求我们透过复杂繁冗的现象看清事物发展的内在本质，科学把握事物螺旋式上升的历史规律。', 'Biànzhèng wéiwùzhǔyì yāoqiú wǒmen tòuguò fùzá fánrǒng de xiànxiàng kàn qīng shìwù fāzhǎn de nèizài běnzhì, kēxué bǎwò shìwù luóxuánshì shàngshēng de lìshǐ guīlǜ.', 'Chủ nghĩa duy vật biện chứng đòi hỏi chúng ta phải xuyên qua các hiện tượng rườm rà phức tạp để nhìn rõ bản chất nội tại của sự phát triển sự vật, nắm bắt khoa học quy luật lịch sử tiến lên theo đường xoắn ốc của các sự vật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3038] [事先] (shìxiān) - trước, từ trước, trước khi việc xảy ra [Phó từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '事先' AND pinyin = 'shìxiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事先' AND pinyin = 'shìxiān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '事先'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事先'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Danh từ',
      pinyin = 'shìxiān',
      meaning_vi = 'trước, từ trước, trước khi việc xảy ra',
      example_hanzi = '如果明天因突发急事无法按时参加会议，请事先向办公室请假。',
      example_pinyin = 'Rúguǒ míngtiān yīn tūfā jíshì wúfǎ ànshí cānjiā huìyì, qǐng shìxiān xiàng bàngōngshì qǐngjià.',
      example_vi = 'Nếu ngày mai vì việc đột xuất không thể tham dự cuộc họp đúng giờ, xin vui lòng báo xin phép văn phòng từ trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '事先',
      'shìxiān',
      'trước, từ trước, trước khi việc xảy ra',
      'Phó từ / Danh từ',
      'HSK 5',
      '如果明天因突发急事无法按时参加会议，请事先向办公室请假。',
      'Rúguǒ míngtiān yīn tūfā jíshì wúfǎ ànshí cānjiā huìyì, qǐng shìxiān xiàng bàngōngshì qǐngjià.',
      'Nếu ngày mai vì việc đột xuất không thể tham dự cuộc họp đúng giờ, xin vui lòng báo xin phép văn phòng từ trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果明天因突发急事无法按时参加会议，请事先向办公室请假。', 'Rúguǒ míngtiān yīn tūfā jíshì wúfǎ ànshí cānjiā huìyì, qǐng shìxiān xiàng bàngōngshì qǐngjià.', 'Nếu ngày mai vì việc đột xuất không thể tham dự cuộc họp đúng giờ, xin vui lòng báo xin phép văn phòng từ trước.', 'basic', 1),
      (v_id, '在实施重大工程野外爆破作业之前，施工单位必须事先向应急安全主管机构报批并向周围居民发布公告。', 'Zài shíshī zhòngdà gōngchéng yěwài bàopò zuòyè zhīqián, shīgōng dānwèi bìxū shìxiān xiàng yìngjí ānquán zhǔguǎn jīgòu bàopī bìng xiàng zhōuwéi jūmín fābù gōnggào.', 'Trước khi thực hiện hoạt động nổ mìn dã ngoại của công trình trọng điểm, đơn vị thi công bắt buộc phải đệ trình phê duyệt lên cơ quan chủ quản an toàn khẩn cấp từ trước và phát thông báo tới cư dân xung quanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3039] [试验] (shìyàn) - thử nghiệm, kiểm nghiệm thực nghiệm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '试验' AND pinyin = 'shìyàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '试验' AND pinyin = 'shìyàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '试验'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '试验'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shìyàn',
      meaning_vi = 'thử nghiệm, kiểm nghiệm thực nghiệm',
      example_hanzi = '新研发的高铁车头在试验轨道上顺利完成了四百公里时速的高速测试。',
      example_pinyin = 'Xīn yánfā de gāotiě chētóu zài shìyàn guǐdào shang shùnlì wánchéng le sìbǎi gōnglǐ shísù de gāosù cèshì.',
      example_vi = 'Đầu máy đường sắt cao tốc mới nghiên cứu chế tạo đã hoàn thành thuận lợi cuộc kiểm tra tốc độ cao 400 km/h trên đường ray thử nghiệm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '试验',
      'shìyàn',
      'thử nghiệm, kiểm nghiệm thực nghiệm',
      'Động từ / Danh từ',
      'HSK 5',
      '新研发的高铁车头在试验轨道上顺利完成了四百公里时速的高速测试。',
      'Xīn yánfā de gāotiě chētóu zài shìyàn guǐdào shang shùnlì wánchéng le sìbǎi gōnglǐ shísù de gāosù cèshì.',
      'Đầu máy đường sắt cao tốc mới nghiên cứu chế tạo đã hoàn thành thuận lợi cuộc kiểm tra tốc độ cao 400 km/h trên đường ray thử nghiệm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新研发的高铁车头在试验轨道上顺利完成了四百公里时速的高速测试。', 'Xīn yánfā de gāotiě chētóu zài shìyàn guǐdào shang shùnlì wánchéng le sìbǎi gōnglǐ shísù de gāosù cèshì.', 'Đầu máy đường sắt cao tốc mới nghiên cứu chế tạo đã hoàn thành thuận lợi cuộc kiểm tra tốc độ cao 400 km/h trên đường ray thử nghiệm.', 'basic', 1),
      (v_id, '我国在深海高压极端工况环境下开展全海深潜水器极限耐压寿命试验，全面验证了国产钛合金球舱的结构可靠性。', 'Wǒguó zài shēnhǎi gāoyā jíduān gōngkuàng huánjìng xià kāizhǎn quán-hǎishēn qiánshuǐqì jíxiàn nàiyā shòumìng shìyàn, quánmiàn yànzhèng le guóchǎn tàihéjīn qiúcāng de jiégòu kěkàoxìng.', 'Nước ta đã triển khai thử nghiệm tuổi thọ chịu áp suất giới hạn của tàu lặn biển toàn phần dưới điều kiện công tác cực đoan cao áp biển sâu, kiểm chứng toàn diện độ tin cậy kết cấu khoang cầu hợp kim titan nội địa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3040] [事业] (shìyè) - sự nghiệp, công cuộc nghiệp lớn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '事业' AND pinyin = 'shìyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事业' AND pinyin = 'shìyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '事业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '事业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shìyè',
      meaning_vi = 'sự nghiệp, công cuộc nghiệp lớn',
      example_hanzi = '他把毕生的心血和青春都奉献给了祖国的乡村基础教育事业。',
      example_pinyin = 'Tā bǎ bìshēng de xīnxuè hé qīngchūn dōu fèngxiàn gěi le zǔguó de xiāngcūn jīchǔ jiàoyù shìyè.',
      example_vi = 'Thầy đã cống hiến trọn vẹn tâm huyết và tuổi thanh xuân của cả cuộc đời mình cho sự nghiệp giáo dục cơ sở nông thôn của tổ quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '事业',
      'shìyè',
      'sự nghiệp, công cuộc nghiệp lớn',
      'Danh từ',
      'HSK 5',
      '他把毕生的心血和青春都奉献给了祖国的乡村基础教育事业。',
      'Tā bǎ bìshēng de xīnxuè hé qīngchūn dōu fèngxiàn gěi le zǔguó de xiāngcūn jīchǔ jiàoyù shìyè.',
      'Thầy đã cống hiến trọn vẹn tâm huyết và tuổi thanh xuân của cả cuộc đời mình cho sự nghiệp giáo dục cơ sở nông thôn của tổ quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他把毕生的心血和青春都奉献给了祖国的乡村基础教育事业。', 'Tā bǎ bìshēng de xīnxuè hé qīngchūn dōu fèngxiàn gěi le zǔguó de xiāngcūn jīchǔ jiàoyù shìyè.', 'Thầy đã cống hiến trọn vẹn tâm huyết và tuổi thanh xuân của cả cuộc đời mình cho sự nghiệp giáo dục cơ sở nông thôn của tổ quốc.', 'basic', 1),
      (v_id, '推进人与自然和谐共生的中国式现代化，是造福全人类福祉的崇高生态文明事业，需要一代代人接续奋斗。', 'Tuījìn rén yǔ zìrán héxié gòngshēng de Zhōngguóshì xiàndàihuà, shì zàofú quán rénlèi fúzhǐ de chónggāo shēngtài wénmíng shìyè, xūyào yídàidài rén jiēxù fèndòu.', 'Thúc đẩy hiện đại hóa kiểu Trung Quốc nơi con người và tự nhiên chung sống hài hòa là sự nghiệp văn minh sinh thái cao cả mang lại phúc lợi cho toàn nhân loại, đòi hỏi bao thế hệ người nối tiếp nhau phấn đấu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3041] [试用] (shìyòng) - dùng thử, thử nghiệm, thử việc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '试用' AND pinyin = 'shìyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '试用' AND pinyin = 'shìyòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '试用'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '试用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shìyòng',
      meaning_vi = 'dùng thử, thử nghiệm, thử việc',
      example_hanzi = '新入职的员工通常有三个月的试用期，考核合格后转为正式员工。',
      example_pinyin = 'Xīn rùzhí de yuángōng tōngcháng yǒu sān ge yuè de shìyòngqī, kǎohé hégé hòu zhuǎn wéi zhèngshì yuángōng.',
      example_vi = 'Nhân viên mới vào công ty thường có thời gian thử việc ba tháng, sau khi đánh giá đạt yêu cầu sẽ chuyển sang làm nhân viên chính thức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '试用',
      'shìyòng',
      'dùng thử, thử nghiệm, thử việc',
      'Động từ',
      'HSK 5',
      '新入职的员工通常有三个月的试用期，考核合格后转为正式员工。',
      'Xīn rùzhí de yuángōng tōngcháng yǒu sān ge yuè de shìyòngqī, kǎohé hégé hòu zhuǎn wéi zhèngshì yuángōng.',
      'Nhân viên mới vào công ty thường có thời gian thử việc ba tháng, sau khi đánh giá đạt yêu cầu sẽ chuyển sang làm nhân viên chính thức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新入职的员工通常有三个月的试用期，考核合格后转为正式员工。', 'Xīn rùzhí de yuángōng tōngcháng yǒu sān ge yuè de shìyòngqī, kǎohé hégé hòu zhuǎn wéi zhèngshì yuángōng.', 'Nhân viên mới vào công ty thường có thời gian thử việc ba tháng, sau khi đánh giá đạt yêu cầu sẽ chuyển sang làm nhân viên chính thức.', 'basic', 1),
      (v_id, '软件开发团队邀请首批核心开发者对新一代分布式数据库进行深度试用体验，并根据反馈持续优化高并发读写性能。', 'Ruǎnjiàn kāifā tuánduì yāoqǐng shǒupī héxīn kāifāzhě duì xīn yí dài fēnbùshì shùjùkù jìnxíng shēndù shìyòng tǐyàn, bìng gēnjù fǎnkuì chíxù yōuhuà gāo-bīngfā dú-xiě xìngnéng.', 'Nhóm phát triển phần mềm mời đợt lập trình viên cốt lõi đầu tiên tiến hành trải nghiệm dùng thử chuyên sâu hệ cơ sở dữ liệu phân tán thế hệ mới, đồng thời dựa trên phản hồi để liên tục tối ưu hóa hiệu năng đọc ghi đồng thời cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3042] [适用] (shìyòng) - thích dụng, phù hợp ứng dụng, áp dụng được [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '适用' AND pinyin = 'shìyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '适用' AND pinyin = 'shìyòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '适用'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '适用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shìyòng',
      meaning_vi = 'thích dụng, phù hợp ứng dụng, áp dụng được',
      example_hanzi = '这套通俗易懂的中文学习教材非常适合零基础外国成年学习者使用。',
      example_pinyin = 'Zhè tào tōngsú-yìdǒng de Zhōngwén xuéxí jiàocái fēicháng shìhé líng-jīchǔ wàiguó chéngnián xuéxízhě shǐyòng.',
      example_vi = 'Bộ giáo trình học tiếng Trung dễ hiểu đời thường này cực kỳ thích hợp áp dụng cho những người học trưởng thành nước ngoài chưa có nền tảng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '适用',
      'shìyòng',
      'thích dụng, phù hợp ứng dụng, áp dụng được',
      'Tính từ',
      'HSK 5',
      '这套通俗易懂的中文学习教材非常适合零基础外国成年学习者使用。',
      'Zhè tào tōngsú-yìdǒng de Zhōngwén xuéxí jiàocái fēicháng shìhé líng-jīchǔ wàiguó chéngnián xuéxízhě shǐyòng.',
      'Bộ giáo trình học tiếng Trung dễ hiểu đời thường này cực kỳ thích hợp áp dụng cho những người học trưởng thành nước ngoài chưa có nền tảng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这套通俗易懂的中文学习教材非常适合零基础外国成年学习者使用。', 'Zhè tào tōngsú-yìdǒng de Zhōngwén xuéxí jiàocái fēicháng shìhé líng-jīchǔ wàiguó chéngnián xuéxízhě shǐyòng.', 'Bộ giáo trình học tiếng Trung dễ hiểu đời thường này cực kỳ thích hợp áp dụng cho những người học trưởng thành nước ngoài chưa có nền tảng.', 'basic', 1),
      (v_id, '司法审判实践应当准确把握法律条款的适用范围，防止机械照搬法条导致利益衡量严重失衡。', 'Sīfǎ shěnpàn shíjiàn yīngdāng zhǔnquè bǎwò fǎlǜ tiáokuǎn de shìyòng fànwéi, fángzhǐ jīxiè zhàobān fǎtiáo dǎozhì lìyì héngliáng yánzhòng shīhéng.', 'Thực tiễn xét xử tư pháp cần phải nắm vững chính xác phạm vi áp dụng của các điều khoản pháp luật, ngăn ngừa việc rập khuôn điều luật máy móc dẫn tới sự mất cân bằng nghiêm trọng trong cân nhắc lợi ích.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3043] [收获] (shōuhuò) - thu hoạch, gặt hái; thành quả đạt được [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '收获' AND pinyin = 'shōuhuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '收获' AND pinyin = 'shōuhuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '收获'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '收获'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shōuhuò',
      meaning_vi = 'thu hoạch, gặt hái; thành quả đạt được',
      example_hanzi = '一分耕耘，一分收获，辛勤的汗水终于换来了优异的学业成绩。',
      example_pinyin = 'Yì fēn gēngyún, yì fēn shōuhuò, xīnqín de hànshuǐ zhōngyú huàn lái le yōuyì de xuéyè chéngjì.',
      example_vi = 'Có công mài sắt có ngày nên kim, một phần cày bừa một phần thu hoạch, những giọt mồ hôi công sức cuối cùng đã đổi lại thành tích học tập xuất sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '收获',
      'shōuhuò',
      'thu hoạch, gặt hái; thành quả đạt được',
      'Động từ / Danh từ',
      'HSK 5',
      '一分耕耘，一分收获，辛勤的汗水终于换来了优异的学业成绩。',
      'Yì fēn gēngyún, yì fēn shōuhuò, xīnqín de hànshuǐ zhōngyú huàn lái le yōuyì de xuéyè chéngjì.',
      'Có công mài sắt có ngày nên kim, một phần cày bừa một phần thu hoạch, những giọt mồ hôi công sức cuối cùng đã đổi lại thành tích học tập xuất sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一分耕耘，一分收获，辛勤的汗水终于换来了优异的学业成绩。', 'Yì fēn gēngyún, yì fēn shōuhuò, xīnqín de hànshuǐ zhōngyú huàn lái le yōuyì de xuéyè chéngjì.', 'Có công mài sắt có ngày nên kim, một phần cày bừa một phần thu hoạch, những giọt mồ hôi công sức cuối cùng đã đổi lại thành tích học tập xuất sắc.', 'basic', 1),
      (v_id, '经过长达三年的国际联合科研攻坚，跨国课题组在非线性光学材料合成领域收获了突破性理论成果。', 'Jīngguò cháng dá sān nián de guójì liánhé kēyán gōngjiān, kuàguó kètízǔ zài fēi-xiànxìng guāngxué cáiliào héchéng lǐngyù shōuhuò le tūpòxìng lǐlùn chéngguǒ.', 'Sau ba năm dài cùng nhau liên kết nghiên cứu khắc phục khó khăn, nhóm đề tài đa quốc gia đã gặt hái được những thành quả lý thuyết đột phá trong lĩnh vực tổng hợp vật liệu quang học phi tuyến.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3044] [收集] (shōují) - thu thập, sưu tầm, gom góp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '收集' AND pinyin = 'shōují'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '收集' AND pinyin = 'shōují'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '收集'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '收集'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shōují',
      meaning_vi = 'thu thập, sưu tầm, gom góp',
      example_hanzi = '他从小就喜欢收集世界各国发行的特色纪念邮票和精美明信片。',
      example_pinyin = 'Tā cóngxiǎo jiù xǐhuan shōují shìjiè gè guó fāxíng de tèsè jǐniàn yóupiào hé jīngměi míngxìnpiàn.',
      example_vi = 'Từ nhỏ anh ấy đã thích sưu tầm những bộ tem kỷ niệm đặc sắc và bưu thiếp tinh xảo do các quốc gia trên thế giới phát hành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '收集',
      'shōují',
      'thu thập, sưu tầm, gom góp',
      'Động từ',
      'HSK 5',
      '他从小就喜欢收集世界各国发行的特色纪念邮票和精美明信片。',
      'Tā cóngxiǎo jiù xǐhuan shōují shìjiè gè guó fāxíng de tèsè jǐniàn yóupiào hé jīngměi míngxìnpiàn.',
      'Từ nhỏ anh ấy đã thích sưu tầm những bộ tem kỷ niệm đặc sắc và bưu thiếp tinh xảo do các quốc gia trên thế giới phát hành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他从小就喜欢收集世界各国发行的特色纪念邮票和精美明信片。', 'Tā cóngxiǎo jiù xǐhuan shōují shìjiè gè guó fāxíng de tèsè jǐniàn yóupiào hé jīngměi míngxìnpiàn.', 'Từ nhỏ anh ấy đã thích sưu tầm những bộ tem kỷ niệm đặc sắc và bưu thiếp tinh xảo do các quốc gia trên thế giới phát hành.', 'basic', 1),
      (v_id, '气象卫星遥感网络实时收集台风中心气压与海平面云系高光谱多源遥感数据，为防灾减灾提供精准时空支撑。', 'Qìxiàng wèixīng yáogǎn wǎngluò shíshí shōují táifēng zhōngxīn qìyā yǔ hǎipíngmiàn yúnxì gāo-guāngpǔ duō-yuán yáogǎn shùjù, wèi fángzāi-jiǎnzāi tígōng jīngzhǔn shíkōng zhīchēng.', 'Mạng lưới viễn thám vệ tinh khí tượng thu thập thời gian thực dữ liệu viễn thám đa nguồn siêu quang phổ của áp suất khí quyển tâm bão và hệ thống mây mặt biển, cung cấp căn cứ không gian thời gian chính xác cho công tác phòng chống giảm nhẹ thiên tai.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3045] [收看] (shōukàn) - đón xem, theo dõi qua màn ảnh nhỏ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '收看' AND pinyin = 'shōukàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '收看' AND pinyin = 'shōukàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '收看'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '收看'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shōukàn',
      meaning_vi = 'đón xem, theo dõi qua màn ảnh nhỏ',
      example_hanzi = '除夕夜，全家人围坐在电视机旁准时收看一年一度的中央广播电视总台春节联欢晚会。',
      example_pinyin = 'Chúxī yè, quán jiā rén wéizuò zài diànshìjī páng zhǔnshí shōukàn yì nián yí dù de Zhōngyāng Guǎngbō Diànshì Zǒngtái Chūnjié Liánhuān Wǎnhuì.',
      example_vi = 'Đêm giao thừa, cả nhà quây quần bên chiếc tivi đúng giờ đón xem đêm hội Gala mừng Xuân hàng năm của Đài Phát thanh Truyền hình Trung ương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '收看',
      'shōukàn',
      'đón xem, theo dõi qua màn ảnh nhỏ',
      'Động từ',
      'HSK 5',
      '除夕夜，全家人围坐在电视机旁准时收看一年一度的中央广播电视总台春节联欢晚会。',
      'Chúxī yè, quán jiā rén wéizuò zài diànshìjī páng zhǔnshí shōukàn yì nián yí dù de Zhōngyāng Guǎngbō Diànshì Zǒngtái Chūnjié Liánhuān Wǎnhuì.',
      'Đêm giao thừa, cả nhà quây quần bên chiếc tivi đúng giờ đón xem đêm hội Gala mừng Xuân hàng năm của Đài Phát thanh Truyền hình Trung ương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '除夕夜，全家人围坐在电视机旁准时收看一年一度的中央广播电视总台春节联欢晚会。', 'Chúxī yè, quán jiā rén wéizuò zài diànshìjī páng zhǔnshí shōukàn yì nián yí dù de Zhōngyāng Guǎngbō Diànshì Zǒngtái Chūnjié Liánhuān Wǎnhuì.', 'Đêm giao thừa, cả nhà quây quần bên chiếc tivi đúng giờ đón xem đêm hội Gala mừng Xuân hàng năm của Đài Phát thanh Truyền hình Trung ương.', 'basic', 1),
      (v_id, '全球数亿观众通过超高清8K超宽带多视角直播卫星信号，实时收看奥运会主体育场盛大的开幕式庆典。', 'Quánqiú shù yì guānzhòng tōngguò chāo-gāoqīng 8K chāo-kuāndài duō-shìjiǎo zhíbò wèixīng xìnhào, shíshí shōukàn Àoyùnhuì zhǔ tǐyùchǎng shèngdà de kāimùshì qìngdiǎn.', 'Hàng trăm triệu khán giả toàn cầu thông qua tín hiệu vệ tinh trực tiếp đa góc nhìn băng thông siêu rộng 8K siêu nét đã theo dõi trực tiếp buổi lễ khai mạc hoành tráng của Thế vận hội tại sân vận động chính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3046] [守] (shǒu) - giữ gìn, canh gác, tuân thủ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '守' AND pinyin = 'shǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '守' AND pinyin = 'shǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '守'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '守'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shǒu',
      meaning_vi = 'giữ gìn, canh gác, tuân thủ',
      example_hanzi = '做人要讲信誉，答应了别人的事情就一定要恪守诺言。',
      example_pinyin = 'Zuòrén yào jiǎng xìnyù, dāying le biérén de shìqing jiù yídìng yào kèshǒu nuòyán.',
      example_vi = 'Làm người phải trọng chữ tín, việc gì đã nhận lời với người khác thì nhất định phải giữ đúng lời hứa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '守',
      'shǒu',
      'giữ gìn, canh gác, tuân thủ',
      'Động từ',
      'HSK 5',
      '做人要讲信誉，答应了别人的事情就一定要恪守诺言。',
      'Zuòrén yào jiǎng xìnyù, dāying le biérén de shìqing jiù yídìng yào kèshǒu nuòyán.',
      'Làm người phải trọng chữ tín, việc gì đã nhận lời với người khác thì nhất định phải giữ đúng lời hứa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '做人要讲信誉，答应了别人的事情就一定要恪守诺言。', 'Zuòrén yào jiǎng xìnyù, dāying le biérén de shìqing jiù yídìng yào kèshǒu nuòyán.', 'Làm người phải trọng chữ tín, việc gì đã nhận lời với người khác thì nhất định phải giữ đúng lời hứa.', 'basic', 1),
      (v_id, '戍边边防官兵在雪域高原缺氧严寒环境下日夜巡逻坚守哨所，用热血与赤诚筑起保卫国家主权安全的钢铁长城。', 'Shùbiān biānfáng guānbīng zài xuěyù gāoyuán quēyǎng yánhán huánjìng xià rìyè xúnluó jiānshǒu shàosuǒ, yòng rèxuè yǔ chìchéng zhù qǐ bǎowèi guójiā zhǔquán ānquán de gāngtiě chángchéng.', 'Các cán bộ chiến sĩ biên phòng đóng quân nơi biên cương trong điều kiện thiếu oxy rét buốt trên cao nguyên tuyết trắng ngày đêm tuần tra kiên thủ chốt gác, lấy nhiệt huyết và lòng son đúc nên bức trường thành thép bảo vệ chủ quyền an ninh quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3047] [首次] (shǒucì) - lần đầu tiên, lần đầu [Số-Lượng từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '首次' AND pinyin = 'shǒucì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '首次' AND pinyin = 'shǒucì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '首次'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '首次'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Số-Lượng từ / Phó từ',
      pinyin = 'shǒucì',
      meaning_vi = 'lần đầu tiên, lần đầu',
      example_hanzi = '这是他首次代表学校参加全国大学生英语演讲总决赛。',
      example_pinyin = 'Zhè shì tā shǒucì dàibiǎo xuéxiào cānjiā quánguó dàxuéshēng Yīngyǔ yǎnjiǎng zǒngjuésài.',
      example_vi = 'Đây là lần đầu tiên anh ấy đại diện cho nhà trường tham dự vòng chung kết cuộc thi hùng biện tiếng Anh sinh viên toàn quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '首次',
      'shǒucì',
      'lần đầu tiên, lần đầu',
      'Số-Lượng từ / Phó từ',
      'HSK 5',
      '这是他首次代表学校参加全国大学生英语演讲总决赛。',
      'Zhè shì tā shǒucì dàibiǎo xuéxiào cānjiā quánguó dàxuéshēng Yīngyǔ yǎnjiǎng zǒngjuésài.',
      'Đây là lần đầu tiên anh ấy đại diện cho nhà trường tham dự vòng chung kết cuộc thi hùng biện tiếng Anh sinh viên toàn quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这是他首次代表学校参加全国大学生英语演讲总决赛。', 'Zhè shì tā shǒucì dàibiǎo xuéxiào cānjiā quánguó dàxuéshēng Yīngyǔ yǎnjiǎng zǒngjuésài.', 'Đây là lần đầu tiên anh ấy đại diện cho nhà trường tham dự vòng chung kết cuộc thi hùng biện tiếng Anh sinh viên toàn quốc.', 'basic', 1),
      (v_id, '空间站航天员乘组成功完成我国航天员首次在轨紧急出舱太空行走与机械臂协同巡检任务。', 'Kōngjiānzhàn hángtiānyuán chéngzǔ chénggōng wánchéng wǒguó hángtiānyuán shǒucì zàiguǐ jǐnjí chūcāng tàikōng xíngzǒu yǔ jīxièbì xiétóng xúnjiǎn rènwù.', 'Tổ phi hành gia trạm vũ trụ đã hoàn thành xuất sắc nhiệm vụ đi bộ ngoài không gian bước ra khỏi khoang khẩn cấp trên quỹ đạo và phối hợp cánh tay robot tuần tra kiểm tra lần đầu tiên của phi hành gia nước ta.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3048] [手段] (shǒuduàn) - thủ đoạn, phương thức, biện pháp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '手段' AND pinyin = 'shǒuduàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手段' AND pinyin = 'shǒuduàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '手段'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手段'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shǒuduàn',
      meaning_vi = 'thủ đoạn, phương thức, biện pháp',
      example_hanzi = '老师运用多种生动有趣的教学手段，极大地激发了学生们学习外语的兴趣。',
      example_pinyin = 'Lǎoshī yùnyòng duō zhǒng shēngdòng yǒuqù de jiàoxué shǒuduàn, jídà de jīfā le xuéshēngmen xuéxí wàiyǔ de xìngqù.',
      example_vi = 'Thầy giáo đã vận dụng nhiều phương thức dạy học sinh động và thú vị, khơi dậy mạnh mẽ hứng thú học ngoại ngữ của các em học sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '手段',
      'shǒuduàn',
      'thủ đoạn, phương thức, biện pháp',
      'Danh từ',
      'HSK 5',
      '老师运用多种生动有趣的教学手段，极大地激发了学生们学习外语的兴趣。',
      'Lǎoshī yùnyòng duō zhǒng shēngdòng yǒuqù de jiàoxué shǒuduàn, jídà de jīfā le xuéshēngmen xuéxí wàiyǔ de xìngqù.',
      'Thầy giáo đã vận dụng nhiều phương thức dạy học sinh động và thú vị, khơi dậy mạnh mẽ hứng thú học ngoại ngữ của các em học sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老师运用多种生动有趣的教学手段，极大地激发了学生们学习外语的兴趣。', 'Lǎoshī yùnyòng duō zhǒng shēngdòng yǒuqù de jiàoxué shǒuduàn, jídà de jīfā le xuéshēngmen xuéxí wàiyǔ de xìngqù.', 'Thầy giáo đã vận dụng nhiều phương thức dạy học sinh động và thú vị, khơi dậy mạnh mẽ hứng thú học ngoại ngữ của các em học sinh.', 'basic', 1),
      (v_id, '中央银行综合运用降准、定向再贷款以及公开市场操作等多种货币政策手段，精准有力支持实体经济高质量发展。', 'Zhōngyāng yínháng zōnghé yùnyòng jiàngzhǔn, dìngxiàng zàidàikuǎn yǐjí gōngkāi shìchǎng cāozuò děng duō zhǒng huòbì zhèngcè shǒuduàn, jīngzhǔn yǒulì zhīchí shítǐ jīngjì gāo-zhìliàng fāzhǎn.', 'Ngân hàng Trung ương vận dụng tổng hợp nhiều phương thức chính sách tiền tệ như giảm tỷ lệ dự trữ bắt buộc, tái cấp vốn theo mục tiêu và nghiệp vụ thị trường mở, hỗ trợ chuẩn xác và mạnh mẽ cho sự phát triển chất lượng cao của nền kinh tế thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3049] [手工] (shǒugōng) - thủ công, làm bằng tay [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '手工' AND pinyin = 'shǒugōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手工' AND pinyin = 'shǒugōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '手工'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手工'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'shǒugōng',
      meaning_vi = 'thủ công, làm bằng tay',
      example_hanzi = '幼儿园老师正在耐心地教孩子们用彩色纸张折叠各种精美的手工作品。',
      example_pinyin = 'Yòu’éryuán lǎoshī zhèngzài nàixīn de jiāo háizimen yòng cǎisè zhǐzhāng zhédié gè zhǒng jīngměi de shǒugōng zuòpǐn.',
      example_vi = 'Cô giáo mầm non đang kiên nhẫn dạy các bé dùng những tờ giấy màu xếp thành các tác phẩm thủ công tinh xảo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '手工',
      'shǒugōng',
      'thủ công, làm bằng tay',
      'Danh từ / Tính từ',
      'HSK 5',
      '幼儿园老师正在耐心地教孩子们用彩色纸张折叠各种精美的手工作品。',
      'Yòu’éryuán lǎoshī zhèngzài nàixīn de jiāo háizimen yòng cǎisè zhǐzhāng zhédié gè zhǒng jīngměi de shǒugōng zuòpǐn.',
      'Cô giáo mầm non đang kiên nhẫn dạy các bé dùng những tờ giấy màu xếp thành các tác phẩm thủ công tinh xảo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '幼儿园老师正在耐心地教孩子们用彩色纸张折叠各种精美的手工作品。', 'Yòu’éryuán lǎoshī zhèngzài nàixīn de jiāo háizimen yòng cǎisè zhǐzhāng zhédié gè zhǒng jīngměi de shǒugōng zuòpǐn.', 'Cô giáo mầm non đang kiên nhẫn dạy các bé dùng những tờ giấy màu xếp thành các tác phẩm thủ công tinh xảo.', 'basic', 1),
      (v_id, '在工业标准化规模量产时代，坚守古法手工锻造的传统工艺美术精品凭借其独一无二的人文温润感具有极高的艺术附加值。', 'Zài gōngyè biāozhǔnhuà guīmó liàngchǎn shídài, jiānshǒu gǔfǎ shǒugōng duànzào de chuántǒng gōngyì měishù jīngpǐn píngjiè qí dúyī-wú’èr de rénwén wēnrùngǎn jùyǒu jí gāo de yìshù fùjiāzhí.', 'Trong kỷ nguyên sản xuất hàng loạt quy mô lớn chuẩn hóa công nghiệp, những tác phẩm mỹ nghệ thủ công truyền thống kiên trì với cách đúc rèn thủ công cổ xưa nhờ vào sự ấm áp nhân văn độc nhất vô nhị mà sở hữu giá trị gia tăng nghệ thuật cực kỳ cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3050] [手术] (shǒushù) - phẫu thuật, ca phẫu thuật, mổ [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '手术' AND pinyin = 'shǒushù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手术' AND pinyin = 'shǒushù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '手术'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手术'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'shǒushù',
      meaning_vi = 'phẫu thuật, ca phẫu thuật, mổ',
      example_hanzi = '主刀医生精湛的技术使得这台长达五个小时的心脏微创手术非常成功。',
      example_pinyin = 'Zhǔdāo yīshēng jīngzhàn de jìshù shǐde zhè tái cháng dá wǔ ge xiǎoshí de xīnzàng wēichuàng shǒushù fēicháng chénggōng.',
      example_vi = 'Tay nghề tinh xảo của bác sĩ phẫu thuật chính đã khiến ca phẫu thuật tim xâm lấn tối thiểu kéo dài 5 tiếng đồng hồ này thành công mỹ mãn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '手术',
      'shǒushù',
      'phẫu thuật, ca phẫu thuật, mổ',
      'Danh từ / Động từ',
      'HSK 5',
      '主刀医生精湛的技术使得这台长达五个小时的心脏微创手术非常成功。',
      'Zhǔdāo yīshēng jīngzhàn de jìshù shǐde zhè tái cháng dá wǔ ge xiǎoshí de xīnzàng wēichuàng shǒushù fēicháng chénggōng.',
      'Tay nghề tinh xảo của bác sĩ phẫu thuật chính đã khiến ca phẫu thuật tim xâm lấn tối thiểu kéo dài 5 tiếng đồng hồ này thành công mỹ mãn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '主刀医生精湛的技术使得这台长达五个小时的心脏微创手术非常成功。', 'Zhǔdāo yīshēng jīngzhàn de jìshù shǐde zhè tái cháng dá wǔ ge xiǎoshí de xīnzàng wēichuàng shǒushù fēicháng chénggōng.', 'Tay nghề tinh xảo của bác sĩ phẫu thuật chính đã khiến ca phẫu thuật tim xâm lấn tối thiểu kéo dài 5 tiếng đồng hồ này thành công mỹ mãn.', 'basic', 1),
      (v_id, '借助5G低时延超宽带通信技术，三甲专科医院首席神经外科专家为千里之外的边疆偏远医院成功实施了远程机器人脑部微创手术。', 'Jièzhù 5G dī-shíyán chāo-kuāndài tōngxìn jìshù, sānjiǎ zhuānkē yīyuàn shǒuxí shénjīng wàikē zhuānjiā wèi qiānlǐ zhī wài de biānjiāng piānyuǎn yīyuàn chénggōng shíshī le yuǎnchéng jīqìrén nǎobù wēichuàng shǒushù.', 'Nhờ công nghệ truyền thông 5G độ trễ cực thấp băng thông siêu rộng, chuyên gia phẫu thuật thần kinh hàng đầu của bệnh viện chuyên khoa tuyến một đã thực hiện thành công ca phẫu thuật não xâm lấn tối thiểu bằng robot từ xa cho một bệnh viện hẻo lánh vùng biên ải cách xa hàng nghìn dặm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3051] [手套] (shǒutào) - găng tay, bao tay [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '手套' AND pinyin = 'shǒutào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手套' AND pinyin = 'shǒutào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '手套'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手套'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shǒutào',
      meaning_vi = 'găng tay, bao tay',
      example_hanzi = '冬天骑自行车外出时，戴上一副厚实温暖的皮手套可以抵御刺骨的寒风。',
      example_pinyin = 'Dōngtiān qí zìxíngchē wàichū shí, dài shàng yí fù hòushi wēnnuǎn de pí shǒutào kěyǐ dǐyù cìgǔ de hánfēng.',
      example_vi = 'Khi đi xe đạp ra ngoài vào mùa đông, đeo một đôi găng tay da dày dặn ấm áp có thể chống chọi được những cơn gió lạnh thấu xương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '手套',
      'shǒutào',
      'găng tay, bao tay',
      'Danh từ',
      'HSK 5',
      '冬天骑自行车外出时，戴上一副厚实温暖的皮手套可以抵御刺骨的寒风。',
      'Dōngtiān qí zìxíngchē wàichū shí, dài shàng yí fù hòushi wēnnuǎn de pí shǒutào kěyǐ dǐyù cìgǔ de hánfēng.',
      'Khi đi xe đạp ra ngoài vào mùa đông, đeo một đôi găng tay da dày dặn ấm áp có thể chống chọi được những cơn gió lạnh thấu xương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬天骑自行车外出时，戴上一副厚实温暖的皮手套可以抵御刺骨的寒风。', 'Dōngtiān qí zìxíngchē wàichū shí, dài shàng yí fù hòushi wēnnuǎn de pí shǒutào kěyǐ dǐyù cìgǔ de hánfēng.', 'Khi đi xe đạp ra ngoài vào mùa đông, đeo một đôi găng tay da dày dặn ấm áp có thể chống chọi được những cơn gió lạnh thấu xương.', 'basic', 1),
      (v_id, '半导体百级无尘车间作业人员必须严格穿戴防静电防化学渗透的医用丁腈净化手套，杜绝对纳米级晶圆造成任何微尘颗粒污染。', 'Bàndǎotǐ bǎijí wúchén chējiān zuòyè rényuán bìxū yángé chuāndài fáng-jìngdiàn fáng-huàxué shèntòu de yīyòng dīngjīng jìnghuà shǒutào, dùjué duì nàmǐjí jīngyuán zàochéng rènhé wēichén kèlì wūrǎn.', 'Nhân viên thao tác trong phòng sạch cấp 100 của ngành bán dẫn bắt buộc phải đeo găng tay phòng sạch nitrile y tế chống tĩnh điện chống thẩm thấu hóa chất một cách nghiêm ngặt, triệt để ngăn chặn gây ra bất kỳ sự nhiễm bẩn hạt bụi vi mô nào đối với phiến bán dẫn cấp nanomet.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3052] [手续] (shǒuxù) - thủ tục, giấy tờ thủ tục hành chính [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '手续' AND pinyin = 'shǒuxù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手续' AND pinyin = 'shǒuxù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '手续'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手续'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shǒuxù',
      meaning_vi = 'thủ tục, giấy tờ thủ tục hành chính',
      example_hanzi = '办理护照和签证手续时，请务必提前准备好身份证与近期照片。',
      example_pinyin = 'Bànlǐ hùzhào hé qiānzhèng shǒuxù shí, qǐng wùbì tíqián zhǔnbèi hǎo shēnfènzhèng yǔ jìnqī zhàopiàn.',
      example_vi = 'Khi làm thủ tục hộ chiếu và thị thực visa, xin nhất thiết phải chuẩn bị sẵn từ trước căn cước công dân và ảnh chụp gần đây.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '手续',
      'shǒuxù',
      'thủ tục, giấy tờ thủ tục hành chính',
      'Danh từ',
      'HSK 5',
      '办理护照和签证手续时，请务必提前准备好身份证与近期照片。',
      'Bànlǐ hùzhào hé qiānzhèng shǒuxù shí, qǐng wùbì tíqián zhǔnbèi hǎo shēnfènzhèng yǔ jìnqī zhàopiàn.',
      'Khi làm thủ tục hộ chiếu và thị thực visa, xin nhất thiết phải chuẩn bị sẵn từ trước căn cước công dân và ảnh chụp gần đây.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '办理护照和签证手续时，请务必提前准备好身份证与近期照片。', 'Bànlǐ hùzhào hé qiānzhèng shǒuxù shí, qǐng wùbì tíqián zhǔnbèi hǎo shēnfènzhèng yǔ jìnqī zhàopiàn.', 'Khi làm thủ tục hộ chiếu và thị thực visa, xin nhất thiết phải chuẩn bị sẵn từ trước căn cước công dân và ảnh chụp gần đây.', 'basic', 1),
      (v_id, '深化“放管服”改革要求大幅精简企业准入审批手续，全面推行跨部门涉企事项集成办理。', 'Shēnhuà “fàng-guǎn-fú” gǎigé yāoqiú dàfú jīngjiǎn qǐyè zhǔnrù shěnpī shǒuxù, quánmiàn tuīxíng kuà-bùmén shèqǐ shìxiàng jíchéng bànlǐ.', 'Đào sâu cải cách tinh giản thủ tục hành chính đòi hỏi phải tinh gọn mạnh mẽ các thủ tục phê duyệt tiếp cận thị trường của doanh nghiệp, thực hiện toàn diện việc giải quyết tích hợp các hạng mục liên quan đến doanh nghiệp liên cơ quan.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3053] [手指] (shǒuzhǐ) - ngón tay [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '手指' AND pinyin = 'shǒuzhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手指' AND pinyin = 'shǒuzhǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '手指'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '手指'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shǒuzhǐ',
      meaning_vi = 'ngón tay',
      example_hanzi = '在寒冷的冬日户外待久了，冻僵的手指连写字都很困难。',
      example_pinyin = 'Zài hánlěng de dōngrì hùwài dāi jiǔ le, dòngjiāng de shǒuzhǐ lián xiězì dōu hěn kùnnan.',
      example_vi = 'Ở ngoài trời mùa đông giá rét lâu, những ngón tay bị cóng đơ đến mức ngay cả việc viết chữ cũng thấy khó khăn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '手指',
      'shǒuzhǐ',
      'ngón tay',
      'Danh từ',
      'HSK 5',
      '在寒冷的冬日户外待久了，冻僵的手指连写字都很困难。',
      'Zài hánlěng de dōngrì hùwài dāi jiǔ le, dòngjiāng de shǒuzhǐ lián xiězì dōu hěn kùnnan.',
      'Ở ngoài trời mùa đông giá rét lâu, những ngón tay bị cóng đơ đến mức ngay cả việc viết chữ cũng thấy khó khăn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在寒冷的冬日户外待久了，冻僵的手指连写字都很困难。', 'Zài hánlěng de dōngrì hùwài dāi jiǔ le, dòngjiāng de shǒuzhǐ lián xiězì dōu hěn kùnnan.', 'Ở ngoài trời mùa đông giá rét lâu, những ngón tay bị cóng đơ đến mức ngay cả việc viết chữ cũng thấy khó khăn.', 'basic', 1),
      (v_id, '微创手外科专家借助超高倍手术显微镜与超精细缝合线，成功为患者完成了离断手指微循环血管再植吻合手术。', 'Wēichuàng shǒuwàikē zhuānjiā jièzhù chāo-gāobèi shǒushù xiǎnwéijìng yǔ chāo-jīngxì fénghéxiàn, chénggōng wèi huànzhě wánchéng le líduàn shǒuzhǐ wēixúnhuán xiěguǎn zàizhí wěnhé shǒushù.', 'Chuyên gia ngoại khoa bàn tay xâm lấn tối thiểu nhờ kính hiển vi phẫu thuật phóng đại siêu cao và chỉ khâu siêu mảnh đã hoàn thành xuất sắc ca phẫu thuật nối ghép tái tưới máu vi tuần hoàn cho các ngón tay bị đứt rời của người bệnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3054] [售价] (shòujià) - giá bán, giá chào bán ra [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '售价' AND pinyin = 'shòujià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '售价' AND pinyin = 'shòujià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '售价'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '售价'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shòujià',
      meaning_vi = 'giá bán, giá chào bán ra',
      example_hanzi = '这款新款节能空调虽然售价略高于普通产品，但因省电深受消费者欢迎。',
      example_pinyin = 'Zhè kuǎn xīnkuǎn jiénéng kōngtiáo suīrán shòujià lüè gāoyú pǔtōng chǎnpǐn, dàn yīn shěngdiàn shēnshòu xiāofèizhě huānyíng.',
      example_vi = 'Chiếc điều hòa tiết kiệm năng lượng mẫu mới này tuy giá bán hơi cao hơn sản phẩm thông thường một chút nhưng nhờ tiết kiệm điện nên rất được người tiêu dùng đón nhận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '售价',
      'shòujià',
      'giá bán, giá chào bán ra',
      'Danh từ',
      'HSK 5',
      '这款新款节能空调虽然售价略高于普通产品，但因省电深受消费者欢迎。',
      'Zhè kuǎn xīnkuǎn jiénéng kōngtiáo suīrán shòujià lüè gāoyú pǔtōng chǎnpǐn, dàn yīn shěngdiàn shēnshòu xiāofèizhě huānyíng.',
      'Chiếc điều hòa tiết kiệm năng lượng mẫu mới này tuy giá bán hơi cao hơn sản phẩm thông thường một chút nhưng nhờ tiết kiệm điện nên rất được người tiêu dùng đón nhận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这款新款节能空调虽然售价略高于普通产品，但因省电深受消费者欢迎。', 'Zhè kuǎn xīnkuǎn jiénéng kōngtiáo suīrán shòujià lüè gāoyú pǔtōng chǎnpǐn, dàn yīn shěngdiàn shēnshòu xiāofèizhě huānyíng.', 'Chiếc điều hòa tiết kiệm năng lượng mẫu mới này tuy giá bán hơi cao hơn sản phẩm thông thường một chút nhưng nhờ tiết kiệm điện nên rất được người tiêu dùng đón nhận.', 'basic', 1),
      (v_id, '随着上游电池原材料供应链产能集中释放与规模效应显现，终端主流新能源车型的平均市场售价呈现理性回落态势。', 'Suízhe shàngyóu diànchí yuáncáiliào gōngyìngliàn chǎnnéng jízhōng shìfàng yǔ guīmó xiàoyì xiǎnxiàn, zhōngduān zhǔliú xīnnéngyuán chēxíng de píngjūn shìchǎng shòujià chéngxiàn lǐxìng huíluò tàishì.', 'Cùng với năng lực sản xuất của chuỗi cung ứng nguyên liệu pin thượng nguồn được giải phóng tập trung và hiệu ứng quy mô bộc lộ, giá bán trung bình trên thị trường của các dòng xe năng lượng mới chủ lưu đầu cuối xuất hiện chiều hướng giảm dần mang tính lý tính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3055] [蔬菜] (shūcài) - rau xanh, rau củ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '蔬菜' AND pinyin = 'shūcài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '蔬菜' AND pinyin = 'shūcài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '蔬菜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '蔬菜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shūcài',
      meaning_vi = 'rau xanh, rau củ',
      example_hanzi = '医生建议多吃富含膳食纤维的新鲜蔬菜，少吃油腻和高盐食品。',
      example_pinyin = 'Yīshēng jiànyì duō chī fùhán shànshí xiānwéi de xīnxiān shūcài, shǎo chī yóunì hé gāoyán shípǐn.',
      example_vi = 'Bác sĩ khuyên nên ăn nhiều rau củ tươi giàu chất xơ, hạn chế đồ ăn dầu mỡ và nhiều muối.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '蔬菜',
      'shūcài',
      'rau xanh, rau củ',
      'Danh từ',
      'HSK 5',
      '医生建议多吃富含膳食纤维的新鲜蔬菜，少吃油腻和高盐食品。',
      'Yīshēng jiànyì duō chī fùhán shànshí xiānwéi de xīnxiān shūcài, shǎo chī yóunì hé gāoyán shípǐn.',
      'Bác sĩ khuyên nên ăn nhiều rau củ tươi giàu chất xơ, hạn chế đồ ăn dầu mỡ và nhiều muối.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医生建议多吃富含膳食纤维的新鲜蔬菜，少吃油腻和高盐食品。', 'Yīshēng jiànyì duō chī fùhán shànshí xiānwéi de xīnxiān shūcài, shǎo chī yóunì hé gāoyán shípǐn.', 'Bác sĩ khuyên nên ăn nhiều rau củ tươi giàu chất xơ, hạn chế đồ ăn dầu mỡ và nhiều muối.', 'basic', 1),
      (v_id, '现代都市农业积极构建“菜篮子”市长负责制考核评价体系，确保重点民生蔬菜供应充足与应急保供韧性。', 'Xiàndài dūshì nóngyè jījí gòujiàn “càilánzi” shìzhǎng fùzézhì kǎohé píngjià tǐxì, quèbǎo zhòngdiǎn mínshēng shūcài gōngyìng chōngzú yǔ yìngjí bǎogōng rènxìng.', 'Nông nghiệp đô thị hiện đại tích cực xây dựng hệ thống khảo hạch đánh giá chế độ thị trưởng chịu trách nhiệm về "giỏ rau xanh", bảo đảm nguồn cung rau củ dân sinh trọng điểm dồi dào và khả năng chống chịu bảo đảm nguồn cung khẩn cấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3056] [书法] (shūfǎ) - thư pháp, nghệ thuật viết chữ đẹp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '书法' AND pinyin = 'shūfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '书法' AND pinyin = 'shūfǎ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '书法'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '书法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shūfǎ',
      meaning_vi = 'thư pháp, nghệ thuật viết chữ đẹp',
      example_hanzi = '爷爷练习毛笔书法几十年，写出来的行书字迹苍劲有力、挥洒自如。',
      example_pinyin = 'Yéye liànxí máobǐ shūfǎ jǐshí nián, xiě chūlái de xíngshū zìjì cāngjìn-yǒulì, huīsǎ-zìrú.',
      example_vi = 'Ông nội tôi luyện thư pháp bút lông mấy chục năm nay, nét chữ hành thư viết ra khoáng đạt mạnh mẽ, phóng bút tự nhiên nhẹ nhàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '书法',
      'shūfǎ',
      'thư pháp, nghệ thuật viết chữ đẹp',
      'Danh từ',
      'HSK 5',
      '爷爷练习毛笔书法几十年，写出来的行书字迹苍劲有力、挥洒自如。',
      'Yéye liànxí máobǐ shūfǎ jǐshí nián, xiě chūlái de xíngshū zìjì cāngjìn-yǒulì, huīsǎ-zìrú.',
      'Ông nội tôi luyện thư pháp bút lông mấy chục năm nay, nét chữ hành thư viết ra khoáng đạt mạnh mẽ, phóng bút tự nhiên nhẹ nhàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '爷爷练习毛笔书法几十年，写出来的行书字迹苍劲有力、挥洒自如。', 'Yéye liànxí máobǐ shūfǎ jǐshí nián, xiě chūlái de xíngshū zìjì cāngjìn-yǒulì, huīsǎ-zìrú.', 'Ông nội tôi luyện thư pháp bút lông mấy chục năm nay, nét chữ hành thư viết ra khoáng đạt mạnh mẽ, phóng bút tự nhiên nhẹ nhàng.', 'basic', 1),
      (v_id, '中国传统书法艺术融汇了汉字字形构造之美、墨色浓淡枯润之韵与文人精神气节，被列为人类非物质文化遗产杰作。', 'Zhōngguó chuántǒng shūfǎ yìshù rónghuì le hànzì zìxíng gòuzào zhī měi, mòsè nóngdàn kūrùn zhī yùn yǔ wénrén jīngshén qìjié, bèi liè wéi rénlèi fēiwùzhì wénhuà yíchǎn jiézuò.', 'Nghệ thuật thư pháp truyền thống Trung Hoa dung hòa vẻ đẹp cấu trúc tự hình chữ Hán, vận vị đậm nhạt khô ướt của sắc mực cùng khí phách tinh thần văn nhân, được liệt vào kiệt tác di sản văn hóa phi vật thể của nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3057] [书房] (shūfáng) - phòng đọc sách, thư phòng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '书房' AND pinyin = 'shūfáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '书房' AND pinyin = 'shūfáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '书房'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '书房'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shūfáng',
      meaning_vi = 'phòng đọc sách, thư phòng',
      example_hanzi = '父亲下班回家后，最喜欢坐在安静的书房里翻阅专业期刊。',
      example_pinyin = 'Fùqīn xiàbān huíjiā hòu, zuì xǐhuan zuò zài ānjìng de shūfáng lǐ fānyuè zhuānyè qīkān.',
      example_vi = 'Cha tôi sau khi tan làm về nhà, thích nhất là ngồi trong thư phòng yên tĩnh lật đọc các tạp chí chuyên ngành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '书房',
      'shūfáng',
      'phòng đọc sách, thư phòng',
      'Danh từ',
      'HSK 5',
      '父亲下班回家后，最喜欢坐在安静的书房里翻阅专业期刊。',
      'Fùqīn xiàbān huíjiā hòu, zuì xǐhuan zuò zài ānjìng de shūfáng lǐ fānyuè zhuānyè qīkān.',
      'Cha tôi sau khi tan làm về nhà, thích nhất là ngồi trong thư phòng yên tĩnh lật đọc các tạp chí chuyên ngành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '父亲下班回家后，最喜欢坐在安静的书房里翻阅专业期刊。', 'Fùqīn xiàbān huíjiā hòu, zuì xǐhuan zuò zài ānjìng de shūfáng lǐ fānyuè zhuānyè qīkān.', 'Cha tôi sau khi tan làm về nhà, thích nhất là ngồi trong thư phòng yên tĩnh lật đọc các tạp chí chuyên ngành.', 'basic', 1),
      (v_id, '中国传统文人书房不仅是阅读著述的清雅空间，更是承载文房四宝、金石拓本与修身悟道的人文精神栖所。', 'Zhōngguó chuántǒng wénrén shūfáng bùjǐn shì yuèdú zhùshù de qīngyǎ kōngjiān, gèng shì chéngzài wénfáng-sìbǎo, jīnshí tàběn yǔ xiūshēn-wùdào de rénwén jīngshén qīsuǒ.', 'Thư phòng văn nhân truyền thống Trung Hoa không chỉ là không gian thanh nhã đọc sách trước tác mà còn là chốn neo đậu tinh thần nhân văn chứa đựng văn phòng tứ bảo, văn bia dập thác bản cùng sự tu dưỡng ngộ đạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3058] [书架] (shūjià) - giá sách, kệ sách [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '书架' AND pinyin = 'shūjià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '书架' AND pinyin = 'shūjià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '书架'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '书架'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shūjià',
      meaning_vi = 'giá sách, kệ sách',
      example_hanzi = '他把新买的专业书籍按照学科分类整整齐齐地码放在书架上。',
      example_pinyin = 'Tā bǎ xīn mǎi de zhuānyè shūjí ànzhào xuékē fēnlèi zhěngzhěng-qíqí de mǎfàng zài shūjià shang.',
      example_vi = 'Anh ấy xếp những cuốn sách chuyên ngành mới mua ngay ngắn gọn gàng lên giá sách theo phân loại môn học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '书架',
      'shūjià',
      'giá sách, kệ sách',
      'Danh từ',
      'HSK 5',
      '他把新买的专业书籍按照学科分类整整齐齐地码放在书架上。',
      'Tā bǎ xīn mǎi de zhuānyè shūjí ànzhào xuékē fēnlèi zhěngzhěng-qíqí de mǎfàng zài shūjià shang.',
      'Anh ấy xếp những cuốn sách chuyên ngành mới mua ngay ngắn gọn gàng lên giá sách theo phân loại môn học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他把新买的专业书籍按照学科分类整整齐齐地码放在书架上。', 'Tā bǎ xīn mǎi de zhuānyè shūjí ànzhào xuékē fēnlèi zhěngzhěng-qíqí de mǎfàng zài shūjià shang.', 'Anh ấy xếp những cuốn sách chuyên ngành mới mua ngay ngắn gọn gàng lên giá sách theo phân loại môn học.', 'basic', 1),
      (v_id, '现代化国家图书馆普遍应用超高频RFID无线射频识别智能书架，实现了数十万册馆藏图书的秒级自动化盘点与精准定位。', 'Xiàndàihuà guójiā túshūguǎn pǔbiàn yìngyòng chāo-gāopín RFID wúxiàn shèpín shíbié zhìnéng shūjià, shíxiàn le shùshí wàn cè guǎncáng túshū de miǎojí zìdònghuà pándiǎn yǔ jīngzhǔn dìngwèi.', 'Các thư viện quốc gia hiện đại hóa nói chung đều ứng dụng giá sách thông minh nhận dạng tần số vô tuyến RFID siêu cao tần, thực hiện kiểm kê tự động hóa tính bằng giây và định vị chuẩn xác cho hàng chục vạn cuốn sách lưu trữ trong kho.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3059] [输入] (shūrù) - nhập vào, đưa vào, input [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '输入' AND pinyin = 'shūrù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '输入' AND pinyin = 'shūrù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '输入'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '输入'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shūrù',
      meaning_vi = 'nhập vào, đưa vào, input',
      example_hanzi = '登录系统账号时，需要先输入正确的用户名和密码。',
      example_pinyin = 'Dēnglù xìtǒng zhànghào shí, xūyào xiān shūrù zhèngquè de yònghùmíng hé mìmǎ.',
      example_vi = 'Khi đăng nhập vào tài khoản hệ thống, cần phải nhập đúng tên người dùng và mật khẩu trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '输入',
      'shūrù',
      'nhập vào, đưa vào, input',
      'Động từ',
      'HSK 5',
      '登录系统账号时，需要先输入正确的用户名和密码。',
      'Dēnglù xìtǒng zhànghào shí, xūyào xiān shūrù zhèngquè de yònghùmíng hé mìmǎ.',
      'Khi đăng nhập vào tài khoản hệ thống, cần phải nhập đúng tên người dùng và mật khẩu trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '登录系统账号时，需要先输入正确的用户名和密码。', 'Dēnglù xìtǒng zhànghào shí, xūyào xiān shūrù zhèngquè de yònghùmíng hé mìmǎ.', 'Khi đăng nhập vào tài khoản hệ thống, cần phải nhập đúng tên người dùng và mật khẩu trước.', 'basic', 1),
      (v_id, '多模态深度学习算法能够将文本、语音和高清图像作为联合多源特征输入，从而实现跨模态语义精准推理与决策。', 'Duō-mótài shēndù xuéxí suànfǎ nénggòu jiāng wénběn, yǔyīn hé gāoqīng túxiàng zuòwéi liánhé duōyuán tèzhēng shūrù, cóng’ér shíxiàn kuà-mótài yǔyì jīngzhǔn tuīlǐ yǔ juécè.', 'Thuật toán học sâu đa phương thức có thể đưa văn bản, giọng nói và hình ảnh độ nét cao vào làm đặc trưng đa nguồn liên kết, từ đó thực hiện việc suy luận ngữ nghĩa chuẩn xác và ra quyết định xuyên phương thức.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3060] [舒适] (shūshì) - thoải mái, dễ chịu, tiện nghi [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '舒适' AND pinyin = 'shūshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舒适' AND pinyin = 'shūshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '舒适'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舒适'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shūshì',
      meaning_vi = 'thoải mái, dễ chịu, tiện nghi',
      example_hanzi = '客房里的床铺松软干净，让人一躺下去就感到格外舒适。',
      example_pinyin = 'Kèfáng lǐ de chuángpù sōngruǎn gānjìng, ràng rén yì tǎng xiàqù jiù gǎndào géwài shūshì.',
      example_vi = 'Chiếc giường trong phòng ngủ êm ái sạch sẽ, khiến người ta hễ nằm xuống là cảm thấy vô cùng thoải mái dễ chịu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '舒适',
      'shūshì',
      'thoải mái, dễ chịu, tiện nghi',
      'Tính từ',
      'HSK 5',
      '客房里的床铺松软干净，让人一躺下去就感到格外舒适。',
      'Kèfáng lǐ de chuángpù sōngruǎn gānjìng, ràng rén yì tǎng xiàqù jiù gǎndào géwài shūshì.',
      'Chiếc giường trong phòng ngủ êm ái sạch sẽ, khiến người ta hễ nằm xuống là cảm thấy vô cùng thoải mái dễ chịu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '客房里的床铺松软干净，让人一躺下去就感到格外舒适。', 'Kèfáng lǐ de chuángpù sōngruǎn gānjìng, ràng rén yì tǎng xiàqù jiù gǎndào géwài shūshì.', 'Chiếc giường trong phòng ngủ êm ái sạch sẽ, khiến người ta hễ nằm xuống là cảm thấy vô cùng thoải mái dễ chịu.', 'basic', 1),
      (v_id, '高品质超低能耗建筑通过高性能外保温系统与全热交换新风机组，实现了四季恒温恒湿恒氧的极致舒适室内微环境。', 'Gāo-pǐnzhì chāo-dī nénghào jiànzhù tōngguò gāo-xìngnéng wàibǎowēn xìtǒng yǔ quán-rè jiāohuàn xīnfēng jīzǔ, shíxiàn le sìjì héngwēn héngshī héngyǎng de jízhì shūshì shìnèi wēihuánjìng.', 'Công trình kiến trúc tiêu hao năng lượng siêu thấp chất lượng cao nhờ hệ thống cách nhiệt bên ngoài hiệu suất cao và tổ máy thông gió tươi trao đổi nhiệt toàn phần đã đạt được tiểu khí hậu trong nhà cực kỳ tiện nghi bốn mùa nhiệt độ, độ ẩm và oxy luôn giữ mức ổn định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3061] [熟练] (shúliàn) - thành thạo, thuần thục, điêu luyện [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '熟练' AND pinyin = 'shúliàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '熟练' AND pinyin = 'shúliàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '熟练'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '熟练'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shúliàn',
      meaning_vi = 'thành thạo, thuần thục, điêu luyện',
      example_hanzi = '经过长达几个月的刻苦练习，他已经能非常熟练地盲打电脑键盘了。',
      example_pinyin = 'Jīngguò cháng dá jǐ ge yuè de kèkǔ liànxí, tā yǐjīng néng fēicháng shúliàn de mángdǎ diànnǎo jiànpán le.',
      example_vi = 'Sau mấy tháng khổ luyện kiên trì, anh ấy đã có thể gõ phím máy tính mười ngón vô cùng thành thạo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '熟练',
      'shúliàn',
      'thành thạo, thuần thục, điêu luyện',
      'Tính từ',
      'HSK 5',
      '经过长达几个月的刻苦练习，他已经能非常熟练地盲打电脑键盘了。',
      'Jīngguò cháng dá jǐ ge yuè de kèkǔ liànxí, tā yǐjīng néng fēicháng shúliàn de mángdǎ diànnǎo jiànpán le.',
      'Sau mấy tháng khổ luyện kiên trì, anh ấy đã có thể gõ phím máy tính mười ngón vô cùng thành thạo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过长达几个月的刻苦练习，他已经能非常熟练地盲打电脑键盘了。', 'Jīngguò cháng dá jǐ ge yuè de kèkǔ liànxí, tā yǐjīng néng fēicháng shúliàn de mángdǎ diànnǎo jiànpán le.', 'Sau mấy tháng khổ luyện kiên trì, anh ấy đã có thể gõ phím máy tính mười ngón vô cùng thành thạo.', 'basic', 1),
      (v_id, '高级数控机床技师凭借多年积累的精湛技艺，能够极其熟练地手工铲刮出精度达微米级的精密导轨结合面。', 'Gāojí shùkòng jīchuáng jìshī píngjiè duō nián jīlěi de jīngzhàn jìyì, nénggòu jíqí shúliàn de shǒugōng chǎnguā chū jīngdù dá wēimǐjí de jīngmì dǎoguǐ jiéhémiàn.', 'Kỹ thuật viên máy công cụ điều khiển số cao cấp dựa vào tay nghề điêu luyện tích lũy nhiều năm có thể cạo gọt thủ công bề mặt tiếp xúc đường ray dẫn hướng chính xác với độ chuẩn đạt cấp micromet một cách cực kỳ thuần thục.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3062] [熟人] (shúrén) - người quen, người quen biết [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '熟人' AND pinyin = 'shúrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '熟人' AND pinyin = 'shúrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '熟人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '熟人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shúrén',
      meaning_vi = 'người quen, người quen biết',
      example_hanzi = '在异国他乡的街头偶然偶遇多年不见的老熟人，他激动得热泪盈眶。',
      example_pinyin = 'Zài yìguó tāxiāng de jiētóu ǒurán ǒuyù duō nián bú jiàn de lǎo shúrén, tā jīdòng de rèlèi yíng kuàng.',
      example_vi = 'Trên đường phố nơi đất khách quê người tình cờ gặp lại người quen cũ nhiều năm không gặp, anh ấy xúc động trào dâng nước mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '熟人',
      'shúrén',
      'người quen, người quen biết',
      'Danh từ',
      'HSK 5',
      '在异国他乡的街头偶然偶遇多年不见的老熟人，他激动得热泪盈眶。',
      'Zài yìguó tāxiāng de jiētóu ǒurán ǒuyù duō nián bú jiàn de lǎo shúrén, tā jīdòng de rèlèi yíng kuàng.',
      'Trên đường phố nơi đất khách quê người tình cờ gặp lại người quen cũ nhiều năm không gặp, anh ấy xúc động trào dâng nước mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在异国他乡的街头偶然偶遇多年不见的老熟人，他激动得热泪盈眶。', 'Zài yìguó tāxiāng de jiētóu ǒurán ǒuyù duō nián bú jiàn de lǎo shúrén, tā jīdòng de rèlèi yíng kuàng.', 'Trên đường phố nơi đất khách quê người tình cờ gặp lại người quen cũ nhiều năm không gặp, anh ấy xúc động trào dâng nước mắt.', 'basic', 1),
      (v_id, '构建规范现代市场经济秩序必须破除传统“熟人社会”的人情关系干扰，坚定奉行契约精神与公正法治规则。', 'Gòujiàn guīfàn xiàndài shìchǎng jīngjì zhìxù bìxū pòchú chuántǒng “shúrén shèhuì” de rénqíng guānxì gānrǎo, jiāndìng fèngxíng qìyuē jīngshén yǔ gōngzhèng fǎzhì guīzé.', 'Xây dựng trật tự kinh tế thị trường hiện đại quy chuẩn bắt buộc phải phá bỏ sự can thiệp của quan hệ tình nghĩa trong "xã hội người quen" truyền thống, kiên định phụng hành tinh thần khế ước và các quy tắc pháp trị công bằng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3063] [数] (shǔ) - đếm, tính [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '数' AND pinyin = 'shǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '数' AND pinyin = 'shǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '数'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '数'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shǔ',
      meaning_vi = 'đếm, tính',
      example_hanzi = '夜幕降临，山顶上的星空格外明亮，弟弟仰着头数着天上的星星。',
      example_pinyin = 'Yèmù jiànglín, shāndǐng shang de xīngkōng géwài míngliàng, dìdi yǎng zhe tóu shǔ zhe tiān shang de xīngxing.',
      example_vi = 'Màn đêm buông xuống, bầu trời đầy sao trên đỉnh núi sáng rực lạ thường, em trai ngửa đầu đếm từng vì sao trên trời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '数',
      'shǔ',
      'đếm, tính',
      'Động từ',
      'HSK 5',
      '夜幕降临，山顶上的星空格外明亮，弟弟仰着头数着天上的星星。',
      'Yèmù jiànglín, shāndǐng shang de xīngkōng géwài míngliàng, dìdi yǎng zhe tóu shǔ zhe tiān shang de xīngxing.',
      'Màn đêm buông xuống, bầu trời đầy sao trên đỉnh núi sáng rực lạ thường, em trai ngửa đầu đếm từng vì sao trên trời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夜幕降临，山顶上的星空格外明亮，弟弟仰着头数着天上的星星。', 'Yèmù jiànglín, shāndǐng shang de xīngkōng géwài míngliàng, dìdi yǎng zhe tóu shǔ zhe tiān shang de xīngxing.', 'Màn đêm buông xuống, bầu trời đầy sao trên đỉnh núi sáng rực lạ thường, em trai ngửa đầu đếm từng vì sao trên trời.', 'basic', 1),
      (v_id, '在评估重大基础设施全生命周期碳资产价值时，必须严格逐项核数各建设运营环节的温室气体实际排放当量。', 'Zài pínggū zhòngdà jīchǔ shèshī quán-shēngmìngzhōuqī tàn-zīchǎn jiàzhí shí, bìxū yángé zhú xiàng héshǔ gè jiànshè yùnyíng huánjié de wēnshì qìtǐ shíjì páifàng dāngliàng.', 'Khi đánh giá giá trị tài sản carbon trong toàn bộ vòng đời của cơ sở hạ tầng trọng điểm, bắt buộc phải kiểm tra đếm tính nghiêm ngặt từng hạng mục lượng phát thải thực tế quy đổi của khí nhà kính ở các khâu xây dựng và vận hành.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3064] [鼠标] (shǔbiāo) - chuột máy tính [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '鼠标' AND pinyin = 'shǔbiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '鼠标' AND pinyin = 'shǔbiāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '鼠标'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '鼠标'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shǔbiāo',
      meaning_vi = 'chuột máy tính',
      example_hanzi = '轻点两下无线鼠标左键，即可快速打开电脑桌面上的目标文档。',
      example_pinyin = 'Qīng diǎn liǎng xià wúxiàn shǔbiāo zuǒjiàn, jíkě kuàisù dǎkāi diànnǎo zhuōmiàn shang de mùbiāo wéndàng.',
      example_vi = 'Nhấp nhẹ hai lần chuột trái của chuột không dây là có thể mở nhanh tập tài liệu mục tiêu trên màn hình máy tính.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '鼠标',
      'shǔbiāo',
      'chuột máy tính',
      'Danh từ',
      'HSK 5',
      '轻点两下无线鼠标左键，即可快速打开电脑桌面上的目标文档。',
      'Qīng diǎn liǎng xià wúxiàn shǔbiāo zuǒjiàn, jíkě kuàisù dǎkāi diànnǎo zhuōmiàn shang de mùbiāo wéndàng.',
      'Nhấp nhẹ hai lần chuột trái của chuột không dây là có thể mở nhanh tập tài liệu mục tiêu trên màn hình máy tính.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '轻点两下无线鼠标左键，即可快速打开电脑桌面上的目标文档。', 'Qīng diǎn liǎng xià wúxiàn shǔbiāo zuǒjiàn, jíkě kuàisù dǎkāi diànnǎo zhuōmiàn shang de mùbiāo wéndàng.', 'Nhấp nhẹ hai lần chuột trái của chuột không dây là có thể mở nhanh tập tài liệu mục tiêu trên màn hình máy tính.', 'basic', 1),
      (v_id, '新一代人体工学垂直光学鼠标深度优化了手腕握持姿态曲线，能有效预防长期使用电脑导致的腕管综合征。', 'Xīn yí dài réntǐ gōngxué chuízhí guāngxué shǔbiāo shēndù yōuhuà le shǒuwàn wòchí zītài qūxiàn, néng yǒuxiào yùfáng chángqī shǐyòng diànnǎo dǎozhì de wànguǎn zōnghézhēng.', 'Chuột quang dạng đứng công thái học thế hệ mới đã tối ưu hóa sâu sắc đường cong tư thế cầm nắm cổ tay, có thể phòng ngừa hiệu quả hội chứng ống cổ tay do dùng máy tính lâu dài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3065] [属于] (shǔyú) - thuộc về, thuộc quyền, là của [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '属于' AND pinyin = 'shǔyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '属于' AND pinyin = 'shǔyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '属于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '属于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shǔyú',
      meaning_vi = 'thuộc về, thuộc quyền, là của',
      example_hanzi = '未来的世界属于充满朝气、勇于探索未知奥秘的年轻一代。',
      example_pinyin = 'Wèilái de shìjiè shǔyú chōngmǎn zhāoqì, yǒngyú tànsuǒ wèizhī àomì de niánqīng yídài.',
      example_vi = 'Thế giới tương lai thuộc về thế hệ trẻ tràn đầy khí thế thanh xuân và dũng cảm khám phá những bí ẩn chưa biết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '属于',
      'shǔyú',
      'thuộc về, thuộc quyền, là của',
      'Động từ',
      'HSK 5',
      '未来的世界属于充满朝气、勇于探索未知奥秘的年轻一代。',
      'Wèilái de shìjiè shǔyú chōngmǎn zhāoqì, yǒngyú tànsuǒ wèizhī àomì de niánqīng yídài.',
      'Thế giới tương lai thuộc về thế hệ trẻ tràn đầy khí thế thanh xuân và dũng cảm khám phá những bí ẩn chưa biết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '未来的世界属于充满朝气、勇于探索未知奥秘的年轻一代。', 'Wèilái de shìjiè shǔyú chōngmǎn zhāoqì, yǒngyú tànsuǒ wèizhī àomì de niánqīng yídài.', 'Thế giới tương lai thuộc về thế hệ trẻ tràn đầy khí thế thanh xuân và dũng cảm khám phá những bí ẩn chưa biết.', 'basic', 1),
      (v_id, '无论外部国际风云如何变幻，国家对包括南海诸岛在内的全部固有领土主权始终无可辩驳地属于中国人民。', 'Wúlùn wàibù guójì fēngyún rúhé biànhuàn, guójiā duì bāokuò Nánhǎi zhūdǎo zài nèi de quánbù gùyǒu lǐngtǔ zhǔquán shǐzhōng wúkě-biànbó de shǔyú Zhōngguó rénmín.', 'Bất luận phong vân quốc tế bên ngoài có biến đổi ra sao, chủ quyền lãnh thổ cố hữu toàn vẹn của quốc gia bao gồm quần đảo Nam Hải từ trước đến nay không thể tranh cãi luôn thuộc về nhân dân Trung Quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3066] [束] (shù) - bó, chùm, tia, nén [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '束' AND pinyin = 'shù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '束' AND pinyin = 'shù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '束'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '束'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ',
      pinyin = 'shù',
      meaning_vi = 'bó, chùm, tia, nén',
      example_hanzi = '母亲节清晨，女儿给妈妈送上了一束芬芳四溢的康乃馨鲜花。',
      example_pinyin = 'Mǔqīnjié qīngchén, nǚ’ér gěi māma sòng shàng le yí shù fēnfāng-sìyì de kāngnǎixīn xiānhuā.',
      example_vi = 'Sáng sớm Ngày của Mẹ, con gái đã gửi tặng mẹ một bó hoa cẩm chướng tươi thắm ngát hương thơm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '束',
      'shù',
      'bó, chùm, tia, nén',
      'Lượng từ',
      'HSK 5',
      '母亲节清晨，女儿给妈妈送上了一束芬芳四溢的康乃馨鲜花。',
      'Mǔqīnjié qīngchén, nǚ’ér gěi māma sòng shàng le yí shù fēnfāng-sìyì de kāngnǎixīn xiānhuā.',
      'Sáng sớm Ngày của Mẹ, con gái đã gửi tặng mẹ một bó hoa cẩm chướng tươi thắm ngát hương thơm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '母亲节清晨，女儿给妈妈送上了一束芬芳四溢的康乃馨鲜花。', 'Mǔqīnjié qīngchén, nǚ’ér gěi māma sòng shàng le yí shù fēnfāng-sìyì de kāngnǎixīn xiānhuā.', 'Sáng sớm Ngày của Mẹ, con gái đã gửi tặng mẹ một bó hoa cẩm chướng tươi thắm ngát hương thơm.', 'basic', 1),
      (v_id, '同步辐射光源能够产生能量极高、准直度极佳的超强高亮度X射线束，为解析微观复杂蛋白质晶体空间构型提供了微观利器。', 'Tóngbù fúshè guāngyuán nénggòu chǎnshēng néngliàng jí gāo, zhǔnzhídù jí jiā de chāo-qiáng gāo-liàngdù X shèxiàn shù, wèi jiěxī wēiguān fùzá dànbáizhǐ jīngtǐ kōngjiān gòuxíng tígōng le wēiguān lìqì.', 'Nguồn sáng bức xạ đồng bộ có thể tạo ra chùm tia X siêu mạnh độ sáng cao có mức năng lượng cực lớn và độ chuẩn trực hoàn hảo, cung cấp công cụ vi mô đắc lực để giải mã cấu hình không gian tinh thể protein phức tạp ở cấp độ vi mô.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3067] [数据] (shùjù) - dữ liệu, số liệu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '数据' AND pinyin = 'shùjù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '数据' AND pinyin = 'shùjù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '数据'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '数据'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shùjù',
      meaning_vi = 'dữ liệu, số liệu',
      example_hanzi = '在撰写市场调研报告时，必须列出可靠详实的数据作为佐证。',
      example_pinyin = 'Zài zhuànxiě shìchǎng diàoyán bàogào shí, bìxū liè chū kěkào xiángshí de shùjù zuòwéi zuǒzhèng.',
      example_vi = 'Khi soạn thảo báo cáo khảo sát thị trường, bắt buộc phải liệt kê các số liệu chi tiết đáng tin cậy để làm bằng chứng chứng minh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '数据',
      'shùjù',
      'dữ liệu, số liệu',
      'Danh từ',
      'HSK 5',
      '在撰写市场调研报告时，必须列出可靠详实的数据作为佐证。',
      'Zài zhuànxiě shìchǎng diàoyán bàogào shí, bìxū liè chū kěkào xiángshí de shùjù zuòwéi zuǒzhèng.',
      'Khi soạn thảo báo cáo khảo sát thị trường, bắt buộc phải liệt kê các số liệu chi tiết đáng tin cậy để làm bằng chứng chứng minh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在撰写市场调研报告时，必须列出可靠详实的数据作为佐证。', 'Zài zhuànxiě shìchǎng diàoyán bàogào shí, bìxū liè chū kěkào xiángshí de shùjù zuòwéi zuǒzhèng.', 'Khi soạn thảo báo cáo khảo sát thị trường, bắt buộc phải liệt kê các số liệu chi tiết đáng tin cậy để làm bằng chứng chứng minh.', 'basic', 1),
      (v_id, '将数据要素确立为关键生产要素并依法保障其产权流通交易，是驱动我国数字经济高质量跨越式发展的战略支点。', 'Jiāng shùjù yàosù quèlì wèi guānjiàn shēngchǎn yàosù bìng yīfǎ bǎozhàng qí chǎnquán liútōng jiāoyì, shì qūdòng wǒguó shùzì jīngjì gāo-zhìliàng kuàyuèshì fāzhǎn de zhànlüè zhīdiǎn.', 'Việc xác lập yếu tố dữ liệu trở thành yếu tố sản xuất then chốt và bảo đảm lưu thông giao dịch quyền tài sản theo luật định là điểm tựa chiến lược thúc đẩy kinh tế số nước ta phát triển nhảy vọt chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3068] [树木] (shùmù) - cây cối, cây cối xanh tươi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '树木' AND pinyin = 'shùmù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '树木' AND pinyin = 'shùmù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '树木'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '树木'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shùmù',
      meaning_vi = 'cây cối, cây cối xanh tươi',
      example_hanzi = '植树节那天，全校师生在荒坡上种下了数百棵郁郁葱葱的树木。',
      example_pinyin = 'Zhíshùjié nà tiān, quán xiào shīshēng zài huāngpō shang zhòng xià le shùbǎi kē yùyù-cōngcōng de shùmù.',
      example_vi = 'Vào ngày Tết trồng cây hôm đó, toàn thể thầy trò nhà trường đã trồng hàng trăm cây xanh tươi tốt trên sườn đồi hoang vu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '树木',
      'shùmù',
      'cây cối, cây cối xanh tươi',
      'Danh từ',
      'HSK 5',
      '植树节那天，全校师生在荒坡上种下了数百棵郁郁葱葱的树木。',
      'Zhíshùjié nà tiān, quán xiào shīshēng zài huāngpō shang zhòng xià le shùbǎi kē yùyù-cōngcōng de shùmù.',
      'Vào ngày Tết trồng cây hôm đó, toàn thể thầy trò nhà trường đã trồng hàng trăm cây xanh tươi tốt trên sườn đồi hoang vu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '植树节那天，全校师生在荒坡上种下了数百棵郁郁葱葱的树木。', 'Zhíshùjié nà tiān, quán xiào shīshēng zài huāngpō shang zhòng xià le shùbǎi kē yùyù-cōngcōng de shùmù.', 'Vào ngày Tết trồng cây hôm đó, toàn thể thầy trò nhà trường đã trồng hàng trăm cây xanh tươi tốt trên sườn đồi hoang vu.', 'basic', 1),
      (v_id, '科学构建混交林群落并加强珍稀濒危野生树木就地保护，是维护陆地森林生态系统碳汇能力与生物多样性的关键举措。', 'Kēxué gòujiàn hùnjiāolín qúnluò bìng jiāqiáng zhēnxī bīnwēi yěshēng shùmù jiùdì bǎohù, shì wéihù lùdì sēnlín shēngtài xìtǒng tànhuì nénglì yǔ shēngwù duōyàngxìng de guānjiàn jǔcuò.', 'Xây dựng khoa học các quần xã rừng hỗn giao và tăng cường bảo tồn tại chỗ các loại cây rừng hoang dã quý hiếm có nguy cơ tuyệt chủng là giải pháp then chốt duy trì năng lực hấp thụ carbon và tính đa dạng sinh học của hệ sinh thái rừng trên cạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3069] [摔] (shuāi) - ngã, té, ném rơi, vỡ rơi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '摔' AND pinyin = 'shuāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摔' AND pinyin = 'shuāi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '摔'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摔'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shuāi',
      meaning_vi = 'ngã, té, ném rơi, vỡ rơi',
      example_hanzi = '小弟弟学骑自行车时不小心摔倒在地上，但在妈妈的鼓励下坚强地爬了起来。',
      example_pinyin = 'Xiǎo dìdi xué qí zìxíngchē shí bù xiǎoxīn shuāidǎo zài dì shang, dàn zài māma de gǔlì xià jiānqiáng de pá le qǐlai.',
      example_vi = 'Em trai nhỏ khi tập đi xe đạp sơ ý bị té ngã xuống đất, nhưng dưới sự khích lệ của mẹ đã kiên cường tự đứng dậy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '摔',
      'shuāi',
      'ngã, té, ném rơi, vỡ rơi',
      'Động từ',
      'HSK 5',
      '小弟弟学骑自行车时不小心摔倒在地上，但在妈妈的鼓励下坚强地爬了起来。',
      'Xiǎo dìdi xué qí zìxíngchē shí bù xiǎoxīn shuāidǎo zài dì shang, dàn zài māma de gǔlì xià jiānqiáng de pá le qǐlai.',
      'Em trai nhỏ khi tập đi xe đạp sơ ý bị té ngã xuống đất, nhưng dưới sự khích lệ của mẹ đã kiên cường tự đứng dậy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小弟弟学骑自行车时不小心摔倒在地上，但在妈妈的鼓励下坚强地爬了起来。', 'Xiǎo dìdi xué qí zìxíngchē shí bù xiǎoxīn shuāidǎo zài dì shang, dàn zài māma de gǔlì xià jiānqiáng de pá le qǐlai.', 'Em trai nhỏ khi tập đi xe đạp sơ ý bị té ngã xuống đất, nhưng dưới sự khích lệ của mẹ đã kiên cường tự đứng dậy.', 'basic', 1),
      (v_id, '新型抗冲击手机陶瓷盖板经过上千次不同高度与极端角度的跌落抗摔破坏性试验，显著提高了耐撞击韧性。', 'Xīnxíng kàng-chōngjī shǒujī táocí gàibǎn jīngguò shàng qiān cì bùtóng gāodù yǔ jíduān jiǎodù de diēluò kàngshuāi pòhuàixìng shìyàn, xiǎnzhù tígāo le nài-zhuàngjī rènxìng.', 'Tấm ốp gốm sứ điện thoại chống va đập kiểu mới sau hàng nghìn lần thử nghiệm phá hủy chống rơi ở các độ cao và góc độ rơi cực đoan khác nhau, đã nâng cao rõ rệt độ dẻo dai chống va đập.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3070] [双方] (shuāngfāng) - hai bên, đôi bên, song phương [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '双方' AND pinyin = 'shuāngfāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '双方' AND pinyin = 'shuāngfāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '双方'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '双方'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shuāngfāng',
      meaning_vi = 'hai bên, đôi bên, song phương',
      example_hanzi = '经过友好协商，谈判双方终于就劳动合同的核心条款达成了一致意见。',
      example_pinyin = 'Jīngguò yǒuhǎo xiéshāng, tánpàn shuāngfāng zhōngyú jiù láodòng hétong de héxīn tiáokuǎn dáchéng le yízhì yìjiàn.',
      example_vi = 'Qua thương lượng hữu hảo, đôi bên đàm phán cuối cùng đã đạt được ý kiến thống nhất về các điều khoản cốt lõi của hợp đồng lao động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '双方',
      'shuāngfāng',
      'hai bên, đôi bên, song phương',
      'Danh từ',
      'HSK 5',
      '经过友好协商，谈判双方终于就劳动合同的核心条款达成了一致意见。',
      'Jīngguò yǒuhǎo xiéshāng, tánpàn shuāngfāng zhōngyú jiù láodòng hétong de héxīn tiáokuǎn dáchéng le yízhì yìjiàn.',
      'Qua thương lượng hữu hảo, đôi bên đàm phán cuối cùng đã đạt được ý kiến thống nhất về các điều khoản cốt lõi của hợp đồng lao động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过友好协商，谈判双方终于就劳动合同的核心条款达成了一致意见。', 'Jīngguò yǒuhǎo xiéshāng, tánpàn shuāngfāng zhōngyú jiù láodòng hétong de héxīn tiáokuǎn dáchéng le yízhì yìjiàn.', 'Qua thương lượng hữu hảo, đôi bên đàm phán cuối cùng đã đạt được ý kiến thống nhất về các điều khoản cốt lõi của hợp đồng lao động.', 'basic', 1),
      (v_id, '中外双方秉持求同存异、合作共赢理念，在联合国气候治理框架下正式签署了双边绿色低碳转型的联合公报。', 'Zhōng-wài shuāngfāng bǐngchí qiútóng-cúnyì, hézuò-gòngyíng lǐniàn, zài Liánhéguó qìhòu zhìlǐ kuàngjià xià zhèngshì qiānshǔ le shuāngbiān lǜsè dītàn zhuǎnxíng de liánhé gōngbào.', 'Hai bên Trung Quốc và nước ngoài giữ vững quan niệm cầu đồng tồn dị và hợp tác cùng thắng, đã chính thức ký kết thông cáo chung về chuyển đổi xanh ít carbon song phương dưới khuôn khổ quản trị khí hậu Liên Hợp Quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3071] [水分] (shuǐfèn) - lượng nước, độ ẩm, thành phần nước [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '水分' AND pinyin = 'shuǐfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '水分' AND pinyin = 'shuǐfèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '水分'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '水分'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shuǐfèn',
      meaning_vi = 'lượng nước, độ ẩm, thành phần nước',
      example_hanzi = '新鲜的西瓜甘甜多汁，水分含量高达百分之九十以上。',
      example_pinyin = 'Xīnxiān de xīguā gāntián duō zhī, shuǐfèn hánliàng gāo dá bǎifēnzhī jiǔshí yǐshàng.',
      example_vi = 'Quả dưa hấu tươi ngọt mát mọng nước, hàm lượng nước lên tới trên 90%.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '水分',
      'shuǐfèn',
      'lượng nước, độ ẩm, thành phần nước',
      'Danh từ',
      'HSK 5',
      '新鲜的西瓜甘甜多汁，水分含量高达百分之九十以上。',
      'Xīnxiān de xīguā gāntián duō zhī, shuǐfèn hánliàng gāo dá bǎifēnzhī jiǔshí yǐshàng.',
      'Quả dưa hấu tươi ngọt mát mọng nước, hàm lượng nước lên tới trên 90%.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新鲜的西瓜甘甜多汁，水分含量高达百分之九十以上。', 'Xīnxiān de xīguā gāntián duō zhī, shuǐfèn hánliàng gāo dá bǎifēnzhī jiǔshí yǐshàng.', 'Quả dưa hấu tươi ngọt mát mọng nước, hàm lượng nước lên tới trên 90%.', 'basic', 1),
      (v_id, '针对部分统计申报中存在的弄虚作假现象，督察组严肃核查并坚决挤干数据水分，确保经济运行指标真实可信。', 'Zhēnduì bùfen tǒngjì shēnbào zhōng cúnzài de nòngxū-zuòjiǎ xiànxiàng, dūcházǔ yánsù héchá bìng jiānjué jǐ gān shùjù shuǐfèn, quèbǎo jīngjì yùnxíng zhǐbiāo zhēnshí kěxìn.', 'Nhắm vào hiện tượng làm giả gian lận tồn tại ở một số báo cáo thống kê, tổ thanh tra đã kiểm tra nghiêm túc và kiên quyết vắt kiệt lượng nước ảo trong số liệu, bảo đảm các chỉ số vận hành kinh tế trung thực và đáng tin cậy.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3072] [税] (shuì) - thuế, tiền thuế [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '税' AND pinyin = 'shuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '税' AND pinyin = 'shuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '税'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '税'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shuì',
      meaning_vi = 'thuế, tiền thuế',
      example_hanzi = '依法诚信纳税是每一个公民和企业应尽的光荣法定义务。',
      example_pinyin = 'Yīfǎ chéngxìn nàshuì shì měi yí ge gōngmín hé qǐyè yīng jìn de guāngróng fǎdìng yìwù.',
      example_vi = 'Nộp thuế trung thực theo luật định là nghĩa vụ pháp lý vẻ vang mà mỗi một công dân và doanh nghiệp phải làm tròn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '税',
      'shuì',
      'thuế, tiền thuế',
      'Danh từ',
      'HSK 5',
      '依法诚信纳税是每一个公民和企业应尽的光荣法定义务。',
      'Yīfǎ chéngxìn nàshuì shì měi yí ge gōngmín hé qǐyè yīng jìn de guāngróng fǎdìng yìwù.',
      'Nộp thuế trung thực theo luật định là nghĩa vụ pháp lý vẻ vang mà mỗi một công dân và doanh nghiệp phải làm tròn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '依法诚信纳税是每一个公民和企业应尽的光荣法定义务。', 'Yīfǎ chéngxìn nàshuì shì měi yí ge gōngmín hé qǐyè yīng jìn de guāngróng fǎdìng yìwù.', 'Nộp thuế trung thực theo luật định là nghĩa vụ pháp lý vẻ vang mà mỗi một công dân và doanh nghiệp phải làm tròn.', 'basic', 1),
      (v_id, '深化现代税收制度改革必须健全直接税体系，合理调节过高收入，充分发挥税收在促进社会公平分配中的调节功能。', 'Shēnhuà xiàndài shuìshōu zhìdù gǎigé bìxū jiànquán zhíjiēshuì tǐxì, hélǐ tiáojié guò gāo shōurù, chōngfèn fāhuī shuìshōu zài cùjìn shèhuì gōngpíng fēnpèi zhōng de tiáojié gōngnéng.', 'Đào sâu cải cách chế độ thuế khóa hiện đại bắt buộc phải hoàn thiện hệ thống thuế trực thu, điều tiết hợp lý các khoản thu nhập quá cao, phát huy triệt để công năng điều tiết của thuế trong thúc đẩy phân phối công bằng xã hội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3073] [睡眠] (shuìmián) - giấc ngủ, giấc ngủ say [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '睡眠' AND pinyin = 'shuìmián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '睡眠' AND pinyin = 'shuìmián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '睡眠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '睡眠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shuìmián',
      meaning_vi = 'giấc ngủ, giấc ngủ say',
      example_hanzi = '保持充足规律的优质睡眠是恢复体力和维持大脑高效运转的前提。',
      example_pinyin = 'Bǎochí chōngzú guīlǜ de yōuzhì shuìmián shì huīfù tǐlì hé wéichí dànǎo gāoxiào yùnzhuǎn de qiántí.',
      example_vi = 'Duy trì giấc ngủ chất lượng cao đều đặn đầy đủ là tiền đề để phục hồi thể lực và duy trì não bộ vận hành hiệu quả cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '睡眠',
      'shuìmián',
      'giấc ngủ, giấc ngủ say',
      'Danh từ',
      'HSK 5',
      '保持充足规律的优质睡眠是恢复体力和维持大脑高效运转的前提。',
      'Bǎochí chōngzú guīlǜ de yōuzhì shuìmián shì huīfù tǐlì hé wéichí dànǎo gāoxiào yùnzhuǎn de qiántí.',
      'Duy trì giấc ngủ chất lượng cao đều đặn đầy đủ là tiền đề để phục hồi thể lực và duy trì não bộ vận hành hiệu quả cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '保持充足规律的优质睡眠是恢复体力和维持大脑高效运转的前提。', 'Bǎochí chōngzú guīlǜ de yōuzhì shuìmián shì huīfù tǐlì hé wéichí dànǎo gāoxiào yùnzhuǎn de qiántí.', 'Duy trì giấc ngủ chất lượng cao đều đặn đầy đủ là tiền đề để phục hồi thể lực và duy trì não bộ vận hành hiệu quả cao.', 'basic', 1),
      (v_id, '临床神经医学研究揭示，长期睡眠剥夺将严重扰乱脑部胶质淋巴系统的代谢废物清除机制，显著诱发神经退行性病变风险。', 'Línchuáng shénjīng yīxué yánjiū jiēshì, chángqī shuìmián bōduó jiāng yánzhòng rǎoluàn nǎobù jiāozhì línbā xìtǒng de dàixiè fèiwù qīngchú jīzhì, xiǎnzhù yòufā shénjīng tuìxíngxìng bìngbiàn fēngxiǎn.', 'Nghiên cứu y học thần kinh lâm sàng chỉ ra rằng, việc bị tước đoạt giấc ngủ kéo dài sẽ làm xáo trộn nghiêm trọng cơ chế dọn dẹp chất thải chuyển hóa của hệ thống glymphatic trong não bộ, gây ra rủi ro mắc bệnh thoái hóa thần kinh rõ rệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3074] [顺] (shùn) - thuận lợi, xuôi chèo mát mái; thuận theo, xuôi theo [Tính từ / Giới từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '顺' AND pinyin = 'shùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '顺' AND pinyin = 'shùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '顺'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '顺'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Giới từ / Động từ',
      pinyin = 'shùn',
      meaning_vi = 'thuận lợi, xuôi chèo mát mái; thuận theo, xuôi theo',
      example_hanzi = '新学期里，老师祝愿全体同学们学习进步、万事顺心如意。',
      example_pinyin = 'Xīn xuéqī lǐ, lǎoshī zhùyuàn quántǐ tóngxuémen xuéxí jìnbù, wànshì shùnxīn-rúyì.',
      example_vi = 'Trong học kỳ mới, thầy giáo chúc toàn thể các bạn học sinh học tập tiến bộ, vạn sự thuận buồm xuôi gió như ý.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '顺',
      'shùn',
      'thuận lợi, xuôi chèo mát mái; thuận theo, xuôi theo',
      'Tính từ / Giới từ / Động từ',
      'HSK 5',
      '新学期里，老师祝愿全体同学们学习进步、万事顺心如意。',
      'Xīn xuéqī lǐ, lǎoshī zhùyuàn quántǐ tóngxuémen xuéxí jìnbù, wànshì shùnxīn-rúyì.',
      'Trong học kỳ mới, thầy giáo chúc toàn thể các bạn học sinh học tập tiến bộ, vạn sự thuận buồm xuôi gió như ý.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新学期里，老师祝愿全体同学们学习进步、万事顺心如意。', 'Xīn xuéqī lǐ, lǎoshī zhùyuàn quántǐ tóngxuémen xuéxí jìnbù, wànshì shùnxīn-rúyì.', 'Trong học kỳ mới, thầy giáo chúc toàn thể các bạn học sinh học tập tiến bộ, vạn sự thuận buồm xuôi gió như ý.', 'basic', 1),
      (v_id, '制定区域产业规划必须顺应全球产业梯度转移与科技革命的大趋势，避免因逆向盲目决策造成重大资源闲置浪费。', 'Zhìdìng qūyù chǎnyè guīhuà bìxū shùnyìng quánqiú chǎnyè tīdù zhuǎnyí yǔ kējì gémìng de dà qūshì, bìmiǎn yīn nìxiàng mángmù juécè zàochéng zhòngdà zīyuán xiánzhì làngfèi.', 'Xây dựng quy hoạch công nghiệp vùng bắt buộc phải thuận theo đại xu thế chuyển dịch thứ bậc sản xuất toàn cầu và cách mạng khoa học công nghệ, tránh việc ra quyết sách mù quáng đi ngược xu thế gây ra lãng phí nhàn rỗi tài nguyên trọng đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3075] [说不定] (shuōbudìng) - nói không chừng, khéo lại, có thể, có lẽ [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '说不定' AND pinyin = 'shuōbudìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '说不定' AND pinyin = 'shuōbudìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '说不定'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '说不定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'shuōbudìng',
      meaning_vi = 'nói không chừng, khéo lại, có thể, có lẽ',
      example_hanzi = '天空中乌云密布，赶紧带上雨伞出门，说不定待会儿就会下起大雨。',
      example_pinyin = 'Tiānkōng zhōng wūyún mìbù, gǎnjǐn dài shàng yǔsǎn chūmén, shuōbudìng dāihuìr jiù huì xià qǐ dàyǔ.',
      example_vi = 'Trên bầu trời mây đen vần vũ, hãy mau mang theo ô rồi hãy ra ngoài, nói không chừng lát nữa sẽ đổ mưa to.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '说不定',
      'shuōbudìng',
      'nói không chừng, khéo lại, có thể, có lẽ',
      'Phó từ',
      'HSK 5',
      '天空中乌云密布，赶紧带上雨伞出门，说不定待会儿就会下起大雨。',
      'Tiānkōng zhōng wūyún mìbù, gǎnjǐn dài shàng yǔsǎn chūmén, shuōbudìng dāihuìr jiù huì xià qǐ dàyǔ.',
      'Trên bầu trời mây đen vần vũ, hãy mau mang theo ô rồi hãy ra ngoài, nói không chừng lát nữa sẽ đổ mưa to.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天空中乌云密布，赶紧带上雨伞出门，说不定待会儿就会下起大雨。', 'Tiānkōng zhōng wūyún mìbù, gǎnjǐn dài shàng yǔsǎn chūmén, shuōbudìng dāihuìr jiù huì xià qǐ dàyǔ.', 'Trên bầu trời mây đen vần vũ, hãy mau mang theo ô rồi hãy ra ngoài, nói không chừng lát nữa sẽ đổ mưa to.', 'basic', 1),
      (v_id, '在看似不起眼的基础科学实验偶然反常现象深处，说不定就潜藏着颠覆现有经典物理认知体系的重磅科学突破。', 'Zài kànsì bù qǐyǎn de jīchǔ kēxué shíyàn ǒurán fǎncháng xiànxiàng shēnchù, shuōbudìng jiù qiáncáng zhe diānfù xiànyǒu jīngdiǎn wùlǐ rènzhī tǐxì de zhòngbàng kēxué tūpò.', 'Ẩn sâu bên trong các hiện tượng dị thường ngẫu nhiên tưởng chừng không mấy nổi bật của thí nghiệm khoa học cơ bản, nói không chừng lại đang tiềm ẩn những đột phá khoa học chấn động lật đổ cả hệ thống nhận thức vật lý kinh điển hiện có.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3076] [说服] (shuōfú) - thuyết phục [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '说服' AND pinyin = 'shuōfú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '说服' AND pinyin = 'shuōfú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '说服'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '说服'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shuōfú',
      meaning_vi = 'thuyết phục',
      example_hanzi = '他用大量真实可靠的调查数据和逻辑清晰的分析，最终成功说服了客户接受新方案。',
      example_pinyin = 'Tā yòng dàliàng zhēnshí kěkào de diàochá shùjù hé luóji qīngxī de fēnxī, zuìzhōng chénggōng shuōfú le kèhù jiēshòu xīn fāng’àn.',
      example_vi = 'Anh ấy dùng lượng lớn số liệu điều tra xác thực đáng tin cậy và phân tích logic sáng rõ, cuối cùng đã thuyết phục thành công khách hàng chấp nhận phương án mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '说服',
      'shuōfú',
      'thuyết phục',
      'Động từ',
      'HSK 5',
      '他用大量真实可靠的调查数据和逻辑清晰的分析，最终成功说服了客户接受新方案。',
      'Tā yòng dàliàng zhēnshí kěkào de diàochá shùjù hé luóji qīngxī de fēnxī, zuìzhōng chénggōng shuōfú le kèhù jiēshòu xīn fāng’àn.',
      'Anh ấy dùng lượng lớn số liệu điều tra xác thực đáng tin cậy và phân tích logic sáng rõ, cuối cùng đã thuyết phục thành công khách hàng chấp nhận phương án mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他用大量真实可靠的调查数据和逻辑清晰的分析，最终成功说服了客户接受新方案。', 'Tā yòng dàliàng zhēnshí kěkào de diàochá shùjù hé luóji qīngxī de fēnxī, zuìzhōng chénggōng shuōfú le kèhù jiēshòu xīn fāng’àn.', 'Anh ấy dùng lượng lớn số liệu điều tra xác thực đáng tin cậy và phân tích logic sáng rõ, cuối cùng đã thuyết phục thành công khách hàng chấp nhận phương án mới.', 'basic', 1),
      (v_id, '在多边外交气候峰会谈判中，首席代表凭借令人信服的法理依据与兼顾各方诉求的包容方案，成功说服了持保留意见的缔约国签署协定。', 'Zài duōbiān wàijiāo qìhòu fēnghuì tánpàn zhōng, shǒuxí dàibiǎo píngjiè lìngrén-xìnfú de fǎlǐ yījù yǔ jiāngù gèfāng sùqiú de bāoróng fāng’àn, chénggōng shuōfú le chí bǎoliú yìjiàn de dìyuēguó qiānshǔ xiédìng.', 'Trong đàm phán hội nghị thượng đỉnh ngoại giao khí hậu đa phương, trưởng đoàn đại biểu nhờ vào căn cứ pháp lý đầy thuyết phục cùng phương án bao trùm dung hòa thỉnh cầu các bên, đã thành công thuyết phục các quốc gia thành viên đang có ý kiến bảo lưu đặt bút ký kết hiệp định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3077] [思考] (sīkǎo) - suy nghĩ, suy ngẫm, tư duy [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '思考' AND pinyin = 'sīkǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '思考' AND pinyin = 'sīkǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '思考'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '思考'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'sīkǎo',
      meaning_vi = 'suy nghĩ, suy ngẫm, tư duy',
      example_hanzi = '遇到复杂难题时，我们要先冷静思考，理清解题思路后再动笔作答。',
      example_pinyin = 'Yùdào fùzá nántí shí, wǒmen yào xiān lěngjìng sīkǎo, lǐqīng jiětí sīlù hòu zài dòngbǐ zuòdá.',
      example_vi = 'Khi gặp phải bài toán phức tạp, chúng ta phải bình tĩnh suy ngẫm trước, làm rõ mạch giải đề rồi hãy đặt bút trả lời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '思考',
      'sīkǎo',
      'suy nghĩ, suy ngẫm, tư duy',
      'Động từ / Danh từ',
      'HSK 5',
      '遇到复杂难题时，我们要先冷静思考，理清解题思路后再动笔作答。',
      'Yùdào fùzá nántí shí, wǒmen yào xiān lěngjìng sīkǎo, lǐqīng jiětí sīlù hòu zài dòngbǐ zuòdá.',
      'Khi gặp phải bài toán phức tạp, chúng ta phải bình tĩnh suy ngẫm trước, làm rõ mạch giải đề rồi hãy đặt bút trả lời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '遇到复杂难题时，我们要先冷静思考，理清解题思路后再动笔作答。', 'Yùdào fùzá nántí shí, wǒmen yào xiān lěngjìng sīkǎo, lǐqīng jiětí sīlù hòu zài dòngbǐ zuòdá.', 'Khi gặp phải bài toán phức tạp, chúng ta phải bình tĩnh suy ngẫm trước, làm rõ mạch giải đề rồi hãy đặt bút trả lời.', 'basic', 1),
      (v_id, '面对新一轮科技革命与产业变革，全社会应当深入思考人工智能如何更好地服务人类文明进步而非造成新的数字鸿沟。', 'Miànduì xīn yì lún kējì gémìng yǔ chǎnyè biàngé, quán shèhuì yīngdāng shēnrù sīkǎo réngōng zhìnéng rúhé gèng hǎo de fúwù rénlèi wénmíng jìnbù ér fēi zàochéng xīn de shùzì hónggōu.', 'Đối mặt với cuộc cách mạng khoa học công nghệ và biến đổi sản xuất vòng mới, toàn xã hội cần suy ngẫm sâu sắc về việc làm thế nào để trí tuệ nhân tạo phục vụ tốt hơn cho sự tiến bộ văn minh của nhân loại thay vì tạo nên hố sâu ngăn cách số mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3078] [私人] (sīrén) - riêng tư, cá nhân, tư nhân [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '私人' AND pinyin = 'sīrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '私人' AND pinyin = 'sīrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '私人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '私人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'sīrén',
      meaning_vi = 'riêng tư, cá nhân, tư nhân',
      example_hanzi = '未经他人明确许可，随意翻看别人的私人信件与日记是不礼貌的行为。',
      example_pinyin = 'Wèijīng tārén míngquè xǔkě, suíyì fānkàn biérén de sīrén xìnjiàn yǔ rìjì shì bù lǐmào de xíngwéi.',
      example_vi = 'Khi chưa có sự đồng ý rõ ràng của người khác, tùy tiện lật xem thư từ và nhật ký riêng tư của người ta là hành vi bất lịch sự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '私人',
      'sīrén',
      'riêng tư, cá nhân, tư nhân',
      'Danh từ / Tính từ',
      'HSK 5',
      '未经他人明确许可，随意翻看别人的私人信件与日记是不礼貌的行为。',
      'Wèijīng tārén míngquè xǔkě, suíyì fānkàn biérén de sīrén xìnjiàn yǔ rìjì shì bù lǐmào de xíngwéi.',
      'Khi chưa có sự đồng ý rõ ràng của người khác, tùy tiện lật xem thư từ và nhật ký riêng tư của người ta là hành vi bất lịch sự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '未经他人明确许可，随意翻看别人的私人信件与日记是不礼貌的行为。', 'Wèijīng tārén míngquè xǔkě, suíyì fānkàn biérén de sīrén xìnjiàn yǔ rìjì shì bù lǐmào de xíngwéi.', 'Khi chưa có sự đồng ý rõ ràng của người khác, tùy tiện lật xem thư từ và nhật ký riêng tư của người ta là hành vi bất lịch sự.', 'basic', 1),
      (v_id, '依据民法典隐私权保护专章规定，任何组织和个人不得非法刺探、侵扰、泄露或公开他人的私人生活安宁与敏感隐私信息。', 'Yījù mǐnfǎdiǎn yǐnsīquán bǎohù zhuānzhāng guīdìng, rènhé zǔzhī hé gèrén bùdé fēifǎ cìtàn, qīnrǎo, xièlòu huò gōngkāi tārén de sīrén shēnghuó ānníng yǔ mǐngǎn yǐnsī xìnxī.', 'Căn cứ vào quy định tại chương bảo vệ quyền riêng tư của Bộ luật Dân sự, bất kỳ tổ chức và cá nhân nào cũng không được do thám, quấy rối, rò rỉ hoặc công khai bất hợp pháp sự yên bình trong đời sống riêng tư và thông tin nhạy cảm của người khác.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3079] [思维] (sīwéi) - tư duy, năng lực tư duy, cách suy nghĩ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '思维' AND pinyin = 'sīwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '思维' AND pinyin = 'sīwéi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '思维'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '思维'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'sīwéi',
      meaning_vi = 'tư duy, năng lực tư duy, cách suy nghĩ',
      example_hanzi = '学习高等数学不仅能掌握计算公式，更能有效锻炼严密的逻辑思维能力。',
      example_pinyin = 'Xuéxí gāoděng shùxué bùjǐn néng zhǎngwò jìsuàn gōngshì, gèng néng yǒuxiào duànliàn yánmì de luóji sīwéi nénglì.',
      example_vi = 'Học toán cao cấp không chỉ giúp nắm vững công thức tính toán mà còn rèn luyện hiệu quả năng lực tư duy logic chặt chẽ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '思维',
      'sīwéi',
      'tư duy, năng lực tư duy, cách suy nghĩ',
      'Danh từ',
      'HSK 5',
      '学习高等数学不仅能掌握计算公式，更能有效锻炼严密的逻辑思维能力。',
      'Xuéxí gāoděng shùxué bùjǐn néng zhǎngwò jìsuàn gōngshì, gèng néng yǒuxiào duànliàn yánmì de luóji sīwéi nénglì.',
      'Học toán cao cấp không chỉ giúp nắm vững công thức tính toán mà còn rèn luyện hiệu quả năng lực tư duy logic chặt chẽ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学习高等数学不仅能掌握计算公式，更能有效锻炼严密的逻辑思维能力。', 'Xuéxí gāoděng shùxué bùjǐn néng zhǎngwò jìsuàn gōngshì, gèng néng yǒuxiào duànliàn yánmì de luóji sīwéi nénglì.', 'Học toán cao cấp không chỉ giúp nắm vững công thức tính toán mà còn rèn luyện hiệu quả năng lực tư duy logic chặt chẽ.', 'basic', 1),
      (v_id, '培养具有全球视野的领军战略科学家，必须破除教条固化的传统认知范式，着力重构开放多元的跨界颠覆性创新思维。', 'Péiyǎng jùyǒu quánqiú shìyě de lǐngjūn zhànlüè kēxuéjiā, bìxū pòchú jiàotiáo gùhuà de chuántǒng rènzhī fànshì, zhuólì chónggòu kāifàng duōyuán de kuàjiè diānfùxìng chuàngxīn sīwéi.', 'Bồi dưỡng các nhà khoa học chiến lược dẫn đầu có tầm nhìn toàn cầu bắt buộc phải phá bỏ chuẩn thức nhận thức truyền thống giáo điều xơ cứng, tập trung tái cấu trúc tư duy đổi mới mang tính đảo lộn liên ngành cởi mở và đa nguyên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3080] [思想] (sīxiǎng) - tư tưởng, ý nghĩ, tư duy triết học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '思想' AND pinyin = 'sīxiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '思想' AND pinyin = 'sīxiǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '思想'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '思想'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'sīxiǎng',
      meaning_vi = 'tư tưởng, ý nghĩ, tư duy triết học',
      example_hanzi = '这篇课文语言虽然通俗易懂，但蕴含着极其丰富深刻的哲理思想。',
      example_pinyin = 'Zhè piān kèwén yǔyán suīrán tōngsú-yìdǒng, dàn yùnhán zhe jíqí fēngfù shēnkè de zhélǐ sīxiǎng.',
      example_vi = 'Bài khóa này ngôn từ tuy giản dị dễ hiểu nhưng lại ẩn chứa tư tưởng triết lý vô cùng phong phú và sâu sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '思想',
      'sīxiǎng',
      'tư tưởng, ý nghĩ, tư duy triết học',
      'Danh từ',
      'HSK 5',
      '这篇课文语言虽然通俗易懂，但蕴含着极其丰富深刻的哲理思想。',
      'Zhè piān kèwén yǔyán suīrán tōngsú-yìdǒng, dàn yùnhán zhe jíqí fēngfù shēnkè de zhélǐ sīxiǎng.',
      'Bài khóa này ngôn từ tuy giản dị dễ hiểu nhưng lại ẩn chứa tư tưởng triết lý vô cùng phong phú và sâu sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这篇课文语言虽然通俗易懂，但蕴含着极其丰富深刻的哲理思想。', 'Zhè piān kèwén yǔyán suīrán tōngsú-yìdǒng, dàn yùnhán zhe jíqí fēngfù shēnkè de zhélǐ sīxiǎng.', 'Bài khóa này ngôn từ tuy giản dị dễ hiểu nhưng lại ẩn chứa tư tưởng triết lý vô cùng phong phú và sâu sắc.', 'basic', 1),
      (v_id, '坚持以科学理论武装头脑，不断从博大精深的中外优秀哲学社会科学思想中汲取治国理政的宏阔智慧。', 'Jiānchí yǐ kēxué lǐlùn wǔzhuāng tóunǎo, búduàn cóng bódà-jīngshēn de zhōng-wài yōuxiù zhéxué shèhuì kēxué sīxiǎng zhōng jíqǔ zhìguó-lǐzhèng de hóngkuò zhìhuì.', 'Kiên trì vũ trang trí tuệ bằng lý luận khoa học, không ngừng chắt lọc trí tuệ rộng lớn về trị quốc an dân từ tư tưởng triết học khoa học xã hội xuất sắc uyên thâm của Trung Quốc và thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3081] [四处] (sìchù) - bốn phía, khắp nơi, bốn phương tám hướng [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '四处' AND pinyin = 'sìchù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '四处' AND pinyin = 'sìchù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '四处'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '四处'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Phó từ',
      pinyin = 'sìchù',
      meaning_vi = 'bốn phía, khắp nơi, bốn phương tám hướng',
      example_hanzi = '春天百花盛开，微风吹拂，四处弥漫着清幽淡雅的花香。',
      example_pinyin = 'Chūntiān bǎihuā shèngkāi, wēifēng chuīfú, sìchù mímàn zhe qīngyōu dànyǎ de huāxiāng.',
      example_vi = 'Mùa xuân trăm hoa đua nở, gió nhẹ thoảng qua, khắp bốn phía lan tỏa mùi hương hoa thanh nhã dịu dàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '四处',
      'sìchù',
      'bốn phía, khắp nơi, bốn phương tám hướng',
      'Danh từ / Phó từ',
      'HSK 5',
      '春天百花盛开，微风吹拂，四处弥漫着清幽淡雅的花香。',
      'Chūntiān bǎihuā shèngkāi, wēifēng chuīfú, sìchù mímàn zhe qīngyōu dànyǎ de huāxiāng.',
      'Mùa xuân trăm hoa đua nở, gió nhẹ thoảng qua, khắp bốn phía lan tỏa mùi hương hoa thanh nhã dịu dàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春天百花盛开，微风吹拂，四处弥漫着清幽淡雅的花香。', 'Chūntiān bǎihuā shèngkāi, wēifēng chuīfú, sìchù mímàn zhe qīngyōu dànyǎ de huāxiāng.', 'Mùa xuân trăm hoa đua nở, gió nhẹ thoảng qua, khắp bốn phía lan tỏa mùi hương hoa thanh nhã dịu dàng.', 'basic', 1),
      (v_id, '针对边疆地质灾害隐患点，应急监测巡查队四处奔波开展全天候遥感雷达雷达巡检与实地勘查。', 'Zhēnduì biānjiāng dìzhì zāihài yǐnhuàndiǎn, yìngjí jiānkè xúncháduì sìchù bēnbō kāizhǎn quán-tiānhòu yáogǎn léidá léidá xúnjiǎn yǔ shídì kānchá.', 'Nhắm vào các điểm nguy cơ tiềm ẩn thảm họa địa chất biên cương, đội tuần tra giám sát khẩn cấp đã bôn ba khắp nơi triển khai tuần tra radar viễn thám và khảo sát thực địa suốt ngày đêm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3082] [似乎] (sìhū) - dường như, hình như, dường tựa [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '似乎' AND pinyin = 'sìhū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '似乎' AND pinyin = 'sìhū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '似乎'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '似乎'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'sìhū',
      meaning_vi = 'dường như, hình như, dường tựa',
      example_hanzi = '天空中渐渐聚拢起厚厚的乌云，似乎马上就要下起暴雨了。',
      example_pinyin = 'Tiānkōng zhōng jiànjiàn jùlǒng qǐ hòuhòu de wūyún, sìhū mǎshàng jiù yào xià qǐ bàoyǔ le.',
      example_vi = 'Trên bầu trời dần dần tụ lại những tầng mây đen dày đặc, hình như sắp sửa đổ cơn mưa rào đến nơi rồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '似乎',
      'sìhū',
      'dường như, hình như, dường tựa',
      'Phó từ',
      'HSK 5',
      '天空中渐渐聚拢起厚厚的乌云，似乎马上就要下起暴雨了。',
      'Tiānkōng zhōng jiànjiàn jùlǒng qǐ hòuhòu de wūyún, sìhū mǎshàng jiù yào xià qǐ bàoyǔ le.',
      'Trên bầu trời dần dần tụ lại những tầng mây đen dày đặc, hình như sắp sửa đổ cơn mưa rào đến nơi rồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天空中渐渐聚拢起厚厚的乌云，似乎马上就要下起暴雨了。', 'Tiānkōng zhōng jiànjiàn jùlǒng qǐ hòuhòu de wūyún, sìhū mǎshàng jiù yào xià qǐ bàoyǔ le.', 'Trên bầu trời dần dần tụ lại những tầng mây đen dày đặc, hình như sắp sửa đổ cơn mưa rào đến nơi rồi.', 'basic', 1),
      (v_id, '地缘政治冲突与逆全球化思潮似乎正在加剧全球供应链割裂，但经济全球化底层效率驱动的历史大势依然不可逆转。', 'Dìyuán zhèngzhì chōngtū yǔ nì-quánqiúhuà sīcháo sìhū zhèngzài jiājù quánqiú gōngyìngliàn gēliè, dàn jīngjì quánqiúhuà dǐcéng xiàolǜ qūdòng de lìshǐ dàshì yīrán bùkě nìzhuǎn.', 'Xung đột địa chính trị và trào lưu chống toàn cầu hóa dường như đang làm trầm trọng thêm sự đứt gãy chuỗi cung ứng toàn cầu, nhưng đại thế lịch sử thúc đẩy bởi hiệu quả nền tảng của toàn cầu hóa kinh tế vẫn là điều không thể đảo ngược.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3083] [四周] (sìzhōu) - bốn phía, chung quanh, xung quanh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '四周' AND pinyin = 'sìzhōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '四周' AND pinyin = 'sìzhōu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '四周'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '四周'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'sìzhōu',
      meaning_vi = 'bốn phía, chung quanh, xung quanh',
      example_hanzi = '登上山顶古塔的最高层，四周连绵起伏的青翠群山一览无余。',
      example_pinyin = 'Dēng shàng shāndǐng gǔtǎ de zuì gāocéng, sìzhōu liánmián-qǐfú de qīngcuì qúnshān yìlǎn-wúyú.',
      example_vi = 'Trèo lên tầng cao nhất của ngọn tháp cổ trên đỉnh núi, những dãy núi xanh mướt nhấp nhô trải dài bốn phía thu trọn vẹn vào tầm mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '四周',
      'sìzhōu',
      'bốn phía, chung quanh, xung quanh',
      'Danh từ',
      'HSK 5',
      '登上山顶古塔的最高层，四周连绵起伏的青翠群山一览无余。',
      'Dēng shàng shāndǐng gǔtǎ de zuì gāocéng, sìzhōu liánmián-qǐfú de qīngcuì qúnshān yìlǎn-wúyú.',
      'Trèo lên tầng cao nhất của ngọn tháp cổ trên đỉnh núi, những dãy núi xanh mướt nhấp nhô trải dài bốn phía thu trọn vẹn vào tầm mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '登上山顶古塔的最高层，四周连绵起伏的青翠群山一览无余。', 'Dēng shàng shāndǐng gǔtǎ de zuì gāocéng, sìzhōu liánmián-qǐfú de qīngcuì qúnshān yìlǎn-wúyú.', 'Trèo lên tầng cao nhất của ngọn tháp cổ trên đỉnh núi, những dãy núi xanh mướt nhấp nhô trải dài bốn phía thu trọn vẹn vào tầm mắt.', 'basic', 1),
      (v_id, '大型水电枢纽大坝在四周山体构筑了高精度渗流监测与微震监测孔网，全天候全方位感知库区四周岩石力学动态。', 'Dàxíng shuǐdiàn shūniǔ dàbà zài sìzhōu shāntǐ gòuzhù le gāo-jīngdù shènliú jiānkòng yǔ wēizhèn jiānkòng kǒngwǎng, quán-tiānhòu quán-fāngwèi gǎnzhī kùqū sìzhōu yánshí lìxué dòngtài.', 'Đập đầu mối thủy điện quy mô lớn đã xây dựng mạng lưới lỗ khoan giám sát vi chấn và dòng thấm độ chính xác cao tại các khối núi xung quanh, cảm biến toàn diện suốt ngày đêm động lực học cơ học đá bốn phía vùng lòng hồ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3084] [搜] (sōu) - tìm, lùng sục, tra tìm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '搜' AND pinyin = 'sōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '搜' AND pinyin = 'sōu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '搜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '搜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'sōu',
      meaning_vi = 'tìm, lùng sục, tra tìm',
      example_hanzi = '如果不认识这个生词，你可以打开手机词典软件搜一下它的读音和例句。',
      example_pinyin = 'Rúguǒ bú rènshi zhè ge shēngcí, nǐ kěyǐ dǎkāi shǒujī cídiǎn ruǎnjiàn sōu yíxià tā de dúyīn hé lìjù.',
      example_vi = 'Nếu không biết từ mới này, bạn có thể mở ứng dụng từ điển trên điện thoại để tra tìm một chút phát âm và câu ví dụ của nó.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '搜',
      'sōu',
      'tìm, lùng sục, tra tìm',
      'Động từ',
      'HSK 5',
      '如果不认识这个生词，你可以打开手机词典软件搜一下它的读音和例句。',
      'Rúguǒ bú rènshi zhè ge shēngcí, nǐ kěyǐ dǎkāi shǒujī cídiǎn ruǎnjiàn sōu yíxià tā de dúyīn hé lìjù.',
      'Nếu không biết từ mới này, bạn có thể mở ứng dụng từ điển trên điện thoại để tra tìm một chút phát âm và câu ví dụ của nó.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果不认识这个生词，你可以打开手机词典软件搜一下它的读音和例句。', 'Rúguǒ bú rènshi zhè ge shēngcí, nǐ kěyǐ dǎkāi shǒujī cídiǎn ruǎnjiàn sōu yíxià tā de dúyīn hé lìjù.', 'Nếu không biết từ mới này, bạn có thể mở ứng dụng từ điển trên điện thoại để tra tìm một chút phát âm và câu ví dụ của nó.', 'basic', 1),
      (v_id, '海上搜救应急指挥中心接到外籍货轮求救信标后，迅速指令专业巡航救援机在失事海域展开地毯式搜救。', 'Hǎishàng sōujiù yìngjí zhǐhuī zhōngxīn jiē dào wàijí huòlún qiújiù xìnbiāo hòu, xùnsù zhǐlìng zhuānyè xúnháng jiùyuánjī zài shīshì hǎiyù zhǎnkāi dìtǎnshì sōujiù.', 'Trung tâm chỉ huy khẩn cấp cứu hộ cứu nạn trên biển sau khi nhận được tín hiệu cầu cứu từ tàu hàng nước ngoài, đã nhanh chóng điều động máy bay cứu hộ tuần tra chuyên dụng triển khai tìm kiếm cứu nạn kiểu rải thảm tại vùng biển gặp nạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3085] [搜索] (sōusuǒ) - tìm kiếm, tra cứu, truy tìm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '搜索' AND pinyin = 'sōusuǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '搜索' AND pinyin = 'sōusuǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '搜索'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '搜索'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'sōusuǒ',
      meaning_vi = 'tìm kiếm, tra cứu, truy tìm',
      example_hanzi = '只要在网页搜索框中输入几个关键词，就能在零点几秒内获取海量相关信息。',
      example_pinyin = 'Zhǐyào zài wǎngyè sōusuǒkuāng zhōng shūrù jǐ ge guānjiàncí, jiù néng zài líng diǎn jǐ miǎo nèi huòqǔ hǎiliàng xiāngguān xìnxī.',
      example_vi = 'Chỉ cần nhập vài từ khóa vào thanh tìm kiếm trên trang web là có thể nhận được lượng thông tin liên quan khổng lồ chỉ trong vài phần mười giây.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '搜索',
      'sōusuǒ',
      'tìm kiếm, tra cứu, truy tìm',
      'Động từ / Danh từ',
      'HSK 5',
      '只要在网页搜索框中输入几个关键词，就能在零点几秒内获取海量相关信息。',
      'Zhǐyào zài wǎngyè sōusuǒkuāng zhōng shūrù jǐ ge guānjiàncí, jiù néng zài líng diǎn jǐ miǎo nèi huòqǔ hǎiliàng xiāngguān xìnxī.',
      'Chỉ cần nhập vài từ khóa vào thanh tìm kiếm trên trang web là có thể nhận được lượng thông tin liên quan khổng lồ chỉ trong vài phần mười giây.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只要在网页搜索框中输入几个关键词，就能在零点几秒内获取海量相关信息。', 'Zhǐyào zài wǎngyè sōusuǒkuāng zhōng shūrù jǐ ge guānjiàncí, jiù néng zài líng diǎn jǐ miǎo nèi huòqǔ hǎiliàng xiāngguān xìnxī.', 'Chỉ cần nhập vài từ khóa vào thanh tìm kiếm trên trang web là có thể nhận được lượng thông tin liên quan khổng lồ chỉ trong vài phần mười giây.', 'basic', 1),
      (v_id, '下一代智能知识图谱与语义搜索引擎不仅能完成字面字符串匹配，更深度解析用户复杂自然语言背后的多跳逻辑关联。', 'Xià-yí-dài zhìnéng zhīshi túpǔ yǔ yǔyì sōusuǒ yǐnqíng bùjǐn néng wánchéng zìmiàn zìfúchuàn pǐpèi, gèng shēndù jiěxī yònghù fùzá zìrán yǔyán bèihòu de duō-tiào luóji guānlián.', 'Đồ thị tri thức thông minh và công cụ tìm kiếm ngữ nghĩa thế hệ mới không chỉ làm được việc khớp chuỗi ký tự trên mặt chữ mà còn phân tích sâu sắc các liên hệ logic nhiều bước ẩn sau ngôn ngữ tự nhiên phức tạp của người dùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3086] [宿舍] (sùshè) - ký túc xá, phòng ở tập thể [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宿舍' AND pinyin = 'sùshè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宿舍' AND pinyin = 'sùshè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '宿舍'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宿舍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'sùshè',
      meaning_vi = 'ký túc xá, phòng ở tập thể',
      example_hanzi = '大学学生宿舍楼下配有洗衣房、自习室和二十四小时便利店。',
      example_pinyin = 'Dàxué xuéshēng sùshè lóu xià pèi yǒu xǐyīfáng, zìxíshì hé èrshísì xiǎoshí biànlìdiàn.',
      example_vi = 'Dưới chân tòa ký túc xá sinh viên trường đại học có trang bị phòng giặt đồ, phòng tự học và cửa hàng tiện lợi 24 giờ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宿舍',
      'sùshè',
      'ký túc xá, phòng ở tập thể',
      'Danh từ',
      'HSK 5',
      '大学学生宿舍楼下配有洗衣房、自习室和二十四小时便利店。',
      'Dàxué xuéshēng sùshè lóu xià pèi yǒu xǐyīfáng, zìxíshì hé èrshísì xiǎoshí biànlìdiàn.',
      'Dưới chân tòa ký túc xá sinh viên trường đại học có trang bị phòng giặt đồ, phòng tự học và cửa hàng tiện lợi 24 giờ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大学学生宿舍楼下配有洗衣房、自习室和二十四小时便利店。', 'Dàxué xuéshēng sùshè lóu xià pèi yǒu xǐyīfáng, zìxíshì hé èrshísì xiǎoshí biànlìdiàn.', 'Dưới chân tòa ký túc xá sinh viên trường đại học có trang bị phòng giặt đồ, phòng tự học và cửa hàng tiện lợi 24 giờ.', 'basic', 1),
      (v_id, '现代科技园区推行青年人才保障性租赁社区建设，将高品质人才公寓宿舍与孵化创客空间有机融合。', 'Xiàndài kējì yuánqū tuīxíng qīngnián réncái bǎozhàngxìng zūlìn shèqū jiànshè, jiāng gāo-pǐnzhì réncái gōngyù sùshè yǔ fūhuà chuàngkè kōngjiān yǒujī rónghé.', 'Khu công viên khoa học công nghệ hiện đại thúc đẩy việc xây dựng cộng đồng nhà ở cho thuê bảo đảm dành cho nhân tài trẻ, dung hợp hữu cơ giữa ký túc xá căn hộ nhân tài chất lượng cao với không gian ươm mầm khởi nghiệp sáng tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3087] [酸甜苦辣] (suān-tián-kǔ-là) - chua ngọt đắng cay, những thăng trầm hỷ nộ ái ố của cuộc đời [Cụm từ cố định]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '酸甜苦辣' AND pinyin = 'suān-tián-kǔ-là'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '酸甜苦辣' AND pinyin = 'suān-tián-kǔ-là'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '酸甜苦辣'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '酸甜苦辣'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Cụm từ cố định',
      pinyin = 'suān-tián-kǔ-là',
      meaning_vi = 'chua ngọt đắng cay, những thăng trầm hỷ nộ ái ố của cuộc đời',
      example_hanzi = '几位年过花甲的老知青坐在一起促膝长谈，感慨着几十年人生的酸甜苦辣。',
      example_pinyin = 'Jǐ wèi nián guò huājiǎ de lǎo zhīqīng zuò zài yìqǐ cùxī-chángtán, gǎnkǎi zhe jǐshí nián rénshēng de suān-tián-kǔ-là.',
      example_vi = 'Mấy bác cựu thanh niên trí thức tuổi đã ngoài hoa giáp ngồi lại bên nhau chuyện trò tâm sự thâu đêm, bùi ngùi cảm khái những đắng cay ngọt bùi của mấy chục năm cuộc đời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '酸甜苦辣',
      'suān-tián-kǔ-là',
      'chua ngọt đắng cay, những thăng trầm hỷ nộ ái ố của cuộc đời',
      'Cụm từ cố định',
      'HSK 5',
      '几位年过花甲的老知青坐在一起促膝长谈，感慨着几十年人生的酸甜苦辣。',
      'Jǐ wèi nián guò huājiǎ de lǎo zhīqīng zuò zài yìqǐ cùxī-chángtán, gǎnkǎi zhe jǐshí nián rénshēng de suān-tián-kǔ-là.',
      'Mấy bác cựu thanh niên trí thức tuổi đã ngoài hoa giáp ngồi lại bên nhau chuyện trò tâm sự thâu đêm, bùi ngùi cảm khái những đắng cay ngọt bùi của mấy chục năm cuộc đời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '几位年过花甲的老知青坐在一起促膝长谈，感慨着几十年人生的酸甜苦辣。', 'Jǐ wèi nián guò huājiǎ de lǎo zhīqīng zuò zài yìqǐ cùxī-chángtán, gǎnkǎi zhe jǐshí nián rénshēng de suān-tián-kǔ-là.', 'Mấy bác cựu thanh niên trí thức tuổi đã ngoài hoa giáp ngồi lại bên nhau chuyện trò tâm sự thâu đêm, bùi ngùi cảm khái những đắng cay ngọt bùi của mấy chục năm cuộc đời.', 'basic', 1),
      (v_id, '一代代科技创业者走过的艰苦奋斗历程，饱含着从无到有攻坚克难的酸甜苦辣，铸就了弥足珍贵的民族工业精神脊梁。', 'Yídàidài kējì chuàngyèzhě zǒu guò de jiānkǔ fèndòu lìchéng, bǎohán zhe cóng wú dào yǒu gōngjiān-kènán de suān-tián-kǔ-là, zhùjiù le mǐzú-zhēnguì de mínzú gōngyè jīngshén jǐliáng.', 'Chặng đường phấn đấu gian khổ mà bao thế hệ doanh nhân khởi nghiệp công nghệ đã đi qua, chan chứa bao đắng cay ngọt bùi của việc đi từ hai bàn tay trắng vượt qua muôn vàn khó khăn, đúc kết nên rường cột tinh thần công nghiệp dân tộc vô cùng quý báu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3088] [随] (suí) - theo, đi theo, theo sau, cùng với [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '随' AND pinyin = 'suí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随' AND pinyin = 'suí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '随'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Giới từ',
      pinyin = 'suí',
      meaning_vi = 'theo, đi theo, theo sau, cùng với',
      example_hanzi = '一阵清脆的下课铃声响起，同学们随着人流鱼贯走出教学大楼。',
      example_pinyin = 'Yí zhèn qīngcuì de xiàkè língshēng xiǎngqǐ, tóngxuémen suízhe rénliú yúguàn zǒu chū jiàoxué dàlóu.',
      example_vi = 'Một hồi chuông tan học giòn giã vang lên, các bạn học sinh đi theo dòng người lần lượt nối đuôi nhau bước ra khỏi tòa nhà giảng đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '随',
      'suí',
      'theo, đi theo, theo sau, cùng với',
      'Động từ / Giới từ',
      'HSK 5',
      '一阵清脆的下课铃声响起，同学们随着人流鱼贯走出教学大楼。',
      'Yí zhèn qīngcuì de xiàkè língshēng xiǎngqǐ, tóngxuémen suízhe rénliú yúguàn zǒu chū jiàoxué dàlóu.',
      'Một hồi chuông tan học giòn giã vang lên, các bạn học sinh đi theo dòng người lần lượt nối đuôi nhau bước ra khỏi tòa nhà giảng đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一阵清脆的下课铃声响起，同学们随着人流鱼贯走出教学大楼。', 'Yí zhèn qīngcuì de xiàkè língshēng xiǎngqǐ, tóngxuémen suízhe rénliú yúguàn zǒu chū jiàoxué dàlóu.', 'Một hồi chuông tan học giòn giã vang lên, các bạn học sinh đi theo dòng người lần lượt nối đuôi nhau bước ra khỏi tòa nhà giảng đường.', 'basic', 1),
      (v_id, '随经济全球化深入推进与区域全面经济伙伴关系协定落地生效，亚太供应链各经济体间的贸易依存度持续深化。', 'Suí jīngjì quánqiúhuà shēnrù tuījìn yǔ qūyù quánmiàn jīngjì huǒbàn guānxì xiédìng luòdì shēngxiào, Yà-Tài gōngyìngliàn gè jīngjìtǐ jiān de màoyì yīcúndù chíxù shēnhuà.', 'Cùng với toàn cầu hóa kinh tế đi sâu thúc đẩy và hiệp định đối tác kinh tế toàn diện khu vực đi vào hiệu lực thực tế, mức độ phụ thuộc thương mại lẫn nhau giữa các nền kinh tế trong chuỗi cung ứng châu Á - Thái Bình Dương không ngừng sâu sắc thêm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3089] [随后] (suíhòu) - ngay sau đó, tiếp theo, tiếp sau [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '随后' AND pinyin = 'suíhòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随后' AND pinyin = 'suíhòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '随后'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随后'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'suíhòu',
      meaning_vi = 'ngay sau đó, tiếp theo, tiếp sau',
      example_hanzi = '主持人宣读完开幕词，随后宣布本次科技创新成果展览正式开始。',
      example_pinyin = 'Zhǔchírén xuāndú wán kāimùcí, suíhòu xuānbù běn cì kējì chuàngxīn chéngguǒ zhǎnlǎn zhèngshì kāishǐ.',
      example_vi = 'Người dẫn chương trình đọc xong lời khai mạc, ngay sau đó tuyên bố triển lãm thành quả đổi mới khoa học công nghệ lần này chính thức bắt đầu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '随后',
      'suíhòu',
      'ngay sau đó, tiếp theo, tiếp sau',
      'Phó từ',
      'HSK 5',
      '主持人宣读完开幕词，随后宣布本次科技创新成果展览正式开始。',
      'Zhǔchírén xuāndú wán kāimùcí, suíhòu xuānbù běn cì kējì chuàngxīn chéngguǒ zhǎnlǎn zhèngshì kāishǐ.',
      'Người dẫn chương trình đọc xong lời khai mạc, ngay sau đó tuyên bố triển lãm thành quả đổi mới khoa học công nghệ lần này chính thức bắt đầu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '主持人宣读完开幕词，随后宣布本次科技创新成果展览正式开始。', 'Zhǔchírén xuāndú wán kāimùcí, suíhòu xuānbù běn cì kējì chuàngxīn chéngguǒ zhǎnlǎn zhèngshì kāishǐ.', 'Người dẫn chương trình đọc xong lời khai mạc, ngay sau đó tuyên bố triển lãm thành quả đổi mới khoa học công nghệ lần này chính thức bắt đầu.', 'basic', 1),
      (v_id, '火箭成功将试验卫星送入预定近地轨道，随后地面测控中心宣布各载荷遥测遥控信号接收一切正常。', 'Huǒjiàn chénggōng jiāng shìyàn wèixīng sòng rù yùdìng jìndì guǐdào, suíhòu dìmiàn cèkòng zhōngxīn xuānbù gè zàihè yáocè yáokòng xìnhào jiēshōu yíqiè zhèngcháng.', 'Tên lửa đã đưa thành công vệ tinh thí nghiệm vào quỹ đạo tầm thấp dự kiến, ngay sau đó trung tâm đo lường điều khiển mặt đất tuyên bố việc thu nhận các tín hiệu viễn trắc viễn điều khiển của mọi tải trọng đều hoàn toàn bình thường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3090] [随时] (suíshí) - bất cứ lúc nào, mọi lúc [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '随时' AND pinyin = 'suíshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随时' AND pinyin = 'suíshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '随时'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'suíshí',
      meaning_vi = 'bất cứ lúc nào, mọi lúc',
      example_hanzi = '如果在学习过程中遇到不懂的问题，大家可以随时向老师发邮件请教。',
      example_pinyin = 'Rúguǒ zài xuéxí guòchéng zhōng yùdào bù dǒng de wèntí, dàjiā kěyǐ suíshí xiàng lǎoshī fā yóujiàn qǐngjiào.',
      example_vi = 'Nếu trong quá trình học tập gặp phải câu hỏi không hiểu, mọi người có thể gửi thư điện tử thỉnh giáo thầy giáo bất kỳ lúc nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '随时',
      'suíshí',
      'bất cứ lúc nào, mọi lúc',
      'Phó từ',
      'HSK 5',
      '如果在学习过程中遇到不懂的问题，大家可以随时向老师发邮件请教。',
      'Rúguǒ zài xuéxí guòchéng zhōng yùdào bù dǒng de wèntí, dàjiā kěyǐ suíshí xiàng lǎoshī fā yóujiàn qǐngjiào.',
      'Nếu trong quá trình học tập gặp phải câu hỏi không hiểu, mọi người có thể gửi thư điện tử thỉnh giáo thầy giáo bất kỳ lúc nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果在学习过程中遇到不懂的问题，大家可以随时向老师发邮件请教。', 'Rúguǒ zài xuéxí guòchéng zhōng yùdào bù dǒng de wèntí, dàjiā kěyǐ suíshí xiàng lǎoshī fā yóujiàn qǐngjiào.', 'Nếu trong quá trình học tập gặp phải câu hỏi không hiểu, mọi người có thể gửi thư điện tử thỉnh giáo thầy giáo bất kỳ lúc nào.', 'basic', 1),
      (v_id, '国家防汛抗旱应急指挥部与综合气象雷达网络保持密切联动，随时做好调集跨区域抢险救灾专业力量的临战准备。', 'Guójiā fángxùn kànghàn yìngjí zhǐhuībù yǔ zōnghé qìxiàng léidá wǎngluò bǎochí mìqiè liándòng, suíshí zuò hǎo diàojí kuà-qūyù qiǎngxiǎn jiùzāi zhuānyè lìliàng de línzhàn zhǔnbèi.', 'Ban chỉ huy ứng phó khẩn cấp phòng chống bão hạn quốc gia duy trì phối hợp hiệp đồng chặt chẽ với mạng lưới radar khí tượng tổng hợp, bất cứ lúc nào cũng chuẩn bị sẵn sàng tư thế xuất quân điều động các lực lượng cứu hộ thiên tai chuyên nghiệp liên khu vực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3091] [随手] (suíshǒu) - tiện tay, thuận tay [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '随手' AND pinyin = 'suíshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随手' AND pinyin = 'suíshǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '随手'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随手'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'suíshǒu',
      meaning_vi = 'tiện tay, thuận tay',
      example_hanzi = '离开会议室时，请随手关灯关空调以节约用电。',
      example_pinyin = 'Líkāi huìyìshì shí, qǐng suíshǒu guāndēng guān kōngtiáo yǐ jiéyuē yòngdiàn.',
      example_vi = 'Khi rời khỏi phòng họp, xin vui lòng tiện tay tắt đèn tắt điều hòa để tiết kiệm điện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '随手',
      'suíshǒu',
      'tiện tay, thuận tay',
      'Phó từ',
      'HSK 5',
      '离开会议室时，请随手关灯关空调以节约用电。',
      'Líkāi huìyìshì shí, qǐng suíshǒu guāndēng guān kōngtiáo yǐ jiéyuē yòngdiàn.',
      'Khi rời khỏi phòng họp, xin vui lòng tiện tay tắt đèn tắt điều hòa để tiết kiệm điện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '离开会议室时，请随手关灯关空调以节约用电。', 'Líkāi huìyìshì shí, qǐng suíshǒu guāndēng guān kōngtiáo yǐ jiéyuē yòngdiàn.', 'Khi rời khỏi phòng họp, xin vui lòng tiện tay tắt đèn tắt điều hòa để tiết kiệm điện.', 'basic', 1),
      (v_id, '广大市民自觉养成不随手乱扔垃圾、主动进行垃圾分类的文明生活习惯，让城市生态环境更加整洁优美。', 'Guǎngdà shìmín zìjué yǎngchéng bù suíshǒu luàn rēng lājī, zhǔdòng jìnxíng lājī fēnlèi de wénmíng shēnghuó xíguàn, ràng chéngshì shēngtài huánjìng gèngjiā zhěngjié yōuměi.', 'Đông đảo người dân thành phố tự giác hình thành thói quen nếp sống văn minh không tiện tay vứt rác bừa bãi và chủ động phân loại rác thải, giúp môi trường sinh thái đô thị ngày càng ngăn nắp sạch đẹp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3092] [随意] (suíyì) - tùy ý, tự nhiên, tùy tiện [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '随意' AND pinyin = 'suíyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随意' AND pinyin = 'suíyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '随意'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '随意'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'suíyì',
      meaning_vi = 'tùy ý, tự nhiên, tùy tiện',
      example_hanzi = '到了朋友家里做客，主人热情地招呼大家不要拘束，随意坐下喝茶聊天。',
      example_pinyin = 'Dào le péngyou jiālǐ zuòkè, zhǔrén rèqíng de zhāohu dàjiā bú yào jūshù, suíyì zuò xià hēchá liáotiān.',
      example_vi = 'Đến nhà bạn làm khách, chủ nhà nhiệt tình chào mời mọi người đừng câu nệ giữ kẽ, cứ tự nhiên ngồi xuống uống trà trò chuyện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '随意',
      'suíyì',
      'tùy ý, tự nhiên, tùy tiện',
      'Tính từ / Phó từ',
      'HSK 5',
      '到了朋友家里做客，主人热情地招呼大家不要拘束，随意坐下喝茶聊天。',
      'Dào le péngyou jiālǐ zuòkè, zhǔrén rèqíng de zhāohu dàjiā bú yào jūshù, suíyì zuò xià hēchá liáotiān.',
      'Đến nhà bạn làm khách, chủ nhà nhiệt tình chào mời mọi người đừng câu nệ giữ kẽ, cứ tự nhiên ngồi xuống uống trà trò chuyện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '到了朋友家里做客，主人热情地招呼大家不要拘束，随意坐下喝茶聊天。', 'Dào le péngyou jiālǐ zuòkè, zhǔrén rèqíng de zhāohu dàjiā bú yào jūshù, suíyì zuò xià hēchá liáotiān.', 'Đến nhà bạn làm khách, chủ nhà nhiệt tình chào mời mọi người đừng câu nệ giữ kẽ, cứ tự nhiên ngồi xuống uống trà trò chuyện.', 'basic', 1),
      (v_id, '任何企业不得随意修改排污许可证规定的排放口位置与浓度限值，必须恪守生态环保法律法规底线。', 'Rènhé qǐyè bùdé suíyì xiūgǎi páiwū xǔkězhèng guīdìng de páifàngkǒu wèizhì yǔ nóngdù xiànzhí, bìxū kèshǒu shēngtài huánbǎo fǎlǜ fǎguī dǐxiàn.', 'Bất kỳ doanh nghiệp nào cũng không được tùy tiện sửa đổi vị trí họng xả thải và giới hạn nồng độ quy định trong giấy phép xả thải, bắt buộc phải nghiêm cẩn tuân thủ giới hạn đỏ của luật pháp quy chuẩn bảo vệ môi trường sinh thái.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3093] [碎] (suì) - vỡ vụn, nát; làm vỡ, đập vụn [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '碎' AND pinyin = 'suì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '碎' AND pinyin = 'suì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '碎'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '碎'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'suì',
      meaning_vi = 'vỡ vụn, nát; làm vỡ, đập vụn',
      example_hanzi = '他不小心将玻璃水杯掉在瓷砖地板上，杯子顿时摔得粉碎。',
      example_pinyin = 'Tā bù xiǎoxīn jiāng bōli shuǐbēi diào zài cízhuān dìbǎn shang, bēizi dùnshí shuāi de fěnsuì.',
      example_vi = 'Anh ấy sơ ý đánh rơi chiếc cốc thủy tinh xuống sàn gạch men, chiếc cốc lập tức rơi vỡ tan tành thành từng mảnh vụn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '碎',
      'suì',
      'vỡ vụn, nát; làm vỡ, đập vụn',
      'Tính từ / Động từ',
      'HSK 5',
      '他不小心将玻璃水杯掉在瓷砖地板上，杯子顿时摔得粉碎。',
      'Tā bù xiǎoxīn jiāng bōli shuǐbēi diào zài cízhuān dìbǎn shang, bēizi dùnshí shuāi de fěnsuì.',
      'Anh ấy sơ ý đánh rơi chiếc cốc thủy tinh xuống sàn gạch men, chiếc cốc lập tức rơi vỡ tan tành thành từng mảnh vụn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他不小心将玻璃水杯掉在瓷砖地板上，杯子顿时摔得粉碎。', 'Tā bù xiǎoxīn jiāng bōli shuǐbēi diào zài cízhuān dìbǎn shang, bēizi dùnshí shuāi de fěnsuì.', 'Anh ấy sơ ý đánh rơi chiếc cốc thủy tinh xuống sàn gạch men, chiếc cốc lập tức rơi vỡ tan tành thành từng mảnh vụn.', 'basic', 1),
      (v_id, '深层岩石高效水力压裂技术利用超高压脉冲水力流体将致密页岩地层压裂成微细裂隙网，实现了页岩气规模化开采突破。', 'Shēncéng yánshí gāoxiào shuǐlì yāliè jìshù lìyòng chāo-gāoyā màichōng shuǐlì liútǐ jiāng zhìmì yèyán dìcéng yāliè chéng wēixì lièxì wǎng, shíxiàn le yèyánqì guīmóhuà kāicǎi tūpò.', 'Kỹ thuật nứt vỉa thủy lực hiệu quả cao tầng đá sâu tận dụng chất lưu thủy lực xung siêu cao áp để làm nứt vỡ địa tầng đá phiến sét đặc sít thành mạng lưới khe nứt vi mô, đạt được bước đột phá trong khai thác khí đá phiến quy mô lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3094] [损害] (sǔnhài) - làm hại, tổn hại, làm hư tổn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '损害' AND pinyin = 'sǔnhài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '损害' AND pinyin = 'sǔnhài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '损害'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '损害'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'sǔnhài',
      meaning_vi = 'làm hại, tổn hại, làm hư tổn',
      example_hanzi = '长期熬夜睡眠不足会严重损害身体的免疫系统功能。',
      example_pinyin = 'Chángqī áoyè shuìmián bùzú huì yánzhòng sǔnhài shēntǐ de miǎnyì xìtǒng gōngnéng.',
      example_vi = 'Thức khuya lâu ngày thiếu ngủ sẽ làm tổn hại nghiêm trọng đến chức năng hệ thống miễn dịch của cơ thể.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '损害',
      'sǔnhài',
      'làm hại, tổn hại, làm hư tổn',
      'Động từ',
      'HSK 5',
      '长期熬夜睡眠不足会严重损害身体的免疫系统功能。',
      'Chángqī áoyè shuìmián bùzú huì yánzhòng sǔnhài shēntǐ de miǎnyì xìtǒng gōngnéng.',
      'Thức khuya lâu ngày thiếu ngủ sẽ làm tổn hại nghiêm trọng đến chức năng hệ thống miễn dịch của cơ thể.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长期熬夜睡眠不足会严重损害身体的免疫系统功能。', 'Chángqī áoyè shuìmián bùzú huì yánzhòng sǔnhài shēntǐ de miǎnyì xìtǒng gōngnéng.', 'Thức khuya lâu ngày thiếu ngủ sẽ làm tổn hại nghiêm trọng đến chức năng hệ thống miễn dịch của cơ thể.', 'basic', 1),
      (v_id, '严禁任何不正当竞争行为与虚假商业宣传，依法坚决打击损害广大消费者合法权益与扰乱市场秩序的违法活动。', 'Yánjìn rènhé bú-zhèngdàng jìngzhēng xíngwéi yǔ xūjiǎ shāngyè xuānchuán, yīfǎ jiānjué dǎjī sǔnhài guǎngdà xiāofèizhě héfǎ quányì yǔ rǎoluàn shìchǎng zhìxù de wéifǎ huódòng.', 'Nghiêm cấm mọi hành vi cạnh tranh không lành mạnh và tuyên truyền thương mại sai sự thật, kiên quyết xử lý theo pháp luật các hoạt động vi phạm làm tổn hại quyền lợi hợp pháp của đông đảo người tiêu dùng và làm rối loạn trật tự thị trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3095] [损失] (sǔnshī) - tổn thất, thiệt hại; làm mất [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '损失' AND pinyin = 'sǔnshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '损失' AND pinyin = 'sǔnshī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '损失'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '损失'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'sǔnshī',
      meaning_vi = 'tổn thất, thiệt hại; làm mất',
      example_hanzi = '消防队员迅速赶到火灾现场扑灭了大火，最大程度减少了居民的财产损失。',
      example_pinyin = 'Xiāofáng duìyuán xùnsù gǎndào huǒzāi xiànchǎng pūmiè le dàhuǒ, zuìdà chéngdù jiǎnshǎo le jūmín de cáichǎn sǔnshī.',
      example_vi = 'Lực lượng lính cứu hỏa đã nhanh chóng có mặt tại hiện trường vụ cháy dập tắt ngọn lửa lớn, giảm thiểu tối đa tổn thất tài sản của cư dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '损失',
      'sǔnshī',
      'tổn thất, thiệt hại; làm mất',
      'Động từ / Danh từ',
      'HSK 5',
      '消防队员迅速赶到火灾现场扑灭了大火，最大程度减少了居民的财产损失。',
      'Xiāofáng duìyuán xùnsù gǎndào huǒzāi xiànchǎng pūmiè le dàhuǒ, zuìdà chéngdù jiǎnshǎo le jūmín de cáichǎn sǔnshī.',
      'Lực lượng lính cứu hỏa đã nhanh chóng có mặt tại hiện trường vụ cháy dập tắt ngọn lửa lớn, giảm thiểu tối đa tổn thất tài sản của cư dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '消防队员迅速赶到火灾现场扑灭了大火，最大程度减少了居民的财产损失。', 'Xiāofáng duìyuán xùnsù gǎndào huǒzāi xiànchǎng pūmiè le dàhuǒ, zuìdà chéngdù jiǎnshǎo le jūmín de cáichǎn sǔnshī.', 'Lực lượng lính cứu hỏa đã nhanh chóng có mặt tại hiện trường vụ cháy dập tắt ngọn lửa lớn, giảm thiểu tối đa tổn thất tài sản của cư dân.', 'basic', 1),
      (v_id, '跨国供应链中断与汇率剧烈波动给涉外进出口企业带来了巨大的潜在经济损失，亟需健全汇率套期保值避险工具。', 'Kuàguó gōngyìngliàn zhōngduàn yǔ huìlǜ jùliè bōdòng gěi shèwài jìn-chūkǒu qǐyè dài lái le jùdà de qiánzài jīngjì sǔnshī, jíxū jiànquán huìlǜ tàoqī-bǎozhí bìxiǎn gōngjù.', 'Sự gián đoạn chuỗi cung ứng xuyên quốc gia và tỷ giá hối đoái biến động dữ dội đã đem lại tổn thất kinh tế tiềm ẩn to lớn cho các doanh nghiệp xuất nhập khẩu có yếu tố nước ngoài, khẩn thiết cần hoàn thiện các công cụ phòng hộ rủi ro phòng ngừa tỷ giá.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3096] [缩短] (suōduǎn) - rút ngắn, thu ngắn lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '缩短' AND pinyin = 'suōduǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缩短' AND pinyin = 'suōduǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '缩短'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缩短'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'suōduǎn',
      meaning_vi = 'rút ngắn, thu ngắn lại',
      example_hanzi = '新建成的高速铁路将两座大城市之间的通行时间由原来的六小时大幅缩短至两小时以内。',
      example_pinyin = 'Xīn jiànchéng de gāosù tiělù jiāng liǎng zuò dà chéngshì zhījiān de tōngxíng shíjiān yóu yuánlái de liù xiǎoshí dàfú suōduǎn zhì liǎng xiǎoshí yǐnèi.',
      example_vi = 'Tuyến đường sắt cao tốc mới khánh thành đã rút ngắn mạnh mẽ thời gian lưu thông giữa hai thành phố lớn từ 6 tiếng trước đây xuống dưới 2 tiếng đồng hồ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '缩短',
      'suōduǎn',
      'rút ngắn, thu ngắn lại',
      'Động từ',
      'HSK 5',
      '新建成的高速铁路将两座大城市之间的通行时间由原来的六小时大幅缩短至两小时以内。',
      'Xīn jiànchéng de gāosù tiělù jiāng liǎng zuò dà chéngshì zhījiān de tōngxíng shíjiān yóu yuánlái de liù xiǎoshí dàfú suōduǎn zhì liǎng xiǎoshí yǐnèi.',
      'Tuyến đường sắt cao tốc mới khánh thành đã rút ngắn mạnh mẽ thời gian lưu thông giữa hai thành phố lớn từ 6 tiếng trước đây xuống dưới 2 tiếng đồng hồ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新建成的高速铁路将两座大城市之间的通行时间由原来的六小时大幅缩短至两小时以内。', 'Xīn jiànchéng de gāosù tiělù jiāng liǎng zuò dà chéngshì zhījiān de tōngxíng shíjiān yóu yuánlái de liù xiǎoshí dàfú suōduǎn zhì liǎng xiǎoshí yǐnèi.', 'Tuyến đường sắt cao tốc mới khánh thành đã rút ngắn mạnh mẽ thời gian lưu thông giữa hai thành phố lớn từ 6 tiếng trước đây xuống dưới 2 tiếng đồng hồ.', 'basic', 1),
      (v_id, '基于人工智能的多靶点虚拟药物分子筛选技术，成功将新药早期先导化合物发现周期由三年大幅缩短至数月。', 'Jīyú réngōng zhìnéng de duō-bǎdiǎn xūnǐ yàowù fēnzǐ shāixuǎn jìshù, chénggōng jiāng xīnyào zǎoqī xiāndǎo huàhéwù fāxiàn zhōuqī yóu sān nián dàfú suōduǎn zhì shù yuè.', 'Kỹ thuật sàng lọc phân tử thuốc ảo đa đích dựa trên trí tuệ nhân tạo đã rút ngắn thành công chu kỳ phát hiện hợp chất dẫn đường giai đoạn đầu của thuốc mới từ ba năm xuống chỉ còn vài tháng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3097] [缩小] (suōxiǎo) - thu nhỏ, thu hẹp lại (khoảng cách, chênh lệch) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '缩小' AND pinyin = 'suōxiǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缩小' AND pinyin = 'suōxiǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '缩小'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缩小'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'suōxiǎo',
      meaning_vi = 'thu nhỏ, thu hẹp lại (khoảng cách, chênh lệch)',
      example_hanzi = '在手机屏幕上用两个手指轻轻一捏，就可以缩小正在查看的电子地图。',
      example_pinyin = 'Zài shǒujī píngmù shang yòng liǎng ge shǒuzhǐ qīngqīng yì niē, jiù kěyǐ suōxiǎo zhèngzài chákàn de diànzǐ dìtú.',
      example_vi = 'Trên màn hình điện thoại dùng hai ngón tay khẽ chụm lại là có thể thu nhỏ bản đồ điện tử đang xem.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '缩小',
      'suōxiǎo',
      'thu nhỏ, thu hẹp lại (khoảng cách, chênh lệch)',
      'Động từ',
      'HSK 5',
      '在手机屏幕上用两个手指轻轻一捏，就可以缩小正在查看的电子地图。',
      'Zài shǒujī píngmù shang yòng liǎng ge shǒuzhǐ qīngqīng yì niē, jiù kěyǐ suōxiǎo zhèngzài chákàn de diànzǐ dìtú.',
      'Trên màn hình điện thoại dùng hai ngón tay khẽ chụm lại là có thể thu nhỏ bản đồ điện tử đang xem.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在手机屏幕上用两个手指轻轻一捏，就可以缩小正在查看的电子地图。', 'Zài shǒujī píngmù shang yòng liǎng ge shǒuzhǐ qīngqīng yì niē, jiù kěyǐ suōxiǎo zhèngzài chákàn de diànzǐ dìtú.', 'Trên màn hình điện thoại dùng hai ngón tay khẽ chụm lại là có thể thu nhỏ bản đồ điện tử đang xem.', 'basic', 1),
      (v_id, '扎实推进共同富裕战略要求着力缩小城乡差距、区域差距和收入分配差距，持续健全多层次社会保障兜底体系。', 'Zhāshi tuījìn gòngtóng fùyù zhànlüè yāoqiú zhuólì suōxiǎo chéng-xiāng chājù, qūyù chājù hé shōurù fēnpèi chājù, chíxù jiànquán duō-céngcì shèhuì bǎozhàng dōudǐ tǐxì.', 'Thúc đẩy vững chắc chiến lược cùng chung thịnh vượng đòi hỏi phải tập trung thu hẹp khoảng cách nông thôn - thành thị, khoảng cách vùng miền và khoảng cách phân phối thu nhập, liên tục hoàn thiện hệ thống bảo đảm an sinh xã hội đa tầng vững chãi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3098] [所] (suǒ) - ngôi, sở, chỗ, nơi [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '所' AND pinyin = 'suǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '所' AND pinyin = 'suǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '所'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '所'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'suǒ',
      meaning_vi = 'ngôi, sở, chỗ, nơi',
      example_hanzi = '经过一年的紧张施工，这座偏远乡村里建起了一所设施现代化的小学。',
      example_pinyin = 'Jīngguò yì nián de jǐnzhāng shīgōng, zhè zuò piānyuǎn xiāngcūn lǐ jiàn qǐ le yì suǒ shèshī xiàndàihuà de xiǎoxué.',
      example_vi = 'Sau một năm thi công khẩn trương, tại ngôi làng nông thôn hẻo lánh này đã mọc lên một ngôi trường tiểu học có cơ sở vật chất hiện đại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '所',
      'suǒ',
      'ngôi, sở, chỗ, nơi',
      'Lượng từ / Danh từ',
      'HSK 5',
      '经过一年的紧张施工，这座偏远乡村里建起了一所设施现代化的小学。',
      'Jīngguò yì nián de jǐnzhāng shīgōng, zhè zuò piānyuǎn xiāngcūn lǐ jiàn qǐ le yì suǒ shèshī xiàndàihuà de xiǎoxué.',
      'Sau một năm thi công khẩn trương, tại ngôi làng nông thôn hẻo lánh này đã mọc lên một ngôi trường tiểu học có cơ sở vật chất hiện đại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过一年的紧张施工，这座偏远乡村里建起了一所设施现代化的小学。', 'Jīngguò yì nián de jǐnzhāng shīgōng, zhè zuò piānyuǎn xiāngcūn lǐ jiàn qǐ le yì suǒ shèshī xiàndàihuà de xiǎoxué.', 'Sau một năm thi công khẩn trương, tại ngôi làng nông thôn hẻo lánh này đã mọc lên một ngôi trường tiểu học có cơ sở vật chất hiện đại.', 'basic', 1),
      (v_id, '这所坐落于国家科学中心核心区的高水平国家实验室，集聚了数十位两院院士与全球顶尖跨学科青年科研领军人才。', 'Zhè suǒ zuòluò yú guójiā kēxué zhōngxīn héxīnqū de gāo-shuǐpíng guójiā shíyànshì, jíjù le shùshí wèi liǎngyuàn yuànshì yǔ quánqiú dǐngjiān kuà-xuékē qīngnián kēyán lǐngjūn réncái.', 'Phòng thí nghiệm quốc gia trình độ cao tọa lạc tại khu vực lõi của trung tâm khoa học quốc gia này quy tụ hàng chục viện sĩ hai viện hàn lâm cùng những nhân tài khoa học trẻ dẫn đầu liên ngành đỉnh cao toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3099] [锁] (suǒ) - ổ khóa; khóa lại, khóa chặt [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '锁' AND pinyin = 'suǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '锁' AND pinyin = 'suǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '锁'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '锁'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'suǒ',
      meaning_vi = 'ổ khóa; khóa lại, khóa chặt',
      example_hanzi = '出门上班前，请务必仔细检查门窗是否关好并锁好大门。',
      example_pinyin = 'Chūmén shàngbān qián, qǐng wùbì zǐxì jiǎnchá ménchuāng shìfǒu guān hǎo bìng suǒ hǎo dàmén.',
      example_vi = 'Trước khi ra ngoài đi làm, xin nhất thiết phải kiểm tra kỹ càng xem cửa sổ cửa ra vào đã đóng cẩn thận và khóa chắc cổng lớn hay chưa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '锁',
      'suǒ',
      'ổ khóa; khóa lại, khóa chặt',
      'Danh từ / Động từ',
      'HSK 5',
      '出门上班前，请务必仔细检查门窗是否关好并锁好大门。',
      'Chūmén shàngbān qián, qǐng wùbì zǐxì jiǎnchá ménchuāng shìfǒu guān hǎo bìng suǒ hǎo dàmén.',
      'Trước khi ra ngoài đi làm, xin nhất thiết phải kiểm tra kỹ càng xem cửa sổ cửa ra vào đã đóng cẩn thận và khóa chắc cổng lớn hay chưa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门上班前，请务必仔细检查门窗是否关好并锁好大门。', 'Chūmén shàngbān qián, qǐng wùbì zǐxì jiǎnchá ménchuāng shìfǒu guān hǎo bìng suǒ hǎo dàmén.', 'Trước khi ra ngoài đi làm, xin nhất thiết phải kiểm tra kỹ càng xem cửa sổ cửa ra vào đã đóng cẩn thận và khóa chắc cổng lớn hay chưa.', 'basic', 1),
      (v_id, '新一代智能家居物联网安全网关采用了硬件级物理安全芯片加密技术，彻底锁死并防御了非法网络远程挟持风险。', 'Xīn yí dài zhìnéng jiājū wùliánwǎng ānquán wǎngguān cǎiyòng le yìngjiànjí wùlǐ ānquán xīanpiàn jiāmì jìshù, chèdǐ suǒsǐ bìng fángyù le fēifǎ wǎngluò yuǎnchéng xiéchí fēngxiǎn.', 'Cổng an ninh Internet vạn vật nhà thông minh thế hệ mới đã ứng dụng công nghệ mã hóa chip bảo mật vật lý cấp phần cứng, khóa chặt triệt để và phòng ngự nguy cơ bị khống chế điều khiển từ xa bất hợp pháp qua mạng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3100] [他人] (tārén) - người khác, người ta [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '他人' AND pinyin = 'tārén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '他人' AND pinyin = 'tārén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '他人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '他人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'tārén',
      meaning_vi = 'người khác, người ta',
      example_hanzi = '在公共图书馆或自习室阅读时，请保持安静，不要大声喧哗打扰他人。',
      example_pinyin = 'Zài gōnggòng túshūguǎn huò zìxíshì yuèdú shí, qǐng bǎochí ānjìng, bú yào dàshēng xuānhuá dǎrǎo tārén.',
      example_vi = 'Khi đọc sách trong thư viện công cộng hoặc phòng tự học, xin hãy giữ trật tự yên tĩnh, không làm ồn huyên náo gây phiền hà tới người khác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '他人',
      'tārén',
      'người khác, người ta',
      'Đại từ',
      'HSK 5',
      '在公共图书馆或自习室阅读时，请保持安静，不要大声喧哗打扰他人。',
      'Zài gōnggòng túshūguǎn huò zìxíshì yuèdú shí, qǐng bǎochí ānjìng, bú yào dàshēng xuānhuá dǎrǎo tārén.',
      'Khi đọc sách trong thư viện công cộng hoặc phòng tự học, xin hãy giữ trật tự yên tĩnh, không làm ồn huyên náo gây phiền hà tới người khác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在公共图书馆或自习室阅读时，请保持安静，不要大声喧哗打扰他人。', 'Zài gōnggòng túshūguǎn huò zìxíshì yuèdú shí, qǐng bǎochí ānjìng, bú yào dàshēng xuānhuá dǎrǎo tārén.', 'Khi đọc sách trong thư viện công cộng hoặc phòng tự học, xin hãy giữ trật tự yên tĩnh, không làm ồn huyên náo gây phiền hà tới người khác.', 'basic', 1),
      (v_id, '侵犯他人注册商标专用权与商业秘密的不正当竞争行为，依法将承担巨额惩罚性民事赔偿责任直至刑事追责。', 'Qīnfàn tārén zhùcè shāngbiāo zhuānyǒuquán yǔ shāngyè mìmì de bú-zhèngdàng jìngzhēng xíngwéi, yīfǎ jiāng chéngdān jù’é chéngfáxìng mínshì péicháng zérèn zhízhì xíngshì zhuīzé.', 'Hành vi cạnh tranh không lành mạnh xâm phạm quyền sở hữu nhãn hiệu đã đăng ký và bí mật kinh doanh của người khác, theo luật định sẽ phải chịu trách nhiệm bồi thường dân sự mang tính trừng phạt số tiền khổng lồ cho tới truy cứu trách nhiệm hình sự.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3101] [台灯] (táidēng) - đèn bàn, đèn học để bàn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '台灯' AND pinyin = 'táidēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '台灯' AND pinyin = 'táidēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '台灯'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '台灯'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'táidēng',
      meaning_vi = 'đèn bàn, đèn học để bàn',
      example_hanzi = '夜晚做功课时，书桌上的柔光护眼台灯散发着温馨柔和的光芒。',
      example_pinyin = 'Yèwǎn zuò gōngkè shí, shūzhuō shang de róuguāng hùyǎn táidēng sànfā zhe wēnxīn róuhé de guāngmáng.',
      example_vi = 'Vào buổi tối khi làm bài tập, chiếc đèn bàn bảo vệ mắt ánh sáng êm dịu trên bàn học tỏa ra luồng sáng ấm áp nhẹ nhàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '台灯',
      'táidēng',
      'đèn bàn, đèn học để bàn',
      'Danh từ',
      'HSK 5',
      '夜晚做功课时，书桌上的柔光护眼台灯散发着温馨柔和的光芒。',
      'Yèwǎn zuò gōngkè shí, shūzhuō shang de róuguāng hùyǎn táidēng sànfā zhe wēnxīn róuhé de guāngmáng.',
      'Vào buổi tối khi làm bài tập, chiếc đèn bàn bảo vệ mắt ánh sáng êm dịu trên bàn học tỏa ra luồng sáng ấm áp nhẹ nhàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夜晚做功课时，书桌上的柔光护眼台灯散发着温馨柔和的光芒。', 'Yèwǎn zuò gōngkè shí, shūzhuō shang de róuguāng hùyǎn táidēng sànfā zhe wēnxīn róuhé de guāngmáng.', 'Vào buổi tối khi làm bài tập, chiếc đèn bàn bảo vệ mắt ánh sáng êm dịu trên bàn học tỏa ra luồng sáng ấm áp nhẹ nhàng.', 'basic', 1),
      (v_id, '新一代全光谱高显色指数智能护眼台灯深度结合人体昼夜节律算法，能自适应动态调节色温以最大程度保护青少年视力健康。', 'Xīn yí dài quán-guāngpǔ gāo-xiǎnsè zhǐshù zhìnéng hùyǎn táidēng shēndù jiéhé réntǐ zhòuyè jiélǜ suànfǎ, néng zìshìyìng dòngtài tiáojié sèwēn yǐ zuìdà chéngdù bǎohù qīng-shàonián shìlì jiànkāng.', 'Đèn bàn bảo vệ mắt thông minh chỉ số hoàn màu cao toàn quang phổ thế hệ mới kết hợp sâu sắc với thuật toán nhịp sinh học ngày đêm của cơ thể người, có thể tự thích ứng điều chỉnh động nhiệt độ màu nhằm bảo vệ tối đa sức khỏe thị lực của thanh thiếu niên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn tất cập nhật HSK 5 - Batch 11! Tổng số từ đã xử lý: %', v_count;
END $$;
