-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 2 (100 TỪ TIẾP THEO)
-- Phạm vi: #2101 [差距] (chājù) -> #2201 [从而] (cóng’ér)
-- Tổng số câu ví dụ: 200 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Chuẩn hóa cột word_type (Từ loại) và meaning_vi (Nghĩa TV)
--   - Bảo tồn 100% UUID hiện có của từ vựng nếu đã tồn tại
--   - Phân biệt rõ các từ đa âm như [处] (chǔ) và [处] (chù)
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
  -- [2101] [差距] (chājù) - khoảng cách, chênh lệch (trình độ, kinh tế, điểm số) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '差距' AND pinyin = 'chājù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '差距' AND pinyin = 'chājù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '差距'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '差距'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chājù',
      meaning_vi = 'khoảng cách, chênh lệch (trình độ, kinh tế, điểm số)',
      example_hanzi = '通过虚心学习，他正在努力缩小与优秀同事之间的业务差距。',
      example_pinyin = 'Tōngguò xūxīn xuéxí, tā zhèngzài nǔlì suōxiǎo yǔ yōuxiù tóngshì zhījiān de yèwù chājù.',
      example_vi = 'Thông qua việc khiêm tốn học hỏi, anh ấy đang nỗ lực thu hẹp khoảng cách nghiệp vụ với các đồng nghiệp xuất sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '差距',
      'chājù',
      'khoảng cách, chênh lệch (trình độ, kinh tế, điểm số)',
      'Danh từ',
      'HSK 5',
      '通过虚心学习，他正在努力缩小与优秀同事之间的业务差距。',
      'Tōngguò xūxīn xuéxí, tā zhèngzài nǔlì suōxiǎo yǔ yōuxiù tóngshì zhījiān de yèwù chājù.',
      'Thông qua việc khiêm tốn học hỏi, anh ấy đang nỗ lực thu hẹp khoảng cách nghiệp vụ với các đồng nghiệp xuất sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '通过虚心学习，他正在努力缩小与优秀同事之间的业务差距。',
        'Tōngguò xūxīn xuéxí, tā zhèngzài nǔlì suōxiǎo yǔ yōuxiù tóngshì zhījiān de yèwù chājù.',
        'Thông qua việc khiêm tốn học hỏi, anh ấy đang nỗ lực thu hẹp khoảng cách nghiệp vụ với các đồng nghiệp xuất sắc.',
        'basic',
        1
      ),
      (
        v_id,
        '虽然我国在高端芯片制造领域起步较晚，但近年来正通过加大自主研发投入，逐步拉近与国际先进水平的技术差距。',
        'Suīrán wǒ guó zài gāoduān xīnpiàn zhìzào lǐngyù qǐbù jiào wǎn, dàn jìnniánlái zhèng tōngguò jiàdà zìzhǔ yánfā tóurù, zhúbù lājìn yǔ guójì xiānjìn shuǐpíng de jìshù chājù.',
        'Mặc dù nước ta khởi bước muộn hơn trong lĩnh vực chế tạo chip cao cấp, nhưng những năm gần đây đang từng bước thu hẹp khoảng cách công nghệ với trình độ tiên tiến quốc tế nhờ gia tăng đầu tư nghiên cứu tự chủ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2102] [叉子] (chāzi) - cái nĩa, cái dĩa (dụng cụ ăn uống) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '叉子' AND pinyin = 'chāzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '叉子' AND pinyin = 'chāzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '叉子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '叉子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chāzi',
      meaning_vi = 'cái nĩa, cái dĩa (dụng cụ ăn uống)',
      example_hanzi = '吃西餐时，通常左手拿叉子，右手拿刀。',
      example_pinyin = 'Chī xīcān shí, tōngcháng zuǒshǒu ná chāzi, yòushǒu ná dāo.',
      example_vi = 'Khi ăn đồ Tây, thông thường tay trái cầm dĩa, tay phải cầm dao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '叉子',
      'chāzi',
      'cái nĩa, cái dĩa (dụng cụ ăn uống)',
      'Danh từ',
      'HSK 5',
      '吃西餐时，通常左手拿叉子，右手拿刀。',
      'Chī xīcān shí, tōngcháng zuǒshǒu ná chāzi, yòushǒu ná dāo.',
      'Khi ăn đồ Tây, thông thường tay trái cầm dĩa, tay phải cầm dao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '吃西餐时，通常左手拿叉子，右手拿刀。',
        'Chī xīcān shí, tōngcháng zuǒshǒu ná chāzi, yòushǒu ná dāo.',
        'Khi ăn đồ Tây, thông thường tay trái cầm dĩa, tay phải cầm dao.',
        'basic',
        1
      ),
      (
        v_id,
        '服务员热情地为初次吃西餐的外国留学生递上一套崭新擦得发亮的不锈钢刀叉和精美餐巾。',
        'Fúwùyuán rèqíng de wèi chūcì chī xīcān de wàiguó liúxuéshēng dì shàng yí tào zhǎnxīn cā de fāliàng de bùxiùgāng dāochā hé jīngměi cānjīn.',
        'Nhân viên phục vụ niềm nở mang lên một bộ dao dĩa bằng thép không gỉ sáng bóng mới tinh cùng khăn ăn tinh tế cho bạn du học sinh nước ngoài lần đầu ăn món Tây.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2103] [拆] (chāi) - tháo dỡ, dỡ bỏ (nhà cửa, máy móc); bóc, mở (thư từ, gói hàng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '拆' AND pinyin = 'chāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拆' AND pinyin = 'chāi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '拆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chāi',
      meaning_vi = 'tháo dỡ, dỡ bỏ (nhà cửa, máy móc); bóc, mở (thư từ, gói hàng)',
      example_hanzi = '他迫不及待地拆开了朋友从国外寄来的生日礼物包裹。',
      example_pinyin = 'Tā pòbùjídài de chāikāi le péngyou cóng guówài jì lái de shēngrì lǐwù bāoguǒ.',
      example_vi = 'Anh ấy nóng lòng bóc mở gói quà sinh nhật bạn bè gửi từ nước ngoài về.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '拆',
      'chāi',
      'tháo dỡ, dỡ bỏ (nhà cửa, máy móc); bóc, mở (thư từ, gói hàng)',
      'Động từ',
      'HSK 5',
      '他迫不及待地拆开了朋友从国外寄来的生日礼物包裹。',
      'Tā pòbùjídài de chāikāi le péngyou cóng guówài jì lái de shēngrì lǐwù bāoguǒ.',
      'Anh ấy nóng lòng bóc mở gói quà sinh nhật bạn bè gửi từ nước ngoài về.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他迫不及待地拆开了朋友从国外寄来的生日礼物包裹。',
        'Tā pòbùjídài de chāikāi le péngyou cóng guówài jì lái de shēngrì lǐwù bāoguǒ.',
        'Anh ấy nóng lòng bóc mở gói quà sinh nhật bạn bè gửi từ nước ngoài về.',
        'basic',
        1
      ),
      (
        v_id,
        '由于旧城改造与市政轻轨建设需要，沿线这几栋年久失修的危旧楼房将在下周起被依法拆除。',
        'Yóuyú jiùchéng gǎizào yǔ shìzhèng qīngguǐ jiànshè xūyào, yánxiàn zhè jǐ dòng niánjiǔ-shīxiū de wēijiù lóufáng jiāng zài xià zhōu qǐ bèi yīfǎ chāichú.',
        'Do nhu cầu cải tạo đô thị cũ và xây dựng tuyến đường sắt đô thị nhẹ, mấy tòa nhà nguy hiểm cũ kỹ xuống cấp lâu năm dọc tuyến đường sẽ được tháo dỡ theo đúng pháp luật kể từ tuần tới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2104] [产] (chǎn) - sinh, đẻ; sản sinh, sinh ra, sản xuất [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '产' AND pinyin = 'chǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '产' AND pinyin = 'chǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '产'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '产'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chǎn',
      meaning_vi = 'sinh, đẻ; sản sinh, sinh ra, sản xuất',
      example_hanzi = '母牛在昨天夜里顺利产下了一只健康的小牛犊。',
      example_pinyin = 'Mǔniú zài zuótiān yèlǐ shùnlì chǎn xià le yì zhī jiànkāng de xiǎo niúdú.',
      example_vi = 'Con bò mẹ tối hôm qua đã sinh hạ thuận lợi một chú bê con khỏe mạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '产',
      'chǎn',
      'sinh, đẻ; sản sinh, sinh ra, sản xuất',
      'Động từ',
      'HSK 5',
      '母牛在昨天夜里顺利产下了一只健康的小牛犊。',
      'Mǔniú zài zuótiān yèlǐ shùnlì chǎn xià le yì zhī jiànkāng de xiǎo niúdú.',
      'Con bò mẹ tối hôm qua đã sinh hạ thuận lợi một chú bê con khỏe mạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '母牛在昨天夜里顺利产下了一只健康的小牛犊。',
        'Mǔniú zài zuótiān yèlǐ shùnlì chǎn xià le yì zhī jiànkāng de xiǎo niúdú.',
        'Con bò mẹ tối hôm qua đã sinh hạ thuận lợi một chú bê con khỏe mạnh.',
        'basic',
        1
      ),
      (
        v_id,
        '这个风景秀丽的南方江南水乡盛产优质大米和鲜美淡水鱼，自古便享有“鱼米之乡”的美誉。',
        'Zhè gè fēngjǐng xiùlì de nánfāng Jiāngnán shuǐxiāng shèngchǎn yōuzhì dàmǐ hé xiānměi dànshuǐyú, zìgǔ biàn xiǎngyǒu “yúmǐ zhī xiāng” de měiyù.',
        'Vùng sông nước Giang Nam miền nam non xanh nước biếc này dồi dào gạo ngon thượng hạng và cá nước ngọt thơm ngon, từ xa xưa đã nức tiếng với danh xưng mỹ miều “vùng đất cá gạo”.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2105] [产量] (chǎnliàng) - sản lượng (lúa gạo, thép, ô tô sản xuất được) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '产量' AND pinyin = 'chǎnliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '产量' AND pinyin = 'chǎnliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '产量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '产量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chǎnliàng',
      meaning_vi = 'sản lượng (lúa gạo, thép, ô tô sản xuất được)',
      example_hanzi = '科学施肥使得今年小麦的单位面积产量创下了历史新高。',
      example_pinyin = 'Kēxué shīféi shǐde jīntiān xiǎomài de dānwèi miànjī chǎnliàng chuàng xià le lìshǐ xīngāo.',
      example_vi = 'Bón phân theo phương pháp khoa học đã khiến sản lượng lúa mì trên một đơn vị diện tích năm nay lập đỉnh cao lịch sử mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '产量',
      'chǎnliàng',
      'sản lượng (lúa gạo, thép, ô tô sản xuất được)',
      'Danh từ',
      'HSK 5',
      '科学施肥使得今年小麦的单位面积产量创下了历史新高。',
      'Kēxué shīféi shǐde jīntiān xiǎomài de dānwèi miànjī chǎnliàng chuàng xià le lìshǐ xīngāo.',
      'Bón phân theo phương pháp khoa học đã khiến sản lượng lúa mì trên một đơn vị diện tích năm nay lập đỉnh cao lịch sử mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '科学施肥使得今年小麦的单位面积产量创下了历史新高。',
        'Kēxué shīféi shǐde jīntiān xiǎomài de dānwèi miànjī chǎnliàng chuàng xià le lìshǐ xīngāo.',
        'Bón phân theo phương pháp khoa học đã khiến sản lượng lúa mì trên một đơn vị diện tích năm nay lập đỉnh cao lịch sử mới.',
        'basic',
        1
      ),
      (
        v_id,
        '随着全新的智能绿色超级工厂正式投产，该车企新能源纯电动汽车的年产量预计将突破百万辆大关。',
        'Suízhe quánxīn de zhìnéng lǜsè chāojí gōngchǎng zhèngshì tóuchǎn, gāi chēqǐ xīn néngyuán chún diàndòng qìchē de nián chǎnliàng yùjì jiāng tūpò bǎi wàn liàng dàguān.',
        'Cùng với việc siêu nhà máy thông minh xanh hoàn toàn mới chính thức đi vào sản xuất, sản lượng xe ô tô điện năng lượng mới thuần túy hàng năm của doanh nghiệp này dự kiến sẽ phá vỡ cột mốc quan trọng một triệu chiếc.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2106] [产品] (chǎnpǐn) - sản phẩm (hàng hóa chế tạo ra) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '产品' AND pinyin = 'chǎnpǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '产品' AND pinyin = 'chǎnpǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '产品'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '产品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chǎnpǐn',
      meaning_vi = 'sản phẩm (hàng hóa chế tạo ra)',
      example_hanzi = '只有过硬的产品质量才能赢得广大消费者的长期信赖。',
      example_pinyin = 'Zhǐyǒu guòyìng de chǎnpǐn zhìliàng cái néng yíngdé guǎngdà xiāofèizhě de chángqī xìnlài.',
      example_vi = 'Chỉ có chất lượng sản phẩm vững vàng mới có thể giành được sự tín nhiệm lâu dài của đông đảo người tiêu dùng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '产品',
      'chǎnpǐn',
      'sản phẩm (hàng hóa chế tạo ra)',
      'Danh từ',
      'HSK 5',
      '只有过硬的产品质量才能赢得广大消费者的长期信赖。',
      'Zhǐyǒu guòyìng de chǎnpǐn zhìliàng cái néng yíngdé guǎngdà xiāofèizhě de chángqī xìnlài.',
      'Chỉ có chất lượng sản phẩm vững vàng mới có thể giành được sự tín nhiệm lâu dài của đông đảo người tiêu dùng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '只有过硬的产品质量才能赢得广大消费者的长期信赖。',
        'Zhǐyǒu guòyìng de chǎnpǐn zhìliàng cái néng yíngdé guǎngdà xiāofèizhě de chángqī xìnlài.',
        'Chỉ có chất lượng sản phẩm vững vàng mới có thể giành được sự tín nhiệm lâu dài của đông đảo người tiêu dùng.',
        'basic',
        1
      ),
      (
        v_id,
        '公司在春季新品全球发布会上隆重推出了三款搭载最新人工智能芯片的旗舰科技产品。',
        'Gōngsī zài chūnjì xīnpǐn quánqiú fābùhuì shàng lóngzhòng tuīchū le sān kuǎn dāzài zuìxīn réngōng zhìnéng xīnpiàn de qíjiàn kējì chǎnpǐn.',
        'Công ty tại buổi lễ ra mắt sản phẩm mới mùa xuân toàn cầu đã long trọng tung ra ba mẫu sản phẩm công nghệ đầu bảng trang bị chip trí tuệ nhân tạo mới nhất.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2107] [产业] (chǎnyè) - ngành nghề, ngành công nghiệp, sản nghiệp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '产业' AND pinyin = 'chǎnyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '产业' AND pinyin = 'chǎnyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '产业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '产业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chǎnyè',
      meaning_vi = 'ngành nghề, ngành công nghiệp, sản nghiệp',
      example_hanzi = '现代信息技术产业是推动经济高质量增长的重要引擎。',
      example_pinyin = 'Xiàndài xìnxī jìshù chǎnyè shì tuīdòng jīngjì gāo zhìliàng zēngzhǎng de zhòngyào yǐnqíng.',
      example_vi = 'Ngành công nghiệp công nghệ thông tin hiện đại là động cơ quan trọng thúc đẩy kinh tế tăng trưởng chất lượng cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '产业',
      'chǎnyè',
      'ngành nghề, ngành công nghiệp, sản nghiệp',
      'Danh từ',
      'HSK 5',
      '现代信息技术产业是推动经济高质量增长的重要引擎。',
      'Xiàndài xìnxī jìshù chǎnyè shì tuīdòng jīngjì gāo zhìliàng zēngzhǎng de zhòngyào yǐnqíng.',
      'Ngành công nghiệp công nghệ thông tin hiện đại là động cơ quan trọng thúc đẩy kinh tế tăng trưởng chất lượng cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '现代信息技术产业是推动经济高质量增长的重要引擎。',
        'Xiàndài xìnxī jìshù chǎnyè shì tuīdòng jīngjì gāo zhìliàng zēngzhǎng de zhòngyào yǐnqíng.',
        'Ngành công nghiệp công nghệ thông tin hiện đại là động cơ quan trọng thúc đẩy kinh tế tăng trưởng chất lượng cao.',
        'basic',
        1
      ),
      (
        v_id,
        '政府出台了一系列重磅税收扶持与专项补贴政策，旨在全力做大做强生物医药与高端装备制造两大战略支柱产业。',
        'Zhèngfǔ chūtái le yí xìliè zhòngbàng shuìshōu fúchí yǔ zhuānxiàng bǔtiē zhèngcè, zhǐ zài quánlì zuò dà zuò qiáng shēngwù yīyào yǔ gāoduān zhuāngbèi zhìzào liǎng dà zhànlüè zhīzhù chǎnyè.',
        'Chính phủ đã ban hành hàng loạt chính sách hỗ trợ thuế và trợ cấp chuyên trách quan trọng, nhằm dốc toàn lực mở rộng và phát triển vững mạnh hai ngành công nghiệp trụ cột chiến lược là y sinh học và chế tạo trang thiết bị cao cấp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2108] [长处] (chángchu) - sở trường, điểm mạnh, ưu điểm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '长处' AND pinyin = 'chángchu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长处' AND pinyin = 'chángchu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '长处'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长处'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chángchu',
      meaning_vi = 'sở trường, điểm mạnh, ưu điểm',
      example_hanzi = '尺有所短，寸有所长，每个人都有自己独特且不可替代的长处。',
      example_pinyin = 'Chǐ yǒu suǒ duǎn, cùn yǒu suǒ cháng, měi gè rén dōu yǒu zìjǐ dútè qiě bùkě tìdài de chángchu.',
      example_vi = 'Thước có chỗ ngắn, tấc có chỗ dài, mỗi con người đều có những sở trường độc đáo riêng không thể thay thế.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '长处',
      'chángchu',
      'sở trường, điểm mạnh, ưu điểm',
      'Danh từ',
      'HSK 5',
      '尺有所短，寸有所长，每个人都有自己独特且不可替代的长处。',
      'Chǐ yǒu suǒ duǎn, cùn yǒu suǒ cháng, měi gè rén dōu yǒu zìjǐ dútè qiě bùkě tìdài de chángchu.',
      'Thước có chỗ ngắn, tấc có chỗ dài, mỗi con người đều có những sở trường độc đáo riêng không thể thay thế.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '尺有所短，寸有所长，每个人都有自己独特且不可替代的长处。',
        'Chǐ yǒu suǒ duǎn, cùn yǒu suǒ cháng, měi gè rén dōu yǒu zìjǐ dútè qiě bùkě tìdài de chángchu.',
        'Thước có chỗ ngắn, tấc có chỗ dài, mỗi con người đều có những sở trường độc đáo riêng không thể thay thế.',
        'basic',
        1
      ),
      (
        v_id,
        '一位高明的管理者善于敏锐洞察每位团队成员的长处，并将其合理配置到最能施展才华的核心岗位上。',
        'Yí wèi gāomíng de guǎnlǐzhě shànyú mǐnruì dòngchá měi wèi tuánduì chéngyuán de chángchu, bìng jiāng qí hélǐ pèizhì dào zuì néng shīzhǎn cáihuá de héxīn gǎngwèi shàng.',
        'Một nhà quản lý sáng suốt luôn nhạy bén nhìn thấu điểm mạnh của từng thành viên trong nhóm, đồng thời bố trí họ một cách hợp lý vào vị trí then chốt có thể phát huy tối đa tài năng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2109] [长度] (chángdù) - chiều dài, độ dài [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '长度' AND pinyin = 'chángdù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长度' AND pinyin = 'chángdù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '长度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chángdù',
      meaning_vi = 'chiều dài, độ dài',
      example_hanzi = '请同学们用直尺准确测量出这根铁丝的实际长度。',
      example_pinyin = 'Qǐng tóngxuémen yòng zhíchǐ zhǔnquè cèliáng chū zhè gēn tiěsī de shíjì chángdù.',
      example_vi = 'Xin các bạn học sinh hãy dùng thước thẳng đo chuẩn xác chiều dài thực tế của sợi dây thép này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '长度',
      'chángdù',
      'chiều dài, độ dài',
      'Danh từ',
      'HSK 5',
      '请同学们用直尺准确测量出这根铁丝的实际长度。',
      'Qǐng tóngxuémen yòng zhíchǐ zhǔnquè cèliáng chū zhè gēn tiěsī de shíjì chángdù.',
      'Xin các bạn học sinh hãy dùng thước thẳng đo chuẩn xác chiều dài thực tế của sợi dây thép này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '请同学们用直尺准确测量出这根铁丝的实际长度。',
        'Qǐng tóngxuémen yòng zhíchǐ zhǔnquè cèliáng chū zhè gēn tiěsī de shíjì chángdù.',
        'Xin các bạn học sinh hãy dùng thước thẳng đo chuẩn xác chiều dài thực tế của sợi dây thép này.',
        'basic',
        1
      ),
      (
        v_id,
        '新建成的跨海大桥全长超过五十公里，是目前世界上长度最长、施工技术难度最高的跨海通道工程。',
        'Xīnjiàn chéng de kuàhǎi dàqiáo quán cháng chāoguò wǔshí gōnglǐ, shì mùqián shìjiè shàng chángdù zuì cháng, shīgōng jìshù nándù zuì gāo de kuàhǎi tōngdào gōngchéng.',
        'Cây cầu vượt biển mới xây xong có tổng chiều dài hơn năm mươi cây số, hiện là công trình tuyến đường vượt biển có độ dài dài nhất và độ khó kỹ thuật thi công cao nhất thế giới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2110] [长久] (chángjiǔ) - lâu dài, trường cửu, bền lâu [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '长久' AND pinyin = 'chángjiǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长久' AND pinyin = 'chángjiǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '长久'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长久'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'chángjiǔ',
      meaning_vi = 'lâu dài, trường cửu, bền lâu',
      example_hanzi = '只顾眼前蝇头小利而牺牲环境的做法绝不是长久之计。',
      example_pinyin = 'Zhǐ gù yǎnqián yíngtóu-xiǎolì ér xīshēng huánjìng de zuòfǎ jué bú shì chángjiǔ zhī jì.',
      example_vi = 'Cách làm chỉ chăm chăm vào chút lợi cỏn con trước mắt mà đánh đổi môi trường tuyệt đối không phải là kế sách lâu dài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '长久',
      'chángjiǔ',
      'lâu dài, trường cửu, bền lâu',
      'Tính từ / Phó từ',
      'HSK 5',
      '只顾眼前蝇头小利而牺牲环境的做法绝不是长久之计。',
      'Zhǐ gù yǎnqián yíngtóu-xiǎolì ér xīshēng huánjìng de zuòfǎ jué bú shì chángjiǔ zhī jì.',
      'Cách làm chỉ chăm chăm vào chút lợi cỏn con trước mắt mà đánh đổi môi trường tuyệt đối không phải là kế sách lâu dài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '只顾眼前蝇头小利而牺牲环境的做法绝不是长久之计。',
        'Zhǐ gù yǎnqián yíngtóu-xiǎolì ér xīshēng huánjìng de zuòfǎ jué bú shì chángjiǔ zhī jì.',
        'Cách làm chỉ chăm chăm vào chút lợi cỏn con trước mắt mà đánh đổi môi trường tuyệt đối không phải là kế sách lâu dài.',
        'basic',
        1
      ),
      (
        v_id,
        '两国元首在联合声明中明确表示，愿在和平共处五项原则基础上建立长期、稳定、长久互信的全面战略伙伴关系。',
        'Liǎng guó yuánshǒu zài liánhé shēngmíng zhōng míngquè biǎoshì, yuàn zài hépíng gòngchǔ wǔ xiàng yuánzé jīchǔ shàng jiànlì chángqī, wěndìng, chángjiǔ hùxìn de quánmiàn zhànlüè huǒbàn guānxì.',
        'Nguyên thủ hai nước trong tuyên bố chung nêu rõ, sẵn sàng trên cơ sở năm nguyên tắc cùng tồn tại hòa bình xây dựng mối quan hệ đối tác chiến lược toàn diện lâu dài, ổn định và tin cậy lẫn nhau bền lâu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2111] [长期] (chángqī) - lâu dài, dài hạn, thời gian dài [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '长期' AND pinyin = 'chángqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长期' AND pinyin = 'chángqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '长期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'chángqī',
      meaning_vi = 'lâu dài, dài hạn, thời gian dài',
      example_hanzi = '坚持长期进行适度体育锻炼有助于增强心肺功能。',
      example_pinyin = 'Jiānchí chángqī jìnxíng shìdù tǐyù duànliàn yǒuzhùyú zēngqiáng xīnfèi gōngnéng.',
      example_vi = 'Kiên trì rèn luyện thể dục thể thao điều độ dài hạn sẽ giúp tăng cường chức năng tim phổi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '长期',
      'chángqī',
      'lâu dài, dài hạn, thời gian dài',
      'Tính từ / Danh từ',
      'HSK 5',
      '坚持长期进行适度体育锻炼有助于增强心肺功能。',
      'Jiānchí chángqī jìnxíng shìdù tǐyù duànliàn yǒuzhùyú zēngqiáng xīnfèi gōngnéng.',
      'Kiên trì rèn luyện thể dục thể thao điều độ dài hạn sẽ giúp tăng cường chức năng tim phổi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '坚持长期进行适度体育锻炼有助于增强心肺功能。',
        'Jiānchí chángqī jìnxíng shìdù tǐyù duànliàn yǒuzhùyú zēngqiáng xīnfèi gōngnéng.',
        'Kiên trì rèn luyện thể dục thể thao điều độ dài hạn sẽ giúp tăng cường chức năng tim phổi.',
        'basic',
        1
      ),
      (
        v_id,
        '集团董事会经过深入论证，确立了未来十年进军新能源与前沿生物科技的长期发展战略规划。',
        'Jítuán dǒngshìhuì jīngguò shēnrù lùnzhèng, quèlì le wèilái shí nián jīnjūn xīn néngyuán yǔ qiányán shēngwù kējì de chángqī fāzhǎn zhànlüè guīhuà.',
        'Hội đồng quản trị tập đoàn sau quá trình phân tích chứng minh sâu sát đã xác lập quy hoạch chiến lược phát triển dài hạn lấn sân sang năng lượng mới và công nghệ sinh học tiên phong trong mười năm tới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2112] [常识] (chángshí) - thường thức, kiến thức thông thường phổ thông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '常识' AND pinyin = 'chángshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '常识' AND pinyin = 'chángshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '常识'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '常识'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chángshí',
      meaning_vi = 'thường thức, kiến thức thông thường phổ thông',
      example_hanzi = '发生火灾时不能乘坐电梯逃生，这是人人都必须掌握的安全常识。',
      example_pinyin = 'Fāshēng huǒzāi shí bù néng chéngzuò diàntī táoshēng, zhè shì rénrén dōu bìxū zhǎngwò de ānquán chángshí.',
      example_vi = 'Khi xảy ra hỏa hoạn không được đi thang máy thoát hiểm, đây là kiến thức thường thức an toàn mà ai ai cũng bắt buộc phải nắm vững.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '常识',
      'chángshí',
      'thường thức, kiến thức thông thường phổ thông',
      'Danh từ',
      'HSK 5',
      '发生火灾时不能乘坐电梯逃生，这是人人都必须掌握的安全常识。',
      'Fāshēng huǒzāi shí bù néng chéngzuò diàntī táoshēng, zhè shì rénrén dōu bìxū zhǎngwò de ānquán chángshí.',
      'Khi xảy ra hỏa hoạn không được đi thang máy thoát hiểm, đây là kiến thức thường thức an toàn mà ai ai cũng bắt buộc phải nắm vững.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '发生火灾时不能乘坐电梯逃生，这是人人都必须掌握的安全常识。',
        'Fāshēng huǒzāi shí bù néng chéngzuò diàntī táoshēng, zhè shì rénrén dōu bìxū zhǎngwò de ānquán chángshí.',
        'Khi xảy ra hỏa hoạn không được đi thang máy thoát hiểm, đây là kiến thức thường thức an toàn mà ai ai cũng bắt buộc phải nắm vững.',
        'basic',
        1
      ),
      (
        v_id,
        '掌握必要的野外生存与自救急救常识，在突遭意外灾害的极端关键时刻能够挽救宝贵的生命。',
        'Zhǎngwò bìyào de yěwài shēngcún yǔ zìjiù jíjiù chángshí, zài tū zāo yìwài zāihài de jíduān guānjiàn shíkè nénggòu wǎnjiù bǎoguì de shēngmìng.',
        'Nắm vững kiến thức thường thức sinh tồn nơi hoang dã và sơ cứu tự cứu bản thân cần thiết, trong thời khắc then chốt ngặt nghèo khi bất ngờ gặp thiên tai tai nạn có thể cứu sống được sinh mạng quý báu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2113] [尝试] (chángshì) - thử, thử nghiệm; sự trải nghiệm làm thử [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '尝试' AND pinyin = 'chángshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尝试' AND pinyin = 'chángshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '尝试'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尝试'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'chángshì',
      meaning_vi = 'thử, thử nghiệm; sự trải nghiệm làm thử',
      example_hanzi = '不要害怕犯错，年轻时要勇于尝试新鲜事物。',
      example_pinyin = 'Bú yào hàipà fàncuò, niánqīng shí yào yǒngyú chángshì xīnxiān shìwù.',
      example_vi = 'Đừng sợ mắc sai lầm, thời trẻ cần dũng cảm thử nghiệm những điều mới lạ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '尝试',
      'chángshì',
      'thử, thử nghiệm; sự trải nghiệm làm thử',
      'Động từ / Danh từ',
      'HSK 5',
      '不要害怕犯错，年轻时要勇于尝试新鲜事物。',
      'Bú yào hàipà fàncuò, niánqīng shí yào yǒngyú chángshì xīnxiān shìwù.',
      'Đừng sợ mắc sai lầm, thời trẻ cần dũng cảm thử nghiệm những điều mới lạ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '不要害怕犯错，年轻时要勇于尝试新鲜事物。',
        'Bú yào hàipà fàncuò, niánqīng shí yào yǒngyú chángshì xīnxiān shìwù.',
        'Đừng sợ mắc sai lầm, thời trẻ cần dũng cảm thử nghiệm những điều mới lạ.',
        'basic',
        1
      ),
      (
        v_id,
        '研发团队在经历数十次失败后依然百折不挠，终于通过一种全新的算法架构做出了颠覆性的技术尝试并取得重大突破。',
        'Yánfā tuánduì zài jīnglì shù shí cì shībài hòu yīrán bǎizhébùnáo, zhōngyú tōngguò yì zhǒng quánxīn de suànfǎ jiàgòu zuò chū le diānfùxìng de jìshù chángshì bìng qǔdé zhòngdà tūpò.',
        'Đội ngũ R&D sau hàng chục lần thất bại vẫn kiên cường không nản chí, cuối cùng thông qua một cấu trúc thuật toán hoàn toàn mới đã thực hiện một bước thử nghiệm công nghệ mang tính cách mạng và gặt hái đột phá lớn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2114] [长途] (chángtú) - đường dài, cự ly dài (xe khách, cuộc gọi, du lịch) [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '长途' AND pinyin = 'chángtú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长途' AND pinyin = 'chángtú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '长途'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长途'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'chángtú',
      meaning_vi = 'đường dài, cự ly dài (xe khách, cuộc gọi, du lịch)',
      example_hanzi = '连续驾驶长途汽车容易疲劳，中途一定要进服务区停车休息。',
      example_pinyin = 'Liánxù jiàshǐ chángtú qìchē róngyì píláo, zhōngtú yídìng yào jìn fúwùqū tíngchē xiūxi.',
      example_vi = 'Lái xe ô tô đường dài liên tục rất dễ mệt mỏi, giữa đường nhất định phải rẽ vào trạm dừng chân đỗ xe nghỉ ngơi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '长途',
      'chángtú',
      'đường dài, cự ly dài (xe khách, cuộc gọi, du lịch)',
      'Tính từ / Danh từ',
      'HSK 5',
      '连续驾驶长途汽车容易疲劳，中途一定要进服务区停车休息。',
      'Liánxù jiàshǐ chángtú qìchē róngyì píláo, zhōngtú yídìng yào jìn fúwùqū tíngchē xiūxi.',
      'Lái xe ô tô đường dài liên tục rất dễ mệt mỏi, giữa đường nhất định phải rẽ vào trạm dừng chân đỗ xe nghỉ ngơi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '连续驾驶长途汽车容易疲劳，中途一定要进服务区停车休息。',
        'Liánxù jiàshǐ chángtú qìchē róngyì píláo, zhōngtú yídìng yào jìn fúwùqū tíngchē xiūxi.',
        'Lái xe ô tô đường dài liên tục rất dễ mệt mỏi, giữa đường nhất định phải rẽ vào trạm dừng chân đỗ xe nghỉ ngơi.',
        'basic',
        1
      ),
      (
        v_id,
        '长途客运汽车站积极推行无纸化电子客票与人脸识别快速进站，极大缩短了春运高峰期间旅客的排队等候时间。',
        'Chángtú kèyùn qìchēzhàn jījí tuīxíng wúzǐhuà diànzǐ kèpiào yǔ rénliǎn shíbié kuàisù jìnzhàn, jí dà suōduǎn le chūnyùn gāofēng qījiān lǚkè de páiduì děnghòu shíjiān.',
        'Bến xe khách đường dài tích cực triển khai vé xe điện tử không dùng giấy và nhận diện khuôn mặt vào bến nhanh chóng, rút ngắn đáng kể thời gian xếp hàng chờ đợi của hành khách trong dịp cao điểm vận tải Tết.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2115] [长远] (chángyuǎn) - lâu dài, sâu rộng, có tầm nhìn xa trông rộng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '长远' AND pinyin = 'chángyuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长远' AND pinyin = 'chángyuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '长远'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '长远'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'chángyuǎn',
      meaning_vi = 'lâu dài, sâu rộng, có tầm nhìn xa trông rộng',
      example_hanzi = '做决策时既要解决当前矛盾，更要立足于长远发展。',
      example_pinyin = 'Zuò juécè shí jì yào jiějué dāngqián máodùn, gèng yào lìzú yú chángyuǎn fāzhǎn.',
      example_vi = 'Khi đưa ra quyết sách vừa phải giải quyết mâu thuẫn trước mắt, lại càng phải đứng trên góc độ phát triển lâu dài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '长远',
      'chángyuǎn',
      'lâu dài, sâu rộng, có tầm nhìn xa trông rộng',
      'Tính từ',
      'HSK 5',
      '做决策时既要解决当前矛盾，更要立足于长远发展。',
      'Zuò juécè shí jì yào jiějué dāngqián máodùn, gèng yào lìzú yú chángyuǎn fāzhǎn.',
      'Khi đưa ra quyết sách vừa phải giải quyết mâu thuẫn trước mắt, lại càng phải đứng trên góc độ phát triển lâu dài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '做决策时既要解决当前矛盾，更要立足于长远发展。',
        'Zuò juécè shí jì yào jiějué dāngqián máodùn, gèng yào lìzú yú chángyuǎn fāzhǎn.',
        'Khi đưa ra quyết sách vừa phải giải quyết mâu thuẫn trước mắt, lại càng phải đứng trên góc độ phát triển lâu dài.',
        'basic',
        1
      ),
      (
        v_id,
        '虽然引进环保节能减排设备在初期需要投入巨额改造成本，但从长远利益来看，不仅符合国家法规更能显著提升企业竞争力。',
        'Suīrán yǐnjìn huánbǎo jiénéng jiǎnpái shèbèi zài chūqī xūyào tóurù jù’é gǎizào chéngběn, dàn cóng chángyuǎn lìyì lái kàn, bùjǐn fúhé guójiā fǎguī gèng néng xiǎnzhù tíshēng qǐyè jìngzhēnglì.',
        'Mặc dù việc đưa vào thiết bị tiết kiệm năng lượng giảm phát thải thân thiện môi trường trong giai đoạn đầu cần đầu tư chi phí cải tạo khổng lồ, nhưng nhìn từ lợi ích lâu dài thì không chỉ phù hợp quy định pháp luật nhà nước mà còn nâng cao rõ rệt sức cạnh tranh của doanh nghiệp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2116] [场所] (chǎngsuǒ) - địa điểm, nơi chốn, khu vực sinh hoạt hoạt động [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '场所' AND pinyin = 'chǎngsuǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '场所' AND pinyin = 'chǎngsuǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '场所'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '场所'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chǎngsuǒ',
      meaning_vi = 'địa điểm, nơi chốn, khu vực sinh hoạt hoạt động',
      example_hanzi = '医院、学校和加油站等公共场所严禁吸烟。',
      example_pinyin = 'Yīyuàn, xuéxiào hé jiāyóuzhàn děng gōnggòng chǎngsuǒ yánjìn xīyān.',
      example_vi = 'Các địa điểm công cộng như bệnh viện, trường học và cây xăng nghiêm cấm hút thuốc lá.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '场所',
      'chǎngsuǒ',
      'địa điểm, nơi chốn, khu vực sinh hoạt hoạt động',
      'Danh từ',
      'HSK 5',
      '医院、学校和加油站等公共场所严禁吸烟。',
      'Yīyuàn, xuéxiào hé jiāyóuzhàn děng gōnggòng chǎngsuǒ yánjìn xīyān.',
      'Các địa điểm công cộng như bệnh viện, trường học và cây xăng nghiêm cấm hút thuốc lá.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '医院、学校和加油站等公共场所严禁吸烟。',
        'Yīyuàn, xuéxiào hé jiāyóuzhàn děng gōnggòng chǎngsuǒ yánjìn xīyān.',
        'Các địa điểm công cộng như bệnh viện, trường học và cây xăng nghiêm cấm hút thuốc lá.',
        'basic',
        1
      ),
      (
        v_id,
        '文化旅游主管部门组织执法人员对全区网吧、KTV等娱乐经营场所进行了全覆盖的安全防火隐患大排查。',
        'Wénhuà lǚyóu zhǔguǎn bùmén zǔzhī zhífǎ rényuán duì quán qū wǎngba, KTV děng yúlè jīngyíng chǎngsuǒ jìnxíng le quán fùgài de ānquán fánghuǒ yǐnhuàn dà páichá.',
        'Cơ quan phụ trách văn hóa du lịch đã tổ chức lực lượng thực thi pháp luật tiến hành đợt tổng rà soát nguy cơ phòng cháy chữa cháy an toàn bao phủ toàn diện tại các địa điểm kinh doanh giải trí như quán internet, quán karaoke trên toàn địa bàn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2117] [超] (chāo) - vượt quá, vượt qua; siêu, cực kỳ [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '超' AND pinyin = 'chāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '超' AND pinyin = 'chāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '超'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '超'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Phó từ',
      pinyin = 'chāo',
      meaning_vi = 'vượt quá, vượt qua; siêu, cực kỳ',
      example_hanzi = '由于行李总重量超重了五公斤，他在柜台补交了托运费。',
      example_pinyin = 'Yóuyú xíngli zǒng zhòngliàng chāozhòng le wǔ gōngjǐn, tā zài guìtái bǔjiāo le tuōyùnfèi.',
      example_vi = 'Do tổng trọng lượng hành lý bị vượt quá năm ký, anh ấy đã nộp bổ sung tiền cước ký gửi tại quầy vé.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '超',
      'chāo',
      'vượt quá, vượt qua; siêu, cực kỳ',
      'Động từ / Phó từ',
      'HSK 5',
      '由于行李总重量超重了五公斤，他在柜台补交了托运费。',
      'Yóuyú xíngli zǒng zhòngliàng chāozhòng le wǔ gōngjǐn, tā zài guìtái bǔjiāo le tuōyùnfèi.',
      'Do tổng trọng lượng hành lý bị vượt quá năm ký, anh ấy đã nộp bổ sung tiền cước ký gửi tại quầy vé.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '由于行李总重量超重了五公斤，他在柜台补交了托运费。',
        'Yóuyú xíngli zǒng zhòngliàng chāozhòng le wǔ gōngjǐn, tā zài guìtái bǔjiāo le tuōyùnfèi.',
        'Do tổng trọng lượng hành lý bị vượt quá năm ký, anh ấy đã nộp bổ sung tiền cước ký gửi tại quầy vé.',
        'basic',
        1
      ),
      (
        v_id,
        '在高速公路上超车时，必须提前打转向灯并确认左侧车道后方有足够的安全距离。',
        'Zài gāosù gōnglù shàng chāochē shí, bìxū tíqián dǎ zhuǎnxiàngdēng bìng quèrèn zuǒcè chēdào hòufāng yǒu zúgòu de ānquán jùlí.',
        'Khi vượt xe trên đường cao tốc, bắt buộc phải bật xi nhan trước và xác nhận phía sau làn đường bên trái có đủ khoảng cách an toàn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2118] [超出] (chāochū) - vượt quá, vượt ra ngoài (phạm vi, dự toán, khả năng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '超出' AND pinyin = 'chāochū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '超出' AND pinyin = 'chāochū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '超出'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '超出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chāochū',
      meaning_vi = 'vượt quá, vượt ra ngoài (phạm vi, dự toán, khả năng)',
      example_hanzi = '这栋精装修商品房的售价远远超出了我们一家的预算承受范围。',
      example_pinyin = 'Zhè dòng jīngzhuāngxiū shāngpǐnfáng de shòujià yuǎnyuǎn chāochū le wǒmen yì jiā de yùsuàn chéngshòu fànwéi.',
      example_vi = 'Giá bán của căn hộ thương phẩm trang trí nội thất tinh xảo này đã vượt quá xa phạm vi chịu đựng dự toán của gia đình chúng tôi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '超出',
      'chāochū',
      'vượt quá, vượt ra ngoài (phạm vi, dự toán, khả năng)',
      'Động từ',
      'HSK 5',
      '这栋精装修商品房的售价远远超出了我们一家的预算承受范围。',
      'Zhè dòng jīngzhuāngxiū shāngpǐnfáng de shòujià yuǎnyuǎn chāochū le wǒmen yì jiā de yùsuàn chéngshòu fànwéi.',
      'Giá bán của căn hộ thương phẩm trang trí nội thất tinh xảo này đã vượt quá xa phạm vi chịu đựng dự toán của gia đình chúng tôi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这栋精装修商品房的售价远远超出了我们一家的预算承受范围。',
        'Zhè dòng jīngzhuāngxiū shāngpǐnfáng de shòujià yuǎnyuǎn chāochū le wǒmen yì jiā de yùsuàn chéngshòu fànwéi.',
        'Giá bán của căn hộ thương phẩm trang trí nội thất tinh xảo này đã vượt quá xa phạm vi chịu đựng dự toán của gia đình chúng tôi.',
        'basic',
        1
      ),
      (
        v_id,
        '这部科幻史诗大片在全球上映后的票房成绩与口碑好评，完全超出了电影制作方最初的所有乐观预期。',
        'Zhè bù kēhuàn shǐshī dàpiān zài quánqiú shàngyìng hòu de piàofáng chéngjì yǔ kǒubēi hǎopíng, wánquán chāochū le diànyǐng zhìzuòfāng zuìchū de suǒyǒu lèguān yùqī.',
        'Thành tích doanh thu phòng vé và những đánh giá khen ngợi truyền miệng của bộ phim bom tấn sử thi khoa học viễn tưởng này sau khi công chiếu toàn cầu đã hoàn toàn vượt ra ngoài mọi dự tính lạc quan ban đầu của nhà sản xuất.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2119] [超级] (chāojí) - siêu cấp, cực kỳ, siêu hạng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '超级' AND pinyin = 'chāojí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '超级' AND pinyin = 'chāojí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '超级'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '超级'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'chāojí',
      meaning_vi = 'siêu cấp, cực kỳ, siêu hạng',
      example_hanzi = '孩子们周末最喜欢去市中心的大型超级市场挑选零食。',
      example_pinyin = 'Háizimen zhōumò zuì xǐhuan qù shì zhōngxīn de dàxíng chāojí shìchǎng tiāoxuǎn língshí.',
      example_vi = 'Tụi nhỏ cuối tuần thích nhất là được đến siêu thị mua sắm lớn ở trung tâm thành phố để chọn đồ ăn vặt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '超级',
      'chāojí',
      'siêu cấp, cực kỳ, siêu hạng',
      'Tính từ',
      'HSK 5',
      '孩子们周末最喜欢去市中心的大型超级市场挑选零食。',
      'Háizimen zhōumò zuì xǐhuan qù shì zhōngxīn de dàxíng chāojí shìchǎng tiāoxuǎn língshí.',
      'Tụi nhỏ cuối tuần thích nhất là được đến siêu thị mua sắm lớn ở trung tâm thành phố để chọn đồ ăn vặt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '孩子们周末最喜欢去市中心的大型超级市场挑选零食。',
        'Háizimen zhōumò zuì xǐhuan qù shì zhōngxīn de dàxíng chāojí shìchǎng tiāoxuǎn língshí.',
        'Tụi nhỏ cuối tuần thích nhất là được đến siêu thị mua sắm lớn ở trung tâm thành phố để chọn đồ ăn vặt.',
        'basic',
        1
      ),
      (
        v_id,
        '由我国自主研发制造的新一代超级计算机，在计算速度与能效比方面再次刷新了全球行业排行榜纪录。',
        'Yóu wǒ guó zìzhǔ yánfā zhìzào de xīn yídài chāojí jìsuànjī, zài jìsuàn sùdù yǔ néngxiàobǐ fāngmiàn zàicì shuāxīn le quánqiú hángyè páihángbǎng jìlù.',
        'Siêu máy tính thế hệ mới do nước ta tự chủ nghiên cứu chế tạo đã một lần nữa xác lập kỷ lục mới trên bảng xếp hạng ngành toàn cầu về tốc độ tính toán và tỷ số hiệu năng năng lượng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2120] [超速] (chāosù) - chạy quá tốc độ quy định [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '超速' AND pinyin = 'chāosù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '超速' AND pinyin = 'chāosù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '超速'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '超速'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chāosù',
      meaning_vi = 'chạy quá tốc độ quy định',
      example_hanzi = '为了自己和他人的生命安全，开车时严禁超速行驶。',
      example_pinyin = 'Wèile zìjǐ hé tārén de shēngmìng ānquán, kāichē shí yánjìn chāosù xíngshǐ.',
      example_vi = 'Vì an toàn sinh mạng của bản thân và người khác, khi lái xe nghiêm cấm chạy quá tốc độ quy định.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '超速',
      'chāosù',
      'chạy quá tốc độ quy định',
      'Động từ',
      'HSK 5',
      '为了自己和他人的生命安全，开车时严禁超速行驶。',
      'Wèile zìjǐ hé tārén de shēngmìng ānquán, kāichē shí yánjìn chāosù xíngshǐ.',
      'Vì an toàn sinh mạng của bản thân và người khác, khi lái xe nghiêm cấm chạy quá tốc độ quy định.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '为了自己和他人的生命安全，开车时严禁超速行驶。',
        'Wèile zìjǐ hé tārén de shēngmìng ānquán, kāichē shí yánjìn chāosù xíngshǐ.',
        'Vì an toàn sinh mạng của bản thân và người khác, khi lái xe nghiêm cấm chạy quá tốc độ quy định.',
        'basic',
        1
      ),
      (
        v_id,
        '交警部门在各主要高速路段启用了高清电子雷达测速系统，对严重超速的违法驾驶人员依法扣分并处以罚款。',
        'Jiāojǐng bùmén zài gè zhǔyào gāosù lùduàn qǐyòng le gāoqīng diànzǐ léidá cèsù xìtǒng, duì yánzhòng chāosù de wéifǎ jiàshǐ rényuán yīfǎ kòufēn bìng chǔyǐ fákuǎn.',
        'Cơ quan cảnh sát giao thông đã kích hoạt hệ thống đo tốc độ bằng radar điện tử độ nét cao tại các đoạn đường cao tốc chính, xử lý trừ điểm bằng lái và phạt tiền theo luật đối với tài xế vi phạm chạy quá tốc độ nghiêm trọng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2121] [朝] (cháo) - hướng về, quay về phía; triều đại (Đường triều, Tống triều) [Giới từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '朝' AND pinyin = 'cháo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '朝' AND pinyin = 'cháo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '朝'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '朝'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Giới từ / Danh từ',
      pinyin = 'cháo',
      meaning_vi = 'hướng về, quay về phía; triều đại (Đường triều, Tống triều)',
      example_hanzi = '清晨打开窗户，迎面朝升起的太阳深呼吸新鲜空气。',
      example_pinyin = 'Qīngchén dǎkāi chuānghu, yíngmiàn cháo shēngqǐ de tàiyáng shēnhūxī xīnxiān kōngqì.',
      example_vi = 'Sáng sớm mở cửa sổ ra, hướng mặt về phía mặt trời đang mọc mà hít thở sâu bầu không khí trong lành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '朝',
      'cháo',
      'hướng về, quay về phía; triều đại (Đường triều, Tống triều)',
      'Giới từ / Danh từ',
      'HSK 5',
      '清晨打开窗户，迎面朝升起的太阳深呼吸新鲜空气。',
      'Qīngchén dǎkāi chuānghu, yíngmiàn cháo shēngqǐ de tàiyáng shēnhūxī xīnxiān kōngqì.',
      'Sáng sớm mở cửa sổ ra, hướng mặt về phía mặt trời đang mọc mà hít thở sâu bầu không khí trong lành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '清晨打开窗户，迎面朝升起的太阳深呼吸新鲜空气。',
        'Qīngchén dǎkāi chuānghu, yíngmiàn cháo shēngqǐ de tàiyáng shēnhūxī xīnxiān kōngqì.',
        'Sáng sớm mở cửa sổ ra, hướng mặt về phía mặt trời đang mọc mà hít thở sâu bầu không khí trong lành.',
        'basic',
        1
      ),
      (
        v_id,
        '唐朝是中国古代封建社会经济高度繁荣、诗歌艺术绚烂璀璨的鼎盛历史朝代。',
        'Tángcháo shì Zhōngguó gǔdài fēngjiàn shèhuì jīngjì gāodù fánróng, shīgē yìshù xuànlàn cuǐcàn de dǐngshèng lìshǐ cháodài.',
        'Thời nhà Đường là triều đại lịch sử thịnh trị tột bậc trong xã hội phong kiến cổ đại Trung Quốc với nền kinh tế phồn vinh vượt bậc và nghệ thuật thi ca rực rỡ chói lọi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2122] [吵] (chǎo) - ồn ào, làm ồn; cãi nhau, tranh cãi [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '吵' AND pinyin = 'chǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '吵' AND pinyin = 'chǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '吵'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '吵'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'chǎo',
      meaning_vi = 'ồn ào, làm ồn; cãi nhau, tranh cãi',
      example_hanzi = '隔壁房间的电视机声音开得太大了，吵得我无法专心做作业。',
      example_pinyin = 'Gébì fángjiān de diànshìjī shēngyīn kāi de tài dà le, chǎo de wǒ wúfǎ zhuānxīn zuò zuòyè.',
      example_vi = 'Tiếng tivi phòng bên cạnh bật to quá, làm ồn khiến tôi không tài nào tập trung làm bài tập được.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '吵',
      'chǎo',
      'ồn ào, làm ồn; cãi nhau, tranh cãi',
      'Tính từ / Động từ',
      'HSK 5',
      '隔壁房间的电视机声音开得太大了，吵得我无法专心做作业。',
      'Gébì fángjiān de diànshìjī shēngyīn kāi de tài dà le, chǎo de wǒ wúfǎ zhuānxīn zuò zuòyè.',
      'Tiếng tivi phòng bên cạnh bật to quá, làm ồn khiến tôi không tài nào tập trung làm bài tập được.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '隔壁房间的电视机声音开得太大了，吵得我无法专心做作业。',
        'Gébì fángjiān de diànshìjī shēngyīn kāi de tài dà le, chǎo de wǒ wúfǎ zhuānxīn zuò zuòyè.',
        'Tiếng tivi phòng bên cạnh bật to quá, làm ồn khiến tôi không tài nào tập trung làm bài tập được.',
        'basic',
        1
      ),
      (
        v_id,
        '夫妻之间因生活琐事难免会有摩擦，但遇事要冷静沟通，千万不要当着孩子的面大吵大闹。',
        'Fūqī zhījiān yīn shēnghuó suǒshì nánmiǎn huì yǒu mócā, dàn yùshì yào lěngjìng gōutōng, qiānwàn bú yào dāng zhe háizi de miàn dà chǎo dà nào.',
        'Vợ chồng với nhau vì chuyện vặt vãnh đời sống khó tránh khỏi có va chạm, nhưng khi gặp chuyện cần bình tĩnh trao đổi, tuyệt đối không được cãi cọ ầm ĩ trước mặt con trẻ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2123] [炒] (chǎo) - xào, rang (món ăn); đầu cơ (cổ phiếu, bất động sản) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '炒' AND pinyin = 'chǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '炒' AND pinyin = 'chǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '炒'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '炒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chǎo',
      meaning_vi = 'xào, rang (món ăn); đầu cơ (cổ phiếu, bất động sản)',
      example_hanzi = '西红柿炒鸡蛋是一道深受大众喜爱的中国家常菜。',
      example_pinyin = 'Xīhóngshì chǎo jīdàn shì yí dào shēn shòu dàzhòng xǐ’ài de Zhōngguó jiāchángcài.',
      example_vi = 'Cà chua xào trứng là một món ăn gia đình quen thuộc của Trung Quốc được đông đảo mọi người vô cùng yêu thích.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '炒',
      'chǎo',
      'xào, rang (món ăn); đầu cơ (cổ phiếu, bất động sản)',
      'Động từ',
      'HSK 5',
      '西红柿炒鸡蛋是一道深受大众喜爱的中国家常菜。',
      'Xīhóngshì chǎo jīdàn shì yí dào shēn shòu dàzhòng xǐ’ài de Zhōngguó jiāchángcài.',
      'Cà chua xào trứng là một món ăn gia đình quen thuộc của Trung Quốc được đông đảo mọi người vô cùng yêu thích.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '西红柿炒鸡蛋是一道深受大众喜爱的中国家常菜。',
        'Xīhóngshì chǎo jīdàn shì yí dào shēn shòu dàzhòng xǐ’ài de Zhōngguó jiāchángcài.',
        'Cà chua xào trứng là một món ăn gia đình quen thuộc của Trung Quốc được đông đảo mọi người vô cùng yêu thích.',
        'basic',
        1
      ),
      (
        v_id,
        '国家坚决贯彻“房子是用来住的，不是用来炒的”调控政策，严厉打击各类投机炒房行为以稳定房地产市场。',
        'Guójiā jiānjué guànchè “fángzi shì yònglái zhù de, bú shì yònglái chǎo de” tiáokòng zhèngcè, yánlì dǎjī gè lèi tóujī chǎofáng xíngwéi yǐ wěndìng fángdìchǎn shìchǎng.',
        'Nhà nước kiên quyết quán triệt chính sách điều tiết “nhà là để ở, không phải để đầu cơ lướt sóng”, đánh mạnh vào mọi hành vi đầu cơ thổi giá nhà đất nhằm ổn định thị trường bất động sản.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2124] [车祸] (chēhuò) - tai nạn xe cộ, tai nạn giao thông đường bộ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '车祸' AND pinyin = 'chēhuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车祸' AND pinyin = 'chēhuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '车祸'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车祸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chēhuò',
      meaning_vi = 'tai nạn xe cộ, tai nạn giao thông đường bộ',
      example_hanzi = '雨天路滑视线受阻，司机要减速慢行以防发生车祸。',
      example_pinyin = 'Yǔtiān lù huá shìxiàn shòuzǔ, sījī yào jiǎnsù mànxíng yǐ fáng fāshēng chēhuò.',
      example_vi = 'Trời mưa đường trơn tầm nhìn bị cản trở, tài xế phải giảm tốc độ đi chậm để phòng ngừa xảy ra tai nạn giao thông.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '车祸',
      'chēhuò',
      'tai nạn xe cộ, tai nạn giao thông đường bộ',
      'Danh từ',
      'HSK 5',
      '雨天路滑视线受阻，司机要减速慢行以防发生车祸。',
      'Yǔtiān lù huá shìxiàn shòuzǔ, sījī yào jiǎnsù mànxíng yǐ fáng fāshēng chēhuò.',
      'Trời mưa đường trơn tầm nhìn bị cản trở, tài xế phải giảm tốc độ đi chậm để phòng ngừa xảy ra tai nạn giao thông.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '雨天路滑视线受阻，司机要减速慢行以防发生车祸。',
        'Yǔtiān lù huá shìxiàn shòuzǔ, sījī yào jiǎnsù mànxíng yǐ fáng fāshēng chēhuò.',
        'Trời mưa đường trơn tầm nhìn bị cản trở, tài xế phải giảm tốc độ đi chậm để phòng ngừa xảy ra tai nạn giao thông.',
        'basic',
        1
      ),
      (
        v_id,
        '救护车和交警火速赶往连环车祸事故现场开展伤员急救，并在最短时间内恢复了道路正常通行秩序。',
        'Jiùhùchē hé jiāojǐng huǒsù gǎnwǎng liánhuán chēhuò shìgù xiànchǎng kāizhǎn shāngyuán jíjiù, bìng zài zuì duǎn shíjiān nèi huīfù le dàolù zhèngcháng tōngxíng zhìxù.',
        'Xe cứu thương và cảnh sát giao thông hỏa tốc có mặt tại hiện trường vụ tai nạn xe đâm liên hoàn để triển khai cấp cứu người bị thương, đồng thời khôi phục trật tự lưu thông bình thường của tuyến đường trong thời gian ngắn nhất.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2125] [车库] (chēkù) - nhà để xe, gara đỗ xe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '车库' AND pinyin = 'chēkù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车库' AND pinyin = 'chēkù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '车库'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车库'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chēkù',
      meaning_vi = 'nhà để xe, gara đỗ xe',
      example_hanzi = '爸爸每天下班回家后，都会把车稳稳地停进地下车库。',
      example_pinyin = 'Bàba měitiān xiàbān huíjiā hòu, dōu huì bǎ chē wěnwěn de tíng jìn dìxià chēkù.',
      example_vi = 'Bố mỗi ngày sau khi tan làm về nhà đều cho xe đỗ ngay ngắn vào trong gara tầng hầm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '车库',
      'chēkù',
      'nhà để xe, gara đỗ xe',
      'Danh từ',
      'HSK 5',
      '爸爸每天下班回家后，都会把车稳稳地停进地下车库。',
      'Bàba měitiān xiàbān huíjiā hòu, dōu huì bǎ chē wěnwěn de tíng jìn dìxià chēkù.',
      'Bố mỗi ngày sau khi tan làm về nhà đều cho xe đỗ ngay ngắn vào trong gara tầng hầm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '爸爸每天下班回家后，都会把车稳稳地停进地下车库。',
        'Bàba měitiān xiàbān huíjiā hòu, dōu huì bǎ chē wěnwěn de tíng jìn dìxià chēkù.',
        'Bố mỗi ngày sau khi tan làm về nhà đều cho xe đỗ ngay ngắn vào trong gara tầng hầm.',
        'basic',
        1
      ),
      (
        v_id,
        '现代化新建商业综合体配备了智能感应立体地下车库，车主通过手机扫码即可自动实现反向寻车与无感缴费。',
        'Xiàndàihuà xīnjiàn shāngyè zōnghètǐ pèibèi le zhìnéng gǎnyìng lìtǐ dìxià chēkù, chēzhǔ tōngguò shǒujī sǎomǎ jí kě zìdòng shíxiàn fǎnxiàng xún chē yǔ wúgǎn jiǎofèi.',
        'Khu phức hợp thương mại mới xây hiện đại được trang bị gara tầng hầm lập thể cảm ứng thông minh, chủ xe thông qua quét mã điện thoại là có thể tự động tìm vị trí đỗ xe và thanh toán không chạm.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2126] [车辆] (chēliàng) - xe cộ, phương tiện giao thông đường bộ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '车辆' AND pinyin = 'chēliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车辆' AND pinyin = 'chēliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '车辆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车辆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chēliàng',
      meaning_vi = 'xe cộ, phương tiện giao thông đường bộ',
      example_hanzi = '早晚交通高峰期，主干道上的过往车辆川流不息。',
      example_pinyin = 'Zǎowǎn jiāotōng gāofēngqī, zhǔgàndào shàng de guòwǎng chēliàng chuānliú-bùxī.',
      example_vi = 'Vào giờ cao điểm giao thông sáng tối, xe cộ qua lại trên tuyến đường huyết mạch nườm nượp không ngớt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '车辆',
      'chēliàng',
      'xe cộ, phương tiện giao thông đường bộ',
      'Danh từ',
      'HSK 5',
      '早晚交通高峰期，主干道上的过往车辆川流不息。',
      'Zǎowǎn jiāotōng gāofēngqī, zhǔgàndào shàng de guòwǎng chēliàng chuānliú-bùxī.',
      'Vào giờ cao điểm giao thông sáng tối, xe cộ qua lại trên tuyến đường huyết mạch nườm nượp không ngớt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '早晚交通高峰期，主干道上的过往车辆川流不息。',
        'Zǎowǎn jiāotōng gāofēngqī, zhǔgàndào shàng de guòwǎng chēliàng chuānliú-bùxī.',
        'Vào giờ cao điểm giao thông sáng tối, xe cộ qua lại trên tuyến đường huyết mạch nườm nượp không ngớt.',
        'basic',
        1
      ),
      (
        v_id,
        '为有效缓解市中心拥堵状况并减少碳排放，交管部门对高排放机动车辆实行工作日尾号限行措施。',
        'Wèi yǒuxiào huǎnjiě shì zhōngxīn yōngdǔ zhuàngkuàng bìng jiǎnshǎo tànpáifàng, jiāoguǎn bùmén duì gāo páifàng jīdòng chēliàng shíxíng gōngzuòrì wěihào xiànxíng cuòshī.',
        'Nhằm giảm thiểu hiệu quả tình trạng ùn tắc giao thông ở trung tâm thành phố và cắt giảm khí thải carbon, cơ quan quản lý giao thông áp dụng biện pháp hạn chế lưu thông theo số đuôi biển số xe vào ngày làm việc đối với xe cơ giới có mức phát thải cao.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2127] [车厢] (chēxiāng) - toa xe (tàu hỏa, tàu điện ngầm) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '车厢' AND pinyin = 'chēxiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车厢' AND pinyin = 'chēxiāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '车厢'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车厢'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chēxiāng',
      meaning_vi = 'toa xe (tàu hỏa, tàu điện ngầm)',
      example_hanzi = '高铁车厢里十分干净整洁，座椅坐着非常舒适。',
      example_pinyin = 'Gāotiě chēxiāng lǐ shífēn gānjìng zhěngjié, zuòyǐ zuò zhe fēicháng shūshì.',
      example_vi = 'Bên trong toa tàu cao tốc vô cùng sạch sẽ ngăn nắp, ghế ngồi rất êm ái thoải mái.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '车厢',
      'chēxiāng',
      'toa xe (tàu hỏa, tàu điện ngầm)',
      'Danh từ',
      'HSK 5',
      '高铁车厢里十分干净整洁，座椅坐着非常舒适。',
      'Gāotiě chēxiāng lǐ shífēn gānjìng zhěngjié, zuòyǐ zuò zhe fēicháng shūshì.',
      'Bên trong toa tàu cao tốc vô cùng sạch sẽ ngăn nắp, ghế ngồi rất êm ái thoải mái.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '高铁车厢里十分干净整洁，座椅坐着非常舒适。',
        'Gāotiě chēxiāng lǐ shífēn gānjìng zhěngjié, zuòyǐ zuò zhe fēicháng shūshì.',
        'Bên trong toa tàu cao tốc vô cùng sạch sẽ ngăn nắp, ghế ngồi rất êm ái thoải mái.',
        'basic',
        1
      ),
      (
        v_id,
        '为了给长途旅客营造良好的旅途休息环境，铁路部门在多趟跨省高铁列车上推出了静音车厢服务。',
        'Wèile gěi chángtú lǚkè yíngzào liánghǎo de lǚtú xiūxi huánjìng, tiělù bùmén zài duō tàng kuàshěng gāotiě lièchē shàng tuīchū le jìngyīn chēxiāng fúwù.',
        'Nhằm tạo dựng môi trường nghỉ ngơi lý tưởng cho hành khách đi đường dài, ngành đường sắt đã triển khai dịch vụ toa xe yên tĩnh trên nhiều chuyến tàu cao tốc liên tỉnh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2128] [车主] (chēzhǔ) - chủ xe, chủ sở hữu phương tiện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '车主' AND pinyin = 'chēzhǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车主' AND pinyin = 'chēzhǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '车主'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '车主'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chēzhǔ',
      meaning_vi = 'chủ xe, chủ sở hữu phương tiện',
      example_hanzi = '交警正在根据挡风玻璃上的挪车电话联系违停车辆的车主。',
      example_pinyin = 'Jiāojǐng zhèngzài gēnjù dǎngfēng bōli shàng de nuó chē diànhuà liánxì wéitíng chēliàng de chēzhǔ.',
      example_vi = 'Cảnh sát giao thông đang dựa theo số điện thoại dời xe để trên kính chắn gió liên hệ với chủ xe đỗ xe sai quy định.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '车主',
      'chēzhǔ',
      'chủ xe, chủ sở hữu phương tiện',
      'Danh từ',
      'HSK 5',
      '交警正在根据挡风玻璃上的挪车电话联系违停车辆的车主。',
      'Jiāojǐng zhèngzài gēnjù dǎngfēng bōli shàng de nuó chē diànhuà liánxì wéitíng chēliàng de chēzhǔ.',
      'Cảnh sát giao thông đang dựa theo số điện thoại dời xe để trên kính chắn gió liên hệ với chủ xe đỗ xe sai quy định.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '交警正在根据挡风玻璃上的挪车电话联系违停车辆的车主。',
        'Jiāojǐng zhèngzài gēnjù dǎngfēng bōli shàng de nuó chē diànhuà liánxì wéitíng chēliàng de chēzhǔ.',
        'Cảnh sát giao thông đang dựa theo số điện thoại dời xe để trên kính chắn gió liên hệ với chủ xe đỗ xe sai quy định.',
        'basic',
        1
      ),
      (
        v_id,
        '随着公共充电桩网络的迅速完善，纯电动汽车车主告别了里程焦虑，日常充电体验得到了大幅改善。',
        'Suízhe gōnggòng chōngdiànzhuāng wǎngluò de xùnsù wánshàn, chún diàndòng qìchē chēzhǔ gàobié le lǐchéng jiāolǜ, rìcháng chōngdiàn tǐyàn dédào le dà fú gǎishàn.',
        'Cùng với việc mạng lưới trụ sạc công cộng nhanh chóng hoàn thiện, các chủ xe ô tô thuần điện đã chia tay nỗi lo lắng về quãng đường di chuyển, trải nghiệm sạc pin hằng ngày được nâng cao rõ rệt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2129] [彻底] (chèdǐ) - triệt để, hoàn toàn, thấu đáo, tận gốc [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '彻底' AND pinyin = 'chèdǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '彻底' AND pinyin = 'chèdǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '彻底'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '彻底'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'chèdǐ',
      meaning_vi = 'triệt để, hoàn toàn, thấu đáo, tận gốc',
      example_hanzi = '周末全家人一起动手，对整个屋子做了一次彻底的大扫除。',
      example_pinyin = 'Zhōumò quán jiārén yìqǐ dòngshǒu, duì zhěnggè wūzi zuò le yí cì chèdǐ de dàsǎochú.',
      example_vi = 'Cuối tuần cả nhà cùng nhau bắt tay làm một đợt tổng vệ sinh triệt để cho toàn bộ ngôi nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '彻底',
      'chèdǐ',
      'triệt để, hoàn toàn, thấu đáo, tận gốc',
      'Tính từ / Phó từ',
      'HSK 5',
      '周末全家人一起动手，对整个屋子做了一次彻底的大扫除。',
      'Zhōumò quán jiārén yìqǐ dòngshǒu, duì zhěnggè wūzi zuò le yí cì chèdǐ de dàsǎochú.',
      'Cuối tuần cả nhà cùng nhau bắt tay làm một đợt tổng vệ sinh triệt để cho toàn bộ ngôi nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '周末全家人一起动手，对整个屋子做了一次彻底的大扫除。',
        'Zhōumò quán jiārén yìqǐ dòngshǒu, duì zhěnggè wūzi zuò le yí cì chèdǐ de dàsǎochú.',
        'Cuối tuần cả nhà cùng nhau bắt tay làm một đợt tổng vệ sinh triệt để cho toàn bộ ngôi nhà.',
        'basic',
        1
      ),
      (
        v_id,
        '要想彻底解决工业企业偷排污水的问题，不仅需要严密的技术监测，更需要建立健全的长效法律惩戒机制。',
        'Yào xiǎng chèdǐ jiějué gōngyè qǐyè tōupái wūshuǐ de wèntí, bùjǐn xūyào yánmì de jìshù jiāncè, gèng xūyào jiànlì jiànquán de chángxiào fǎlǜ chéngjiè jīzhì.',
        'Muốn giải quyết triệt để vấn đề doanh nghiệp công nghiệp xả trộm nước thải, không chỉ cần sự giám sát kỹ thuật chặt chẽ, mà càng cần thiết lập cơ chế xử phạt pháp lý hiệu quả dài lâu và hoàn thiện.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2130] [沉] (chén) - chìm, lặn xuống nước; nặng trĩu, trầm mặc [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '沉' AND pinyin = 'chén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沉' AND pinyin = 'chén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '沉'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'chén',
      meaning_vi = 'chìm, lặn xuống nước; nặng trĩu, trầm mặc',
      example_hanzi = '把一块石头扔进水池里，它很快就沉到了水底。',
      example_pinyin = 'Bǎ yí kuài shítóu rēng jìn shuǐchí lǐ, tā hěn kuài jiù chén dào le shuǐdǐ.',
      example_vi = 'Ném một hòn đá vào trong hồ nước, nó rất nhanh chìm nghỉm xuống tận đáy nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '沉',
      'chén',
      'chìm, lặn xuống nước; nặng trĩu, trầm mặc',
      'Động từ / Tính từ',
      'HSK 5',
      '把一块石头扔进水池里，它很快就沉到了水底。',
      'Bǎ yí kuài shítóu rēng jìn shuǐchí lǐ, tā hěn kuài jiù chén dào le shuǐdǐ.',
      'Ném một hòn đá vào trong hồ nước, nó rất nhanh chìm nghỉm xuống tận đáy nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '把一块石头扔进水池里，它很快就沉到了水底。',
        'Bǎ yí kuài shítóu rēng jìn shuǐchí lǐ, tā hěn kuài jiù chén dào le shuǐdǐ.',
        'Ném một hòn đá vào trong hồ nước, nó rất nhanh chìm nghỉm xuống tận đáy nước.',
        'basic',
        1
      ),
      (
        v_id,
        '听到项目关键技术攻关失败的通报，整个研发会议室里的气氛瞬间沉了下来，大家的心情十分沉重。',
        'Tīngdào xiàngmù guānjiàn jìshù gōngguān shībài de tōngbào, zhěnggè yánfā huìyìshì lǐ de qìfēn shùnjiān chén le xiàlái, dàjiā de xīnqíng shífēn chénzhòng.',
        'Nghe thông báo việc khắc phục công nghệ then chốt của dự án bị thất bại, bầu không khí trong toàn bộ phòng họp R&D tức thì trầm hẳn xuống, tâm trạng ai nấy đều vô cùng nặng trĩu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2131] [沉默] (chénmò) - trầm mặc, im lặng, làm thinh không nói [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '沉默' AND pinyin = 'chénmò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沉默' AND pinyin = 'chénmò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '沉默'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沉默'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'chénmò',
      meaning_vi = 'trầm mặc, im lặng, làm thinh không nói',
      example_hanzi = '面对老师提出的严肃批评，他低下头保持了沉默。',
      example_pinyin = 'Miànduì lǎoshī tíchū de yánsù pīpíng, tā dī xià tóu bǎochí le chénmò.',
      example_vi = 'Đối mặt với lời phê bình nghiêm khắc của thầy giáo, cậu ấy cúi đầu im lặng làm thinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '沉默',
      'chénmò',
      'trầm mặc, im lặng, làm thinh không nói',
      'Tính từ / Động từ',
      'HSK 5',
      '面对老师提出的严肃批评，他低下头保持了沉默。',
      'Miànduì lǎoshī tíchū de yánsù pīpíng, tā dī xià tóu bǎochí le chénmò.',
      'Đối mặt với lời phê bình nghiêm khắc của thầy giáo, cậu ấy cúi đầu im lặng làm thinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '面对老师提出的严肃批评，他低下头保持了沉默。',
        'Miànduì lǎoshī tíchū de yánsù pīpíng, tā dī xià tóu bǎochí le chénmò.',
        'Đối mặt với lời phê bình nghiêm khắc của thầy giáo, cậu ấy cúi đầu im lặng làm thinh.',
        'basic',
        1
      ),
      (
        v_id,
        '在这场涉及公众切身健康利益的食品安全争议中，监管部门绝不能选择保持沉默，而应迅速查明真相并及时向社会公布。',
        'Zài zhè chǎng shèjí gōngzhòng qiēshēn jiànkāng lìyì de shípǐn ānquán zhēngyì zhōng, jiānguǎn bùmén jué bù néng xuǎnzé bǎochí chénmò, ér yīng xùnsù chámíng zhēnxiàng bìng jíshí xiàng shèhuì gōngbù.',
        'Trong cuộc tranh cãi về an toàn thực phẩm liên quan trực tiếp đến lợi ích sức khỏe thiết thân của công chúng này, cơ quan giám sát tuyệt đối không thể chọn cách im lặng, mà nên nhanh chóng làm rõ chân tướng và kịp thời công bố rộng rãi trước xã hội.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2132] [称] (chēng) - gọi là, xưng hô; cân, đo lường trọng lượng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '称' AND pinyin = 'chēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '称' AND pinyin = 'chēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '称'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '称'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chēng',
      meaning_vi = 'gọi là, xưng hô; cân, đo lường trọng lượng',
      example_hanzi = '人们常用“东方之珠”来亲切称呼繁华美丽的香港。',
      example_pinyin = 'Rénmen cháng yòng “Dōngfāng zhī Zhū” lái qīnqiè chēnghu fánhuá měilì de Xiānggǎng.',
      example_vi = 'Mọi người thường dùng cụm từ “Hòn ngọc Viễn Đông” để xưng gọi một cách thân thương vùng đất Hong Kong phồn hoa xinh đẹp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '称',
      'chēng',
      'gọi là, xưng hô; cân, đo lường trọng lượng',
      'Động từ',
      'HSK 5',
      '人们常用“东方之珠”来亲切称呼繁华美丽的香港。',
      'Rénmen cháng yòng “Dōngfāng zhī Zhū” lái qīnqiè chēnghu fánhuá měilì de Xiānggǎng.',
      'Mọi người thường dùng cụm từ “Hòn ngọc Viễn Đông” để xưng gọi một cách thân thương vùng đất Hong Kong phồn hoa xinh đẹp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '人们常用“东方之珠”来亲切称呼繁华美丽的香港。',
        'Rénmen cháng yòng “Dōngfāng zhī Zhū” lái qīnqiè chēnghu fánhuá měilì de Xiānggǎng.',
        'Mọi người thường dùng cụm từ “Hòn ngọc Viễn Đông” để xưng gọi một cách thân thương vùng đất Hong Kong phồn hoa xinh đẹp.',
        'basic',
        1
      ),
      (
        v_id,
        '顾客在生鲜水果超市挑选好新鲜苹果后，营业员熟练地放在电子秤上称了重量并打印价格标签。',
        'Gùkè zài shēngxiān shuǐguǒ chāoshì tiāoxuǎn hǎo xīnxiān píngguǒ hòu, yíngyèyuán shúliàn de fàng zài diànzǐchèng shàng chēng le zhòngliàng bìng dǎyìn jiàgé biāoqiān.',
        'Khách hàng sau khi chọn xong táo tươi tại siêu thị trái cây tươi sống, nhân viên bán hàng thoăn thoắt đặt lên cân điện tử cân trọng lượng và in tem nhãn giá.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2133] [称为] (chēngwéi) - được gọi là, gọi là, mệnh danh là [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '称为' AND pinyin = 'chēngwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '称为' AND pinyin = 'chēngwéi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '称为'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '称为'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chēngwéi',
      meaning_vi = 'được gọi là, gọi là, mệnh danh là',
      example_hanzi = '大熊猫是中国的国宝，被人们亲切地称为“活化石”。',
      example_pinyin = 'Dàxióngmāo shì Zhōngguó de guóbǎo, bèi rénmen qīnqiè de chēngwéi “huóhuàshí”.',
      example_vi = 'Gấu trúc lớn là quốc bảo của Trung Quốc, được mọi người trìu mến gọi là “hóa thạch sống”.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '称为',
      'chēngwéi',
      'được gọi là, gọi là, mệnh danh là',
      'Động từ',
      'HSK 5',
      '大熊猫是中国的国宝，被人们亲切地称为“活化石”。',
      'Dàxióngmāo shì Zhōngguó de guóbǎo, bèi rénmen qīnqiè de chēngwéi “huóhuàshí”.',
      'Gấu trúc lớn là quốc bảo của Trung Quốc, được mọi người trìu mến gọi là “hóa thạch sống”.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '大熊猫是中国的国宝，被人们亲切地称为“活化石”。',
        'Dàxióngmāo shì Zhōngguó de guóbǎo, bèi rénmen qīnqiè de chēngwéi “huóhuàshí”.',
        'Gấu trúc lớn là quốc bảo của Trung Quốc, được mọi người trìu mến gọi là “hóa thạch sống”.',
        'basic',
        1
      ),
      (
        v_id,
        '由于长期专注于高端精密制造且在细分市场占据全球领先份额，这批优秀民营企业被业界誉称为“隐形冠军”。',
        'Yóuyú chángqī zhuānzhù yú gāoduān jīngmì zhìzào qiě zài xìfēn shìchǎng zhànjù quánqiú lǐngxiān fèn’é, zhè pī yōuxiù mínyíng qǐyè bèi yèjiè yùchēng wèi “yǐnxíng guànjūn”.',
        'Nhờ lâu dài chuyên tâm vào lĩnh vực chế tạo chuẩn xác cao cấp và chiếm lĩnh thị phần hàng đầu thế giới tại thị trường ngách, nhóm doanh nghiệp tư nhân xuất sắc này được giới chuyên ngành tôn xưng là “nhà vô địch ẩn mình”.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2134] [称赞] (chēngzàn) - khen ngợi, tán thưởng, ca ngợi [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '称赞' AND pinyin = 'chēngzàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '称赞' AND pinyin = 'chēngzàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '称赞'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '称赞'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'chēngzàn',
      meaning_vi = 'khen ngợi, tán thưởng, ca ngợi',
      example_hanzi = '小明主动扶盲人过马路的行为受到了老师和同学们的由衷称赞。',
      example_pinyin = 'Xiǎomíng zhǔdòng fú mángrén guò mǎlù de xíngwéi shòudào le lǎoshī hé tóngxuémen de yóuzhōng chēngzàn.',
      example_vi = 'Hành động chủ động dắt người khiếm thị qua đường của Tiểu Minh đã nhận được lời khen ngợi chân thành từ thầy giáo và các bạn học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '称赞',
      'chēngzàn',
      'khen ngợi, tán thưởng, ca ngợi',
      'Động từ / Danh từ',
      'HSK 5',
      '小明主动扶盲人过马路的行为受到了老师和同学们的由衷称赞。',
      'Xiǎomíng zhǔdòng fú mángrén guò mǎlù de xíngwéi shòudào le lǎoshī hé tóngxuémen de yóuzhōng chēngzàn.',
      'Hành động chủ động dắt người khiếm thị qua đường của Tiểu Minh đã nhận được lời khen ngợi chân thành từ thầy giáo và các bạn học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '小明主动扶盲人过马路的行为受到了老师和同学们的由衷称赞。',
        'Xiǎomíng zhǔdòng fú mángrén guò mǎlù de xíngwéi shòudào le lǎoshī hé tóngxuémen de yóuzhōng chēngzàn.',
        'Hành động chủ động dắt người khiếm thị qua đường của Tiểu Minh đã nhận được lời khen ngợi chân thành từ thầy giáo và các bạn học.',
        'basic',
        1
      ),
      (
        v_id,
        '该医疗援助团队在非洲偏远地区克服重重艰苦条件救死扶伤，赢得了受援国政府与广大当地民众的高度称赞。',
        'Gāi yīliáo yuánzhù tuánduì zài Fēizhōu piānyuǎn dìqū kèfú chóngchóng jiānkǔ tiáojiàn jiùsǐ-fúshāng, yíngdé le shòuyuánguó zhèngfǔ yǔ guǎngdà dāngdì mínzhòng de gāodù chēngzàn.',
        'Đoàn viện trợ y tế này tại vùng xa xôi hẻo lánh của châu Phi đã vượt qua muôn vàn điều kiện gian khổ để cứu chữa người bệnh, giành được sự tán thưởng và ca ngợi hết lời từ chính phủ nước tiếp nhận và đông đảo người dân sở tại.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2135] [成本] (chéngběn) - giá thành, chi phí sản xuất kinh doanh, vốn liếng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成本' AND pinyin = 'chéngběn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成本' AND pinyin = 'chéngběn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成本'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成本'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngběn',
      meaning_vi = 'giá thành, chi phí sản xuất kinh doanh, vốn liếng',
      example_hanzi = '采用节能设备不仅能保护环境，还能有效降低生产成本。',
      example_pinyin = 'Cǎiyòng jiénéng shèbèi bùjǐn néng bǎohù huánjìng, hái néng yǒuxiào jiàngdī shēngchǎn chéngběn.',
      example_vi = 'Sử dụng thiết bị tiết kiệm năng lượng không chỉ bảo vệ môi trường mà còn hạ thấp chi phí sản xuất một cách hiệu quả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成本',
      'chéngběn',
      'giá thành, chi phí sản xuất kinh doanh, vốn liếng',
      'Danh từ',
      'HSK 5',
      '采用节能设备不仅能保护环境，还能有效降低生产成本。',
      'Cǎiyòng jiénéng shèbèi bùjǐn néng bǎohù huánjìng, hái néng yǒuxiào jiàngdī shēngchǎn chéngběn.',
      'Sử dụng thiết bị tiết kiệm năng lượng không chỉ bảo vệ môi trường mà còn hạ thấp chi phí sản xuất một cách hiệu quả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '采用节能设备不仅能保护环境，还能有效降低生产成本。',
        'Cǎiyòng jiénéng shèbèi bùjǐn néng bǎohù huánjìng, hái néng yǒuxiào jiàngdī shēngchǎn chéngběn.',
        'Sử dụng thiết bị tiết kiệm năng lượng không chỉ bảo vệ môi trường mà còn hạ thấp chi phí sản xuất một cách hiệu quả.',
        'basic',
        1
      ),
      (
        v_id,
        '在激烈的市场价格战中，企业必须通过优化供应链管理与精益生产流程，全方位压缩不必要的间接运营成本。',
        'Zài jīliè de shìchǎng jiàgézhàn zhōng, qǐyè bìxū tōngguò yōuhuà gōngyìngliàn guǎnlǐ yǔ jīngyì shēngchǎn liúchéng, quán fāngwèi yāsuō bú bìyào de jiànjiē yùnyíng chéngběn.',
        'Trong cuộc chiến giá cả thị trường khốc liệt, doanh nghiệp bắt buộc phải tối ưu hóa quản lý chuỗi cung ứng và quy trình sản xuất tinh gọn, cắt giảm toàn diện các chi phí vận hành gián tiếp không cần thiết.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2136] [承担] (chéngdān) - gánh vác, đảm đương (trách nhiệm, nghĩa vụ, chi phí, rủi ro) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '承担' AND pinyin = 'chéngdān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '承担' AND pinyin = 'chéngdān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '承担'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '承担'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chéngdān',
      meaning_vi = 'gánh vác, đảm đương (trách nhiệm, nghĩa vụ, chi phí, rủi ro)',
      example_hanzi = '作为班长，他主动承担了组织这次班级集体活动的全部工作。',
      example_pinyin = 'Zuòwéi bānzhǎng, tā zhǔdòng chéngdān le zǔzhī zhè cì bānjí jítǐ huódòng de quánbù gōngzuò.',
      example_vi = 'Với tư cách lớp trưởng, bạn ấy đã chủ động gánh vác toàn bộ công việc tổ chức hoạt động tập thể lớp lần này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '承担',
      'chéngdān',
      'gánh vác, đảm đương (trách nhiệm, nghĩa vụ, chi phí, rủi ro)',
      'Động từ',
      'HSK 5',
      '作为班长，他主动承担了组织这次班级集体活动的全部工作。',
      'Zuòwéi bānzhǎng, tā zhǔdòng chéngdān le zǔzhī zhè cì bānjí jítǐ huódòng de quánbù gōngzuò.',
      'Với tư cách lớp trưởng, bạn ấy đã chủ động gánh vác toàn bộ công việc tổ chức hoạt động tập thể lớp lần này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '作为班长，他主动承担了组织这次班级集体活动的全部工作。',
        'Zuòwéi bānzhǎng, tā zhǔdòng chéngdān le zǔzhī zhè cì bānjí jítǐ huódòng de quánbù gōngzuò.',
        'Với tư cách lớp trưởng, bạn ấy đã chủ động gánh vác toàn bộ công việc tổ chức hoạt động tập thể lớp lần này.',
        'basic',
        1
      ),
      (
        v_id,
        '合同双方在不可抗力条款中明确约定，如因极端自然灾害导致工程延期，各自依法承担相应的经济损失。',
        'Hétong shuāngfāng zài bùkěkànglì tiáokuǎn zhōng míngquè yuēdìng, rú yīn jíduān zìrán zāihài dǎozhì gōngchéng yánqī, gèzì yīfǎ chéngdān xiāngyìng de jīngjì sǔnshī.',
        'Hai bên hợp đồng đã quy định rõ ràng trong điều khoản bất khả kháng rằng, nếu vì thiên tai tự nhiên cực đoan dẫn tới công trình bị chậm trễ tiến độ, mỗi bên sẽ tự gánh chịu tổn thất kinh tế tương ứng theo quy định pháp luật.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2137] [程度] (chéngdù) - trình độ, mức độ (phát triển, tổn hại, thấu hiểu) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '程度' AND pinyin = 'chéngdù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '程度' AND pinyin = 'chéngdù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '程度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '程度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngdù',
      meaning_vi = 'trình độ, mức độ (phát triển, tổn hại, thấu hiểu)',
      example_hanzi = '每个人的汉语口语流利程度各不相同，需要针对性地多加练习。',
      example_pinyin = 'Měi gè rén de Hànyǔ kǒuyǔ liúlì chéngdù gè bù xiāngtóng, xūyào zhēnduìxìng de duō jiā liànxí.',
      example_vi = 'Mức độ lưu loát khi nói khẩu ngữ tiếng Hán của mỗi người đều không giống nhau, cần phải luyện tập thêm nhiều một cách có trọng tâm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '程度',
      'chéngdù',
      'trình độ, mức độ (phát triển, tổn hại, thấu hiểu)',
      'Danh từ',
      'HSK 5',
      '每个人的汉语口语流利程度各不相同，需要针对性地多加练习。',
      'Měi gè rén de Hànyǔ kǒuyǔ liúlì chéngdù gè bù xiāngtóng, xūyào zhēnduìxìng de duō jiā liànxí.',
      'Mức độ lưu loát khi nói khẩu ngữ tiếng Hán của mỗi người đều không giống nhau, cần phải luyện tập thêm nhiều một cách có trọng tâm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '每个人的汉语口语流利程度各不相同，需要针对性地多加练习。',
        'Měi gè rén de Hànyǔ kǒuyǔ liúlì chéngdù gè bù xiāngtóng, xūyào zhēnduìxìng de duō jiā liànxí.',
        'Mức độ lưu loát khi nói khẩu ngữ tiếng Hán của mỗi người đều không giống nhau, cần phải luyện tập thêm nhiều một cách có trọng tâm.',
        'basic',
        1
      ),
      (
        v_id,
        '专家评估报告指出，本轮强震对老旧砖混民房造成了不同程度的结构性损伤，需分类采取加固或拆除重建方案。',
        'Zhuānjiā pínggū bàogào zhǐchū, běn lún qiángzhèn duì lǎojiù zhuānhùn mínfáng zàochéng le bù tóng chéngdù de jiégòuxìng sǔnshāng, xū fēnlèi cǎiqǔ jiāgù huò chāichú chóngjiàn fāng’àn.',
        'Báo cáo đánh giá của chuyên gia chỉ rõ, đợt động đất mạnh lần này đã gây ra hư hại kết cấu ở các mức độ khác nhau đối với những ngôi nhà dân xây gạch vữa cũ kỹ, cần phân loại để áp dụng phương án gia cố hoặc phá dỡ xây dựng lại.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2138] [成分] (chéngfèn) - thành phần (hóa học, dinh dưỡng, nguyên liệu) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成分' AND pinyin = 'chéngfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成分' AND pinyin = 'chéngfèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成分'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成分'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngfèn',
      meaning_vi = 'thành phần (hóa học, dinh dưỡng, nguyên liệu)',
      example_hanzi = '食品外包装袋上用清晰的文字标明了所有原材料成分。',
      example_pinyin = 'Shípǐn wài bāozhuāngdài shàng yòng qīngxī de wénzì biāomíng le suǒyǒu yuáncáiliào chéngfèn.',
      example_vi = 'Trên bao bì ngoài của thực phẩm dùng văn tự rõ ràng ghi rõ tất cả thành phần nguyên vật liệu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成分',
      'chéngfèn',
      'thành phần (hóa học, dinh dưỡng, nguyên liệu)',
      'Danh từ',
      'HSK 5',
      '食品外包装袋上用清晰的文字标明了所有原材料成分。',
      'Shípǐn wài bāozhuāngdài shàng yòng qīngxī de wénzì biāomíng le suǒyǒu yuáncáiliào chéngfèn.',
      'Trên bao bì ngoài của thực phẩm dùng văn tự rõ ràng ghi rõ tất cả thành phần nguyên vật liệu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '食品外包装袋上用清晰的文字标明了所有原材料成分。',
        'Shípǐn wài bāozhuāngdài shàng yòng qīngxī de wénzì biāomíng le suǒyǒu yuáncáiliào chéngfèn.',
        'Trên bao bì ngoài của thực phẩm dùng văn tự rõ ràng ghi rõ tất cả thành phần nguyên vật liệu.',
        'basic',
        1
      ),
      (
        v_id,
        '药理学家通过现代分离提纯技术，成功从传统中草药中提取出了具有显著抗肿瘤活性的有效化学成分。',
        'Yàolǐxuéjiā tōngguò xiàndài fēnlí tíchún jìshù, chénggōng cóng chuántǒng zhōngcǎoyào zhōng tíqǔ chū le jùyǒu xiǎnzhù kàng zhǒngliú huóxìng de yǒuxiào huàxué chéngfèn.',
        'Các nhà dược lý học thông qua kỹ thuật phân tách chiết xuất tinh khiết hiện đại đã thành công chiết xuất được thành phần hóa học hữu hiệu có hoạt tính kháng u bướu rõ rệt từ thảo dược truyền thống.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2139] [成果] (chéngguǒ) - thành quả, kết quả tốt đẹp đạt được (nghiên cứu, lao động) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成果' AND pinyin = 'chéngguǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成果' AND pinyin = 'chéngguǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成果'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成果'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngguǒ',
      meaning_vi = 'thành quả, kết quả tốt đẹp đạt được (nghiên cứu, lao động)',
      example_hanzi = '经过全体科研人员一年的刻苦攻关，这项重点课题终于取得了突破性成果。',
      example_pinyin = 'Jīngguò quántǐ kēyán rényuán yì nián de kèkǔ gōngguān, zhè xiàng zhòngdiǎn kètí zhōngyú qǔdé le tūpòxìng chéngguǒ.',
      example_vi = 'Sau một năm miệt mài nghiên cứu khắc phục khó khăn của toàn thể nhân viên nghiên cứu khoa học, đề tài trọng điểm này cuối cùng đã thu được thành quả mang tính đột phá.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成果',
      'chéngguǒ',
      'thành quả, kết quả tốt đẹp đạt được (nghiên cứu, lao động)',
      'Danh từ',
      'HSK 5',
      '经过全体科研人员一年的刻苦攻关，这项重点课题终于取得了突破性成果。',
      'Jīngguò quántǐ kēyán rényuán yì nián de kèkǔ gōngguān, zhè xiàng zhòngdiǎn kètí zhōngyú qǔdé le tūpòxìng chéngguǒ.',
      'Sau một năm miệt mài nghiên cứu khắc phục khó khăn của toàn thể nhân viên nghiên cứu khoa học, đề tài trọng điểm này cuối cùng đã thu được thành quả mang tính đột phá.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '经过全体科研人员一年的刻苦攻关，这项重点课题终于取得了突破性成果。',
        'Jīngguò quántǐ kēyán rényuán yì nián de kèkǔ gōngguān, zhè xiàng zhòngdiǎn kètí zhōngyú qǔdé le tūpòxìng chéngguǒ.',
        'Sau một năm miệt mài nghiên cứu khắc phục khó khăn của toàn thể nhân viên nghiên cứu khoa học, đề tài trọng điểm này cuối cùng đã thu được thành quả mang tính đột phá.',
        'basic',
        1
      ),
      (
        v_id,
        '峰会闭幕之际，与会各国领导人签署了多边经贸合作联合公报，充分肯定了各方在推动绿色转型领域取得的丰硕务实成果。',
        'Fēnghuì bìmù zhī jì, yùhuì gè guó lǐngdǎorén qiānshǔ le duōbiān jīng-mào hézuò liánhé gōngbào, chōngfèn kěndìng le gè fāng zài tuīdòng lǜsè zhuǎnxíng lǐngyù qǔdé de fēngshuò wùshí chéngguǒ.',
        'Vào thời điểm hội nghị thượng đỉnh bế mạc, lãnh đạo các nước tham dự đã ký kết thông cáo chung hợp tác kinh tế thương mại đa phương, khẳng định đầy đủ các thành quả thiết thực dồi dào mà các bên đã đạt được trong lĩnh vực thúc đẩy chuyển đổi xanh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2140] [成就] (chéngjiù) - thành tựu, thành tích vĩ đại; vun đắp nên, tạo dựng [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成就' AND pinyin = 'chéngjiù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成就' AND pinyin = 'chéngjiù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成就'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成就'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'chéngjiù',
      meaning_vi = 'thành tựu, thành tích vĩ đại; vun đắp nên, tạo dựng',
      example_hanzi = '他在生物物理学研究领域所取得的杰出成就令人瞩目。',
      example_pinyin = 'Tā zài shēngwù wùlǐxué yánjiū lǐngyù suǒ qǔdé de jiéchū chéngjiù lìngrén zhǔmù.',
      example_vi = 'Những thành tựu kiệt xuất mà ông ấy đạt được trong lĩnh vực nghiên cứu vật lý sinh học khiến mọi người vô cùng ngưỡng mộ dõi theo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成就',
      'chéngjiù',
      'thành tựu, thành tích vĩ đại; vun đắp nên, tạo dựng',
      'Danh từ / Động từ',
      'HSK 5',
      '他在生物物理学研究领域所取得的杰出成就令人瞩目。',
      'Tā zài shēngwù wùlǐxué yánjiū lǐngyù suǒ qǔdé de jiéchū chéngjiù lìngrén zhǔmù.',
      'Những thành tựu kiệt xuất mà ông ấy đạt được trong lĩnh vực nghiên cứu vật lý sinh học khiến mọi người vô cùng ngưỡng mộ dõi theo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他在生物物理学研究领域所取得的杰出成就令人瞩目。',
        'Tā zài shēngwù wùlǐxué yánjiū lǐngyù suǒ qǔdé de jiéchū chéngjiù lìngrén zhǔmù.',
        'Những thành tựu kiệt xuất mà ông ấy đạt được trong lĩnh vực nghiên cứu vật lý sinh học khiến mọi người vô cùng ngưỡng mộ dõi theo.',
        'basic',
        1
      ),
      (
        v_id,
        '优秀的导师不仅能为青年学者传授扎实严谨的治学方法，更能以博大宽广的胸怀成就下一代科学领军人才。',
        'Yōuxiù de dǎoshī bùjǐn néng wèi qīngnián xuézhě chuánshòu zhāshi yánjǐn de zhìxué fāngfǎ, gèng néng yǐ bódà kuānguǎng de xiōnghuái chéngjiù xià yí dài kēxué lǐngjūn réncái.',
        'Một người thầy hướng dẫn xuất sắc không chỉ có thể truyền thụ phương pháp học thuật vững vàng nghiêm cẩn cho các học giả trẻ, mà càng có thể lấy tấm lòng bao dung rộng lớn để vun đắp nên thế hệ nhân tài khoa học dẫn đầu tiếp theo.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2141] [成立] (chénglì) - thành lập, sáng lập (tổ chức, công ty); đứng vững (lập luận) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成立' AND pinyin = 'chénglì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成立' AND pinyin = 'chénglì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成立'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成立'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chénglì',
      meaning_vi = 'thành lập, sáng lập (tổ chức, công ty); đứng vững (lập luận)',
      example_hanzi = '这所享有盛誉的高等学府成立于1902年。',
      example_pinyin = 'Zhè suǒ xiǎngyǒu shèngyù de gāoděng xuéfǔ chénglì yú yījiǔlíng’èr nián.',
      example_vi = 'Cơ sở giáo dục đại học danh tiếng lẫy lừng này được thành lập vào năm 1902.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成立',
      'chénglì',
      'thành lập, sáng lập (tổ chức, công ty); đứng vững (lập luận)',
      'Động từ',
      'HSK 5',
      '这所享有盛誉的高等学府成立于1902年。',
      'Zhè suǒ xiǎngyǒu shèngyù de gāoděng xuéfǔ chénglì yú yījiǔlíng’èr nián.',
      'Cơ sở giáo dục đại học danh tiếng lẫy lừng này được thành lập vào năm 1902.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这所享有盛誉的高等学府成立于1902年。',
        'Zhè suǒ xiǎngyǒu shèngyù de gāoděng xuéfǔ chénglì yú yījiǔlíng’èr nián.',
        'Cơ sở giáo dục đại học danh tiếng lẫy lừng này được thành lập vào năm 1902.',
        'basic',
        1
      ),
      (
        v_id,
        '在法律诉讼辩论过程中，原告必须出示确凿充分的客观证据链，否则其提出的侵权赔偿主张在法律上根本无法成立。',
        'Zài fǎlǜ sùsòng biànlùn guòchéng zhōng, yuángào bìxū chūshì quèzáo chōngfèn de kèguān zhèngjù liàn, fǒuzé qí tíchū de qīnquán péicháng zhǔzhāng zài fǎlǜ shàng gēnběn wúfǎ chénglì.',
        'Trong quá trình tranh luận tố tụng pháp luật, nguyên đơn bắt buộc phải xuất trình chuỗi chứng cứ khách quan xác thực đầy đủ, bằng không yêu cầu bồi thường xâm phạm quyền lợi mà họ đưa ra hoàn toàn không thể đứng vững về mặt pháp lý.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2142] [成年] (chéngnián) - trưởng thành, thành niên (đủ tuổi luật định); cả năm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成年' AND pinyin = 'chéngnián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成年' AND pinyin = 'chéngnián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成年'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'chéngnián',
      meaning_vi = 'trưởng thành, thành niên (đủ tuổi luật định); cả năm',
      example_hanzi = '年满十八周岁在法律上被正式认定为成年人。',
      example_pinyin = 'Nián mǎn shíbā zhōusuì zài fǎlǜ shàng bèi zhèngshì rèndìng wéi chéngniánrén.',
      example_vi = 'Tròn mười tám tuổi theo quy định pháp luật được chính thức công nhận là người đã thành niên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成年',
      'chéngnián',
      'trưởng thành, thành niên (đủ tuổi luật định); cả năm',
      'Động từ / Danh từ',
      'HSK 5',
      '年满十八周岁在法律上被正式认定为成年人。',
      'Nián mǎn shíbā zhōusuì zài fǎlǜ shàng bèi zhèngshì rèndìng wéi chéngniánrén.',
      'Tròn mười tám tuổi theo quy định pháp luật được chính thức công nhận là người đã thành niên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '年满十八周岁在法律上被正式认定为成年人。',
        'Nián mǎn shíbā zhōusuì zài fǎlǜ shàng bèi zhèngshì rèndìng wéi chéngniánrén.',
        'Tròn mười tám tuổi theo quy định pháp luật được chính thức công nhận là người đã thành niên.',
        'basic',
        1
      ),
      (
        v_id,
        '未成年人网络保护条例严格限制未成年玩家在工作日的工作时段玩网络游戏，以保障其身心身心健康。',
        'Wèichéngniánrén wǎngluò bǎohù tiáolì yángé xiànzhì wèichéngnián wánjiā zài gōngzuòrì de gōngzuò shíduàn wán wǎngluò yóuxì, yǐ bǎozhàng qí shēnxīn jiànkāng.',
        'Điều lệ bảo vệ người chưa thành niên trên không gian mạng hạn chế nghiêm ngặt người chơi chưa thành niên chơi game online vào các khung giờ ngày làm việc nhằm bảo đảm sức khỏe thể chất và tinh thần của các em.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2143] [城区] (chéngqū) - khu vực nội thành, khu đô thị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '城区' AND pinyin = 'chéngqū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '城区' AND pinyin = 'chéngqū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '城区'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '城区'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngqū',
      meaning_vi = 'khu vực nội thành, khu đô thị',
      example_hanzi = '为改善市民居住环境，市政府大力推进了老城区的老旧小区改造工程。',
      example_pinyin = 'Wèi gǎishàn shìmín jūzhù huánjìng, shì zhèngfǔ dàlì tuījìn le lǎo chéngqū de lǎojiù xiǎoqū gǎizào gōngchéng.',
      example_vi = 'Nhằm cải thiện môi trường sống của người dân, chính quyền thành phố đã ra sức thúc đẩy công trình cải tạo các khu tập thể cũ kỹ ở khu vực nội thành cũ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '城区',
      'chéngqū',
      'khu vực nội thành, khu đô thị',
      'Danh từ',
      'HSK 5',
      '为改善市民居住环境，市政府大力推进了老城区的老旧小区改造工程。',
      'Wèi gǎishàn shìmín jūzhù huánjìng, shì zhèngfǔ dàlì tuījìn le lǎo chéngqū de lǎojiù xiǎoqū gǎizào gōngchéng.',
      'Nhằm cải thiện môi trường sống của người dân, chính quyền thành phố đã ra sức thúc đẩy công trình cải tạo các khu tập thể cũ kỹ ở khu vực nội thành cũ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '为改善市民居住环境，市政府大力推进了老城区的老旧小区改造工程。',
        'Wèi gǎishàn shìmín jūzhù huánjìng, shì zhèngfǔ dàlì tuījìn le lǎo chéngqū de lǎojiù xiǎoqū gǎizào gōngchéng.',
        'Nhằm cải thiện môi trường sống của người dân, chính quyền thành phố đã ra sức thúc đẩy công trình cải tạo các khu tập thể cũ kỹ ở khu vực nội thành cũ.',
        'basic',
        1
      ),
      (
        v_id,
        '随着城市规模的不断外延拓展，连接中心城区与周边卫星城镇的快速轨道交通网正在加紧全线贯通施工。',
        'Suízhe chéngshì guīmó de búduàn wàiyán tuòzhǎn, liánjiē zhōngxīn chéngqū yǔ zhōubiān wèixīng chéngzhèn de kuàisù guǐdào jiāotōng wǎng zhèngzài jiājǐn quánxiàn guàntōng shīgōng.',
        'Cùng với việc quy mô thành phố không ngừng mở rộng ra bên ngoài, mạng lưới đường sắt đô thị nhanh nối liền khu đô thị trung tâm với các thị trấn vệ tinh xung quanh đang được đẩy nhanh thi công thông tuyến toàn tuyến.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2144] [成人] (chéngrén) - người lớn, người trưởng thành; nên người, khôn lớn [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成人' AND pinyin = 'chéngrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成人' AND pinyin = 'chéngrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'chéngrén',
      meaning_vi = 'người lớn, người trưởng thành; nên người, khôn lớn',
      example_hanzi = '有些游乐园的过山车项目刺激性强，仅限成人乘坐。',
      example_pinyin = 'Yǒuxiē yóulèyuán de guòshānchē xiàngmù cìjīxìng qiáng, jǐn xiàn chéngrén chéngzuò.',
      example_vi = 'Một số trò tàu lượn siêu tốc ở công viên giải trí có tính cảm giác mạnh rất cao, chỉ giới hạn cho người lớn đi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成人',
      'chéngrén',
      'người lớn, người trưởng thành; nên người, khôn lớn',
      'Danh từ / Động từ',
      'HSK 5',
      '有些游乐园的过山车项目刺激性强，仅限成人乘坐。',
      'Yǒuxiē yóulèyuán de guòshānchē xiàngmù cìjīxìng qiáng, jǐn xiàn chéngrén chéngzuò.',
      'Một số trò tàu lượn siêu tốc ở công viên giải trí có tính cảm giác mạnh rất cao, chỉ giới hạn cho người lớn đi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '有些游乐园的过山车项目刺激性强，仅限成人乘坐。',
        'Yǒuxiē yóulèyuán de guòshānchē xiàngmù cìjīxìng qiáng, jǐn xiàn chéngrén chéngzuò.',
        'Một số trò tàu lượn siêu tốc ở công viên giải trí có tính cảm giác mạnh rất cao, chỉ giới hạn cho người lớn đi.',
        'basic',
        1
      ),
      (
        v_id,
        '父母辛勤操劳大半辈子把孩子们抚育成人的过程充满艰辛，为人子女应当常怀感恩孝敬之心。',
        'Fùmǔ xīnqín cāoláo dà bàn bèizi bǎ háizimen fǔyù chéngrén de guòchéng chōngmǎn jiānxīn, wéi rén zǐnǚ yīngdāng cháng huái gǎn’ēn xiàojìng zhī xīn.',
        'Cha mẹ vất vả tần tảo hơn nửa đời người nuôi dạy con cái nên người là quá trình ngập tràn gian lao, phận làm con cái phải luôn ghi nhớ tấm lòng biết ơn và hiếu kính.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2145] [承认] (chéngrèn) - thừa nhận, nhận lỗi; công nhận (chính thức) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '承认' AND pinyin = 'chéngrèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '承认' AND pinyin = 'chéngrèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '承认'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '承认'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chéngrèn',
      meaning_vi = 'thừa nhận, nhận lỗi; công nhận (chính thức)',
      example_hanzi = '做错了事情要勇敢承认并诚恳道歉，而不能想方设法找借口推卸责任。',
      example_pinyin = 'Zuò cuò le shìqing yào yǒnggǎn chéngrèn bìng chéngkěn dàoqiàn, ér bù néng xiǎngfāng-shèfǎ zhǎo jièkǒu tuīxiè zérèn.',
      example_vi = 'Làm sai việc gì thì phải dũng cảm thừa nhận và thành khẩn xin lỗi, chứ không thể tìm đủ trăm phương ngàn kế viện cớ đùn đẩy trách nhiệm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '承认',
      'chéngrèn',
      'thừa nhận, nhận lỗi; công nhận (chính thức)',
      'Động từ',
      'HSK 5',
      '做错了事情要勇敢承认并诚恳道歉，而不能想方设法找借口推卸责任。',
      'Zuò cuò le shìqing yào yǒnggǎn chéngrèn bìng chéngkěn dàoqiàn, ér bù néng xiǎngfāng-shèfǎ zhǎo jièkǒu tuīxiè zérèn.',
      'Làm sai việc gì thì phải dũng cảm thừa nhận và thành khẩn xin lỗi, chứ không thể tìm đủ trăm phương ngàn kế viện cớ đùn đẩy trách nhiệm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '做错了事情要勇敢承认并诚恳道歉，而不能想方设法找借口推卸责任。',
        'Zuò cuò le shìqing yào yǒnggǎn chéngrèn bìng chéngkěn dàoqiàn, ér bù néng xiǎngfāng-shèfǎ zhǎo jièkǒu tuīxiè zérèn.',
        'Làm sai việc gì thì phải dũng cảm thừa nhận và thành khẩn xin lỗi, chứ không thể tìm đủ trăm phương ngàn kế viện cớ đùn đẩy trách nhiệm.',
        'basic',
        1
      ),
      (
        v_id,
        '经过严格严密的国际医学同行评议审查，这项源自中国的临床手术创新成果获得了全球外科学界的一致承认与高度赞赏。',
        'Jīngguò yángé yánmì de guójì yīxué tóngháng píngyì shěnchá, zhè xiàng yuánzì Zhōngguó de línchuáng shǒushù chuàngxīn chéngguǒ huòdé le quánqiú wàikē xuéjiè de yízhì chéngrèn yǔ gāodù zànshǎng.',
        'Qua quá trình thẩm định bình duyệt đồng đẳng y học quốc tế nghiêm ngặt chặt chẽ, thành quả sáng tạo phẫu thuật lâm sàng bắt nguồn từ Trung Quốc này đã nhận được sự công nhận nhất trí và đánh giá cao từ giới ngoại khoa toàn cầu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2146] [承受] (chéngshòu) - chịu đựng, gánh chịu (áp lực, sức nặng, nỗi đau khổ) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '承受' AND pinyin = 'chéngshòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '承受' AND pinyin = 'chéngshòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '承受'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '承受'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chéngshòu',
      meaning_vi = 'chịu đựng, gánh chịu (áp lực, sức nặng, nỗi đau khổ)',
      example_hanzi = '在面临考试和求职的双重挑战时，年轻人要学会自我调节以承受各种压力。',
      example_pinyin = 'Zài miànlín kǎoshì hé qiúzhí de shuāngchóng tiǎozhàn shí, niánqīngrén yào xuéhuì zìwǒ tiáojié yǐ chéngshòu gè zhǒng yālì.',
      example_vi = 'Khi đối mặt với thách thức kép giữa thi cử và tìm việc làm, người trẻ cần học cách tự điều chỉnh tâm lý để chịu đựng các loại áp lực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '承受',
      'chéngshòu',
      'chịu đựng, gánh chịu (áp lực, sức nặng, nỗi đau khổ)',
      'Động từ',
      'HSK 5',
      '在面临考试和求职的双重挑战时，年轻人要学会自我调节以承受各种压力。',
      'Zài miànlín kǎoshì hé qiúzhí de shuāngchóng tiǎozhàn shí, niánqīngrén yào xuéhuì zìwǒ tiáojié yǐ chéngshòu gè zhǒng yālì.',
      'Khi đối mặt với thách thức kép giữa thi cử và tìm việc làm, người trẻ cần học cách tự điều chỉnh tâm lý để chịu đựng các loại áp lực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在面临考试和求职的双重挑战时，年轻人要学会自我调节以承受各种压力。',
        'Zài miànlín kǎoshì hé qiúzhí de shuāngchóng tiǎozhàn shí, niánqīngrén yào xuéhuì zìwǒ tiáojié yǐ chéngshòu gè zhǒng yālì.',
        'Khi đối mặt với thách thức kép giữa thi cử và tìm việc làm, người trẻ cần học cách tự điều chỉnh tâm lý để chịu đựng các loại áp lực.',
        'basic',
        1
      ),
      (
        v_id,
        '新建跨海悬索大桥的主缆钢索能够承受数十万吨的巨大拉力，确保百年大桥在强台风袭击下的绝对安全稳固。',
        'Xīnjiàn kuàhǎi xuánsuǒ dàqiáo de zhǔlǎn gāngsuǒ nénggòu chéngshòu shù shí wàn dūn de jùdà lālì, quèbǎo bǎi nián dàqiáo zài qiáng táifēng xíjī xià de juéduì ānquán wěngù.',
        'Dây cáp thép treo chủ lực của cây cầu dây võng vượt biển mới xây có thể chịu đựng được sức kéo khổng lồ lên tới hàng trăm nghìn tấn, đảm bảo cây cầu trăm năm vững chãi tuyệt đối an toàn dưới sự càn quét của bão mạnh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2147] [成熟] (chéngshú) - chín (trái cây, lúa); chín chắn, thành thục, hoàn thiện (tính cách, công nghệ) [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成熟' AND pinyin = 'chéngshú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成熟' AND pinyin = 'chéngshú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成熟'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成熟'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'chéngshú',
      meaning_vi = 'chín (trái cây, lúa); chín chắn, thành thục, hoàn thiện (tính cách, công nghệ)',
      example_hanzi = '秋天到了，果园里的苹果和葡萄都成熟了，散发出诱人的果香。',
      example_pinyin = 'Qiūtiān dào le, guǒyuán lǐ de píngguǒ hé pútao dōu chéngshú le, sànfā chū yòurén de guǒxiāng.',
      example_vi = 'Mùa thu tới rồi, táo và nho trong vườn quả đều đã chín rộ, tỏa ra hương thơm hoa quả mời gọi quyến rũ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成熟',
      'chéngshú',
      'chín (trái cây, lúa); chín chắn, thành thục, hoàn thiện (tính cách, công nghệ)',
      'Tính từ / Động từ',
      'HSK 5',
      '秋天到了，果园里的苹果和葡萄都成熟了，散发出诱人的果香。',
      'Qiūtiān dào le, guǒyuán lǐ de píngguǒ hé pútao dōu chéngshú le, sànfā chū yòurén de guǒxiāng.',
      'Mùa thu tới rồi, táo và nho trong vườn quả đều đã chín rộ, tỏa ra hương thơm hoa quả mời gọi quyến rũ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '秋天到了，果园里的苹果和葡萄都成熟了，散发出诱人的果香。',
        'Qiūtiān dào le, guǒyuán lǐ de píngguǒ hé pútao dōu chéngshú le, sànfā chū yòurén de guǒxiāng.',
        'Mùa thu tới rồi, táo và nho trong vườn quả đều đã chín rộ, tỏa ra hương thơm hoa quả mời gọi quyến rũ.',
        'basic',
        1
      ),
      (
        v_id,
        '随着第五代移动通信技术的日益成熟与全产业链深度商业化应用，工业互联网迎来了爆发式的发展机遇。',
        'Suízhe dì-wǔ dài yídòng tōngxìn jìshù de rìyì chéngshú yǔ quán chǎnyèliàn shēndù shāngyèhuà yìngyòng, gōngyè hùliánwǎng yínglái le bàofāshì de fāzhǎn jīyù.',
        'Cùng với sự ngày càng hoàn thiện chín muồi của công nghệ thông tin di động thế hệ thứ 5 (5G) và ứng dụng thương mại hóa sâu rộng trên toàn chuỗi ngành nghề, internet công nghiệp đã đón chào cơ hội phát triển bùng nổ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2148] [乘务员] (chéngwùyuán) - tiếp viên, nhân viên phục vụ (trên máy bay, tàu hỏa cao tốc) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '乘务员' AND pinyin = 'chéngwùyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乘务员' AND pinyin = 'chéngwùyuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '乘务员'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乘务员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngwùyuán',
      meaning_vi = 'tiếp viên, nhân viên phục vụ (trên máy bay, tàu hỏa cao tốc)',
      example_hanzi = '飞机上的乘务员微笑着为每一位乘客递送饮料和毛毯。',
      example_pinyin = 'Fēijī shàng de chéngwùyuán wēixiào zhe wèi měi yí wèi chéngkè dìsòng yǐnliào hé máotǎn.',
      example_vi = 'Tiếp viên trên máy bay mỉm cười mang đồ uống và chăn đắp đến cho từng hành khách.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '乘务员',
      'chéngwùyuán',
      'tiếp viên, nhân viên phục vụ (trên máy bay, tàu hỏa cao tốc)',
      'Danh từ',
      'HSK 5',
      '飞机上的乘务员微笑着为每一位乘客递送饮料和毛毯。',
      'Fēijī shàng de chéngwùyuán wēixiào zhe wèi měi yí wèi chéngkè dìsòng yǐnliào hé máotǎn.',
      'Tiếp viên trên máy bay mỉm cười mang đồ uống và chăn đắp đến cho từng hành khách.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '飞机上的乘务员微笑着为每一位乘客递送饮料和毛毯。',
        'Fēijī shàng de chéngwùyuán wēixiào zhe wèi měi yí wèi chéngkè dìsòng yǐnliào hé máotǎn.',
        'Tiếp viên trên máy bay mỉm cười mang đồ uống và chăn đắp đến cho từng hành khách.',
        'basic',
        1
      ),
      (
        v_id,
        '高铁列车乘务员在旅途中不仅要熟练掌握多门外语与急救技能，还要时刻密切关注老弱病残孕重点旅客的特殊出行需求。',
        'Gāotiě lièchē chéngwùyuán zài lǚtú zhōng bùjǐn yào shúliàn zhǎngwò duō mén wàiyǔ yǔ jíjiù jìnéng, hái yào shíkè mìqiè guānzhù lǎoruò-bìngcán-yùn zhòngdiǎn lǚkè de tèshū chūxíng xūqiú.',
        'Tiếp viên tàu hỏa cao tốc trong suốt hành trình không chỉ phải nắm vững thành thạo nhiều ngoại ngữ và kỹ năng sơ cấp cứu, mà còn phải luôn dõi theo sát sao nhu cầu đi lại đặc biệt của các hành khách trọng điểm như người già, trẻ nhỏ, người bệnh, người khuyết tật và phụ nữ mang thai.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2149] [程序] (chéngxù) - trình tự, quy trình thủ tục; chương trình phần mềm máy tính [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '程序' AND pinyin = 'chéngxù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '程序' AND pinyin = 'chéngxù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '程序'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '程序'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngxù',
      meaning_vi = 'trình tự, quy trình thủ tục; chương trình phần mềm máy tính',
      example_hanzi = '办理护照和签证必须严格按照官方规定的法律程序进行申请。',
      example_pinyin = 'Bànlǐ hùzhào hé qiānzhèng bìxū yángé ànzhào guānfāng guīdìng de fǎlǜ chéngxù jìnxíng shēnqǐng.',
      example_vi = 'Làm hộ chiếu và thị thực bắt buộc phải tiến hành nộp đơn theo đúng trình tự thủ tục pháp luật mà cơ quan chức năng quy định.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '程序',
      'chéngxù',
      'trình tự, quy trình thủ tục; chương trình phần mềm máy tính',
      'Danh từ',
      'HSK 5',
      '办理护照和签证必须严格按照官方规定的法律程序进行申请。',
      'Bànlǐ hùzhào hé qiānzhèng bìxū yángé ànzhào guānfāng guīdìng de fǎlǜ chéngxù jìnxíng shēnqǐng.',
      'Làm hộ chiếu và thị thực bắt buộc phải tiến hành nộp đơn theo đúng trình tự thủ tục pháp luật mà cơ quan chức năng quy định.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '办理护照和签证必须严格按照官方规定的法律程序进行申请。',
        'Bànlǐ hùzhào hé qiānzhèng bìxū yángé ànzhào guānfāng guīdìng de fǎlǜ chéngxù jìnxíng shēnqǐng.',
        'Làm hộ chiếu và thị thực bắt buộc phải tiến hành nộp đơn theo đúng trình tự thủ tục pháp luật mà cơ quan chức năng quy định.',
        'basic',
        1
      ),
      (
        v_id,
        '资深软件架构师正在对这款大型金融交易后台的核心代码程序进行高并发与高可用性能优化。',
        'Zīshēn ruǎnjiàn jiàgòushī zhèngzài duì zhè kuǎn dàxíng jīnróng jiāoyì hòutái de héxīn dàimǎ chéngxù jìnxíng gāo bīngfā yǔ gāo kěyòng xìngnéng yōuhuà.',
        'Kiến trúc sư phần mềm kỳ cựu đang tiến hành tối ưu hóa hiệu năng chịu tải đồng thời cao và tính sẵn sàng cao cho chương trình mã nguồn cốt lõi của hệ thống backend giao dịch tài chính quy mô lớn này.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2150] [成员] (chéngyuán) - thành viên (trong gia đình, tổ chức, nhóm, câu lạc bộ) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成员' AND pinyin = 'chéngyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成员' AND pinyin = 'chéngyuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成员'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngyuán',
      meaning_vi = 'thành viên (trong gia đình, tổ chức, nhóm, câu lạc bộ)',
      example_hanzi = '周末所有的家庭成员都聚在一起吃团圆饭。',
      example_pinyin = 'Zhōumò suǒyǒu de jiātíng chéngyuán dōu jù zài yìqǐ chī tuányuánfàn.',
      example_vi = 'Cuối tuần tất cả các thành viên trong gia đình đều quây quần bên nhau ăn bữa cơm đoàn viên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成员',
      'chéngyuán',
      'thành viên (trong gia đình, tổ chức, nhóm, câu lạc bộ)',
      'Danh từ',
      'HSK 5',
      '周末所有的家庭成员都聚在一起吃团圆饭。',
      'Zhōumò suǒyǒu de jiātíng chéngyuán dōu jù zài yìqǐ chī tuányuánfàn.',
      'Cuối tuần tất cả các thành viên trong gia đình đều quây quần bên nhau ăn bữa cơm đoàn viên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '周末所有的家庭成员都聚在一起吃团圆饭。',
        'Zhōumò suǒyǒu de jiātíng chéngyuán dōu jù zài yìqǐ chī tuányuánfàn.',
        'Cuối tuần tất cả các thành viên trong gia đình đều quây quần bên nhau ăn bữa cơm đoàn viên.',
        'basic',
        1
      ),
      (
        v_id,
        '作为联合国安理会常任理事国成员，中国积极参与国际热点维和行动，坚定维护世界和平与发展。',
        'Zuòwéi Liánhéguó Ānlǐhuì chángrèn lǐshìguó chéngyuán, Zhōngguó jījí cānyù guójì rèdiǎn wéihé xíngdòng, jiāndìng wéihù shìjiè hépíng yǔ fāzhǎn.',
        'Với tư cách là thành viên thường trực Hội đồng Bảo an Liên Hợp Quốc, Trung Quốc tích cực tham gia các hoạt động gìn giữ hòa bình tại các điểm nóng quốc tế, kiên định bảo vệ hòa bình và phát triển trên thế giới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2151] [成长] (chéngzhǎng) - lớn lên, trưởng thành, phát triển khôn lớn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '成长' AND pinyin = 'chéngzhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成长' AND pinyin = 'chéngzhǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '成长'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '成长'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'chéngzhǎng',
      meaning_vi = 'lớn lên, trưởng thành, phát triển khôn lớn',
      example_hanzi = '良好的家庭教育环境有助于孩子健康快乐地成长。',
      example_pinyin = 'Liánghǎo de jiātíng jiàoyù huánjìng yǒuzhùyú háizi jiànkāng kuàilè de chéngzhǎng.',
      example_vi = 'Môi trường giáo dục gia đình tốt đẹp có lợi cho sự trưởng thành vui vẻ và khỏe mạnh của trẻ nhỏ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '成长',
      'chéngzhǎng',
      'lớn lên, trưởng thành, phát triển khôn lớn',
      'Động từ / Danh từ',
      'HSK 5',
      '良好的家庭教育环境有助于孩子健康快乐地成长。',
      'Liánghǎo de jiātíng jiàoyù huánjìng yǒuzhùyú háizi jiànkāng kuàilè de chéngzhǎng.',
      'Môi trường giáo dục gia đình tốt đẹp có lợi cho sự trưởng thành vui vẻ và khỏe mạnh của trẻ nhỏ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '良好的家庭教育环境有助于孩子健康快乐地成长。',
        'Liánghǎo de jiātíng jiàoyù huánjìng yǒuzhùyú háizi jiànkāng kuàilè de chéngzhǎng.',
        'Môi trường giáo dục gia đình tốt đẹp có lợi cho sự trưởng thành vui vẻ và khỏe mạnh của trẻ nhỏ.',
        'basic',
        1
      ),
      (
        v_id,
        '青年员工在经历多岗位实战轮岗与急难险重任务的磨砺中，迅速成长为能够独当一面的业务骨干。',
        'Qīngnián yuángōng zài jīnglì duō gǎngwèi shízhàn lúngǎng yǔ jínánxiǎnzhòng rènwu de mólì zhōng, xùnsù chéngzhǎng wéi nénggòu dídāng-yímiàn de yèwù gǔgàn.',
        'Cán bộ nhân viên trẻ qua quá trình tôi luyện luân chuyển nhiều vị trí thực chiến và đảm nhận các nhiệm vụ gian khổ khẩn cấp, đã nhanh chóng trưởng thành thành cán bộ nòng cốt nghiệp vụ có thể độc lập gánh vác một phương.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2152] [橙子] (chéngzi) - quả cam, trái cam [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '橙子' AND pinyin = 'chéngzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '橙子' AND pinyin = 'chéngzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '橙子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '橙子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chéngzi',
      meaning_vi = 'quả cam, trái cam',
      example_hanzi = '新鲜的橙子富含维生素C，酸甜多汁，老少皆宜。',
      example_pinyin = 'Xīnxiān de chéngzi fùhán wéishēngsù C, suāntián duōzhī, lǎoshào-jiēyí.',
      example_vi = 'Những quả cam tươi giàu vitamin C, chua ngọt mọng nước, già trẻ đều thích ăn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '橙子',
      'chéngzi',
      'quả cam, trái cam',
      'Danh từ',
      'HSK 5',
      '新鲜的橙子富含维生素C，酸甜多汁，老少皆宜。',
      'Xīnxiān de chéngzi fùhán wéishēngsù C, suāntián duōzhī, lǎoshào-jiēyí.',
      'Những quả cam tươi giàu vitamin C, chua ngọt mọng nước, già trẻ đều thích ăn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '新鲜的橙子富含维生素C，酸甜多汁，老少皆宜。',
        'Xīnxiān de chéngzi fùhán wéishēngsù C, suāntián duōzhī, lǎoshào-jiēyí.',
        'Những quả cam tươi giàu vitamin C, chua ngọt mọng nước, già trẻ đều thích ăn.',
        'basic',
        1
      ),
      (
        v_id,
        '当地农民通过引进智能化滴灌与生态培育技术种植优质脐橙，把金灿灿的橙子打造成了带动全村脱贫致富的特色地理标志品牌。',
        'Dāngdì nóngmín tōngguò yǐnjìn zhìnénghuà dīguàn yǔ shēngtài péiyù jìshù zhòngzhí yōuzhì qíchéng, bǎ jīncàncàn de chéngzi dǎzào chéng le dàidòng quán cūn tuōpín-zhìfù de tèsè dìlǐ biāozhì pǐnpái.',
        'Nông dân địa phương thông qua đưa vào kỹ thuật tưới nhỏ giọt thông minh và nuôi trồng sinh thái để trồng cam rốn chất lượng cao, đã biến những quả cam vàng óng thành thương hiệu chỉ dẫn địa lý đặc sản dẫn dắt cả làng thoát nghèo làm giàu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2153] [池] (chí) - ao, hồ nước, bể chứa nước (như trong chízi, yóuyǒngchí, shuǐchí) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '池' AND pinyin = 'chí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '池' AND pinyin = 'chí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '池'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '池'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chí',
      meaning_vi = 'ao, hồ nước, bể chứa nước (như trong chízi, yóuyǒngchí, shuǐchí)',
      example_hanzi = '公园的荷花池里盛开着美丽的粉色荷花，几条红金鱼在水草间欢快游动。',
      example_pinyin = 'Gōngyuán de héhuāchí lǐ shèngkāi zhe měilì de fěnsè héhuā, jǐ tiáo hóng jīnyú zài shuǐcǎo jiān huānkuài yóudòng.',
      example_vi = 'Trong hồ hoa sen của công viên đang nở rộ những bông sen hồng xinh đẹp, vài chú cá vàng bơi lội tung tăng giữa đám rong nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '池',
      'chí',
      'ao, hồ nước, bể chứa nước (như trong chízi, yóuyǒngchí, shuǐchí)',
      'Danh từ',
      'HSK 5',
      '公园的荷花池里盛开着美丽的粉色荷花，几条红金鱼在水草间欢快游动。',
      'Gōngyuán de héhuāchí lǐ shèngkāi zhe měilì de fěnsè héhuā, jǐ tiáo hóng jīnyú zài shuǐcǎo jiān huānkuài yóudòng.',
      'Trong hồ hoa sen của công viên đang nở rộ những bông sen hồng xinh đẹp, vài chú cá vàng bơi lội tung tăng giữa đám rong nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '公园的荷花池里盛开着美丽的粉色荷花，几条红金鱼在水草间欢快游动。',
        'Gōngyuán de héhuāchí lǐ shèngkāi zhe měilì de fěnsè héhuā, jǐ tiáo hóng jīnyú zài shuǐcǎo jiān huānkuài yóudòng.',
        'Trong hồ hoa sen của công viên đang nở rộ những bông sen hồng xinh đẹp, vài chú cá vàng bơi lội tung tăng giữa đám rong nước.',
        'basic',
        1
      ),
      (
        v_id,
        '污水处理厂采用现代多级沉淀过滤与生物降解技术，在大型净化调节池中实现工业污水的深度无害化循环利用。',
        'Wūshuǐ chǔlǐchǎng cǎiyòng xiàndài duōjí chéndiàn guòlǜ yǔ shēngwù jiàngjiě jìshù, zài dàxíng jìnghuà tiáojiéchí zhōng shíxiàn gōngyè wūshuǐ de shēndù wúhàihuà xúnhuán lìyòng.',
        'Nhà máy xử lý nước thải sử dụng công nghệ lắng đọng lọc nhiều cấp và phân hủy sinh học hiện đại, thực hiện tuần hoàn tái sử dụng vô hại hóa chuyên sâu nước thải công nghiệp ngay trong bể điều hòa lọc lớn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2154] [持续] (chíxù) - tiếp tục, kéo dài liên tục không ngắt quãng [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '持续' AND pinyin = 'chíxù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '持续' AND pinyin = 'chíxù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '持续'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '持续'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Phó từ',
      pinyin = 'chíxù',
      meaning_vi = 'tiếp tục, kéo dài liên tục không ngắt quãng',
      example_hanzi = '这场大雨已经持续下了整整三天三夜。',
      example_pinyin = 'Zhè chǎng dàyǔ yǐjīng chíxù xià le zhěngzhěng sān tiān sān yè.',
      example_vi = 'Trận mưa lớn này đã kéo dài trọn vẹn suốt ba ngày ba đêm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '持续',
      'chíxù',
      'tiếp tục, kéo dài liên tục không ngắt quãng',
      'Động từ / Phó từ',
      'HSK 5',
      '这场大雨已经持续下了整整三天三夜。',
      'Zhè chǎng dàyǔ yǐjīng chíxù xià le zhěngzhěng sān tiān sān yè.',
      'Trận mưa lớn này đã kéo dài trọn vẹn suốt ba ngày ba đêm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这场大雨已经持续下了整整三天三夜。',
        'Zhè chǎng dàyǔ yǐjīng chíxù xià le zhěngzhěng sān tiān sān yè.',
        'Trận mưa lớn này đã kéo dài trọn vẹn suốt ba ngày ba đêm.',
        'basic',
        1
      ),
      (
        v_id,
        '国家坚持创新驱动发展理念，持续加大对基础科学研究与前沿高新技术领域的财政支持力度，以实现经济社会绿色可持续发展。',
        'Guójiā jiānchí chuàngxīn qūdòng fāzhǎn lǐniàn, chíxù jiàdà duì jīchǔ kēxué yánjiū yǔ qiányán gāoxīn jìshù lǐngyù de cáizhèng zhīchí lìdù, yǐ shíxiàn jīngjì shèhuì lǜsè kěchíxù fāzhǎn.',
        'Nhà nước kiên trì quan điểm phát triển lấy đổi mới sáng tạo làm động lực, liên tục gia tăng mức độ hỗ trợ tài chính cho nghiên cứu khoa học cơ bản và các lĩnh vực công nghệ cao tiên phong, nhằm hiện thực hóa sự phát triển xanh bền vững của kinh tế xã hội.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2155] [尺子] (chǐzi) - cái thước, thước đo (độ dài, góc) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '尺子' AND pinyin = 'chǐzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尺子' AND pinyin = 'chǐzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '尺子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尺子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chǐzi',
      meaning_vi = 'cái thước, thước đo (độ dài, góc)',
      example_hanzi = '数学课上画几何图形时，要用尺子把线条画笔直。',
      example_pinyin = 'Shùxuékè shàng huà jǐhé túxíng shí, yào yòng chǐzi bǎ xiàntiáo huà bǐzhí.',
      example_vi = 'Khi vẽ hình học trong tiết toán, cần dùng thước kẻ để vẽ các đường nét thật thẳng thắn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '尺子',
      'chǐzi',
      'cái thước, thước đo (độ dài, góc)',
      'Danh từ',
      'HSK 5',
      '数学课上画几何图形时，要用尺子把线条画笔直。',
      'Shùxuékè shàng huà jǐhé túxíng shí, yào yòng chǐzi bǎ xiàntiáo huà bǐzhí.',
      'Khi vẽ hình học trong tiết toán, cần dùng thước kẻ để vẽ các đường nét thật thẳng thắn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '数学课上画几何图形时，要用尺子把线条画笔直。',
        'Shùxuékè shàng huà jǐhé túxíng shí, yào yòng chǐzi bǎ xiàntiáo huà bǐzhí.',
        'Khi vẽ hình học trong tiết toán, cần dùng thước kẻ để vẽ các đường nét thật thẳng thắn.',
        'basic',
        1
      ),
      (
        v_id,
        '裁缝师傅手里握着一把软尺，极其细致严谨地为前来进行高级西装定制的客人测量身形尺寸。',
        'Cáifeng shīfu shǒulǐ wò zhe yì bǎ ruǎnchǐ, jíqí xìzhì yánjǐn de wèi qiánlái jìnxíng gāojí xīzhuāng dìngzhì de kèrén cèliáng shēnxíng chǐcun.',
        'Bác thợ may cầm trên tay chiếc thước dây mềm, đo đạc kích thước phom dáng cực kỳ tỉ mỉ cẩn trọng cho vị khách đến may đo âu phục cao cấp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2156] [翅膀] (chìbǎng) - đôi cánh (của chim, côn trùng, máy bay) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '翅膀' AND pinyin = 'chìbǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '翅膀' AND pinyin = 'chìbǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '翅膀'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '翅膀'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chìbǎng',
      meaning_vi = 'đôi cánh (của chim, côn trùng, máy bay)',
      example_hanzi = '受伤的小鸟在好心人的精心照顾下终于康复，张开翅膀飞向了蓝天。',
      example_pinyin = 'Shòushāng de xiǎoniǎo zài hǎoxīnrén de jīngxīn zhàogù xià zhōngyú kāngfù, zhāngkāi chìbǎng fēi xiàng le lántiān.',
      example_vi = 'Chú chim non bị thương dưới sự chăm sóc ân cần của người tốt bụng cuối cùng đã bình phục, dang rộng đôi cánh bay vút lên bầu trời xanh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '翅膀',
      'chìbǎng',
      'đôi cánh (của chim, côn trùng, máy bay)',
      'Danh từ',
      'HSK 5',
      '受伤的小鸟在好心人的精心照顾下终于康复，张开翅膀飞向了蓝天。',
      'Shòushāng de xiǎoniǎo zài hǎoxīnrén de jīngxīn zhàogù xià zhōngyú kāngfù, zhāngkāi chìbǎng fēi xiàng le lántiān.',
      'Chú chim non bị thương dưới sự chăm sóc ân cần của người tốt bụng cuối cùng đã bình phục, dang rộng đôi cánh bay vút lên bầu trời xanh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '受伤的小鸟在好心人的精心照顾下终于康复，张开翅膀飞向了蓝天。',
        'Shòushāng de xiǎoniǎo zài hǎoxīnrén de jīngxīn zhàogù xià zhōngyú kāngfù, zhāngkāi chìbǎng fēi xiàng le lántiān.',
        'Chú chim non bị thương dưới sự chăm sóc ân cần của người tốt bụng cuối cùng đã bình phục, dang rộng đôi cánh bay vút lên bầu trời xanh.',
        'basic',
        1
      ),
      (
        v_id,
        '科技创新宛如为现代农业插上了腾飞的翅膀，无人机遥感巡田与智能自动化灌溉彻底改变了传统耕作模式。',
        'Kējì chuàngxīn wǎnrú wèi xiàndài nóngyè chā shàng le téngfēi de chìbǎng, wúrénjī yáogǎn xúntián yǔ zhìnéng zìdònghuà guàngài chèdǐ gǎibiàn le chuántǒng gēngzuò móshì.',
        'Đổi mới khoa học công nghệ tựa như chắp thêm đôi cánh tung bay cho nền nông nghiệp hiện đại, việc dùng máy bay không người lái viễn thám tuần tra ruộng đồng và tưới tiêu tự động hóa thông minh đã thay đổi triệt để phương thức canh tác truyền thống.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2157] [冲] (chōng) - lao về phía trước, xông lên; xối, tráng, pha (nước, trà, cà phê) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '冲' AND pinyin = 'chōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '冲' AND pinyin = 'chōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '冲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '冲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chōng',
      meaning_vi = 'lao về phía trước, xông lên; xối, tráng, pha (nước, trà, cà phê)',
      example_hanzi = '工作累了的时候，他喜欢冲一杯香浓的热咖啡提神。',
      example_pinyin = 'Gōngzuò lèi le de shíhou, tā xǐhuan chōng yì bēi xiāngnóng de rè kāfēi tíshén.',
      example_vi = 'Những lúc làm việc mệt mỏi, anh ấy thích pha một ly cà phê nóng thơm nồng để lấy lại tinh thần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '冲',
      'chōng',
      'lao về phía trước, xông lên; xối, tráng, pha (nước, trà, cà phê)',
      'Động từ',
      'HSK 5',
      '工作累了的时候，他喜欢冲一杯香浓的热咖啡提神。',
      'Gōngzuò lèi le de shíhou, tā xǐhuan chōng yì bēi xiāngnóng de rè kāfēi tíshén.',
      'Những lúc làm việc mệt mỏi, anh ấy thích pha một ly cà phê nóng thơm nồng để lấy lại tinh thần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '工作累了的时候，他喜欢冲一杯香浓的热咖啡提神。',
        'Gōngzuò lèi le de shíhou, tā xǐhuan chōng yì bēi xiāngnóng de rè kāfēi tíshén.',
        'Những lúc làm việc mệt mỏi, anh ấy thích pha một ly cà phê nóng thơm nồng để lấy lại tinh thần.',
        'basic',
        1
      ),
      (
        v_id,
        '在发生特大森林火灾的危急关头，英勇的消防指战员不顾个人安危，冒着滚滚浓烟和冲天大火毅然冲进火场实施扑救救援。',
        'Zài fāshēng tèdà sēnlín huǒzāi de wēijí guāntóu, yīngyǒng de xiāofáng zhǐzhànyuán búgù gèrén ānwēi, mào zhe gǔngǔn nóngyān hé chōngtiān dàhuǒ yìrán chōng jìn huǒchǎng shíshī pūjiù jiùyuán.',
        'Trong thời khắc nguy cấp khi xảy ra trận cháy rừng đặc biệt lớn, các cán bộ chiến sĩ phòng cháy chữa cháy anh dũng không màng an nguy cá nhân, đội làn khói dày đặc cuồn cuộn và ngọn lửa ngút trời kiên quyết xông vào biển lửa để tiến hành dập lửa cứu nạn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2158] [充电] (chōngdiàn) - sạc điện, nạp pin; học tập thêm để bồi dưỡng kiến thức [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '充电' AND pinyin = 'chōngdiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充电' AND pinyin = 'chōngdiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '充电'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充电'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chōngdiàn',
      meaning_vi = 'sạc điện, nạp pin; học tập thêm để bồi dưỡng kiến thức',
      example_hanzi = '手机电量只剩百分之十了，我得赶紧插上电源充电。',
      example_pinyin = 'Shǒujī diànliàng zhǐ shèng bǎifēnzhī shí le, wǒ děi gǎnjǐn chā shàng diànyuán chōngdiàn.',
      example_vi = 'Pin điện thoại chỉ còn lại mười phần trăm thôi, tôi phải mau chóng cắm sạc vào nguồn điện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '充电',
      'chōngdiàn',
      'sạc điện, nạp pin; học tập thêm để bồi dưỡng kiến thức',
      'Động từ',
      'HSK 5',
      '手机电量只剩百分之十了，我得赶紧插上电源充电。',
      'Shǒujī diànliàng zhǐ shèng bǎifēnzhī shí le, wǒ děi gǎnjǐn chā shàng diànyuán chōngdiàn.',
      'Pin điện thoại chỉ còn lại mười phần trăm thôi, tôi phải mau chóng cắm sạc vào nguồn điện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '手机电量只剩百分之十了，我得赶紧插上电源充电。',
        'Shǒujī diànliàng zhǐ shèng bǎifēnzhī shí le, wǒ děi gǎnjǐn chā shàng diànyuán chōngdiàn.',
        'Pin điện thoại chỉ còn lại mười phần trăm thôi, tôi phải mau chóng cắm sạc vào nguồn điện.',
        'basic',
        1
      ),
      (
        v_id,
        '面对日新月异的技术变革，职场人士利用业余周末时间主动报班学习前沿技能，为自己及时“充电”赋能。',
        'Miànduì rìxīn-yuèyì de jìshù biàngé, zhíchǎng rénshì lìyòng yèyú zhōumò shíjiān zhǔdòng bào bān xuéxí qiányán jìnéng, wèi zìjǐ jíshí “chōngdiàn” fùnéng.',
        'Đối mặt với sự biến đổi công nghệ đổi thay từng ngày từng tháng, người đi làm tận dụng thời gian rảnh rỗi cuối tuần chủ động đăng ký các lớp học kỹ năng tiên phong, kịp thời “sạc pin” tiếp thêm năng lực cho chính mình.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2159] [充分] (chōngfèn) - đầy đủ, sung túc; phát huy tối đa hết mức [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '充分' AND pinyin = 'chōngfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充分' AND pinyin = 'chōngfèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '充分'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充分'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'chōngfèn',
      meaning_vi = 'đầy đủ, sung túc; phát huy tối đa hết mức',
      example_hanzi = '在参加重要面试之前，一定要做好充分的思想和专业准备。',
      example_pinyin = 'Zài cānjiā zhòngyào miànshì zhīqián, yídìng yào zuò hǎo chōngfèn de sīxiǎng hé zhuānyè zhǔnbèi.',
      example_vi = 'Trước khi tham gia buổi phỏng vấn quan trọng, nhất định phải làm tốt sự chuẩn bị đầy đủ về tư tưởng và chuyên môn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '充分',
      'chōngfèn',
      'đầy đủ, sung túc; phát huy tối đa hết mức',
      'Tính từ / Phó từ',
      'HSK 5',
      '在参加重要面试之前，一定要做好充分的思想和专业准备。',
      'Zài cānjiā zhòngyào miànshì zhīqián, yídìng yào zuò hǎo chōngfèn de sīxiǎng hé zhuānyè zhǔnbèi.',
      'Trước khi tham gia buổi phỏng vấn quan trọng, nhất định phải làm tốt sự chuẩn bị đầy đủ về tư tưởng và chuyên môn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在参加重要面试之前，一定要做好充分的思想和专业准备。',
        'Zài cānjiā zhòngyào miànshì zhīqián, yídìng yào zuò hǎo chōngfèn de sīxiǎng hé zhuānyè zhǔnbèi.',
        'Trước khi tham gia buổi phỏng vấn quan trọng, nhất định phải làm tốt sự chuẩn bị đầy đủ về tư tưởng và chuyên môn.',
        'basic',
        1
      ),
      (
        v_id,
        '企业唯有充分利用现代大数据分析工具挖掘潜在客户需求，才能在细分市场竞争中抢占发展先机。',
        'Qǐyè wéi yǒu chōngfèn lìyòng xiàndài dàshùjù fēnxī gōngjù wājué qiánzài kèhù xūqiú, cái néng zài xìfēn shìchǎng jìngzhēng zhōng qiǎngzhàn fāzhǎn xiānjī.',
        'Doanh nghiệp chỉ khi tận dụng triệt để tối đa các công cụ phân tích dữ liệu lớn hiện đại để khai thác nhu cầu của khách hàng tiềm năng thì mới có thể chiếm lĩnh tiên cơ phát triển trong cuộc cạnh tranh thị trường ngách.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2160] [充满] (chōngmǎn) - tràn ngập, đầy ắp (niềm tin, hy vọng, năng lượng, tiếng cười) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '充满' AND pinyin = 'chōngmǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充满' AND pinyin = 'chōngmǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '充满'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充满'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chōngmǎn',
      meaning_vi = 'tràn ngập, đầy ắp (niềm tin, hy vọng, năng lượng, tiếng cười)',
      example_hanzi = '看到孩子们天真无邪的笑脸，整个教室里充满了欢声笑语。',
      example_pinyin = 'Kàndào háizimen tiānzhēn-wúxié de xiàoliǎn, zhěnggè jiàoshì lǐ chōngmǎn le huānshēng-xiàoyǔ.',
      example_vi = 'Nhìn thấy khuôn mặt tươi cười ngây thơ trong sáng của các em nhỏ, toàn bộ lớp học tràn ngập tiếng cười nói rộn rã.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '充满',
      'chōngmǎn',
      'tràn ngập, đầy ắp (niềm tin, hy vọng, năng lượng, tiếng cười)',
      'Động từ',
      'HSK 5',
      '看到孩子们天真无邪的笑脸，整个教室里充满了欢声笑语。',
      'Kàndào háizimen tiānzhēn-wúxié de xiàoliǎn, zhěnggè jiàoshì lǐ chōngmǎn le huānshēng-xiàoyǔ.',
      'Nhìn thấy khuôn mặt tươi cười ngây thơ trong sáng của các em nhỏ, toàn bộ lớp học tràn ngập tiếng cười nói rộn rã.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '看到孩子们天真无邪的笑脸，整个教室里充满了欢声笑语。',
        'Kàndào háizimen tiānzhēn-wúxié de xiàoliǎn, zhěnggè jiàoshì lǐ chōngmǎn le huānshēng-xiàoyǔ.',
        'Nhìn thấy khuôn mặt tươi cười ngây thơ trong sáng của các em nhỏ, toàn bộ lớp học tràn ngập tiếng cười nói rộn rã.',
        'basic',
        1
      ),
      (
        v_id,
        '面对充满未知与艰巨挑战的海外新兴市场开拓征程，这支朝气蓬勃的青年创业团队始终充满必胜的信心与激情。',
        'Miànduì chōngmǎn wèizhī yǔ jiānjù tiǎozhàn de hǎiwài xīnxīng shìchǎng kāituò zhēngchéng, zhè zhī zhāoqì-péngbó de qīngnián chuàngyè tuánduì shǐzhōng chōngmǎn bìshèng de xìnxīn yǔ jīqíng.',
        'Đối mặt với hành trình khai phá thị trường mới nổi ở nước ngoài đầy ắp những điều chưa biết và thách thức cam go, đội ngũ khởi nghiệp trẻ trung tràn đầy nhựa sống này luôn đong đầy niềm tin quyết thắng và lòng nhiệt huyết sục sôi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2161] [充值] (chōngzhí) - nạp tiền vào tài khoản, nạp tiền vào thẻ (điện thoại, xe buýt, ví điện tử) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '充值' AND pinyin = 'chōngzhí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充值' AND pinyin = 'chōngzhí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '充值'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充值'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chōngzhí',
      meaning_vi = 'nạp tiền vào tài khoản, nạp tiền vào thẻ (điện thoại, xe buýt, ví điện tử)',
      example_hanzi = '在手机应用程序上动动手指就能轻松给公共交通卡充值。',
      example_pinyin = 'Zài shǒujī yìngyòng chéngxù shàng dòngdong shǒuzhǐ jiù néng qīngsōng gěi gōnggòng jiāotōngkǎ chōngzhí.',
      example_vi = 'Chỉ cần cử động ngón tay trên ứng dụng điện thoại di động là có thể dễ dàng nạp tiền vào thẻ giao thông công cộng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '充值',
      'chōngzhí',
      'nạp tiền vào tài khoản, nạp tiền vào thẻ (điện thoại, xe buýt, ví điện tử)',
      'Động từ',
      'HSK 5',
      '在手机应用程序上动动手指就能轻松给公共交通卡充值。',
      'Zài shǒujī yìngyòng chéngxù shàng dòngdong shǒuzhǐ jiù néng qīngsōng gěi gōnggòng jiāotōngkǎ chōngzhí.',
      'Chỉ cần cử động ngón tay trên ứng dụng điện thoại di động là có thể dễ dàng nạp tiền vào thẻ giao thông công cộng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在手机应用程序上动动手指就能轻松给公共交通卡充值。',
        'Zài shǒujī yìngyòng chéngxù shàng dòngdong shǒuzhǐ jiù néng qīngsōng gěi gōnggòng jiāotōngkǎ chōngzhí.',
        'Chỉ cần cử động ngón tay trên ứng dụng điện thoại di động là có thể dễ dàng nạp tiền vào thẻ giao thông công cộng.',
        'basic',
        1
      ),
      (
        v_id,
        '电信运营商推出了线上手机话费自动充值赠送专属流量包的优惠回馈活动，吸引了大量年轻用户的积极参与。',
        'Diànxìn yùnyíngshāng tuīchū le xiànshàng shǒujī huàfèi zìdòng chōngzhí zèngsòng zhuānshǔ liúliàngbāo de yōuhuì huíkuì huódòng, xīyǐn le dàliàng niánqīng yònghù de jījí cānyù.',
        'Nhà mạng viễn thông đã tung ra chương trình ưu đãi tri ân tự động nạp tiền cước điện thoại trực tuyến tặng gói dung lượng data độc quyền, thu hút sự tham gia tích cực của đông đảo người dùng trẻ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2162] [充足] (chōngzú) - dồi dào, sung túc, đầy đủ (nguồn vốn, ánh sáng, năng lượng, thời gian) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '充足' AND pinyin = 'chōngzú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充足' AND pinyin = 'chōngzú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '充足'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '充足'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'chōngzú',
      meaning_vi = 'dồi dào, sung túc, đầy đủ (nguồn vốn, ánh sáng, năng lượng, thời gian)',
      example_hanzi = '阳台上的阳光十分充足，非常适宜盆栽绿色植物的生长。',
      example_pinyin = 'Yángtái shàng de yángguāng shífēn chōngzú, fēicháng shìyí pénzāi lǜsè zhíwù de shēngzhǎng.',
      example_vi = 'Ánh nắng trên ban công vô cùng dồi dào chan hòa, rất thích hợp cho sự sinh trưởng của các chậu cây cảnh xanh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '充足',
      'chōngzú',
      'dồi dào, sung túc, đầy đủ (nguồn vốn, ánh sáng, năng lượng, thời gian)',
      'Tính từ',
      'HSK 5',
      '阳台上的阳光十分充足，非常适宜盆栽绿色植物的生长。',
      'Yángtái shàng de yángguāng shífēn chōngzú, fēicháng shìyí pénzāi lǜsè zhíwù de shēngzhǎng.',
      'Ánh nắng trên ban công vô cùng dồi dào chan hòa, rất thích hợp cho sự sinh trưởng của các chậu cây cảnh xanh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '阳台上的阳光十分充足，非常适宜盆栽绿色植物的生长。',
        'Yángtái shàng de yángguāng shífēn chōngzú, fēicháng shìyí pénzāi lǜsè zhíwù de shēngzhǎng.',
        'Ánh nắng trên ban công vô cùng dồi dào chan hòa, rất thích hợp cho sự sinh trưởng của các chậu cây cảnh xanh.',
        'basic',
        1
      ),
      (
        v_id,
        '为确保国家重大科研攻关工程顺利如期推进，项目指挥部提前筹措了充足的专项研发科研经费与实验物资储备。',
        'Wèi quèbǎo guójiā zhòngdà kēyán gōngguān gōngchéng shùnlì rúqī tuījìn, xiàngmù zhǐhuībù tíqián chóucuò le chōngzú de zhuānxiàng yánfā kēyán jīngfèi yǔ shíyàn wùzī chǔbèi.',
        'Để đảm bảo công trình nghiên cứu khoa học trọng điểm quốc gia được đẩy mạnh thuận lợi đúng thời hạn, ban chỉ huy dự án đã trù liệu chuẩn bị từ trước nguồn kinh phí nghiên cứu chuyên ngành dồi dào và vật tư thực nghiệm dự trữ đầy đủ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2163] [重复] (chóngfù) - lặp lại, trùng lặp, lặp đi lặp lại [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '重复' AND pinyin = 'chóngfù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '重复' AND pinyin = 'chóngfù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '重复'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '重复'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'chóngfù',
      meaning_vi = 'lặp lại, trùng lặp, lặp đi lặp lại',
      example_hanzi = '请老师把刚才那句重点语法例句再重复念一遍。',
      example_pinyin = 'Qǐng lǎoshī bǎ gāngcái nà jù zhòngdiǎn yǔfǎ lìjù zài chóngfù niàn yí biàn.',
      example_vi = 'Xin thầy giáo nhắc lại đọc lại một lần nữa câu ví dụ ngữ pháp trọng điểm vừa rồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '重复',
      'chóngfù',
      'lặp lại, trùng lặp, lặp đi lặp lại',
      'Động từ / Tính từ',
      'HSK 5',
      '请老师把刚才那句重点语法例句再重复念一遍。',
      'Qǐng lǎoshī bǎ gāngcái nà jù zhòngdiǎn yǔfǎ lìjù zài chóngfù niàn yí biàn.',
      'Xin thầy giáo nhắc lại đọc lại một lần nữa câu ví dụ ngữ pháp trọng điểm vừa rồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '请老师把刚才那句重点语法例句再重复念一遍。',
        'Qǐng lǎoshī bǎ gāngcái nà jù zhòngdiǎn yǔfǎ lìjù zài chóngfù niàn yí biàn.',
        'Xin thầy giáo nhắc lại đọc lại một lần nữa câu ví dụ ngữ pháp trọng điểm vừa rồi.',
        'basic',
        1
      ),
      (
        v_id,
        '工厂引入工业机器人自动化替代方案，使一线工人们彻底摆脱了单调枯燥、高强度的简单机械重复劳动。',
        'Gōngchǎng yǐnrù gōngyè jīqìrén zìdònghuà tìdài fāng’àn, shǐ yīxiàn gōngrénmen chèdǐ bǎituō le dāndiào kūzào, gāo qiángdù de jiǎndān jīxiè chóngfù láodòng.',
        'Nhà máy đưa vào giải pháp thay thế tự động hóa bằng robot công nghiệp, giúp các công nhân tuyến đầu thoát khỏi hoàn toàn những công việc lao động lặp đi lặp lại cơ bắp đơn giản, cường độ cao và tẻ nhạt buồn chán.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2164] [虫子] (chóngzi) - con sâu, côn trùng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '虫子' AND pinyin = 'chóngzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '虫子' AND pinyin = 'chóngzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '虫子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '虫子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chóngzi',
      meaning_vi = 'con sâu, côn trùng',
      example_hanzi = '下过雨后，潮湿的花园草地上爬出了许多小虫子。',
      example_pinyin = 'Xià guò yǔ hòu, cháoshī de huāyuán cǎodì shàng pá chū le xǔduō xiǎo chóngzi.',
      example_vi = 'Sau cơn mưa, trên bãi cỏ vườn hoa ẩm ướt bò ra rất nhiều con sâu bọ nhỏ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '虫子',
      'chóngzi',
      'con sâu, côn trùng',
      'Danh từ',
      'HSK 5',
      '下过雨后，潮湿的花园草地上爬出了许多小虫子。',
      'Xià guò yǔ hòu, cháoshī de huāyuán cǎodì shàng pá chū le xǔduō xiǎo chóngzi.',
      'Sau cơn mưa, trên bãi cỏ vườn hoa ẩm ướt bò ra rất nhiều con sâu bọ nhỏ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '下过雨后，潮湿的花园草地上爬出了许多小虫子。',
        'Xià guò yǔ hòu, cháoshī de huāyuán cǎodì shàng pá chū le xǔduō xiǎo chóngzi.',
        'Sau cơn mưa, trên bãi cỏ vườn hoa ẩm ướt bò ra rất nhiều con sâu bọ nhỏ.',
        'basic',
        1
      ),
      (
        v_id,
        '生态农场坚持利用以虫治虫等绿色生物物理综合防治手段，坚决杜绝在蔬菜上喷洒剧毒化学农药。',
        'Shēngtài nóngchǎng jiānchí lìyòng yǐchóngzhìchóng děng lǜsè shēngwù wùlǐ zōnghé fángzhì shǒuduàn, jiānjué dùjué zài shūcài shàng pēnsǎ jùdú huàxué nóngyào.',
        'Trang trại sinh thái kiên trì sử dụng các biện pháp phòng trừ tổng hợp sinh học vật lý xanh như lấy côn trùng trị sâu bọ, kiên quyết chấm dứt việc phun thuốc trừ sâu hóa học độc hại cao lên rau màu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2165] [宠物] (chǒngwù) - thú cưng, vật nuôi bầu bạn trong gia đình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宠物' AND pinyin = 'chǒngwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宠物' AND pinyin = 'chǒngwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '宠物'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宠物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chǒngwù',
      meaning_vi = 'thú cưng, vật nuôi bầu bạn trong gia đình',
      example_hanzi = '许多孤寡老人喜欢养一只温顺的猫咪作为陪伴自己的宠物。',
      example_pinyin = 'Xǔduō gūguǎ lǎorén xǐhuan yǎng yì zhī wēnshùn de māomī zuòwéi péibàn zìjǐ de chǒngwù.',
      example_vi = 'Nhiều người già neo đơn thích nuôi một chú mèo ngoan ngoãn làm thú cưng để bầu bạn cùng mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宠物',
      'chǒngwù',
      'thú cưng, vật nuôi bầu bạn trong gia đình',
      'Danh từ',
      'HSK 5',
      '许多孤寡老人喜欢养一只温顺的猫咪作为陪伴自己的宠物。',
      'Xǔduō gūguǎ lǎorén xǐhuan yǎng yì zhī wēnshùn de māomī zuòwéi péibàn zìjǐ de chǒngwù.',
      'Nhiều người già neo đơn thích nuôi một chú mèo ngoan ngoãn làm thú cưng để bầu bạn cùng mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '许多孤寡老人喜欢养一只温顺的猫咪作为陪伴自己的宠物。',
        'Xǔduō gūguǎ lǎorén xǐhuan yǎng yì zhī wēnshùn de māomī zuòwéi péibàn zìjǐ de chǒngwù.',
        'Nhiều người già neo đơn thích nuôi một chú mèo ngoan ngoãn làm thú cưng để bầu bạn cùng mình.',
        'basic',
        1
      ),
      (
        v_id,
        '带宠物犬到公共绿地和居民社区散步时，饲养人必须自觉系好牵引绳并随身清理宠物粪便，做到文明养宠。',
        'Dài chǒngwùquǎn dào gōnggòng lǜdì hé jūmín shèqū sànbù shí, sìyǎngrén bìxū zìjué jì hǎo qiānyǐnshéng bìng suíshēn qīnglǐ chǒngwù fènbiàn, zuò dào wénmíng yǎng chǒng.',
        'Khi dắt chó cưng ra thảm cỏ công cộng và khu dân cư đi dạo, người nuôi bắt buộc phải tự giác buộc dây xích dắt và dọn dẹp phân thú cưng mang theo, thực hiện việc nuôi thú cưng văn minh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2166] [抽] (chōu) - rút ra, kéo ra; rút (thời gian); hút (thuốc) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '抽' AND pinyin = 'chōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抽' AND pinyin = 'chōu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '抽'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抽'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chōu',
      meaning_vi = 'rút ra, kéo ra; rút (thời gian); hút (thuốc)',
      example_hanzi = '工作再忙，也要抽点儿时间多陪陪家里的父母和孩子。',
      example_pinyin = 'Gōngzuò zài máng, yě yào chōu diǎnr shíjiān duō péipei jiā lǐ de fùmǔ hé háizi.',
      example_vi = 'Công việc dù bận rộn đến đâu cũng nên rút ra chút thời gian để ở bên cạnh bầu bạn với cha mẹ và con cái ở nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '抽',
      'chōu',
      'rút ra, kéo ra; rút (thời gian); hút (thuốc)',
      'Động từ',
      'HSK 5',
      '工作再忙，也要抽点儿时间多陪陪家里的父母和孩子。',
      'Gōngzuò zài máng, yě yào chōu diǎnr shíjiān duō péipei jiā lǐ de fùmǔ hé háizi.',
      'Công việc dù bận rộn đến đâu cũng nên rút ra chút thời gian để ở bên cạnh bầu bạn với cha mẹ và con cái ở nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '工作再忙，也要抽点儿时间多陪陪家里的父母和孩子。',
        'Gōngzuò zài máng, yě yào chōu diǎnr shíjiān duō péipei jiā lǐ de fùmǔ hé háizi.',
        'Công việc dù bận rộn đến đâu cũng nên rút ra chút thời gian để ở bên cạnh bầu bạn với cha mẹ và con cái ở nhà.',
        'basic',
        1
      ),
      (
        v_id,
        '为了自身健康和家人的长久幸福，广大吸烟者应当痛下决心尽早把烟彻底抽掉并坚决戒烟。',
        'Wèile zìshēn jiànkāng hé jiārén de chángjiǔ xìngfú, guǎngdà xīyānzhě yīngdāng tòng xià juéxīn jìnzǎo bǎ yān chèdǐ chōudiào bìng jiānjué jièyān.',
        'Vì sức khỏe của chính mình và hạnh phúc lâu dài của người thân, đông đảo người hút thuốc nên hạ quyết tâm sớm ngày bỏ hẳn và kiên quyết cai thuốc lá.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2167] [丑] (chǒu) - xấu xí, khó coi; đáng hổ thẹn, khó chấp nhận [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '丑' AND pinyin = 'chǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '丑' AND pinyin = 'chǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '丑'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '丑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'chǒu',
      meaning_vi = 'xấu xí, khó coi; đáng hổ thẹn, khó chấp nhận',
      example_hanzi = '评价一个人不能只看外表美丑，心灵善良高尚才是真正的美。',
      example_pinyin = 'Píngjià yí gè rén bù néng zhǐ kàn wàibiǎo měi chǒu, xīnlíng shànliáng gāoshàng cái shì zhēnzhèng de měi.',
      example_vi = 'Đánh giá một con người không thể chỉ nhìn vẻ ngoài đẹp xấu, tâm hồn lương thiện thanh cao mới là vẻ đẹp đích thực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '丑',
      'chǒu',
      'xấu xí, khó coi; đáng hổ thẹn, khó chấp nhận',
      'Tính từ',
      'HSK 5',
      '评价一个人不能只看外表美丑，心灵善良高尚才是真正的美。',
      'Píngjià yí gè rén bù néng zhǐ kàn wàibiǎo měi chǒu, xīnlíng shànliáng gāoshàng cái shì zhēnzhèng de měi.',
      'Đánh giá một con người không thể chỉ nhìn vẻ ngoài đẹp xấu, tâm hồn lương thiện thanh cao mới là vẻ đẹp đích thực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '评价一个人不能只看外表美丑，心灵善良高尚才是真正的美。',
        'Píngjià yí gè rén bù néng zhǐ kàn wàibiǎo měi chǒu, xīnlíng shànliáng gāoshàng cái shì zhēnzhèng de měi.',
        'Đánh giá một con người không thể chỉ nhìn vẻ ngoài đẹp xấu, tâm hồn lương thiện thanh cao mới là vẻ đẹp đích thực.',
        'basic',
        1
      ),
      (
        v_id,
        '个别运动员为了追求名利在国际大赛中公然服用违禁药物作弊，这种丑恶行径遭到了体育界各方的强烈谴责与严厉处罚。',
        'Gèbié yùndòngyuán wèile zhuīqiú mínglì zài guójì dàsài zhōng gōngrán fúyòng wéijìnyàowù zuòbì, zhè zhǒng chǒu’è xíngjìng zāodào le tǐyùjiè gè fāng de qiángliè qiǎnzé yǔ yánlì chǔfá.',
        'Một vài vận động viên vì theo đuổi danh lợi đã ngang nhiên dùng chất cấm gian lận trong các giải đấu lớn quốc tế, hành vi xấu xa này đã gặp phải sự lên án kịch liệt và hình phạt nghiêm khắc từ các bên trong giới thể thao.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2168] [臭] (chòu) - hôi, thối (mùi); tai tiếng, đáng ghét [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '臭' AND pinyin = 'chòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '臭' AND pinyin = 'chòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '臭'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '臭'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'chòu',
      meaning_vi = 'hôi, thối (mùi); tai tiếng, đáng ghét',
      example_hanzi = '厨余垃圾在炎热的夏天容易腐烂变质并散发出难闻的臭味。',
      example_pinyin = 'Chúyú lājī zài yánrè de xiàtiān róngyì fǔlàn biànzhì bìng sànfā chū nánwén de chòuwèi.',
      example_vi = 'Rác thải nhà bếp vào mùa hè oi bức rất dễ thối rữa biến chất và bốc ra mùi hôi thối khó ngửi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '臭',
      'chòu',
      'hôi, thối (mùi); tai tiếng, đáng ghét',
      'Tính từ',
      'HSK 5',
      '厨余垃圾在炎热的夏天容易腐烂变质并散发出难闻的臭味。',
      'Chúyú lājī zài yánrè de xiàtiān róngyì fǔlàn biànzhì bìng sànfā chū nánwén de chòuwèi.',
      'Rác thải nhà bếp vào mùa hè oi bức rất dễ thối rữa biến chất và bốc ra mùi hôi thối khó ngửi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '厨余垃圾在炎热的夏天容易腐烂变质并散发出难闻的臭味。',
        'Chúyú lājī zài yánrè de xiàtiān róngyì fǔlàn biànzhì bìng sànfā chū nánwén de chòuwèi.',
        'Rác thải nhà bếp vào mùa hè oi bức rất dễ thối rữa biến chất và bốc ra mùi hôi thối khó ngửi.',
        'basic',
        1
      ),
      (
        v_id,
        '长沙特色名吃“臭豆腐”闻起来虽然有一股独特的臭气，但油炸出锅蘸上秘制辣椒酱汁后吃起来却焦脆香辣、回味无穷。',
        'Chángshā tèsè míngchī “chòudòufu” wén qǐlai suīrán yǒu yì gǔ dútè de chòuqì, dàn yóuzhá chū guō zhàn shàng mìnzhì làjiāo jiàngzhī hòu chī qǐlai què jiāocuì xiānglà, huíwèi-wúqióng.',
        'Món ăn đặc sản nổi tiếng Trường Sa “đậu phụ thối” ngửi qua tuy có một mùi hôi nồng nặc đặc trưng, nhưng sau khi chiên vàng giòn vớt ra khỏi chảo chấm với nước sốt ớt bí truyền thì ăn vào lại giòn rụm thơm cay, dư vị khôn cùng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2169] [初] (chū) - ban đầu, thuở đầu, thời kỳ đầu; mồng (đầu tháng âm lịch) [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '初' AND pinyin = 'chū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '初' AND pinyin = 'chū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '初'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '初'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'chū',
      meaning_vi = 'ban đầu, thuở đầu, thời kỳ đầu; mồng (đầu tháng âm lịch)',
      example_hanzi = '古人云“人之初，性本善”，强调了后天良善品德培养与家庭启蒙教育的重要性。',
      example_pinyin = 'Gǔrén yún “rén zhī chū, xìng běn shàn”, qiángdiào le hòutiān liángshàn pǐndé péiyǎng yǔ jiātíng qǐméng jiàoyù de zhòngyàoxìng.',
      example_vi = 'Người xưa nói “Nhân chi sơ, tính bản thiện”, nhấn mạnh tầm quan trọng của việc bồi dưỡng phẩm đức lương thiện sau này và giáo dục khai tâm gia đình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '初',
      'chū',
      'ban đầu, thuở đầu, thời kỳ đầu; mồng (đầu tháng âm lịch)',
      'Danh từ / Tính từ',
      'HSK 5',
      '古人云“人之初，性本善”，强调了后天良善品德培养与家庭启蒙教育的重要性。',
      'Gǔrén yún “rén zhī chū, xìng běn shàn”, qiángdiào le hòutiān liángshàn pǐndé péiyǎng yǔ jiātíng qǐméng jiàoyù de zhòngyàoxìng.',
      'Người xưa nói “Nhân chi sơ, tính bản thiện”, nhấn mạnh tầm quan trọng của việc bồi dưỡng phẩm đức lương thiện sau này và giáo dục khai tâm gia đình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '古人云“人之初，性本善”，强调了后天良善品德培养与家庭启蒙教育的重要性。',
        'Gǔrén yún “rén zhī chū, xìng běn shàn”, qiángdiào le hòutiān liángshàn pǐndé péiyǎng yǔ jiātíng qǐméng jiàoyù de zhòngyàoxìng.',
        'Người xưa nói “Nhân chi sơ, tính bản thiện”, nhấn mạnh tầm quan trọng của việc bồi dưỡng phẩm đức lương thiện sau này và giáo dục khai tâm gia đình.',
        'basic',
        1
      ),
      (
        v_id,
        '无论走出多远、攀登多高，我们都应当铭记当初创业起步时的那份赤诚初心，矢志不渝地砥砺前行。',
        'Wúlùn zǒu chū duō yuǎn, pāndēng duō gāo, wǒmen dōu yīngdāng míngjì dāngchū chuàngyè qǐbù shí de nà fèn chìchéng chūxīn, shǐzhìbùyú de dǐlì qiánxíng.',
        'Dù đi xa đến đâu, leo cao thế nào, chúng ta đều phải khắc ghi tâm nguyện ban đầu chân thành thời điểm khởi nghiệp bước đầu năm ấy, son sắt một lòng tôi luyện vững bước tiến lên.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2170] [出版] (chūbǎn) - xuất bản (sách, báo, tạp chí, giáo trình) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '出版' AND pinyin = 'chūbǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出版' AND pinyin = 'chūbǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '出版'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出版'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chūbǎn',
      meaning_vi = 'xuất bản (sách, báo, tạp chí, giáo trình)',
      example_hanzi = '著名作家的这本全新长篇小说将于下个月在全国各大书店正式出版发行。',
      example_pinyin = 'Zhùmíng zuòjiā de zhè běn quánxīn chángpiān xiǎoshuō jiāng yú xià gè yuè zài quánguó gè dà shūdiàn zhèngshì chūbǎn fāxíng.',
      example_vi = 'Cuốn tiểu thuyết dài tập hoàn toàn mới của nhà văn nổi tiếng sẽ chính thức được xuất bản phát hành tại các hiệu sách lớn trên toàn quốc vào tháng tới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '出版',
      'chūbǎn',
      'xuất bản (sách, báo, tạp chí, giáo trình)',
      'Động từ',
      'HSK 5',
      '著名作家的这本全新长篇小说将于下个月在全国各大书店正式出版发行。',
      'Zhùmíng zuòjiā de zhè běn quánxīn chángpiān xiǎoshuō jiāng yú xià gè yuè zài quánguó gè dà shūdiàn zhèngshì chūbǎn fāxíng.',
      'Cuốn tiểu thuyết dài tập hoàn toàn mới của nhà văn nổi tiếng sẽ chính thức được xuất bản phát hành tại các hiệu sách lớn trên toàn quốc vào tháng tới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '著名作家的这本全新长篇小说将于下个月在全国各大书店正式出版发行。',
        'Zhùmíng zuòjiā de zhè běn quánxīn chángpiān xiǎoshuō jiāng yú xià gè yuè zài quánguó gè dà shūdiàn zhèngshì chūbǎn fāxíng.',
        'Cuốn tiểu thuyết dài tập hoàn toàn mới của nhà văn nổi tiếng sẽ chính thức được xuất bản phát hành tại các hiệu sách lớn trên toàn quốc vào tháng tới.',
        'basic',
        1
      ),
      (
        v_id,
        '高校出版社严格执行“三审三校”学术出版质量管理规范，确保每一本专业学术专著都达到极高的编校质量标准。',
        'Gāoxiào chūbǎnshè yángé zhíxíng “sān shěn sān jiào” xuéshù chūbǎn zhìliàng guǎnlǐ guīfàn, quèbǎo měi yì běn zhuānyè xuéshù zhuānzhù dōu dádào jí gāo de biānjiào zhìliàng biāozhǔn.',
        'Nhà xuất bản các trường đại học thực hiện nghiêm ngặt quy phạm quản lý chất lượng xuất bản học thuật “ba lần duyệt ba lần sửa bản in”, đảm bảo mỗi một cuốn chuyên khảo học thuật chuyên ngành đều đạt tiêu chuẩn chất lượng biên tập hiệu đính cực cao.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2171] [初级] (chūjí) - sơ cấp, cơ bản, trình độ nhập môn ban đầu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '初级' AND pinyin = 'chūjí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '初级' AND pinyin = 'chūjí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '初级'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '初级'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'chūjí',
      meaning_vi = 'sơ cấp, cơ bản, trình độ nhập môn ban đầu',
      example_hanzi = '零基础的外国留学生需要先在国际学院修读一年的初级汉语强化课程。',
      example_pinyin = 'Líng jīchǔ de wàiguó liúxuéshēng xūyào xiān zài guójì xuéyuàn xiūdú yì nián de chūjí Hànyǔ qiánghuà kèchéng.',
      example_vi = 'Du học sinh nước ngoài chưa có nền tảng cần phải học một năm khóa học tăng cường tiếng Hán sơ cấp tại học viện quốc tế trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '初级',
      'chūjí',
      'sơ cấp, cơ bản, trình độ nhập môn ban đầu',
      'Tính từ',
      'HSK 5',
      '零基础的外国留学生需要先在国际学院修读一年的初级汉语强化课程。',
      'Líng jīchǔ de wàiguó liúxuéshēng xūyào xiān zài guójì xuéyuàn xiūdú yì nián de chūjí Hànyǔ qiánghuà kèchéng.',
      'Du học sinh nước ngoài chưa có nền tảng cần phải học một năm khóa học tăng cường tiếng Hán sơ cấp tại học viện quốc tế trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '零基础的外国留学生需要先在国际学院修读一年的初级汉语强化课程。',
        'Líng jīchǔ de wàiguó liúxuéshēng xūyào xiān zài guójì xuéyuàn xiūdú yì nián de chūjí Hànyǔ qiánghuà kèchéng.',
        'Du học sinh nước ngoài chưa có nền tảng cần phải học một năm khóa học tăng cường tiếng Hán sơ cấp tại học viện quốc tế trước.',
        'basic',
        1
      ),
      (
        v_id,
        '该软件开发平台为没有任何编程基础的初级学员提供了模块化积木式代码拖拽练习，大幅降低了数字化技能的学习门槛。',
        'Gāi ruǎnjiàn kāifā píngtái wèi méiyǒu rènhé biānchéng jīchǔ de chūjí xuéyuán tígōng le mókuàihuà jīmùshì dàimǎ tuōzhuài liànxí, dà fú jiàngdī le shùzìhuà jìnéng de xuéxí ménkǎn.',
        'Nền tảng phát triển phần mềm này cung cấp các bài tập kéo thả khối mã module hóa cho các học viên sơ cấp chưa có bất kỳ nền tảng lập trình nào, hạ thấp đáng kể rào cản học tập kỹ năng kỹ thuật số.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2172] [初期] (chūqī) - thời kỳ đầu, giai đoạn ban đầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '初期' AND pinyin = 'chūqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '初期' AND pinyin = 'chūqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '初期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '初期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chūqī',
      meaning_vi = 'thời kỳ đầu, giai đoạn ban đầu',
      example_hanzi = '在创业初期，团队面临着资金严重匮乏和技术攻关的多重严峻考验。',
      example_pinyin = 'Zài chuàngyè chūqī, tuánduì miànlín zhe zījīn yánzhòng kuìfá hé jìshù gōngguān de duōchóng yánjùn kǎoyàn.',
      example_vi = 'Trong thời kỳ đầu khởi nghiệp, đội ngũ phải đối mặt với nhiều thử thách gay gắt từ việc thiếu thốn nguồn vốn trầm trọng và đột phá công nghệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '初期',
      'chūqī',
      'thời kỳ đầu, giai đoạn ban đầu',
      'Danh từ',
      'HSK 5',
      '在创业初期，团队面临着资金严重匮乏和技术攻关的多重严峻考验。',
      'Zài chuàngyè chūqī, tuánduì miànlín zhe zījīn yánzhòng kuìfá hé jìshù gōngguān de duōchóng yánjùn kǎoyàn.',
      'Trong thời kỳ đầu khởi nghiệp, đội ngũ phải đối mặt với nhiều thử thách gay gắt từ việc thiếu thốn nguồn vốn trầm trọng và đột phá công nghệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在创业初期，团队面临着资金严重匮乏和技术攻关的多重严峻考验。',
        'Zài chuàngyè chūqī, tuánduì miànlín zhe zījīn yánzhòng kuìfá hé jìshù gōngguān de duōchóng yánjùn kǎoyàn.',
        'Trong thời kỳ đầu khởi nghiệp, đội ngũ phải đối mặt với nhiều thử thách gay gắt từ việc thiếu thốn nguồn vốn trầm trọng và đột phá công nghệ.',
        'basic',
        1
      ),
      (
        v_id,
        '多数慢性疾病如果在发病初期通过定期体检做到早发现、早诊断和早干预，患者的临床治愈率与生存质量将得到显著提升。',
        'Duōshù mànxìng jíbìng rúguǒ zài fābìng chūqī tōngguò dìngqī tǐjiǎn zuò dào zǎo fāxiàn, zǎo zhěnduàn hé zǎo gānyù, huànzhě de línchuáng zhìyùlǜ yǔ shēngcún zhìliàng jiāng dédào xiǎnzhù tíshēng.',
        'Đa số các bệnh mạn tính nếu ở thời kỳ đầu phát bệnh thông qua khám sức khỏe định kỳ làm tốt việc phát hiện sớm, chẩn đoán sớm và can thiệp sớm, thì tỷ lệ khỏi bệnh lâm sàng và chất lượng sống của người bệnh sẽ được nâng cao rõ rệt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2173] [出色] (chūsè) - xuất sắc, vượt trội, nổi bật khác thường [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '出色' AND pinyin = 'chūsè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出色' AND pinyin = 'chūsè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '出色'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出色'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'chūsè',
      meaning_vi = 'xuất sắc, vượt trội, nổi bật khác thường',
      example_hanzi = '小李在本次青年辩论赛中表现得极其出色，赢得了评委和观众的一致起立鼓掌。',
      example_pinyin = 'Xiǎo Lǐ zài běn cì qīngnián biànlùnsài zhōng biǎoxiàn de jíqí chūsè, yíngdé le píngwěi hé guānzhòng de yízhì qǐlì gǔzhǎng.',
      example_vi = 'Tiểu Lý trong cuộc thi tranh biện thanh niên lần này đã thể hiện vô cùng xuất sắc, giành được tràng pháo tay đứng dậy đồng loạt tán thưởng của ban giám khảo và khán giả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '出色',
      'chūsè',
      'xuất sắc, vượt trội, nổi bật khác thường',
      'Tính từ',
      'HSK 5',
      '小李在本次青年辩论赛中表现得极其出色，赢得了评委和观众的一致起立鼓掌。',
      'Xiǎo Lǐ zài běn cì qīngnián biànlùnsài zhōng biǎoxiàn de jíqí chūsè, yíngdé le píngwěi hé guānzhòng de yízhì qǐlì gǔzhǎng.',
      'Tiểu Lý trong cuộc thi tranh biện thanh niên lần này đã thể hiện vô cùng xuất sắc, giành được tràng pháo tay đứng dậy đồng loạt tán thưởng của ban giám khảo và khán giả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '小李在本次青年辩论赛中表现得极其出色，赢得了评委和观众的一致起立鼓掌。',
        'Xiǎo Lǐ zài běn cì qīngnián biànlùnsài zhōng biǎoxiàn de jíqí chūsè, yíngdé le píngwěi hé guānzhòng de yízhì qǐlì gǔzhǎng.',
        'Tiểu Lý trong cuộc thi tranh biện thanh niên lần này đã thể hiện vô cùng xuất sắc, giành được tràng pháo tay đứng dậy đồng loạt tán thưởng của ban giám khảo và khán giả.',
        'basic',
        1
      ),
      (
        v_id,
        '凭借出色卓越的领导统筹能力和敏锐的市场洞察眼光，这位年轻的首席执行官成功带领跨国企业走出行业低谷重获强劲增长。',
        'Píngjiè chūsè zhuóyuè de lǐngdǎo tǒngchóu nénglì hé mǐnruì de shìchǎng dòngchá yǎnguāng, zhè wèi niánqīng de shǒuxí zhíxíngguān chénggōng dàilǐng kuàguó qǐyè zǒu chū hángyè dīgǔ chóng huò qiángjìn zēngzhǎng.',
        'Nhờ vào năng lực lãnh đạo điều phối xuất sắc kiệt xuất và ánh mắt thấu suốt thị trường nhạy bén, vị giám đốc điều hành (CEO) trẻ tuổi này đã dẫn dắt doanh nghiệp đa quốc gia bước ra khỏi vùng đáy của ngành và lấy lại đà tăng trưởng mạnh mẽ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2174] [出售] (chūshòu) - bán ra, chào bán (hàng hóa, nhà đất, tài sản) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '出售' AND pinyin = 'chūshòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出售' AND pinyin = 'chūshòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '出售'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出售'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chūshòu',
      meaning_vi = 'bán ra, chào bán (hàng hóa, nhà đất, tài sản)',
      example_hanzi = '这家新华书店目前正在打折出售各类中外经典名著。',
      example_pinyin = 'Zhè jiā Xīnhuá Shūdiàn mùqián zhèngzài dǎzhé chūshòu gè lèi zhōng-wài jīngdiǎn míngzhù.',
      example_vi = 'Hiệu sách Tân Hoa này hiện đang giảm giá bán ra các loại danh tác kinh điển trong và ngoài nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '出售',
      'chūshòu',
      'bán ra, chào bán (hàng hóa, nhà đất, tài sản)',
      'Động từ',
      'HSK 5',
      '这家新华书店目前正在打折出售各类中外经典名著。',
      'Zhè jiā Xīnhuá Shūdiàn mùqián zhèngzài dǎzhé chūshòu gè lèi zhōng-wài jīngdiǎn míngzhù.',
      'Hiệu sách Tân Hoa này hiện đang giảm giá bán ra các loại danh tác kinh điển trong và ngoài nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这家新华书店目前正在打折出售各类中外经典名著。',
        'Zhè jiā Xīnhuá Shūdiàn mùqián zhèngzài dǎzhé chūshòu gè lèi zhōng-wài jīngdiǎn míngzhù.',
        'Hiệu sách Tân Hoa này hiện đang giảm giá bán ra các loại danh tác kinh điển trong và ngoài nước.',
        'basic',
        1
      ),
      (
        v_id,
        '依法取得不动产权属证书的商品房，房产所有人有权在房屋交易中心公开挂牌挂牌或依法向社会第三方买家出售。',
        'Yīfǎ qǔdé búdòngchǎn quánshǔ zhèngshū de shāngpǐnfáng, fángchǎn suǒyǒurén yǒu quán zài fángwū jiāoyì zhōngxīn gōngkāi guàpái huò yīfǎ xiàng shèhuì dì-sānfāng mǎijiā chūshòu.',
        'Căn hộ thương phẩm đã đạt được giấy chứng nhận quyền sở hữu bất động sản theo đúng pháp luật, chủ sở hữu nhà đất có quyền niêm yết công khai tại trung tâm giao dịch nhà đất hoặc bán ra cho người mua bên thứ ba trong xã hội theo luật định.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2175] [出席] (chūxí) - tham dự, có mặt (hội nghị, buổi lễ, sự kiện chính thức) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '出席' AND pinyin = 'chūxí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出席' AND pinyin = 'chūxí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '出席'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出席'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chūxí',
      meaning_vi = 'tham dự, có mặt (hội nghị, buổi lễ, sự kiện chính thức)',
      example_hanzi = '来自三十多个国家和地区的五百多位代表出席了本次国际科技学术年会。',
      example_pinyin = 'Láizì sānshí duō gè guójiā hé dìqū de wǔbǎi duō wèi dàibiǎo chūxí le běn cì guójì kējì xuéshù niánhuì.',
      example_vi = 'Hơn năm trăm đại biểu đến từ hơn ba mươi quốc gia và vùng lãnh thổ đã tham dự hội nghị khoa học công nghệ thường niên quốc tế lần này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '出席',
      'chūxí',
      'tham dự, có mặt (hội nghị, buổi lễ, sự kiện chính thức)',
      'Động từ',
      'HSK 5',
      '来自三十多个国家和地区的五百多位代表出席了本次国际科技学术年会。',
      'Láizì sānshí duō gè guójiā hé dìqū de wǔbǎi duō wèi dàibiǎo chūxí le běn cì guójì kējì xuéshù niánhuì.',
      'Hơn năm trăm đại biểu đến từ hơn ba mươi quốc gia và vùng lãnh thổ đã tham dự hội nghị khoa học công nghệ thường niên quốc tế lần này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '来自三十多个国家和地区的五百多位代表出席了本次国际科技学术年会。',
        'Láizì sānshí duō gè guójiā hé dìqū de wǔbǎi duō wèi dàibiǎo chūxí le běn cì guójì kējì xuéshù niánhuì.',
        'Hơn năm trăm đại biểu đến từ hơn ba mươi quốc gia và vùng lãnh thổ đã tham dự hội nghị khoa học công nghệ thường niên quốc tế lần này.',
        'basic',
        1
      ),
      (
        v_id,
        '在两国建交四十周年重要纪念日之际，双方国家领导人应邀隆重出席了联合庆祝招待宴会并发表主旨演讲。',
        'Zài liǎng guó jiànjiāo sìshí zhōunián zhòngyào jīniànrì zhī jì, shuāngfāng guójiā lǐngdǎorén yìngyāo lóngzhòng chūxí le liánhé qìngzhù zhāodài yànhuì bìng fābiǎo zhǔzhǐ yǎnjiǎng.',
        'Nhân dịp kỷ niệm trọng đại bốn mươi năm thiết lập quan hệ ngoại giao giữa hai nước, các nhà lãnh đạo hai quốc gia đã nhận lời mời long trọng tham dự tiệc chiêu đãi kỷ niệm chung và phát biểu bài diễn văn chủ đạo.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2176] [出自] (chūzì) - xuất phát từ, bắt nguồn từ, do ai sáng tác/chế tác [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '出自' AND pinyin = 'chūzì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出自' AND pinyin = 'chūzì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '出自'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '出自'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chūzì',
      meaning_vi = 'xuất phát từ, bắt nguồn từ, do ai sáng tác/chế tác',
      example_hanzi = '这句富有哲理的传世名言出自中国古代著名思想家庄子的著作。',
      example_pinyin = 'Zhè jù fùyǒu zhélǐ de chuánshì míngyán chūzì Zhōngguó gǔdài zhùmíng sīxiǎngjiā Zhuāngzǐ de zhùzuò.',
      example_vi = 'Câu danh ngôn truyền đời giàu tính triết lý này xuất phát từ tác phẩm của Trang Tử - nhà tư tưởng nổi tiếng thời cổ đại Trung Quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '出自',
      'chūzì',
      'xuất phát từ, bắt nguồn từ, do ai sáng tác/chế tác',
      'Động từ',
      'HSK 5',
      '这句富有哲理的传世名言出自中国古代著名思想家庄子的著作。',
      'Zhè jù fùyǒu zhélǐ de chuánshì míngyán chūzì Zhōngguó gǔdài zhùmíng sīxiǎngjiā Zhuāngzǐ de zhùzuò.',
      'Câu danh ngôn truyền đời giàu tính triết lý này xuất phát từ tác phẩm của Trang Tử - nhà tư tưởng nổi tiếng thời cổ đại Trung Quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这句富有哲理的传世名言出自中国古代著名思想家庄子的著作。',
        'Zhè jù fùyǒu zhélǐ de chuánshì míngyán chūzì Zhōngguó gǔdài zhùmíng sīxiǎngjiā Zhuāngzǐ de zhùzuò.',
        'Câu danh ngôn truyền đời giàu tính triết lý này xuất phát từ tác phẩm của Trang Tử - nhà tư tưởng nổi tiếng thời cổ đại Trung Quốc.',
        'basic',
        1
      ),
      (
        v_id,
        '国家大剧院大厅陈列的这幅气势磅礴的巨幅传统水墨山水壁画，全部出自当代杰出美术大师之手。',
        'Guójiā Dàjùyuàn dàtīng chénliè de zhè fú qìshì pángbó de jùfú chuántǒng shuǐmò shānshuǐ bìhuà, quánbù chūzì dāngdài jiéchū měishù dàshī zhī shǒu.',
        'Bức bích họa tranh thủy mặc non nước truyền thống khổ lớn khí thế bàng bạc trưng bày tại sảnh lớn Nhà hát Lớn Quốc gia toàn bộ do chính tay các bậc thầy mỹ thuật kiệt xuất đương đại chấp bút sáng tạo.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2177] [除夕] (chúxī) - đêm giao thừa (đêm ba mươi Tết Nguyên đán) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '除夕' AND pinyin = 'chúxī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '除夕' AND pinyin = 'chúxī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '除夕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '除夕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chúxī',
      meaning_vi = 'đêm giao thừa (đêm ba mươi Tết Nguyên đán)',
      example_hanzi = '除夕之夜，全家人围坐在电视机旁一边包饺子一边收看春节联欢晚会。',
      example_pinyin = 'Chúxī zhī yè, quán jiārén wéizuò zài diànshìjī páng yìbiān bāo jiǎozi yìbiān shōukàn Chūnjié liánhuān wǎnhuì.',
      example_vi = 'Trong đêm giao thừa, cả nhà quây quần bên tivi vừa gói sủi cảo vừa theo dõi chương trình dạ hội chào xuân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '除夕',
      'chúxī',
      'đêm giao thừa (đêm ba mươi Tết Nguyên đán)',
      'Danh từ',
      'HSK 5',
      '除夕之夜，全家人围坐在电视机旁一边包饺子一边收看春节联欢晚会。',
      'Chúxī zhī yè, quán jiārén wéizuò zài diànshìjī páng yìbiān bāo jiǎozi yìbiān shōukàn Chūnjié liánhuān wǎnhuì.',
      'Trong đêm giao thừa, cả nhà quây quần bên tivi vừa gói sủi cảo vừa theo dõi chương trình dạ hội chào xuân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '除夕之夜，全家人围坐在电视机旁一边包饺子一边收看春节联欢晚会。',
        'Chúxī zhī yè, quán jiārén wéizuò zài diànshìjī páng yìbiān bāo jiǎozi yìbiān shōukàn Chūnjié liánhuān wǎnhuì.',
        'Trong đêm giao thừa, cả nhà quây quần bên tivi vừa gói sủi cảo vừa theo dõi chương trình dạ hội chào xuân.',
        'basic',
        1
      ),
      (
        v_id,
        '除夕守岁辞旧迎新是中华民族延续千年的重要传统年俗，寓意着阖家团聚、幸福安康与来年五谷丰登。',
        'Chúxī shǒusuì cíjiù-yíngxīn shì Zhōnghuá mínzú yánxù qiān nián de zhòngyào chuántǒng niánsú, yùyì zhe héjiā tuánjù, xìngfú ānkāng yǔ láinián wǔgǔ-fēngdēng.',
        'Đón giao thừa thức thâu đêm tiễn năm cũ nghênh năm mới là phong tục tết cổ truyền quan trọng kéo dài nghìn năm của dân tộc Trung Hoa, mang ngụ ý gia đình sum họp đoàn viên, an khang hạnh phúc và mùa màng bội thu trong năm tới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2178] [处] (chǔ) - ở vào, sống chung, xử sự; xử lý (trong chǔlǐ, chǔshì, chǔyú) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '处' AND pinyin = 'chǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '处' AND pinyin = 'chǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chǔ',
      meaning_vi = 'ở vào, sống chung, xử sự; xử lý (trong chǔlǐ, chǔshì, chǔyú)',
      example_hanzi = '为人处世要谦逊宽容，懂得换位思考多为他人着想。',
      example_pinyin = 'Wéirén chǔshì yào qiānxùn kuānróng, dǒngde huànwèi sīkǎo duō wèi tārén zhuóxiǎng.',
      example_vi = 'Làm người và xử sự cần phải khiêm tốn bao dung, biết đặt mình vào vị trí người khác để suy nghĩ cho người ta.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '处',
      'chǔ',
      'ở vào, sống chung, xử sự; xử lý (trong chǔlǐ, chǔshì, chǔyú)',
      'Động từ',
      'HSK 5',
      '为人处世要谦逊宽容，懂得换位思考多为他人着想。',
      'Wéirén chǔshì yào qiānxùn kuānróng, dǒngde huànwèi sīkǎo duō wèi tārén zhuóxiǎng.',
      'Làm người và xử sự cần phải khiêm tốn bao dung, biết đặt mình vào vị trí người khác để suy nghĩ cho người ta.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '为人处世要谦逊宽容，懂得换位思考多为他人着想。',
        'Wéirén chǔshì yào qiānxùn kuānróng, dǒngde huànwèi sīkǎo duō wèi tārén zhuóxiǎng.',
        'Làm người và xử sự cần phải khiêm tốn bao dung, biết đặt mình vào vị trí người khác để suy nghĩ cho người ta.',
        'basic',
        1
      ),
      (
        v_id,
        '合资企业中来自不同文化背景的中外管理团队成员只有坦诚相处、彼此尊重，才能形成强大的团队凝聚力。',
        'Hézī qǐyè zhōng láizì bù tóng wénhuà bèijǐng de zhōng-wài guǎnlǐ tuánduì chéngyuán zhǐyǒu tǎnchéng xiāngchǔ, bǐcǐ zūnzhòng, cái néng xíngchéng qiángdà de tuánduì níngjùlì.',
        'Trong doanh nghiệp liên doanh, các thành viên ban quản lý Trung - ngoại đến từ những bối cảnh văn hóa khác nhau chỉ khi chung sống chân thành và tôn trọng lẫn nhau thì mới có thể tạo nên sức mạnh gắn kết tập thể vững vàng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2179] [处理] (chǔlǐ) - xử lý, giải quyết (công việc, rác thải, khủng hoảng); bán thanh lý [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '处理' AND pinyin = 'chǔlǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '处理' AND pinyin = 'chǔlǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '处理'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '处理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chǔlǐ',
      meaning_vi = 'xử lý, giải quyết (công việc, rác thải, khủng hoảng); bán thanh lý',
      example_hanzi = '每天上班后的第一件事就是抓紧时间处理紧急的公务电子邮件。',
      example_pinyin = 'Měitiān shàngbān hòu de dì-yī jiàn shì jiù shì zhuājǐn shíjiān chǔlǐ jǐnjí de gōngwù diànzǐ yóujiàn.',
      example_vi = 'Việc đầu tiên mỗi ngày sau khi đi làm là tranh thủ thời gian xử lý các thư điện tử công việc khẩn cấp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '处理',
      'chǔlǐ',
      'xử lý, giải quyết (công việc, rác thải, khủng hoảng); bán thanh lý',
      'Động từ',
      'HSK 5',
      '每天上班后的第一件事就是抓紧时间处理紧急的公务电子邮件。',
      'Měitiān shàngbān hòu de dì-yī jiàn shì jiù shì zhuājǐn shíjiān chǔlǐ jǐnjí de gōngwù diànzǐ yóujiàn.',
      'Việc đầu tiên mỗi ngày sau khi đi làm là tranh thủ thời gian xử lý các thư điện tử công việc khẩn cấp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '每天上班后的第一件事就是抓紧时间处理紧急的公务电子邮件。',
        'Měitiān shàngbān hòu de dì-yī jiàn shì jiù shì zhuājǐn shíjiān chǔlǐ jǐnjí de gōngwù diànzǐ yóujiàn.',
        'Việc đầu tiên mỗi ngày sau khi đi làm là tranh thủ thời gian xử lý các thư điện tử công việc khẩn cấp.',
        'basic',
        1
      ),
      (
        v_id,
        '公关危机管理部门迅速启动应急预案并妥善处理突发舆情事件，最大限度降低了负面舆论对企业声誉的冲击。',
        'Gōngguān wēijī guǎnlǐ bùmén xùnsù qǐdòng yìngjí yù’àn bìng tuǒshàn chǔlǐ tūfā yúqíng shìjiàn, zuì dà xiàndù jiàngdī le fùmiàn yúlùn duì qǐyè shēngyù de chōngjī.',
        'Bộ phận quản lý khủng hoảng quan hệ công chúng (PR) đã nhanh chóng kích hoạt phương án ứng phó khẩn cấp và giải quyết ổn thỏa sự cố dư luận bất ngờ nảy sinh, giảm thiểu tối đa tác động tiêu cực của dư luận đối với uy tín của doanh nghiệp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2180] [处于] (chǔyú) - ở vào, rơi vào (vị trí, trạng thái, giai đoạn phát triển) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '处于' AND pinyin = 'chǔyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '处于' AND pinyin = 'chǔyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '处于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '处于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chǔyú',
      meaning_vi = 'ở vào, rơi vào (vị trí, trạng thái, giai đoạn phát triển)',
      example_hanzi = '目前该工程项目正处于关键的最后封顶施工阶段。',
      example_pinyin = 'Mùqián gāi gōngchéng xiàngmù zhèng chǔyú guānjiàn de zuìhòu fēngdǐng shīgōng jiēduàn.',
      example_vi = 'Hiện nay dự án công trình này đang ở vào giai đoạn thi công cất nóc cuối cùng then chốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '处于',
      'chǔyú',
      'ở vào, rơi vào (vị trí, trạng thái, giai đoạn phát triển)',
      'Động từ',
      'HSK 5',
      '目前该工程项目正处于关键的最后封顶施工阶段。',
      'Mùqián gāi gōngchéng xiàngmù zhèng chǔyú guānjiàn de zuìhòu fēngdǐng shīgōng jiēduàn.',
      'Hiện nay dự án công trình này đang ở vào giai đoạn thi công cất nóc cuối cùng then chốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '目前该工程项目正处于关键的最后封顶施工阶段。',
        'Mùqián gāi gōngchéng xiàngmù zhèng chǔyú guānjiàn de zuìhòu fēngdǐng shīgōng jiēduàn.',
        'Hiện nay dự án công trình này đang ở vào giai đoạn thi công cất nóc cuối cùng then chốt.',
        'basic',
        1
      ),
      (
        v_id,
        '随着高新技术产业的迅猛崛起，该国在量子通信和高能物理前沿研发领域正处于世界领跑的优势地位。',
        'Suízhe gāoxīn jìshù chǎnyè de xùnměng juéqǐ, gāi guó zài liàngzǐ tōngxìn hé gāonéng wùlǐ qiányán yánfā lǐngyù zhèng chǔyú shìjiè lǐngpǎo de yōushì dìwèi.',
        'Cùng với sự vươn lên mạnh mẽ của ngành công nghiệp công nghệ cao, quốc gia này trong lĩnh vực nghiên cứu phát triển tiên phong thông tin lượng tử và vật lý năng lượng cao đang ở vào vị thế ưu thế dẫn đầu thế giới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2181] [处] (chù) - nơi, chốn, chỗ (địa điểm); phòng, ban, cơ quan hành chính [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '处' AND pinyin = 'chù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '处' AND pinyin = 'chù'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chù',
      meaning_vi = 'nơi, chốn, chỗ (địa điểm); phòng, ban, cơ quan hành chính',
      example_hanzi = '春风吹过大地，公园各处都呈现出一派生机盎然的景象。',
      example_pinyin = 'Chūnfēng chuī guò dàdì, gōngyuán gè chù dōu chéngxxiàn chū yí pài shēngjī-àngrán de jǐngxiàng.',
      example_vi = 'Gió xuân thổi qua mặt đất, các nơi trong công viên đều hiện lên cảnh tượng dạt dào sức sống phơi phới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '处',
      'chù',
      'nơi, chốn, chỗ (địa điểm); phòng, ban, cơ quan hành chính',
      'Danh từ',
      'HSK 5',
      '春风吹过大地，公园各处都呈现出一派生机盎然的景象。',
      'Chūnfēng chuī guò dàdì, gōngyuán gè chù dōu chéngxxiàn chū yí pài shēngjī-àngrán de jǐngxiàng.',
      'Gió xuân thổi qua mặt đất, các nơi trong công viên đều hiện lên cảnh tượng dạt dào sức sống phơi phới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '春风吹过大地，公园各处都呈现出一派生机盎然的景象。',
        'Chūnfēng chuī guò dàdì, gōngyuán gè chù dōu chéngxxiàn chū yí pài shēngjī-àngrán de jǐngxiàng.',
        'Gió xuân thổi qua mặt đất, các nơi trong công viên đều hiện lên cảnh tượng dạt dào sức sống phơi phới.',
        'basic',
        1
      ),
      (
        v_id,
        '市民办理个人不动产产权过户手续时，需携带全部原始身份证件到市行政服务大厅不动产登记处窗口办理。',
        'Shìmín bànlǐ gèrén búdòngchǎn chǎnquán guòhù shǒuxù shí, xū xiédài quánbù yuánshǐ shēnfèn zhèngjiàn dào shì xíngzhèng fúwù dàtīng búdòngchǎn dēngjìchù chuāngkǒu bànlǐ.',
        'Khi người dân làm thủ tục sang tên đổi chủ quyền sở hữu bất động sản cá nhân, cần mang theo toàn bộ giấy tờ tùy thân gốc tới quầy Phòng Đăng ký Bất động sản tại sảnh dịch vụ hành chính công thành phố để làm thủ tục.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2182] [传] (chuán) - truyền, truyền đạt, lan truyền, truyền thụ lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '传' AND pinyin = 'chuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传' AND pinyin = 'chuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '传'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chuán',
      meaning_vi = 'truyền, truyền đạt, lan truyền, truyền thụ lại',
      example_hanzi = '请大家把这份重要的通知材料从前排依次往后传。',
      example_pinyin = 'Qǐng dàjiā bǎ zhè fèn zhòngyào de tōngzhī cáiliào cóng qiánpái yīcì wǎng hòu chuán.',
      example_vi = 'Xin mọi người hãy chuyền tập tài liệu thông báo quan trọng này từ hàng ghế trước lần lượt ra phía sau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '传',
      'chuán',
      'truyền, truyền đạt, lan truyền, truyền thụ lại',
      'Động từ',
      'HSK 5',
      '请大家把这份重要的通知材料从前排依次往后传。',
      'Qǐng dàjiā bǎ zhè fèn zhòngyào de tōngzhī cáiliào cóng qiánpái yīcì wǎng hòu chuán.',
      'Xin mọi người hãy chuyền tập tài liệu thông báo quan trọng này từ hàng ghế trước lần lượt ra phía sau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '请大家把这份重要的通知材料从前排依次往后传。',
        'Qǐng dàjiā bǎ zhè fèn zhòngyào de tōngzhī cáiliào cóng qiánpái yīcì wǎng hòu chuán.',
        'Xin mọi người hãy chuyền tập tài liệu thông báo quan trọng này từ hàng ghế trước lần lượt ra phía sau.',
        'basic',
        1
      ),
      (
        v_id,
        '这门古老精湛的传统刺绣手工技艺，在师徒之间历经数百年的口传心授代代相传至今。',
        'Zhè mén gǔlǎo jīngzhàn de chuántǒng cìxiù shǒugōng jìyì, zài shītú zhījiān lìjīng shù bǎi nián de kǒuchuán-xīnshòu dài dài xiāngchuán zhìjīn.',
        'Kỹ nghệ thủ công thêu thùa truyền thống cổ kính tinh xảo này giữa thầy và trò đã trải qua hàng trăm năm truyền khẩu tâm thụ, đời đời truyền thừa lại cho đến tận ngày nay.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2183] [传播] (chuánbō) - lan truyền, truyền bá (thông tin, văn hóa, dịch bệnh, tri thức) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '传播' AND pinyin = 'chuánbō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传播' AND pinyin = 'chuánbō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '传播'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传播'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chuánbō',
      meaning_vi = 'lan truyền, truyền bá (thông tin, văn hóa, dịch bệnh, tri thức)',
      example_hanzi = '互联网和社交媒体极大地加快了新闻信息的全球传播速度。',
      example_pinyin = 'Hùliánwǎng hé shèjiāo méitǐ jí dà de jiākuài le xīnwén xìnxī de quánqiú chuánbō sùdù.',
      example_vi = 'Internet và mạng xã hội đã đẩy nhanh cực lớn tốc độ lan truyền thông tin tin tức trên phạm vi toàn cầu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '传播',
      'chuánbō',
      'lan truyền, truyền bá (thông tin, văn hóa, dịch bệnh, tri thức)',
      'Động từ',
      'HSK 5',
      '互联网和社交媒体极大地加快了新闻信息的全球传播速度。',
      'Hùliánwǎng hé shèjiāo méitǐ jí dà de jiākuài le xīnwén xìnxī de quánqiú chuánbō sùdù.',
      'Internet và mạng xã hội đã đẩy nhanh cực lớn tốc độ lan truyền thông tin tin tức trên phạm vi toàn cầu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '互联网和社交媒体极大地加快了新闻信息的全球传播速度。',
        'Hùliánwǎng hé shèjiāo méitǐ jí dà de jiākuài le xīnwén xìnxī de quánqiú chuánbō sùdù.',
        'Internet và mạng xã hội đã đẩy nhanh cực lớn tốc độ lan truyền thông tin tin tức trên phạm vi toàn cầu.',
        'basic',
        1
      ),
      (
        v_id,
        '为了弘扬中华优秀传统文化，文化交流使团通过海外巡回演出与多媒体展览积极开展跨文化国际传播。',
        'Wèile hóngyáng Zhōnghuá yōuxiù chuántǒng wénhuà, wénhuà jiāoliú shǐtuán tōngguò hǎiwài xúnhuí yǎnchū yǔ duōméitǐ zhǎnlǎn jījí kāizhǎn kuà wénhuà guójì chuánbō.',
        'Nhằm tôn vinh văn hóa truyền thống xuất sắc của Trung Hoa, phái đoàn giao lưu văn hóa thông qua các buổi biểu diễn lưu diễn ở nước ngoài và triển lãm đa phương tiện đã tích cực triển khai hoạt động truyền bá quốc tế liên văn hóa.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2184] [传递] (chuándì) - chuyển giao, truyền tay, truyền đạt (thông điệp, ngọn đuốc, tình yêu thương) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '传递' AND pinyin = 'chuándì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传递' AND pinyin = 'chuándì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '传递'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传递'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chuándì',
      meaning_vi = 'chuyển giao, truyền tay, truyền đạt (thông điệp, ngọn đuốc, tình yêu thương)',
      example_hanzi = '奥运圣火接力传递活动吸引了成千上万名热情的市民驻足观看。',
      example_pinyin = 'Àoyùn shènghuǒ jiēlì chuándì huódòng xīyǐn le chéngqiān-shàngwàn míng rèqíng de shìmín zhùzú guānkàn.',
      example_vi = 'Hoạt động chạy rước tiếp sức ngọn đuốc thiêng Olympic đã thu hút hàng nghìn hàng vạn người dân nhiệt tình dừng bước dõi theo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '传递',
      'chuándì',
      'chuyển giao, truyền tay, truyền đạt (thông điệp, ngọn đuốc, tình yêu thương)',
      'Động từ',
      'HSK 5',
      '奥运圣火接力传递活动吸引了成千上万名热情的市民驻足观看。',
      'Àoyùn shènghuǒ jiēlì chuándì huódòng xīyǐn le chéngqiān-shàngwàn míng rèqíng de shìmín zhùzú guānkàn.',
      'Hoạt động chạy rước tiếp sức ngọn đuốc thiêng Olympic đã thu hút hàng nghìn hàng vạn người dân nhiệt tình dừng bước dõi theo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '奥运圣火接力传递活动吸引了成千上万名热情的市民驻足观看。',
        'Àoyùn shènghuǒ jiēlì chuándì huódòng xīyǐn le chéngqiān-shàngwàn míng rèqíng de shìmín zhùzú guānkàn.',
        'Hoạt động chạy rước tiếp sức ngọn đuốc thiêng Olympic đã thu hút hàng nghìn hàng vạn người dân nhiệt tình dừng bước dõi theo.',
        'basic',
        1
      ),
      (
        v_id,
        '公益慈善基金会通过志愿帮扶项目，把全社会的关爱温暖精准传递到每一位偏远山区困难儿童的心坎上。',
        'Gōngyì císhàn jījīnhuì tōngguò zhìyuàn bāngfú xiàngmù, bǎ quán shèhuì de guān’ài wēnnuǎn jīngzhǔn chuándì dào měi yí wèi piānyuǎn shānqū kùnnan értóng de xīnkǎn shàng.',
        'Quỹ từ thiện công ích thông qua dự án giúp đỡ tình nguyện đã truyền tải tình yêu thương ấm áp của toàn xã hội một cách chuẩn xác đến tận sâu đáy lòng của từng em nhỏ có hoàn cảnh khó khăn ở vùng núi xa xôi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2185] [传说] (chuánshuō) - truyền thuyết, câu chuyện dân gian; tương truyền, nghe đồn [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '传说' AND pinyin = 'chuánshuō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传说' AND pinyin = 'chuánshuō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '传说'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传说'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'chuánshuō',
      meaning_vi = 'truyền thuyết, câu chuyện dân gian; tương truyền, nghe đồn',
      example_hanzi = '中国民间广为流传着牛郎织女的美丽爱情神话传说。',
      example_pinyin = 'Zhōngguó mínjiān guǎng wèi liúchuán zhe Niúláng Zhīnǚ de měilì àiqíng shénhuà chuánshuō.',
      example_vi = 'Trong dân gian Trung Quốc lưu truyền rộng rãi câu chuyện thần thoại truyền thuyết tình yêu đẹp đẽ về Ngưu Lang Chức Nữ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '传说',
      'chuánshuō',
      'truyền thuyết, câu chuyện dân gian; tương truyền, nghe đồn',
      'Danh từ / Động từ',
      'HSK 5',
      '中国民间广为流传着牛郎织女的美丽爱情神话传说。',
      'Zhōngguó mínjiān guǎng wèi liúchuán zhe Niúláng Zhīnǚ de měilì àiqíng shénhuà chuánshuō.',
      'Trong dân gian Trung Quốc lưu truyền rộng rãi câu chuyện thần thoại truyền thuyết tình yêu đẹp đẽ về Ngưu Lang Chức Nữ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '中国民间广为流传着牛郎织女的美丽爱情神话传说。',
        'Zhōngguó mínjiān guǎng wèi liúchuán zhe Niúláng Zhīnǚ de měilì àiqíng shénhuà chuánshuō.',
        'Trong dân gian Trung Quốc lưu truyền rộng rãi câu chuyện thần thoại truyền thuyết tình yêu đẹp đẽ về Ngưu Lang Chức Nữ.',
        'basic',
        1
      ),
      (
        v_id,
        '相传这座屹立于绝壁之上的古老寺庙建于东汉年间，千百年来留下了许多引人入胜的民间传说与文人墨客的诗篇题咏。',
        'Xiāngchuán zhè zuò yìlì yú juébì zhī shàng de gǔlǎo sìmiào jiàn yú Dōng Hàn niánjiān, qiān bǎi nián lái liúxià le xǔduō yǐnrénrùshèng de mínjiān chuánshuō yǔ wénrén-mòkè de shīpiān tíyǒng.',
        'Tương truyền ngôi chùa cổ sừng sững trên vách đá cheo leo này được xây dựng từ thời Đông Hán, nghìn trăm năm qua đã để lại biết bao truyền thuyết dân gian cuốn hút lòng người cùng các bài thơ đề vịnh của giới tao nhân mặc khách.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2186] [传统] (chuántǒng) - truyền thống, mang tính cổ truyền lâu đời [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '传统' AND pinyin = 'chuántǒng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传统' AND pinyin = 'chuántǒng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '传统'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '传统'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'chuántǒng',
      meaning_vi = 'truyền thống, mang tính cổ truyền lâu đời',
      example_hanzi = '春节是中华民族最重要的传统节日之一。',
      example_pinyin = 'Chūnjié shì Zhōnghuá mínzú zuì zhòngyào de chuántǒng jiérì zhī yī.',
      example_vi = 'Tết Nguyên đán là một trong những ngày lễ tết truyền thống quan trọng nhất của dân tộc Trung Hoa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '传统',
      'chuántǒng',
      'truyền thống, mang tính cổ truyền lâu đời',
      'Danh từ / Tính từ',
      'HSK 5',
      '春节是中华民族最重要的传统节日之一。',
      'Chūnjié shì Zhōnghuá mínzú zuì zhòngyào de chuántǒng jiérì zhī yī.',
      'Tết Nguyên đán là một trong những ngày lễ tết truyền thống quan trọng nhất của dân tộc Trung Hoa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '春节是中华民族最重要的传统节日之一。',
        'Chūnjié shì Zhōnghuá mínzú zuì zhòngyào de chuántǒng jiérì zhī yī.',
        'Tết Nguyên đán là một trong những ngày lễ tết truyền thống quan trọng nhất của dân tộc Trung Hoa.',
        'basic',
        1
      ),
      (
        v_id,
        '年轻一代非遗传承人打破陈规，将古老的传统景泰蓝工艺与现代时尚潮流审美深度融合，焕发了传统非遗文化的现代生机。',
        'Niánqīng yídài fēiyí chuánchéngrén dǎpò chéngguī, jiāng gǔlǎo de chuántǒng Jǐngtàilán gōngyì yǔ xiàndài shíshàng cháoliú shěnměi shēndù rónghé, huànfā le chuántǒng fēiyí wénhuà de xiàndài shēngjī.',
        'Thế hệ người kế thừa di sản văn hóa phi vật thể trẻ tuổi đã phá bỏ lề thói cũ, kết hợp sâu sắc tay nghề pháp lam Cảnh Thái Lam truyền thống cổ xưa với thẩm mỹ trào lưu thời trang hiện đại, làm bừng sáng sức sống đương đại của văn hóa di sản phi vật thể truyền thống.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2187] [窗台] (chuāngtái) - bệ cửa sổ, gờ cửa sổ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '窗台' AND pinyin = 'chuāngtái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '窗台' AND pinyin = 'chuāngtái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '窗台'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '窗台'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chuāngtái',
      meaning_vi = 'bệ cửa sổ, gờ cửa sổ',
      example_hanzi = '她在朝南的窗台上摆放了几盆绿油油的多肉植物。',
      example_pinyin = 'Tā zài cháo nán de chuāngtái shàng bǎifàng le jǐ pén lǜyóuyóu de duōròu zhíwù.',
      example_vi = 'Cô ấy đặt mấy chậu cây mọng nước xanh mơn mởn trên bệ cửa sổ hướng về phía nam.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '窗台',
      'chuāngtái',
      'bệ cửa sổ, gờ cửa sổ',
      'Danh từ',
      'HSK 5',
      '她在朝南的窗台上摆放了几盆绿油油的多肉植物。',
      'Tā zài cháo nán de chuāngtái shàng bǎifàng le jǐ pén lǜyóuyóu de duōròu zhíwù.',
      'Cô ấy đặt mấy chậu cây mọng nước xanh mơn mởn trên bệ cửa sổ hướng về phía nam.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '她在朝南的窗台上摆放了几盆绿油油的多肉植物。',
        'Tā zài cháo nán de chuāngtái shàng bǎifàng le jǐ pén lǜyóuyóu de duōròu zhíwù.',
        'Cô ấy đặt mấy chậu cây mọng nước xanh mơn mởn trên bệ cửa sổ hướng về phía nam.',
        'basic',
        1
      ),
      (
        v_id,
        '为严防高空坠物险情并确保儿童居家安全，物业管理处在全小区住户群反复提醒切勿在窗台外侧随意堆放花盆及杂物。',
        'Wèi yánfáng gāokōng zhuìwù xiǎnqíng bìng quèbǎo értóng jūjiā ānquán, wùyè guǎnlǐchù zài quán xiǎoqū zhùhù qún fǎnfù tíxǐng qièwù zài chuāngtái wàicè suíyì duīfàng huāpén jí záwù.',
        'Nhằm phòng ngừa nghiêm ngặt hiểm họa rơi đồ từ trên cao và bảo đảm an toàn cho trẻ em tại nhà, ban quản lý tòa nhà trong nhóm cư dân toàn khu chung cư đã liên tục nhắc nhở tuyệt đối không tùy tiện chất đống chậu hoa và đồ linh tinh bên ngoài bệ cửa sổ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2188] [床单] (chuángdān) - ga trải giường, drap trải giường [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '床单' AND pinyin = 'chuángdān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '床单' AND pinyin = 'chuángdān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '床单'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '床单'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'chuángdān',
      meaning_vi = 'ga trải giường, drap trải giường',
      example_hanzi = '妈妈把刚洗干净晒干的纯棉床单整齐地铺在了床上。',
      example_pinyin = 'Māma bǎ gāng xǐ gānjìng shài gān de chúnmián chuángdān zhěngqí de pū zài le chuáng shàng.',
      example_vi = 'Mẹ đem chiếc ga trải giường bằng vải cotton vừa giặt sạch phơi khô trải thật phẳng phiu lên giường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '床单',
      'chuángdān',
      'ga trải giường, drap trải giường',
      'Danh từ',
      'HSK 5',
      '妈妈把刚洗干净晒干的纯棉床单整齐地铺在了床上。',
      'Māma bǎ gāng xǐ gānjìng shài gān de chúnmián chuángdān zhěngqí de pū zài le chuáng shàng.',
      'Mẹ đem chiếc ga trải giường bằng vải cotton vừa giặt sạch phơi khô trải thật phẳng phiu lên giường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '妈妈把刚洗干净晒干的纯棉床单整齐地铺在了床上。',
        'Māma bǎ gāng xǐ gānjìng shài gān de chúnmián chuángdān zhěngqí de pū zài le chuáng shàng.',
        'Mẹ đem chiếc ga trải giường bằng vải cotton vừa giặt sạch phơi khô trải thật phẳng phiu lên giường.',
        'basic',
        1
      ),
      (
        v_id,
        '星级涉外酒店客房部制定了极为严苛的卫生消毒操作标准，每位客人退房后所有床单、被套均必须实行“一客一换一消毒”。',
        'Xīngjí shèwài jiǔdiàn kèfángbù zhìdìng le jíwéi yánkē de wèishēng xiāodú cāozuò biāozhǔn, měi wèi kèrén tuìfáng hòu suǒyǒu chuángdān, bèitào jūn bìxū shíxíng “yí kè yí huàn yí xiāodú”.',
        'Bộ phận buồng phòng khách sạn đón khách quốc tế xếp hạng sao đã ban hành tiêu chuẩn thao tác vệ sinh khử trùng cực kỳ nghiêm ngặt, sau khi mỗi một vị khách trả phòng toàn bộ ga giường, vỏ chăn đều bắt buộc phải thực hiện “mỗi lượt khách thay mới và khử trùng một lần”.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2189] [创新] (chuàngxīn) - đổi mới sáng tạo; sự đổi mới mang tính đột phá [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '创新' AND pinyin = 'chuàngxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '创新' AND pinyin = 'chuàngxīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '创新'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '创新'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'chuàngxīn',
      meaning_vi = 'đổi mới sáng tạo; sự đổi mới mang tính đột phá',
      example_hanzi = '青年科技人才富有朝气，是推动国家科技创新的生力军。',
      example_pinyin = 'Qīngnián kējì réncái fùyǒu zhāoqì, shì tuīdòng guójiā kējì chuàngxīn de shēnglìjūn.',
      example_vi = 'Nhân tài khoa học công nghệ trẻ tuổi tràn đầy nhiệt huyết, là lực lượng xung kích thúc đẩy đổi mới sáng tạo khoa học công nghệ của đất nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '创新',
      'chuàngxīn',
      'đổi mới sáng tạo; sự đổi mới mang tính đột phá',
      'Động từ / Danh từ',
      'HSK 5',
      '青年科技人才富有朝气，是推动国家科技创新的生力军。',
      'Qīngnián kējì réncái fùyǒu zhāoqì, shì tuīdòng guójiā kējì chuàngxīn de shēnglìjūn.',
      'Nhân tài khoa học công nghệ trẻ tuổi tràn đầy nhiệt huyết, là lực lượng xung kích thúc đẩy đổi mới sáng tạo khoa học công nghệ của đất nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '青年科技人才富有朝气，是推动国家科技创新的生力军。',
        'Qīngnián kējì réncái fùyǒu zhāoqì, shì tuīdòng guójiā kējì chuàngxīn de shēnglìjūn.',
        'Nhân tài khoa học công nghệ trẻ tuổi tràn đầy nhiệt huyết, là lực lượng xung kích thúc đẩy đổi mới sáng tạo khoa học công nghệ của đất nước.',
        'basic',
        1
      ),
      (
        v_id,
        '高科技企业必须坚持把自主创新摆在核心全局位置，不断加大关键核心技术研发攻关，牢牢掌握产业发展的主动权。',
        'Gāokējì qǐyè bìxū jiānchí bǎ zìzhǔ chuàngxīn bǎi zài héxīn quánjú wèizhì, búduàn jiàdà guānjiàn héxīn jìshù yánfā gōngguān, láoláo zhǎngwò chǎnyè fāzhǎn de zhǔdòngquán.',
        'Doanh nghiệp công nghệ cao bắt buộc phải kiên trì đặt tự chủ đổi mới sáng tạo vào vị trí cốt lõi toàn cục, không ngừng gia tăng đầu tư nghiên cứu các công nghệ lõi then chốt, nắm chắc trong tay quyền chủ động phát triển ngành nghề.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2190] [创业] (chuàngyè) - khởi nghiệp, lập nghiệp, mở doanh nghiệp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '创业' AND pinyin = 'chuàngyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '创业' AND pinyin = 'chuàngyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '创业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '创业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chuàngyè',
      meaning_vi = 'khởi nghiệp, lập nghiệp, mở doanh nghiệp',
      example_hanzi = '大学毕业后，他和几位志同道合的同学一起留在大城市自主创业。',
      example_pinyin = 'Dàxué bìyè hòu, tā hé jǐ wèi zhìtóng-dàohé de tóngxué yìqǐ liú zài dà chéngshì zìzhǔ chuàngyè.',
      example_vi = 'Sau khi tốt nghiệp đại học, anh ấy cùng vài người bạn học cùng chung chí hướng đã ở lại thành phố lớn tự chủ khởi nghiệp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '创业',
      'chuàngyè',
      'khởi nghiệp, lập nghiệp, mở doanh nghiệp',
      'Động từ',
      'HSK 5',
      '大学毕业后，他和几位志同道合的同学一起留在大城市自主创业。',
      'Dàxué bìyè hòu, tā hé jǐ wèi zhìtóng-dàohé de tóngxué yìqǐ liú zài dà chéngshì zìzhǔ chuàngyè.',
      'Sau khi tốt nghiệp đại học, anh ấy cùng vài người bạn học cùng chung chí hướng đã ở lại thành phố lớn tự chủ khởi nghiệp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '大学毕业后，他和几位志同道合的同学一起留在大城市自主创业。',
        'Dàxué bìyè hòu, tā hé jǐ wèi zhìtóng-dàohé de tóngxué yìqǐ liú zài dà chéngshì zìzhǔ chuàngyè.',
        'Sau khi tốt nghiệp đại học, anh ấy cùng vài người bạn học cùng chung chí hướng đã ở lại thành phố lớn tự chủ khởi nghiệp.',
        'basic',
        1
      ),
      (
        v_id,
        '政府设立了专门的青年科技创新创业扶持引导基金，为初创高新企业提供低成本办公场地、税收减免与融资对接全方位支持。',
        'Zhèngfǔ shèlì le zhuānmén de qīngnián kējì chuàngxīn chuàngyè fúchí yǐndǎo jījīn, wèi chūchuàng gāoxīn qǐyè tígōng dī chéngběn bàngōng chǎngdì, shuìshōu jiǎnmiǎn yǔ róngzī duìjiē quán fāngwèi zhīchí.',
        'Chính phủ đã thành lập quỹ hướng dẫn hỗ trợ đổi mới sáng tạo khởi nghiệp khoa học công nghệ cho thanh niên chuyên trách, cung cấp sự hỗ trợ toàn diện về mặt bằng văn phòng chi phí thấp, miễn giảm thuế và kết nối huy động vốn cho các doanh nghiệp công nghệ cao mới thành lập.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2191] [创造] (chuàngzào) - sáng tạo ra, tạo nên (giá trị, kỳ tích, điều kiện thuận lợi) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '创造' AND pinyin = 'chuàngzào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '创造' AND pinyin = 'chuàngzào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '创造'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '创造'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'chuàngzào',
      meaning_vi = 'sáng tạo ra, tạo nên (giá trị, kỳ tích, điều kiện thuận lợi)',
      example_hanzi = '劳动人民用勤劳的双手和智慧创造了璀璨辉煌的人类文明。',
      example_pinyin = 'Láodòng rénmín yòng qínláo de shuāngshǒu hé zhìhuì chuàngzào le cuǐcàn huīhuáng de rénlèi wénmíng.',
      example_vi = 'Nhân dân lao động dùng đôi bàn tay cần cù và trí tuệ sáng tạo nên nền văn minh nhân loại rực rỡ huy hoàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '创造',
      'chuàngzào',
      'sáng tạo ra, tạo nên (giá trị, kỳ tích, điều kiện thuận lợi)',
      'Động từ',
      'HSK 5',
      '劳动人民用勤劳的双手和智慧创造了璀璨辉煌的人类文明。',
      'Láodòng rénmín yòng qínláo de shuāngshǒu hé zhìhuì chuàngzào le cuǐcàn huīhuáng de rénlèi wénmíng.',
      'Nhân dân lao động dùng đôi bàn tay cần cù và trí tuệ sáng tạo nên nền văn minh nhân loại rực rỡ huy hoàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '劳动人民用勤劳的双手和智慧创造了璀璨辉煌的人类文明。',
        'Láodòng rénmín yòng qínláo de shuāngshǒu hé zhìhuì chuàngzào le cuǐcàn huīhuáng de rénlèi wénmíng.',
        'Nhân dân lao động dùng đôi bàn tay cần cù và trí tuệ sáng tạo nên nền văn minh nhân loại rực rỡ huy hoàng.',
        'basic',
        1
      ),
      (
        v_id,
        '中国航天科技工作者凭借自主攻坚与无私奉献精神，在极短时间内独立建成了空间站，创造了世界载人航天史上的又一伟大奇迹。',
        'Zhōngguó hángtiān kējì gōngzuòzhě píngjiè zìzhǔ gōngjiān yǔ wúsī fèngxiàn jīngshén, zài jí duǎn shíjiān nèi dúlì jiànchéng le kōngjiānzhàn, chuàngzào le shìjiè zàirén hángtiān shǐ shàng de yòu yí wěidà qíjī.',
        'Các cán bộ nghiên cứu công nghệ hàng không vũ trụ Trung Quốc dựa vào tinh thần tự lực khắc phục khó khăn và cống hiến quên mình, trong thời gian cực ngắn đã độc lập xây dựng hoàn thành trạm không gian, tạo nên thêm một kỳ tích vĩ đại trong lịch sử vũ trụ có người lái của thế giới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2192] [创作] (chuàngzuò) - sáng tác (văn học, nghệ thuật, âm nhạc, hội họa); tác phẩm sáng tác [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '创作' AND pinyin = 'chuàngzuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '创作' AND pinyin = 'chuàngzuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '创作'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '创作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'chuàngzuò',
      meaning_vi = 'sáng tác (văn học, nghệ thuật, âm nhạc, hội họa); tác phẩm sáng tác',
      example_hanzi = '这位音乐家在漫长的旅途中汲取灵感，创作出了许多脍炙人口的优美歌曲。',
      example_pinyin = 'Zhè wèi yīnyuèjiā zài màncháng de lǚtú zhōng jíqǔ línggǎn, chuàngzuò chū le xǔduō kuàizhì-rénkǒu de yōuměi gēqǔ.',
      example_vi = 'Nhà soạn nhạc này trong suốt hành trình du ngoạn dài dằng dặc đã thu thập cảm hứng, sáng tác nên nhiều ca khúc tuyệt vời đi vào lòng người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '创作',
      'chuàngzuò',
      'sáng tác (văn học, nghệ thuật, âm nhạc, hội họa); tác phẩm sáng tác',
      'Động từ / Danh từ',
      'HSK 5',
      '这位音乐家在漫长的旅途中汲取灵感，创作出了许多脍炙人口的优美歌曲。',
      'Zhè wèi yīnyuèjiā zài màncháng de lǚtú zhōng jíqǔ línggǎn, chuàngzuò chū le xǔduō kuàizhì-rénkǒu de yōuměi gēqǔ.',
      'Nhà soạn nhạc này trong suốt hành trình du ngoạn dài dằng dặc đã thu thập cảm hứng, sáng tác nên nhiều ca khúc tuyệt vời đi vào lòng người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这位音乐家在漫长的旅途中汲取灵感，创作出了许多脍炙人口的优美歌曲。',
        'Zhè wèi yīnyuèjiā zài màncháng de lǚtú zhōng jíqǔ línggǎn, chuàngzuò chū le xǔduō kuàizhì-rénkǒu de yōuměi gēqǔ.',
        'Nhà soạn nhạc này trong suốt hành trình du ngoạn dài dằng dặc đã thu thập cảm hứng, sáng tác nên nhiều ca khúc tuyệt vời đi vào lòng người.',
        'basic',
        1
      ),
      (
        v_id,
        '文艺工作者应当深入基层现实生活与人民群众之中，潜心打磨具有鲜明时代特色与深刻思想内涵的高峰艺术创作力作。',
        'Wényì gōngzuòzhě yīngdāng shēnrù jīcéng xiànshí shēnghuó yǔ rénmín qúnzhòng zhī zhōng, qiǎnxīn dǎmó jùyǒu xiānmíng shídài tèsè yǔ shēnkè sīxiǎng nèihán de gāofēng yìshù chuàngzuò lìzuò.',
        'Những người làm công tác văn học nghệ thuật nên đi sâu vào đời sống thực tế cơ sở và quần chúng nhân dân, dốc lòng gọt giũa nên những kiệt tác sáng tác nghệ thuật đỉnh cao mang đậm nét đặc sắc thời đại và nội hàm tư tưởng sâu sắc.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2193] [词汇] (cíhuì) - từ vựng, vốn từ trong một ngôn ngữ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '词汇' AND pinyin = 'cíhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '词汇' AND pinyin = 'cíhuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '词汇'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '词汇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'cíhuì',
      meaning_vi = 'từ vựng, vốn từ trong một ngôn ngữ',
      example_hanzi = '扩大汉语词汇量是提高中文阅读理解和写作表达能力的必由之路。',
      example_pinyin = 'Kuòdà Hànyǔ cíhuìliàng shì tígāo Zhōngwén yuèdú lǐjiě hé xiězuò biǎodá nénglì de bìyóuzhīlù.',
      example_vi = 'Mở rộng vốn từ vựng tiếng Hán là con đường tất yếu để nâng cao khả năng đọc hiểu và viết lách diễn đạt bằng tiếng Trung.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '词汇',
      'cíhuì',
      'từ vựng, vốn từ trong một ngôn ngữ',
      'Danh từ',
      'HSK 5',
      '扩大汉语词汇量是提高中文阅读理解和写作表达能力的必由之路。',
      'Kuòdà Hànyǔ cíhuìliàng shì tígāo Zhōngwén yuèdú lǐjiě hé xiězuò biǎodá nénglì de bìyóuzhīlù.',
      'Mở rộng vốn từ vựng tiếng Hán là con đường tất yếu để nâng cao khả năng đọc hiểu và viết lách diễn đạt bằng tiếng Trung.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '扩大汉语词汇量是提高中文阅读理解和写作表达能力的必由之路。',
        'Kuòdà Hànyǔ cíhuìliàng shì tígāo Zhōngwén yuèdú lǐjiě hé xiězuò biǎodá nénglì de bìyóuzhīlù.',
        'Mở rộng vốn từ vựng tiếng Hán là con đường tất yếu để nâng cao khả năng đọc hiểu và viết lách diễn đạt bằng tiếng Trung.',
        'basic',
        1
      ),
      (
        v_id,
        '新版汉语水平考试等级标准结合时代发展语境，科学规范地补充收录了大量反映现代数字经济与网络科技前沿的新生词汇。',
        'Xīnbǎn Hànyǔ Shuǐpíng Kǎoshì děngjí biāozhǔn jiéhé shídài fāzhǎn yǔjìng, kēxué guīfàn de bǔchōng shōulù le dàliàng fǎnyìng xiàndài shùzì jīngjì yǔ wǎngluò kējì qiányán de xīnshēng cíhuì.',
        'Tiêu chuẩn cấp độ thi HSK phiên bản mới kết hợp ngữ cảnh phát triển thời đại, đã bổ sung và thu nạp một cách khoa học quy phạm số lượng lớn các từ vựng mới sinh phản ánh nền kinh tế số hiện đại và công nghệ mạng tiên phong.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2194] [辞职] (cízhí) - từ chức, xin thôi việc, xin nghỉ việc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '辞职' AND pinyin = 'cízhí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '辞职' AND pinyin = 'cízhí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '辞职'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '辞职'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cízhí',
      meaning_vi = 'từ chức, xin thôi việc, xin nghỉ việc',
      example_hanzi = '为了全心全意照顾身患重病的母亲，他艰难决定向单位递交辞职信。',
      example_pinyin = 'Wèile quánxīn-quányì zhàogù shēnhuàn zhòngbìng de mǔqīn, tā jiānnán juédìng xiàng dānwèi dìjiāo cízhíxìn.',
      example_vi = 'Để toàn tâm toàn ý chăm sóc mẹ già mắc bệnh nặng, anh ấy đã đưa ra quyết định khó khăn nộp đơn xin thôi việc lên cơ quan.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '辞职',
      'cízhí',
      'từ chức, xin thôi việc, xin nghỉ việc',
      'Động từ',
      'HSK 5',
      '为了全心全意照顾身患重病的母亲，他艰难决定向单位递交辞职信。',
      'Wèile quánxīn-quányì zhàogù shēnhuàn zhòngbìng de mǔqīn, tā jiānnán juédìng xiàng dānwèi dìjiāo cízhíxìn.',
      'Để toàn tâm toàn ý chăm sóc mẹ già mắc bệnh nặng, anh ấy đã đưa ra quyết định khó khăn nộp đơn xin thôi việc lên cơ quan.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '为了全心全意照顾身患重病的母亲，他艰难决定向单位递交辞职信。',
        'Wèile quánxīn-quányì zhàogù shēnhuàn zhòngbìng de mǔqīn, tā jiānnán juédìng xiàng dānwèi dìjiāo cízhíxìn.',
        'Để toàn tâm toàn ý chăm sóc mẹ già mắc bệnh nặng, anh ấy đã đưa ra quyết định khó khăn nộp đơn xin thôi việc lên cơ quan.',
        'basic',
        1
      ),
      (
        v_id,
        '按照劳动合同法规定，员工如因个人职业发展规划拟申请离职，通常需提前三十日以书面形式向用人单位提出正式辞职报告。',
        'Ànzhào láodòng hétong fǎ guīdìng, yuángōng rú yīn gèrén zhíyè fāzhǎn guīhuà nǐ shēnqǐng lízhí, tōngcháng xū tíqián sānshí rì yǐ shūmiàn xíngshì xiàng yòngrén dānwèi tíchū zhèngshì cízhí bàogào.',
        'Theo quy định của luật hợp đồng lao động, nhân viên nếu vì quy hoạch phát triển nghề nghiệp cá nhân mà muốn làm thủ tục nghỉ việc, thông thường cần gửi báo cáo xin thôi việc chính thức bằng văn bản cho đơn vị sử dụng lao động trước ba mươi ngày.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2195] [此后] (cǐhòu) - sau đó, từ đó về sau, kể từ đó [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '此后' AND pinyin = 'cǐhòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '此后' AND pinyin = 'cǐhòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '此后'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '此后'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'cǐhòu',
      meaning_vi = 'sau đó, từ đó về sau, kể từ đó',
      example_hanzi = '经过那次深刻的教训之后，他此后再也没有在考试中粗心大意过。',
      example_pinyin = 'Jīngguò nà cì shēnkè de jiàoxùn zhīhòu, tā cǐhòu zài yě méiyǒu zài kǎoshì zhōng cūxīn-dàyì guò.',
      example_vi = 'Sau bài học nhớ đời sâu sắc lần đó, anh ấy từ đó về sau không bao giờ lơ là bất cẩn trong các kỳ thi nữa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '此后',
      'cǐhòu',
      'sau đó, từ đó về sau, kể từ đó',
      'Danh từ',
      'HSK 5',
      '经过那次深刻的教训之后，他此后再也没有在考试中粗心大意过。',
      'Jīngguò nà cì shēnkè de jiàoxùn zhīhòu, tā cǐhòu zài yě méiyǒu zài kǎoshì zhōng cūxīn-dàyì guò.',
      'Sau bài học nhớ đời sâu sắc lần đó, anh ấy từ đó về sau không bao giờ lơ là bất cẩn trong các kỳ thi nữa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '经过那次深刻的教训之后，他此后再也没有在考试中粗心大意过。',
        'Jīngguò nà cì shēnkè de jiàoxùn zhīhòu, tā cǐhòu zài yě méiyǒu zài kǎoshì zhōng cūxīn-dàyì guò.',
        'Sau bài học nhớ đời sâu sắc lần đó, anh ấy từ đó về sau không bao giờ lơ là bất cẩn trong các kỳ thi nữa.',
        'basic',
        1
      ),
      (
        v_id,
        '双方在国际经贸博览会上签署了战略合作备忘录，此后双方在清洁能源与智能制造领域的深度合作全面铺开。',
        'Shuāngfāng zài guójì jīng-mào bólǎnhuì shàng qiānshǔ le zhànlüè hézuò bèiwànglù, cǐhòu shuāngfāng zài qīngjié néngyuán yǔ zhìnéng zhìzào lǐngyù de shēndù hézuò quánmiàn pūkāi.',
        'Hai bên đã ký kết biên bản ghi nhớ hợp tác chiến lược tại hội chợ triển lãm kinh tế thương mại quốc tế, kể từ đó sự hợp tác sâu rộng của hai bên trong lĩnh vực năng lượng sạch và sản xuất thông minh đã được mở ra toàn diện.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2196] [此前] (cǐqián) - trước đó, trước thời điểm này [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '此前' AND pinyin = 'cǐqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '此前' AND pinyin = 'cǐqián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '此前'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '此前'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'cǐqián',
      meaning_vi = 'trước đó, trước thời điểm này',
      example_hanzi = '在此前进行的三次模拟考试中，他的总成绩一直稳居年级前五名。',
      example_pinyin = 'Zài cǐqián jìnxíng de sān cì mónǐ kǎoshì zhōng, tā de zǒng chéngjì yìzhí wěnjū niánjí qián wǔ míng.',
      example_vi = 'Trong ba lần thi thử được tiến hành trước đó, tổng điểm của bạn ấy luôn vững vàng nằm trong top năm của khối lớp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '此前',
      'cǐqián',
      'trước đó, trước thời điểm này',
      'Danh từ',
      'HSK 5',
      '在此前进行的三次模拟考试中，他的总成绩一直稳居年级前五名。',
      'Zài cǐqián jìnxíng de sān cì mónǐ kǎoshì zhōng, tā de zǒng chéngjì yìzhí wěnjū niánjí qián wǔ míng.',
      'Trong ba lần thi thử được tiến hành trước đó, tổng điểm của bạn ấy luôn vững vàng nằm trong top năm của khối lớp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在此前进行的三次模拟考试中，他的总成绩一直稳居年级前五名。',
        'Zài cǐqián jìnxíng de sān cì mónǐ kǎoshì zhōng, tā de zǒng chéngjì yìzhí wěnjū niánjí qián wǔ míng.',
        'Trong ba lần thi thử được tiến hành trước đó, tổng điểm của bạn ấy luôn vững vàng nằm trong top năm của khối lớp.',
        'basic',
        1
      ),
      (
        v_id,
        '发言人严正澄清指出，此前在互联网和境外社交媒体上广为流传的所谓内部裁员降薪文件纯属虚构伪造。',
        'Fāyánrén yánzhèng chéngqīng zhǐchū, cǐqián zài hùliánwǎng hé jìngwài shèjiāo méitǐ shàng guǎng wèi liúchuán de suǒwèi nèibù cáiyuán jiàngxīn wénjiàn chúnshǔ xūgòu wěizào.',
        'Người phát ngôn nghiêm túc đính chính chỉ rõ, cái gọi là văn bản nội bộ sa thải nhân sự cắt giảm tiền lương lưu truyền rầm rộ trên internet và mạng xã hội nước ngoài trước đó hoàn toàn là bịa đặt giả mạo.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2197] [此时] (cǐshí) - lúc này, thời điểm này, giờ phút này [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '此时' AND pinyin = 'cǐshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '此时' AND pinyin = 'cǐshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '此时'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '此时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'cǐshí',
      meaning_vi = 'lúc này, thời điểm này, giờ phút này',
      example_hanzi = '此时此刻，天空中升起了绚烂璀璨的节日节日烟花。',
      example_pinyin = 'Cǐshí-cǐkè, tiānkōng zhōng shēngqǐ le xuànlàn cuǐcàn de jiérì yānhuā.',
      example_vi = 'Ngay trong giờ phút này, trên bầu trời đã bừng sáng những chùm pháo hoa ngày tết rực rỡ muôn màu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '此时',
      'cǐshí',
      'lúc này, thời điểm này, giờ phút này',
      'Danh từ',
      'HSK 5',
      '此时此刻，天空中升起了绚烂璀璨的节日节日烟花。',
      'Cǐshí-cǐkè, tiānkōng zhōng shēngqǐ le xuànlàn cuǐcàn de jiérì yānhuā.',
      'Ngay trong giờ phút này, trên bầu trời đã bừng sáng những chùm pháo hoa ngày tết rực rỡ muôn màu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '此时此刻，天空中升起了绚烂璀璨的节日节日烟花。',
        'Cǐshí-cǐkè, tiānkōng zhōng shēngqǐ le xuànlàn cuǐcàn de jiérì yānhuā.',
        'Ngay trong giờ phút này, trên bầu trời đã bừng sáng những chùm pháo hoa ngày tết rực rỡ muôn màu.',
        'basic',
        1
      ),
      (
        v_id,
        '面对突如其来的剧烈市场行情震荡，此时保持高度理智与冷静客观的风险意识比盲目恐慌抛售重要千百倍。',
        'Miànduì tūrúqílái de jùliè shìchǎng hángqíng zhèndàng, cǐshí bǎochí gāodù lǐzhì yǔ lěngjìng kèguān de fēngxiǎn yìshí bǐ mángmù kǒnghuāng pāoshòu zhòngyào qiān bǎi bèi.',
        'Đối mặt với sự rung lắc dữ dội bất ngờ của diễn biến thị trường, lúc này việc giữ vững lý trí cao độ và ý thức rủi ro khách quan bình tĩnh quan trọng gấp trăm ngàn lần so với việc hoảng loạn bán tháo mù quáng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2198] [刺激] (cìjī) - kích thích, thúc đẩy; gây sốc, kịch tính, gay cấn cảm giác mạnh [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '刺激' AND pinyin = 'cìjī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '刺激' AND pinyin = 'cìjī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '刺激'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '刺激'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'cìjī',
      meaning_vi = 'kích thích, thúc đẩy; gây sốc, kịch tính, gay cấn cảm giác mạnh',
      example_hanzi = '高山滑雪是一项非常惊险刺激的冬季户外极限运动。',
      example_pinyin = 'Gāoshān huáxuě shì yí xiàng fēicháng jīngxiǎn cìjī de dōngjì hùwài jíxiàn yùndòng.',
      example_vi = 'Trượt tuyết trên núi cao là một môn thể thao mạo hiểm ngoài trời mùa đông vô cùng thót tim và cảm giác mạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '刺激',
      'cìjī',
      'kích thích, thúc đẩy; gây sốc, kịch tính, gay cấn cảm giác mạnh',
      'Động từ / Tính từ',
      'HSK 5',
      '高山滑雪是一项非常惊险刺激的冬季户外极限运动。',
      'Gāoshān huáxuě shì yí xiàng fēicháng jīngxiǎn cìjī de dōngjì hùwài jíxiàn yùndòng.',
      'Trượt tuyết trên núi cao là một môn thể thao mạo hiểm ngoài trời mùa đông vô cùng thót tim và cảm giác mạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '高山滑雪是一项非常惊险刺激的冬季户外极限运动。',
        'Gāoshān huáxuě shì yí xiàng fēicháng jīngxiǎn cìjī de dōngjì hùwài jíxiàn yùndòng.',
        'Trượt tuyết trên núi cao là một môn thể thao mạo hiểm ngoài trời mùa đông vô cùng thót tim và cảm giác mạnh.',
        'basic',
        1
      ),
      (
        v_id,
        '为了提振消费信心并有效激发国内市场需求，商务部联合多部委出台了一揽子刺激汽车与家电“以旧换新”的有力举措。',
        'Wèile tìzhèn xiāofèi xìnxīn bìng yǒuxiào jīfā guónèi shìchǎng xūqiú, Shāngwùbù liánhé duō bùwěi chūtái le yì lǎnzǐ cìjī qìchē yǔ jiādiàn “yǐjiù-huànxīn” de yǒulì jǔcuò.',
        'Nhằm thúc đẩy niềm tin tiêu dùng và khơi dậy hiệu quả nhu cầu thị trường nội địa, Bộ Thương mại phối hợp nhiều bộ ngành đã ban hành gói giải pháp mạnh mẽ kích thích chương trình “thu cũ đổi mới” cho ô tô và đồ điện gia dụng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2199] [从不] (cóng bù) - không bao giờ, chưa từng, từ trước tới nay chưa hề [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '从不' AND pinyin = 'cóng bù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '从不' AND pinyin = 'cóng bù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '从不'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '从不'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'cóng bù',
      meaning_vi = 'không bao giờ, chưa từng, từ trước tới nay chưa hề',
      example_hanzi = '李老师对待工作极其严谨认真，从不迟到早退。',
      example_pinyin = 'Lǐ lǎoshī duìdài gōngzuò jíqí yánjǐn rènzhēn, cóng bù chídào zǎotuì.',
      example_vi = 'Thầy Lý đối đãi với công việc cực kỳ cẩn trọng nghiêm túc, không bao giờ đi muộn về sớm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '从不',
      'cóng bù',
      'không bao giờ, chưa từng, từ trước tới nay chưa hề',
      'Phó từ',
      'HSK 5',
      '李老师对待工作极其严谨认真，从不迟到早退。',
      'Lǐ lǎoshī duìdài gōngzuò jíqí yánjǐn rènzhēn, cóng bù chídào zǎotuì.',
      'Thầy Lý đối đãi với công việc cực kỳ cẩn trọng nghiêm túc, không bao giờ đi muộn về sớm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '李老师对待工作极其严谨认真，从不迟到早退。',
        'Lǐ lǎoshī duìdài gōngzuò jíqí yánjǐn rènzhēn, cóng bù chídào zǎotuì.',
        'Thầy Lý đối đãi với công việc cực kỳ cẩn trọng nghiêm túc, không bao giờ đi muộn về sớm.',
        'basic',
        1
      ),
      (
        v_id,
        '一位真正胸怀高远的学者在追寻真理的坎坷道路上，从不因暂时的挫折与外界的误解而动摇心中的学术信念。',
        'Yí wèi zhēnzhèng xiōnghuái gāoyuǎn de xuézhě zài zhuīxún zhēnlǐ de kǎnkě dàolù shàng, cóng bù yīn zànshí de cuòzhé yǔ wàijiè de wùjiě ér dòngyáo xīn zhōng de xuéshù xìnniàn.',
        'Một học giả thực sự có tầm nhìn cao rộng trên con đường gập ghềnh tìm kiếm chân lý, không bao giờ vì những trắc trở tạm thời hay sự hiểu lầm của bên ngoài mà lung lay niềm tin học thuật nơi đáy lòng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2200] [从而] (cóng’ér) - do đó, từ đó mà, nhờ vậy mà (kết nối nguyên nhân - kết quả/mục đích) [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '从而' AND pinyin = 'cóng’ér'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '从而' AND pinyin = 'cóng’ér'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '从而'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '从而'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'cóng’ér',
      meaning_vi = 'do đó, từ đó mà, nhờ vậy mà (kết nối nguyên nhân - kết quả/mục đích)',
      example_hanzi = '每天坚持背诵二十个生词，从而稳步提升了中文阅读和写作能力。',
      example_pinyin = 'Měitiān jiānchí bèisòng èrshí gè shēngcí, cóng’ér wěnbù tíshēng le Zhōngwén yuèdú hé xiězuò nénglì.',
      example_vi = 'Mỗi ngày kiên trì học thuộc hai mươi từ mới, từ đó mà từng bước nâng cao vững chắc khả năng đọc hiểu và viết văn tiếng Trung.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '从而',
      'cóng’ér',
      'do đó, từ đó mà, nhờ vậy mà (kết nối nguyên nhân - kết quả/mục đích)',
      'Liên từ',
      'HSK 5',
      '每天坚持背诵二十个生词，从而稳步提升了中文阅读和写作能力。',
      'Měitiān jiānchí bèisòng èrshí gè shēngcí, cóng’ér wěnbù tíshēng le Zhōngwén yuèdú hé xiězuò nénglì.',
      'Mỗi ngày kiên trì học thuộc hai mươi từ mới, từ đó mà từng bước nâng cao vững chắc khả năng đọc hiểu và viết văn tiếng Trung.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '每天坚持背诵二十个生词，从而稳步提升了中文阅读和写作能力。',
        'Měitiān jiānchí bèisòng èrshí gè shēngcí, cóng’ér wěnbù tíshēng le Zhōngwén yuèdú hé xiězuò nénglì.',
        'Mỗi ngày kiên trì học thuộc hai mươi từ mới, từ đó mà từng bước nâng cao vững chắc khả năng đọc hiểu và viết văn tiếng Trung.',
        'basic',
        1
      ),
      (
        v_id,
        '制造企业通过全流程推行自动化流水线作业，大幅降低了次品率并节约了人工成本，从而在激烈的国际出口市场竞争中赢得了巨大价格优势。',
        'Zhìzào qǐyè tōngguò quán liúchéng tuīxíng zìdònghuà liúshuǐxiàn zuòyè, dà fú jiàngdī le cìpǐnlǜ bìng jiéyuē le réngōng chéngběn, cóng’ér zài jīliè de guójì chūkǒu shìchǎng jìngzhēng zhōng yíngdé le jùdà jiàgé yōushì.',
        'Doanh nghiệp chế tạo thông qua việc đẩy mạnh vận hành dây chuyền tự động hóa toàn quy trình, đã cắt giảm đáng kể tỷ lệ phế phẩm và tiết kiệm chi phí nhân công, nhờ đó mà giành được ưu thế giá cả khổng lồ trong cuộc cạnh tranh thị trường xuất khẩu quốc tế gay gắt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp câu ví dụ HSK 5 - Batch 2: đã xử lý % từ vựng.', v_count;
END $$;
