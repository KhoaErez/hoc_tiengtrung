-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 10 (100 TỪ TIẾP THEO)
-- Phạm vi: #2902 [全体] (quántǐ) -> #3001 [胜] (shèng)
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
  -- [2902] [全体] (quántǐ) - toàn thể, tất cả thành viên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '全体' AND pinyin = 'quántǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '全体' AND pinyin = 'quántǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '全体'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '全体'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'quántǐ',
      meaning_vi = 'toàn thể, tất cả thành viên',
      example_hanzi = '大会开幕时，全体与会代表起立齐唱国歌。',
      example_pinyin = 'Dàhuì kāimù shí, quántǐ yùhuì dàibiǎo qǐlì qíchàng guógē.',
      example_vi = 'Khi đại hội khai mạc, toàn thể đại biểu tham dự đứng dậy cùng hát vang quốc ca.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '全体',
      'quántǐ',
      'toàn thể, tất cả thành viên',
      'Danh từ',
      'HSK 5',
      '大会开幕时，全体与会代表起立齐唱国歌。',
      'Dàhuì kāimù shí, quántǐ yùhuì dàibiǎo qǐlì qíchàng guógē.',
      'Khi đại hội khai mạc, toàn thể đại biểu tham dự đứng dậy cùng hát vang quốc ca.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大会开幕时，全体与会代表起立齐唱国歌。', 'Dàhuì kāimù shí, quántǐ yùhuì dàibiǎo qǐlì qíchàng guógē.', 'Khi đại hội khai mạc, toàn thể đại biểu tham dự đứng dậy cùng hát vang quốc ca.', 'basic', 1),
      (v_id, '在全体研发人员夜以继日的协同攻关下，核心操作系统原型测试获得圆满成功。', 'Zài quántǐ yánfā rényuán yèyǐjìrì de xiétóng gōngguān xià, héxīn cāozuò xìtǒng yuánxíng cèshì huòdé yuánmǎn chénggōng.', 'Dưới nỗ lực hiệp đồng khắc phục khó khăn ngày đêm của toàn thể đội ngũ nghiên cứu phát triển, việc thử nghiệm nguyên mẫu hệ điều hành cốt lõi đã đạt thành công viên mãn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2903] [全新] (quánxīn) - hoàn toàn mới, mới toanh [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '全新' AND pinyin = 'quánxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '全新' AND pinyin = 'quánxīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '全新'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '全新'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'quánxīn',
      meaning_vi = 'hoàn toàn mới, mới toanh',
      example_hanzi = '新学期开始后，校园里呈现出一片全新而充满活力的气象。',
      example_pinyin = 'Xīn xuéqī kāishǐ hòu, xiàoyuán lǐ chéngxiàn chū yí piàn quánxīn ér chōngmǎn huólì de qìxiàng.',
      example_vi = 'Sau khi học kỳ mới bắt đầu, trong khuôn viên trường hiện lên một bầu không khí hoàn toàn mới và tràn đầy sức sống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '全新',
      'quánxīn',
      'hoàn toàn mới, mới toanh',
      'Tính từ',
      'HSK 5',
      '新学期开始后，校园里呈现出一片全新而充满活力的气象。',
      'Xīn xuéqī kāishǐ hòu, xiàoyuán lǐ chéngxiàn chū yí piàn quánxīn ér chōngmǎn huólì de qìxiàng.',
      'Sau khi học kỳ mới bắt đầu, trong khuôn viên trường hiện lên một bầu không khí hoàn toàn mới và tràn đầy sức sống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新学期开始后，校园里呈现出一片全新而充满活力的气象。', 'Xīn xuéqī kāishǐ hòu, xiàoyuán lǐ chéngxiàn chū yí piàn quánxīn ér chōngmǎn huólì de qìxiàng.', 'Sau khi học kỳ mới bắt đầu, trong khuôn viên trường hiện lên một bầu không khí hoàn toàn mới và tràn đầy sức sống.', 'basic', 1),
      (v_id, '企业依托自主前沿科技推出了全新一代智能化生产制造系统，大幅提升了产线柔性与运行能效。', 'Qǐyè yītuō zìzhǔ qiányán kējì tuīchū le quánxīn yí dài zhìnénghuà shēngchǎn zhìzào xìtǒng, dàfú tíshēng le chǎnxiàn róuxìng yǔ yùnxíng néngxiào.', 'Doanh nghiệp dựa vào khoa học công nghệ mũi nhọn tự chủ đã cho ra mắt hệ thống sản xuất chế tạo thông minh thế hệ hoàn toàn mới, nâng cao đáng kể độ linh hoạt và hiệu suất năng lượng của dây chuyền.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2904] [劝] (quàn) - khuyên bảo, can ngăn, khuyên giải [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '劝' AND pinyin = 'quàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '劝' AND pinyin = 'quàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '劝'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '劝'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'quàn',
      meaning_vi = 'khuyên bảo, can ngăn, khuyên giải',
      example_hanzi = '医生再三劝他戒烟戒酒，平时要多注意饮食健康。',
      example_pinyin = 'Yīshēng zàisān quàn tā jièyān-jièjiǔ, píngshí yào duō zhùyì yǐnshí jiànkāng.',
      example_vi = 'Bác sĩ nhiều lần khuyên anh ấy bỏ thuốc lá cai rượu bia, ngày thường nên chú ý ăn uống lành mạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '劝',
      'quàn',
      'khuyên bảo, can ngăn, khuyên giải',
      'Động từ',
      'HSK 5',
      '医生再三劝他戒烟戒酒，平时要多注意饮食健康。',
      'Yīshēng zàisān quàn tā jièyān-jièjiǔ, píngshí yào duō zhùyì yǐnshí jiànkāng.',
      'Bác sĩ nhiều lần khuyên anh ấy bỏ thuốc lá cai rượu bia, ngày thường nên chú ý ăn uống lành mạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医生再三劝他戒烟戒酒，平时要多注意饮食健康。', 'Yīshēng zàisān quàn tā jièyān-jièjiǔ, píngshí yào duō zhùyì yǐnshí jiànkāng.', 'Bác sĩ nhiều lần khuyên anh ấy bỏ thuốc lá cai rượu bia, ngày thường nên chú ý ăn uống lành mạnh.', 'basic', 1),
      (v_id, '面对情绪激动的争议双方，人民调解员以法释理、耐心规劝，最终促使双方握手言和达成和解。', 'Miànduì qíngxù jīdòng de zhēngyì shuāngfāng, rénmín tiáojiěyuán yǐ fǎ shì lǐ, nàixīn guīquàn, zuìzhōng cùshǐ shuāngfāng wòshǒu-yánhé dáchéng héjiě.', 'Đối mặt với đôi bên tranh chấp đang xúc động mất bình tĩnh, hòa giải viên nhân dân lấy luật giải thích lý lẽ, kiên nhẫn khuyên giải, cuối cùng thúc đẩy hai bên bắt tay làm hòa đạt được thỏa thuận giải quyết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2905] [缺乏] (quēfá) - thiếu thốn, thiếu hụt, không đủ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '缺乏' AND pinyin = 'quēfá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缺乏' AND pinyin = 'quēfá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '缺乏'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缺乏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'quēfá',
      meaning_vi = 'thiếu thốn, thiếu hụt, không đủ',
      example_hanzi = '长期缺乏体育锻炼会导致身体抵抗力明显下降。',
      example_pinyin = 'Chángqī quēfá tǐyù duànliàn huì dǎozhì shēntǐ dǐkànglì míngxiǎn xiàjiàng.',
      example_vi = 'Lâu ngày thiếu rèn luyện thể dục thể thao sẽ dẫn đến sức đề kháng của cơ thể sụt giảm rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '缺乏',
      'quēfá',
      'thiếu thốn, thiếu hụt, không đủ',
      'Động từ',
      'HSK 5',
      '长期缺乏体育锻炼会导致身体抵抗力明显下降。',
      'Chángqī quēfá tǐyù duànliàn huì dǎozhì shēntǐ dǐkànglì míngxiǎn xiàjiàng.',
      'Lâu ngày thiếu rèn luyện thể dục thể thao sẽ dẫn đến sức đề kháng của cơ thể sụt giảm rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长期缺乏体育锻炼会导致身体抵抗力明显下降。', 'Chángqī quēfá tǐyù duànliàn huì dǎozhì shēntǐ dǐkànglì míngxiǎn xiàjiàng.', 'Lâu ngày thiếu rèn luyện thể dục thể thao sẽ dẫn đến sức đề kháng của cơ thể sụt giảm rõ rệt.', 'basic', 1),
      (v_id, '部分初创科技企业虽有优秀创意，但因缺乏充足的资本积累与产业化落地经验而陷入成长困局。', 'Bùfen chūchuàng kējì qǐyè suī yǒu yōuxiù chuàngyì, dàn yīn quēfá chōngzú de zīběn jīlěi yǔ chǎnyèhuà luòdì jīngyàn ér xiànrù chéngzhǎng kùnjú.', 'Một số doanh nghiệp khởi nghiệp công nghệ tuy có ý tưởng sáng tạo tuyệt vời nhưng vì thiếu tích lũy nguồn vốn đầy đủ và thiếu kinh nghiệm triển khai sản xuất thực tế nên rơi vào bế tắc tăng trưởng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2906] [确保] (quèbǎo) - bảo đảm, chắc chắn, giữ gìn chắc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '确保' AND pinyin = 'quèbǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '确保' AND pinyin = 'quèbǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '确保'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '确保'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'quèbǎo',
      meaning_vi = 'bảo đảm, chắc chắn, giữ gìn chắc',
      example_hanzi = '学校食堂每天严格消毒餐具，确保广大师生的饮食卫生安全。',
      example_pinyin = 'Xuéxiào shítáng měitiān yángé xiāodú cānjù, quèbǎo guǎngdà shīshēng de yǐnshí wèishēng ānquán.',
      example_vi = 'Căng tin trường học mỗi ngày đều khử trùng nghiêm ngặt đồ dùng ăn uống, bảo đảm an toàn vệ sinh ăn uống cho đông đảo thầy trò.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '确保',
      'quèbǎo',
      'bảo đảm, chắc chắn, giữ gìn chắc',
      'Động từ',
      'HSK 5',
      '学校食堂每天严格消毒餐具，确保广大师生的饮食卫生安全。',
      'Xuéxiào shítáng měitiān yángé xiāodú cānjù, quèbǎo guǎngdà shīshēng de yǐnshí wèishēng ānquán.',
      'Căng tin trường học mỗi ngày đều khử trùng nghiêm ngặt đồ dùng ăn uống, bảo đảm an toàn vệ sinh ăn uống cho đông đảo thầy trò.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校食堂每天严格消毒餐具，确保广大师生的饮食卫生安全。', 'Xuéxiào shítáng měitiān yángé xiāodú cānjù, quèbǎo guǎngdà shīshēng de yǐnshí wèishēng ānquán.', 'Căng tin trường học mỗi ngày đều khử trùng nghiêm ngặt đồ dùng ăn uống, bảo đảm an toàn vệ sinh ăn uống cho đông đảo thầy trò.', 'basic', 1),
      (v_id, '水利工程指挥部科学调度沿线防洪枢纽与分洪通道，确保大江大河在特大暴雨汛期安澜无恙。', 'Shuǐlì gōngchéng zhǐhuībù kēxué diàodù yánxiàn fánghóng shūniǔ yǔ fēnhóng tōngdào, quèbǎo dàjiāng-dàhé zài tèdà bàoyǔ xùnqī ānlán-wúyàng.', 'Ban chỉ huy công trình thủy lợi điều tiết khoa học các đầu mối chống lũ và phân lũ dọc tuyến, bảo đảm các dòng sông lớn bình yên an toàn trong mùa lũ mưa bão đặc biệt nghiêm trọng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2907] [确定] (quèdìng) - xác định, khẳng định; chắc chắn [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '确定' AND pinyin = 'quèdìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '确定' AND pinyin = 'quèdìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '确定'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '确定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'quèdìng',
      meaning_vi = 'xác định, khẳng định; chắc chắn',
      example_hanzi = '经过多次协商，大家终于确定了周末集体出游的具体时间和路线。',
      example_pinyin = 'Jīngguò duō cì xiéshāng, dàjiā zhōngyú quèdìng le zhōumò jítǐ chūyóu de jùtǐ shíjiān hé lùxiàn.',
      example_vi = 'Sau nhiều lần bàn bạc, mọi người cuối cùng đã xác định được thời gian và tuyến đường cụ thể của chuyến đi chơi tập thể cuối tuần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '确定',
      'quèdìng',
      'xác định, khẳng định; chắc chắn',
      'Động từ / Tính từ',
      'HSK 5',
      '经过多次协商，大家终于确定了周末集体出游的具体时间和路线。',
      'Jīngguò duō cì xiéshāng, dàjiā zhōngyú quèdìng le zhōumò jítǐ chūyóu de jùtǐ shíjiān hé lùxiàn.',
      'Sau nhiều lần bàn bạc, mọi người cuối cùng đã xác định được thời gian và tuyến đường cụ thể của chuyến đi chơi tập thể cuối tuần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过多次协商，大家终于确定了周末集体出游的具体时间和路线。', 'Jīngguò duō cì xiéshāng, dàjiā zhōngyú quèdìng le zhōumò jítǐ chūyóu de jùtǐ shíjiān hé lùxiàn.', 'Sau nhiều lần bàn bạc, mọi người cuối cùng đã xác định được thời gian và tuyến đường cụ thể của chuyến đi chơi tập thể cuối tuần.', 'basic', 1),
      (v_id, '在制定新一轮城市综合交通总体规划前，专家组必须科学确定客流走廊与关键轨道交通骨干网络。', 'Zài zhìdìng xīn yì lún chéngshì zōnghé jiāotōng zǒngtǐ guīhuà qián, zhuānjiāzǔ bìxū kēxué quèdìng kèliú zǒuláng yǔ guānjiàn guǐdào jiāotōng gǔgàn wǎngluò.', 'Trước khi xây dựng quy hoạch tổng thể giao thông tích hợp đô thị vòng mới, tổ chuyên gia bắt buộc phải xác định một cách khoa học các hành lang luồng hành khách và mạng lưới đường sắt đô thị trục then chốt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2908] [确认] (quèrèn) - xác nhận, khẳng định lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '确认' AND pinyin = 'quèrèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '确认' AND pinyin = 'quèrèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '确认'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '确认'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'quèrèn',
      meaning_vi = 'xác nhận, khẳng định lại',
      example_hanzi = '网上支付成功后，手机屏幕上立即弹出了订单确认的提示信息。',
      example_pinyin = 'Wǎngshàng zhīfù chénggōng hòu, shǒujī píngmù shang lìjí tán chū le dìngdān quèrèn de tíshì xìnxī.',
      example_vi = 'Sau khi thanh toán trực tuyến thành công, màn hình điện thoại lập tức hiển thị thông tin nhắc nhở xác nhận đơn hàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '确认',
      'quèrèn',
      'xác nhận, khẳng định lại',
      'Động từ',
      'HSK 5',
      '网上支付成功后，手机屏幕上立即弹出了订单确认的提示信息。',
      'Wǎngshàng zhīfù chénggōng hòu, shǒujī píngmù shang lìjí tán chū le dìngdān quèrèn de tíshì xìnxī.',
      'Sau khi thanh toán trực tuyến thành công, màn hình điện thoại lập tức hiển thị thông tin nhắc nhở xác nhận đơn hàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '网上支付成功后，手机屏幕上立即弹出了订单确认的提示信息。', 'Wǎngshàng zhīfù chénggōng hòu, shǒujī píngmù shang lìjí tán chū le dìngdān quèrèn de tíshì xìnxī.', 'Sau khi thanh toán trực tuyến thành công, màn hình điện thoại lập tức hiển thị thông tin nhắc nhở xác nhận đơn hàng.', 'basic', 1),
      (v_id, '买卖双方授权代表签署书面交付清单，正式确认大型成套工业设备已按合同标准验收合格。', 'Mǎimài shuāngfāng shòuquán dàibiǎo qiānshǔ shūmiàn jiāofù qīngdān, zhèngshì quèrèn dàxíng chéngtào gōngyè shèbèi yǐ àn hétong biāozhǔn yànshōu hégé.', 'Đại diện được ủy quyền của hai bên mua bán đã ký biên bản bàn giao bằng văn bản, chính thức xác nhận toàn bộ thiết bị công nghiệp đồng bộ quy mô lớn đã được nghiệm thu đạt chuẩn theo hợp đồng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2909] [群] (qún) - bầy, đàn, nhóm, tốp [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '群' AND pinyin = 'qún'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '群' AND pinyin = 'qún'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '群'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '群'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'qún',
      meaning_vi = 'bầy, đàn, nhóm, tốp',
      example_hanzi = '蔚蓝的天空中飞过一群候鸟，朝着温暖的南方展翅翱翔。',
      example_pinyin = 'Wèilán de tiānkōng zhōng fēi guò yì qún hòuniǎo, cháozhe wēnnuǎn de nánfāng zhǎnchì áoxiáng.',
      example_vi = 'Trên bầu trời xanh biếc bay qua một đàn chim di cư, sải cánh bay lượn về phía phương Nam ấm áp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '群',
      'qún',
      'bầy, đàn, nhóm, tốp',
      'Lượng từ / Danh từ',
      'HSK 5',
      '蔚蓝的天空中飞过一群候鸟，朝着温暖的南方展翅翱翔。',
      'Wèilán de tiānkōng zhōng fēi guò yì qún hòuniǎo, cháozhe wēnnuǎn de nánfāng zhǎnchì áoxiáng.',
      'Trên bầu trời xanh biếc bay qua một đàn chim di cư, sải cánh bay lượn về phía phương Nam ấm áp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '蔚蓝的天空中飞过一群候鸟，朝着温暖的南方展翅翱翔。', 'Wèilán de tiānkōng zhōng fēi guò yì qún hòuniǎo, cháozhe wēnnuǎn de nánfāng zhǎnchì áoxiáng.', 'Trên bầu trời xanh biếc bay qua một đàn chim di cư, sải cánh bay lượn về phía phương Nam ấm áp.', 'basic', 1),
      (v_id, '围绕国家重点实验室建设高水平青年学者创新群，是加速前沿基础理论研究突破的重要组织范式。', 'Wéirào guójiā zhòngdiǎn shíyànshì jiànshè gāo-shuǐpíng qīngnián xuézhě chuàngxīn qún, shì jiāsù qiányán jīchǔ lǐlùn yánjiū tūpò de zhòngyào zǔzhī fànshì.', 'Xoay quanh việc xây dựng phòng thí nghiệm trọng điểm quốc gia để thiết lập nhóm học giả trẻ sáng tạo trình độ cao là chuẩn thức tổ chức quan trọng nhằm thúc đẩy đột phá nghiên cứu lý thuyết cơ bản mũi nhọn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2910] [群体] (qúntǐ) - quần thể, nhóm người, tập thể đối tượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '群体' AND pinyin = 'qúntǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '群体' AND pinyin = 'qúntǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '群体'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '群体'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'qúntǐ',
      meaning_vi = 'quần thể, nhóm người, tập thể đối tượng',
      example_hanzi = '关爱老年人群体和残障人士是衡量社会文明进步的重要尺度。',
      example_pinyin = 'Guān’ài lǎoniánrén qúntǐ hé cánzhàng rénshì shì héngliáng shèhuì wénmíng jìnbù de zhòngyào chǐdù.',
      example_vi = 'Quan tâm chăm sóc nhóm người cao tuổi và người khuyết tật là thước đo quan trọng để đánh giá sự tiến bộ văn minh của xã hội.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '群体',
      'qúntǐ',
      'quần thể, nhóm người, tập thể đối tượng',
      'Danh từ',
      'HSK 5',
      '关爱老年人群体和残障人士是衡量社会文明进步的重要尺度。',
      'Guān’ài lǎoniánrén qúntǐ hé cánzhàng rénshì shì héngliáng shèhuì wénmíng jìnbù de zhòngyào chǐdù.',
      'Quan tâm chăm sóc nhóm người cao tuổi và người khuyết tật là thước đo quan trọng để đánh giá sự tiến bộ văn minh của xã hội.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '关爱老年人群体和残障人士是衡量社会文明进步的重要尺度。', 'Guān’ài lǎoniánrén qúntǐ hé cánzhàng rénshì shì héngliáng shèhuì wénmíng jìnbù de zhòngyào chǐdù.', 'Quan tâm chăm sóc nhóm người cao tuổi và người khuyết tật là thước đo quan trọng để đánh giá sự tiến bộ văn minh của xã hội.', 'basic', 1),
      (v_id, '流行病学专家借助大数据轨迹分析，对特定易感人群群体开展靶向精准筛查与动态免疫保护。', 'Liúxíngbìngxué zhuānjiā jièzhù dà-shùjù guǐjì fēnxī, duì tèdìng yìgǎn rénqún qúntǐ kāizhǎn bǎxiàng jīngzhǔn shāichá yǔ dòngtài miǎnyì bǎohù.', 'Các chuyên gia dịch tễ học nhờ phân tích dấu vết dữ liệu lớn đã triển khai sàng lọc chính xác trúng đích và bảo vệ miễn dịch động đối với quần thể người có nguy cơ cảm nhiễm cao cụ thể.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2911] [燃烧] (ránshāo) - cháy, đốt cháy, bốc hỏa [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '燃烧' AND pinyin = 'ránshāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '燃烧' AND pinyin = 'ránshāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '燃烧'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '燃烧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'ránshāo',
      meaning_vi = 'cháy, đốt cháy, bốc hỏa',
      example_hanzi = '寒冷的冬夜里，壁炉中干柴烈火旺盛地燃烧着，给整间屋子带来了融融暖意。',
      example_pinyin = 'Hánlěng de dōngyè lǐ, bìlú zhōng gānchái-lièhuǒ wàngshèng de ránshāo zhe, gěi zhěng jiān wūzi dài lái le róngróng nuǎnyì.',
      example_vi = 'Trong đêm đông giá lạnh, củi khô trong lò sưởi bốc cháy bập bùng dữ dội, mang lại hơi ấm ngập tràn cho cả căn phòng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '燃烧',
      'ránshāo',
      'cháy, đốt cháy, bốc hỏa',
      'Động từ',
      'HSK 5',
      '寒冷的冬夜里，壁炉中干柴烈火旺盛地燃烧着，给整间屋子带来了融融暖意。',
      'Hánlěng de dōngyè lǐ, bìlú zhōng gānchái-lièhuǒ wàngshèng de ránshāo zhe, gěi zhěng jiān wūzi dài lái le róngróng nuǎnyì.',
      'Trong đêm đông giá lạnh, củi khô trong lò sưởi bốc cháy bập bùng dữ dội, mang lại hơi ấm ngập tràn cho cả căn phòng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '寒冷的冬夜里，壁炉中干柴烈火旺盛地燃烧着，给整间屋子带来了融融暖意。', 'Hánlěng de dōngyè lǐ, bìlú zhōng gānchái-lièhuǒ wàngshèng de ránshāo zhe, gěi zhěng jiān wūzi dài lái le róngróng nuǎnyì.', 'Trong đêm đông giá lạnh, củi khô trong lò sưởi bốc cháy bập bùng dữ dội, mang lại hơi ấm ngập tràn cho cả căn phòng.', 'basic', 1),
      (v_id, '新型重型运载火箭采用液氧煤油高压补燃循环发动机，实现了极佳的燃烧效率与超高推进推力。', 'Xīnxíng zhòngxíng yùnzài huǒjiàn cǎiyòng yèyǎng méiyóu gāoyā bǔrán xúnhuán fādòngjī, shíxiàn le jí jiā de ránshāo xiàolǜ yǔ chāo-gāo tuījìn tuīlì.', 'Tên lửa đẩy hạng nặng kiểu mới ứng dụng động cơ chu trình đốt bổ sung cao áp oxy lỏng - dầu hỏa, đạt được hiệu suất cháy cực tốt cùng lực đẩy phản lực siêu lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2912] [绕] (rào) - đi vòng, uốn lượn, quấn quanh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '绕' AND pinyin = 'rào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '绕' AND pinyin = 'rào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '绕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '绕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'rào',
      meaning_vi = 'đi vòng, uốn lượn, quấn quanh',
      example_hanzi = '前方路段正在施工维修，司机师傅只好驾驶汽车绕道而行。',
      example_pinyin = 'Qiánfāng lùduàn zhèngzài shīgōng wéixiū, sījī shīfu zhǐhǎo jiàshǐ qìchē ràodào ér xíng.',
      example_vi = 'Đoạn đường phía trước đang thi công sửa chữa, bác tài xế đành phải lái xe đi đường vòng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '绕',
      'rào',
      'đi vòng, uốn lượn, quấn quanh',
      'Động từ',
      'HSK 5',
      '前方路段正在施工维修，司机师傅只好驾驶汽车绕道而行。',
      'Qiánfāng lùduàn zhèngzài shīgōng wéixiū, sījī shīfu zhǐhǎo jiàshǐ qìchē ràodào ér xíng.',
      'Đoạn đường phía trước đang thi công sửa chữa, bác tài xế đành phải lái xe đi đường vòng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '前方路段正在施工维修，司机师傅只好驾驶汽车绕道而行。', 'Qiánfāng lùduàn zhèngzài shīgōng wéixiū, sījī shīfu zhǐhǎo jiàshǐ qìchē ràodào ér xíng.', 'Đoạn đường phía trước đang thi công sửa chữa, bác tài xế đành phải lái xe đi đường vòng.', 'basic', 1),
      (v_id, '月球探测器在完成变轨机动后，顺利进入距离月面一百公里的近圆形环月绕飞轨道运行。', 'Yuèqiú tàncèqì zài wánchéng biànguǐ jīdòng hòu, shùnlì jìnrù jùlí yuèmiàn yìbǎi gōnglǐ de jìn-yuánxíng huányuè ràofēi guǐdào yùnxíng.', 'Tàu thăm dò mặt trăng sau khi hoàn thành thao tác đổi quỹ đạo đã thuận lợi tiến vào vận hành trên quỹ đạo bay lượn quanh mặt trăng gần hình tròn cách bề mặt mặt trăng một trăm kilomet.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2913] [热爱] (rè’ài) - yêu tha thiết, nồng nhiệt yêu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '热爱' AND pinyin = 'rè’ài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '热爱' AND pinyin = 'rè’ài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '热爱'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '热爱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'rè’ài',
      meaning_vi = 'yêu tha thiết, nồng nhiệt yêu',
      example_hanzi = '他从小就非常热爱绘画，立志将来成为一名优秀的插画艺术家。',
      example_pinyin = 'Tā cóngxiǎo jiù fēicháng rè’ài huìhuà, lìzhì jiānglái chéngwéi yì míng yōuxiù de chāhuà yìshùjiā.',
      example_vi = 'Từ nhỏ anh ấy đã rất say mê hội họa, lập chí sau này trở thành một nghệ sĩ vẽ tranh minh họa xuất sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '热爱',
      'rè’ài',
      'yêu tha thiết, nồng nhiệt yêu',
      'Động từ',
      'HSK 5',
      '他从小就非常热爱绘画，立志将来成为一名优秀的插画艺术家。',
      'Tā cóngxiǎo jiù fēicháng rè’ài huìhuà, lìzhì jiānglái chéngwéi yì míng yōuxiù de chāhuà yìshùjiā.',
      'Từ nhỏ anh ấy đã rất say mê hội họa, lập chí sau này trở thành một nghệ sĩ vẽ tranh minh họa xuất sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他从小就非常热爱绘画，立志将来成为一名优秀的插画艺术家。', 'Tā cóngxiǎo jiù fēicháng rè’ài huìhuà, lìzhì jiānglái chéngwéi yì míng yōuxiù de chāhuà yìshùjiā.', 'Từ nhỏ anh ấy đã rất say mê hội họa, lập chí sau này trở thành một nghệ sĩ vẽ tranh minh họa xuất sắc.', 'basic', 1),
      (v_id, '无论面对多么艰苦卓绝的边远野外考察环境，老一辈地质学家始终深沉热爱着脚下辽阔的祖国山河。', 'Wúlùn miànduì duōme jiānkǔ-zhuójué de biānyuǎn yěwài kǎochá huánjìng, lǎoyíbèi dìzhìxuéjiā shǐzhōng shēnchén rè’ài zhe jiǎoxià liáokuò de zǔguó shānhé.', 'Bất luận phải đối mặt với môi trường khảo sát dã ngoại biên cương gian khổ khốc liệt đến mức nào, thế hệ các nhà địa chất đi trước vẫn luôn yêu thương sâu nặng từng tấc giang sơn gấm vóc dưới chân mình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2914] [热量] (rèliàng) - nhiệt lượng, lượng calo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '热量' AND pinyin = 'rèliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '热量' AND pinyin = 'rèliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '热量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '热量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rèliàng',
      meaning_vi = 'nhiệt lượng, lượng calo',
      example_hanzi = '油炸食品和含糖奶茶热量很高，经常食用容易导致身体发胖。',
      example_pinyin = 'Yóuzhá shípǐn hé hán táng nǎichá rèliàng hěn gāo, chángcháng shíyòng róngyì dǎozhì shēntǐ fāpàng.',
      example_vi = 'Đồ ăn chiên rán và trà sữa nhiều đường có lượng calo rất cao, thường xuyên ăn dùng dễ dẫn đến tăng cân béo phì.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '热量',
      'rèliàng',
      'nhiệt lượng, lượng calo',
      'Danh từ',
      'HSK 5',
      '油炸食品和含糖奶茶热量很高，经常食用容易导致身体发胖。',
      'Yóuzhá shípǐn hé hán táng nǎichá rèliàng hěn gāo, chángcháng shíyòng róngyì dǎozhì shēntǐ fāpàng.',
      'Đồ ăn chiên rán và trà sữa nhiều đường có lượng calo rất cao, thường xuyên ăn dùng dễ dẫn đến tăng cân béo phì.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '油炸食品和含糖奶茶热量很高，经常食用容易导致身体发胖。', 'Yóuzhá shípǐn hé hán táng nǎichá rèliàng hěn gāo, chángcháng shíyòng róngyì dǎozhì shēntǐ fāpàng.', 'Đồ ăn chiên rán và trà sữa nhiều đường có lượng calo rất cao, thường xuyên ăn dùng dễ dẫn đến tăng cân béo phì.', 'basic', 1),
      (v_id, '在工业热工水力系统中，精准计算流体传热系数与核心热量耗散速率是优化反应堆安全边界的前提。', 'Zài gōngyè règōng shuǐlì xìtǒng zhōng, jīngzhǔn jìsuàn liútǐ chuánrè xìshù yǔ héxīn rèliàng hàosàn sùlǜ shì yōuhuà fǎnyìngduī ānquán biānjiè de qiántí.', 'Trong hệ thống nhiệt thủy lực công nghiệp, việc tính toán chuẩn xác hệ số truyền nhiệt chất lưu và tốc độ tiêu tán nhiệt lượng vùng lõi là tiền đề để tối ưu hóa ranh giới an toàn của lò phản ứng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2915] [热烈] (rèliè) - nhiệt liệt, sôi nổi, nồng nhiệt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '热烈' AND pinyin = 'rèliè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '热烈' AND pinyin = 'rèliè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '热烈'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '热烈'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'rèliè',
      meaning_vi = 'nhiệt liệt, sôi nổi, nồng nhiệt',
      example_hanzi = '精彩的杂技表演刚一结束，台下就响起了经久不息的热烈掌声。',
      example_pinyin = 'Jīngcǎi de zájì biǎoyǎn gāng yì jiéshù, tái xià jiù xiǎng qǐ le jīngjiǔ-bùxī de rèliè zhǎngshēng.',
      example_vi = 'Tiết mục xiếc đặc sắc vừa kết thúc, dưới khán đài liền vang lên tràng pháo tay nhiệt liệt kéo dài không ngớt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '热烈',
      'rèliè',
      'nhiệt liệt, sôi nổi, nồng nhiệt',
      'Tính từ',
      'HSK 5',
      '精彩的杂技表演刚一结束，台下就响起了经久不息的热烈掌声。',
      'Jīngcǎi de zájì biǎoyǎn gāng yì jiéshù, tái xià jiù xiǎng qǐ le jīngjiǔ-bùxī de rèliè zhǎngshēng.',
      'Tiết mục xiếc đặc sắc vừa kết thúc, dưới khán đài liền vang lên tràng pháo tay nhiệt liệt kéo dài không ngớt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '精彩的杂技表演刚一结束，台下就响起了经久不息的热烈掌声。', 'Jīngcǎi de zájì biǎoyǎn gāng yì jiéshù, tái xià jiù xiǎng qǐ le jīngjiǔ-bùxī de rèliè zhǎngshēng.', 'Tiết mục xiếc đặc sắc vừa kết thúc, dưới khán đài liền vang lên tràng pháo tay nhiệt liệt kéo dài không ngớt.', 'basic', 1),
      (v_id, '围绕人工智能伦理治理新准则，来自全球法学界与科技产业界的青年领军学者展开了异常热烈的圆桌辩论。', 'Wéirào réngōng zhìnéng lúnlǐ zhìlǐ xīn zhǔnzé, láizì quánqiú fǎxuéjiè yǔ kējì chǎnyèjiè de qīngnián lǐngjūn xuézhě zhǎnkāi le yìcháng rèliè de yuánzhuō biànlùn.', 'Xoay quanh chuẩn tắc quản trị đạo đức trí tuệ nhân tạo mới, các học giả trẻ dẫn đầu đến từ giới luật học và công nghiệp công nghệ toàn cầu đã triển khai cuộc tranh biện bàn tròn hết sức sôi nổi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2916] [热心] (rèxīn) - nhiệt tình, sốt sắng, hăng hái [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '热心' AND pinyin = 'rèxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '热心' AND pinyin = 'rèxīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '热心'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '热心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'rèxīn',
      meaning_vi = 'nhiệt tình, sốt sắng, hăng hái',
      example_hanzi = '邻居王阿姨平时非常热心，总是主动帮社区孤寡老人买菜送药。',
      example_pinyin = 'Línjū Wáng āyí píngshí fēicháng rèxīn, zǒngshì zhǔdòng bāng shèqū gūguǎ lǎorén mǎi cài sòng yào.',
      example_vi = 'Bác Vương hàng xóm ngày thường rất nhiệt tình, luôn chủ động giúp đỡ người già neo đơn trong khu phố đi chợ mua rau mua thuốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '热心',
      'rèxīn',
      'nhiệt tình, sốt sắng, hăng hái',
      'Tính từ',
      'HSK 5',
      '邻居王阿姨平时非常热心，总是主动帮社区孤寡老人买菜送药。',
      'Línjū Wáng āyí píngshí fēicháng rèxīn, zǒngshì zhǔdòng bāng shèqū gūguǎ lǎorén mǎi cài sòng yào.',
      'Bác Vương hàng xóm ngày thường rất nhiệt tình, luôn chủ động giúp đỡ người già neo đơn trong khu phố đi chợ mua rau mua thuốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '邻居王阿姨平时非常热心，总是主动帮社区孤寡老人买菜送药。', 'Línjū Wáng āyí píngshí fēicháng rèxīn, zǒngshì zhǔdòng bāng shèqū gūguǎ lǎorén mǎi cài sòng yào.', 'Bác Vương hàng xóm ngày thường rất nhiệt tình, luôn chủ động giúp đỡ người già neo đơn trong khu phố đi chợ mua rau mua thuốc.', 'basic', 1),
      (v_id, '广大热心公益的爱心志愿者队伍风雨无阻深入偏远山区，为农村留守儿童带去温暖关爱与丰富多彩的书籍文具。', 'Guǎngdà rèxīn gōngyì de àixīn zhìyuànzhě duìwu fēngyǔ-wúzǔ shēnrù piānyuǎn shāncūn, wèi nóngcūn liúshǒu értóng dài qù wēnnuǎn guān’ài yǔ fēngfù-duōcǎi de shūjí wénjù.', 'Đội ngũ tình nguyện viên giàu lòng nhân ái nhiệt tình với các hoạt động thiện nguyện không quản mưa nắng đi sâu vào các vùng núi hẻo lánh, mang tới tình yêu thương ấm áp cùng sách vở đồ dùng học tập phong phú cho trẻ em nông thôn xa cha mẹ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2917] [人才] (réncái) - nhân tài, người tài giỏi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人才' AND pinyin = 'réncái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人才' AND pinyin = 'réncái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人才'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人才'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'réncái',
      meaning_vi = 'nhân tài, người tài giỏi',
      example_hanzi = '一流大学不仅要传授专业知识，更要努力为国家培养各行各业的栋梁人才。',
      example_pinyin = 'Yīliú dàxué bùjǐn yào chuánshòu zhuānyè zhīshi, gèng yào nǔlì wèi guójiā péiyǎng gè háng gè yè de dòngliáng réncái.',
      example_vi = 'Trường đại học hàng đầu không chỉ cần truyền thụ kiến thức chuyên môn mà còn phải nỗ lực đào tạo những nhân tài rường cột cho mọi ngành nghề của đất nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人才',
      'réncái',
      'nhân tài, người tài giỏi',
      'Danh từ',
      'HSK 5',
      '一流大学不仅要传授专业知识，更要努力为国家培养各行各业的栋梁人才。',
      'Yīliú dàxué bùjǐn yào chuánshòu zhuānyè zhīshi, gèng yào nǔlì wèi guójiā péiyǎng gè háng gè yè de dòngliáng réncái.',
      'Trường đại học hàng đầu không chỉ cần truyền thụ kiến thức chuyên môn mà còn phải nỗ lực đào tạo những nhân tài rường cột cho mọi ngành nghề của đất nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一流大学不仅要传授专业知识，更要努力为国家培养各行各业的栋梁人才。', 'Yīliú dàxué bùjǐn yào chuánshòu zhuānyè zhīshi, gèng yào nǔlì wèi guójiā péiyǎng gè háng gè yè de dòngliáng réncái.', 'Trường đại học hàng đầu không chỉ cần truyền thụ kiến thức chuyên môn mà còn phải nỗ lực đào tạo những nhân tài rường cột cho mọi ngành nghề của đất nước.', 'basic', 1),
      (v_id, '高新技术产业开发区实施更加开放包容的全球引才引智战略，着力构筑具有国际竞争力的高素质科研人才集聚高地。', 'Gāoxīn jìshù chǎnyè kāifāqū shíshī gèngjiā kāifàng bāoróng de quánqiú yǐncái yǐnzhì zhànlüè, zhuólì gòuzhù jùyǒu guójì jìngzhēnglì de gāo-sùzhì kēyán réncái jíjù gāodì.', 'Khu công nghiệp kỹ thuật cao triển khai chiến lược thu hút nhân tài và trí tuệ toàn cầu cởi mở và bao dung hơn, tập trung xây dựng mảnh đất màu mỡ tập hợp nhân tài nghiên cứu khoa học chất lượng cao có sức cạnh tranh quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2918] [人工] (réngōng) - nhân tạo, làm thủ công, công thợ [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人工' AND pinyin = 'réngōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人工' AND pinyin = 'réngōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人工'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人工'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'réngōng',
      meaning_vi = 'nhân tạo, làm thủ công, công thợ',
      example_hanzi = '公园中心有一个清澈美丽的人工湖，周围环绕着垂柳与鹅卵石步道。',
      example_pinyin = 'Gōngyuán zhōngxīn yǒu yí ge qīngchè měilì de réngōnghú, zhōuwéi huánrào zhe chuíliǔ yǔ éluǎnshí bùdào.',
      example_vi = 'Trung tâm công viên có một hồ nước nhân tạo trong lành xinh đẹp, xung quanh có rặng liễu rủ và lối đi lát đá cuội bao quanh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人工',
      'réngōng',
      'nhân tạo, làm thủ công, công thợ',
      'Tính từ / Danh từ',
      'HSK 5',
      '公园中心有一个清澈美丽的人工湖，周围环绕着垂柳与鹅卵石步道。',
      'Gōngyuán zhōngxīn yǒu yí ge qīngchè měilì de réngōnghú, zhōuwéi huánrào zhe chuíliǔ yǔ éluǎnshí bùdào.',
      'Trung tâm công viên có một hồ nước nhân tạo trong lành xinh đẹp, xung quanh có rặng liễu rủ và lối đi lát đá cuội bao quanh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '公园中心有一个清澈美丽的人工湖，周围环绕着垂柳与鹅卵石步道。', 'Gōngyuán zhōngxīn yǒu yí ge qīngchè měilì de réngōnghú, zhōuwéi huánrào zhe chuíliǔ yǔ éluǎnshí bùdào.', 'Trung tâm công viên có một hồ nước nhân tạo trong lành xinh đẹp, xung quanh có rặng liễu rủ và lối đi lát đá cuội bao quanh.', 'basic', 1),
      (v_id, '将生成式人工智能算法与高端工业机器人相结合，正促使传统流水线生产迈向高度自适应智能作业。', 'Jiāng shēngchéngxìng réngōng zhìnéng suànfǎ yǔ gāoduān gōngyè jīqìrén xiāng jiéhé, zhèng cùshǐ chuántǒng liúshuǐxiàn shēngchǎn mài xiàng gāodù zìshìyìng zhìnéng zuòyè.', 'Việc kết hợp thuật toán trí tuệ nhân tạo tạo sinh với robot công nghiệp cao cấp đang thúc đẩy sản xuất dây chuyền truyền thống tiến bước tới vận hành thông minh có khả năng tự thích ứng cao độ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2919] [人际] (rénjì) - giữa người với người, giao tế, nhân tế [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人际' AND pinyin = 'rénjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人际' AND pinyin = 'rénjì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人际'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人际'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'rénjì',
      meaning_vi = 'giữa người với người, giao tế, nhân tế',
      example_hanzi = '初入职场的年轻人除了提升专业技能，还要学会处理好良好的人际关系。',
      example_pinyin = 'Chū rù zhíchǎng de niánqīngrén chúle tíshēng zhuānyè jìnéng, hái yào xuéhuì chǔlǐ hǎo liánghǎo de rénjì guānxì.',
      example_vi = 'Người trẻ tuổi mới bước chân vào nơi làm việc ngoài nâng cao kỹ năng chuyên môn còn phải học cách xử lý tốt các mối quan hệ giao tiếp nhân tế lành mạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人际',
      'rénjì',
      'giữa người với người, giao tế, nhân tế',
      'Tính từ',
      'HSK 5',
      '初入职场的年轻人除了提升专业技能，还要学会处理好良好的人际关系。',
      'Chū rù zhíchǎng de niánqīngrén chúle tíshēng zhuānyè jìnéng, hái yào xuéhuì chǔlǐ hǎo liánghǎo de rénjì guānxì.',
      'Người trẻ tuổi mới bước chân vào nơi làm việc ngoài nâng cao kỹ năng chuyên môn còn phải học cách xử lý tốt các mối quan hệ giao tiếp nhân tế lành mạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '初入职场的年轻人除了提升专业技能，还要学会处理好良好的人际关系。', 'Chū rù zhíchǎng de niánqīngrén chúle tíshēng zhuānyè jìnéng, hái yào xuéhuì chǔlǐ hǎo liánghǎo de rénjì guānxì.', 'Người trẻ tuổi mới bước chân vào nơi làm việc ngoài nâng cao kỹ năng chuyên môn còn phải học cách xử lý tốt các mối quan hệ giao tiếp nhân tế lành mạnh.', 'basic', 1),
      (v_id, '跨文化沟通能力与人际同理心，已成为全球化跨国企业高管团队领导力模型中的核心考核指标。', 'Kuà-wénhuà gōutōng nénglì yǔ rénjì tónglǐxīn, yǐ chéngwéi quánqiúhuà kuàguó qǐyè gāoguǎn tuánduì lǐngdǎolì móxíng zhōng de héxīn kǎohé zhǐbiāo.', 'Năng lực giao tiếp liên văn hóa và sự thấu cảm trong quan hệ giữa các cá nhân đã trở thành chỉ số đánh giá cốt lõi trong mô hình năng lực lãnh đạo đội ngũ quản trị cấp cao tại các tập đoàn đa quốc gia toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2920] [人口] (rénkǒu) - dân số, số dân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人口' AND pinyin = 'rénkǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人口' AND pinyin = 'rénkǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人口'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人口'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rénkǒu',
      meaning_vi = 'dân số, số dân',
      example_hanzi = '随着城市经济的繁荣发展，该地区常住人口近年来呈现平稳增长态势。',
      example_pinyin = 'Suízhe chéngshì jīngjì de fánróng fāzhǎn, gāi dìqū chángzhù rénkǒu jìnniánlái chéngxiàn píngwěn zēngzhǎng tàishì.',
      example_vi = 'Cùng với sự phát triển phồn vinh của kinh tế đô thị, dân số thường trú của khu vực này những năm gần đây có chiều hướng tăng trưởng vững chắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人口',
      'rénkǒu',
      'dân số, số dân',
      'Danh từ',
      'HSK 5',
      '随着城市经济的繁荣发展，该地区常住人口近年来呈现平稳增长态势。',
      'Suízhe chéngshì jīngjì de fánróng fāzhǎn, gāi dìqū chángzhù rénkǒu jìnniánlái chéngxiàn píngwěn zēngzhǎng tàishì.',
      'Cùng với sự phát triển phồn vinh của kinh tế đô thị, dân số thường trú của khu vực này những năm gần đây có chiều hướng tăng trưởng vững chắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着城市经济的繁荣发展，该地区常住人口近年来呈现平稳增长态势。', 'Suízhe chéngshì jīngjì de fánróng fāzhǎn, gāi dìqū chángzhù rénkǒu jìnniánlái chéngxiàn píngwěn zēngzhǎng tàishì.', 'Cùng với sự phát triển phồn vinh của kinh tế đô thị, dân số thường trú của khu vực này những năm gần đây có chiều hướng tăng trưởng vững chắc.', 'basic', 1),
      (v_id, '积极应对人口深度老龄化国家战略要求全面构建多层次养老保障体系，推动实现人口高质量发展。', 'Jījí yìngduì rénkǒu shēndù lǎolínghuà guójiā zhànlüè yāoqiú quánmiàn gòujiàn duō-céngcì yǎnglǎo bǎozhàng tǐxì, tuīdòng shíxiàn rénkǒu gāo-zhìliàng fāzhǎn.', 'Chiến lược quốc gia tích cực ứng phó tình trạng dân số già hóa sâu sắc đòi hỏi phải xây dựng toàn diện hệ thống an sinh dưỡng lão đa tầng nấc, thúc đẩy thực hiện phát triển dân số chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2921] [人类] (rénlèi) - nhân loại, loài người [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人类' AND pinyin = 'rénlèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人类' AND pinyin = 'rénlèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人类'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人类'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rénlèi',
      meaning_vi = 'nhân loại, loài người',
      example_hanzi = '保护地球生态环境，是全人类共同的责任与义务。',
      example_pinyin = 'Bǎohù Dìqiú shēngtài huánjìng, shì quán rénlèi gòngtóng de zérèn yǔ yìwù.',
      example_vi = 'Bảo vệ môi trường sinh thái Trái Đất là trách nhiệm và nghĩa vụ chung của toàn thể nhân loại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人类',
      'rénlèi',
      'nhân loại, loài người',
      'Danh từ',
      'HSK 5',
      '保护地球生态环境，是全人类共同的责任与义务。',
      'Bǎohù Dìqiú shēngtài huánjìng, shì quán rénlèi gòngtóng de zérèn yǔ yìwù.',
      'Bảo vệ môi trường sinh thái Trái Đất là trách nhiệm và nghĩa vụ chung của toàn thể nhân loại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '保护地球生态环境，是全人类共同的责任与义务。', 'Bǎohù Dìqiú shēngtài huánjìng, shì quán rénlèi gòngtóng de zérèn yǔ yìwù.', 'Bảo vệ môi trường sinh thái Trái Đất là trách nhiệm và nghĩa vụ chung của toàn thể nhân loại.', 'basic', 1),
      (v_id, '深空深海探测不仅拓展了人类对未知宇宙物理规律的科学认知，而且促进了跨代际前沿尖端工程技术的集成突破。', 'Shēnkōng shēnhǎi tàncè bùjǐn tuòzhǎn le rénlèi duì wèizhī yǔzhòu wùlǐ guīlǜ de kēxué rènzhī, érqiě cùjìn le kuà-dàijì qiányán jiānduān gōngchéng jìshù de jíchéng tūpò.', 'Thám hiểm không gian sâu và biển sâu không chỉ mở rộng nhận thức khoa học của nhân loại về các quy luật vật lý vũ trụ chưa biết mà còn thúc đẩy đột phá tích hợp công nghệ kỹ thuật tiên tiến vượt thế hệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2922] [人力] (rénlì) - nhân lực, sức người, nguồn nhân lực [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人力' AND pinyin = 'rénlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人力' AND pinyin = 'rénlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rénlì',
      meaning_vi = 'nhân lực, sức người, nguồn nhân lực',
      example_hanzi = '为了确保大桥工程如期完工，施工单位紧急调配了充足的人力和物资。',
      example_pinyin = 'Wèile quèbǎo dàqiáo gōngchéng rúqī wángōng, shīgōng dānwèi jǐnjí diàopèi le chōngzú de rénlì yǔ wùzī.',
      example_vi = 'Để bảo đảm công trình cầu lớn hoàn thành đúng hạn, đơn vị thi công đã khẩn cấp điều phối đầy đủ nhân lực và vật tư.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人力',
      'rénlì',
      'nhân lực, sức người, nguồn nhân lực',
      'Danh từ',
      'HSK 5',
      '为了确保大桥工程如期完工，施工单位紧急调配了充足的人力和物资。',
      'Wèile quèbǎo dàqiáo gōngchéng rúqī wángōng, shīgōng dānwèi jǐnjí diàopèi le chōngzú de rénlì yǔ wùzī.',
      'Để bảo đảm công trình cầu lớn hoàn thành đúng hạn, đơn vị thi công đã khẩn cấp điều phối đầy đủ nhân lực và vật tư.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了确保大桥工程如期完工，施工单位紧急调配了充足的人力和物资。', 'Wèile quèbǎo dàqiáo gōngchéng rúqī wángōng, shīgōng dānwèi jǐnjí diàopèi le chōngzú de rénlì yǔ wùzī.', 'Để bảo đảm công trình cầu lớn hoàn thành đúng hạn, đơn vị thi công đã khẩn cấp điều phối đầy đủ nhân lực và vật tư.', 'basic', 1),
      (v_id, '人力资本投资是推动全要素生产率持续提升的核心源泉，必须加大对基础教育和终身职业技能培训的公共投入。', 'Rénlì zīběn tóuzī shì tuīdòng quán-yàosù shēngchǎnlǜ chíxù tíshēng de héxīn yuánquán, bìxū jiàdà duì jīchǔ jiàoyù hé zhōngshēn zhíyè jìnéng péixùn de gōnggòng tóurù.', 'Đầu tư nguồn vốn nhân lực là ngọn nguồn cốt lõi thúc đẩy năng suất nhân tố tổng hợp tăng trưởng bền vững, bắt buộc phải tăng cường đầu tư công vào giáo dục cơ sở và đào tạo kỹ năng nghề trọn đời.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2923] [人民] (rénmín) - nhân dân, người dân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人民' AND pinyin = 'rénmín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人民' AND pinyin = 'rénmín'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人民'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人民'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rénmín',
      meaning_vi = 'nhân dân, người dân',
      example_hanzi = '一切工作的出发点和落脚点，都是为了实现好、维护好人民的切身利益。',
      example_pinyin = 'Yíqiè gōngzuò de chūfādiǎn hé luòjiǎodiǎn, dōu shì wèile shíxiàn hǎo, wéihù hǎo rénmín de qièshēn lìyì.',
      example_vi = 'Điểm xuất phát và đích đến của mọi công tác đều là vì thực hiện tốt và bảo vệ tốt lợi ích thiết thân của nhân dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人民',
      'rénmín',
      'nhân dân, người dân',
      'Danh từ',
      'HSK 5',
      '一切工作的出发点和落脚点，都是为了实现好、维护好人民的切身利益。',
      'Yíqiè gōngzuò de chūfādiǎn hé luòjiǎodiǎn, dōu shì wèile shíxiàn hǎo, wéihù hǎo rénmín de qièshēn lìyì.',
      'Điểm xuất phát và đích đến của mọi công tác đều là vì thực hiện tốt và bảo vệ tốt lợi ích thiết thân của nhân dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一切工作的出发点和落脚点，都是为了实现好、维护好人民的切身利益。', 'Yíqiè gōngzuò de chūfādiǎn hé luòjiǎodiǎn, dōu shì wèile shíxiàn hǎo, wéihù hǎo rénmín de qièshēn lìyì.', 'Điểm xuất phát và đích đến của mọi công tác đều là vì thực hiện tốt và bảo vệ tốt lợi ích thiết thân của nhân dân.', 'basic', 1),
      (v_id, '坚持以人民为中心的发展思想，着力解决好人民群众在就业、教育、医疗等关键领域的急难愁盼问题。', 'Jiānchí yǐ rénmín wéi zhōngxīn de fāzhǎn sīxiǎng, zhuólì jiějué hǎo rénmín qúnzhòng zài jiùyè, jiàoyù, yīliáo děng guānjiàn lǐngyù de jínán-chóupàn wèntí.', 'Kiên trì tư tưởng phát triển lấy nhân dân làm trung tâm, tập trung giải quyết thỏa đáng các vấn đề cấp bách thiết thân nhất của quần chúng nhân dân trong các lĩnh vực then chốt như việc làm, giáo dục và y tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2924] [人民币] (rénmínbì) - đồng Nhân dân tệ (RMB) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人民币' AND pinyin = 'rénmínbì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人民币' AND pinyin = 'rénmínbì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人民币'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人民币'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rénmínbì',
      meaning_vi = 'đồng Nhân dân tệ (RMB)',
      example_hanzi = '外国游客到达机场后，可以在外币兑换窗口将美元兑换成人民币。',
      example_pinyin = 'Wàiguó yóukè dàodá jīchǎng hòu, kěyǐ zài wàibì duìhuàn chuāngkǒu jiāng měiyuán duìhuàn chéng rénmínbì.',
      example_vi = 'Du khách nước ngoài sau khi tới sân bay có thể đổi đồng đô la Mỹ sang đồng Nhân dân tệ tại quầy đổi ngoại tệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人民币',
      'rénmínbì',
      'đồng Nhân dân tệ (RMB)',
      'Danh từ',
      'HSK 5',
      '外国游客到达机场后，可以在外币兑换窗口将美元兑换成人民币。',
      'Wàiguó yóukè dàodá jīchǎng hòu, kěyǐ zài wàibì duìhuàn chuāngkǒu jiāng měiyuán duìhuàn chéng rénmínbì.',
      'Du khách nước ngoài sau khi tới sân bay có thể đổi đồng đô la Mỹ sang đồng Nhân dân tệ tại quầy đổi ngoại tệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '外国游客到达机场后，可以在外币兑换窗口将美元兑换成人民币。', 'Wàiguó yóukè dàodá jīchǎng hòu, kěyǐ zài wàibì duìhuàn chuāngkǒu jiāng měiyuán duìhuàn chéng rénmínbì.', 'Du khách nước ngoài sau khi tới sân bay có thể đổi đồng đô la Mỹ sang đồng Nhân dân tệ tại quầy đổi ngoại tệ.', 'basic', 1),
      (v_id, '有序推进人民币跨境支付系统建设与多边双边本币互换，稳慎扎实提升人民币国际储备与贸易结算份额。', 'Yǒuxù tuījìn Rénmínbì kuàjìng zhīfù xìtǒng jiànshè yǔ duōbiān shuāngbiān běnbì hùhuàn, wěnshèn zhāshi tíshēng Rénmínbì guójì chǔbèi yǔ màoyì jiésuàn fèn’é.', 'Thúc đẩy có trật tự việc xây dựng hệ thống thanh toán xuyên biên giới bằng đồng Nhân dân tệ và hoán đổi đồng bản tệ đa phương song phương, nâng cao một cách vững chắc thận trọng tỷ trọng dự trữ quốc tế và quyết toán thương mại của đồng Nhân dân tệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2925] [人群] (rénqún) - đám đông, dòng người, nhóm người [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人群' AND pinyin = 'rénqún'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人群' AND pinyin = 'rénqún'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人群'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人群'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rénqún',
      meaning_vi = 'đám đông, dòng người, nhóm người',
      example_hanzi = '节日期间的步行街上张灯结彩，熙熙攘攘的人群川流不息。',
      example_pinyin = 'Jiérì qījiān de bùxíngjiē shang zhāngdēng-jiécǎi, xīxī-rǎngrǎng de rénqún chuānliú-bùxī.',
      example_vi = 'Phố đi bộ trong dịp lễ hội giăng đèn kết hoa, dòng người tấp nập nhộn nhịp đi lại không ngớt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人群',
      'rénqún',
      'đám đông, dòng người, nhóm người',
      'Danh từ',
      'HSK 5',
      '节日期间的步行街上张灯结彩，熙熙攘攘的人群川流不息。',
      'Jiérì qījiān de bùxíngjiē shang zhāngdēng-jiécǎi, xīxī-rǎngrǎng de rénqún chuānliú-bùxī.',
      'Phố đi bộ trong dịp lễ hội giăng đèn kết hoa, dòng người tấp nập nhộn nhịp đi lại không ngớt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '节日期间的步行街上张灯结彩，熙熙攘攘的人群川流不息。', 'Jiérì qījiān de bùxíngjiē shang zhāngdēng-jiécǎi, xīxī-rǎngrǎng de rénqún chuānliú-bùxī.', 'Phố đi bộ trong dịp lễ hội giăng đèn kết hoa, dòng người tấp nập nhộn nhịp đi lại không ngớt.', 'basic', 1),
      (v_id, '大型交通枢纽安装了高精度智能客流疏导感知系统，防止节假日极端高峰时段发生危险的人群拥挤踩踏事故。', 'Dàxíng jiāotōng shūniǔ ānzhuāng le gāo-jīngdù zhìnéng kèliú shūdǎo gǎnzhī xìtǒng, fángzhǐ jiéjiàrì jíduān gāofēng shíduàn fāshēng wēixiǎn de rénqún yōngjǐ cǎità shìgù.', 'Đầu mối giao thông quy mô lớn đã lắp đặt hệ thống cảm biến phân luồng hành khách thông minh độ chính xác cao nhằm ngăn ngừa sự cố chen lấn giẫm đạp đám đông nguy hiểm trong các khung giờ cao điểm cực độ của kỳ nghỉ lễ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2926] [人体] (réntǐ) - cơ thể người, thân thể người [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人体' AND pinyin = 'réntǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人体' AND pinyin = 'réntǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人体'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人体'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'réntǐ',
      meaning_vi = 'cơ thể người, thân thể người',
      example_hanzi = '水约占成年人体重的百分之六十到七十，是维持生命不可或缺的成分。',
      example_pinyin = 'Shuǐ yuē zhàn chéngnián réntǐ zhòng de bǎifēnzhī liùshí dào qīshí, shì wéichí shēngmìng bùkě huòquē de chéngfèn.',
      example_vi = 'Nước chiếm khoảng 60% đến 70% trọng lượng cơ thể người trưởng thành, là thành phần không thể thiếu để duy trì sự sống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人体',
      'réntǐ',
      'cơ thể người, thân thể người',
      'Danh từ',
      'HSK 5',
      '水约占成年人体重的百分之六十到七十，是维持生命不可或缺的成分。',
      'Shuǐ yuē zhàn chéngnián réntǐ zhòng de bǎifēnzhī liùshí dào qīshí, shì wéichí shēngmìng bùkě huòquē de chéngfèn.',
      'Nước chiếm khoảng 60% đến 70% trọng lượng cơ thể người trưởng thành, là thành phần không thể thiếu để duy trì sự sống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '水约占成年人体重的百分之六十到七十，是维持生命不可或缺的成分。', 'Shuǐ yuē zhàn chéngnián réntǐ zhòng de bǎifēnzhī liùshí dào qīshí, shì wéichí shēngmìng bùkě huòquē de chéngfèn.', 'Nước chiếm khoảng 60% đến 70% trọng lượng cơ thể người trưởng thành, là thành phần không thể thiếu để duy trì sự sống.', 'basic', 1),
      (v_id, '生物医用植入材料必须经过严格的生物相容性与降解代谢毒理学评价，确保对人体组织无任何排异与潜在致畸危害。', 'Shēngwù yīyòng zhírù cáiliào bìxū jīngguò yángé de shēngwù xiāngróngxìng yǔ jiàngjiě dàixiè dúlǐxué píngjià, quèbǎo duì réntǐ zǔzhī wú rènhé páiyì yǔ qiánzài zhìjī wēihài.', 'Vật liệu cấy ghép y sinh bắt buộc phải trải qua đánh giá độc chất học thoái hóa trao đổi chất và tương thích sinh học nghiêm ngặt, bảo đảm không có bất kỳ phản ứng thải ghép hay nguy hại tiềm ẩn gây dị tật nào đối với các mô của cơ thể người.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2927] [人物] (rénwù) - nhân vật (tiểu thuyết, lịch sử), nhân sĩ tiêu biểu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '人物' AND pinyin = 'rénwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人物' AND pinyin = 'rénwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '人物'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '人物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rénwù',
      meaning_vi = 'nhân vật (tiểu thuyết, lịch sử), nhân sĩ tiêu biểu',
      example_hanzi = '这本经典传记生动细腻地刻画了多位极具时代代表性的历史人物。',
      example_pinyin = 'Zhè běn jīngdiǎn zhuànjì shēngdòng xìnì de kèhuà le duō wèi jí jù shídài dàibiǎoxìng de lìshǐ rénwù.',
      example_vi = 'Cuốn tiểu sử kinh điển này đã khắc họa sinh động và tinh tế nhiều nhân vật lịch sử mang đậm tính đại diện cho thời đại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '人物',
      'rénwù',
      'nhân vật (tiểu thuyết, lịch sử), nhân sĩ tiêu biểu',
      'Danh từ',
      'HSK 5',
      '这本经典传记生动细腻地刻画了多位极具时代代表性的历史人物。',
      'Zhè běn jīngdiǎn zhuànjì shēngdòng xìnì de kèhuà le duō wèi jí jù shídài dàibiǎoxìng de lìshǐ rénwù.',
      'Cuốn tiểu sử kinh điển này đã khắc họa sinh động và tinh tế nhiều nhân vật lịch sử mang đậm tính đại diện cho thời đại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这本经典传记生动细腻地刻画了多位极具时代代表性的历史人物。', 'Zhè běn jīngdiǎn zhuànjì shēngdòng xìnì de kèhuà le duō wèi jí jù shídài dàibiǎoxìng de lìshǐ rénwù.', 'Cuốn tiểu sử kinh điển này đã khắc họa sinh động và tinh tế nhiều nhân vật lịch sử mang đậm tính đại diện cho thời đại.', 'basic', 1),
      (v_id, '评选年度经济风云人物重在表彰那些在核心产业技术创新与履行社会责任方面做出卓越贡献的企业领军者。', 'Píngxuǎn niándù jīngjì fēngyún rénwù zhòng zài biǎozhāng nàxiē zài héxīn chǎnyè jìshù chuàngxīn yǔ lǚxíng shèhuì zérèn fāngmiàn zuòchū zhuóyuè gòngxiàn de qǐyè lǐngjūnzhě.', 'Việc bình chọn nhân vật kinh tế tiêu biểu của năm chú trọng tôn vinh những nhà lãnh đạo doanh nghiệp đã có cống hiến vượt bậc trong đổi mới công nghệ công nghiệp cốt lõi và thực thi trách nhiệm xã hội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2928] [忍] (rěn) - nhẫn nại, chịu đựng, kiềm chế [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '忍' AND pinyin = 'rěn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '忍' AND pinyin = 'rěn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '忍'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '忍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'rěn',
      meaning_vi = 'nhẫn nại, chịu đựng, kiềm chế',
      example_hanzi = '面对暂时的误解和委屈，他强忍住泪水，默默地坚持把手头的工作做完。',
      example_pinyin = 'Miànduì zànshí de wùjiě hé wěiqu, tā qiáng rěn zhù lèishuǐ, mòmò de jiānchí bǎ shǒutóu de gōngzuò zuò wán.',
      example_vi = 'Đối mặt với sự hiểu lầm và tủi thân nhất thời, anh ấy cố kìm nén nước mắt, lặng lẽ kiên trì hoàn thành nốt công việc dang dở trên tay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '忍',
      'rěn',
      'nhẫn nại, chịu đựng, kiềm chế',
      'Động từ',
      'HSK 5',
      '面对暂时的误解和委屈，他强忍住泪水，默默地坚持把手头的工作做完。',
      'Miànduì zànshí de wùjiě hé wěiqu, tā qiáng rěn zhù lèishuǐ, mòmò de jiānchí bǎ shǒutóu de gōngzuò zuò wán.',
      'Đối mặt với sự hiểu lầm và tủi thân nhất thời, anh ấy cố kìm nén nước mắt, lặng lẽ kiên trì hoàn thành nốt công việc dang dở trên tay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对暂时的误解和委屈，他强忍住泪水，默默地坚持把手头的工作做完。', 'Miànduì zànshí de wùjiě hé wěiqu, tā qiáng rěn zhù lèishuǐ, mòmò de jiānchí bǎ shǒutóu de gōngzuò zuò wán.', 'Đối mặt với sự hiểu lầm và tủi thân nhất thời, anh ấy cố kìm nén nước mắt, lặng lẽ kiên trì hoàn thành nốt công việc dang dở trên tay.', 'basic', 1),
      (v_id, '一名成熟的专业商务谈判专家必须具备极高的情绪韧性，在对手施加极限施压时忍耐克制并精准寻找反制契机。', 'Yì míng chéngshú de zhuānyè shāngwù tánpàn zhuānjiā bìxū jùbèi jí gāo de qíngxù rènxìng, zài duìshǒu shījiā jíxiàn shīyā shí rěnnài kèzhì bìng jīngzhǔn xúnzhǎo fǎnzhì qìjī.', 'Một chuyên gia đàm phán thương mại chuyên nghiệp trưởng thành bắt buộc phải sở hữu độ dẻo dai cảm xúc cực cao, biết nhẫn nại kiềm chế khi đối thủ gia tăng áp lực tột độ và tìm kiếm chuẩn xác cơ hội phản công.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2929] [认] (rèn) - nhận ra, thừa nhận, chấp nhận [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '认' AND pinyin = 'rèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '认' AND pinyin = 'rèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '认'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '认'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'rèn',
      meaning_vi = 'nhận ra, thừa nhận, chấp nhận',
      example_hanzi = '多年未见，他在拥挤的车站人群中一眼就认出了当年的老同学。',
      example_pinyin = 'Duō nián wèi jiàn, tā zài yōngjǐ de chēzhàn rénqún zhōng yì yǎn jiù rèn chū le dāngnián de lǎo tóngxué.',
      example_vi = 'Nhiều năm không gặp, giữa đám đông bến xe chen chúc anh ấy chỉ nhìn một cái là nhận ra ngay người bạn học năm nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '认',
      'rèn',
      'nhận ra, thừa nhận, chấp nhận',
      'Động từ',
      'HSK 5',
      '多年未见，他在拥挤的车站人群中一眼就认出了当年的老同学。',
      'Duō nián wèi jiàn, tā zài yōngjǐ de chēzhàn rénqún zhōng yì yǎn jiù rèn chū le dāngnián de lǎo tóngxué.',
      'Nhiều năm không gặp, giữa đám đông bến xe chen chúc anh ấy chỉ nhìn một cái là nhận ra ngay người bạn học năm nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '多年未见，他在拥挤的车站人群中一眼就认出了当年的老同学。', 'Duō nián wèi jiàn, tā zài yōngjǐ de chēzhàn rénqún zhōng yì yǎn jiù rèn chū le dāngnián de lǎo tóngxué.', 'Nhiều năm không gặp, giữa đám đông bến xe chen chúc anh ấy chỉ nhìn một cái là nhận ra ngay người bạn học năm nào.', 'basic', 1),
      (v_id, '勇于正视发展差距并公开发表认错检讨，是展现组织战略自信与全面深化内部机制改革的务实前提。', 'Yǒngyú zhèngshì fāzhǎn chājù bìng gōngkāi fābiǎo rèncuò jiǎntǎo, shì zhǎnxiàn zǔzhī zhànlüè zìxìn yǔ quánmiàn shēnhuà nèibù jīzhì gǎigé de wùshí qiántí.', 'Dũng cảm nhìn thẳng vào khoảng cách phát triển và công khai thừa nhận sai sót tự kiểm điểm là tiền đề thiết thực thể hiện sự tự tin chiến lược của tổ chức và đào sâu toàn diện cải cách cơ chế nội bộ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2930] [日历] (rìlì) - lịch, cuốn lịch, niên lịch [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '日历' AND pinyin = 'rìlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '日历' AND pinyin = 'rìlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '日历'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '日历'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rìlì',
      meaning_vi = 'lịch, cuốn lịch, niên lịch',
      example_hanzi = '他在书桌上的精美台历日历上圈出了下周的重要考试日期。',
      example_pinyin = 'Tā zài shūzhuō shang de jīngměi táilì rìlì shang quān chū le xià zhōu de zhòngyào kǎoshì rìqī.',
      example_vi = 'Anh ấy khoanh tròn ngày thi quan trọng của tuần tới trên cuốn lịch để bàn tinh xảo đặt ở bàn học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '日历',
      'rìlì',
      'lịch, cuốn lịch, niên lịch',
      'Danh từ',
      'HSK 5',
      '他在书桌上的精美台历日历上圈出了下周的重要考试日期。',
      'Tā zài shūzhuō shang de jīngměi táilì rìlì shang quān chū le xià zhōu de zhòngyào kǎoshì rìqī.',
      'Anh ấy khoanh tròn ngày thi quan trọng của tuần tới trên cuốn lịch để bàn tinh xảo đặt ở bàn học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在书桌上的精美台历日历上圈出了下周的重要考试日期。', 'Tā zài shūzhuō shang de jīngměi táilì rìlì shang quān chū le xià zhōu de zhòngyào kǎoshì rìqī.', 'Anh ấy khoanh tròn ngày thi quan trọng của tuần tới trên cuốn lịch để bàn tinh xảo đặt ở bàn học.', 'basic', 1),
      (v_id, '企业级协同办公系统将员工个人日程与部门共享日历深度打通，显著提升了跨部门会议协调与资源调度效能。', 'Qǐyèjí xiétóng bàngōng xìtǒng jiāng yuángōng gèrén rìchéng yǔ bùmén gòngxiǎng rìlì shēndù dǎtōng, xiǎnzhù tíshēng le kuà-bùmén huìyì xiétiáo yǔ zīyuán diàodù xiàonéng.', 'Hệ thống văn phòng cộng tác cấp doanh nghiệp đã liên thông sâu sắc lịch trình cá nhân của nhân viên với lịch dùng chung của phòng ban, nâng cao rõ rệt hiệu năng điều phối cuộc họp và sắp xếp tài nguyên liên bộ phận.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2931] [日用品] (rìyòngpǐn) - đồ dùng hàng ngày, hàng tạp hóa thiết yếu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '日用品' AND pinyin = 'rìyòngpǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '日用品' AND pinyin = 'rìyòngpǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '日用品'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '日用品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rìyòngpǐn',
      meaning_vi = 'đồ dùng hàng ngày, hàng tạp hóa thiết yếu',
      example_hanzi = '周末去超级市场采购时，妈妈买齐了牙膏、毛巾和肥皂等常用日用品。',
      example_pinyin = 'Zhōumò qù chāojí shìchǎng cǎigòu shí, māma mǎi qí le yágāo, máojīn hé féizào děng chángyòng rìyòngpǐn.',
      example_vi = 'Dịp cuối tuần đi siêu thị mua sắm, mẹ đã mua đủ các đồ dùng hàng ngày quen thuộc như kem đánh răng, khăn mặt và xà phòng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '日用品',
      'rìyòngpǐn',
      'đồ dùng hàng ngày, hàng tạp hóa thiết yếu',
      'Danh từ',
      'HSK 5',
      '周末去超级市场采购时，妈妈买齐了牙膏、毛巾和肥皂等常用日用品。',
      'Zhōumò qù chāojí shìchǎng cǎigòu shí, māma mǎi qí le yágāo, máojīn hé féizào děng chángyòng rìyòngpǐn.',
      'Dịp cuối tuần đi siêu thị mua sắm, mẹ đã mua đủ các đồ dùng hàng ngày quen thuộc như kem đánh răng, khăn mặt và xà phòng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末去超级市场采购时，妈妈买齐了牙膏、毛巾和肥皂等常用日用品。', 'Zhōumò qù chāojí shìchǎng cǎigòu shí, māma mǎi qí le yágāo, máojīn hé féizào děng chángyòng rìyòngpǐn.', 'Dịp cuối tuần đi siêu thị mua sắm, mẹ đã mua đủ các đồ dùng hàng ngày quen thuộc như kem đánh răng, khăn mặt và xà phòng.', 'basic', 1),
      (v_id, '在发生突发公共事件时，政府物资保障部门必须迅速启动应急储备投放机制，平抑居民基本日用品市场价格波动。', 'Zài fāshēng tūfā gōnggòng shìjiàn shí, zhèngfǔ wùzī bǎozhàng bùmén bìxū xùnsù qǐdòng yìngjí chǔbèi tóufàng jīzhì, píngyì jūmín jīběn rìyòngpǐn shìchǎng jiàgé bōdòng.', 'Khi xảy ra sự kiện công cộng bất ngờ, cơ quan bảo đảm vật tư chính quyền bắt buộc phải nhanh chóng kích hoạt cơ chế cung ứng dự trữ khẩn cấp nhằm bình ổn dao động giá cả thị trường hàng hóa sinh hoạt thiết yếu cơ bản của người dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2932] [如] (rú) - như, giống như; ví như, nếu [Động từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '如' AND pinyin = 'rú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如' AND pinyin = 'rú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '如'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Liên từ',
      pinyin = 'rú',
      meaning_vi = 'như, giống như; ví như, nếu',
      example_hanzi = '时光如流水般匆匆飞逝，转眼间我们已经共同学习了四年。',
      example_pinyin = 'Shíguāng rú liúshuǐ bān cōngcōng fēishì, zhuǎnyǎnjiān wǒmen yǐjīng gòngtóng xuéxí le sì nián.',
      example_vi = 'Thời gian trôi mau như dòng nước chảy xiết, chớp mắt một cái chúng tôi đã cùng học tập bên nhau suốt bốn năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '如',
      'rú',
      'như, giống như; ví như, nếu',
      'Động từ / Liên từ',
      'HSK 5',
      '时光如流水般匆匆飞逝，转眼间我们已经共同学习了四年。',
      'Shíguāng rú liúshuǐ bān cōngcōng fēishì, zhuǎnyǎnjiān wǒmen yǐjīng gòngtóng xuéxí le sì nián.',
      'Thời gian trôi mau như dòng nước chảy xiết, chớp mắt một cái chúng tôi đã cùng học tập bên nhau suốt bốn năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '时光如流水般匆匆飞逝，转眼间我们已经共同学习了四年。', 'Shíguāng rú liúshuǐ bān cōngcōng fēishì, zhuǎnyǎnjiān wǒmen yǐjīng gòngtóng xuéxí le sì nián.', 'Thời gian trôi mau như dòng nước chảy xiết, chớp mắt một cái chúng tôi đã cùng học tập bên nhau suốt bốn năm.', 'basic', 1),
      (v_id, '如合同履行期间遭遇不可抗力事件，受影响一方应在四十八小时内以书面形式通知相对方并出具有效法律证明。', 'Rú hétong lǚxíng qījiān zāoyù bùkěkànglì shìjiàn, shòu yǐngxiǎng yìfāng yīng zài sìshíbā xiǎoshí nèi yǐ shūmiàn xíngshì tōngzhī xiāngduìfāng bìng chūjù yǒuxiào fǎlǜ zhèngmíng.', 'Nếu trong thời hạn thực hiện hợp đồng gặp phải sự kiện bất khả kháng, bên chịu ảnh hưởng phải thông báo bằng văn bản cho phía đối tác trong vòng bốn mươi tám giờ và xuất trình chứng cứ pháp lý hợp lệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2933] [如此] (rúcǐ) - như vậy, như thế này, dường này [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '如此' AND pinyin = 'rúcǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如此' AND pinyin = 'rúcǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '如此'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如此'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'rúcǐ',
      meaning_vi = 'như vậy, như thế này, dường này',
      example_hanzi = '面对如此复杂难懂的数学题，同学们都在草稿纸上反复演算推导。',
      example_pinyin = 'Miànduì rúcǐ fùzá nándǒng de shùxuétí, tóngxuémen dōu zài cǎogǎozhǐ shang fǎnfù yǎnsuàn tuīdǎo.',
      example_vi = 'Đối mặt với bài toán phức tạp khó hiểu đến dường này, các bạn học sinh đều miệt mài tính toán suy luận lại trên giấy nháp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '如此',
      'rúcǐ',
      'như vậy, như thế này, dường này',
      'Đại từ',
      'HSK 5',
      '面对如此复杂难懂的数学题，同学们都在草稿纸上反复演算推导。',
      'Miànduì rúcǐ fùzá nándǒng de shùxuétí, tóngxuémen dōu zài cǎogǎozhǐ shang fǎnfù yǎnsuàn tuīdǎo.',
      'Đối mặt với bài toán phức tạp khó hiểu đến dường này, các bạn học sinh đều miệt mài tính toán suy luận lại trên giấy nháp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对如此复杂难懂的数学题，同学们都在草稿纸上反复演算推导。', 'Miànduì rúcǐ fùzá nándǒng de shùxuétí, tóngxuémen dōu zài cǎogǎozhǐ shang fǎnfù yǎnsuàn tuīdǎo.', 'Đối mặt với bài toán phức tạp khó hiểu đến dường này, các bạn học sinh đều miệt mài tính toán suy luận lại trên giấy nháp.', 'basic', 1),
      (v_id, '全球产业供应链唯有保持如此高度的开放协同与标准化互认，方能有效抵御地缘政治不确定性带来的冲击。', 'Quánqiú chǎnyè gōngyìngliàn wéiyǒu bǎochí rúcǐ gāo-dù de kāifàng xiétóng yǔ biāozhǔnhuà hùrèn, fāng néng yǒuxiào dǐyù dìyuán zhèngzhì bù-quèdìngxìng dài lái de chōngjī.', 'Chuỗi cung ứng sản xuất toàn cầu chỉ khi duy trì được mức độ cởi mở phối hợp cao và công nhận chuẩn hóa lẫn nhau như thế này thì mới có thể chống chọi hữu hiệu những cú sốc do yếu tố bất định địa chính trị mang lại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2934] [如何] (rúhé) - làm sao, như thế nào, ra sao [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '如何' AND pinyin = 'rúhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如何' AND pinyin = 'rúhé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '如何'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如何'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'rúhé',
      meaning_vi = 'làm sao, như thế nào, ra sao',
      example_hanzi = '新入职的员工正在认真向导师请教如何高效处理客户的咨询邮件。',
      example_pinyin = 'Xīn rùzhí de yuángōng zhèngzài rènzhēn xiàng dǎoshī qǐngjiào rúhé gāoxiào chǔlǐ kèhù de zīxún yóujiàn.',
      example_vi = 'Nhân viên mới tuyển dụng đang nghiêm túc thỉnh giáo người hướng dẫn cách xử lý email tư vấn của khách hàng một cách hiệu quả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '如何',
      'rúhé',
      'làm sao, như thế nào, ra sao',
      'Đại từ',
      'HSK 5',
      '新入职的员工正在认真向导师请教如何高效处理客户的咨询邮件。',
      'Xīn rùzhí de yuángōng zhèngzài rènzhēn xiàng dǎoshī qǐngjiào rúhé gāoxiào chǔlǐ kèhù de zīxún yóujiàn.',
      'Nhân viên mới tuyển dụng đang nghiêm túc thỉnh giáo người hướng dẫn cách xử lý email tư vấn của khách hàng một cách hiệu quả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新入职的员工正在认真向导师请教如何高效处理客户的咨询邮件。', 'Xīn rùzhí de yuángōng zhèngzài rènzhēn xiàng dǎoshī qǐngjiào rúhé gāoxiào chǔlǐ kèhù de zīxún yóujiàn.', 'Nhân viên mới tuyển dụng đang nghiêm túc thỉnh giáo người hướng dẫn cách xử lý email tư vấn của khách hàng một cách hiệu quả.', 'basic', 1),
      (v_id, '在兼顾经济增长动能的同时如何稳步实现碳达峰碳中和战略目标，是摆在各国宏观经济政策制定者面前的历史性课题。', 'Zài jiāngù jīngjì zēngzhǎng dòngnéng de tóngshí rúhé wěnbù shíxiàn tàndáfēng tànzhōnghé zhànlüè mùbiāo, shì bǎi zài gè guó hóngguān jīngjì zhèngcè zhìdìngzhě miànqián de lìshǐxìng kètí.', 'Làm thế nào để từng bước thực hiện mục tiêu chiến lược đạt đỉnh carbon và trung hòa carbon trong khi vẫn bảo đảm động năng tăng trưởng kinh tế là đề tài lịch sử đặt ra trước các nhà hoạch định chính sách kinh tế vĩ mô của các quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2935] [如今] (rújīn) - ngày nay, hiện nay, giờ đây [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '如今' AND pinyin = 'rújīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如今' AND pinyin = 'rújīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '如今'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如今'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'rújīn',
      meaning_vi = 'ngày nay, hiện nay, giờ đây',
      example_hanzi = '如今，手机移动支付已经深入到了老百姓日常生活的方方面面。',
      example_pinyin = 'Rújīn, shǒujī yídòng zhīfù yǐjīng shēnrù dào le lǎobǎixìng rìcháng shēnghuó de fāngfāng-miànmiàn.',
      example_vi = 'Ngày nay, thanh toán trên điện thoại di động đã thâm nhập sâu rộng vào mọi phương diện trong cuộc sống hàng ngày của người dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '如今',
      'rújīn',
      'ngày nay, hiện nay, giờ đây',
      'Danh từ',
      'HSK 5',
      '如今，手机移动支付已经深入到了老百姓日常生活的方方面面。',
      'Rújīn, shǒujī yídòng zhīfù yǐjīng shēnrù dào le lǎobǎixìng rìcháng shēnghuó de fāngfāng-miànmiàn.',
      'Ngày nay, thanh toán trên điện thoại di động đã thâm nhập sâu rộng vào mọi phương diện trong cuộc sống hàng ngày của người dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如今，手机移动支付已经深入到了老百姓日常生活的方方面面。', 'Rújīn, shǒujī yídòng zhīfù yǐjīng shēnrù dào le lǎobǎixìng rìcháng shēnghuó de fāngfāng-miànmiàn.', 'Ngày nay, thanh toán trên điện thoại di động đã thâm nhập sâu rộng vào mọi phương diện trong cuộc sống hàng ngày của người dân.', 'basic', 1),
      (v_id, '昔日交通闭塞、资源匮乏的贫瘠山村，如今依托生态特色种植与乡村文化旅游实现了令人瞩目的绿色蜕变。', 'Xīrì jiāotōng bìsè, zīyuán kuìfá de pínjí shāncūn, rújīn yītuō shēngtài tèsè zhòngzhí yǔ xiāngcūn wénhuà lǚyóu shíxiàn le lìngrén-zhǔmù de lǜsè tuìbiàn.', 'Ngôi làng miền núi nghèo cằn cỗi ngày xưa giao thông bế tắc và nghèo nàn tài nguyên, ngày nay nhờ trồng trọt đặc sản sinh thái và du lịch văn hóa làng quê đã thực hiện bước chuyển mình xanh đáng khâm phục.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2936] [如同] (rútóng) - giống như, tựa như, hệt như [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '如同' AND pinyin = 'rútóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如同' AND pinyin = 'rútóng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '如同'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如同'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'rútóng',
      meaning_vi = 'giống như, tựa như, hệt như',
      example_hanzi = '一本好书如同良师益友，能在迷茫时为我们照亮前行的道路。',
      example_pinyin = 'Yì běn hǎoshū rútóng liángshī-yìyǒu, néng zài mímáng shí wèi wǒmen zhàoliàng qiánxíng de dàolù.',
      example_vi = 'Một cuốn sách hay tựa như người thầy giỏi người bạn tốt, có thể soi sáng con đường tiến bước cho chúng ta khi đang lạc lối.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '如同',
      'rútóng',
      'giống như, tựa như, hệt như',
      'Động từ',
      'HSK 5',
      '一本好书如同良师益友，能在迷茫时为我们照亮前行的道路。',
      'Yì běn hǎoshū rútóng liángshī-yìyǒu, néng zài mímáng shí wèi wǒmen zhàoliàng qiánxíng de dàolù.',
      'Một cuốn sách hay tựa như người thầy giỏi người bạn tốt, có thể soi sáng con đường tiến bước cho chúng ta khi đang lạc lối.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一本好书如同良师益友，能在迷茫时为我们照亮前行的道路。', 'Yì běn hǎoshū rútóng liángshī-yìyǒu, néng zài mímáng shí wèi wǒmen zhàoliàng qiánxíng de dàolù.', 'Một cuốn sách hay tựa như người thầy giỏi người bạn tốt, có thể soi sáng con đường tiến bước cho chúng ta khi đang lạc lối.', 'basic', 1),
      (v_id, '健全完备的现代金融监管法律体系，如同行驶在高速公路上的护栏与刹车系统，确保金融资本运行始终在安全轨道内。', 'Jiànquán wánbèi de xiàndài jīnróng jiānguǎn fǎlǜ tǐxì, rútóng xíngshǐ zài gāosù gōnglù shang de hùlán yǔ shāchē xìtǒng, quèbǎo jīnróng zīběn yùnxíng shǐzhōng zài ānquán guǐdào nèi.', 'Hệ thống pháp luật giám sát tài chính hiện đại hoàn thiện đồng bộ tựa như lan can bảo vệ và hệ thống phanh hãm khi lưu thông trên đường cao tốc, bảo đảm dòng vốn tài chính vận hành luôn trong phạm vi quỹ đạo an toàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2937] [如下] (rúxià) - như sau, nêu ở dưới đây [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '如下' AND pinyin = 'rúxià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如下' AND pinyin = 'rúxià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '如下'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '如下'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'rúxià',
      meaning_vi = 'như sau, nêu ở dưới đây',
      example_hanzi = '本学期图书馆的具体借阅规定与开放时间如下，请各位读者知悉。',
      example_pinyin = 'Běn xuéqī túshūguǎn de jùtǐ jièyuè guīdìng yǔ kāifàng shíjiān rúxià, qǐng gèwèi dúzhě zhīxī.',
      example_vi = 'Quy định mượn sách và thời gian mở cửa cụ thể của thư viện trong học kỳ này như sau, xin kính mời quý độc giả nắm rõ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '如下',
      'rúxià',
      'như sau, nêu ở dưới đây',
      'Động từ',
      'HSK 5',
      '本学期图书馆的具体借阅规定与开放时间如下，请各位读者知悉。',
      'Běn xuéqī túshūguǎn de jùtǐ jièyuè guīdìng yǔ kāifàng shíjiān rúxià, qǐng gèwèi dúzhě zhīxī.',
      'Quy định mượn sách và thời gian mở cửa cụ thể của thư viện trong học kỳ này như sau, xin kính mời quý độc giả nắm rõ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '本学期图书馆的具体借阅规定与开放时间如下，请各位读者知悉。', 'Běn xuéqī túshūguǎn de jùtǐ jièyuè guīdìng yǔ kāifàng shíjiān rúxià, qǐng gèwèi dúzhě zhīxī.', 'Quy định mượn sách và thời gian mở cửa cụ thể của thư viện trong học kỳ này như sau, xin kính mời quý độc giả nắm rõ.', 'basic', 1),
      (v_id, '经专家组综合严格评审，重大科技专项中标候选机构的核心技术指标与履约方案公示如下。', 'Jīng zhuānjiāzǔ zōnghé yángé píngshěn, zhòngdà kējì zhuānxiàng zhòngbiāo hòuxuǎn jīgòu de héxīn jìshù zhǐbiāo yǔ lǚyuē fāng’àn gōngshì rúxià.', 'Qua quá trình hội đồng chuyên gia thẩm định nghiêm ngặt toàn diện, các chỉ tiêu kỹ thuật cốt lõi và phương án thực thi hợp đồng của cơ quan trúng thầu dự án khoa học công nghệ trọng điểm được công bố như sau.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2938] [软] (ruǎn) - mềm, êm ái, yếu mềm [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '软' AND pinyin = 'ruǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '软' AND pinyin = 'ruǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '软'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '软'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'ruǎn',
      meaning_vi = 'mềm, êm ái, yếu mềm',
      example_hanzi = '客厅里新买的布艺沙发坐上去又松又软，让人感觉特别放松舒适。',
      example_pinyin = 'Kètīng lǐ xīn mǎi de bùyì shāfā zuò shàngqù yòu sōng yòu ruǎn, ràng rén gǎnjué tèbié fàngsōng shūshì.',
      example_vi = 'Chiếc ghế sofa bọc vải mới mua ở phòng khách ngồi lên vừa êm vừa mềm, khiến người ta cảm thấy vô cùng thư giãn dễ chịu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '软',
      'ruǎn',
      'mềm, êm ái, yếu mềm',
      'Tính từ',
      'HSK 5',
      '客厅里新买的布艺沙发坐上去又松又软，让人感觉特别放松舒适。',
      'Kètīng lǐ xīn mǎi de bùyì shāfā zuò shàngqù yòu sōng yòu ruǎn, ràng rén gǎnjué tèbié fàngsōng shūshì.',
      'Chiếc ghế sofa bọc vải mới mua ở phòng khách ngồi lên vừa êm vừa mềm, khiến người ta cảm thấy vô cùng thư giãn dễ chịu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '客厅里新买的布艺沙发坐上去又松又软，让人感觉特别放松舒适。', 'Kètīng lǐ xīn mǎi de bùyì shāfā zuò shàngqù yòu sōng yòu ruǎn, ràng rén gǎnjué tèbié fàngsōng shūshì.', 'Chiếc ghế sofa bọc vải mới mua ở phòng khách ngồi lên vừa êm vừa mềm, khiến người ta cảm thấy vô cùng thư giãn dễ chịu.', 'basic', 1),
      (v_id, '在提升硬实力的同时全面加强国家文化软实力建设，是塑造良好国家形象与深化文明交流互鉴的核心战略。', 'Zài tíshēng yìnglì de tóngshí quánmiàn jiāqiáng guójiā wénhuà ruǎnlì jiànshè, shì shùzào liánghǎo guójiā xíngxiàng yǔ shēnhuà wénmíng jiāoliú hùjiàn de héxīn zhànlüè.', 'Song song với nâng cao sức mạnh cứng là tăng cường toàn diện xây dựng sức mạnh mềm văn hóa quốc gia, đây là chiến lược cốt lõi để kiến tạo hình tượng quốc gia tốt đẹp và làm sâu sắc thêm giao lưu học hỏi lẫn nhau giữa các nền văn minh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2939] [软件] (ruǎnjiàn) - phần mềm (máy tính, điện thoại) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '软件' AND pinyin = 'ruǎnjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '软件' AND pinyin = 'ruǎnjiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '软件'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '软件'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'ruǎnjiàn',
      meaning_vi = 'phần mềm (máy tính, điện thoại)',
      example_hanzi = '为了提高日常办公效率，他在电脑上安装了一套高效的办公软件。',
      example_pinyin = 'Wèile tígāo rìcháng bàngōng xiàolǜ, tā zài diànnǎo shang ānzhuāng le yí tào gāoxiào de bàngōng ruǎnjiàn.',
      example_vi = 'Để nâng cao hiệu suất làm việc văn phòng hàng ngày, anh ấy đã cài đặt một bộ phần mềm văn phòng hiệu quả trên máy tính.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '软件',
      'ruǎnjiàn',
      'phần mềm (máy tính, điện thoại)',
      'Danh từ',
      'HSK 5',
      '为了提高日常办公效率，他在电脑上安装了一套高效的办公软件。',
      'Wèile tígāo rìcháng bàngōng xiàolǜ, tā zài diànnǎo shang ānzhuāng le yí tào gāoxiào de bàngōng ruǎnjiàn.',
      'Để nâng cao hiệu suất làm việc văn phòng hàng ngày, anh ấy đã cài đặt một bộ phần mềm văn phòng hiệu quả trên máy tính.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了提高日常办公效率，他在电脑上安装了一套高效的办公软件。', 'Wèile tígāo rìcháng bàngōng xiàolǜ, tā zài diànnǎo shang ānzhuāng le yí tào gāoxiào de bàngōng ruǎnjiàn.', 'Để nâng cao hiệu suất làm việc văn phòng hàng ngày, anh ấy đã cài đặt một bộ phần mềm văn phòng hiệu quả trên máy tính.', 'basic', 1),
      (v_id, '工业制造基础软件与集成电路设计EDA工具链的自主可控，是维护国家数字经济与高端制造安全的关键底座。', 'Gōngyè zhìzào jīchǔ ruǎnjiàn yǔ jíchéng diànlù shèjì EDA gōngjùliàn de zìzhǔ kěkòng, shì wéihù guójiā shùzì jīngjì yǔ gāoduān zhìzào ānquán de guānjiàn dǐzuò.', 'Việc tự chủ và kiểm soát được các phần mềm nền tảng sản xuất công nghiệp cùng chuỗi công cụ thiết kế vi mạch tích hợp EDA là bệ đỡ then chốt bảo vệ an ninh sản xuất cao cấp và kinh tế số của quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2940] [弱] (ruò) - yếu, yếu ớt, kém [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '弱' AND pinyin = 'ruò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '弱' AND pinyin = 'ruò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '弱'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '弱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'ruò',
      meaning_vi = 'yếu, yếu ớt, kém',
      example_hanzi = '大病初愈的他身体还比较虚弱，医生建议暂时不要进行剧烈运动。',
      example_pinyin = 'Dà bìng chū yù de tā shēntǐ hái bǐjiào xūruò, yīshēng jiànyì zànshí bú yào jìnxíng jùliè yùndòng.',
      example_vi = 'Anh ấy vừa mới khỏi sau trận ốm nặng cơ thể vẫn còn khá yếu ớt, bác sĩ khuyên tạm thời không nên vận động mạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '弱',
      'ruò',
      'yếu, yếu ớt, kém',
      'Tính từ',
      'HSK 5',
      '大病初愈的他身体还比较虚弱，医生建议暂时不要进行剧烈运动。',
      'Dà bìng chū yù de tā shēntǐ hái bǐjiào xūruò, yīshēng jiànyì zànshí bú yào jìnxíng jùliè yùndòng.',
      'Anh ấy vừa mới khỏi sau trận ốm nặng cơ thể vẫn còn khá yếu ớt, bác sĩ khuyên tạm thời không nên vận động mạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大病初愈的他身体还比较虚弱，医生建议暂时不要进行剧烈运动。', 'Dà bìng chū yù de tā shēntǐ hái bǐjiào xūruò, yīshēng jiànyì zànshí bú yào jìnxíng jùliè yùndòng.', 'Anh ấy vừa mới khỏi sau trận ốm nặng cơ thể vẫn còn khá yếu ớt, bác sĩ khuyên tạm thời không nên vận động mạnh.', 'basic', 1),
      (v_id, '针对产业链上下游协同偏弱、基础元器件依赖度高的薄弱环节，产业联盟正积极组织多方联合技术攻关。', 'Zhēnduì chǎnyèliàn shàng-xiàyóu xiétóng piān ruò, jīchǔ yuánqìjiàn yīlàidù gāo de bóruò huánjié, chǎnyè liánméng zhèng jījí zǔzhī duō fāng liánhé jìshù gōngguān.', 'Nhắm vào các mắt xích xung yếu nơi sự phối hợp giữa thượng nguồn và hạ nguồn chuỗi sản xuất còn yếu và mức độ phụ thuộc vào linh kiện cơ sở còn cao, liên minh công nghiệp đang tích cực tổ chức liên kết kỹ thuật nhiều bên cùng khắc phục.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2941] [洒] (sǎ) - rải, rắc, vãi, làm đổ tràn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '洒' AND pinyin = 'sǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '洒' AND pinyin = 'sǎ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '洒'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '洒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'sǎ',
      meaning_vi = 'rải, rắc, vãi, làm đổ tràn',
      example_hanzi = '走路时不小心撞到了桌角，杯子里的温水洒了一地。',
      example_pinyin = 'Zǒulù shí bù xiǎoxīn zhuàng dào le zhuōjiǎo, bēizi lǐ de wēnshuǐ sǎ le yí dì.',
      example_vi = 'Khi đi bộ sơ ý va vào góc bàn, nước ấm trong cốc đổ tràn lênh láng ra cả sàn nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '洒',
      'sǎ',
      'rải, rắc, vãi, làm đổ tràn',
      'Động từ',
      'HSK 5',
      '走路时不小心撞到了桌角，杯子里的温水洒了一地。',
      'Zǒulù shí bù xiǎoxīn zhuàng dào le zhuōjiǎo, bēizi lǐ de wēnshuǐ sǎ le yí dì.',
      'Khi đi bộ sơ ý va vào góc bàn, nước ấm trong cốc đổ tràn lênh láng ra cả sàn nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '走路时不小心撞到了桌角，杯子里的温水洒了一地。', 'Zǒulù shí bù xiǎoxīn zhuàng dào le zhuōjiǎo, bēizi lǐ de wēnshuǐ sǎ le yí dì.', 'Khi đi bộ sơ ý va vào góc bàn, nước ấm trong cốc đổ tràn lênh láng ra cả sàn nhà.', 'basic', 1),
      (v_id, '环卫部门在干燥少雨季节启用新能源多功能智能洒水车，定时对城市主干道实施高压冲洗抑尘作业。', 'Huánwèi bùmén zài gānzào shǎo yǔ jìjié qǐyòng xīnnéngyuán duō-gōngnéng zhìnéng sǎshuǐchē, dìngshí duì chéngshì zhǔgàndào shíshī gāoyā chōngxǐ yìchén zuòyè.', 'Ngành vệ sinh môi trường vào mùa khô ít mưa đã đưa vào sử dụng xe phun nước thông minh đa năng năng lượng mới, định kỳ thực hiện xịt rửa cao áp giảm bụi trên các tuyến đường trục chính của đô thị.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2942] [赛场] (sàichǎng) - sân thi đấu, đấu trường, thao trường [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '赛场' AND pinyin = 'sàichǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赛场' AND pinyin = 'sàichǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '赛场'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赛场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'sàichǎng',
      meaning_vi = 'sân thi đấu, đấu trường, thao trường',
      example_hanzi = '运动健儿们在赛场上奋勇拼搏，为观众带来了一场场精彩激烈的对抗。',
      example_pinyin = 'Yùndòng jiàn’érmen zài sàichǎng shang fènyǒng pīnbó, wèi guānzhòng dài lái le yì chǎngchǎng jīngcǎi jīliè de duìkàng.',
      example_vi = 'Các vận động viên trên sân thi đấu dũng cảm chiến đấu hết mình, mang lại cho khán giả những màn so tài kịch tính và đặc sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '赛场',
      'sàichǎng',
      'sân thi đấu, đấu trường, thao trường',
      'Danh từ',
      'HSK 5',
      '运动健儿们在赛场上奋勇拼搏，为观众带来了一场场精彩激烈的对抗。',
      'Yùndòng jiàn’érmen zài sàichǎng shang fènyǒng pīnbó, wèi guānzhòng dài lái le yì chǎngchǎng jīngcǎi jīliè de duìkàng.',
      'Các vận động viên trên sân thi đấu dũng cảm chiến đấu hết mình, mang lại cho khán giả những màn so tài kịch tính và đặc sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '运动健儿们在赛场上奋勇拼搏，为观众带来了一场场精彩激烈的对抗。', 'Yùndòng jiàn’érmen zài sàichǎng shang fènyǒng pīnbó, wèi guānzhòng dài lái le yì chǎngchǎng jīngcǎi jīliè de duìkàng.', 'Các vận động viên trên sân thi đấu dũng cảm chiến đấu hết mình, mang lại cho khán giả những màn so tài kịch tính và đặc sắc.', 'basic', 1),
      (v_id, '现代大型综合体育赛场在规划设计中深度融入了BIM数字化建造技术与超低能耗绿色建筑评价标准。', 'Xiàndài dàxíng zōnghé tǐyù sàichǎng zài guīhuà shèjì zhōng shēndù róngrù le BIM shùzìhuà jiànzào jìshù yǔ chāo-dī nénghào lǜsè jiànzhù píngjià biāozhǔn.', 'Đấu trường thể thao tổng hợp quy mô lớn hiện đại trong quy hoạch thiết kế đã lồng ghép sâu sắc công nghệ xây dựng kỹ thuật số BIM và tiêu chuẩn đánh giá công trình xanh tiêu hao năng lượng siêu thấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2943] [色彩] (sècǎi) - màu sắc, sắc thái [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '色彩' AND pinyin = 'sècǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '色彩' AND pinyin = 'sècǎi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '色彩'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '色彩'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'sècǎi',
      meaning_vi = 'màu sắc, sắc thái',
      example_hanzi = '秋天的香山红叶层林尽染，呈现出绚丽多彩的大自然色彩。',
      example_pinyin = 'Qiūtiān de Xiāngshān hóngyè cénglín-jìnrǎn, chéngxiàn chū xuànlì-duōcǎi de dà-zìrán sècǎi.',
      example_vi = 'Lá phong đỏ Hương Sơn vào mùa thu nhuộm thắm các tầng rừng, hiện lên những sắc màu thiên nhiên lộng lẫy và rực rỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '色彩',
      'sècǎi',
      'màu sắc, sắc thái',
      'Danh từ',
      'HSK 5',
      '秋天的香山红叶层林尽染，呈现出绚丽多彩的大自然色彩。',
      'Qiūtiān de Xiāngshān hóngyè cénglín-jìnrǎn, chéngxiàn chū xuànlì-duōcǎi de dà-zìrán sècǎi.',
      'Lá phong đỏ Hương Sơn vào mùa thu nhuộm thắm các tầng rừng, hiện lên những sắc màu thiên nhiên lộng lẫy và rực rỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '秋天的香山红叶层林尽染，呈现出绚丽多彩的大自然色彩。', 'Qiūtiān de Xiāngshān hóngyè cénglín-jìnrǎn, chéngxiàn chū xuànlì-duōcǎi de dà-zìrán sècǎi.', 'Lá phong đỏ Hương Sơn vào mùa thu nhuộm thắm các tầng rừng, hiện lên những sắc màu thiên nhiên lộng lẫy và rực rỡ.', 'basic', 1),
      (v_id, '这篇深度政治评论文章客观剖析了国际地缘冲突背后的复杂利益博弈，不带有任何偏激的主观意识形态色彩。', 'Zhè piān shēndù zhèngzhì pínglùn wénzhāng kèguān pōuxī le guójì dìyuán chōngtū bèihòu de fùzá lìyì bóyì, bú dài yǒu rènhé piānjī de zhǔguān yìshí xíngtài sècǎi.', 'Bài viết bình luận chính trị chuyên sâu này đã mổ xẻ khách quan cuộc đấu tranh giành lợi ích phức tạp phía sau các xung đột địa chính trị quốc tế mà không mang bất kỳ sắc thái ý thức hệ chủ quan thiên lệch nào.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2944] [沙漠] (shāmò) - sa mạc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '沙漠' AND pinyin = 'shāmò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沙漠' AND pinyin = 'shāmò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '沙漠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沙漠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shāmò',
      meaning_vi = 'sa mạc',
      example_hanzi = '在浩瀚无垠的沙漠中旅行，必须带足饮用水并做好防风防沙准备。',
      example_pinyin = 'Zài hàohàn-wúyín de shāmò zhōng lǚxíng, bìxū dài zú yǐnyòngshuǐ bìng zuò hǎo fángfēng-fángshā zhǔnbèi.',
      example_vi = 'Đi du lịch giữa sa mạc mênh mông bát ngát, bắt buộc phải mang theo đủ nước uống và chuẩn bị tốt công tác chắn gió chắn cát.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '沙漠',
      'shāmò',
      'sa mạc',
      'Danh từ',
      'HSK 5',
      '在浩瀚无垠的沙漠中旅行，必须带足饮用水并做好防风防沙准备。',
      'Zài hàohàn-wúyín de shāmò zhōng lǚxíng, bìxū dài zú yǐnyòngshuǐ bìng zuò hǎo fángfēng-fángshā zhǔnbèi.',
      'Đi du lịch giữa sa mạc mênh mông bát ngát, bắt buộc phải mang theo đủ nước uống và chuẩn bị tốt công tác chắn gió chắn cát.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在浩瀚无垠的沙漠中旅行，必须带足饮用水并做好防风防沙准备。', 'Zài hàohàn-wúyín de shāmò zhōng lǚxíng, bìxū dài zú yǐnyòngshuǐ bìng zuò hǎo fángfēng-fángshā zhǔnbèi.', 'Đi du lịch giữa sa mạc mênh mông bát ngát, bắt buộc phải mang theo đủ nước uống và chuẩn bị tốt công tác chắn gió chắn cát.', 'basic', 1),
      (v_id, '科研人员在西北干旱荒漠化边缘大力推广“光伏治沙”综合生态修复模式，实现了清洁能源发电与沙漠土壤固化双重收益。', 'Kēyán rényuán zài xīběi gānhàn huāngmòhuà biānyuán dàlì tuīguǎng “guāngfú zhìshā” zōnghé shēngtài xiūfù móshì, shíxiàn le qīngjié néngyuán fādiàn yǔ shāmò tǔrǎng gùhuà shuāngzhòng shōuyì.', 'Các cán bộ nghiên cứu khoa học tại vùng ven hoang mạc khô hạn Tây Bắc đã đẩy mạnh nhân rộng mô hình phục hồi sinh thái tích hợp "trị sa mạc bằng điện mặt trời", mang lại lợi ích kép về phát điện năng lượng sạch và cố định đất sa mạc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2945] [沙子] (shāzi) - cát, hạt cát [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '沙子' AND pinyin = 'shāzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沙子' AND pinyin = 'shāzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '沙子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沙子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shāzi',
      meaning_vi = 'cát, hạt cát',
      example_hanzi = '海风吹拂下，孩子们光着脚丫在柔软细腻的海滩沙子上快乐奔跑。',
      example_pinyin = 'Hǎifēng chuīfú xià, háizimen guāng zhe jiǎoyā zài róuruǎn xìnì de hǎitān shāzi shang kuàilè bēnpǎo.',
      example_vi = 'Dưới làn gió biển vi vu, những đứa trẻ đi chân trần vui sướng chạy nhảy trên bãi cát biển mềm mịn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '沙子',
      'shāzi',
      'cát, hạt cát',
      'Danh từ',
      'HSK 5',
      '海风吹拂下，孩子们光着脚丫在柔软细腻的海滩沙子上快乐奔跑。',
      'Hǎifēng chuīfú xià, háizimen guāng zhe jiǎoyā zài róuruǎn xìnì de hǎitān shāzi shang kuàilè bēnpǎo.',
      'Dưới làn gió biển vi vu, những đứa trẻ đi chân trần vui sướng chạy nhảy trên bãi cát biển mềm mịn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '海风吹拂下，孩子们光着脚丫在柔软细腻的海滩沙子上快乐奔跑。', 'Hǎifēng chuīfú xià, háizimen guāng zhe jiǎoyā zài róuruǎn xìnì de hǎitān shāzi shang kuàilè bēnpǎo.', 'Dưới làn gió biển vi vu, những đứa trẻ đi chân trần vui sướng chạy nhảy trên bãi cát biển mềm mịn.', 'basic', 1),
      (v_id, '高纯度石英矿物提炼的高纯石英砂是半导体单晶硅拉晶冶炼不可替代的基础原材料，绝非普通建筑沙子所能比拟。', 'Gāo-chúndù shíyīng kuàngwù tíliàn de gāo-chún shíyīngshā shì bàndǎotǐ dānjīngguī lājīng yěliàn bùkě tìdài de jīchǔ yuáncáiliào, jué fēi pǔtōng jiànzhù shāzi suǒ néng bǐnǐ.', 'Cát thạch anh siêu tinh khiết chiết xuất từ khoáng vật thạch anh độ tinh khiết cao là nguyên liệu thô cơ sở không thể thay thế cho quá trình kéo tinh thể silic đơn tinh thể bán dẫn, hoàn toàn không phải loại cát xây dựng thông thường có thể so sánh được.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2946] [傻] (shǎ) - ngốc, ngốc nghếch, ngây ngô [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '傻' AND pinyin = 'shǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '傻' AND pinyin = 'shǎ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '傻'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '傻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shǎ',
      meaning_vi = 'ngốc, ngốc nghếch, ngây ngô',
      example_hanzi = '他总是乐呵呵地热心帮助大家，甚至被一些人笑称为做傻事的老实人。',
      example_pinyin = 'Tā zǒngshì lèhēhē de rèxīn bāngzhù dàjiā, shènzhì bèi yìxiē rén xiàochēng wèi zuò shǎ shì de lǎoshirén.',
      example_vi = 'Anh ấy luôn tươi cười nhiệt tình giúp đỡ mọi người, thậm chí còn bị một số người trêu cười là người thật thà làm chuyện ngốc nghếch.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '傻',
      'shǎ',
      'ngốc, ngốc nghếch, ngây ngô',
      'Tính từ',
      'HSK 5',
      '他总是乐呵呵地热心帮助大家，甚至被一些人笑称为做傻事的老实人。',
      'Tā zǒngshì lèhēhē de rèxīn bāngzhù dàjiā, shènzhì bèi yìxiē rén xiàochēng wèi zuò shǎ shì de lǎoshirén.',
      'Anh ấy luôn tươi cười nhiệt tình giúp đỡ mọi người, thậm chí còn bị một số người trêu cười là người thật thà làm chuyện ngốc nghếch.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他总是乐呵呵地热心帮助大家，甚至被一些人笑称为做傻事的老实人。', 'Tā zǒngshì lèhēhē de rèxīn bāngzhù dàjiā, shènzhì bèi yìxiē rén xiàochēng wèi zuò shǎ shì de lǎoshirén.', 'Anh ấy luôn tươi cười nhiệt tình giúp đỡ mọi người, thậm chí còn bị một số người trêu cười là người thật thà làm chuyện ngốc nghếch.', 'basic', 1),
      (v_id, '在纷繁复杂的商战博弈中，盲目轻信未经尽职调查的高收益投资承诺，无异于将企业资本置于极为愚傻的毁灭性风险之中。', 'Zài fēnfán-fùzá de shāngzhàn bóyì zhōng, mángmù qīngxìn wèijīng jìnzhí diàochá de gāo-shōuyì tóuzī chéngnuò, wúyìyú jiāng qǐyè zīběn zhìyú jíwéi yúshǎ de huǐmièxìng fēngxiǎn zhīzhōng.', 'Trong cuộc cờ thương chiến rối ren phức tạp, việc mù quáng tin vào những cam kết đầu tư lợi nhuận cao chưa qua thẩm định tính cẩn trọng không khác gì đặt nguồn vốn doanh nghiệp vào rủi ro mang tính hủy diệt vô cùng dại dột.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2947] [晒] (shài) - phơi nắng, tắm nắng, phơi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '晒' AND pinyin = 'shài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '晒' AND pinyin = 'shài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '晒'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '晒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shài',
      meaning_vi = 'phơi nắng, tắm nắng, phơi',
      example_hanzi = '晴朗的周末，奶奶把厚厚的被褥拿到阳光充足的阳台上晾晒。',
      example_pinyin = 'Qínglǎng de zhōumò, nǎinai bǎ hòuhòu de bèirù ná dào yángguāng chōngzú de yángtái shang liàngshài.',
      example_vi = 'Dịp cuối tuần trời nắng ráo, bà mang chiếc chăn đệm dày ra ngoài ban công ngập tràn ánh nắng để phơi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '晒',
      'shài',
      'phơi nắng, tắm nắng, phơi',
      'Động từ',
      'HSK 5',
      '晴朗的周末，奶奶把厚厚的被褥拿到阳光充足的阳台上晾晒。',
      'Qínglǎng de zhōumò, nǎinai bǎ hòuhòu de bèirù ná dào yángguāng chōngzú de yángtái shang liàngshài.',
      'Dịp cuối tuần trời nắng ráo, bà mang chiếc chăn đệm dày ra ngoài ban công ngập tràn ánh nắng để phơi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '晴朗的周末，奶奶把厚厚的被褥拿到阳光充足的阳台上晾晒。', 'Qínglǎng de zhōumò, nǎinai bǎ hòuhòu de bèirù ná dào yángguāng chōngzú de yángtái shang liàngshài.', 'Dịp cuối tuần trời nắng ráo, bà mang chiếc chăn đệm dày ra ngoài ban công ngập tràn ánh nắng để phơi.', 'basic', 1),
      (v_id, '沿海传统天然盐田充分利用强日照与大风气候蒸发浓缩海水，传承并发展了古老纯正的天然日晒海盐提取工艺。', 'Yánhǎi chuántǒng tiānrán yántián chōngfèn lìyòng qiáng rìzhào yǔ dàfēng qìhòu zhēngfā nóngsuō hǎishuǐ, chuánchéng bìng fāzhǎn le gǔlǎo chúnzhèng de tiānrán rìshài hǎiyán tíqǔ gōngyì.', 'Các cánh đồng muối tự nhiên truyền thống ven biển tận dụng triệt để thời tiết nắng to và gió lớn để bay hơi cô đặc nước biển, kế thừa và phát triển quy trình chiết xuất muối biển phơi nắng tự nhiên cổ xưa thuần khiết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2948] [删] (shān) - xóa, lược bỏ, cắt bớt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '删' AND pinyin = 'shān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '删' AND pinyin = 'shān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '删'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '删'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shān',
      meaning_vi = 'xóa, lược bỏ, cắt bớt',
      example_hanzi = '这篇文章字数有点超标，作者决定将结尾处两段不重要的描写删掉。',
      example_pinyin = 'Zhè piān wénzhāng zìshù yǒudiǎn chāobiāo, zuòzhě juédìng jiāng jiéwěi chù liǎng duàn bú zhòngyào de miáoxiě shān diào.',
      example_vi = 'Số chữ của bài viết này hơi vượt quá tiêu chuẩn, tác giả quyết định xóa bớt hai đoạn miêu tả không quan trọng ở phần cuối.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '删',
      'shān',
      'xóa, lược bỏ, cắt bớt',
      'Động từ',
      'HSK 5',
      '这篇文章字数有点超标，作者决定将结尾处两段不重要的描写删掉。',
      'Zhè piān wénzhāng zìshù yǒudiǎn chāobiāo, zuòzhě juédìng jiāng jiéwěi chù liǎng duàn bú zhòngyào de miáoxiě shān diào.',
      'Số chữ của bài viết này hơi vượt quá tiêu chuẩn, tác giả quyết định xóa bớt hai đoạn miêu tả không quan trọng ở phần cuối.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这篇文章字数有点超标，作者决定将结尾处两段不重要的描写删掉。', 'Zhè piān wénzhāng zìshù yǒudiǎn chāobiāo, zuòzhě juédìng jiāng jiéwěi chù liǎng duàn bú zhòngyào de miáoxiě shān diào.', 'Số chữ của bài viết này hơi vượt quá tiêu chuẩn, tác giả quyết định xóa bớt hai đoạn miêu tả không quan trọng ở phần cuối.', 'basic', 1),
      (v_id, '为提高文章论证的精炼度与学术规范性，审稿专家建议删繁就简，果断剔除缺乏可靠数据支撑的推测性假说。', 'Wèi tígāo wénzhāng lùnzhèng de jīngliàndù yǔ xuéshù guīfànxìng, shěngǎo zhuānjiā jiànyì shānfán-jiùjiǎn, guǒduàn tīchú quēfá kěkào shùjù zhīchēng de tuīcèxìng jiǎshuō.', 'Nhằm nâng cao tính súc tích và chuẩn mực học thuật của lập luận trong bài viết, chuyên gia phản biện đề xuất lược bớt rườm rà giữ lấy tinh hoa, dứt khoát loại bỏ các giả thuyết mang tính suy đoán thiếu dữ liệu đáng tin cậy hỗ trợ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2949] [扇] (shān) - quạt (gió), phe phẩy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '扇' AND pinyin = 'shān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '扇' AND pinyin = 'shān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '扇'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '扇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shān',
      meaning_vi = 'quạt (gió), phe phẩy',
      example_hanzi = '夏天停电的时候，老爷爷一边给熟睡的孙子轻轻扇着蒲扇，一边讲着民间故事。',
      example_pinyin = 'Xiàtiān tíngdiàn de shíhou, lǎoyéye yìbiān gěi shúshuì de sūnzi qīngqīng shān zhe púshàn, yìbiān jiǎng zhe mínjiān gùshi.',
      example_vi = 'Những lúc mất điện vào mùa hè, người ông một tay phe phẩy chiếc quạt nan nhẹ nhàng quạt cho đứa cháu đang ngủ say, một bên kể chuyện cổ tích dân gian.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '扇',
      'shān',
      'quạt (gió), phe phẩy',
      'Động từ',
      'HSK 5',
      '夏天停电的时候，老爷爷一边给熟睡的孙子轻轻扇着蒲扇，一边讲着民间故事。',
      'Xiàtiān tíngdiàn de shíhou, lǎoyéye yìbiān gěi shúshuì de sūnzi qīngqīng shān zhe púshàn, yìbiān jiǎng zhe mínjiān gùshi.',
      'Những lúc mất điện vào mùa hè, người ông một tay phe phẩy chiếc quạt nan nhẹ nhàng quạt cho đứa cháu đang ngủ say, một bên kể chuyện cổ tích dân gian.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夏天停电的时候，老爷爷一边给熟睡的孙子轻轻扇着蒲扇，一边讲着民间故事。', 'Xiàtiān tíngdiàn de shíhou, lǎoyéye yìbiān gěi shúshuì de sūnzi qīngqīng shān zhe púshàn, yìbiān jiǎng zhe mínjiān gùshi.', 'Những lúc mất điện vào mùa hè, người ông một tay phe phẩy chiếc quạt nan nhẹ nhàng quạt cho đứa cháu đang ngủ say, một bên kể chuyện cổ tích dân gian.', 'basic', 1),
      (v_id, '在古法木炭炼铁作坊中，匠人需要协同操作大型双动活塞风箱持续向炉膛扇风鼓气，以维持炼炉内上千摄氏度的冶炼极温。', 'Zài gǔfǎ mùtàn liàntiě zuòfāng zhōng, jiàngrén xūyào xiétóng cāozuò dàxíng shuāngdòng huósāi fēngxiāng chíxù xiàng lútáng shānfēng gǔqì, yǐ wéichí liànlú nèi shàng qiān shèshìdù de yěliàn jíwēn.', 'Tại xưởng luyện sắt bằng than củi phương pháp cổ, những người thợ cần phối hợp vận hành bễ thụt pít-tông tác động kép cỡ lớn liên tục quạt gió thổi khí vào buồng lò nhằm duy trì nhiệt độ luyện kim tột đỉnh lên tới hàng nghìn độ C bên trong lò luyện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2950] [删除] (shānchú) - xóa bỏ, gỡ bỏ (dữ liệu, tập tin, nội dung) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '删除' AND pinyin = 'shānchú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '删除' AND pinyin = 'shānchú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '删除'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '删除'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shānchú',
      meaning_vi = 'xóa bỏ, gỡ bỏ (dữ liệu, tập tin, nội dung)',
      example_hanzi = '清理手机存储空间时，请注意不要误将重要的家庭照片给删除了。',
      example_pinyin = 'Qīnglǐ shǒujī cúnchǔ kōngjiān shí, qǐng zhùyì bú yào wù jiāng zhòngyào de jiātíng zhàopiàn gěi shānchú le.',
      example_vi = 'Khi dọn dẹp dung lượng bộ nhớ điện thoại, xin chú ý đừng bấm nhầm xóa mất những bức ảnh gia đình quan trọng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '删除',
      'shānchú',
      'xóa bỏ, gỡ bỏ (dữ liệu, tập tin, nội dung)',
      'Động từ',
      'HSK 5',
      '清理手机存储空间时，请注意不要误将重要的家庭照片给删除了。',
      'Qīnglǐ shǒujī cúnchǔ kōngjiān shí, qǐng zhùyì bú yào wù jiāng zhòngyào de jiātíng zhàopiàn gěi shānchú le.',
      'Khi dọn dẹp dung lượng bộ nhớ điện thoại, xin chú ý đừng bấm nhầm xóa mất những bức ảnh gia đình quan trọng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '清理手机存储空间时，请注意不要误将重要的家庭照片给删除了。', 'Qīnglǐ shǒujī cúnchǔ kōngjiān shí, qǐng zhùyì bú yào wù jiāng zhòngyào de jiātíng zhàopiàn gěi shānchú le.', 'Khi dọn dẹp dung lượng bộ nhớ điện thoại, xin chú ý đừng bấm nhầm xóa mất những bức ảnh gia đình quan trọng.', 'basic', 1),
      (v_id, '根据国际个人信息数据合规保护法案，用户依法享有要求互联网运营平台彻底删除其个人敏感行踪数据的权利。', 'Gēnjù guójì gèrén xìnxī shùjù héguī bǎohù fǎ’àn, yònghù yīfǎ xiǎngyǒu yāoqiú hùliánwǎng yùnyíng píngtái chèdǐ shānchú qí gèrén mǐngǎn xíngzōng shùjù de quánlì.', 'Căn cứ vào đạo luật bảo vệ tuân thủ dữ liệu thông tin cá nhân quốc tế, người dùng được hưởng quyền yêu cầu nền tảng vận hành Internet xóa bỏ triệt để dữ liệu hành tung nhạy cảm cá nhân của mình theo luật định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2951] [山区] (shānqū) - vùng núi, miền núi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '山区' AND pinyin = 'shānqū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '山区' AND pinyin = 'shānqū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '山区'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '山区'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shānqū',
      meaning_vi = 'vùng núi, miền núi',
      example_hanzi = '近年来国家大力修建乡村公路，极大方便了边远山区老百姓的出行与物资流通。',
      example_pinyin = 'Jìnniánlái guójiā dàlì xiūjiàn xiāngcūn gōnglù, jídà fāngbiàn le biānyuǎn shānqū lǎobǎixìng de chūxíng yǔ wùzī liútōng.',
      example_vi = 'Những năm gần đây nhà nước ra sức xây dựng đường giao thông nông thôn, tạo thuận tiện to lớn cho việc đi lại và lưu thông hàng hóa của bà con vùng núi hẻo lánh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '山区',
      'shānqū',
      'vùng núi, miền núi',
      'Danh từ',
      'HSK 5',
      '近年来国家大力修建乡村公路，极大方便了边远山区老百姓的出行与物资流通。',
      'Jìnniánlái guójiā dàlì xiūjiàn xiāngcūn gōnglù, jídà fāngbiàn le biānyuǎn shānqū lǎobǎixìng de chūxíng yǔ wùzī liútōng.',
      'Những năm gần đây nhà nước ra sức xây dựng đường giao thông nông thôn, tạo thuận tiện to lớn cho việc đi lại và lưu thông hàng hóa của bà con vùng núi hẻo lánh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '近年来国家大力修建乡村公路，极大方便了边远山区老百姓的出行与物资流通。', 'Jìnniánlái guójiā dàlì xiūjiàn xiāngcūn gōnglù, jídà fāngbiàn le biānyuǎn shānqū lǎobǎixìng de chūxíng yǔ wùzī liútōng.', 'Những năm gần đây nhà nước ra sức xây dựng đường giao thông nông thôn, tạo thuận tiện to lớn cho việc đi lại và lưu thông hàng hóa của bà con vùng núi hẻo lánh.', 'basic', 1),
      (v_id, '针对复杂艰险山区特长公路隧道施工，工程团队采用了超前地质预报与全断面智能掘进装备以防范突泥涌水地质灾害。', 'Zhēnduì fùzá jiānxiǎn shānqū tècháng gōnglù suìdào shīgōng, gōngchéng tuánduì cǎiyòng le chāoqián dìzhì yùbào yǔ quán-duànmiàn zhìnéng juéjìn zhuāngbèi yǐ fángfàn tūní-yǒngshuǐ dìzhì zāihài.', 'Nhắm vào việc thi công hầm đường bộ siêu dài ở vùng núi hiểm trở phức tạp, đội ngũ công trình đã áp dụng kỹ thuật dự báo địa chất đón đầu và thiết bị đào thông minh toàn mặt cắt để phòng ngừa thảm họa địa chất sạt bùn phun nước ngầm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2952] [擅长] (shàncháng) - giỏi về, có sở trường về [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '擅长' AND pinyin = 'shàncháng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '擅长' AND pinyin = 'shàncháng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '擅长'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '擅长'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shàncháng',
      meaning_vi = 'giỏi về, có sở trường về',
      example_hanzi = '他在大学期间主修计算机，尤其擅长手机移动应用软件的开发。',
      example_pinyin = 'Tā zài dàxué qījiān zhǔxiū jìsuànjī, yóuqí shàncháng shǒujī yídòng yìngyòng ruǎnjiàn de kāifā.',
      example_vi = 'Thời đại học anh ấy theo học chuyên ngành máy tính, đặc biệt có sở trường về phát triển ứng dụng di động trên điện thoại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '擅长',
      'shàncháng',
      'giỏi về, có sở trường về',
      'Động từ',
      'HSK 5',
      '他在大学期间主修计算机，尤其擅长手机移动应用软件的开发。',
      'Tā zài dàxué qījiān zhǔxiū jìsuànjī, yóuqí shàncháng shǒujī yídòng yìngyòng ruǎnjiàn de kāifā.',
      'Thời đại học anh ấy theo học chuyên ngành máy tính, đặc biệt có sở trường về phát triển ứng dụng di động trên điện thoại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在大学期间主修计算机，尤其擅长手机移动应用软件的开发。', 'Tā zài dàxué qījiān zhǔxiū jìsuànjī, yóuqí shàncháng shǒujī yídòng yìngyòng ruǎnjiàn de kāifā.', 'Thời đại học anh ấy theo học chuyên ngành máy tính, đặc biệt có sở trường về phát triển ứng dụng di động trên điện thoại.', 'basic', 1),
      (v_id, '优秀的现代企业首席执行官不仅擅长战略规划，更擅长整合多元跨学科复合型创新团队。', 'Yōuxiù de xiàndài qǐyè shǒuxí zhíxíngguān bùjǐn shàncháng zhànlüè guīhuà, gèng shàncháng zhěnghé duōyuán kuà-xuékē fùhéxíng chuàngxīn tuánduì.', 'Một CEO doanh nghiệp hiện đại xuất sắc không chỉ giỏi về hoạch định chiến lược mà còn đặc biệt có sở trường trong tích hợp các đội ngũ sáng tạo phức hợp liên ngành đa dạng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2953] [善良] (shànliáng) - lương thiện, hiền lành, nhân hậu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '善良' AND pinyin = 'shànliáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '善良' AND pinyin = 'shànliáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '善良'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '善良'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shànliáng',
      meaning_vi = 'lương thiện, hiền lành, nhân hậu',
      example_hanzi = '村里那位善良淳朴的老爷爷经常把自家菜园里摘的新鲜蔬菜分送给街坊邻里。',
      example_pinyin = 'Cūn lǐ nà wèi shànliáng chúnpǔ de lǎoyéye jīngcháng bǎ zìjiā càiyuán lǐ zhāi de xīnxiān shūcài fēnsòng gěi jiēfang-línlǐ.',
      example_vi = 'Ông lão hiền lành chất phác trong làng thường mang các loại rau tươi hái từ vườn rau nhà mình chia cho bà con lối xóm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '善良',
      'shànliáng',
      'lương thiện, hiền lành, nhân hậu',
      'Tính từ',
      'HSK 5',
      '村里那位善良淳朴的老爷爷经常把自家菜园里摘的新鲜蔬菜分送给街坊邻里。',
      'Cūn lǐ nà wèi shànliáng chúnpǔ de lǎoyéye jīngcháng bǎ zìjiā càiyuán lǐ zhāi de xīnxiān shūcài fēnsòng gěi jiēfang-línlǐ.',
      'Ông lão hiền lành chất phác trong làng thường mang các loại rau tươi hái từ vườn rau nhà mình chia cho bà con lối xóm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '村里那位善良淳朴的老爷爷经常把自家菜园里摘的新鲜蔬菜分送给街坊邻里。', 'Cūn lǐ nà wèi shànliáng chúnpǔ de lǎoyéye jīngcháng bǎ zìjiā càiyuán lǐ zhāi de xīnxiān shūcài fēnsòng gěi jiēfang-línlǐ.', 'Ông lão hiền lành chất phác trong làng thường mang các loại rau tươi hái từ vườn rau nhà mình chia cho bà con lối xóm.', 'basic', 1),
      (v_id, '在充满不确定性与功利诱惑的现代社会，坚守内心深处的善良与道义底线是弥足珍贵的人格特质。', 'Zài chōngmǎn bù-quèdìngxìng yǔ gōnglì yòuhuò de xiàndài shèhuì, jiānshǒu nèixīn shēnchù de shànliáng yǔ dàoyì dǐxiàn shì mǐzú-zhēnguì de réngé tèzhì.', 'Trong xã hội hiện đại ngập tràn những bất định và cám dỗ thực dụng, kiên trì giữ vững sự lương thiện và lằn ranh đạo nghĩa tận sâu thẳm nội tâm là một phẩm chất nhân cách vô cùng quý giá.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2954] [善于] (shànyú) - khéo về, giỏi về, biết cách [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '善于' AND pinyin = 'shànyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '善于' AND pinyin = 'shànyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '善于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '善于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shànyú',
      meaning_vi = 'khéo về, giỏi về, biết cách',
      example_hanzi = '班长善于倾听同学们的不同想法，总能提出大家满意的折中建议。',
      example_pinyin = 'Bānzhǎng shànyú qīngtīng tóngxuémen de bùtóng xiǎngfǎ, zǒng néng tíchū dàjiā mǎnyì de zhézhōng jiànyì.',
      example_vi = 'Lớp trưởng rất biết cách lắng nghe các suy nghĩ khác nhau của các bạn, luôn đưa ra được đề xuất dung hòa khiến mọi người vừa lòng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '善于',
      'shànyú',
      'khéo về, giỏi về, biết cách',
      'Động từ',
      'HSK 5',
      '班长善于倾听同学们的不同想法，总能提出大家满意的折中建议。',
      'Bānzhǎng shànyú qīngtīng tóngxuémen de bùtóng xiǎngfǎ, zǒng néng tíchū dàjiā mǎnyì de zhézhōng jiànyì.',
      'Lớp trưởng rất biết cách lắng nghe các suy nghĩ khác nhau của các bạn, luôn đưa ra được đề xuất dung hòa khiến mọi người vừa lòng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '班长善于倾听同学们的不同想法，总能提出大家满意的折中建议。', 'Bānzhǎng shànyú qīngtīng tóngxuémen de bùtóng xiǎngfǎ, zǒng néng tíchū dàjiā mǎnyì de zhézhōng jiànyì.', 'Lớp trưởng rất biết cách lắng nghe các suy nghĩ khác nhau của các bạn, luôn đưa ra được đề xuất dung hòa khiến mọi người vừa lòng.', 'basic', 1),
      (v_id, '优秀的科研领军学者善于从错综复杂的实验失败表象中敏锐洞察潜在规律，进而开启突破性创新方向。', 'Yōuxiù de kēyán lǐngjūn xuézhě shànyú cóng cuòzōng-fùzá de shíyàn shībài biǎoxiàng zhōng mǐnruì dòngchá qiánzài guīlǜ, jìn’ér kāiqǐ tūpòxìng chuàngxīn fāngxiàng.', 'Nhà khoa học dẫn đầu xuất sắc rất biết cách nhìn thấu các quy luật tiềm ẩn từ những hiện tượng thất bại thí nghiệm chằng chịt phức tạp, từ đó mở ra những hướng đổi mới mang tính đột phá.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2955] [扇子] (shànzi) - cây quạt, chiếc quạt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '扇子' AND pinyin = 'shànzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '扇子' AND pinyin = 'shànzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '扇子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '扇子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shànzi',
      meaning_vi = 'cây quạt, chiếc quạt',
      example_hanzi = '夏天天气炎热，爷爷手里拿着一把精致的折叠纸扇子纳凉。',
      example_pinyin = 'Xiàtiān tiānqì yánrè, yéye shǒu lǐ ná zhe yì bǎ jīngzhì de zhédié zhǐ shànzi nàliáng.',
      example_vi = 'Thời tiết mùa hè nóng bức, ông cầm trên tay một chiếc quạt giấy gấp tinh xảo để hóng mát.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '扇子',
      'shànzi',
      'cây quạt, chiếc quạt',
      'Danh từ',
      'HSK 5',
      '夏天天气炎热，爷爷手里拿着一把精致的折叠纸扇子纳凉。',
      'Xiàtiān tiānqì yánrè, yéye shǒu lǐ ná zhe yì bǎ jīngzhì de zhédié zhǐ shànzi nàliáng.',
      'Thời tiết mùa hè nóng bức, ông cầm trên tay một chiếc quạt giấy gấp tinh xảo để hóng mát.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夏天天气炎热，爷爷手里拿着一把精致的折叠纸扇子纳凉。', 'Xiàtiān tiānqì yánrè, yéye shǒu lǐ ná zhe yì bǎ jīngzhì de zhédié zhǐ shànzi nàliáng.', 'Thời tiết mùa hè nóng bức, ông cầm trên tay một chiếc quạt giấy gấp tinh xảo để hóng mát.', 'basic', 1),
      (v_id, '苏州制扇工艺以紫檀、水磨竹骨与精妙书法微雕相融合，使得原本日常使用的扇子升华为极具收藏价值的高雅艺术品。', 'Sūzhōu zhìshàn gōngyì yǐ zǐtán, shuǐmò zhúgǔ yǔ jīngmiào shūfǎ wēidiāo xiāng rónghé, shǐde yuánběn rìcháng shǐyòng de shànzi shēnghuá wèi jí jù shōucáng jiàzhí de gāoyǎ yìshùpǐn.', 'Kỹ nghệ làm quạt Tô Châu kết hợp hài hòa giữa gỗ tử đàn, nan tre mài bóng và nghệ thuật vi chạm thư pháp tinh diệu, khiến chiếc quạt dùng hàng ngày ban đầu thăng hoa thành tác phẩm nghệ thuật tao nhã có giá trị sưu tầm cực cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2956] [伤] (shāng) - vết thương; làm bị thương, làm tổn thương [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '伤' AND pinyin = 'shāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伤' AND pinyin = 'shāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '伤'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伤'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'shāng',
      meaning_vi = 'vết thương; làm bị thương, làm tổn thương',
      example_hanzi = '他在打篮球时不小心扭伤了脚踝，校医及时为他冷敷处理伤处。',
      example_pinyin = 'Tā zài dǎ lánqiú shí bù xiǎoxīn niǔshāng le jiǎohuái, xiàoyī jíshí wèi tā lěngfū chǔlǐ shāngchù.',
      example_vi = 'Khi chơi bóng rổ anh ấy sơ ý bị trẹo mắt cá chân, bác sĩ trường đã kịp thời chườm lạnh xử lý chỗ vết thương cho anh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '伤',
      'shāng',
      'vết thương; làm bị thương, làm tổn thương',
      'Danh từ / Động từ',
      'HSK 5',
      '他在打篮球时不小心扭伤了脚踝，校医及时为他冷敷处理伤处。',
      'Tā zài dǎ lánqiú shí bù xiǎoxīn niǔshāng le jiǎohuái, xiàoyī jíshí wèi tā lěngfū chǔlǐ shāngchù.',
      'Khi chơi bóng rổ anh ấy sơ ý bị trẹo mắt cá chân, bác sĩ trường đã kịp thời chườm lạnh xử lý chỗ vết thương cho anh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在打篮球时不小心扭伤了脚踝，校医及时为他冷敷处理伤处。', 'Tā zài dǎ lánqiú shí bù xiǎoxīn niǔshāng le jiǎohuái, xiàoyī jíshí wèi tā lěngfū chǔlǐ shāngchù.', 'Khi chơi bóng rổ anh ấy sơ ý bị trẹo mắt cá chân, bác sĩ trường đã kịp thời chườm lạnh xử lý chỗ vết thương cho anh.', 'basic', 1),
      (v_id, '未经事实核查的虚假网络谣言往往对当事人的商业信誉和心理健康造成难以挽回的严重名誉伤痛。', 'Wèijīng shìshí héchá de xūjiǎ wǎngluò yáoyán wǎngwǎng duì dāngshìrén de shāngyè xìnyù hé xīnlǐ jiànkāng zàochéng nányǐ wǎnhuí de yánzhòng míngyù shāngtòng.', 'Những tin đồn thất thiệt trên mạng chưa qua kiểm chứng sự thật thường gây ra nỗi tổn thương danh dự nghiêm trọng khó lòng vãn hồi cho uy tín thương mại và sức khỏe tâm lý của người trong cuộc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2957] [伤害] (shānghài) - làm hại, gây tổn thương, xâm hại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '伤害' AND pinyin = 'shānghài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伤害' AND pinyin = 'shānghài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '伤害'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伤害'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shānghài',
      meaning_vi = 'làm hại, gây tổn thương, xâm hại',
      example_hanzi = '在发生口角争执时，切勿说出伤感情的过激话语来伤害身边的人。',
      example_pinyin = 'Zài fāshēng kǒujiǎo zhēngzhì shí, qiè wù shuō chū shāng gǎnqíng de guòjī huàyǔ lái shānghài shēnbiān de rén.',
      example_vi = 'Khi xảy ra tranh cãi khẩu thiệt, tuyệt đối chớ nói ra những lời quá khích làm tổn hại tình cảm khiến người bên cạnh bị tổn thương.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '伤害',
      'shānghài',
      'làm hại, gây tổn thương, xâm hại',
      'Động từ',
      'HSK 5',
      '在发生口角争执时，切勿说出伤感情的过激话语来伤害身边的人。',
      'Zài fāshēng kǒujiǎo zhēngzhì shí, qiè wù shuō chū shāng gǎnqíng de guòjī huàyǔ lái shānghài shēnbiān de rén.',
      'Khi xảy ra tranh cãi khẩu thiệt, tuyệt đối chớ nói ra những lời quá khích làm tổn hại tình cảm khiến người bên cạnh bị tổn thương.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在发生口角争执时，切勿说出伤感情的过激话语来伤害身边的人。', 'Zài fāshēng kǒujiǎo zhēngzhì shí, qiè wù shuō chū shāng gǎnqíng de guòjī huàyǔ lái shānghài shēnbiān de rén.', 'Khi xảy ra tranh cãi khẩu thiệt, tuyệt đối chớ nói ra những lời quá khích làm tổn hại tình cảm khiến người bên cạnh bị tổn thương.', 'basic', 1),
      (v_id, '严格禁止任何形式的工业污水偷排超排行为，杜绝对沿河流域珍稀水生生物种群造成不可逆的生态伤害。', 'Yángé jìnzhǐ rènhé xíngshì de gōngyè wūshuǐ tōupái chāopái xíngwéi, dùjué duì yánhé liùyù zhēnxī shuǐshēng shēngwù zhǒngqún zàochéng bùkě nì de shēngtài shānghài.', 'Nghiêm cấm mọi hành vi xả trộm và xả thải quá mức nước thải công nghiệp, triệt để ngăn chặn gây ra tổn thương sinh thái không thể đảo ngược đối với các quần xã sinh vật thủy sinh quý hiếm dọc lưu vực sông.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2958] [商家] (shāngjiā) - thương gia, người kinh doanh, bên bán hàng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '商家' AND pinyin = 'shāngjiā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '商家' AND pinyin = 'shāngjiā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '商家'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '商家'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shāngjiā',
      meaning_vi = 'thương gia, người kinh doanh, bên bán hàng',
      example_hanzi = '购物节期间，许多线上电商商家纷纷推出了满减折扣和免运费优惠活动。',
      example_pinyin = 'Gòuwùjié qījiān, xǔduō xiànshàng diànshāng shāngjiā fēnfēn tuīchū le mǎnjiǎn zhékòu hé miǎn yùnfèi yōuhuì huódòng.',
      example_vi = 'Trong dịp lễ hội mua sắm, rất nhiều đơn vị bán lẻ thương mại điện tử trực tuyến rầm rộ tung ra các chương trình ưu đãi chiết khấu giảm giá và miễn phí vận chuyển.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '商家',
      'shāngjiā',
      'thương gia, người kinh doanh, bên bán hàng',
      'Danh từ',
      'HSK 5',
      '购物节期间，许多线上电商商家纷纷推出了满减折扣和免运费优惠活动。',
      'Gòuwùjié qījiān, xǔduō xiànshàng diànshāng shāngjiā fēnfēn tuīchū le mǎnjiǎn zhékòu hé miǎn yùnfèi yōuhuì huódòng.',
      'Trong dịp lễ hội mua sắm, rất nhiều đơn vị bán lẻ thương mại điện tử trực tuyến rầm rộ tung ra các chương trình ưu đãi chiết khấu giảm giá và miễn phí vận chuyển.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '购物节期间，许多线上电商商家纷纷推出了满减折扣和免运费优惠活动。', 'Gòuwùjié qījiān, xǔduō xiànshàng diànshāng shāngjiā fēnfēn tuīchū le mǎnjiǎn zhékòu hé miǎn yùnfèi yōuhuì huódòng.', 'Trong dịp lễ hội mua sắm, rất nhiều đơn vị bán lẻ thương mại điện tử trực tuyến rầm rộ tung ra các chương trình ưu đãi chiết khấu giảm giá và miễn phí vận chuyển.', 'basic', 1),
      (v_id, '市场监管部门督促数字平台建立健全商家准入资质审核与全流程消费者权益保护兜底机制。', 'Shìchǎng jiānguǎn bùmén dūcù shùzì píngtái jiànlì jiànquán shāngjiā zhǔnrù zīzhì shěnhé yǔ quán-liúchéng xiāofèizhě quányì bǎohù dōudǐ jīzhì.', 'Cơ quan quản lý thị trường đốc thúc các nền tảng số xây dựng và hoàn thiện cơ chế thẩm tra tư cách tiếp cận của thương gia cùng cơ chế bảo vệ quyền lợi người tiêu dùng toàn trình dự phòng cuối cùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2959] [商人] (shāngrén) - thương nhân, người buôn bán, doanh nhân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '商人' AND pinyin = 'shāngrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '商人' AND pinyin = 'shāngrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '商人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '商人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shāngrén',
      meaning_vi = 'thương nhân, người buôn bán, doanh nhân',
      example_hanzi = '他是一位守法经营、讲究诚信的布料批发商人。',
      example_pinyin = 'Tā shì yí wèi shǒufǎ jīngyíng, jiǎngjiu chéngxìn de bùliào pīfā shāngrén.',
      example_vi = 'Ông ấy là một thương nhân bán buôn vải vóc kinh doanh tuân thủ pháp luật và coi trọng chữ tín.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '商人',
      'shāngrén',
      'thương nhân, người buôn bán, doanh nhân',
      'Danh từ',
      'HSK 5',
      '他是一位守法经营、讲究诚信的布料批发商人。',
      'Tā shì yí wèi shǒufǎ jīngyíng, jiǎngjiu chéngxìn de bùliào pīfā shāngrén.',
      'Ông ấy là một thương nhân bán buôn vải vóc kinh doanh tuân thủ pháp luật và coi trọng chữ tín.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他是一位守法经营、讲究诚信的布料批发商人。', 'Tā shì yí wèi shǒufǎ jīngyíng, jiǎngjiu chéngxìn de bùliào pīfā shāngrén.', 'Ông ấy là một thương nhân bán buôn vải vóc kinh doanh tuân thủ pháp luật và coi trọng chữ tín.', 'basic', 1),
      (v_id, '古丝绸之路上络绎不绝的跨国商人不仅促进了物质财富交换，更架起了东西方文明互学互鉴的友谊桥梁。', 'Gǔ Sīchóu zhī Lù shang luòyì-bùjué de kuàguó shāngrén bùjǐn cùjìn le wùzhì cáifù jiāohuàn, gèng jià qǐ le dōng-xīfāng wénmíng hùxué-hùjiàn de yǒuyì qiáoliáng.', 'Những đoàn thương nhân xuyên quốc gia nườm nượp qua lại trên Con đường Tơ lụa cổ xưa không chỉ thúc đẩy trao đổi của cải vật chất mà còn bắc nên nhịp cầu hữu nghị giao lưu học hỏi lẫn nhau giữa các nền văn minh Đông Tây.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2960] [商务] (shāngwù) - thương vụ, công việc kinh doanh, nghiệp vụ thương mại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '商务' AND pinyin = 'shāngwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '商务' AND pinyin = 'shāngwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '商务'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '商务'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shāngwù',
      meaning_vi = 'thương vụ, công việc kinh doanh, nghiệp vụ thương mại',
      example_hanzi = '他下周一将乘高铁前往邻省省会参加一场重要的商务洽谈会。',
      example_pinyin = 'Tā xià zhōuyī jiāng chéng gāotiě qiánwǎng lín shěng shěnghuì cānjiā yì chǎng zhòngyào de shāngwù qiàtánhuì.',
      example_vi = 'Thứ Hai tuần tới anh ấy sẽ đi tàu cao tốc đến thủ phủ tỉnh lân cận để tham dự một buổi đàm phán thương vụ quan trọng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '商务',
      'shāngwù',
      'thương vụ, công việc kinh doanh, nghiệp vụ thương mại',
      'Danh từ',
      'HSK 5',
      '他下周一将乘高铁前往邻省省会参加一场重要的商务洽谈会。',
      'Tā xià zhōuyī jiāng chéng gāotiě qiánwǎng lín shěng shěnghuì cānjiā yì chǎng zhòngyào de shāngwù qiàtánhuì.',
      'Thứ Hai tuần tới anh ấy sẽ đi tàu cao tốc đến thủ phủ tỉnh lân cận để tham dự một buổi đàm phán thương vụ quan trọng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他下周一将乘高铁前往邻省省会参加一场重要的商务洽谈会。', 'Tā xià zhōuyī jiāng chéng gāotiě qiánwǎng lín shěng shěnghuì cānjiā yì chǎng zhòngyào de shāngwù qiàtánhuì.', 'Thứ Hai tuần tới anh ấy sẽ đi tàu cao tốc đến thủ phủ tỉnh lân cận để tham dự một buổi đàm phán thương vụ quan trọng.', 'basic', 1),
      (v_id, '国家跨境电子商务综合试验区通过制度创新与通关提速，有力推动了数字贸易与国际商务合作的高水平发展。', 'Guójiā kuàjìng diànzǐ shāngwù zōnghé shìyànqū tōngguò zhìdù chuàngxīn yǔ tōngguān tísù, yǒulì tuīdòng le shùzì màoyì yǔ guójì shāngwù hézuò de gāo-shuǐpíng fāzhǎn.', 'Khu thí điểm toàn diện thương mại điện tử xuyên biên giới quốc gia thông qua đổi mới thể chế và tăng tốc thông quan đã thúc đẩy mạnh mẽ sự phát triển trình độ cao của thương mại số và hợp tác thương vụ quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2961] [商业] (shāngyè) - thương nghiệp, kinh doanh thương mại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '商业' AND pinyin = 'shāngyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '商业' AND pinyin = 'shāngyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '商业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '商业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shāngyè',
      meaning_vi = 'thương nghiệp, kinh doanh thương mại',
      example_hanzi = '市中心新建的商业综合体吸引了众多餐饮和时尚零售品牌入驻。',
      example_pinyin = 'Shì zhōngxīn xīn jiàn de shāngyè zōnghétǐ xīyǐn le zhòngduō cānyǐn hé shíshàng língshòu pǐnpái rùzhù.',
      example_vi = 'Tổ hợp thương mại mới xây dựng ở trung tâm thành phố đã thu hút đông đảo các thương hiệu ẩm thực và bán lẻ thời trang tới đặt gian hàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '商业',
      'shāngyè',
      'thương nghiệp, kinh doanh thương mại',
      'Danh từ',
      'HSK 5',
      '市中心新建的商业综合体吸引了众多餐饮和时尚零售品牌入驻。',
      'Shì zhōngxīn xīn jiàn de shāngyè zōnghétǐ xīyǐn le zhòngduō cānyǐn hé shíshàng língshòu pǐnpái rùzhù.',
      'Tổ hợp thương mại mới xây dựng ở trung tâm thành phố đã thu hút đông đảo các thương hiệu ẩm thực và bán lẻ thời trang tới đặt gian hàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '市中心新建的商业综合体吸引了众多餐饮和时尚零售品牌入驻。', 'Shì zhōngxīn xīn jiàn de shāngyè zōnghétǐ xīyǐn le zhòngduō cānyǐn hé shíshàng língshòu pǐnpái rùzhù.', 'Tổ hợp thương mại mới xây dựng ở trung tâm thành phố đã thu hút đông đảo các thương hiệu ẩm thực và bán lẻ thời trang tới đặt gian hàng.', 'basic', 1),
      (v_id, '如何将前沿实验室前瞻科研成果转化为具备成熟商业变现前景的产业产品，是科技成果转化的核心难点。', 'Rúhé jiāng qiányán shíyànshì qiánzhān kēyán chéngguǒ zhuǎnhuà wèi jùbèi chéngshú shāngyè biànxiàn qiánjǐng de chǎnyè chǎnpǐn, shì kējì chéngguǒ zhuǎnhuà de héxīn nándiǎn.', 'Làm thế nào để chuyển hóa các thành quả nghiên cứu khoa học mang tính đón đầu từ các phòng thí nghiệm mũi nhọn thành sản phẩm công nghiệp có triển vọng hiện thực hóa thương mại chín muồi là khó khăn cốt lõi của công tác chuyển giao công nghệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2962] [赏] (shǎng) - thưởng, ngắm, thưởng thức [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '赏' AND pinyin = 'shǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赏' AND pinyin = 'shǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '赏'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '赏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shǎng',
      meaning_vi = 'thưởng, ngắm, thưởng thức',
      example_hanzi = '中秋之夜，全家人坐在院子里一边吃月饼，一边赏月。',
      example_pinyin = 'Zhōngqiū zhī yè, quán jiā rén zuò zài yuànzi lǐ yìbiān chī yuèbǐng, yìbiān shǎng yuè.',
      example_vi = 'Đêm Trung thu, cả gia đình ngồi trong sân nhà vừa ăn bánh trung thu vừa cùng nhau ngắm trăng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '赏',
      'shǎng',
      'thưởng, ngắm, thưởng thức',
      'Động từ',
      'HSK 5',
      '中秋之夜，全家人坐在院子里一边吃月饼，一边赏月。',
      'Zhōngqiū zhī yè, quán jiā rén zuò zài yuànzi lǐ yìbiān chī yuèbǐng, yìbiān shǎng yuè.',
      'Đêm Trung thu, cả gia đình ngồi trong sân nhà vừa ăn bánh trung thu vừa cùng nhau ngắm trăng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中秋之夜，全家人坐在院子里一边吃月饼，一边赏月。', 'Zhōngqiū zhī yè, quán jiā rén zuò zài yuànzi lǐ yìbiān chī yuèbǐng, yìbiān shǎng yuè.', 'Đêm Trung thu, cả gia đình ngồi trong sân nhà vừa ăn bánh trung thu vừa cùng nhau ngắm trăng.', 'basic', 1),
      (v_id, '中国古典园林通过借景、漏窗与步移景异的精妙构思，为游人营造出可居、可行、可赏的深远诗意境界。', 'Zhōngguó gǔdiǎn yuánlín tōngguò jièjǐng, lòuchuāng yǔ bùyí-jǐngyì de jīngmiào gòusī, wèi yóurén yíngzào chū kě jū, kě xíng, kě shǎng de shēnyuǎn shīyì jìngjiè.', 'Vườn hoa cổ điển Trung Hoa thông qua ý tưởng tinh xảo về mượn cảnh, ô thoáng hoa văn và mỗi bước chuyển cảnh khác nhau đã tạo nên cho du khách một cảnh giới thi vị sâu xa có thể an cư, có thể dạo bước và có thể thưởng ngoạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2963] [上传] (shàngchuán) - tải lên, upload [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '上传' AND pinyin = 'shàngchuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '上传' AND pinyin = 'shàngchuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '上传'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '上传'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shàngchuán',
      meaning_vi = 'tải lên, upload',
      example_hanzi = '请同学们在周五下午五点前将写好的课程论文上传至教学平台。',
      example_pinyin = 'Qǐng tóngxuémen zài zhōuwǔ xiàwǔ wǔ diǎn qián jiāng xiě hǎo de kèchéng lùnwén shàngchuán zhì jiàoxué píngtái.',
      example_vi = 'Xin mời các bạn học sinh tải bài luận môn học đã viết xong lên nền tảng dạy học trước năm giờ chiều thứ Sáu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '上传',
      'shàngchuán',
      'tải lên, upload',
      'Động từ',
      'HSK 5',
      '请同学们在周五下午五点前将写好的课程论文上传至教学平台。',
      'Qǐng tóngxuémen zài zhōuwǔ xiàwǔ wǔ diǎn qián jiāng xiě hǎo de kèchéng lùnwén shàngchuán zhì jiàoxué píngtái.',
      'Xin mời các bạn học sinh tải bài luận môn học đã viết xong lên nền tảng dạy học trước năm giờ chiều thứ Sáu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请同学们在周五下午五点前将写好的课程论文上传至教学平台。', 'Qǐng tóngxuémen zài zhōuwǔ xiàwǔ wǔ diǎn qián jiāng xiě hǎo de kèchéng lùnwén shàngchuán zhì jiàoxué píngtái.', 'Xin mời các bạn học sinh tải bài luận môn học đã viết xong lên nền tảng dạy học trước năm giờ chiều thứ Sáu.', 'basic', 1),
      (v_id, '基于边缘计算的工业传感器能够将采集的实时震动频谱加密上传至工业互联网云平台进行深度预测性故障诊断。', 'Jīyú biānyuán jìsuàn de gōngyè chuángǎnqì nénggòu jiāng cǎijí de shíshí zhèndòng pīnpǔ jiāmì shàngchuán zhì gōngyè hùliánwǎng yún píngtái jìnxíng shēndù yùcèxìng gùzhàng zhěnduàn.', 'Cảm biến công nghiệp dựa trên điện toán biên có thể mã hóa tải lên phổ rung chấn theo thời gian thực thu thập được lên nền tảng đám mây Internet công nghiệp để tiến hành chẩn đoán sự cố dự đoán chuyên sâu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2964] [上升] (shàngshēng) - tăng lên, đi lên, dâng lên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '上升' AND pinyin = 'shàngshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '上升' AND pinyin = 'shàngshēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '上升'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '上升'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shàngshēng',
      meaning_vi = 'tăng lên, đi lên, dâng lên',
      example_hanzi = '太阳升起后，山间清晨的温度开始慢慢上升。',
      example_pinyin = 'Tàiyáng shēngqǐ hòu, shānjiān qīngchén de wēndù kāishǐ mànmàn shàngshēng.',
      example_vi = 'Sau khi mặt trời mọc, nhiệt độ buổi sáng sớm giữa vùng núi bắt đầu từ từ ấm dần lên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '上升',
      'shàngshēng',
      'tăng lên, đi lên, dâng lên',
      'Động từ',
      'HSK 5',
      '太阳升起后，山间清晨的温度开始慢慢上升。',
      'Tàiyáng shēngqǐ hòu, shānjiān qīngchén de wēndù kāishǐ mànmàn shàngshēng.',
      'Sau khi mặt trời mọc, nhiệt độ buổi sáng sớm giữa vùng núi bắt đầu từ từ ấm dần lên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '太阳升起后，山间清晨的温度开始慢慢上升。', 'Tàiyáng shēngqǐ hòu, shānjiān qīngchén de wēndù kāishǐ mànmàn shàngshēng.', 'Sau khi mặt trời mọc, nhiệt độ buổi sáng sớm giữa vùng núi bắt đầu từ từ ấm dần lên.', 'basic', 1),
      (v_id, '随着高附加值高端装备制造与现代生产性服务业的深度融合，制造业全员劳动生产率呈现稳步上升趋势。', 'Suízhe gāo-fùjiāzhí gāoduān zhuāngbèi zhìzào yǔ xiàndài shēngchǎnxìng fúwùyè de shēndù rónghé, zhìzàoyè quányuán láodòng shēngchǎnlǜ chéngxiàn wěnbù shàngshēng qūshì.', 'Cùng với sự hội nhập sâu sắc giữa sản xuất trang thiết bị cao cấp giá trị gia tăng cao và ngành dịch vụ sản xuất hiện đại, năng suất lao động của toàn bộ nhân lực ngành chế tạo đang thể hiện xu thế tăng trưởng vững chắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2965] [上下] (shàngxià) - trên dưới; khoảng chừng, xấp xỉ [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '上下' AND pinyin = 'shàngxià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '上下' AND pinyin = 'shàngxià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '上下'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '上下'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Phó từ',
      pinyin = 'shàngxià',
      meaning_vi = 'trên dưới; khoảng chừng, xấp xỉ',
      example_hanzi = '站在高耸的山峰顶端极目远眺，山峰上下到处是一片郁郁葱葱的林海。',
      example_pinyin = 'Zhàn zài gāosǒng de shānfēng dǐngduān jímù-yuǎntiào, shānfēng shàngxià dàochù shì yí piàn yùyù-cōngcōng de línhǎi.',
      example_vi = 'Đứng trên đỉnh núi cao chót vót phóng tầm mắt ra xa, khắp trên dưới ngọn núi đâu đâu cũng là một biển rừng xanh tươi mướt mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '上下',
      'shàngxià',
      'trên dưới; khoảng chừng, xấp xỉ',
      'Danh từ / Phó từ',
      'HSK 5',
      '站在高耸的山峰顶端极目远眺，山峰上下到处是一片郁郁葱葱的林海。',
      'Zhàn zài gāosǒng de shānfēng dǐngduān jímù-yuǎntiào, shānfēng shàngxià dàochù shì yí piàn yùyù-cōngcōng de línhǎi.',
      'Đứng trên đỉnh núi cao chót vót phóng tầm mắt ra xa, khắp trên dưới ngọn núi đâu đâu cũng là một biển rừng xanh tươi mướt mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '站在高耸的山峰顶端极目远眺，山峰上下到处是一片郁郁葱葱的林海。', 'Zhàn zài gāosǒng de shānfēng dǐngduān jímù-yuǎntiào, shānfēng shàngxià dàochù shì yí piàn yùyù-cōngcōng de línhǎi.', 'Đứng trên đỉnh núi cao chót vót phóng tầm mắt ra xa, khắp trên dưới ngọn núi đâu đâu cũng là một biển rừng xanh tươi mướt mắt.', 'basic', 1),
      (v_id, '全厂上下团结一心紧密协作，终于在规定工期内保质保量完成了重大出口设备的交付任务。', 'Quán chǎng shàngxià tuánjié-yìxīn jǐnmì xiézuò, zhōngyú zài guīdìng gōngqī nèi bǎozhì-bǎoliàng wánchéng le zhòngdà chūkǒu shèbèi de jiāofù rènwù.', 'Toàn thể trên dưới nhà máy đồng lòng đoàn kết phối hợp chặt chẽ, cuối cùng đã hoàn thành nhiệm vụ bàn giao thiết bị xuất khẩu trọng điểm đúng chất lượng và số lượng trong thời hạn thi công quy định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2966] [上涨] (shàngzhǎng) - tăng giá, nước dâng lên, leo thang [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '上涨' AND pinyin = 'shàngzhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '上涨' AND pinyin = 'shàngzhǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '上涨'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '上涨'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shàngzhǎng',
      meaning_vi = 'tăng giá, nước dâng lên, leo thang',
      example_hanzi = '受持续暴雨天气影响，流经本市的河流水位出现了明显上涨。',
      example_pinyin = 'Shòu chíxù bàoyǔ tiānqì yǐngxiǎng, liújīng běn shì de héliú shuǐwèi chūxiàn le míngxiǎn shàngzhǎng.',
      example_vi = 'Do chịu ảnh hưởng của thời tiết mưa lớn kéo dài, mực nước sông chảy qua thành phố đã dâng lên rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '上涨',
      'shàngzhǎng',
      'tăng giá, nước dâng lên, leo thang',
      'Động từ',
      'HSK 5',
      '受持续暴雨天气影响，流经本市的河流水位出现了明显上涨。',
      'Shòu chíxù bàoyǔ tiānqì yǐngxiǎng, liújīng běn shì de héliú shuǐwèi chūxiàn le míngxiǎn shàngzhǎng.',
      'Do chịu ảnh hưởng của thời tiết mưa lớn kéo dài, mực nước sông chảy qua thành phố đã dâng lên rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '受持续暴雨天气影响，流经本市的河流水位出现了明显上涨。', 'Shòu chíxù bàoyǔ tiānqì yǐngxiǎng, liújīng běn shì de héliú shuǐwèi chūxiàn le míngxiǎn shàngzhǎng.', 'Do chịu ảnh hưởng của thời tiết mưa lớn kéo dài, mực nước sông chảy qua thành phố đã dâng lên rõ rệt.', 'basic', 1),
      (v_id, '国际大宗能源原材料价格的大幅上涨，给中下游制造业企业的生产经营成本带来了显著的输入型通胀压力。', 'Guójì dàzōng néngyuán yuáncáiliào jiàgé de dàfú shàngzhǎng, gěi zhōng-xiàyóu zhìzàoyè qǐyè de shēngchǎn jīngyíng chéngběn dài lái le xiǎnzhù de shūrùxíng tōngzhàng yālì.', 'Giá cả các mặt hàng nguyên liệu thô năng lượng số lượng lớn quốc tế tăng vọt đã tạo nên áp lực lạm phát nhập khẩu rõ rệt đối với chi phí sản xuất kinh doanh của các doanh nghiệp chế tạo trung và hạ nguồn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2967] [烧] (shāo) - nấu, đốt, nướng, đun [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '烧' AND pinyin = 'shāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '烧' AND pinyin = 'shāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '烧'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '烧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shāo',
      meaning_vi = 'nấu, đốt, nướng, đun',
      example_hanzi = '天气转凉，妈妈特意在厨房里为全家人烧了一锅热气腾腾的排骨汤。',
      example_pinyin = 'Tiānqì zhuǎn liáng, māma tèyì zài chúfáng lǐ wèi quán jiā rén shāo le yì guō rèqì-téngténg de páigǔtāng.',
      example_vi = 'Trời trở lạnh, mẹ đã đặc biệt vào bếp nấu cho cả nhà một nồi canh sườn nghi ngút khói nóng hổi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '烧',
      'shāo',
      'nấu, đốt, nướng, đun',
      'Động từ',
      'HSK 5',
      '天气转凉，妈妈特意在厨房里为全家人烧了一锅热气腾腾的排骨汤。',
      'Tiānqì zhuǎn liáng, māma tèyì zài chúfáng lǐ wèi quán jiā rén shāo le yì guō rèqì-téngténg de páigǔtāng.',
      'Trời trở lạnh, mẹ đã đặc biệt vào bếp nấu cho cả nhà một nồi canh sườn nghi ngút khói nóng hổi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天气转凉，妈妈特意在厨房里为全家人烧了一锅热气腾腾的排骨汤。', 'Tiānqì zhuǎn liáng, māma tèyì zài chúfáng lǐ wèi quán jiā rén shāo le yì guō rèqì-téngténg de páigǔtāng.', 'Trời trở lạnh, mẹ đã đặc biệt vào bếp nấu cho cả nhà một nồi canh sườn nghi ngút khói nóng hổi.', 'basic', 1),
      (v_id, '利用工业固体废弃物协同烧制新型低碳高强度水泥熟料，是水泥建材产业实现资源化绿色循环的关键路径。', 'Lìyòng gōngyè gùtǐ fèiqìwù xiétóng shāozhì xīnxíng dītàn gāo-qiángdù shuǐní shúliào, shì shuǐní jiàncái chǎnyè shíxiàn zīyuánhuà lǜsè xúnhuán de guānjiàn lùjìng.', 'Tận dụng chất thải rắn công nghiệp để phối hợp nung luyện clinker xi măng cường độ cao ít carbon kiểu mới là con đường then chốt để ngành vật liệu xây dựng xi măng hiện thực hóa tuần hoàn xanh tài nguyên hóa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2968] [烧烤] (shāokǎo) - đồ nướng, món thịt nướng BBQ [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '烧烤' AND pinyin = 'shāokǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '烧烤' AND pinyin = 'shāokǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '烧烤'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '烧烤'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'shāokǎo',
      meaning_vi = 'đồ nướng, món thịt nướng BBQ',
      example_hanzi = '周末几位好友相约去郊外露营，大家在草地上支起架子开心地吃烧烤。',
      example_pinyin = 'Zhōumò jǐ wèi hǎoyǒu xiāngyuē qù jiāowài lùyíng, dàjiā zài cǎodì shang zhī qǐ jiàzi kāixīn de chī shāokǎo.',
      example_vi = 'Dịp cuối tuần mấy người bạn thân hẹn nhau đi cắm trại ở ngoại ô, mọi người dựng bếp nướng trên bãi cỏ vui vẻ thưởng thức đồ nướng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '烧烤',
      'shāokǎo',
      'đồ nướng, món thịt nướng BBQ',
      'Danh từ / Động từ',
      'HSK 5',
      '周末几位好友相约去郊外露营，大家在草地上支起架子开心地吃烧烤。',
      'Zhōumò jǐ wèi hǎoyǒu xiāngyuē qù jiāowài lùyíng, dàjiā zài cǎodì shang zhī qǐ jiàzi kāixīn de chī shāokǎo.',
      'Dịp cuối tuần mấy người bạn thân hẹn nhau đi cắm trại ở ngoại ô, mọi người dựng bếp nướng trên bãi cỏ vui vẻ thưởng thức đồ nướng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末几位好友相约去郊外露营，大家在草地上支起架子开心地吃烧烤。', 'Zhōumò jǐ wèi hǎoyǒu xiāngyuē qù jiāowài lùyíng, dàjiā zài cǎodì shang zhī qǐ jiàzi kāixīn de chī shāokǎo.', 'Dịp cuối tuần mấy người bạn thân hẹn nhau đi cắm trại ở ngoại ô, mọi người dựng bếp nướng trên bãi cỏ vui vẻ thưởng thức đồ nướng.', 'basic', 1),
      (v_id, '城市夜间经济的发展应当平衡市井烟火气与环保秩序，推广无烟环保烧烤设备以有效遏制油烟扰民问题。', 'Chéngshì yèjiān jīngjì de fāzhǎn yīngdāng pínghéng shìjǐng yānhuǒqì yǔ huánbǎo zhìxù, tuīguǎng wúyān huánbǎo shāokǎo shèbèi yǐ yǒuxiào èzhì yóuyān rǎomín wèntí.', 'Sự phát triển của kinh tế đêm đô thị cần cân bằng giữa nét sinh động phố thị đời thường và trật tự bảo vệ môi trường, nhân rộng thiết bị nướng BBQ không khói bảo vệ môi trường để ngăn chặn hiệu quả vấn đề khói dầu làm phiền người dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2969] [蛇] (shé) - con rắn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '蛇' AND pinyin = 'shé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '蛇' AND pinyin = 'shé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '蛇'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '蛇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shé',
      meaning_vi = 'con rắn',
      example_hanzi = '在野外树林徒步旅行时要多加小心，避免被草丛中隐匿的毒蛇咬伤。',
      example_pinyin = 'Zài yěwài shùlín túbù lǚxíng shí yào duō jiā xiǎoxīn, bìmiǎn bèi cǎocóng zhōng yǐnnì de dúshé yǎoshāng.',
      example_vi = 'Khi đi bộ dã ngoại trong rừng cần hết sức cẩn thận, tránh để bị rắn độc ẩn mình trong bụi cỏ cắn phải.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '蛇',
      'shé',
      'con rắn',
      'Danh từ',
      'HSK 5',
      '在野外树林徒步旅行时要多加小心，避免被草丛中隐匿的毒蛇咬伤。',
      'Zài yěwài shùlín túbù lǚxíng shí yào duō jiā xiǎoxīn, bìmiǎn bèi cǎocóng zhōng yǐnnì de dúshé yǎoshāng.',
      'Khi đi bộ dã ngoại trong rừng cần hết sức cẩn thận, tránh để bị rắn độc ẩn mình trong bụi cỏ cắn phải.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在野外树林徒步旅行时要多加小心，避免被草丛中隐匿的毒蛇咬伤。', 'Zài yěwài shùlín túbù lǚxíng shí yào duō jiā xiǎoxīn, bìmiǎn bèi cǎocóng zhōng yǐnnì de dúshé yǎoshāng.', 'Khi đi bộ dã ngoại trong rừng cần hết sức cẩn thận, tránh để bị rắn độc ẩn mình trong bụi cỏ cắn phải.', 'basic', 1),
      (v_id, '现代生物医药科研人员从剧毒蛇毒蛋白组分中分离出具备强效抗凝血特性的活性多肽，用于研发新一代抗血栓靶向药物。', 'Xiàndài shēngwù yīyào kēyán rényuán cóng jùdú shédú dànbái zǔfēn zhōng fēnlí chū jùbèi qiángxiào kàng-níngxuè tèxìng de huóxìng duōtài, yòngyú yánfā xīn yí dài kàng-xuèshuān bǎxiàng yàowù.', 'Các cán bộ nghiên cứu y sinh học hiện đại đã tách chiết được các peptide hoạt tính có đặc tính chống đông máu cực mạnh từ các thành phần protein trong nọc rắn kịch độc, ứng dụng để nghiên cứu phát triển thế hệ thuốc đích chống huyết khối mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2970] [舍不得] (shěbude) - không nỡ, luyến tiếc, không đành lòng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '舍不得' AND pinyin = 'shěbude'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舍不得' AND pinyin = 'shěbude'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '舍不得'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舍不得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shěbude',
      meaning_vi = 'không nỡ, luyến tiếc, không đành lòng',
      example_hanzi = '毕业离校那天，同学们拥抱告别，心里都依依不舍，舍不得分开。',
      example_pinyin = 'Bìyè lí xiào nà tiān, tóngxuémen yōngbào gàobié, xīn lǐ dōu yīyī-bùshě, shěbude fēnkāi.',
      example_vi = 'Hôm tốt nghiệp rời trường, các bạn học ôm nhau từ biệt, trong lòng ai cũng lưu luyến khôn nguôi, không nỡ rời xa nhau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '舍不得',
      'shěbude',
      'không nỡ, luyến tiếc, không đành lòng',
      'Động từ',
      'HSK 5',
      '毕业离校那天，同学们拥抱告别，心里都依依不舍，舍不得分开。',
      'Bìyè lí xiào nà tiān, tóngxuémen yōngbào gàobié, xīn lǐ dōu yīyī-bùshě, shěbude fēnkāi.',
      'Hôm tốt nghiệp rời trường, các bạn học ôm nhau từ biệt, trong lòng ai cũng lưu luyến khôn nguôi, không nỡ rời xa nhau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '毕业离校那天，同学们拥抱告别，心里都依依不舍，舍不得分开。', 'Bìyè lí xiào nà tiān, tóngxuémen yōngbào gàobié, xīn lǐ dōu yīyī-bùshě, shěbude fēnkāi.', 'Hôm tốt nghiệp rời trường, các bạn học ôm nhau từ biệt, trong lòng ai cũng lưu luyến khôn nguôi, không nỡ rời xa nhau.', 'basic', 1),
      (v_id, '传统手工业传承人舍不得放弃家族世代相传的雕版技艺，即便在数字出版时代依然矢志不渝地默默坚守。', 'Chuántǒng shǒugōngyè chuánchéngrén shěbude fàngqì jiāzú shìdài-xiāngchuán de diāobǎn jìyì, jíbiàn zài shùzì chūbǎn shídài yīrán shǐzhì-bùyú de mòmò jiānshǒu.', 'Truyền nhân nghề thủ công truyền thống không nỡ từ bỏ kỹ nghệ khắc bản gỗ gia truyền qua bao thế hệ, cho dù trong thời đại xuất bản số vẫn một lòng kiên định âm thầm gìn giữ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2971] [舍得] (shěde) - nỡ, sẵn lòng bỏ ra, không tiếc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '舍得' AND pinyin = 'shěde'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舍得' AND pinyin = 'shěde'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '舍得'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舍得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shěde',
      meaning_vi = 'nỡ, sẵn lòng bỏ ra, không tiếc',
      example_hanzi = '为了孩子的教育和健康成长，父母无论如何都舍得投入时间和精力。',
      example_pinyin = 'Wèile háizi de jiàoyù hé jiànkāng chéngzhǎng, fùmǔ wúlùn-rúhé dōu shěde tóurù shíjiān hé jīnglì.',
      example_vi = 'Vì sự học hành và trưởng thành khỏe mạnh của con cái, cha mẹ dù thế nào cũng sẵn lòng bỏ ra thời gian và tâm sức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '舍得',
      'shěde',
      'nỡ, sẵn lòng bỏ ra, không tiếc',
      'Động từ',
      'HSK 5',
      '为了孩子的教育和健康成长，父母无论如何都舍得投入时间和精力。',
      'Wèile háizi de jiàoyù hé jiànkāng chéngzhǎng, fùmǔ wúlùn-rúhé dōu shěde tóurù shíjiān hé jīnglì.',
      'Vì sự học hành và trưởng thành khỏe mạnh của con cái, cha mẹ dù thế nào cũng sẵn lòng bỏ ra thời gian và tâm sức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了孩子的教育和健康成长，父母无论如何都舍得投入时间和精力。', 'Wèile háizi de jiàoyù hé jiànkāng chéngzhǎng, fùmǔ wúlùn-rúhé dōu shěde tóurù shíjiān hé jīnglì.', 'Vì sự học hành và trưởng thành khỏe mạnh của con cái, cha mẹ dù thế nào cũng sẵn lòng bỏ ra thời gian và tâm sức.', 'basic', 1),
      (v_id, '高科技领军企业只有舍得在基础科学前沿持续投入战略研发资金，才能在关键底层核心技术上摆脱受制于人的被动局面。', 'Gāokējì lǐngjūn qǐyè zhǐyǒu shěde zài jīchǔ kēxué qiányán chíxù tóurù zhànlüè yánfā zījīn, cái néng zài guānjiàn dǐcéng héxīn jìshù shang bǎituō shòuzhì-yú-rén de bèidòng júmiàn.', 'Doanh nghiệp công nghệ cao dẫn đầu chỉ khi dám mạnh tay chi tiền đầu tư nguồn vốn nghiên cứu chiến lược bền bỉ vào mũi nhọn khoa học cơ bản thì mới có thể thoát khỏi thế bị động lệ thuộc người khác ở các công nghệ lõi nền tảng then chốt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2972] [设备] (shèbèi) - thiết bị, máy móc trang thiết bị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '设备' AND pinyin = 'shèbèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设备' AND pinyin = 'shèbèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '设备'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设备'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shèbèi',
      meaning_vi = 'thiết bị, máy móc trang thiết bị',
      example_hanzi = '新落成的化学实验室里配备了先进齐全的实验分析仪器与安全设备。',
      example_pinyin = 'Xīn luòchéng de huàxué shíyànshì lǐ pèibèi le xiānjìn qíquán de shíyàn fēnxī yíqì yǔ ānquán shèbèi.',
      example_vi = 'Trong phòng thí nghiệm hóa học mới khánh thành được trang bị các dụng cụ phân tích thí nghiệm và thiết bị an toàn tiên tiến đầy đủ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '设备',
      'shèbèi',
      'thiết bị, máy móc trang thiết bị',
      'Danh từ',
      'HSK 5',
      '新落成的化学实验室里配备了先进齐全的实验分析仪器与安全设备。',
      'Xīn luòchéng de huàxué shíyànshì lǐ pèibèi le xiānjìn qíquán de shíyàn fēnxī yíqì yǔ ānquán shèbèi.',
      'Trong phòng thí nghiệm hóa học mới khánh thành được trang bị các dụng cụ phân tích thí nghiệm và thiết bị an toàn tiên tiến đầy đủ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新落成的化学实验室里配备了先进齐全的实验分析仪器与安全设备。', 'Xīn luòchéng de huàxué shíyànshì lǐ pèibèi le xiānjìn qíquán de shíyàn fēnxī yíqì yǔ ānquán shèbèi.', 'Trong phòng thí nghiệm hóa học mới khánh thành được trang bị các dụng cụ phân tích thí nghiệm và thiết bị an toàn tiên tiến đầy đủ.', 'basic', 1),
      (v_id, '高端智能制造工厂全面部署物联网工业控制设备，实现了设备状态实时感知、预测性维护与全生命周期能耗优化。', 'Gāoduān zhìnéng zhìzào gōngchǎng quánmiàn bùshǔ wùliánwǎng gōngyè kòngzhì shèbèi, shíxiàn le shèbèi zhuàngtài shíshí gǎnzhī, yùcèxìng wéihù yǔ quán-shēngmìngzhōuqī nénghào yōuhuà.', 'Nhà máy chế tạo thông minh cao cấp đã triển khai toàn diện các thiết bị điều khiển công nghiệp Internet vạn vật, thực hiện cảm biến thời gian thực trạng thái thiết bị, bảo trì dự đoán và tối ưu hóa mức tiêu hao năng lượng trong toàn bộ vòng đời.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2973] [设计] (shèjì) - thiết kế; bản thiết kế [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '设计' AND pinyin = 'shèjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设计' AND pinyin = 'shèjì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '设计'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设计'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shèjì',
      meaning_vi = 'thiết kế; bản thiết kế',
      example_hanzi = '年轻的设计师为这家咖啡馆设计了一款充满温馨复古格调的内部装修方案。',
      example_pinyin = 'Niánqīng de shèjìshī wèi zhè jiā kāfēiguǎn shèjì le yì kuǎn chōngmǎn wēnxīn fùgǔ gédiào de nèibù zhuāngxiū fāng’àn.',
      example_vi = 'Nhà thiết kế trẻ tuổi đã thiết kế cho quán cà phê này một phương án trang trí nội thất tràn đầy phong cách cổ điển ấm cúng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '设计',
      'shèjì',
      'thiết kế; bản thiết kế',
      'Động từ / Danh từ',
      'HSK 5',
      '年轻的设计师为这家咖啡馆设计了一款充满温馨复古格调的内部装修方案。',
      'Niánqīng de shèjìshī wèi zhè jiā kāfēiguǎn shèjì le yì kuǎn chōngmǎn wēnxīn fùgǔ gédiào de nèibù zhuāngxiū fāng’àn.',
      'Nhà thiết kế trẻ tuổi đã thiết kế cho quán cà phê này một phương án trang trí nội thất tràn đầy phong cách cổ điển ấm cúng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '年轻的设计师为这家咖啡馆设计了一款充满温馨复古格调的内部装修方案。', 'Niánqīng de shèjìshī wèi zhè jiā kāfēiguǎn shèjì le yì kuǎn chōngmǎn wēnxīn fùgǔ gédiào de nèibù zhuāngxiū fāng’àn.', 'Nhà thiết kế trẻ tuổi đã thiết kế cho quán cà phê này một phương án trang trí nội thất tràn đầy phong cách cổ điển ấm cúng.', 'basic', 1),
      (v_id, '芯片顶层系统架构设计是决定微处理器算力密度、能效比与指令集兼容性的决定性工程环节。', 'Xīanpiàn dǐngcéng xìtǒng jiàgòu shèjì shì juédìng wēichǔlǐqì suànlì mìdù, néngxiàobǐ yǔ zhǐlìngjí xiāngróngxìng de juédìngxìng gōngchéng huánjié.', 'Thiết kế kiến trúc hệ thống tầng đỉnh của vi mạch là khâu công trình mang tính quyết định đến mật độ năng lực tính toán, tỷ số hiệu suất năng lượng và tính tương thích tập lệnh của bộ vi xử lý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2974] [设立] (shèlì) - thiết lập, thành lập, lập ra [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '设立' AND pinyin = 'shèlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设立' AND pinyin = 'shèlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '设立'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设立'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shèlì',
      meaning_vi = 'thiết lập, thành lập, lập ra',
      example_hanzi = '为鼓励优秀贫困学子完成学业，热心校友在母校专门设立了助学奖学金。',
      example_pinyin = 'Wèi gǔlì yōuxiù pínkùn xuézǐ wánchéng xuéyè, rèxīn xiàoyǒu zài mǔxiào zhuānmén shèlì le zhùxué jiǎngxuéjīn.',
      example_vi = 'Nhằm khích lệ các học sinh sinh viên nghèo vượt khó học giỏi hoàn thành việc học, các cựu học sinh nhiệt tình đã đặc biệt thành lập quỹ học bổng khuyến học tại trường cũ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '设立',
      'shèlì',
      'thiết lập, thành lập, lập ra',
      'Động từ',
      'HSK 5',
      '为鼓励优秀贫困学子完成学业，热心校友在母校专门设立了助学奖学金。',
      'Wèi gǔlì yōuxiù pínkùn xuézǐ wánchéng xuéyè, rèxīn xiàoyǒu zài mǔxiào zhuānmén shèlì le zhùxué jiǎngxuéjīn.',
      'Nhằm khích lệ các học sinh sinh viên nghèo vượt khó học giỏi hoàn thành việc học, các cựu học sinh nhiệt tình đã đặc biệt thành lập quỹ học bổng khuyến học tại trường cũ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为鼓励优秀贫困学子完成学业，热心校友在母校专门设立了助学奖学金。', 'Wèi gǔlì yōuxiù pínkùn xuézǐ wánchéng xuéyè, rèxīn xiàoyǒu zài mǔxiào zhuānmén shèlì le zhùxué jiǎngxuéjīn.', 'Nhằm khích lệ các học sinh sinh viên nghèo vượt khó học giỏi hoàn thành việc học, các cựu học sinh nhiệt tình đã đặc biệt thành lập quỹ học bổng khuyến học tại trường cũ.', 'basic', 1),
      (v_id, '国务院正式批复同意在沿海经济特区设立国家级绿色金融改革创新试验区，探索构建与国际接轨的ESG投资标准体系。', 'Guówùyuàn zhèngshì pīfù tóngyì zài yánhǎi jīngjì tèqū shèlì guójiājí lǜsè jīnróng gǎigé chuàngxīn shìyànqū, tànsuǒ gòujiàn yǔ guójì jiēguǐ de ESG tóuzī biāozhǔn tǐxì.', 'Quốc vụ viện chính thức phê chuẩn đồng ý thành lập khu thí nghiệm đổi mới cải cách tài chính xanh cấp quốc gia tại đặc khu kinh tế ven biển, tìm tòi xây dựng hệ thống tiêu chuẩn đầu tư ESG tiệm cận quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2975] [社区] (shèqū) - cộng đồng, khu dân cư, tổ dân phố [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '社区' AND pinyin = 'shèqū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '社区' AND pinyin = 'shèqū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '社区'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '社区'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shèqū',
      meaning_vi = 'cộng đồng, khu dân cư, tổ dân phố',
      example_hanzi = '周末社区居委会在文化活动中心组织了丰富多彩的书画摄影义卖展览。',
      example_pinyin = 'Zhōumò shèqū jūwěihuì zài wénhuà huódòng zhōngxīn zǔzhī le fēngfù-duōcǎi de shūhuà shèyǐng yìmài zhǎnlǎn.',
      example_vi = 'Cuối tuần ban cán sự tổ dân phố đã tổ chức một buổi triển lãm bán đấu giá từ thiện tranh ảnh thư pháp phong phú tại trung tâm hoạt động văn hóa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '社区',
      'shèqū',
      'cộng đồng, khu dân cư, tổ dân phố',
      'Danh từ',
      'HSK 5',
      '周末社区居委会在文化活动中心组织了丰富多彩的书画摄影义卖展览。',
      'Zhōumò shèqū jūwěihuì zài wénhuà huódòng zhōngxīn zǔzhī le fēngfù-duōcǎi de shūhuà shèyǐng yìmài zhǎnlǎn.',
      'Cuối tuần ban cán sự tổ dân phố đã tổ chức một buổi triển lãm bán đấu giá từ thiện tranh ảnh thư pháp phong phú tại trung tâm hoạt động văn hóa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末社区居委会在文化活动中心组织了丰富多彩的书画摄影义卖展览。', 'Zhōumò shèqū jūwěihuì zài wénhuà huódòng zhōngxīn zǔzhī le fēngfù-duōcǎi de shūhuà shèyǐng yìmài zhǎnlǎn.', 'Cuối tuần ban cán sự tổ dân phố đã tổ chức một buổi triển lãm bán đấu giá từ thiện tranh ảnh thư pháp phong phú tại trung tâm hoạt động văn hóa.', 'basic', 1),
      (v_id, '全面推进一刻钟便民生活圈建设，依托智慧社区数字底座实现养老托育、家政便民与社区卫生服务的网格化高效覆盖。', 'Quánmiàn tuījìn yí kèzhōng biànmín shēnghuóquān jiànshè, yītuō zhìhuì shèqū shùzì dǐzuò shíxiàn yǎnglǎo tuōyù, jiāzhèng biànmín yǔ shèqū wèishēng fúwù de wǎnggéhuà gāoxiào fùgài.', 'Thúc đẩy toàn diện xây dựng vành đai tiện ích sinh hoạt dân cư mười lăm phút, dựa vào nền tảng số cộng đồng thông minh để thực hiện việc bao phủ hiệu quả theo mạng lưới đối với dịch vụ dưỡng lão trông trẻ, việc nhà tiện ích và y tế cơ sở.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2976] [设施] (shèshī) - cơ sở vật chất, cơ sở hạ tầng, tiện ích [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '设施' AND pinyin = 'shèshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设施' AND pinyin = 'shèshī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '设施'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设施'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shèshī',
      meaning_vi = 'cơ sở vật chất, cơ sở hạ tầng, tiện ích',
      example_hanzi = '新建的小区里配有健身器材、儿童游乐场和无障碍通道等公共设施。',
      example_pinyin = 'Xīn jiàn de xiǎoqū lǐ pèi yǒu jiànshēn qìcái, értóng yóulèchǎng hé wú-zhàng’ài tōngdào děng gōnggòng shèshī.',
      example_vi = 'Trong khu dân cư mới xây dựng có trang bị các cơ sở vật chất công cộng như dụng cụ tập thể dục, sân chơi trẻ em và lối đi cho người khuyết tật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '设施',
      'shèshī',
      'cơ sở vật chất, cơ sở hạ tầng, tiện ích',
      'Danh từ',
      'HSK 5',
      '新建的小区里配有健身器材、儿童游乐场和无障碍通道等公共设施。',
      'Xīn jiàn de xiǎoqū lǐ pèi yǒu jiànshēn qìcái, értóng yóulèchǎng hé wú-zhàng’ài tōngdào děng gōnggòng shèshī.',
      'Trong khu dân cư mới xây dựng có trang bị các cơ sở vật chất công cộng như dụng cụ tập thể dục, sân chơi trẻ em và lối đi cho người khuyết tật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新建的小区里配有健身器材、儿童游乐场和无障碍通道等公共设施。', 'Xīn jiàn de xiǎoqū lǐ pèi yǒu jiànshēn qìcái, értóng yóulèchǎng hé wú-zhàng’ài tōngdào děng gōnggòng shèshī.', 'Trong khu dân cư mới xây dựng có trang bị các cơ sở vật chất công cộng như dụng cụ tập thể dục, sân chơi trẻ em và lối đi cho người khuyết tật.', 'basic', 1),
      (v_id, '统筹布局建设超前适度的新型基础设施体系，是赋能传统产业数字化转型升级与培育新质生产力的关键支撑。', 'Tǒngchóu bùjú jiànshè chāoqián shìdù de xīnxíng jīchǔ shèshī tǐxì, shì fùnéng chuántǒng chǎnyè shùzìhuà zhuǎnxíng shēngjí yǔ péiyù xīnzhì shēngchǎnlì de guānjiàn zhīchēng.', 'Quy hoạch xây dựng đồng bộ hệ thống cơ sở hạ tầng kiểu mới đón đầu ở mức độ phù hợp là điểm tựa then chốt tiếp sức cho chuyển đổi số nâng cấp ngành truyền thống và ươm mầm lực lượng sản xuất chất lượng mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2977] [摄影] (shèyǐng) - chụp ảnh, quay phim; nghệ thuật nhiếp ảnh [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '摄影' AND pinyin = 'shèyǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摄影' AND pinyin = 'shèyǐng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '摄影'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摄影'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shèyǐng',
      meaning_vi = 'chụp ảnh, quay phim; nghệ thuật nhiếp ảnh',
      example_hanzi = '叔叔是一位资深的野生动物摄影爱好者，经常利用假期走进自然保护区采风。',
      example_pinyin = 'Shūshu shì yí wèi zīshēn de yěshēng dòngwù shèyǐng àihàozhě, jīngcháng lìyòng jiàqī zǒu jìn zìrán bǎohùqū cǎifēng.',
      example_vi = 'Chú tôi là một người đam mê nhiếp ảnh động vật hoang dã kỳ cựu, thường tranh thủ các kỳ nghỉ đi vào các khu bảo tồn thiên nhiên để săn ảnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '摄影',
      'shèyǐng',
      'chụp ảnh, quay phim; nghệ thuật nhiếp ảnh',
      'Động từ / Danh từ',
      'HSK 5',
      '叔叔是一位资深的野生动物摄影爱好者，经常利用假期走进自然保护区采风。',
      'Shūshu shì yí wèi zīshēn de yěshēng dòngwù shèyǐng àihàozhě, jīngcháng lìyòng jiàqī zǒu jìn zìrán bǎohùqū cǎifēng.',
      'Chú tôi là một người đam mê nhiếp ảnh động vật hoang dã kỳ cựu, thường tranh thủ các kỳ nghỉ đi vào các khu bảo tồn thiên nhiên để săn ảnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '叔叔是一位资深的野生动物摄影爱好者，经常利用假期走进自然保护区采风。', 'Shūshu shì yí wèi zīshēn de yěshēng dòngwù shèyǐng àihàozhě, jīngcháng lìyòng jiàqī zǒu jìn zìrán bǎohùqū cǎifēng.', 'Chú tôi là một người đam mê nhiếp ảnh động vật hoang dã kỳ cựu, thường tranh thủ các kỳ nghỉ đi vào các khu bảo tồn thiên nhiên để săn ảnh.', 'basic', 1),
      (v_id, '国际地理摄影大奖赛汇聚了全球顶尖纪实摄影大师的经典力作，以极具冲击力的视觉张力记录地球生态变迁。', 'Guójì dìlǐ shèyǐng dàjiǎngsài huìjù le quánqiú dǐngjiān jìshí shèyǐng dàshī de jīngdiǎn lìzuò, yǐ jí jù chōngjīlì de shìjué zhānglì jìlù Dìqiú shēngtài biànqiān.', 'Giải thưởng lớn nhiếp ảnh địa lý quốc tế quy tụ những kiệt tác kinh điển của các bậc thầy nhiếp ảnh phóng sự tài liệu hàng đầu toàn cầu, ghi lại những biến chuyển sinh thái của Trái Đất bằng sức căng thị giác đầy va đập.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2978] [设置] (shèzhì) - cài đặt, thiết lập, bố trí [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '设置' AND pinyin = 'shèzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设置' AND pinyin = 'shèzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '设置'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '设置'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shèzhì',
      meaning_vi = 'cài đặt, thiết lập, bố trí',
      example_hanzi = '购买新手机后，第一件事就是进入系统设置修改屏幕显示亮度与字体大小。',
      example_pinyin = 'Gòumǎi xīn shǒujī hòu, dì-yī jiàn shì jiùshì jìnrù xìtǒng shèzhì xiūgǎi píngmù xiǎnshì liàngdù yǔ zìtǐ dàxiǎo.',
      example_vi = 'Sau khi mua điện thoại mới, việc đầu tiên là vào phần cài đặt hệ thống để điều chỉnh độ sáng màn hình hiển thị và cỡ chữ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '设置',
      'shèzhì',
      'cài đặt, thiết lập, bố trí',
      'Động từ / Danh từ',
      'HSK 5',
      '购买新手机后，第一件事就是进入系统设置修改屏幕显示亮度与字体大小。',
      'Gòumǎi xīn shǒujī hòu, dì-yī jiàn shì jiùshì jìnrù xìtǒng shèzhì xiūgǎi píngmù xiǎnshì liàngdù yǔ zìtǐ dàxiǎo.',
      'Sau khi mua điện thoại mới, việc đầu tiên là vào phần cài đặt hệ thống để điều chỉnh độ sáng màn hình hiển thị và cỡ chữ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '购买新手机后，第一件事就是进入系统设置修改屏幕显示亮度与字体大小。', 'Gòumǎi xīn shǒujī hòu, dì-yī jiàn shì jiùshì jìnrù xìtǒng shèzhì xiūgǎi píngmù xiǎnshì liàngdù yǔ zìtǐ dàxiǎo.', 'Sau khi mua điện thoại mới, việc đầu tiên là vào phần cài đặt hệ thống để điều chỉnh độ sáng màn hình hiển thị và cỡ chữ.', 'basic', 1),
      (v_id, '大型云数据中心在网络边界设置了多层次智能访问控制策略与全天候入侵阻断系统。', 'Dàxíng yún shùjù zhōngxīn zài wǎngluò biānjiè shèzhì le duō-céngcì zhìnéng fǎngwèn kòngzhì cèlüè yǔ quán-tiānhòu rùqīn zǔduàn xìtǒng.', 'Trung tâm dữ liệu đám mây quy mô lớn đã thiết lập các chiến lược kiểm soát truy cập thông minh đa tầng nấc cùng hệ thống ngăn chặn xâm nhập suốt ngày đêm tại ranh giới mạng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2979] [伸] (shēn) - duỗi, giơ ra, vươn ra, chìa ra [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '伸' AND pinyin = 'shēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伸' AND pinyin = 'shēn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '伸'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shēn',
      meaning_vi = 'duỗi, giơ ra, vươn ra, chìa ra',
      example_hanzi = '长时间伏案工作后，他站起身来伸了个懒腰，舒缓酸痛的腰背肌肉。',
      example_pinyin = 'Cháng shíjiān fú’àn gōngzuò hòu, tā zhàn qǐ shēn lái shēn le ge lǎnyāo, shūhuǎn suāntòng de yāobèi jīròu.',
      example_vi = 'Sau thời gian dài cúi đầu làm việc bên bàn, anh ấy đứng dậy vươn vai một cái để xoa dịu các bó cơ lưng eo đang đau nhức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '伸',
      'shēn',
      'duỗi, giơ ra, vươn ra, chìa ra',
      'Động từ',
      'HSK 5',
      '长时间伏案工作后，他站起身来伸了个懒腰，舒缓酸痛的腰背肌肉。',
      'Cháng shíjiān fú’àn gōngzuò hòu, tā zhàn qǐ shēn lái shēn le ge lǎnyāo, shūhuǎn suāntòng de yāobèi jīròu.',
      'Sau thời gian dài cúi đầu làm việc bên bàn, anh ấy đứng dậy vươn vai một cái để xoa dịu các bó cơ lưng eo đang đau nhức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长时间伏案工作后，他站起身来伸了个懒腰，舒缓酸痛的腰背肌肉。', 'Cháng shíjiān fú’àn gōngzuò hòu, tā zhàn qǐ shēn lái shēn le ge lǎnyāo, shūhuǎn suāntòng de yāobèi jīròu.', 'Sau thời gian dài cúi đầu làm việc bên bàn, anh ấy đứng dậy vươn vai một cái để xoa dịu các bó cơ lưng eo đang đau nhức.', 'basic', 1),
      (v_id, '在发生重大地震灾难时，社会各界纷纷伸出援助之手，迅速向灾区同胞调集急需的医疗帐篷与救灾物资。', 'Zài fāshēng zhòngdà dìzhèn zāinàn shí, shèhuì gèjiè fēnfēn shēn chū yuánzhù zhī shǒu, xùnsù xiàng zāiqū tóngbāo diàojí jíxū de yīliáo zhàngpeng yǔ jiùzāi wùzī.', 'Khi xảy ra tai họa động đất nghiêm trọng, các giới trong xã hội đồng loạt chìa ra cánh tay tương trợ, nhanh chóng điều phối lều bạt y tế khẩn cấp và vật tư cứu trợ tới đồng bào vùng thiên tai.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2980] [身材] (shēncái) - vóc dáng, dáng người, thân hình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '身材' AND pinyin = 'shēncái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '身材' AND pinyin = 'shēncái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '身材'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '身材'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shēncái',
      meaning_vi = 'vóc dáng, dáng người, thân hình',
      example_hanzi = '她平时非常注重科学饮食与瑜伽锻炼，因此始终保持着匀称健康的身材。',
      example_pinyin = 'Tā píngshí fēicháng zhùzhòng kēxué yǐnshí yǔ yújiā duànliàn, yīncǐ shǐzhōng bǎochí zhe yúnchèn jiànkāng de shēncái.',
      example_vi = 'Chị ấy ngày thường rất chú trọng ăn uống khoa học và tập luyện yoga, do đó luôn duy trì được một vóc dáng cân đối khỏe khoắn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '身材',
      'shēncái',
      'vóc dáng, dáng người, thân hình',
      'Danh từ',
      'HSK 5',
      '她平时非常注重科学饮食与瑜伽锻炼，因此始终保持着匀称健康的身材。',
      'Tā píngshí fēicháng zhùzhòng kēxué yǐnshí yǔ yújiā duànliàn, yīncǐ shǐzhōng bǎochí zhe yúnchèn jiànkāng de shēncái.',
      'Chị ấy ngày thường rất chú trọng ăn uống khoa học và tập luyện yoga, do đó luôn duy trì được một vóc dáng cân đối khỏe khoắn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '她平时非常注重科学饮食与瑜伽锻炼，因此始终保持着匀称健康的身材。', 'Tā píngshí fēicháng zhùzhòng kēxué yǐnshí yǔ yújiā duànliàn, yīncǐ shǐzhōng bǎochí zhe yúnchèn jiànkāng de shēncái.', 'Chị ấy ngày thường rất chú trọng ăn uống khoa học và tập luyện yoga, do đó luôn duy trì được một vóc dáng cân đối khỏe khoắn.', 'basic', 1),
      (v_id, '人体工学办公座椅研发团队基于不同人群的身材骨骼大数据测绘模型，精心校准了脊柱支撑曲面弧度。', 'Réntǐ gōngxué bàngōng zuòyǐ yánfā tuánduì jīyú bùtóng rénqún de shēncái gǔgé dà-shùjù cèhuì móxíng, jīngxīn jiàozhǔn le jǐzhū zhīchēng qūmiàn húdù.', 'Đội ngũ nghiên cứu ghế văn phòng công thái học dựa trên mô hình đo đạc dữ liệu lớn về xương và vóc dáng của các nhóm người khác nhau, đã hiệu chỉnh tỉ mỉ độ cong bề mặt nâng đỡ cột sống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2981] [深度] (shēndù) - độ sâu, chiều sâu; sâu sắc [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '深度' AND pinyin = 'shēndù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深度' AND pinyin = 'shēndù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '深度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'shēndù',
      meaning_vi = 'độ sâu, chiều sâu; sâu sắc',
      example_hanzi = '游泳池浅水区水深一米二，而深水区的深度则达到了两米以上。',
      example_pinyin = 'Yóuyǒngchí qiǎnshuǐqū shuǐshēn yì mǐ èr, ér shēnshuǐqū de shēndù zé dádào le liǎng mǐ yǐshàng.',
      example_vi = 'Khu nước nông của bể bơi sâu 1,2 mét, còn độ sâu của khu nước sâu thì đạt trên 2 mét.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '深度',
      'shēndù',
      'độ sâu, chiều sâu; sâu sắc',
      'Danh từ / Tính từ',
      'HSK 5',
      '游泳池浅水区水深一米二，而深水区的深度则达到了两米以上。',
      'Yóuyǒngchí qiǎnshuǐqū shuǐshēn yì mǐ èr, ér shēnshuǐqū de shēndù zé dádào le liǎng mǐ yǐshàng.',
      'Khu nước nông của bể bơi sâu 1,2 mét, còn độ sâu của khu nước sâu thì đạt trên 2 mét.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '游泳池浅水区水深一米二，而深水区的深度则达到了两米以上。', 'Yóuyǒngchí qiǎnshuǐqū shuǐshēn yì mǐ èr, ér shēnshuǐqū de shēndù zé dádào le liǎng mǐ yǐshàng.', 'Khu nước nông của bể bơi sâu 1,2 mét, còn độ sâu của khu nước sâu thì đạt trên 2 mét.', 'basic', 1),
      (v_id, '以深度学习为代表的新一代人工智能模型，正在推动自然语言理解、药物分子设计以及自动驾驶算法实现质的飞跃。', 'Yǐ shēndù xuéxí wéi dàibiǎo de xīn yí dài réngōng zhìnéng móxíng, zhèngzài tuīdòng zìrán yǔyán lǐjiě, yàowù fēnzǐ shèjì yǐjí zìdòng jiàshǐ suànfǎ shíxiàn zhì de fēiyuè.', 'Các mô hình trí tuệ nhân tạo thế hệ mới với đại diện là học sâu đang thúc đẩy việc hiểu ngôn ngữ tự nhiên, thiết kế phân tử dược phẩm cũng như thuật toán lái xe tự động đạt bước nhảy vọt về chất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2982] [身份] (shēnfèn) - thân phận, danh tính, tư cách, địa vị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '身份' AND pinyin = 'shēnfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '身份' AND pinyin = 'shēnfèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '身份'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '身份'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shēnfèn',
      meaning_vi = 'thân phận, danh tính, tư cách, địa vị',
      example_hanzi = '去银行办理开户手续时，请务必随身携带本人有效身份证件。',
      example_pinyin = 'Qù yínháng bànlǐ kāihù shǒuxù shí, qǐng wùbì suíshēn xiédài běnrén yǒuxiào shēnfèn zhèngjiàn.',
      example_vi = 'Khi đến ngân hàng làm thủ tục mở tài khoản, xin quý khách nhất thiết phải mang theo giấy tờ chứng minh danh tính hợp lệ của bản thân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '身份',
      'shēnfèn',
      'thân phận, danh tính, tư cách, địa vị',
      'Danh từ',
      'HSK 5',
      '去银行办理开户手续时，请务必随身携带本人有效身份证件。',
      'Qù yínháng bànlǐ kāihù shǒuxù shí, qǐng wùbì suíshēn xiédài běnrén yǒuxiào shēnfèn zhèngjiàn.',
      'Khi đến ngân hàng làm thủ tục mở tài khoản, xin quý khách nhất thiết phải mang theo giấy tờ chứng minh danh tính hợp lệ của bản thân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '去银行办理开户手续时，请务必随身携带本人有效身份证件。', 'Qù yínháng bànlǐ kāihù shǒuxù shí, qǐng wùbì suíshēn xiédài běnrén yǒuxiào shēnfèn zhèngjiàn.', 'Khi đến ngân hàng làm thủ tục mở tài khoản, xin quý khách nhất thiết phải mang theo giấy tờ chứng minh danh tính hợp lệ của bản thân.', 'basic', 1),
      (v_id, '零信任网络安全架构坚持“持续验证、从不默认信任”原则，对每一个终端接入请求实施精细化身份鉴权。', 'Líng-xìnrèn wǎngluò ānquán jiàgòu jiānchí “chíxù yànzhèng, cóng bù mòrèn xìnrèn” yuánzé, duì měi yí ge zhōngduān jiērù qǐngqiú shíshī jīngxìhuà shēnfèn jiànquán.', 'Kiến trúc an ninh mạng Zero Trust kiên định nguyên tắc "liên tục kiểm thực, tuyệt không mặc định tin cậy", thực hiện giám định xác thực danh tính tinh vi đối với từng yêu cầu kết nối đầu cuối.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2983] [深厚] (shēnhòu) - sâu dày, sâu sắc, đậm đà [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '深厚' AND pinyin = 'shēnhòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深厚' AND pinyin = 'shēnhòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '深厚'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深厚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shēnhòu',
      meaning_vi = 'sâu dày, sâu sắc, đậm đà',
      example_hanzi = '两位老科学家在数十年共同奋斗的科研历程中结下了无比深厚的同窗友谊。',
      example_pinyin = 'Liǎng wèi lǎo kēxuéjiā zài shùshí nián gòngtóng fèndòu de kēyán lìchéng zhōng jié xià le wúbǐ shēnhòu de tóngchuāng yǒuyì.',
      example_vi = 'Hai nhà khoa học lão thành trong chặng đường nghiên cứu khoa học cùng phấn đấu hàng chục năm đã kết nên tình bạn đồng môn vô cùng sâu nặng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '深厚',
      'shēnhòu',
      'sâu dày, sâu sắc, đậm đà',
      'Tính từ',
      'HSK 5',
      '两位老科学家在数十年共同奋斗的科研历程中结下了无比深厚的同窗友谊。',
      'Liǎng wèi lǎo kēxuéjiā zài shùshí nián gòngtóng fèndòu de kēyán lìchéng zhōng jié xià le wúbǐ shēnhòu de tóngchuāng yǒuyì.',
      'Hai nhà khoa học lão thành trong chặng đường nghiên cứu khoa học cùng phấn đấu hàng chục năm đã kết nên tình bạn đồng môn vô cùng sâu nặng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '两位老科学家在数十年共同奋斗的科研历程中结下了无比深厚的同窗友谊。', 'Liǎng wèi lǎo kēxuéjiā zài shùshí nián gòngtóng fèndòu de kēyán lìchéng zhōng jié xià le wúbǐ shēnhòu de tóngchuāng yǒuyì.', 'Hai nhà khoa học lão thành trong chặng đường nghiên cứu khoa học cùng phấn đấu hàng chục năm đã kết nên tình bạn đồng môn vô cùng sâu nặng.', 'basic', 1),
      (v_id, '中国传统书法与绘画艺术蕴含着深厚的美学意蕴与哲学哲思，体现了东方文明对人与自然和谐统一的崇高追求。', 'Zhōngguó chuántǒng shūfǎ yǔ huìhuà yìshù yùnhán zhe shēnhòu de měixué yìyùn yǔ zhéxué zhésī, tǐxiàn le dōngfāng wénmíng duì rén yǔ zìrán héxié tǒngyī de chónggāo zhuīqiú.', 'Nghệ thuật thư pháp và hội họa truyền thống Trung Hoa ẩn chứa chiều sâu mỹ học và tư tưởng triết học sâu dày, thể hiện sự mưu cầu cao thượng của văn minh phương Đông về sự thống nhất hài hòa giữa con người và tự nhiên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2984] [深刻] (shēnkè) - sâu sắc, khắc sâu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '深刻' AND pinyin = 'shēnkè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深刻' AND pinyin = 'shēnkè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '深刻'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深刻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shēnkè',
      meaning_vi = 'sâu sắc, khắc sâu',
      example_hanzi = '这堂生动的安全教育课给全体师生留下了极其深刻的印象。',
      example_pinyin = 'Zhè táng shēngdòng de ānquán jiàoyù kè gěi quántǐ shīshēng liú xià le jíqí shēnkè de yìnxiàng.',
      example_vi = 'Tiết học giáo dục an toàn sinh động này đã để lại ấn tượng vô cùng sâu sắc cho toàn thể giáo viên và học sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '深刻',
      'shēnkè',
      'sâu sắc, khắc sâu',
      'Tính từ',
      'HSK 5',
      '这堂生动的安全教育课给全体师生留下了极其深刻的印象。',
      'Zhè táng shēngdòng de ānquán jiàoyù kè gěi quántǐ shīshēng liú xià le jíqí shēnkè de yìnxiàng.',
      'Tiết học giáo dục an toàn sinh động này đã để lại ấn tượng vô cùng sâu sắc cho toàn thể giáo viên và học sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这堂生动的安全教育课给全体师生留下了极其深刻的印象。', 'Zhè táng shēngdòng de ānquán jiàoyù kè gěi quántǐ shīshēng liú xià le jíqí shēnkè de yìnxiàng.', 'Tiết học giáo dục an toàn sinh động này đã để lại ấn tượng vô cùng sâu sắc cho toàn thể giáo viên và học sinh.', 'basic', 1),
      (v_id, '当前全球格局正在经历深刻复杂的结构性变迁，科技自立自强已成为大国博弈中最核心的战略制高点。', 'Dāngqián quánqiú géjú zhèngzài jīnglì shēnkè fùzá de jiégòuxìng biànqiān, kējì zìlì-zìqiáng yǐ chéngwéi dàguó bóyì zhōng zuì héxīn de zhànlüè zhìgāodiǎn.', 'Cục diện toàn cầu hiện nay đang trải qua những biến chuyển mang tính cấu trúc sâu sắc và phức tạp, tự lực tự cường về khoa học công nghệ đã trở thành điểm tựa chiến lược cao nhất trong cạnh tranh giữa các nước lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2985] [深入] (shēnrù) - đi sâu vào, chuyên sâu, thấu đáo [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '深入' AND pinyin = 'shēnrù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深入' AND pinyin = 'shēnrù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '深入'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深入'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'shēnrù',
      meaning_vi = 'đi sâu vào, chuyên sâu, thấu đáo',
      example_hanzi = '调研组今天下午深入基层社区，实地走访了解居民对老旧小区加装电梯的真实想法。',
      example_pinyin = 'Diàoyánzǔ jīntiān xiàwǔ shēnrù jīcéng shèqū, shídì zǒufǎng liǎojiě jūmín duì lǎojiù xiǎoqū jiāzhuāng diàntī de zhēnshí xiǎngfǎ.',
      example_vi = 'Tổ khảo sát chiều nay đã đi sâu xuống cộng đồng dân cư cơ sở, trực tiếp đi thăm tìm hiểu suy nghĩ thực tế của cư dân về việc lắp đặt thêm thang máy cho các khu tập thể cũ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '深入',
      'shēnrù',
      'đi sâu vào, chuyên sâu, thấu đáo',
      'Động từ / Tính từ',
      'HSK 5',
      '调研组今天下午深入基层社区，实地走访了解居民对老旧小区加装电梯的真实想法。',
      'Diàoyánzǔ jīntiān xiàwǔ shēnrù jīcéng shèqū, shídì zǒufǎng liǎojiě jūmín duì lǎojiù xiǎoqū jiāzhuāng diàntī de zhēnshí xiǎngfǎ.',
      'Tổ khảo sát chiều nay đã đi sâu xuống cộng đồng dân cư cơ sở, trực tiếp đi thăm tìm hiểu suy nghĩ thực tế của cư dân về việc lắp đặt thêm thang máy cho các khu tập thể cũ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '调研组今天下午深入基层社区，实地走访了解居民对老旧小区加装电梯的真实想法。', 'Diàoyánzǔ jīntiān xiàwǔ shēnrù jīcéng shèqū, shídì zǒufǎng liǎojiě jūmín duì lǎojiù xiǎoqū jiāzhuāng diàntī de zhēnshí xiǎngfǎ.', 'Tổ khảo sát chiều nay đã đi sâu xuống cộng đồng dân cư cơ sở, trực tiếp đi thăm tìm hiểu suy nghĩ thực tế của cư dân về việc lắp đặt thêm thang máy cho các khu tập thể cũ.', 'basic', 1),
      (v_id, '只有深入推进要素市场化配置综合改革，才能彻底破除阻碍创新要素自由流动的体制机制障碍。', 'Zhǐyǒu shēnrù tuījìn yàosù shìchǎnghuà pèizhì zōnghé gǎigé, cái néng chèdǐ pòchú zǔ’ài chuàngxīn yàosù zìyóu liúdòng de tǐzhì jīzhì zhàng’ài.', 'Chỉ có đi sâu thúc đẩy cải cách toàn diện phân bổ thị trường hóa các yếu tố nguồn lực thì mới có thể xóa bỏ triệt để các rào cản thể chế cơ chế ngăn trở sự lưu chuyển tự do của các yếu tố đổi mới sáng tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2986] [深远] (shēnyuǎn) - sâu xa, sâu rộng, lâu dài [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '深远' AND pinyin = 'shēnyuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深远' AND pinyin = 'shēnyuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '深远'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '深远'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shēnyuǎn',
      meaning_vi = 'sâu xa, sâu rộng, lâu dài',
      example_hanzi = '父母良好的言传身教对孩子一生的品格养成具有深远的影响。',
      example_pinyin = 'Fùmǔ liánghǎo de yánchuán-shēnjiào duì háizi yìshēng de pǐngé yǎngchéng jùyǒu shēnyuǎn de yǐngxiǎng.',
      example_vi = 'Lời dạy bảo và tấm gương tốt của cha mẹ có sức ảnh hưởng sâu xa đối với việc rèn luyện nhân cách cả đời của con trẻ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '深远',
      'shēnyuǎn',
      'sâu xa, sâu rộng, lâu dài',
      'Tính từ',
      'HSK 5',
      '父母良好的言传身教对孩子一生的品格养成具有深远的影响。',
      'Fùmǔ liánghǎo de yánchuán-shēnjiào duì háizi yìshēng de pǐngé yǎngchéng jùyǒu shēnyuǎn de yǐngxiǎng.',
      'Lời dạy bảo và tấm gương tốt của cha mẹ có sức ảnh hưởng sâu xa đối với việc rèn luyện nhân cách cả đời của con trẻ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '父母良好的言传身教对孩子一生的品格养成具有深远的影响。', 'Fùmǔ liánghǎo de yánchuán-shēnjiào duì háizi yìshēng de pǐngé yǎngchéng jùyǒu shēnyuǎn de yǐngxiǎng.', 'Lời dạy bảo và tấm gương tốt của cha mẹ có sức ảnh hưởng sâu xa đối với việc rèn luyện nhân cách cả đời của con trẻ.', 'basic', 1),
      (v_id, '全面推进新型工业化与能源结构绿色转型，将对未来数十年全球产业生态与地缘经济格局产生极其深远的历史性影响。', 'Quánmiàn tuījìn xīnxíng gōngyèhuà yǔ néngyuán jiégòu lǜsè zhuǎnxíng, jiāng duì wèilái shùshí nián quánqiú chǎnyè shēngtài yǔ dìyuán jīngjì géjú chǎnshēng jíqí shēnyuǎn de lìshǐxìng yǐngxiǎng.', 'Thúc đẩy toàn diện công nghiệp hóa kiểu mới và chuyển đổi xanh cơ cấu năng lượng sẽ tạo ra ảnh hưởng lịch sử vô cùng sâu rộng tới hệ sinh thái sản xuất toàn cầu và cục diện kinh tế địa chính trị trong nhiều thập kỷ tới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2987] [神话] (shénhuà) - thần thoại, câu chuyện truyền kỳ, huyền thoại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '神话' AND pinyin = 'shénhuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '神话' AND pinyin = 'shénhuà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '神话'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '神话'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shénhuà',
      meaning_vi = 'thần thoại, câu chuyện truyền kỳ, huyền thoại',
      example_hanzi = '盘古开天辟地和女娲补天是中国家喻户晓的经典古代神话故事。',
      example_pinyin = 'Pángǔ kāitiān-pìdì hé Nǚwā bǔtiān shì Zhōngguó jiāyù-hùxiǎo de jīngdiǎn gǔdài shénhuà gùshi.',
      example_vi = 'Bàn Cổ khai thiên lập địa và Nữ Oa vá trời là những câu chuyện thần thoại cổ đại kinh điển mà mọi nhà ở Trung Quốc đều biết đến.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '神话',
      'shénhuà',
      'thần thoại, câu chuyện truyền kỳ, huyền thoại',
      'Danh từ',
      'HSK 5',
      '盘古开天辟地和女娲补天是中国家喻户晓的经典古代神话故事。',
      'Pángǔ kāitiān-pìdì hé Nǚwā bǔtiān shì Zhōngguó jiāyù-hùxiǎo de jīngdiǎn gǔdài shénhuà gùshi.',
      'Bàn Cổ khai thiên lập địa và Nữ Oa vá trời là những câu chuyện thần thoại cổ đại kinh điển mà mọi nhà ở Trung Quốc đều biết đến.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '盘古开天辟地和女娲补天是中国家喻户晓的经典古代神话故事。', 'Pángǔ kāitiān-pìdì hé Nǚwā bǔtiān shì Zhōngguó jiāyù-hùxiǎo de jīngdiǎn gǔdài shénhuà gùshi.', 'Bàn Cổ khai thiên lập địa và Nữ Oa vá trời là những câu chuyện thần thoại cổ đại kinh điển mà mọi nhà ở Trung Quốc đều biết đến.', 'basic', 1),
      (v_id, '航天重大工程以“嫦娥”、“祝融”、“羲和”等古代神话意象命名，体现了现代硬核科技与深邃中华传统文化浪漫主义的完美结合。', 'Hángtiān zhòngdà gōngchéng yǐ “Cháng’é”, “Zhùróng”, “Xīhé” děng gǔdài shénhuà yìxiàng mìngmíng, tǐxiàn le xiàndài yìnghé kējì yǔ shēnsuì Zhōnghuá chuántǒng wénhuà làngmànzhǔyì de wánměi jiéhé.', 'Các công trình hàng không vũ trụ trọng điểm được đặt tên theo hình tượng thần thoại cổ đại như "Hằng Nga", "Chúc Dung", "Hi Hòa", thể hiện sự kết hợp hoàn hảo giữa công nghệ đỉnh cao hiện đại và chủ nghĩa lãng mạn văn hóa truyền thống Trung Hoa sâu thẳm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2988] [神秘] (shénmì) - thần bí, bí ẩn, huyền bí [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '神秘' AND pinyin = 'shénmì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '神秘' AND pinyin = 'shénmì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '神秘'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '神秘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shénmì',
      meaning_vi = 'thần bí, bí ẩn, huyền bí',
      example_hanzi = '那座深藏在崇山峻岭之中的古老城堡，笼罩着一层神秘的面纱。',
      example_pinyin = 'Nà zuò shēncáng zài chóngshān-jùnlǐng zhī zhōng de gǔlǎo chéngbǎo, lǒngzhào zhe yì céng shénmì de miànshā.',
      example_vi = 'Tòa lâu đài cổ kính ẩn sâu giữa các dãy núi trùng điệp ấy dường như được bao phủ bởi một tấm mạng che mặt đầy bí ẩn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '神秘',
      'shénmì',
      'thần bí, bí ẩn, huyền bí',
      'Tính từ',
      'HSK 5',
      '那座深藏在崇山峻岭之中的古老城堡，笼罩着一层神秘的面纱。',
      'Nà zuò shēncáng zài chóngshān-jùnlǐng zhī zhōng de gǔlǎo chéngbǎo, lǒngzhào zhe yì céng shénmì de miànshā.',
      'Tòa lâu đài cổ kính ẩn sâu giữa các dãy núi trùng điệp ấy dường như được bao phủ bởi một tấm mạng che mặt đầy bí ẩn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '那座深藏在崇山峻岭之中的古老城堡，笼罩着一层神秘的面纱。', 'Nà zuò shēncáng zài chóngshān-jùnlǐng zhī zhōng de gǔlǎo chéngbǎo, lǒngzhào zhe yì céng shénmì de miànshā.', 'Tòa lâu đài cổ kính ẩn sâu giữa các dãy núi trùng điệp ấy dường như được bao phủ bởi một tấm mạng che mặt đầy bí ẩn.', 'basic', 1),
      (v_id, '深海深渊极端环境下生存的化能自养微生物群落，为科学家揭示生命起源与外星生命探测揭开了神秘的面纱。', 'Shēnhǎi shēnyuān jíduān huánjìng xià shēngcún de huànéng zìyǎng wēishēngwù qúnluò, wèi kēxuéjiā jiēshì shēngmìng qǐyuán yǔ wàixīng shēngmìng tàncè jiē kāi le shénmì de miànshā.', 'Quần xã vi sinh vật tự dưỡng hóa năng sinh tồn dưới môi trường cực đoan ở các rãnh vực biển sâu đã vén bức màn bí ẩn giúp các nhà khoa học làm sáng tỏ nguồn gốc sự sống và thám hiểm sinh mệnh ngoài Trái Đất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2989] [升] (shēng) - thăng (chức), lên cao, mọc lên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '升' AND pinyin = 'shēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '升' AND pinyin = 'shēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '升'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '升'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shēng',
      meaning_vi = 'thăng (chức), lên cao, mọc lên',
      example_hanzi = '经过几年的踏实努力工作，他最近被公司正式升为了销售部经理。',
      example_pinyin = 'Jīngguò jǐ nián de tāshi nǔlì gōngzuò, tā zuìjìn bèi gōngsī zhèngshì shēng wéi le xiāoshòubù jīnglǐ.',
      example_vi = 'Sau mấy năm làm việc chăm chỉ vững vàng, anh ấy gần đây đã được công ty chính thức cất nhắc thăng chức lên làm trưởng phòng kinh doanh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '升',
      'shēng',
      'thăng (chức), lên cao, mọc lên',
      'Động từ',
      'HSK 5',
      '经过几年的踏实努力工作，他最近被公司正式升为了销售部经理。',
      'Jīngguò jǐ nián de tāshi nǔlì gōngzuò, tā zuìjìn bèi gōngsī zhèngshì shēng wéi le xiāoshòubù jīnglǐ.',
      'Sau mấy năm làm việc chăm chỉ vững vàng, anh ấy gần đây đã được công ty chính thức cất nhắc thăng chức lên làm trưởng phòng kinh doanh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过几年的踏实努力工作，他最近被公司正式升为了销售部经理。', 'Jīngguò jǐ nián de tāshi nǔlì gōngzuò, tā zuìjìn bèi gōngsī zhèngshì shēng wéi le xiāoshòubù jīnglǐ.', 'Sau mấy năm làm việc chăm chỉ vững vàng, anh ấy gần đây đã được công ty chính thức cất nhắc thăng chức lên làm trưởng phòng kinh doanh.', 'basic', 1),
      (v_id, '伴随着清晨第一缕阳光升起，天安门广场上五星红旗在庄严军乐声中冉冉升起。', 'Bànsuí zhe qīngchén dì-yī lǚ yángguāng shēngqǐ, Tiān’ānmén guǎngchǎng shang wǔxīng hóngqí zài zhuāngyán jūnyuè shēng zhōng rǎnrǎn shēngqǐ.', 'Hòa cùng tia nắng ban mai đầu tiên bừng sáng, trên quảng trường Thiên An Môn lá cờ đỏ năm sao từ từ bay lên cao trong tiếng quân nhạc trang nghiêm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2990] [生产] (shēngchǎn) - sản xuất; sinh nở [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '生产' AND pinyin = 'shēngchǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生产' AND pinyin = 'shēngchǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '生产'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生产'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shēngchǎn',
      meaning_vi = 'sản xuất; sinh nở',
      example_hanzi = '这家现代化汽车制造工厂每天可以生产两千辆新能源纯电动汽车。',
      example_pinyin = 'Zhè jiā xiàndàihuà qìchē zhìzào gōngchǎng měitiān kěyǐ shēngchǎn liǎngqiān liàng xīnnéngyuán chún diàndòng qìchē.',
      example_vi = 'Nhà máy sản xuất ô tô hiện đại này mỗi ngày có thể sản xuất được hai nghìn chiếc ô tô thuần điện năng lượng mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '生产',
      'shēngchǎn',
      'sản xuất; sinh nở',
      'Động từ / Danh từ',
      'HSK 5',
      '这家现代化汽车制造工厂每天可以生产两千辆新能源纯电动汽车。',
      'Zhè jiā xiàndàihuà qìchē zhìzào gōngchǎng měitiān kěyǐ shēngchǎn liǎngqiān liàng xīnnéngyuán chún diàndòng qìchē.',
      'Nhà máy sản xuất ô tô hiện đại này mỗi ngày có thể sản xuất được hai nghìn chiếc ô tô thuần điện năng lượng mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家现代化汽车制造工厂每天可以生产两千辆新能源纯电动汽车。', 'Zhè jiā xiàndàihuà qìchē zhìzào gōngchǎng měitiān kěyǐ shēngchǎn liǎngqiān liàng xīnnéngyuán chún diàndòng qìchē.', 'Nhà máy sản xuất ô tô hiện đại này mỗi ngày có thể sản xuất được hai nghìn chiếc ô tô thuần điện năng lượng mới.', 'basic', 1),
      (v_id, '发展新质生产力要求以全要素生产率大幅提升为核心标志，推动传统要素驱动向创新驱动全面升级。', 'Fāzhǎn xīnzhì shēngchǎnlì yāoqiú yǐ quán-yàosù shēngchǎnlǜ dàfú tíshēng wéi héxīn biāozhì, tuīdòng chuántǒng yàosù qūdòng xiàng chuàngxīn qūdòng quánmiàn shēngjí.', 'Phát triển lực lượng sản xuất chất lượng mới đòi hỏi phải lấy việc tăng vọt năng suất nhân tố tổng hợp làm dấu ấn cốt lõi, thúc đẩy nâng cấp toàn diện từ định hướng dựa vào yếu tố truyền thống sang định hướng dựa vào đổi mới sáng tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2991] [生存] (shēngcún) - sinh tồn, sống sót, tồn tại [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '生存' AND pinyin = 'shēngcún'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生存' AND pinyin = 'shēngcún'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '生存'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生存'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'shēngcún',
      meaning_vi = 'sinh tồn, sống sót, tồn tại',
      example_hanzi = '水、空气和充足的阳光是自然界动植物生存所不可或缺的基本条件。',
      example_pinyin = 'Shuǐ, kōngqì hé chōngzú de yángguāng shì zìránjiè dòng-zhíwù shēngcún suǒ bùkě huòquē de jīběn tiáojiàn.',
      example_vi = 'Nước, không khí và ánh nắng đầy đủ là những điều kiện cơ bản không thể thiếu để động thực vật trong tự nhiên sinh tồn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '生存',
      'shēngcún',
      'sinh tồn, sống sót, tồn tại',
      'Động từ / Danh từ',
      'HSK 5',
      '水、空气和充足的阳光是自然界动植物生存所不可或缺的基本条件。',
      'Shuǐ, kōngqì hé chōngzú de yángguāng shì zìránjiè dòng-zhíwù shēngcún suǒ bùkě huòquē de jīběn tiáojiàn.',
      'Nước, không khí và ánh nắng đầy đủ là những điều kiện cơ bản không thể thiếu để động thực vật trong tự nhiên sinh tồn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '水、空气和充足的阳光是自然界动植物生存所不可或缺的基本条件。', 'Shuǐ, kōngqì hé chōngzú de yángguāng shì zìránjiè dòng-zhíwù shēngcún suǒ bùkě huòquē de jīběn tiáojiàn.', 'Nước, không khí và ánh nắng đầy đủ là những điều kiện cơ bản không thể thiếu để động thực vật trong tự nhiên sinh tồn.', 'basic', 1),
      (v_id, '在激烈的全球产业生态重构浪潮中，缺乏自主底层核心技术的企业将面临极为严峻的生存与发展挑战。', 'Zài jīliè de quánqiú chǎnyè shēngtài chónggòu làngcháo zhōng, quēfá zìzhǔ dǐcéng héxīn jìshù de qǐyè jiāng miànlín jíwéi yánjùn de shēngcún yǔ fāzhǎn tiǎozhàn.', 'Trong làn sóng tái cấu trúc hệ sinh thái sản xuất toàn cầu gay gắt, doanh nghiệp nào thiếu công nghệ cốt lõi nền tảng tự chủ sẽ phải đối mặt với những thách thức sinh tồn và phát triển cực kỳ gay gắt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2992] [生动] (shēngdòng) - sinh động, sống động, truyền cảm [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '生动' AND pinyin = 'shēngdòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生动' AND pinyin = 'shēngdòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '生动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'shēngdòng',
      meaning_vi = 'sinh động, sống động, truyền cảm',
      example_hanzi = '李老师讲课幽默风趣，总是能用许多生动的日常生活实例来解释复杂的物理原理。',
      example_pinyin = 'Lǐ lǎoshī jiǎngkè yōumò fēngqù, zǒngshì néng yòng xǔduō shēngdòng de rìcháng shēnghuó shílì lái jiěshì fùzá de wùlǐ yuánlǐ.',
      example_vi = 'Thầy Lý giảng bài hóm hỉnh sinh động, luôn biết dùng nhiều ví dụ thực tế đời sống hàng ngày sinh động để giải thích những nguyên lý vật lý phức tạp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '生动',
      'shēngdòng',
      'sinh động, sống động, truyền cảm',
      'Tính từ',
      'HSK 5',
      '李老师讲课幽默风趣，总是能用许多生动的日常生活实例来解释复杂的物理原理。',
      'Lǐ lǎoshī jiǎngkè yōumò fēngqù, zǒngshì néng yòng xǔduō shēngdòng de rìcháng shēnghuó shílì lái jiěshì fùzá de wùlǐ yuánlǐ.',
      'Thầy Lý giảng bài hóm hỉnh sinh động, luôn biết dùng nhiều ví dụ thực tế đời sống hàng ngày sinh động để giải thích những nguyên lý vật lý phức tạp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '李老师讲课幽默风趣，总是能用许多生动的日常生活实例来解释复杂的物理原理。', 'Lǐ lǎoshī jiǎngkè yōumò fēngqù, zǒngshì néng yòng xǔduō shēngdòng de rìcháng shēnghuó shílì lái jiěshì fùzá de wùlǐ yuánlǐ.', 'Thầy Lý giảng bài hóm hỉnh sinh động, luôn biết dùng nhiều ví dụ thực tế đời sống hàng ngày sinh động để giải thích những nguyên lý vật lý phức tạp.', 'basic', 1),
      (v_id, '这部大型历史文献纪录片通过罕见的历史胶片修复与亲历者访谈，生动再现了民族复兴史诗般的波澜壮阔征程。', 'Zhè bù dàxíng lìshǐ wénxiàn jìlùpiàn tōngguò hǎnjiàn de lìshǐ jiāopiàn xiūfù yǔ qīnlìzhě fǎngtán, shēngdòng zàixiàn le mínzú fùxīng shǐshībān de bōlán-zhuàngkuò zhēngchéng.', 'Bộ phim tài liệu tư liệu lịch sử quy mô lớn này thông qua việc phục chế những thước phim nhựa lịch sử quý hiếm và phỏng vấn các nhân chứng trực tiếp, đã tái hiện sinh động chặng đường lịch sử hào hùng tráng lệ tựa như bản anh hùng ca phục hưng dân tộc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2993] [升级] (shēngjí) - nâng cấp, thăng cấp, cải tiến [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '升级' AND pinyin = 'shēngjí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '升级' AND pinyin = 'shēngjí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '升级'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '升级'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shēngjí',
      meaning_vi = 'nâng cấp, thăng cấp, cải tiến',
      example_hanzi = '手机提示系统有新的更新包，建议在连接无线网络时进行升级。',
      example_pinyin = 'Shǒujī tíshì xìtǒng yǒu xīn de gēngxīn bāo, jiànyì zài liánjiē wúxiàn wǎngluò shí jìnxíng shēngjí.',
      example_vi = 'Điện thoại nhắc nhở hệ thống có gói cập nhật mới, khuyên nên thực hiện nâng cấp khi đang kết nối mạng không dây.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '升级',
      'shēngjí',
      'nâng cấp, thăng cấp, cải tiến',
      'Động từ',
      'HSK 5',
      '手机提示系统有新的更新包，建议在连接无线网络时进行升级。',
      'Shǒujī tíshì xìtǒng yǒu xīn de gēngxīn bāo, jiànyì zài liánjiē wúxiàn wǎngluò shí jìnxíng shēngjí.',
      'Điện thoại nhắc nhở hệ thống có gói cập nhật mới, khuyên nên thực hiện nâng cấp khi đang kết nối mạng không dây.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '手机提示系统有新的更新包，建议在连接无线网络时进行升级。', 'Shǒujī tíshì xìtǒng yǒu xīn de gēngxīn bāo, jiànyì zài liánjiē wúxiàn wǎngluò shí jìnxíng shēngjí.', 'Điện thoại nhắc nhở hệ thống có gói cập nhật mới, khuyên nên thực hiện nâng cấp khi đang kết nối mạng không dây.', 'basic', 1),
      (v_id, '推动制造业高端化、智能化、绿色化转型升级，是构建现代化产业体系并巩固实体经济根基的核心抓手。', 'Tuīdòng zhìzàoyè gāoduānhuà, zhìnénghuà, lǜsèhuà zhuǎnxíng shēngjí, shì gòujiàn xiàndàihuà chǎnyè tǐxì bìng gǒnggù shítǐ jīngjì gēnjī de héxīn zhuāshǒu.', 'Thúc đẩy ngành chế tạo chuyển đổi nâng cấp theo hướng cao cấp hóa, thông minh hóa và xanh hóa là khâu then chốt cốt lõi để xây dựng hệ thống ngành hiện đại và củng cố nền tảng kinh tế thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2994] [升温] (shēngwēn) - tăng nhiệt độ, ấm lên, nóng lên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '升温' AND pinyin = 'shēngwēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '升温' AND pinyin = 'shēngwēn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '升温'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '升温'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shēngwēn',
      meaning_vi = 'tăng nhiệt độ, ấm lên, nóng lên',
      example_hanzi = '寒潮过去之后，未来几天全国大部分地区气温将显著回暖升温。',
      example_pinyin = 'Háncháo guòqù zhīhòu, wèilái jǐ tiān quánguó dà bùfen dìqū qìwēn jiāng xiǎnzhù huínuǎn shēngwēn.',
      example_vi = 'Sau khi đợt không khí lạnh đi qua, nhiệt độ phần lớn các khu vực trên toàn quốc trong mấy ngày tới sẽ ấm áp tăng nhiệt rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '升温',
      'shēngwēn',
      'tăng nhiệt độ, ấm lên, nóng lên',
      'Động từ',
      'HSK 5',
      '寒潮过去之后，未来几天全国大部分地区气温将显著回暖升温。',
      'Háncháo guòqù zhīhòu, wèilái jǐ tiān quánguó dà bùfen dìqū qìwēn jiāng xiǎnzhù huínuǎn shēngwēn.',
      'Sau khi đợt không khí lạnh đi qua, nhiệt độ phần lớn các khu vực trên toàn quốc trong mấy ngày tới sẽ ấm áp tăng nhiệt rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '寒潮过去之后，未来几天全国大部分地区气温将显著回暖升温。', 'Háncháo guòqù zhīhòu, wèilái jǐ tiān quánguó dà bùfen dìqū qìwēn jiāng xiǎnzhù huínuǎn shēngwēn.', 'Sau khi đợt không khí lạnh đi qua, nhiệt độ phần lớn các khu vực trên toàn quốc trong mấy ngày tới sẽ ấm áp tăng nhiệt rõ rệt.', 'basic', 1),
      (v_id, '联合国政府间气候变化专门委员会最新评估报告警告，若全球地表平均升温突破临界阈值，极地冰盖消融与极端灾害天气将引发不可逆的生态危机。', 'Liánhéguó zhèngfǔjiān qìhòu biànhuà zhuānmén wěiyuánhuì zuìxīn pínggū bàogào jǐnggào, ruò quánqiú dìbiǎo píngjūn shēngwēn tūpò línjiè yùzhí, jídì bīnggài xiāoróng yǔ jíduān zāihài tiānqì jiāng yǐnfā bùkě nì de shēngtài wēijī.', 'Báo cáo đánh giá mới nhất của Ủy ban Liên chính phủ về Biến đổi Khí hậu của Liên Hợp Quốc cảnh báo nếu mức tăng nhiệt độ trung bình bề mặt Trái Đất vượt ngưỡng tới hạn, việc băng địa cực tan chảy và thời tiết thiên tai cực đoan sẽ châm ngòi cho cuộc khủng hoảng sinh thái không thể vãn hồi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2995] [生物] (shēngwù) - sinh vật, sinh học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '生物' AND pinyin = 'shēngwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生物' AND pinyin = 'shēngwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '生物'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shēngwù',
      meaning_vi = 'sinh vật, sinh học',
      example_hanzi = '热带雨林是地球上生物多样性最为丰富的自然生态宝库之一。',
      example_pinyin = 'Rèdài yǔlín shì Dìqiú shang shēngwù duōyàngxìng zuìwéi fēngfù de zìrán shēngtài bǎokù zhī yī.',
      example_vi = 'Rừng mưa nhiệt đới là một trong những kho báu sinh thái tự nhiên có tính đa dạng sinh học phong phú bậc nhất trên Trái Đất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '生物',
      'shēngwù',
      'sinh vật, sinh học',
      'Danh từ',
      'HSK 5',
      '热带雨林是地球上生物多样性最为丰富的自然生态宝库之一。',
      'Rèdài yǔlín shì Dìqiú shang shēngwù duōyàngxìng zuìwéi fēngfù de zìrán shēngtài bǎokù zhī yī.',
      'Rừng mưa nhiệt đới là một trong những kho báu sinh thái tự nhiên có tính đa dạng sinh học phong phú bậc nhất trên Trái Đất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '热带雨林是地球上生物多样性最为丰富的自然生态宝库之一。', 'Rèdài yǔlín shì Dìqiú shang shēngwù duōyàngxìng zuìwéi fēngfù de zìrán shēngtài bǎokù zhī yī.', 'Rừng mưa nhiệt đới là một trong những kho báu sinh thái tự nhiên có tính đa dạng sinh học phong phú bậc nhất trên Trái Đất.', 'basic', 1),
      (v_id, '以合成生物学、基因编辑和细胞免疫治疗为代表的现代生物医药前沿领域，正在孕育全球新一轮生物经济科技产业变革。', 'Yǐ héchéng shēngwùxué, jīyīn biānjí hé xìbāo miǎnyì zhìliáo wéi dàibiǎo de xiàndài shēngwù yīyào qiányán lǐngyù, zhèngzài yùnyù quánqiú xīn yì lún shēngwù jīngjì kējì chǎnyè biàngé.', 'Các lĩnh vực y sinh học hiện đại mũi nhọn với đại diện là sinh học tổng hợp, chỉnh sửa gen và liệu pháp miễn dịch tế bào đang ươm mầm một làn sóng chuyển đổi ngành công nghệ kinh tế sinh học mới trên phạm vi toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2996] [生肖] (shēngxiào) - con giáp (trong 12 con giáp Trung Hoa) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '生肖' AND pinyin = 'shēngxiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生肖' AND pinyin = 'shēngxiào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '生肖'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生肖'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shēngxiào',
      meaning_vi = 'con giáp (trong 12 con giáp Trung Hoa)',
      example_hanzi = '在中国传统生肖文化中，今年是充满吉祥与力量的龙年。',
      example_pinyin = 'Zài Zhōngguó chuántǒng shēngxiào wénhuà zhōng, jīnnián shì chōngmǎn jíxiáng yǔ lìliàng de lóngnián.',
      example_vi = 'Trong văn hóa 12 con giáp truyền thống của Trung Hoa, năm nay là năm con Rồng tràn đầy may mắn và sức mạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '生肖',
      'shēngxiào',
      'con giáp (trong 12 con giáp Trung Hoa)',
      'Danh từ',
      'HSK 5',
      '在中国传统生肖文化中，今年是充满吉祥与力量的龙年。',
      'Zài Zhōngguó chuántǒng shēngxiào wénhuà zhōng, jīnnián shì chōngmǎn jíxiáng yǔ lìliàng de lóngnián.',
      'Trong văn hóa 12 con giáp truyền thống của Trung Hoa, năm nay là năm con Rồng tràn đầy may mắn và sức mạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在中国传统生肖文化中，今年是充满吉祥与力量的龙年。', 'Zài Zhōngguó chuántǒng shēngxiào wénhuà zhōng, jīnnián shì chōngmǎn jíxiáng yǔ lìliàng de lóngnián.', 'Trong văn hóa 12 con giáp truyền thống của Trung Hoa, năm nay là năm con Rồng tràn đầy may mắn và sức mạnh.', 'basic', 1),
      (v_id, '国家邮政部门每年发行的十二生肖特种纪念邮票，巧妙融合了民间剪纸民俗与当代雕刻凹版印刷工艺，深受国内外集邮爱好者的青睐。', 'Guójiā yóuzhèng bùmén měinián fāxíng de shí’èr shēngxiào tèzhǒng jǐniàn yóupiào, qiǎomiào rónghé le mínjiān jiǎnzhǐ mínsú yǔ dāngdài diāokè āobǎn yìnshuā gōngyì, shēnshòu guónèiwài jíyóu àihàozhě de qīnglài.', 'Bộ tem kỷ niệm đặc biệt 12 con giáp do ngành bưu chính quốc gia phát hành hàng năm kết hợp khéo léo giữa phong tục cắt giấy dân gian và công nghệ in khắc lõm đương đại, rất được người sưu tập tem trong và ngoài nước ưa chuộng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2997] [生长] (shēngzhǎng) - sinh trưởng, phát triển lớn lên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '生长' AND pinyin = 'shēngzhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生长' AND pinyin = 'shēngzhǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '生长'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '生长'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shēngzhǎng',
      meaning_vi = 'sinh trưởng, phát triển lớn lên',
      example_hanzi = '春雨过后，竹林里的春笋在一夜之间破土而出，迅速生长。',
      example_pinyin = 'Chūnyǔ guòhòu, zhúlín lǐ de chūnsǔn zài yí yè zhījiān pòtǔ-érchū, xùnsù shēngzhǎng.',
      example_vi = 'Sau cơn mưa xuân, măng non trong rừng trúc chỉ sau một đêm đã đội đất nhú lên, sinh trưởng nhanh chóng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '生长',
      'shēngzhǎng',
      'sinh trưởng, phát triển lớn lên',
      'Động từ',
      'HSK 5',
      '春雨过后，竹林里的春笋在一夜之间破土而出，迅速生长。',
      'Chūnyǔ guòhòu, zhúlín lǐ de chūnsǔn zài yí yè zhījiān pòtǔ-érchū, xùnsù shēngzhǎng.',
      'Sau cơn mưa xuân, măng non trong rừng trúc chỉ sau một đêm đã đội đất nhú lên, sinh trưởng nhanh chóng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春雨过后，竹林里的春笋在一夜之间破土而出，迅速生长。', 'Chūnyǔ guòhòu, zhúlín lǐ de chūnsǔn zài yí yè zhījiān pòtǔ-érchū, xùnsù shēngzhǎng.', 'Sau cơn mưa xuân, măng non trong rừng trúc chỉ sau một đêm đã đội đất nhú lên, sinh trưởng nhanh chóng.', 'basic', 1),
      (v_id, '现代设施农业利用智能温室物联网与全光谱植物生长补光灯，精准调控水肥光热参数，大幅缩短了经济作物的生长周期。', 'Xiàndài shèshī nóngyè lìyòng zhìnéng wēnshì wùliánwǎng yǔ quán-guāngpǔ zhíwù shēngzhǎng bǔguāngdēng, jīngzhǔn tiáokòng shuǐ-féi-guāng-rè cānshù, dàfú suōduǎn le jīngjì zuòwù de shēngzhǎng zhōuqī.', 'Nông nghiệp công nghệ cao sử dụng nhà kính thông minh Internet vạn vật và đèn chiếu bù quang phổ đầy đủ hỗ trợ sinh trưởng thực vật, điều tiết chuẩn xác các thông số nước phân ánh sáng nhiệt độ, rút ngắn đáng kể chu kỳ sinh trưởng của cây trồng kinh tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2998] [省] (shěng) - tiết kiệm, bớt xén, giảm bớt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '省' AND pinyin = 'shěng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '省' AND pinyin = 'shěng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '省'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '省'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shěng',
      meaning_vi = 'tiết kiệm, bớt xén, giảm bớt',
      example_hanzi = '出门随手关灯关水龙头，既能节约资源，又能省下不少水费电费。',
      example_pinyin = 'Chūmén suíshǒu guāndēng guān shuǐlóngtóu, jì néng jiéyuē zīyuán, yòu néng shěng xià bù shǎo shuǐfèi diànfèi.',
      example_vi = 'Ra ngoài tiện tay tắt đèn khóa vòi nước, vừa có thể tiết kiệm tài nguyên lại vừa tiết kiệm được không ít tiền điện tiền nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '省',
      'shěng',
      'tiết kiệm, bớt xén, giảm bớt',
      'Động từ',
      'HSK 5',
      '出门随手关灯关水龙头，既能节约资源，又能省下不少水费电费。',
      'Chūmén suíshǒu guāndēng guān shuǐlóngtóu, jì néng jiéyuē zīyuán, yòu néng shěng xià bù shǎo shuǐfèi diànfèi.',
      'Ra ngoài tiện tay tắt đèn khóa vòi nước, vừa có thể tiết kiệm tài nguyên lại vừa tiết kiệm được không ít tiền điện tiền nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门随手关灯关水龙头，既能节约资源，又能省下不少水费电费。', 'Chūmén suíshǒu guāndēng guān shuǐlóngtóu, jì néng jiéyuē zīyuán, yòu néng shěng xià bù shǎo shuǐfèi diànfèi.', 'Ra ngoài tiện tay tắt đèn khóa vòi nước, vừa có thể tiết kiệm tài nguyên lại vừa tiết kiệm được không ít tiền điện tiền nước.', 'basic', 1),
      (v_id, '政务服务推行“一网通办”数字化流程改革，旨在让企业和老百姓办事少跑腿，最大限度省去冗长繁琐的审批审批材料。', 'Zhèngwù fúwù tuīxíng “yìwǎngtōngbàn” shùzìhuà liúchéng gǎigé, zhǐ zài ràng qǐyè hé lǎobǎixìng bànshì shǎo pǎotuǐ, zuìdà xiàndù shěng qù rǒngcháng fánsuǒ de shěnpī shěnpī cáiliào.', 'Dịch vụ hành chính công thực hiện cải cách quy trình số hóa "một cửa điện tử liên thông", nhằm giúp doanh nghiệp và người dân bớt công đi lại giải quyết thủ tục, cắt giảm tối đa các giấy tờ phê duyệt rườm rà dài dòng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2999] [省份] (shěngfèn) - tỉnh, các tỉnh (đơn vị hành chính) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '省份' AND pinyin = 'shěngfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '省份' AND pinyin = 'shěngfèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '省份'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '省份'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shěngfèn',
      meaning_vi = 'tỉnh, các tỉnh (đơn vị hành chính)',
      example_hanzi = '放假期间，他们一家人计划自驾游览祖国南方的几个美丽省份。',
      example_pinyin = 'Fàngjià qījiān, tāmen yì jiā rén jìhuà zìjià yóulǎn zǔguó nánfāng de jǐ ge měilì shěngfèn.',
      example_vi = 'Trong kỳ nghỉ phép, cả gia đình họ dự định tự lái xe đi du lịch ngắm cảnh một số tỉnh thành tươi đẹp ở miền Nam tổ quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '省份',
      'shěngfèn',
      'tỉnh, các tỉnh (đơn vị hành chính)',
      'Danh từ',
      'HSK 5',
      '放假期间，他们一家人计划自驾游览祖国南方的几个美丽省份。',
      'Fàngjià qījiān, tāmen yì jiā rén jìhuà zìjià yóulǎn zǔguó nánfāng de jǐ ge měilì shěngfèn.',
      'Trong kỳ nghỉ phép, cả gia đình họ dự định tự lái xe đi du lịch ngắm cảnh một số tỉnh thành tươi đẹp ở miền Nam tổ quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '放假期间，他们一家人计划自驾游览祖国南方的几个美丽省份。', 'Fàngjià qījiān, tāmen yì jiā rén jìhuà zìjià yóulǎn zǔguó nánfāng de jǐ ge měilì shěngfèn.', 'Trong kỳ nghỉ phép, cả gia đình họ dự định tự lái xe đi du lịch ngắm cảnh một số tỉnh thành tươi đẹp ở miền Nam tổ quốc.', 'basic', 1),
      (v_id, '国家统筹推进跨区域重大基础设施网络互联互通，全面消除相邻省份之间的电力调度壁垒与交通断头路瓶颈。', 'Guójiā tǒngchóu tuījìn kuà-qūyù zhòngdà jīchǔ shèshī wǎngluò hùlián-hùtōng, quánmiàn xiāochú xiānglín shěngfèn zhījiān de diànlì diàodù bìlěi yǔ jiāotōng duàntóulù píngjǐng.', 'Nhà nước điều phối đồng bộ thúc đẩy kết nối liên thông mạng lưới cơ sở hạ tầng trọng điểm liên khu vực, xóa bỏ triệt để rào cản điều phối điện lực và các nút thắt đường cụt giao thông giữa các tỉnh giáp ranh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3000] [省会] (shěnghuì) - tỉnh lỵ, thủ phủ của tỉnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '省会' AND pinyin = 'shěnghuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '省会' AND pinyin = 'shěnghuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '省会'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '省会'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'shěnghuì',
      meaning_vi = 'tỉnh lỵ, thủ phủ của tỉnh',
      example_hanzi = '广州是广东省的省会，也是华南地区重要的经济、文化和交通中心。',
      example_pinyin = 'Guǎngzhōu shì Guǎngdōng shěng de shěnghuì, yě shì Huánán dìqū zhòngyào de jīngjì, wénhuà hé jiāotōng zhōngxīn.',
      example_vi = 'Quảng Châu là thủ phủ của tỉnh Quảng Đông, cũng là trung tâm kinh tế, văn hóa và giao thông trọng điểm của khu vực Hoa Nam.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '省会',
      'shěnghuì',
      'tỉnh lỵ, thủ phủ của tỉnh',
      'Danh từ',
      'HSK 5',
      '广州是广东省的省会，也是华南地区重要的经济、文化和交通中心。',
      'Guǎngzhōu shì Guǎngdōng shěng de shěnghuì, yě shì Huánán dìqū zhòngyào de jīngjì, wénhuà hé jiāotōng zhōngxīn.',
      'Quảng Châu là thủ phủ của tỉnh Quảng Đông, cũng là trung tâm kinh tế, văn hóa và giao thông trọng điểm của khu vực Hoa Nam.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '广州是广东省的省会，也是华南地区重要的经济、文化和交通中心。', 'Guǎngzhōu shì Guǎngdōng shěng de shěnghuì, yě shì Huánán dìqū zhòngyào de jīngjì, wénhuà hé jiāotōng zhōngxīn.', 'Quảng Châu là thủ phủ của tỉnh Quảng Đông, cũng là trung tâm kinh tế, văn hóa và giao thông trọng điểm của khu vực Hoa Nam.', 'basic', 1),
      (v_id, '做优做强省会城市核心功能，充分发挥省会特大城市对周边都市圈和区域经济协同发展的辐射带动作用。', 'Zuò yōu zuò qiáng shěnghuì chéngshì héxīn gōngnéng, chōngfèn fāhuī shěnghuì tèdà chéngshì duì zhōuwéi dūshìquān hé qūyù jīngjì xiétóng fāzhǎn de fúshè dàidòng zuòyòng.', 'Tối ưu hóa và củng cố chức năng cốt lõi của các thành phố tỉnh lỵ, phát huy triệt để vai trò bức xạ lôi kéo của các siêu đô thị thủ phủ tỉnh đối với vành đai đô thị xung quanh và sự phát triển hiệp đồng kinh tế khu vực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3001] [胜] (shèng) - thắng, chiến thắng, vượt trội [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '胜' AND pinyin = 'shèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胜' AND pinyin = 'shèng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '胜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'shèng',
      meaning_vi = 'thắng, chiến thắng, vượt trội',
      example_hanzi = '在激烈的校园辩论总决赛中，正方团队配合默契，最终战胜了反方夺得桂冠。',
      example_pinyin = 'Zài jīliè de xiàoyuán biànlùn zǒngjuésài zhōng, zhèngfāng tuánduì pèihé mòqì, zuìzhōng zhànshèng le fǎnfāng duó dé guìguān.',
      example_vi = 'Trong trận chung kết tranh biện toàn trường nảy lửa, đội bên thuận phối hợp ăn ý, cuối cùng đã chiến thắng đội bên chống để giành vòng nguyệt quế.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '胜',
      'shèng',
      'thắng, chiến thắng, vượt trội',
      'Động từ',
      'HSK 5',
      '在激烈的校园辩论总决赛中，正方团队配合默契，最终战胜了反方夺得桂冠。',
      'Zài jīliè de xiàoyuán biànlùn zǒngjuésài zhōng, zhèngfāng tuánduì pèihé mòqì, zuìzhōng zhànshèng le fǎnfāng duó dé guìguān.',
      'Trong trận chung kết tranh biện toàn trường nảy lửa, đội bên thuận phối hợp ăn ý, cuối cùng đã chiến thắng đội bên chống để giành vòng nguyệt quế.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在激烈的校园辩论总决赛中，正方团队配合默契，最终战胜了反方夺得桂冠。', 'Zài jīliè de xiàoyuán biànlùn zǒngjuésài zhōng, zhèngfāng tuánduì pèihé mòqì, zuìzhōng zhànshèng le fǎnfāng duó dé guìguān.', 'Trong trận chung kết tranh biện toàn trường nảy lửa, đội bên thuận phối hợp ăn ý, cuối cùng đã chiến thắng đội bên chống để giành vòng nguyệt quế.', 'basic', 1),
      (v_id, '科技企业要在激烈的国际红海竞争中决胜未来，核心在于能否以高水准自主创新出奇制胜、占领价值链顶端。', 'Kējì qǐyè yào zài jīliè de guójì hónghǎi jìngzhēng zhōng juéshèng wèilái, héxīn zàiyú néngfǒu yǐ gāo-shuǐzhǔn zìzhǔ chuàngxīn chūqí-zhìshèng, zhànlǐng jiàzhíliàn dǐngduān.', 'Doanh nghiệp công nghệ muốn quyết thắng tương lai giữa cạnh tranh đại dương đỏ quốc tế khốc liệt, điểm mấu chốt nằm ở việc liệu có thể lấy đổi mới tự chủ trình độ cao để xuất kỳ bất ý giành phần thắng, chiếm lĩnh đỉnh cao chuỗi giá trị hay không.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn tất cập nhật HSK 5 - Batch 10! Tổng số từ đã xử lý: %', v_count;
END $$;
