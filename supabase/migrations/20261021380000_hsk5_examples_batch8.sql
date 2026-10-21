-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 8 (100 TỪ TIẾP THEO)
-- Phạm vi: #2702 [里头] (lǐtou) -> #2801 [念] (niàn)
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
  -- [2702] [里头] (lǐtou) - bên trong, phía trong [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '里头' AND pinyin = 'lǐtou'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '里头' AND pinyin = 'lǐtou'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '里头'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '里头'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǐtou',
      meaning_vi = 'bên trong, phía trong',
      example_hanzi = '打开这个木盒子，里头整整齐齐地放着一套精美的茶具。',
      example_pinyin = 'Dǎkāi zhè gè mù hézi, lǐtou zhěngzhěng-qíqí de fàng zhe yí tào jīngměi de chájù.',
      example_vi = 'Mở chiếc hộp gỗ này ra, bên trong đặt ngay ngắn một bộ ấm chén pha trà tinh xảo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '里头',
      'lǐtou',
      'bên trong, phía trong',
      'Danh từ',
      'HSK 5',
      '打开这个木盒子，里头整整齐齐地放着一套精美的茶具。',
      'Dǎkāi zhè gè mù hézi, lǐtou zhěngzhěng-qíqí de fàng zhe yí tào jīngměi de chájù.',
      'Mở chiếc hộp gỗ này ra, bên trong đặt ngay ngắn một bộ ấm chén pha trà tinh xảo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '打开这个木盒子，里头整整齐齐地放着一套精美的茶具。', 'Dǎkāi zhè gè mù hézi, lǐtou zhěngzhěng-qíqí de fàng zhe yí tào jīngměi de chájù.', 'Mở chiếc hộp gỗ này ra, bên trong đặt ngay ngắn một bộ ấm chén pha trà tinh xảo.', 'basic', 1),
      (v_id, '这项看似寻常的产业技术改造工程，其实里头大有学问，涉及材料力学与高精度流体力学的深度融合。', 'Zhè xiàng kànsì xúncháng de chǎnyè jìshù gǎizào gōngchéng, qíshí lǐtou dàyǒu-xuéwen, shèjí cáiliào lìxué yǔ gāo jīngdù liútǐ lìxué de shēndù rónghé.', 'Công trình cải tạo kỹ thuật công nghiệp thoạt nhìn tưởng như bình thường này, thực ra bên trong ẩn chứa rất nhiều tri thức sâu xa, liên quan đến sự kết hợp sâu rộng giữa cơ học vật liệu và cơ học chất lưu độ chính xác cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2703] [理由] (lǐyóu) - lý do, nguyên cớ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '理由' AND pinyin = 'lǐyóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '理由' AND pinyin = 'lǐyóu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '理由'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '理由'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǐyóu',
      meaning_vi = 'lý do, nguyên cớ',
      example_hanzi = '他因突发高烧不能参加期末考试，并向教务处提交了医院的请假理由证明。',
      example_pinyin = 'Tā yīn tūfā gāoshāo bùnéng cānjiā qīmò kǎoshì, bìng xiàng jiàowùchù tíjiāo le yīyuàn de qǐngjià lǐyóu zhèngmíng.',
      example_vi = 'Anh ấy do đột ngột sốt cao không thể tham gia thi cuối kỳ, và đã nộp giấy chứng nhận lý do xin nghỉ phép của bệnh viện cho phòng đào tạo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '理由',
      'lǐyóu',
      'lý do, nguyên cớ',
      'Danh từ',
      'HSK 5',
      '他因突发高烧不能参加期末考试，并向教务处提交了医院的请假理由证明。',
      'Tā yīn tūfā gāoshāo bùnéng cānjiā qīmò kǎoshì, bìng xiàng jiàowùchù tíjiāo le yīyuàn de qǐngjià lǐyóu zhèngmíng.',
      'Anh ấy do đột ngột sốt cao không thể tham gia thi cuối kỳ, và đã nộp giấy chứng nhận lý do xin nghỉ phép của bệnh viện cho phòng đào tạo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他因突发高烧不能参加期末考试，并向教务处提交了医院的请假理由证明。', 'Tā yīn tūfā gāoshāo bùnéng cānjiā qīmò kǎoshì, bìng xiàng jiàowùchù tíjiāo le yīyuàn de qǐngjià lǐyóu zhèngmíng.', 'Anh ấy do đột ngột sốt cao không thể tham gia thi cuối kỳ, và đã nộp giấy chứng nhận lý do xin nghỉ phép của bệnh viện cho phòng đào tạo.', 'basic', 1),
      (v_id, '司法裁判文书必须全面阐述法官采纳或排除各项核心证据的法理理由，以确保司法审判的透明度与公信力。', 'Sīfǎ cáipàn wénshū bìxū quánmiàn chǎnshù fǎguān cǎinà huò páichú gè xiàng héxīn zhèngjù de fǎlǐ lǐyóu, yǐ quèbǎo sīfǎ shěnpàn de tòumíngdù yǔ gōngxìnlì.', 'Văn bản phán quyết tư pháp phải trình bày toàn diện lý lẽ pháp lý của thẩm phán khi chấp nhận hoặc loại bỏ các chứng cứ cốt lõi, nhằm bảo đảm tính minh bạch và uy tín công quyền của xét xử tư pháp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2704] [力] (lì) - sức, lực, sức lực, năng lực [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '力' AND pinyin = 'lì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '力' AND pinyin = 'lì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lì',
      meaning_vi = 'sức, lực, sức lực, năng lực',
      example_hanzi = '搬运重物时要注意用力均匀，以免拉伤腰部肌肉。',
      example_pinyin = 'Bānyùn zhòngwù shí yào zhùyì yòng lì jūnyún, yǐmiǎn lāshāng yāobù jīròu.',
      example_vi = 'Khi bốc vác đồ vật nặng cần chú ý dùng lực đều đặn để tránh làm căng rách cơ lưng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '力',
      'lì',
      'sức, lực, sức lực, năng lực',
      'Danh từ',
      'HSK 5',
      '搬运重物时要注意用力均匀，以免拉伤腰部肌肉。',
      'Bānyùn zhòngwù shí yào zhùyì yòng lì jūnyún, yǐmiǎn lāshāng yāobù jīròu.',
      'Khi bốc vác đồ vật nặng cần chú ý dùng lực đều đặn để tránh làm căng rách cơ lưng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '搬运重物时要注意用力均匀，以免拉伤腰部肌肉。', 'Bānyùn zhòngwù shí yào zhùyì yòng lì jūnyún, yǐmiǎn lāshāng yāobù jīròu.', 'Khi bốc vác đồ vật nặng cần chú ý dùng lực đều đặn để tránh làm căng rách cơ lưng.', 'basic', 1),
      (v_id, '在激烈的全球高科技产业竞争中，企业唯有全面提升自主创新力、品牌竞争力和国际抗风险力，方能立于不败之地。', 'Zài jīliè de quánqiú gāo kējì chǎnyè jìngzhēng zhōng, qǐyè wéiyǒu quánmiàn tíshēng zìzhǔ chuàngxīnlì, pǐnpái jìngzhēnglì hé guójì kàng fēngxiǎnlì, fāng néng lìyú búbàizhīdì.', 'Trong cuộc cạnh tranh công nghiệp công nghệ cao khốc liệt toàn cầu, doanh nghiệp chỉ có nâng cao toàn diện năng lực đổi mới tự chủ, sức cạnh tranh thương hiệu và khả năng kháng cự rủi ro quốc tế thì mới có thể đứng vững ở vị thế bất bại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2705] [立即] (lìjí) - ngay lập tức, tức khắc [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '立即' AND pinyin = 'lìjí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '立即' AND pinyin = 'lìjí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '立即'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '立即'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'lìjí',
      meaning_vi = 'ngay lập tức, tức khắc',
      example_hanzi = '接到火灾报警电话后，消防队员们立即穿好防护服奔赴事故现场。',
      example_pinyin = 'Jiēdào huǒzāi bàojǐng diànhuà hòu, xiāofáng duìyuánmen lìjí chuān hǎo fánghùfú bēnfù shìgù xiànchǎng.',
      example_vi = 'Sau khi nhận được điện thoại báo cháy, các chiến sĩ cứu hỏa ngay lập tức mặc trang phục bảo hộ và lao tới hiện trường vụ việc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '立即',
      'lìjí',
      'ngay lập tức, tức khắc',
      'Phó từ',
      'HSK 5',
      '接到火灾报警电话后，消防队员们立即穿好防护服奔赴事故现场。',
      'Jiēdào huǒzāi bàojǐng diànhuà hòu, xiāofáng duìyuánmen lìjí chuān hǎo fánghùfú bēnfù shìgù xiànchǎng.',
      'Sau khi nhận được điện thoại báo cháy, các chiến sĩ cứu hỏa ngay lập tức mặc trang phục bảo hộ và lao tới hiện trường vụ việc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '接到火灾报警电话后，消防队员们立即穿好防护服奔赴事故现场。', 'Jiēdào huǒzāi bàojǐng diànhuà hòu, xiāofáng duìyuánmen lìjí chuān hǎo fánghùfú bēnfù shìgù xiànchǎng.', 'Sau khi nhận được điện thoại báo cháy, các chiến sĩ cứu hỏa ngay lập tức mặc trang phục bảo hộ và lao tới hiện trường vụ việc.', 'basic', 1),
      (v_id, '面对突发的跨境金融网络黑客攻击，网络安全应急响应小组立即切断外网连接并实施全网防御阻断策略。', 'Miànduì tūfā de kuàjìng jīnróng wǎngluò hēikè gōngjī, wǎngluò ānquán yìngjí xiǎngyìng xiǎozǔ lìjí qiēduàn wàiwǎng liánjiē bìng shíshī quánwǎng fángyù zǔduàn cèlüè.', 'Đối mặt với cuộc tấn công mạng của tin tặc vào hệ thống tài chính xuyên biên giới nổ ra bất ngờ, tổ ứng cứu khẩn cấp an ninh mạng đã lập tức ngắt kết nối mạng ngoài và triển khai chiến lược phòng thủ chặn lọc toàn mạng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2706] [立刻] (lìkè) - tức khắc, ngay tức khắc, liền [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '立刻' AND pinyin = 'lìkè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '立刻' AND pinyin = 'lìkè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '立刻'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '立刻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'lìkè',
      meaning_vi = 'tức khắc, ngay tức khắc, liền',
      example_hanzi = '看到老人摔倒在马路上，几名热心路人立刻上前将他小心扶起。',
      example_pinyin = 'Kàndào lǎorén shuāidǎo zài mǎlù shang, jǐ míng rèxīn lùrén lìkè shàngqián jiāng tā xiǎoxīn fúqǐ.',
      example_vi = 'Nhìn thấy cụ già vấp ngã trên đường, vài người đi đường tốt bụng liền lập tức tiến tới cẩn thận đỡ cụ dậy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '立刻',
      'lìkè',
      'tức khắc, ngay tức khắc, liền',
      'Phó từ',
      'HSK 5',
      '看到老人摔倒在马路上，几名热心路人立刻上前将他小心扶起。',
      'Kàndào lǎorén shuāidǎo zài mǎlù shang, jǐ míng rèxīn lùrén lìkè shàngqián jiāng tā xiǎoxīn fúqǐ.',
      'Nhìn thấy cụ già vấp ngã trên đường, vài người đi đường tốt bụng liền lập tức tiến tới cẩn thận đỡ cụ dậy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '看到老人摔倒在马路上，几名热心路人立刻上前将他小心扶起。', 'Kàndào lǎorén shuāidǎo zài mǎlù shang, jǐ míng rèxīn lùrén lìkè shàngqián jiāng tā xiǎoxīn fúqǐ.', 'Nhìn thấy cụ già vấp ngã trên đường, vài người đi đường tốt bụng liền lập tức tiến tới cẩn thận đỡ cụ dậy.', 'basic', 1),
      (v_id, '在监测到地质滑坡预警信号的第一时间，现场指挥部立刻下达了全员撤离指令，成功避免了重大人员伤亡。', 'Zài jiāncè dào dìzhì huápō yùjǐng xìnhào de dì-yī shíjiān, xiànchǎng zhǐhuībù lìkè xiàdá le quányuán chèlí zhǐlìng, chénggōng bìmǐan le zhòngdà rényuán shāngwáng.', 'Ngay khoảnh khắc phát hiện tín hiệu cảnh báo sạt lở địa chất, ban chỉ huy hiện trường lập tức ban bố lệnh sơ tán toàn bộ lực lượng, ngăn chặn thành công thương vong nghiêm trọng về người.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2707] [力量] (lìliàng) - sức mạnh, lực lượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '力量' AND pinyin = 'lìliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '力量' AND pinyin = 'lìliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '力量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '力量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lìliàng',
      meaning_vi = 'sức mạnh, lực lượng',
      example_hanzi = '团结就是力量，只要全班同学齐心协力就一定能夺取比赛冠军。',
      example_pinyin = 'Tuánjié jiùshì lìliàng, zhǐyào quán bān tóngxué qíxīn-xiélì jiù yídìng néng duóqǔ bǐsài guànjūn.',
      example_vi = 'Đoàn kết chính là sức mạnh, chỉ cần cả lớp đồng lòng chung sức nhất định sẽ giành được cúp vô địch cuộc thi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '力量',
      'lìliàng',
      'sức mạnh, lực lượng',
      'Danh từ',
      'HSK 5',
      '团结就是力量，只要全班同学齐心协力就一定能夺取比赛冠军。',
      'Tuánjié jiùshì lìliàng, zhǐyào quán bān tóngxué qíxīn-xiélì jiù yídìng néng duóqǔ bǐsài guànjūn.',
      'Đoàn kết chính là sức mạnh, chỉ cần cả lớp đồng lòng chung sức nhất định sẽ giành được cúp vô địch cuộc thi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '团结就是力量，只要全班同学齐心协力就一定能夺取比赛冠军。', 'Tuánjié jiùshì lìliàng, zhǐyào quán bān tóngxué qíxīn-xiélì jiù yídìng néng duóqǔ bǐsài guànjūn.', 'Đoàn kết chính là sức mạnh, chỉ cần cả lớp đồng lòng chung sức nhất định sẽ giành được cúp vô địch cuộc thi.', 'basic', 1),
      (v_id, '在推进国家高水平科技自立自强的历史征程中，国家实验室与国家科研机构构成了核心战略科技力量。', 'Zài tuījìn guójiā gāo shuǐpíng kējì zìlì-zìqiáng de lìshǐ zhēngchéng zhōng, guójiā shíyànshì yǔ guójiā kēyán jīgòu gòuchéng le héxīn zhànlüè kējì lìliàng.', 'Trong hành trình lịch sử thúc đẩy khoa học công nghệ quốc gia tự lực tự cường trình độ cao, các phòng thí nghiệm quốc gia cùng viện nghiên cứu quốc gia tạo nên lực lượng khoa học công nghệ chiến lược cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2708] [利润] (lìrùn) - lợi nhuận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '利润' AND pinyin = 'lìrùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '利润' AND pinyin = 'lìrùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '利润'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '利润'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lìrùn',
      meaning_vi = 'lợi nhuận',
      example_hanzi = '这家服装店通过严格控制进货成本，去年实现了可观的利润。',
      example_pinyin = 'Zhè jiā fúzhuāngdiàn tōngguò yángé kòngzhì jìnhuò chéngběn, qùnián shíxiàn le kěguān de lìrùn.',
      example_vi = 'Cửa hàng quần áo này nhờ kiểm soát nghiêm ngặt chi phí nhập hàng nên năm ngoái đã đạt được mức lợi nhuận đáng kể.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '利润',
      'lìrùn',
      'lợi nhuận',
      'Danh từ',
      'HSK 5',
      '这家服装店通过严格控制进货成本，去年实现了可观的利润。',
      'Zhè jiā fúzhuāngdiàn tōngguò yángé kòngzhì jìnhuò chéngběn, qùnián shíxiàn le kěguān de lìrùn.',
      'Cửa hàng quần áo này nhờ kiểm soát nghiêm ngặt chi phí nhập hàng nên năm ngoái đã đạt được mức lợi nhuận đáng kể.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家服装店通过严格控制进货成本，去年实现了可观的利润。', 'Zhè jiā fúzhuāngdiàn tōngguò yángé kòngzhì jìnhuò chéngběn, qùnián shíxiàn le kěguān de lìrùn.', 'Cửa hàng quần áo này nhờ kiểm soát nghiêm ngặt chi phí nhập hàng nên năm ngoái đã đạt được mức lợi nhuận đáng kể.', 'basic', 1),
      (v_id, '企业在追求商业利润合理增长的同时，必须严格恪守环保法律法规并切实履行节能减排的社会责任。', 'Qǐyè zài zhuīqiú shāngyè lìrùn hélǐ zēngzhǎng de tóngshí, bìxū yángé kèshǒu huánbǎo fǎlǜ fǎguī bìng qièshí lǚxíng jiénéng-jiǎnpái de shèhuì zérèn.', 'Doanh nghiệp trong khi theo đuổi sự tăng trưởng lợi nhuận thương mại hợp lý, bắt buộc phải nghiêm chỉnh tuân thủ các quy định pháp luật môi trường và thực hiện thiết thực trách nhiệm xã hội về tiết kiệm năng lượng giảm phát thải.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2709] [利益] (lìyì) - lợi ích, quyền lợi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '利益' AND pinyin = 'lìyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '利益' AND pinyin = 'lìyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '利益'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '利益'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lìyì',
      meaning_vi = 'lợi ích, quyền lợi',
      example_hanzi = '在团队合作中，大家应当顾全大局，不能只顾及个人的一己私利。',
      example_pinyin = 'Zài tuánduì hézuò zhōng, dàjiā yīngdāng gùquán-dàjú, bùnéng zhǐ gùjí gèrén de yìjǐ-sīlì.',
      example_vi = 'Trong làm việc nhóm, mọi người nên nghĩ đến đại cục chung, không thể chỉ chăm chăm nghĩ tới tư lợi cá nhân của riêng mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '利益',
      'lìyì',
      'lợi ích, quyền lợi',
      'Danh từ',
      'HSK 5',
      '在团队合作中，大家应当顾全大局，不能只顾及个人的一己私利。',
      'Zài tuánduì hézuò zhōng, dàjiā yīngdāng gùquán-dàjú, bùnéng zhǐ gùjí gèrén de yìjǐ-sīlì.',
      'Trong làm việc nhóm, mọi người nên nghĩ đến đại cục chung, không thể chỉ chăm chăm nghĩ tới tư lợi cá nhân của riêng mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在团队合作中，大家应当顾全大局，不能只顾及个人的一己私利。', 'Zài tuánduì hézuò zhōng, dàjiā yīngdāng gùquán-dàjú, bùnéng zhǐ gùjí gèrén de yìjǐ-sīlì.', 'Trong làm việc nhóm, mọi người nên nghĩ đến đại cục chung, không thể chỉ chăm chăm nghĩ tới tư lợi cá nhân của riêng mình.', 'basic', 1),
      (v_id, '在深化多边国际经贸谈判中，各国代表团应当兼顾各方核心利益关切，寻求互利共赢的最大公约数。', 'Zài shēnhuà duōbiān guójì jīngmào tánpàn zhōng, gè guó dàibiǎotuán yīngdāng jiāngù gèfāng héxīn lìyì guānqiè, xúnqiú hùlì-gòngyíng de zuìdà gōngyuēshù.', 'Trong việc làm sâu sắc đàm phán kinh tế thương mại quốc tế đa phương, đoàn đại biểu các nước nên xem xét dung hòa những mối quan tâm lợi ích cốt lõi của các bên, tìm kiếm mẫu số chung lớn nhất về hợp tác đôi bên cùng có lợi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2710] [利用] (lìyòng) - tận dụng, sử dụng, khai thác [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '利用' AND pinyin = 'lìyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '利用' AND pinyin = 'lìyòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '利用'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '利用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'lìyòng',
      meaning_vi = 'tận dụng, sử dụng, khai thác',
      example_hanzi = '我们可以充分利用周末空闲时间来学习一门新的计算机语言。',
      example_pinyin = 'Wǒmen kěyǐ chōngfèn lìyòng zhōumò kòngxián shíjiān lái xuéxí yì mén xīn de jìsuànjī yǔyán.',
      example_vi = 'Chúng ta có thể tận dụng triệt để thời gian rảnh rỗi cuối tuần để học một ngôn ngữ lập trình máy tính mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '利用',
      'lìyòng',
      'tận dụng, sử dụng, khai thác',
      'Động từ',
      'HSK 5',
      '我们可以充分利用周末空闲时间来学习一门新的计算机语言。',
      'Wǒmen kěyǐ chōngfèn lìyòng zhōumò kòngxián shíjiān lái xuéxí yì mén xīn de jìsuànjī yǔyán.',
      'Chúng ta có thể tận dụng triệt để thời gian rảnh rỗi cuối tuần để học một ngôn ngữ lập trình máy tính mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们可以充分利用周末空闲时间来学习一门新的计算机语言。', 'Wǒmen kěyǐ chōngfèn lìyòng zhōumò kòngxián shíjiān lái xuéxí yì mén xīn de jìsuànjī yǔyán.', 'Chúng ta có thể tận dụng triệt để thời gian rảnh rỗi cuối tuần để học một ngôn ngữ lập trình máy tính mới.', 'basic', 1),
      (v_id, '大力发展循环经济的关键在于全面提升工业固体废弃物与工业副产石膏的无害化综合利用水平。', 'Dàlì fāzhǎn xúnhuán jīngjì de guānjiàn zàiyú quánmiàn tíshēng gōngyè gùtǐ fèiqìwù yǔ gōngyè fùchǎn shígāo de wúhàihuà zōnghé lìyòng shuǐpíng.', 'Mấu chốt của việc đẩy mạnh phát triển kinh tế tuần hoàn nằm ở việc nâng cao toàn diện trình độ tận dụng tổng hợp không gây hại đối với chất thải rắn công nghiệp và thạch cao phụ phẩm công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2711] [联合] (liánhé) - liên hợp, liên minh, phối hợp; chung [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '联合' AND pinyin = 'liánhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '联合' AND pinyin = 'liánhé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '联合'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '联合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'liánhé',
      meaning_vi = 'liên hợp, liên minh, phối hợp; chung',
      example_hanzi = '两所大学联合举办了一年一度的大学生中文辩论邀请赛。',
      example_pinyin = 'Liǎng suǒ dàxué liánhé jǔbàn le yì nián yí dù de dàxuésheng Zhōngwén biànlùn yāoqǐngsài.',
      example_vi = 'Hai trường đại học đã phối hợp liên kết tổ chức giải đấu tranh biện tiếng Trung sinh viên thường niên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '联合',
      'liánhé',
      'liên hợp, liên minh, phối hợp; chung',
      'Động từ / Tính từ',
      'HSK 5',
      '两所大学联合举办了一年一度的大学生中文辩论邀请赛。',
      'Liǎng suǒ dàxué liánhé jǔbàn le yì nián yí dù de dàxuésheng Zhōngwén biànlùn yāoqǐngsài.',
      'Hai trường đại học đã phối hợp liên kết tổ chức giải đấu tranh biện tiếng Trung sinh viên thường niên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '两所大学联合举办了一年一度的大学生中文辩论邀请赛。', 'Liǎng suǒ dàxué liánhé jǔbàn le yì nián yí dù de dàxuésheng Zhōngwén biànlùn yāoqǐngsài.', 'Hai trường đại học đã phối hợp liên kết tổ chức giải đấu tranh biện tiếng Trung sinh viên thường niên.', 'basic', 1),
      (v_id, '三国海警部门定期开展跨国水域联合巡航与海上反恐搜救演练，共同维护国际航运主通道的安全畅通。', 'Sān guó hǎijǐng bùmén dìngqī kāizhǎn kuàguó shuǐyù liánhé xúnháng yǔ hǎishàng fǎnkǒng sōujiù yǎnliàn, gòngtóng wéihù guójì hángyùn zhǔ tōngdào de ānquán chàngtōng.', 'Lực lượng cảnh sát biển ba nước định kỳ triển khai tuần tra chung tại vùng biển liên quốc gia cùng diễn tập chống khủng bố tìm kiếm cứu nạn trên biển, chung tay giữ gìn an toàn thông suốt cho tuyến hàng hải quốc tế huyết mạch.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2712] [连接] (liánjiē) - kết nối, nối liền, liên kết [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '连接' AND pinyin = 'liánjiē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '连接' AND pinyin = 'liánjiē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '连接'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '连接'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'liánjiē',
      meaning_vi = 'kết nối, nối liền, liên kết',
      example_hanzi = '只要把电脑连接到无线网络上，就可以畅快地浏览各类学术资料。',
      example_pinyin = 'Zhǐyào bǎ diànnǎo liánjiē dào wúxiàn wǎngluò shang, jiù kěyǐ chàngkuài de liúlǎn gèlèi xuéshù zīliào.',
      example_vi = 'Chỉ cần kết nối máy tính vào mạng không dây là có thể thoải mái tra cứu duyệt xem các loại tài liệu học thuật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '连接',
      'liánjiē',
      'kết nối, nối liền, liên kết',
      'Động từ',
      'HSK 5',
      '只要把电脑连接到无线网络上，就可以畅快地浏览各类学术资料。',
      'Zhǐyào bǎ diànnǎo liánjiē dào wúxiàn wǎngluò shang, jiù kěyǐ chàngkuài de liúlǎn gèlèi xuéshù zīliào.',
      'Chỉ cần kết nối máy tính vào mạng không dây là có thể thoải mái tra cứu duyệt xem các loại tài liệu học thuật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只要把电脑连接到无线网络上，就可以畅快地浏览各类学术资料。', 'Zhǐyào bǎ diànnǎo liánjiē dào wúxiàn wǎngluò shang, jiù kěyǐ chàngkuài de liúlǎn gèlèi xuéshù zīliào.', 'Chỉ cần kết nối máy tính vào mạng không dây là có thể thoải mái tra cứu duyệt xem các loại tài liệu học thuật.', 'basic', 1),
      (v_id, '这座跨海公铁两用特大桥梁将珠三角核心城市群与粤西沿海经济带紧紧连接在一起，重塑了区域经济发展新格局。', 'Zhè zuò kuàhǎi gōng-tiě liǎngyòng tèdà qiáoliáng jiāng Zhūsānjiǎo héxīn chéngshìqún yǔ Yuèxī yánhǎi jīngjìdài jǐnjǐn liánjiē zài yìqǐ, chóngsù le qūyù jīngjì fāzhǎn xīn géjú.', 'Cây cầu vượt biển siêu lớn kết hợp đường bộ và đường sắt này đã liên kết chặt chẽ cụm đô thị cốt lõi Đồng bằng Châu Giang cùng vành đai kinh tế ven biển Tây Quảng Đông, tái định hình cục diện phát triển kinh tế vùng mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2713] [连忙] (liánmáng) - vội vàng, vội vã, mau lẹ [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '连忙' AND pinyin = 'liánmáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '连忙' AND pinyin = 'liánmáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '连忙'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '连忙'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'liánmáng',
      meaning_vi = 'vội vàng, vội vã, mau lẹ',
      example_hanzi = '看见老奶奶提着沉重的东西上楼，他连忙走上前去帮忙。',
      example_pinyin = 'Kànjiàn lǎonǎinai tízhe chénzhòng de dōngxi shàng lóu, tā liánmáng zǒushàngqián qù bāngmáng.',
      example_vi = 'Thấy bà cụ xách đồ nặng bước lên cầu thang, anh ấy vội vàng bước tới giúp đỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '连忙',
      'liánmáng',
      'vội vàng, vội vã, mau lẹ',
      'Phó từ',
      'HSK 5',
      '看见老奶奶提着沉重的东西上楼，他连忙走上前去帮忙。',
      'Kànjiàn lǎonǎinai tízhe chénzhòng de dōngxi shàng lóu, tā liánmáng zǒushàngqián qù bāngmáng.',
      'Thấy bà cụ xách đồ nặng bước lên cầu thang, anh ấy vội vàng bước tới giúp đỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '看见老奶奶提着沉重的东西上楼，他连忙走上前去帮忙。', 'Kànjiàn lǎonǎinai tízhe chénzhòng de dōngxi shàng lóu, tā liánmáng zǒushàngqián qù bāngmáng.', 'Thấy bà cụ xách đồ nặng bước lên cầu thang, anh ấy vội vàng bước tới giúp đỡ.', 'basic', 1),
      (v_id, '在巡检中发现天然气管道存在微小渗漏隐患后，维保技术人员连忙关闭上游控制阀门并迅速开展带压封堵作业。', 'Zài xúnjiǎn zhōng fāxiàn tiānránqì guǎndào cúnzài wēixiǎo shènlòu yǐnhuàn hòu, wéibǎo jìshù rényuán liánmáng guānbì shàngyóu kòngzhì fámén bìng xùnsù kāizhǎn dàiyā fēngdǔ zuòyè.', 'Sau khi phát hiện nguy cơ rò rỉ khí đốt tự nhiên mức độ nhỏ trong lúc đi tuần tra, nhân viên kỹ thuật bảo trì vội vàng khóa van điều khiển thượng nguồn và nhanh chóng triển khai thao tác bịt kín chịu áp lực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2714] [连续] (liánxù) - liên tục, liên tiếp [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '连续' AND pinyin = 'liánxù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '连续' AND pinyin = 'liánxù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '连续'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '连续'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Phó từ',
      pinyin = 'liánxù',
      meaning_vi = 'liên tục, liên tiếp',
      example_hanzi = '为了赶在截止日期前提交设计方案，他连续加了三个晚上的班。',
      example_pinyin = 'Wèile gǎn zài jiézhǐ rìqī qián tíjiāo shèjì fāng’àn, tā liánxù jiā le sān gè wǎnshang de bān.',
      example_vi = 'Để kịp nộp phương án thiết kế trước ngày hạn chót, anh ấy đã tăng ca liên tiếp suốt 3 buổi tối.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '连续',
      'liánxù',
      'liên tục, liên tiếp',
      'Động từ / Phó từ',
      'HSK 5',
      '为了赶在截止日期前提交设计方案，他连续加了三个晚上的班。',
      'Wèile gǎn zài jiézhǐ rìqī qián tíjiāo shèjì fāng’àn, tā liánxù jiā le sān gè wǎnshang de bān.',
      'Để kịp nộp phương án thiết kế trước ngày hạn chót, anh ấy đã tăng ca liên tiếp suốt 3 buổi tối.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了赶在截止日期前提交设计方案，他连续加了三个晚上的班。', 'Wèile gǎn zài jiézhǐ rìqī qián tíjiāo shèjì fāng’àn, tā liánxù jiā le sān gè wǎnshang de bān.', 'Để kịp nộp phương án thiết kế trước ngày hạn chót, anh ấy đã tăng ca liên tiếp suốt 3 buổi tối.', 'basic', 1),
      (v_id, '高精度数控机床在无人值守的自动化车间里连续无故障稳定运行上千小时，充分展现了国产工业母机卓越的机械耐久性。', 'Gāo jīngmìdù shùkòng jīchuáng zài wúrén-zhíshǒu de zìdònghuà chējiān lǐ liánxù wú gùzhàng wěndìng yùnxíng shàng qiān xiǎoshí, chōngfèn zhǎnxiàn le guóchǎn gōngyè mǔjī zhuóyuè de jīxiè nàijiǔxìng.', 'Máy công cụ CNC độ chính xác cao trong phân xưởng tự động hóa không người trực đã vận hành ổn định không lỗi liên tục hàng nghìn giờ đồng hồ, thể hiện trọn vẹn độ bền cơ học xuất sắc của máy công cụ nguồn nội địa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2715] [脸色] (liǎnsè) - sắc mặt, nét mặt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '脸色' AND pinyin = 'liǎnsè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '脸色' AND pinyin = 'liǎnsè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '脸色'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '脸色'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'liǎnsè',
      meaning_vi = 'sắc mặt, nét mặt',
      example_hanzi = '你今天脸色看起来有些苍白，是不是身体不舒服？',
      example_pinyin = 'Nǐ jīntiān liǎnsè kàn qǐlái yǒuxiē cāngbái, shì bushì shēntǐ bù shūfu?',
      example_vi = 'Hôm nay sắc mặt bạn trông có phần nhợt nhạt, có phải trong người thấy không khỏe không?'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '脸色',
      'liǎnsè',
      'sắc mặt, nét mặt',
      'Danh từ',
      'HSK 5',
      '你今天脸色看起来有些苍白，是不是身体不舒服？',
      'Nǐ jīntiān liǎnsè kàn qǐlái yǒuxiē cāngbái, shì bushì shēntǐ bù shūfu?',
      'Hôm nay sắc mặt bạn trông có phần nhợt nhạt, có phải trong người thấy không khỏe không?'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '你今天脸色看起来有些苍白，是不是身体不舒服？', 'Nǐ jīntiān liǎnsè kàn qǐlái yǒuxiē cāngbái, shì bushì shēntǐ bù shūfu?', 'Hôm nay sắc mặt bạn trông có phần nhợt nhạt, có phải trong người thấy không khỏe không?', 'basic', 1),
      (v_id, '在激烈的跨国并购谈判桌前，首席谈判代表时刻保持从容沉静的神情，决不轻易让对手从自己的脸色中窥见商业底线。', 'Zài jīliè de kuàguó bìnggòu tánpànzhuō qián, shǒuxí tánpàn dàibiǎo shíkè bǎochí cóngróng chénjìng de shénqíng, jué bù qīngyì ràng duìshǒu cóng zìjǐ de liǎnsè zhōng kuījiàn shāngyè dǐxiàn.', 'Trước bàn đàm phán mua bán sáp nhập xuyên quốc gia khốc liệt, trưởng đoàn đàm phán luôn giữ thần sắc điềm tĩnh ung dung, tuyệt đối không dễ dàng để đối phương nhìn qua nét mặt mà dò xét được lằn ranh đỏ thương mại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2716] [恋爱] (liàn’ài) - yêu đương, chuyện tình cảm, tình yêu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '恋爱' AND pinyin = 'liàn’ài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '恋爱' AND pinyin = 'liàn’ài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '恋爱'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '恋爱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'liàn’ài',
      meaning_vi = 'yêu đương, chuyện tình cảm, tình yêu',
      example_hanzi = '他们俩从大学时期就开始谈恋爱，如今已经携手走进了婚姻的殿堂。',
      example_pinyin = 'Tāmen liǎ cóng dàxué shíqī jiù kāishǐ tán liàn’ài, rújīn yǐjīng xiéshǒu zǒujìn le hūnyīn de diàntáng.',
      example_vi = 'Hai người họ từ thời đại học đã bắt đầu yêu nhau, đến nay đã cùng nắm tay nhau bước vào ngưỡng cửa hôn nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '恋爱',
      'liàn’ài',
      'yêu đương, chuyện tình cảm, tình yêu',
      'Động từ / Danh từ',
      'HSK 5',
      '他们俩从大学时期就开始谈恋爱，如今已经携手走进了婚姻的殿堂。',
      'Tāmen liǎ cóng dàxué shíqī jiù kāishǐ tán liàn’ài, rújīn yǐjīng xiéshǒu zǒujìn le hūnyīn de diàntáng.',
      'Hai người họ từ thời đại học đã bắt đầu yêu nhau, đến nay đã cùng nắm tay nhau bước vào ngưỡng cửa hôn nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他们俩从大学时期就开始谈恋爱，如今已经携手走进了婚姻的殿堂。', 'Tāmen liǎ cóng dàxué shíqī jiù kāishǐ tán liàn’ài, rújīn yǐjīng xiéshǒu zǒujìn le hūnyīn de diàntáng.', 'Hai người họ từ thời đại học đã bắt đầu yêu nhau, đến nay đã cùng nắm tay nhau bước vào ngưỡng cửa hôn nhân.', 'basic', 1),
      (v_id, '青年一代应当树立成熟理性、相互尊重和平等包容的现代恋爱观，让纯真的爱情成为彼此共同成长与追求人生理想的精神动力。', 'Qīngnián yídài yīngdāng shùlì chéngshú lǐxìng, xiānghù zūnzhòng hé píngděng bāoróng de xiàndài liàn’àiguān, ràng chúnzhēn de àiqíng chéngwéi bǐcǐ gòngtóng chéngzhǎng yǔ zhuīqiú rénshēng lǐxiǎng de jīngshén dònglì.', 'Thế hệ trẻ nên xây dựng quan niệm tình yêu hiện đại chín chắn lý trí, tôn trọng lẫn nhau và bình đẳng bao dung, để tình yêu trong sáng trở thành động lực tinh thần thúc đẩy đôi bên cùng trưởng thành và theo đuổi lý tưởng cuộc đời.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2717] [良好] (liánghǎo) - tốt đẹp, khả quan, thuận lợi [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '良好' AND pinyin = 'liánghǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '良好' AND pinyin = 'liánghǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '良好'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '良好'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'liánghǎo',
      meaning_vi = 'tốt đẹp, khả quan, thuận lợi',
      example_hanzi = '养成良好的阅读习惯和规律的作息时间对青少年的身心健康大有裨益。',
      example_pinyin = 'Yǎngchéng liánghǎo de yuèdú xíguàn hé guīlǜ de zuòxī shíjiān duì qīngshàonián de shēnxīn jiànkāng dàyǒu-bìyì.',
      example_vi = 'Rèn luyện thói quen đọc sách tốt đẹp và thời gian biểu sinh hoạt điều độ mang lại rất nhiều lợi ích cho sức khỏe thể chất và tinh thần của thanh thiếu niên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '良好',
      'liánghǎo',
      'tốt đẹp, khả quan, thuận lợi',
      'Tính từ',
      'HSK 5',
      '养成良好的阅读习惯和规律的作息时间对青少年的身心健康大有裨益。',
      'Yǎngchéng liánghǎo de yuèdú xíguàn hé guīlǜ de zuòxī shíjiān duì qīngshàonián de shēnxīn jiànkāng dàyǒu-bìyì.',
      'Rèn luyện thói quen đọc sách tốt đẹp và thời gian biểu sinh hoạt điều độ mang lại rất nhiều lợi ích cho sức khỏe thể chất và tinh thần của thanh thiếu niên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '养成良好的阅读习惯和规律的作息时间对青少年的身心健康大有裨益。', 'Yǎngchéng liánghǎo de yuèdú xíguàn hé guīlǜ de zuòxī shíjiān duì qīngshàonián de shēnxīn jiànkāng dàyǒu-bìyì.', 'Rèn luyện thói quen đọc sách tốt đẹp và thời gian biểu sinh hoạt điều độ mang lại rất nhiều lợi ích cho sức khỏe thể chất và tinh thần của thanh thiếu niên.', 'basic', 1),
      (v_id, '持续优化法治化、国际化、市场化的一流营商环境，是稳定跨国资本预期并吸引外资长期扎根投资兴业的良好土壤。', 'Chíxù yōuhuà fǎzhìhuà, guójìhuà, shìchǎnghuà de yīliú yíngshāng huánjìng, shì wěndìng kuàguó zīběn yùqī bìng xīyǐn wàizī chángqī zhāgēn tóuzī xīngyè de liánghǎo tǔrǎng.', 'Liên tục tối ưu hóa môi trường kinh doanh hàng đầu mang tính pháp trị hóa, quốc tế hóa và thị trường hóa là mảnh đất màu mỡ tốt đẹp nhằm ổn định kỳ vọng của dòng vốn xuyên quốc gia và thu hút vốn ngoại cắm rễ lâu dài đầu tư phát triển sự nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2718] [粮食] (liángshi) - lương thực, thóc lúa ngũ cốc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '粮食' AND pinyin = 'liángshi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '粮食' AND pinyin = 'liángshi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '粮食'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '粮食'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'liángshi',
      meaning_vi = 'lương thực, thóc lúa ngũ cốc',
      example_hanzi = '“谁知盘中餐，粒粒皆辛苦”，我们要自觉节约粮食，杜绝餐桌浪费。',
      example_pinyin = '“Shuí zhī pán zhōng cān, lì lì jiē xīnkǔ”, wǒmen yào zìjué jiéyuē liángshi, dùjué cānzhuō làngfèi.',
      example_vi = '"Ai hay cơm trong đĩa, hạt hạt đều gian lao", chúng ta cần tự giác tiết kiệm lương thực, bài trừ nạn lãng phí đồ ăn trên bàn ăn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '粮食',
      'liángshi',
      'lương thực, thóc lúa ngũ cốc',
      'Danh từ',
      'HSK 5',
      '“谁知盘中餐，粒粒皆辛苦”，我们要自觉节约粮食，杜绝餐桌浪费。',
      '“Shuí zhī pán zhōng cān, lì lì jiē xīnkǔ”, wǒmen yào zìjué jiéyuē liángshi, dùjué cānzhuō làngfèi.',
      '"Ai hay cơm trong đĩa, hạt hạt đều gian lao", chúng ta cần tự giác tiết kiệm lương thực, bài trừ nạn lãng phí đồ ăn trên bàn ăn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '“谁知盘中餐，粒粒皆辛苦”，我们要自觉节约粮食，杜绝餐桌浪费。', '“Shuí zhī pán zhōng cān, lì lì jiē xīnkǔ”, wǒmen yào zìjué jiéyuē liángshi, dùjué cānzhuō làngfèi.', '"Ai hay cơm trong đĩa, hạt hạt đều gian lao", chúng ta cần tự giác tiết kiệm lương thực, bài trừ nạn lãng phí đồ ăn trên bàn ăn.', 'basic', 1),
      (v_id, '国家坚持藏粮于地、藏粮于技战略，严守十八亿亩耕地红线，坚决将中国人的饭碗牢牢端在自己手中，夯实国家粮食安全根基。', 'Guójiā jiānchí cáng liáng yú dì, cáng liáng yú jì zhànlüè, yánshǒu shíbā yì mǔ gēngdì hóngxiàn, jiānjué jiāng Zhōngguórén de fànwǎn láoláo duān zài zìjǐ shǒuzhōng, hāngshí guójiā liángshi ānquán gēnjī.', 'Nhà nước kiên trì chiến lược giữ lúa trong đất, trữ lúa trong công nghệ, giữ vững lằn ranh đỏ 1,8 tỷ mẫu đất canh tác, kiên quyết giữ chắc bát cơm của người Trung Quốc trong tay mình, bồi đắp vững chắc nền tảng an ninh lương thực quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2719] [量] (liàng) - lượng, số lượng, khối lượng, dung lượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '量' AND pinyin = 'liàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '量' AND pinyin = 'liàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'liàng',
      meaning_vi = 'lượng, số lượng, khối lượng, dung lượng',
      example_hanzi = '运动出汗过多后，应当适量补充含有微量电解质的淡盐水。',
      example_pinyin = 'Yùndòng chūhàn guòduō hòu, yīngdāng shìliàng bǔchōng hányǒu wēiliàng diànjiězì de dànyánshuǐ.',
      example_vi = 'Sau khi vận động ra quá nhiều mồ hôi, nên bổ sung một lượng nước muối loãng vừa phải có chứa chất điện giải vi lượng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '量',
      'liàng',
      'lượng, số lượng, khối lượng, dung lượng',
      'Danh từ',
      'HSK 5',
      '运动出汗过多后，应当适量补充含有微量电解质的淡盐水。',
      'Yùndòng chūhàn guòduō hòu, yīngdāng shìliàng bǔchōng hányǒu wēiliàng diànjiězì de dànyánshuǐ.',
      'Sau khi vận động ra quá nhiều mồ hôi, nên bổ sung một lượng nước muối loãng vừa phải có chứa chất điện giải vi lượng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '运动出汗过多后，应当适量补充含有微量电解质的淡盐水。', 'Yùndòng chūhàn guòduō hòu, yīngdāng shìliàng bǔchōng hányǒu wēiliàng diànjiězì de dànyánshuǐ.', 'Sau khi vận động ra quá nhiều mồ hôi, nên bổ sung một lượng nước muối loãng vừa phải có chứa chất điện giải vi lượng.', 'basic', 1),
      (v_id, '面对井喷式增长的海量非结构化多模态数据，分布式云存储集群通过自适应压缩与冷热分级存储，大幅提升了数据吞吐量与处理效能。', 'Miànduì jǐngpēnshì zēngzhǎng de hǎiliàng fēijiégòuhuà duōmótài shùjù, fēnbùshì yún cúnchǔ jíqún tōngguò zìshìyìng yāsuō yǔ lěng-rè fēnjí cúnchǔ, dàfú tíshēng le shùjù tūntǔliàng yǔ chǔlǐ xiàonéng.', 'Đối mặt với lượng dữ liệu phi cấu trúc đa phương thức khổng lồ tăng vọt như phun trào, cụm lưu trữ đám mây phân tán thông qua nén tự thích ứng và phân tầng lưu trữ nóng lạnh đã nâng cao đáng kể thông lượng dữ liệu và hiệu năng xử lý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2720] [了不起] (liǎobuqǐ) - tài ba, phi thường, đáng khâm phục [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '了不起' AND pinyin = 'liǎobuqǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '了不起' AND pinyin = 'liǎobuqǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '了不起'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '了不起'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'liǎobuqǐ',
      meaning_vi = 'tài ba, phi thường, đáng khâm phục',
      example_hanzi = '他凭借顽强的毅力自学成才并考上了名牌大学，真是一个了不起的青年。',
      example_pinyin = 'Tā píngjiè wánqiáng de yìlì zìxué-chéngcái bìng kǎoshàng le míngpái dàxué, zhēn shì yí gè liǎobuqǐ de qīngnián.',
      example_vi = 'Cậu ấy dựa vào nghị lực kiên cường tự học thành tài và thi đỗ vào trường đại học danh tiếng, thật là một thanh niên đáng khâm phục.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '了不起',
      'liǎobuqǐ',
      'tài ba, phi thường, đáng khâm phục',
      'Tính từ',
      'HSK 5',
      '他凭借顽强的毅力自学成才并考上了名牌大学，真是一个了不起的青年。',
      'Tā píngjiè wánqiáng de yìlì zìxué-chéngcái bìng kǎoshàng le míngpái dàxué, zhēn shì yí gè liǎobuqǐ de qīngnián.',
      'Cậu ấy dựa vào nghị lực kiên cường tự học thành tài và thi đỗ vào trường đại học danh tiếng, thật là một thanh niên đáng khâm phục.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他凭借顽强的毅力自学成才并考上了名牌大学，真是一个了不起的青年。', 'Tā píngjiè wánqiáng de yìlì zìxué-chéngcái bìng kǎoshàng le míngpái dàxué, zhēn shì yí gè liǎobuqǐ de qīngnián.', 'Cậu ấy dựa vào nghị lực kiên cường tự học thành tài và thi đỗ vào trường đại học danh tiếng, thật là một thanh niên đáng khâm phục.', 'basic', 1),
      (v_id, '中国航天科技工作者独立自主攻克空间站组装建造与长期驻留等一系列世界级技术难题，创造了举世瞩目的了不起航天奇迹。', 'Zhōngguó hángtiān kējì gōngzuòzhě dúlì-zìzhǔ gōngkè kōngjiānzhàn zǔzhuāng jiànzào yǔ chángqī zhùliú děng yí xìliè shìjièjí jìshù nántí, chuàngzào le jǔshì-zhǔmù de liǎobuqǐ hángtiān qíjì.', 'Đội ngũ cán bộ khoa học hàng không vũ trụ Trung Quốc đã độc lập tự chủ chinh phục một loạt các bài toán kỹ thuật tầm cỡ thế giới như lắp ráp xây dựng trạm không gian và đồn trú dài ngày, tạo nên kỳ tích vũ trụ phi thường khiến toàn thế giới phải dõi mắt khâm phục.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2721] [列车] (lièchē) - đoàn tàu, đoàn xe lửa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '列车' AND pinyin = 'lièchē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '列车' AND pinyin = 'lièchē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '列车'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '列车'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lièchē',
      meaning_vi = 'đoàn tàu, đoàn xe lửa',
      example_hanzi = '各位旅客请注意，开往北京方向的高速动车组列车马上就要进站了。',
      example_pinyin = 'Gèwèi lǚkè qǐng zhùyì, kāiwǎng Běijīng fāngxiàng de gāosù dòngchēzǔ lièchē mǎshàng jiù yào jìnzhàn le.',
      example_vi = 'Kính mời quý hành khách chú ý, đoàn tàu cao tốc động lực phân tán hướng đi Bắc Kinh sắp sửa tiến vào sân ga.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '列车',
      'lièchē',
      'đoàn tàu, đoàn xe lửa',
      'Danh từ',
      'HSK 5',
      '各位旅客请注意，开往北京方向的高速动车组列车马上就要进站了。',
      'Gèwèi lǚkè qǐng zhùyì, kāiwǎng Běijīng fāngxiàng de gāosù dòngchēzǔ lièchē mǎshàng jiù yào jìnzhàn le.',
      'Kính mời quý hành khách chú ý, đoàn tàu cao tốc động lực phân tán hướng đi Bắc Kinh sắp sửa tiến vào sân ga.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '各位旅客请注意，开往北京方向的高速动车组列车马上就要进站了。', 'Gèwèi lǚkè qǐng zhùyì, kāiwǎng Běijīng fāngxiàng de gāosù dòngchēzǔ lièchē mǎshàng jiù yào jìnzhàn le.', 'Kính mời quý hành khách chú ý, đoàn tàu cao tốc động lực phân tán hướng đi Bắc Kinh sắp sửa tiến vào sân ga.', 'basic', 1),
      (v_id, '时速三百五十公里的复兴号智能动车组列车实现了全自动驾驶辅助与全车物联网故障自诊断，成为彰显中国制造业创新实力的闪亮名片。', 'Shísù sānbǎi wǔshí gōnglǐ de Fùxīnghào zhìnéng dòngchēzǔ lièchē shíxiàn le quán zìdòng jiàshǐ fǔzhù yǔ quán chē wùliánwǎng gùzhàng zì zhěnduàn, chéngwéi zhāngxiǎn Zhōngguó zhìzàoyè chuàngxīn shílì de shǎnliàng míngpiàn.', 'Đoàn tàu điện thông minh Phục Hưng vận tốc 350 km/h đã hiện thực hóa việc hỗ trợ tự lái hoàn toàn và tự chẩn đoán sự cố IoT toàn tàu, trở thành tấm danh thiếp rực rỡ thể hiện năng lực đổi mới sáng tạo của ngành chế tạo Trung Quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2722] [临时] (línshí) - tạm thời, lâm thời, nhất thời [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '临时' AND pinyin = 'línshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '临时' AND pinyin = 'línshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '临时'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '临时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Tính từ',
      pinyin = 'línshí',
      meaning_vi = 'tạm thời, lâm thời, nhất thời',
      example_hanzi = '由于原定会议室设备出现故障，会议临时改到三楼多功能学术报告厅举行。',
      example_pinyin = 'Yóuyú yuándìng huìyìshì shèbèi chūxiàn gùzhàng, huìyì línshí gǎi dào sān lóu duōgōngnéng xuéshù bàogàotīng jǔxíng.',
      example_vi = 'Do trang thiết bị phòng họp dự kiến ban đầu gặp sự cố, cuộc họp tạm thời được chuyển sang tổ chức tại hội trường báo cáo học thuật đa năng tầng 3.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '临时',
      'línshí',
      'tạm thời, lâm thời, nhất thời',
      'Phó từ / Tính từ',
      'HSK 5',
      '由于原定会议室设备出现故障，会议临时改到三楼多功能学术报告厅举行。',
      'Yóuyú yuándìng huìyìshì shèbèi chūxiàn gùzhàng, huìyì línshí gǎi dào sān lóu duōgōngnéng xuéshù bàogàotīng jǔxíng.',
      'Do trang thiết bị phòng họp dự kiến ban đầu gặp sự cố, cuộc họp tạm thời được chuyển sang tổ chức tại hội trường báo cáo học thuật đa năng tầng 3.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '由于原定会议室设备出现故障，会议临时改到三楼多功能学术报告厅举行。', 'Yóuyú yuándìng huìyìshì shèbèi chūxiàn gùzhàng, huìyì línshí gǎi dào sān lóu duōgōngnéng xuéshù bàogàotīng jǔxíng.', 'Do trang thiết bị phòng họp dự kiến ban đầu gặp sự cố, cuộc họp tạm thời được chuyển sang tổ chức tại hội trường báo cáo học thuật đa năng tầng 3.', 'basic', 1),
      (v_id, '在特大洪涝灾害发生后，救援指挥部火速调集活动板房与医疗物资，仅用两天时间便在安全高地搭建起可容纳数千名受灾群众的临时安置点。', 'Zài tèdà hónglào zāihài fāshēng hòu, jiùyuán zhǐhuībù huǒsù diàojí huódòng bǎnfáng yǔ yīliáo wùzī, jǐn yòng liǎng tiān shíjiān biàn zài ānquán gāodì dājiàn qǐ kě róngnà shù qiān míng shòuzāi qúnzhòng de línshí ānzhìdiǎn.', 'Sau khi trận lũ lụt lớn xảy ra, ban chỉ huy cứu hộ đã hỏa tốc điều động nhà lắp ghép cùng vật tư y tế, chỉ trong 2 ngày đã dựng nên một khu tái định cư tạm thời trên vùng đất cao an toàn có thể dung nạp hàng nghìn bà con bị ảnh hưởng bởi thiên tai.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2723] [铃] (líng) - chuông, cái chuông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '铃' AND pinyin = 'líng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '铃' AND pinyin = 'líng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '铃'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '铃'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'líng',
      meaning_vi = 'chuông, cái chuông',
      example_hanzi = '清脆的下课铃声一响，操场上立刻充满了同学们的欢声笑语。',
      example_pinyin = 'Qīngcuì de xiàkè língshēng yì xiǎng, cǎochǎng shang lìkè chōngmǎn le tóngxuémen de huānshēng-xiàoyǔ.',
      example_vi = 'Tiếng chuông tan học trong trẻo vừa vang lên, trên sân trường lập tức tràn ngập tiếng cười nói rộn rã của các bạn học sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '铃',
      'líng',
      'chuông, cái chuông',
      'Danh từ',
      'HSK 5',
      '清脆的下课铃声一响，操场上立刻充满了同学们的欢声笑语。',
      'Qīngcuì de xiàkè língshēng yì xiǎng, cǎochǎng shang lìkè chōngmǎn le tóngxuémen de huānshēng-xiàoyǔ.',
      'Tiếng chuông tan học trong trẻo vừa vang lên, trên sân trường lập tức tràn ngập tiếng cười nói rộn rã của các bạn học sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '清脆的下课铃声一响，操场上立刻充满了同学们的欢声笑语。', 'Qīngcuì de xiàkè língshēng yì xiǎng, cǎochǎng shang lìkè chōngmǎn le tóngxuémen de huānshēng-xiàoyǔ.', 'Tiếng chuông tan học trong trẻo vừa vang lên, trên sân trường lập tức tràn ngập tiếng cười nói rộn rã của các bạn học sinh.', 'basic', 1),
      (v_id, '在金融交易所数字化监控中心，高频交易异常风控警报电铃能够在毫秒内捕捉到恶意违规大单报价并触发系统自动熔断。', 'Zài jīnróng jiāoyìsuǒ shùzìhuà jiānkòng zhōngxīn, gāopín jiāoyì yìcháng fēngkòng jǐngbào diànlíng nénggòu zài háomiǎo nèi bǔzhuō dào èyì wéiguī dà dān bàojià bìng chùfā xìtǒng zìdòng róngduàn.', 'Tại trung tâm giám sát số hóa của sàn giao dịch tài chính, chuông báo động kiểm soát rủi ro giao dịch bất thường tần suất cao có thể trong tích tắc mili giây bắt trọn lệnh đặt giá lớn vi phạm quy chế độc hại và kích hoạt cơ chế tự động ngắt mạch giao dịch.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2724] [灵活] (línghuó) - linh hoạt, nhanh nhẹn, uyển chuyển [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '灵活' AND pinyin = 'línghuó'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '灵活' AND pinyin = 'línghuó'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '灵活'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '灵活'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'línghuó',
      meaning_vi = 'linh hoạt, nhanh nhẹn, uyển chuyển',
      example_hanzi = '遇到突发问题时，不能死板照搬教条，而要学会灵活变通处理。',
      example_pinyin = 'Yùdào tūfā wèntí shí, bùnéng sǐbǎn zhàobān jiàotiáo, ér yào xuéhuì línghuó biàntōng chǔlǐ.',
      example_vi = 'Khi gặp phải vấn đề phát sinh đột xuất, không thể rập khuôn máy móc theo giáo điều, mà phải học cách linh hoạt biến chuyển xử lý.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '灵活',
      'línghuó',
      'linh hoạt, nhanh nhẹn, uyển chuyển',
      'Tính từ',
      'HSK 5',
      '遇到突发问题时，不能死板照搬教条，而要学会灵活变通处理。',
      'Yùdào tūfā wèntí shí, bùnéng sǐbǎn zhàobān jiàotiáo, ér yào xuéhuì línghuó biàntōng chǔlǐ.',
      'Khi gặp phải vấn đề phát sinh đột xuất, không thể rập khuôn máy móc theo giáo điều, mà phải học cách linh hoạt biến chuyển xử lý.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '遇到突发问题时，不能死板照搬教条，而要学会灵活变通处理。', 'Yùdào tūfā wèntí shí, bùnéng sǐbǎn zhàobān jiàotiáo, ér yào xuéhuì línghuó biàntōng chǔlǐ.', 'Khi gặp phải vấn đề phát sinh đột xuất, không thể rập khuôn máy móc theo giáo điều, mà phải học cách linh hoạt biến chuyển xử lý.', 'basic', 1),
      (v_id, '面对高度分化且快速迭代的细分市场，柔性制造系统允许生产线在数分钟内灵活切换不同规格的复杂零件加工任务。', 'Miànduì gāodù fēnhuà qiě kuàisù diédài de xìfēn shìchǎng, róuxìng zhìzào xìtǒng yǔnxǔ shēngchǎnxiàn zài shù fēnzhōng nèi línghuó qiēhuàn bùtóng guīgé de fùzá língjiàn jiāgōng rènwu.', 'Đối mặt với một thị trường ngách phân hóa cao độ và cải tiến nhanh chóng, hệ thống chế tạo linh hoạt cho phép dây chuyền sản xuất chỉ trong vài phút có thể chuyển đổi uyển chuyển nhiệm vụ gia công các linh kiện phức tạp với các quy cách khác nhau.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2725] [领] (lǐng) - dẫn đầu, dẫn dắt; nhận, lĩnh; cổ áo [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '领' AND pinyin = 'lǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领' AND pinyin = 'lǐng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '领'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'lǐng',
      meaning_vi = 'dẫn đầu, dẫn dắt; nhận, lĩnh; cổ áo',
      example_hanzi = '班长领着新转来的同学熟悉校园环境和各学科教室。',
      example_pinyin = 'Bānzhǎng lǐng zhe xīn zhuǎnlái de tóngxué shúxī xiàoyuán huánjìng hé gè xuékē jiàoshì.',
      example_vi = 'Lớp trưởng dẫn bạn học mới chuyển tới làm quen với khuôn viên trường và phòng học của các môn học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '领',
      'lǐng',
      'dẫn đầu, dẫn dắt; nhận, lĩnh; cổ áo',
      'Động từ / Danh từ',
      'HSK 5',
      '班长领着新转来的同学熟悉校园环境和各学科教室。',
      'Bānzhǎng lǐng zhe xīn zhuǎnlái de tóngxué shúxī xiàoyuán huánjìng hé gè xuékē jiàoshì.',
      'Lớp trưởng dẫn bạn học mới chuyển tới làm quen với khuôn viên trường và phòng học của các môn học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '班长领着新转来的同学熟悉校园环境和各学科教室。', 'Bānzhǎng lǐng zhe xīn zhuǎnlái de tóngxué shúxī xiàoyuán huánjìng hé gè xuékē jiàoshì.', 'Lớp trưởng dẫn bạn học mới chuyển tới làm quen với khuôn viên trường và phòng học của các môn học.', 'basic', 1),
      (v_id, '在国家高水平科技攻坚行动中，战略科学家与顶尖技术领军人才领衔主持重大攻关课题，充分发挥了科技领头羊的关键牵引作用。', 'Zài guójiā gāo shuǐpíng kējì gōngjiān xíngdòng zhōng, zhànlüè kēxuéjiā yǔ dǐngjiān jìshù lǐngjūn réncái lǐngxián zhǔchí zhòngdà gōngguān kètí, chōngfèn fāhuī le kējì lǐngtóuyáng de guānjiàn qiānyǐn zuòyòng.', 'Trong chiến dịch đột phá khoa học công nghệ trình độ cao cấp quốc gia, các nhà khoa học chiến lược cùng nhân tài dẫn đầu công nghệ đỉnh cao đã đứng đầu chủ trì các đề tài mũi nhọn trọng đại, phát huy trọn vẹn vai trò dẫn dắt then chốt như cánh chim đầu đàn công nghệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2726] [领带] (lǐngdài) - cà vạt, ca-vát [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '领带' AND pinyin = 'lǐngdài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领带' AND pinyin = 'lǐngdài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '领带'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领带'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǐngdài',
      meaning_vi = 'cà vạt, ca-vát',
      example_hanzi = '参加正式商务宴会时，男士通常会穿上深色西装并系上一条雅致的领带。',
      example_pinyin = 'Cānjiā zhèngshì shāngwù yànhuì shí, nánshì tōngcháng huì chuān shàng shēnsè xīzhuāng bìng jì shàng yì tiáo yǎzhì de lǐngdài.',
      example_vi = 'Khi tham gia tiệc chiêu đãi thương mại chính thức, nam giới thông thường sẽ mặc âu phục sẫm màu và thắt một chiếc cà vạt trang nhã.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '领带',
      'lǐngdài',
      'cà vạt, ca-vát',
      'Danh từ',
      'HSK 5',
      '参加正式商务宴会时，男士通常会穿上深色西装并系上一条雅致的领带。',
      'Cānjiā zhèngshì shāngwù yànhuì shí, nánshì tōngcháng huì chuān shàng shēnsè xīzhuāng bìng jì shàng yì tiáo yǎzhì de lǐngdài.',
      'Khi tham gia tiệc chiêu đãi thương mại chính thức, nam giới thông thường sẽ mặc âu phục sẫm màu và thắt một chiếc cà vạt trang nhã.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '参加正式商务宴会时，男士通常会穿上深色西装并系上一条雅致的领带。', 'Cānjiā zhèngshì shāngwù yànhuì shí, nánshì tōngcháng huì chuān shàng shēnsè xīzhuāng bìng jì shàng yì tiáo yǎzhì de lǐngdài.', 'Khi tham gia tiệc chiêu đãi thương mại chính thức, nam giới thông thường sẽ mặc âu phục sẫm màu và thắt một chiếc cà vạt trang nhã.', 'basic', 1),
      (v_id, '在国际多边外交互访与元首峰会的外交礼仪中，服饰细节、西装版型以及领带领结的色系搭配，均严格契合格调典雅的国际惯例礼仪规范。', 'Zài guójì duōbiān wàijiāo hùfǎng yǔ yuánshǒu fēnghuì de wàijiāo lǐyí zhōng, fúshì xìjié, xīzhuāng bǎnxíng yǐjí lǐngdài lǐngjié de sèxì dāpèi, jūn yángé qìhé gédiào diǎnyǎ de guójì guànlì lǐyí guīfàn.', 'Trong nghi thức ngoại giao của các chuyến thăm ngoại giao đa phương quốc tế và hội nghị thượng đỉnh nguyên thủ, từng chi tiết trang phục, phom dáng âu phục cùng việc phối tông màu cà vạt hay nơ đều tuân thủ nghiêm ngặt chuẩn mực lễ tân quốc tế sang trọng và nhã nhặn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2727] [领导] (lǐngdǎo) - lãnh đạo; người lãnh đạo, cấp trên [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '领导' AND pinyin = 'lǐngdǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领导' AND pinyin = 'lǐngdǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '领导'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领导'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'lǐngdǎo',
      meaning_vi = 'lãnh đạo; người lãnh đạo, cấp trên',
      example_hanzi = '在部门领导的关心和指导下，新入职员工迅速适应了日常业务工作。',
      example_pinyin = 'Zài bùmén lǐngdǎo de guānxīn hé zhǐdǎo xià, xīn rùzhí yuángōng xùnsù shìyìng le rìcháng yèwù gōngzuò.',
      example_vi = 'Dưới sự quan tâm và chỉ bảo của lãnh đạo phòng ban, nhân viên mới vào nghề đã nhanh chóng thích nghi với công việc nghiệp vụ thường nhật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '领导',
      'lǐngdǎo',
      'lãnh đạo; người lãnh đạo, cấp trên',
      'Động từ / Danh từ',
      'HSK 5',
      '在部门领导的关心和指导下，新入职员工迅速适应了日常业务工作。',
      'Zài bùmén lǐngdǎo de guānxīn hé zhǐdǎo xià, xīn rùzhí yuángōng xùnsù shìyìng le rìcháng yèwù gōngzuò.',
      'Dưới sự quan tâm và chỉ bảo của lãnh đạo phòng ban, nhân viên mới vào nghề đã nhanh chóng thích nghi với công việc nghiệp vụ thường nhật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在部门领导的关心和指导下，新入职员工迅速适应了日常业务工作。', 'Zài bùmén lǐngdǎo de guānxīn hé zhǐdǎo xià, xīn rùzhí yuángōng xùnsù shìyìng le rìcháng yèwù gōngzuò.', 'Dưới sự quan tâm và chỉ bảo của lãnh đạo phòng ban, nhân viên mới vào nghề đã nhanh chóng thích nghi với công việc nghiệp vụ thường nhật.', 'basic', 1),
      (v_id, '高瞻远瞩的战略领导力在于敏锐把握新一轮科技革命的发展大势，带领企业在百年未有之变局中抢占未来竞争制高点。', 'Gāozhān-yuǎnzhǔ de zhànlüè lǐngdǎolì zàiyú mǐnruì bǎwò xīn yì lún kējì gémìng de fāzhǎn dàshì, dàilǐng qǐyè zài bǎi nián wèiyǒu zhī biànjú zhōng qiǎngzhàn wèilái jìngzhēng zhìgāodiǎn.', 'Năng lực lãnh đạo chiến lược nhìn xa trông rộng thể hiện ở chỗ nắm bắt nhạy bén xu thế phát triển của cuộc cách mạng khoa học công nghệ mới, dẫn dắt doanh nghiệp chiếm lĩnh điểm cao cạnh tranh tương lai giữa cục diện đổi thay trăm năm chưa từng có.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2728] [领取] (lǐngqǔ) - nhận, lĩnh (tiền trợ cấp, giải thưởng, giấy tờ) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '领取' AND pinyin = 'lǐngqǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领取' AND pinyin = 'lǐngqǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '领取'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领取'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'lǐngqǔ',
      meaning_vi = 'nhận, lĩnh (tiền trợ cấp, giải thưởng, giấy tờ)',
      example_hanzi = '请获奖同学持有效学生证到教务办公室领取荣誉证书和奖学金。',
      example_pinyin = 'Qǐng huòjiǎng tóngxué chí yǒuxiào xuéshengzhèng dào jiàowù bàngōngshì lǐngqǔ róngyù zhèngshū hé jiǎngxuéjīn.',
      example_vi = 'Xin mời các bạn học sinh đoạt giải mang thẻ học sinh còn hiệu lực đến văn phòng đào tạo để nhận giấy khen vinh dự và học bổng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '领取',
      'lǐngqǔ',
      'nhận, lĩnh (tiền trợ cấp, giải thưởng, giấy tờ)',
      'Động từ',
      'HSK 5',
      '请获奖同学持有效学生证到教务办公室领取荣誉证书和奖学金。',
      'Qǐng huòjiǎng tóngxué chí yǒuxiào xuéshengzhèng dào jiàowù bàngōngshì lǐngqǔ róngyù zhèngshū hé jiǎngxuéjīn.',
      'Xin mời các bạn học sinh đoạt giải mang thẻ học sinh còn hiệu lực đến văn phòng đào tạo để nhận giấy khen vinh dự và học bổng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请获奖同学持有效学生证到教务办公室领取荣誉证书和奖学金。', 'Qǐng huòjiǎng tóngxué chí yǒuxiào xuéshengzhèng dào jiàowù bàngōngshì lǐngqǔ róngyù zhèngshū hé jiǎngxuéjīn.', 'Xin mời các bạn học sinh đoạt giải mang thẻ học sinh còn hiệu lực đến văn phòng đào tạo để nhận giấy khen vinh dự và học bổng.', 'basic', 1),
      (v_id, '政务服务中心全面推行智能化自助服务终端，群众只需刷脸识别身份，即可在数秒内轻松领取不动产权电子证书。', 'Zhèngwù fúwù zhōngxīn quánmiàn tuīxíng zhìnénghuà zìzhù fúwù zhōngduān, qúnzhòng zhǐxū shuāliǎn shíbié shēnfèn, jíkě zài shù miǎo nèi qīngsōng lǐngqǔ búdòngchǎnquán diànzǐ zhèngshū.', 'Trung tâm dịch vụ hành chính công triển khai toàn diện trạm dịch vụ tự phục vụ thông minh, người dân chỉ cần quét khuôn mặt nhận diện danh tính là có thể dễ dàng nhận giấy chứng nhận quyền sở hữu bất động sản điện tử chỉ trong vài giây.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2729] [领先] (lǐngxiān) - dẫn đầu, đi đầu, vượt lên trước [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '领先' AND pinyin = 'lǐngxiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领先' AND pinyin = 'lǐngxiān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '领先'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领先'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'lǐngxiān',
      meaning_vi = 'dẫn đầu, đi đầu, vượt lên trước',
      example_hanzi = '在男子四百米接力赛中，我们班的运动员凭借默契的交接棒始终保持领先。',
      example_pinyin = 'Zài nánzǐ sìbǎimǐ jièlìsài zhōng, wǒmen bān de yùndòngyuán píngjiè mòqì de jiāojiēbàng shǐzhōng bǎochí lǐngxiān.',
      example_vi = 'Trong cuộc thi chạy tiếp sức 400m nam, các vận động viên lớp chúng tôi nhờ sự phối hợp trao gậy ăn ý đã luôn giữ vững vị trí dẫn đầu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '领先',
      'lǐngxiān',
      'dẫn đầu, đi đầu, vượt lên trước',
      'Động từ',
      'HSK 5',
      '在男子四百米接力赛中，我们班的运动员凭借默契的交接棒始终保持领先。',
      'Zài nánzǐ sìbǎimǐ jièlìsài zhōng, wǒmen bān de yùndòngyuán píngjiè mòqì de jiāojiēbàng shǐzhōng bǎochí lǐngxiān.',
      'Trong cuộc thi chạy tiếp sức 400m nam, các vận động viên lớp chúng tôi nhờ sự phối hợp trao gậy ăn ý đã luôn giữ vững vị trí dẫn đầu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在男子四百米接力赛中，我们班的运动员凭借默契的交接棒始终保持领先。', 'Zài nánzǐ sìbǎimǐ jièlìsài zhōng, wǒmen bān de yùndòngyuán píngjiè mòqì de jiāojiēbàng shǐzhōng bǎochí lǐngxiān.', 'Trong cuộc thi chạy tiếp sức 400m nam, các vận động viên lớp chúng tôi nhờ sự phối hợp trao gậy ăn ý đã luôn giữ vững vị trí dẫn đầu.', 'basic', 1),
      (v_id, '得益于持续高强度的研发投入与全产业链布局，我国在超高压特高压输电工程与动力电池制造技术上已处于世界绝对领先水平。', 'Déyì yú chíxù gāo qiángdù de yánfā tóurù yǔ quán chǎnyèliàn bùjú, wǒ guó zài chāogāoyā tè-gāoyā shūdiàn gōngchéng yǔ dònglì diànchí zhìzào jìshù shang yǐ chǔyú shìjiè juéduì lǐngxiān shuǐpíng.', 'Nhờ vào việc liên tục đầu tư cho nghiên cứu phát triển với cường độ cao và bố trí hoàn chỉnh toàn chuỗi công nghiệp, nước ta trong công trình truyền tải điện siêu cao áp và công nghệ chế tạo pin năng lượng đã đứng ở trình độ dẫn đầu tuyệt đối trên thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2730] [领域] (lǐngyù) - lĩnh vực, phạm vi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '领域' AND pinyin = 'lǐngyù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领域' AND pinyin = 'lǐngyù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '领域'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '领域'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǐngyù',
      meaning_vi = 'lĩnh vực, phạm vi',
      example_hanzi = '王教授在古代汉语语音史研究领域发表了许多具有开创性的学术专著。',
      example_pinyin = 'Wáng jiàoshòu zài gǔdài Hànyǔ yǔyīnshǐ yánjiū lǐngyù fābiǎo le xǔduō jùyǒu kāichuàngxìng de xuéshù zhuānzhù.',
      example_vi = 'Giáo sư Vương trong lĩnh vực nghiên cứu lịch sử ngữ âm Hán ngữ cổ đại đã công bố rất nhiều chuyên khảo học thuật mang tính mở đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '领域',
      'lǐngyù',
      'lĩnh vực, phạm vi',
      'Danh từ',
      'HSK 5',
      '王教授在古代汉语语音史研究领域发表了许多具有开创性的学术专著。',
      'Wáng jiàoshòu zài gǔdài Hànyǔ yǔyīnshǐ yánjiū lǐngyù fābiǎo le xǔduō jùyǒu kāichuàngxìng de xuéshù zhuānzhù.',
      'Giáo sư Vương trong lĩnh vực nghiên cứu lịch sử ngữ âm Hán ngữ cổ đại đã công bố rất nhiều chuyên khảo học thuật mang tính mở đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '王教授在古代汉语语音史研究领域发表了许多具有开创性的学术专著。', 'Wáng jiàoshòu zài gǔdài Hànyǔ yǔyīnshǐ yánjiū lǐngyù fābiǎo le xǔduō jùyǒu kāichuàngxìng de xuéshù zhuānzhù.', 'Giáo sư Vương trong lĩnh vực nghiên cứu lịch sử ngữ âm Hán ngữ cổ đại đã công bố rất nhiều chuyên khảo học thuật mang tính mở đường.', 'basic', 1),
      (v_id, '生成式人工智能与量子计算的深度交融，正在生物靶向制药、航空动力学仿真以及深海探测等尖端科学领域掀起前所未有的范式变革。', 'Shēngchéngxìng réngōng zhìnéng yǔ liàngzǐ jìsuàn de shēndù jiāoróng, zhèngzài shēngwù bǎxiàng zhìyào, hángkōng dònglìxué fǎngzhēn yǐjí shēnhǎi tàncè děng jiānduān kēxué lǐngyù xiānqǐ qiánsuǒwèiyǒu de fànshì biàngé.', 'Sự dung hợp sâu sắc giữa trí tuệ nhân tạo tạo sinh và tính toán lượng tử đang dấy lên một cuộc cải cách mô thức chưa từng có trong các lĩnh vực khoa học mũi nhọn như bào chế thuốc nhắm trúng đích sinh học, mô phỏng khí động lực học hàng không và thám hiểm biển sâu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2731] [令] (lìng) - khiến cho, làm cho; mệnh lệnh, chỉ thị [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '令' AND pinyin = 'lìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '令' AND pinyin = 'lìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '令'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '令'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'lìng',
      meaning_vi = 'khiến cho, làm cho; mệnh lệnh, chỉ thị',
      example_hanzi = '他在关键时刻挺身而出解救落水儿童的英勇行为，令人肃然起敬。',
      example_pinyin = 'Tā zài guānjiàn shíkè tǐngshēn-érchū jiějiù luòshuǐ értóng de yīngyǒng xíngwéi, lìngrén sùrán-qǐjìng.',
      example_vi = 'Hành động dũng cảm dám xông pha trong thời khắc nguy nan cứu giúp em bé ngã nước của anh ấy khiến người ta phải kính cẩn thán phục.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '令',
      'lìng',
      'khiến cho, làm cho; mệnh lệnh, chỉ thị',
      'Động từ / Danh từ',
      'HSK 5',
      '他在关键时刻挺身而出解救落水儿童的英勇行为，令人肃然起敬。',
      'Tā zài guānjiàn shíkè tǐngshēn-érchū jiějiù luòshuǐ értóng de yīngyǒng xíngwéi, lìngrén sùrán-qǐjìng.',
      'Hành động dũng cảm dám xông pha trong thời khắc nguy nan cứu giúp em bé ngã nước của anh ấy khiến người ta phải kính cẩn thán phục.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在关键时刻挺身而出解救落水儿童的英勇行为，令人肃然起敬。', 'Tā zài guānjiàn shíkè tǐngshēn-érchū jiějiù luòshuǐ értóng de yīngyǒng xíngwéi, lìngrén sùrán-qǐjìng.', 'Hành động dũng cảm dám xông pha trong thời khắc nguy nan cứu giúp em bé ngã nước của anh ấy khiến người ta phải kính cẩn thán phục.', 'basic', 1),
      (v_id, '面对局部突发极端暴雨洪涝险情，防汛抗旱应急指挥部以令行禁止的严明纪律迅速调集抢险舟桥部队连夜封堵堤防缺口。', 'Miànduì júbù tūfā jíduān bàoyǔ hónglào xiǎnqíng, fángxùn-kànghàn yìngjí zhǐhuībù yǐ lìngxíng-jìnzhǐ de yánmíng jìlǜ xùnsù diàojí qiǎngxiǎn zhōuqiáo bùduì liányè fēngdǔ dīfáng quēkǒu.', 'Đối mặt với tình thế hiểm nghèo do mưa to lũ lụt cực đoan đột xuất cục bộ gây ra, ban chỉ huy ứng phó lũ lụt hạn hán với kỷ luật nghiêm minh lệnh ban là thi hành đã nhanh chóng điều động bộ đội công binh thuyền cầu xuyên đêm hàn gắn các đoạn đê xung yếu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2732] [流传] (liúchuán) - lưu truyền, truyền lại, lan truyền [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '流传' AND pinyin = 'liúchuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '流传' AND pinyin = 'liúchuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '流传'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '流传'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'liúchuán',
      meaning_vi = 'lưu truyền, truyền lại, lan truyền',
      example_hanzi = '这首优美动听的江南民歌已经在民间流传了数百年。',
      example_pinyin = 'Zhè shǒu yōuměi dòngtīng de Jiāngnán míngē yǐjīng zài mínjiān liúchuán le shù bǎi nián.',
      example_vi = 'Bài dân ca Giang Nam du dương êm tai này đã được lưu truyền trong dân gian suốt mấy trăm năm nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '流传',
      'liúchuán',
      'lưu truyền, truyền lại, lan truyền',
      'Động từ',
      'HSK 5',
      '这首优美动听的江南民歌已经在民间流传了数百年。',
      'Zhè shǒu yōuměi dòngtīng de Jiāngnán míngē yǐjīng zài mínjiān liúchuán le shù bǎi nián.',
      'Bài dân ca Giang Nam du dương êm tai này đã được lưu truyền trong dân gian suốt mấy trăm năm nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这首优美动听的江南民歌已经在民间流传了数百年。', 'Zhè shǒu yōuměi dòngtīng de Jiāngnán míngē yǐjīng zài mínjiān liúchuán le shù bǎi nián.', 'Bài dân ca Giang Nam du dương êm tai này đã được lưu truyền trong dân gian suốt mấy trăm năm nay.', 'basic', 1),
      (v_id, '非物质文化遗产专家通过现代数字化音视频采集与口述史整理技术，让许多濒临失传的古老民族史诗与传统手工技艺得以长久流传存续。', 'Fēiwùzhì wénhuà yíchǎn zhuānjiā tōngguò xiàndài shùzìhuà yīn-shìpín cǎijí yǔ kǒushùshǐ zhěnglǐ jìshù, ràng xǔduō bīnlín shīchuán de gǔlǎo mínzú shǐshī yǔ chuántǒng shǒugōng jìyì déyǐ chángjiǔ liúchuán cúnxù.', 'Các chuyên gia di sản văn hóa phi vật thể thông qua công nghệ thu thập âm thanh hình ảnh số hóa hiện đại và chỉnh lý lịch sử truyền khẩu, đã giúp nhiều pho sử thi dân tộc cổ xưa cùng kỹ nghệ thủ công truyền thống đang bên bờ vực mai một có thể được lưu truyền và tiếp nối dài lâu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2733] [流感] (liúgǎn) - cúm, bệnh cúm (cảm cúm mùa) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '流感' AND pinyin = 'liúgǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '流感' AND pinyin = 'liúgǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '流感'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '流感'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'liúgǎn',
      meaning_vi = 'cúm, bệnh cúm (cảm cúm mùa)',
      example_hanzi = '秋冬季节气温骤降，应当注意开窗通风以预防季节性流感的传播。',
      example_pinyin = 'Qiū-dōng jìjié qìwēn zhòujiàng, yīngdāng zhùyì kāichuāng tōngfēng yǐ yùfáng jìjiéxìng liúgǎn de chuánbō.',
      example_vi = 'Mùa thu đông nhiệt độ giảm đột ngột, nên chú ý mở cửa sổ thông gió để phòng ngừa sự lây lan của cảm cúm theo mùa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '流感',
      'liúgǎn',
      'cúm, bệnh cúm (cảm cúm mùa)',
      'Danh từ',
      'HSK 5',
      '秋冬季节气温骤降，应当注意开窗通风以预防季节性流感的传播。',
      'Qiū-dōng jìjié qìwēn zhòujiàng, yīngdāng zhùyì kāichuāng tōngfēng yǐ yùfáng jìjiéxìng liúgǎn de chuánbō.',
      'Mùa thu đông nhiệt độ giảm đột ngột, nên chú ý mở cửa sổ thông gió để phòng ngừa sự lây lan của cảm cúm theo mùa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '秋冬季节气温骤降，应当注意开窗通风以预防季节性流感的传播。', 'Qiū-dōng jìjié qìwēn zhòujiàng, yīngdāng zhùyì kāichuāng tōngfēng yǐ yùfáng jìjiéxìng liúgǎn de chuánbō.', 'Mùa thu đông nhiệt độ giảm đột ngột, nên chú ý mở cửa sổ thông gió để phòng ngừa sự lây lan của cảm cúm theo mùa.', 'basic', 1),
      (v_id, '疾病预防控制中心通过构建覆盖全国的三维呼吸道传染病监测网络，能够对高变异性流感病毒株实施毫秒级分子基因溯源与靶向疫苗早期研发储备。', 'Jíbìng Yùfáng Kòngzhì Zhōngxīn tōngguò gòujiàn fùgài quánguó de sānwéi hūxīdào chuánrǎnbìng jiāncè wǎngluò, nénggòu duì gāo biànyìxìng liúgǎn bìngdúzhū shíshī háomiǎojí fēnzǐ jīyīn sùyuán yǔ bǎxiàng yìmiáo zǎoqī yánfā chǔbèi.', 'Trung tâm Kiểm soát và Phòng ngừa Dịch bệnh thông qua việc xây dựng mạng lưới giám sát bệnh truyền nhiễm đường hô hấp 3 chiều bao phủ toàn quốc, có thể thực hiện truy vết gen phân tử cấp độ mili giây đối với các chủng virus cúm biến dị cao và nghiên cứu dự trữ sớm vắc xin định hướng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2734] [浏览] (liúlǎn) - lướt xem, duyệt, xem qua [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '浏览' AND pinyin = 'liúlǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '浏览' AND pinyin = 'liúlǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '浏览'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '浏览'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'liúlǎn',
      meaning_vi = 'lướt xem, duyệt, xem qua',
      example_hanzi = '每天早晨上班前，他习惯先快速浏览一下当天的核心新闻要点。',
      example_pinyin = 'Měi tiān zǎochen shàngbān qián, tā xíguàn xiān kuàisù liúlǎn yíxià dāngtiān de héxīn xīnwén yàodiǎn.',
      example_vi = 'Mỗi buổi sáng trước khi đi làm, anh ấy quen lướt nhanh qua các điểm tin tức thời sự cốt lõi trong ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '浏览',
      'liúlǎn',
      'lướt xem, duyệt, xem qua',
      'Động từ',
      'HSK 5',
      '每天早晨上班前，他习惯先快速浏览一下当天的核心新闻要点。',
      'Měi tiān zǎochen shàngbān qián, tā xíguàn xiān kuàisù liúlǎn yíxià dāngtiān de héxīn xīnwén yàodiǎn.',
      'Mỗi buổi sáng trước khi đi làm, anh ấy quen lướt nhanh qua các điểm tin tức thời sự cốt lõi trong ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天早晨上班前，他习惯先快速浏览一下当天的核心新闻要点。', 'Měi tiān zǎochen shàngbān qián, tā xíguàn xiān kuàisù liúlǎn yíxià dāngtiān de héxīn xīnwén yàodiǎn.', 'Mỗi buổi sáng trước khi đi làm, anh ấy quen lướt nhanh qua các điểm tin tức thời sự cốt lõi trong ngày.', 'basic', 1),
      (v_id, '在知识爆炸的大数据时代，学者不仅需要广泛浏览学科交叉前沿文献，更要善于在海量信息中抽丝剥茧提炼出原创性科学问题。', 'Zài zhīshi bàozhà de dàshùjù shídài, xuézhě bùjǐn xūyào guǎngfàn liúlǎn xuékē jiāochā qiányán wénxiàn, gèng yào shànyú zài hǎiliàng xìnxī zhōng chōusī-bōjiǎn tíliàn chū yuánchuàngxìng kēxué wèntí.', 'Trong kỷ nguyên dữ liệu lớn bùng nổ tri thức, học giả không chỉ cần lướt xem rộng rãi các tài liệu tiên phong giao thoa liên ngành, mà càng phải giỏi bóc tách từng lớp thông tin trong khối lượng đồ sộ để chắt lọc ra các vấn đề khoa học có tính sáng tạo nguyên bản.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2735] [留言] (liúyán) - để lại lời nhắn, bình luận; lời nhắn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '留言' AND pinyin = 'liúyán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '留言' AND pinyin = 'liúyán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '留言'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '留言'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'liúyán',
      meaning_vi = 'để lại lời nhắn, bình luận; lời nhắn',
      example_hanzi = '外出如果碰上朋友不在家，可以在门口便签条上留下一段温馨的留言。',
      example_pinyin = 'Wàichū rúguǒ pèngshang péngyou bú zài jiā, kěyǐ zài ménkǒu biànqiāntiáo shang liúxià yí duàn wēnxīn de liúyán.',
      example_vi = 'Ra ngoài nếu gặp lúc bạn không có nhà, có thể để lại một lời nhắn ấm áp trên mảnh giấy ghi chú trước cửa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '留言',
      'liúyán',
      'để lại lời nhắn, bình luận; lời nhắn',
      'Động từ / Danh từ',
      'HSK 5',
      '外出如果碰上朋友不在家，可以在门口便签条上留下一段温馨的留言。',
      'Wàichū rúguǒ pèngshang péngyou bú zài jiā, kěyǐ zài ménkǒu biànqiāntiáo shang liúxià yí duàn wēnxīn de liúyán.',
      'Ra ngoài nếu gặp lúc bạn không có nhà, có thể để lại một lời nhắn ấm áp trên mảnh giấy ghi chú trước cửa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '外出如果碰上朋友不在家，可以在门口便签条上留下一段温馨的留言。', 'Wàichū rúguǒ pèngshang péngyou bú zài jiā, kěyǐ zài ménkǒu biànqiāntiáo shang liúxià yí duàn wēnxīn de liúyán.', 'Ra ngoài nếu gặp lúc bạn không có nhà, có thể để lại một lời nhắn ấm áp trên mảnh giấy ghi chú trước cửa.', 'basic', 1),
      (v_id, '电子政务“领导留言板”已成为践行网上群众路线的重要桥梁，各级职能部门实行全流程闭环办理，切实做到件件有回音、事事有落实。', 'Diànzǐ zhèngwù “Lǐngdǎo Liúyánbǎn” yǐ chéngwéi jiànxíng wǎngshang qúnzhòng lùxiàn de zhòngyào qiáoliáng, gè jí zhíngnéng bùmén shíxíng quán liúchéng bìhuán bànlǐ, qièshí zuòdào jiànjiàn yǒu huíyīn, shìshì yǒu luòshí.', '"Hòm thư điện tử góp ý cho lãnh đạo" trên cổng chính quyền điện tử đã trở thành cây cầu nối quan trọng hiện thực hóa đường lối quần chúng qua mạng, các cơ quan ban ngành thực hiện quy trình xử lý khép kín toàn diện, đảm bảo từng ý kiến đều được hồi âm và từng việc đều được triển khai thực chất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2736] [龙] (lóng) - rồng, loài rồng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '龙' AND pinyin = 'lóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '龙' AND pinyin = 'lóng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '龙'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '龙'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lóng',
      meaning_vi = 'rồng, loài rồng',
      example_hanzi = '端午节赛龙舟是中华民族传承了两千多年的传统民俗体育活动。',
      example_pinyin = 'Duānwǔjié sài lóngzhōu shì Zhōnghuá mínzú chuánchéng le liǎng qiān duō nián de chuántǒng mínsú tǐyù huódòng.',
      example_vi = 'Đua thuyền rồng dịp Tết Đoan ngọ là hoạt động thể thao dân gian truyền thống được dân tộc Trung Hoa lưu truyền hơn 2000 năm nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '龙',
      'lóng',
      'rồng, loài rồng',
      'Danh từ',
      'HSK 5',
      '端午节赛龙舟是中华民族传承了两千多年的传统民俗体育活动。',
      'Duānwǔjié sài lóngzhōu shì Zhōnghuá mínzú chuánchéng le liǎng qiān duō nián de chuántǒng mínsú tǐyù huódòng.',
      'Đua thuyền rồng dịp Tết Đoan ngọ là hoạt động thể thao dân gian truyền thống được dân tộc Trung Hoa lưu truyền hơn 2000 năm nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '端午节赛龙舟是中华民族传承了两千多年的传统民俗体育活动。', 'Duānwǔjié sài lóngzhōu shì Zhōnghuá mínzú chuánchéng le liǎng qiān duō nián de chuántǒng mínsú tǐyù huódòng.', 'Đua thuyền rồng dịp Tết Đoan ngọ là hoạt động thể thao dân gian truyền thống được dân tộc Trung Hoa lưu truyền hơn 2000 năm nay.', 'basic', 1),
      (v_id, '在中国传统文化中，龙象征着威武自强、吉祥腾飞与海纳百川的崇高精神，是凝聚海内外中华儿女文化认同的核心精神图腾。', 'Zài Zhōngguó chuántǒng wénhuà zhōng, lóng xiàngzhēng zhe wēiwǔ zìqiáng, jíxiáng téngfēi yǔ hǎinà-bǎichuān de chónggāo jīngshén, shì níngjù hǎinèiwài Zhōnghuá érnǚ wénhuà rèntóng de héxīn jīngshén túténg.', 'Trong văn hóa truyền thống Trung Hoa, rồng tượng trưng cho tinh thần cao quý uy dũng tự cường, cát tường vươn cao và dung nạp trăm sông, là biểu tượng vật tổ tinh thần cốt lõi gắn kết bản sắc văn hóa của những người con đất Việt - Hoa trong và ngoài nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2737] [漏] (lòu) - rò rỉ, chảy dột; sót, bỏ sót [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '漏' AND pinyin = 'lòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '漏' AND pinyin = 'lòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '漏'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '漏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'lòu',
      meaning_vi = 'rò rỉ, chảy dột; sót, bỏ sót',
      example_hanzi = '连日的大雨导致这间老房子的屋顶开始滴滴答答地往下漏水。',
      example_pinyin = 'Liánrì de dàyǔ dǎozhì zhè jiān lǎo fángzi de wūdǐng kāishǐ dīdī-dādā de wǎng xià lòushuǐ.',
      example_vi = 'Cơn mưa lớn kéo dài nhiều ngày khiến mái của ngôi nhà cũ này bắt đầu dột nước tí tách xuống sàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '漏',
      'lòu',
      'rò rỉ, chảy dột; sót, bỏ sót',
      'Động từ',
      'HSK 5',
      '连日的大雨导致这间老房子的屋顶开始滴滴答答地往下漏水。',
      'Liánrì de dàyǔ dǎozhì zhè jiān lǎo fángzi de wūdǐng kāishǐ dīdī-dādā de wǎng xià lòushuǐ.',
      'Cơn mưa lớn kéo dài nhiều ngày khiến mái của ngôi nhà cũ này bắt đầu dột nước tí tách xuống sàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '连日的大雨导致这间老房子的屋顶开始滴滴答答地往下漏水。', 'Liánrì de dàyǔ dǎozhì zhè jiān lǎo fángzi de wūdǐng kāishǐ dīdī-dādā de wǎng xià lòushuǐ.', 'Cơn mưa lớn kéo dài nhiều ngày khiến mái của ngôi nhà cũ này bắt đầu dột nước tí tách xuống sàn.', 'basic', 1),
      (v_id, '在严格的信息安全审计体系下，任何核心业务数据库必须部署全天候防泄密探针，决不允许关键用户数据发生哪怕一次泄漏风险。', 'Zài yángé de xìnxī ānquán shěnjì tǐxì xià, rènhé héxīn yèwù shùjùkù bìxū bùshǔ quántiānhòu fáng xièmì tànzhēn, jué bù yǔnxǔ guānjiàn yònghù shùjù fāshēng nǎpà yí cì xièlòu fēngxiǎn.', 'Dưới hệ thống kiểm toán an ninh thông tin nghiêm ngặt, bất kỳ cơ sở dữ liệu nghiệp vụ cốt lõi nào cũng bắt buộc phải triển khai đầu dò chống rò rỉ 24/7, tuyệt đối không cho phép dữ liệu người dùng then chốt xảy ra nguy cơ rò rỉ dù chỉ một lần.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2738] [录] (lù) - ghi âm, ghi hình, chép lại; tuyển dụng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '录' AND pinyin = 'lù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '录' AND pinyin = 'lù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '录'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '录'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'lù',
      meaning_vi = 'ghi âm, ghi hình, chép lại; tuyển dụng',
      example_hanzi = '歌手正在专业的隔音录音棚里录制自己的最新个人专辑。',
      example_pinyin = 'Gēshǒu zhèngzài zhuānyè de géyīn lùyīnpéng lǐ lùzhì zìjǐ de zuìxīn gèrén zhuānjí.',
      example_vi = 'Ca sĩ đang thu âm album cá nhân mới nhất của mình trong phòng thu cách âm chuyên nghiệp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '录',
      'lù',
      'ghi âm, ghi hình, chép lại; tuyển dụng',
      'Động từ',
      'HSK 5',
      '歌手正在专业的隔音录音棚里录制自己的最新个人专辑。',
      'Gēshǒu zhèngzài zhuānyè de géyīn lùyīnpéng lǐ lùzhì zìjǐ de zuìxīn gèrén zhuānjí.',
      'Ca sĩ đang thu âm album cá nhân mới nhất của mình trong phòng thu cách âm chuyên nghiệp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '歌手正在专业的隔音录音棚里录制自己的最新个人专辑。', 'Gēshǒu zhèngzài zhuānyè de géyīn lùyīnpéng lǐ lùzhì zìjǐ de zuìxīn gèrén zhuānjí.', 'Ca sĩ đang thu âm album cá nhân mới nhất của mình trong phòng thu cách âm chuyên nghiệp.', 'basic', 1),
      (v_id, '最高人民法院要求各级审判法庭全面实现“每庭必录”，依托智能语音转写与高清视音频同步录存技术，确保每一次司法庭审全过程规范留痕。', 'Zuìgāo Rénmín Fǎyuàn yāoqiú gè jí shěnpàn fǎtíng quánmiàn shíxiàn “měi tíng bì lù”, yītuō zhìnéng yǔyīn zhuǎnxiě yǔ gāoqīng shì-yīnpín tóngbù lùcún jìshù, quèbǎo měi yí cì sīfǎ tíngshěn quán guòchéng guīfàn liúhén.', 'Tòa án Nhân dân Tối cao yêu cầu các phòng xét xử các cấp thực hiện đầy đủ "phiên tòa nào cũng phải ghi âm ghi hình", dựa vào công nghệ chuyển đổi giọng nói thông minh thành văn bản và lưu trữ đồng bộ video âm thanh độ nét cao, đảm bảo từng phiên tòa tư pháp đều lưu lại dấu vết quy chuẩn trong toàn bộ tiến trình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2739] [陆地] (lùdì) - lục địa, đất liền [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '陆地' AND pinyin = 'lùdì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '陆地' AND pinyin = 'lùdì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '陆地'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '陆地'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lùdì',
      meaning_vi = 'lục địa, đất liền',
      example_hanzi = '地球表面的面积由广阔的海洋和大约百分之二十九的陆地共同组成。',
      example_pinyin = 'Dìqiú biǎomiàn de miànjī yóu guǎngkuò de hǎiyáng hé dàyuē bǎifēnzhī èrshíjiǔ de lùdì gòngtóng zǔchéng.',
      example_vi = 'Diện tích bề mặt Trái Đất do đại dương bao la và khoảng 29% đất liền cùng hợp thành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '陆地',
      'lùdì',
      'lục địa, đất liền',
      'Danh từ',
      'HSK 5',
      '地球表面的面积由广阔的海洋和大约百分之二十九的陆地共同组成。',
      'Dìqiú biǎomiàn de miànjī yóu guǎngkuò de hǎiyáng hé dàyuē bǎifēnzhī èrshíjiǔ de lùdì gòngtóng zǔchéng.',
      'Diện tích bề mặt Trái Đất do đại dương bao la và khoảng 29% đất liền cùng hợp thành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '地球表面的面积由广阔的海洋和大约百分之二十九的陆地共同组成。', 'Dìqiú biǎomiàn de miànjī yóu guǎngkuò de hǎiyáng hé dàyuē bǎifēnzhī èrshíjiǔ de lùdì gòngtóng zǔchéng.', 'Diện tích bề mặt Trái Đất do đại dương bao la và khoảng 29% đất liền cùng hợp thành.', 'basic', 1),
      (v_id, '全球陆地生态系统在涵养水源、防风固沙以及吸收大气温室气体方面承担着至关重要的自然生态屏障功能。', 'Quánqiú lùdì shēngtài xìtǒng zài hányǎng shuǐyuán, fángfēng-gùshā yǐjí xīshōu dàqì wēnshì qìtǐ fāngmiàn chéngdān zhe zhìguān-zhòngyào de zìrán shēngtài píngzhàng gōngnéng.', 'Hệ sinh thái đất liền toàn cầu gánh vác chức năng bình phong sinh thái tự nhiên đặc biệt quan trọng trong việc bảo tồn nguồn nước, chắn gió giữ cát và hấp thụ khí nhà kính trong bầu khí quyển.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2740] [录取] (lùqǔ) - trúng tuyển, tuyển chọn, nhận vào học [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '录取' AND pinyin = 'lùqǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '录取' AND pinyin = 'lùqǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '录取'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '录取'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'lùqǔ',
      meaning_vi = 'trúng tuyển, tuyển chọn, nhận vào học',
      example_hanzi = '收到心仪大学的正式录取通知书时，全家人都激动地欢呼雀跃。',
      example_pinyin = 'Shōudào xīnyí dàxué de zhèngshì lùqǔ tōngzhīshū shí, quán jiārén dōu jīdòng de huānhū-quèyuè.',
      example_vi = 'Khi nhận được giấy báo trúng tuyển chính thức của trường đại học hằng mơ ước, cả nhà đều vui sướng reo hò nhảy múa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '录取',
      'lùqǔ',
      'trúng tuyển, tuyển chọn, nhận vào học',
      'Động từ',
      'HSK 5',
      '收到心仪大学的正式录取通知书时，全家人都激动地欢呼雀跃。',
      'Shōudào xīnyí dàxué de zhèngshì lùqǔ tōngzhīshū shí, quán jiārén dōu jīdòng de huānhū-quèyuè.',
      'Khi nhận được giấy báo trúng tuyển chính thức của trường đại học hằng mơ ước, cả nhà đều vui sướng reo hò nhảy múa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '收到心仪大学的正式录取通知书时，全家人都激动地欢呼雀跃。', 'Shōudào xīnyí dàxué de zhèngshì lùqǔ tōngzhīshū shí, quán jiārén dōu jīdòng de huānhū-quèyuè.', 'Khi nhận được giấy báo trúng tuyển chính thức của trường đại học hằng mơ ước, cả nhà đều vui sướng reo hò nhảy múa.', 'basic', 1),
      (v_id, '国家普通高校招生录取工作严格执行阳光招生政策，坚持分数面前人人平等与全程公开透明，坚决维护教育公平与广大考生切身权益。', 'Guójiā pǔtōng gāoxiào zhāoshēng lùqǔ gōngzuò yángé zhíxíng yángguāng zhāoshēng zhèngcè, jiānchí fēnshù miànqián rénrén píngděng yǔ quánchéng gōngkāi tòumíng, jiānjué wéihù jiàoyù gōngpíng yǔ guǎngdà kǎoshēng qièshēn quányì.', 'Công tác tuyển sinh đại học công lập quốc gia thực hiện nghiêm túc chính sách tuyển sinh minh bạch, kiên trì trước điểm số mọi người đều bình đẳng và công khai toàn bộ tiến trình, kiên quyết bảo vệ sự công bằng giáo dục cùng quyền lợi thiết thực của đông đảo thí sinh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2741] [路人] (lùrén) - người qua đường, người đi đường [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '路人' AND pinyin = 'lùrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '路人' AND pinyin = 'lùrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '路人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '路人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lùrén',
      meaning_vi = 'người qua đường, người đi đường',
      example_hanzi = '在陌生城市迷路时，不妨礼貌地向路人询问正确的行走方向。',
      example_pinyin = 'Zài mòshēng chéngshì mílù shí, bùfáng lǐmào de xiàng lùrén xúnwèn zhèngquè de xíngzǒu fāngxiàng.',
      example_vi = 'Khi bị lạc đường ở một thành phố xa lạ, bạn có thể lịch sự hỏi thăm người qua đường về phương hướng đi lại chính xác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '路人',
      'lùrén',
      'người qua đường, người đi đường',
      'Danh từ',
      'HSK 5',
      '在陌生城市迷路时，不妨礼貌地向路人询问正确的行走方向。',
      'Zài mòshēng chéngshì mílù shí, bùfáng lǐmào de xiàng lùrén xúnwèn zhèngquè de xíngzǒu fāngxiàng.',
      'Khi bị lạc đường ở một thành phố xa lạ, bạn có thể lịch sự hỏi thăm người qua đường về phương hướng đi lại chính xác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在陌生城市迷路时，不妨礼貌地向路人询问正确的行走方向。', 'Zài mòshēng chéngshì mílù shí, bùfáng lǐmào de xiàng lùrén xúnwèn zhèngquè de xíngzǒu fāngxiàng.', 'Khi bị lạc đường ở một thành phố xa lạ, bạn có thể lịch sự hỏi thăm người qua đường về phương hướng đi lại chính xác.', 'basic', 1),
      (v_id, '见义勇为基金会对三位在冰冷湍急河流中合力救起落水儿童的普通路人给予了公开表彰与重奖，弘扬了社会崇德向善的正能量。', 'Jiànyì-yǒngwéi jījīnhuì duì sān wèi zài bīnglěng tuānjí héliú zhōng hélì jiùqǐ luòshuǐ értóng de pǔtōng lùrén jǐyǔ le gōngkāi biǎozhāng yǔ zhòngjiǎng, hóngyáng le shèhuì chóngdé-xiàngshàn de zhèngnéngliàng.', 'Quỹ người tốt việc tốt dũng cảm đã tuyên dương công khai và trọng thưởng cho ba người đi đường bình dị đã chung sức cứu sống em bé ngã xuống dòng sông lạnh buốt chảy xiết, lan tỏa nguồn năng lượng tích cực hướng thiện đề cao đạo đức xã hội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2742] [路线] (lùxiàn) - tuyến đường, lộ trình; đường lối [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '路线' AND pinyin = 'lùxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '路线' AND pinyin = 'lùxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '路线'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '路线'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lùxiàn',
      meaning_vi = 'tuyến đường, lộ trình; đường lối',
      example_hanzi = '出发去郊游前，大家用手机地图提前规划好了最优的行驶路线。',
      example_pinyin = 'Chūfā qù jiāoyóu qián, dàjiā yòng shǒujī dìtú tíqián guīhuà hǎo le zuìyōu de xíngshǐ lùxiàn.',
      example_vi = 'Trước khi xuất phát đi dã ngoại, mọi người đã dùng bản đồ trên điện thoại để lên kế hoạch trước cho lộ trình di chuyển tối ưu nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '路线',
      'lùxiàn',
      'tuyến đường, lộ trình; đường lối',
      'Danh từ',
      'HSK 5',
      '出发去郊游前，大家用手机地图提前规划好了最优的行驶路线。',
      'Chūfā qù jiāoyóu qián, dàjiā yòng shǒujī dìtú tíqián guīhuà hǎo le zuìyōu de xíngshǐ lùxiàn.',
      'Trước khi xuất phát đi dã ngoại, mọi người đã dùng bản đồ trên điện thoại để lên kế hoạch trước cho lộ trình di chuyển tối ưu nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出发去郊游前，大家用手机地图提前规划好了最优的行驶路线。', 'Chūfā qù jiāoyóu qián, dàjiā yòng shǒujī dìtú tíqián guīhuà hǎo le zuìyōu de xíngshǐ lùxiàn.', 'Trước khi xuất phát đi dã ngoại, mọi người đã dùng bản đồ trên điện thoại để lên kế hoạch trước cho lộ trình di chuyển tối ưu nhất.', 'basic', 1),
      (v_id, '在关键核心技术攻坚中，必须紧密跟踪全球前沿科技演进趋势，科学论证技术路线，避免因路线误判而错失战略机遇。', 'Zài guānjiàn héxīn jìshù gōngjiān zhōng, bìxū jǐnmì gēnzōng quánqiú qiányán kējì yǎnjìn qūshì, kēxué lùnzhèng jìshù lùxiàn, bìmǐan yīn lùxiàn wùpàn ér cuòshī zhànlüè jīyù.', 'Trong cuộc đột phá công nghệ cốt lõi then chốt, đòi hỏi phải theo sát xu thế phát triển công nghệ tiên phong toàn cầu, luận chứng khoa học lộ trình kỹ thuật, tránh vì đánh giá sai lầm về lộ trình mà bỏ lỡ cơ hội chiến lược.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2743] [陆续] (lùxù) - lần lượt, nối tiếp nhau, dần dà [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '陆续' AND pinyin = 'lùxù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '陆续' AND pinyin = 'lùxù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '陆续'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '陆续'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'lùxù',
      meaning_vi = 'lần lượt, nối tiếp nhau, dần dà',
      example_hanzi = '早晨七点半左右，学生们背着书包陆续走进学校大门。',
      example_pinyin = 'Zǎochen qī diǎn bàn zuǒyòu, xuéshengmen bēi zhe shūbāo lùxù zǒujìn xuéxiào dàmén.',
      example_vi = 'Khoảng 7 giờ 30 sáng, các bạn học sinh đeo cặp sách lần lượt bước vào cổng trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '陆续',
      'lùxù',
      'lần lượt, nối tiếp nhau, dần dà',
      'Phó từ',
      'HSK 5',
      '早晨七点半左右，学生们背着书包陆续走进学校大门。',
      'Zǎochen qī diǎn bàn zuǒyòu, xuéshengmen bēi zhe shūbāo lùxù zǒujìn xuéxiào dàmén.',
      'Khoảng 7 giờ 30 sáng, các bạn học sinh đeo cặp sách lần lượt bước vào cổng trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '早晨七点半左右，学生们背着书包陆续走进学校大门。', 'Zǎochen qī diǎn bàn zuǒyòu, xuéshengmen bēi zhe shūbāo lùxù zǒujìn xuéxiào dàmén.', 'Khoảng 7 giờ 30 sáng, các bạn học sinh đeo cặp sách lần lượt bước vào cổng trường.', 'basic', 1),
      (v_id, '随着多项支持民营经济高质量发展的精准金融扶持政策陆续落地见效，实体企业的投资信心正在稳步回升。', 'Suízhe duō xiàng zhīchí mínyíng jīngjì gāo zhìliàng fāzhǎn de jīngzhǔn jīnróng fúchí zhèngcè lùxù luòdì jiànxiào, shítǐ qǐyè de tóuzī xìnxīn zhèngzài wěnbù huíshēng.', 'Cùng với việc nhiều chính sách tài chính trúng đích hỗ trợ kinh tế tư nhân phát triển chất lượng cao lần lượt đi vào thực tiễn phát huy hiệu quả, niềm tin đầu tư của các doanh nghiệp sản xuất kinh doanh đang phục hồi vững chắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2744] [录音] (lùyīn) - ghi âm; bản ghi âm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '录音' AND pinyin = 'lùyīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '录音' AND pinyin = 'lùyīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '录音'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '录音'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'lùyīn',
      meaning_vi = 'ghi âm; bản ghi âm',
      example_hanzi = '上英语听力课时，老师播放了一段发音地道的对话录音。',
      example_pinyin = 'Shàng Yīngyǔ tīnglìkè shí, lǎoshī bōfàng le yí duàn fāyīn dìdao de duìhuà lùyīn.',
      example_vi = 'Trong giờ học nghe tiếng Anh, cô giáo đã bật một đoạn băng ghi âm đối thoại có phát âm chuẩn bản địa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '录音',
      'lùyīn',
      'ghi âm; bản ghi âm',
      'Động từ / Danh từ',
      'HSK 5',
      '上英语听力课时，老师播放了一段发音地道的对话录音。',
      'Shàng Yīngyǔ tīnglìkè shí, lǎoshī bōfàng le yí duàn fāyīn dìdao de duìhuà lùyīn.',
      'Trong giờ học nghe tiếng Anh, cô giáo đã bật một đoạn băng ghi âm đối thoại có phát âm chuẩn bản địa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '上英语听力课时，老师播放了一段发音地道的对话录音。', 'Shàng Yīngyǔ tīnglìkè shí, lǎoshī bōfàng le yí duàn fāyīn dìdao de duìhuà lùyīn.', 'Trong giờ học nghe tiếng Anh, cô giáo đã bật một đoạn băng ghi âm đối thoại có phát âm chuẩn bản địa.', 'basic', 1),
      (v_id, '在民商事诉讼案件举证质证中，未经对方当事人明确知晓的私下录音资料若要作为合法证据采纳，必须严格接受真实性、关联性与合法性的司法审查。', 'Zài mín-shāngshì sùsòng ànjiàn jǔzhèng zhìzhèng zhōng, wèijīng duìfāng dāngshìrén míngquè zhīxiǎo de sīxià lùyīn zīliào ruò yào zuòwéi héfǎ zhèngjù cǎinà, bìxū yángé jiēshòu zhēnshíxìng, guānliánxìng yǔ héfǎxìng de sīfǎ shěnchá.', 'Trong hoạt động đối chất và đưa ra chứng cứ của các vụ kiện dân sự thương mại, tài liệu ghi âm lén không qua sự đồng ý rõ ràng của đương sự bên kia nếu muốn được chấp nhận làm bằng chứng hợp pháp thì bắt buộc phải trải qua sự thẩm tra tư pháp nghiêm ngặt về tính chân thực, tính liên quan và tính hợp pháp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2745] [旅行社] (lǚxíngshè) - công ty du lịch, công ty lữ hành [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '旅行社' AND pinyin = 'lǚxíngshè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '旅行社' AND pinyin = 'lǚxíngshè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '旅行社'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '旅行社'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lǚxíngshè',
      meaning_vi = 'công ty du lịch, công ty lữ hành',
      example_hanzi = '为了省心，我们全家选择报名参加了一家正规旅行社的北京五日游。',
      example_pinyin = 'Wèile shěngxīn, wǒmen quánjiā xuǎnzé bàomíng cānjiā le yì jiā zhèngguī lǚxíngshè de Běijīng wǔ rì yóu.',
      example_vi = 'Để đỡ mất công lo toan, cả nhà chúng tôi lựa chọn đăng ký tham gia tour du lịch Bắc Kinh 5 ngày của một công ty lữ hành chính quy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '旅行社',
      'lǚxíngshè',
      'công ty du lịch, công ty lữ hành',
      'Danh từ',
      'HSK 5',
      '为了省心，我们全家选择报名参加了一家正规旅行社的北京五日游。',
      'Wèile shěngxīn, wǒmen quánjiā xuǎnzé bàomíng cānjiā le yì jiā zhèngguī lǚxíngshè de Běijīng wǔ rì yóu.',
      'Để đỡ mất công lo toan, cả nhà chúng tôi lựa chọn đăng ký tham gia tour du lịch Bắc Kinh 5 ngày của một công ty lữ hành chính quy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了省心，我们全家选择报名参加了一家正规旅行社的北京五日游。', 'Wèile shěngxīn, wǒmen quánjiā xuǎnzé bàomíng cānjiā le yì jiā zhèngguī lǚxíngshè de Běijīng wǔ rì yóu.', 'Để đỡ mất công lo toan, cả nhà chúng tôi lựa chọn đăng ký tham gia tour du lịch Bắc Kinh 5 ngày của một công ty lữ hành chính quy.', 'basic', 1),
      (v_id, '为规范文化旅游市场秩序，文化和旅游部对个别旅行社诱导游客强制购物与恶性低价竞争等违法违规行为进行了依法严厉整顿取缔。', 'Wèi guīfàn wénhuà lǚyóu shìchǎng zhìxù, Wénhuà hé Lǚyóubù duì gèbié lǚxíngshè yòudǎo yóukè qiángzhì gòuwù yǔ èxìng dījià jìngzhēng děng wéifǎ wéiguī xíngwéi jìnxíng le yīfǎ yánlì zhěngdùn qǔdì.', 'Nhằm chấn chỉnh trật tự thị trường du lịch văn hóa, Bộ Văn hóa và Du lịch đã xử lý nghiêm minh theo pháp luật các hành vi vi phạm như dụ dỗ ép buộc du khách mua sắm và cạnh tranh giá rẻ độc hại của một số công ty du lịch.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2746] [论文] (lùnwén) - luận văn, bài báo khoa học, chuyên khảo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '论文' AND pinyin = 'lùnwén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '论文' AND pinyin = 'lùnwén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '论文'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '论文'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'lùnwén',
      meaning_vi = 'luận văn, bài báo khoa học, chuyên khảo',
      example_hanzi = '经过半年的调研与修改，他终于顺利完成了硕士毕业论文的撰写。',
      example_pinyin = 'Jīngguò bàn nián de diàoyán yǔ xiūgǎi, tā zhōngyú shùnlì wánchéng le shuòshì bìyè lùnwén de zhuànxiě.',
      example_vi = 'Qua nửa năm khảo sát thực tế và chỉnh sửa, anh ấy cuối cùng đã hoàn tất thuận lợi việc viết luận văn tốt nghiệp thạc sĩ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '论文',
      'lùnwén',
      'luận văn, bài báo khoa học, chuyên khảo',
      'Danh từ',
      'HSK 5',
      '经过半年的调研与修改，他终于顺利完成了硕士毕业论文的撰写。',
      'Jīngguò bàn nián de diàoyán yǔ xiūgǎi, tā zhōngyú shùnlì wánchéng le shuòshì bìyè lùnwén de zhuànxiě.',
      'Qua nửa năm khảo sát thực tế và chỉnh sửa, anh ấy cuối cùng đã hoàn tất thuận lợi việc viết luận văn tốt nghiệp thạc sĩ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过半年的调研与修改，他终于顺利完成了硕士毕业论文的撰写。', 'Jīngguò bàn nián de diàoyán yǔ xiūgǎi, tā zhōngyú shùnlì wánchéng le shuòshì bìyè lùnwén de zhuànxiě.', 'Qua nửa năm khảo sát thực tế và chỉnh sửa, anh ấy cuối cùng đã hoàn tất thuận lợi việc viết luận văn tốt nghiệp thạc sĩ.', 'basic', 1),
      (v_id, '该科研团队在国际顶尖学术期刊上发表了题为拓扑量子超导新态的高水平研究论文，引发了全球凝聚态物理学界的强烈反响。', 'Gāi kēyán tuánduì zài guójì dǐngjiān xuéshù qīkān shang fābiǎo le tíwéi tuòpū liàngzǐ chāodǎo xīntài de gāo shuǐpíng yánjiū lùnwén, yǐnfā le quánqiú níngjùtài wùlǐxué jiè de qiángliè fǎnxiǎng.', 'Nhóm nghiên cứu khoa học này đã công bố một bài báo học thuật trình độ cao mang tựa đề về trạng thái mới siêu dẫn lượng tử tô pô trên tạp chí học thuật hàng đầu thế giới, dấy lên tiếng vang mạnh mẽ trong giới vật lý chất ngưng tụ toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2747] [逻辑] (luójí) - logic, quy luật logic, tư duy logic [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '逻辑' AND pinyin = 'luójí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '逻辑' AND pinyin = 'luójí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '逻辑'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '逻辑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'luójí',
      meaning_vi = 'logic, quy luật logic, tư duy logic',
      example_hanzi = '写议论文时必须注意论点明确、论据充分且前后逻辑严密。',
      example_pinyin = 'Xiě yìlùnwén shí bìxū zhùyì lùndiǎn míngquè, lùnjù chōngfèn qiě qiánhòu luójí yánmì.',
      example_vi = 'Khi viết văn nghị luận bắt buộc phải chú ý luận điểm rõ ràng, luận cứ xác đáng và logic trước sau chặt chẽ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '逻辑',
      'luójí',
      'logic, quy luật logic, tư duy logic',
      'Danh từ',
      'HSK 5',
      '写议论文时必须注意论点明确、论据充分且前后逻辑严密。',
      'Xiě yìlùnwén shí bìxū zhùyì lùndiǎn míngquè, lùnjù chōngfèn qiě qiánhòu luójí yánmì.',
      'Khi viết văn nghị luận bắt buộc phải chú ý luận điểm rõ ràng, luận cứ xác đáng và logic trước sau chặt chẽ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '写议论文时必须注意论点明确、论据充分且前后逻辑严密。', 'Xiě yìlùnwén shí bìxū zhùyì lùndiǎn míngquè, lùnjù chōngfèn qiě qiánhòu luójí yánmì.', 'Khi viết văn nghị luận bắt buộc phải chú ý luận điểm rõ ràng, luận cứ xác đáng và logic trước sau chặt chẽ.', 'basic', 1),
      (v_id, '现代法律制度的建构深刻遵循权利义务相一致的底层逻辑，确保每一个司法条文都在严谨的形式逻辑与公平正义的价值追求中实现高度自洽。', 'Xiàndài fǎlǜ zhìdù de jiàngòu shēnkè zūnxún quánlì yìwù xiāng yīzhì de dǐcéng luójí, quèbǎo měi yí gè sīfǎ tiáowén dōu zài yánjǐn de xíngshì luójí yǔ gōngpíng-zhèngyì de jiàzhí zhuīqiú zhōng shíxiàn gāodù zìqià.', 'Việc xây dựng hệ thống pháp luật hiện đại tuân thủ sâu sắc logic nền tảng về sự thống nhất giữa quyền lợi và nghĩa vụ, bảo đảm từng điều khoản tư pháp đều đạt được sự tự nhất quán cao độ giữa logic hình thức chặt chẽ cùng giá trị theo đuổi công bằng chính nghĩa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2748] [骂] (mà) - mắng, chửi, quở trách [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '骂' AND pinyin = 'mà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '骂' AND pinyin = 'mà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '骂'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '骂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'mà',
      meaning_vi = 'mắng, chửi, quở trách',
      example_hanzi = '教育犯了错误的孩子时要耐心讲清道理，千万不要随意大声责骂。',
      example_pinyin = 'Jiàoyù fàn le cuòwù de háizi shí yào nàixīn jiǎng qīng dàolǐ, qiānwàn bú yào suíyì dàshēng zémà.',
      example_vi = 'Khi giáo dục đứa trẻ mắc lỗi cần phải kiên nhẫn giảng giải rõ đạo lý, tuyệt đối không nên tùy tiện lớn tiếng mắng mỏ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '骂',
      'mà',
      'mắng, chửi, quở trách',
      'Động từ',
      'HSK 5',
      '教育犯了错误的孩子时要耐心讲清道理，千万不要随意大声责骂。',
      'Jiàoyù fàn le cuòwù de háizi shí yào nàixīn jiǎng qīng dàolǐ, qiānwàn bú yào suíyì dàshēng zémà.',
      'Khi giáo dục đứa trẻ mắc lỗi cần phải kiên nhẫn giảng giải rõ đạo lý, tuyệt đối không nên tùy tiện lớn tiếng mắng mỏ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '教育犯了错误的孩子时要耐心讲清道理，千万不要随意大声责骂。', 'Jiàoyù fàn le cuòwù de háizi shí yào nàixīn jiǎng qīng dàolǐ, qiānwàn bú yào suíyì dàshēng zémà.', 'Khi giáo dục đứa trẻ mắc lỗi cần phải kiên nhẫn giảng giải rõ đạo lý, tuyệt đối không nên tùy tiện lớn tiếng mắng mỏ.', 'basic', 1),
      (v_id, '网络文明建设坚决抵制任何形式的匿名网络暴力与人身攻击辱骂，依法维护清朗健康的网络生态空间。', 'Wǎngluò wénmíng jiànshè jiānjué dǐzhì rènhé xíngshì de nìmíng wǎngluò bàolì yǔ rénshēn gōngjī rǔmà, yīfǎ wéihù qīnglǎng jiànkāng de wǎngluò shēngtài kōngjiān.', 'Công cuộc xây dựng văn minh mạng kiên quyết bài trừ mọi hình thức bạo lực mạng ẩn danh và lăng mạ tấn công nhân phẩm, bảo vệ không gian sinh thái mạng trong lành lành mạnh theo đúng quy định của pháp luật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2749] [买卖] (mǎimai) - buôn bán, kinh doanh; vụ giao dịch [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '买卖' AND pinyin = 'mǎimai'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '买卖' AND pinyin = 'mǎimai'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '买卖'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '买卖'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'mǎimai',
      meaning_vi = 'buôn bán, kinh doanh; vụ giao dịch',
      example_hanzi = '集市上的小商贩们正在热情招揽顾客，街头买卖十分红火。',
      example_pinyin = 'Jíshì shang de xiǎo shāngfànmen zhèngzài rèqíng zhāolǎn gùkè, jiētóu mǎimai shífēn hónghuǒ.',
      example_vi = 'Các tiểu thương trên khu chợ phiên đang nhiệt tình mời chào khách hàng, chuyện buôn bán nơi góc phố vô cùng tấp nập phát đạt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '买卖',
      'mǎimai',
      'buôn bán, kinh doanh; vụ giao dịch',
      'Danh từ',
      'HSK 5',
      '集市上的小商贩们正在热情招揽顾客，街头买卖十分红火。',
      'Jíshì shang de xiǎo shāngfànmen zhèngzài rèqíng zhāolǎn gùkè, jiētóu mǎimai shífēn hónghuǒ.',
      'Các tiểu thương trên khu chợ phiên đang nhiệt tình mời chào khách hàng, chuyện buôn bán nơi góc phố vô cùng tấp nập phát đạt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '集市上的小商贩们正在热情招揽顾客，街头买卖十分红火。', 'Jíshì shang de xiǎo shāngfànmen zhèngzài rèqíng zhāolǎn gùkè, jiētóu mǎimai shífēn hónghuǒ.', 'Các tiểu thương trên khu chợ phiên đang nhiệt tình mời chào khách hàng, chuyện buôn bán nơi góc phố vô cùng tấp nập phát đạt.', 'basic', 1),
      (v_id, '现代合同法明确规定买卖合同双方当事人应当遵循自愿、公平、诚实信用的民商事交易基本原则。', 'Xiàndài hétongfǎ míngquè guīdìng mǎimai hétong shuāngfāng dāngshìrén yīngdāng zūnxún zìyuàn, gōngpíng, chéngshí xìnyòng de mín-shāngshì jiāoyì jīběn yuánzé.', 'Luật Hợp đồng hiện đại quy định rõ ràng rằng các bên tham gia ký kết hợp đồng mua bán phải tuân thủ các nguyên tắc cơ bản trong giao dịch dân sự thương mại như tự nguyện, công bằng và trung thực giữ chữ tín.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2750] [满足] (mǎnzú) - làm thỏa mãn, đáp ứng; hài lòng, mãn nguyện [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '满足' AND pinyin = 'mǎnzú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '满足' AND pinyin = 'mǎnzú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '满足'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '满足'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'mǎnzú',
      meaning_vi = 'làm thỏa mãn, đáp ứng; hài lòng, mãn nguyện',
      example_hanzi = '无论取得多么优秀的成绩，在求知治学的道路上都决不能轻易自满自足。',
      example_pinyin = 'Wúlùn qǔdé duōme yōuxiù de chéngjì, zài qiúzhī-zhìxué de dàolù shang dōu jué bùnéng qīngyì zìmǎn-zìzú.',
      example_vi = 'Bất luận giành được thành tích xuất sắc đến đâu, trên con đường tìm kiếm tri thức và nghiên cứu học thuật đều tuyệt đối không thể dễ dàng tự thỏa mãn với bản thân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '满足',
      'mǎnzú',
      'làm thỏa mãn, đáp ứng; hài lòng, mãn nguyện',
      'Động từ / Tính từ',
      'HSK 5',
      '无论取得多么优秀的成绩，在求知治学的道路上都决不能轻易自满自足。',
      'Wúlùn qǔdé duōme yōuxiù de chéngjì, zài qiúzhī-zhìxué de dàolù shang dōu jué bùnéng qīngyì zìmǎn-zìzú.',
      'Bất luận giành được thành tích xuất sắc đến đâu, trên con đường tìm kiếm tri thức và nghiên cứu học thuật đều tuyệt đối không thể dễ dàng tự thỏa mãn với bản thân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论取得多么优秀的成绩，在求知治学的道路上都决不能轻易自满自足。', 'Wúlùn qǔdé duōme yōuxiù de chéngjì, zài qiúzhī-zhìxué de dàolù shang dōu jué bùnéng qīngyì zìmǎn-zìzú.', 'Bất luận giành được thành tích xuất sắc đến đâu, trên con đường tìm kiếm tri thức và nghiên cứu học thuật đều tuyệt đối không thể dễ dàng tự thỏa mãn với bản thân.', 'basic', 1),
      (v_id, '供给侧结构性改革的核心在于不断提升供给体系的质量与韧性，以高质量供给更好地满足人民群众对美好生活的新期待。', 'Gōngjǐcè jiégòuxìng gǎigé de héxīn zàiyú búduàn tíshēng gōngjǐ tǐxì de zhìliàng yǔ rènxìng, yǐ gāo zhìliàng gōngjǐ gèng hǎo de mǎnzú rénmín qúnzhòng duì měihǎo shēnghuó de xīn qīdài.', 'Hạt nhân của cải cách cơ cấu phía cung nằm ở việc không ngừng nâng cao chất lượng và sức bền của hệ thống cung ứng, dùng nguồn cung chất lượng cao để đáp ứng tốt hơn những mong ước mới của quần chúng nhân dân về một cuộc sống tốt đẹp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2751] [忙碌] (mánglù) - bận rộn, tất bật [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '忙碌' AND pinyin = 'mánglù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '忙碌' AND pinyin = 'mánglù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '忙碌'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '忙碌'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'mánglù',
      meaning_vi = 'bận rộn, tất bật',
      example_hanzi = '期末考试周期间，图书馆里到处都是忙碌复习功课的莘莘学子。',
      example_pinyin = 'Qīmò kǎoshì zhōuqī jiān, túshūguǎn lǐ dàochù dōu shì mánglù fùxí gōngkè de shēnshēn xuézǐ.',
      example_vi = 'Trong tuần lễ thi cuối kỳ, trong thư viện đâu đâu cũng là hình bóng của các bạn học sinh đang tất bật ôn tập bài vở.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '忙碌',
      'mánglù',
      'bận rộn, tất bật',
      'Tính từ',
      'HSK 5',
      '期末考试周期间，图书馆里到处都是忙碌复习功课的莘莘学子。',
      'Qīmò kǎoshì zhōuqī jiān, túshūguǎn lǐ dàochù dōu shì mánglù fùxí gōngkè de shēnshēn xuézǐ.',
      'Trong tuần lễ thi cuối kỳ, trong thư viện đâu đâu cũng là hình bóng của các bạn học sinh đang tất bật ôn tập bài vở.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '期末考试周期间，图书馆里到处都是忙碌复习功课的莘莘学子。', 'Qīmò kǎoshì zhōuqī jiān, túshūguǎn lǐ dàochù dōu shì mánglù fùxí gōngkè de shēnshēn xuézǐ.', 'Trong tuần lễ thi cuối kỳ, trong thư viện đâu đâu cũng là hình bóng của các bạn học sinh đang tất bật ôn tập bài vở.', 'basic', 1),
      (v_id, '在现代国际枢纽港口，全自动化无人集装箱码头日夜不停地忙碌运转，数万个标箱的高效装卸映射出全球外贸的强劲复苏脉搏。', 'Zài xiàndài guójì shūniǔ gǎngkǒu, quán zìdònghuà wúrén jízhuāngxiāng mǎtóu rì-yè bù tíng de mánglù yùnzhuǎn, shù wàn gè biāoxiāng de gāoxiào zhuāngxiè yìngshè chū quánqiú wàimào de qiángjìn fùsū màibó.', 'Tại cảng đầu mối quốc tế hiện đại, bến cảng container không người tự động hóa hoàn toàn ngày đêm không ngừng tất bật vận hành, việc bốc dỡ hiệu quả cao hàng vạn container tiêu chuẩn phản chiếu từng nhịp đập phục hồi mạnh mẽ của thương mại quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2752] [毛笔] (máobǐ) - bút lông (viết thư pháp/vẽ tranh) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '毛笔' AND pinyin = 'máobǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '毛笔' AND pinyin = 'máobǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '毛笔'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '毛笔'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'máobǐ',
      meaning_vi = 'bút lông (viết thư pháp/vẽ tranh)',
      example_hanzi = '练习中国书法需要先学会正确的手握毛笔姿势。',
      example_pinyin = 'Liànxí Zhōngguó shūfǎ xūyào xiān xuéhuì zhèngquè de shǒu wò máobǐ zīshì.',
      example_vi = 'Luyện tập thư pháp Trung Quốc cần phải học được tư thế cầm bút lông đúng cách trước tiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '毛笔',
      'máobǐ',
      'bút lông (viết thư pháp/vẽ tranh)',
      'Danh từ',
      'HSK 5',
      '练习中国书法需要先学会正确的手握毛笔姿势。',
      'Liànxí Zhōngguó shūfǎ xūyào xiān xuéhuì zhèngquè de shǒu wò máobǐ zīshì.',
      'Luyện tập thư pháp Trung Quốc cần phải học được tư thế cầm bút lông đúng cách trước tiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '练习中国书法需要先学会正确的手握毛笔姿势。', 'Liànxí Zhōngguó shūfǎ xūyào xiān xuéhuì zhèngquè de shǒu wò máobǐ zīshì.', 'Luyện tập thư pháp Trung Quốc cần phải học được tư thế cầm bút lông đúng cách trước tiên.', 'basic', 1),
      (v_id, '宣笔作为文房四宝之首，其手工制作技艺讲究尖、齐、圆、健四大德性，在传统水墨写意丹青中具有不可替代的艺术表现力。', 'Xuānbǐ zuòwéi wénfáng-sìbǎo zhī shǒu, qí shǒugōng zhìzuò jìyì jiǎngjiu jiān, qí, yuán, jiàn sì dà déxìng, zài chuántǒng shuǐmò xièyì dānqīng zhōng jùyǒu bùkě-tìdài de yìshù biǎoxiànlì.', 'Bút lông Tuyên Châu với vị thế đứng đầu văn phòng tứ bảo, kỹ thuật chế tác thủ công rất chú trọng 4 đặc tính nhọn, đều, tròn, khỏe, có sức biểu đạt nghệ thuật không thể thay thế trong hội họa thủy mặc truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2753] [毛病] (máobìng) - lỗi, tật, trục trặc, thói xấu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '毛病' AND pinyin = 'máobìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '毛病' AND pinyin = 'máobìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '毛病'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '毛病'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'máobìng',
      meaning_vi = 'lỗi, tật, trục trặc, thói xấu',
      example_hanzi = '这台旧洗衣机最近总是出现排水不畅的毛病。',
      example_pinyin = 'Zhè tái jiù xǐyījī zuìjìn zǒngshì chūxiàn páishuǐ bú chàng de máobìng.',
      example_vi = 'Chiếc máy giặt cũ này gần đây hay gặp trục trặc thoát nước không trôi chảy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '毛病',
      'máobìng',
      'lỗi, tật, trục trặc, thói xấu',
      'Danh từ',
      'HSK 5',
      '这台旧洗衣机最近总是出现排水不畅的毛病。',
      'Zhè tái jiù xǐyījī zuìjìn zǒngshì chūxiàn páishuǐ bú chàng de máobìng.',
      'Chiếc máy giặt cũ này gần đây hay gặp trục trặc thoát nước không trôi chảy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这台旧洗衣机最近总是出现排水不畅的毛病。', 'Zhè tái jiù xǐyījī zuìjìn zǒngshì chūxiàn páishuǐ bú chàng de máobìng.', 'Chiếc máy giặt cũ này gần đây hay gặp trục trặc thoát nước không trôi chảy.', 'basic', 1),
      (v_id, '在大型复杂软件系统上线前，测试工程师必须反复进行全方位压力测试，坚决查出并消除所有潜在的逻辑毛病与安全漏洞。', 'Zài dàxíng fùzá ruǎnjiàn xìtǒng shàngxiàn qián, cèshì gōngchéngshī bìxū fǎnfù jìnxíng quán fāngwèi yālì cèshì, jiānjué cháchū bìng xiāochú suǒyǒu qiánzài de luójí máobìng yǔ ānquán lòudòng.', 'Trước khi hệ thống phần mềm lớn và phức tạp đi vào vận hành thực tế, các kỹ sư kiểm thử phần mềm phải kiểm tra chịu tải toàn diện nhiều lần, kiên quyết tìm ra và triệt tiêu tất cả các lỗi logic tiềm ẩn cùng lỗ hổng an ninh mạng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2754] [矛盾] (máodùn) - mâu thuẫn; mâu thuẫn xung đột [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '矛盾' AND pinyin = 'máodùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '矛盾' AND pinyin = 'máodùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '矛盾'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '矛盾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'máodùn',
      meaning_vi = 'mâu thuẫn; mâu thuẫn xung đột',
      example_hanzi = '同学之间难免会产生一些小摩擦，只要坦诚沟通就能化解矛盾。',
      example_pinyin = 'Tóngxué zhījiān nánmiǎn huì chǎnshēng yìxiē xiǎo mócā, zhǐyào tǎnchéng gōutōng jiù néng huàjiě máodùn.',
      example_vi = 'Giữa các bạn học sinh khó tránh khỏi nảy sinh chút va chạm nhỏ, chỉ cần giao tiếp chân thành là có thể hóa giải mâu thuẫn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '矛盾',
      'máodùn',
      'mâu thuẫn; mâu thuẫn xung đột',
      'Danh từ / Tính từ',
      'HSK 5',
      '同学之间难免会产生一些小摩擦，只要坦诚沟通就能化解矛盾。',
      'Tóngxué zhījiān nánmiǎn huì chǎnshēng yìxiē xiǎo mócā, zhǐyào tǎnchéng gōutōng jiù néng huàjiě máodùn.',
      'Giữa các bạn học sinh khó tránh khỏi nảy sinh chút va chạm nhỏ, chỉ cần giao tiếp chân thành là có thể hóa giải mâu thuẫn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '同学之间难免会产生一些小摩擦，只要坦诚沟通就能化解矛盾。', 'Tóngxué zhījiān nánmiǎn huì chǎnshēng yìxiē xiǎo mócā, zhǐyào tǎnchéng gōutōng jiù néng huàjiě máodùn.', 'Giữa các bạn học sinh khó tránh khỏi nảy sinh chút va chạm nhỏ, chỉ cần giao tiếp chân thành là có thể hóa giải mâu thuẫn.', 'basic', 1),
      (v_id, '如何兼顾经济高速增长与生态环境保护之间的复杂关系，是现代国家治理中必须妥善协调处理的一对根本矛盾。', 'Rúhé jiāngù jīngjì gāosù zēngzhǎng yǔ shēngtài huánjìng bǎohù zhījiān de fùzá guānxì, shì xiàndài guójiā zhìlǐ zhōng bìxū tuǒshàn xiétiáo chǔlǐ de yí duì gēnběn máodùn.', 'Làm thế nào để dung hòa mối quan hệ phức tạp giữa tăng trưởng kinh tế tốc độ cao và bảo vệ môi trường sinh thái là một cặp mâu thuẫn căn bản đòi hỏi phải được điều phối xử lý thỏa đáng trong quản trị quốc gia hiện đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2755] [没法儿] (méifǎr) - không có cách nào, bó tay, hết cách [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '没法儿' AND pinyin = 'méifǎr'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '没法儿' AND pinyin = 'méifǎr'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '没法儿'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '没法儿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'méifǎr',
      meaning_vi = 'không có cách nào, bó tay, hết cách',
      example_hanzi = '外面的暴风雨实在太大了，我们今天没法儿按原计划出门去爬山了。',
      example_pinyin = 'Wàimiàn de bàofēngyǔ shízài tài dà le, wǒmen jīntiān méifǎr àn yuán jìhuà chūmén qù páshān le.',
      example_vi = 'Mưa bão bên ngoài thực sự quá lớn, hôm nay chúng tôi không có cách nào ra ngoài leo núi theo kế hoạch ban đầu được nữa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '没法儿',
      'méifǎr',
      'không có cách nào, bó tay, hết cách',
      'Động từ',
      'HSK 5',
      '外面的暴风雨实在太大了，我们今天没法儿按原计划出门去爬山了。',
      'Wàimiàn de bàofēngyǔ shízài tài dà le, wǒmen jīntiān méifǎr àn yuán jìhuà chūmén qù páshān le.',
      'Mưa bão bên ngoài thực sự quá lớn, hôm nay chúng tôi không có cách nào ra ngoài leo núi theo kế hoạch ban đầu được nữa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '外面的暴风雨实在太大了，我们今天没法儿按原计划出门去爬山了。', 'Wàimiàn de bàofēngyǔ shízài tài dà le, wǒmen jīntiān méifǎr àn yuán jìhuà chūmén qù páshān le.', 'Mưa bão bên ngoài thực sự quá lớn, hôm nay chúng tôi không có cách nào ra ngoài leo núi theo kế hoạch ban đầu được nữa.', 'basic', 1),
      (v_id, '如果没有底层芯片与基础软件工具链的自主可控，高端工业自动化设备在面临供应链断供时就根本没法儿正常维持生产。', 'Rúguǒ méiyǒu dǐcéng xīnpiàn yǔ jīchǔ ruǎnjiàn gōngjùliàn de zìzhǔ kěkòng, gāoduān gōngyè zìdònghuà shèbèi zài miànlín gōngyìngliàn duàngōng shí jiù gēnběn méifǎr zhèngcháng wéichí shēngchǎn.', 'Nếu không có sự tự chủ kiểm soát về chip nền tảng và chuỗi công cụ phần mềm cơ sở, các thiết bị tự động hóa công nghiệp cao cấp khi đối mặt với đứt gãy chuỗi cung ứng sẽ hoàn toàn không có cách nào duy trì sản xuất bình thường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2756] [玫瑰] (méigui) - hoa hồng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '玫瑰' AND pinyin = 'méigui'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '玫瑰' AND pinyin = 'méigui'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '玫瑰'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '玫瑰'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'méigui',
      meaning_vi = 'hoa hồng',
      example_hanzi = '情人节那天，花店里的红玫瑰和粉玫瑰十分畅销。',
      example_pinyin = 'Qíngrénjié nà tiān, huādiàn lǐ de hóng méigui hé fěn méigui shífēn chàngxiāo.',
      example_vi = 'Vào ngày lễ Tình nhân, hoa hồng đỏ và hoa hồng phấn trong tiệm hoa bán rất chạy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '玫瑰',
      'méigui',
      'hoa hồng',
      'Danh từ',
      'HSK 5',
      '情人节那天，花店里的红玫瑰和粉玫瑰十分畅销。',
      'Qíngrénjié nà tiān, huādiàn lǐ de hóng méigui hé fěn méigui shífēn chàngxiāo.',
      'Vào ngày lễ Tình nhân, hoa hồng đỏ và hoa hồng phấn trong tiệm hoa bán rất chạy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '情人节那天，花店里的红玫瑰和粉玫瑰十分畅销。', 'Qíngrénjié nà tiān, huādiàn lǐ de hóng méigui hé fěn méigui shífēn chàngxiāo.', 'Vào ngày lễ Tình nhân, hoa hồng đỏ và hoa hồng phấn trong tiệm hoa bán rất chạy.', 'basic', 1),
      (v_id, '高原冷凉气候非常适宜高品质大马士革玫瑰的有机种植，深加工提取的高纯度玫瑰精油已成为带动当地村民致富的支柱产业。', 'Gāoyuán lěngliáng qìhòu fēicháng shìyí gāo pǐnzhì Dàmǎshìgé méigui de yǒujī zhòngzhí, shēnjiāgōng tíqǔ de gāo chúndù méigui jīngyóu yǐ chéngwéi dàidòng dāngdì cūnmín zhìfù de zhīzhù chǎnyè.', 'Khí hậu mát lạnh vùng cao nguyên vô cùng thích hợp cho việc canh tác hữu cơ giống hoa hồng Damascus chất lượng cao, tinh dầu hoa hồng độ tinh khiết cao chiết xuất sau chế biến sâu đã trở thành ngành kinh tế trụ cột giúp bà con nông dân địa phương làm giàu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2757] [媒体] (méitǐ) - truyền thông, phương tiện thông tin đại chúng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '媒体' AND pinyin = 'méitǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '媒体' AND pinyin = 'méitǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '媒体'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '媒体'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'méitǐ',
      meaning_vi = 'truyền thông, phương tiện thông tin đại chúng',
      example_hanzi = '这起突发公共事件在各大社交媒体平台上引发了广泛热议。',
      example_pinyin = 'Zhè qǐ tūfā gōnggòng shìjiàn zài gè dà shèjiāo méitǐ píngtái shang yǐnfā le guǎnfàn rèyì.',
      example_vi = 'Vụ việc công cộng đột xuất này đã dấy lên làn sóng bàn luận sôi nổi rộng rãi trên các nền tảng mạng xã hội lớn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '媒体',
      'méitǐ',
      'truyền thông, phương tiện thông tin đại chúng',
      'Danh từ',
      'HSK 5',
      '这起突发公共事件在各大社交媒体平台上引发了广泛热议。',
      'Zhè qǐ tūfā gōnggòng shìjiàn zài gè dà shèjiāo méitǐ píngtái shang yǐnfā le guǎnfàn rèyì.',
      'Vụ việc công cộng đột xuất này đã dấy lên làn sóng bàn luận sôi nổi rộng rãi trên các nền tảng mạng xã hội lớn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这起突发公共事件在各大社交媒体平台上引发了广泛热议。', 'Zhè qǐ tūfā gōnggòng shìjiàn zài gè dà shèjiāo méitǐ píngtái shang yǐnfā le guǎnfàn rèyì.', 'Vụ việc công cộng đột xuất này đã dấy lên làn sóng bàn luận sôi nổi rộng rãi trên các nền tảng mạng xã hội lớn.', 'basic', 1),
      (v_id, '在全媒体融合发展的大趋势下，主流权威媒体必须牢牢把握正确的舆论导向，创新叙事表达方式以讲好中国发展故事。', 'Zài quán méitǐ rónghé fāzhǎn de dà qūshì xià, zhǔliú quánwēi méitǐ bìxū láoláo bǎwò zhèngquè de yúlùn dǎoxiàng, chuàngxīn xùshì biǎodá fāngshì yǐ jiǎng hǎo Zhōngguó fāzhǎn gùshì.', 'Dưới xu thế lớn về phát triển hội tụ đa phương tiện truyền thông, các cơ quan báo chí truyền thông chính thống uy tín phải nắm vững định hướng dư luận đúng đắn, đổi mới phương thức biểu đạt trần thuật để kể thật hay những câu chuyện phát triển của đất nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2758] [美术] (měishù) - mỹ thuật, hội họa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '美术' AND pinyin = 'měishù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '美术' AND pinyin = 'měishù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '美术'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '美术'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'měishù',
      meaning_vi = 'mỹ thuật, hội họa',
      example_hanzi = '他从小就在少年宫学习美术，练就了一手扎实的素描基本功。',
      example_pinyin = 'Tā cóngxiǎo jiù zài shàoniángōng xuéxí měishù, liànjiù le yì shǒu zhāshi de sùmiáo jīběngōng.',
      example_vi = 'Từ nhỏ anh ấy đã học mỹ thuật tại cung thiếu nhi, rèn luyện được kỹ năng hình họa chì cơ bản rất vững vàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '美术',
      'měishù',
      'mỹ thuật, hội họa',
      'Danh từ',
      'HSK 5',
      '他从小就在少年宫学习美术，练就了一手扎实的素描基本功。',
      'Tā cóngxiǎo jiù zài shàoniángōng xuéxí měishù, liànjiù le yì shǒu zhāshi de sùmiáo jīběngōng.',
      'Từ nhỏ anh ấy đã học mỹ thuật tại cung thiếu nhi, rèn luyện được kỹ năng hình họa chì cơ bản rất vững vàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他从小就在少年宫学习美术，练就了一手扎实的素描基本功。', 'Tā cóngxiǎo jiù zài shàoniángōng xuéxí měishù, liànjiù le yì shǒu zhāshi de sùmiáo jīběngōng.', 'Từ nhỏ anh ấy đã học mỹ thuật tại cung thiếu nhi, rèn luyện được kỹ năng hình họa chì cơ bản rất vững vàng.', 'basic', 1),
      (v_id, '中国美术馆举办的百年中国现代美术名家典藏特展，多维度呈现了现当代艺术家扎根人民生活的崇高美学追求。', 'Zhōngguó Měishùguǎn jǔbàn de bǎi nián Zhōngguó xiàndài měishù míngjiā diǎncáng tèzhǎn, duō wéidù chéngxiàn le xiàn-dāngdài yìshùjiā zhāgēn rénmín shēnghuó de chónggāo měixué zhuīqiú.', 'Triển lãm đặc biệt các bộ sưu tập kinh điển của danh gia mỹ thuật hiện đại Trung Quốc 100 năm do Bảo tàng Mỹ thuật Trung Quốc tổ chức, đã tái hiện đa chiều sự theo đuổi mỹ học cao quý bám rễ vào đời sống nhân dân của các nghệ sĩ cận hiện đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2759] [美味] (měiwèi) - món ngon, mỹ vị; thơm ngon [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '美味' AND pinyin = 'měiwèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '美味' AND pinyin = 'měiwèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '美味'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '美味'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'měiwèi',
      meaning_vi = 'món ngon, mỹ vị; thơm ngon',
      example_hanzi = '经过一个多小时的细火慢炖，一锅香气扑鼻的美味鸡汤做好了。',
      example_pinyin = 'Jīngguò yí gè duō xiǎoshí de xìhuǒ màndùn, yì guō xiāngqì-pūbí de měiwèi jītāng zuò hǎo le.',
      example_vi = 'Qua hơn một tiếng đồng hồ ninh nhỏ lửa, một nồi canh gà thơm ngon nức mũi đã hoàn thành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '美味',
      'měiwèi',
      'món ngon, mỹ vị; thơm ngon',
      'Danh từ / Tính từ',
      'HSK 5',
      '经过一个多小时的细火慢炖，一锅香气扑鼻的美味鸡汤做好了。',
      'Jīngguò yí gè duō xiǎoshí de xìhuǒ màndùn, yì guō xiāngqì-pūbí de měiwèi jītāng zuò hǎo le.',
      'Qua hơn một tiếng đồng hồ ninh nhỏ lửa, một nồi canh gà thơm ngon nức mũi đã hoàn thành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过一个多小时的细火慢炖，一锅香气扑鼻的美味鸡汤做好了。', 'Jīngguò yí gè duō xiǎoshí de xìhuǒ màndùn, yì guō xiāngqì-pūbí de měiwèi jītāng zuò hǎo le.', 'Qua hơn một tiếng đồng hồ ninh nhỏ lửa, một nồi canh gà thơm ngon nức mũi đã hoàn thành.', 'basic', 1),
      (v_id, '中华传统饮食文化兼具药膳同源的深厚智慧，以精湛的烹饪技艺将天然食材升华为抚慰人心的舌尖美味。', 'Zhōnghuá chuántǒng yǐnshí wénhuà jiānjù yàoshàn-tóngyuán de shēnhòu zhìhuì, yǐ jīngzhàn de pēngrèn jìyì jiāng tiānrán shícái shēnghuá wéi fǔwèi rénxīn de shéjiān měiwèi.', 'Văn hóa ẩm thực truyền thống Trung Hoa hàm chứa trí tuệ sâu sắc về sự đồng nguyên giữa dược liệu và món ăn, bằng kỹ nghệ nấu nướng tinh xảo đã nâng tầm các nguyên liệu tự nhiên thành những phong vị đầu lưỡi thơm ngon vỗ về lòng người.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2760] [魅力] (mèilì) - sức quyến rũ, sức hút, mị lực [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '魅力' AND pinyin = 'mèilì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '魅力' AND pinyin = 'mèilì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '魅力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '魅力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'mèilì',
      meaning_vi = 'sức quyến rũ, sức hút, mị lực',
      example_hanzi = '这座历史文化名城凭借古色古香的建筑展现出独特的东方魅力。',
      example_pinyin = 'Zhè zuò lìshǐ wénhuà míngchéng píngjiè gǔsè-gǔxiāng de jiànzhù zhǎnxiàn chū dútè de dōngfāng mèilì.',
      example_vi = 'Thành phố lịch sử văn hóa nổi tiếng này nhờ các công trình kiến trúc cổ kính trang nhã đã thể hiện sức quyến rũ phương Đông độc đáo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '魅力',
      'mèilì',
      'sức quyến rũ, sức hút, mị lực',
      'Danh từ',
      'HSK 5',
      '这座历史文化名城凭借古色古香的建筑展现出独特的东方魅力。',
      'Zhè zuò lìshǐ wénhuà míngchéng píngjiè gǔsè-gǔxiāng de jiànzhù zhǎnxiàn chū dútè de dōngfāng mèilì.',
      'Thành phố lịch sử văn hóa nổi tiếng này nhờ các công trình kiến trúc cổ kính trang nhã đã thể hiện sức quyến rũ phương Đông độc đáo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这座历史文化名城凭借古色古香的建筑展现出独特的东方魅力。', 'Zhè zuò lìshǐ wénhuà míngchéng píngjiè gǔsè-gǔxiāng de jiànzhù zhǎnxiàn chū dútè de dōngfāng mèilì.', 'Thành phố lịch sử văn hóa nổi tiếng này nhờ các công trình kiến trúc cổ kính trang nhã đã thể hiện sức quyến rũ phương Đông độc đáo.', 'basic', 1),
      (v_id, '古老博大的中华文明历经数千年风雨沧桑依然生机勃勃，向世界各国全方位彰显出跨越时空的深厚文化吸引力与永恒魅力。', 'Gǔlǎo bódà de Zhōnghuá wénmíng lìjīng shù qiān nián fēngyǔ-cāngsāng yīrán shēngjī-bóbó, xiàng shìjiè gè guó quán fāngwèi zhāngxiǎn chū kuàyuè shíkōng de shēnhòu wénhuà xīyǐnlì yǔ yǒnghéng mèilì.', 'Nền văn minh Trung Hoa cổ xưa uyên bác trải qua hàng nghìn năm dãi dầu dâu bể vẫn căng tràn nhựa sống, phô diễn trọn vẹn trước các quốc gia trên thế giới sức hút văn hóa sâu sắc vượt thời gian cùng mị lực trường tồn bất diệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2761] [门诊] (ménzhěn) - khám ngoại trú, khoa khám bệnh [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '门诊' AND pinyin = 'ménzhěn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '门诊' AND pinyin = 'ménzhěn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '门诊'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '门诊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'ménzhěn',
      meaning_vi = 'khám ngoại trú, khoa khám bệnh',
      example_hanzi = '患者可以通过医院官方手机小程序提前预约专家门诊号。',
      example_pinyin = 'Huànzhě kěyǐ tōngguò yīyuàn guānfāng shǒujī xiǎochéngxù tíqián yùyuē zhuānjiā ménzhěnhào.',
      example_vi = 'Người bệnh có thể thông qua ứng dụng nhỏ chính thức của bệnh viện trên điện thoại để đặt trước số khám chuyên gia.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '门诊',
      'ménzhěn',
      'khám ngoại trú, khoa khám bệnh',
      'Danh từ / Động từ',
      'HSK 5',
      '患者可以通过医院官方手机小程序提前预约专家门诊号。',
      'Huànzhě kěyǐ tōngguò yīyuàn guānfāng shǒujī xiǎochéngxù tíqián yùyuē zhuānjiā ménzhěnhào.',
      'Người bệnh có thể thông qua ứng dụng nhỏ chính thức của bệnh viện trên điện thoại để đặt trước số khám chuyên gia.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '患者可以通过医院官方手机小程序提前预约专家门诊号。', 'Huànzhě kěyǐ tōngguò yīyuàn guānfāng shǒujī xiǎochéngxù tíqián yùyuē zhuānjiā ménzhěnhào.', 'Người bệnh có thể thông qua ứng dụng nhỏ chính thức của bệnh viện trên điện thoại để đặt trước số khám chuyên gia.', 'basic', 1),
      (v_id, '为切实解决基层偏远山区看病难问题，三甲医院常态化开设远程专家门诊，使山区群众在家门口就能享受到国家级权威诊疗服务。', 'Wèi qièshí jiějué jīcéng piānyuǎn shānqū kànbìng nán wèntí, sānjiǎ yīyuàn chángtàihuà kāishè yuǎnchéng zhuānjiā ménzhěn, shǐ shānqū qúnzhòng zài jiā ménkǒu jiù néng xiǎngshòu dào guójiājí quánwēi zhěnliáo fúwù.', 'Nhằm giải quyết thiết thực bài toán khó khăn khi đi khám chữa bệnh ở vùng cao hẻo lánh, các bệnh viện tuyến đầu định kỳ mở phòng khám chuyên gia từ xa, giúp bà con vùng cao ngay trước cửa nhà đã có thể thụ hưởng dịch vụ chẩn trị uy tín cấp quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2762] [迷] (mí) - mê, say mê; người hâm mộ (fan); lạc hướng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '迷' AND pinyin = 'mí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迷' AND pinyin = 'mí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '迷'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'mí',
      meaning_vi = 'mê, say mê; người hâm mộ (fan); lạc hướng',
      example_hanzi = '他是一个狂热的足球迷，几乎每场重大的国际足球比赛都不会错过。',
      example_pinyin = 'Tā shì yí gè kuángrè de zúqiúmí, jīhū měi chǎng zhòngdà de guójì zúqiú bǐsài dōu bú huì cuòguò.',
      example_vi = 'Anh ấy là một người hâm mộ bóng đá cuồng nhiệt, hầu như mọi trận cầu quốc tế quan trọng đều không bao giờ bỏ lỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '迷',
      'mí',
      'mê, say mê; người hâm mộ (fan); lạc hướng',
      'Động từ / Danh từ',
      'HSK 5',
      '他是一个狂热的足球迷，几乎每场重大的国际足球比赛都不会错过。',
      'Tā shì yí gè kuángrè de zúqiúmí, jīhū měi chǎng zhòngdà de guójì zúqiú bǐsài dōu bú huì cuòguò.',
      'Anh ấy là một người hâm mộ bóng đá cuồng nhiệt, hầu như mọi trận cầu quốc tế quan trọng đều không bao giờ bỏ lỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他是一个狂热的足球迷，几乎每场重大的国际足球比赛都不会错过。', 'Tā shì yí gè kuángrè de zúqiúmí, jīhū měi chǎng zhòngdà de guójì zúqiú bǐsài dōu bú huì cuòguò.', 'Anh ấy là một người hâm mộ bóng đá cuồng nhiệt, hầu như mọi trận cầu quốc tế quan trọng đều không bao giờ bỏ lỡ.', 'basic', 1),
      (v_id, '面对资本市场形形色色的概念炒作与短期投机诱惑，理性投资者必须保持清醒头脑，决不被表面的泡沫假象所迷惑。', 'Miànduì zīběn shìchǎng xíngxíng-sèsè de gàiniàn chǎozuò yǔ duǎnqī tóujī yòuhuò, lǐxìng tóuzīzhě bìxū bǎochí qīngxǐng tóunǎo, jué bú bèi biǎomiàn de pàomò jiǎxiàng suǒ míhuò.', 'Đứng trước muôn hình vạn trạng các chiêu trò thổi phồng khái niệm và cám dỗ đầu cơ ngắn hạn của thị trường vốn, nhà đầu tư lý trí cần giữ cho mình một cái đầu tỉnh táo, quyết không để những ảo ảnh bong bóng bề ngoài làm mê muội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2763] [迷路] (mílù) - lạc đường, mất phương hướng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '迷路' AND pinyin = 'mílù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迷路' AND pinyin = 'mílù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '迷路'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迷路'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'mílù',
      meaning_vi = 'lạc đường, mất phương hướng',
      example_hanzi = '在没有网络信号的原始森林里徒步，很容易迷路失联。',
      example_pinyin = 'Zài méiyǒu wǎngluò xìnhào de yuánshǐ sēnlín lǐ túbù, hěn róngyì mílù shīlián.',
      example_vi = 'Đi bộ đường dài trong khu rừng nguyên sinh không có sóng mạng rất dễ bị lạc đường và mất liên lạc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '迷路',
      'mílù',
      'lạc đường, mất phương hướng',
      'Động từ',
      'HSK 5',
      '在没有网络信号的原始森林里徒步，很容易迷路失联。',
      'Zài méiyǒu wǎngluò xìnhào de yuánshǐ sēnlín lǐ túbù, hěn róngyì mílù shīlián.',
      'Đi bộ đường dài trong khu rừng nguyên sinh không có sóng mạng rất dễ bị lạc đường và mất liên lạc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在没有网络信号的原始森林里徒步，很容易迷路失联。', 'Zài méiyǒu wǎngluò xìnhào de yuánshǐ sēnlín lǐ túbù, hěn róngyì mílù shīlián.', 'Đi bộ đường dài trong khu rừng nguyên sinh không có sóng mạng rất dễ bị lạc đường và mất liên lạc.', 'basic', 1),
      (v_id, '探险队在暴风雪肆虐的极地荒原深处不慎迷路，凭借北斗卫星短报文终端成功发出带有高精经纬度坐标的紧急求救信号。', 'Tànxiǎnduì zài bàofēngxuě sìnüè de jídì huāngyuán shēnchù búshèn mílù, píngjiè Běidǒu wèixīng duǎnbàowén zhōngduān chénggōng fāchū dài yǒu gāojīng jīng-wěidù zuòbiāo de jǐnjí qiújiù xìnhào.', 'Đội thám hiểm nơi hoang mạc vùng cực giữa bão tuyết hoành hành dữ dội sơ ý bị lạc đường, nhờ vào thiết bị tin nhắn ngắn vệ tinh Bắc Đẩu đã phát đi thành công tín hiệu cầu cứu khẩn cấp mang tọa độ kinh vĩ độ độ chính xác cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2764] [秘密] (mìmì) - bí mật, điều bí mật; bí mật kín đáo [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '秘密' AND pinyin = 'mìmì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '秘密' AND pinyin = 'mìmì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '秘密'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '秘密'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'mìmì',
      meaning_vi = 'bí mật, điều bí mật; bí mật kín đáo',
      example_hanzi = '好朋友之间要坦诚相待，保守彼此心中的秘密。',
      example_pinyin = 'Hǎo péngyou zhījiān yào tǎnchéng xiāngdài, bǎoshǒu bǐcǐ xīnzhōng de mìmì.',
      example_vi = 'Bạn tốt với nhau cần đối đãi chân thành, biết giữ kín những bí mật trong lòng của nhau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '秘密',
      'mìmì',
      'bí mật, điều bí mật; bí mật kín đáo',
      'Danh từ / Tính từ',
      'HSK 5',
      '好朋友之间要坦诚相待，保守彼此心中的秘密。',
      'Hǎo péngyou zhījiān yào tǎnchéng xiāngdài, bǎoshǒu bǐcǐ xīnzhōng de mìmì.',
      'Bạn tốt với nhau cần đối đãi chân thành, biết giữ kín những bí mật trong lòng của nhau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '好朋友之间要坦诚相待，保守彼此心中的秘密。', 'Hǎo péngyou zhījiān yào tǎnchéng xiāngdài, bǎoshǒu bǐcǐ xīnzhōng de mìmì.', 'Bạn tốt với nhau cần đối đãi chân thành, biết giữ kín những bí mật trong lòng của nhau.', 'basic', 1),
      (v_id, '涉密科研单位必须严格执行国家保密法律法规，严防核心国防科研成果与尖端前沿技术商业秘密发生外泄。', 'Shèmì kēyán dānwèi bìxū yángé zhíxíng guójiā bǎomì fǎlǜ fǎguī, yánfáng héxīn guófáng kēyán chéngguǒ yǔ jiānduān qiányán jìshù shāngyè mìmì fāshēng wàixiè.', 'Các đơn vị nghiên cứu khoa học liên quan đến bí mật bắt buộc phải chấp hành nghiêm túc pháp luật quy chế bảo mật quốc gia, phòng ngừa nghiêm ngặt việc rò rỉ các thành quả nghiên cứu quốc phòng cốt lõi và bí mật thương mại công nghệ tiên phong đỉnh cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2765] [密切] (mìqiè) - mật thiết, chặt chẽ, gắn bó [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '密切' AND pinyin = 'mìqiè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '密切' AND pinyin = 'mìqiè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '密切'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '密切'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'mìqiè',
      meaning_vi = 'mật thiết, chặt chẽ, gắn bó',
      example_hanzi = '气象部门正在密切监视今年第十二号台风的移动路径。',
      example_pinyin = 'Qìxiàng bùmén zhèngzài mìqiè jiānshì jīnnián dì-shí’èr hào táifēng de yídòng lùjìng.',
      example_vi = 'Cơ quan khí tượng đang theo dõi sát sao đường đi di chuyển của cơn bão số 12 trong năm nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '密切',
      'mìqiè',
      'mật thiết, chặt chẽ, gắn bó',
      'Tính từ / Động từ',
      'HSK 5',
      '气象部门正在密切监视今年第十二号台风的移动路径。',
      'Qìxiàng bùmén zhèngzài mìqiè jiānshì jīnnián dì-shí’èr hào táifēng de yídòng lùjìng.',
      'Cơ quan khí tượng đang theo dõi sát sao đường đi di chuyển của cơn bão số 12 trong năm nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '气象部门正在密切监视今年第十二号台风的移动路径。', 'Qìxiàng bùmén zhèngzài mìqiè jiānshì jīnnián dì-shí’èr hào táifēng de yídòng lùjìng.', 'Cơ quan khí tượng đang theo dõi sát sao đường đi di chuyển của cơn bão số 12 trong năm nay.', 'basic', 1),
      (v_id, '在应对全球公共卫生危机与跨国洗钱犯罪等非传统安全威胁时，国际刑警组织与各国执法部门必须保持高度密切的情报共享与行动协调。', 'Zài yìngduì quánqiú gōnggòng wèishēng wēijī yǔ kuàguó xǐqián fànzuì děng fēichuántǒng ānquán wēixié shí, Guójì Xíngjǐng Zǔzhī yǔ gè guó zhífǎ bùmén bìxū bǎochí gāodù mìqiè de qíngbào gòngxiǎng yǔ xíngdòng xiétiáo.', 'Khi ứng phó với các mối đe dọa an ninh phi truyền thống như khủng hoảng y tế công cộng toàn cầu và tội phạm rửa tiền xuyên quốc gia, Tổ chức Cảnh sát Hình sự Quốc tế cùng cơ quan hành pháp các nước bắt buộc phải duy trì việc chia sẻ thông tin tình báo và phối hợp hành động hết sức mật thiết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2766] [秘书] (mìshū) - thư ký [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '秘书' AND pinyin = 'mìshū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '秘书' AND pinyin = 'mìshū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '秘书'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '秘书'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'mìshū',
      meaning_vi = 'thư ký',
      example_hanzi = '总经理的秘书工作细致负责，将每天的日程安排得井井有条。',
      example_pinyin = 'Zǒngjīnglǐ de mìshū gōngzuò xìzhì fùzé, jiāng měi tiān de rìchéng ānpái de jǐngjǐng-yǒutiáo.',
      example_vi = 'Thư ký của tổng giám đốc làm việc rất tỉ mỉ và có trách nhiệm, sắp xếp lịch trình mỗi ngày đâu ra đấy ngăn nắp trật tự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '秘书',
      'mìshū',
      'thư ký',
      'Danh từ',
      'HSK 5',
      '总经理的秘书工作细致负责，将每天的日程安排得井井有条。',
      'Zǒngjīnglǐ de mìshū gōngzuò xìzhì fùzé, jiāng měi tiān de rìchéng ānpái de jǐngjǐng-yǒutiáo.',
      'Thư ký của tổng giám đốc làm việc rất tỉ mỉ và có trách nhiệm, sắp xếp lịch trình mỗi ngày đâu ra đấy ngăn nắp trật tự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '总经理的秘书工作细致负责，将每天的日程安排得井井有条。', 'Zǒngjīnglǐ de mìshū gōngzuò xìzhì fùzé, jiāng měi tiān de rìchéng ānpái de jǐngjǐng-yǒutiáo.', 'Thư ký của tổng giám đốc làm việc rất tỉ mỉ và có trách nhiệm, sắp xếp lịch trình mỗi ngày đâu ra đấy ngăn nắp trật tự.', 'basic', 1),
      (v_id, '作为国际多边经贸组织常设秘书处的资深法律秘书，她承担着起草跨境争端解决规则与多边多语种公约文本的重要职责。', 'Zuòwéi guójì duōbiān jīngmào zǔzhī chángshè mìshūchù de zīshēn fǎlǜ mìshū, tā chéngdān zhe qǐcǎo kuàjìng zhēngduān jiějué guīzé yǔ duōbiān duōyǔzhǒng gōngyuē wénběn de zhòngyào zhízé.', 'Với tư cách là thư ký pháp lý kỳ cựu của Ban Thư ký thường trực một tổ chức kinh tế thương mại đa phương quốc tế, cô gánh vác trọng trách quan trọng là soạn thảo các quy tắc giải quyết tranh chấp xuyên biên giới và văn bản công ước đa phương đa ngôn ngữ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2767] [面] (miàn) - mặt, bề mặt, phương diện; lá (cờ) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '面' AND pinyin = 'miàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '面' AND pinyin = 'miàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '面'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '面'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'miàn',
      meaning_vi = 'mặt, bề mặt, phương diện; lá (cờ)',
      example_hanzi = '清晨的校园广场上，伴随着国歌声升起了一面鲜艳的五星红旗。',
      example_pinyin = 'Qīngchén de xiàoyuán guǎngchǎng shang, bànsuí zhe guógē shēng shēngqǐ le yí miàn xiānyàn de wǔxīng hóngqí.',
      example_vi = 'Trên quảng trường sân trường vào buổi sáng sớm, hòa cùng tiếng quốc ca vang lên là một lá cờ đỏ sao vàng tươi thắm được kéo lên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '面',
      'miàn',
      'mặt, bề mặt, phương diện; lá (cờ)',
      'Danh từ / Lượng từ',
      'HSK 5',
      '清晨的校园广场上，伴随着国歌声升起了一面鲜艳的五星红旗。',
      'Qīngchén de xiàoyuán guǎngchǎng shang, bànsuí zhe guógē shēng shēngqǐ le yí miàn xiānyàn de wǔxīng hóngqí.',
      'Trên quảng trường sân trường vào buổi sáng sớm, hòa cùng tiếng quốc ca vang lên là một lá cờ đỏ sao vàng tươi thắm được kéo lên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '清晨的校园广场上，伴随着国歌声升起了一面鲜艳的五星红旗。', 'Qīngchén de xiàoyuán guǎngchǎng shang, bànsuí zhe guógē shēng shēngqǐ le yí miàn xiānyàn de wǔxīng hóngqí.', 'Trên quảng trường sân trường vào buổi sáng sớm, hòa cùng tiếng quốc ca vang lên là một lá cờ đỏ sao vàng tươi thắm được kéo lên.', 'basic', 1),
      (v_id, '全面推进乡村振兴必须坚持多措并举，不仅要抓好农业产业化发展这一面，更要兼顾乡村生态治理与精神文明建设的各个基本面。', 'Quánmiàn tuījìn xiāngcūn zhènxīng bìxū jiānchí duōcuò-bìngjǔ, bùjǐn yào zhuā hǎo nóngyè chǎnyèhuà fāzhǎn zhè yí miàn, gèng yào jiāngù xiāngcūn shēngtài zhìlǐ yǔ jīngshén wénmíng jiànshè de gègè jīběnmiàn.', 'Đẩy mạnh toàn diện công cuộc chấn hưng nông thôn đòi hỏi phải đồng bộ nhiều biện pháp, không chỉ nắm chắc mặt phát triển công nghiệp hóa nông nghiệp, mà càng phải chăm lo đến các phương diện cơ bản như quản trị sinh thái làng quê và xây dựng văn minh tinh thần.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2768] [面积] (miànjī) - diện tích [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '面积' AND pinyin = 'miànjī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '面积' AND pinyin = 'miànjī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '面积'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '面积'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'miànjī',
      meaning_vi = 'diện tích',
      example_hanzi = '这套三居室公寓的实用建筑面积大约有一百二十平方米。',
      example_pinyin = 'Zhè tào sān jūshì gōngyù de shíyòng jiànzhù miànjī dàyuē yǒu yībǎi èrshí píngfāngmǐ.',
      example_vi = 'Căn hộ chung cư 3 phòng ngủ này có diện tích xây dựng sử dụng thực tế khoảng 120 mét vuông.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '面积',
      'miànjī',
      'diện tích',
      'Danh từ',
      'HSK 5',
      '这套三居室公寓的实用建筑面积大约有一百二十平方米。',
      'Zhè tào sān jūshì gōngyù de shíyòng jiànzhù miànjī dàyuē yǒu yībǎi èrshí píngfāngmǐ.',
      'Căn hộ chung cư 3 phòng ngủ này có diện tích xây dựng sử dụng thực tế khoảng 120 mét vuông.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这套三居室公寓的实用建筑面积大约有一百二十平方米。', 'Zhè tào sān jūshì gōngyù de shíyòng jiànzhù miànjī dàyuē yǒu yībǎi èrshí píngfāngmǐ.', 'Căn hộ chung cư 3 phòng ngủ này có diện tích xây dựng sử dụng thực tế khoảng 120 mét vuông.', 'basic', 1),
      (v_id, '国家持续推进“三北”等重点生态工程建设，累计完成退耕还林还草与防沙治沙绿化面积达数千万公顷，创造了全球荒漠化治理的绿色奇迹。', 'Guójiā chíxù tuījìn “Sānběi” děng zhòngdiǎn shēngtài gōngchéng jiànshè, lěijì wánchéng tuìgēng-huánlín-huáncǎo yǔ fángshā-zhìshā lǜhuà miànjī dá shù qiān wàn gōngqǐng, chuàngzào le quánqiú huāngmòhuà zhìlǐ de lǜsè qíjì.', 'Nhà nước liên tục đẩy mạnh xây dựng các công trình sinh thái trọng điểm như "Tam Bắc", hoàn thành diện tích phủ xanh đất trồng rừng trồng cỏ và chắn cát cải tạo sa mạc lên tới hàng chục triệu hecta, tạo nên kỳ tích xanh trong công cuộc quản trị sa mạc hóa toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2769] [面临] (miànlín) - đối mặt với, đương đầu với [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '面临' AND pinyin = 'miànlín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '面临' AND pinyin = 'miànlín'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '面临'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '面临'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'miànlín',
      meaning_vi = 'đối mặt với, đương đầu với',
      example_hanzi = '大学毕业生在步入社会时，往往面临着激烈的就业竞争压力。',
      example_pinyin = 'Dàxué bìyèshēng zài bùrù shèhuì shí, wǎngwǎng miànlín zhe jīliè de jiùyè jìngzhēng yālì.',
      example_vi = 'Sinh viên tốt nghiệp đại học khi bước vào xã hội thường phải đối mặt với áp lực cạnh tranh việc làm khốc liệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '面临',
      'miànlín',
      'đối mặt với, đương đầu với',
      'Động từ',
      'HSK 5',
      '大学毕业生在步入社会时，往往面临着激烈的就业竞争压力。',
      'Dàxué bìyèshēng zài bùrù shèhuì shí, wǎngwǎng miànlín zhe jīliè de jiùyè jìngzhēng yālì.',
      'Sinh viên tốt nghiệp đại học khi bước vào xã hội thường phải đối mặt với áp lực cạnh tranh việc làm khốc liệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大学毕业生在步入社会时，往往面临着激烈的就业竞争压力。', 'Dàxué bìyèshēng zài bùrù shèhuì shí, wǎngwǎng miànlín zhe jīliè de jiùyè jìngzhēng yālì.', 'Sinh viên tốt nghiệp đại học khi bước vào xã hội thường phải đối mặt với áp lực cạnh tranh việc làm khốc liệt.', 'basic', 1),
      (v_id, '当前世界经济增长动能不足，地缘政治冲突频发，人类社会面临着逆全球化浪潮与气候变暖等多重严峻风险挑战。', 'Dāngqián shìjiè jīngjì zēngzhǎng dòngnéng bùzú, dìyuán zhèngzhì chōngtū pínfā, rénlèi shèhuì miànlín zhe nì-quánqiúhuà làngcháo yǔ qìhòu biànnuǎn děng duōchóng yánjùn fēngxiǎn tiǎozhàn.', 'Hiện nay động năng tăng trưởng kinh tế thế giới thiếu hụt, xung đột địa chính trị diễn ra thường xuyên, xã hội loài người đang phải đối mặt với muôn vàn thách thức rủi ro cam go như làn sóng phi toàn cầu hóa và biến đổi khí hậu ấm lên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2770] [面向] (miànxiàng) - hướng tới, hướng về, dành cho [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '面向' AND pinyin = 'miànxiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '面向' AND pinyin = 'miànxiàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '面向'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '面向'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'miànxiàng',
      meaning_vi = 'hướng tới, hướng về, dành cho',
      example_hanzi = '这所语言学院开设了专门面向外国留学生的基础中文听说速成班。',
      example_pinyin = 'Zhè suǒ yǔyán xuéyuàn kāishè le zhuānmén miànxiàng wàiguó liúxuéshēng de jīchǔ Zhōngwén tīngshuō sùchéngbān.',
      example_vi = 'Học viện ngôn ngữ này đã mở lớp cấp tốc nghe nói tiếng Trung cơ bản chuyên hướng tới các du học sinh nước ngoài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '面向',
      'miànxiàng',
      'hướng tới, hướng về, dành cho',
      'Động từ',
      'HSK 5',
      '这所语言学院开设了专门面向外国留学生的基础中文听说速成班。',
      'Zhè suǒ yǔyán xuéyuàn kāishè le zhuānmén miànxiàng wàiguó liúxuéshēng de jīchǔ Zhōngwén tīngshuō sùchéngbān.',
      'Học viện ngôn ngữ này đã mở lớp cấp tốc nghe nói tiếng Trung cơ bản chuyên hướng tới các du học sinh nước ngoài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这所语言学院开设了专门面向外国留学生的基础中文听说速成班。', 'Zhè suǒ yǔyán xuéyuàn kāishè le zhuānmén miànxiàng wàiguó liúxuéshēng de jīchǔ Zhōngwén tīngshuō sùchéngbān.', 'Học viện ngôn ngữ này đã mở lớp cấp tốc nghe nói tiếng Trung cơ bản chuyên hướng tới các du học sinh nước ngoài.', 'basic', 1),
      (v_id, '国家科技重大专项始终坚持面向世界科技前沿、面向经济主战场、面向国家重大需求、面向人民生命健康，加快实现高水平科技自立自强。', 'Guójiā kējì zhòngdà zhuānxiàng shǐzhōng jiānchí miànxiàng shìjiè kējì qiányán, miànxiàng jīngjì zhǔ zhànchǎng, miànxiàng guójiā zhòngdà xūqiú, miànxiàng rénmín shēngmìng jiànkāng, jiākuài shíxiàn gāo shuǐpíng kējì zìlì-zìqiáng.', 'Các chương trình khoa học công nghệ trọng đại quốc gia luôn kiên trì hướng tới tiền tuyến công nghệ thế giới, hướng về chiến trường chính kinh tế, hướng tới nhu cầu lớn của quốc gia, hướng tới tính mạng sức khỏe nhân dân, đẩy nhanh hiện thực hóa khoa học công nghệ tự lực tự cường cấp cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2771] [描述] (miáoshù) - miêu tả, mô tả; sự mô tả [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '描述' AND pinyin = 'miáoshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '描述' AND pinyin = 'miáoshù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '描述'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '描述'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'miáoshù',
      meaning_vi = 'miêu tả, mô tả; sự mô tả',
      example_hanzi = '请你根据目击情况，向民警详细描述一下嫌疑人的体貌特征。',
      example_pinyin = 'Qǐng nǐ gēnjù mùjī qíngkuàng, xiàng mínjǐng xiángxì miáoshù yíxià xiányírén de tǐmào tèzhēng.',
      example_vi = 'Xin bạn hãy căn cứ vào tình hình tận mắt chứng kiến, miêu tả chi tiết với cảnh sát về đặc điểm nhận dạng của nghi phạm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '描述',
      'miáoshù',
      'miêu tả, mô tả; sự mô tả',
      'Động từ / Danh từ',
      'HSK 5',
      '请你根据目击情况，向民警详细描述一下嫌疑人的体貌特征。',
      'Qǐng nǐ gēnjù mùjī qíngkuàng, xiàng mínjǐng xiángxì miáoshù yíxià xiányírén de tǐmào tèzhēng.',
      'Xin bạn hãy căn cứ vào tình hình tận mắt chứng kiến, miêu tả chi tiết với cảnh sát về đặc điểm nhận dạng của nghi phạm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请你根据目击情况，向民警详细描述一下嫌疑人的体貌特征。', 'Qǐng nǐ gēnjù mùjī qíngkuàng, xiàng mínjǐng xiángxì miáoshù yíxià xiányírén de tǐmào tèzhēng.', 'Xin bạn hãy căn cứ vào tình hình tận mắt chứng kiến, miêu tả chi tiết với cảnh sát về đặc điểm nhận dạng của nghi phạm.', 'basic', 1),
      (v_id, '爱因斯坦在广义相对论中，运用高深优美的黎曼几何曲率张量数学语言，极其精确地描述了宇宙大质量天体引力场对四维时空的弯曲效应。', 'Àiyīnsītǎn zài guǎngyì xiāngduìlùn zhōng, yùnyòng gāoshēn yōuměi de Límàn jǐhé qūlǜ zhāngliàng shùxué yǔyán, jíqí jīngquè de miáoshù le yǔzhòu dà zhìliàng tiāntǐ yǐnlìchǎng duì sìwéi shíkōng de wānqū xiàoyìng.', 'Einstein trong Thuyết tương đối rộng đã vận dụng ngôn ngữ toán học ten-xơ độ cong hình học Riemann cao siêu đẹp đẽ để mô tả cực kỳ chính xác hiệu ứng bẻ cong không - thời gian 4 chiều của trường hấp dẫn thiên thể khối lượng lớn trong vũ trụ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2772] [敏感] (mǐngǎn) - nhạy cảm, mẫn cảm, dễ dị ứng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '敏感' AND pinyin = 'mǐngǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '敏感' AND pinyin = 'mǐngǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '敏感'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '敏感'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'mǐngǎn',
      meaning_vi = 'nhạy cảm, mẫn cảm, dễ dị ứng',
      example_hanzi = '春天花粉较多，皮肤敏感的人外出最好戴上口罩做好防护。',
      example_pinyin = 'Chūntiān huāfěn jiào duō, pífū mǐngǎn de rén wàichū zuìhǎo dài shàng kǒuzhào zuò hǎo fánghù.',
      example_vi = 'Mùa xuân phấn hoa khá nhiều, những người có làn da nhạy cảm khi ra ngoài tốt nhất nên đeo khẩu trang phòng hộ cẩn thận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '敏感',
      'mǐngǎn',
      'nhạy cảm, mẫn cảm, dễ dị ứng',
      'Tính từ',
      'HSK 5',
      '春天花粉较多，皮肤敏感的人外出最好戴上口罩做好防护。',
      'Chūntiān huāfěn jiào duō, pífū mǐngǎn de rén wàichū zuìhǎo dài shàng kǒuzhào zuò hǎo fánghù.',
      'Mùa xuân phấn hoa khá nhiều, những người có làn da nhạy cảm khi ra ngoài tốt nhất nên đeo khẩu trang phòng hộ cẩn thận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春天花粉较多，皮肤敏感的人外出最好戴上口罩做好防护。', 'Chūntiān huāfěn jiào duō, pífū mǐngǎn de rén wàichū zuìhǎo dài shàng kǒuzhào zuò hǎo fánghù.', 'Mùa xuân phấn hoa khá nhiều, những người có làn da nhạy cảm khi ra ngoài tốt nhất nên đeo khẩu trang phòng hộ cẩn thận.', 'basic', 1),
      (v_id, '国际资本流动对美联储利率政策走向极具高度敏感性，任何超预期的通胀数据波动都可能引发全球外汇与资产市场的连锁剧烈震荡。', 'Guójì zīběn liúdòng duì Měiliánchǔ lìlǜ zhèngcè zǒuxiàng jí jù gāodù mǐngǎnxìng, rènhé chāo yùqī de tōngzhàng shùjù bōdòng dōu kěnéng yǐnfā quánqiú wàihuì yǔ zīchǎn shìchǎng de liánsuǒ jùliè zhèndàng.', 'Dòng vốn quốc tế có độ nhạy cảm cao độ đối với hướng đi chính sách lãi suất của Cục Dự trữ Liên bang Mỹ, bất kỳ sự dao động số liệu lạm phát nào vượt dự kiến cũng có thể gây ra chuỗi chấn động dữ dội trên thị trường ngoại hối và tài sản toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2773] [名称] (míngchēng) - tên gọi, danh xưng, tên thương mại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '名称' AND pinyin = 'míngchēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '名称' AND pinyin = 'míngchēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '名称'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '名称'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'míngchēng',
      meaning_vi = 'tên gọi, danh xưng, tên thương mại',
      example_hanzi = '在填写注册登记表格时，请务必核对好公司的法定完整名称。',
      example_pinyin = 'Zài tiánxiě zhùcè dēngjì biǎogé shí, qǐng wùbì héduì hǎo gōngsī de fǎdìng wánzhěng míngchēng.',
      example_vi = 'Khi điền biểu mẫu đăng ký, xin nhất thiết phải kiểm tra đối chiếu thật kỹ tên gọi pháp định đầy đủ của công ty.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '名称',
      'míngchēng',
      'tên gọi, danh xưng, tên thương mại',
      'Danh từ',
      'HSK 5',
      '在填写注册登记表格时，请务必核对好公司的法定完整名称。',
      'Zài tiánxiě zhùcè dēngjì biǎogé shí, qǐng wùbì héduì hǎo gōngsī de fǎdìng wánzhěng míngchēng.',
      'Khi điền biểu mẫu đăng ký, xin nhất thiết phải kiểm tra đối chiếu thật kỹ tên gọi pháp định đầy đủ của công ty.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在填写注册登记表格时，请务必核对好公司的法定完整名称。', 'Zài tiánxiě zhùcè dēngjì biǎogé shí, qǐng wùbì héduì hǎo gōngsī de fǎdìng wánzhěng míngchēng.', 'Khi điền biểu mẫu đăng ký, xin nhất thiết phải kiểm tra đối chiếu thật kỹ tên gọi pháp định đầy đủ của công ty.', 'basic', 1),
      (v_id, '国家地理标志保护产品严格限定产地范围与传统加工工艺，严厉打击任何擅自盗用地理标志名称的假冒侵权假劣行为。', 'Guójiā dìlǐ biāozhì bǎohù chǎnpǐn yángé xiàndìng chǎndì fànwéi yǔ chuántǒng jiāgōng gōngyì, yánlì dǎjī rènhé shànzì dàoyòng dìlǐ biāozhì míngchēng de jiǎmào qīnquán jiǎliè xíngwéi.', 'Sản phẩm được bảo hộ chỉ dẫn địa lý quốc gia quy định khắt khe phạm vi vùng xuất xứ và quy trình gia công truyền thống, xử lý nghiêm khắc mọi hành vi giả mạo xâm quyền tự tiện đánh cắp tên gọi chỉ dẫn địa lý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2774] [名牌] (míngpái) - hàng hiệu, thương hiệu nổi tiếng, danh bài [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '名牌' AND pinyin = 'míngpái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '名牌' AND pinyin = 'míngpái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '名牌'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '名牌'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'míngpái',
      meaning_vi = 'hàng hiệu, thương hiệu nổi tiếng, danh bài',
      example_hanzi = '青年人消费应当量力而行，切忌为了虚荣盲目追求名牌奢侈品。',
      example_pinyin = 'Qīngniánrén xiāofèi yīngdāng liànglì-érxíng, qièjì wèile xūróng mángmù zhuīqiú míngpái shēchǐpǐn.',
      example_vi = 'Người trẻ tuổi tiêu dùng nên lượng sức mình, tuyệt đối tránh vì hư vinh mà mù quáng chạy theo các món hàng hiệu xa xỉ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '名牌',
      'míngpái',
      'hàng hiệu, thương hiệu nổi tiếng, danh bài',
      'Danh từ',
      'HSK 5',
      '青年人消费应当量力而行，切忌为了虚荣盲目追求名牌奢侈品。',
      'Qīngniánrén xiāofèi yīngdāng liànglì-érxíng, qièjì wèile xūróng mángmù zhuīqiú míngpái shēchǐpǐn.',
      'Người trẻ tuổi tiêu dùng nên lượng sức mình, tuyệt đối tránh vì hư vinh mà mù quáng chạy theo các món hàng hiệu xa xỉ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年人消费应当量力而行，切忌为了虚荣盲目追求名牌奢侈品。', 'Qīngniánrén xiāofèi yīngdāng liànglì-érxíng, qièjì wèile xūróng mángmù zhuīqiú míngpái shēchǐpǐn.', 'Người trẻ tuổi tiêu dùng nên lượng sức mình, tuyệt đối tránh vì hư vinh mà mù quáng chạy theo các món hàng hiệu xa xỉ.', 'basic', 1),
      (v_id, '实施质量强国与中国制造走出去战略，重在打造一批具有核心自主知识产权与全球卓越影响力的中国名牌企业。', 'Shíshī zhìliàng qiángguó yǔ Zhōngguó zhìzào zǒuchūqù zhànlüè, zhòng zài dǎzào yì pī jùyǒu héxīn zìzhǔ zhīshi chǎnquán yǔ quánqiú zhuóyuè yǐngxiǎnglì de Zhōngguó míngpái qǐyè.', 'Thực thi chiến lược xây dựng quốc gia chất lượng mạnh và đưa hàng chế tạo Trung Quốc vươn ra thế giới, trọng tâm là gây dựng nên một loạt các doanh nghiệp mang thương hiệu nổi tiếng Trung Quốc sở hữu quyền sở hữu trí tuệ tự chủ cốt lõi và sức ảnh hưởng vượt trội toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2775] [名片] (míngpiàn) - danh thiếp, card visit; tấm danh thiếp (biểu tượng) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '名片' AND pinyin = 'míngpiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '名片' AND pinyin = 'míngpiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '名片'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '名片'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'míngpiàn',
      meaning_vi = 'danh thiếp, card visit; tấm danh thiếp (biểu tượng)',
      example_hanzi = '在商务社交场合，双手递交和接取名片是一种基本的礼貌习惯。',
      example_pinyin = 'Zài shāngwù shèjiāo chǎnghé, shuāngshǒu dìjiāo hé jiēqǔ míngpiàn shì yì zhǒng jīběn de lǐmào xíguàn.',
      example_vi = 'Trong các dịp giao tế thương mại, đưa và nhận danh thiếp bằng hai tay là một thói quen lịch thiệp cơ bản.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '名片',
      'míngpiàn',
      'danh thiếp, card visit; tấm danh thiếp (biểu tượng)',
      'Danh từ',
      'HSK 5',
      '在商务社交场合，双手递交和接取名片是一种基本的礼貌习惯。',
      'Zài shāngwù shèjiāo chǎnghé, shuāngshǒu dìjiāo hé jiēqǔ míngpiàn shì yì zhǒng jīběn de lǐmào xíguàn.',
      'Trong các dịp giao tế thương mại, đưa và nhận danh thiếp bằng hai tay là một thói quen lịch thiệp cơ bản.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在商务社交场合，双手递交和接取名片是一种基本的礼貌习惯。', 'Zài shāngwù shèjiāo chǎnghé, shuāngshǒu dìjiāo hé jiēqǔ míngpiàn shì yì zhǒng jīběn de lǐmào xíguàn.', 'Trong các dịp giao tế thương mại, đưa và nhận danh thiếp bằng hai tay là một thói quen lịch thiệp cơ bản.', 'basic', 1),
      (v_id, '拥有自主知识产权的中国高铁、特高压输电工程与新能源汽车，已成为彰显国家高端工业制造强劲实力的闪亮“国家名片”。', 'Yōngyǒu zìzhǔ zhīshi chǎnquán de Zhōngguó gāotiě, tè-gāoyā shūdiàn gōngchéng yǔ xīnnéngyuán qìchē, yǐ chéngwéi zhāngxiǎn guójiā gāoduān gōngyè zhìzào qiángjìn shílì de shǎnliàng “guójiā míngpiàn”.', 'Đường sắt cao tốc Trung Quốc, công trình truyền tải điện siêu cao áp và xe năng lượng mới sở hữu quyền sở hữu trí tuệ tự chủ đã trở thành những "tấm danh thiếp quốc gia" rực rỡ thể hiện sức mạnh nội lực to lớn của ngành chế tạo công nghiệp cao cấp đất nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2776] [明确] (míngquè) - rõ ràng, dứt khoát, minh xác; làm rõ [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '明确' AND pinyin = 'míngquè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '明确' AND pinyin = 'míngquè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '明确'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '明确'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'míngquè',
      meaning_vi = 'rõ ràng, dứt khoát, minh xác; làm rõ',
      example_hanzi = '开会前必须明确本次讨论的核心议题与具体解决目标。',
      example_pinyin = 'Kāihuì qián bìxū míngquè běn cì tǎolùn de héxīn yìtí yǔ jùtǐ jiějué mùbiāo.',
      example_vi = 'Trước khi họp bắt buộc phải làm rõ chủ đề cốt lõi của buổi thảo luận lần này cùng mục tiêu giải quyết cụ thể.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '明确',
      'míngquè',
      'rõ ràng, dứt khoát, minh xác; làm rõ',
      'Tính từ / Động từ',
      'HSK 5',
      '开会前必须明确本次讨论的核心议题与具体解决目标。',
      'Kāihuì qián bìxū míngquè běn cì tǎolùn de héxīn yìtí yǔ jùtǐ jiějué mùbiāo.',
      'Trước khi họp bắt buộc phải làm rõ chủ đề cốt lõi của buổi thảo luận lần này cùng mục tiêu giải quyết cụ thể.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '开会前必须明确本次讨论的核心议题与具体解决目标。', 'Kāihuì qián bìxū míngquè běn cì tǎolùn de héxīn yìtí yǔ jùtǐ jiějué mùbiāo.', 'Trước khi họp bắt buộc phải làm rõ chủ đề cốt lõi của buổi thảo luận lần này cùng mục tiêu giải quyết cụ thể.', 'basic', 1),
      (v_id, '最新出台的知识产权保护司法解释进一步明确了侵犯数字商业秘密惩罚性赔偿的适用条件，有力震慑了恶意侵权行为。', 'Zuìxīn chūtái de zhīshi chǎnquán bǎohù sīfǎ jiěshì jìnyíbù míngquè le qīnfàn shùzì shāngyè mìmì chéngfáxìng péicháng de shìyòng tiáojiàn, yǒulì zhènshè le èyì qīnquán xíngwéi.', 'Bản giải thích tư pháp về bảo vệ quyền sở hữu trí tuệ mới được ban hành đã làm rõ hơn nữa các điều kiện áp dụng mức bồi thường mang tính trừng phạt đối với hành vi xâm phạm bí mật thương mại số, răn đe mạnh mẽ các hành vi xâm phạm quyền sở hữu mang tính ác ý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2777] [明显] (míngxiǎn) - rõ rệt, hiển nhiên, rõ ràng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '明显' AND pinyin = 'míngxiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '明显' AND pinyin = 'míngxiǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '明显'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '明显'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'míngxiǎn',
      meaning_vi = 'rõ rệt, hiển nhiên, rõ ràng',
      example_hanzi = '经过一个月的系统锻炼，他的体能状态有了明显的改善。',
      example_pinyin = 'Jīngguò yí gè yuè de xìtǒng duànliàn, tā de tǐnéng zhuàngtài yǒu le míngxiǎn de gǎishàn.',
      example_vi = 'Qua một tháng rèn luyện có hệ thống, thể lực của anh ấy đã có sự cải thiện rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '明显',
      'míngxiǎn',
      'rõ rệt, hiển nhiên, rõ ràng',
      'Tính từ',
      'HSK 5',
      '经过一个月的系统锻炼，他的体能状态有了明显的改善。',
      'Jīngguò yí gè yuè de xìtǒng duànliàn, tā de tǐnéng zhuàngtài yǒu le míngxiǎn de gǎishàn.',
      'Qua một tháng rèn luyện có hệ thống, thể lực của anh ấy đã có sự cải thiện rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过一个月的系统锻炼，他的体能状态有了明显的改善。', 'Jīngguò yí gè yuè de xìtǒng duànliàn, tā de tǐnéng zhuàngtài yǒu le míngxiǎn de gǎishàn.', 'Qua một tháng rèn luyện có hệ thống, thể lực của anh ấy đã có sự cải thiện rõ rệt.', 'basic', 1),
      (v_id, '统计数据显示，高附加值绿色低碳产业对规上工业增加值增长的拉动作用呈现出明显的提速态势。', 'Tǒngjì shùjù xiǎnshì, gāo fùjiāzhí lǜsè dītàn chǎnyè duì guīshàng gōngyè zēngjiāzhí zēngzhǎng de lādòng zuòyòng chéngxiàn chū míngxiǎn de tísù tàishì.', 'Số liệu thống kê chỉ ra rằng, tác động thúc đẩy của các ngành công nghiệp xanh ít carbon có giá trị gia tăng cao đối với đà tăng trưởng giá trị gia tăng công nghiệp quy mô lớn đang thể hiện xu thế tăng tốc rõ rệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2778] [明星] (míngxīng) - ngôi sao, minh tinh, nhân vật xuất chúng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '明星' AND pinyin = 'míngxīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '明星' AND pinyin = 'míngxīng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '明星'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '明星'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'míngxīng',
      meaning_vi = 'ngôi sao, minh tinh, nhân vật xuất chúng',
      example_hanzi = '他在全国青年田径锦标赛中一战成名，成为了大家心目中的体育明星。',
      example_pinyin = 'Tā zài quánguó qīngnián tiánjìng jǐnbiāosài zhōng yízhàn-chéngmíng, chéngwéi le dàjiā xīnmù zhōng de tǐyù míngxīng.',
      example_vi = 'Anh ấy chỉ sau một trận đấu tại giải vô địch điền kinh thanh niên toàn quốc đã nổi danh, trở thành ngôi sao thể thao trong mắt mọi người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '明星',
      'míngxīng',
      'ngôi sao, minh tinh, nhân vật xuất chúng',
      'Danh từ',
      'HSK 5',
      '他在全国青年田径锦标赛中一战成名，成为了大家心目中的体育明星。',
      'Tā zài quánguó qīngnián tiánjìng jǐnbiāosài zhōng yízhàn-chéngmíng, chéngwéi le dàjiā xīnmù zhōng de tǐyù míngxīng.',
      'Anh ấy chỉ sau một trận đấu tại giải vô địch điền kinh thanh niên toàn quốc đã nổi danh, trở thành ngôi sao thể thao trong mắt mọi người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在全国青年田径锦标赛中一战成名，成为了大家心目中的体育明星。', 'Tā zài quánguó qīngnián tiánjìng jǐnbiāosài zhōng yízhàn-chéngmíng, chéngwéi le dàjiā xīnmù zhōng de tǐyù míngxīng.', 'Anh ấy chỉ sau một trận đấu tại giải vô địch điền kinh thanh niên toàn quốc đã nổi danh, trở thành ngôi sao thể thao trong mắt mọi người.', 'basic', 1),
      (v_id, '公众人物与演艺明星应当自觉珍惜自身社会声誉，带头践行社会主义核心价值观并积极投身公益事业，发挥良好的示范表率作用。', 'Gōngzhòng rénwù yǔ yǎnyì míngxīng yīngdāng zìjué zhēnxī zìshēn shèhuì shēngyù, dàitóu jiànxíng shèhuì zhǔyì héxīn jiàzhíguān bìng jījí tóushēn gōngyì shìyè, fāhuī liánghǎo de shìfàn biǎoshuài zuòyòng.', 'Người của công chúng và các ngôi sao nghệ thuật biểu diễn nên tự giác trân quý danh tiếng xã hội của bản thân, đi đầu thực hành các giá trị cốt lõi và tích cực tham gia các hoạt động thiện nguyện công ích, phát huy vai trò nêu gương sáng tốt đẹp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2779] [命] (mìng) - tính mạng, mạng sống; mệnh, số phận; mệnh lệnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '命' AND pinyin = 'mìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '命' AND pinyin = 'mìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '命'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '命'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'mìng',
      meaning_vi = 'tính mạng, mạng sống; mệnh, số phận; mệnh lệnh',
      example_hanzi = '在抗击自然灾害中，救援队伍始终坚持人民至上、生命至上。',
      example_pinyin = 'Zài kàngjī zìrán zāihài zhōng, jiùyuán duìwù shǐzhōng jiānchí rénmín zhìshàng, shēngmìng zhìshàng.',
      example_vi = 'Trong công cuộc chống chọi thiên tai, lực lượng cứu hộ luôn kiên trì đặt nhân dân lên trên hết, tính mạng sinh mạng con người là trên hết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '命',
      'mìng',
      'tính mạng, mạng sống; mệnh, số phận; mệnh lệnh',
      'Danh từ',
      'HSK 5',
      '在抗击自然灾害中，救援队伍始终坚持人民至上、生命至上。',
      'Zài kàngjī zìrán zāihài zhōng, jiùyuán duìwù shǐzhōng jiānchí rénmín zhìshàng, shēngmìng zhìshàng.',
      'Trong công cuộc chống chọi thiên tai, lực lượng cứu hộ luôn kiên trì đặt nhân dân lên trên hết, tính mạng sinh mạng con người là trên hết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在抗击自然灾害中，救援队伍始终坚持人民至上、生命至上。', 'Zài kàngjī zìrán zāihài zhōng, jiùyuán duìwù shǐzhōng jiānchí rénmín zhìshàng, shēngmìng zhìshàng.', 'Trong công cuộc chống chọi thiên tai, lực lượng cứu hộ luôn kiên trì đặt nhân dân lên trên hết, tính mạng sinh mạng con người là trên hết.', 'basic', 1),
      (v_id, '当代有为青年应当勇于打破所谓的宿命论桎梏，坚信我命由我不由天，在拼搏奉献中把前途命运牢牢掌握在自己手中。', 'Dāngdài yǒuwéi qīngnián yīngdāng yǒngyú dǎpò suǒwèi de sùmìnglùn zhìgù, jiānxìn wǒ mìng yóu wǒ bù yóu tiān, zài pīnbó fèngxiàn zhōng bǎ qiántú mìngyùn láoláo zhǎngwò zài zìjǐ shǒuzhōng.', 'Thanh niên có chí hướng thời nay cần dũng cảm đập tan xiềng xích của cái gọi là thuyết định mệnh, vững tin rằng mệnh do ta chứ không do trời định, trong nỗ lực cống hiến nắm chắc tiền đồ vận mệnh trong tay mình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2780] [命运] (mìngyùn) - vận mệnh, số phận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '命运' AND pinyin = 'mìngyùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '命运' AND pinyin = 'mìngyùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '命运'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '命运'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'mìngyùn',
      meaning_vi = 'vận mệnh, số phận',
      example_hanzi = '刻苦读书与掌握一技之长是偏远山区孩子改变自身命运的重要途径。',
      example_pinyin = 'Kèkǔ dúshū yǔ zhǎngwò yíjìzhīcháng shì piānyuǎn shānqū háizi gǎibiàn zìshēn mìngyùn de zhòngyào tújìng.',
      example_vi = 'Chăm chỉ học hành và nắm vững một kỹ năng nghề nghiệp là con đường quan trọng để trẻ em vùng cao hẻo lánh thay đổi số phận bản thân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '命运',
      'mìngyùn',
      'vận mệnh, số phận',
      'Danh từ',
      'HSK 5',
      '刻苦读书与掌握一技之长是偏远山区孩子改变自身命运的重要途径。',
      'Kèkǔ dúshū yǔ zhǎngwò yíjìzhīcháng shì piānyuǎn shānqū háizi gǎibiàn zìshēn mìngyùn de zhòngyào tújìng.',
      'Chăm chỉ học hành và nắm vững một kỹ năng nghề nghiệp là con đường quan trọng để trẻ em vùng cao hẻo lánh thay đổi số phận bản thân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '刻苦读书与掌握一技之长是偏远山区孩子改变自身命运的重要途径。', 'Kèkǔ dúshū yǔ zhǎngwò yíjìzhīcháng shì piānyuǎn shānqū háizi gǎibiàn zìshēn mìngyùn de zhòngyào tújìng.', 'Chăm chỉ học hành và nắm vững một kỹ năng nghề nghiệp là con đường quan trọng để trẻ em vùng cao hẻo lánh thay đổi số phận bản thân.', 'basic', 1),
      (v_id, '人类同处一个地球村，面对气候变暖、粮食安全等全球性危机，各国唯有同舟共济，才能携手构建休戚与共的人类命运共同体。', 'Rénlèi tóng chǔ yí gè dìqiúcūn, miànduì qìhòu biànnuǎn, liángshi ānquán děng quánqiúxìng wēijī, gè guó wéiyǒu tóngzhōu-gòngjì, cáinéng xiéshǒu gòujiàn xiūqī-yǔgòng de rénlèi mìngyùn gòngtóngtǐ.', 'Nhân loại cùng sống trong một ngôi làng Trái Đất, trước các cuộc khủng hoảng toàn cầu như biến đổi khí hậu ấm lên và an ninh lương thực, các quốc gia chỉ có cùng chung một con thuyền mới có thể chung tay dựng xây cộng đồng chung vận mệnh nhân loại cùng chung vui buồn hoạn nạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2781] [摸] (mō) - sờ, sờ soạng, mò mẫm, tìm hiểu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '摸' AND pinyin = 'mō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摸' AND pinyin = 'mō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '摸'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'mō',
      meaning_vi = 'sờ, sờ soạng, mò mẫm, tìm hiểu',
      example_hanzi = '这件真丝衬衫摸起来手感非常柔软光滑。',
      example_pinyin = 'Zhè jiàn zhēnsī chènshān mō qǐlái shǒugǎn fēicháng róuruǎn guānghuá.',
      example_vi = 'Chiếc áo sơ mi lụa tơ tằm này sờ vào cảm giác tay vô cùng mềm mại và trơn láng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '摸',
      'mō',
      'sờ, sờ soạng, mò mẫm, tìm hiểu',
      'Động từ',
      'HSK 5',
      '这件真丝衬衫摸起来手感非常柔软光滑。',
      'Zhè jiàn zhēnsī chènshān mō qǐlái shǒugǎn fēicháng róuruǎn guānghuá.',
      'Chiếc áo sơ mi lụa tơ tằm này sờ vào cảm giác tay vô cùng mềm mại và trơn láng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这件真丝衬衫摸起来手感非常柔软光滑。', 'Zhè jiàn zhēnsī chènshān mō qǐlái shǒugǎn fēicháng róuruǎn guānghuá.', 'Chiếc áo sơ mi lụa tơ tằm này sờ vào cảm giác tay vô cùng mềm mại và trơn láng.', 'basic', 1),
      (v_id, '中国改革开放初期正是依靠“摸着石头过河”的务实探索精神，敢闯敢试，成功开创了一条具有中国特色的社会主义现代化道路。', 'Zhōngguó gǎigé-kāifàng chūqī zhèngshì yīkào “mō zhe shítou guò hé” de wùshí tànsuǒ jīngshén, gǎn chuǎng gǎn shì, chénggōng kāichuàng le yì tiáo jùyǒu Zhōngguó tèsè de shèhuì zhǔyì xiàndàihuà dàolù.', 'Thời kỳ đầu cải cách mở cửa của Trung Quốc chính là nhờ vào tinh thần tìm tòi thực tế "dò đá qua sông", dám nghĩ dám làm, đã mở ra thành công con đường hiện đại hóa xã hội chủ nghĩa mang đặc sắc Trung Quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2782] [模糊] (móhu) - mờ mịt, mơ hồ, nhòe; làm mờ [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '模糊' AND pinyin = 'móhu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '模糊' AND pinyin = 'móhu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '模糊'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '模糊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'móhu',
      meaning_vi = 'mờ mịt, mơ hồ, nhòe; làm mờ',
      example_hanzi = '大雨淋湿了汽车的前挡风玻璃，外面的街景变得一片模糊。',
      example_pinyin = 'Dàyǔ línshī le qìchē de qián dǎngfēng bōli, wàimiàn de jiējǐng biànde yí piàn móhu.',
      example_vi = 'Mưa lớn làm ướt sũng kính chắn gió phía trước của xe ô tô, cảnh quan đường phố bên ngoài trở nên mờ mịt một màu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '模糊',
      'móhu',
      'mờ mịt, mơ hồ, nhòe; làm mờ',
      'Tính từ / Động từ',
      'HSK 5',
      '大雨淋湿了汽车的前挡风玻璃，外面的街景变得一片模糊。',
      'Dàyǔ línshī le qìchē de qián dǎngfēng bōli, wàimiàn de jiējǐng biànde yí piàn móhu.',
      'Mưa lớn làm ướt sũng kính chắn gió phía trước của xe ô tô, cảnh quan đường phố bên ngoài trở nên mờ mịt một màu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大雨淋湿了汽车的前挡风玻璃，外面的街景变得一片模糊。', 'Dàyǔ línshī le qìchē de qián dǎngfēng bōli, wàimiàn de jiējǐng biànde yí piàn móhu.', 'Mưa lớn làm ướt sũng kính chắn gió phía trước của xe ô tô, cảnh quan đường phố bên ngoài trở nên mờ mịt một màu.', 'basic', 1),
      (v_id, '在起草具有法律约束力的商业合同时，对违约责任的界定必须精确严密，决不能留下任何模棱两可的模糊表述。', 'Zài qǐcǎo jùyǒu fǎlǜ yuēshùlì de shāngyè hétong shí, duì wéiyuē zérèn de jièdìng bìxū jīngquè yánmì, jué bùnéng liúxià rènhé móléng-liǎngkě de móhu biǎoshù.', 'Khi soạn thảo hợp đồng thương mại có giá trị ràng buộc pháp lý, việc phân định trách nhiệm vi phạm hợp đồng phải thật chính xác chặt chẽ, tuyệt đối không được để lại bất kỳ cách diễn đạt mơ hồ nước đôi nào.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2783] [模式] (móshì) - mô hình, khuôn mẫu, phương thức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '模式' AND pinyin = 'móshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '模式' AND pinyin = 'móshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '模式'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '模式'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'móshì',
      meaning_vi = 'mô hình, khuôn mẫu, phương thức',
      example_hanzi = '这所学校推行的小班互动式教学模式深受广大学生与家长的欢迎。',
      example_pinyin = 'Zhè suǒ xuéxiào tuīxíng de xiǎobān hùdòngshì jiàoxué móshì shēnshòu guǎngdà xuésheng yǔ jiāzhǎng de huānyíng.',
      example_vi = 'Mô hình giảng dạy tương tác lớp nhỏ do ngôi trường này áp dụng rất được đông đảo học sinh và phụ huynh đón nhận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '模式',
      'móshì',
      'mô hình, khuôn mẫu, phương thức',
      'Danh từ',
      'HSK 5',
      '这所学校推行的小班互动式教学模式深受广大学生与家长的欢迎。',
      'Zhè suǒ xuéxiào tuīxíng de xiǎobān hùdòngshì jiàoxué móshì shēnshòu guǎngdà xuésheng yǔ jiāzhǎng de huānyíng.',
      'Mô hình giảng dạy tương tác lớp nhỏ do ngôi trường này áp dụng rất được đông đảo học sinh và phụ huynh đón nhận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这所学校推行的小班互动式教学模式深受广大学生与家长的欢迎。', 'Zhè suǒ xuéxiào tuīxíng de xiǎobān hùdòngshì jiàoxué móshì shēnshòu guǎngdà xuésheng yǔ jiāzhǎng de huānyíng.', 'Mô hình giảng dạy tương tác lớp nhỏ do ngôi trường này áp dụng rất được đông đảo học sinh và phụ huynh đón nhận.', 'basic', 1),
      (v_id, '以数字平台为依托的共享经济新商业模式，极大降低了交易边际成本并促进了社会闲置资源的跨区域优化配置。', 'Yǐ shùzì píngtái wéi yītuō de gòngxiǎng jīngjì xīn shāngyè móshì, jídà jiàngdī le jiāoyì biānjì chéngběn bìng cùjìn le shèhuì xiánzhì zīyuán de kuà qūyù yōuhuà pèizhì.', 'Mô hình kinh doanh mới về kinh tế chia sẻ dựa trên nền tảng kỹ thuật số đã giảm thiểu tối đa chi phí biên giao dịch và thúc đẩy việc phân bổ tối ưu các nguồn lực dư thừa trong xã hội xuyên khu vực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2784] [陌生] (mòshēng) - xa lạ, lạ lẫm, không quen biết [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '陌生' AND pinyin = 'mòshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '陌生' AND pinyin = 'mòshēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '陌生'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '陌生'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'mòshēng',
      meaning_vi = 'xa lạ, lạ lẫm, không quen biết',
      example_hanzi = '刚到一个陌生的城市上大学，小王起初在生活上有些不太习惯。',
      example_pinyin = 'Gāng dào yí gè mòshēng de chéngshì shàng dàxué, Xiǎo Wáng qǐchū zài shēnghuó shang yǒuxiē bú tài xíguàn.',
      example_vi = 'Vừa tới một thành phố xa lạ để học đại học, Tiểu Vương ban đầu có phần chưa quen lắm trong nếp sinh hoạt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '陌生',
      'mòshēng',
      'xa lạ, lạ lẫm, không quen biết',
      'Tính từ',
      'HSK 5',
      '刚到一个陌生的城市上大学，小王起初在生活上有些不太习惯。',
      'Gāng dào yí gè mòshēng de chéngshì shàng dàxué, Xiǎo Wáng qǐchū zài shēnghuó shang yǒuxiē bú tài xíguàn.',
      'Vừa tới một thành phố xa lạ để học đại học, Tiểu Vương ban đầu có phần chưa quen lắm trong nếp sinh hoạt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '刚到一个陌生的城市上大学，小王起初在生活上有些不太习惯。', 'Gāng dào yí gè mòshēng de chéngshì shàng dàxué, Xiǎo Wáng qǐchū zài shēnghuó shang yǒuxiē bú tài xíguàn.', 'Vừa tới một thành phố xa lạ để học đại học, Tiểu Vương ban đầu có phần chưa quen lắm trong nếp sinh hoạt.', 'basic', 1),
      (v_id, '社区工作者以高度的亲和力走进素不相识的陌生家庭，耐心宣讲惠民医疗政策，架起了党群干群之间的连心桥。', 'Shèqū gōngzuòzhě yǐ gāodù de qīnhélì zǒujìn sùbù-xiāngshí de mòshēng jiātíng, nàixīn xuānjiǎng huìmín yīliáo zhèngcè, jiàqǐ le dǎng-qún gàn-qún zhījiān de liánxīnqiáo.', 'Các cán bộ làm công tác cộng đồng với sự gần gũi cao độ đã bước vào những gia đình xa lạ vốn chưa từng quen biết, kiên nhẫn tuyên truyền chính sách y tế vì dân, bắc nên nhịp cầu nối liền trái tim giữa cán bộ và quần chúng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2785] [某] (mǒu) - mỗ, nào đó, người nào đó, cái nào đó [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '某' AND pinyin = 'mǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '某' AND pinyin = 'mǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '某'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '某'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'mǒu',
      meaning_vi = 'mỗ, nào đó, người nào đó, cái nào đó',
      example_hanzi = '这篇案例分析以南方某知名高新技术企业为样本展开了深入研究。',
      example_pinyin = 'Zhè piān ànlì fēnxī yǐ nánfāng mǒu zhīmíng gāoxīnjìshù qǐyè wéi yàngběn zhǎnkāi le shēnrù yánjiū.',
      example_vi = 'Bài phân tích tình huống này đã lấy một doanh nghiệp công nghệ cao nổi tiếng nào đó ở miền Nam làm mẫu thử để triển khai nghiên cứu chuyên sâu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '某',
      'mǒu',
      'mỗ, nào đó, người nào đó, cái nào đó',
      'Đại từ',
      'HSK 5',
      '这篇案例分析以南方某知名高新技术企业为样本展开了深入研究。',
      'Zhè piān ànlì fēnxī yǐ nánfāng mǒu zhīmíng gāoxīnjìshù qǐyè wéi yàngběn zhǎnkāi le shēnrù yánjiū.',
      'Bài phân tích tình huống này đã lấy một doanh nghiệp công nghệ cao nổi tiếng nào đó ở miền Nam làm mẫu thử để triển khai nghiên cứu chuyên sâu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这篇案例分析以南方某知名高新技术企业为样本展开了深入研究。', 'Zhè piān ànlì fēnxī yǐ nánfāng mǒu zhīmíng gāoxīnjìshù qǐyè wéi yàngběn zhǎnkāi le shēnrù yánjiū.', 'Bài phân tích tình huống này đã lấy một doanh nghiệp công nghệ cao nổi tiếng nào đó ở miền Nam làm mẫu thử để triển khai nghiên cứu chuyên sâu.', 'basic', 1),
      (v_id, '新闻报道在披露涉及未成年人合法权益的司法案件时，一律依法隐去当事人的真实姓名而以某某代替，切实履行未成年人司法保护职责。', 'Xīnwén bàodào zài pīlù shèjí wèichéngniánrén héfǎ quányì de sīfǎ ànjiàn shí, yílǜ yīfǎ yǐnqù dāngshìrén de zhēnshí xìngmíng ér yǐ mǒumǒu dàitì, qièshí lǚxíng wèichéngniánrén sīfǎ bǎohù zhízé.', 'Các bản tin báo chí khi đưa tin về các vụ án tư pháp liên quan đến quyền lợi hợp pháp của trẻ vị thành niên đều theo luật ẩn danh tính thật của đương sự và thay bằng ông/bà mỗ, thực hiện thiết thực trách nhiệm bảo vệ tư pháp người chưa thành niên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2786] [目光] (mùguāng) - ánh mắt, ánh nhìn; tầm nhìn, tầm mắt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '目光' AND pinyin = 'mùguāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '目光' AND pinyin = 'mùguāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '目光'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '目光'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'mùguāng',
      meaning_vi = 'ánh mắt, ánh nhìn; tầm nhìn, tầm mắt',
      example_hanzi = '当台上主持人宣布比赛结果时，全场观众的目光瞬间齐刷刷投向了大屏幕。',
      example_pinyin = 'Dāng táishang zhǔchírén xuānbù bǐsài jiéguǒ shí, quánchǎng guānzhòng de mùguāng shùnjiān qíshuāshuā tóuxiàng le dà píngmù.',
      example_vi = 'Khi người dẫn chương trình trên sân khấu tuyên bố kết quả cuộc thi, ánh mắt của toàn thể khán giả lập tức đồng loạt hướng về màn hình lớn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '目光',
      'mùguāng',
      'ánh mắt, ánh nhìn; tầm nhìn, tầm mắt',
      'Danh từ',
      'HSK 5',
      '当台上主持人宣布比赛结果时，全场观众的目光瞬间齐刷刷投向了大屏幕。',
      'Dāng táishang zhǔchírén xuānbù bǐsài jiéguǒ shí, quánchǎng guānzhòng de mùguāng shùnjiān qíshuāshuā tóuxiàng le dà píngmù.',
      'Khi người dẫn chương trình trên sân khấu tuyên bố kết quả cuộc thi, ánh mắt của toàn thể khán giả lập tức đồng loạt hướng về màn hình lớn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '当台上主持人宣布比赛结果时，全场观众的目光瞬间齐刷刷投向了大屏幕。', 'Dāng táishang zhǔchírén xuānbù bǐsài jiéguǒ shí, quánchǎng guānzhòng de mùguāng shùnjiān qíshuāshuā tóuxiàng le dà píngmù.', 'Khi người dẫn chương trình trên sân khấu tuyên bố kết quả cuộc thi, ánh mắt của toàn thể khán giả lập tức đồng loạt hướng về màn hình lớn.', 'basic', 1),
      (v_id, '优秀的战略决策者不能仅仅将目光局限于眼前的季度财报利润，更要把目光投向未来十年的产业变革大趋势。', 'Yōuxiù de zhànlüè juécèzhě bùnéng jǐnjǐn jiāng mùguāng júxiàn yú yǎnqián de jìdù cáibào lìrùn, gèng yào bǎ mùguāng tóuxiàng wèilái shí nián de chǎnyè biàngé dà qūshì.', 'Người ra quyết định chiến lược xuất sắc không thể chỉ hạn hẹp tầm nhìn vào lợi nhuận báo cáo tài chính hàng quý trước mắt, mà càng phải phóng tầm mắt tới xu thế cải cách ngành công nghiệp to lớn trong 10 năm tới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2787] [木头] (mùtou) - gỗ, khúc gỗ, thanh gỗ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '木头' AND pinyin = 'mùtou'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '木头' AND pinyin = 'mùtou'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '木头'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '木头'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'mùtou',
      meaning_vi = 'gỗ, khúc gỗ, thanh gỗ',
      example_hanzi = '工匠师傅正熟练地用锯子将这块优质红木木头切割成桌面板材。',
      example_pinyin = 'Gōngjiàng shīfu zhèng shúliàn de yòng jùzi jiāng zhè kuài yōuzhì hóngmù mùtou qiēgē chéng zhuōmiàn bǎncái.',
      example_vi = 'Bác thợ thủ công đang thuần thục dùng cưa xẻ khúc gỗ hồng mộc hảo hạng này thành tấm ván mặt bàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '木头',
      'mùtou',
      'gỗ, khúc gỗ, thanh gỗ',
      'Danh từ',
      'HSK 5',
      '工匠师傅正熟练地用锯子将这块优质红木木头切割成桌面板材。',
      'Gōngjiàng shīfu zhèng shúliàn de yòng jùzi jiāng zhè kuài yōuzhì hóngmù mùtou qiēgē chéng zhuōmiàn bǎncái.',
      'Bác thợ thủ công đang thuần thục dùng cưa xẻ khúc gỗ hồng mộc hảo hạng này thành tấm ván mặt bàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '工匠师傅正熟练地用锯子将这块优质红木木头切割成桌面板材。', 'Gōngjiàng shīfu zhèng shúliàn de yòng jùzi jiāng zhè kuài yōuzhì hóngmù mùtou qiēgē chéng zhuōmiàn bǎncái.', 'Bác thợ thủ công đang thuần thục dùng cưa xẻ khúc gỗ hồng mộc hảo hạng này thành tấm ván mặt bàn.', 'basic', 1),
      (v_id, '中国传统古建筑采用榫卯结构，通体全靠木头之间的凹凸咬合严丝合缝，历经千年风雨地震依然稳固屹立。', 'Zhōngguó chuántǒng gǔ jiànzhù cǎiyòng sǔnmǎo jiégòu, tōngtǐ quán kào mùtou zhījiān de āotū yǎohé yánsī-héfèng, lìjīng qiān nián fēngyǔ dìzhèn yīrán wěngù yìlì.', 'Kiến trúc cổ truyền thống Trung Hoa sử dụng kết cấu mộng ngàm, toàn thân hoàn toàn dựa vào sự khớp nối lồi lõm khít khao giữa các thanh gỗ với nhau, dẫu trải qua nghìn năm mưa gió động đất vẫn vững chãi đứng sừng sững.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2788] [哪怕] (nǎpà) - dẫu cho, cho dù, cho dẫu [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '哪怕' AND pinyin = 'nǎpà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哪怕' AND pinyin = 'nǎpà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '哪怕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哪怕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'nǎpà',
      meaning_vi = 'dẫu cho, cho dù, cho dẫu',
      example_hanzi = '哪怕前方的道路再艰难曲折，我们也要坚持不懈地走下去。',
      example_pinyin = 'Nǎpà qiánfāng de dàolù zài jiānnán qūzhé, wǒmen yě yào jiānchí-búxiè de zǒu xiàqù.',
      example_vi = 'Dẫu cho con đường phía trước có gian nan khúc khuỷu đến đâu, chúng ta cũng phải kiên trì bền bỉ bước tiếp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '哪怕',
      'nǎpà',
      'dẫu cho, cho dù, cho dẫu',
      'Liên từ',
      'HSK 5',
      '哪怕前方的道路再艰难曲折，我们也要坚持不懈地走下去。',
      'Nǎpà qiánfāng de dàolù zài jiānnán qūzhé, wǒmen yě yào jiānchí-búxiè de zǒu xiàqù.',
      'Dẫu cho con đường phía trước có gian nan khúc khuỷu đến đâu, chúng ta cũng phải kiên trì bền bỉ bước tiếp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '哪怕前方的道路再艰难曲折，我们也要坚持不懈地走下去。', 'Nǎpà qiánfāng de dàolù zài jiānnán qūzhé, wǒmen yě yào jiānchí-búxiè de zǒu xiàqù.', 'Dẫu cho con đường phía trước có gian nan khúc khuỷu đến đâu, chúng ta cũng phải kiên trì bền bỉ bước tiếp.', 'basic', 1),
      (v_id, '科研攻关往往需要坐冷板凳数十年，哪怕遭遇成百上千次的实验挫折，科学家们也依然百折不挠勇攀世界科学高峰。', 'Kēyán gōngguān wǎngwǎng xūyào zuò lěngbǎndèng shù shí nián, nǎpà zāoyù chéngbǎi-shàngqiān cì de shíyàn cuòzhé, kēxuéjiāmen yě yīrán bǎizhé-bùnáo yǒngpān shìjiè kēxué gāofēng.', 'Nghiên cứu khoa học mũi nhọn thường đòi hỏi phải ngồi ghế lạnh suốt mấy chục năm ròng, dẫu cho gặp phải hàng trăm hàng nghìn lần thất bại thực nghiệm, các nhà khoa học vẫn kiên cường bất khuất dũng cảm trèo lên đỉnh cao khoa học thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2789] [难得] (nándé) - hiếm có, đáng quý, khó gặp [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '难得' AND pinyin = 'nándé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '难得' AND pinyin = 'nándé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '难得'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '难得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'nándé',
      meaning_vi = 'hiếm có, đáng quý, khó gặp',
      example_hanzi = '今天难得全家人都放假聚在一起，妈妈特地做了一桌丰盛可口的饭菜。',
      example_pinyin = 'Jīntiān nándé quán jiārén dōu fàngjià jù zài yìqǐ, māma tēdì zuò le yì zhuō fēngshèng kěkǒu de fàncài.',
      example_vi = 'Hôm nay hiếm có dịp cả nhà đều được nghỉ quây quần bên nhau, mẹ đã đặc biệt nấu một bàn cơm canh thịnh soạn ngon lành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '难得',
      'nándé',
      'hiếm có, đáng quý, khó gặp',
      'Tính từ / Phó từ',
      'HSK 5',
      '今天难得全家人都放假聚在一起，妈妈特地做了一桌丰盛可口的饭菜。',
      'Jīntiān nándé quán jiārén dōu fàngjià jù zài yìqǐ, māma tēdì zuò le yì zhuō fēngshèng kěkǒu de fàncài.',
      'Hôm nay hiếm có dịp cả nhà đều được nghỉ quây quần bên nhau, mẹ đã đặc biệt nấu một bàn cơm canh thịnh soạn ngon lành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天难得全家人都放假聚在一起，妈妈特地做了一桌丰盛可口的饭菜。', 'Jīntiān nándé quán jiārén dōu fàngjià jù zài yìqǐ, māma tēdì zuò le yì zhuō fēngshèng kěkǒu de fàncài.', 'Hôm nay hiếm có dịp cả nhà đều được nghỉ quây quần bên nhau, mẹ đã đặc biệt nấu một bàn cơm canh thịnh soạn ngon lành.', 'basic', 1),
      (v_id, '在百年变局加速演进的当下，中国展现出强劲的经济发展韧性与长期政治社会稳定，这是极为宝贵且难得的确定性发展环境。', 'Zài bǎi nián biànjú jiāsù yǎnjìn de dāngxià, Zhōngguó zhǎnxiàn chū qiángjìn de jīngjì fāzhǎn rènxìng yǔ chángqī zhèngzhì shèhuì wěndìng, zhè shì jíwéi bǎoguì qiě nándé de quèdìngxìng fāzhǎn huánjìng.', 'Giữa thời điểm cục diện trăm năm đang gia tốc đổi thay, Trung Quốc thể hiện sức bền phát triển kinh tế mạnh mẽ và sự ổn định chính trị xã hội lâu dài, đây là một môi trường phát triển có tính xác định vô cùng quý báu và hiếm có.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2790] [难度] (nándù) - độ khó, mức độ khó khăn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '难度' AND pinyin = 'nándù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '难度' AND pinyin = 'nándù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '难度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '难度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'nándù',
      meaning_vi = 'độ khó, mức độ khó khăn',
      example_hanzi = '体操运动员在单杠决赛中挑战了一套极高难度的动作组合。',
      example_pinyin = 'Tǐcāo yùndòngyuán zài dāngàng juésài zhōng tiǎozhàn le yí tào jí gāo nándù de dòngzuò zǔhé.',
      example_vi = 'Vận động viên thể dục dụng cụ trong trận chung kết xà đơn đã thử thách một tổ hợp động tác có độ khó cực cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '难度',
      'nándù',
      'độ khó, mức độ khó khăn',
      'Danh từ',
      'HSK 5',
      '体操运动员在单杠决赛中挑战了一套极高难度的动作组合。',
      'Tǐcāo yùndòngyuán zài dāngàng juésài zhōng tiǎozhàn le yí tào jí gāo nándù de dòngzuò zǔhé.',
      'Vận động viên thể dục dụng cụ trong trận chung kết xà đơn đã thử thách một tổ hợp động tác có độ khó cực cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '体操运动员在单杠决赛中挑战了一套极高难度的动作组合。', 'Tǐcāo yùndòngyuán zài dāngàng juésài zhōng tiǎozhàn le yí tào jí gāo nándù de dòngzuò zǔhé.', 'Vận động viên thể dục dụng cụ trong trận chung kết xà đơn đã thử thách một tổ hợp động tác có độ khó cực cao.', 'basic', 1),
      (v_id, '在海底超深水强压高腐蚀极端地质条件下钻探开采天然气水合物，其工程施工技术难度堪称世界能源开采史之最。', 'Zài hǎidǐ chāoshēnshuǐ qiángyā gāo fǔshí jíduān dìzhì tiáojiàn xià zuàntàn kāicǎi tiānránqì shuǐhèwù, qí gōngchéng shīgōng jìshù nándù kānchēng shìjiè néngyuán kāicǎi shǐ zhī zuì.', 'Khoan thăm dò và khai thác băng cháy trong điều kiện địa chất cực đoan dưới đáy biển sâu với áp suất cực lớn và độ ăn mòn cao, mức độ khó khăn kỹ thuật thi công của nó được xem là kỷ lục hàng đầu trong lịch sử khai thác năng lượng thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2791] [难以] (nányǐ) - khó mà, khó lòng, không thể [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '难以' AND pinyin = 'nányǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '难以' AND pinyin = 'nányǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '难以'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '难以'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Phó từ',
      pinyin = 'nányǐ',
      meaning_vi = 'khó mà, khó lòng, không thể',
      example_hanzi = '听闻老朋友突发意外离世的消息，大家心中的悲痛心情难以言表。',
      example_pinyin = 'Tīngwén lǎo péngyou tūfā yìwài líshì de xiāoxi, dàjiā xīnzhōng de bēitòng xīnqíng nányǐ yánbiǎo.',
      example_vi = 'Nghe tin người bạn cũ đột ngột qua đời vì tai nạn, nỗi niềm đau xót trong lòng mọi người khó mà diễn tả thành lời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '难以',
      'nányǐ',
      'khó mà, khó lòng, không thể',
      'Động từ / Phó từ',
      'HSK 5',
      '听闻老朋友突发意外离世的消息，大家心中的悲痛心情难以言表。',
      'Tīngwén lǎo péngyou tūfā yìwài líshì de xiāoxi, dàjiā xīnzhōng de bēitòng xīnqíng nányǐ yánbiǎo.',
      'Nghe tin người bạn cũ đột ngột qua đời vì tai nạn, nỗi niềm đau xót trong lòng mọi người khó mà diễn tả thành lời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听闻老朋友突发意外离世的消息，大家心中的悲痛心情难以言表。', 'Tīngwén lǎo péngyou tūfā yìwài líshì de xiāoxi, dàjiā xīnzhōng de bēitòng xīnqíng nányǐ yánbiǎo.', 'Nghe tin người bạn cũ đột ngột qua đời vì tai nạn, nỗi niềm đau xót trong lòng mọi người khó mà diễn tả thành lời.', 'basic', 1),
      (v_id, '如果不能在底层基础研究与原始创新上取得自主突破，关键产业核心零部件长期受制于人的被动局面将难以从根本上扭转。', 'Rúguǒ bùnéng zài dǐcéng jīchǔ yánjiū yǔ yuánshǐ chuàngxīn shang qǔdé zìzhǔ tūpò, guānjiàn chǎnyè héxīn língbùjiàn chángqī shòuzhìyúrén de bèidòng júmiàn jiāng nányǐ cóng gēnběn shang niǔzhuǎn.', 'Nếu không thể đạt được đột phá tự chủ trong nghiên cứu cơ bản nền tảng và sáng tạo nguyên bản, thì cục diện bị động phụ thuộc vào người khác suốt thời gian dài của các linh kiện cốt lõi trong ngành công nghiệp then chốt sẽ khó lòng xoay chuyển từ gốc rễ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2792] [男子] (nánzǐ) - nam giới, nam tử, đàn ông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '男子' AND pinyin = 'nánzǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '男子' AND pinyin = 'nánzǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '男子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '男子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'nánzǐ',
      meaning_vi = 'nam giới, nam tử, đàn ông',
      example_hanzi = '我国短跑运动员在奥运会男子一百米半决赛中跑出了优异成绩。',
      example_pinyin = 'Wǒ guó duǎnpǎo yùndòngyuán zài Àoyùnhuì nánzǐ yībǎimǐ bànjuésài zhōng pǎochū le yōuyì chéngjì.',
      example_vi = 'Vận động viên chạy cự ly ngắn nước ta đã đạt thành tích xuất sắc tại vòng bán kết cự ly 100m nam Thế vận hội Olympic.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '男子',
      'nánzǐ',
      'nam giới, nam tử, đàn ông',
      'Danh từ',
      'HSK 5',
      '我国短跑运动员在奥运会男子一百米半决赛中跑出了优异成绩。',
      'Wǒ guó duǎnpǎo yùndòngyuán zài Àoyùnhuì nánzǐ yībǎimǐ bànjuésài zhōng pǎochū le yōuyì chéngjì.',
      'Vận động viên chạy cự ly ngắn nước ta đã đạt thành tích xuất sắc tại vòng bán kết cự ly 100m nam Thế vận hội Olympic.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我国短跑运动员在奥运会男子一百米半决赛中跑出了优异成绩。', 'Wǒ guó duǎnpǎo yùndòngyuán zài Àoyùnhuì nánzǐ yībǎimǐ bànjuésài zhōng pǎochū le yōuyì chéngjì.', 'Vận động viên chạy cự ly ngắn nước ta đã đạt thành tích xuất sắc tại vòng bán kết cự ly 100m nam Thế vận hội Olympic.', 'basic', 1),
      (v_id, '中华传统文化崇尚顶天立地、保家卫国的堂堂男子汉气概，激励着一代代热血青年在国家危难时刻挺身而出。', 'Zhōnghuá chuántǒng wénhuà chóngshàng dǐngtiān-lìdì, bǎojiā-wèiguó de tángtáng nánzǐhàn qìgài, jīlì zhe yídàidài rèxiè qīngnián zài guójiā wēinàn shíkè tǐngshēn-érchū.', 'Văn hóa truyền thống Trung Hoa tôn vinh khí phách đấng nam nhi đường hoàng đầu đội trời chân đạp đất xả thân bảo vệ quê hương đất nước, khích lệ từng thế hệ thanh niên nhiệt huyết dám xông pha trong thời khắc quốc gia nguy nan.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2793] [闹] (nào) - ồn ào, náo nhiệt; làm ầm ĩ; phát sinh (bệnh, tai họa, đói kém) [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '闹' AND pinyin = 'nào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '闹' AND pinyin = 'nào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '闹'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '闹'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'nào',
      meaning_vi = 'ồn ào, náo nhiệt; làm ầm ĩ; phát sinh (bệnh, tai họa, đói kém)',
      example_hanzi = '大街上车水马龙，到处都是热闹喧哗的人流。',
      example_pinyin = 'Dàjiē shang chēshuǐ-mǎlóng, dàochù dōu shì rènao xuānhuá de rénliú.',
      example_vi = 'Trên phố lớn xe cộ nườm nượp như nước chảy ngựa phi, đâu đâu cũng là dòng người ồn ào náo nhiệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '闹',
      'nào',
      'ồn ào, náo nhiệt; làm ầm ĩ; phát sinh (bệnh, tai họa, đói kém)',
      'Tính từ / Động từ',
      'HSK 5',
      '大街上车水马龙，到处都是热闹喧哗的人流。',
      'Dàjiē shang chēshuǐ-mǎlóng, dàochù dōu shì rènao xuānhuá de rénliú.',
      'Trên phố lớn xe cộ nườm nượp như nước chảy ngựa phi, đâu đâu cũng là dòng người ồn ào náo nhiệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大街上车水马龙，到处都是热闹喧哗的人流。', 'Dàjiē shang chēshuǐ-mǎlóng, dàochù dōu shì rènao xuānhuá de rénliú.', 'Trên phố lớn xe cộ nườm nượp như nước chảy ngựa phi, đâu đâu cũng là dòng người ồn ào náo nhiệt.', 'basic', 1),
      (v_id, '面对局部地区突发的洪涝灾害与病虫害侵袭，农业农村部门迅速组织专家深入田间地头指导农户科学补种抗灾，坚决防范闹荒减产风险。', 'Miànduì júbù dìqū tūfā de hónglào zāihài yǔ bìngchónghài qīnxí, nóngyè nóngcūn bùmén xùnsù zǔzhī zhuānjiā shēnrù tiánjiān-dìtóu zhǐdǎo nónghù kēxué bǔzhòng kàngzāi, jiānjué fángfàn nàohuāng jiǎnchǎn fēngxiǎn.', 'Đối mặt với thiên tai lũ lụt và sâu bệnh đột ngột tấn công cục bộ, cơ quan nông nghiệp nông thôn nhanh chóng tổ chức chuyên gia xuống tận đồng ruộng hướng dẫn bà con trồng dặm khoa học chống hạn chống úng, kiên quyết ngăn ngừa rủi ro mất mùa giảm sản lượng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2794] [闹钟] (nàozhōng) - đồng hồ báo thức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '闹钟' AND pinyin = 'nàozhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '闹钟' AND pinyin = 'nàozhōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '闹钟'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '闹钟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'nàozhōng',
      meaning_vi = 'đồng hồ báo thức',
      example_hanzi = '他把手机闹钟设置在清晨六点半，以便起床晨跑锻炼身体。',
      example_pinyin = 'Tā bǎ shǒujī nàozhōng shèzhì zài qīngchén liù diǎn bàn, yǐbiàn qǐchuáng chénpǎo duànliàn shēntǐ.',
      example_vi = 'Anh ấy cài đặt đồng hồ báo thức điện thoại vào lúc 6 giờ 30 sáng để thức dậy chạy bộ buổi sáng rèn luyện thân thể.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '闹钟',
      'nàozhōng',
      'đồng hồ báo thức',
      'Danh từ',
      'HSK 5',
      '他把手机闹钟设置在清晨六点半，以便起床晨跑锻炼身体。',
      'Tā bǎ shǒujī nàozhōng shèzhì zài qīngchén liù diǎn bàn, yǐbiàn qǐchuáng chénpǎo duànliàn shēntǐ.',
      'Anh ấy cài đặt đồng hồ báo thức điện thoại vào lúc 6 giờ 30 sáng để thức dậy chạy bộ buổi sáng rèn luyện thân thể.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他把手机闹钟设置在清晨六点半，以便起床晨跑锻炼身体。', 'Tā bǎ shǒujī nàozhōng shèzhì zài qīngchén liù diǎn bàn, yǐbiàn qǐchuáng chénpǎo duànliàn shēntǐ.', 'Anh ấy cài đặt đồng hồ báo thức điện thoại vào lúc 6 giờ 30 sáng để thức dậy chạy bộ buổi sáng rèn luyện thân thể.', 'basic', 1),
      (v_id, '突发的重大自然灾害给全社会的生态保护意识敲响了长鸣的警示闹钟，警醒人们决不能以牺牲自然生态为代价换取短期的经济利益。', 'Tūfā de zhòngdà zìrán zāihài gěi quán shèhuì de shēngtài bǎohù yìshí qiāoxiǎng le chángmíng de jǐngshì nàozhōng, jǐngxǐng rénmen jué bùnéng yǐ xīshēng zìrán shēngtài wéi dàijià huànqǔ duǎnqī de jīngjì lìyì.', 'Thiên tai thảm họa nghiêm trọng bất ngờ xảy ra đã gióng lên hồi chuông báo thức cảnh tỉnh ngân vang cho ý thức bảo vệ sinh thái của toàn xã hội, cảnh tỉnh con người tuyệt đối không thể lấy việc đánh đổi sinh thái tự nhiên làm cái giá để đổi lấy lợi ích kinh tế trước mắt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2795] [内部] (nèibù) - nội bộ, bên trong [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '内部' AND pinyin = 'nèibù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '内部' AND pinyin = 'nèibù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '内部'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '内部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'nèibù',
      meaning_vi = 'nội bộ, bên trong',
      example_hanzi = '公司定期召开内部员工交流分享会，促进各业务部门之间的协同合作。',
      example_pinyin = 'Gōngsī dìngqī zhàokāi nèibù yuángōng jiāoliú fēnxiǎnghuì, cùjìn gè yèwù bùmén zhījiān de xiétóng hézuò.',
      example_vi = 'Công ty định kỳ tổ chức các buổi giao lưu chia sẻ cho nhân viên nội bộ, thúc đẩy sự phối hợp hiệp đồng giữa các phòng ban nghiệp vụ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '内部',
      'nèibù',
      'nội bộ, bên trong',
      'Danh từ',
      'HSK 5',
      '公司定期召开内部员工交流分享会，促进各业务部门之间的协同合作。',
      'Gōngsī dìngqī zhàokāi nèibù yuángōng jiāoliú fēnxiǎnghuì, cùjìn gè yèwù bùmén zhījiān de xiétóng hézuò.',
      'Công ty định kỳ tổ chức các buổi giao lưu chia sẻ cho nhân viên nội bộ, thúc đẩy sự phối hợp hiệp đồng giữa các phòng ban nghiệp vụ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '公司定期召开内部员工交流分享会，促进各业务部门之间的协同合作。', 'Gōngsī dìngqī zhàokāi nèibù yuángōng jiāoliú fēnxiǎnghuì, cùjìn gè yèwù bùmén zhījiān de xiétóng hézuò.', 'Công ty định kỳ tổ chức các buổi giao lưu chia sẻ cho nhân viên nội bộ, thúc đẩy sự phối hợp hiệp đồng giữa các phòng ban nghiệp vụ.', 'basic', 1),
      (v_id, '为防范化解金融系统性风险，商业银行必须加快建立健全穿透式内部风控审计体系与权责清晰的现代企业内部法人治理结构。', 'Wèi fángfàn huàjiě jīnróng xìtǒngxìng fēngxiǎn, shāngyè yínháng bìxū jiākuài jiànlì jiànquán chuāntòushì nèibù fēngkòng shěnjì tǐxì yǔ quánzé qīngxī de xiàndài qǐyè nèibù fǎrén zhìlǐ jiégòu.', 'Nhằm phòng ngừa và hóa giải rủi ro hệ thống tài chính, các ngân hàng thương mại phải khẩn trương hoàn thiện hệ thống kiểm toán kiểm soát rủi ro nội bộ có tính xuyên thấu cùng cơ cấu quản trị pháp nhân nội bộ doanh nghiệp hiện đại có quyền hạn trách nhiệm rõ ràng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2796] [能干] (nénggàn) - tháo vát, đảm đang, giỏi giang, tài giỏi [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '能干' AND pinyin = 'nénggàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '能干' AND pinyin = 'nénggàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '能干'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '能干'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'nénggàn',
      meaning_vi = 'tháo vát, đảm đang, giỏi giang, tài giỏi',
      example_hanzi = '小李工作勤快又善于解决复杂问题，是大家公认的能干助手。',
      example_pinyin = 'Xiǎo Lǐ gōngzuò qínkuài yòu shànyú jiějué fùzá wèntí, shì dàjiā gōngrèn de nénggàn zhùshǒu.',
      example_vi = 'Tiểu Lý làm việc nhanh nhẹn lại giỏi giải quyết các vấn đề phức tạp, là một trợ thủ tháo vát tài ba được mọi người công nhận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '能干',
      'nénggàn',
      'tháo vát, đảm đang, giỏi giang, tài giỏi',
      'Tính từ',
      'HSK 5',
      '小李工作勤快又善于解决复杂问题，是大家公认的能干助手。',
      'Xiǎo Lǐ gōngzuò qínkuài yòu shànyú jiějué fùzá wèntí, shì dàjiā gōngrèn de nénggàn zhùshǒu.',
      'Tiểu Lý làm việc nhanh nhẹn lại giỏi giải quyết các vấn đề phức tạp, là một trợ thủ tháo vát tài ba được mọi người công nhận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小李工作勤快又善于解决复杂问题，是大家公认的能干助手。', 'Xiǎo Lǐ gōngzuò qínkuài yòu shànyú jiějué fùzá wèntí, shì dàjiā gōngrèn de nénggàn zhùshǒu.', 'Tiểu Lý làm việc nhanh nhẹn lại giỏi giải quyết các vấn đề phức tạp, là một trợ thủ tháo vát tài ba được mọi người công nhận.', 'basic', 1),
      (v_id, '在基层治理一线，一大批政治过硬、作风扎实且极具实干担当精神的能干青年基层干部，正带领乡亲们在乡村振兴大道上阔步前行。', 'Zài jīcéng zhìlǐ yíxiàn, yí dà pī zhèngzhì guòyìng, zuòfēng zhāshi qiě jí jù shígàn dāndāng jīngshén de nénggàn qīngnián jīcéng gànbù, zhèng dàilǐng xiāngqīnmen zài xiāngcūn zhènxīng dàdào shang kuòbù qiánxíng.', 'Nơi tuyến đầu quản trị cơ sở, một lượng lớn cán bộ trẻ cơ sở tài giỏi có bản lĩnh chính trị vững vàng, tác phong sâu sát và tinh thần gánh vác dám nghĩ dám làm, đang dẫn dắt bà con sải bước vững vàng trên con đường chấn hưng nông thôn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2797] [年初] (niánchū) - đầu năm, thời điểm đầu năm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '年初' AND pinyin = 'niánchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '年初' AND pinyin = 'niánchū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '年初'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '年初'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'niánchū',
      meaning_vi = 'đầu năm, thời điểm đầu năm',
      example_hanzi = '每年年初，公司董事会都会制定并公布全年的核心经营业绩目标。',
      example_pinyin = 'Měi nián niánchū, gōngsī dǒngshìhuì dōu huì zhìdìng bìng gōngbù quán nián de héxīn jīngyíng yèjì mùbiāo.',
      example_vi = 'Vào đầu mỗi năm, hội đồng quản trị công ty đều xây dựng và công bố các mục tiêu thành tích kinh doanh cốt lõi của cả năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '年初',
      'niánchū',
      'đầu năm, thời điểm đầu năm',
      'Danh từ',
      'HSK 5',
      '每年年初，公司董事会都会制定并公布全年的核心经营业绩目标。',
      'Měi nián niánchū, gōngsī dǒngshìhuì dōu huì zhìdìng bìng gōngbù quán nián de héxīn jīngyíng yèjì mùbiāo.',
      'Vào đầu mỗi năm, hội đồng quản trị công ty đều xây dựng và công bố các mục tiêu thành tích kinh doanh cốt lõi của cả năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每年年初，公司董事会都会制定并公布全年的核心经营业绩目标。', 'Měi nián niánchū, gōngsī dǒngshìhuì dōu huì zhìdìng bìng gōngbù quán nián de héxīn jīngyíng yèjì mùbiāo.', 'Vào đầu mỗi năm, hội đồng quản trị công ty đều xây dựng và công bố các mục tiêu thành tích kinh doanh cốt lõi của cả năm.', 'basic', 1),
      (v_id, '从年初国家统筹出台的一揽子增量宏观调控政策来看，扩大有效益的投资与激发有潜能的消费始终是贯穿全年的宏观主基调。', 'Cóng niánchū guójiā tǒngchóu chūtái de yì lǎnzi zēngliàng hóngguān tiáokòng zhèngcè lái kàn, kuòdà yǒu xiàoyì de tóuzī yǔ jīfā yǒu qiánnéng de xiāofèi shǐzhōng shì guànchuān quán nián de hóngguān zhǔ jīdiào.', 'Nhìn từ gói chính sách điều tiết vĩ mô gia tăng đồng bộ được nhà nước ban hành từ đầu năm, việc mở rộng đầu tư có hiệu quả và kích thích tiêu dùng có tiềm năng luôn là âm hưởng chủ đạo vĩ mô xuyên suốt cả năm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2798] [年代] (niándài) - thập niên, niên đại, thời đại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '年代' AND pinyin = 'niándài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '年代' AND pinyin = 'niándài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '年代'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '年代'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'niándài',
      meaning_vi = 'thập niên, niên đại, thời đại',
      example_hanzi = '上世纪八十年代流行的经典老歌，至今听起来依然感人至深。',
      example_pinyin = 'Shàng shìjì bāshí niándài liúxíng de jīngdiǎn lǎogē, zhìjīn tīng qǐlái yīrán gǎnrén-zhìshēn.',
      example_vi = 'Những bài hát kinh điển thịnh hành vào những năm 80 của thế kỷ trước, cho đến nay nghe lại vẫn vô cùng xúc động lòng người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '年代',
      'niándài',
      'thập niên, niên đại, thời đại',
      'Danh từ',
      'HSK 5',
      '上世纪八十年代流行的经典老歌，至今听起来依然感人至深。',
      'Shàng shìjì bāshí niándài liúxíng de jīngdiǎn lǎogē, zhìjīn tīng qǐlái yīrán gǎnrén-zhìshēn.',
      'Những bài hát kinh điển thịnh hành vào những năm 80 của thế kỷ trước, cho đến nay nghe lại vẫn vô cùng xúc động lòng người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '上世纪八十年代流行的经典老歌，至今听起来依然感人至深。', 'Shàng shìjì bāshí niándài liúxíng de jīngdiǎn lǎogē, zhìjīn tīng qǐlái yīrán gǎnrén-zhìshēn.', 'Những bài hát kinh điển thịnh hành vào những năm 80 của thế kỷ trước, cho đến nay nghe lại vẫn vô cùng xúc động lòng người.', 'basic', 1),
      (v_id, '那是一个激情燃烧的火红年代，老一辈科学家隐姓埋名于戈壁大漠，以“两弹一星”的惊世功勋挺起了新中国的民族脊梁。', 'Nà shì yí gè jīqíng ránshāo de huǒhóng niándài, lǎoyíbèi kēxuéjiā yǐnxìng-máimíng yú gēbì dàmò, yǐ “liǎngtàn-yīxīng” de jīngshì gōngxūn tǐngqǐ le xīn Zhōngguó de mínzú jǐliáng.', 'Đó là một thời đại rực lửa ngập tràn nhiệt huyết sôi trào, thế hệ các nhà khoa học đi trước ẩn danh chôn tích giữa sa mạc Gobi hoang vu, bằng chiến công chấn động thế giới "hai quả bom một vệ tinh" đã dựng đứng cột sống dân tộc của nước Trung Hoa mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2799] [年纪] (niánjì) - tuổi tác, tuổi đời [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '年纪' AND pinyin = 'niánjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '年纪' AND pinyin = 'niánjì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '年纪'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '年纪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'niánjì',
      meaning_vi = 'tuổi tác, tuổi đời',
      example_hanzi = '奶奶虽然上了年纪，但走起路来依然精神矍铄脚步轻快。',
      example_pinyin = 'Nǎinai suīrán shàng le niánjì, dàn zǒu qǐ lù lai yīrán jīngshén-juéshuò jiǎobù qīngkuài.',
      example_vi = 'Bà nội tuy tuổi tác đã cao, nhưng đi lại vẫn quắc thước tinh anh và bước chân thoăn thoắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '年纪',
      'niánjì',
      'tuổi tác, tuổi đời',
      'Danh từ',
      'HSK 5',
      '奶奶虽然上了年纪，但走起路来依然精神矍铄脚步轻快。',
      'Nǎinai suīrán shàng le niánjì, dàn zǒu qǐ lù lai yīrán jīngshén-juéshuò jiǎobù qīngkuài.',
      'Bà nội tuy tuổi tác đã cao, nhưng đi lại vẫn quắc thước tinh anh và bước chân thoăn thoắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '奶奶虽然上了年纪，但走起路来依然精神矍铄脚步轻快。', 'Nǎinai suīrán shàng le niánjì, dàn zǒu qǐ lù lai yīrán jīngshén-juéshuò jiǎobù qīngkuài.', 'Bà nội tuy tuổi tác đã cao, nhưng đi lại vẫn quắc thước tinh anh và bước chân thoăn thoắt.', 'basic', 1),
      (v_id, '终身学习是抵御时代信息迭代焦虑的最佳良药，一个人无论处于何等年纪，只要保持对求知的渴望，人生便永远充满无限可能。', 'Zhōngshēn xuéxí shì dǐyù shídài xìnxī diédài jiāolǜ de zuìjiā liángyào, yí gè rén wúlùn chǔyú héděng niánjì, zhǐyào bǎochí duì qiúzhī de kěwàng, rénshēng biàn yǒngyuǎn chōngmǎn wúxiàn kěnéng.', 'Học tập suốt đời là liều thuốc bổ hữu hiệu nhất chống lại nỗi lo âu trước sự cải tiến thông tin của thời đại, một con người dẫu đang ở độ tuổi nào, chỉ cần giữ vững niềm khát khao tri thức thì cuộc đời sẽ luôn tràn đầy những tiềm năng vô tận.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2800] [年夜饭] (niányèfàn) - bữa cơm tất niên, bữa cơm giao thừa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '年夜饭' AND pinyin = 'niányèfàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '年夜饭' AND pinyin = 'niányèfàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '年夜饭'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '年夜饭'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'niányèfàn',
      meaning_vi = 'bữa cơm tất niên, bữa cơm giao thừa',
      example_hanzi = '除夕之夜，全家人围坐在一起吃热气腾腾的年夜饭并收看春晚。',
      example_pinyin = 'Chúxī zhī yè, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de niányèfàn bìng shōukàn chūnwǎn.',
      example_vi = 'Vào đêm 30 Tết giao thừa, cả nhà quây quần bên nhau ăn bữa cơm tất niên bốc khói nghi ngút và đón xem chương trình đại hội mùa xuân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '年夜饭',
      'niányèfàn',
      'bữa cơm tất niên, bữa cơm giao thừa',
      'Danh từ',
      'HSK 5',
      '除夕之夜，全家人围坐在一起吃热气腾腾的年夜饭并收看春晚。',
      'Chúxī zhī yè, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de niányèfàn bìng shōukàn chūnwǎn.',
      'Vào đêm 30 Tết giao thừa, cả nhà quây quần bên nhau ăn bữa cơm tất niên bốc khói nghi ngút và đón xem chương trình đại hội mùa xuân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '除夕之夜，全家人围坐在一起吃热气腾腾的年夜饭并收看春晚。', 'Chúxī zhī yè, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de niányèfàn bìng shōukàn chūnwǎn.', 'Vào đêm 30 Tết giao thừa, cả nhà quây quần bên nhau ăn bữa cơm tất niên bốc khói nghi ngút và đón xem chương trình đại hội mùa xuân.', 'basic', 1),
      (v_id, '一桌承载着家国温情的丰盛年夜饭，不仅是中华民族辞旧迎新最重要的仪式寄托，更是融化在海内外华人血脉深处的文化基因图景。', 'Yì zhuō chéngzài zhe jiāguó wēnqíng de fēngshèng niányèfàn, bùjǐn shì Zhōnghuá mínzú cíjiù-yíngxīn zuì zhòngyào de yíshì jìtuō, gèngshì rónghuà zài hǎinèiwài Huárén xuèmài shēnchù de wénhuà jīyīn tújǐng.', 'Một mâm cơm tất niên thịnh soạn chuyên chở hơi ấm tình cảm gia đình và quê hương không chỉ là điểm tựa nghi thức quan trọng nhất tống cựu nghinh tân của dân tộc Trung Hoa, mà còn là bức tranh gen văn hóa hòa tan sâu lắng trong huyết mạch của người Hoa khắp năm châu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2801] [念] (niàn) - đọc (thành tiếng); học tập; tưởng nhớ, nhớ nhung; niệm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '念' AND pinyin = 'niàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '念' AND pinyin = 'niàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '念'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '念'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'niàn',
      meaning_vi = 'đọc (thành tiếng); học tập; tưởng nhớ, nhớ nhung; niệm',
      example_hanzi = '语文老师请小明大声朗读课文里的第三个自然段。',
      example_pinyin = 'Yǔwén lǎoshī qǐng Xiǎo Míng dàshēng lǎngdú kèwén lǐ de dì-sān gè zìránduàn.',
      example_vi = 'Cô giáo dạy ngữ văn mời Tiểu Minh đọc to đoạn văn tự nhiên thứ ba trong bài học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '念',
      'niàn',
      'đọc (thành tiếng); học tập; tưởng nhớ, nhớ nhung; niệm',
      'Động từ',
      'HSK 5',
      '语文老师请小明大声朗读课文里的第三个自然段。',
      'Yǔwén lǎoshī qǐng Xiǎo Míng dàshēng lǎngdú kèwén lǐ de dì-sān gè zìránduàn.',
      'Cô giáo dạy ngữ văn mời Tiểu Minh đọc to đoạn văn tự nhiên thứ ba trong bài học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '语文老师请小明大声朗读课文里的第三个自然段。', 'Yǔwén lǎoshī qǐng Xiǎo Míng dàshēng lǎngdú kèwén lǐ de dì-sān gè zìránduàn.', 'Cô giáo dạy ngữ văn mời Tiểu Minh đọc to đoạn văn tự nhiên thứ ba trong bài học.', 'basic', 1),
      (v_id, '身居海外的华侨华人始终心系故土，深切念想着祖国的繁荣富强，并以赤子之心积极投身于支持家乡建设的崇高事业之中。', 'Shēnjū hǎiwài de huáqiáo-huárén shǐzhōng xīn xì gùtǔ, shēnqiè niànxiǎng zhe zǔguó de fánróng-fùqiáng, bìng yǐ chìzǐzhīxīn jījí tóushēn yú zhīchí jiāxiāng jiànshè de chónggāo shìyè zhīzhōng.', 'Kiều bào sinh sống ở nước ngoài luôn hướng trọn trái tim về mảnh đất quê hương, tha thiết tưởng nhớ sự phồn vinh giàu mạnh của tổ quốc, và với tấm lòng son sắt đã tích cực dấn thân vào sự nghiệp cao cả ủng hộ xây dựng quê nhà.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp Batch 8 HSK 5: % từ vựng đã được chuẩn hóa và thêm 200 câu ví dụ.', v_count;
END $$;
