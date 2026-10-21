-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 7 (100 TỪ TIẾP THEO)
-- Phạm vi: #2602 [结合] (jiéhé) -> #2701 [理论] (lǐlùn)
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
  -- [2602] [结合] (jiéhé) - kết hợp, liên kết, phối hợp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '结合' AND pinyin = 'jiéhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '结合' AND pinyin = 'jiéhé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '结合'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '结合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiéhé',
      meaning_vi = 'kết hợp, liên kết, phối hợp',
      example_hanzi = '学习外语时，要把理论语法知识与口语实际训练紧密结合起来。',
      example_pinyin = 'Xuéxí wàiyǔ shí, yào bǎ lǐlùn yǔfǎ zhīshi yǔ kǒuyǔ shíjì xùnliàn jǐnmì jiéhé qǐlái.',
      example_vi = 'Khi học ngoại ngữ, cần phải kết hợp chặt chẽ giữa kiến thức ngữ pháp lý thuyết với rèn luyện giao tiếp thực tế.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '结合',
      'jiéhé',
      'kết hợp, liên kết, phối hợp',
      'Động từ',
      'HSK 5',
      '学习外语时，要把理论语法知识与口语实际训练紧密结合起来。',
      'Xuéxí wàiyǔ shí, yào bǎ lǐlùn yǔfǎ zhīshi yǔ kǒuyǔ shíjì xùnliàn jǐnmì jiéhé qǐlái.',
      'Khi học ngoại ngữ, cần phải kết hợp chặt chẽ giữa kiến thức ngữ pháp lý thuyết với rèn luyện giao tiếp thực tế.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学习外语时，要把理论语法知识与口语实际训练紧密结合起来。', 'Xuéxí wàiyǔ shí, yào bǎ lǐlùn yǔfǎ zhīshi yǔ kǒuyǔ shíjì xùnliàn jǐnmì jiéhé qǐlái.', 'Khi học ngoại ngữ, cần phải kết hợp chặt chẽ giữa kiến thức ngữ pháp lý thuyết với rèn luyện giao tiếp thực tế.', 'basic', 1),
      (v_id, '该研发项目坚持产学研深度结合，推动前沿实验室基础科学成果迅速转化为具备市场竞争力的高端产品。', 'Gāi yánfā xiàngmù jiānchí chǎn-xué-yán shēndù jiéhé, tuīdòng qiányán shíyànshì jīchǔ kēxué chéngguǒ xùnsù zhuǎnhuà wéi jùbèi shìchǎng jìngzhēnglì de gāoduān chǎnpǐn.', 'Dự án nghiên cứu này kiên trì kết hợp sâu rộng giữa doanh nghiệp, viện nghiên cứu và trường đại học, thúc đẩy các thành quả khoa học cơ bản nơi phòng thí nghiệm tiên phong chuyển hóa nhanh chóng thành sản phẩm cao cấp có sức cạnh tranh thị trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2603] [结论] (jiélùn) - kết luận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '结论' AND pinyin = 'jiélùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '结论' AND pinyin = 'jiélùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '结论'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '结论'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiélùn',
      meaning_vi = 'kết luận',
      example_hanzi = '在没有掌握充分证据之前，千万不要轻易下结论。',
      example_pinyin = 'Zài méiyǒu zhǎngwò chōngfèn zhèngjù zhīqián, qiānwàn bú yào qīngyì xià jiélùn.',
      example_vi = 'Trước khi nắm vững đầy đủ bằng chứng, tuyệt đối không nên vội vã đưa ra kết luận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '结论',
      'jiélùn',
      'kết luận',
      'Danh từ',
      'HSK 5',
      '在没有掌握充分证据之前，千万不要轻易下结论。',
      'Zài méiyǒu zhǎngwò chōngfèn zhèngjù zhīqián, qiānwàn bú yào qīngyì xià jiélùn.',
      'Trước khi nắm vững đầy đủ bằng chứng, tuyệt đối không nên vội vã đưa ra kết luận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在没有掌握充分证据之前，千万不要轻易下结论。', 'Zài méiyǒu zhǎngwò chōngfèn zhèngjù zhīqián, qiānwàn bú yào qīngyì xià jiélùn.', 'Trước khi nắm vững đầy đủ bằng chứng, tuyệt đối không nên vội vã đưa ra kết luận.', 'basic', 1),
      (v_id, '经过严谨的双盲对照实验与详尽的数据统计分析，专家组最终得出了该新型疫苗安全有效的科学结论。', 'Jīngguò yánjǐn de shuāngmáng duìzhào shíyàn yǔ xiángjìn de shùjù tǒngjì fēnxī, zhuānjiāzǔ zuìzhōng déchū le gāi xīnxíng yìmiáo ānquán yǒuxiào de kēxué jiélùn.', 'Trải qua thử nghiệm đối chứng mù đôi nghiêm ngặt cùng sự phân tích thống kê dữ liệu chi tiết, nhóm chuyên gia cuối cùng đã rút ra kết luận khoa học rằng loại vắc xin kiểu mới này an toàn và hiệu quả.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2604] [节省] (jiéshěng) - tiết kiệm, giảm bớt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '节省' AND pinyin = 'jiéshěng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '节省' AND pinyin = 'jiéshěng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '节省'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '节省'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiéshěng',
      meaning_vi = 'tiết kiệm, giảm bớt',
      example_hanzi = '出门随手关灯能够有效节省家庭用电开支。',
      example_pinyin = 'Chūmén suíshǒu guāndēng nénggòu yǒuxiào jiéshěng jiātíng yòngdiàn kāizhī.',
      example_vi = 'Ra ngoài tiện tay tắt đèn có thể tiết kiệm chi tiêu tiền điện sinh hoạt cho gia đình một cách hiệu quả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '节省',
      'jiéshěng',
      'tiết kiệm, giảm bớt',
      'Động từ',
      'HSK 5',
      '出门随手关灯能够有效节省家庭用电开支。',
      'Chūmén suíshǒu guāndēng nénggòu yǒuxiào jiéshěng jiātíng yòngdiàn kāizhī.',
      'Ra ngoài tiện tay tắt đèn có thể tiết kiệm chi tiêu tiền điện sinh hoạt cho gia đình một cách hiệu quả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门随手关灯能够有效节省家庭用电开支。', 'Chūmén suíshǒu guāndēng nénggòu yǒuxiào jiéshěng jiātíng yòngdiàn kāizhī.', 'Ra ngoài tiện tay tắt đèn có thể tiết kiệm chi tiêu tiền điện sinh hoạt cho gia đình một cách hiệu quả.', 'basic', 1),
      (v_id, '通过引入全自动化智能仓储物流分拣系统，该电商物流中心成功节省了近百分之三十的仓储运转与人工综合成本。', 'Tōngguò yǐnrù quán zìdònghuà zhìnéng cāngchǔ wùliú fēnjiǎn xìtǒng, gāi diànshāng wùliú zhōngxīn chénggōng jiéshěng le jìn bǎifēnzhī sānshí de cāngchǔ yùnzhuǎn yǔ réngōng zōnghé chéngběn.', 'Bằng cách đưa vào vận hành hệ thống phân loại hậu cần kho bãi thông minh hoàn toàn tự động, trung tâm logistics thương mại điện tử này đã tiết kiệm thành công gần 30% chi phí vận hành kho bãi và nhân công tổng hợp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2605] [届] (jiè) - khóa, nhiệm kỳ, kỳ (hội nghị, triển lãm, tốt nghiệp) [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '届' AND pinyin = 'jiè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '届' AND pinyin = 'jiè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '届'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '届'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'jiè',
      meaning_vi = 'khóa, nhiệm kỳ, kỳ (hội nghị, triển lãm, tốt nghiệp)',
      example_hanzi = '这所大学迎来了建校以来的第七十届毕业生。',
      example_pinyin = 'Zhè suǒ dàxué yínglái le jiànxiào yǐlái de dì-qīshí jiè bìyèshēng.',
      example_vi = 'Trường đại học này đã chào đón khóa sinh viên tốt nghiệp thứ 70 kể từ ngày thành lập trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '届',
      'jiè',
      'khóa, nhiệm kỳ, kỳ (hội nghị, triển lãm, tốt nghiệp)',
      'Lượng từ / Danh từ',
      'HSK 5',
      '这所大学迎来了建校以来的第七十届毕业生。',
      'Zhè suǒ dàxué yínglái le jiànxiào yǐlái de dì-qīshí jiè bìyèshēng.',
      'Trường đại học này đã chào đón khóa sinh viên tốt nghiệp thứ 70 kể từ ngày thành lập trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这所大学迎来了建校以来的第七十届毕业生。', 'Zhè suǒ dàxué yínglái le jiànxiào yǐlái de dì-qīshí jiè bìyèshēng.', 'Trường đại học này đã chào đón khóa sinh viên tốt nghiệp thứ 70 kể từ ngày thành lập trường.', 'basic', 1),
      (v_id, '本届中国国际进口博览会吸引了来自一百五十多个国家和地区的数千家跨国企业参展，达成了丰硕的经贸合作成果。', 'Běn jiè Zhōngguó Guójì Jìnkǒu Bólǎnhuì xīyǐn le láizì yībǎi wǔshí duō gè guójiā hé dìqū de shù qiān jiā kuàguó qǐyè cānzhǎn, dáchéng le fēngshuò de jīngmào hézuò chéngguǒ.', 'Hội chợ Triển lãm Nhập khẩu Quốc tế Trung Quốc kỳ này đã thu hút hàng nghìn doanh nghiệp đa quốc gia đến từ hơn 150 quốc gia và vùng lãnh thổ tham gia trưng bày, đạt được những thành quả hợp tác kinh tế thương mại phong phú.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2606] [今日] (jīnrì) - hôm nay, ngày nay [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '今日' AND pinyin = 'jīnrì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '今日' AND pinyin = 'jīnrì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '今日'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '今日'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jīnrì',
      meaning_vi = 'hôm nay, ngày nay',
      example_hanzi = '今日的晨会主要讨论下半年的市场推广计划。',
      example_pinyin = 'Jīnrì de chénhuì zhǔyào tǎolùn xiàbànnián de shìchǎng tuīguǎng jìhuà.',
      example_vi = 'Cuộc họp buổi sáng hôm nay chủ yếu thảo luận về kế hoạch quảng bá thị trường trong nửa cuối năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '今日',
      'jīnrì',
      'hôm nay, ngày nay',
      'Danh từ',
      'HSK 5',
      '今日的晨会主要讨论下半年的市场推广计划。',
      'Jīnrì de chénhuì zhǔyào tǎolùn xiàbànnián de shìchǎng tuīguǎng jìhuà.',
      'Cuộc họp buổi sáng hôm nay chủ yếu thảo luận về kế hoạch quảng bá thị trường trong nửa cuối năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今日的晨会主要讨论下半年的市场推广计划。', 'Jīnrì de chénhuì zhǔyào tǎolùn xiàbànnián de shìchǎng tuīguǎng jìhuà.', 'Cuộc họp buổi sáng hôm nay chủ yếu thảo luận về kế hoạch quảng bá thị trường trong nửa cuối năm.', 'basic', 1),
      (v_id, '抚今追昔，正是几代人艰苦卓绝的接续奋斗，才铸就了今日国家繁荣昌盛与人民安居乐业的崭新风貌。', 'Fǔjīn-zhuīxī, zhèngshì jǐ dài rén jiānkǔ-zhuójué de jiēxù fèndòu, cái zhùjiù le jīnrì guójiā fánróng-chāngshèng yǔ rénmín ānjū-lèyè de zhǎnxīn fēngmào.', 'Nhìn lại quá khứ để ngẫm về hôm nay, chính sự phấn đấu bền bỉ kiên cường của bao thế hệ mới tôi luyện nên diện mạo hoàn toàn mới của một đất nước phồn vinh thịnh vượng và nhân dân an cư lạc nghiệp ngày nay.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2607] [紧] (jǐn) - chặt, sít sao, khẩn cấp; eo hẹp (thời gian, tiền nong) [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '紧' AND pinyin = 'jǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '紧' AND pinyin = 'jǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '紧'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '紧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'jǐn',
      meaning_vi = 'chặt, sít sao, khẩn cấp; eo hẹp (thời gian, tiền nong)',
      example_hanzi = '这双新鞋穿起来感觉有点儿紧，走久了脚会不舒服。',
      example_pinyin = 'Zhè shuāng xīn xié chuān qǐlái gǎnjué yǒudiǎnr jǐn, zǒu jiǔ le jiǎo huì bù shūfu.',
      example_vi = 'Đôi giày mới này đi vào có cảm giác hơi chật, đi bộ lâu chân sẽ khó chịu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '紧',
      'jǐn',
      'chặt, sít sao, khẩn cấp; eo hẹp (thời gian, tiền nong)',
      'Tính từ / Động từ',
      'HSK 5',
      '这双新鞋穿起来感觉有点儿紧，走久了脚会不舒服。',
      'Zhè shuāng xīn xié chuān qǐlái gǎnjué yǒudiǎnr jǐn, zǒu jiǔ le jiǎo huì bù shūfu.',
      'Đôi giày mới này đi vào có cảm giác hơi chật, đi bộ lâu chân sẽ khó chịu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这双新鞋穿起来感觉有点儿紧，走久了脚会不舒服。', 'Zhè shuāng xīn xié chuān qǐlái gǎnjué yǒudiǎnr jǐn, zǒu jiǔ le jiǎo huì bù shūfu.', 'Đôi giày mới này đi vào có cảm giác hơi chật, đi bộ lâu chân sẽ khó chịu.', 'basic', 1),
      (v_id, '面对交付工期极紧且工艺标准极其苛刻的跨国大型工程，项目指挥部实行倒排工期与挂图作战以确保如期履约。', 'Miànduì jiāofù gōngqī jí jǐn qiě gōngyì biāozhǔn jíqí kēkè de kuàguó dàxíng gōngchéng, xiàngmù zhǐhuībù shíxíng dàopái gōngqī yǔ guàtú zuòzhàn yǐ quèbǎo rúqī lǚyuē.', 'Đứng trước một dự án công trình lớn xuyên quốc gia có thời hạn bàn giao vô cùng gấp rút và tiêu chuẩn kỹ thuật cực kỳ khắt khe, ban chỉ huy dự án đã thực hiện lập lịch tiến độ ngược và bám sát sơ đồ tác chiến nhằm đảm bảo hoàn thành đúng hẹn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2608] [紧急] (jǐnjí) - khẩn cấp, cấp bách [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '紧急' AND pinyin = 'jǐnjí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '紧急' AND pinyin = 'jǐnjí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '紧急'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '紧急'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'jǐnjí',
      meaning_vi = 'khẩn cấp, cấp bách',
      example_hanzi = '如果遇到火灾等紧急情况，请务必保持冷静并迅速从安全通道撤离。',
      example_pinyin = 'Rúguǒ yùdào huǒzāi děng jǐnjí qíngkuàng, qǐng wùbì bǎochí lěngjìng bìng xùnsù cóng ānquán tōngdào chèlí.',
      example_vi = 'Nếu gặp phải các tình huống khẩn cấp như hỏa hoạn, xin hãy giữ bình tĩnh và nhanh chóng sơ tán theo lối thoát hiểm an toàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '紧急',
      'jǐnjí',
      'khẩn cấp, cấp bách',
      'Tính từ',
      'HSK 5',
      '如果遇到火灾等紧急情况，请务必保持冷静并迅速从安全通道撤离。',
      'Rúguǒ yùdào huǒzāi děng jǐnjí qíngkuàng, qǐng wùbì bǎochí lěngjìng bìng xùnsù cóng ānquán tōngdào chèlí.',
      'Nếu gặp phải các tình huống khẩn cấp như hỏa hoạn, xin hãy giữ bình tĩnh và nhanh chóng sơ tán theo lối thoát hiểm an toàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果遇到火灾等紧急情况，请务必保持冷静并迅速从安全通道撤离。', 'Rúguǒ yùdào huǒzāi děng jǐnjí qíngkuàng, qǐng wùbì bǎochí lěngjìng bìng xùnsù cóng ānquán tōngdào chèlí.', 'Nếu gặp phải các tình huống khẩn cấp như hỏa hoạn, xin hãy giữ bình tĩnh và nhanh chóng sơ tán theo lối thoát hiểm an toàn.', 'basic', 1),
      (v_id, '国务院应急管理部门在地震灾害发生后第一时刻启动国家一级紧急响应，全面统筹调配全国专业救援力量星夜驰援灾区。', 'Guówùyuàn yìngjí guǎnlǐ bùmén zài dìzhèn zāihài fāshēng hòu dì-yī shíkè qǐdòng guójiā yī jí jǐnjí xiǎngyìng, quánmiàn tǒngchóu tiàopèi quánguó zhuānyè jiùyuán lìliàng xīngyè chíyuán zāiqū.', 'Bộ Quản lý Khẩn cấp Quốc vụ viện ngay sau khi xảy ra thảm họa động đất đã kích hoạt phản ứng khẩn cấp cấp độ một quốc gia, điều phối tổng thể các lực lượng cứu hộ chuyên nghiệp trên toàn quốc gấp rút cứu trợ xuyên đêm tới vùng thảm họa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2609] [尽快] (jǐnkuài) - càng sớm càng tốt, nhanh chóng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '尽快' AND pinyin = 'jǐnkuài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尽快' AND pinyin = 'jǐnkuài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '尽快'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尽快'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jǐnkuài',
      meaning_vi = 'càng sớm càng tốt, nhanh chóng',
      example_hanzi = '请大家在下班前尽快把本月的财务报销单据提交审核。',
      example_pinyin = 'Qǐng dàjiā zài xiàbān qián jǐnkuài bǎ běn yuè de cáiwù bàoxiāo dānjù tíjiāo shěnhé.',
      example_vi = 'Xin mọi người trước giờ tan làm hãy nhanh chóng nộp các chứng từ thanh toán tài chính của tháng này để xét duyệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '尽快',
      'jǐnkuài',
      'càng sớm càng tốt, nhanh chóng',
      'Phó từ',
      'HSK 5',
      '请大家在下班前尽快把本月的财务报销单据提交审核。',
      'Qǐng dàjiā zài xiàbān qián jǐnkuài bǎ běn yuè de cáiwù bàoxiāo dānjù tíjiāo shěnhé.',
      'Xin mọi người trước giờ tan làm hãy nhanh chóng nộp các chứng từ thanh toán tài chính của tháng này để xét duyệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请大家在下班前尽快把本月的财务报销单据提交审核。', 'Qǐng dàjiā zài xiàbān qián jǐnkuài bǎ běn yuè de cáiwù bàoxiāo dānjù tíjiāo shěnhé.', 'Xin mọi người trước giờ tan làm hãy nhanh chóng nộp các chứng từ thanh toán tài chính của tháng này để xét duyệt.', 'basic', 1),
      (v_id, '为遏制疫情蔓延并恢复正常的社会经济秩序，当地政府协同公共卫生机构尽快建立起全域覆盖的快速筛查与流调网络。', 'Wèi èzhì yìqíng mànyán bìng huīfù zhèngcháng de shèhuì jīngjì zhìxù, dāngdì zhèngfǔ xiétóng gōnggòng wèishēng jīgòu jǐnkuài jiànlì qǐ quányù fùgài de kuàisù shāichá yǔ liúdiào wǎngluò.', 'Nhằm kiềm chế dịch bệnh lây lan và phục hồi trật tự kinh tế xã hội bình thường, chính quyền địa phương phối hợp cùng cơ quan y tế công cộng nhanh chóng thiết lập mạng lưới sàng lọc nhanh và điều tra dịch tễ bao phủ toàn địa bàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2610] [尽量] (jǐnliàng) - cố gắng hết sức, ráng hết mức, hết sức có thể [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '尽量' AND pinyin = 'jǐnliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尽量' AND pinyin = 'jǐnliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '尽量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尽量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jǐnliàng',
      meaning_vi = 'cố gắng hết sức, ráng hết mức, hết sức có thể',
      example_hanzi = '医生叮嘱他平时要尽量少吃辛辣油腻的食物。',
      example_pinyin = 'Yīshēng dīngzhǔ tā píngshí yào jǐnliàng shǎo chī xīnlà yóunì de shíwù.',
      example_vi = 'Bác sĩ dặn dò anh ấy thường ngày nên cố gắng hạn chế ăn các món cay nóng và nhiều dầu mỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '尽量',
      'jǐnliàng',
      'cố gắng hết sức, ráng hết mức, hết sức có thể',
      'Phó từ',
      'HSK 5',
      '医生叮嘱他平时要尽量少吃辛辣油腻的食物。',
      'Yīshēng dīngzhǔ tā píngshí yào jǐnliàng shǎo chī xīnlà yóunì de shíwù.',
      'Bác sĩ dặn dò anh ấy thường ngày nên cố gắng hạn chế ăn các món cay nóng và nhiều dầu mỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医生叮嘱他平时要尽量少吃辛辣油腻的食物。', 'Yīshēng dīngzhǔ tā píngshí yào jǐnliàng shǎo chī xīnlà yóunì de shíwù.', 'Bác sĩ dặn dò anh ấy thường ngày nên cố gắng hạn chế ăn các món cay nóng và nhiều dầu mỡ.', 'basic', 1),
      (v_id, '在制定企业中长期发展规划时，管理层必须充分评估宏观政策不确定性，尽量规避跨国资本市场的潜在流动性风险。', 'Zài zhìdìng qǐyè zhōng-chángqī fāzhǎn guīhuà shí, guǎnlǐcéng bìxū chōngfèn pínggū hóngguān zhèngcè bùquèdìngxìng, jǐnliàng guībì kuàguó zīběn shìchǎng de qiánzài liúdòngxìng fēngxiǎn.', 'Khi xây dựng quy hoạch phát triển trung và dài hạn cho doanh nghiệp, ban điều hành phải đánh giá thấu đáo sự bất định của chính sách vĩ mô nhằm cố gắng tối đa né tránh các rủi ro thanh khoản tiềm ẩn trên thị trường vốn xuyên quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2611] [紧密] (jǐnmì) - khăng khít, chặt chẽ, gắn kết [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '紧密' AND pinyin = 'jǐnmì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '紧密' AND pinyin = 'jǐnmì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '紧密'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '紧密'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'jǐnmì',
      meaning_vi = 'khăng khít, chặt chẽ, gắn kết',
      example_hanzi = '邻里之间保持着紧密的联系，谁家有困难大家都会热心帮忙。',
      example_pinyin = 'Línlǐ zhījiān bǎochí zhe jǐnmì de liánxì, shuí jiā yǒu kùnnan dàjiā dōu huì rèxīn bāngmáng.',
      example_vi = 'Giữa xóm giềng luôn duy trì mối liên hệ khăng khít, nhà ai gặp khó khăn mọi người đều nhiệt tình giúp đỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '紧密',
      'jǐnmì',
      'khăng khít, chặt chẽ, gắn kết',
      'Tính từ',
      'HSK 5',
      '邻里之间保持着紧密的联系，谁家有困难大家都会热心帮忙。',
      'Línlǐ zhījiān bǎochí zhe jǐnmì de liánxì, shuí jiā yǒu kùnnan dàjiā dōu huì rèxīn bāngmáng.',
      'Giữa xóm giềng luôn duy trì mối liên hệ khăng khít, nhà ai gặp khó khăn mọi người đều nhiệt tình giúp đỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '邻里之间保持着紧密的联系，谁家有困难大家都会热心帮忙。', 'Línlǐ zhījiān bǎochí zhe jǐnmì de liánxì, shuí jiā yǒu kùnnan dàjiā dōu huì rèxīn bāngmáng.', 'Giữa xóm giềng luôn duy trì mối liên hệ khăng khít, nhà ai gặp khó khăn mọi người đều nhiệt tình giúp đỡ.', 'basic', 1),
      (v_id, '随着区域全面经济伙伴关系协定的深入实施，成员国之间在关税减让、产业链分工以及技术标准互认方面建立了更加紧密的战略协作体系。', 'Suízhe Qūyù Quánmiàn Jīngjì Huǒbàn Guānxì Xiédìng de shēnrù shíshī, chéngyuánguó zhījiān zài guānshuì jiǎnràng, chǎnyèliàn fēngōng yǐjí jìshù biāozhǔn hùrèn fāngmiàn jiànlì le gèngjiā jǐnmì de zhànlüè xiézuò tǐxì.', 'Cùng với sự thực thi sâu rộng của Hiệp định Đối tác Kinh tế Toàn diện Khu vực, giữa các nước thành viên đã thiết lập một hệ thống hợp tác chiến lược ngày càng chặt chẽ về cắt giảm thuế quan, phân công chuỗi công nghiệp và công nhận lẫn nhau các tiêu chuẩn kỹ thuật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2612] [谨慎] (jǐnshèn) - cẩn trọng, thận trọng, dè dặt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '谨慎' AND pinyin = 'jǐnshèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '谨慎' AND pinyin = 'jǐnshèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '谨慎'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '谨慎'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'jǐnshèn',
      meaning_vi = 'cẩn trọng, thận trọng, dè dặt',
      example_hanzi = '在签署重要的商业合同前，务必谨慎阅读每一项条款细则。',
      example_pinyin = 'Zài qiānshǔ zhòngyào de shāngyè hétong qián, wùbì jǐnshèn yuèdú měi yí xiàng tiáokuǎn xìzé.',
      example_vi = 'Trước khi ký kết các hợp đồng thương mại quan trọng, nhất thiết phải đọc thật cẩn trọng từng điều khoản chi tiết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '谨慎',
      'jǐnshèn',
      'cẩn trọng, thận trọng, dè dặt',
      'Tính từ',
      'HSK 5',
      '在签署重要的商业合同前，务必谨慎阅读每一项条款细则。',
      'Zài qiānshǔ zhòngyào de shāngyè hétong qián, wùbì jǐnshèn yuèdú měi yí xiàng tiáokuǎn xìzé.',
      'Trước khi ký kết các hợp đồng thương mại quan trọng, nhất thiết phải đọc thật cẩn trọng từng điều khoản chi tiết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在签署重要的商业合同前，务必谨慎阅读每一项条款细则。', 'Zài qiānshǔ zhòngyào de shāngyè hétong qián, wùbì jǐnshèn yuèdú měi yí xiàng tiáokuǎn xìzé.', 'Trước khi ký kết các hợp đồng thương mại quan trọng, nhất thiết phải đọc thật cẩn trọng từng điều khoản chi tiết.', 'basic', 1),
      (v_id, '面对高度复杂的国际金融环境与外汇汇率剧烈波动，投资决策委员会采取了极为谨慎稳健的跨国资产配置策略。', 'Miànduì gāodù fùzá de guójì jīnróng huánjìng yǔ wàihuì huìlǜ jùliè bōdòng, tóuzī juécè wěiyuánhuì cǎiqǔ le jíwéi jǐnshèn wěnjiàn de kuàguó zīchǎn pèizhì cèlüè.', 'Đối mặt với môi trường tài chính quốc tế phức tạp cao độ và biến động dữ dội của tỷ giá ngoại hối, hội đồng ra quyết định đầu tư đã áp dụng chiến lược phân bổ tài sản xuyên quốc gia vô cùng thận trọng và vững chắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2613] [进步] (jìnbù) - tiến bộ, cải thiện; tiến bộ (tư tưởng) [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '进步' AND pinyin = 'jìnbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '进步' AND pinyin = 'jìnbù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '进步'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '进步'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'jìnbù',
      meaning_vi = 'tiến bộ, cải thiện; tiến bộ (tư tưởng)',
      example_hanzi = '经过一个学期的刻苦钻研，他的中文听说水平取得了显著的进步。',
      example_pinyin = 'Jīngguò yí gè xuéqī de kèkǔ zuānyán, tā de Zhōngwén tīngshuō shuǐpíng qǔdé le xiǎnzhù de jìnbù.',
      example_vi = 'Qua một học kỳ miệt mài rèn luyện, trình độ nghe nói tiếng Trung của anh ấy đã đạt được sự tiến bộ rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '进步',
      'jìnbù',
      'tiến bộ, cải thiện; tiến bộ (tư tưởng)',
      'Động từ / Tính từ',
      'HSK 5',
      '经过一个学期的刻苦钻研，他的中文听说水平取得了显著的进步。',
      'Jīngguò yí gè xuéqī de kèkǔ zuānyán, tā de Zhōngwén tīngshuō shuǐpíng qǔdé le xiǎnzhù de jìnbù.',
      'Qua một học kỳ miệt mài rèn luyện, trình độ nghe nói tiếng Trung của anh ấy đã đạt được sự tiến bộ rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过一个学期的刻苦钻研，他的中文听说水平取得了显著的进步。', 'Jīngguò yí gè xuéqī de kèkǔ zuānyán, tā de Zhōngwén tīngshuō shuǐpíng qǔdé le xiǎnzhù de jìnbù.', 'Qua một học kỳ miệt mài rèn luyện, trình độ nghe nói tiếng Trung của anh ấy đã đạt được sự tiến bộ rõ rệt.', 'basic', 1),
      (v_id, '科技创新是引领人类文明社会进步的核心动力源泉，必须持续加大基础前沿科学的基础性与战略性研发投入。', 'Kējì chuàngxīn shì yǐnlǐng rénlèi wénmíng shèhuì jìnbù de héxīn dònglì yuánquán, bìxū chíxù jiādà jīchǔ qiányán kēxué de jīchǔxìng yǔ zhànlüèxìng yánfā tóurù.', 'Đổi mới sáng tạo khoa học công nghệ là nguồn động lực cốt lõi dẫn dắt sự tiến bộ của xã hội văn minh nhân loại, đòi hỏi phải liên tục gia tăng đầu tư nghiên cứu mang tính chiến lược và nền tảng cho khoa học cơ bản tiên phong.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2614] [近代] (jìndài) - thời cận đại, cận đại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '近代' AND pinyin = 'jìndài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '近代' AND pinyin = 'jìndài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '近代'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '近代'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìndài',
      meaning_vi = 'thời cận đại, cận đại',
      example_hanzi = '历史博物馆里陈列着许多反映中国近代社会变迁的历史珍贵文物。',
      example_pinyin = 'Lìshǐ bówùguǎn lǐ chénliè zhe xǔduō fǎnyìng Zhōngguó jìndài shèhuì biànqiān de lìshǐ zhēnguì wénwù.',
      example_vi = 'Trong bảo tàng lịch sử trưng bày rất nhiều hiện vật quý giá phản ánh những biến thiên của xã hội Trung Quốc thời cận đại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '近代',
      'jìndài',
      'thời cận đại, cận đại',
      'Danh từ',
      'HSK 5',
      '历史博物馆里陈列着许多反映中国近代社会变迁的历史珍贵文物。',
      'Lìshǐ bówùguǎn lǐ chénliè zhe xǔduō fǎnyìng Zhōngguó jìndài shèhuì biànqiān de lìshǐ zhēnguì wénwù.',
      'Trong bảo tàng lịch sử trưng bày rất nhiều hiện vật quý giá phản ánh những biến thiên của xã hội Trung Quốc thời cận đại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '历史博物馆里陈列着许多反映中国近代社会变迁的历史珍贵文物。', 'Lìshǐ bówùguǎn lǐ chénliè zhe xǔduō fǎnyìng Zhōngguó jìndài shèhuì biànqiān de lìshǐ zhēnguì wénwù.', 'Trong bảo tàng lịch sử trưng bày rất nhiều hiện vật quý giá phản ánh những biến thiên của xã hội Trung Quốc thời cận đại.', 'basic', 1),
      (v_id, '中国近代史是一部中华民族百折不挠救亡图存的壮烈奋斗史，深刻昭示了落后就要挨打、唯有自强才能自立的历史铁律。', 'Zhōngguó jìndàishǐ shì yí bù Zhōnghuá mínzú bǎizhé-bùnáo jiùwáng-túcún de zhuàngliè fèndòushǐ, shēnkè zhāoshì le luòhòu jiù yào áidǎ, wéiyǒu zìqiáng cáinéng zìlì de lìshǐ tiělǜ.', 'Lịch sử cận đại Trung Quốc là một pho sử đấu tranh kiên cường bất khuất cứu nước cứu nòi đầy bi tráng của dân tộc Trung Hoa, minh chứng sâu sắc quy luật lịch sử rằng lạc hậu ắt bị bắt nạt, chỉ có tự cường mới có thể tự lập.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2615] [进口] (jìnkǒu) - nhập khẩu; lối vào, cửa vào [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '进口' AND pinyin = 'jìnkǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '进口' AND pinyin = 'jìnkǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '进口'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '进口'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jìnkǒu',
      meaning_vi = 'nhập khẩu; lối vào, cửa vào',
      example_hanzi = '商场超市里设立了专门销售进口优质水果和奶制品的专柜。',
      example_pinyin = 'Shāngchǎng chāoshì lǐ shèlì le zhuānmén xiāoshòu jìnkǒu yōuzhì shuǐguǒ hé nǎizhìpǐn de zhuānguì.',
      example_vi = 'Trong siêu thị có đặt các quầy hàng chuyên bán hoa quả và sản phẩm từ sữa nhập khẩu chất lượng cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '进口',
      'jìnkǒu',
      'nhập khẩu; lối vào, cửa vào',
      'Động từ / Danh từ',
      'HSK 5',
      '商场超市里设立了专门销售进口优质水果和奶制品的专柜。',
      'Shāngchǎng chāoshì lǐ shèlì le zhuānmén xiāoshòu jìnkǒu yōuzhì shuǐguǒ hé nǎizhìpǐn de zhuānguì.',
      'Trong siêu thị có đặt các quầy hàng chuyên bán hoa quả và sản phẩm từ sữa nhập khẩu chất lượng cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '商场超市里设立了专门销售进口优质水果和奶制品的专柜。', 'Shāngchǎng chāoshì lǐ shèlì le zhuānmén xiāoshòu jìnkǒu yōuzhì shuǐguǒ hé nǎizhìpǐn de zhuānguì.', 'Trong siêu thị có đặt các quầy hàng chuyên bán hoa quả và sản phẩm từ sữa nhập khẩu chất lượng cao.', 'basic', 1),
      (v_id, '为满足国内产业转型与消费升级的多元化需求，国家主动降低部分先进技术装备、关键零部件及抗癌医药品的进口关税。', 'Wèi mǎnzú guónèi chǎnyè zhuǎnxíng yǔ xiāofèi shēngjí de duōyuánhuà xūqiú, guójiā zhǔdòng jiàngdī bùfen xiānjìn jìshù zhuāngbèi, guānjiàn língbùjiàn jí kàng’ái yīyàopǐn de jìnkǒu guānshuì.', 'Nhằm đáp ứng nhu cầu đa dạng hóa về chuyển đổi ngành nghề và nâng tầm tiêu dùng trong nước, nhà nước đã chủ động hạ thuế nhập khẩu đối với một số thiết bị công nghệ tiên tiến, linh kiện then chốt và thuốc kháng ung thư.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2616] [尽力] (jìnlì) - hết sức, tận lực, dốc toàn lực [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '尽力' AND pinyin = 'jìnlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尽力' AND pinyin = 'jìnlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '尽力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尽力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jìnlì',
      meaning_vi = 'hết sức, tận lực, dốc toàn lực',
      example_hanzi = '无论最终结果如何，只要我们在整个备考过程中尽力了就不会留下遗憾。',
      example_pinyin = 'Wúlùn zuìzhōng jiéguǒ rúhé, zhǐyào wǒmen zài zhěnggè bèikǎo guòchéng zhōng jìnlì le jiù bú huì liúxià yíhàn.',
      example_vi = 'Bất luận kết quả cuối cùng ra sao, chỉ cần chúng ta đã dốc hết sức mình trong suốt quá trình ôn thi thì sẽ không còn gì phải nuối tiếc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '尽力',
      'jìnlì',
      'hết sức, tận lực, dốc toàn lực',
      'Động từ',
      'HSK 5',
      '无论最终结果如何，只要我们在整个备考过程中尽力了就不会留下遗憾。',
      'Wúlùn zuìzhōng jiéguǒ rúhé, zhǐyào wǒmen zài zhěnggè bèikǎo guòchéng zhōng jìnlì le jiù bú huì liúxià yíhàn.',
      'Bất luận kết quả cuối cùng ra sao, chỉ cần chúng ta đã dốc hết sức mình trong suốt quá trình ôn thi thì sẽ không còn gì phải nuối tiếc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论最终结果如何，只要我们在整个备考过程中尽力了就不会留下遗憾。', 'Wúlùn zuìzhōng jiéguǒ rúhé, zhǐyào wǒmen zài zhěnggè bèikǎo guòchéng zhōng jìnlì le jiù bú huì liúxià yíhàn.', 'Bất luận kết quả cuối cùng ra sao, chỉ cần chúng ta đã dốc hết sức mình trong suốt quá trình ôn thi thì sẽ không còn gì phải nuối tiếc.', 'basic', 1),
      (v_id, '全体医护人员通宵达旦与死神赛跑，尽最大努力拯救每一个危重患者的宝贵生命，完美诠释了救死扶伤的医者仁心。', 'Quántǐ yīhù rényuán tōngxiāo-dádàn yǔ sǐshén sàipǎo, jìn zuìdà nǔlì zhěngjiù měi yí gè wēizhòng huànzhě de bǎoguì shēngmìng, wánměi quánshì le jiùsǐ-fúshāng de yīzhě rénxīn.', 'Toàn thể đội ngũ y bác sĩ thức trắng đêm chạy đua với tử thần, dốc kiệt sức mình cứu lấy từng sinh mạng quý báu của người bệnh nguy kịch, khắc họa trọn vẹn lòng nhân ái của người thầy thuốc cứu người giúp đời.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2617] [近年来] (jìnnián lái) - những năm gần đây, mấy năm trở lại đây [Cụm từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '近年来' AND pinyin = 'jìnnián lái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '近年来' AND pinyin = 'jìnnián lái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '近年来'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '近年来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Cụm từ / Danh từ',
      pinyin = 'jìnnián lái',
      meaning_vi = 'những năm gần đây, mấy năm trở lại đây',
      example_hanzi = '近年来，越来越多的人选择骑共享单车作为城市短途出行的低碳方式。',
      example_pinyin = 'Jìnnián lái, yuèláiyuè duō de rén xuǎnzé qí gòngxiǎng dānchē zuòwéi chéngshì duǎntú chūxíng de dītàn fāngshì.',
      example_vi = 'Những năm gần đây, ngày càng nhiều người lựa chọn đi xe đạp công cộng như một cách thức đi lại cự ly ngắn ít phát thải carbon trong đô thị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '近年来',
      'jìnnián lái',
      'những năm gần đây, mấy năm trở lại đây',
      'Cụm từ / Danh từ',
      'HSK 5',
      '近年来，越来越多的人选择骑共享单车作为城市短途出行的低碳方式。',
      'Jìnnián lái, yuèláiyuè duō de rén xuǎnzé qí gòngxiǎng dānchē zuòwéi chéngshì duǎntú chūxíng de dītàn fāngshì.',
      'Những năm gần đây, ngày càng nhiều người lựa chọn đi xe đạp công cộng như một cách thức đi lại cự ly ngắn ít phát thải carbon trong đô thị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '近年来，越来越多的人选择骑共享单车作为城市短途出行的低碳方式。', 'Jìnnián lái, yuèláiyuè duō de rén xuǎnzé qí gòngxiǎng dānchē zuòwéi chéngshì duǎntú chūxíng de dītàn fāngshì.', 'Những năm gần đây, ngày càng nhiều người lựa chọn đi xe đạp công cộng như một cách thức đi lại cự ly ngắn ít phát thải carbon trong đô thị.', 'basic', 1),
      (v_id, '近年来，依托大数据算力底座与生成式人工智能技术的爆发式迭代，数字经济已成为驱动全球高质量发展的新引擎。', 'Jìnnián lái, yītuō dàshùjù suànlì dǐzuò yǔ shēngchéngxìng réngōng zhìnéng jìshù de bàofāshì diédài, shùzì jīngjì yǐ chéngwéi qūdòng quánqiú gāo zhìliàng fāzhǎn de xīn yǐnqíng.', 'Mấy năm trở lại đây, dựa trên nền tảng năng lực tính toán dữ liệu lớn và sự bùng nổ cải tiến của trí tuệ nhân tạo tạo sinh, nền kinh tế số đã trở thành động cơ mới thúc đẩy sự phát triển chất lượng cao trên toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2618] [近期] (jìnqī) - thời gian gần đây, dạo gần đây; thời kỳ sắp tới [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '近期' AND pinyin = 'jìnqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '近期' AND pinyin = 'jìnqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '近期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '近期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìnqī',
      meaning_vi = 'thời gian gần đây, dạo gần đây; thời kỳ sắp tới',
      example_hanzi = '学校近期将组织一次全校范围的春季消防疏散应急演练。',
      example_pinyin = 'Xuéxiào jìnqī jiāng zǔzhī yí cì quán xiào fànwéi de chūnjì xiāofáng shūsàn yìngjí yǎanliàn.',
      example_vi = 'Trường học trong thời gian tới đây sẽ tổ chức một buổi diễn tập khẩn cấp sơ tán phòng cháy chữa cháy mùa xuân trong phạm vi toàn trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '近期',
      'jìnqī',
      'thời gian gần đây, dạo gần đây; thời kỳ sắp tới',
      'Danh từ',
      'HSK 5',
      '学校近期将组织一次全校范围的春季消防疏散应急演练。',
      'Xuéxiào jìnqī jiāng zǔzhī yí cì quán xiào fànwéi de chūnjì xiāofáng shūsàn yìngjí yǎanliàn.',
      'Trường học trong thời gian tới đây sẽ tổ chức một buổi diễn tập khẩn cấp sơ tán phòng cháy chữa cháy mùa xuân trong phạm vi toàn trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校近期将组织一次全校范围的春季消防疏散应急演练。', 'Xuéxiào jìnqī jiāng zǔzhī yí cì quán xiào fànwéi de chūnjì xiāofáng shūsàn yìngjí yǎanliàn.', 'Trường học trong thời gian tới đây sẽ tổ chức một buổi diễn tập khẩn cấp sơ tán phòng cháy chữa cháy mùa xuân trong phạm vi toàn trường.', 'basic', 1),
      (v_id, '鉴于近期国际大宗商品价格与航运运价指数的剧烈震荡，多部门联合发布风险提示并出台供应链保供稳价政策组合拳。', 'Jiànyú jìnqī guójì dàzōng shāngpǐn jiàgé yǔ hángyùn yùnjià zhǐshù de jùliè zhèndàng, duō bùmén liánhé fābù fēngxiǎn tíshì bìng chūtái gōngyìngliàn bǎogōng-wěnjià zhèngcè zǔhéquán.', 'Xét thấy thời gian gần đây giá hàng hóa cơ bản quốc tế và chỉ số cước vận tải biển biến động mạnh, nhiều cơ quan ban ngành đã phối hợp phát cảnh báo rủi ro và tung ra gói chính sách đồng bộ nhằm bảo đảm nguồn cung và bình ổn giá chuỗi cung ứng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2619] [近日] (jìnrì) - mấy ngày gần đây, dạo này; vài ngày tới [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '近日' AND pinyin = 'jìnrì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '近日' AND pinyin = 'jìnrì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '近日'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '近日'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìnrì',
      meaning_vi = 'mấy ngày gần đây, dạo này; vài ngày tới',
      example_hanzi = '近日天气多变早晚温差较大，出门时请注意及时添减衣物防寒。',
      example_pinyin = 'Jìnrì tiānqì duōbiàn zǎowǎn wēnchā jiào dà, chūmén shí qǐng zhùyì jíshí tiān-jiǎn yīwù fánghán.',
      example_vi = 'Mấy ngày gần đây thời tiết biến đổi thất thường, chênh lệch nhiệt độ ngày và đêm khá lớn, khi ra ngoài xin lưu ý mặc thêm hoặc bớt áo ấm để phòng cảm lạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '近日',
      'jìnrì',
      'mấy ngày gần đây, dạo này; vài ngày tới',
      'Danh từ',
      'HSK 5',
      '近日天气多变早晚温差较大，出门时请注意及时添减衣物防寒。',
      'Jìnrì tiānqì duōbiàn zǎowǎn wēnchā jiào dà, chūmén shí qǐng zhùyì jíshí tiān-jiǎn yīwù fánghán.',
      'Mấy ngày gần đây thời tiết biến đổi thất thường, chênh lệch nhiệt độ ngày và đêm khá lớn, khi ra ngoài xin lưu ý mặc thêm hoặc bớt áo ấm để phòng cảm lạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '近日天气多变早晚温差较大，出门时请注意及时添减衣物防寒。', 'Jìnrì tiānqì duōbiàn zǎowǎn wēnchā jiào dà, chūmén shí qǐng zhùyì jíshí tiān-jiǎn yīwù fánghán.', 'Mấy ngày gần đây thời tiết biến đổi thất thường, chênh lệch nhiệt độ ngày và đêm khá lớn, khi ra ngoài xin lưu ý mặc thêm hoặc bớt áo ấm để phòng cảm lạnh.', 'basic', 1),
      (v_id, '近日，由我国科研机构牵头联合研发的超导量子计算机原型机成功实现量子优越性验证，引发国际学术界的广泛关注。', 'Jìnrì, yóu wǒ guó kēyán jīgòu qiāntóu liánhé yánfā de chāodǎo liàngzǐ jìsuànjī yuánxíngjī chénggōng shíxiàn liàngzǐ yōuyuèxìng yànzhèng, yǐnfā guójì xuéshùjiè de guǎnfàn guānzhù.', 'Mới đây, nguyên mẫu máy tính lượng tử siêu dẫn do các viện nghiên cứu khoa học nước ta chủ trì phối hợp phát triển đã kiểm chứng thành công tính ưu việt lượng tử, thu hút sự quan tâm rộng rãi của giới học thuật quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2620] [进一步] (jìnyíbù) - hơn một bước, sâu hơn, thêm một bước [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '进一步' AND pinyin = 'jìnyíbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '进一步' AND pinyin = 'jìnyíbù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '进一步'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '进一步'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jìnyíbù',
      meaning_vi = 'hơn một bước, sâu hơn, thêm một bước',
      example_hanzi = '通过老师的细致讲解，我们对这首古诗的主题有了进一步的理解。',
      example_pinyin = 'Tōngguò lǎoshī de xìzhì jiǎngjiě, wǒmen duì zhè shǒu gǔshī de zhǔtí yǒu le jìnyíbù de lǐjiě.',
      example_vi = 'Qua lời giảng tỉ mỉ của thầy giáo, chúng tôi đã có sự hiểu biết sâu sắc hơn một bước về chủ đề của bài thơ cổ này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '进一步',
      'jìnyíbù',
      'hơn một bước, sâu hơn, thêm một bước',
      'Phó từ',
      'HSK 5',
      '通过老师的细致讲解，我们对这首古诗的主题有了进一步的理解。',
      'Tōngguò lǎoshī de xìzhì jiǎngjiě, wǒmen duì zhè shǒu gǔshī de zhǔtí yǒu le jìnyíbù de lǐjiě.',
      'Qua lời giảng tỉ mỉ của thầy giáo, chúng tôi đã có sự hiểu biết sâu sắc hơn một bước về chủ đề của bài thơ cổ này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '通过老师的细致讲解，我们对这首古诗的主题有了进一步的理解。', 'Tōngguò lǎoshī de xìzhì jiǎngjiě, wǒmen duì zhè shǒu gǔshī de zhǔtí yǒu le jìnyíbù de lǐjiě.', 'Qua lời giảng tỉ mỉ của thầy giáo, chúng tôi đã có sự hiểu biết sâu sắc hơn một bước về chủ đề của bài thơ cổ này.', 'basic', 1),
      (v_id, '为进一步激发民营经济活力并优化营商法治环境，国家持续破除市场准入壁垒并强化知识产权全链条司法保护。', 'Wèi jìnyíbù jīfā mínyíng jīngjì huólì bìng yōuhuà yíngshāng fǎzhì huánjìng, guójiā chíxù pòchú shìchǎng zhǔnrù bìlěi bìng qiánghuà zhīshi chǎnquán quán liàntiáo sīfǎ bǎohù.', 'Nhằm kích thích thêm một bước sức sống của nền kinh tế tư nhân và tối ưu hóa môi trường pháp lý kinh doanh, nhà nước liên tục dỡ bỏ các rào cản gia nhập thị trường và tăng cường bảo hộ tư pháp toàn chuỗi đối với quyền sở hữu trí tuệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2621] [经典] (jīngdiǎn) - kinh điển, tác phẩm kinh điển; mẫu mực, tiêu biểu [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '经典' AND pinyin = 'jīngdiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '经典' AND pinyin = 'jīngdiǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '经典'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '经典'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'jīngdiǎn',
      meaning_vi = 'kinh điển, tác phẩm kinh điển; mẫu mực, tiêu biểu',
      example_hanzi = '阅读世界文学经典名著能够丰富一个人的内心世界与精神境界。',
      example_pinyin = 'Yuèdú shìjiè wénxué jīngdiǎn míngzhù nénggòu fēngfù yí gè rén de nèixīn shìjiè yǔ jīngshén jìngjiè.',
      example_vi = 'Đọc các tác phẩm danh tác kinh điển của văn học thế giới có thể làm phong phú thế giới nội tâm và cảnh giới tinh thần của mỗi con người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '经典',
      'jīngdiǎn',
      'kinh điển, tác phẩm kinh điển; mẫu mực, tiêu biểu',
      'Danh từ / Tính từ',
      'HSK 5',
      '阅读世界文学经典名著能够丰富一个人的内心世界与精神境界。',
      'Yuèdú shìjiè wénxué jīngdiǎn míngzhù nénggòu fēngfù yí gè rén de nèixīn shìjiè yǔ jīngshén jìngjiè.',
      'Đọc các tác phẩm danh tác kinh điển của văn học thế giới có thể làm phong phú thế giới nội tâm và cảnh giới tinh thần của mỗi con người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '阅读世界文学经典名著能够丰富一个人的内心世界与精神境界。', 'Yuèdú shìjiè wénxué jīngdiǎn míngzhù nénggòu fēngfù yí gè rén de nèixīn shìjiè yǔ jīngshén jìngjiè.', 'Đọc các tác phẩm danh tác kinh điển của văn học thế giới có thể làm phong phú thế giới nội tâm và cảnh giới tinh thần của mỗi con người.', 'basic', 1),
      (v_id, '这部由著名导演倾力执导的史诗巨作，以其深刻的哲思意蕴与开创性的镜头语言，成为了世界电影艺术史上无可争议的传世经典。', 'Zhè bù yóu zhùmíng dǎoyǎn qīnglì zhídǎo de shǐshī jùzuò, yǐ qí shēnkè de zhésī yìyùn yǔ kāichuàngxìng de jìngtóu yǔyán, chéngwéi le shìjiè diànyǐng yìshùshǐ shang wúkě zhēngyì de chuánshì jīngdiǎn.', 'Tác phẩm sử thi đồ sộ do đạo diễn lừng danh dồn trọn tâm huyết dàn dựng, với hàm ý triết học sâu xa và ngôn ngữ khung hình mang tính mở đường, đã trở thành tác phẩm kinh điển lưu danh thiên cổ không thể tranh cãi trong lịch sử nghệ thuật điện ảnh thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2622] [精力] (jīnglì) - tinh lực, sức lực, năng lượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '精力' AND pinyin = 'jīnglì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '精力' AND pinyin = 'jīnglì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '精力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '精力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jīnglì',
      meaning_vi = 'tinh lực, sức lực, năng lượng',
      example_hanzi = '考前复习阶段，要把有限的精力和时间集中在攻克自己的薄弱知识点上。',
      example_pinyin = 'Kǎoqián fùxí jiēduàn, yào bǎ yǒuxiàn de jīnglì hé shíjiān jízhōng zài gōngkè zìjǐ de bóruò zhīshidǐan shang.',
      example_vi = 'Trong giai đoạn ôn thi trước kỳ thi, cần phải tập trung thời gian và tinh lực có hạn vào việc khắc phục những điểm kiến thức còn yếu của bản thân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '精力',
      'jīnglì',
      'tinh lực, sức lực, năng lượng',
      'Danh từ',
      'HSK 5',
      '考前复习阶段，要把有限的精力和时间集中在攻克自己的薄弱知识点上。',
      'Kǎoqián fùxí jiēduàn, yào bǎ yǒuxiàn de jīnglì hé shíjiān jízhōng zài gōngkè zìjǐ de bóruò zhīshidǐan shang.',
      'Trong giai đoạn ôn thi trước kỳ thi, cần phải tập trung thời gian và tinh lực có hạn vào việc khắc phục những điểm kiến thức còn yếu của bản thân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '考前复习阶段，要把有限的精力和时间集中在攻克自己的薄弱知识点上。', 'Kǎoqián fùxí jiēduàn, yào bǎ yǒuxiàn de jīnglì hé shíjiān jízhōng zài gōngkè zìjǐ de bóruò zhīshidǐan shang.', 'Trong giai đoạn ôn thi trước kỳ thi, cần phải tập trung thời gian và tinh lực có hạn vào việc khắc phục những điểm kiến thức còn yếu của bản thân.', 'basic', 1),
      (v_id, '优秀的科研工作者往往善于排除外界的一切纷扰诱惑，数十年如一日将全部精力倾注于人类未知的科学前沿探索之中。', 'Yōuxiù de kēyán gōngzuòzhě wǎngwǎng shànyú páichú wàijiè de yíqiè fēnrǎo yòuhuò, shù shí nián rú yí rì jiāng quánbù jīnglì qīngzhù yú rénlèi wèizhī de kēxué qiányán tànsuǒ zhīzhōng.', 'Những nhà nghiên cứu khoa học xuất sắc thường rất giỏi gạt bỏ mọi phiền toái cám dỗ từ thế giới bên ngoài, hàng chục năm như một dồn toàn bộ tâm lực cho việc khai phá những chân trời khoa học tiên phong còn chưa biết của nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2623] [精神] (jīngshen) - tinh thần, tâm hồn; lanh lợi, phấn chấn, rạng rỡ [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '精神' AND pinyin = 'jīngshen'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '精神' AND pinyin = 'jīngshen'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '精神'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '精神'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'jīngshen',
      meaning_vi = 'tinh thần, tâm hồn; lanh lợi, phấn chấn, rạng rỡ',
      example_hanzi = '睡了一个好觉之后，他今天看起来精神格外饱满。',
      example_pinyin = 'Shuì le yí gè hǎo jiào zhīhòu, tā jīntiān kàn qǐlái jīngshen géwài bǎomǎn.',
      example_vi = 'Sau khi có một giấc ngủ ngon, hôm nay trông anh ấy tinh thần đặc biệt phấn chấn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '精神',
      'jīngshen',
      'tinh thần, tâm hồn; lanh lợi, phấn chấn, rạng rỡ',
      'Danh từ / Tính từ',
      'HSK 5',
      '睡了一个好觉之后，他今天看起来精神格外饱满。',
      'Shuì le yí gè hǎo jiào zhīhòu, tā jīntiān kàn qǐlái jīngshen géwài bǎomǎn.',
      'Sau khi có một giấc ngủ ngon, hôm nay trông anh ấy tinh thần đặc biệt phấn chấn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '睡了一个好觉之后，他今天看起来精神格外饱满。', 'Shuì le yí gè hǎo jiào zhīhòu, tā jīntiān kàn qǐlái jīngshen géwài bǎomǎn.', 'Sau khi có một giấc ngủ ngon, hôm nay trông anh ấy tinh thần đặc biệt phấn chấn.', 'basic', 1),
      (v_id, '中华民族在漫长的历史长河中铸就了自强不息、厚德载物的伟大民族精神，这是支撑国家穿越风浪并屹立于世界东方的精神纽带。', 'Zhōnghuá mínzú zài màncháng de lìshǐ chánghé zhōng zhùjiù le zìqiáng-bùxī, hòudé-zàiwù de wěidà mínzú jīngshén, zhè shì zhīchēng guójiā chuānyuè fēnglàng bìng yìlì yú shìjiè dōngfāng de jīngshén niǔdài.', 'Dân tộc Trung Hoa trong dòng chảy lịch sử đằng đẵng đã đúc kết nên tinh thần dân tộc vĩ đại không ngừng tự cường, đức dày nâng đỡ vạn vật, đây là sợi dây tinh thần chống đỡ đất nước vượt qua mọi phong ba bão táp để đứng sừng sững tại phương Đông thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2624] [惊喜] (jīngxǐ) - bất ngờ thú vị, ngạc nhiên vui sướng; mừng rỡ bất ngờ [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '惊喜' AND pinyin = 'jīngxǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '惊喜' AND pinyin = 'jīngxǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '惊喜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '惊喜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'jīngxǐ',
      meaning_vi = 'bất ngờ thú vị, ngạc nhiên vui sướng; mừng rỡ bất ngờ',
      example_hanzi = '过生日那天，朋友们悄悄为我策划了一个充满惊喜的派对。',
      example_pinyin = 'Guò shēngrì nà tiān, péngyoumen qiāoqiāo wèi wǒ cèhuà le yí gè chōngmǎn jīngxǐ de pàiduì.',
      example_vi = 'Hôm sinh nhật, bạn bè đã bí mật lên kế hoạch chuẩn bị cho tôi một bữa tiệc đầy bất ngờ thú vị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '惊喜',
      'jīngxǐ',
      'bất ngờ thú vị, ngạc nhiên vui sướng; mừng rỡ bất ngờ',
      'Danh từ / Tính từ',
      'HSK 5',
      '过生日那天，朋友们悄悄为我策划了一个充满惊喜的派对。',
      'Guò shēngrì nà tiān, péngyoumen qiāoqiāo wèi wǒ cèhuà le yí gè chōngmǎn jīngxǐ de pàiduì.',
      'Hôm sinh nhật, bạn bè đã bí mật lên kế hoạch chuẩn bị cho tôi một bữa tiệc đầy bất ngờ thú vị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '过生日那天，朋友们悄悄为我策划了一个充满惊喜的派对。', 'Guò shēngrì nà tiān, péngyoumen qiāoqiāo wèi wǒ cèhuà le yí gè chōngmǎn jīngxǐ de pàiduì.', 'Hôm sinh nhật, bạn bè đã bí mật lên kế hoạch chuẩn bị cho tôi một bữa tiệc đầy bất ngờ thú vị.', 'basic', 1),
      (v_id, '科研人员在分析深空望远镜传回的数据时惊喜地发现了一颗处于宜居带的新型系外类地行星，为地外生命探索提供了全新线索。', 'Kēyán rényuán zài fēnxī shēnkōng wàngyuǎnjìng chuánhuí de shùjù shí jīngxǐ de fāxiàn le yì kē chǔyú yíjūdài de xīnxíng xìwài lèidì hángxīng, wèi dìwài shēngmìng tànsuǒ tígōng le quánxīn xiànsuǒ.', 'Các nhà nghiên cứu khoa học khi phân tích dữ liệu kính viễn vọng không gian sâu truyền về đã mừng rỡ và bất ngờ phát hiện ra một hành tinh giống Trái Đất ngoài hệ Mặt Trời mới nằm trong vùng có thể sống được, mở ra manh mối hoàn toàn mới cho việc thám hiểm sự sống ngoài Trái Đất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2625] [经营] (jīngyíng) - kinh doanh, quản lý điều hành, vận hành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '经营' AND pinyin = 'jīngyíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '经营' AND pinyin = 'jīngyíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '经营'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '经营'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jīngyíng',
      meaning_vi = 'kinh doanh, quản lý điều hành, vận hành',
      example_hanzi = '李叔叔在古城老街上经营着一家具有百年历史的手工茶馆。',
      example_pinyin = 'Lǐ shūshu zài gǔchéng lǎojiē shang jīngyíng zhe yì jiā jùyǒu bǎi nián lìshǐ de shǒugōng cháguǎn.',
      example_vi = 'Chú Lý kinh doanh một quán trà thủ công có lịch sử trăm năm trên con phố cổ của thành cổ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '经营',
      'jīngyíng',
      'kinh doanh, quản lý điều hành, vận hành',
      'Động từ',
      'HSK 5',
      '李叔叔在古城老街上经营着一家具有百年历史的手工茶馆。',
      'Lǐ shūshu zài gǔchéng lǎojiē shang jīngyíng zhe yì jiā jùyǒu bǎi nián lìshǐ de shǒugōng cháguǎn.',
      'Chú Lý kinh doanh một quán trà thủ công có lịch sử trăm năm trên con phố cổ của thành cổ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '李叔叔在古城老街上经营着一家具有百年历史的手工茶馆。', 'Lǐ shūshu zài gǔchéng lǎojiē shang jīngyíng zhe yì jiā jùyǒu bǎi nián lìshǐ de shǒugōng cháguǎn.', 'Chú Lý kinh doanh một quán trà thủ công có lịch sử trăm năm trên con phố cổ của thành cổ.', 'basic', 1),
      (v_id, '跨国零售集团通过全面推行线上线下一体化的全渠道精细化经营战略，成功实现了在存量市场中的利润逆势增长。', 'Kuàguó língshòu jítuán tōngguò quánmiàn tuīxíng xiànshàng-xiànxià yītǐhuà de quán qúdào jīngxìhuà jīngyíng zhànlüè, chénggōng shíxiàn le zài cúnliàng shìchǎng zhōng de lìrùn nìshì zēngzhǎng.', 'Tập đoàn bán lẻ xuyên quốc gia thông qua việc triển khai toàn diện chiến lược vận hành kinh doanh tinh tế đa kênh tích hợp online và offline, đã thực hiện thành công việc tăng trưởng lợi nhuận ngược dòng ngay trong một thị trường dung lượng bão hòa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2626] [静] (jìng) - yên tĩnh, tĩnh lặng, thanh tịnh; làm tĩnh lại [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '静' AND pinyin = 'jìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '静' AND pinyin = 'jìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '静'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '静'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'jìng',
      meaning_vi = 'yên tĩnh, tĩnh lặng, thanh tịnh; làm tĩnh lại',
      example_hanzi = '夜深人静的时候，窗外只有微风吹动树叶沙沙作响的声音。',
      example_pinyin = 'Yèshēn-rénjìng de shíhou, chuāngwài zhǐyǒu wēifēng chuīdòng shùyè shāshā zuòxiǎng de shēngyīn.',
      example_vi = 'Lúc đêm khuya thanh vắng, bên ngoài cửa sổ chỉ còn lại tiếng gió thoảng lay động cành lá xào xạc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '静',
      'jìng',
      'yên tĩnh, tĩnh lặng, thanh tịnh; làm tĩnh lại',
      'Tính từ / Động từ',
      'HSK 5',
      '夜深人静的时候，窗外只有微风吹动树叶沙沙作响的声音。',
      'Yèshēn-rénjìng de shíhou, chuāngwài zhǐyǒu wēifēng chuīdòng shùyè shāshā zuòxiǎng de shēngyīn.',
      'Lúc đêm khuya thanh vắng, bên ngoài cửa sổ chỉ còn lại tiếng gió thoảng lay động cành lá xào xạc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夜深人静的时候，窗外只有微风吹动树叶沙沙作响的声音。', 'Yèshēn-rénjìng de shíhou, chuāngwài zhǐyǒu wēifēng chuīdòng shùyè shāshā zuòxiǎng de shēngyīn.', 'Lúc đêm khuya thanh vắng, bên ngoài cửa sổ chỉ còn lại tiếng gió thoảng lay động cành lá xào xạc.', 'basic', 1),
      (v_id, '在纷繁浮躁的现代都市生活中，唯有保持内心的宁静与笃定，才能在复杂变幻的环境中坚守初心、行稳致远。', 'Zài fēnfán fúzào de xiàndài dūshì shēnghuó zhōng, wéiyǒu bǎochí nèixīn de níngjìng yǔ dǔdìng, cáinéng zài fùzá biànhuàn de huánjìng zhōng jiānshǒu chūxīn, xíngwěn-zhìyuǎn.', 'Giữa đời sống đô thị hiện đại đầy xô bồ và phù hoa, chỉ có giữ cho nội tâm được tĩnh lặng và kiên định thì mới có thể kiên trì tâm niệm thuở ban đầu và vững vàng bước xa giữa muôn vàn đổi thay của hoàn cảnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2627] [酒吧] (jiǔbā) - quán rượu, quán bar [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '酒吧' AND pinyin = 'jiǔbā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '酒吧' AND pinyin = 'jiǔbā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '酒吧'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '酒吧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiǔbā',
      meaning_vi = 'quán rượu, quán bar',
      example_hanzi = '周末晚上，几个老朋友喜欢相约在静谧的酒吧里聊天听民谣。',
      example_pinyin = 'Zhōumò wǎnshang, jǐ gè lǎo péngyou xǐhuan xiāngyuē zài jìngmì de jiǔbā lǐ liáotiān tīng mínyáo.',
      example_vi = 'Tối cuối tuần, mấy người bạn cũ thích hẹn nhau ở một quán bar yên tĩnh để trò chuyện và nghe nhạc dân ca.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '酒吧',
      'jiǔbā',
      'quán rượu, quán bar',
      'Danh từ',
      'HSK 5',
      '周末晚上，几个老朋友喜欢相约在静谧的酒吧里聊天听民谣。',
      'Zhōumò wǎnshang, jǐ gè lǎo péngyou xǐhuan xiāngyuē zài jìngmì de jiǔbā lǐ liáotiān tīng mínyáo.',
      'Tối cuối tuần, mấy người bạn cũ thích hẹn nhau ở một quán bar yên tĩnh để trò chuyện và nghe nhạc dân ca.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末晚上，几个老朋友喜欢相约在静谧的酒吧里聊天听民谣。', 'Zhōumò wǎnshang, jǐ gè lǎo péngyou xǐhuan xiāngyuē zài jìngmì de jiǔbā lǐ liáotiān tīng mínyáo.', 'Tối cuối tuần, mấy người bạn cũ thích hẹn nhau ở một quán bar yên tĩnh để trò chuyện và nghe nhạc dân ca.', 'basic', 1),
      (v_id, '城市文化旅游街区通过规范发展特色主题音乐酒吧与文创演艺空间，极大地激活了夜间经济的消费新活力。', 'Chéngshì wénhuà lǚyóu jiēqū tōngguò guīfàn fāzhǎn tèsè zhǔtí yīnyuè jiǔbā yǔ wénchuàng yǎnyì kōngjiān, jídà de jīhuó le yèjiān jīngjì de xiāofèi xīn huólì.', 'Tuyến phố du lịch văn hóa đô thị thông qua việc định hướng phát triển các quán bar âm nhạc chủ đề độc đáo và không gian biểu diễn sáng tạo văn hóa đã khơi dậy mạnh mẽ sức sống tiêu dùng mới cho nền kinh tế đêm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2628] [久远] (jiǔyuǎn) - lâu đời, xa xưa, thăm thẳm [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '久远' AND pinyin = 'jiǔyuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '久远' AND pinyin = 'jiǔyuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '久远'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '久远'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'jiǔyuǎn',
      meaning_vi = 'lâu đời, xa xưa, thăm thẳm',
      example_hanzi = '由于年代久远，这本古籍书页上的字迹已经有些泛黄模糊了。',
      example_pinyin = 'Yóuyú niándài jiǔyuǎn, zhè běn gǔjí shūyè shang de zìjì yǐjīng yǒuxiē fànhuáng móhu le.',
      example_vi = 'Do thời gian đã quá lâu đời, nét chữ trên những trang sách cổ này đã có phần ố vàng và mờ nhạt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '久远',
      'jiǔyuǎn',
      'lâu đời, xa xưa, thăm thẳm',
      'Tính từ',
      'HSK 5',
      '由于年代久远，这本古籍书页上的字迹已经有些泛黄模糊了。',
      'Yóuyú niándài jiǔyuǎn, zhè běn gǔjí shūyè shang de zìjì yǐjīng yǒuxiē fànhuáng móhu le.',
      'Do thời gian đã quá lâu đời, nét chữ trên những trang sách cổ này đã có phần ố vàng và mờ nhạt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '由于年代久远，这本古籍书页上的字迹已经有些泛黄模糊了。', 'Yóuyú niándài jiǔyuǎn, zhè běn gǔjí shūyè shang de zìjì yǐjīng yǒuxiē fànhuáng móhu le.', 'Do thời gian đã quá lâu đời, nét chữ trên những trang sách cổ này đã có phần ố vàng và mờ nhạt.', 'basic', 1),
      (v_id, '考古队在地下遗址中发掘出大量青铜礼器，将该流域先民文明起源的历史向前推进到了更为久远的石器时代末期。', 'Kǎogǔduì zài dìxià yízhǐ zhōng fājué chū dàliàng qīngtóng lǐqì, jiāng gāi liùyù xiānmín wénmíng qǐyuán de lìshǐ xiàng qián tuījìn dào le gèng wéi jiǔyuǎn de shíqì shídài mòqī.', 'Đội khảo cổ đã khai quật được số lượng lớn đồ lễ bằng đồng thau trong khu di chỉ dưới lòng đất, đẩy lùi lịch sử khởi nguồn văn minh của cư dân cổ vùng lưu vực này về thời kỳ cuối thời đồ đá xa xưa hơn nữa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2629] [救] (jiù) - cứu, cứu giúp, cứu chữa, giải cứu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '救' AND pinyin = 'jiù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '救' AND pinyin = 'jiù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '救'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '救'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiù',
      meaning_vi = 'cứu, cứu giúp, cứu chữa, giải cứu',
      example_hanzi = '见有儿童不慎落水，路过的一位热心青年毫不犹豫地跳入水中将他救起。',
      example_pinyin = 'Jiàn yǒu értóng búshèn luòshuǐ, lùguò de yí wèi rèxīn qīngnián háobù-yóuyù de tiàorù shuǐzhōng jiāng tā jiùqǐ.',
      example_vi = 'Trông thấy có đứa trẻ sơ ý ngã xuống nước, một thanh niên nhiệt tình đi ngang qua đã không chút do dự nhảy xuống nước cứu em lên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '救',
      'jiù',
      'cứu, cứu giúp, cứu chữa, giải cứu',
      'Động từ',
      'HSK 5',
      '见有儿童不慎落水，路过的一位热心青年毫不犹豫地跳入水中将他救起。',
      'Jiàn yǒu értóng búshèn luòshuǐ, lùguò de yí wèi rèxīn qīngnián háobù-yóuyù de tiàorù shuǐzhōng jiāng tā jiùqǐ.',
      'Trông thấy có đứa trẻ sơ ý ngã xuống nước, một thanh niên nhiệt tình đi ngang qua đã không chút do dự nhảy xuống nước cứu em lên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '见有儿童不慎落水，路过的一位热心青年毫不犹豫地跳入水中将他救起。', 'Jiàn yǒu értóng búshèn luòshuǐ, lùguò de yí wèi rèxīn qīngnián háobù-yóuyù de tiàorù shuǐzhōng jiāng tā jiùqǐ.', 'Trông thấy có đứa trẻ sơ ý ngã xuống nước, một thanh niên nhiệt tình đi ngang qua đã không chút do dự nhảy xuống nước cứu em lên.', 'basic', 1),
      (v_id, '面对重度烧伤合并多器官衰竭的危重病患，多学科医疗专家团队通力协作连续抢救数十个小时，终于将患者从死神手中抢救回来。', 'Miànduì zhòngdù shāoshāng hébìng duō qìguān shuāijié de wēizhòng bìnghuàn, duō xuékē yīliáo zhuānjiā tuánduì tōnglì xiézuò liánxù qiǎngjiù shù shí gè xiǎoshí, zhōngyú jiāng huànzhě cóng sǐshén shǒuzhōng qiǎngjiù huílái.', 'Đối mặt với bệnh nhân nguy kịch bị bỏng nặng kèm theo suy đa cơ quan, đội ngũ chuyên gia y tế đa chuyên khoa đã hợp lực liên tục cấp cứu hàng chục tiếng đồng hồ, cuối cùng đã cứu sống được người bệnh từ tay thần chết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2630] [救护车] (jiùhùchē) - xe cứu thương, xe cấp cứu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '救护车' AND pinyin = 'jiùhùchē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '救护车' AND pinyin = 'jiùhùchē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '救护车'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '救护车'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiùhùchē',
      meaning_vi = 'xe cứu thương, xe cấp cứu',
      example_hanzi = '听见救护车的警笛声，公路上行驶的所有车辆都主动向两侧让行。',
      example_pinyin = 'Tīngjiàn jiùhùchē de jǐngdí shēng, gōnglù shang xíngshǐ de suǒyǒu chēliàng dōu zhǔdòng xiàng liǎngcè ràngxíng.',
      example_vi = 'Nghe thấy tiếng còi xe cứu thương, tất cả các phương tiện đang lưu thông trên đường đều chủ động nép sang hai bên để nhường đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '救护车',
      'jiùhùchē',
      'xe cứu thương, xe cấp cứu',
      'Danh từ',
      'HSK 5',
      '听见救护车的警笛声，公路上行驶的所有车辆都主动向两侧让行。',
      'Tīngjiàn jiùhùchē de jǐngdí shēng, gōnglù shang xíngshǐ de suǒyǒu chēliàng dōu zhǔdòng xiàng liǎngcè ràngxíng.',
      'Nghe thấy tiếng còi xe cứu thương, tất cả các phương tiện đang lưu thông trên đường đều chủ động nép sang hai bên để nhường đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听见救护车的警笛声，公路上行驶的所有车辆都主动向两侧让行。', 'Tīngjiàn jiùhùchē de jǐngdí shēng, gōnglù shang xíngshǐ de suǒyǒu chēliàng dōu zhǔdòng xiàng liǎngcè ràngxíng.', 'Nghe thấy tiếng còi xe cứu thương, tất cả các phương tiện đang lưu thông trên đường đều chủ động nép sang hai bên để nhường đường.', 'basic', 1),
      (v_id, '该现代化急救指挥中心配备了具备5G远程多参数诊疗功能的移动智能救护车，实现了患者“上车即入院”的生命急救全新模式。', 'Gāi xiàndàihuà jíjiù zhǐhuī zhōngxīn pèibèi le jùbèi 5G yuǎnchéng duō cānshù zhěnliáo gōngnéng de yídòng zhìnéng jiùhùchē, shíxiàn le huànzhě “shàngchē jí rùyuàn” de shēngmìng jíjiù quánxīn móshì.', 'Trung tâm chỉ huy cấp cứu hiện đại này được trang bị xe cứu thương thông minh di động tích hợp tính năng chẩn đoán đa thông số từ xa qua 5G, hiện thực hóa mô hình cấp cứu sinh mạng hoàn toàn mới: "bước lên xe là vào viện".', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2631] [就业] (jiùyè) - việc làm, tìm việc, giải quyết việc làm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '就业' AND pinyin = 'jiùyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '就业' AND pinyin = 'jiùyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '就业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '就业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiùyè',
      meaning_vi = 'việc làm, tìm việc, giải quyết việc làm',
      example_hanzi = '大学毕业后，他通过校园招聘顺利在一家知名软件公司实现了就业。',
      example_pinyin = 'Dàxué bìyè hòu, tā tōngguò xiàoyuán zhāopìn shùnlì zài yì jiā zhīmíng ruǎnjiàn gōngsī shíxiàn le jiùyè.',
      example_vi = 'Sau khi tốt nghiệp đại học, anh ấy thông qua hội chợ tuyển dụng trong trường đã thuận lợi tìm được việc làm tại một công ty phần mềm nổi tiếng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '就业',
      'jiùyè',
      'việc làm, tìm việc, giải quyết việc làm',
      'Động từ / Danh từ',
      'HSK 5',
      '大学毕业后，他通过校园招聘顺利在一家知名软件公司实现了就业。',
      'Dàxué bìyè hòu, tā tōngguò xiàoyuán zhāopìn shùnlì zài yì jiā zhīmíng ruǎnjiàn gōngsī shíxiàn le jiùyè.',
      'Sau khi tốt nghiệp đại học, anh ấy thông qua hội chợ tuyển dụng trong trường đã thuận lợi tìm được việc làm tại một công ty phần mềm nổi tiếng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大学毕业后，他通过校园招聘顺利在一家知名软件公司实现了就业。', 'Dàxué bìyè hòu, tā tōngguò xiàoyuán zhāopìn shùnlì zài yì jiā zhīmíng ruǎnjiàn gōngsī shíxiàn le jiùyè.', 'Sau khi tốt nghiệp đại học, anh ấy thông qua hội chợ tuyển dụng trong trường đã thuận lợi tìm được việc làm tại một công ty phần mềm nổi tiếng.', 'basic', 1),
      (v_id, '国家坚持实施就业优先战略，通过减税降费与普惠金融贷款扶持中小微企业稳岗扩岗，千方百计确保高校毕业生等重点群体高质量充分就业。', 'Guójiā jiānchí shíshī jiùyè yōuxiān zhànlüè, tōngguò jiǎnshuì-jiàngfèi yǔ pǔhuì jīnróng dàikuǎn fúchí zhōng-xiǎo-wēi qǐyè wěngǎng-kuògǎng, qiānfāng-bǎijì quèbǎo gāoxiào bìyèshēng děng zhòngdiǎn qúntǐ gāo zhìliàng chōngfèn jiùyè.', 'Nhà nước kiên trì thực hiện chiến lược ưu tiên việc làm, thông qua miễn giảm thuế phí và tín dụng tài chính toàn diện để hỗ trợ doanh nghiệp vừa và nhỏ giữ vững và mở rộng vị trí việc làm, bằng mọi cách bảo đảm các nhóm đối tượng trọng điểm như sinh viên tốt nghiệp có được việc làm đầy đủ và chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2632] [居民] (jūmín) - cư dân, người dân, người cư trú [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '居民' AND pinyin = 'jūmín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '居民' AND pinyin = 'jūmín'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '居民'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '居民'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jūmín',
      meaning_vi = 'cư dân, người dân, người cư trú',
      example_hanzi = '社区居委会定期组织志愿者为辖区内的高龄独居居民上门提供生活照料。',
      example_pinyin = 'Shèqū jūwěihuì dìngqī zǔzhī yuànzhě wèi xiáqū nèi de gāolíng dújū jūmín shàngmén tígōng shēnghuó zhàoliào.',
      example_vi = 'Ban quản lý khu dân cư định kỳ tổ chức tình nguyện viên đến tận nhà chăm sóc đời sống cho các cư dân cao tuổi sống một mình trong địa bàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '居民',
      'jūmín',
      'cư dân, người dân, người cư trú',
      'Danh từ',
      'HSK 5',
      '社区居委会定期组织志愿者为辖区内的高龄独居居民上门提供生活照料。',
      'Shèqū jūwěihuì dìngqī zǔzhī yuànzhě wèi xiáqū nèi de gāolíng dújū jūmín shàngmén tígōng shēnghuó zhàoliào.',
      'Ban quản lý khu dân cư định kỳ tổ chức tình nguyện viên đến tận nhà chăm sóc đời sống cho các cư dân cao tuổi sống một mình trong địa bàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '社区居委会定期组织志愿者为辖区内的高龄独居居民上门提供生活照料。', 'Shèqū jūwěihuì dìngqī zǔzhī yuànzhě wèi xiáqū nèi de gāolíng dújū jūmín shàngmén tígōng shēnghuó zhàoliào.', 'Ban quản lý khu dân cư định kỳ tổ chức tình nguyện viên đến tận nhà chăm sóc đời sống cho các cư dân cao tuổi sống một mình trong địa bàn.', 'basic', 1),
      (v_id, '城市老旧小区微改造工程广泛听取常住居民的合理诉求，增设加装电梯与无障碍设施，显著提升了社区居民的获得感与幸福感。', 'Chéngshì lǎojiù xiǎoqū wēi-gǎizào gōngchéng guǎngfàn tīngqǔ chángzhù jūmín de hélǐ sùqiú, zēngshè jiāzhuāng diàntī yǔ wúzhàng’ài shèshī, xiǎnzhù tíshēng le shèqū jūmín de huòdégǎn yǔ xìngfúgǎn.', 'Công trình vi cải tạo các khu chung cư cũ trong đô thị đã lắng nghe sâu rộng những nguyện vọng chính đáng của cư dân thường trú, lắp đặt thêm thang máy và trang thiết bị không rào cản, nâng cao rõ rệt cảm giác thụ hưởng và hạnh phúc của cư dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2633] [居然] (jūrán) - lại, mà lại, không ngờ lại [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '居然' AND pinyin = 'jūrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '居然' AND pinyin = 'jūrán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '居然'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '居然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jūrán',
      meaning_vi = 'lại, mà lại, không ngờ lại',
      example_hanzi = '这道如此复杂的数学竞赛难题，他居然只用了十分钟就解出了正确答案。',
      example_pinyin = 'Zhè dào rúcǐ fùzá de shùxué jìngsài nántí, tā jūrán zhǐ yòng le shí fēnzhōng jiù jiěchū le zhèngquè dá’àn.',
      example_vi = 'Bài toán thi học sinh giỏi phức tạp như thế này, cậu ấy lại chỉ mất đúng 10 phút là đã giải ra đáp án chính xác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '居然',
      'jūrán',
      'lại, mà lại, không ngờ lại',
      'Phó từ',
      'HSK 5',
      '这道如此复杂的数学竞赛难题，他居然只用了十分钟就解出了正确答案。',
      'Zhè dào rúcǐ fùzá de shùxué jìngsài nántí, tā jūrán zhǐ yòng le shí fēnzhōng jiù jiěchū le zhèngquè dá’àn.',
      'Bài toán thi học sinh giỏi phức tạp như thế này, cậu ấy lại chỉ mất đúng 10 phút là đã giải ra đáp án chính xác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这道如此复杂的数学竞赛难题，他居然只用了十分钟就解出了正确答案。', 'Zhè dào rúcǐ fùzá de shùxué jìngsài nántí, tā jūrán zhǐ yòng le shí fēnzhōng jiù jiěchū le zhèngquè dá’àn.', 'Bài toán thi học sinh giỏi phức tạp như thế này, cậu ấy lại chỉ mất đúng 10 phút là đã giải ra đáp án chính xác.', 'basic', 1),
      (v_id, '在极端干旱贫瘠的戈壁荒滩上，这批采用生物工程培育的新型防风固沙灌木居然顽强地扎根存活并长出了一片生机勃勃的绿洲。', 'Zài jíduān gānhàn pínjí de gēbì huāngtān shang, zhè pī cǎiyòng shēngwù gōngchéng péiyù de xīnxíng fángfēng-gùshā guānmù jūrán wánqiáng de zhāgēn cúnhuó bìng zhǎngchū le yí piàn shēngjī-bóbó de lǜzhōu.', 'Giữa bãi sỏi sa mạc Gobi khô cằn cùng cực, lứa cây bụi chắn gió giữ cát kiểu mới được lai tạo bằng công nghệ sinh học này không ngờ lại bén rễ sinh tồn kiên cường và vươn mình thành một ốc đảo tràn trề nhựa sống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2634] [居住] (jūzhù) - cư trú, sinh sống, ở [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '居住' AND pinyin = 'jūzhù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '居住' AND pinyin = 'jūzhù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '居住'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '居住'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jūzhù',
      meaning_vi = 'cư trú, sinh sống, ở',
      example_hanzi = '他们一家人在这座风景如画的海滨小城已经居住了十几年。',
      example_pinyin = 'Tāmen yì jiā rén zài zhè zuò fēngjǐng-rúhuà de hǎibīn xiǎochéng yǐjīng jūzhù le shí jǐ nián.',
      example_vi = 'Cả gia đình họ đã sinh sống hơn mười năm tại thành phố ven biển đẹp như tranh vẽ này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '居住',
      'jūzhù',
      'cư trú, sinh sống, ở',
      'Động từ',
      'HSK 5',
      '他们一家人在这座风景如画的海滨小城已经居住了十几年。',
      'Tāmen yì jiā rén zài zhè zuò fēngjǐng-rúhuà de hǎibīn xiǎochéng yǐjīng jūzhù le shí jǐ nián.',
      'Cả gia đình họ đã sinh sống hơn mười năm tại thành phố ven biển đẹp như tranh vẽ này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他们一家人在这座风景如画的海滨小城已经居住了十几年。', 'Tāmen yì jiā rén zài zhè zuò fēngjǐng-rúhuà de hǎibīn xiǎochéng yǐjīng jūzhù le shí jǐ nián.', 'Cả gia đình họ đã sinh sống hơn mười năm tại thành phố ven biển đẹp như tranh vẽ này.', 'basic', 1),
      (v_id, '生态宜居城市建设强调合理规划人居空间密度，营造人与自然和谐共生的高品质居住生态环境。', 'Shēngtài yíjū chéngshì jiànshè qiángdiào hélǐ guīhuà rénjū kōngjiān mìdù, yíngzào rén yǔ zìrán héxié gòngshēng de gāo pǐnzhì jūzhù shēngtài huánjìng.', 'Việc xây dựng đô thị sinh thái đáng sống nhấn mạnh việc quy hoạch hợp lý mật độ không gian định cư, kiến tạo môi trường sinh thái cư trú chất lượng cao nơi con người và tự nhiên chung sống hài hòa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2635] [橘子] (júzi) - quả quýt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '橘子' AND pinyin = 'júzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '橘子' AND pinyin = 'júzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '橘子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '橘子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'júzi',
      meaning_vi = 'quả quýt',
      example_hanzi = '秋天果园里的橘子成熟了，金黄色的果实挂满了枝头。',
      example_pinyin = 'Qiūtiān guǒyuán lǐ de júzi chéngshú le, jīnhuángsè de guǒshí guàmǎn le zhītóu.',
      example_vi = 'Mùa thu quýt trong vườn đã chín, những quả quýt vàng óng trĩu nặng trên cành cây.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '橘子',
      'júzi',
      'quả quýt',
      'Danh từ',
      'HSK 5',
      '秋天果园里的橘子成熟了，金黄色的果实挂满了枝头。',
      'Qiūtiān guǒyuán lǐ de júzi chéngshú le, jīnhuángsè de guǒshí guàmǎn le zhītóu.',
      'Mùa thu quýt trong vườn đã chín, những quả quýt vàng óng trĩu nặng trên cành cây.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '秋天果园里的橘子成熟了，金黄色的果实挂满了枝头。', 'Qiūtiān guǒyuán lǐ de júzi chéngshú le, jīnhuángsè de guǒshí guàmǎn le zhītóu.', 'Mùa thu quýt trong vườn đã chín, những quả quýt vàng óng trĩu nặng trên cành cây.', 'basic', 1),
      (v_id, '农业科研团队利用航天诱变育种技术培育出无核多汁、富含花青素的特种优质沙糖橘新品种，有效助力了山区果农增产增收。', 'Nóngyè kēyán tuánduì lìyòng hángtiān yòubiàn yùzhǒng jìshù péiyù chū wúhé duōzhī, fùhán huāqīngsù de tèzhǒng yōuzhì shātángjú xīn pǐnzhǒng, yǒuxiào zhùlì le shānqū guǒnóng zēngchǎn-zēngshōu.', 'Đội ngũ nghiên cứu khoa học nông nghiệp đã ứng dụng kỹ thuật gây đột biến nhân giống trong không gian vũ trụ để lai tạo giống quýt đường không hạt mọng nước, giàu anthocyanin mới, hỗ trợ hiệu quả nông dân trồng cây ăn quả miền núi tăng sản lượng và thu nhập.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2636] [据] (jù) - theo, căn cứ vào, theo như [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '据' AND pinyin = 'jù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '据' AND pinyin = 'jù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '据'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '据'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Giới từ',
      pinyin = 'jù',
      meaning_vi = 'theo, căn cứ vào, theo như',
      example_hanzi = '据气象部门预报，明天傍晚本市将迎来一场雷阵雨。',
      example_pinyin = 'Jù qìxiàng bùmén yùbào, míngtiān bàngwǎn běn shì jiāng yínglái yì chǎng léizhènyǔ.',
      example_vi = 'Theo dự báo của cơ quan khí tượng, chiều tối mai thành phố sẽ đón một cơn mưa rào kèm sấm sét.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '据',
      'jù',
      'theo, căn cứ vào, theo như',
      'Giới từ',
      'HSK 5',
      '据气象部门预报，明天傍晚本市将迎来一场雷阵雨。',
      'Jù qìxiàng bùmén yùbào, míngtiān bàngwǎn běn shì jiāng yínglái yì chǎng léizhènyǔ.',
      'Theo dự báo của cơ quan khí tượng, chiều tối mai thành phố sẽ đón một cơn mưa rào kèm sấm sét.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '据气象部门预报，明天傍晚本市将迎来一场雷阵雨。', 'Jù qìxiàng bùmén yùbào, míngtiān bàngwǎn běn shì jiāng yínglái yì chǎng léizhènyǔ.', 'Theo dự báo của cơ quan khí tượng, chiều tối mai thành phố sẽ đón một cơn mưa rào kèm sấm sét.', 'basic', 1),
      (v_id, '据世界知识产权组织最新发布的全球创新指数报告显示，我国在专利申请总量与高科技集群规模方面连续多年位居全球领先地位。', 'Jù Shìjiè Zhīshi Chǎnquán Zǔzhī zuìxīn fābù de quánqiú chuàngxīn zhǐshù bàogào xiǎnshì, wǒ guó zài zhuānlì shēnqǐng zǒngliàng yǔ gāo kējì jíqún guīmó fāngmiàn liánxù duō nián wèijū quánqiú lǐngxiān dìwèi.', 'Căn cứ theo Báo cáo Chỉ số Đổi mới Sáng tạo Toàn cầu mới nhất do Tổ chức Sở hữu Trí tuệ Thế giới công bố, nước ta nhiều năm liên tiếp giữ vị trí hàng đầu thế giới về tổng số đơn đăng ký sáng chế và quy mô cụm công nghệ cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2637] [距] (jù) - cách, cự ly, khoảng cách so với [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '距' AND pinyin = 'jù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '距' AND pinyin = 'jù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '距'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '距'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jù',
      meaning_vi = 'cách, cự ly, khoảng cách so với',
      example_hanzi = '我们新搬的家距地铁站只有五分钟的步行路程，出行非常便利。',
      example_pinyin = 'Wǒmen xīn bān de jiā jù dìtiězhàn zhǐyǒu wǔ fēnzhōng de bùxíng lùchéng, chūxíng fēicháng biànlì.',
      example_vi = 'Ngôi nhà mới chuyển của chúng tôi chỉ cách ga tàu điện ngầm 5 phút đi bộ, đi lại vô cùng thuận tiện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '距',
      'jù',
      'cách, cự ly, khoảng cách so với',
      'Động từ',
      'HSK 5',
      '我们新搬的家距地铁站只有五分钟的步行路程，出行非常便利。',
      'Wǒmen xīn bān de jiā jù dìtiězhàn zhǐyǒu wǔ fēnzhōng de bùxíng lùchéng, chūxíng fēicháng biànlì.',
      'Ngôi nhà mới chuyển của chúng tôi chỉ cách ga tàu điện ngầm 5 phút đi bộ, đi lại vô cùng thuận tiện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们新搬的家距地铁站只有五分钟的步行路程，出行非常便利。', 'Wǒmen xīn bān de jiā jù dìtiězhàn zhǐyǒu wǔ fēnzhōng de bùxíng lùchéng, chūxíng fēicháng biànlì.', 'Ngôi nhà mới chuyển của chúng tôi chỉ cách ga tàu điện ngầm 5 phút đi bộ, đi lại vô cùng thuận tiện.', 'basic', 1),
      (v_id, '该深水钻井平台距海岸线数百海里，依靠先进的动力定位系统在十级狂风巨浪中依然能保持稳定作业。', 'Gāi shēnshuǐ zuànjǐng píngtái jù hǎi’ànxiàn shù bǎi hǎilǐ, yīkào xiānjìn de dònglì dìngwèi xìtǒng zài shí jí kuángfēng-jùlàng zhōng yīrán néng bǎochí wěndìng zuòyè.', 'Giàn khoan nước sâu này cách bờ biển hàng trăm hải lý, nhờ vào hệ thống định vị động học tiên tiến vẫn có thể duy trì hoạt động tác nghiệp ổn định giữa sóng to gió lớn cấp 10.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2638] [具备] (jùbèi) - có đủ, hội tụ đủ, trang bị đủ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '具备' AND pinyin = 'jùbèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '具备' AND pinyin = 'jùbèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '具备'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '具备'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jùbèi',
      meaning_vi = 'có đủ, hội tụ đủ, trang bị đủ',
      example_hanzi = '应聘该岗位的人员需要具备扎实的专业理论基础和良好的团队沟通能力。',
      example_pinyin = 'Yìngpìn gāi gǎngwèi de rényuán xūyào jùbèi zhāshi de zhuānyè lǐlùn jīchǔ hé liánghǎo de tuánduì gōutōng nénglì.',
      example_vi = 'Ứng viên ứng tuyển vị trí này cần phải có nền tảng lý thuyết chuyên môn vững vàng và khả năng giao tiếp đội nhóm tốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '具备',
      'jùbèi',
      'có đủ, hội tụ đủ, trang bị đủ',
      'Động từ',
      'HSK 5',
      '应聘该岗位的人员需要具备扎实的专业理论基础和良好的团队沟通能力。',
      'Yìngpìn gāi gǎngwèi de rényuán xūyào jùbèi zhāshi de zhuānyè lǐlùn jīchǔ hé liánghǎo de tuánduì gōutōng nénglì.',
      'Ứng viên ứng tuyển vị trí này cần phải có nền tảng lý thuyết chuyên môn vững vàng và khả năng giao tiếp đội nhóm tốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '应聘该岗位的人员需要具备扎实的专业理论基础和良好的团队沟通能力。', 'Yìngpìn gāi gǎngwèi de rényuán xūyào jùbèi zhāshi de zhuānyè lǐlùn jīchǔ hé liánghǎo de tuánduì gōutōng nénglì.', 'Ứng viên ứng tuyển vị trí này cần phải có nền tảng lý thuyết chuyên môn vững vàng và khả năng giao tiếp đội nhóm tốt.', 'basic', 1),
      (v_id, '该超大型深远海海上风力发电机组具备抵御超强台风与深海强腐蚀环境的卓越性能，标志着我国海上风电整机装备制造迈入世界先进行列。', 'Gāi chāodàxíng shēnyuǎnhǎi hǎishàng fēnglì fādiǎnjǐ zǔ jùbèi dǐyù chāoqiáng táifēng yǔ shēnhǎi qiáng fǔshí huánjìng de zhuóyuè xìngnéng, biāozhì zhe wǒ guó hǎishàng fēngdiàn zhěngjī zhuāngbèi zhìzào màirù shìjiè xiānjìn hángliè.', 'Tổ máy phát điện gió ngoài khơi vùng biển xa siêu lớn này hội tụ đủ hiệu năng vượt trội để chống chịu các siêu bão và môi trường biển sâu ăn mòn cực mạnh, đánh dấu việc chế tạo thiết bị máy phát điện gió ngoài khơi trọn bộ của nước ta đã bước vào hàng ngũ tiên tiến thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2639] [剧场] (jùchǎng) - nhà hát, rạp hát [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '剧场' AND pinyin = 'jùchǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '剧场' AND pinyin = 'jùchǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '剧场'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '剧场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jùchǎng',
      meaning_vi = 'nhà hát, rạp hát',
      example_hanzi = '今晚市中心大剧场将上演一场精彩纷呈的芭蕾舞剧。',
      example_pinyin = 'Jīnwǎn shì zhōngxīn dà jùchǎng jiāng shàngyǎn yì chǎng jīngcǎi-fēncéng de bālěiwǔ jù.',
      example_vi = 'Tối nay tại đại nhà hát trung tâm thành phố sẽ công diễn một vở kịch múa ballet vô cùng đặc sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '剧场',
      'jùchǎng',
      'nhà hát, rạp hát',
      'Danh từ',
      'HSK 5',
      '今晚市中心大剧场将上演一场精彩纷呈的芭蕾舞剧。',
      'Jīnwǎn shì zhōngxīn dà jùchǎng jiāng shàngyǎn yì chǎng jīngcǎi-fēncéng de bālěiwǔ jù.',
      'Tối nay tại đại nhà hát trung tâm thành phố sẽ công diễn một vở kịch múa ballet vô cùng đặc sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今晚市中心大剧场将上演一场精彩纷呈的芭蕾舞剧。', 'Jīnwǎn shì zhōngxīn dà jùchǎng jiāng shàngyǎn yì chǎng jīngcǎi-fēncéng de bālěiwǔ jù.', 'Tối nay tại đại nhà hát trung tâm thành phố sẽ công diễn một vở kịch múa ballet vô cùng đặc sắc.', 'basic', 1),
      (v_id, '新建成的国家级歌剧院剧场不仅采用了全球顶尖的声学反射空间设计，更配备了全景三维沉浸式声场渲染系统。', 'Xīnjiàn chéng de guójiājí gējùyuàn jùchǎng bùjǐn cǎiyòng le quánqiú dǐngjiān de shēngxué fǎnshè kōngjiān shèjì, gèng pèibèi le quánjǐng sānwéi chénjìnshì shēngchǎng xuànrǎn xìtǒng.', 'Nhà hát kịch tầm cỡ quốc gia mới khánh thành không chỉ ứng dụng thiết kế không gian phản xạ âm học đỉnh cao thế giới, mà còn được trang bị hệ thống dựng trường âm chìm đắm không gian 3 chiều toàn cảnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2640] [巨大] (jùdà) - to lớn, khổng lồ, vĩ đại [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '巨大' AND pinyin = 'jùdà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '巨大' AND pinyin = 'jùdà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '巨大'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '巨大'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'jùdà',
      meaning_vi = 'to lớn, khổng lồ, vĩ đại',
      example_hanzi = '这项科研成果的成功转化给企业带来了巨大的经济效益。',
      example_pinyin = 'Zhè xiàng kēyán chéngguǒ de chénggōng zhuǎnhuà gěi qǐyè dàilái le jùdà de jīngjì xiàoyì.',
      example_vi = 'Việc chuyển giao thành công thành quả nghiên cứu khoa học này đã mang lại lợi ích kinh tế to lớn cho doanh nghiệp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '巨大',
      'jùdà',
      'to lớn, khổng lồ, vĩ đại',
      'Tính từ',
      'HSK 5',
      '这项科研成果的成功转化给企业带来了巨大的经济效益。',
      'Zhè xiàng kēyán chéngguǒ de chénggōng zhuǎnhuà gěi qǐyè dàilái le jùdà de jīngjì xiàoyì.',
      'Việc chuyển giao thành công thành quả nghiên cứu khoa học này đã mang lại lợi ích kinh tế to lớn cho doanh nghiệp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这项科研成果的成功转化给企业带来了巨大的经济效益。', 'Zhè xiàng kēyán chéngguǒ de chénggōng zhuǎnhuà gěi qǐyè dàilái le jùdà de jīngjì xiàoyì.', 'Việc chuyển giao thành công thành quả nghiên cứu khoa học này đã mang lại lợi ích kinh tế to lớn cho doanh nghiệp.', 'basic', 1),
      (v_id, '面对全球气候治理的巨大挑战与国际减排博弈，各国必须共同坚守公平合理、合作共赢的原则，携手构建人类命运共同体。', 'Miànduì quánqiú qìhòu zhìlǐ de jùdà tiǎozhàn yǔ guójì jiǎnpái bóyì, gè guó bìxū gòngtóng jiānshǒu gōngpíng-hélǐ, hézuò-gòngyíng de yuánzé, xiéshǒu gòujiàn rénlèi mìngyùn gòngtóngtǐ.', 'Đứng trước những thách thức to lớn của nền quản trị khí hậu toàn cầu và sự cạnh tranh giảm phát thải quốc tế, các quốc gia phải cùng giữ vững nguyên tắc công bằng hợp lý và hợp tác cùng thắng, chung tay xây dựng cộng đồng chung vận mệnh nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2641] [据说] (jùshuō) - nghe nói, nghe đồn, tương truyền [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '据说' AND pinyin = 'jùshuō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '据说' AND pinyin = 'jùshuō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '据说'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '据说'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jùshuō',
      meaning_vi = 'nghe nói, nghe đồn, tương truyền',
      example_hanzi = '据说这家隐藏在老巷子深处的餐馆已经传承了祖孙四代人。',
      example_pinyin = 'Jùshuō zhè jiā yǐncáng zài lǎoxiàngzi shēnchù de cānguǎn yǐjīng chuánchéng le zǔ-sūn sì dài rén.',
      example_vi = 'Nghe nói quán ăn ẩn sâu trong con ngõ cổ này đã được truyền thừa qua 4 thế hệ ông cháu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '据说',
      'jùshuō',
      'nghe nói, nghe đồn, tương truyền',
      'Động từ',
      'HSK 5',
      '据说这家隐藏在老巷子深处的餐馆已经传承了祖孙四代人。',
      'Jùshuō zhè jiā yǐncáng zài lǎoxiàngzi shēnchù de cānguǎn yǐjīng chuánchéng le zǔ-sūn sì dài rén.',
      'Nghe nói quán ăn ẩn sâu trong con ngõ cổ này đã được truyền thừa qua 4 thế hệ ông cháu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '据说这家隐藏在老巷子深处的餐馆已经传承了祖孙四代人。', 'Jùshuō zhè jiā yǐncáng zài lǎoxiàngzi shēnchù de cānguǎn yǐjīng chuánchéng le zǔ-sūn sì dài rén.', 'Nghe nói quán ăn ẩn sâu trong con ngõ cổ này đã được truyền thừa qua 4 thế hệ ông cháu.', 'basic', 1),
      (v_id, '据说当地民间流传千年的古法酿酒工艺暗合天人合一之理，其发酵窖池中独特的微生物菌群至今仍吸引着众多中外生物学家前来考证探秘。', 'Jùshuō dāngdì mínjiān liúchuán qiān nián de gǔfǎ niàngjiǔ gōngyì ànhé tiānrén-héyī zhī lǐ, qí fājiào jiàochí zhōng dútè de wēishēngwù jùnqún zhìjīn réng xīyǐn zhe zhòngduō zhōngwài shēngwùxuéjiā qiánlái kǎozhèng tànmì.', 'Tương truyền kỹ thuật ủ rượu thủ công cổ truyền lưu truyền nghìn năm trong dân gian nơi đây ngầm khớp với đạo lý thiên nhân hợp nhất, quần thể vi sinh vật độc đáo trong các hầm lên men của nó cho đến nay vẫn thu hút đông đảo các nhà sinh vật học trong và ngoài nước tìm đến khảo chứng khám phá.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2642] [具体] (jùtǐ) - cụ thể, chi tiết, rõ ràng; cụ thể hóa [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '具体' AND pinyin = 'jùtǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '具体' AND pinyin = 'jùtǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '具体'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '具体'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'jùtǐ',
      meaning_vi = 'cụ thể, chi tiết, rõ ràng; cụ thể hóa',
      example_hanzi = '请你结合具体的案例详细说明这个理论概念。',
      example_pinyin = 'Qǐng nǐ jiéhé jùtǐ de ànlì xiángxì shuōmíng zhè gè lǐlùn gàiniàn.',
      example_vi = 'Xin bạn hãy kết hợp với các trường hợp ca bệnh cụ thể để thuyết minh chi tiết cho khái niệm lý luận này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '具体',
      'jùtǐ',
      'cụ thể, chi tiết, rõ ràng; cụ thể hóa',
      'Tính từ / Động từ',
      'HSK 5',
      '请你结合具体的案例详细说明这个理论概念。',
      'Qǐng nǐ jiéhé jùtǐ de ànlì xiángxì shuōmíng zhè gè lǐlùn gàiniàn.',
      'Xin bạn hãy kết hợp với các trường hợp ca bệnh cụ thể để thuyết minh chi tiết cho khái niệm lý luận này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请你结合具体的案例详细说明这个理论概念。', 'Qǐng nǐ jiéhé jùtǐ de ànlì xiángxì shuōmíng zhè gè lǐlùn gàiniàn.', 'Xin bạn hãy kết hợp với các trường hợp ca bệnh cụ thể để thuyết minh chi tiết cho khái niệm lý luận này.', 'basic', 1),
      (v_id, '有关部门针对优化营商环境出台了一系列操作性极强的具体实施细则，明确了各项便民惠企审批事项的办理时限与标准流程。', 'Yǒuguān bùmén zhēnduì yōuhuà yíngshāng huánjìng chūtái le yí xìliè cāozuòxìng jí qiáng de jùtǐ shíshī xìzé, míngquè le gè xiàng biànmín-huìqǐ shěnpī shìxiàng de bànlǐ shíxiàn yǔ biāozhǔn liúchéng.', 'Các ban ngành hữu quan nhằm vào việc tối ưu hóa môi trường kinh doanh đã ban hành một chuỗi các điều khoản thực thi cụ thể có tính thực tế thao tác rất cao, nêu rõ thời hạn giải quyết và quy trình tiêu chuẩn cho từng thủ tục phê duyệt hỗ trợ doanh nghiệp và người dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2643] [具有] (jùyǒu) - có, sở hữu, mang tính [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '具有' AND pinyin = 'jùyǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '具有' AND pinyin = 'jùyǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '具有'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '具有'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jùyǒu',
      meaning_vi = 'có, sở hữu, mang tính',
      example_hanzi = '这种新型环保材料具有重量轻、强度高和防火防水的特点。',
      example_pinyin = 'Zhè zhǒng xīnxíng huánbǎo cáiliào jùyǒu zhòngliàng qīng, qiángdù gāo hé fánghuǒ fángshuǐ de tèdiǎn.',
      example_vi = 'Loại vật liệu bảo vệ môi trường kiểu mới này mang các đặc điểm nhẹ, cường độ cao và chống cháy chống thấm nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '具有',
      'jùyǒu',
      'có, sở hữu, mang tính',
      'Động từ',
      'HSK 5',
      '这种新型环保材料具有重量轻、强度高和防火防水的特点。',
      'Zhè zhǒng xīnxíng huánbǎo cáiliào jùyǒu zhòngliàng qīng, qiángdù gāo hé fánghuǒ fángshuǐ de tèdiǎn.',
      'Loại vật liệu bảo vệ môi trường kiểu mới này mang các đặc điểm nhẹ, cường độ cao và chống cháy chống thấm nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这种新型环保材料具有重量轻、强度高和防火防水的特点。', 'Zhè zhǒng xīnxíng huánbǎo cáiliào jùyǒu zhòngliàng qīng, qiángdù gāo hé fánghuǒ fángshuǐ de tèdiǎn.', 'Loại vật liệu bảo vệ môi trường kiểu mới này mang các đặc điểm nhẹ, cường độ cao và chống cháy chống thấm nước.', 'basic', 1),
      (v_id, '共建“一带一路”倡议是一项具有全球深远历史影响的世纪工程，为推动沿线国家基础设施联通与包容性经济增长注入了澎湃动能。', 'Gòngjiàn “Yídài-Yílù” chàngyì shì yí xiàng jùyǒu quánqiú shēnyuǎn lìshǐ yǐngxiǎng de shìjì gōngchéng, wèi tuīdòng yánxiàn guójiā jīchǔ shèshī liántōng yǔ bāoróngxìng jīngjì zēngzhǎng zhùrù le péngpài dòngnéng.', 'Sáng kiến cùng xây dựng "Vành đai và Con đường" là một công trình thế kỷ có sức ảnh hưởng lịch sử sâu rộng toàn cầu, tiếp thêm động năng mạnh mẽ thúc đẩy kết nối cơ sở hạ tầng và tăng trưởng kinh tế bao trùm cho các quốc gia dọc tuyến.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2644] [捐] (juān) - quyên góp, hiến tặng, ủng hộ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '捐' AND pinyin = 'juān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '捐' AND pinyin = 'juān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '捐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '捐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'juān',
      meaning_vi = 'quyên góp, hiến tặng, ủng hộ',
      example_hanzi = '得知山区学校缺乏图书，同学们纷纷捐出了自己喜爱的课外书。',
      example_pinyin = 'Dézhī shānqū xuéxiào quēfá túshū, tóngxuémen fēnfēn juān chū le zìjǐ xǐ’ài de kèwàishū.',
      example_vi = 'Biết tin trường học vùng cao còn thiếu sách vở, các bạn học sinh đua nhau quyên góp những cuốn sách ngoại khóa mà mình yêu thích.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '捐',
      'juān',
      'quyên góp, hiến tặng, ủng hộ',
      'Động từ',
      'HSK 5',
      '得知山区学校缺乏图书，同学们纷纷捐出了自己喜爱的课外书。',
      'Dézhī shānqū xuéxiào quēfá túshū, tóngxuémen fēnfēn juān chū le zìjǐ xǐ’ài de kèwàishū.',
      'Biết tin trường học vùng cao còn thiếu sách vở, các bạn học sinh đua nhau quyên góp những cuốn sách ngoại khóa mà mình yêu thích.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '得知山区学校缺乏图书，同学们纷纷捐出了自己喜爱的课外书。', 'Dézhī shānqū xuéxiào quēfá túshū, tóngxuémen fēnfēn juān chū le zìjǐ xǐ’ài de kèwàishū.', 'Biết tin trường học vùng cao còn thiếu sách vở, các bạn học sinh đua nhau quyên góp những cuốn sách ngoại khóa mà mình yêu thích.', 'basic', 1),
      (v_id, '爱心企业家在成立慈善教育基金会后，向多所国家重点高校累计捐赠数亿元人民币，专门用于奖励基础前沿学科的优秀青年学者。', 'Àixīn qǐyèjiā zài chénglì císhàn jiàoyù jījīnhuì hòu, xiàng duō suǒ guójiā zhòngdiǎn gāoxiào lěijì juānzèng shù yì yuán Rénmínbì, zhuānmén yòngyú jiǎnglì jīchǔ qiányán xuékē de yōuxiù niánqīng xuézhě.', 'Nhà doanh nghiệp giàu lòng hảo tâm sau khi thành lập quỹ giáo dục từ thiện đã quyên tặng lũy kế hàng trăm triệu nhân dân tệ cho nhiều trường đại học trọng điểm quốc gia, chuyên dùng để khen thưởng các học giả trẻ xuất sắc trong các ngành học khoa học cơ bản tiên phong.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2645] [绝对] (juéduì) - tuyệt đối, hoàn toàn [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '绝对' AND pinyin = 'juéduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '绝对' AND pinyin = 'juéduì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '绝对'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '绝对'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'juéduì',
      meaning_vi = 'tuyệt đối, hoàn toàn',
      example_hanzi = '在任何体育竞技比赛中，运动员都必须绝对服从裁判员的判罚。',
      example_pinyin = 'Zài rènhé tǐyù jìngjì bǐsài zhōng, yùndòngyuán dōu bìxū juéduì fúcóng cáipànyuán de pànfá.',
      example_vi = 'Trong bất kỳ cuộc thi đấu thể thao nào, vận động viên đều phải tuyệt đối phục tùng phán quyết của trọng tài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '绝对',
      'juéduì',
      'tuyệt đối, hoàn toàn',
      'Tính từ / Phó từ',
      'HSK 5',
      '在任何体育竞技比赛中，运动员都必须绝对服从裁判员的判罚。',
      'Zài rènhé tǐyù jìngjì bǐsài zhōng, yùndòngyuán dōu bìxū juéduì fúcóng cáipànyuán de pànfá.',
      'Trong bất kỳ cuộc thi đấu thể thao nào, vận động viên đều phải tuyệt đối phục tùng phán quyết của trọng tài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在任何体育竞技比赛中，运动员都必须绝对服从裁判员的判罚。', 'Zài rènhé tǐyù jìngjì bǐsài zhōng, yùndòngyuán dōu bìxū juéduì fúcóng cáipànyuán de pànfá.', 'Trong bất kỳ cuộc thi đấu thể thao nào, vận động viên đều phải tuyệt đối phục tùng phán quyết của trọng tài.', 'basic', 1),
      (v_id, '在航天载人飞船与空间站核心舱的交会对接任务中，姿态校准与相对测速必须做到绝对精确无误，容不得半点疏漏。', 'Zài hángtiān zàirén fēichuán yǔ kōngjiānzhàn héxīncāng de jiāohuì-duìjiē rènwu zhōng, zītài xiàozhǔn yǔ xiāngduì cèsù bìxū zuòdào juéduì jīngquè-wúwù, róngbùdé bàndiǎnr shūlòu.', 'Trong nhiệm vụ kết nối và tiếp cận giữa tàu vũ trụ có người lái và khoang lõi trạm không gian, việc hiệu chỉnh tư thế và đo tốc độ tương đối phải đạt tới độ chuẩn xác tuyệt đối không một sai sót, không cho phép có bất kỳ sơ suất nhỏ nào.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2646] [决赛] (juésài) - trận chung kết; thi chung kết [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '决赛' AND pinyin = 'juésài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '决赛' AND pinyin = 'juésài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '决赛'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '决赛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'juésài',
      meaning_vi = 'trận chung kết; thi chung kết',
      example_hanzi = '经过多轮顽强拼搏，我们学校的足球队终于挺进了全市总决赛。',
      example_pinyin = 'Jīngguò duō lún wánqiáng pīnbó, wǒmen xuéxiào de zúqiúduì zhōngyú tǐngjìn le quán shì zǒngjuésài.',
      example_vi = 'Qua nhiều vòng thi đấu kiên cường, đội bóng đá trường chúng tôi cuối cùng đã xuất sắc lọt vào trận chung kết toàn thành phố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '决赛',
      'juésài',
      'trận chung kết; thi chung kết',
      'Danh từ / Động từ',
      'HSK 5',
      '经过多轮顽强拼搏，我们学校的足球队终于挺进了全市总决赛。',
      'Jīngguò duō lún wánqiáng pīnbó, wǒmen xuéxiào de zúqiúduì zhōngyú tǐngjìn le quán shì zǒngjuésài.',
      'Qua nhiều vòng thi đấu kiên cường, đội bóng đá trường chúng tôi cuối cùng đã xuất sắc lọt vào trận chung kết toàn thành phố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过多轮顽强拼搏，我们学校的足球队终于挺进了全市总决赛。', 'Jīngguò duō lún wánqiáng pīnbó, wǒmen xuéxiào de zúqiúduì zhōngyú tǐngjìn le quán shì zǒngjuésài.', 'Qua nhiều vòng thi đấu kiên cường, đội bóng đá trường chúng tôi cuối cùng đã xuất sắc lọt vào trận chung kết toàn thành phố.', 'basic', 1),
      (v_id, '在奥运会乒乓球男子单打金牌决赛中，两位顶尖选手展现出了惊人的技战术水平和高超的抗压心理素养。', 'Zài Àoyùnhuì pīngpāngqiú nánzǐ dāndǎ jīnpái juésài zhōng, liǎng wèi dǐngjiān xuǎnshǒu zhǎnxiàn chū le jīngrén de jì-zhànshù shuǐpíng hé gāochāo de kàngyā xīnlǐ sùyǎng.', 'Tại trận chung kết tranh huy chương vàng đơn nam môn bóng bàn Thế vận hội Olympic, hai tay vợt đỉnh cao đã thể hiện trình độ kỹ chiến thuật đáng kinh ngạc và bản lĩnh tâm lý chịu áp lực siêu phàm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2647] [角色] (juésè) - vai diễn, nhân vật; vai trò [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '角色' AND pinyin = 'juésè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '角色' AND pinyin = 'juésè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '角色'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '角色'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'juésè',
      meaning_vi = 'vai diễn, nhân vật; vai trò',
      example_hanzi = '那位老戏骨通过精湛的演技，把反面角色塑造得栩栩如生。',
      example_pinyin = 'Nà wèi lǎoxìgǔ tōngguò jīngzhàn de yǎnjì, bǎ fǎnmiàn juésè sùzào de xǔxǔ-rúshēng.',
      example_vi = 'Người diễn viên gạo cội ấy qua diễn xuất điêu luyện đã khắc họa nhân vật phản diện sống động như thật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '角色',
      'juésè',
      'vai diễn, nhân vật; vai trò',
      'Danh từ',
      'HSK 5',
      '那位老戏骨通过精湛的演技，把反面角色塑造得栩栩如生。',
      'Nà wèi lǎoxìgǔ tōngguò jīngzhàn de yǎnjì, bǎ fǎnmiàn juésè sùzào de xǔxǔ-rúshēng.',
      'Người diễn viên gạo cội ấy qua diễn xuất điêu luyện đã khắc họa nhân vật phản diện sống động như thật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '那位老戏骨通过精湛的演技，把反面角色塑造得栩栩如生。', 'Nà wèi lǎoxìgǔ tōngguò jīngzhàn de yǎnjì, bǎ fǎnmiàn juésè sùzào de xǔxǔ-rúshēng.', 'Người diễn viên gạo cội ấy qua diễn xuất điêu luyện đã khắc họa nhân vật phản diện sống động như thật.', 'basic', 1),
      (v_id, '在推动多边全球气候治理与发展中国家绿色低碳转型的进程中，中国正扮演着越来越重要的建设性引领角色。', 'Zài tuīdòng duōbiān quánqiú qìhòu zhìlǐ yǔ fāzhǎnzhōng guójiā lǜsè dītàn zhuǎnxíng de jìnchéng zhōng, Zhōngguó zhèng bànyǎn zhe yuèláiyuè zhòngyào de jiànshèxìng yǐnlǐng juésè.', 'Trong tiến trình thúc đẩy quản trị khí hậu toàn cầu đa phương và chuyển đổi xanh ít phát thải của các quốc gia đang phát triển, Trung Quốc đang đảm nhận vai trò dẫn dắt mang tính xây dựng ngày càng quan trọng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2648] [决心] (juéxīn) - quyết tâm; hạ quyết tâm [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '决心' AND pinyin = 'juéxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '决心' AND pinyin = 'juéxīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '决心'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '决心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'juéxīn',
      meaning_vi = 'quyết tâm; hạ quyết tâm',
      example_hanzi = '新学期伊始，他下定决心要在期末考试中进入年级前十名。',
      example_pinyin = 'Xīn xuéqī yīshǐ, tā xiàdìng juéxīn yào zài qīmò kǎoshì zhōng jìnrù niánjí qián shí míng.',
      example_vi = 'Bắt đầu học kỳ mới, cậu ấy hạ quyết tâm sẽ lọt vào top 10 của khối trong kỳ thi cuối kỳ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '决心',
      'juéxīn',
      'quyết tâm; hạ quyết tâm',
      'Danh từ / Động từ',
      'HSK 5',
      '新学期伊始，他下定决心要在期末考试中进入年级前十名。',
      'Xīn xuéqī yīshǐ, tā xiàdìng juéxīn yào zài qīmò kǎoshì zhōng jìnrù niánjí qián shí míng.',
      'Bắt đầu học kỳ mới, cậu ấy hạ quyết tâm sẽ lọt vào top 10 của khối trong kỳ thi cuối kỳ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新学期伊始，他下定决心要在期末考试中进入年级前十名。', 'Xīn xuéqī yīshǐ, tā xiàdìng juéxīn yào zài qīmò kǎoshì zhōng jìnrù niánjí qián shí míng.', 'Bắt đầu học kỳ mới, cậu ấy hạ quyết tâm sẽ lọt vào top 10 của khối trong kỳ thi cuối kỳ.', 'basic', 1),
      (v_id, '党和国家以壮士断腕的坚定政治决心推进党风廉政建设与反腐败斗争，赢得了全体人民群众的衷心拥护。', 'Dǎng hé guójiā yǐ zhuàngshì-duànwàn de jiāndìng zhèngzhì juéxīn tuījìn dǎngfēng liánzhèng jiànshè yǔ fǎnfǔbài dòuzhēng, yíngdé le quántǐ rénmín qúnzhòng de zhōngxīn yōnghù.', 'Đảng và Nhà nước với quyết tâm chính trị kiên định sẵn sàng hy sinh để làm trong sạch bộ máy đã đẩy mạnh việc xây dựng liêm chính và đấu tranh phòng chống tham nhũng, giành được sự ủng hộ chân thành của toàn thể quần chúng nhân dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2649] [开发] (kāifā) - phát triển, khai thác, lập trình phát triển (phần mềm, tài nguyên) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '开发' AND pinyin = 'kāifā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开发' AND pinyin = 'kāifā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '开发'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开发'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kāifā',
      meaning_vi = 'phát triển, khai thác, lập trình phát triển (phần mềm, tài nguyên)',
      example_hanzi = '技术研发小组历经数月成功开发出了一款操作简便的手机办公软件。',
      example_pinyin = 'Jìshù yánfā xiǎozǔ lìjīng shù yuè chénggōng kāifā chū le yì kuǎn cāozuò jiǎnbiàn de shǒujī bàngōng ruǎnjiàn.',
      example_vi = 'Nhóm nghiên cứu kỹ thuật trải qua mấy tháng đã phát triển thành công một phần mềm văn phòng trên điện thoại với thao tác đơn giản.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '开发',
      'kāifā',
      'phát triển, khai thác, lập trình phát triển (phần mềm, tài nguyên)',
      'Động từ',
      'HSK 5',
      '技术研发小组历经数月成功开发出了一款操作简便的手机办公软件。',
      'Jìshù yánfā xiǎozǔ lìjīng shù yuè chénggōng kāifā chū le yì kuǎn cāozuò jiǎnbiàn de shǒujī bàngōng ruǎnjiàn.',
      'Nhóm nghiên cứu kỹ thuật trải qua mấy tháng đã phát triển thành công một phần mềm văn phòng trên điện thoại với thao tác đơn giản.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '技术研发小组历经数月成功开发出了一款操作简便的手机办公软件。', 'Jìshù yánfā xiǎozǔ lìjīng shù yuè chénggōng kāifā chū le yì kuǎn cāozuò jiǎnbiàn de shǒujī bàngōng ruǎnjiàn.', 'Nhóm nghiên cứu kỹ thuật trải qua mấy tháng đã phát triển thành công một phần mềm văn phòng trên điện thoại với thao tác đơn giản.', 'basic', 1),
      (v_id, '该国家级新区坚持统筹集约原则，大力开发利用深层地热能、风能与陆上光伏等清洁绿色可再生能源。', 'Gāi guójiājí xīnqū jiānchí tǒngchóu jíyuē yuánzé, dàlì kāifā lìyòng shēncéng dìrènéng, fēngnéng yǔ lùshang guāngfú děng qīngjié lǜsè kězàishēng néngyuán.', 'Khu đô thị mới cấp quốc gia này kiên trì nguyên tắc quy hoạch tập trung tiết kiệm, đẩy mạnh khai thác và sử dụng các nguồn năng lượng tái tạo xanh sạch như năng lượng địa nhiệt tầng sâu, năng lượng gió và điện mặt trời trên mặt đất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2650] [开放] (kāifàng) - mở cửa, cởi mở; nở hoa; tự do [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '开放' AND pinyin = 'kāifàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开放' AND pinyin = 'kāifàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '开放'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开放'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'kāifàng',
      meaning_vi = 'mở cửa, cởi mở; nở hoa; tự do',
      example_hanzi = '市立图书馆的自习室每周末对全市市民免费开放。',
      example_pinyin = 'Shìlì túshūguǎn de zìxíshì měi zhōumò duì quán shì shìmín miǎnfèi kāifàng.',
      example_vi = 'Phòng tự học của thư viện thành phố mở cửa miễn phí cho toàn thể cư dân thành phố vào mỗi cuối tuần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '开放',
      'kāifàng',
      'mở cửa, cởi mở; nở hoa; tự do',
      'Động từ / Tính từ',
      'HSK 5',
      '市立图书馆的自习室每周末对全市市民免费开放。',
      'Shìlì túshūguǎn de zìxíshì měi zhōumò duì quán shì shìmín miǎnfèi kāifàng.',
      'Phòng tự học của thư viện thành phố mở cửa miễn phí cho toàn thể cư dân thành phố vào mỗi cuối tuần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '市立图书馆的自习室每周末对全市市民免费开放。', 'Shìlì túshūguǎn de zìxíshì měi zhōumò duì quán shì shìmín miǎnfèi kāifàng.', 'Phòng tự học của thư viện thành phố mở cửa miễn phí cho toàn thể cư dân thành phố vào mỗi cuối tuần.', 'basic', 1),
      (v_id, '中国坚定不移奉行互利共赢的对外开放战略，持续放宽外资市场准入并积极对标高标准国际经贸规则。', 'Zhōngguó jiāndìng-bùyí fèngxíng hùlì-gòngyíng de duìwài kāifàng zhànlüè, chíxù fàngkuān wàizī shìchǎng zhǔnrù bìng jījí duìbiāo gāo biāozhǔn guójì jīngmào guīzé.', 'Trung Quốc kiên định thực thi chiến lược mở cửa đối ngoại cùng có lợi cùng thắng, liên tục nới lỏng điều kiện tiếp cận thị trường đối với vốn đầu tư nước ngoài và chủ động tiệm cận các quy tắc kinh tế thương mại quốc tế tiêu chuẩn cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2651] [开幕] (kāimù) - khai mạc, mở màn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '开幕' AND pinyin = 'kāimù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开幕' AND pinyin = 'kāimù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '开幕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开幕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kāimù',
      meaning_vi = 'khai mạc, mở màn',
      example_hanzi = '一年一度的国际青年文化交流艺术节在掌声中正式拉开帷幕。',
      example_pinyin = 'Yì nián yí dù de guójì qīngnián wénhuà jiāoliú yìshùjié zài zhǎngshēng zhōng zhèngshì lākāi wéimù.',
      example_vi = 'Liên hoan nghệ thuật giao lưu văn hóa thanh niên quốc tế thường niên đã chính thức mở màn trong tràng pháo tay rộn rã.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '开幕',
      'kāimù',
      'khai mạc, mở màn',
      'Động từ',
      'HSK 5',
      '一年一度的国际青年文化交流艺术节在掌声中正式拉开帷幕。',
      'Yì nián yí dù de guójì qīngnián wénhuà jiāoliú yìshùjié zài zhǎngshēng zhōng zhèngshì lākāi wéimù.',
      'Liên hoan nghệ thuật giao lưu văn hóa thanh niên quốc tế thường niên đã chính thức mở màn trong tràng pháo tay rộn rã.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一年一度的国际青年文化交流艺术节在掌声中正式拉开帷幕。', 'Yì nián yí dù de guójì qīngnián wénhuà jiāoliú yìshùjié zài zhǎngshēng zhōng zhèngshì lākāi wéimù.', 'Liên hoan nghệ thuật giao lưu văn hóa thanh niên quốc tế thường niên đã chính thức mở màn trong tràng pháo tay rộn rã.', 'basic', 1),
      (v_id, '世界互联网大会乌镇峰会隆重开幕，与会全球政要与科技领军企业家围绕数字经济合作与人工智能治理达成了广泛倡议。', 'Shìjiè Hùliánwǎng Dàhuì Wūzhèn Fēnghuì lóngzhòng kāimù, yùhuì quánqiú zhèngyào yǔ kējì lǐngjūn qǐyèjiā wéirào shùzì jīngjì hézuò yǔ réngōng zhìnéng zhìlǐ dáchéng le guǎnfàn chàngyì.', 'Hội nghị Thượng đỉnh Ô Trấn thuộc Hội nghị Internet Thế giới đã long trọng khai mạc, các chính khách toàn cầu cùng các doanh nhân công nghệ đầu ngành tham dự đã đạt được những sáng kiến rộng rãi xoay quanh hợp tác kinh tế số và quản trị trí tuệ nhân tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2652] [开幕式] (kāimùshì) - lễ khai mạc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '开幕式' AND pinyin = 'kāimùshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开幕式' AND pinyin = 'kāimùshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '开幕式'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开幕式'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kāimùshì',
      meaning_vi = 'lễ khai mạc',
      example_hanzi = '学校运动会的开幕式上，各班代表队迈着整齐的步伐走过主席台。',
      example_pinyin = 'Xuéxiào yùndònghuì de kāimùshì shang, gè bān dàibiǎoduì mài zhe zhěngqí de bùfá zǒuguò zhǔxítái.',
      example_vi = 'Tại lễ khai mạc đại hội thể thao của trường, các đoàn đại diện của từng lớp đã rảo bước chân đều tăm tắp đi qua khán đài chủ tịch.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '开幕式',
      'kāimùshì',
      'lễ khai mạc',
      'Danh từ',
      'HSK 5',
      '学校运动会的开幕式上，各班代表队迈着整齐的步伐走过主席台。',
      'Xuéxiào yùndònghuì de kāimùshì shang, gè bān dàibiǎoduì mài zhe zhěngqí de bùfá zǒuguò zhǔxítái.',
      'Tại lễ khai mạc đại hội thể thao của trường, các đoàn đại diện của từng lớp đã rảo bước chân đều tăm tắp đi qua khán đài chủ tịch.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校运动会的开幕式上，各班代表队迈着整齐的步伐走过主席台。', 'Xuéxiào yùndònghuì de kāimùshì shang, gè bān dàibiǎoduì mài zhe zhěngqí de bùfá zǒuguò zhǔxítái.', 'Tại lễ khai mạc đại hội thể thao của trường, các đoàn đại diện của từng lớp đã rảo bước chân đều tăm tắp đi qua khán đài chủ tịch.', 'basic', 1),
      (v_id, '夏季奥林匹克运动会开幕式将千年古老文明与现代裸眼3D全息光影技术完美交融，为全球数十亿观众奉献了一场震撼心灵的文化视觉盛宴。', 'Xiàjì Àolínpǐkè Yùndònghuì kāimùshì jiāng qiān nián gǔlǎo wénmíng yǔ xiàndài luǒyǎn 3D quánxī guāngyǐng jìshù wánměi jiāoróng, wèi quánqiú shù shí yì guānzhòng fèngxiàn le yì chǎng zhènhàn xīnlíng de wénhuà shìjué shèngyàn.', 'Lễ khai mạc Thế vận hội Olympic mùa hè đã giao thoa hoàn mỹ nền văn minh cổ xưa nghìn năm cùng công nghệ ánh sáng 3D toàn cảnh không cần kính hiện đại, cống hiến cho hàng tỷ khán giả toàn cầu một bữa tiệc thị giác văn hóa chấn động tâm hồn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2653] [开水] (kāishuǐ) - nước sôi, nước đun sôi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '开水' AND pinyin = 'kāishuǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开水' AND pinyin = 'kāishuǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '开水'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开水'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kāishuǐ',
      meaning_vi = 'nước sôi, nước đun sôi',
      example_hanzi = '感冒发烧时，医生建议多喝温开水并注意卧床休息。',
      example_pinyin = 'Gǎnmào fāshāo shí, yīshēng jiànyì duō hē wēn kāishuǐ bìng zhùyì wòchuáng xiūxi.',
      example_vi = 'Khi bị cảm sốt, bác sĩ khuyên nên uống nhiều nước đun sôi để ấm và chú ý nghỉ ngơi trên giường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '开水',
      'kāishuǐ',
      'nước sôi, nước đun sôi',
      'Danh từ',
      'HSK 5',
      '感冒发烧时，医生建议多喝温开水并注意卧床休息。',
      'Gǎnmào fāshāo shí, yīshēng jiànyì duō hē wēn kāishuǐ bìng zhùyì wòchuáng xiūxi.',
      'Khi bị cảm sốt, bác sĩ khuyên nên uống nhiều nước đun sôi để ấm và chú ý nghỉ ngơi trên giường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '感冒发烧时，医生建议多喝温开水并注意卧床休息。', 'Gǎnmào fāshāo shí, yīshēng jiànyì duō hē wēn kāishuǐ bìng zhùyì wòchuáng xiūxi.', 'Khi bị cảm sốt, bác sĩ khuyên nên uống nhiều nước đun sôi để ấm và chú ý nghỉ ngơi trên giường.', 'basic', 1),
      (v_id, '在野外地质勘探与野外生存作业中，将天然水源完全煮沸沉淀形成卫生安全的开水，是预防肠道传染病传播的最基本要求。', 'Zài yěwài dìzhì kāntàn yǔ yěwài shēngcún zuòyè zhōng, jiāng tiānrán shuǐyuán wánquán zhǔfèi chéndiàn xíngchéng wèishēng ānquán de kāishuǐ, shì yùfáng chángdào chuánrǎnbìng chuánbō de zuì jīběn yāoqiú.', 'Trong công tác khảo sát địa chất thực địa và sinh tồn dã ngoại, việc đun sôi sùng sục và lắng lọc nguồn nước tự nhiên thành nước sôi hợp vệ sinh an toàn là yêu cầu cơ bản nhất nhằm phòng ngừa sự lây lan của các bệnh truyền nhiễm đường ruột.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2654] [开通] (kāitōng) - thông tuyến, mở tuyến, kích hoạt; tư tưởng cởi mở [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '开通' AND pinyin = 'kāitōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开通' AND pinyin = 'kāitōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '开通'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开通'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kāitōng',
      meaning_vi = 'thông tuyến, mở tuyến, kích hoạt; tư tưởng cởi mở',
      example_hanzi = '城市新地铁线路正式开通运营，极大缩短了市民上下班的通勤时间。',
      example_pinyin = 'Chéngshì xīn dìtiě xiànlù zhèngshì kāitōng yùnyíng, jídà suōduǎn le shìmín shàng-xiàbān de tōngqín shíjiān.',
      example_vi = 'Tuyến tàu điện ngầm mới của thành phố chính thức thông tuyến vận hành, rút ngắn rất nhiều thời gian đi lại làm việc của người dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '开通',
      'kāitōng',
      'thông tuyến, mở tuyến, kích hoạt; tư tưởng cởi mở',
      'Động từ',
      'HSK 5',
      '城市新地铁线路正式开通运营，极大缩短了市民上下班的通勤时间。',
      'Chéngshì xīn dìtiě xiànlù zhèngshì kāitōng yùnyíng, jídà suōduǎn le shìmín shàng-xiàbān de tōngqín shíjiān.',
      'Tuyến tàu điện ngầm mới của thành phố chính thức thông tuyến vận hành, rút ngắn rất nhiều thời gian đi lại làm việc của người dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '城市新地铁线路正式开通运营，极大缩短了市民上下班的通勤时间。', 'Chéngshì xīn dìtiě xiànlù zhèngshì kāitōng yùnyíng, jídà suōduǎn le shìmín shàng-xiàbān de tōngqín shíjiān.', 'Tuyến tàu điện ngầm mới của thành phố chính thức thông tuyến vận hành, rút ngắn rất nhiều thời gian đi lại làm việc của người dân.', 'basic', 1),
      (v_id, '随着连接内陆腹地与沿海自贸试验区的高速跨海大桥全线开通，沿线区域间的人流、物流与资金流互通效率得到了爆发式释放。', 'Suízhe liánjiē nèilù fùdì yǔ yánhǎi zìmào shìyànqū de gāosù kuàhǎi dàqiáo quánxiàn kāitōng, yánxiàn qūyù jiān de rénliú, wùliú yǔ zījīnliú hùtōng xiàolǜ dédào le bàofāshì shìfàng.', 'Cùng với việc thông tuyến toàn diện cây cầu vượt biển cao tốc nối liền vùng nội địa trù phú và khu thí điểm thương mại tự do ven biển, hiệu suất lưu chuyển dòng người, dòng hàng và dòng vốn giữa các khu vực dọc tuyến đã được giải phóng bùng nổ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2655] [开业] (kāiyè) - khai trương, mở cửa kinh doanh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '开业' AND pinyin = 'kāiyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开业' AND pinyin = 'kāiyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '开业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kāiyè',
      meaning_vi = 'khai trương, mở cửa kinh doanh',
      example_hanzi = '社区门口新开业的面馆正在搞买一送一的优惠酬宾活动。',
      example_pinyin = 'Shèqū ménkǒu xīn kāiyè de miànguǎn zhèngzài gǎo mǎi yī sòng yī de yōuhuì chóubīn huódòng.',
      example_vi = 'Quán mì mới khai trương trước cổng khu dân cư đang triển khai chương trình ưu đãi tri ân mua một tặng một.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '开业',
      'kāiyè',
      'khai trương, mở cửa kinh doanh',
      'Động từ',
      'HSK 5',
      '社区门口新开业的面馆正在搞买一送一的优惠酬宾活动。',
      'Shèqū ménkǒu xīn kāiyè de miànguǎn zhèngzài gǎo mǎi yī sòng yī de yōuhuì chóubīn huódòng.',
      'Quán mì mới khai trương trước cổng khu dân cư đang triển khai chương trình ưu đãi tri ân mua một tặng một.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '社区门口新开业的面馆正在搞买一送一的优惠酬宾活动。', 'Shèqū ménkǒu xīn kāiyè de miànguǎn zhèngzài gǎo mǎi yī sòng yī de yōuhuì chóubīn huódòng.', 'Quán mì mới khai trương trước cổng khu dân cư đang triển khai chương trình ưu đãi tri ân mua một tặng một.', 'basic', 1),
      (v_id, '该跨国高端智能制造产业研发基地在自由贸易试验区隆重开业投产，预计年产值将突破百亿元大关。', 'Gāi kuàguó gāoduān zhìnéng zhìzào chǎnyè yánfā jīdì zài zìyóu màoyì shìyànqū lóngzhòng kāiyè tóuchǎn, yùjì nián chǎnzhí jiāng tūpò bǎi yì yuán dàguān.', 'Cơ sở nghiên cứu phát triển ngành chế tạo thông minh cao cấp xuyên quốc gia này đã long trọng khai trương đi vào sản xuất tại khu thí nghiệm thương mại tự do, dự kiến giá trị sản lượng hằng năm sẽ vượt mốc 10 tỷ nhân dân tệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2656] [开展] (kāizhǎn) - triển khai, phát động, mở rộng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '开展' AND pinyin = 'kāizhǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开展' AND pinyin = 'kāizhǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '开展'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '开展'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kāizhǎn',
      meaning_vi = 'triển khai, phát động, mở rộng',
      example_hanzi = '学校每逢植树节都会积极组织师生开展绿化植树志愿活动。',
      example_pinyin = 'Xuéxiào měiféng zhíshùjié dōu huì jījí zǔzhī shīshēng kāizhǎn lǜhuà zhíshù zhìyuàn huódòng.',
      example_vi = 'Cứ mỗi dịp Tết trồng cây, nhà trường đều tích cực tổ chức cho thầy cô và học sinh triển khai các hoạt động tình nguyện phủ xanh trồng cây.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '开展',
      'kāizhǎn',
      'triển khai, phát động, mở rộng',
      'Động từ',
      'HSK 5',
      '学校每逢植树节都会积极组织师生开展绿化植树志愿活动。',
      'Xuéxiào měiféng zhíshùjié dōu huì jījí zǔzhī shīshēng kāizhǎn lǜhuà zhíshù zhìyuàn huódòng.',
      'Cứ mỗi dịp Tết trồng cây, nhà trường đều tích cực tổ chức cho thầy cô và học sinh triển khai các hoạt động tình nguyện phủ xanh trồng cây.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校每逢植树节都会积极组织师生开展绿化植树志愿活动。', 'Xuéxiào měiféng zhíshùjié dōu huì jījí zǔzhī shīshēng kāizhǎn lǜhuà zhíshù zhìyuàn huódòng.', 'Cứ mỗi dịp Tết trồng cây, nhà trường đều tích cực tổ chức cho thầy cô và học sinh triển khai các hoạt động tình nguyện phủ xanh trồng cây.', 'basic', 1),
      (v_id, '国家多部门联合部署开展打击网络跨境电信诈骗专项治理行动，坚决斩断黑灰产业链并切实守护人民群众的财产安全。', 'Guójiā duō bùmén liánhé bùshǔ kāizhǎn dǎjī wǎngluò kuàjìng diànxìn zhàpiàn zhuānxiàng zhìlǐ xíngdòng, jiānjué zhǎnduàn hēihuī chǎnyèliàn bìng qièshí shǒuhù rénmín qúnzhòng de cáichǎn ānquán.', 'Nhiều cơ quan ban ngành quốc gia đã phối hợp bố trí triển khai đợt chuyên đề hành động truy quét lừa đảo viễn thông mạng xuyên biên giới, kiên quyết chặt đứt chuỗi cung ứng đen xám và bảo vệ thiết thực an toàn tài sản của quần chúng nhân dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2657] [看] (kān) - trông coi, canh giữ, coi sóc, chăm sóc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '看' AND pinyin = 'kān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '看' AND pinyin = 'kān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '看'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '看'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kān',
      meaning_vi = 'trông coi, canh giữ, coi sóc, chăm sóc',
      example_hanzi = '姐姐在家里细心看护生病发烧的小妹妹。',
      example_pinyin = 'Jiějie zài jiālǐ xìxīn kānhù shēngbìng fāshāo de xiǎo mèimei.',
      example_vi = 'Người chị ở nhà chăm chú trông nom, săn sóc cô em gái nhỏ đang bị ốm sốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '看',
      'kān',
      'trông coi, canh giữ, coi sóc, chăm sóc',
      'Động từ',
      'HSK 5',
      '姐姐在家里细心看护生病发烧的小妹妹。',
      'Jiějie zài jiālǐ xìxīn kānhù shēngbìng fāshāo de xiǎo mèimei.',
      'Người chị ở nhà chăm chú trông nom, săn sóc cô em gái nhỏ đang bị ốm sốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '姐姐在家里细心看护生病发烧的小妹妹。', 'Jiějie zài jiālǐ xìxīn kānhù shēngbìng fāshāo de xiǎo mèimei.', 'Người chị ở nhà chăm chú trông nom, săn sóc cô em gái nhỏ đang bị ốm sốt.', 'basic', 1),
      (v_id, '护林员老张在大山深处的国家级自然保护区看林护草数十年，默默守护着祖国的绿色生态屏障。', 'Hùlínyuán Lǎo Zhāng zài dàshān shēnchù de guójiājí zìrán bǎohùqū kān lín hù cǎo shù shí nián, mòmò shǒuhù zhe zǔguó de lǜsè shēngtài píngzhàng.', 'Bác kiểm lâm Trương ở nơi rừng sâu của khu bảo tồn thiên nhiên cấp quốc gia trông coi rừng và giữ gìn cây cỏ suốt hàng chục năm ròng, thầm lặng canh giữ bức bình phong sinh thái xanh của tổ quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2658] [看望] (kànwàng) - thăm hỏi, đến thăm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '看望' AND pinyin = 'kànwàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '看望' AND pinyin = 'kànwàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '看望'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '看望'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kànwàng',
      meaning_vi = 'thăm hỏi, đến thăm',
      example_hanzi = '周末我和父母一起去医院看望生病住院的语文老师。',
      example_pinyin = 'Zhōumò wǒ hé fùmǔ yìqǐ qù yīyuàn kànwàng shēngbìng zhùyuàn de yǔwén lǎoshī.',
      example_vi = 'Cuối tuần tôi cùng bố mẹ đến bệnh viện để thăm hỏi người thầy giáo dạy ngữ văn đang ốm nằm viện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '看望',
      'kànwàng',
      'thăm hỏi, đến thăm',
      'Động từ',
      'HSK 5',
      '周末我和父母一起去医院看望生病住院的语文老师。',
      'Zhōumò wǒ hé fùmǔ yìqǐ qù yīyuàn kànwàng shēngbìng zhùyuàn de yǔwén lǎoshī.',
      'Cuối tuần tôi cùng bố mẹ đến bệnh viện để thăm hỏi người thầy giáo dạy ngữ văn đang ốm nằm viện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末我和父母一起去医院看望生病住院的语文老师。', 'Zhōumò wǒ hé fùmǔ yìqǐ qù yīyuàn kànwàng shēngbìng zhùyuàn de yǔwén lǎoshī.', 'Cuối tuần tôi cùng bố mẹ đến bệnh viện để thăm hỏi người thầy giáo dạy ngữ văn đang ốm nằm viện.', 'basic', 1),
      (v_id, '在新春佳节来临之际，各级政府领导深入基层边远乡村看望慰问老党员与困难群众，向他们致以诚挚的节日祝福并送去慰问品。', 'Zài xīnchūn jiājié láilín zhījì, gè jí zhèngfǔ lǐngdǎo shēnrù jīcéng biānyuǎn xiāngcūn kànwàng wèiwèn lǎo dǎngyuán yǔ kùnnan qúnzhòng, xiàng tāmen zhìyǐ chéngzhì de jiérì zhùfú bìng sòng qù wèiwènpǐn.', 'Nhân dịp Tết cổ truyền sắp đến, lãnh đạo chính quyền các cấp đã sâu sát về các làng quê vùng sâu vùng xa để thăm hỏi động viên các đảng viên lão thành cùng bà con có hoàn cảnh khó khăn, gửi tới họ lời chúc Tết chân thành và những phần quà ấm áp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2659] [看作] (kànzuò) - coi như, xem như [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '看作' AND pinyin = 'kànzuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '看作' AND pinyin = 'kànzuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '看作'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '看作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kànzuò',
      meaning_vi = 'coi như, xem như',
      example_hanzi = '他把每一次失败都看作是人生中宝贵的学习经验。',
      example_pinyin = 'Tā bǎ měi yí cì shībài dōu kànzuò shì rénshēng zhōng bǎoguì de xuéxí jīngyàn.',
      example_vi = 'Anh ấy xem mỗi lần thất bại đều là một bài học kinh nghiệm vô cùng quý giá trong cuộc đời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '看作',
      'kànzuò',
      'coi như, xem như',
      'Động từ',
      'HSK 5',
      '他把每一次失败都看作是人生中宝贵的学习经验。',
      'Tā bǎ měi yí cì shībài dōu kànzuò shì rénshēng zhōng bǎoguì de xuéxí jīngyàn.',
      'Anh ấy xem mỗi lần thất bại đều là một bài học kinh nghiệm vô cùng quý giá trong cuộc đời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他把每一次失败都看作是人生中宝贵的学习经验。', 'Tā bǎ měi yí cì shībài dōu kànzuò shì rénshēng zhōng bǎoguì de xuéxí jīngyàn.', 'Anh ấy xem mỗi lần thất bại đều là một bài học kinh nghiệm vô cùng quý giá trong cuộc đời.', 'basic', 1),
      (v_id, '现代经济学将数据要素看作与土地、劳动力、资本及技术并列的第五大关键生产要素，其在资源重组与财富创造中的作用日益凸显。', 'Xiàndài jīngjìxué jiāng shùjù yàosù kànzuò yǔ tǔdì, láodònglì, zīběn jí jìshù bìngliè de dì-wǔ dà guānjiàn shēngchǎn yàosù, qí zài zīyuán chóngzǔ yǔ cáifù chuàngzào zhōng de zuòyòng rìyì tūxiǎn.', 'Kinh tế học hiện đại xem yếu tố dữ liệu như yếu tố sản xuất then chốt thứ năm song hành cùng đất đai, sức lao động, vốn và công nghệ, với vai trò ngày càng nổi bật trong tái cấu trúc nguồn lực và kiến tạo của cải.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2660] [靠] (kào) - dựa vào, tựa vào, nhờ vào; cập (bến) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '靠' AND pinyin = 'kào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '靠' AND pinyin = 'kào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '靠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '靠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kào',
      meaning_vi = 'dựa vào, tựa vào, nhờ vào; cập (bến)',
      example_hanzi = '他工作累了，就靠在沙发上闭目养神休息一会儿。',
      example_pinyin = 'Tā gōngzuò lèi le, jiù kào zài shāfā shang bìmù-yǎngshén xiūxi yíhuìr.',
      example_vi = 'Làm việc mệt rồi, anh ấy tựa vào ghế sofa nhắm mắt dưỡng thần nghỉ ngơi một lát.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '靠',
      'kào',
      'dựa vào, tựa vào, nhờ vào; cập (bến)',
      'Động từ',
      'HSK 5',
      '他工作累了，就靠在沙发上闭目养神休息一会儿。',
      'Tā gōngzuò lèi le, jiù kào zài shāfā shang bìmù-yǎngshén xiūxi yíhuìr.',
      'Làm việc mệt rồi, anh ấy tựa vào ghế sofa nhắm mắt dưỡng thần nghỉ ngơi một lát.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他工作累了，就靠在沙发上闭目养神休息一会儿。', 'Tā gōngzuò lèi le, jiù kào zài shāfā shang bìmù-yǎngshén xiūxi yíhuìr.', 'Làm việc mệt rồi, anh ấy tựa vào ghế sofa nhắm mắt dưỡng thần nghỉ ngơi một lát.', 'basic', 1),
      (v_id, '在激烈的全球高科技产业竞争中，核心技术的突破不能靠单打独斗，必须依靠完善的产学研协同创新生态体系。', 'Zài jīliè de quánqiú gāo kējì chǎnyè jìngzhēng zhōng, héxīn jìshù de tūpò bùnéng kào dāndǎ-dúdòu, bìxū yīkào wánshàn de chǎn-xué-yán xiétóng chuàngxīn shēngtài tǐxì.', 'Trong cuộc cạnh tranh ngành công nghiệp công nghệ cao toàn cầu khốc liệt, đột phá công nghệ cốt lõi không thể dựa vào đơn thương độc mã, mà phải dựa vào hệ sinh thái đổi mới hiệp đồng hoàn chỉnh giữa doanh nghiệp, viện nghiên cứu và trường đại học.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2661] [靠近] (kàojìn) - lại gần, áp sát, sát gần [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '靠近' AND pinyin = 'kàojìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '靠近' AND pinyin = 'kàojìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '靠近'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '靠近'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kàojìn',
      meaning_vi = 'lại gần, áp sát, sát gần',
      example_hanzi = '为了自身安全，参观动物园时严禁翻越护栏并靠近凶猛动物。',
      example_pinyin = 'Wèile zìshēn ānquán, cānguān dòngwùyuán shí yánjìn fānyuè hùlán bìng kàojìn xiōngměng dòngwù.',
      example_vi = 'Vì sự an toàn của bản thân, khi tham quan vườn thú nghiêm cấm trèo qua lan can và tiến lại gần các loài động vật hung dữ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '靠近',
      'kàojìn',
      'lại gần, áp sát, sát gần',
      'Động từ',
      'HSK 5',
      '为了自身安全，参观动物园时严禁翻越护栏并靠近凶猛动物。',
      'Wèile zìshēn ānquán, cānguān dòngwùyuán shí yánjìn fānyuè hùlán bìng kàojìn xiōngměng dòngwù.',
      'Vì sự an toàn của bản thân, khi tham quan vườn thú nghiêm cấm trèo qua lan can và tiến lại gần các loài động vật hung dữ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了自身安全，参观动物园时严禁翻越护栏并靠近凶猛动物。', 'Wèile zìshēn ānquán, cānguān dòngwùyuán shí yánjìn fānyuè hùlán bìng kàojìn xiōngměng dòngwù.', 'Vì sự an toàn của bản thân, khi tham quan vườn thú nghiêm cấm trèo qua lan can và tiến lại gần các loài động vật hung dữ.', 'basic', 1),
      (v_id, '随着深空探测器逐渐靠近火星轨道，地面测控中心通过微调姿态推进器，精准实施火星捕获制动减速轨道修正。', 'Suízhe shēnkōng tàncèqì zhújiàn kàojìn Huǒxīng guǐdào, dìmiàn cèkòng zhōngxīn tōngguò wēitiáo zītài tuījìnqì, jīngzhǔn shíshī Huǒxīng bǔhuò zhìdòng jiǎnsù guǐdào xiūzhèng.', 'Cùng với việc tàu thăm dò không gian sâu dần dần tiến sát quỹ đạo Sao Hỏa, trung tâm điều khiển mặt đất thông qua tinh chỉnh động cơ đẩy tư thế đã thực hiện chính xác việc hiệu chỉnh quỹ đạo phanh giảm tốc để Sao Hỏa bắt giữ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2662] [颗] (kē) - viên, hạt, quả, ngôi (lượng từ cho hạt, sao, tim, ngọc, vệ tinh) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '颗' AND pinyin = 'kē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '颗' AND pinyin = 'kē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '颗'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '颗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ',
      pinyin = 'kē',
      meaning_vi = 'viên, hạt, quả, ngôi (lượng từ cho hạt, sao, tim, ngọc, vệ tinh)',
      example_hanzi = '晴朗的夏夜里，天空中闪烁着一颗颗耀眼的星星。',
      example_pinyin = 'Qínglǎng de xiàyè lǐ, tiānkōng zhōng shǎnshuò zhe yì kēkē yàoyǎn de xīngxing.',
      example_vi = 'Trong đêm hè quang đãng, trên bầu trời lấp lánh từng ngôi sao sáng ngời rực rỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '颗',
      'kē',
      'viên, hạt, quả, ngôi (lượng từ cho hạt, sao, tim, ngọc, vệ tinh)',
      'Lượng từ',
      'HSK 5',
      '晴朗的夏夜里，天空中闪烁着一颗颗耀眼的星星。',
      'Qínglǎng de xiàyè lǐ, tiānkōng zhōng shǎnshuò zhe yì kēkē yàoyǎn de xīngxing.',
      'Trong đêm hè quang đãng, trên bầu trời lấp lánh từng ngôi sao sáng ngời rực rỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '晴朗的夏夜里，天空中闪烁着一颗颗耀眼的星星。', 'Qínglǎng de xiàyè lǐ, tiānkōng zhōng shǎnshuò zhe yì kēkē yàoyǎn de xīngxing.', 'Trong đêm hè quang đãng, trên bầu trời lấp lánh từng ngôi sao sáng ngời rực rỡ.', 'basic', 1),
      (v_id, '运载火箭成功将最新一代地球环境监测卫星送入预定轨道，这颗高轨道光学卫星将为全球气象灾害早期预警提供精准遥感数据支撑。', 'Yùnzài huǒjiàn chénggōng jiāng zuìxīn yídài dìqiú huánjìng jiāncè wèixīng sòngrù yùdìng guǐdào, zhè kē gāo guǐdào guāngxué wèixīng jiāng wèi quánqiú qìxiàng zāihài zǎoqī yùjǐng tígōng jīngzhǔn yáogǎn shùjù zhīchēng.', 'Tên lửa đẩy đã phóng thành công vệ tinh giám sát môi trường Trái Đất thế hệ mới nhất vào quỹ đạo dự định, quả vệ tinh quang học quỹ đạo cao này sẽ cung cấp nguồn dữ liệu viễn thám chuẩn xác cho việc cảnh báo sớm thiên tai khí tượng toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2663] [科研] (kēyán) - nghiên cứu khoa học; làm nghiên cứu [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '科研' AND pinyin = 'kēyán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '科研' AND pinyin = 'kēyán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '科研'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '科研'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'kēyán',
      meaning_vi = 'nghiên cứu khoa học; làm nghiên cứu',
      example_hanzi = '李教授带领学生们在实验室里全身心投入到国家科研课题中。',
      example_pinyin = 'Lǐ jiàoshòu dàilǐng xuéshengmen zài shíyànshì lǐ quánshēnxīn tóurù dào guójiā kēyán kètí zhōng.',
      example_vi = 'Giáo sư Lý dẫn dắt các học trò toàn tâm toàn ý cống hiến cho đề tài nghiên cứu khoa học cấp quốc gia nơi phòng thí nghiệm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '科研',
      'kēyán',
      'nghiên cứu khoa học; làm nghiên cứu',
      'Danh từ / Động từ',
      'HSK 5',
      '李教授带领学生们在实验室里全身心投入到国家科研课题中。',
      'Lǐ jiàoshòu dàilǐng xuéshengmen zài shíyànshì lǐ quánshēnxīn tóurù dào guójiā kēyán kètí zhōng.',
      'Giáo sư Lý dẫn dắt các học trò toàn tâm toàn ý cống hiến cho đề tài nghiên cứu khoa học cấp quốc gia nơi phòng thí nghiệm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '李教授带领学生们在实验室里全身心投入到国家科研课题中。', 'Lǐ jiàoshòu dàilǐng xuéshengmen zài shíyànshì lǐ quánshēnxīn tóurù dào guójiā kēyán kètí zhōng.', 'Giáo sư Lý dẫn dắt các học trò toàn tâm toàn ý cống hiến cho đề tài nghiên cứu khoa học cấp quốc gia nơi phòng thí nghiệm.', 'basic', 1),
      (v_id, '国家持续深化科研体制机制改革，赋予科研人员更大的科研经费支配权与技术路线自主权，全方位激发创新创造活力。', 'Guójiā chíxù shēnhuà kēyán tǐzhì jīzhì gǎigé, fùyǔ kēyán rényuán gèng dà de kēyán jīngfèi zhīpèiquán yǔ jìshù lùxiàn zìzhǔquán, quán fāngwèi jīfā chuàngxīn chuàngzào huólì.', 'Nhà nước liên tục làm sâu sắc thêm công cuộc cải cách thể chế cơ chế nghiên cứu khoa học, trao cho giới nghiên cứu quyền chi phối kinh phí đề tài và quyền tự chủ về lộ trình kỹ thuật lớn hơn, khơi dậy toàn diện sức sống đổi mới sáng tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2664] [可见] (kějiàn) - có thể thấy, thấy rõ là, hiển nhiên [Liên từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '可见' AND pinyin = 'kějiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '可见' AND pinyin = 'kějiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '可见'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '可见'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ / Động từ',
      pinyin = 'kějiàn',
      meaning_vi = 'có thể thấy, thấy rõ là, hiển nhiên',
      example_hanzi = '他在这份报告上做了密密麻麻的批注，可见他对这项工作有多么重视。',
      example_pinyin = 'Tā zài zhè fèn bàogào shang zuò le mìmìmámá de pīzhù, kějiàn tā duì zhè xiàng gōngzuò yǒu duōme zhòngshì.',
      example_vi = 'Anh ấy ghi chú chi chít dày đặc trên bản báo cáo này, có thể thấy anh ấy coi trọng công việc này đến mức nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '可见',
      'kějiàn',
      'có thể thấy, thấy rõ là, hiển nhiên',
      'Liên từ / Động từ',
      'HSK 5',
      '他在这份报告上做了密密麻麻的批注，可见他对这项工作有多么重视。',
      'Tā zài zhè fèn bàogào shang zuò le mìmìmámá de pīzhù, kějiàn tā duì zhè xiàng gōngzuò yǒu duōme zhòngshì.',
      'Anh ấy ghi chú chi chít dày đặc trên bản báo cáo này, có thể thấy anh ấy coi trọng công việc này đến mức nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在这份报告上做了密密麻麻的批注，可见他对这项工作有多么重视。', 'Tā zài zhè fèn bàogào shang zuò le mìmìmámá de pīzhù, kějiàn tā duì zhè xiàng gōngzuò yǒu duōme zhòngshì.', 'Anh ấy ghi chú chi chít dày đặc trên bản báo cáo này, có thể thấy anh ấy coi trọng công việc này đến mức nào.', 'basic', 1),
      (v_id, '高技术制造业投资增速持续显著高于全部投资平均水平，由此可见，产业高端化、智能化转型正在加速重塑国民经济结构。', 'Gāo jìshù zhìzàoyè tóuzī zēngsù chíxù xiǎnzhù gāoyú quánbù tóuzī píngjūn shuǐpíng, yóucǐ kějiàn, chǎnyè gāoduānhuà, zhìnénghuà zhuǎnxíng zhèngzài jiāsù chóngsù guómín jīngjì jiégòu.', 'Tốc độ tăng trưởng đầu tư vào ngành chế tạo công nghệ cao liên tục vượt trội so với mức bình quân toàn xã hội, qua đó có thể thấy rõ sự chuyển đổi cao cấp hóa và thông minh hóa ngành công nghiệp đang đẩy nhanh tái tạo cấu trúc nền kinh tế quốc dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2665] [可靠] (kěkào) - đáng tin cậy, chắc chắn, an toàn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '可靠' AND pinyin = 'kěkào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '可靠' AND pinyin = 'kěkào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '可靠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '可靠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'kěkào',
      meaning_vi = 'đáng tin cậy, chắc chắn, an toàn',
      example_hanzi = '他为人诚恳踏实且办事稳重，是一个非常值得信赖的可靠伙伴。',
      example_pinyin = 'Tā wéirén chéngkěn tàshi qiě bànshì wěnzhòng, shì yí gè fēicháng zhíde xìnlài de kěkào huǒbàn.',
      example_vi = 'Anh ấy ăn ở chân thành chất phác lại làm việc chín chắn, là một người cộng sự đáng tin cậy rất đáng để gửi gắm niềm tin.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '可靠',
      'kěkào',
      'đáng tin cậy, chắc chắn, an toàn',
      'Tính từ',
      'HSK 5',
      '他为人诚恳踏实且办事稳重，是一个非常值得信赖的可靠伙伴。',
      'Tā wéirén chéngkěn tàshi qiě bànshì wěnzhòng, shì yí gè fēicháng zhíde xìnlài de kěkào huǒbàn.',
      'Anh ấy ăn ở chân thành chất phác lại làm việc chín chắn, là một người cộng sự đáng tin cậy rất đáng để gửi gắm niềm tin.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他为人诚恳踏实且办事稳重，是一个非常值得信赖的可靠伙伴。', 'Tā wéirén chéngkěn tàshi qiě bànshì wěnzhòng, shì yí gè fēicháng zhíde xìnlài de kěkào huǒbàn.', 'Anh ấy ăn ở chân thành chất phác lại làm việc chín chắn, là một người cộng sự đáng tin cậy rất đáng để gửi gắm niềm tin.', 'basic', 1),
      (v_id, '大型水电站枢纽工程必须在极端洪水与强烈地震等罕见自然灾害工况下，依然保持大坝水工结构的绝对安全可靠。', 'Dàxíng shuǐdiànzhàn shūniǔ gōngchéng bìxū zài jíduān hóngshuǐ yǔ qiángliè dìzhèn děng hǎnjiàn zìrán zāihài gōngkuàng xià, yīrán bǎochí dàbà shuǐgōng jiégòu de juéduì ānquán kěkào.', 'Công trình đầu mối nhà máy thủy điện lớn bắt buộc phải duy trì độ an toàn chắc chắn tuyệt đối của kết cấu công trình thủy lợi thân đập ngay cả trong những điều kiện thiên tai hiếm gặp như lũ lụt cực đoan và động đất dữ dội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2666] [可怕] (kěpà) - đáng sợ, khủng khiếp [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '可怕' AND pinyin = 'kěpà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '可怕' AND pinyin = 'kěpà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '可怕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '可怕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'kěpà',
      meaning_vi = 'đáng sợ, khủng khiếp',
      example_hanzi = '遭遇失败并不可怕，可怕的是丧失了重新站起来的勇气与信心。',
      example_pinyin = 'Zāoyù shībài bìng bù kěpà, kěpà de shì sàngshī le chóngxīn zhàn qǐlái de yǒngqì yǔ xìnxīn.',
      example_vi = 'Gặp phải thất bại không hề đáng sợ, điều đáng sợ là đánh mất dũng khí và niềm tin để đứng dậy bước tiếp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '可怕',
      'kěpà',
      'đáng sợ, khủng khiếp',
      'Tính từ',
      'HSK 5',
      '遭遇失败并不可怕，可怕的是丧失了重新站起来的勇气与信心。',
      'Zāoyù shībài bìng bù kěpà, kěpà de shì sàngshī le chóngxīn zhàn qǐlái de yǒngqì yǔ xìnxīn.',
      'Gặp phải thất bại không hề đáng sợ, điều đáng sợ là đánh mất dũng khí và niềm tin để đứng dậy bước tiếp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '遭遇失败并不可怕，可怕的是丧失了重新站起来的勇气与信心。', 'Zāoyù shībài bìng bù kěpà, kěpà de shì sàngshī le chóngxīn zhàn qǐlái de yǒngqì yǔ xìnxīn.', 'Gặp phải thất bại không hề đáng sợ, điều đáng sợ là đánh mất dũng khí và niềm tin để đứng dậy bước tiếp.', 'basic', 1),
      (v_id, '核污染水若未经充分科学处理而长期排入公海，对全球海洋生态食物链及人类遗传基因造成的潜在危害将是极其可怕且不可逆转的。', 'Hé wūrǎnshuǐ ruò wèijīng chōngfèn kēxué chǔlǐ ér chángqī páirù gōnghǎi, duì quánqiú hǎiyáng shēngtài shíwùliàn jí rénlèi yíchuán jīyīn zàochéng de qiánzài wēihài jiāng shì jíqí kěpà qiě bùkě nìzhuǎn de.', 'Nước thải nhiễm hạt nhân nếu không qua xử lý khoa học thấu đáo mà xả thải lâu dài ra hải phận quốc tế, thì những hiểm họa tiềm ẩn gây ra cho chuỗi thức ăn sinh thái biển toàn cầu cùng nguồn gen di truyền của nhân loại sẽ là vô cùng khủng khiếp và không thể đảo ngược.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2667] [克服] (kèfú) - khắc phục, vượt qua (khó khăn, trở ngại) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '克服' AND pinyin = 'kèfú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '克服' AND pinyin = 'kèfú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '克服'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '克服'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kèfú',
      meaning_vi = 'khắc phục, vượt qua (khó khăn, trở ngại)',
      example_hanzi = '在大家的齐心协力下，我们终于克服了筹备过程中的重重困难。',
      example_pinyin = 'Zài dàjiā de qíxīn-xiélì xià, wǒmen zhōngyú kèfú le chóubèi guòchéng zhōng de chóngchóng kùnnan.',
      example_vi = 'Dưới sự chung lưng đấu cật của mọi người, chúng tôi cuối cùng đã vượt qua muôn vàn khó khăn trong quá trình chuẩn bị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '克服',
      'kèfú',
      'khắc phục, vượt qua (khó khăn, trở ngại)',
      'Động từ',
      'HSK 5',
      '在大家的齐心协力下，我们终于克服了筹备过程中的重重困难。',
      'Zài dàjiā de qíxīn-xiélì xià, wǒmen zhōngyú kèfú le chóubèi guòchéng zhōng de chóngchóng kùnnan.',
      'Dưới sự chung lưng đấu cật của mọi người, chúng tôi cuối cùng đã vượt qua muôn vàn khó khăn trong quá trình chuẩn bị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在大家的齐心协力下，我们终于克服了筹备过程中的重重困难。', 'Zài dàjiā de qíxīn-xiélì xià, wǒmen zhōngyú kèfú le chóubèi guòchéng zhōng de chóngchóng kùnnan.', 'Dưới sự chung lưng đấu cật của mọi người, chúng tôi cuối cùng đã vượt qua muôn vàn khó khăn trong quá trình chuẩn bị.', 'basic', 1),
      (v_id, '中国极地科考队员们发扬顽强拼搏精神，成功克服了南极高原零下数十度的极寒酷冷与狂风暴雪，圆满完成了全新考察站的建站任务。', 'Zhōngguó jídì kěkǎoduìyuánmen fāyáng wánqiáng pīnbó jīngshén, chénggōng kèfú le Nánjí gāoyuán língxià shù shí dù de jíhán kùlěng yǔ kuángfēng-bàoxuě, yuánmǎn wánchéng le quánxīn kǎocházhàn de jiànzhàn rènwu.', 'Các thành viên đội thám hiểm vùng cực Trung Quốc đã phát huy tinh thần chiến đấu kiên cường, khắc phục thành công cái giá rét cực đoan âm hàng chục độ cùng bão tuyết cuồng nộ trên cao nguyên Nam Cực, hoàn thành trọn vẹn nhiệm vụ xây dựng trạm khảo sát mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2668] [客服] (kèfú) - chăm sóc khách hàng, nhân viên CSKH, dịch vụ khách hàng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '客服' AND pinyin = 'kèfú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '客服' AND pinyin = 'kèfú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '客服'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '客服'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kèfú',
      meaning_vi = 'chăm sóc khách hàng, nhân viên CSKH, dịch vụ khách hàng',
      example_hanzi = '如果在网购过程中遇到商品破损问题，可以随时在线联系平台官方客服。',
      example_pinyin = 'Rúguǒ zài wǎnggòu guòchéng zhōng yùdào shāngpǐn pòsǔn wèntí, kěyǐ suíshí xiànshàng liánxì píngtái guānfāng kèfú.',
      example_vi = 'Nếu trong quá trình mua sắm trực tuyến gặp sự cố hàng hóa bị hư hỏng, bạn có thể liên hệ với bộ phận chăm sóc khách hàng chính thức của sàn bất cứ lúc nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '客服',
      'kèfú',
      'chăm sóc khách hàng, nhân viên CSKH, dịch vụ khách hàng',
      'Danh từ',
      'HSK 5',
      '如果在网购过程中遇到商品破损问题，可以随时在线联系平台官方客服。',
      'Rúguǒ zài wǎnggòu guòchéng zhōng yùdào shāngpǐn pòsǔn wèntí, kěyǐ suíshí xiànshàng liánxì píngtái guānfāng kèfú.',
      'Nếu trong quá trình mua sắm trực tuyến gặp sự cố hàng hóa bị hư hỏng, bạn có thể liên hệ với bộ phận chăm sóc khách hàng chính thức của sàn bất cứ lúc nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果在网购过程中遇到商品破损问题，可以随时在线联系平台官方客服。', 'Rúguǒ zài wǎnggòu guòchéng zhōng yùdào shāngpǐn pòsǔn wèntí, kěyǐ suíshí xiànshàng liánxì píngtái guānfāng kèfú.', 'Nếu trong quá trình mua sắm trực tuyến gặp sự cố hàng hóa bị hư hỏng, bạn có thể liên hệ với bộ phận chăm sóc khách hàng chính thức của sàn bất cứ lúc nào.', 'basic', 1),
      (v_id, '商业银行依托大语言模型开发智能AI语音客服助理，能够全天候秒级解答客户关于信用卡账单、跨境汇款等各类复杂业务咨询。', 'Shāngyè yínháng yītuō dà yǔyán móxíng kāifā zhìnéng AI yǔyīn kèfú zhùlǐ, nénggòu quántiānhòu miǎojí jiědá kèhù guānyú xìnyòngkǎ zhàngdān, kuàjìng huìkuǎn děng gèlèi fùzá yèwù zīxún.', 'Ngân hàng thương mại dựa vào mô hình ngôn ngữ lớn để phát triển trợ lý ảo chăm sóc khách hàng bằng giọng nói AI thông minh, có thể giải đáp chỉ trong tích tắc suốt 24/7 mọi thắc mắc nghiệp vụ phức tạp của khách hàng về hóa đơn thẻ tín dụng và chuyển tiền xuyên biên giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2669] [客观] (kèguān) - khách quan, trung thực, không thiên vị [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '客观' AND pinyin = 'kèguān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '客观' AND pinyin = 'kèguān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '客观'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '客观'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'kèguān',
      meaning_vi = 'khách quan, trung thực, không thiên vị',
      example_hanzi = '评价一个人或一件事时，应当秉持公正而客观的态度。',
      example_pinyin = 'Píngjià yí gè rén huò yí jiàn shì shí, yīngdāng bǐngchí gōngzhèng ér kèguān de tàidu.',
      example_vi = 'Khi đánh giá một con người hay một sự việc, nên giữ vững thái độ công bằng và khách quan.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '客观',
      'kèguān',
      'khách quan, trung thực, không thiên vị',
      'Tính từ',
      'HSK 5',
      '评价一个人或一件事时，应当秉持公正而客观的态度。',
      'Píngjià yí gè rén huò yí jiàn shì shí, yīngdāng bǐngchí gōngzhèng ér kèguān de tàidu.',
      'Khi đánh giá một con người hay một sự việc, nên giữ vững thái độ công bằng và khách quan.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '评价一个人或一件事时，应当秉持公正而客观的态度。', 'Píngjià yí gè rén huò yí jiàn shì shí, yīngdāng bǐngchí gōngzhèng ér kèguān de tàidu.', 'Khi đánh giá một con người hay một sự việc, nên giữ vững thái độ công bằng và khách quan.', 'basic', 1),
      (v_id, '宏观经济政策评估必须建立在对海量客观统计指标与微观市场主体调研的深度交叉验证之上，坚决杜绝主观臆断。', 'Hóngguān jīngjì zhèngcè pínggū bìxū jiànlì zài duì hǎiliàng kèguān tǒngjì zhǐbiāo yǔ wēiguān shìchǎng zhǔtǐ diàoyán de shēndù jiāochā yànzhèng zhīshàng, jiānjué dùjué zhǔguān yìduàn.', 'Đánh giá chính sách kinh tế vĩ mô phải được xây dựng dựa trên việc đối chiếu kiểm chứng chéo sâu sắc giữa khối lượng đồ sộ các chỉ tiêu thống kê khách quan và khảo sát thực tế các chủ thể thị trường vi mô, kiên quyết chấm dứt suy đoán chủ quan.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2670] [客户] (kèhù) - khách hàng, đối tác [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '客户' AND pinyin = 'kèhù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '客户' AND pinyin = 'kèhù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '客户'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '客户'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kèhù',
      meaning_vi = 'khách hàng, đối tác',
      example_hanzi = '我们公司始终把满足客户的合理需求放在首要位置。',
      example_pinyin = 'Wǒmen gōngsī shǐzhōng bǎ mǎnzú kèhù de hélǐ xūqiú fàng zài shǒuyào wèizhì.',
      example_vi = 'Công ty chúng tôi luôn đặt việc đáp ứng các nhu cầu chính đáng của khách hàng lên vị trí hàng đầu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '客户',
      'kèhù',
      'khách hàng, đối tác',
      'Danh từ',
      'HSK 5',
      '我们公司始终把满足客户的合理需求放在首要位置。',
      'Wǒmen gōngsī shǐzhōng bǎ mǎnzú kèhù de hélǐ xūqiú fàng zài shǒuyào wèizhì.',
      'Công ty chúng tôi luôn đặt việc đáp ứng các nhu cầu chính đáng của khách hàng lên vị trí hàng đầu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们公司始终把满足客户的合理需求放在首要位置。', 'Wǒmen gōngsī shǐzhōng bǎ mǎnzú kèhù de hélǐ xūqiú fàng zài shǒuyào wèizhì.', 'Công ty chúng tôi luôn đặt việc đáp ứng các nhu cầu chính đáng của khách hàng lên vị trí hàng đầu.', 'basic', 1),
      (v_id, '在数字化客户关系管理体系中，企业通过用户画像算法精准挖掘核心高端客户的个性化需求，实现客户终身价值的最大化。', 'Zài shùzìhuà kèhù guānxì guǎnlǐ tǐxì zhōng, qǐyè tōngguò yònghù huàxiàng suànfǎ jīngzhǔn wājué héxīn gāoduān kèhù de gèxìnghuà xūqiú, shíxiàn kèhù zhōngshēn jiàzhí de zuìdàhuà.', 'Trong hệ thống quản trị quan hệ khách hàng số hóa, doanh nghiệp thông qua thuật toán phác họa chân dung người dùng để khai phá chính xác nhu cầu cá nhân hóa của các khách hàng cao cấp cốt lõi, tối đa hóa giá trị trọn đời của khách hàng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2671] [空间] (kōngjiān) - không gian, khoảng trống, dư địa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '空间' AND pinyin = 'kōngjiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '空间' AND pinyin = 'kōngjiān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '空间'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '空间'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kōngjiān',
      meaning_vi = 'không gian, khoảng trống, dư địa',
      example_hanzi = '这个房间布局合理，即使摆放了大家具依然留有宽敞的活动空间。',
      example_pinyin = 'Zhè gè fángjiān bùjú hélǐ, jíshǐ bǎifàng le dà jiājù yīrán liúyǒu kuānchǎng de huódòng kōngjiān.',
      example_vi = 'Căn phòng này bài trí rất hợp lý, dẫu có kê đồ nội thất cỡ lớn vẫn để lại không gian sinh hoạt rộng rãi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '空间',
      'kōngjiān',
      'không gian, khoảng trống, dư địa',
      'Danh từ',
      'HSK 5',
      '这个房间布局合理，即使摆放了大家具依然留有宽敞的活动空间。',
      'Zhè gè fángjiān bùjú hélǐ, jíshǐ bǎifàng le dà jiājù yīrán liúyǒu kuānchǎng de huódòng kōngjiān.',
      'Căn phòng này bài trí rất hợp lý, dẫu có kê đồ nội thất cỡ lớn vẫn để lại không gian sinh hoạt rộng rãi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这个房间布局合理，即使摆放了大家具依然留有宽敞的活动空间。', 'Zhè gè fángjiān bùjú hélǐ, jíshǐ bǎifàng le dà jiājù yīrán liúyǒu kuānchǎng de huódòng kōngjiān.', 'Căn phòng này bài trí rất hợp lý, dẫu có kê đồ nội thất cỡ lớn vẫn để lại không gian sinh hoạt rộng rãi.', 'basic', 1),
      (v_id, '随着高水平双向对外开放战略的深入推进，我国在绿色低碳能源、高端智能装备制造等领域的国际经贸合作空间十分广阔。', 'Suízhe gāo shuǐpíng shuāngxiàng duìwài kāifàng zhànlüè de shēnrù tuījìn, wǒ guó zài lǜsè dītàn néngyuán, gāoduān zhìnéng zhuāngbèi zhìzào děng lǐngyù de guójì jīngmào hézuò kōngjiān shífēn guǎngkuò.', 'Cùng với sự đẩy mạnh sâu rộng của chiến lược mở cửa đối ngoại hai chiều trình độ cao, dư địa hợp tác kinh tế thương mại quốc tế của nước ta trong các lĩnh vực năng lượng xanh ít carbon và chế tạo thiết bị thông minh cao cấp là vô cùng rộng mở.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2672] [空中] (kōngzhōng) - trên không trung, giữa không gian; đường hàng không [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '空中' AND pinyin = 'kōngzhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '空中' AND pinyin = 'kōngzhōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '空中'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '空中'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'kōngzhōng',
      meaning_vi = 'trên không trung, giữa không gian; đường hàng không',
      example_hanzi = '几只白鹭在蓝天白云映衬下的空中自由自在地翱翔。',
      example_pinyin = 'Jǐ zhī báilù zài lántiān-báiyún yìngchèn xià de kōngzhōng zìyóu-zìzài de áoxiáng.',
      example_vi = 'Vài chú cò trắng bay lượn tự do tự tại trên không trung dưới nền trời xanh mây trắng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '空中',
      'kōngzhōng',
      'trên không trung, giữa không gian; đường hàng không',
      'Danh từ / Tính từ',
      'HSK 5',
      '几只白鹭在蓝天白云映衬下的空中自由自在地翱翔。',
      'Jǐ zhī báilù zài lántiān-báiyún yìngchèn xià de kōngzhōng zìyóu-zìzài de áoxiáng.',
      'Vài chú cò trắng bay lượn tự do tự tại trên không trung dưới nền trời xanh mây trắng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '几只白鹭在蓝天白云映衬下的空中自由自在地翱翔。', 'Jǐ zhī báilù zài lántiān-báiyún yìngchèn xià de kōngzhōng zìyóu-zìzài de áoxiáng.', 'Vài chú cò trắng bay lượn tự do tự tại trên không trung dưới nền trời xanh mây trắng.', 'basic', 1),
      (v_id, '低空经济作为新质生产力的典型代表，正在城市空中交通立体物流配送、应急消防救援以及农林植保作业中加速落地应用。', 'Dīkōng jīngjì zuòwéi xīnzhì shēngchǎnlì de diǎnxíng dàibiǎo, zhèngzài chéngshì kōngzhōng jiāotōng lìtǐ wùliú pèisòng, yìngjí xiāofáng jiùyuán yǐjí nóng-lín zhíbǎo zuòyè zhōng jiāsù luòdì yìngyòng.', 'Kinh tế tầm thấp với tư cách là đại diện tiêu biểu của lực lượng sản xuất chất lượng mới, đang đẩy nhanh ứng dụng vào đời sống trong giao thông không trung đô thị, phân phối hậu cần lập thể, cứu nạn cứu hỏa khẩn cấp và bảo vệ mùa màng nông lâm nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2673] [控制] (kòngzhì) - khống chế, kiểm soát, điều khiển [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '控制' AND pinyin = 'kòngzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '控制' AND pinyin = 'kòngzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '控制'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '控制'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'kòngzhì',
      meaning_vi = 'khống chế, kiểm soát, điều khiển',
      example_hanzi = '在公共场合发生争执时，双方都应当克制情绪，努力控制好自己的言行。',
      example_pinyin = 'Zài gōnggòng chǎnghé fāshēng zhēngzhí shí, shuāngfāng dōu yīngdāng kèzhì qíngxù, nǔlì kòngzhì hǎo zìjǐ de yánxíng.',
      example_vi = 'Khi xảy ra tranh cãi nơi công cộng, hai bên đều nên kiềm chế cảm xúc, nỗ lực kiểm soát tốt lời nói và hành vi của mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '控制',
      'kòngzhì',
      'khống chế, kiểm soát, điều khiển',
      'Động từ / Danh từ',
      'HSK 5',
      '在公共场合发生争执时，双方都应当克制情绪，努力控制好自己的言行。',
      'Zài gōnggòng chǎnghé fāshēng zhēngzhí shí, shuāngfāng dōu yīngdāng kèzhì qíngxù, nǔlì kòngzhì hǎo zìjǐ de yánxíng.',
      'Khi xảy ra tranh cãi nơi công cộng, hai bên đều nên kiềm chế cảm xúc, nỗ lực kiểm soát tốt lời nói và hành vi của mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在公共场合发生争执时，双方都应当克制情绪，努力控制好自己的言行。', 'Zài gōnggòng chǎnghé fāshēng zhēngzhí shí, shuāngfāng dōu yīngdāng kèzhì qíngxù, nǔlì kòngzhì hǎo zìjǐ de yánxíng.', 'Khi xảy ra tranh cãi nơi công cộng, hai bên đều nên kiềm chế cảm xúc, nỗ lực kiểm soát tốt lời nói và hành vi của mình.', 'basic', 1),
      (v_id, '智能电网调度中心采用毫秒级自适应控制算法，有效解决了海量分布式风电光伏高比例并网引发的电压频率波动控制难题。', 'Zhìnéng diànwǎng diàodù zhōngxīn cǎiyòng háomiǎojí zìshìyìng kòngzhì suànfǎ, yǒuxiào jiějué le hǎiliàng fēnbùshì fēngdiàn-guāngfú gāo bǐlì bìngwǎng yǐnfā de diànyā pínlǜ bōdòng kòngzhì nántí.', 'Trung tâm điều độ lưới điện thông minh áp dụng thuật toán điều khiển tự thích ứng cấp độ mili giây, giải quyết hiệu quả bài toán hóc búa về kiểm soát biến động điện áp và tần số khi hòa mạng tỷ lệ cao nguồn điện gió và điện mặt trời phân tán khổng lồ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2674] [口袋] (kǒudai) - túi quần, túi áo, túi đựng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '口袋' AND pinyin = 'kǒudai'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '口袋' AND pinyin = 'kǒudai'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '口袋'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '口袋'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kǒudai',
      meaning_vi = 'túi quần, túi áo, túi đựng',
      example_hanzi = '出门前他习惯性地把钥匙和手机装在外套口袋里。',
      example_pinyin = 'Chūmén qián tā xíguànxìng de bǎ yàoshi hé shǒujī zhuāng zài wàitào kǒudai lǐ.',
      example_vi = 'Trước khi ra khỏi nhà, anh ấy theo thói quen bỏ chìa khóa và điện thoại vào túi áo khoác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '口袋',
      'kǒudai',
      'túi quần, túi áo, túi đựng',
      'Danh từ',
      'HSK 5',
      '出门前他习惯性地把钥匙和手机装在外套口袋里。',
      'Chūmén qián tā xíguànxìng de bǎ yàoshi hé shǒujī zhuāng zài wàitào kǒudai lǐ.',
      'Trước khi ra khỏi nhà, anh ấy theo thói quen bỏ chìa khóa và điện thoại vào túi áo khoác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门前他习惯性地把钥匙和手机装在外套口袋里。', 'Chūmén qián tā xíguànxìng de bǎ yàoshi hé shǒujī zhuāng zài wàitào kǒudai lǐ.', 'Trước khi ra khỏi nhà, anh ấy theo thói quen bỏ chìa khóa và điện thoại vào túi áo khoác.', 'basic', 1),
      (v_id, '脱贫攻坚战取得全面胜利后，乡村振兴政策持续发力，切实鼓起了广大偏远山区乡亲们的钱袋子，让老百姓的口袋真正鼓了起来。', 'Tuōpín gōngjiānzhàn qǔdé quánmiàn shènglì hòu, xiāngcūn zhènxīng zhèngcè chíxù fālì, qièshí gǔqǐ le guǎngdà piānyuǎn shānqū xiāngqīnmen de qiándàizi, ràng lǎobǎixìng de kǒudai zhēnzhèng gǔ le qǐlái.', 'Sau khi chiến dịch xóa đói giảm nghèo giành thắng lợi toàn diện, các chính sách chấn hưng nông thôn tiếp tục phát huy sức mạnh, làm đầy đặn thiết thực túi tiền của bà con nông dân vùng cao hẻo lánh, khiến túi áo của người dân thực sự ấm no.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2675] [口味] (kǒuwèi) - khẩu vị, sở thích hương vị ăn uống [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '口味' AND pinyin = 'kǒuwèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '口味' AND pinyin = 'kǒuwèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '口味'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '口味'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kǒuwèi',
      meaning_vi = 'khẩu vị, sở thích hương vị ăn uống',
      example_hanzi = '南方菜偏甜清淡，而北方菜口味通常偏咸偏浓郁。',
      example_pinyin = 'Nánfāng cài piān tián qīngdàn, ér běifāng cài kǒuwèi tōngcháng piān xián piān nóngyù.',
      example_vi = 'Món ăn phương Nam thiên về thanh đạm ngọt dịu, còn khẩu vị món ăn phương Bắc thông thường thiên về mặn và đậm đà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '口味',
      'kǒuwèi',
      'khẩu vị, sở thích hương vị ăn uống',
      'Danh từ',
      'HSK 5',
      '南方菜偏甜清淡，而北方菜口味通常偏咸偏浓郁。',
      'Nánfāng cài piān tián qīngdàn, ér běifāng cài kǒuwèi tōngcháng piān xián piān nóngyù.',
      'Món ăn phương Nam thiên về thanh đạm ngọt dịu, còn khẩu vị món ăn phương Bắc thông thường thiên về mặn và đậm đà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '南方菜偏甜清淡，而北方菜口味通常偏咸偏浓郁。', 'Nánfāng cài piān tián qīngdàn, ér běifāng cài kǒuwèi tōngcháng piān xián piān nóngyù.', 'Món ăn phương Nam thiên về thanh đạm ngọt dịu, còn khẩu vị món ăn phương Bắc thông thường thiên về mặn và đậm đà.', 'basic', 1),
      (v_id, '跨国餐饮品牌进入本土市场时，必须深入调研当地消费群体的传统饮食偏好，研发出契合区域本土口味的特色创新菜单。', 'Kuàguó cānyǐn pǐnpái jìnrù běntǔ shìchǎng shí, bìxū shēnrù diàoyán dāngdì xiāofèi qúntǐ de chuántǒng yǐnshí piānhào, yánfā chū qìhé qūyù běntǔ kǒuwèi de tèsè chuàngxīn càidān.', 'Các thương hiệu ẩm thực xuyên quốc gia khi thâm nhập thị trường bản địa phải khảo sát sâu sắc thói quen ăn uống truyền thống của nhóm người tiêu dùng sở tại, sáng tạo nên thực đơn đổi mới đặc sắc ăn khớp với khẩu vị địa phương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2676] [库] (kù) - kho, nhà kho, kho chứa, kho tàng, cơ sở dữ liệu (database) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '库' AND pinyin = 'kù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '库' AND pinyin = 'kù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '库'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '库'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kù',
      meaning_vi = 'kho, nhà kho, kho chứa, kho tàng, cơ sở dữ liệu (database)',
      example_hanzi = '大型水库不仅具备防洪调蓄功能，还承担着周边城市的灌溉供水重任。',
      example_pinyin = 'Dàxíng shuǐkù bùjǐn jùbèi fánghóng tiáoxù gōngnéng, hái chéngdān zhe zhōubiān chéngshì de guàngài gōngshuǐ zhòngrèn.',
      example_vi = 'Hồ chứa nước lớn không chỉ có chức năng chống lũ điều tiết nước, mà còn gánh vác trọng trách cấp nước tưới tiêu cho các đô thị lân cận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '库',
      'kù',
      'kho, nhà kho, kho chứa, kho tàng, cơ sở dữ liệu (database)',
      'Danh từ',
      'HSK 5',
      '大型水库不仅具备防洪调蓄功能，还承担着周边城市的灌溉供水重任。',
      'Dàxíng shuǐkù bùjǐn jùbèi fánghóng tiáoxù gōngnéng, hái chéngdān zhe zhōubiān chéngshì de guàngài gōngshuǐ zhòngrèn.',
      'Hồ chứa nước lớn không chỉ có chức năng chống lũ điều tiết nước, mà còn gánh vác trọng trách cấp nước tưới tiêu cho các đô thị lân cận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大型水库不仅具备防洪调蓄功能，还承担着周边城市的灌溉供水重任。', 'Dàxíng shuǐkù bùjǐn jùbèi fánghóng tiáoxù gōngnéng, hái chéngdān zhe zhōubiān chéngshì de guàngài gōngshuǐ zhòngrèn.', 'Hồ chứa nước lớn không chỉ có chức năng chống lũ điều tiết nước, mà còn gánh vác trọng trách cấp nước tưới tiêu cho các đô thị lân cận.', 'basic', 1),
      (v_id, '国家基因库保存了数以万计濒危动植物的活性种质资源样本，为守护全球生物多样性构筑起了坚不可摧的生命种质战略储备库。', 'Guójiā jīyīnkù bǎocún le shù yǐ wàn jì bīnwēi dòngzhíwù de huóxìng zhǒngzhì zīyuán yàngběn, wèi shǒuhù quánqiú shēngwù duōyàngxìng gòuzhù qǐ le jiānbùkěcuī de shēngmìng zhǒngzhì zhànlüè chǔbèikù.', 'Ngân hàng gen quốc gia lưu giữ hàng vạn mẫu tiêu bản tài nguyên mầm gen sống của các loài động thực vật nguy cấp, dựng xây nên kho dự trữ chiến lược giống nòi sự sống kiên cố không thể phá vỡ nhằm bảo tồn tính đa dạng sinh học toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2677] [宽] (kuān) - rộng, rộng rãi; chiều rộng; khoan dung, thoáng [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宽' AND pinyin = 'kuān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宽' AND pinyin = 'kuān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '宽'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宽'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'kuān',
      meaning_vi = 'rộng, rộng rãi; chiều rộng; khoan dung, thoáng',
      example_hanzi = '这条新修建的滨海林荫大道非常宽，双向一共有八条车道。',
      example_pinyin = 'Zhè tiáo xīn xiūjiàn de bīnhǎi línyīn dàdào fēicháng kuān, shuāngxiàng yígòng yǒu bā tiáo chēdào.',
      example_vi = 'Đại lộ rợp bóng cây ven biển mới được xây dựng này rất rộng, hai chiều có tổng cộng tám làn xe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宽',
      'kuān',
      'rộng, rộng rãi; chiều rộng; khoan dung, thoáng',
      'Tính từ / Danh từ',
      'HSK 5',
      '这条新修建的滨海林荫大道非常宽，双向一共有八条车道。',
      'Zhè tiáo xīn xiūjiàn de bīnhǎi línyīn dàdào fēicháng kuān, shuāngxiàng yígòng yǒu bā tiáo chēdào.',
      'Đại lộ rợp bóng cây ven biển mới được xây dựng này rất rộng, hai chiều có tổng cộng tám làn xe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这条新修建的滨海林荫大道非常宽，双向一共有八条车道。', 'Zhè tiáo xīn xiūjiàn de bīnhǎi línyīn dàdào fēicháng kuān, shuāngxiàng yígòng yǒu bā tiáo chēdào.', 'Đại lộ rợp bóng cây ven biển mới được xây dựng này rất rộng, hai chiều có tổng cộng tám làn xe.', 'basic', 1),
      (v_id, '胸怀宽广的领导者往往善于海纳百川并容人之短，从而紧紧凝聚起各方优秀专业人才共同成就一番伟大事业。', 'Xiōnghuái kuānguǎng de lǐngdǎozhě wǎngwǎng shànyú hǎinà-bǎichuān bìng róngrén-zhīduǎn, cóng’ér jǐnjǐn níngjù qǐ gèfāng yōuxiù zhuānyè réncái gòngtóng chéngjiù yì fān wěidà shìyè.', 'Người lãnh đạo có tấm lòng rộng mở thường biết dung nạp muôn dòng và bao dung khuyết điểm của người khác, nhờ đó gắn kết bền chặt nhân tài chuyên môn ưu tú khắp nơi cùng gây dựng nên một sự nghiệp vĩ đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2678] [宽度] (kuāndù) - chiều rộng, bề rộng, độ rộng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宽度' AND pinyin = 'kuāndù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宽度' AND pinyin = 'kuāndù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '宽度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宽度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kuāndù',
      meaning_vi = 'chiều rộng, bề rộng, độ rộng',
      example_hanzi = '在购买新衣柜前，务必先用卷尺准确测量好卧室预留空间的宽度。',
      example_pinyin = 'Zài gòumǎi xīn yīguì qián, wùbì xiān yòng juǎnchǐ zhǔnquè cèliáng hǎo wòshì yùliú kōngjiān de kuāndù.',
      example_vi = 'Trước khi mua tủ quần áo mới, nhất thiết phải dùng thước cuộn đo đạc chính xác chiều rộng không gian dành sẵn trong phòng ngủ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宽度',
      'kuāndù',
      'chiều rộng, bề rộng, độ rộng',
      'Danh từ',
      'HSK 5',
      '在购买新衣柜前，务必先用卷尺准确测量好卧室预留空间的宽度。',
      'Zài gòumǎi xīn yīguì qián, wùbì xiān yòng juǎnchǐ zhǔnquè cèliáng hǎo wòshì yùliú kōngjiān de kuāndù.',
      'Trước khi mua tủ quần áo mới, nhất thiết phải dùng thước cuộn đo đạc chính xác chiều rộng không gian dành sẵn trong phòng ngủ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在购买新衣柜前，务必先用卷尺准确测量好卧室预留空间的宽度。', 'Zài gòumǎi xīn yīguì qián, wùbì xiān yòng juǎnchǐ zhǔnquè cèliáng hǎo wòshì yùliú kōngjiān de kuāndù.', 'Trước khi mua tủ quần áo mới, nhất thiết phải dùng thước cuộn đo đạc chính xác chiều rộng không gian dành sẵn trong phòng ngủ.', 'basic', 1),
      (v_id, '超高压电网跨江输电铁塔基础施工中，工程师对塔身钢构件的装配宽度误差有着毫米级的极高精度标准。', 'Chāogāoyā diànwǎng kuàjiāng shūdiàn tiětǎ jīchǔ shīgōng zhōng, gōngchéngshī duì tǎshēn gāng gòujiàn de zhuāngpèi kuāndù wùchā yǒu zhe háomǐ jí de jí gāo jīngdù biāozhǔn.', 'Trong thi công móng tháp truyền tải điện vượt sông thuộc lưới điện siêu cao áp, các kỹ sư đặt ra tiêu chuẩn độ chính xác cực cao đến từng milimet đối với sai số bề rộng lắp ráp các cấu kiện thép thân tháp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2679] [亏] (kuī) - lỗ vốn, thua thiệt, hao hụt; may nhờ có [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亏' AND pinyin = 'kuī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亏' AND pinyin = 'kuī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亏'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Phó từ',
      pinyin = 'kuī',
      meaning_vi = 'lỗ vốn, thua thiệt, hao hụt; may nhờ có',
      example_hanzi = '今天出门幸亏带了雨伞，不然路上肯定会被大雨淋成落汤鸡。',
      example_pinyin = 'Jīntiān chūmén xìngkuī dài le yǔsǎn, bùrán lùshang kěndìng huì bèi dàyǔ lín chéng luòtāngjī.',
      example_vi = 'Hôm nay ra khỏi nhà may nhờ có mang theo ô, nếu không ở trên đường chắc chắn đã bị mưa ướt như chuột lột.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亏',
      'kuī',
      'lỗ vốn, thua thiệt, hao hụt; may nhờ có',
      'Động từ / Phó từ',
      'HSK 5',
      '今天出门幸亏带了雨伞，不然路上肯定会被大雨淋成落汤鸡。',
      'Jīntiān chūmén xìngkuī dài le yǔsǎn, bùrán lùshang kěndìng huì bèi dàyǔ lín chéng luòtāngjī.',
      'Hôm nay ra khỏi nhà may nhờ có mang theo ô, nếu không ở trên đường chắc chắn đã bị mưa ướt như chuột lột.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天出门幸亏带了雨伞，不然路上肯定会被大雨淋成落汤鸡。', 'Jīntiān chūmén xìngkuī dài le yǔsǎn, bùrán lùshang kěndìng huì bèi dàyǔ lín chéng luòtāngjī.', 'Hôm nay ra khỏi nhà may nhờ có mang theo ô, nếu không ở trên đường chắc chắn đã bị mưa ướt như chuột lột.', 'basic', 1),
      (v_id, '该跨国制造业巨头受困于传统燃油汽车销量持续下滑，上一财年净利润大幅转亏，迫使董事会加速向纯电动智能化战略转型。', 'Gāi kuàguó zhìzàoyè jùtóu shòukùn yú chuántǒng rányóu qìchē xiàoliàng chíxù xiàhuá, shàng yí cáinián jìnglìrùn dàfú zhuǎn kuī, pòshǐ dǒngshìhuì jiāsù xiàng chún diàndòng zhìnénghuà zhànlüè zhuǎnxíng.', 'Gã khổng lồ chế tạo xuyên quốc gia này do sa lầy vào đà sụt giảm doanh số xe chạy xăng truyền thống, lợi nhuận ròng niên độ tài chính trước đã chuyển thành thua lỗ nặng nề, buộc hội đồng quản trị phải đẩy nhanh chuyển dịch chiến lược sang xe điện thông minh thuần túy.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2680] [昆虫] (kūnchóng) - côn trùng, sâu bọ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '昆虫' AND pinyin = 'kūnchóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '昆虫' AND pinyin = 'kūnchóng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '昆虫'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '昆虫'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'kūnchóng',
      meaning_vi = 'côn trùng, sâu bọ',
      example_hanzi = '科学课上，老师带领同学们去植物园观察各种昆虫的生活习性。',
      example_pinyin = 'Kēxuékè shang, lǎoshī dàilǐng tóngxuémen qù zhíwùyuán guānchá gèzhǒng kūnchóng de shēnghuó xíxìng.',
      example_vi = 'Trong tiết khoa học, thầy giáo dẫn các bạn học sinh tới vườn bách thảo để quan sát tập tính sinh hoạt của các loài côn trùng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '昆虫',
      'kūnchóng',
      'côn trùng, sâu bọ',
      'Danh từ',
      'HSK 5',
      '科学课上，老师带领同学们去植物园观察各种昆虫的生活习性。',
      'Kēxuékè shang, lǎoshī dàilǐng tóngxuémen qù zhíwùyuán guānchá gèzhǒng kūnchóng de shēnghuó xíxìng.',
      'Trong tiết khoa học, thầy giáo dẫn các bạn học sinh tới vườn bách thảo để quan sát tập tính sinh hoạt của các loài côn trùng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '科学课上，老师带领同学们去植物园观察各种昆虫的生活习性。', 'Kēxuékè shang, lǎoshī dàilǐng tóngxuémen qù zhíwùyuán guānchá gèzhǒng kūnchóng de shēnghuó xíxìng.', 'Trong tiết khoa học, thầy giáo dẫn các bạn học sinh tới vườn bách thảo để quan sát tập tính sinh hoạt của các loài côn trùng.', 'basic', 1),
      (v_id, '蜜蜂与蝴蝶等传粉昆虫在全球农业生态系统与农作物增产中扮演着至关重要的角色，过度使用化学农药正对昆虫种群生存构成严峻威胁。', 'Mìfēng yǔ húdié děng chuánfěn kūnchóng zài quánqiú nóngyè shēngtài xìtǒng yǔ nóngzuòwù zēngchǎn zhōng bànyǎn zhe zhìguān-zhòngyào de juésè, guòdù shǐyòng huàxué nóngyào zhèng duì kūnchóng zhǒngqún shēngcún gòuchéng yánjùn wēixié.', 'Các loài côn trùng thụ phấn như ong mật và bướm đóng vai trò đặc biệt quan trọng trong hệ sinh thái nông nghiệp toàn cầu và việc tăng sản lượng hoa màu, việc lạm dụng thuốc trừ sâu hóa học đang đặt ra mối đe dọa nghiêm trọng đối với sự sinh tồn của các quần thể côn trùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2681] [扩大] (kuòdà) - mở rộng, khuếch đại, nới rộng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '扩大' AND pinyin = 'kuòdà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '扩大' AND pinyin = 'kuòdà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '扩大'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '扩大'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'kuòdà',
      meaning_vi = 'mở rộng, khuếch đại, nới rộng',
      example_hanzi = '这家糕点店因为口碑极好，老板打算在城市东区再扩大一家分店。',
      example_pinyin = 'Zhè jiā gāodiǎndiàn yīnwèi kǒubēi jí hǎo, lǎobǎn dǎsuàn zài chéngshì dōngqū zài kuòdà yì jiā fēndiàn.',
      example_vi = 'Cửa tiệm bánh ngọt này nhờ danh tiếng truyền miệng rất tốt nên ông chủ dự định sẽ mở rộng thêm một chi nhánh ở khu vực phía đông thành phố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '扩大',
      'kuòdà',
      'mở rộng, khuếch đại, nới rộng',
      'Động từ',
      'HSK 5',
      '这家糕点店因为口碑极好，老板打算在城市东区再扩大一家分店。',
      'Zhè jiā gāodiǎndiàn yīnwèi kǒubēi jí hǎo, lǎobǎn dǎsuàn zài chéngshì dōngqū zài kuòdà yì jiā fēndiàn.',
      'Cửa tiệm bánh ngọt này nhờ danh tiếng truyền miệng rất tốt nên ông chủ dự định sẽ mở rộng thêm một chi nhánh ở khu vực phía đông thành phố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家糕点店因为口碑极好，老板打算在城市东区再扩大一家分店。', 'Zhè jiā gāodiǎndiàn yīnwèi kǒubēi jí hǎo, lǎobǎn dǎsuàn zài chéngshì dōngqū zài kuòdà yì jiā fēndiàn.', 'Cửa tiệm bánh ngọt này nhờ danh tiếng truyền miệng rất tốt nên ông chủ dự định sẽ mở rộng thêm một chi nhánh ở khu vực phía đông thành phố.', 'basic', 1),
      (v_id, '国家坚持扩大高水平制度型对外开放，持续稳步扩大金融服务、电信增值以及生物医药领域的市场准入范围。', 'Guójiā jiānchí kuòdà gāo shuǐpíng zhìdùxíng duìwài kāifàng, chíxù wěnbù kuòdà jīnróng fúwù, diànxìn zēngzhí yǐjí shēngwù yīyào lǐngyù de shìchǎng zhǔnrù fànwéi.', 'Nhà nước kiên trì mở rộng hội nhập mở cửa đối ngoại ở cấp độ thể chế tiêu chuẩn cao, liên tục mở rộng vững chắc phạm vi tiếp cận thị trường trong các lĩnh vực dịch vụ tài chính, viễn thông giá trị gia tăng và dược sinh học.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2682] [来源] (láiyuán) - nguồn, nguồn gốc; bắt nguồn từ [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '来源' AND pinyin = 'láiyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '来源' AND pinyin = 'láiyuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '来源'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '来源'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'láiyuán',
      meaning_vi = 'nguồn, nguồn gốc; bắt nguồn từ',
      example_hanzi = '写学术论文时，引用的所有数据都必须注明权威真实的信息来源。',
      example_pinyin = 'Xiě xuéshù lùnwén shí, yǐnyòng de suǒyǒu shùjù dōu bìxū zhùmíng quánwēi zhēnshí de xìnxī láiyuán.',
      example_vi = 'Khi viết luận văn học thuật, tất cả các số liệu trích dẫn đều bắt buộc phải ghi rõ nguồn thông tin xác thực uy tín.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '来源',
      'láiyuán',
      'nguồn, nguồn gốc; bắt nguồn từ',
      'Danh từ / Động từ',
      'HSK 5',
      '写学术论文时，引用的所有数据都必须注明权威真实的信息来源。',
      'Xiě xuéshù lùnwén shí, yǐnyòng de suǒyǒu shùjù dōu bìxū zhùmíng quánwēi zhēnshí de xìnxī láiyuán.',
      'Khi viết luận văn học thuật, tất cả các số liệu trích dẫn đều bắt buộc phải ghi rõ nguồn thông tin xác thực uy tín.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '写学术论文时，引用的所有数据都必须注明权威真实的信息来源。', 'Xiě xuéshù lùnwén shí, yǐnyòng de suǒyǒu shùjù dōu bìxū zhùmíng quánwēi zhēnshí de xìnxī láiyuán.', 'Khi viết luận văn học thuật, tất cả các số liệu trích dẫn đều bắt buộc phải ghi rõ nguồn thông tin xác thực uy tín.', 'basic', 1),
      (v_id, '科学研究表明，一切真知都是从直接经验发源的，实践不仅是认识的唯一来源，更是检验真理的唯一标准。', 'Kēxué yánjiū biǎomíng, yíqiè zhēnzhī dōu shì cóng zhíjiē jīngyàn fāyuán de, shíjiàn bùjǐn shì rènshi de wéiyī láiyuán, gèng shì jiǎnyàn zhēnlǐ de wéiyī biāozhǔn.', 'Nghiên cứu khoa học chỉ ra rằng, mọi hiểu biết chân thực đều bắt nguồn từ kinh nghiệm trực tiếp, thực tiễn không chỉ là nguồn gốc duy nhất của nhận thức mà còn là tiêu chuẩn duy nhất để kiểm nghiệm chân lý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2683] [劳动] (láodòng) - lao động; làm việc, làm lụng [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '劳动' AND pinyin = 'láodòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '劳动' AND pinyin = 'láodòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '劳动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '劳动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'láodòng',
      meaning_vi = 'lao động; làm việc, làm lụng',
      example_hanzi = '我们从小就应当树立崇尚劳动、尊重每一个劳动者的良好品德。',
      example_pinyin = 'Wǒmen cóngxiǎo jiù yīngdāng shùlì chóngshàng láodòng, zūnzhòng měi yí gè láodòngzhě de liánghǎo pǐndé.',
      example_vi = 'Từ nhỏ chúng ta đã nên tạo dựng phẩm chất tốt đẹp biết tôn vinh lao động và tôn trọng từng người lao động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '劳动',
      'láodòng',
      'lao động; làm việc, làm lụng',
      'Danh từ / Động từ',
      'HSK 5',
      '我们从小就应当树立崇尚劳动、尊重每一个劳动者的良好品德。',
      'Wǒmen cóngxiǎo jiù yīngdāng shùlì chóngshàng láodòng, zūnzhòng měi yí gè láodòngzhě de liánghǎo pǐndé.',
      'Từ nhỏ chúng ta đã nên tạo dựng phẩm chất tốt đẹp biết tôn vinh lao động và tôn trọng từng người lao động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们从小就应当树立崇尚劳动、尊重每一个劳动者的良好品德。', 'Wǒmen cóngxiǎo jiù yīngdāng shùlì chóngshàng láodòng, zūnzhòng měi yí gè láodòngzhě de liánghǎo pǐndé.', 'Từ nhỏ chúng ta đã nên tạo dựng phẩm chất tốt đẹp biết tôn vinh lao động và tôn trọng từng người lao động.', 'basic', 1),
      (v_id, '大力弘扬劳模精神、劳动精神与工匠精神，对于激励当代广大青年走技能成才、技能报国之路具有重大的现实意义。', 'Dàlì hóngyáng láomó jīngshén, láodòng jīngshén yǔ gōngjiàng jīngshén, duìyú jīlì dāngdài guǎngdà qīngnián zǒu jìnéng chéngcái, jìnéng bàoguó zhī lù jùyǒu zhòngdà de xiànshí yìyì.', 'Đẩy mạnh phát huy tinh thần người lao động kiểu mẫu, tinh thần lao động và tinh thần nghệ nhân có ý nghĩa thực tiễn to lớn trong việc khích lệ đông đảo thanh niên thời đại đi theo con đường dùng tay nghề thành tài và dùng kỹ năng cống hiến cho đất nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2684] [老百姓] (lǎobǎixìng) - người dân, người dân thường, bách tính [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '老百姓' AND pinyin = 'lǎobǎixìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '老百姓' AND pinyin = 'lǎobǎixìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '老百姓'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '老百姓'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǎobǎixìng',
      meaning_vi = 'người dân, người dân thường, bách tính',
      example_hanzi = '政府出台的各项便民惠民政策切实减轻了普通老百姓的生活负担。',
      example_pinyin = 'Zhèngfǔ chūtái de gè xiàng biànmín-huìmín zhèngcè qièshí jiǎnqīng le pǔtōng lǎobǎixìng de shēnghuó fùdān.',
      example_vi = 'Các chính sách thuận lòng dân và mang lại lợi ích cho dân do chính quyền ban hành đã giảm nhẹ thiết thực gánh nặng sinh hoạt cho người dân thường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '老百姓',
      'lǎobǎixìng',
      'người dân, người dân thường, bách tính',
      'Danh từ',
      'HSK 5',
      '政府出台的各项便民惠民政策切实减轻了普通老百姓的生活负担。',
      'Zhèngfǔ chūtái de gè xiàng biànmín-huìmín zhèngcè qièshí jiǎnqīng le pǔtōng lǎobǎixìng de shēnghuó fùdān.',
      'Các chính sách thuận lòng dân và mang lại lợi ích cho dân do chính quyền ban hành đã giảm nhẹ thiết thực gánh nặng sinh hoạt cho người dân thường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '政府出台的各项便民惠民政策切实减轻了普通老百姓的生活负担。', 'Zhèngfǔ chūtái de gè xiàng biànmín-huìmín zhèngcè qièshí jiǎnqīng le pǔtōng lǎobǎixìng de shēnghuó fùdān.', 'Các chính sách thuận lòng dân và mang lại lợi ích cho dân do chính quyền ban hành đã giảm nhẹ thiết thực gánh nặng sinh hoạt cho người dân thường.', 'basic', 1),
      (v_id, '江山就是人民，人民就是江山，党和政府始终把老百姓的安危冷暖放在心中最高位置，着力解决人民群众急难愁盼的民生痛点。', 'Jiāngshān jiùshì rénmín, rénmín jiùshì jiāngshān, dǎng hé zhèngfǔ shǐzhōng bǎ lǎobǎixìng de ān-wēi lěng-nuǎn fàng zài xīnlǐ zuì gāo wèizhì, zhuólì jiějué rénmín qúnzhòng jí-nán-chóu-pàn de mínshēng tòngdiǎn.', 'Giang sơn chính là nhân dân, nhân dân chính là giang sơn, Đảng và Chính phủ luôn đặt sự an nguy và đời sống no ấm của người dân lên vị trí cao nhất trong lòng, dốc sức giải quyết những điểm nghẽn bức xúc cấp bách mà quần chúng nhân dân đang mong mỏi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2685] [老板] (lǎobǎn) - ông chủ, chủ tiệm, sếp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '老板' AND pinyin = 'lǎobǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '老板' AND pinyin = 'lǎobǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '老板'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '老板'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǎobǎn',
      meaning_vi = 'ông chủ, chủ tiệm, sếp',
      example_hanzi = '书店老板是一位和蔼可亲的老学者，经常热心给读者推荐好书。',
      example_pinyin = 'Shūdiàn lǎobǎn shì yí wèi hé’ǎi-kěqīn de lǎo xuézhě, chāngcháng rèxīn gěi dúzhě tuījiàn hǎo shū.',
      example_vi = 'Ông chủ tiệm sách là một học giả cao tuổi hiền từ dễ mến, thường xuyên nhiệt tình giới thiệu sách hay cho bạn đọc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '老板',
      'lǎobǎn',
      'ông chủ, chủ tiệm, sếp',
      'Danh từ',
      'HSK 5',
      '书店老板是一位和蔼可亲的老学者，经常热心给读者推荐好书。',
      'Shūdiàn lǎobǎn shì yí wèi hé’ǎi-kěqīn de lǎo xuézhě, chāngcháng rèxīn gěi dúzhě tuījiàn hǎo shū.',
      'Ông chủ tiệm sách là một học giả cao tuổi hiền từ dễ mến, thường xuyên nhiệt tình giới thiệu sách hay cho bạn đọc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '书店老板是一位和蔼可亲的老学者，经常热心给读者推荐好书。', 'Shūdiàn lǎobǎn shì yí wèi hé’ǎi-kěqīn de lǎo xuézhě, chāngcháng rèxīn gěi dúzhě tuījiàn hǎo shū.', 'Ông chủ tiệm sách là một học giả cao tuổi hiền từ dễ mến, thường xuyên nhiệt tình giới thiệu sách hay cho bạn đọc.', 'basic', 1),
      (v_id, '作为拥有敏锐战略眼光的科技初创企业老板，他果断决策将全部天使轮融资投入到了生成式AI底座模型的自主研发当中。', 'Zuòwéi yōngyǒu mǐnruì zhànlüè yǎnguāng de kējì chūchuàng qǐyè lǎobǎn, tā guǒduàn juécè jiāng quánbù tiānshǐ lún róngzī tóurù dào le shēngchéngxìng AI dǐzuò móxíng de zìzhǔ yánfā dāngzhōng.', 'Là một ông chủ doanh nghiệp công nghệ khởi nghiệp sở hữu tầm nhìn chiến lược nhạy bén, anh ấy đã quyết đoán đưa ra quyết định dồn toàn bộ nguồn vốn gọi được ở vòng thiên thần vào việc tự chủ nghiên cứu mô hình nền tảng AI tạo sinh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2686] [老公] (lǎogōng) - chồng, ông xã [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '老公' AND pinyin = 'lǎogōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '老公' AND pinyin = 'lǎogōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '老公'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '老公'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǎogōng',
      meaning_vi = 'chồng, ông xã',
      example_hanzi = '每天下班回到家，老公总是主动走进厨房准备丰盛的晚餐。',
      example_pinyin = 'Měi tiān xiàbān huídào jiā, lǎogōng zǒngshì zhǔdòng zǒujìn chúfáng zhǔnbèi fēngshèng de wǎncān.',
      example_vi = 'Mỗi ngày tan sở về nhà, người chồng luôn chủ động bước vào bếp nấu một bữa tối thịnh soạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '老公',
      'lǎogōng',
      'chồng, ông xã',
      'Danh từ',
      'HSK 5',
      '每天下班回到家，老公总是主动走进厨房准备丰盛的晚餐。',
      'Měi tiān xiàbān huídào jiā, lǎogōng zǒngshì zhǔdòng zǒujìn chúfáng zhǔnbèi fēngshèng de wǎncān.',
      'Mỗi ngày tan sở về nhà, người chồng luôn chủ động bước vào bếp nấu một bữa tối thịnh soạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天下班回到家，老公总是主动走进厨房准备丰盛的晚餐。', 'Měi tiān xiàbān huídào jiā, lǎogōng zǒngshì zhǔdòng zǒujìn chúfáng zhǔnbèi fēngshèng de wǎncān.', 'Mỗi ngày tan sở về nhà, người chồng luôn chủ động bước vào bếp nấu một bữa tối thịnh soạn.', 'basic', 1),
      (v_id, '结婚十余年来，夫妻俩在职业发展与家庭教育中始终相互扶持、同甘共苦，树立了文明相爱、和睦融洽的良好家风。', 'Jiéhūn shí yú nián lái, fūqī liǎ zài zhíyè fāzhǎn yǔ jiātíng jiàoyù zhōng shǐzhōng xiānghù fúchí, tónggān-gòngkǔ, shùlì le wénmíng xiāng’ài, hémù róngqià de liánghǎo jiāfēng.', 'Hơn 10 năm kết hôn, hai vợ chồng trong phát triển sự nghiệp và giáo dục gia đình luôn nâng đỡ lẫn nhau, đồng cam cộng khổ, xây dựng nếp nhà văn minh yêu thương và hòa thuận ấm cúng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2687] [姥姥] (lǎolao) - bà ngoại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '姥姥' AND pinyin = 'lǎolao'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '姥姥' AND pinyin = 'lǎolao'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '姥姥'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '姥姥'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǎolao',
      meaning_vi = 'bà ngoại',
      example_hanzi = '放暑假的时候，我最喜欢去乡下姥姥家吃她亲手包的玉米饺子。',
      example_pinyin = 'Fàng shǔjià de shíhou, wǒ zuì xǐhuan qù xiāngxia lǎolao jiā chī tā qīnshǒu bāo de yùmǐ jiǎozi.',
      example_vi = 'Khi được nghỉ hè, tôi thích nhất là về quê nhà bà ngoại để ăn món sủi cảo nhân ngô do chính tay bà gói.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '姥姥',
      'lǎolao',
      'bà ngoại',
      'Danh từ',
      'HSK 5',
      '放暑假的时候，我最喜欢去乡下姥姥家吃她亲手包的玉米饺子。',
      'Fàng shǔjià de shíhou, wǒ zuì xǐhuan qù xiāngxia lǎolao jiā chī tā qīnshǒu bāo de yùmǐ jiǎozi.',
      'Khi được nghỉ hè, tôi thích nhất là về quê nhà bà ngoại để ăn món sủi cảo nhân ngô do chính tay bà gói.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '放暑假的时候，我最喜欢去乡下姥姥家吃她亲手包的玉米饺子。', 'Fàng shǔjià de shíhou, wǒ zuì xǐhuan qù xiāngxia lǎolao jiā chī tā qīnshǒu bāo de yùmǐ jiǎozi.', 'Khi được nghỉ hè, tôi thích nhất là về quê nhà bà ngoại để ăn món sủi cảo nhân ngô do chính tay bà gói.', 'basic', 1),
      (v_id, '姥姥慈祥温暖的叮咛与勤俭持家的崇高美德，犹如一盏明灯，深深烙印在每一个儿孙辈的心中代代相传。', 'Lǎolao cíxiáng wēnnuǎn de dīngníng yǔ qínjiǎn-chíjiā de chónggāo měidé, yóurú yì zhǎn míngdēng, shēnshēn làoyìn zài měi yí gè érsūnbèi de xīnzhōng dài dài xiāngchuán.', 'Lời dặn dò ấm áp đôn hậu của bà ngoại cùng đức tính cần kiệm vun vén gia đình cao đẹp, tựa như một ngọn đèn sáng ngời khắc sâu trong tâm khảm của từng thế hệ con cháu và truyền thừa qua các đời.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2688] [老婆] (lǎopo) - vợ, bà xã [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '老婆' AND pinyin = 'lǎopo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '老婆' AND pinyin = 'lǎopo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '老婆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '老婆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǎopo',
      meaning_vi = 'vợ, bà xã',
      example_hanzi = '今天是老婆的生日，丈夫特意买了一束鲜艳的红玫瑰作为惊喜礼物。',
      example_pinyin = 'Jīntiān shì lǎopo de shēngrì, zhàngfu tèyì mǎi le yí shù xiānyàn de hóng méiguī zuòwéi jīngxǐ lǐwù.',
      example_vi = 'Hôm nay là sinh nhật của vợ, người chồng đặc biệt mua một bó hoa hồng đỏ tươi thắm làm món quà bất ngờ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '老婆',
      'lǎopo',
      'vợ, bà xã',
      'Danh từ',
      'HSK 5',
      '今天是老婆的生日，丈夫特意买了一束鲜艳的红玫瑰作为惊喜礼物。',
      'Jīntiān shì lǎopo de shēngrì, zhàngfu tèyì mǎi le yí shù xiānyàn de hóng méiguī zuòwéi jīngxǐ lǐwù.',
      'Hôm nay là sinh nhật của vợ, người chồng đặc biệt mua một bó hoa hồng đỏ tươi thắm làm món quà bất ngờ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天是老婆的生日，丈夫特意买了一束鲜艳的红玫瑰作为惊喜礼物。', 'Jīntiān shì lǎopo de shēngrì, zhàngfu tèyì mǎi le yí shù xiānyàn de hóng méiguī zuòwéi jīngxǐ lǐwù.', 'Hôm nay là sinh nhật của vợ, người chồng đặc biệt mua một bó hoa hồng đỏ tươi thắm làm món quà bất ngờ.', 'basic', 1),
      (v_id, '在艰苦的边疆支教岁月里，他和妻子互为最坚强的精神支柱，共同为偏远山区的孩子们点亮了求知的希望之光。', 'Zài jiānkǔ de biānjiāng zhījiào suìyuè lǐ, tā hé qīzi hù wéi zuì jiānqiáng de jīngshén zhīzhù, gòngtóng wèi piānyuǎn shānqū de háizimen diǎnliàng le qiúzhī de xīwàng zhī guāng.', 'Trong những năm tháng tình nguyện dạy học đầy gian khó nơi biên cương, anh và người vợ đã là điểm tựa tinh thần vững chắc nhất cho nhau, cùng nhau thắp sáng ngọn lửa hy vọng tìm kiếm tri thức cho trẻ em vùng cao hẻo lánh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2689] [姥爷] (lǎoye) - ông ngoại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '姥爷' AND pinyin = 'lǎoye'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '姥爷' AND pinyin = 'lǎoye'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '姥爷'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '姥爷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǎoye',
      meaning_vi = 'ông ngoại',
      example_hanzi = '姥爷年轻时曾是一名优秀的铁路机车司机，经常给我讲火车的故事。',
      example_pinyin = 'Lǎoye niánqīng shí céng shì yì míng yōuxiù de tiělù jīchē sījī, chángcháng gěi wǒ jiǎng huǒchē de gùshì.',
      example_vi = 'Ông ngoại thời trẻ từng là một người lái đầu máy xe lửa xuất sắc, thường hay kể cho tôi nghe những câu chuyện về đoàn tàu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '姥爷',
      'lǎoye',
      'ông ngoại',
      'Danh từ',
      'HSK 5',
      '姥爷年轻时曾是一名优秀的铁路机车司机，经常给我讲火车的故事。',
      'Lǎoye niánqīng shí céng shì yì míng yōuxiù de tiělù jīchē sījī, chángcháng gěi wǒ jiǎng huǒchē de gùshì.',
      'Ông ngoại thời trẻ từng là một người lái đầu máy xe lửa xuất sắc, thường hay kể cho tôi nghe những câu chuyện về đoàn tàu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '姥爷年轻时曾是一名优秀的铁路机车司机，经常给我讲火车的故事。', 'Lǎoye niánqīng shí céng shì yì míng yōuxiù de tiělù jīchē sījī, chángcháng gěi wǒ jiǎng huǒchē de gùshì.', 'Ông ngoại thời trẻ từng là một người lái đầu máy xe lửa xuất sắc, thường hay kể cho tôi nghe những câu chuyện về đoàn tàu.', 'basic', 1),
      (v_id, '身为参加过抗美援朝的老战士，姥爷珍藏在旧铁盒里的勋章见证了那个战火纷飞年代保家卫国的赤胆忠心。', 'Shēnwéi cānjiā guò Kàng Měi Yuán Cháo de lǎo zhànshì, lǎoye zhēncáng zài jiù tiěhé lǐ de xūnzhāng jiànzhèng le nà gè zhànhuǒ-fēnfēi niándài bǎojiā-wèiguó de chìdǎn-zhōngxīn.', 'Với tư cách là người cựu chiến binh từng tham gia kháng chiến chống Mỹ viện Triều, những tấm huân chương được ông ngoại nâng niu gìn giữ trong chiếc hộp sắt cũ là minh chứng cho tấm lòng trung trinh son sắt bảo vệ gia đình và tổ quốc trong những năm tháng đạn bom khói lửa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2690] [乐观] (lèguān) - lạc quan, yêu đời, tin tưởng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '乐观' AND pinyin = 'lèguān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乐观' AND pinyin = 'lèguān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '乐观'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乐观'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'lèguān',
      meaning_vi = 'lạc quan, yêu đời, tin tưởng',
      example_hanzi = '无论面对多么棘手的困难，他脸上总是挂着乐观灿烂的微笑。',
      example_pinyin = 'Wúlùn miànduì duōme jíshǒu de kùnnan, tā liǎn shang zǒngshì guà zhe lèguān cànlàn de wēixiào.',
      example_vi = 'Bất luận đối mặt với khó khăn hóc búa đến nhường nào, trên gương mặt anh ấy lúc nào cũng nở nụ cười lạc quan rạng rỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '乐观',
      'lèguān',
      'lạc quan, yêu đời, tin tưởng',
      'Tính từ',
      'HSK 5',
      '无论面对多么棘手的困难，他脸上总是挂着乐观灿烂的微笑。',
      'Wúlùn miànduì duōme jíshǒu de kùnnan, tā liǎn shang zǒngshì guà zhe lèguān cànlàn de wēixiào.',
      'Bất luận đối mặt với khó khăn hóc búa đến nhường nào, trên gương mặt anh ấy lúc nào cũng nở nụ cười lạc quan rạng rỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论面对多么棘手的困难，他脸上总是挂着乐观灿烂的微笑。', 'Wúlùn miànduì duōme jíshǒu de kùnnan, tā liǎn shang zǒngshì guà zhe lèguān cànlàn de wēixiào.', 'Bất luận đối mặt với khó khăn hóc búa đến nhường nào, trên gương mặt anh ấy lúc nào cũng nở nụ cười lạc quan rạng rỡ.', 'basic', 1),
      (v_id, '国际货币基金组织首席经济学家在发布会上表示，基于中国内需潜力的持续释放与高科技制造业的强劲韧性，对未来全球经济走势抱持审慎乐观预期。', 'Guójì Huòbì Jījīnzǔzhī shǒuxí jīngjìxuéjiā zài fābùhuì shang biǎoshì, jīyú Zhōngguó nèixū qiánlì de chíxù shìfàng yǔ gāo kējì zhìzàoyè de qiángjìn rènxìng, duì wèilái quánqiú jīngjì zǒushì bàochí shěnshèn lèguān yùqī.', 'Chuyên gia kinh tế trưởng của Quỹ Tiền tệ Quốc tế tại buổi họp báo cho biết, dựa trên sự giải phóng liên tục tiềm năng nhu cầu nội địa của Trung Quốc và sức bền mạnh mẽ của ngành chế tạo công nghệ cao, họ giữ vững kỳ vọng lạc quan thận trọng về xu thế kinh tế toàn cầu tương lai.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2691] [乐趣] (lèqù) - niềm vui, sự thú vị, lạc thú [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '乐趣' AND pinyin = 'lèqù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乐趣' AND pinyin = 'lèqù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '乐趣'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乐趣'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lèqù',
      meaning_vi = 'niềm vui, sự thú vị, lạc thú',
      example_hanzi = '在阳光明媚的午后静下心来读一本好书，能让人体验到无穷的乐趣。',
      example_pinyin = 'Zài yángguāng míngmèi de wǔhòu jìng xià xīn lai dú yì běn hǎo shū, néng ràng rén tǐyàn dào wúqióng de lèqù.',
      example_vi = 'Lắng lòng đọc một cuốn sách hay vào buổi chiều ngập tràn ánh nắng ấm áp có thể giúp con người trải nghiệm niềm vui thú vô tận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '乐趣',
      'lèqù',
      'niềm vui, sự thú vị, lạc thú',
      'Danh từ',
      'HSK 5',
      '在阳光明媚的午后静下心来读一本好书，能让人体验到无穷的乐趣。',
      'Zài yángguāng míngmèi de wǔhòu jìng xià xīn lai dú yì běn hǎo shū, néng ràng rén tǐyàn dào wúqióng de lèqù.',
      'Lắng lòng đọc một cuốn sách hay vào buổi chiều ngập tràn ánh nắng ấm áp có thể giúp con người trải nghiệm niềm vui thú vô tận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在阳光明媚的午后静下心来读一本好书，能让人体验到无穷的乐趣。', 'Zài yángguāng míngmèi de wǔhòu jìng xià xīn lai dú yì běn hǎo shū, néng ràng rén tǐyàn dào wúqióng de lèqù.', 'Lắng lòng đọc một cuốn sách hay vào buổi chiều ngập tràn ánh nắng ấm áp có thể giúp con người trải nghiệm niềm vui thú vô tận.', 'basic', 1),
      (v_id, '大科学家往往能从枯燥繁琐的代码调试与海量抽象的公式推导中，敏锐捕捉到洞悉宇宙自然运行奥秘的崇高智力乐趣。', 'Dà kēxuéjiā wǎngwǎng néng cóng kūzào fánsuǒ de dàimǎ tiáoshì yǔ hǎiliàng chōuxiàng de gōngshì tuīdǎo zhōng, mǐnruì bǔzhuō dào dòngxī yǔzhòu zìrán yùnxíng àomì de chónggāo zhìlì lèqù.', 'Các nhà khoa học vĩ đại thường có thể từ những dòng gỡ lỗi lập trình khô khan tẻ nhạt và phép suy diễn công thức trừu tượng khổng lồ, nhạy bén bắt trọn niềm vui trí tuệ cao quý khi thấu suốt bí ẩn vận hành của tự nhiên vũ trụ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2692] [泪] (lèi) - nước mắt, giọt lệ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '泪' AND pinyin = 'lèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '泪' AND pinyin = 'lèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '泪'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '泪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lèi',
      meaning_vi = 'nước mắt, giọt lệ',
      example_hanzi = '听到远方亲人平安归来的喜讯，母亲忍不住流下了激动的热泪。',
      example_pinyin = 'Tīngdào yuǎnfāng qīnrén píng’ān guīlái de xǐxùn, mǔqīn rěnbuzhù liúxià le jīdòng de rèlèi.',
      example_vi = 'Nghe được tin vui người thân nơi phương xa bình an trở về, người mẹ không kìm được đã rơi những giọt nước mắt nghẹn ngào xúc động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '泪',
      'lèi',
      'nước mắt, giọt lệ',
      'Danh từ',
      'HSK 5',
      '听到远方亲人平安归来的喜讯，母亲忍不住流下了激动的热泪。',
      'Tīngdào yuǎnfāng qīnrén píng’ān guīlái de xǐxùn, mǔqīn rěnbuzhù liúxià le jīdòng de rèlèi.',
      'Nghe được tin vui người thân nơi phương xa bình an trở về, người mẹ không kìm được đã rơi những giọt nước mắt nghẹn ngào xúc động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听到远方亲人平安归来的喜讯，母亲忍不住流下了激动的热泪。', 'Tīngdào yuǎnfāng qīnrén píng’ān guīlái de xǐxùn, mǔqīn rěnbuzhù liúxià le jīdòng de rèlèi.', 'Nghe được tin vui người thân nơi phương xa bình an trở về, người mẹ không kìm được đã rơi những giọt nước mắt nghẹn ngào xúc động.', 'basic', 1),
      (v_id, '这部展现志愿军战士在冰天雪地中浴血保家卫国的战争电影催人泪下，每一个观众的眼眶里都饱含着对英烈的崇高敬意之泪。', 'Zhè bù zhǎnxiàn zhìyuànjūn zhànshì zài bīngtiān-xuědì zhōng yùxiě bǎojiā-wèiguó de zhànzhēng diànyǐng cuīrén-lèixià, měi yí gè guānzhòng de yǎnkuàng lǐ dōu bǎohán zhe duì yīngliè de chónggāo jìngyì zhī lèi.', 'Bộ phim chiến tranh tái hiện những người lính quân tình nguyện đổ máu bảo vệ quê hương giữa trời băng tuyết rơi đã lấy đi bao giọt nước mắt, khóe mắt của từng khán giả đều đong đầy những giọt lệ thành kính tri ân các bậc anh hùng liệt sĩ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2693] [类] (lèi) - loài, loại, thể loại, dạng [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '类' AND pinyin = 'lèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '类' AND pinyin = 'lèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '类'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '类'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'lèi',
      meaning_vi = 'loài, loại, thể loại, dạng',
      example_hanzi = '超市的货架上将食品、日用品和文具等不同类别的商品划分得非常清晰。',
      example_pinyin = 'Chāoshì de huòjià shang jiāng shípǐn, rìyòngpǐn hé wénjù děng bùtóng lèibié de shāngpǐn huàfēn de fēicháng qīngxī.',
      example_vi = 'Trên các kệ hàng siêu thị phân chia rành mạch các chủng loại sản phẩm khác nhau như thực phẩm, đồ dùng sinh hoạt và văn phòng phẩm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '类',
      'lèi',
      'loài, loại, thể loại, dạng',
      'Danh từ / Lượng từ',
      'HSK 5',
      '超市的货架上将食品、日用品和文具等不同类别的商品划分得非常清晰。',
      'Chāoshì de huòjià shang jiāng shípǐn, rìyòngpǐn hé wénjù děng bùtóng lèibié de shāngpǐn huàfēn de fēicháng qīngxī.',
      'Trên các kệ hàng siêu thị phân chia rành mạch các chủng loại sản phẩm khác nhau như thực phẩm, đồ dùng sinh hoạt và văn phòng phẩm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '超市的货架上将食品、日用品和文具等不同类别的商品划分得非常清晰。', 'Chāoshì de huòjià shang jiāng shípǐn, rìyòngpǐn hé wénjù děng bùtóng lèibié de shāngpǐn huàfēn de fēicháng qīngxī.', 'Trên các kệ hàng siêu thị phân chia rành mạch các chủng loại sản phẩm khác nhau như thực phẩm, đồ dùng sinh hoạt và văn phòng phẩm.', 'basic', 1),
      (v_id, '在大数据时代，机器学习聚类算法能够根据用户的消费行为特征，将海量客户精准划分至不同的细分消费群体类别中。', 'Zài dàshùjù shídài, jīqì xuéxí jùlèi suànfǎ nénggòu gēnjù yònghù de xiāofèi xíngwéi tèzhēng, jiāng hǎiliàng kèhù jīngzhǔn huàfēn zhì bùtóng de xìfēn xiāofèi qúntǐ lèibié zhōng.', 'Trong kỷ nguyên dữ liệu lớn, các thuật toán phân cụm học máy có thể căn cứ vào đặc trưng hành vi tiêu dùng của người dùng để phân loại chuẩn xác lượng lớn khách hàng vào từng nhóm đối tượng người tiêu dùng ngách khác nhau.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2694] [泪水] (lèishuǐ) - nước mắt, giọt nước mắt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '泪水' AND pinyin = 'lèishuǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '泪水' AND pinyin = 'lèishuǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '泪水'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '泪水'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lèishuǐ',
      meaning_vi = 'nước mắt, giọt nước mắt',
      example_hanzi = '在毕业典礼上，大家互相拥抱道别，眼中闪烁着依依不舍的泪水。',
      example_pinyin = 'Zài bìyè diǎnlǐ shang, dàjiā hùxiāng yōngbào dàobié, yǎnzhōng shǎnshuò zhe yīyī-bùshě de lèishuǐ.',
      example_vi = 'Trong buổi lễ tốt nghiệp, mọi người ôm nhau tạm biệt, trong ánh mắt ai nấy đều lấp lánh những giọt nước mắt lưu luyến bịn rịn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '泪水',
      'lèishuǐ',
      'nước mắt, giọt nước mắt',
      'Danh từ',
      'HSK 5',
      '在毕业典礼上，大家互相拥抱道别，眼中闪烁着依依不舍的泪水。',
      'Zài bìyè diǎnlǐ shang, dàjiā hùxiāng yōngbào dàobié, yǎnzhōng shǎnshuò zhe yīyī-bùshě de lèishuǐ.',
      'Trong buổi lễ tốt nghiệp, mọi người ôm nhau tạm biệt, trong ánh mắt ai nấy đều lấp lánh những giọt nước mắt lưu luyến bịn rịn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在毕业典礼上，大家互相拥抱道别，眼中闪烁着依依不舍的泪水。', 'Zài bìyè diǎnlǐ shang, dàjiā hùxiāng yōngbào dàobié, yǎnzhōng shǎnshuò zhe yīyī-bùshě de lèishuǐ.', 'Trong buổi lễ tốt nghiệp, mọi người ôm nhau tạm biệt, trong ánh mắt ai nấy đều lấp lánh những giọt nước mắt lưu luyến bịn rịn.', 'basic', 1),
      (v_id, '夺冠那一刻，老将回想起多年来经受严重伤病困扰所付出的无数汗水与辛酸泪水，终于在领奖台上绽放出了欣慰的笑容。', 'Duóguàn nà yí kè, lǎojiàng huíxiǎng qǐ duō nián lái jīngshòu yánzhòng shāngbìng kùnrǎo suǒ fùchū de wúshù hànshuǐ yǔ xīnsuān lèishuǐ, zhōngyú zài lǐngjiǎngtái shang zhànfàng chū le xīnwèi de xiàoróng.', 'Khoảnh khắc đăng quang, người vận động viên kỳ cựu nhớ lại biết bao mồ hôi và những giọt nước mắt cay đắng đã bỏ ra suốt bao năm dài chịu đựng chấn thương hành hạ, cuối cùng đã nở nụ cười mãn nguyện trên bục nhận huy chương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2695] [类似] (lèisì) - tương tự, giống như, na ná [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '类似' AND pinyin = 'lèisì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '类似' AND pinyin = 'lèisì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '类似'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '类似'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'lèisì',
      meaning_vi = 'tương tự, giống như, na ná',
      example_hanzi = '这两款手机在外观设计上非常类似，但在内部硬件配置上差别很大。',
      example_pinyin = 'Zhè liǎng kuǎn shǒujī zài wàiguān shèjì shang fēicháng lèisì, dàn zài nèibù yìngjiàn pèizhì shang chābié hěn dà.',
      example_vi = 'Hai mẫu điện thoại này về thiết kế kiểu dáng bề ngoài rất tương tự nhau, nhưng về cấu hình phần cứng bên trong lại khác biệt rất lớn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '类似',
      'lèisì',
      'tương tự, giống như, na ná',
      'Tính từ / Động từ',
      'HSK 5',
      '这两款手机在外观设计上非常类似，但在内部硬件配置上差别很大。',
      'Zhè liǎng kuǎn shǒujī zài wàiguān shèjì shang fēicháng lèisì, dàn zài nèibù yìngjiàn pèizhì shang chābié hěn dà.',
      'Hai mẫu điện thoại này về thiết kế kiểu dáng bề ngoài rất tương tự nhau, nhưng về cấu hình phần cứng bên trong lại khác biệt rất lớn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这两款手机在外观设计上非常类似，但在内部硬件配置上差别很大。', 'Zhè liǎng kuǎn shǒujī zài wàiguān shèjì shang fēicháng lèisì, dàn zài nèibù yìngjiàn pèizhì shang chābié hěn dà.', 'Hai mẫu điện thoại này về thiết kế kiểu dáng bề ngoài rất tương tự nhau, nhưng về cấu hình phần cứng bên trong lại khác biệt rất lớn.', 'basic', 1),
      (v_id, '为防范类似硅谷银行倒闭所引发的流动性挤兑风险再次发生，全球主要央行纷纷强化了对商业银行资产负债表久期错配的压力测试监管。', 'Wèi fángfàn lèisì Guīgǔ Yínháng dǎobì suǒ yǐnfā de liúdòngxìng jǐduì fēngxiǎn zàicì fāshēng, quánqiú zhǔyào yāngháng fēnfēn qiánghuà le duì shāngyè yínháng zīchǎn-fùzhàibiǎo jiǔqī cuòpèi de yālì cèshì jiānguǎn.', 'Nhằm phòng ngừa những rủi ro tháo chạy thanh khoản tương tự như vụ sụp đổ của Ngân hàng Thung lũng Silicon tái diễn, các ngân hàng trung ương lớn trên toàn cầu đã đồng loạt siết chặt giám sát kiểm tra sức chịu tải đối với sự lệch pha kỳ hạn trên bảng cân đối kế toán của các ngân hàng thương mại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2696] [类型] (lèixíng) - kiểu loại, mô hình, hình mẫu, thể loại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '类型' AND pinyin = 'lèixíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '类型' AND pinyin = 'lèixíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '类型'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '类型'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lèixíng',
      meaning_vi = 'kiểu loại, mô hình, hình mẫu, thể loại',
      example_hanzi = '在图书馆借书时，他偏爱科幻与悬疑推理这两种类型的长篇小说。',
      example_pinyin = 'Zài túshūguǎn jiè shū shí, tā piān’ài kēhuàn yǔ xuányí tuīlǐ zhè liǎng zhǒng lèixíng de chángpiān xiǎoshuō.',
      example_vi = 'Khi mượn sách ở thư viện, cậu ấy đặc biệt thích hai thể loại tiểu thuyết dài kỳ là khoa học viễn tưởng và trinh thám ly kỳ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '类型',
      'lèixíng',
      'kiểu loại, mô hình, hình mẫu, thể loại',
      'Danh từ',
      'HSK 5',
      '在图书馆借书时，他偏爱科幻与悬疑推理这两种类型的长篇小说。',
      'Zài túshūguǎn jiè shū shí, tā piān’ài kēhuàn yǔ xuányí tuīlǐ zhè liǎng zhǒng lèixíng de chángpiān xiǎoshuō.',
      'Khi mượn sách ở thư viện, cậu ấy đặc biệt thích hai thể loại tiểu thuyết dài kỳ là khoa học viễn tưởng và trinh thám ly kỳ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在图书馆借书时，他偏爱科幻与悬疑推理这两种类型的长篇小说。', 'Zài túshūguǎn jiè shū shí, tā piān’ài kēhuàn yǔ xuányí tuīlǐ zhè liǎng zhǒng lèixíng de chángpiān xiǎoshuō.', 'Khi mượn sách ở thư viện, cậu ấy đặc biệt thích hai thể loại tiểu thuyết dài kỳ là khoa học viễn tưởng và trinh thám ly kỳ.', 'basic', 1),
      (v_id, '现代企业治理体系需要根据资本结构与行业周期的不同类型，因企制宜构建权责法定、运转高效且制衡有效的现代化董事会运作机制。', 'Xiàndài qǐyè zhìlǐ tǐxì xūyào gēnjù zīběn jiégòu yǔ hángyè zhōuqī de bùtóng lèixíng, yīnqǐ-zhìyí gòujiàn quánzé fǎdìng, yùnzhuǎn gāoxiào qiě zhìhéng yǒuxiào de xiàndàihuà dǒngshìhuì yùnzuò jīzhì.', 'Hệ thống quản trị doanh nghiệp hiện đại đòi hỏi phải căn cứ vào các loại hình cơ cấu vốn và chu kỳ ngành nghề khác nhau, linh hoạt áp dụng theo từng doanh nghiệp để xây dựng cơ chế vận hành hội đồng quản trị hiện đại có thẩm quyền và trách nhiệm pháp định, vận hành hiệu quả cao và kiểm soát kiềm chế lẫn nhau hiệu lực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2697] [梨] (lí) - quả lê, cây lê [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '梨' AND pinyin = 'lí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '梨' AND pinyin = 'lí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '梨'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '梨'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lí',
      meaning_vi = 'quả lê, cây lê',
      example_hanzi = '秋燥季节里，炖一碗冰糖雪梨汤具有很好的润肺止咳功效。',
      example_pinyin = 'Qiūzào jìjié lǐ, dùn yì wǎn bīngtáng xuělítāng jùyǒu hěn hǎo de rùnfèi zhǐké gōngxiào.',
      example_vi = 'Trong mùa hanh khô mùa thu, chưng một bát canh lê đường phèn có công hiệu bổ phổi giảm ho rất tốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '梨',
      'lí',
      'quả lê, cây lê',
      'Danh từ',
      'HSK 5',
      '秋燥季节里，炖一碗冰糖雪梨汤具有很好的润肺止咳功效。',
      'Qiūzào jìjié lǐ, dùn yì wǎn bīngtáng xuělítāng jùyǒu hěn hǎo de rùnfèi zhǐké gōngxiào.',
      'Trong mùa hanh khô mùa thu, chưng một bát canh lê đường phèn có công hiệu bổ phổi giảm ho rất tốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '秋燥季节里，炖一碗冰糖雪梨汤具有很好的润肺止咳功效。', 'Qiūzào jìjié lǐ, dùn yì wǎn bīngtáng xuělítāng jùyǒu hěn hǎo de rùnfèi zhǐké gōngxiào.', 'Trong mùa hanh khô mùa thu, chưng một bát canh lê đường phèn có công hiệu bổ phổi giảm ho rất tốt.', 'basic', 1),
      (v_id, '国家级特色果树良种繁育基地通过精准杂交与分子标记辅助育种，培育出了皮薄汁丰、耐储运的特级优质玉露香梨新品种。', 'Guójiājí tèsè guǒshù liángzhǒng fányù jīdì tōngguò jīngzhǔn zájiāo yǔ fēnzǐ biāojì fǔzhù yùzhǒng, péiyù chū le pí báo zhī fēng, nài chǔyùn de tèjí yōuzhì Yùlù Xiānglí xīn pǐnzhǒng.', 'Cơ sở chọn tạo giống cây ăn quả đặc sản cấp quốc gia thông qua phương pháp lai chính xác và nhân giống hỗ trợ chỉ thị phân tử, đã lai tạo ra giống lê thơm Ngọc Lộ thượng hạng mới mỏng vỏ mọng nước và chịu được bảo quản vận chuyển.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2698] [离婚] (líhūn) - ly hôn, ly dị [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '离婚' AND pinyin = 'líhūn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '离婚' AND pinyin = 'líhūn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '离婚'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '离婚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'líhūn',
      meaning_vi = 'ly hôn, ly dị',
      example_hanzi = '夫妻双方如果感情确已破裂，可以通过法律程序协商申请协议离婚。',
      example_pinyin = 'Fūqī shuāngfāng rúguǒ gǎnqíng què yǐ pòliè, kěyǐ tōngguò fǎlǜ chéngxù xiéshāng shēnqǐng xiéyì líhūn.',
      example_vi = 'Hai bên vợ chồng nếu tình cảm thực sự đã rạn nứt, có thể thông qua trình tự pháp lý để thương lượng nộp đơn thuận tình ly hôn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '离婚',
      'líhūn',
      'ly hôn, ly dị',
      'Động từ',
      'HSK 5',
      '夫妻双方如果感情确已破裂，可以通过法律程序协商申请协议离婚。',
      'Fūqī shuāngfāng rúguǒ gǎnqíng què yǐ pòliè, kěyǐ tōngguò fǎlǜ chéngxù xiéshāng shēnqǐng xiéyì líhūn.',
      'Hai bên vợ chồng nếu tình cảm thực sự đã rạn nứt, có thể thông qua trình tự pháp lý để thương lượng nộp đơn thuận tình ly hôn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夫妻双方如果感情确已破裂，可以通过法律程序协商申请协议离婚。', 'Fūqī shuāngfāng rúguǒ gǎnqíng què yǐ pòliè, kěyǐ tōngguò fǎlǜ chéngxù xiéshāng shēnqǐng xiéyì líhūn.', 'Hai bên vợ chồng nếu tình cảm thực sự đã rạn nứt, có thể thông qua trình tự pháp lý để thương lượng nộp đơn thuận tình ly hôn.', 'basic', 1),
      (v_id, '我国《民法典》婚姻家庭编确立了三十天“离婚冷静期”制度，旨在引导夫妻双方理性对待婚姻家庭矛盾，切实减少冲动型离婚现象。', 'Wǒ guó 《Mínfǎdiǎn》 hūnyīn jiātíng biān quèlì le sānshí tiān “líhūn lěngjìngqī” zhìdù, zhǐzài yǐndǎo fūqī shuāngfāng lǐxìng duìdài hūnyīn jiātíng máodùn, qièshí jiǎnshǎo chōngdòngxíng líhūn xiànxiàng.', 'Phần Hôn nhân và Gia đình trong "Bộ luật Dân sự" nước ta đã xác lập chế định "thời hạn cân nhắc ly hôn" kéo dài 30 ngày, nhằm dẫn dắt hai vợ chồng nhìn nhận lý trí các mâu thuẫn gia đình hôn nhân, giảm bớt thiết thực hiện tượng ly hôn do bốc đồng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2699] [厘米] (límǐ) - xăng-ti-mét (cm) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '厘米' AND pinyin = 'límǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '厘米' AND pinyin = 'límǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '厘米'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '厘米'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ',
      pinyin = 'límǐ',
      meaning_vi = 'xăng-ti-mét (cm)',
      example_hanzi = '这本精装字典的长约二十厘米，宽约十五厘米，便于随身携带查阅。',
      example_pinyin = 'Zhè běn jīngzhuāng zìdiǎn de cháng yuē èrshí límǐ, kuān yuē shíwǔ límǐ, biànyú suíshēn xiédài cháyuè.',
      example_vi = 'Cuốn từ điển bìa cứng này dài khoảng 20 cm, rộng khoảng 15 cm, tiện mang theo bên mình để tra cứu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '厘米',
      'límǐ',
      'xăng-ti-mét (cm)',
      'Lượng từ',
      'HSK 5',
      '这本精装字典的长约二十厘米，宽约十五厘米，便于随身携带查阅。',
      'Zhè běn jīngzhuāng zìdiǎn de cháng yuē èrshí límǐ, kuān yuē shíwǔ límǐ, biànyú suíshēn xiédài cháyuè.',
      'Cuốn từ điển bìa cứng này dài khoảng 20 cm, rộng khoảng 15 cm, tiện mang theo bên mình để tra cứu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这本精装字典的长约二十厘米，宽约十五厘米，便于随身携带查阅。', 'Zhè běn jīngzhuāng zìdiǎn de cháng yuē èrshí límǐ, kuān yuē shíwǔ límǐ, biànyú suíshēn xiédài cháyuè.', 'Cuốn từ điển bìa cứng này dài khoảng 20 cm, rộng khoảng 15 cm, tiện mang theo bên mình để tra cứu.', 'basic', 1),
      (v_id, '在现代高精密度北斗地基增强系统定位服务中，其动态差分定位精度已可达到厘米级甚至毫米级，为高级自动驾驶提供了高可靠时空基准。', 'Zài xiàndài gāo jīngmìdù Běidǒu dìjī zēngqiáng xìtǒng dìngwèi fúwù zhōng, qí dòngtài chāfēn dìngwèi jīngdù yǐ kě dádào límǐ jí shènzhì háomǐ jí, wèi gāojí zìdòng jiàshǐ tígōng le gāo kěkào shíkōng jīzhǔn.', 'Trong dịch vụ định vị hệ thống tăng cường trên mặt đất Bắc Đẩu độ chính xác cao hiện đại, độ chuẩn xác định vị vi sai động học của nó đã có thể đạt tới cấp xăng-ti-mét thậm chí là milimet, mang lại mốc chuẩn không gian - thời gian có độ tin cậy cao cho việc tự lái xe cấp cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2700] [离职] (lízhí) - thôi việc, nghỉ việc, rời vị trí công tác [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '离职' AND pinyin = 'lízhí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '离职' AND pinyin = 'lízhí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '离职'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '离职'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'lízhí',
      meaning_vi = 'thôi việc, nghỉ việc, rời vị trí công tác',
      example_hanzi = '员工在正式离职前，应当依照劳动合同约定提前一个月提交书面辞职信。',
      example_pinyin = 'Yuángōng zài zhèngshì lízhí qián, yīngdāng yīzhào láodòng hétong yuēdìng tíqián yí gè yuè tíjiāo shūmiàn cízhíxìn.',
      example_vi = 'Nhân viên trước khi chính thức thôi việc nên nộp đơn xin từ chức bằng văn bản trước một tháng theo đúng thỏa thuận hợp đồng lao động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '离职',
      'lízhí',
      'thôi việc, nghỉ việc, rời vị trí công tác',
      'Động từ',
      'HSK 5',
      '员工在正式离职前，应当依照劳动合同约定提前一个月提交书面辞职信。',
      'Yuángōng zài zhèngshì lízhí qián, yīngdāng yīzhào láodòng hétong yuēdìng tíqián yí gè yuè tíjiāo shūmiàn cízhíxìn.',
      'Nhân viên trước khi chính thức thôi việc nên nộp đơn xin từ chức bằng văn bản trước một tháng theo đúng thỏa thuận hợp đồng lao động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '员工在正式离职前，应当依照劳动合同约定提前一个月提交书面辞职信。', 'Yuángōng zài zhèngshì lízhí qián, yīngdāng yīzhào láodòng hétong yuēdìng tíqián yí gè yuè tíjiāo shūmiàn cízhíxìn.', 'Nhân viên trước khi chính thức thôi việc nên nộp đơn xin từ chức bằng văn bản trước một tháng theo đúng thỏa thuận hợp đồng lao động.', 'basic', 1),
      (v_id, '根据国家反不正当竞争法与劳动合同法规定，掌握企业商业机密的高管在离职后必须严格履行约定的竞业限制义务。', 'Gēnjù guójiā fǎn bùzhèngdàng jìngzhēng fǎ yǔ láodòng hétong fǎ guīdìng, zhǎngwò qǐyè shāngyè jīmì de gāoguǎn zài lízhí hòu bìxū yángé lǚxíng yuēdìng de jìngyè xiànzhì yìwù.', 'Theo quy định của Luật Chống cạnh tranh không lành mạnh và Luật Hợp đồng lao động quốc gia, các cán bộ quản lý cấp cao nắm giữ bí mật thương mại của doanh nghiệp sau khi nghỉ việc bắt buộc phải thực hiện nghiêm túc nghĩa vụ hạn chế cạnh tranh đã thỏa thuận.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2701] [理论] (lǐlùn) - lý luận, lý thuyết; phân bua, tranh cãi lý lẽ [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '理论' AND pinyin = 'lǐlùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '理论' AND pinyin = 'lǐlùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '理论'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '理论'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'lǐlùn',
      meaning_vi = 'lý luận, lý thuyết; phân bua, tranh cãi lý lẽ',
      example_hanzi = '我们不仅要学好书本上的专业理论，更要注重在实践中灵活运用。',
      example_pinyin = 'Wǒmen bùjǐn yào xuéhǎo shūběn shang de zhuānyè lǐlùn, gèng yào zhùzhòng zài shíjiàn zhōng línghuó yùnyòng.',
      example_vi = 'Chúng ta không chỉ phải học giỏi lý thuyết chuyên môn trên sách vở, mà càng phải coi trọng việc vận dụng linh hoạt trong thực tiễn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '理论',
      'lǐlùn',
      'lý luận, lý thuyết; phân bua, tranh cãi lý lẽ',
      'Danh từ / Động từ',
      'HSK 5',
      '我们不仅要学好书本上的专业理论，更要注重在实践中灵活运用。',
      'Wǒmen bùjǐn yào xuéhǎo shūběn shang de zhuānyè lǐlùn, gèng yào zhùzhòng zài shíjiàn zhōng línghuó yùnyòng.',
      'Chúng ta không chỉ phải học giỏi lý thuyết chuyên môn trên sách vở, mà càng phải coi trọng việc vận dụng linh hoạt trong thực tiễn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们不仅要学好书本上的专业理论，更要注重在实践中灵活运用。', 'Wǒmen bùjǐn yào xuéhǎo shūběn shang de zhuānyè lǐlùn, gèng yào zhùzhòng zài shíjiàn zhōng línghuó yùnyòng.', 'Chúng ta không chỉ phải học giỏi lý thuyết chuyên môn trên sách vở, mà càng phải coi trọng việc vận dụng linh hoạt trong thực tiễn.', 'basic', 1),
      (v_id, '当代马克思主义中国化时代化的重大理论创新成果，深刻回答了新时代坚持和发展中国特色社会主义的一系列重大时代课题。', 'Dāngdài Mǎkèsī-zhǔyì Zhōngguóhuà shídàihuà de zhòngdà lǐlùn chuàngxīn chéngguǒ, shēnkè huídá le xīn shídài jiānchí hé fāzhǎn Zhōngguó tèsè shèhuì zhǔyì de yí xìliè zhòngdà shídài kètí.', 'Thành quả đổi mới sáng tạo lý luận trọng đại về Trung Quốc hóa và hiện đại hóa chủ nghĩa Mác đương đại đã giải đáp sâu sắc một loạt các vấn đề thời đại lớn về việc kiên trì và phát triển chủ nghĩa xã hội mang đặc sắc Trung Quốc trong thời đại mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp Batch 7 HSK 5: % từ vựng đã được chuẩn hóa và thêm 200 câu ví dụ.', v_count;
END $$;
