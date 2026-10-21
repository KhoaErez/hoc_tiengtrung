-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 16 (FINAL BATCH)
-- Phạm vi: #3502 [直播] (zhíbō) -> #3600 [作出] (zuòchū)
-- Tổng số câu ví dụ: 198 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- ĐẠT MỐC: 1.600 / 1.600 TỪ HSK 5 THEO CHUẨN ĐỀ CƯƠNG HSK 3.0 (GF 0025-2021)
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
  -- [3502] [直播] (zhíbō) - phát sóng trực tiếp, livestream [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '直播' AND pinyin = 'zhíbō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '直播' AND pinyin = 'zhíbō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '直播'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '直播'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhíbō',
      meaning_vi = 'phát sóng trực tiếp, livestream',
      example_hanzi = '今晚八点电视台将对全国青年歌手大奖赛总决赛进行现场高清直播。',
      example_pinyin = 'Jīnwǎn bā diǎn diànshìtái jiāng duì quánguó qīngnián gēshǒu dàjiǎngsài zǒngjuésài jìnxíng xiànchǎng gāoqīng zhíbō.',
      example_vi = 'Tám giờ tối nay đài truyền hình sẽ phát sóng trực tiếp độ nét cao hiện trường trận chung kết cuộc thi giải ca sĩ trẻ toàn quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '直播',
      'zhíbō',
      'phát sóng trực tiếp, livestream',
      'Động từ / Danh từ',
      'HSK 5',
      '今晚八点电视台将对全国青年歌手大奖赛总决赛进行现场高清直播。',
      'Jīnwǎn bā diǎn diànshìtái jiāng duì quánguó qīngnián gēshǒu dàjiǎngsài zǒngjuésài jìnxíng xiànchǎng gāoqīng zhíbō.',
      'Tám giờ tối nay đài truyền hình sẽ phát sóng trực tiếp độ nét cao hiện trường trận chung kết cuộc thi giải ca sĩ trẻ toàn quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今晚八点电视台将对全国青年歌手大奖赛总决赛进行现场高清直播。', 'Jīnwǎn bā diǎn diànshìtái jiāng duì quánguó qīngnián gēshǒu dàjiǎngsài zǒngjuésài jìnxíng xiànchǎng gāoqīng zhíbō.', 'Tám giờ tối nay đài truyền hình sẽ phát sóng trực tiếp độ nét cao hiện trường trận chung kết cuộc thi giải ca sĩ trẻ toàn quốc.', 'basic', 1),
      (v_id, '乡村振兴电商直播基地通过5G超低延迟直播技术将优质高山有机农产品直接销往全国各大一线城市。', 'Xiāngcūn zhènxīng diànshāng zhíbō jīdì tōngguò 5G chāo-dī yánchí zhíbō jìshù jiāng yōuzhì gāoshān yǒujī nóngchǎnpǐn zhíjiē xiāo wǎng quánguó gè dà yīxiàn chéngshì.', 'Căn cứ livestream thương mại điện tử chấn hưng nông thôn thông qua công nghệ phát trực tiếp độ trễ siêu thấp 5G đã bán trực tiếp nông sản hữu cơ vùng núi cao chất lượng ưu việt tới các thành phố tuyến một trên toàn quốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3503] [职场] (zhíchǎng) - chốn công sở, môi trường làm việc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '职场' AND pinyin = 'zhíchǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '职场' AND pinyin = 'zhíchǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '职场'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '职场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhíchǎng',
      meaning_vi = 'chốn công sở, môi trường làm việc',
      example_hanzi = '刚刚大学毕业踏入职场的新人，应当虚心向经验丰富的老同事请教业务知识。',
      example_pinyin = 'Gānggāng dàxué bìyè tà rù zhíchǎng de xīnrén, yīngdāng xūxīn xiàng jīngyàn fēngfù de lǎo tóngshì qǐngjiào yèwù zhīshi.',
      example_vi = 'Những người mới vừa tốt nghiệp đại học bước chân vào chốn công sở nên khiêm tốn thỉnh giáo kiến thức nghiệp vụ từ các đồng nghiệp lâu năm giàu kinh nghiệm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '职场',
      'zhíchǎng',
      'chốn công sở, môi trường làm việc',
      'Danh từ',
      'HSK 5',
      '刚刚大学毕业踏入职场的新人，应当虚心向经验丰富的老同事请教业务知识。',
      'Gānggāng dàxué bìyè tà rù zhíchǎng de xīnrén, yīngdāng xūxīn xiàng jīngyàn fēngfù de lǎo tóngshì qǐngjiào yèwù zhīshi.',
      'Những người mới vừa tốt nghiệp đại học bước chân vào chốn công sở nên khiêm tốn thỉnh giáo kiến thức nghiệp vụ từ các đồng nghiệp lâu năm giàu kinh nghiệm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '刚刚大学毕业踏入职场的新人，应当虚心向经验丰富的老同事请教业务知识。', 'Gānggāng dàxué bìyè tà rù zhíchǎng de xīnrén, yīngdāng xūxīn xiàng jīngyàn fēngfù de lǎo tóngshì qǐngjiào yèwù zhīshi.', 'Những người mới vừa tốt nghiệp đại học bước chân vào chốn công sở nên khiêm tốn thỉnh giáo kiến thức nghiệp vụ từ các đồng nghiệp lâu năm giàu kinh nghiệm.', 'basic', 1),
      (v_id, '现代职场不仅高度看重专业技术硬实力，更加强调跨部门敏捷沟通协作、情绪韧性与持续学习能力等综合软实力。', 'Xiàndài zhíchǎng bù jǐn gāodù kànzhòng zhuānyè jìshù yìng-shílì, gèngjiā qiángdiào kuà-bùmén mǐnjié gōutōng xiézuò, qíngxù rènxìng yǔ chíxù xuéxí nénglì děng zōnghé ruǎn-shílì.', 'Môi trường làm việc hiện đại không chỉ đánh giá rất cao năng lực cứng về kỹ thuật chuyên môn, mà còn nhấn mạnh hơn nữa các năng lực mềm tổng hợp như giao tiếp cộng tác liên phòng ban linh hoạt, độ bền bỉ cảm xúc và khả năng không ngừng học hỏi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3504] [职工] (zhígōng) - cán bộ công nhân viên, người lao động [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '职工' AND pinyin = 'zhígōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '职工' AND pinyin = 'zhígōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '职工'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '职工'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhígōng',
      meaning_vi = 'cán bộ công nhân viên, người lao động',
      example_hanzi = '为了丰富广大职工的业余文体生活，工会组织在周末举办了职工羽毛球友谊赛。',
      example_pinyin = 'Wèile fēngfù guǎngdà zhígōng de yèyú wéntǐ shēnghuó, gōnghuì zǔzhī zài zhōumò jǔbàn le zhígōng yǔmáoqiú yǒuyìsài.',
      example_vi = 'Để làm phong phú đời sống văn thể mỹ ngoài giờ của đông đảo cán bộ công nhân viên, tổ chức công đoàn đã tổ chức giải cầu lông hữu nghị cán bộ công nhân viên vào dịp cuối tuần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '职工',
      'zhígōng',
      'cán bộ công nhân viên, người lao động',
      'Danh từ',
      'HSK 5',
      '为了丰富广大职工的业余文体生活，工会组织在周末举办了职工羽毛球友谊赛。',
      'Wèile fēngfù guǎngdà zhígōng de yèyú wéntǐ shēnghuó, gōnghuì zǔzhī zài zhōumò jǔbàn le zhígōng yǔmáoqiú yǒuyìsài.',
      'Để làm phong phú đời sống văn thể mỹ ngoài giờ của đông đảo cán bộ công nhân viên, tổ chức công đoàn đã tổ chức giải cầu lông hữu nghị cán bộ công nhân viên vào dịp cuối tuần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了丰富广大职工的业余文体生活，工会组织在周末举办了职工羽毛球友谊赛。', 'Wèile fēngfù guǎngdà zhígōng de yèyú wéntǐ shēnghuó, gōnghuì zǔzhī zài zhōumò jǔbàn le zhígōng yǔmáoqiú yǒuyìsài.', 'Để làm phong phú đời sống văn thể mỹ ngoài giờ của đông đảo cán bộ công nhân viên, tổ chức công đoàn đã tổ chức giải cầu lông hữu nghị cán bộ công nhân viên vào dịp cuối tuần.', 'basic', 1),
      (v_id, '大型国有制造集团严格健全职工代表大会民主决策程序，依法切实保障一线产业工人在劳动报酬与安全防护上的法定权益。', 'Dàxíng guóyǒu zhìzào jítuán yángé jiànquán zhígōng dàibiǎo dàhuì mínzhǔ juécè chéngxù, yīfǎ qièshí bǎozhàng yīxiàn chǎnyè gōngrén zài láodòng bàochóu yǔ ānquán fánghù shang de fǎdìng quányì.', 'Tập đoàn chế tạo quốc doanh quy mô lớn hoàn thiện nghiêm ngặt quy trình ra quyết định dân chủ của đại hội đại biểu cán bộ công nhân viên, bảo đảm thực chất theo luật định quyền lợi hợp pháp về thù lao lao động và bảo hộ an toàn của công nhân công nghiệp tuyến đầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3505] [执行] (zhíxíng) - chấp hành, thực thi, thi hành [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '执行' AND pinyin = 'zhíxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '执行' AND pinyin = 'zhíxíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '执行'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '执行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'zhíxíng',
      meaning_vi = 'chấp hành, thực thi, thi hành',
      example_hanzi = '所有员工在进入工业生产车间前，都必须严格执行佩戴防尘口罩与安全帽的安全规程。',
      example_pinyin = 'Suǒyǒu yuángōng zài jìnrù gōngyè shēngchǎn chējiān qián, dōu bìxū yángé zhíxíng pèidài fángchén kǒuzhào yǔ ānquánmào de ānquán guīchéng.',
      example_vi = 'Tất cả nhân viên trước khi bước vào phân xưởng sản xuất công nghiệp đều phải chấp hành nghiêm ngặt quy trình an toàn là đeo khẩu trang chống bụi và mũ bảo hộ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '执行',
      'zhíxíng',
      'chấp hành, thực thi, thi hành',
      'Động từ / Tính từ',
      'HSK 5',
      '所有员工在进入工业生产车间前，都必须严格执行佩戴防尘口罩与安全帽的安全规程。',
      'Suǒyǒu yuángōng zài jìnrù gōngyè shēngchǎn chējiān qián, dōu bìxū yángé zhíxíng pèidài fángchén kǒuzhào yǔ ānquánmào de ānquán guīchéng.',
      'Tất cả nhân viên trước khi bước vào phân xưởng sản xuất công nghiệp đều phải chấp hành nghiêm ngặt quy trình an toàn là đeo khẩu trang chống bụi và mũ bảo hộ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '所有员工在进入工业生产车间前，都必须严格执行佩戴防尘口罩与安全帽的安全规程。', 'Suǒyǒu yuángōng zài jìnrù gōngyè shēngchǎn chējiān qián, dōu bìxū yángé zhíxíng pèidài fángchén kǒuzhào yǔ ānquánmào de ānquán guīchéng.', 'Tất cả nhân viên trước khi bước vào phân xưởng sản xuất công nghiệp đều phải chấp hành nghiêm ngặt quy trình an toàn là đeo khẩu trang chống bụi và mũ bảo hộ.', 'basic', 1),
      (v_id, '商业银行风险合规管理委员会要求各分支机构穿透式严格执行反洗钱监管指令与宏观审慎资本约束指标。', 'Shāngwè yínháng fēngxiǎn hégūi guǎnlǐ wěiyuánhuì yāoqiú gè fēnzhī jīgòu chuāntòushì yángé zhíxíng fǎn-xǐqián jiānguǎn zhǐlìng yǔ hóngguān shěnshèn zīběn yuēshù zhǐbiāo.', 'Hội đồng quản lý tuân thủ rủi ro ngân hàng thương mại yêu cầu các chi nhánh thực thi nghiêm ngặt mang tính xuyên thấu các chỉ thị giám sát chống rửa tiền và chỉ tiêu kiềm chế vốn thận trọng vĩ mô.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3506] [止] (zhǐ) - ngừng, thôi, chấm dứt, đình chỉ; ngăn chặn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '止' AND pinyin = 'zhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '止' AND pinyin = 'zhǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '止'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '止'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǐ',
      meaning_vi = 'ngừng, thôi, chấm dứt, đình chỉ; ngăn chặn',
      example_hanzi = '医护人员用无菌纱布轻轻按压在伤口上，很快就帮助患者把血止住了。',
      example_pinyin = 'Yīhù rényuán yòng wújūn shābù qīngqīng ànyā zài shāngkǒu shang, hěn kuài jiù bāngzhù huànzhě bǎ xiě zhǐ zhù le.',
      example_vi = 'Nhân viên y tế dùng gạc vô trùng ấn nhẹ lên vết thương, rất nhanh chóng đã giúp bệnh nhân cầm được máu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '止',
      'zhǐ',
      'ngừng, thôi, chấm dứt, đình chỉ; ngăn chặn',
      'Động từ',
      'HSK 5',
      '医护人员用无菌纱布轻轻按压在伤口上，很快就帮助患者把血止住了。',
      'Yīhù rényuán yòng wújūn shābù qīngqīng ànyā zài shāngkǒu shang, hěn kuài jiù bāngzhù huànzhě bǎ xiě zhǐ zhù le.',
      'Nhân viên y tế dùng gạc vô trùng ấn nhẹ lên vết thương, rất nhanh chóng đã giúp bệnh nhân cầm được máu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医护人员用无菌纱布轻轻按压在伤口上，很快就帮助患者把血止住了。', 'Yīhù rényuán yòng wújūn shābù qīngqīng ànyā zài shāngkǒu shang, hěn kuài jiù bāngzhù huànzhě bǎ xiě zhǐ zhù le.', 'Nhân viên y tế dùng gạc vô trùng ấn nhẹ lên vết thương, rất nhanh chóng đã giúp bệnh nhân cầm được máu.', 'basic', 1),
      (v_id, '科技企业必须牢固树立知止有定的合规伦理防线，决不能为追逐商业暴利而突破法律法规与人工智能数据向善的道德底线。', 'Kējì qǐyè bìxū láogù shùlì zhīzhǐ-yǒudìng de hégūi lúnlǐ fángxiàn, jué bù néng wèi zhuīzhú shāngyè bàolì ér tūpò fǎlǜ fǎguī yǔ réngōng zhìnéng shùjù xiàngshàn de dàodé dǐxiàn.', 'Doanh nghiệp công nghệ bắt buộc phải xác lập vững chắc phòng tuyến đạo đức tuân thủ biết điểm dừng có định hướng, tuyệt đối không vì săn đón lợi nhuận kinh doanh khổng lồ mà phá vỡ ranh giới đỏ đạo đức về hướng thiện dữ liệu AI và luật pháp quy định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3507] [指导] (zhǐdǎo) - chỉ đạo, hướng dẫn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '指导' AND pinyin = 'zhǐdǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '指导' AND pinyin = 'zhǐdǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '指导'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '指导'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhǐdǎo',
      meaning_vi = 'chỉ đạo, hướng dẫn',
      example_hanzi = '在经验丰富的指导老师耐心点拨下，他只用了两天时间就顺利完成了毕业论文的开题报告。',
      example_pinyin = 'Zài jīngyàn fēngfù de zhǐdǎo lǎoshī nàixīn diǎnbō xià, tā zhǐ yòng le liǎng tiān shíjiān jiù shùnlì wánchéng le bìyè lùnwén de kāití bàogào.',
      example_vi = 'Dưới sự hướng dẫn gợi mở kiên nhẫn của người giáo viên hướng dẫn giàu kinh nghiệm, anh ấy chỉ mất hai ngày là đã hoàn thành thuận lợi đề cương nghiên cứu khóa luận tốt nghiệp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '指导',
      'zhǐdǎo',
      'chỉ đạo, hướng dẫn',
      'Động từ / Danh từ',
      'HSK 5',
      '在经验丰富的指导老师耐心点拨下，他只用了两天时间就顺利完成了毕业论文的开题报告。',
      'Zài jīngyàn fēngfù de zhǐdǎo lǎoshī nàixīn diǎnbō xià, tā zhǐ yòng le liǎng tiān shíjiān jiù shùnlì wánchéng le bìyè lùnwén de kāití bàogào.',
      'Dưới sự hướng dẫn gợi mở kiên nhẫn của người giáo viên hướng dẫn giàu kinh nghiệm, anh ấy chỉ mất hai ngày là đã hoàn thành thuận lợi đề cương nghiên cứu khóa luận tốt nghiệp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在经验丰富的指导老师耐心点拨下，他只用了两天时间就顺利完成了毕业论文的开题报告。', 'Zài jīngyàn fēngfù de zhǐdǎo lǎoshī nàixīn diǎnbō xià, tā zhǐ yòng le liǎng tiān shíjiān jiù shùnlì wánchéng le bìyè lùnwén de kāití bàogào.', 'Dưới sự hướng dẫn gợi mở kiên nhẫn của người giáo viên hướng dẫn giàu kinh nghiệm, anh ấy chỉ mất hai ngày là đã hoàn thành thuận lợi đề cương nghiên cứu khóa luận tốt nghiệp.', 'basic', 1),
      (v_id, '国务院国资委出台专项合规指导意见，指导中央企业在全球跨国投资与境外并购交易中健全全流程海外法律合规风控体系。', 'Guówùyuàn Guózīwěi chūtái zhuānxiàng hégūi zhǐdǎo yìjiàn, zhǐdǎo zhōngyāng qǐyè zài quánqiú kuàguó tóuzī yǔ jìngwài bìnggòu jiāoyì zhōng jiànquán quán-liúchéng hǎiwài fǎlǜ hégūi fēngkòng tǐxì.', 'Ủy ban Quản lý Vốn Nhà nước thuộc Quốc vụ viện đã ban hành ý kiến chỉ đạo tuân thủ chuyên đề, hướng dẫn các doanh nghiệp trung ương hoàn thiện hệ thống kiểm soát rủi ro tuân thủ pháp lý hải ngoại toàn quy trình trong các giao dịch sáp nhập mua lại ở nước ngoài và đầu tư xuyên quốc gia toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3508] [至] (zhì) - đến, tới; cho đến [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '至' AND pinyin = 'zhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '至' AND pinyin = 'zhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '至'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '至'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Giới từ',
      pinyin = 'zhì',
      meaning_vi = 'đến, tới; cho đến',
      example_hanzi = '本次高校春季图书展销会将于五月一日至五月五日在综合体育馆主馆隆重举行。',
      example_pinyin = 'Běncì gāoxiào chūnjì túshū zhǎnxiāohuì jiāng yú wǔ yuè yī rì zhì wǔ yuè wǔ rì zài zōnghé tǐyùguǎn zhǔguǎn lóngzhòng jǔxíng.',
      example_vi = 'Hội chợ triển lãm sách mùa xuân các trường đại học lần này sẽ được tổ chức long trọng từ ngày 1 tháng 5 đến ngày 5 tháng 5 tại nhà thi đấu tổng hợp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '至',
      'zhì',
      'đến, tới; cho đến',
      'Động từ / Giới từ',
      'HSK 5',
      '本次高校春季图书展销会将于五月一日至五月五日在综合体育馆主馆隆重举行。',
      'Běncì gāoxiào chūnjì túshū zhǎnxiāohuì jiāng yú wǔ yuè yī rì zhì wǔ yuè wǔ rì zài zōnghé tǐyùguǎn zhǔguǎn lóngzhòng jǔxíng.',
      'Hội chợ triển lãm sách mùa xuân các trường đại học lần này sẽ được tổ chức long trọng từ ngày 1 tháng 5 đến ngày 5 tháng 5 tại nhà thi đấu tổng hợp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '本次高校春季图书展销会将于五月一日至五月五日在综合体育馆主馆隆重举行。', 'Běncì gāoxiào chūnjì túshū zhǎnxiāohuì jiāng yú wǔ yuè yī rì zhì wǔ yuè wǔ rì zài zōnghé tǐyùguǎn zhǔguǎn lóngzhòng jǔxíng.', 'Hội chợ triển lãm sách mùa xuân các trường đại học lần này sẽ được tổ chức long trọng từ ngày 1 tháng 5 đến ngày 5 tháng 5 tại nhà thi đấu tổng hợp.', 'basic', 1),
      (v_id, '跨大西洋海底超高速光缆将洲际互联网金融交易信息传输延迟大幅压缩至微秒级别，构筑了全球高频量化交易的数字基石。', 'Kuà-Dàxīyáng hǎidǐ chāo-gāosù guānglǎn jiāng zhōujì hùliánwǎng jīnróng jiāoyì xìnxī chuánshū yánchí dàfú yāsuō zhì wēimiǎojí jíbié, gòuzhù le quánqiú gāopín liànghuà jiāoyì de shùzì jīshí.', 'Tuyến cáp quang siêu tốc dưới đáy biển xuyên Đại Tây Dương đã nén mạnh độ trễ truyền dẫn thông tin giao dịch tài chính internet liên lục địa xuống tới cấp vi giây (microsecond), xây dựng nền móng số cho giao dịch định lượng cao tần toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3509] [治] (zhì) - chữa trị; cai trị, quản trị, xử lý [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '治' AND pinyin = 'zhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '治' AND pinyin = 'zhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '治'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '治'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhì',
      meaning_vi = 'chữa trị; cai trị, quản trị, xử lý',
      example_hanzi = '中医主张通过辨证施治和调整饮食作息来从根本上调理身体、治愈慢性疾病。',
      example_pinyin = 'Zhōngyī zhǔzhāng tōngguò biànzhèng-shīzhì hé tiáozhěng yǐnshí zuòxī lái cóng gēnběn shang tiáolǐ shēntǐ, zhìyù mànxìng jíbìng.',
      example_vi = 'Đông y chủ trương thông qua việc biện chứng thi trị và điều chỉnh ăn uống nghỉ ngơi để điều dưỡng cơ thể từ gốc rễ và chữa khỏi các bệnh mãn tính.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '治',
      'zhì',
      'chữa trị; cai trị, quản trị, xử lý',
      'Động từ',
      'HSK 5',
      '中医主张通过辨证施治和调整饮食作息来从根本上调理身体、治愈慢性疾病。',
      'Zhōngyī zhǔzhāng tōngguò biànzhèng-shīzhì hé tiáozhěng yǐnshí zuòxī lái cóng gēnběn shang tiáolǐ shēntǐ, zhìyù mànxìng jíbìng.',
      'Đông y chủ trương thông qua việc biện chứng thi trị và điều chỉnh ăn uống nghỉ ngơi để điều dưỡng cơ thể từ gốc rễ và chữa khỏi các bệnh mãn tính.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中医主张通过辨证施治和调整饮食作息来从根本上调理身体、治愈慢性疾病。', 'Zhōngyī zhǔzhāng tōngguò biànzhèng-shīzhì hé tiáozhěng yǐnshí zuòxī lái cóng gēnběn shang tiáolǐ shēntǐ, zhìyù mànxìng jíbìng.', 'Đông y chủ trương thông qua việc biện chứng thi trị và điều chỉnh ăn uống nghỉ ngơi để điều dưỡng cơ thể từ gốc rễ và chữa khỏi các bệnh mãn tính.', 'basic', 1),
      (v_id, '流域生态环境保护必须坚持山水林田湖草沙一体化保护和系统治理，全方位遏制农业面源污染与工业水土流失。', 'Liúyù shēngtài huánjìng bǎohù bìxū jiānchí shān shuǐ lín tián hú cǎo shā yītǐhuà bǎohù hé xìtǒng zhìlǐ, quán-fāngwèi èzhì nóngyè miànyuán wūrǎn yǔ gōngyè shuǐtǔ liúshī.', 'Bảo vệ môi trường sinh thái lưu vực bắt buộc phải kiên trì bảo vệ nhất thể hóa và quản trị có hệ thống núi, nước, rừng, ruộng, hồ, cỏ, cát, ngăn chặn toàn diện ô nhiễm nguồn nông nghiệp và xói mòn đất nước công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3510] [制订] (zhìdìng) - soạn thảo, lập ra, xây dựng (kế hoạch, dự thảo) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '制订' AND pinyin = 'zhìdìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制订' AND pinyin = 'zhìdìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '制订'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制订'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhìdìng',
      meaning_vi = 'soạn thảo, lập ra, xây dựng (kế hoạch, dự thảo)',
      example_hanzi = '为了迎接即将到来的期末考试，班长组织大家共同制订了一份切实可行的集体复习计划。',
      example_pinyin = 'Wèile yíngjiē jíjiāng dàolái de qīmò kǎoshì, bānzhǎng zǔzhī dàjiā gòngtóng zhìdìng le yí fèn qièshí-kěxíng de jítǐ fùxí jìhuà.',
      example_vi = 'Để đón kỳ thi cuối kỳ sắp tới, lớp trưởng đã tổ chức cho mọi người cùng nhau lập ra một bản kế hoạch ôn tập tập thể khả thi và thiết thực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '制订',
      'zhìdìng',
      'soạn thảo, lập ra, xây dựng (kế hoạch, dự thảo)',
      'Động từ',
      'HSK 5',
      '为了迎接即将到来的期末考试，班长组织大家共同制订了一份切实可行的集体复习计划。',
      'Wèile yíngjiē jíjiāng dàolái de qīmò kǎoshì, bānzhǎng zǔzhī dàjiā gòngtóng zhìdìng le yí fèn qièshí-kěxíng de jítǐ fùxí jìhuà.',
      'Để đón kỳ thi cuối kỳ sắp tới, lớp trưởng đã tổ chức cho mọi người cùng nhau lập ra một bản kế hoạch ôn tập tập thể khả thi và thiết thực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了迎接即将到来的期末考试，班长组织大家共同制订了一份切实可行的集体复习计划。', 'Wèile yíngjiē jíjiāng dàolái de qīmò kǎoshì, bānzhǎng zǔzhī dàjiā gòngtóng zhìdìng le yí fèn qièshí-kěxíng de jítǐ fùxí jìhuà.', 'Để đón kỳ thi cuối kỳ sắp tới, lớp trưởng đã tổ chức cho mọi người cùng nhau lập ra một bản kế hoạch ôn tập tập thể khả thi và thiết thực.', 'basic', 1),
      (v_id, '跨部门联合工作组正在抓紧制订支持战略性新兴产业高质量发展的专项财税激励政策实施细则草案。', 'Kuà-bùmén liánhé gōngzuòzǔ zhèngzài zhuājǐn zhìdìng zhīchí zhànlüèxìng xīnxīng chǎnyè gāozhìliàng fāzhǎn de zhuānxiàng cái-shuì jīlì zhèngcè shíshī xìzé cǎo''àn.', 'Tổ công tác liên bộ ngành đang khẩn trương soạn thảo dự thảo thông tư hướng dẫn chi tiết thực hiện chính sách khuyến khích tài chính thuế chuyên đề hỗ trợ các ngành công nghiệp mới nổi mang tính chiến lược phát triển chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3511] [制定] (zhìdìng) - ban hành, định ra, chế định (luật pháp, quy chế chính thức) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '制定' AND pinyin = 'zhìdìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制定' AND pinyin = 'zhìdìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '制定'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhìdìng',
      meaning_vi = 'ban hành, định ra, chế định (luật pháp, quy chế chính thức)',
      example_hanzi = '学校管理层根据广大家长的反馈意见，重新制定了更为合理的学生食堂营养配餐标准。',
      example_pinyin = 'Xuéxiào guǎnlǐcéng gēnjù guǎngdà jiāzhǎng de fǎnkuì yìjiàn, chóngxīn zhìdìng le gèngwéi hélǐ de xuésheng shítáng yíngyǎng pèicān biāozhǔn.',
      example_vi = 'Ban giám hiệu nhà trường dựa theo ý kiến phản hồi của đông đảo phụ huynh đã định ra lại tiêu chuẩn chia suất ăn dinh dưỡng bếp ăn học sinh hợp lý hơn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '制定',
      'zhìdìng',
      'ban hành, định ra, chế định (luật pháp, quy chế chính thức)',
      'Động từ',
      'HSK 5',
      '学校管理层根据广大家长的反馈意见，重新制定了更为合理的学生食堂营养配餐标准。',
      'Xuéxiào guǎnlǐcéng gēnjù guǎngdà jiāzhǎng de fǎnkuì yìjiàn, chóngxīn zhìdìng le gèngwéi hélǐ de xuésheng shítáng yíngyǎng pèicān biāozhǔn.',
      'Ban giám hiệu nhà trường dựa theo ý kiến phản hồi của đông đảo phụ huynh đã định ra lại tiêu chuẩn chia suất ăn dinh dưỡng bếp ăn học sinh hợp lý hơn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校管理层根据广大家长的反馈意见，重新制定了更为合理的学生食堂营养配餐标准。', 'Xuéxiào guǎnlǐcéng gēnjù guǎngdà jiāzhǎng de fǎnkuì yìjiàn, chóngxīn zhìdìng le gèngwéi hélǐ de xuésheng shítáng yíngyǎng pèicān biāozhǔn.', 'Ban giám hiệu nhà trường dựa theo ý kiến phản hồi của đông đảo phụ huynh đã định ra lại tiêu chuẩn chia suất ăn dinh dưỡng bếp ăn học sinh hợp lý hơn.', 'basic', 1),
      (v_id, '全国人民代表大会常务委员会审议并正式表决通过制定《中华人民共和国数据安全法》，构建了国家数字主权防护的根本法律基石。', 'Quánguó Rénmín Dàibiǎo Dàhuì Chángwù Wěiyuánhuì shěnyì bìng zhèngshì biǎojué tōngguò zhìdìng "Zhōnghuá Rénmín Gònghéguó Shùjù Ānquán Fǎ", gòujiàn le guójiā shùzì zhǔquán fánghù de gēnběn fǎlǜ jīshí.', 'Ủy ban Thường vụ Đại hội Đại biểu Nhân dân Toàn quốc đã thẩm nghị và biểu quyết chính thức thông qua việc ban hành "Luật An toàn Dữ liệu Nước Cộng hòa Xã hội Chủ nghĩa Trung Hoa", thiết lập nền móng pháp lý căn bản bảo vệ chủ quyền số quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3512] [制度] (zhìdù) - chế độ, thể chế, quy chế [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '制度' AND pinyin = 'zhìdù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制度' AND pinyin = 'zhìdù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '制度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhìdù',
      meaning_vi = 'chế độ, thể chế, quy chế',
      example_hanzi = '新员工入职培训的第一课，就是认真学习并严格遵守公司的各项规章制度与考勤纪律。',
      example_pinyin = 'Xīn yuángōng rùzhí péixùn de dì-yī kè, jiù shì rènzhēn xuéxí bìng yángé zūnshǒu gōngsī de gè xiàng guīzhāng zhìdù yǔ kǎoqín jìlǜ.',
      example_vi = 'Bài học đầu tiên của khóa đào tạo hội nhập nhân viên mới chính là nghiêm túc học tập và tuân thủ nghiêm ngặt các nội quy quy chế cùng kỷ luật chấm công của công ty.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '制度',
      'zhìdù',
      'chế độ, thể chế, quy chế',
      'Danh từ',
      'HSK 5',
      '新员工入职培训的第一课，就是认真学习并严格遵守公司的各项规章制度与考勤纪律。',
      'Xīn yuángōng rùzhí péixùn de dì-yī kè, jiù shì rènzhēn xuéxí bìng yángé zūnshǒu gōngsī de gè xiàng guīzhāng zhìdù yǔ kǎoqín jìlǜ.',
      'Bài học đầu tiên của khóa đào tạo hội nhập nhân viên mới chính là nghiêm túc học tập và tuân thủ nghiêm ngặt các nội quy quy chế cùng kỷ luật chấm công của công ty.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新员工入职培训的第一课，就是认真学习并严格遵守公司的各项规章制度与考勤纪律。', 'Xīn yuángōng rùzhí péixùn de dì-yī kè, jiù shì rènzhēn xuéxí bìng yángé zūnshǒu gōngsī de gè xiàng guīzhāng zhìdù yǔ kǎoqín jìlǜ.', 'Bài học đầu tiên của khóa đào tạo hội nhập nhân viên mới chính là nghiêm túc học tập và tuân thủ nghiêm ngặt các nội quy quy chế cùng kỷ luật chấm công của công ty.', 'basic', 1),
      (v_id, '健全现代预算管理制度与地方政府债务长效防范化解机制，是保障国家财政平稳可持续运行的根本制度保障。', 'Jiànquán xiàndài yùsuàn guǎnlǐ zhìdù yǔ dìfāng zhèngfǔ zhàiwù chángxiào fángfàn huàjiě jīzhì, shì bǎozhàng guójiā cáizhèng píngwěn kěchíxù yùnxíng de gēnběn zhìdù bǎozhàng.', 'Hoàn thiện chế độ quản lý ngân sách hiện đại và cơ chế hữu hiệu lâu dài phòng ngừa giải tỏa nợ chính quyền địa phương là sự bảo đảm thể chế căn bản giúp tài chính quốc gia vận hành bình ổn và bền vững.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3513] [智慧] (zhìhuì) - trí tuệ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '智慧' AND pinyin = 'zhìhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '智慧' AND pinyin = 'zhìhuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '智慧'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '智慧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhìhuì',
      meaning_vi = 'trí tuệ',
      example_hanzi = '这位老学者凭借一生的丰富阅历和人生智慧，为前来请教的年轻创业者指明了方向。',
      example_pinyin = 'Zhè wèi lǎo xuézhě píngjiè yìshēng de fēngfù yuèlì hé rénshēng zhìhuì, wèi qiánlái qǐngjiào de niánqīng chuàngyèzhě zhǐmíng le fāngxiàng.',
      example_vi = 'Vị học giả cao tuổi này dựa vào vốn trải nghiệm phong phú cả một đời và trí tuệ nhân sinh đã chỉ rõ phương hướng cho người khởi nghiệp trẻ tuổi đến thỉnh giáo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '智慧',
      'zhìhuì',
      'trí tuệ',
      'Danh từ',
      'HSK 5',
      '这位老学者凭借一生的丰富阅历和人生智慧，为前来请教的年轻创业者指明了方向。',
      'Zhè wèi lǎo xuézhě píngjiè yìshēng de fēngfù yuèlì hé rénshēng zhìhuì, wèi qiánlái qǐngjiào de niánqīng chuàngyèzhě zhǐmíng le fāngxiàng.',
      'Vị học giả cao tuổi này dựa vào vốn trải nghiệm phong phú cả một đời và trí tuệ nhân sinh đã chỉ rõ phương hướng cho người khởi nghiệp trẻ tuổi đến thỉnh giáo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位老学者凭借一生的丰富阅历和人生智慧，为前来请教的年轻创业者指明了方向。', 'Zhè wèi lǎo xuézhě píngjiè yìshēng de fēngfù yuèlì hé rénshēng zhìhuì, wèi qiánlái qǐngjiào de niánqīng chuàngyèzhě zhǐmíng le fāngxiàng.', 'Vị học giả cao tuổi này dựa vào vốn trải nghiệm phong phú cả một đời và trí tuệ nhân sinh đã chỉ rõ phương hướng cho người khởi nghiệp trẻ tuổi đến thỉnh giáo.', 'basic', 1),
      (v_id, '智慧城市数字化中枢运用数字孪生建模技术全面聚合交通、气象与应急管网大数据，实现超大城市精细化敏捷治理。', 'Zhìhuì chéngshì shùzìhuà zhōngshū yùnyòng shùzì luánshēng jiànmó jìshù quánmiàn jùhé jiāotōng, qìxiàng yǔ yīngjí guǎnwǎng dà-shùjù, shíxiàn chāo-dà chéngshì jīngxìhuà mǐnjié zhìlǐ.', 'Bộ não kỹ thuật số đô thị thông minh vận dụng công nghệ mô hình hóa bản sao kỹ thuật số để tổng hợp toàn diện dữ liệu lớn về giao thông, khí tượng và mạng lưới đường ống khẩn cấp, hiện thực hóa việc quản trị đô thị siêu lớn một cách tinh vi và linh hoạt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3514] [至今] (zhìjīn) - cho đến nay, đến tận bây giờ [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '至今' AND pinyin = 'zhìjīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '至今' AND pinyin = 'zhìjīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '至今'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '至今'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'zhìjīn',
      meaning_vi = 'cho đến nay, đến tận bây giờ',
      example_hanzi = '那本小学毕业时同班好友赠送给我的精美集邮册，至今我依然完好地珍藏在书房的抽屉里。',
      example_pinyin = 'Nà běn xiǎoxué bìyè shí tóngbān hǎoyǒu zèngsòng gěi wǒ de jīngměi jíyóucè, zhìjīn wǒ yīrán wánhǎo de zhēncáng zài shūfáng de chōuti lǐ.',
      example_vi = 'Cuốn sổ sưu tập tem tinh xảo mà người bạn thân cùng lớp tặng tôi hồi tốt nghiệp tiểu học, cho đến nay tôi vẫn trân trọng cất giữ nguyên vẹn trong ngăn kéo phòng đọc sách.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '至今',
      'zhìjīn',
      'cho đến nay, đến tận bây giờ',
      'Phó từ',
      'HSK 5',
      '那本小学毕业时同班好友赠送给我的精美集邮册，至今我依然完好地珍藏在书房的抽屉里。',
      'Nà běn xiǎoxué bìyè shí tóngbān hǎoyǒu zèngsòng gěi wǒ de jīngměi jíyóucè, zhìjīn wǒ yīrán wánhǎo de zhēncáng zài shūfáng de chōuti lǐ.',
      'Cuốn sổ sưu tập tem tinh xảo mà người bạn thân cùng lớp tặng tôi hồi tốt nghiệp tiểu học, cho đến nay tôi vẫn trân trọng cất giữ nguyên vẹn trong ngăn kéo phòng đọc sách.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '那本小学毕业时同班好友赠送给我的精美集邮册，至今我依然完好地珍藏在书房的抽屉里。', 'Nà běn xiǎoxué bìyè shí tóngbān hǎoyǒu zèngsòng gěi wǒ de jīngměi jíyóucè, zhìjīn wǒ yīrán wánhǎo de zhēncáng zài shūfáng de chōuti lǐ.', 'Cuốn sổ sưu tập tem tinh xảo mà người bạn thân cùng lớp tặng tôi hồi tốt nghiệp tiểu học, cho đến nay tôi vẫn trân trọng cất giữ nguyên vẹn trong ngăn kéo phòng đọc sách.', 'basic', 1),
      (v_id, '尽管量子物理学在微观粒子实验观测上取得了巨大成功，但将引力理论与量子场论完美统一的万物理论构想至今仍是未解之谜。', 'Jǐnguǎn liàngzǐ wùlǐxué zài wēiguān lìzǐ shíyàn guāncè shang qǔdé le jùdà chénggōng, dàn jiāng yǐnlì lǐlùn yǔ liàngzǐ chǎnglùn wánměi tǒngyī de wànwù lǐlùn gòuxiǎng zhìjīn réng shì wèijiě zhī mǐ.', 'Mặc dù vật lý lượng tử đã đạt được thành công to lớn trong quan sát thực nghiệm hạt vi mô, nhưng ý niệm lý thuyết vạn vật thống nhất hoàn hảo thuyết hấp dẫn với lý thuyết trường lượng tử cho đến tận ngày nay vẫn là câu đố chưa có lời giải.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3515] [治疗] (zhìliáo) - điều trị, chữa trị [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '治疗' AND pinyin = 'zhìliáo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '治疗' AND pinyin = 'zhìliáo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '治疗'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '治疗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhìliáo',
      meaning_vi = 'điều trị, chữa trị',
      example_hanzi = '患者只要遵照医嘱按时服药并积极配合康复治疗，骨折部位在两三个月内便能痊愈。',
      example_pinyin = 'Huànzhě zhǐyào zūnlzhào yīzhǔ ànshí fúyào bìng jījí pèihé kāngfù zhìliáo, gǔzhé bùwèi zài liǎng-sān ge yuè nèi biàn néng quányù.',
      example_vi = 'Người bệnh chỉ cần tuân theo lời dặn của bác sĩ uống thuốc đúng giờ và tích cực phối hợp điều trị phục hồi chức năng thì vị trí gãy xương trong vòng hai ba tháng là có thể khỏi hẳn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '治疗',
      'zhìliáo',
      'điều trị, chữa trị',
      'Động từ / Danh từ',
      'HSK 5',
      '患者只要遵照医嘱按时服药并积极配合康复治疗，骨折部位在两三个月内便能痊愈。',
      'Huànzhě zhǐyào zūnlzhào yīzhǔ ànshí fúyào bìng jījí pèihé kāngfù zhìliáo, gǔzhé bùwèi zài liǎng-sān ge yuè nèi biàn néng quányù.',
      'Người bệnh chỉ cần tuân theo lời dặn của bác sĩ uống thuốc đúng giờ và tích cực phối hợp điều trị phục hồi chức năng thì vị trí gãy xương trong vòng hai ba tháng là có thể khỏi hẳn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '患者只要遵照医嘱按时服药并积极配合康复治疗，骨折部位在两三个月内便能痊愈。', 'Huànzhě zhǐyào zūnlzhào yīzhǔ ànshí fúyào bìng jījí pèihé kāngfù zhìliáo, gǔzhé bùwèi zài liǎng-sān ge yuè nèi biàn néng quányù.', 'Người bệnh chỉ cần tuân theo lời dặn của bác sĩ uống thuốc đúng giờ và tích cực phối hợp điều trị phục hồi chức năng thì vị trí gãy xương trong vòng hai ba tháng là có thể khỏi hẳn.', 'basic', 1),
      (v_id, '基于嵌合抗原受体T细胞免疫疗法的精准靶向治疗方案，在难治性恶性血液系统肿瘤临床试验中展现出令人振奋的长期完全缓解率。', 'Jīyú qiānhé kàngyuán shòutǐ T xìbāo miǎnyì liáofǎ de jīngzhǔn bǎxiàng zhìliáo fāng''àn, zài nánzhìxìng èxìng xuèyè xìtǒng zhǒngliú línchuáng shìyàn zhōng zhǎnxiàn chū lìngrén-zhènfèn de chángqī wánquán huǎnjiělǜ.', 'Phương án điều trị nhắm trúng đích chuẩn xác dựa trên liệu pháp miễn dịch tế bào CAR-T trong các thử nghiệm lâm sàng đối với các khối u ác tính khó chữa của hệ tạo máu đã thể hiện tỷ lệ thuyên giảm hoàn toàn dài hạn đáng phấn khởi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3516] [智能] (zhìnéng) - thông minh, trí tuệ nhân tạo, smart [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '智能' AND pinyin = 'zhìnéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '智能' AND pinyin = 'zhìnéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '智能'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '智能'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'zhìnéng',
      meaning_vi = 'thông minh, trí tuệ nhân tạo, smart',
      example_hanzi = '现在的智能扫地机器人不仅能够自主规划清扫路径，还能在电量不足时自动返回基站充电。',
      example_pinyin = 'Xiànzài de zhìnéng sǎodì jīqìrén bù jǐn nénggòu zìzhǔ guīhuà qīngsǎo lùjìng, hái néng zài diànliàng bùzú shí zìdòng fǎnhuí jīzhàn chōngdiàn.',
      example_vi = 'Robot hút bụi thông minh ngày nay không những có thể tự chủ quy hoạch đường đi quét dọn, mà còn có thể tự động quay về trạm sạc khi pin yếu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '智能',
      'zhìnéng',
      'thông minh, trí tuệ nhân tạo, smart',
      'Tính từ / Danh từ',
      'HSK 5',
      '现在的智能扫地机器人不仅能够自主规划清扫路径，还能在电量不足时自动返回基站充电。',
      'Xiànzài de zhìnéng sǎodì jīqìrén bù jǐn nénggòu zìzhǔ guīhuà qīngsǎo lùjìng, hái néng zài diànliàng bùzú shí zìdòng fǎnhuí jīzhàn chōngdiàn.',
      'Robot hút bụi thông minh ngày nay không những có thể tự chủ quy hoạch đường đi quét dọn, mà còn có thể tự động quay về trạm sạc khi pin yếu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现在的智能扫地机器人不仅能够自主规划清扫路径，还能在电量不足时自动返回基站充电。', 'Xiànzài de zhìnéng sǎodì jīqìrén bù jǐn nénggòu zìzhǔ guīhuà qīngsǎo lùjìng, hái néng zài diànliàng bùzú shí zìdòng fǎnhuí jīzhàn chōngdiàn.', 'Robot hút bụi thông minh ngày nay không những có thể tự chủ quy hoạch đường đi quét dọn, mà còn có thể tự động quay về trạm sạc khi pin yếu.', 'basic', 1),
      (v_id, '新一代通用具身人工智能技术正深度重塑工业自动化装备，赋予人形机器人全自主环境感知与复杂工件精密装配能力。', 'Xīn-yídài tōngyòng jùshēn réngōng zhìnéng jìshù zhèng shēndù chóngsù gōngyè zìdònghuà zhuāngbèi, fùyǔ rénxíng jīqìrén quán-zìzhǔ huánjìng gǎnzhī yǔ fùzá gōngjiàn jīngmì zhuāngpèi nénglì.', 'Công nghệ trí tuệ nhân tạo hiện thân đa năng thế hệ mới đang tái định hình sâu sắc các thiết bị tự động hóa công nghiệp, trao cho robot hình người năng lực cảm nhận môi trường hoàn toàn tự chủ và lắp ráp cơ khí chính xác các linh kiện phức tạp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3517] [志愿者] (zhìyuànzhě) - tình nguyện viên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '志愿者' AND pinyin = 'zhìyuànzhě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '志愿者' AND pinyin = 'zhìyuànzhě'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '志愿者'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '志愿者'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhìyuànzhě',
      meaning_vi = 'tình nguyện viên',
      example_hanzi = '上百名大学生志愿者利用周末时间来到社区养老院，陪伴孤寡老人聊天并打扫院落卫生。',
      example_pinyin = 'Shàngbǎi míng dàxuéshēng zhìyuànzhě lìyòng zhōumò shíjiān lái dào shèqū yǎnglǎoyuàn, péibàn gūguǎ lǎorén liáotiān bìng dǎsǎo yuànluò wèishēng.',
      example_vi = 'Hàng trăm sinh viên tình nguyện viên đã tận dụng thời gian cuối tuần đến viện dưỡng lão cộng đồng, đồng hành trò chuyện với các cụ già neo đơn và quét dọn vệ sinh sân vườn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '志愿者',
      'zhìyuànzhě',
      'tình nguyện viên',
      'Danh từ',
      'HSK 5',
      '上百名大学生志愿者利用周末时间来到社区养老院，陪伴孤寡老人聊天并打扫院落卫生。',
      'Shàngbǎi míng dàxuéshēng zhìyuànzhě lìyòng zhōumò shíjiān lái dào shèqū yǎnglǎoyuàn, péibàn gūguǎ lǎorén liáotiān bìng dǎsǎo yuànluò wèishēng.',
      'Hàng trăm sinh viên tình nguyện viên đã tận dụng thời gian cuối tuần đến viện dưỡng lão cộng đồng, đồng hành trò chuyện với các cụ già neo đơn và quét dọn vệ sinh sân vườn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '上百名大学生志愿者利用周末时间来到社区养老院，陪伴孤寡老人聊天并打扫院落卫生。', 'Shàngbǎi míng dàxuéshēng zhìyuànzhě lìyòng zhōumò shíjiān lái dào shèqū yǎnglǎoyuàn, péibàn gūguǎ lǎorén liáotiān bìng dǎsǎo yuànluò wèishēng.', 'Hàng trăm sinh viên tình nguyện viên đã tận dụng thời gian cuối tuần đến viện dưỡng lão cộng đồng, đồng hành trò chuyện với các cụ già neo đơn và quét dọn vệ sinh sân vườn.', 'basic', 1),
      (v_id, '在大型国际体育盛会与多边外交峰会中，精通多国语言的青年志愿者团队构筑了展现东道国开放文明形象的靓丽风景线。', 'Zài dàxíng guójì tǐyù shènghuì yǔ duōbiān wàijiāo fēnghuì zhōng, jīngtōng duōguó yǔyán de qīngnián zhìyuànzhě tuánduì gòuzhù le zhǎnxiàn dōngdàoguó kāifàng wénmíng xíngxiàng de liànglì fēngjǐngxiàn.', 'Tại các đại hội thể thao quốc tế lớn và hội nghị thượng đỉnh ngoại giao đa phương, đội ngũ tình nguyện viên thanh niên tinh thông nhiều thứ tiếng đã tạo nên một bức tranh phong cảnh rực rỡ thể hiện hình ảnh văn minh cởi mở của đất nước chủ nhà.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3518] [制造] (zhìzào) - chế tạo, sản xuất; tạo ra [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '制造' AND pinyin = 'zhìzào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制造' AND pinyin = 'zhìzào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '制造'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制造'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhìzào',
      meaning_vi = 'chế tạo, sản xuất; tạo ra',
      example_hanzi = '这家老牌钟表工厂始终坚持手工装配每一枚齿轮零件，制造出品质卓越的经典机械腕表。',
      example_pinyin = 'Zhè jiā lǎopái zhōngbiǎo gōngchǎng shǐzhōng jiānchí shǒugōng zhuāngpèi měi yì méi chǐlún língjiàn, zhìzào chū pǐnzhì zhuóyuè de jīngdiǎn jīxiè wànbiǎo.',
      example_vi = 'Nhà máy sản xuất đồng hồ lâu năm này luôn kiên trì lắp ráp thủ công từng chiếc linh kiện bánh răng, chế tạo ra những chiếc đồng hồ cơ cổ điển có chất lượng vượt trội.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '制造',
      'zhìzào',
      'chế tạo, sản xuất; tạo ra',
      'Động từ / Danh từ',
      'HSK 5',
      '这家老牌钟表工厂始终坚持手工装配每一枚齿轮零件，制造出品质卓越的经典机械腕表。',
      'Zhè jiā lǎopái zhōngbiǎo gōngchǎng shǐzhōng jiānchí shǒugōng zhuāngpèi měi yì méi chǐlún língjiàn, zhìzào chū pǐnzhì zhuóyuè de jīngdiǎn jīxiè wànbiǎo.',
      'Nhà máy sản xuất đồng hồ lâu năm này luôn kiên trì lắp ráp thủ công từng chiếc linh kiện bánh răng, chế tạo ra những chiếc đồng hồ cơ cổ điển có chất lượng vượt trội.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家老牌钟表工厂始终坚持手工装配每一枚齿轮零件，制造出品质卓越的经典机械腕表。', 'Zhè jiā lǎopái zhōngbiǎo gōngchǎng shǐzhōng jiānchí shǒugōng zhuāngpèi měi yì méi chǐlún língjiàn, zhìzào chū pǐnzhì zhuóyuè de jīngdiǎn jīxiè wànbiǎo.', 'Nhà máy sản xuất đồng hồ lâu năm này luôn kiên trì lắp ráp thủ công từng chiếc linh kiện bánh răng, chế tạo ra những chiếc đồng hồ cơ cổ điển có chất lượng vượt trội.', 'basic', 1),
      (v_id, '推动制造业向高端化、智能化、绿色化迈进，是加快建设现代化产业体系并牢牢掌握全球高端装备制造话语权的核心支撑。', 'Tuīdòng zhìzàoyè xiàng gāoduānhuà, zhìnénghuà, lǜsèhuà màijìn, shì jiākuài jiànshè xiàndàihuà chǎnyè tǐxì bìng láoláo zhǎngwò quánqiú gāoduān zhuāngbèi zhìzào huàyǔquán de héxīn zhīchēng.', 'Thúc đẩy ngành chế tạo tiến bước theo hướng cao cấp hóa, thông minh hóa và xanh hóa là trụ cột cốt lõi để đẩy nhanh xây dựng hệ thống công nghiệp hiện đại và nắm chắc tiếng nói quyết định trong sản xuất chế tạo thiết bị cao cấp toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3519] [制作] (zhìzuò) - chế tác, làm ra, sáng tạo (video, đồ thủ công, tác phẩm) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '制作' AND pinyin = 'zhìzuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制作' AND pinyin = 'zhìzuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '制作'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '制作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhìzuò',
      meaning_vi = 'chế tác, làm ra, sáng tạo (video, đồ thủ công, tác phẩm)',
      example_hanzi = '美术课上，老师耐心地教小朋友们如何用彩纸和剪刀制作生动有趣的动物剪纸模型。',
      example_pinyin = 'Měishùkè shang, lǎoshī nàixīn de jiāo xiǎopéngyoumen rúhé yòng cǎizhǐ hé jiǎndāo zhìzuò shēngdòng-yǒuqù de dòngwù jiǎnzhǐ móxíng.',
      example_vi = 'Trong giờ học mỹ thuật, cô giáo kiên nhẫn dạy các em nhỏ cách dùng giấy màu và kéo để chế tác các mô hình cắt giấy động vật sinh động thú vị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '制作',
      'zhìzuò',
      'chế tác, làm ra, sáng tạo (video, đồ thủ công, tác phẩm)',
      'Động từ',
      'HSK 5',
      '美术课上，老师耐心地教小朋友们如何用彩纸和剪刀制作生动有趣的动物剪纸模型。',
      'Měishùkè shang, lǎoshī nàixīn de jiāo xiǎopéngyoumen rúhé yòng cǎizhǐ hé jiǎndāo zhìzuò shēngdòng-yǒuqù de dòngwù jiǎnzhǐ móxíng.',
      'Trong giờ học mỹ thuật, cô giáo kiên nhẫn dạy các em nhỏ cách dùng giấy màu và kéo để chế tác các mô hình cắt giấy động vật sinh động thú vị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '美术课上，老师耐心地教小朋友们如何用彩纸和剪刀制作生动有趣的动物剪纸模型。', 'Měishùkè shang, lǎoshī nàixīn de jiāo xiǎopéngyoumen rúhé yòng cǎizhǐ hé jiǎndāo zhìzuò shēngdòng-yǒuqù de dòngwù jiǎnzhǐ móxíng.', 'Trong giờ học mỹ thuật, cô giáo kiên nhẫn dạy các em nhỏ cách dùng giấy màu và kéo để chế tác các mô hình cắt giấy động vật sinh động thú vị.', 'basic', 1),
      (v_id, '影视后期数字特效团队运用虚幻引擎虚拟制片技术制作出逼真的科幻宇宙史诗大片，将传统实景搭建周期缩短了近百分之七十。', 'Yǐngshì hòuqī shùzì tèxiào tuánduì yùnyòng Xūhuàn Yǐnqíng xūnǐ zhìpiàn jìshù zhìzuò chū bīzhēn de kēhuàn yǔzhòu shǐshī dàpiān, jiāng chuántǒng shíjǐng dājiàn zhōuqī suōduǎn le jìn bǎifēnzhī-qīshí.', 'Đội ngũ kỹ xảo số hậu kỳ điện ảnh truyền hình vận dụng công nghệ sản xuất phim ảo Unreal Engine để chế tác nên bộ phim sử thi khoa học viễn tưởng vũ trụ chân thực, rút ngắn gần 70% chu kỳ dựng cảnh thực tế truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3520] [中华] (Zhōnghuá) - Trung Hoa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中华' AND pinyin = 'Zhōnghuá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中华' AND pinyin = 'Zhōnghuá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中华'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中华'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'Zhōnghuá',
      meaning_vi = 'Trung Hoa',
      example_hanzi = '中华传统文化博大精深，无论是书法、京剧还是古典诗词都散发着独特的东方艺术魅力。',
      example_pinyin = 'Zhōnghuá chuántǒng wénhuà bódà-jīngshēn, wúlùn shì shūfǎ, Jīngjù háishì gǔdiǎn shīcí dōu sànfā zhe dútè de dōngfāng yìshù mèilì.',
      example_vi = 'Văn hóa truyền thống Trung Hoa uyên bác sâu rộng, bất luận là thư pháp, kinh kịch hay thơ từ cổ điển đều tỏa ra sức quyến rũ nghệ thuật phương Đông độc đáo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中华',
      'Zhōnghuá',
      'Trung Hoa',
      'Danh từ',
      'HSK 5',
      '中华传统文化博大精深，无论是书法、京剧还是古典诗词都散发着独特的东方艺术魅力。',
      'Zhōnghuá chuántǒng wénhuà bódà-jīngshēn, wúlùn shì shūfǎ, Jīngjù háishì gǔdiǎn shīcí dōu sànfā zhe dútè de dōngfāng yìshù mèilì.',
      'Văn hóa truyền thống Trung Hoa uyên bác sâu rộng, bất luận là thư pháp, kinh kịch hay thơ từ cổ điển đều tỏa ra sức quyến rũ nghệ thuật phương Đông độc đáo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中华传统文化博大精深，无论是书法、京剧还是古典诗词都散发着独特的东方艺术魅力。', 'Zhōnghuá chuántǒng wénhuà bódà-jīngshēn, wúlùn shì shūfǎ, Jīngjù háishì gǔdiǎn shīcí dōu sànfā zhe dútè de dōngfāng yìshù mèilì.', 'Văn hóa truyền thống Trung Hoa uyên bác sâu rộng, bất luận là thư pháp, kinh kịch hay thơ từ cổ điển đều tỏa ra sức quyến rũ nghệ thuật phương Đông độc đáo.', 'basic', 1),
      (v_id, '传承弘扬中华优秀传统文化中的天人合一与和合共生哲学理念，为解决当今全球生态危机提供了极具启迪意义的东方智慧方案。', 'Chuánchéng hóngyáng Zhōnghuá yōuxiù chuántǒng wénhuà zhōng de tiānrén-héyī yǔ héhé-gòngshēng zhéxué lǐniàn, wèi jiějué dāngjīn quánqiú shēngtài wēijī tígōng le jí jù qǐdí yìyì de dōngfāng zhìhuì fāng''àn.', 'Kế thừa và phát huy triết lý thiên nhân hợp nhất và hòa hợp cùng sinh tồn trong nền văn hóa truyền thống ưu tú Trung Hoa cung cấp phương án trí tuệ phương Đông mang tính khai sáng sâu sắc để giải quyết khủng hoảng sinh thái toàn cầu ngày nay.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3521] [中华民族] (Zhōnghuá Mínzú) - dân tộc Trung Hoa [Cụm từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中华民族' AND pinyin = 'Zhōnghuá Mínzú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中华民族' AND pinyin = 'Zhōnghuá Mínzú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中华民族'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中华民族'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Cụm từ / Danh từ',
      pinyin = 'Zhōnghuá Mínzú',
      meaning_vi = 'dân tộc Trung Hoa',
      example_hanzi = '吃苦耐劳、自强不息是中华民族自古以来流淌在血液里的优良传统美德。',
      example_pinyin = 'Chīkǔ-nàiláo, zìqiáng-bùxī shì Zhōnghuá Mínzú zìgǔ yǐlái liútǎng zài xuèyè lǐ de yōuliáng chuántǒng měidé.',
      example_vi = 'Chịu thương chịu khó, tự cường không ngừng nghỉ là đức tính truyền thống tốt đẹp chảy trong huyết quản của dân tộc Trung Hoa từ ngàn xưa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中华民族',
      'Zhōnghuá Mínzú',
      'dân tộc Trung Hoa',
      'Cụm từ / Danh từ',
      'HSK 5',
      '吃苦耐劳、自强不息是中华民族自古以来流淌在血液里的优良传统美德。',
      'Chīkǔ-nàiláo, zìqiáng-bùxī shì Zhōnghuá Mínzú zìgǔ yǐlái liútǎng zài xuèyè lǐ de yōuliáng chuántǒng měidé.',
      'Chịu thương chịu khó, tự cường không ngừng nghỉ là đức tính truyền thống tốt đẹp chảy trong huyết quản của dân tộc Trung Hoa từ ngàn xưa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '吃苦耐劳、自强不息是中华民族自古以来流淌在血液里的优良传统美德。', 'Chīkǔ-nàiláo, zìqiáng-bùxī shì Zhōnghuá Mínzú zìgǔ yǐlái liútǎng zài xuèyè lǐ de yōuliáng chuántǒng měidé.', 'Chịu thương chịu khó, tự cường không ngừng nghỉ là đức tính truyền thống tốt đẹp chảy trong huyết quản của dân tộc Trung Hoa từ ngàn xưa.', 'basic', 1),
      (v_id, '铸牢中华民族共同体意识是新时代党的民族工作的主线，推动各民族像石榴籽一样紧紧抱在一起共同繁荣发展。', 'Zhùláo Zhōnghuá Mínzú gòngtóngtǐ yìshí shì xīn-shídài dǎng de mínzú gōngzuò de zhǔxiàn, tuīdòng gè mínzú xiàng shíliuzǐ yíyàng jǐnjǐn bào zài yìqǐ gòngtóng fánróng fāzhǎn.', 'Đúc vững ý thức cộng đồng chung dân tộc Trung Hoa là tuyến chủ đạo trong công tác dân tộc thời đại mới, thúc đẩy các dân tộc gắn kết bền chặt như những hạt lựu để cùng nhau phồn vinh phát triển.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3522] [中级] (zhōngjí) - trung cấp, bậc trung [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中级' AND pinyin = 'zhōngjí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中级' AND pinyin = 'zhōngjí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中级'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中级'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhōngjí',
      meaning_vi = 'trung cấp, bậc trung',
      example_hanzi = '经过半年的刻苦自学，他顺利通过了汉语水平考试四级，成功达到了中级汉语沟通交流水平。',
      example_pinyin = 'Jīngguò bàn nián de kèkǔ zìxué, tā shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì sì jí, chénggōng dádào le zhōngjí Hànyǔ gōutōng jiāoliú shuǐpíng.',
      example_vi = 'Trải qua nửa năm tự học khổ công, anh ấy đã vượt qua kỳ thi năng lực Hán ngữ cấp 4 một cách thuận lợi, thành công đạt đến trình độ giao tiếp tiếng Trung trung cấp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中级',
      'zhōngjí',
      'trung cấp, bậc trung',
      'Tính từ',
      'HSK 5',
      '经过半年的刻苦自学，他顺利通过了汉语水平考试四级，成功达到了中级汉语沟通交流水平。',
      'Jīngguò bàn nián de kèkǔ zìxué, tā shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì sì jí, chénggōng dádào le zhōngjí Hànyǔ gōutōng jiāoliú shuǐpíng.',
      'Trải qua nửa năm tự học khổ công, anh ấy đã vượt qua kỳ thi năng lực Hán ngữ cấp 4 một cách thuận lợi, thành công đạt đến trình độ giao tiếp tiếng Trung trung cấp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过半年的刻苦自学，他顺利通过了汉语水平考试四级，成功达到了中级汉语沟通交流水平。', 'Jīngguò bàn nián de kèkǔ zìxué, tā shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì sì jí, chénggōng dádào le zhōngjí Hànyǔ gōutōng jiāoliú shuǐpíng.', 'Trải qua nửa năm tự học khổ công, anh ấy đã vượt qua kỳ thi năng lực Hán ngữ cấp 4 một cách thuận lợi, thành công đạt đến trình độ giao tiếp tiếng Trung trung cấp.', 'basic', 1),
      (v_id, '人力资源与社会保障部门发布了最新的中级专业技术人员职称评审标准，重点破除唯学历、唯论文的单一评价倾向。', 'Rénlì zīyuán yǔ shèhuì bǎozhàng bùmén fābù le zuìxīn de zhōngjí zhuānyè jìshù rényuán zhíchēng píngshěn biāozhǔn, zhòngdiǎn pòchú wéi xuélì, wéi lùnwén de dānyī píngjià qīngxiàng.', 'Cơ quan nhân lực và bảo đảm xã hội đã công bố tiêu chuẩn xét duyệt chức danh nghề nghiệp cán bộ kỹ thuật chuyên môn bậc trung cấp mới nhất, tập trung xóa bỏ khuynh hướng đánh giá phiến diện chỉ dựa vào bằng cấp hay bài báo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3523] [中介] (zhōngjiè) - môi giới, trung gian [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中介' AND pinyin = 'zhōngjiè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中介' AND pinyin = 'zhōngjiè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中介'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中介'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhōngjiè',
      meaning_vi = 'môi giới, trung gian',
      example_hanzi = '刚到一个陌生的城市工作，他通过一家正规的大型房屋中介公司租下了一套舒适的公寓。',
      example_pinyin = 'Gāng dào yí ge mòshēng de chéngshì gōngzuò, tā tōngguò yì jiā zhèngguī de dàxíng fángwū zhōngjiè gōngsī zū xià le yí tào shūshì de gōngyù.',
      example_vi = 'Vừa tới một thành phố xa lạ làm việc, anh ấy đã thông qua một công ty môi giới nhà đất quy mô lớn chính quy để thuê một căn hộ tiện nghi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中介',
      'zhōngjiè',
      'môi giới, trung gian',
      'Danh từ',
      'HSK 5',
      '刚到一个陌生的城市工作，他通过一家正规的大型房屋中介公司租下了一套舒适的公寓。',
      'Gāng dào yí ge mòshēng de chéngshì gōngzuò, tā tōngguò yì jiā zhèngguī de dàxíng fángwū zhōngjiè gōngsī zū xià le yí tào shūshì de gōngyù.',
      'Vừa tới một thành phố xa lạ làm việc, anh ấy đã thông qua một công ty môi giới nhà đất quy mô lớn chính quy để thuê một căn hộ tiện nghi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '刚到一个陌生的城市工作，他通过一家正规的大型房屋中介公司租下了一套舒适的公寓。', 'Gāng dào yí ge mòshēng de chéngshì gōngzuò, tā tōngguò yì jiā zhèngguī de dàxíng fángwū zhōngjiè gōngsī zū xià le yí tào shūshì de gōngyù.', 'Vừa tới một thành phố xa lạ làm việc, anh ấy đã thông qua một công ty môi giới nhà đất quy mô lớn chính quy để thuê một căn hộ tiện nghi.', 'basic', 1),
      (v_id, '知识产权交易平台充当科技成果转化的高效技术中介枢纽，有效打通了高校科研成果向中小制造企业转移转化的堵点。', 'Zhīshi chǎnquán jiāoyì píngtái chōngdāng kējì chéngguǒ zhuǎnhuà de gāoxiào jìshù zhōngjiè shūniǔ, yǒuxiào dǎtōng le gāoxiào kēyán chéngguǒ xiàng zhōng-xiǎo zhìzào qǐyè zhuǎnyí zhuǎnhuà de dǔdiǎn.', 'Sàn giao dịch quyền sở hữu trí tuệ đóng vai trò là đầu mối trung gian công nghệ hiệu quả cao cho chuyển giao thành quả khoa học công nghệ, khơi thông hiệu quả các điểm nghẽn chuyển giao thành quả nghiên cứu đại học sang các doanh nghiệp chế tạo vừa và nhỏ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3524] [中期] (zhōngqī) - trung kỳ, giai đoạn giữa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中期' AND pinyin = 'zhōngqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中期' AND pinyin = 'zhōngqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhōngqī',
      meaning_vi = 'trung kỳ, giai đoạn giữa',
      example_hanzi = '国家重点实验室定于下周三举行重大科研专项的中期检查评估汇报会。',
      example_pinyin = 'Guójiā zhòngdiǎn shíyànshì dìng yú xià zhōusān jǔxíng zhòngdà kēyán zhuānxiàng de zhōngqī jiǎnchá pínggū huìbàohuì.',
      example_vi = 'Phòng thí nghiệm trọng điểm quốc gia ấn định vào thứ Tư tuần sau sẽ tổ chức hội nghị báo cáo kiểm tra đánh giá giai đoạn giữa của chuyên án nghiên cứu khoa học trọng đại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中期',
      'zhōngqī',
      'trung kỳ, giai đoạn giữa',
      'Danh từ',
      'HSK 5',
      '国家重点实验室定于下周三举行重大科研专项的中期检查评估汇报会。',
      'Guójiā zhòngdiǎn shíyànshì dìng yú xià zhōusān jǔxíng zhòngdà kēyán zhuānxiàng de zhōngqī jiǎnchá pínggū huìbàohuì.',
      'Phòng thí nghiệm trọng điểm quốc gia ấn định vào thứ Tư tuần sau sẽ tổ chức hội nghị báo cáo kiểm tra đánh giá giai đoạn giữa của chuyên án nghiên cứu khoa học trọng đại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '国家重点实验室定于下周三举行重大科研专项的中期检查评估汇报会。', 'Guójiā zhòngdiǎn shíyànshì dìng yú xià zhōusān jǔxíng zhòngdà kēyán zhuānxiàng de zhōngqī jiǎnchá pínggū huìbàohuì.', 'Phòng thí nghiệm trọng điểm quốc gia ấn định vào thứ Tư tuần sau sẽ tổ chức hội nghị báo cáo kiểm tra đánh giá giai đoạn giữa của chuyên án nghiên cứu khoa học trọng đại.', 'basic', 1),
      (v_id, '宏观经济五年规划实施中期评估报告客观指出了战略新兴产业产能结构性过剩与民间投资动能趋缓的潜在挑战。', 'Hóngguān jīngjì wǔ nián guīhuà shíshī zhōngqī pínggū bàogào kèguān zhǐchū le zhànlüè xīnxīng chǎnyè chǎnnéng jiégòuxìng guòshèng yǔ mínjiān tóuzī dòngnéng qūhuǎn de qiánzài tiǎozhàn.', 'Báo cáo đánh giá giữa kỳ việc thực hiện quy hoạch 5 năm kinh tế vĩ mô đã chỉ ra một cách khách quan những thách thức tiềm ẩn về tình trạng dư thừa công suất mang tính cơ cấu của các ngành mới nổi chiến lược và đà đầu tư tư nhân chậm lại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3525] [中外] (zhōngwài) - trong và ngoài nước, Trung Quốc và nước ngoài [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中外' AND pinyin = 'zhōngwài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中外' AND pinyin = 'zhōngwài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中外'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中外'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhōngwài',
      meaning_vi = 'trong và ngoài nước, Trung Quốc và nước ngoài',
      example_hanzi = '在市中心举办的国际传统民俗美食节上，汇聚了成百上千种中外知名特色风味小吃。',
      example_pinyin = 'Zài shìzhōngxīn jǔbàn de guójì chuántǒng mínsú měishíjié shang, huìjù le chéngbǎi-shàngqiān zhǒng zhōngwài zhīmíng tèsè fēngwèi xiǎochī.',
      example_vi = 'Tại lễ hội ẩm thực phong tục dân gian truyền thống quốc tế tổ chức ở trung tâm thành phố đã hội tụ hàng trăm hàng nghìn món ăn vặt hương vị đặc sắc nổi tiếng trong và ngoài nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中外',
      'zhōngwài',
      'trong và ngoài nước, Trung Quốc và nước ngoài',
      'Danh từ',
      'HSK 5',
      '在市中心举办的国际传统民俗美食节上，汇聚了成百上千种中外知名特色风味小吃。',
      'Zài shìzhōngxīn jǔbàn de guójì chuántǒng mínsú měishíjié shang, huìjù le chéngbǎi-shàngqiān zhǒng zhōngwài zhīmíng tèsè fēngwèi xiǎochī.',
      'Tại lễ hội ẩm thực phong tục dân gian truyền thống quốc tế tổ chức ở trung tâm thành phố đã hội tụ hàng trăm hàng nghìn món ăn vặt hương vị đặc sắc nổi tiếng trong và ngoài nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在市中心举办的国际传统民俗美食节上，汇聚了成百上千种中外知名特色风味小吃。', 'Zài shìzhōngxīn jǔbàn de guójì chuántǒng mínsú měishíjié shang, huìjù le chéngbǎi-shàngqiān zhǒng zhōngwài zhīmíng tèsè fēngwèi xiǎochī.', 'Tại lễ hội ẩm thực phong tục dân gian truyền thống quốc tế tổ chức ở trung tâm thành phố đã hội tụ hàng trăm hàng nghìn món ăn vặt hương vị đặc sắc nổi tiếng trong và ngoài nước.', 'basic', 1),
      (v_id, '中外合资高精尖科研机构在深空探测与受控核聚变前沿物理领域开展了深度互补的多边跨国科学攻关。', 'Zhōngwài hézī gāojīngjiān kēyán jīgòu zài shēnkōng tàncè yǔ shòukòng hé-jùbiàn qiányán wùlǐ lǐngyù kāizhǎn le shēndù hùbǔ de duōbiān kuàguó kēxué gōngguān.', 'Cơ quan nghiên cứu khoa học công nghệ đỉnh cao liên doanh Trung - ngoại đã triển khai các cuộc đột phá khoa học xuyên quốc gia đa bên mang tính bổ sung sâu sắc trong các lĩnh vực vật lý mũi nhọn như thăm dò không gian sâu và nhiệt hạch có thể kiểm soát.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3526] [中心] (zhōngxīn) - trung tâm, trọng tâm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中心' AND pinyin = 'zhōngxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中心' AND pinyin = 'zhōngxīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中心'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhōngxīn',
      meaning_vi = 'trung tâm, trọng tâm',
      example_hanzi = '我们学校刚刚在校园中心花园旁边新建了一座藏书极为丰富的现代化综合图书馆。',
      example_pinyin = 'Wǒmen xuéxiào gānggāng zài xiàoyuán zhōngxīn huāyuán pángbiān xīnjiàn le yí zuò cángshū jíqí fēngfù de xiàndàihuà zōnghé túshūguǎn.',
      example_vi = 'Trường học của chúng tôi vừa mới xây dựng một thư viện tổng hợp hiện đại có lượng sách lưu trữ vô cùng phong phú bên cạnh hoa viên trung tâm trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中心',
      'zhōngxīn',
      'trung tâm, trọng tâm',
      'Danh từ',
      'HSK 5',
      '我们学校刚刚在校园中心花园旁边新建了一座藏书极为丰富的现代化综合图书馆。',
      'Wǒmen xuéxiào gānggāng zài xiàoyuán zhōngxīn huāyuán pángbiān xīnjiàn le yí zuò cángshū jíqí fēngfù de xiàndàihuà zōnghé túshūguǎn.',
      'Trường học của chúng tôi vừa mới xây dựng một thư viện tổng hợp hiện đại có lượng sách lưu trữ vô cùng phong phú bên cạnh hoa viên trung tâm trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们学校刚刚在校园中心花园旁边新建了一座藏书极为丰富的现代化综合图书馆。', 'Wǒmen xuéxiào gānggāng zài xiàoyuán zhōngxīn huāyuán pángbiān xīnjiàn le yí zuò cángshū jíqí fēngfù de xiàndàihuà zōnghé túshūguǎn.', 'Trường học của chúng tôi vừa mới xây dựng một thư viện tổng hợp hiện đại có lượng sách lưu trữ vô cùng phong phú bên cạnh hoa viên trung tâm trường.', 'basic', 1),
      (v_id, '国际金融中心与跨国航运枢纽建设必须坚持以高水平制度型对外开放为核心，深化跨境资本双向流动便利化改革。', 'Guójì jīnróng zhōngxīn yǔ kuàguó hángyùn shūniǔ jiànshè bìxū jiānchí yǐ gāoshuǐpíng zhìdùxíng duìwài kāifàng wéi héxīn, shēnhuà kuàjìng zīběn shuāngxiàng liúdòng biànlìhuà gǎigé.', 'Việc xây dựng trung tâm tài chính quốc tế và đầu mối vận tải biển xuyên quốc gia bắt buộc phải kiên trì lấy mở cửa đối ngoại dạng thể chế trình độ cao làm cốt lõi, làm sâu sắc thêm cải cách tạo thuận lợi cho dòng vốn xuyên biên giới luân chuyển hai chiều.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3527] [中药] (zhōngyào) - thuốc Đông y, thuốc bắc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中药' AND pinyin = 'zhōngyào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中药' AND pinyin = 'zhōngyào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中药'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中药'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhōngyào',
      meaning_vi = 'thuốc Đông y, thuốc bắc',
      example_hanzi = '老中医开具的这几副中药具有清热解毒、润肺止咳的良好温补功效。',
      example_pinyin = 'Lǎo zhōngyī kāijù de zhè jǐ fù zhōngyào jùyǒu qīngrè-jiědú, rùnfèi-zhǐké de liánghǎo wēnbǔ gōngxiào.',
      example_vi = 'Mấy thang thuốc Đông y do vị thầy thuốc đông y cao tuổi kê đơn có công hiệu thanh nhiệt giải độc, nhuận phổi ngừng ho bổ dưỡng ôn hòa rất tốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中药',
      'zhōngyào',
      'thuốc Đông y, thuốc bắc',
      'Danh từ',
      'HSK 5',
      '老中医开具的这几副中药具有清热解毒、润肺止咳的良好温补功效。',
      'Lǎo zhōngyī kāijù de zhè jǐ fù zhōngyào jùyǒu qīngrè-jiědú, rùnfèi-zhǐké de liánghǎo wēnbǔ gōngxiào.',
      'Mấy thang thuốc Đông y do vị thầy thuốc đông y cao tuổi kê đơn có công hiệu thanh nhiệt giải độc, nhuận phổi ngừng ho bổ dưỡng ôn hòa rất tốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老中医开具的这几副中药具有清热解毒、润肺止咳的良好温补功效。', 'Lǎo zhōngyī kāijù de zhè jǐ fù zhōngyào jùyǒu qīngrè-jiědú, rùnfèi-zhǐké de liánghǎo wēnbǔ gōngxiào.', 'Mấy thang thuốc Đông y do vị thầy thuốc đông y cao tuổi kê đơn có công hiệu thanh nhiệt giải độc, nhuận phổi ngừng ho bổ dưỡng ôn hòa rất tốt.', 'basic', 1),
      (v_id, '国家药监局加速推进传统经典名方中药复方制剂的标准化质量控制与现代药理活性成分现代化循证医学评价。', 'Guójiā Yàojiānjú jiāsù tuījìn chuántǒng jīngdiǎn míngfāng zhōngyào fùfāng zhìjì de biāozhǔnhuà zhìliàng kòngzhì yǔ xiàndài yàolǐ huóxìng chéngfèn xiàndàihuà xúnzhèng yīxué pínggū.', 'Cục Quản lý Dược phẩm Quốc gia đẩy nhanh kiểm soát chất lượng chuẩn hóa đối với các chế phẩm thuốc Đông y bài thuốc cổ phương kinh điển truyền thống và đánh giá y học thực chứng hiện đại hóa về các thành phần hoạt tính dược lý hiện đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3528] [中医] (zhōngyī) - Đông y, y học cổ truyền Trung Quốc, thầy thuốc Đông y [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '中医' AND pinyin = 'zhōngyī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中医' AND pinyin = 'zhōngyī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '中医'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '中医'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhōngyī',
      meaning_vi = 'Đông y, y học cổ truyền Trung Quốc, thầy thuốc Đông y',
      example_hanzi = '这位经验丰富的老中医仅仅通过搭脉与观察舌苔，就能准确说出患者平时的身体调理弱项。',
      example_pinyin = 'Zhè wèi jīngyàn fēngfù de lǎo zhōngyī jǐnjǐn tōngguò dāmài yǔ guānchá shétāi, jiù néng zhǔnquè shuō chū huànzhě píngshí de shēntǐ tiáolǐ ruòxiàng.',
      example_vi = 'Vị thầy thuốc Đông y giàu kinh nghiệm này chỉ qua việc bắt mạch và xem rêu lưỡi là đã có thể nói chính xác điểm yếu cần điều dưỡng cơ thể thường ngày của người bệnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '中医',
      'zhōngyī',
      'Đông y, y học cổ truyền Trung Quốc, thầy thuốc Đông y',
      'Danh từ',
      'HSK 5',
      '这位经验丰富的老中医仅仅通过搭脉与观察舌苔，就能准确说出患者平时的身体调理弱项。',
      'Zhè wèi jīngyàn fēngfù de lǎo zhōngyī jǐnjǐn tōngguò dāmài yǔ guānchá shétāi, jiù néng zhǔnquè shuō chū huànzhě píngshí de shēntǐ tiáolǐ ruòxiàng.',
      'Vị thầy thuốc Đông y giàu kinh nghiệm này chỉ qua việc bắt mạch và xem rêu lưỡi là đã có thể nói chính xác điểm yếu cần điều dưỡng cơ thể thường ngày của người bệnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位经验丰富的老中医仅仅通过搭脉与观察舌苔，就能准确说出患者平时的身体调理弱项。', 'Zhè wèi jīngyàn fēngfù de lǎo zhōngyī jǐnjǐn tōngguò dāmài yǔ guānchá shétāi, jiù néng zhǔnquè shuō chū huànzhě píngshí de shēntǐ tiáolǐ ruòxiàng.', 'Vị thầy thuốc Đông y giàu kinh nghiệm này chỉ qua việc bắt mạch và xem rêu lưỡi là đã có thể nói chính xác điểm yếu cần điều dưỡng cơ thể thường ngày của người bệnh.', 'basic', 1),
      (v_id, '中西医结合重症救治协作机制在疑难杂症与急性感染病防治中充分发挥了中医治未病与整体调理的独特临床优势。', 'Zhōng-xīyī jiéhé zhòngzhèng jiùzhì xiézuò jīzhì zài yínán-zázhèng yǔ jíxìng gǎnrǎnbìng fángzhì zhōng chōngfèn fāhuī le zhōngyī zhìwèibìng yǔ zhěngtǐ tiáolǐ de dútè línchuáng yōushì.', 'Cơ chế hiệp đồng cấp cứu điều trị ca bệnh nặng kết hợp Đông - Tây y đã phát huy đầy đủ ưu thế lâm sàng độc đáo của Đông y về phòng bệnh từ sớm khi chưa phát và điều hòa cơ thể mang tính tổng thể trong phòng chống các ca bệnh nan y phức tạp và bệnh nhiễm trùng cấp tính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3529] [种类] (zhǒnglèi) - chủng loại, thể loại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '种类' AND pinyin = 'zhǒnglèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '种类' AND pinyin = 'zhǒnglèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '种类'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '种类'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhǒnglèi',
      meaning_vi = 'chủng loại, thể loại',
      example_hanzi = '这家大型进口水果连锁超市销售的热带水果种类繁多，涵盖了榴莲、芒果和红毛丹等数十个品种。',
      example_pinyin = 'Zhè jiā dàxíng jìnkǒu shuǐguǒ liánsuǒ chāoshì xiāoshòu de rèdài shuǐguǒ zhǒnglèi fánduō, hángài le liúlián, mángguǒ hé hóngmáodān děng shùshí ge pǐnzhǒng.',
      example_vi = 'Chuỗi siêu thị hoa quả nhập khẩu quy mô lớn này bày bán chủng loại trái cây nhiệt đới vô cùng phong phú, bao gồm hàng chục giống quả như sầu riêng, xoài và chôm chôm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '种类',
      'zhǒnglèi',
      'chủng loại, thể loại',
      'Danh từ',
      'HSK 5',
      '这家大型进口水果连锁超市销售的热带水果种类繁多，涵盖了榴莲、芒果和红毛丹等数十个品种。',
      'Zhè jiā dàxíng jìnkǒu shuǐguǒ liánsuǒ chāoshì xiāoshòu de rèdài shuǐguǒ zhǒnglèi fánduō, hángài le liúlián, mángguǒ hé hóngmáodān děng shùshí ge pǐnzhǒng.',
      'Chuỗi siêu thị hoa quả nhập khẩu quy mô lớn này bày bán chủng loại trái cây nhiệt đới vô cùng phong phú, bao gồm hàng chục giống quả như sầu riêng, xoài và chôm chôm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家大型进口水果连锁超市销售的热带水果种类繁多，涵盖了榴莲、芒果和红毛丹等数十个品种。', 'Zhè jiā dàxíng jìnkǒu shuǐguǒ liánsuǒ chāoshì xiāoshòu de rèdài shuǐguǒ zhǒnglèi fánduō, hángài le liúlián, mángguǒ hé hóngmáodān děng shùshí ge pǐnzhǒng.', 'Chuỗi siêu thị hoa quả nhập khẩu quy mô lớn này bày bán chủng loại trái cây nhiệt đới vô cùng phong phú, bao gồm hàng chục giống quả như sầu riêng, xoài và chôm chôm.', 'basic', 1),
      (v_id, '热带雨林是全球生物多样性最富集的基因宝库，保存着数以百万计尚未被人类科学界明确分类描述的珍稀动植物种类。', 'Rèdài yǔlín shì quánqiú shēngwù duōyàngxìng zuì fùjí de jīyīn bǎokù, bǎocún zhe shù yǐ bǎiwàn jì shàngwèi bèi rénlèi kēxuéjiè míngquè fēnlèi miáoshù de zhēnxī dòng-zhíwù zhǒnglèi.', 'Rừng mưa nhiệt đới là kho báu gen giàu có tập trung đa dạng sinh học nhất toàn cầu, lưu giữ hàng triệu chủng loại động thực vật quý hiếm chưa từng được giới khoa học nhân loại phân loại và miêu tả rõ ràng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3530] [种子] (zhǒngzi) - hạt giống, mầm mống [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '种子' AND pinyin = 'zhǒngzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '种子' AND pinyin = 'zhǒngzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '种子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '种子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhǒngzi',
      meaning_vi = 'hạt giống, mầm mống',
      example_hanzi = '春天正是播种的最好季节，农民伯伯在湿润肥沃的田地里播撒下一粒粒饱满的玉米种子。',
      example_pinyin = 'Chūntiān zhèng shì bōzhǒng de zuì hǎo jìjié, nóngmín bóbo zài shīrùn féiwò de tiándì lǐ bōsǎ xià yílìlì bǎomǎn de yùmǐ zhǒngzi.',
      example_vi = 'Mùa xuân chính là mùa gieo hạt tốt nhất, các bác nông dân gieo từng hạt giống ngô căng mẩy xuống những mảnh ruộng ẩm ướt màu mỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '种子',
      'zhǒngzi',
      'hạt giống, mầm mống',
      'Danh từ',
      'HSK 5',
      '春天正是播种的最好季节，农民伯伯在湿润肥沃的田地里播撒下一粒粒饱满的玉米种子。',
      'Chūntiān zhèng shì bōzhǒng de zuì hǎo jìjié, nóngmín bóbo zài shīrùn féiwò de tiándì lǐ bōsǎ xià yílìlì bǎomǎn de yùmǐ zhǒngzi.',
      'Mùa xuân chính là mùa gieo hạt tốt nhất, các bác nông dân gieo từng hạt giống ngô căng mẩy xuống những mảnh ruộng ẩm ướt màu mỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春天正是播种的最好季节，农民伯伯在湿润肥沃的田地里播撒下一粒粒饱满的玉米种子。', 'Chūntiān zhèng shì bōzhǒng de zuì hǎo jìjié, nóngmín bóbo zài shīrùn féiwò de tiándì lǐ bōsǎ xià yílìlì bǎomǎn de yùmǐ zhǒngzi.', 'Mùa xuân chính là mùa gieo hạt tốt nhất, các bác nông dân gieo từng hạt giống ngô căng mẩy xuống những mảnh ruộng ẩm ướt màu mỡ.', 'basic', 1),
      (v_id, '种业振兴行动方案明确要求把种质资源安全上升到国家战略高度，坚决打赢核心农作物种子关键育种技术的翻身仗。', 'Zhǒngyè zhènxīng xíngdòng fāng''àn míngquè yāoqiú bǎ zhǒngzhì zīyuán ānquán shàngshēng dào guójiā zhànlüè gāodù, jiānjué dǎ yíng héxīn nóngzuòwù zhǒngzi guānjiàn yùzhǒng jìshù de fānshēnzhàng.', 'Phương án hành động chấn hưng ngành giống cây trồng yêu cầu rõ ràng việc nâng mức an toàn nguồn tài nguyên giống lên tầm cao chiến lược quốc gia, kiên quyết đánh thắng trận chiến chuyển mình về công nghệ tạo giống then chốt đối với hạt giống cây trồng nông nghiệp cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3531] [重大] (zhòngdà) - trọng đại, to lớn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '重大' AND pinyin = 'zhòngdà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '重大' AND pinyin = 'zhòngdà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '重大'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '重大'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhòngdà',
      meaning_vi = 'trọng đại, to lớn',
      example_hanzi = '面对关乎未来职业发展前景的重大抉择，我们一定要保持冷静理性的心态认真分析。',
      example_pinyin = 'Miànduì guānhū wèilái zhíyè fāzhǎn qiánjǐng de zhòngdà juézé, wǒmen yídìng yào bǎochí lěngjìng lǐxìng de xīntài rènzhēn fēnxī.',
      example_vi = 'Đứng trước sự lựa chọn trọng đại liên quan đến tiền đồ phát triển sự nghiệp tương lai, chúng ta nhất định phải giữ tâm thế bình tĩnh và lý tính để phân tích cẩn thận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '重大',
      'zhòngdà',
      'trọng đại, to lớn',
      'Tính từ',
      'HSK 5',
      '面对关乎未来职业发展前景的重大抉择，我们一定要保持冷静理性的心态认真分析。',
      'Miànduì guānhū wèilái zhíyè fāzhǎn qiánjǐng de zhòngdà juézé, wǒmen yídìng yào bǎochí lěngjìng lǐxìng de xīntài rènzhēn fēnxī.',
      'Đứng trước sự lựa chọn trọng đại liên quan đến tiền đồ phát triển sự nghiệp tương lai, chúng ta nhất định phải giữ tâm thế bình tĩnh và lý tính để phân tích cẩn thận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对关乎未来职业发展前景的重大抉择，我们一定要保持冷静理性的心态认真分析。', 'Miànduì guānhū wèilái zhíyè fāzhǎn qiánjǐng de zhòngdà juézé, wǒmen yídìng yào bǎochí lěngjìng lǐxìng de xīntài rènzhēn fēnxī.', 'Đứng trước sự lựa chọn trọng đại liên quan đến tiền đồ phát triển sự nghiệp tương lai, chúng ta nhất định phải giữ tâm thế bình tĩnh và lý tính để phân tích cẩn thận.', 'basic', 1),
      (v_id, '国家超级计算中心在多核异构处理器并行算力架构研发中取得了重大原创突破，大幅提升了极端气候模拟预测算力效率。', 'Guójiā chāojí jìsuàn zhōngxīn zài duōhé yìgòu chǔlǐqì bìngxíng suànlì jiàgòu yánfā zhōng qǔdé le zhòngdà yuánchuàng tūpò, dàfú tíshēng le jíduān qìhòu mónǐ yùcè suànlì xiàolǜ.', 'Trung tâm siêu máy tính quốc gia đã đạt được bước đột phá nguyên bản trọng đại trong nghiên cứu phát triển kiến trúc sức mạnh tính toán song song bộ xử lý đa nhân dị thể, nâng cao vượt bậc hiệu suất năng lực tính toán dự báo mô phỏng khí hậu cực đoan.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3532] [众多] (zhòngduō) - đông đảo, nhiều, vô số [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '众多' AND pinyin = 'zhòngduō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '众多' AND pinyin = 'zhòngduō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '众多'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '众多'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhòngduō',
      meaning_vi = 'đông đảo, nhiều, vô số',
      example_hanzi = '在市中心刚刚开业的大型购物商场里，汇聚了海内外众多知名时尚品牌服装店。',
      example_pinyin = 'Zài shìzhōngxīn gānggāng kāiyè de dàxíng gòuwù shāngchǎng lǐ, huìjù le hǎinèiwài zhòngduō zhīmíng shíshàng pǐnpái fúzhuāngdiàn.',
      example_vi = 'Bên trong trung tâm mua sắm lớn vừa mới khai trương ở trung tâm thành phố đã hội tụ đông đảo cửa hàng quần áo thương hiệu thời trang nổi tiếng trong và ngoài nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '众多',
      'zhòngduō',
      'đông đảo, nhiều, vô số',
      'Tính từ',
      'HSK 5',
      '在市中心刚刚开业的大型购物商场里，汇聚了海内外众多知名时尚品牌服装店。',
      'Zài shìzhōngxīn gānggāng kāiyè de dàxíng gòuwù shāngchǎng lǐ, huìjù le hǎinèiwài zhòngduō zhīmíng shíshàng pǐnpái fúzhuāngdiàn.',
      'Bên trong trung tâm mua sắm lớn vừa mới khai trương ở trung tâm thành phố đã hội tụ đông đảo cửa hàng quần áo thương hiệu thời trang nổi tiếng trong và ngoài nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在市中心刚刚开业的大型购物商场里，汇聚了海内外众多知名时尚品牌服装店。', 'Zài shìzhōngxīn gānggāng kāiyè de dàxíng gòuwù shāngchǎng lǐ, huìjù le hǎinèiwài zhòngduō zhīmíng shíshàng pǐnpái fúzhuāngdiàn.', 'Bên trong trung tâm mua sắm lớn vừa mới khai trương ở trung tâm thành phố đã hội tụ đông đảo cửa hàng quần áo thương hiệu thời trang nổi tiếng trong và ngoài nước.', 'basic', 1),
      (v_id, '开源大模型开发者生态凭借其透明的代码架构与低成本调用接口，迅速吸纳了全球数以万计的企业与众多独立开发者加入。', 'Kāiyuán dà-móxíng kāifāzhě shēngtài píngjiè qí tòumíng de dàimǎ jiàgòu yǔ dī-chéngběn diàoyòng jiēkǒu, xùnsù xīnà le quánqiú shù yǐ wàn jì de qǐyè yǔ zhòngduō dúlì kāifāzhě jiārù.', 'Hệ sinh thái nhà phát triển mô hình lớn mã nguồn mở nhờ kiến trúc mã minh bạch và giao diện gọi API chi phí thấp đã nhanh chóng thu hút hàng vạn doanh nghiệp và đông đảo nhà phát triển độc lập trên toàn cầu tham gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3533] [重量] (zhòngliàng) - trọng lượng, sức nặng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '重量' AND pinyin = 'zhòngliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '重量' AND pinyin = 'zhòngliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '重量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '重量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhòngliàng',
      meaning_vi = 'trọng lượng, sức nặng',
      example_hanzi = '在乘坐国际民航客机托运行李时，地勤工作人员会仔细称量每一件箱包的实际重量。',
      example_pinyin = 'Zài chéngzuò guójì mínháng kèjī tuōyùn xíngli shí, dìqín gōngzuò rényuán huì zǐxì chēngliáng měi yí jiàn xiāngbāo de shíjì zhòngliàng.',
      example_vi = 'Khi đi máy bay chở khách hàng không dân dụng quốc tế gửi hành lý ký gửi, nhân viên mặt đất sẽ cẩn thận cân đo trọng lượng thực tế của từng kiện vali túi xách.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '重量',
      'zhòngliàng',
      'trọng lượng, sức nặng',
      'Danh từ',
      'HSK 5',
      '在乘坐国际民航客机托运行李时，地勤工作人员会仔细称量每一件箱包的实际重量。',
      'Zài chéngzuò guójì mínháng kèjī tuōyùn xíngli shí, dìqín gōngzuò rényuán huì zǐxì chēngliáng měi yí jiàn xiāngbāo de shíjì zhòngliàng.',
      'Khi đi máy bay chở khách hàng không dân dụng quốc tế gửi hành lý ký gửi, nhân viên mặt đất sẽ cẩn thận cân đo trọng lượng thực tế của từng kiện vali túi xách.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在乘坐国际民航客机托运行李时，地勤工作人员会仔细称量每一件箱包的实际重量。', 'Zài chéngzuò guójì mínháng kèjī tuōyùn xíngli shí, dìqín gōngzuò rényuán huì zǐxì chēngliáng měi yí jiàn xiāngbāo de shíjì zhòngliàng.', 'Khi đi máy bay chở khách hàng không dân dụng quốc tế gửi hành lý ký gửi, nhân viên mặt đất sẽ cẩn thận cân đo trọng lượng thực tế của từng kiện vali túi xách.', 'basic', 1),
      (v_id, '新一代民用大型客机广泛采用先进碳纤维复合材料替代传统航空铝合金，在显著降低机身结构重量的同时极大提升了燃油经济性。', 'Xīn-yídài mínyòng dàxíng kèjī guǎngfàn cǎiyòng xiānjìn tàn-xiānwéi fùhé cáiliào tìdài chuántǒng hángkōng lǚhégīn, zài xiǎnzhù jiàngdī jīshēn jiégòu zhòngliàng de tóngshí jídà tíshēng le rányóu jīngjìxìng.', 'Máy bay chở khách cỡ lớn dân dụng thế hệ mới áp dụng rộng rãi vật liệu composite sợi carbon tiên tiến thay thế hợp kim nhôm hàng không truyền thống, cùng lúc hạ giảm rõ rệt trọng lượng cấu trúc thân máy bay đã nâng cao vượt bậc tính kinh tế nhiên liệu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3534] [种植] (zhòngzhí) - trồng trọt, canh tác [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '种植' AND pinyin = 'zhòngzhí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '种植' AND pinyin = 'zhòngzhí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '种植'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '种植'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhòngzhí',
      meaning_vi = 'trồng trọt, canh tác',
      example_hanzi = '为了绿化美化庭院环境，他在小花园的围栏旁种植了几株花期很长的爬藤月季花。',
      example_pinyin = 'Wèile lǜhuà měihuà tíngyuàn huánjìng, tā zài xiǎo huāyuán de wéilán páng zhòngzhí le jǐ zhū huāqī hěn cháng de páténg yuèjìhuā.',
      example_vi = 'Để phủ xanh làm đẹp môi trường sân vườn, anh ấy đã trồng mấy gốc hoa hồng leo có thời gian nở hoa rất dài bên cạnh hàng rào vườn hoa nhỏ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '种植',
      'zhòngzhí',
      'trồng trọt, canh tác',
      'Động từ',
      'HSK 5',
      '为了绿化美化庭院环境，他在小花园的围栏旁种植了几株花期很长的爬藤月季花。',
      'Wèile lǜhuà měihuà tíngyuàn huánjìng, tā zài xiǎo huāyuán de wéilán páng zhòngzhí le jǐ zhū huāqī hěn cháng de páténg yuèjìhuā.',
      'Để phủ xanh làm đẹp môi trường sân vườn, anh ấy đã trồng mấy gốc hoa hồng leo có thời gian nở hoa rất dài bên cạnh hàng rào vườn hoa nhỏ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了绿化美化庭院环境，他在小花园的围栏旁种植了几株花期很长的爬藤月季花。', 'Wèile lǜhuà měihuà tíngyuàn huánjìng, tā zài xiǎo huāyuán de wéilán páng zhòngzhí le jǐ zhū huāqī hěn cháng de páténg yuèjìhuā.', 'Để phủ xanh làm đẹp môi trường sân vườn, anh ấy đã trồng mấy gốc hoa hồng leo có thời gian nở hoa rất dài bên cạnh hàng rào vườn hoa nhỏ.', 'basic', 1),
      (v_id, '现代数字农业示范园区采用无土栽培与智能精准滴灌水肥一体化技术，实现了特色高附加值果蔬的工厂化周年种植。', 'Xiàndài shùzì nóngyè shìfàn yuánqū cǎiyòng wútǔ zāipéi yǔ zhìnéng jīngzhǔn dīguàn shuǐ-féi yītǐhuà jìshù, shíxiàn le tèsè gāo-fùjiāzhí guǒshū de gōngchǎnghuà zhōunián zhòngzhí.', 'Khu công viên trình diễn nông nghiệp số hiện đại áp dụng công nghệ thủy canh không cần đất và tưới nhỏ giọt thông minh chuẩn xác nhất thể hóa phân bón - nước, hiện thực hóa việc trồng trọt rau quả đặc sản giá trị gia tăng cao dạng nhà máy quanh năm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3535] [周年] (zhōunián) - chu niên, tròn năm, ngày kỷ niệm năm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '周年' AND pinyin = 'zhōunián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '周年' AND pinyin = 'zhōunián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '周年'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '周年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhōunián',
      meaning_vi = 'chu niên, tròn năm, ngày kỷ niệm năm',
      example_hanzi = '这所历史悠久的全国知名大学将于下个月隆重举行建校一百周年的庆典大会。',
      example_pinyin = 'Zhè suǒ lìshǐ yōujiǔ de quánguó zhīmíng dàxué jiāng yú xià ge yuè lóngzhòng jǔxíng jiànxiào yìbǎi zhōunián de qìngdiǎn dàhuì.',
      example_vi = 'Trường đại học nổi tiếng toàn quốc có lịch sử lâu đời này sẽ long trọng tổ chức đại lễ kỷ niệm 100 năm thành lập trường vào tháng tới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '周年',
      'zhōunián',
      'chu niên, tròn năm, ngày kỷ niệm năm',
      'Danh từ',
      'HSK 5',
      '这所历史悠久的全国知名大学将于下个月隆重举行建校一百周年的庆典大会。',
      'Zhè suǒ lìshǐ yōujiǔ de quánguó zhīmíng dàxué jiāng yú xià ge yuè lóngzhòng jǔxíng jiànxiào yìbǎi zhōunián de qìngdiǎn dàhuì.',
      'Trường đại học nổi tiếng toàn quốc có lịch sử lâu đời này sẽ long trọng tổ chức đại lễ kỷ niệm 100 năm thành lập trường vào tháng tới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这所历史悠久的全国知名大学将于下个月隆重举行建校一百周年的庆典大会。', 'Zhè suǒ lìshǐ yōujiǔ de quánguó zhīmíng dàxué jiāng yú xià ge yuè lóngzhòng jǔxíng jiànxiào yìbǎi zhōunián de qìngdiǎn dàhuì.', 'Trường đại học nổi tiếng toàn quốc có lịch sử lâu đời này sẽ long trọng tổ chức đại lễ kỷ niệm 100 năm thành lập trường vào tháng tới.', 'basic', 1),
      (v_id, '在两国建交五十周年纪念峰会上，双方领导人共同签署了深化全天候全面战略伙伴关系的联合声明与多项经贸合作协定。', 'Zài liǎng guó jiànjiāo wǔshí zhōunián jìniàn fēnghuì shang, shuāngfāng lǐngdǎorén gòngtóng qiānshǔ le shēnhuà quántiānhòu quánmiàn zhànlüè huǒbàn guānxì de liánhé shēngmíng yǔ duō xiàng jīng-mào hézuò xiédìng.', 'Tại hội nghị thượng đỉnh kỷ niệm 50 năm thiết lập quan hệ ngoại giao giữa hai nước, các nhà lãnh đạo hai bên đã cùng ký tuyên bố chung và nhiều hiệp định hợp tác kinh tế thương mại làm sâu sắc thêm quan hệ đối tác chiến lược toàn diện mọi thời tiết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3536] [猪] (zhū) - con lợn, con heo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '猪' AND pinyin = 'zhū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '猪' AND pinyin = 'zhū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '猪'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '猪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhū',
      meaning_vi = 'con lợn, con heo',
      example_hanzi = '农家小院的围栏里养着几头肥壮的小花猪，每天吃着天然饲料长得非常健康。',
      example_pinyin = 'Nóngjiā xiǎoyuàn de wéilán lǐ yǎng zhe jǐ tóu féizhuàng de xiǎohuāzhū, měitiān chī zhe tiānrán sìliào zhǎng de fēicháng jiànkāng.',
      example_vi = 'Trong hàng rào sân nhỏ nhà nông có nuôi mấy chú lợn khoang mập mạp, ngày ngày ăn thức ăn tự nhiên lớn lên rất khỏe mạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '猪',
      'zhū',
      'con lợn, con heo',
      'Danh từ',
      'HSK 5',
      '农家小院的围栏里养着几头肥壮的小花猪，每天吃着天然饲料长得非常健康。',
      'Nóngjiā xiǎoyuàn de wéilán lǐ yǎng zhe jǐ tóu féizhuàng de xiǎohuāzhū, měitiān chī zhe tiānrán sìliào zhǎng de fēicháng jiànkāng.',
      'Trong hàng rào sân nhỏ nhà nông có nuôi mấy chú lợn khoang mập mạp, ngày ngày ăn thức ăn tự nhiên lớn lên rất khỏe mạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '农家小院的围栏里养着几头肥壮的小花猪，每天吃着天然饲料长得非常健康。', 'Nóngjiā xiǎoyuàn de wéilán lǐ yǎng zhe jǐ tóu féizhuàng de xiǎohuāzhū, měitiān chī zhe tiānrán sìliào zhǎng de fēicháng jiànkāng.', 'Trong hàng rào sân nhỏ nhà nông có nuôi mấy chú lợn khoang mập mạp, ngày ngày ăn thức ăn tự nhiên lớn lên rất khỏe mạnh.', 'basic', 1),
      (v_id, '现代化生猪立体生态养殖示范基地全面配备智能巡检机器人、温湿度自动环控与粪污全量资源化沼气发电闭环系统。', 'Xiàndàihuà shēngzhū lìtǐ shēngtài yǎngzhí shìfàn jīdì quánmiàn pèibèi zhìnéng xúnjiǎn jīqìrén, wēn-shīdù zìdòng huánkòng yǔ fènwū quánliàng zīyuánhuà zhǎoqì fādiàn bìhuán xìtǒng.', 'Căn cứ trình diễn nuôi lợn thịt sinh thái đa tầng hiện đại hóa được trang bị toàn diện robot tuần tra kiểm tra thông minh, hệ thống kiểm soát môi trường nhiệt độ - độ ẩm tự động và vòng tuần hoàn phát điện khí sinh học tận dụng toàn bộ chất thải làm tài nguyên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3537] [逐步] (zhúbù) - từng bước một, tuần tự [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '逐步' AND pinyin = 'zhúbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '逐步' AND pinyin = 'zhúbù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '逐步'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '逐步'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'zhúbù',
      meaning_vi = 'từng bước một, tuần tự',
      example_hanzi = '通过持续不断的词汇积累与口语练习，他的中文表达能力正在逐步得到提高。',
      example_pinyin = 'Tōngguò chíxù-búduàn de cíhuì jīlěi yǔ kǒuyǔ liànxí, tā de Zhōngwén biǎodá nénglì zhèngzài zhúbù dédào tígāo.',
      example_vi = 'Thông qua việc không ngừng tích lũy từ vựng và luyện tập khẩu ngữ, khả năng diễn đạt tiếng Trung của anh ấy đang từng bước được nâng cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '逐步',
      'zhúbù',
      'từng bước một, tuần tự',
      'Phó từ',
      'HSK 5',
      '通过持续不断的词汇积累与口语练习，他的中文表达能力正在逐步得到提高。',
      'Tōngguò chíxù-búduàn de cíhuì jīlěi yǔ kǒuyǔ liànxí, tā de Zhōngwén biǎodá nénglì zhèngzài zhúbù dédào tígāo.',
      'Thông qua việc không ngừng tích lũy từ vựng và luyện tập khẩu ngữ, khả năng diễn đạt tiếng Trung của anh ấy đang từng bước được nâng cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '通过持续不断的词汇积累与口语练习，他的中文表达能力正在逐步得到提高。', 'Tōngguò chíxù-búduàn de cíhuì jīlěi yǔ kǒuyǔ liànxí, tā de Zhōngwén biǎodá nénglì zhèngzài zhúbù dédào tígāo.', 'Thông qua việc không ngừng tích lũy từ vựng và luyện tập khẩu ngữ, khả năng diễn đạt tiếng Trung của anh ấy đang từng bước được nâng cao.', 'basic', 1),
      (v_id, '金融监管部门坚持审慎稳健原则，稳妥推进本币国际化并逐步放开合格境外机构投资者的境内资本市场投资额度限制。', 'Jīnróng jiānguǎn bùmén jiānchí shěnshèn wěnjiàn yuánzé, wěntuǒ tuījìn běnbì guójìhuà bìng zhúbù fàngkāi hégé jìngwài jīgòu tóuzīzhě de jìngnèi zīběn shìchǎng tóuzī édù xiànzhì.', 'Cơ quan giám sát tài chính kiên trì nguyên tắc thận trọng vững chắc, đẩy mạnh vững vàng việc quốc tế hóa đồng nội tệ và từng bước nới lỏng giới hạn hạn mức đầu tư vào thị trường vốn trong nước đối với các nhà đầu tư tổ chức nước ngoài đủ điều kiện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3538] [逐渐] (zhújiàn) - dần dần, từ từ [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '逐渐' AND pinyin = 'zhújiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '逐渐' AND pinyin = 'zhújiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '逐渐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '逐渐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'zhújiàn',
      meaning_vi = 'dần dần, từ từ',
      example_hanzi = '太阳下山以后，原本热闹喧嚣的海滨沙滩逐渐恢复了宁静与安详。',
      example_pinyin = 'Tàiyáng xiàshān yǐhòu, yuánběn rènao xuānxiāo de hǎibīn shātān zhújiàn huīfù le níngjìng yǔ ānxiáng.',
      example_vi = 'Sau khi mặt trời lặn xuống núi, bãi cát ven biển vốn náo nhiệt ồn ào dần dần khôi phục lại vẻ yên tĩnh và thanh bình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '逐渐',
      'zhújiàn',
      'dần dần, từ từ',
      'Phó từ',
      'HSK 5',
      '太阳下山以后，原本热闹喧嚣的海滨沙滩逐渐恢复了宁静与安详。',
      'Tàiyáng xiàshān yǐhòu, yuánběn rènao xuānxiāo de hǎibīn shātān zhújiàn huīfù le níngjìng yǔ ānxiáng.',
      'Sau khi mặt trời lặn xuống núi, bãi cát ven biển vốn náo nhiệt ồn ào dần dần khôi phục lại vẻ yên tĩnh và thanh bình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '太阳下山以后，原本热闹喧嚣的海滨沙滩逐渐恢复了宁静与安详。', 'Tàiyáng xiàshān yǐhòu, yuánběn rènao xuānxiāo de hǎibīn shātān zhújiàn huīfù le níngjìng yǔ ānxiáng.', 'Sau khi mặt trời lặn xuống núi, bãi cát ven biển vốn náo nhiệt ồn ào dần dần khôi phục lại vẻ yên tĩnh và thanh bình.', 'basic', 1),
      (v_id, '随着可再生清洁能源装机规模的井喷式增长，传统化石能源在国家总体能源消耗结构中的主导地位正在逐渐被绿电所替代。', 'Suízhe kězàishēng qīngjié néngyuán zhuāngjī guīmó de jǐngpēnshì zēngzhǎng, chuántǒng huàshí néngyuán zài guójiā zǒngtǐ néngyuán xiāohào jiégòu zhōng de zhǔdǎo dìwèi zhèngzài zhújiàn bèi lǜdiàn suǒ tìdài.', 'Cùng với sự tăng trưởng bùng nổ theo kiểu phun trào về quy mô công suất lắp đặt năng lượng sạch tái tạo, vị thế chủ đạo của năng lượng hóa thạch truyền thống trong cơ cấu tiêu thụ năng lượng tổng thể quốc gia đang dần dần được thay thế bằng điện xanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3539] [竹子] (zhúzi) - cây tre, cây trúc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '竹子' AND pinyin = 'zhúzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '竹子' AND pinyin = 'zhúzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '竹子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '竹子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhúzi',
      meaning_vi = 'cây tre, cây trúc',
      example_hanzi = '大熊猫非常喜欢吃清脆新鲜的竹子，每天大部分时间都在悠闲地咀嚼竹叶和竹笋。',
      example_pinyin = 'Dàxióngmāo fēicháng xǐhuan chī qīngcuì xīnxiān de zhúzi, měitiān dà bùfen shíjiān dōu zài yōuxián de jǔjué zhúyè hé zhúsǔn.',
      example_vi = 'Gấu trúc khổng lồ rất thích ăn tre trúc tươi giòn, phần lớn thời gian mỗi ngày đều ung dung nhai lá tre và măng tre.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '竹子',
      'zhúzi',
      'cây tre, cây trúc',
      'Danh từ',
      'HSK 5',
      '大熊猫非常喜欢吃清脆新鲜的竹子，每天大部分时间都在悠闲地咀嚼竹叶和竹笋。',
      'Dàxióngmāo fēicháng xǐhuan chī qīngcuì xīnxiān de zhúzi, měitiān dà bùfen shíjiān dōu zài yōuxián de jǔjué zhúyè hé zhúsǔn.',
      'Gấu trúc khổng lồ rất thích ăn tre trúc tươi giòn, phần lớn thời gian mỗi ngày đều ung dung nhai lá tre và măng tre.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大熊猫非常喜欢吃清脆新鲜的竹子，每天大部分时间都在悠闲地咀嚼竹叶和竹笋。', 'Dàxióngmāo fēicháng xǐhuan chī qīngcuì xīnxiān de zhúzi, měitiān dà bùfen shíjiān dōu zài yōuxián de jǔjué zhúyè hé zhúsǔn.', 'Gấu trúc khổng lồ rất thích ăn tre trúc tươi giòn, phần lớn thời gian mỗi ngày đều ung dung nhai lá tre và măng tre.', 'basic', 1),
      (v_id, '以竹代塑产业创新联盟通过先进纳米生物改性技术，将速生竹子资源深度加工成高强度全生物降解环保包装与结构材料。', 'Yǐ-zhú-dài-sù chǎnyè chuàngxīn liánméng tōngguò xiānjìn nàmǐ shēngwù gǎixìng jìshù, jiāng sùshēng zhúzi zīyuán shēndù jiāgōng chéng gāogiángdù quán-shēngwù-jiàngjiě huánbǎo bāozhuāng yǔ jiégòu cáiliào.', 'Liên minh đổi mới công nghiệp "lấy tre thay nhựa" thông qua công nghệ biến tính sinh học nano tiên tiến đã gia công sâu nguồn tài nguyên tre sinh trưởng nhanh thành bao bì bảo vệ môi trường phân hủy sinh học hoàn toàn và vật liệu kết cấu có độ bền cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3540] [煮] (zhǔ) - nấu, luộc, đun sôi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '煮' AND pinyin = 'zhǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '煮' AND pinyin = 'zhǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '煮'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '煮'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǔ',
      meaning_vi = 'nấu, luộc, đun sôi',
      example_hanzi = '冬天的早晨，妈妈早早起床在厨房里为全家人煮了一锅热气腾腾的红枣小米粥。',
      example_pinyin = 'Dōngtiān de zǎochén, māma zǎozǎo qǐchuáng zài chúfáng lǐ wèi quánjiārén zhǔ le yì guō rèqì-téngténg de hóngzǎo xiǎomǐzhōu.',
      example_vi = 'Buổi sáng mùa đông, mẹ thức dậy từ sớm ở trong bếp nấu cho cả gia đình một nồi cháo kê táo đỏ nóng hôi hổi bốc khói nghi ngút.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '煮',
      'zhǔ',
      'nấu, luộc, đun sôi',
      'Động từ',
      'HSK 5',
      '冬天的早晨，妈妈早早起床在厨房里为全家人煮了一锅热气腾腾的红枣小米粥。',
      'Dōngtiān de zǎochén, māma zǎozǎo qǐchuáng zài chúfáng lǐ wèi quánjiārén zhǔ le yì guō rèqì-téngténg de hóngzǎo xiǎomǐzhōu.',
      'Buổi sáng mùa đông, mẹ thức dậy từ sớm ở trong bếp nấu cho cả gia đình một nồi cháo kê táo đỏ nóng hôi hổi bốc khói nghi ngút.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬天的早晨，妈妈早早起床在厨房里为全家人煮了一锅热气腾腾的红枣小米粥。', 'Dōngtiān de zǎochén, māma zǎozǎo qǐchuáng zài chúfáng lǐ wèi quánjiārén zhǔ le yì guō rèqì-téngténg de hóngzǎo xiǎomǐzhōu.', 'Buổi sáng mùa đông, mẹ thức dậy từ sớm ở trong bếp nấu cho cả gia đình một nồi cháo kê táo đỏ nóng hôi hổi bốc khói nghi ngút.', 'basic', 1),
      (v_id, '现代食品工业真空低温蒸煮技术精确锁定肉制品的肌原纤维蛋白多肽结构，完美保留了食材的原生风味与天然营养成分。', 'Xiàndài shípǐn gōngyè zhēnkōng dīwēn zhēngzhǔ jìshù jīngquè suǒdìng ròuzhìpǐn de jīyuán-xiānwéi dànbái duōtài jiégòu, wánměi bǎoliú le shícái de yuánshēng fēngwèi yǔ tiānrán yíngyǎng chéngfèn.', 'Công nghệ hấp nấu chân không nhiệt độ thấp của công nghiệp thực phẩm hiện đại khóa chuẩn xác cấu trúc polypeptide protein sợi cơ của sản phẩm thịt, lưu giữ hoàn hảo hương vị nguyên bản và thành phần dinh dưỡng tự nhiên của nguyên liệu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3541] [主持] (zhǔchí) - chủ trì, dẫn chương trình, đảm đương [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '主持' AND pinyin = 'zhǔchí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主持' AND pinyin = 'zhǔchí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '主持'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主持'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhǔchí',
      meaning_vi = 'chủ trì, dẫn chương trình, đảm đương',
      example_hanzi = '这位年轻的女主持人台风大方优雅、普通话标准，成功主持了本次校园歌手大赛。',
      example_pinyin = 'Zhè wèi niánqīng de nǚ zhǔchírén táifēng dàfang yōuyǎ, pǔtōnghuà biāozhǔn, chénggōng zhǔchí le běncì xiàoyuán gēshǒu dàsài.',
      example_vi = 'Cô nữ dẫn chương trình trẻ tuổi này phong thái sân khấu đĩnh đạc tao nhã, phát âm tiếng phổ thông chuẩn mực, đã dẫn chương trình thành công cuộc thi ca sĩ học đường lần này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '主持',
      'zhǔchí',
      'chủ trì, dẫn chương trình, đảm đương',
      'Động từ',
      'HSK 5',
      '这位年轻的女主持人台风大方优雅、普通话标准，成功主持了本次校园歌手大赛。',
      'Zhè wèi niánqīng de nǚ zhǔchírén táifēng dàfang yōuyǎ, pǔtōnghuà biāozhǔn, chénggōng zhǔchí le běncì xiàoyuán gēshǒu dàsài.',
      'Cô nữ dẫn chương trình trẻ tuổi này phong thái sân khấu đĩnh đạc tao nhã, phát âm tiếng phổ thông chuẩn mực, đã dẫn chương trình thành công cuộc thi ca sĩ học đường lần này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位年轻的女主持人台风大方优雅、普通话标准，成功主持了本次校园歌手大赛。', 'Zhè wèi niánqīng de nǚ zhǔchírén táifēng dàfang yōuyǎ, pǔtōnghuà biāozhǔn, chénggōng zhǔchí le běncì xiàoyuán gēshǒu dàsài.', 'Cô nữ dẫn chương trình trẻ tuổi này phong thái sân khấu đĩnh đạc tao nhã, phát âm tiếng phổ thông chuẩn mực, đã dẫn chương trình thành công cuộc thi ca sĩ học đường lần này.', 'basic', 1),
      (v_id, '国际货币基金组织总裁主持召开了多边主权债务重组高级别圆桌闭门会议，积极协调各主权债权国共同防范发展中国家系统性债务违约。', 'Guójì Huòbì Jījīn Zǔzhī zǒngcái zhǔchí zhàokāi le duōbiān zhǔquán zhàiwù chóngzǔ gāojíbié yuánzhuō bìmén huìyì, jījí xiétiáo gè zhǔquán zhàiquánguó gòngtóng fángfàn fāzhǎnzhōng guójiā xìtǒngxìng zhàiwù wéiyuē.', 'Tổng giám đốc Quỹ Tiền tệ Quốc tế đã chủ trì cuộc họp bàn tròn kín cấp cao về tái cơ cấu nợ chủ quyền đa phương, tích cực điều phối các quốc gia chủ nợ cùng phòng chống vỡ nợ mang tính hệ thống của các quốc gia đang phát triển.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3542] [主动] (zhǔdòng) - chủ động [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '主动' AND pinyin = 'zhǔdòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主动' AND pinyin = 'zhǔdòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '主动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'zhǔdòng',
      meaning_vi = 'chủ động',
      example_hanzi = '在新的工作环境中，我们要主动与同事沟通交流，积极融入整个团队大家庭。',
      example_pinyin = 'Zài xīn de gōngzuò huánjìng zhōng, wǒmen yào zhǔdòng yǔ tóngshì gōutōng jiāoliú, jījí róngrù zhěnggè tuánduì dàjiātíng.',
      example_vi = 'Trong môi trường làm việc mới, chúng ta cần chủ động trao đổi giao lưu với các đồng nghiệp, tích cực hòa nhập vào đại gia đình toàn đội ngũ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '主动',
      'zhǔdòng',
      'chủ động',
      'Tính từ / Động từ',
      'HSK 5',
      '在新的工作环境中，我们要主动与同事沟通交流，积极融入整个团队大家庭。',
      'Zài xīn de gōngzuò huánjìng zhōng, wǒmen yào zhǔdòng yǔ tóngshì gōutōng jiāoliú, jījí róngrù zhěnggè tuánduì dàjiātíng.',
      'Trong môi trường làm việc mới, chúng ta cần chủ động trao đổi giao lưu với các đồng nghiệp, tích cực hòa nhập vào đại gia đình toàn đội ngũ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在新的工作环境中，我们要主动与同事沟通交流，积极融入整个团队大家庭。', 'Zài xīn de gōngzuò huánjìng zhōng, wǒmen yào zhǔdòng yǔ tóngshì gōutōng jiāoliú, jījí róngrù zhěnggè tuánduì dàjiātíng.', 'Trong môi trường làm việc mới, chúng ta cần chủ động trao đổi giao lưu với các đồng nghiệp, tích cực hòa nhập vào đại gia đình toàn đội ngũ.', 'basic', 1),
      (v_id, '面对国际经贸规则的深刻调整，我国坚定不移主动对接国际高标准经贸规则，稳步扩大制度型开放以赢得未来全球竞争主动权。', 'Miànduì guójì jīng-mào guīzé de shēndù tiáozhěng, wǒguó jiāndìng-bùyí zhǔdòng duìjiē guójì gāobiāozhǔn jīng-mào guīzé, wěnbù kuòdà zhìdùxíng kāifàng yǐ yíngdé wèilái quánqiú jìngzhēng zhǔdòngquán.', 'Đứng trước sự điều chỉnh sâu sắc của các quy tắc kinh tế thương mại quốc tế, nước ta kiên định không dời chủ động kết nối với các quy tắc thương mại tiêu chuẩn cao quốc tế, mở rộng vững chắc sự mở cửa dạng thể chế nhằm giành quyền chủ động cạnh tranh toàn cầu trong tương lai.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3543] [主观] (zhǔguān) - chủ quan [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '主观' AND pinyin = 'zhǔguān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主观' AND pinyin = 'zhǔguān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '主观'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主观'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhǔguān',
      meaning_vi = 'chủ quan',
      example_hanzi = '我们在评价一个人的工作表现时，应当摆事实讲道理，不能掺杂过多个人主观偏见。',
      example_pinyin = 'Wǒmen zài píngjià yí ge rén de gōngzuò biǎoxiàn shí, yīngdāng bǎi shìshí jiǎng dàolǐ, bù néng chānzá guòduō gèrén zhǔguān piānjiàn.',
      example_vi = 'Chúng ta khi đánh giá biểu hiện công tác của một con người cần phải đưa ra sự thật nói rõ lý lẽ, không thể pha trộn quá nhiều thành kiến chủ quan cá nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '主观',
      'zhǔguān',
      'chủ quan',
      'Tính từ',
      'HSK 5',
      '我们在评价一个人的工作表现时，应当摆事实讲道理，不能掺杂过多个人主观偏见。',
      'Wǒmen zài píngjià yí ge rén de gōngzuò biǎoxiàn shí, yīngdāng bǎi shìshí jiǎng dàolǐ, bù néng chānzá guòduō gèrén zhǔguān piānjiàn.',
      'Chúng ta khi đánh giá biểu hiện công tác của một con người cần phải đưa ra sự thật nói rõ lý lẽ, không thể pha trộn quá nhiều thành kiến chủ quan cá nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们在评价一个人的工作表现时，应当摆事实讲道理，不能掺杂过多个人主观偏见。', 'Wǒmen zài píngjià yí ge rén de gōngzuò biǎoxiàn shí, yīngdāng bǎi shìshí jiǎng dàolǐ, bù néng chānzá guòduō gèrén zhǔguān piānjiàn.', 'Chúng ta khi đánh giá biểu hiện công tác của một con người cần phải đưa ra sự thật nói rõ lý lẽ, không thể pha trộn quá nhiều thành kiến chủ quan cá nhân.', 'basic', 1),
      (v_id, '宏观金融风险评估体系必须依赖可量化的大数据客观压力测试模型，有效规避人工研判中易于产生的经验主义与主观臆断误差。', 'Hóngguān jīnróng fēngxiǎn pínggū tǐxì bìxū yīlài kě-liànghuà de dà-shùjù kèguān yālì cèshì móxíng, yǒuxiào guībì réngōng yánpàn zhōng yìyú chǎnshēng de jīngyànzhǔyì yǔ zhǔguān yìduàn wùchā.', 'Hệ thống đánh giá rủi ro tài chính vĩ mô bắt buộc phải phụ thuộc vào các mô hình kiểm tra sức chịu tải khách quan dữ liệu lớn có thể lượng hóa, né tránh một cách hiệu quả sai số suy đoán chủ quan và chủ nghĩa kinh nghiệm dễ nảy sinh trong phán đoán thủ công bằng con người.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3544] [主人] (zhǔrén) - chủ nhân, chủ nhà [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '主人' AND pinyin = 'zhǔrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主人' AND pinyin = 'zhǔrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '主人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhǔrén',
      meaning_vi = 'chủ nhân, chủ nhà',
      example_hanzi = '每当有远道而来的客人登门拜访，热情好客的房主人总是会端出香浓的清茶招待。',
      example_pinyin = 'Měidāng yǒu yuǎndào-érlái de kèrén dēngmén bàifǎng, rèqíng-hàokè de fángzhǔrén zǒngshì huì duān chū xiāngnóng de qīngchá zhāodài.',
      example_vi = 'Mỗi khi có khách từ phương xa đến thăm nhà, người chủ nhà nhiệt tình mến khách bao giờ cũng bưng ra chén trà thanh thơm ngát thết đãi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '主人',
      'zhǔrén',
      'chủ nhân, chủ nhà',
      'Danh từ',
      'HSK 5',
      '每当有远道而来的客人登门拜访，热情好客的房主人总是会端出香浓的清茶招待。',
      'Měidāng yǒu yuǎndào-érlái de kèrén dēngmén bàifǎng, rèqíng-hàokè de fángzhǔrén zǒngshì huì duān chū xiāngnóng de qīngchá zhāodài.',
      'Mỗi khi có khách từ phương xa đến thăm nhà, người chủ nhà nhiệt tình mến khách bao giờ cũng bưng ra chén trà thanh thơm ngát thết đãi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每当有远道而来的客人登门拜访，热情好客的房主人总是会端出香浓的清茶招待。', 'Měidāng yǒu yuǎndào-érlái de kèrén dēngmén bàifǎng, rèqíng-hàokè de fángzhǔrén zǒngshì huì duān chū xiāngnóng de qīngchá zhāodài.', 'Mỗi khi có khách từ phương xa đến thăm nhà, người chủ nhà nhiệt tình mến khách bao giờ cũng bưng ra chén trà thanh thơm ngát thết đãi.', 'basic', 1),
      (v_id, '全过程人民民主深刻保障了广大人民群众作为国家和社会主人的崇高政治地位，实现最广泛而真实的民主权利。', 'Quán-guòchéng rénmín mínzhǔ shēndù bǎozhàng le guǎngdà rénmín qúnzhòng zuòwéi guójiā hé shèhuì zhǔrén de chónggāo zhèngzhì dìwèi, shíxiàn zuì guǎngfàn ér zhēnshí de mínzhǔ quánlì.', 'Nền dân chủ nhân dân toàn quá trình đã bảo đảm sâu sắc vị thế chính trị cao cả của đông đảo quần chúng nhân dân với tư cách là chủ nhân của đất nước và xã hội, hiện thực hóa các quyền dân chủ chân thực và rộng rãi nhất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3545] [主任] (zhǔrèn) - chủ nhiệm, trưởng phòng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '主任' AND pinyin = 'zhǔrèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主任' AND pinyin = 'zhǔrèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '主任'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主任'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhǔrèn',
      meaning_vi = 'chủ nhiệm, trưởng phòng',
      example_hanzi = '医院内科门诊部的张主任从医三十余年，凭借精湛的医术深受广大患者的信赖。',
      example_pinyin = 'Yīyuàn nèikē ménzhěnbù de Zhāng zhǔrèn cóngyī sānshí yú nián, píngjiè jīngzhàn de yīshù shēnshòu guǎngdà huànzhě de xìnlài.',
      example_vi = 'Bác sĩ chủ nhiệm Trương của khoa nội phòng khám bệnh viện hành nghề y hơn ba mươi năm, nhờ y thuật tinh xảo mà nhận được sự tin yêu sâu sắc của đông đảo bệnh nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '主任',
      'zhǔrèn',
      'chủ nhiệm, trưởng phòng',
      'Danh từ',
      'HSK 5',
      '医院内科门诊部的张主任从医三十余年，凭借精湛的医术深受广大患者的信赖。',
      'Yīyuàn nèikē ménzhěnbù de Zhāng zhǔrèn cóngyī sānshí yú nián, píngjiè jīngzhàn de yīshù shēnshòu guǎngdà huànzhě de xìnlài.',
      'Bác sĩ chủ nhiệm Trương của khoa nội phòng khám bệnh viện hành nghề y hơn ba mươi năm, nhờ y thuật tinh xảo mà nhận được sự tin yêu sâu sắc của đông đảo bệnh nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医院内科门诊部的张主任从医三十余年，凭借精湛的医术深受广大患者的信赖。', 'Yīyuàn nèikē ménzhěnbù de Zhāng zhǔrèn cóngyī sānshí yú nián, píngjiè jīngzhàn de yīshù shēnshòu guǎngdà huànzhě de xìnlài.', 'Bác sĩ chủ nhiệm Trương của khoa nội phòng khám bệnh viện hành nghề y hơn ba mươi năm, nhờ y thuật tinh xảo mà nhận được sự tin yêu sâu sắc của đông đảo bệnh nhân.', 'basic', 1),
      (v_id, '国家发展改革委相关职能司局主任在新闻发布会上全面解读了关于促进民营经济发展壮大的多项重大政策举措。', 'Guójiā Fāzhǎn Gǎigé Wěi xiāngguān zhínéng sījú zhǔrèn zài xīnwén fābùhuì shang quánmiàn jiědú le guānyú cùjìn mínyíng jīngjì fāzhǎn zhuàngdà de duō xiàng zhòngdà zhèngcè jǔcuò.', 'Chủ nhiệm cục vụ chức năng liên quan thuộc Ủy ban Cải cách và Phát triển Quốc gia tại buổi họp báo đã diễn giải toàn diện nhiều biện pháp chính sách trọng đại về việc thúc đẩy kinh tế tư nhân phát triển lớn mạnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3546] [主食] (zhǔshí) - món ăn chính, lương thực chính (cơm, mì, bánh mì...) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '主食' AND pinyin = 'zhǔshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主食' AND pinyin = 'zhǔshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '主食'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主食'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhǔshí',
      meaning_vi = 'món ăn chính, lương thực chính (cơm, mì, bánh mì...)',
      example_hanzi = '在中国北方地区，人们习惯把馒头、面条和饺子等面食当作一日三餐的主食。',
      example_pinyin = 'Zài Zhōngguó běifāng dìqū, rénmen xíguàn bǎ mántou, miàntiáo hé jiǎozi děng miànshí dàngzuò yírì-sāncān de zhǔshí.',
      example_vi = 'Ở khu vực miền bắc Trung Quốc, mọi người có thói quen lấy các món làm từ bột mì như bánh bao chay, mì sợi và sủi cảo làm món ăn chính trong ba bữa mỗi ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '主食',
      'zhǔshí',
      'món ăn chính, lương thực chính (cơm, mì, bánh mì...)',
      'Danh từ',
      'HSK 5',
      '在中国北方地区，人们习惯把馒头、面条和饺子等面食当作一日三餐的主食。',
      'Zài Zhōngguó běifāng dìqū, rénmen xíguàn bǎ mántou, miàntiáo hé jiǎozi děng miànshí dàngzuò yírì-sāncān de zhǔshí.',
      'Ở khu vực miền bắc Trung Quốc, mọi người có thói quen lấy các món làm từ bột mì như bánh bao chay, mì sợi và sủi cảo làm món ăn chính trong ba bữa mỗi ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在中国北方地区，人们习惯把馒头、面条和饺子等面食当作一日三餐的主食。', 'Zài Zhōngguó běifāng dìqū, rénmen xíguàn bǎ mántou, miàntiáo hé jiǎozi děng miànshí dàngzuò yírì-sāncān de zhǔshí.', 'Ở khu vực miền bắc Trung Quốc, mọi người có thói quen lấy các món làm từ bột mì như bánh bao chay, mì sợi và sủi cảo làm món ăn chính trong ba bữa mỗi ngày.', 'basic', 1),
      (v_id, '临床营养学与慢性病代谢研究表明，合理提升全谷物与低升糖指数杂粮在日常主食中的摄入比例，有助于显著降低心血管与糖尿病患病风险。', 'Línchuáng yíngyǎngxué yǔ mànxìngbìng dàixiè yánjiū biǎomíng, hélǐ tíshēng quán-gǔwù yǔ dī-shēngtáng-zhǐshù záliáng zài rìcháng zhǔshí zhōng de shèrù bǐlì, yǒu zhùyú xiǎnzhù jiàngdī xīnxuèguǎn yǔ tángniàobìng huànbìng fēngxiǎn.', 'Nghiên cứu chuyển hóa bệnh mãn tính và dinh dưỡng lâm sàng chỉ ra rằng việc nâng cao hợp lý tỷ lệ nạp ngũ cốc nguyên hạt và các loại hạt thô có chỉ số đường huyết thấp trong món ăn chính hàng ngày có tác dụng hạ giảm rõ rệt nguy cơ mắc bệnh tim mạch và tiểu đường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3547] [主题] (zhǔtí) - chủ đề [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '主题' AND pinyin = 'zhǔtí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主题' AND pinyin = 'zhǔtí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '主题'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主题'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhǔtí',
      meaning_vi = 'chủ đề',
      example_hanzi = '本次校园英语演讲比赛的主题是青年与时代使命，吸引了来自全校各个院系的选手参与。',
      example_pinyin = 'Běncì xiàoyuán Yīngyǔ yǎnjiǎng bǐsài de zhǔtí shì qīngnián yǔ shídài shǐmìng, xīyǐn le láizì quán xiào gè ge yuànxì de xuǎnshǒu cānyù.',
      example_vi = 'Chủ đề của cuộc thi hùng biện tiếng Anh học đường lần này là thanh niên và sứ mệnh thời đại, đã thu hút các thí sinh đến từ khắp các khoa viện trong toàn trường tham gia.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '主题',
      'zhǔtí',
      'chủ đề',
      'Danh từ',
      'HSK 5',
      '本次校园英语演讲比赛的主题是青年与时代使命，吸引了来自全校各个院系的选手参与。',
      'Běncì xiàoyuán Yīngyǔ yǎnjiǎng bǐsài de zhǔtí shì qīngnián yǔ shídài shǐmìng, xīyǐn le láizì quán xiào gè ge yuànxì de xuǎnshǒu cānyù.',
      'Chủ đề của cuộc thi hùng biện tiếng Anh học đường lần này là thanh niên và sứ mệnh thời đại, đã thu hút các thí sinh đến từ khắp các khoa viện trong toàn trường tham gia.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '本次校园英语演讲比赛的主题是青年与时代使命，吸引了来自全校各个院系的选手参与。', 'Běncì xiàoyuán Yīngyǔ yǎnjiǎng bǐsài de zhǔtí shì qīngnián yǔ shídài shǐmìng, xīyǐn le láizì quán xiào gè ge yuànxì de xuǎnshǒu cānyù.', 'Chủ đề của cuộc thi hùng biện tiếng Anh học đường lần này là thanh niên và sứ mệnh thời đại, đã thu hút các thí sinh đến từ khắp các khoa viện trong toàn trường tham gia.', 'basic', 1),
      (v_id, '达沃斯世界经济论坛年会围绕推动全球经济在分化中实现包容性韧性增长的主题展开了多场高级别闭门战略对话。', 'Dáwòsī Shìjiè Jīngjì Lùntán niánhuì wéirào tuīdòng quánqiú jīngjì zài fēnhuà zhōng shíxiàn bāoróngxìng rènxìng zēngzhǎng de zhǔtí zhǎnkāi le duō chǎng gāojíbié bìmén zhànlüè duìhuà.', 'Hội nghị thường niên Diễn đàn Kinh tế Thế giới Davos xoay quanh chủ đề thúc đẩy nền kinh tế toàn cầu đạt được mức tăng trưởng kiên cường bao trùm giữa bối cảnh phân hóa đã triển khai nhiều phiên đối thoại chiến lược kín cấp cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3548] [主席] (zhǔxí) - chủ tịch [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '主席' AND pinyin = 'zhǔxí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主席' AND pinyin = 'zhǔxí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '主席'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '主席'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhǔxí',
      meaning_vi = 'chủ tịch',
      example_hanzi = '在今天下午召开的班委会换届选举中，李明同学以高票当选为新一届班级学生会主席。',
      example_pinyin = 'Zài jīntiān xiàwǔ zhàokāi de bānwěihuì huànjiè xuǎnjǔ zhōng, Lǐ Míng tóngxué yǐ gāopiào dāngxuǎn wéi xīn-yí-jiè bānjí xuéshenghuì zhǔxí.',
      example_vi = 'Trong cuộc bầu cử chuyển giao nhiệm kỳ ban cán sự lớp triệu tập chiều nay, bạn Lý Minh đã trúng cử làm chủ tịch hội sinh viên lớp khóa mới với số phiếu cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '主席',
      'zhǔxí',
      'chủ tịch',
      'Danh từ',
      'HSK 5',
      '在今天下午召开的班委会换届选举中，李明同学以高票当选为新一届班级学生会主席。',
      'Zài jīntiān xiàwǔ zhàokāi de bānwěihuì huànjiè xuǎnjǔ zhōng, Lǐ Míng tóngxué yǐ gāopiào dāngxuǎn wéi xīn-yí-jiè bānjí xuéshenghuì zhǔxí.',
      'Trong cuộc bầu cử chuyển giao nhiệm kỳ ban cán sự lớp triệu tập chiều nay, bạn Lý Minh đã trúng cử làm chủ tịch hội sinh viên lớp khóa mới với số phiếu cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在今天下午召开的班委会换届选举中，李明同学以高票当选为新一届班级学生会主席。', 'Zài jīntiān xiàwǔ zhàokāi de bānwěihuì huànjiè xuǎnjǔ zhōng, Lǐ Míng tóngxué yǐ gāopiào dāngxuǎn wéi xīn-yí-jiè bānjí xuéshenghuì zhǔxí.', 'Trong cuộc bầu cử chuyển giao nhiệm kỳ ban cán sự lớp triệu tập chiều nay, bạn Lý Minh đã trúng cử làm chủ tịch hội sinh viên lớp khóa mới với số phiếu cao.', 'basic', 1),
      (v_id, '二十国集团轮值主席国领导人在峰会开幕致辞中呼吁各成员国摒弃零和博弈思维，深化全球宏观经济政策协同与绿色转型投资。', 'Èrshí Guó Jítuán lúnzhí zhǔxíguó lǐngdǎorén zài fēnghuì kāimù zhìcí zhōng hūyù gè chéngyuánguó bìngqì línghé-bóyì sīwéi, shēnhuà quánqiú hóngguān jīngjì zhèngcè xiétóng yǔ lǜsè zhuǎnxíng tóuzī.', 'Nhà lãnh đạo quốc gia chủ tịch luân phiên G20 trong bài phát biểu khai mạc hội nghị thượng đỉnh đã kêu gọi các nước thành viên gạt bỏ tư duy được mất tổng bằng không, làm sâu sắc thêm sự phối hợp chính sách kinh tế vĩ mô toàn cầu và đầu tư chuyển đổi xanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3549] [注册] (zhùcè) - đăng ký, đăng kiểm, ghi danh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '注册' AND pinyin = 'zhùcè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '注册' AND pinyin = 'zhùcè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '注册'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '注册'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhùcè',
      meaning_vi = 'đăng ký, đăng kiểm, ghi danh',
      example_hanzi = '新学期开学第一天，同学们都需要携带学生证到教务处大厅办理学籍报到与注册手续。',
      example_pinyin = 'Xīn-xuéqī kāixué dì-yī tiān, tóngxuémen dōu xūyào xiédài xuéshengzhèng dào jiàowùchù dàtīng bànlǐ xuéjí bàodào yǔ zhùcè shǒuxù.',
      example_vi = 'Ngày đầu tiên khai giảng học kỳ mới, các bạn học sinh đều cần mang theo thẻ học sinh đến đại sảnh phòng giáo vụ làm thủ tục báo danh và đăng ký học tịch.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '注册',
      'zhùcè',
      'đăng ký, đăng kiểm, ghi danh',
      'Động từ',
      'HSK 5',
      '新学期开学第一天，同学们都需要携带学生证到教务处大厅办理学籍报到与注册手续。',
      'Xīn-xuéqī kāixué dì-yī tiān, tóngxuémen dōu xūyào xiédài xuéshengzhèng dào jiàowùchù dàtīng bànlǐ xuéjí bàodào yǔ zhùcè shǒuxù.',
      'Ngày đầu tiên khai giảng học kỳ mới, các bạn học sinh đều cần mang theo thẻ học sinh đến đại sảnh phòng giáo vụ làm thủ tục báo danh và đăng ký học tịch.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新学期开学第一天，同学们都需要携带学生证到教务处大厅办理学籍报到与注册手续。', 'Xīn-xuéqī kāixué dì-yī tiān, tóngxuémen dōu xūyào xiédài xuéshengzhèng dào jiàowùchù dàtīng bànlǐ xuéjí bàodào yǔ zhùcè shǒuxù.', 'Ngày đầu tiên khai giảng học kỳ mới, các bạn học sinh đều cần mang theo thẻ học sinh đến đại sảnh phòng giáo vụ làm thủ tục báo danh và đăng ký học tịch.', 'basic', 1),
      (v_id, '资本市场全面实行股票发行注册制改革，将企业发行上市的选择权真正交给市场，强化全流程信息披露与退市常态化监管。', 'Zīběn shìchǎng quánmiàn shíxíng gǔpiào fāxíng zhùcèzhì gǎigé, jiāng qǐyè fāxíng shàngshì de xuǎnzéquán zhēnzhèng jiāo gěi shìchǎng, qiánghuà quán-liúchéng xìnxī pīlù yǔ tuìshì chángtàihuà jiānguǎn.', 'Thị trường vốn thực hiện toàn diện cải cách chế độ đăng ký phát hành cổ phiếu, thực sự trao quyền lựa chọn phát hành niêm yết của doanh nghiệp cho thị trường, tăng cường công bố thông tin toàn quy trình và giám sát bình thường hóa việc hủy niêm yết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3550] [住房] (zhùfáng) - nhà ở, chỗ ở [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '住房' AND pinyin = 'zhùfáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '住房' AND pinyin = 'zhùfáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '住房'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '住房'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhùfáng',
      meaning_vi = 'nhà ở, chỗ ở',
      example_hanzi = '为了减轻年轻大学毕业生的租房压力，市政府专门兴建了一批租金优惠的人才保障性住房。',
      example_pinyin = 'Wèile jiǎnqīng niánqīng dàxué bìyèshēng de zūfáng yālì, shì zhèngfǔ zhuānmén xīngjiàn le yì pī zūjīn yōuhuì de réncái bǎozhàngxìng zhùfáng.',
      example_vi = 'Để giảm bớt áp lực thuê nhà cho các sinh viên đại học trẻ mới tốt nghiệp, chính quyền thành phố đã đặc biệt xây dựng một đợt nhà ở xã hội bảo đảm cho nhân tài có giá thuê ưu đãi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '住房',
      'zhùfáng',
      'nhà ở, chỗ ở',
      'Danh từ',
      'HSK 5',
      '为了减轻年轻大学毕业生的租房压力，市政府专门兴建了一批租金优惠的人才保障性住房。',
      'Wèile jiǎnqīng niánqīng dàxué bìyèshēng de zūfáng yālì, shì zhèngfǔ zhuānmén xīngjiàn le yì pī zūjīn yōuhuì de réncái bǎozhàngxìng zhùfáng.',
      'Để giảm bớt áp lực thuê nhà cho các sinh viên đại học trẻ mới tốt nghiệp, chính quyền thành phố đã đặc biệt xây dựng một đợt nhà ở xã hội bảo đảm cho nhân tài có giá thuê ưu đãi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了减轻年轻大学毕业生的租房压力，市政府专门兴建了一批租金优惠的人才保障性住房。', 'Wèile jiǎnqīng niánqīng dàxué bìyèshēng de zūfáng yālì, shì zhèngfǔ zhuānmén xīngjiàn le yì pī zūjīn yōuhuì de réncái bǎozhàngxìng zhùfáng.', 'Để giảm bớt áp lực thuê nhà cho các sinh viên đại học trẻ mới tốt nghiệp, chính quyền thành phố đã đặc biệt xây dựng một đợt nhà ở xã hội bảo đảm cho nhân tài có giá thuê ưu đãi.', 'basic', 1),
      (v_id, '健全租购并举的住房制度并加快构建房地产发展新模式，是有效化解高杠杆房企债务风险与实现住有所居的核心制度设计。', 'Jiànquán zū-gòu bìngjǔ de zhùfáng zhìdù bìng jiākuài gòujiàn fángdìchǎn fāzhǎn xīn móshì, shì yǒuxiào huàjiě gāo-gànggǎn fángqǐ zhàiwù fēngxiǎn yǔ shíxiàn zhùyǒusuǒjū de héxīn zhìdù shèjì.', 'Hoàn thiện chế độ nhà ở kết hợp đồng thời giữa thuê và mua cùng việc đẩy nhanh xây dựng mô hình phát triển bất động sản mới là thiết kế thể chế cốt lõi nhằm giải tỏa hiệu quả rủi ro nợ của doanh nghiệp bất động sản đòn bẩy cao và hiện thực hóa mục tiêu an cư lạc nghiệp cho người dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3551] [住宿] (zhùsù) - trọ lại, lưu trú, chỗ ở [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '住宿' AND pinyin = 'zhùsù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '住宿' AND pinyin = 'zhùsù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '住宿'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '住宿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhùsù',
      meaning_vi = 'trọ lại, lưu trú, chỗ ở',
      example_hanzi = '我们在出发去海滨风景区旅行之前，已经在网上提前预订好了三晚的酒店住宿。',
      example_pinyin = 'Wǒmen zài chūfā qù hǎibīn fēngjǐngqū lǚxíng zhīqián, yǐjīng zài wǎngshang tíqián yùdìng hǎo le sān wǎn de jiǔdiàn zhùsù.',
      example_vi = 'Trước khi xuất phát đi du lịch ở khu thắng cảnh ven biển, chúng tôi đã đặt trước ba đêm lưu trú tại khách sạn trên mạng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '住宿',
      'zhùsù',
      'trọ lại, lưu trú, chỗ ở',
      'Động từ / Danh từ',
      'HSK 5',
      '我们在出发去海滨风景区旅行之前，已经在网上提前预订好了三晚的酒店住宿。',
      'Wǒmen zài chūfā qù hǎibīn fēngjǐngqū lǚxíng zhīqián, yǐjīng zài wǎngshang tíqián yùdìng hǎo le sān wǎn de jiǔdiàn zhùsù.',
      'Trước khi xuất phát đi du lịch ở khu thắng cảnh ven biển, chúng tôi đã đặt trước ba đêm lưu trú tại khách sạn trên mạng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们在出发去海滨风景区旅行之前，已经在网上提前预订好了三晚的酒店住宿。', 'Wǒmen zài chūfā qù hǎibīn fēngjǐngqū lǚxíng zhīqián, yǐjīng zài wǎngshang tíqián yùdìng hǎo le sān wǎn de jiǔdiàn zhùsù.', 'Trước khi xuất phát đi du lịch ở khu thắng cảnh ven biển, chúng tôi đã đặt trước ba đêm lưu trú tại khách sạn trên mạng.', 'basic', 1),
      (v_id, '国际青年交流营地为来自全球数十个国家的留学生提供完备的餐饮、多功能学术研讨空间与高品质无障碍住宿设施。', 'Guójì qīngnián jiāoliú yíngdì wèi láizì quánqiú shùshí ge guójiā de liúxuéshēng tígōng wánbèi de cānyǐn, duō-gōngnéng xuéshù yántǎo kōngjiān yǔ gāopǐnzhì wú-zhàng''ài zhùsù shèshī.', 'Khu trại giao lưu thanh niên quốc tế cung cấp dịch vụ ăn uống hoàn bị, không gian hội thảo học thuật đa chức năng cùng các tiện nghi lưu trú không rào cản chất lượng cao cho lưu học sinh đến từ hàng chục quốc gia trên toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3552] [住址] (zhùzhǐ) - địa chỉ nhà, nơi cư trú [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '住址' AND pinyin = 'zhùzhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '住址' AND pinyin = 'zhùzhǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '住址'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '住址'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhùzhǐ',
      meaning_vi = 'địa chỉ nhà, nơi cư trú',
      example_hanzi = '在填写快递寄件单时，请务必核对好收件人的姓名、电话号码和详细住址。',
      example_pinyin = 'Zài tiánxiě kuàidì jìjiàndān shí, qǐng wùbì héduì hǎo shōujiànrén de xìngmíng, diànhuà hàomǎ hé xiángxì zhùzhǐ.',
      example_vi = 'Khi điền phiếu gửi bưu phẩm chuyển phát nhanh, xin bạn hãy đối chiếu kỹ họ tên, số điện thoại và địa chỉ nhà chi tiết của người nhận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '住址',
      'zhùzhǐ',
      'địa chỉ nhà, nơi cư trú',
      'Danh từ',
      'HSK 5',
      '在填写快递寄件单时，请务必核对好收件人的姓名、电话号码和详细住址。',
      'Zài tiánxiě kuàidì jìjiàndān shí, qǐng wùbì héduì hǎo shōujiànrén de xìngmíng, diànhuà hàomǎ hé xiángxì zhùzhǐ.',
      'Khi điền phiếu gửi bưu phẩm chuyển phát nhanh, xin bạn hãy đối chiếu kỹ họ tên, số điện thoại và địa chỉ nhà chi tiết của người nhận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在填写快递寄件单时，请务必核对好收件人的姓名、电话号码和详细住址。', 'Zài tiánxiě kuàidì jìjiàndān shí, qǐng wùbì héduì hǎo shōujiànrén de xìngmíng, diànhuà hàomǎ hé xiángxì zhùzhǐ.', 'Khi điền phiếu gửi bưu phẩm chuyển phát nhanh, xin bạn hãy đối chiếu kỹ họ tên, số điện thoại và địa chỉ nhà chi tiết của người nhận.', 'basic', 1),
      (v_id, '不动产登记中心严格规范权利人住址与身份证件信息的动态关联变更流程，确保产权法律证书与实体现状完全吻合。', 'Búdòngchǎn dēngjì zhōngxīn yángé guīfàn quánlìrén zhùzhǐ yǔ shēnfèn zhèngjiàn xìnxī de dòngtài guānlián biàngēng liúchéng, quèbǎo chǎnquán fǎlǜ zhèngshū yǔ shítǐ xiànzhuàng wánquán wěnhé.', 'Trung tâm đăng ký bất động sản quy chuẩn nghiêm ngặt quy trình liên kết thay đổi động giữa thông tin giấy tờ tùy thân và địa chỉ cư trú của người có quyền sở hữu, bảo đảm văn bằng pháp lý chủ quyền ăn khớp hoàn toàn với hiện trạng thực thể.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3553] [注重] (zhùzhòng) - chú trọng, coi trọng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '注重' AND pinyin = 'zhùzhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '注重' AND pinyin = 'zhùzhòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '注重'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '注重'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhùzhòng',
      meaning_vi = 'chú trọng, coi trọng',
      example_hanzi = '现代人越来越注重日常饮食的营养均衡，不仅要吃饱而且要吃得健康。',
      example_pinyin = 'Xiàndàirén yuèláiyuè zhùzhòng rìcháng yǐnshí de yíngyǎng jūnhéng, bù jǐn yào chībǎo érqiě yào chī de jiànkāng.',
      example_vi = 'Con người hiện đại ngày càng coi trọng sự cân bằng dinh dưỡng trong bữa ăn hằng ngày, không những phải ăn no mà còn phải ăn sao cho có lợi cho sức khỏe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '注重',
      'zhùzhòng',
      'chú trọng, coi trọng',
      'Động từ',
      'HSK 5',
      '现代人越来越注重日常饮食的营养均衡，不仅要吃饱而且要吃得健康。',
      'Xiàndàirén yuèláiyuè zhùzhòng rìcháng yǐnshí de yíngyǎng jūnhéng, bù jǐn yào chībǎo érqiě yào chī de jiànkāng.',
      'Con người hiện đại ngày càng coi trọng sự cân bằng dinh dưỡng trong bữa ăn hằng ngày, không những phải ăn no mà còn phải ăn sao cho có lợi cho sức khỏe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现代人越来越注重日常饮食的营养均衡，不仅要吃饱而且要吃得健康。', 'Xiàndàirén yuèláiyuè zhùzhòng rìcháng yǐnshí de yíngyǎng jūnhéng, bù jǐn yào chībǎo érqiě yào chī de jiànkāng.', 'Con người hiện đại ngày càng coi trọng sự cân bằng dinh dưỡng trong bữa ăn hằng ngày, không những phải ăn no mà còn phải ăn sao cho có lợi cho sức khỏe.', 'basic', 1),
      (v_id, '企业高质量可持续发展战略注重平衡当期商业利润回报与中长期环境、社会及治理核心指标的稳步提升。', 'Qǐyè gāozhìliàng kěchíxù fāzhǎn zhànlüè zhùzhòng pínghéng dāngqī shāngyè lìrùn huíbào yǔ zhōng-chángqī huánjìng, shèhuì jí zhìlǐ héxīn zhǐbiāo de wěnbù tíshēng.', 'Chiến lược phát triển bền vững chất lượng cao của doanh nghiệp chú trọng cân bằng giữa lợi nhuận kinh doanh hoàn vốn kỳ hiện tại với việc nâng cao vững chắc các chỉ số cốt lõi về môi trường, xã hội và quản trị trong trung và dài hạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3554] [抓] (zhuā) - bắt, chộp, tóm, túm lấy; nắm bắt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '抓' AND pinyin = 'zhuā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抓' AND pinyin = 'zhuā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '抓'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抓'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhuā',
      meaning_vi = 'bắt, chộp, tóm, túm lấy; nắm bắt',
      example_hanzi = '小猫警觉地蹲在墙角草丛中，猛地往前一扑，敏捷地抓住了那只乱窜的小老鼠。',
      example_pinyin = 'Xiǎomāo jǐngjué de dūn zài qiángjiǎo cǎocóng zhōng, měngde wǎng qián yì pū, mǐnjié de zhuā zhù le nà zhī luàncuàn de xiǎolǎoshǔ.',
      example_vi = 'Chú mèo con cảnh giác nép mình trong bụi cỏ góc tường, đột ngột vồ mạnh về phía trước, nhanh nhẹn tóm gọn chú chuột nhắt đang chạy loạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '抓',
      'zhuā',
      'bắt, chộp, tóm, túm lấy; nắm bắt',
      'Động từ',
      'HSK 5',
      '小猫警觉地蹲在墙角草丛中，猛地往前一扑，敏捷地抓住了那只乱窜的小老鼠。',
      'Xiǎomāo jǐngjué de dūn zài qiángjiǎo cǎocóng zhōng, měngde wǎng qián yì pū, mǐnjié de zhuā zhù le nà zhī luàncuàn de xiǎolǎoshǔ.',
      'Chú mèo con cảnh giác nép mình trong bụi cỏ góc tường, đột ngột vồ mạnh về phía trước, nhanh nhẹn tóm gọn chú chuột nhắt đang chạy loạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小猫警觉地蹲在墙角草丛中，猛地往前一扑，敏捷地抓住了那只乱窜的小老鼠。', 'Xiǎomāo jǐngjué de dūn zài qiángjiǎo cǎocóng zhōng, měngde wǎng qián yì pū, mǐnjié de zhuā zhù le nà zhī luàncuàn de xiǎolǎoshǔ.', 'Chú mèo con cảnh giác nép mình trong bụi cỏ góc tường, đột ngột vồ mạnh về phía trước, nhanh nhẹn tóm gọn chú chuột nhắt đang chạy loạn.', 'basic', 1),
      (v_id, '各级政府职能部门牢牢抓紧抓实重大工程建设项目施工安全生产责任制，坚决防范遏制重特大安全事故发生。', 'Gè jí zhèngfǔ zhínéng bùmén láoláo zhuājǐn zhuāshí zhòngdà gōngchéng jiànshè xiàngmù shīgōng ānquán shēngchǎn zérènzhì, jiānjué fángfàn èzhì zhòng-tèdà ānquán shìgù fāshēng.', 'Các cơ quan chức năng chính quyền các cấp nắm chắc siết chặt chế độ trách nhiệm sản xuất an toàn thi công các dự án xây dựng công trình trọng đại, kiên quyết phòng ngừa ngăn chặn các sự cố an toàn đặc biệt nghiêm trọng xảy ra.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3555] [抓紧] (zhuājǐn) - tranh thủ, nắm chắc, khẩn trương [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '抓紧' AND pinyin = 'zhuājǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抓紧' AND pinyin = 'zhuājǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '抓紧'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '抓紧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhuājǐn',
      meaning_vi = 'tranh thủ, nắm chắc, khẩn trương',
      example_hanzi = '距离期末考试只剩下最后两周时间了，大家都在抓紧每分每秒查漏补缺。',
      example_pinyin = 'Jùlí qīmò kǎoshì zhǐ shèng xià zuìhòu liǎng zhōu shíjiān le, dàjiā dōu zài zhuājǐn měi fēn měi miǎo chá-lòu-bǔ-quē.',
      example_vi = 'Cách kỳ thi cuối kỳ chỉ còn lại đúng hai tuần cuối cùng, mọi người đều đang tranh thủ từng phút từng giây để bù đắp các lỗ hổng kiến thức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '抓紧',
      'zhuājǐn',
      'tranh thủ, nắm chắc, khẩn trương',
      'Động từ',
      'HSK 5',
      '距离期末考试只剩下最后两周时间了，大家都在抓紧每分每秒查漏补缺。',
      'Jùlí qīmò kǎoshì zhǐ shèng xià zuìhòu liǎng zhōu shíjiān le, dàjiā dōu zài zhuājǐn měi fēn měi miǎo chá-lòu-bǔ-quē.',
      'Cách kỳ thi cuối kỳ chỉ còn lại đúng hai tuần cuối cùng, mọi người đều đang tranh thủ từng phút từng giây để bù đắp các lỗ hổng kiến thức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '距离期末考试只剩下最后两周时间了，大家都在抓紧每分每秒查漏补缺。', 'Jùlí qīmò kǎoshì zhǐ shèng xià zuìhòu liǎng zhōu shíjiān le, dàjiā dōu zài zhuājǐn měi fēn měi miǎo chá-lòu-bǔ-quē.', 'Cách kỳ thi cuối kỳ chỉ còn lại đúng hai tuần cuối cùng, mọi người đều đang tranh thủ từng phút từng giây để bù đắp các lỗ hổng kiến thức.', 'basic', 1),
      (v_id, '科研攻坚团队正抓紧推进第六代移动通信关键核心射频芯片在超低温极端环境下的可靠性封装测试。', 'Kēyán gōngjiān tuánduì zhèng zhuājǐn tuījìn dì-liù dài yídòng tōngxìn guānjiàn héxīn shèpín xīnpiàn zài chāo-dīwēn jíduān huánjìng xià de kěkàoxìng fēngzhuāng cèshì.', 'Đội ngũ nghiên cứu khoa học đột phá đang khẩn trương đẩy mạnh thử nghiệm đóng gói độ tin cậy của chip vô tuyến then chốt cốt lõi viễn thông di động thế hệ thứ sáu dưới môi trường cực hạn siêu nhiệt độ thấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3556] [专家] (zhuānjiā) - chuyên gia [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '专家' AND pinyin = 'zhuānjiā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '专家' AND pinyin = 'zhuānjiā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '专家'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '专家'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhuānjiā',
      meaning_vi = 'chuyên gia',
      example_hanzi = '为了确保大型跨海大桥的施工质量，工程指挥部专门邀请了数位知名桥梁工程专家亲临现场指导。',
      example_pinyin = 'Wèile quèbǎo dàxíng kuàhǎi dàqiáo de shīgōng zhìliàng, gōngchéng zhǐhuībù zhuānmén yāoqǐng le shù wèi zhīmíng qiáoliáng gōngchéng zhuānjiā qīnlín xiànchǎng zhǐdǎo.',
      example_vi = 'Để bảo đảm chất lượng thi công cầu lớn vượt biển quy mô lớn, ban chỉ huy công trình đã đặc biệt mời mấy vị chuyên gia kỹ thuật cầu đường nổi tiếng đích thân tới hiện trường chỉ đạo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '专家',
      'zhuānjiā',
      'chuyên gia',
      'Danh từ',
      'HSK 5',
      '为了确保大型跨海大桥的施工质量，工程指挥部专门邀请了数位知名桥梁工程专家亲临现场指导。',
      'Wèile quèbǎo dàxíng kuàhǎi dàqiáo de shīgōng zhìliàng, gōngchéng zhǐhuībù zhuānmén yāoqǐng le shù wèi zhīmíng qiáoliáng gōngchéng zhuānjiā qīnlín xiànchǎng zhǐdǎo.',
      'Để bảo đảm chất lượng thi công cầu lớn vượt biển quy mô lớn, ban chỉ huy công trình đã đặc biệt mời mấy vị chuyên gia kỹ thuật cầu đường nổi tiếng đích thân tới hiện trường chỉ đạo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了确保大型跨海大桥的施工质量，工程指挥部专门邀请了数位知名桥梁工程专家亲临现场指导。', 'Wèile quèbǎo dàxíng kuàhǎi dàqiáo de shīgōng zhìliàng, gōngchéng zhǐhuībù zhuānmén yāoqǐng le shù wèi zhīmíng qiáoliáng gōngchéng zhuānjiā qīnlín xiànchǎng zhǐdǎo.', 'Để bảo đảm chất lượng thi công cầu lớn vượt biển quy mô lớn, ban chỉ huy công trình đã đặc biệt mời mấy vị chuyên gia kỹ thuật cầu đường nổi tiếng đích thân tới hiện trường chỉ đạo.', 'basic', 1),
      (v_id, '多边国际气候谈判代表团设立了由顶级生态学与气象学专家组成的独立咨询委员会，为温室气体减排履约提供客观科学基准。', 'Duōbiān guójì qìhòu tánpàn dàibiǎotuán shèlì le yóu dǐngjí shēngtàixué yǔ qìxiàngxué zhuānjiā zǔchéng de dúlì zīxún wěiyuánhuì, wèi wēnshì qìtǐ jiǎnpái lǚyuē tígōng kèguān kēxué jīzhǔn.', 'Đoàn đại biểu đàm phán khí hậu quốc tế đa phương đã thành lập ủy ban tư vấn độc lập gồm các chuyên gia hàng đầu về sinh thái học và khí tượng học, cung cấp chuẩn mực khoa học khách quan cho việc thực thi cam kết cắt giảm khí nhà kính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3557] [专心] (zhuānxīn) - chuyên tâm, tập trung, chú tâm [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '专心' AND pinyin = 'zhuānxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '专心' AND pinyin = 'zhuānxīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '专心'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '专心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zhuānxīn',
      meaning_vi = 'chuyên tâm, tập trung, chú tâm',
      example_hanzi = '只要你在课堂上专心听讲并认真做好笔记，课后复习起来就会感觉轻松许多。',
      example_pinyin = 'Zhǐyào nǐ zài kètáng shang zhuānxīn tīngjiǎng bìng rènzhēn zuò hǎo bǐjì, kèhòu fùxí qǐlái jiù huì gǎnjué qīngsōng xǔduō.',
      example_vi = 'Chỉ cần bạn chuyên tâm nghe giảng trong lớp và cẩn thận ghi chép bài đầy đủ, khi ôn tập sau giờ học sẽ cảm thấy nhẹ nhàng hơn rất nhiều.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '专心',
      'zhuānxīn',
      'chuyên tâm, tập trung, chú tâm',
      'Tính từ',
      'HSK 5',
      '只要你在课堂上专心听讲并认真做好笔记，课后复习起来就会感觉轻松许多。',
      'Zhǐyào nǐ zài kètáng shang zhuānxīn tīngjiǎng bìng rènzhēn zuò hǎo bǐjì, kèhòu fùxí qǐlái jiù huì gǎnjué qīngsōng xǔduō.',
      'Chỉ cần bạn chuyên tâm nghe giảng trong lớp và cẩn thận ghi chép bài đầy đủ, khi ôn tập sau giờ học sẽ cảm thấy nhẹ nhàng hơn rất nhiều.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只要你在课堂上专心听讲并认真做好笔记，课后复习起来就会感觉轻松许多。', 'Zhǐyào nǐ zài kètáng shang zhuānxīn tīngjiǎng bìng rènzhēn zuò hǎo bǐjì, kèhòu fùxí qǐlái jiù huì gǎnjué qīngsōng xǔduō.', 'Chỉ cần bạn chuyên tâm nghe giảng trong lớp và cẩn thận ghi chép bài đầy đủ, khi ôn tập sau giờ học sẽ cảm thấy nhẹ nhàng hơn rất nhiều.', 'basic', 1),
      (v_id, '顶尖基础科学研究需要科研工作者克服外界浮躁诱惑，专心致志地扎根冷门基础理论攻关长达数十载。', 'Dǐngjiān jīchǔ kēxué yánjiū xūyào kēyán gōngzuòzhě kèfú wàijiè fúzào yòuhuò, zhuānxīn-zhìzhì de zhāgēn lěngmén jīchǔ lǐlùn gōngguān chángdá shùshí zǎi.', 'Nghiên cứu khoa học cơ bản đỉnh cao đòi hỏi các cán bộ nghiên cứu phải khắc phục những cám dỗ phù phiếm từ bên ngoài, chuyên tâm dốc chí cắm rễ vào các đột phá lý thuyết cơ bản ít người theo đuổi ròng rã suốt hàng chục năm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3558] [转变] (zhuǎnbiàn) - chuyển biến, biến đổi, chuyển hướng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '转变' AND pinyin = 'zhuǎnbiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '转变' AND pinyin = 'zhuǎnbiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '转变'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '转变'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhuǎnbiàn',
      meaning_vi = 'chuyển biến, biến đổi, chuyển hướng',
      example_hanzi = '通过与老师的一番促膝长谈，他的思想观念发生了积极的转变，开始主动努力学习。',
      example_pinyin = 'Tōngguò yǔ lǎoshī de yì fān cùxī-chángtán, tā de sīxiǎng guānniàn fāshēng le jījí de zhuǎnbiàn, kāishǐ zhǔdòng nǔlì xuéxí.',
      example_vi = 'Thông qua một hồi tâm sự cởi mở với thầy giáo, quan niệm tư tưởng của anh ấy đã phát sinh chuyển biến tích cực, bắt đầu chủ động nỗ lực học tập.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '转变',
      'zhuǎnbiàn',
      'chuyển biến, biến đổi, chuyển hướng',
      'Động từ / Danh từ',
      'HSK 5',
      '通过与老师的一番促膝长谈，他的思想观念发生了积极的转变，开始主动努力学习。',
      'Tōngguò yǔ lǎoshī de yì fān cùxī-chángtán, tā de sīxiǎng guānniàn fāshēng le jījí de zhuǎnbiàn, kāishǐ zhǔdòng nǔlì xuéxí.',
      'Thông qua một hồi tâm sự cởi mở với thầy giáo, quan niệm tư tưởng của anh ấy đã phát sinh chuyển biến tích cực, bắt đầu chủ động nỗ lực học tập.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '通过与老师的一番促膝长谈，他的思想观念发生了积极的转变，开始主动努力学习。', 'Tōngguò yǔ lǎoshī de yì fān cùxī-chángtán, tā de sīxiǎng guānniàn fāshēng le jījí de zhuǎnbiàn, kāishǐ zhǔdòng nǔlì xuéxí.', 'Thông qua một hồi tâm sự cởi mở với thầy giáo, quan niệm tư tưởng của anh ấy đã phát sinh chuyển biến tích cực, bắt đầu chủ động nỗ lực học tập.', 'basic', 1),
      (v_id, '推动经济发展方式由传统的要素驱动粗放扩张向全要素生产率驱动的高质量创新发展方式转变，是构建新发展格局的核心支撑。', 'Tuīdòng jīngjì fāzhǎn fāngshì yóu chuántǒng de yàosù qūdòng cūfàng kuòzhāng xiàng quán-yàosù shēngchǎnlǜ qūdòng de gāozhìliàng chuàngxīn fāzhǎn fāngshì zhuǎnbiàn, shì gòujiàn xīn fāzhǎn géjú de héxīn zhīchēng.', 'Thúc đẩy phương thức phát triển kinh tế chuyển biến từ việc mở rộng tràn lan bằng dẫn dắt các yếu tố truyền thống sang phương thức phát triển đổi mới sáng tạo chất lượng cao do năng suất tổng nhân tố dẫn dắt là trụ cột cốt lõi để xây dựng cục diện phát triển mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3559] [转告] (zhuǎngào) - chuyển lời, nhắn lại, nói lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '转告' AND pinyin = 'zhuǎngào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '转告' AND pinyin = 'zhuǎngào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '转告'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '转告'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhuǎngào',
      meaning_vi = 'chuyển lời, nhắn lại, nói lại',
      example_hanzi = '如果明天早晨王经理先到办公室，麻烦您转告他项目合同原件已经放在他的办公桌上了。',
      example_pinyin = 'Rúguǒ míngtiān zǎochén Wáng jīnglǐ xiān dào bàngōngshì, máfan nín zhuǎngào tā xiàngmù hétong yuánjiàn yǐjīng fàng zài tā de bàngōngzhuō shang le.',
      example_vi = 'Nếu sáng mai giám đốc Vương đến văn phòng trước, làm phiền bạn chuyển lời nhắn với ông ấy rằng bản gốc hợp đồng dự án đã được để sẵn trên bàn làm việc của ông rồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '转告',
      'zhuǎngào',
      'chuyển lời, nhắn lại, nói lại',
      'Động từ',
      'HSK 5',
      '如果明天早晨王经理先到办公室，麻烦您转告他项目合同原件已经放在他的办公桌上了。',
      'Rúguǒ míngtiān zǎochén Wáng jīnglǐ xiān dào bàngōngshì, máfan nín zhuǎngào tā xiàngmù hétong yuánjiàn yǐjīng fàng zài tā de bàngōngzhuō shang le.',
      'Nếu sáng mai giám đốc Vương đến văn phòng trước, làm phiền bạn chuyển lời nhắn với ông ấy rằng bản gốc hợp đồng dự án đã được để sẵn trên bàn làm việc của ông rồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果明天早晨王经理先到办公室，麻烦您转告他项目合同原件已经放在他的办公桌上了。', 'Rúguǒ míngtiān zǎochén Wáng jīnglǐ xiān dào bàngōngshì, máfan nín zhuǎngào tā xiàngmù hétong yuánjiàn yǐjīng fàng zài tā de bàngōngzhuō shang le.', 'Nếu sáng mai giám đốc Vương đến văn phòng trước, làm phiền bạn chuyển lời nhắn với ông ấy rằng bản gốc hợp đồng dự án đã được để sẵn trên bàn làm việc của ông rồi.', 'basic', 1),
      (v_id, '特使在结束闭门斡旋会晤后，郑重请东道国外长向国家元首转告关于立即停火并开启无条件多边人道主义走廊谈判的正式倡议。', 'Tèshǐ zài jiéshù bìmén wòxuán huìwù hòu, zhèngzhòng qǐng dōngdàoguó wàizhǎng xiàng guójiā yuánshǒu zhuǎngào guānyú lìjí tínghuǒ bìng kāiqǐ wú-tiáojiàn duōbiān réndàozhǔyì zǒuláng tánpàn de zhèngshì chàngyì.', 'Đặc phái viên sau khi kết thúc cuộc hội đàm hòa giải kín đã trịnh trọng nhờ Ngoại trưởng nước chủ nhà chuyển lời tới Nguyên thủ quốc gia về sáng kiến chính thức ngừng bắn ngay lập tức và mở đàm phán hành lang nhân đạo đa phương không kèm điều kiện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3560] [装饰] (zhuāngshì) - trang trí, đồ trang trí [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '装饰' AND pinyin = 'zhuāngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '装饰' AND pinyin = 'zhuāngshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '装饰'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '装饰'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhuāngshì',
      meaning_vi = 'trang trí, đồ trang trí',
      example_hanzi = '新春佳节来临之前，各家各户都在门窗上贴满了漂亮的红色窗花与福字来进行节日装饰。',
      example_pinyin = 'Xīnchūn jiājié láilín zhīqián, gèjiā-gèhù dōu zài ménchuāng shang tiē mǎn le piàoliang de hóngsè chuānghuā yǔ fúzì lái jìnxíng jiérì zhuāngshì.',
      example_vi = 'Trước khi dịp Tết cổ truyền đến, nhà nhà đều dán kín những bông hoa giấy đỏ cắt hoa văn tinh xảo và chữ Phúc lên cửa ra vào và cửa sổ để trang trí ngày lễ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '装饰',
      'zhuāngshì',
      'trang trí, đồ trang trí',
      'Động từ / Danh từ',
      'HSK 5',
      '新春佳节来临之前，各家各户都在门窗上贴满了漂亮的红色窗花与福字来进行节日装饰。',
      'Xīnchūn jiājié láilín zhīqián, gèjiā-gèhù dōu zài ménchuāng shang tiē mǎn le piàoliang de hóngsè chuānghuā yǔ fúzì lái jìnxíng jiérì zhuāngshì.',
      'Trước khi dịp Tết cổ truyền đến, nhà nhà đều dán kín những bông hoa giấy đỏ cắt hoa văn tinh xảo và chữ Phúc lên cửa ra vào và cửa sổ để trang trí ngày lễ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新春佳节来临之前，各家各户都在门窗上贴满了漂亮的红色窗花与福字来进行节日装饰。', 'Xīnchūn jiājié láilín zhīqián, gèjiā-gèhù dōu zài ménchuāng shang tiē mǎn le piàoliang de hóngsè chuānghuā yǔ fúzì lái jìnxíng jiérì zhuāngshì.', 'Trước khi dịp Tết cổ truyền đến, nhà nhà đều dán kín những bông hoa giấy đỏ cắt hoa văn tinh xảo và chữ Phúc lên cửa ra vào và cửa sổ để trang trí ngày lễ.', 'basic', 1),
      (v_id, '国家大剧院主音乐厅内壁采用非对称微穿孔声学反射装饰面板，完美兼顾了古典建筑美学视觉享受与极佳的声场扩散效果。', 'Guójiā Dà Jùyuàn zhǔ yīnyuètīng nèibì cǎiyòng fēi-duìchèn wēi-chuānkǒng shēngxué fǎnshè zhuāngshì miànbǎn, wánměi jiāngù le gǔdiǎn jiànzhù měixué shìjué xiǎngshòu yǔ jí jiā de shēngchǎng kuòsàn xiàoguǒ.', 'Vách trong khán phòng âm nhạc chính của Nhà hát Lớn Quốc gia sử dụng tấm ốp trang trí phản xạ âm thanh đục vi lỗ bất đối xứng, kết hợp hoàn hảo giữa thưởng thức thị giác thẩm mỹ kiến trúc cổ điển với hiệu ứng khuếch tán trường âm cực kỳ xuất sắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3561] [装修] (zhuāngxiū) - trang hoàng, sửa sang nội thất, decor [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '装修' AND pinyin = 'zhuāngxiū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '装修' AND pinyin = 'zhuāngxiū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '装修'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '装修'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhuāngxiū',
      meaning_vi = 'trang hoàng, sửa sang nội thất, decor',
      example_hanzi = '他们刚刚购买了一套二手公寓，正忙着挑选环保建材和家具准备在下个月开始装修。',
      example_pinyin = 'Tāmen gānggāng gòumǎi le yí tào èrshǒu gōngyù, zhèng máng zhe tiāoxuǎn huánbǎo jiàncái hé jiājù zhǔnbèi zài xià ge yuè kāishǐ zhuāngxiū.',
      example_vi = 'Họ vừa mới mua một căn hộ chung cư thứ cấp, đang tất bật lựa chọn vật liệu xây dựng thân thiện môi trường và đồ nội thất chuẩn bị khởi công sang sửa nội thất vào tháng tới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '装修',
      'zhuāngxiū',
      'trang hoàng, sửa sang nội thất, decor',
      'Động từ / Danh từ',
      'HSK 5',
      '他们刚刚购买了一套二手公寓，正忙着挑选环保建材和家具准备在下个月开始装修。',
      'Tāmen gānggāng gòumǎi le yí tào èrshǒu gōngyù, zhèng máng zhe tiāoxuǎn huánbǎo jiàncái hé jiājù zhǔnbèi zài xià ge yuè kāishǐ zhuāngxiū.',
      'Họ vừa mới mua một căn hộ chung cư thứ cấp, đang tất bật lựa chọn vật liệu xây dựng thân thiện môi trường và đồ nội thất chuẩn bị khởi công sang sửa nội thất vào tháng tới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他们刚刚购买了一套二手公寓，正忙着挑选环保建材和家具准备在下个月开始装修。', 'Tāmen gānggāng gòumǎi le yí tào èrshǒu gōngyù, zhèng máng zhe tiāoxuǎn huánbǎo jiàncái hé jiājù zhǔnbèi zài xià ge yuè kāishǐ zhuāngxiū.', 'Họ vừa mới mua một căn hộ chung cư thứ cấp, đang tất bật lựa chọn vật liệu xây dựng thân thiện môi trường và đồ nội thất chuẩn bị khởi công sang sửa nội thất vào tháng tới.', 'basic', 1),
      (v_id, '绿色建筑装饰工程行业标准强制要求室内装修所使用的黏合剂与涂料释放物全面达到超低甲醛与挥发性有机化合物限值。', 'Lǜsè jiànzhù zhuāngshì gōngchéng hángyè biāozhǔn qiángzhì yāoqiú shìnèi zhuāngxiū suǒ shǐyòng de niánhéjì yǔ túliào shìfàngwù quánmiàn dádào chāo-dī jiǎquán yǔ huīfāxìng yǒujī huàhéwù xiànzhí.', 'Tiêu chuẩn ngành công trình trang trí kiến trúc xanh bắt buộc yêu cầu chất kết dính và sơn phủ sử dụng trong sửa sang nội thất phải đạt chuẩn ranh giới phát thải formaldehyde siêu thấp và các hợp chất hữu cơ dễ bay hơi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3562] [撞] (zhuàng) - va chạm, đâm, va phải [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '撞' AND pinyin = 'zhuàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '撞' AND pinyin = 'zhuàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '撞'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '撞'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhuàng',
      meaning_vi = 'va chạm, đâm, va phải',
      example_hanzi = '他在走廊拐角处只顾着低头看手机，不小心一下子撞在了迎面走来的同事身上。',
      example_pinyin = 'Tā zài zǒuláng guǎijiǎochù zhǐ gù zhe dītóu kàn shǒujī, bù xiǎoxīn yíxiàzi zhuàng zài le yíngmiàn zǒu lái de tóngshì shēnshang.',
      example_vi = 'Ở khúc ngoặt hành lang anh ấy chỉ mải cúi đầu nhìn điện thoại, vô ý một cái đâm sầm vào người người đồng nghiệp đang đi đón đầu tới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '撞',
      'zhuàng',
      'va chạm, đâm, va phải',
      'Động từ',
      'HSK 5',
      '他在走廊拐角处只顾着低头看手机，不小心一下子撞在了迎面走来的同事身上。',
      'Tā zài zǒuláng guǎijiǎochù zhǐ gù zhe dītóu kàn shǒujī, bù xiǎoxīn yíxiàzi zhuàng zài le yíngmiàn zǒu lái de tóngshì shēnshang.',
      'Ở khúc ngoặt hành lang anh ấy chỉ mải cúi đầu nhìn điện thoại, vô ý một cái đâm sầm vào người người đồng nghiệp đang đi đón đầu tới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在走廊拐角处只顾着低头看手机，不小心一下子撞在了迎面走来的同事身上。', 'Tā zài zǒuláng guǎijiǎochù zhǐ gù zhe dītóu kàn shǒujī, bù xiǎoxīn yíxiàzi zhuàng zài le yíngmiàn zǒu lái de tóngshì shēnshang.', 'Ở khúc ngoặt hành lang anh ấy chỉ mải cúi đầu nhìn điện thoại, vô ý một cái đâm sầm vào người người đồng nghiệp đang đi đón đầu tới.', 'basic', 1),
      (v_id, '汽车主动安全防碰撞预警系统基于毫米波雷达与前视双目摄像头的多模态感知算法，在毫秒级内自动触发全速域紧急制动以规避车辆追尾。', 'Qìchē zhǔdòng ānquán fáng-pèngzhuàng yùjǐng xìtǒng jīyú háomǐbō léidá yǔ qiánshì shuāngmù shèxiàngtóu de duō-mótài gǎnzhī suànfǎ, zài háomiǎojí nèi zìdòng chùfā quán-sùyù jǐnjí zhìdòng yǐ guībì chēliàng zhuīwěi.', 'Hệ thống cảnh báo an toàn chủ động phòng va chạm của ô tô dựa trên thuật toán nhận thức đa phương thức của radar sóng milimet và camera kép nhìn trước, trong cấp mili giây tự động kích hoạt phanh khẩn cấp trên toàn dải tốc độ nhằm né tránh va quẹt đâm đuôi xe.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3563] [状况] (zhuàngkuàng) - tình trạng, tình hình (kinh tế, sức khỏe, giao thông) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '状况' AND pinyin = 'zhuàngkuàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '状况' AND pinyin = 'zhuàngkuàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '状况'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '状况'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhuàngkuàng',
      meaning_vi = 'tình trạng, tình hình (kinh tế, sức khỏe, giao thông)',
      example_hanzi = '爷爷在做完心脏搭桥手术之后一直坚持每天散步，目前身体恢复状况非常良好。',
      example_pinyin = 'Yéye zài zuò wán xīnzàng dāqiáo shǒushù zhīhòu yìzhí jiānchí měitiān sànbù, mùqián shēntǐ huīfù zhuàngkuàng fēicháng liánghǎo.',
      example_vi = 'Ông nội sau khi làm xong phẫu thuật bắc cầu mạch vành luôn kiên trì đi bộ hằng ngày, hiện tại tình trạng hồi phục thể trạng của ông rất tốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '状况',
      'zhuàngkuàng',
      'tình trạng, tình hình (kinh tế, sức khỏe, giao thông)',
      'Danh từ',
      'HSK 5',
      '爷爷在做完心脏搭桥手术之后一直坚持每天散步，目前身体恢复状况非常良好。',
      'Yéye zài zuò wán xīnzàng dāqiáo shǒushù zhīhòu yìzhí jiānchí měitiān sànbù, mùqián shēntǐ huīfù zhuàngkuàng fēicháng liánghǎo.',
      'Ông nội sau khi làm xong phẫu thuật bắc cầu mạch vành luôn kiên trì đi bộ hằng ngày, hiện tại tình trạng hồi phục thể trạng của ông rất tốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '爷爷在做完心脏搭桥手术之后一直坚持每天散步，目前身体恢复状况非常良好。', 'Yéye zài zuò wán xīnzàng dāqiáo shǒushù zhīhòu yìzhí jiānchí měitiān sànbù, mùqián shēntǐ huīfù zhuàngkuàng fēicháng liánghǎo.', 'Ông nội sau khi làm xong phẫu thuật bắc cầu mạch vành luôn kiên trì đi bộ hằng ngày, hiện tại tình trạng hồi phục thể trạng của ông rất tốt.', 'basic', 1),
      (v_id, '中央银行发布的区域金融运行监测报告指出，中小法人金融机构资本充足率与流动性监管指标整体处于稳健安全状况。', 'Zhōngyāng yínháng fābù de qūyù jīnróng yùnxíng jiāncè bàogào zhǐchū, zhōng-xiǎo fǎrén jīnróng jīgòu zīběn chōngzúlǜ yǔ liúdòngxìng jiānguǎn zhǐbiāo zhěngtǐ chǔyú wěnjiàn ānquán zhuàngkuàng.', 'Báo cáo giám sát vận hành tài chính khu vực do ngân hàng trung ương công bố chỉ rõ rằng tỷ lệ an toàn vốn và các chỉ tiêu giám sát thanh khoản của các tổ chức tài chính pháp nhân vừa và nhỏ nhìn chung đang ở trong tình trạng an toàn và vững chắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3564] [状态] (zhuàngtài) - trạng thái [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '状态' AND pinyin = 'zhuàngtài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '状态' AND pinyin = 'zhuàngtài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '状态'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '状态'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zhuàngtài',
      meaning_vi = 'trạng thái',
      example_hanzi = '运动员在赛前一定要调整好自己的作息与心理，努力让自己在比赛当天处于最佳竞技状态。',
      example_pinyin = 'Yùndòngyuán zài sàiqián yídìng yào tiáozhěng hǎo zìjǐ de zuòxī yǔ xīnlǐ, nǔlì ràng zìjǐ zài bǐsài dāngtiān chǔyú zuìjiā jìngjì zhuàngtài.',
      example_vi = 'Vận động viên trước khi thi đấu nhất định phải điều chỉnh tốt chế độ nghỉ ngơi sinh hoạt và tâm lý của bản thân, nỗ lực giúp mình đạt trạng thái thi đấu đỉnh cao trong ngày tranh tài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '状态',
      'zhuàngtài',
      'trạng thái',
      'Danh từ',
      'HSK 5',
      '运动员在赛前一定要调整好自己的作息与心理，努力让自己在比赛当天处于最佳竞技状态。',
      'Yùndòngyuán zài sàiqián yídìng yào tiáozhěng hǎo zìjǐ de zuòxī yǔ xīnlǐ, nǔlì ràng zìjǐ zài bǐsài dāngtiān chǔyú zuìjiā jìngjì zhuàngtài.',
      'Vận động viên trước khi thi đấu nhất định phải điều chỉnh tốt chế độ nghỉ ngơi sinh hoạt và tâm lý của bản thân, nỗ lực giúp mình đạt trạng thái thi đấu đỉnh cao trong ngày tranh tài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '运动员在赛前一定要调整好自己的作息与心理，努力让自己在比赛当天处于最佳竞技状态。', 'Yùndòngyuán zài sàiqián yídìng yào tiáozhěng hǎo zìjǐ de zuòxī yǔ xīnlǐ, nǔlì ràng zìjǐ zài bǐsài dāngtiān chǔyú zuìjiā jìngjì zhuàngtài.', 'Vận động viên trước khi thi đấu nhất định phải điều chỉnh tốt chế độ nghỉ ngơi sinh hoạt và tâm lý của bản thân, nỗ lực giúp mình đạt trạng thái thi đấu đỉnh cao trong ngày tranh tài.', 'basic', 1),
      (v_id, '量子计算机利用超导量子比特的叠加态与纠缠态等量子力学奇异状态，在特定复杂组合优化问题求解上展现出经典算力无法比拟的计算效率。', 'Liàngzǐ jìsuànjī lìyòng chāodǎo liàngzǐ bǐtè de diéjiātài yǔ jiūchántài děng liàngzǐ lìxué qíyì zhuàngtài, zài tèdìng fùzá zǔhé yōuhuà wèntí qiújiě shang zhǎnxiàn chū jīngdiǎn suànlì wúfǎ bǐnǐ de jìsuàn xiàolǜ.', 'Máy tính lượng tử tận dụng các trạng thái kỳ dị của cơ học lượng tử như trạng thái chồng chất và trạng thái vướng víu của qubit siêu dẫn, đã thể hiện hiệu suất tính toán mà sức mạnh tính toán cổ điển không thể sánh kịp trong giải các bài toán tối ưu hóa tổ hợp phức tạp đặc thù.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3565] [追] (zhuī) - đuổi theo, đuổi bắt, truy đuổi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '追' AND pinyin = 'zhuī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '追' AND pinyin = 'zhuī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '追'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '追'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhuī',
      meaning_vi = 'đuổi theo, đuổi bắt, truy đuổi',
      example_hanzi = '他看见老奶奶把刚买的蔬菜遗落在了菜摊上，连忙拿起塑料袋一路追了上去。',
      example_pinyin = 'Tā kànjiàn lǎonǎinai bǎ gāng mǎi de shūcài yíluò zài le càitān shang, liánmáng ná qǐ sùliàodài yílù zhuī le shàngqu.',
      example_vi = 'Anh ấy nhìn thấy bà cụ để quên rau vừa mua ở sạp rau, liền vội vã cầm túi ni lông chạy đuổi theo suốt một đoạn đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '追',
      'zhuī',
      'đuổi theo, đuổi bắt, truy đuổi',
      'Động từ',
      'HSK 5',
      '他看见老奶奶把刚买的蔬菜遗落在了菜摊上，连忙拿起塑料袋一路追了上去。',
      'Tā kànjiàn lǎonǎinai bǎ gāng mǎi de shūcài yíluò zài le càitān shang, liánmáng ná qǐ sùliàodài yílù zhuī le shàngqu.',
      'Anh ấy nhìn thấy bà cụ để quên rau vừa mua ở sạp rau, liền vội vã cầm túi ni lông chạy đuổi theo suốt một đoạn đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他看见老奶奶把刚买的蔬菜遗落在了菜摊上，连忙拿起塑料袋一路追了上去。', 'Tā kànjiàn lǎonǎinai bǎ gāng mǎi de shūcài yíluò zài le càitān shang, liánmáng ná qǐ sùliàodài yílù zhuī le shàngqu.', 'Anh ấy nhìn thấy bà cụ để quên rau vừa mua ở sạp rau, liền vội vã cầm túi ni lông chạy đuổi theo suốt một đoạn đường.', 'basic', 1),
      (v_id, '我国在深空探测与可控核聚变领域奋起直追，成功实现了从长期并跑向引领全球重大前沿科学基础设施建设的历史性跨越。', 'Wǒguó zài shēnkōng tàncè yǔ kěkòng hé-jùbiàn lǐngyù fènqǐ-zhízhuī, chénggōng shíxiàn le cóng chángqī bìngpǎo xiàng yǐnlǐng quánqiú zhòngdà qiányán kēxué jīchǔ-shèshī jiànshè de lìshǐxìng kuàyuè.', 'Nước ta trong các lĩnh vực thăm dò vũ trụ sâu và nhiệt hạch có thể kiểm soát đã vươn lên đuổi kịp mạnh mẽ, thành công hiện thực hóa bước nhảy vọt lịch sử từ việc chạy song hành trường kỳ tiến tới dẫn dắt xây dựng các cơ sở hạ tầng khoa học mũi nhọn trọng đại toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3566] [追求] (zhuīqiú) - theo đuổi, mưu cầu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '追求' AND pinyin = 'zhuīqiú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '追求' AND pinyin = 'zhuīqiú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '追求'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '追求'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zhuīqiú',
      meaning_vi = 'theo đuổi, mưu cầu',
      example_hanzi = '青年人应当树立远大崇高的人生理想，勇于追求自己的梦想而不畏惧途中的艰难险阻。',
      example_pinyin = 'Qīngniánrén yīngdāng shùlì yuǎndà chónggāo de rénshēng lǐxiǎng, yǒngyú zhuīqiú zìjǐ de mèngxiǎng ér bú wèijù túzhōng de jiānnán-xiǎnzǔ.',
      example_vi = 'Thanh niên nên xác lập lý tưởng nhân sinh cao đẹp và rộng lớn, dũng cảm theo đuổi ước mơ của mình mà không hề khiếp sợ những gian lao trắc trở trên đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '追求',
      'zhuīqiú',
      'theo đuổi, mưu cầu',
      'Động từ',
      'HSK 5',
      '青年人应当树立远大崇高的人生理想，勇于追求自己的梦想而不畏惧途中的艰难险阻。',
      'Qīngniánrén yīngdāng shùlì yuǎndà chónggāo de rénshēng lǐxiǎng, yǒngyú zhuīqiú zìjǐ de mèngxiǎng ér bú wèijù túzhōng de jiānnán-xiǎnzǔ.',
      'Thanh niên nên xác lập lý tưởng nhân sinh cao đẹp và rộng lớn, dũng cảm theo đuổi ước mơ của mình mà không hề khiếp sợ những gian lao trắc trở trên đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年人应当树立远大崇高的人生理想，勇于追求自己的梦想而不畏惧途中的艰难险阻。', 'Qīngniánrén yīngdāng shùlì yuǎndà chónggāo de rénshēng lǐxiǎng, yǒngyú zhuīqiú zìjǐ de mèngxiǎng ér bú wèijù túzhōng de jiānnán-xiǎnzǔ.', 'Thanh niên nên xác lập lý tưởng nhân sinh cao đẹp và rộng lớn, dũng cảm theo đuổi ước mơ của mình mà không hề khiếp sợ những gian lao trắc trở trên đường.', 'basic', 1),
      (v_id, '现代法治文明追求实体公正与程序正义的内在统一，保障每一个公民在司法审判案件中都能切实感受到公平正义。', 'Xiàndài fǎzhì wénmíng zhuīqiú shítǐ gōngzhèng yǔ chéngxù zhèngyì de nèizài tǒngyī, bǎozhàng měi yí ge gōngmín zài sīfǎ shěnpàn ànjiàn zhōng dōu néng qièshí gǎnshòu dào gōngpíng zhèngyì.', 'Văn minh pháp trị hiện đại theo đuổi sự thống nhất nội tại giữa công lý thực thể và công lý quy trình, bảo đảm mỗi một công dân trong các vụ án xét xử tư pháp đều có thể cảm nhận thực chất sự công bằng và chính nghĩa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3567] [资格] (zīgé) - tư cách, điều kiện, tiêu chuẩn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '资格' AND pinyin = 'zīgé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '资格' AND pinyin = 'zīgé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '资格'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '资格'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zīgé',
      meaning_vi = 'tư cách, điều kiện, tiêu chuẩn',
      example_hanzi = '只有按时修满规定的大学本科学分并通过毕业答辩的学生，才具备申请学士学位的法定资格。',
      example_pinyin = 'Zhǐyǒu ànshí xiū mǎn guīdìng de dàxué běnkē xuéfēn bìng tōngguò bìyè dábbiàn de xuésheng, cái jùbèi shēnqǐng xuéshì xuéwèi de fǎdìng zīgé.',
      example_vi = 'Chỉ có những sinh viên hoàn thành đúng hạn các tín chỉ đại học chính quy theo quy định và vượt qua bảo vệ khóa luận tốt nghiệp mới có đủ tư cách pháp định để xin cấp bằng cử nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '资格',
      'zīgé',
      'tư cách, điều kiện, tiêu chuẩn',
      'Danh từ',
      'HSK 5',
      '只有按时修满规定的大学本科学分并通过毕业答辩的学生，才具备申请学士学位的法定资格。',
      'Zhǐyǒu ànshí xiū mǎn guīdìng de dàxué běnkē xuéfēn bìng tōngguò bìyè dábbiàn de xuésheng, cái jùbèi shēnqǐng xuéshì xuéwèi de fǎdìng zīgé.',
      'Chỉ có những sinh viên hoàn thành đúng hạn các tín chỉ đại học chính quy theo quy định và vượt qua bảo vệ khóa luận tốt nghiệp mới có đủ tư cách pháp định để xin cấp bằng cử nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只有按时修满规定的大学本科学分并通过毕业答辩的学生，才具备申请学士学位的法定资格。', 'Zhǐyǒu ànshí xiū mǎn guīdìng de dàxué běnkē xuéfēn bìng tōngguò bìyè dábbiàn de xuésheng, cái jùbèi shēnqǐng xuéshì xuéwèi de fǎdìng zīgé.', 'Chỉ có những sinh viên hoàn thành đúng hạn các tín chỉ đại học chính quy theo quy định và vượt qua bảo vệ khóa luận tốt nghiệp mới có đủ tư cách pháp định để xin cấp bằng cử nhân.', 'basic', 1),
      (v_id, '金融监管委员会对申请从事跨境衍生金融工具交易的期货经纪商实行穿透式净资本与风控能力准入资格动态审查。', 'Jīnróng jiānguǎn wěiyuánhuì duì shēnqǐng cóngshì kuàjìng yǎnshēng jīnróng gōngjù jiāoyì de qīhuò jīngjìshāng shíxíng chuāntòushì jìng-zīběn yǔ fēngkòng nénglì zhǔnrù zīgé dòngtài shěnchá.', 'Ủy ban giám sát tài chính thực thi việc thẩm tra động tư cách gia nhập thị trường về năng lực quản trị rủi ro và vốn tự có ròng mang tính xuyên thấu đối với các công ty môi giới phái sinh xin phép kinh doanh giao dịch công cụ tài chính phái sinh xuyên biên giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3568] [资金] (zījīn) - vốn, nguồn vốn, tiền vốn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '资金' AND pinyin = 'zījīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '资金' AND pinyin = 'zījīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '资金'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '资金'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zījīn',
      meaning_vi = 'vốn, nguồn vốn, tiền vốn',
      example_hanzi = '这家初创科技团队凭借出色的智能算法原型设计，在第一轮融资中成功筹集到了五百万元创业资金。',
      example_pinyin = 'Zhè jiā chūchuàng kējì tuánduì píngjiè chūsè de zhìnéng suànfǎ yuánxíng shèjì, zài dì-yī lún róngzī zhōng chénggōng chóují dào le wǔbǎi wàn yuán chuàngyè zījīn.',
      example_vi = 'Đội ngũ công nghệ khởi nghiệp này dựa vào thiết kế nguyên mẫu thuật toán thông minh xuất sắc đã gọi vốn thành công năm triệu nhân dân tệ tiền vốn khởi nghiệp trong vòng cấp vốn đầu tiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '资金',
      'zījīn',
      'vốn, nguồn vốn, tiền vốn',
      'Danh từ',
      'HSK 5',
      '这家初创科技团队凭借出色的智能算法原型设计，在第一轮融资中成功筹集到了五百万元创业资金。',
      'Zhè jiā chūchuàng kējì tuánduì píngjiè chūsè de zhìnéng suànfǎ yuánxíng shèjì, zài dì-yī lún róngzī zhōng chénggōng chóují dào le wǔbǎi wàn yuán chuàngyè zījīn.',
      'Đội ngũ công nghệ khởi nghiệp này dựa vào thiết kế nguyên mẫu thuật toán thông minh xuất sắc đã gọi vốn thành công năm triệu nhân dân tệ tiền vốn khởi nghiệp trong vòng cấp vốn đầu tiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家初创科技团队凭借出色的智能算法原型设计，在第一轮融资中成功筹集到了五百万元创业资金。', 'Zhè jiā chūchuàng kējì tuánduì píngjiè chūsè de zhìnéng suànfǎ yuánxíng shèjì, zài dì-yī lún róngzī zhōng chénggōng chóují dào le wǔbǎi wàn yuán chuàngyè zījīn.', 'Đội ngũ công nghệ khởi nghiệp này dựa vào thiết kế nguyên mẫu thuật toán thông minh xuất sắc đã gọi vốn thành công năm triệu nhân dân tệ tiền vốn khởi nghiệp trong vòng cấp vốn đầu tiên.', 'basic', 1),
      (v_id, '国家引导长期耐性资本与主权养老保障基金以股权投资方式精准注入国家重大科学装置与基础软件研发核心项目，保障研发资金链的稳固韧性。', 'Guójiā yǐndǎo chángqī nàixìng zīběn yǔ zhǔquán yǎnglǎo bǎozhàng jījīn yǐ gǔquán tóuzī fāngshì jīngzhǔn zhùrù guójiā zhòngdà kēxué zhuāngzhì yǔ jīchǔ ruǎnjiàn yánfā héxīn xiàngmù, bǎozhàng yánfā zījīnliàn de wěngù rènxìng.', 'Nhà nước định hướng dòng vốn kiên nhẫn dài hạn và quỹ bảo hiểm hưu trí chủ quyền rót vốn chuẩn xác dưới hình thức đầu tư cổ phần vào các trang thiết bị khoa học trọng đại quốc gia và dự án cốt lõi nghiên cứu phát triển phần mềm nền tảng, bảo đảm độ kiên cố và dẻo dai của chuỗi vốn R&D.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3569] [姿势] (zīshì) - tư thế, dáng điệu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '姿势' AND pinyin = 'zīshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '姿势' AND pinyin = 'zīshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '姿势'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '姿势'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zīshì',
      meaning_vi = 'tư thế, dáng điệu',
      example_hanzi = '长时间坐在电脑前伏案办公的人，一定要保持端正的坐立姿势以防颈椎和腰椎受到劳损。',
      example_pinyin = 'Cháng shíjiān zuò zài diànnǎo qián fú''àn bàngōng de rén, yídìng yào bǎochí duānzhèng de zuò-lì zīshì yǐfáng jǐngzhuī hé yāozhuī shòudào láosǔn.',
      example_vi = 'Những người ngồi làm việc trước máy tính trong thời gian dài nhất định phải duy trì tư thế ngồi đứng ngay ngắn để phòng ngừa đốt sống cổ và thắt lưng bị tổn thương thoái hóa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '姿势',
      'zīshì',
      'tư thế, dáng điệu',
      'Danh từ',
      'HSK 5',
      '长时间坐在电脑前伏案办公的人，一定要保持端正的坐立姿势以防颈椎和腰椎受到劳损。',
      'Cháng shíjiān zuò zài diànnǎo qián fú''àn bàngōng de rén, yídìng yào bǎochí duānzhèng de zuò-lì zīshì yǐfáng jǐngzhuī hé yāozhuī shòudào láosǔn.',
      'Những người ngồi làm việc trước máy tính trong thời gian dài nhất định phải duy trì tư thế ngồi đứng ngay ngắn để phòng ngừa đốt sống cổ và thắt lưng bị tổn thương thoái hóa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长时间坐在电脑前伏案办公的人，一定要保持端正的坐立姿势以防颈椎和腰椎受到劳损。', 'Cháng shíjiān zuò zài diànnǎo qián fú''àn bàngōng de rén, yídìng yào bǎochí duānzhèng de zuò-lì zīshì yǐfáng jǐngzhuī hé yāozhuī shòudào láosǔn.', 'Những người ngồi làm việc trước máy tính trong thời gian dài nhất định phải duy trì tư thế ngồi đứng ngay ngắn để phòng ngừa đốt sống cổ và thắt lưng bị tổn thương thoái hóa.', 'basic', 1),
      (v_id, '高精度人体姿态估计计算机视觉算法通过深度神经网络实时捕捉多关节三维空间坐标，被广泛应用于骨科康复评估与高端运动医学指导。', 'Gāojīngdù réntǐ zītài gūjì jìsuànjī shìjué suànfǎ tōngguò shēndù shénjīng-wǎngluò shíshí bǔzhuō duō-guānjié sānwéi kōngjiān zuòbiāo, bèi guǎngfàn yìngyòng yú gǔkē kāngfù pínggū yǔ gāoduān yùndòng yīxué zhǐdǎo.', 'Thuật toán thị giác máy tính ước lượng tư thế cơ thể người độ chính xác cao thông qua mạng nơ-ron sâu chụp lại tọa độ không gian ba chiều đa khớp theo thời gian thực, được ứng dụng rộng rãi trong đánh giá phục hồi chức năng chỉnh hình và chỉ đạo y học thể thao cao cấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3570] [咨询] (zīxún) - tư vấn, tham vấn [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '咨询' AND pinyin = 'zīxún'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '咨询' AND pinyin = 'zīxún'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '咨询'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '咨询'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zīxún',
      meaning_vi = 'tư vấn, tham vấn',
      example_hanzi = '如果你对大学志愿填报流程或者专业录取分数线有任何疑问，可以随时拨打招生咨询热线电话。',
      example_pinyin = 'Rúguǒ nǐ duì dàxué zhìyuàn tiánbào liúchéng huòzhě zhuānyè lùqǔ fēnshùxiàn yǒu rènhé yíwèn, kěyǐ suíshí bōdǎ zhāoshēng zīxún rèxiàn diànhuà.',
      example_vi = 'Nếu bạn có bất kỳ thắc mắc nào về quy trình đăng ký nguyện vọng đại học hay điểm chuẩn tuyển sinh chuyên ngành, bạn có thể gọi điện tới đường dây nóng tư vấn tuyển sinh bất cứ lúc nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '咨询',
      'zīxún',
      'tư vấn, tham vấn',
      'Động từ / Danh từ',
      'HSK 5',
      '如果你对大学志愿填报流程或者专业录取分数线有任何疑问，可以随时拨打招生咨询热线电话。',
      'Rúguǒ nǐ duì dàxué zhìyuàn tiánbào liúchéng huòzhě zhuānyè lùqǔ fēnshùxiàn yǒu rènhé yíwèn, kěyǐ suíshí bōdǎ zhāoshēng zīxún rèxiàn diànhuà.',
      'Nếu bạn có bất kỳ thắc mắc nào về quy trình đăng ký nguyện vọng đại học hay điểm chuẩn tuyển sinh chuyên ngành, bạn có thể gọi điện tới đường dây nóng tư vấn tuyển sinh bất cứ lúc nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果你对大学志愿填报流程或者专业录取分数线有任何疑问，可以随时拨打招生咨询热线电话。', 'Rúguǒ nǐ duì dàxué zhìyuàn tiánbào liúchéng huòzhě zhuānyè lùqǔ fēnshùxiàn yǒu rènhé yíwèn, kěyǐ suíshí bōdǎ zhāoshēng zīxún rèxiàn diànhuà.', 'Nếu bạn có bất kỳ thắc mắc nào về quy trình đăng ký nguyện vọng đại học hay điểm chuẩn tuyển sinh chuyên ngành, bạn có thể gọi điện tới đường dây nóng tư vấn tuyển sinh bất cứ lúc nào.', 'basic', 1),
      (v_id, '知名跨国战略管理咨询机构为该传统汽车制造巨头量身定制了向智能纯电新能源整体转型的五年实施路线图。', 'Zhīmíng kuàguó zhànlüè guǎnlǐ zīxún jīgòu wèi gāi chuántǒng qìchē zhìzào jùtóu liàngshēn dìngzhì le xiàng zhìnéng chún-diàn xīn-néngyuán zhěngtǐ zhuǎnxíng de wǔ nián shíshī lùxiàntú.', 'Cơ quan tư vấn quản lý chiến lược xuyên quốc gia nổi tiếng đã thiết kế riêng cho gã khổng lồ sản xuất ô tô truyền thống đó bản lộ trình thực thi năm năm về việc chuyển đổi tổng thể sang dòng xe năng lượng mới thuần điện thông minh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3571] [资源] (zīyuán) - tài nguyên, nguồn lực [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '资源' AND pinyin = 'zīyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '资源' AND pinyin = 'zīyuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '资源'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '资源'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zīyuán',
      meaning_vi = 'tài nguyên, nguồn lực',
      example_hanzi = '水资源是地球上所有生命不可或缺的宝贵物质基础，我们每个人在日常生活中都要养成节约用水的好习惯。',
      example_pinyin = 'Shuǐ zīyuán shì dìqiú shang suǒyǒu shēngmìng bùkě-huòquē de bǎoguì wùzhì jīchǔ, wǒmen měi ge rén zài rìcháng shēnghuó zhōng dōu yào yǎngchéng jiéyuē yòngshuǐ de hǎo xíguàn.',
      example_vi = 'Tài nguyên nước là cơ sở vật chất quý báu không thể thiếu của mọi sự sống trên Trái Đất, mỗi người chúng ta trong cuộc sống hằng ngày đều phải hình thành thói quen tốt tiết kiệm nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '资源',
      'zīyuán',
      'tài nguyên, nguồn lực',
      'Danh từ',
      'HSK 5',
      '水资源是地球上所有生命不可或缺的宝贵物质基础，我们每个人在日常生活中都要养成节约用水的好习惯。',
      'Shuǐ zīyuán shì dìqiú shang suǒyǒu shēngmìng bùkě-huòquē de bǎoguì wùzhì jīchǔ, wǒmen měi ge rén zài rìcháng shēnghuó zhōng dōu yào yǎngchéng jiéyuē yòngshuǐ de hǎo xíguàn.',
      'Tài nguyên nước là cơ sở vật chất quý báu không thể thiếu của mọi sự sống trên Trái Đất, mỗi người chúng ta trong cuộc sống hằng ngày đều phải hình thành thói quen tốt tiết kiệm nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '水资源是地球上所有生命不可或缺的宝贵物质基础，我们每个人在日常生活中都要养成节约用水的好习惯。', 'Shuǐ zīyuán shì dìqiú shang suǒyǒu shēngmìng bùkě-huòquē de bǎoguì wùzhì jīchǔ, wǒmen měi ge rén zài rìcháng shēnghuó zhōng dōu yào yǎngchéng jiéyuē yòngshuǐ de hǎo xíguàn.', 'Tài nguyên nước là cơ sở vật chất quý báu không thể thiếu của mọi sự sống trên Trái Đất, mỗi người chúng ta trong cuộc sống hằng ngày đều phải hình thành thói quen tốt tiết kiệm nước.', 'basic', 1),
      (v_id, '健全自然资源资产产权制度与生态产品价值实现机制，是统筹推进资源全面节约和集约循环利用的根本战略保障。', 'Jiànquán zìrán zīyuán zīchǎn chǎnquán zhìdù yǔ shēngtài chǎnpǐn jiàzhí shíxiàn jīzhì, shì tǒngchóu tuījìn zīyuán quánmiàn jiéyuē hé jíyuē xúnhuán lìyòng de gēnběn zhànlüè bǎozhàng.', 'Hoàn thiện chế độ quyền tài sản đối với tài sản tài nguyên thiên nhiên và cơ chế hiện thực hóa giá trị sản phẩm sinh thái là sự bảo đảm chiến lược căn bản để quy hoạch tổng thể thúc đẩy tiết kiệm toàn diện và sử dụng tuần hoàn tập trung tài nguyên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3572] [紫] (zǐ) - màu tím, tím [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '紫' AND pinyin = 'zǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '紫' AND pinyin = 'zǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '紫'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '紫'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zǐ',
      meaning_vi = 'màu tím, tím',
      example_hanzi = '秋天到来时，公园小湖边的草地上盛开着一大片清新雅致的淡紫色薰衣草花海。',
      example_pinyin = 'Qiūtiān dàolái shí, gōngyuán xiǎohú biān de cǎodì shang shèngkāi zhe yí dà piàn qīngxīn yǎzhì de dànzǐsè xūnyīcǎo huāhǎi.',
      example_vi = 'Khi mùa thu đến, trên bãi cỏ ven hồ nhỏ công viên nở rộ một biển hoa oải hương màu tím nhạt thanh tân tao nhã.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '紫',
      'zǐ',
      'màu tím, tím',
      'Tính từ',
      'HSK 5',
      '秋天到来时，公园小湖边的草地上盛开着一大片清新雅致的淡紫色薰衣草花海。',
      'Qiūtiān dàolái shí, gōngyuán xiǎohú biān de cǎodì shang shèngkāi zhe yí dà piàn qīngxīn yǎzhì de dànzǐsè xūnyīcǎo huāhǎi.',
      'Khi mùa thu đến, trên bãi cỏ ven hồ nhỏ công viên nở rộ một biển hoa oải hương màu tím nhạt thanh tân tao nhã.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '秋天到来时，公园小湖边的草地上盛开着一大片清新雅致的淡紫色薰衣草花海。', 'Qiūtiān dàolái shí, gōngyuán xiǎohú biān de cǎodì shang shèngkāi zhe yí dà piàn qīngxīn yǎzhì de dànzǐsè xūnyīcǎo huāhǎi.', 'Khi mùa thu đến, trên bãi cỏ ven hồ nhỏ công viên nở rộ một biển hoa oải hương màu tím nhạt thanh tân tao nhã.', 'basic', 1),
      (v_id, '极紫外光刻机采用十三点五纳米极短波长脉冲等离子体光源，代表着人类超大规模集成电路制造工艺的巅峰技术水平。', 'Jí-zǐwài guāngkèjī cǎiyòng shísān diǎn wǔ nàmǐ jí duǎn bōcháng màichōng děnglǐzǐtǐ guāngyuán, dàibiǎo zhe rénlèi chāo-dà-guīmó jíchéng-diànlù zhìzào gōngyì de diānfēng jìshù shuǐpíng.', 'Máy quang khắc cực tím (EUV) sử dụng nguồn sáng plasma xung bước sóng cực ngắn 13.5 nanomet, đại diện cho trình độ công nghệ kỹ thuật đỉnh cao trong quy trình chế tạo mạch tích hợp quy mô siêu lớn của nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3573] [子女] (zǐnǚ) - con cái, con trai con gái [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '子女' AND pinyin = 'zǐnǚ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '子女' AND pinyin = 'zǐnǚ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '子女'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '子女'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zǐnǚ',
      meaning_vi = 'con cái, con trai con gái',
      example_hanzi = '父母含辛茹苦将子女抚养成人，作为子女理应常回家看看并孝敬长辈。',
      example_pinyin = 'Fùmǔ hánxīn-rǔkǔ jiāng zǐnǚ fǔyǎng chéngrén, zuòwéi zǐnǚ lǐyīng cháng huíjiā kànkan bìng xiàojìng zhǎngbèi.',
      example_vi = 'Cha mẹ ngậm đắng nuốt cay nuôi nấng con cái nên người, phận làm con lẽ đương nhiên phải thường xuyên về nhà thăm nom và hiếu kính các bậc bề trên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '子女',
      'zǐnǚ',
      'con cái, con trai con gái',
      'Danh từ',
      'HSK 5',
      '父母含辛茹苦将子女抚养成人，作为子女理应常回家看看并孝敬长辈。',
      'Fùmǔ hánxīn-rǔkǔ jiāng zǐnǚ fǔyǎng chéngrén, zuòwéi zǐnǚ lǐyīng cháng huíjiā kànkan bìng xiàojìng zhǎngbèi.',
      'Cha mẹ ngậm đắng nuốt cay nuôi nấng con cái nên người, phận làm con lẽ đương nhiên phải thường xuyên về nhà thăm nom và hiếu kính các bậc bề trên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '父母含辛茹苦将子女抚养成人，作为子女理应常回家看看并孝敬长辈。', 'Fùmǔ hánxīn-rǔkǔ jiāng zǐnǚ fǔyǎng chéngrén, zuòwéi zǐnǚ lǐyīng cháng huíjiā kànkan bìng xiàojìng zhǎngbèi.', 'Cha mẹ ngậm đắng nuốt cay nuôi nấng con cái nên người, phận làm con lẽ đương nhiên phải thường xuyên về nhà thăm nom và hiếu kính các bậc bề trên.', 'basic', 1),
      (v_id, '完善生育支持政策体系包括大力发展普惠托育服务体系并全面减轻家庭在子女养育与优质教育方面的综合负担。', 'Wánshàn shēngyù zhīchí zhèngcè tǐxì bāokuò dàlì fāzhǎn pǔhuì tuōyù fúwù tǐxì bìng quánmiàn jiǎnqīng jiātíng zài zǐnǚ yǎngyù yǔ yōuzhì jiàoyù fāngmiàn de zōnghé fùdān.', 'Hoàn thiện hệ thống chính sách hỗ trợ sinh sản bao gồm việc phát triển mạnh mẽ hệ thống dịch vụ chăm sóc trẻ hòa nhập và giảm nhẹ toàn diện gánh nặng tổng hợp của gia đình trong nuôi dưỡng và giáo dục chất lượng cao cho con cái.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3574] [自从] (zìcóng) - từ khi, kể từ khi [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '自从' AND pinyin = 'zìcóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自从' AND pinyin = 'zìcóng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '自从'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自从'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Giới từ',
      pinyin = 'zìcóng',
      meaning_vi = 'từ khi, kể từ khi',
      example_hanzi = '自从去年夏天参加了长跑健身俱乐部以后，他的体质明显变强了，很少再生病感冒。',
      example_pinyin = 'Zìcóng qùnián xiàtiān cānjiā le chángpǎo jiànshēn jùlèbù yǐhòu, tā de tǐzhì míngxiǎn biàn qiáng le, hěn shǎo zài shēngbìng gǎnmào.',
      example_vi = 'Kể từ khi tham gia câu lạc bộ thể hình chạy đường dài vào mùa hè năm ngoái, thể chất của anh ấy đã mạnh lên rõ rệt, rất ít khi còn bị ốm đau cảm cúm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '自从',
      'zìcóng',
      'từ khi, kể từ khi',
      'Giới từ',
      'HSK 5',
      '自从去年夏天参加了长跑健身俱乐部以后，他的体质明显变强了，很少再生病感冒。',
      'Zìcóng qùnián xiàtiān cānjiā le chángpǎo jiànshēn jùlèbù yǐhòu, tā de tǐzhì míngxiǎn biàn qiáng le, hěn shǎo zài shēngbìng gǎnmào.',
      'Kể từ khi tham gia câu lạc bộ thể hình chạy đường dài vào mùa hè năm ngoái, thể chất của anh ấy đã mạnh lên rõ rệt, rất ít khi còn bị ốm đau cảm cúm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '自从去年夏天参加了长跑健身俱乐部以后，他的体质明显变强了，很少再生病感冒。', 'Zìcóng qùnián xiàtiān cānjiā le chángpǎo jiànshēn jùlèbù yǐhòu, tā de tǐzhì míngxiǎn biàn qiáng le, hěn shǎo zài shēngbìng gǎnmào.', 'Kể từ khi tham gia câu lạc bộ thể hình chạy đường dài vào mùa hè năm ngoái, thể chất của anh ấy đã mạnh lên rõ rệt, rất ít khi còn bị ốm đau cảm cúm.', 'basic', 1),
      (v_id, '自从世界贸易组织确立多边争端解决机制以来，基于规则的国际经贸争端仲裁对防止全球单边贸易制裁升级起到了极其重要的护栏作用。', 'Zìcóng Shìjiè Màoyì Zǔzhī quèlì duōbiān zhēngduān jiějué jīzhì yǐlái, jīyú guīzé de guójì jīng-mào zhēngduān zhòngcái duì fángzhǐ quánqiú dānbiān màoyì zhìcái shēngjí qǐdào le jíqí zhòngyào de hùlán zuòyòng.', 'Kể từ khi Tổ chức Thương mại Thế giới xác lập cơ chế giải quyết tranh chấp đa phương, trọng tài tranh chấp kinh tế thương mại quốc tế dựa trên quy tắc đã phát huy tác dụng rào chắn bảo vệ cực kỳ quan trọng đối với việc ngăn ngừa sự leo thang cấm vận thương mại đơn phương toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3575] [自动] (zìdòng) - tự động [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '自动' AND pinyin = 'zìdòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自动' AND pinyin = 'zìdòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '自动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Tính từ',
      pinyin = 'zìdòng',
      meaning_vi = 'tự động',
      example_hanzi = '商场入口处安装的感应式自动玻璃门极大方便了顾客推着购物车进出大厅。',
      example_pinyin = 'Shāngchǎng rùkǒuchù ānzhuāng de gǎnyìngshì zìdòng bōlímén jídà fāngbiàn le gùkè tuī zhe gòuwùchē jìnchū dàtīng.',
      example_vi = 'Cửa kính tự động dạng cảm ứng lắp đặt ở lối vào trung tâm thương mại đã tạo thuận lợi lớn cho khách hàng đẩy xe mua sắm ra vào sảnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '自动',
      'zìdòng',
      'tự động',
      'Phó từ / Tính từ',
      'HSK 5',
      '商场入口处安装的感应式自动玻璃门极大方便了顾客推着购物车进出大厅。',
      'Shāngchǎng rùkǒuchù ānzhuāng de gǎnyìngshì zìdòng bōlímén jídà fāngbiàn le gùkè tuī zhe gòuwùchē jìnchū dàtīng.',
      'Cửa kính tự động dạng cảm ứng lắp đặt ở lối vào trung tâm thương mại đã tạo thuận lợi lớn cho khách hàng đẩy xe mua sắm ra vào sảnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '商场入口处安装的感应式自动玻璃门极大方便了顾客推着购物车进出大厅。', 'Shāngchǎng rùkǒuchù ānzhuāng de gǎnyìngshì zìdòng bōlímén jídà fāngbiàn le gùkè tuī zhe gòuwùchē jìnchū dàtīng.', 'Cửa kính tự động dạng cảm ứng lắp đặt ở lối vào trung tâm thương mại đã tạo thuận lợi lớn cho khách hàng đẩy xe mua sắm ra vào sảnh.', 'basic', 1),
      (v_id, '深海油气开采浮式生产储卸油平台配备了全自动动态定位系统与井下紧急自动关断切断安全阀，确保在超强台风等恶劣海况下的作业安全性。', 'Shēnhǎi yóu-qì kāicǎi fúshì shēngchǎn chǔ-xiè yóu píngtái pèibèi le quán-zìdòng dòngtài dìngwèi xìtǒng yǔ jǐngxià jǐnjí zìdòng guānduàn qiēduàn ānquánfá, quèbǎo zài chāo-qiáng táifēng děng èliè hǎikuàng xià de zuòyè ānquánxìng.', 'Giàn khoan nổi sản xuất chứa và xuất dầu khí biển sâu được trang bị hệ thống định vị động học hoàn toàn tự động và van an toàn tự động ngắt khẩn cấp dưới giếng, bảo đảm an toàn tác nghiệp trong điều kiện biển động khắc nghiệt như siêu bão.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3576] [自觉] (zìjué) - tự giác, tự ý thức [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '自觉' AND pinyin = 'zìjué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自觉' AND pinyin = 'zìjué'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '自觉'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自觉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'zìjué',
      meaning_vi = 'tự giác, tự ý thức',
      example_hanzi = '在没有老师监考的情况下，同学们依然自觉遵守考场纪律，安静认真地答卷。',
      example_pinyin = 'Zài méiyǒu lǎoshī jiānkǎo de qíngkuàng xià, tóngxuémen yīrán zìjué zūnshǒu kǎochǎng jìlǜ, ānjìng rènzhēn de dájuàn.',
      example_vi = 'Trong tình huống không có giáo viên giám thị, các bạn học sinh vẫn tự giác tuân thủ kỷ luật phòng thi, làm bài một cách yên lặng và nghiêm túc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '自觉',
      'zìjué',
      'tự giác, tự ý thức',
      'Tính từ / Động từ',
      'HSK 5',
      '在没有老师监考的情况下，同学们依然自觉遵守考场纪律，安静认真地答卷。',
      'Zài méiyǒu lǎoshī jiānkǎo de qíngkuàng xià, tóngxuémen yīrán zìjué zūnshǒu kǎochǎng jìlǜ, ānjìng rènzhēn de dájuàn.',
      'Trong tình huống không có giáo viên giám thị, các bạn học sinh vẫn tự giác tuân thủ kỷ luật phòng thi, làm bài một cách yên lặng và nghiêm túc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在没有老师监考的情况下，同学们依然自觉遵守考场纪律，安静认真地答卷。', 'Zài méiyǒu lǎoshī jiānkǎo de qíngkuàng xià, tóngxuémen yīrán zìjué zūnshǒu kǎochǎng jìlǜ, ānjìng rènzhēn de dájuàn.', 'Trong tình huống không có giáo viên giám thị, các bạn học sinh vẫn tự giác tuân thủ kỷ luật phòng thi, làm bài một cách yên lặng và nghiêm túc.', 'basic', 1),
      (v_id, '全体党员干部必须把纪律规矩挺在前面，强化自我约束意识并自觉接受党内监督、社会舆论监督和广大人民群众监督。', 'Quántǐ dǎngyuán gànbù bìxū bǎ jìlǜ guīju tǐng zài qiánmiàn, qiánghuà zìwǒ yuēshù yìshí bìng zìjué jiēshòu dǎngrèi jiāndū, shèhuì yúlùn jiāndū hé guǎngdà rénmín qúnzhòng jiāndū.', 'Toàn thể cán bộ đảng viên bắt buộc phải đặt kỷ luật kỷ cương lên hàng đầu, tăng cường ý thức tự kiềm chế và tự giác chấp nhận sự giám sát trong nội bộ Đảng, giám sát dư luận xã hội cùng sự giám sát của đông đảo quần chúng nhân dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3577] [字母] (zìmǔ) - chữ cái, mẫu tự [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '字母' AND pinyin = 'zìmǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '字母' AND pinyin = 'zìmǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '字母'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '字母'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zìmǔ',
      meaning_vi = 'chữ cái, mẫu tự',
      example_hanzi = '初学汉语拼音的孩子们，首先需要熟练掌握声母和韵母的每一个汉语拼音字母发音。',
      example_pinyin = 'Chūxué Hànyǔ pīnyīn de háizimen, shǒuxiān xūyào shúliàn zhǎngwò shēngmǔ hé yùnmǔ de měi yí ge Hànyǔ pīnyīn zìmǔ fāyīn.',
      example_vi = 'Những đứa trẻ mới bắt đầu học phiên âm chữ Hán trước tiên cần nắm vững thành thạo cách phát âm của từng chữ cái thanh mẫu và vận mẫu trong phiên âm tiếng Hán.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '字母',
      'zìmǔ',
      'chữ cái, mẫu tự',
      'Danh từ',
      'HSK 5',
      '初学汉语拼音的孩子们，首先需要熟练掌握声母和韵母的每一个汉语拼音字母发音。',
      'Chūxué Hànyǔ pīnyīn de háizimen, shǒuxiān xūyào shúliàn zhǎngwò shēngmǔ hé yùnmǔ de měi yí ge Hànyǔ pīnyīn zìmǔ fāyīn.',
      'Những đứa trẻ mới bắt đầu học phiên âm chữ Hán trước tiên cần nắm vững thành thạo cách phát âm của từng chữ cái thanh mẫu và vận mẫu trong phiên âm tiếng Hán.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '初学汉语拼音的孩子们，首先需要熟练掌握声母和韵母的每一个汉语拼音字母发音。', 'Chūxué Hànyǔ pīnyīn de háizimen, shǒuxiān xūyào shúliàn zhǎngwò shēngmǔ hé yùnmǔ de měi yí ge Hànyǔ pīnyīn zìmǔ fāyīn.', 'Những đứa trẻ mới bắt đầu học phiên âm chữ Hán trước tiên cần nắm vững thành thạo cách phát âm của từng chữ cái thanh mẫu và vận mẫu trong phiên âm tiếng Hán.', 'basic', 1),
      (v_id, '银行核心数据库安全审计规范强制要求用户账户密码必须包含大写字母、小写字母、数字及特殊符号的复杂组合。', 'Yínháng héxīn shùjùkù ānquán shěnjì guīfàn qiángzhì yāoqiú yònghù zhànghù mìmǎ bìxū bāohán dàxiě zìmǔ, xiǎoxiě zìmǔ, shùzì jí tèshū fúhào de fùzá zǔhé.', 'Quy chuẩn kiểm toán an toàn cơ sở dữ liệu cốt lõi ngân hàng bắt buộc yêu cầu mật khẩu tài khoản người dùng phải bao gồm tổ hợp phức tạp của chữ cái in hoa, chữ cái in thường, chữ số và các ký tự đặc biệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3578] [自身] (zìshēn) - bản thân, chính mình, nội tại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '自身' AND pinyin = 'zìshēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自身' AND pinyin = 'zìshēn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '自身'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自身'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zìshēn',
      meaning_vi = 'bản thân, chính mình, nội tại',
      example_hanzi = '在激烈的职场竞争中，一个人只有不断提升自身的核心业务能力，才能赢得长远的发展空间。',
      example_pinyin = 'Zài jīliè de zhíchǎng jìngzhēng zhōng, yí ge rén zhǐyǒu búduàn tíshēng zìshēn de héxīn yèwù nénglì, cáinéng yíngdé chángyuǎn de fāzhǎn kōngjiān.',
      example_vi = 'Trong cuộc cạnh tranh công sở khốc liệt, một con người chỉ khi không ngừng nâng cao năng lực nghiệp vụ cốt lõi của bản thân thì mới có thể giành được không gian phát triển lâu dài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '自身',
      'zìshēn',
      'bản thân, chính mình, nội tại',
      'Danh từ',
      'HSK 5',
      '在激烈的职场竞争中，一个人只有不断提升自身的核心业务能力，才能赢得长远的发展空间。',
      'Zài jīliè de zhíchǎng jìngzhēng zhōng, yí ge rén zhǐyǒu búduàn tíshēng zìshēn de héxīn yèwù nénglì, cáinéng yíngdé chángyuǎn de fāzhǎn kōngjiān.',
      'Trong cuộc cạnh tranh công sở khốc liệt, một con người chỉ khi không ngừng nâng cao năng lực nghiệp vụ cốt lõi của bản thân thì mới có thể giành được không gian phát triển lâu dài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在激烈的职场竞争中，一个人只有不断提升自身的核心业务能力，才能赢得长远的发展空间。', 'Zài jīliè de zhíchǎng jìngzhēng zhōng, yí ge rén zhǐyǒu búduàn tíshēng zìshēn de héxīn yèwù nénglì, cáinéng yíngdé chángyuǎn de fāzhǎn kōngjiān.', 'Trong cuộc cạnh tranh công sở khốc liệt, một con người chỉ khi không ngừng nâng cao năng lực nghiệp vụ cốt lõi của bản thân thì mới có thể giành được không gian phát triển lâu dài.', 'basic', 1),
      (v_id, '跨国金融机构必须依托自身健全的合规管理体系与充足的资本缓冲，从容抵御来自全球地缘冲突与汇率剧烈波动的系统性外部冲击。', 'Kuàguó jīnróng jīgòu bìxū yītuō zìshēn jiànquán de hégūi guǎnlǐ tǐxì yǔ chōngzú de zīběn huǎnchōng, cóngróng dǐyù láizì quánqiú dìyuán chōngtū yǔ huìlǜ jùliè bōdòng de xìtǒngxìng wàibù chōngjī.', 'Các tổ chức tài chính xuyên quốc gia bắt buộc phải dựa vào hệ thống quản lý tuân thủ hoàn thiện và lớp đệm vốn dồi dào của bản thân để bình tĩnh chống đỡ các cú sốc hệ thống bên ngoài đến từ xung đột địa chính trị toàn cầu và sự biến động tỷ giá hối đoái dữ dội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3579] [自由] (zìyóu) - tự do [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '自由' AND pinyin = 'zìyóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自由' AND pinyin = 'zìyóu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '自由'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '自由'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'zìyóu',
      meaning_vi = 'tự do',
      example_hanzi = '周末做完功课之后，孩子们在开阔的绿草地上自由自在地奔跑玩耍、放风筝。',
      example_pinyin = 'Zhōumò zuò wán gōngkè zhīhòu, háizimen zài kāikuò de lǜ cǎodì shang zìyóu-zìzài de bēnpǎo wánshuǎ, fàng fēngzheng.',
      example_vi = 'Cuối tuần sau khi làm xong bài tập, các em nhỏ tự do tự tại chạy nhảy vui đùa thả diều trên thảm cỏ xanh rộng mở.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '自由',
      'zìyóu',
      'tự do',
      'Tính từ / Danh từ',
      'HSK 5',
      '周末做完功课之后，孩子们在开阔的绿草地上自由自在地奔跑玩耍、放风筝。',
      'Zhōumò zuò wán gōngkè zhīhòu, háizimen zài kāikuò de lǜ cǎodì shang zìyóu-zìzài de bēnpǎo wánshuǎ, fàng fēngzheng.',
      'Cuối tuần sau khi làm xong bài tập, các em nhỏ tự do tự tại chạy nhảy vui đùa thả diều trên thảm cỏ xanh rộng mở.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末做完功课之后，孩子们在开阔的绿草地上自由自在地奔跑玩耍、放风筝。', 'Zhōumò zuò wán gōngkè zhīhòu, háizimen zài kāikuò de lǜ cǎodì shang zìyóu-zìzài de bēnpǎo wánshuǎ, fàng fēngzheng.', 'Cuối tuần sau khi làm xong bài tập, các em nhỏ tự do tự tại chạy nhảy vui đùa thả diều trên thảm cỏ xanh rộng mở.', 'basic', 1),
      (v_id, '高标准国际自由贸易试验区持续对标国际高水平经贸规则，稳步推进投资贸易自由化便利化与跨国数据安全有序跨境流动。', 'Gāobiāozhǔn guójì zìyóu màoyì shìyànqū chíxù duìbiāo guójì gāoshuǐpíng jīng-mào guīzé, wěnbù tuījìn tóuzī màoyì zìyóuhuà biànlìhuà yǔ kuàguó shùjù ānquán yǒuxù kuàjìng liúdòng.', 'Khu thí điểm thương mại tự do quốc tế tiêu chuẩn cao liên tục đối chuẩn với các quy tắc kinh tế thương mại trình độ cao quốc tế, đẩy mạnh vững chắc việc tự do hóa và thuận lợi hóa đầu tư thương mại cùng dòng dữ liệu xuyên quốc gia luân chuyển qua biên giới an toàn có trật tự.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3580] [综合] (zōnghé) - tổng hợp [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '综合' AND pinyin = 'zōnghé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '综合' AND pinyin = 'zōnghé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '综合'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '综合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'zōnghé',
      meaning_vi = 'tổng hợp',
      example_hanzi = '这所综合性大学不仅拥有雄厚的文理工商学科实力，还设立了高水平的附属教学医院。',
      example_pinyin = 'Zhè suǒ zōnghéxìng dàxué bù jǐn yōngyǒu xiónghòu de wén-lǐ-gōng-shāng xuékē shílì, hái shèlì le gāoshuǐpíng de fùshǔ jiàoxué yīyuàn.',
      example_vi = 'Trường đại học tổng hợp này không chỉ sở hữu tiềm lực học thuật hùng hậu về các ngành văn khoa, tự nhiên, kỹ thuật và thương mại, mà còn thành lập bệnh viện thực hành giảng dạy trực thuộc trình độ cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '综合',
      'zōnghé',
      'tổng hợp',
      'Động từ / Tính từ',
      'HSK 5',
      '这所综合性大学不仅拥有雄厚的文理工商学科实力，还设立了高水平的附属教学医院。',
      'Zhè suǒ zōnghéxìng dàxué bù jǐn yōngyǒu xiónghòu de wén-lǐ-gōng-shāng xuékē shílì, hái shèlì le gāoshuǐpíng de fùshǔ jiàoxué yīyuàn.',
      'Trường đại học tổng hợp này không chỉ sở hữu tiềm lực học thuật hùng hậu về các ngành văn khoa, tự nhiên, kỹ thuật và thương mại, mà còn thành lập bệnh viện thực hành giảng dạy trực thuộc trình độ cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这所综合性大学不仅拥有雄厚的文理工商学科实力，还设立了高水平的附属教学医院。', 'Zhè suǒ zōnghéxìng dàxué bù jǐn yōngyǒu xiónghòu de wén-lǐ-gōng-shāng xuékē shílì, hái shèlì le gāoshuǐpíng de fùshǔ jiàoxué yīyuàn.', 'Trường đại học tổng hợp này không chỉ sở hữu tiềm lực học thuật hùng hậu về các ngành văn khoa, tự nhiên, kỹ thuật và thương mại, mà còn thành lập bệnh viện thực hành giảng dạy trực thuộc trình độ cao.', 'basic', 1),
      (v_id, '宏观经济运行综合监测预警系统基于海量产业运行指标与高频物流用电数据，为国家精准制定逆周期宏观调控政策提供科学依据。', 'Hóngguān jīngjì yùnxíng zōnghé jiāncè yùjǐng xìtǒng jīyú hǎiliàng chǎnyè yùnxíng zhǐbiāo yǔ gāopín wùliú yòngdiàn shùjù, wèi guójiā jīngzhǔn zhìdìng nì-zhōuqī hóngguān tiáokòng zhèngcè tígōng kēxué yījù.', 'Hệ thống cảnh báo sớm và giám sát tổng hợp vận hành kinh tế vĩ mô dựa trên khối lượng lớn các chỉ số vận hành công nghiệp và dữ liệu điện năng logistics tần suất cao, cung cấp căn cứ khoa học cho nhà nước định ra chuẩn xác chính sách điều tiết vĩ mô ngược chu kỳ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3581] [总部] (zǒngbù) - trụ sở chính, tổng bộ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '总部' AND pinyin = 'zǒngbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总部' AND pinyin = 'zǒngbù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '总部'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zǒngbù',
      meaning_vi = 'trụ sở chính, tổng bộ',
      example_hanzi = '这家跨国互联网科技公司的全球总部坐落在市中心繁华的高新技术软件产业园区内。',
      example_pinyin = 'Zhè jiā kuàguó hùliánwǎng kējì gōngsī de quánqiú zǒngbù zuòluò zài shìzhōngxīn fánhuá de gāoxīn-jìshù ruǎnjiàn chǎnyè yuánqū nèi.',
      example_vi = 'Trụ sở chính toàn cầu của công ty công nghệ internet xuyên quốc gia này tọa lạc bên trong khu công nghiệp phần mềm công nghệ cao sầm uất ở trung tâm thành phố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '总部',
      'zǒngbù',
      'trụ sở chính, tổng bộ',
      'Danh từ',
      'HSK 5',
      '这家跨国互联网科技公司的全球总部坐落在市中心繁华的高新技术软件产业园区内。',
      'Zhè jiā kuàguó hùliánwǎng kējì gōngsī de quánqiú zǒngbù zuòluò zài shìzhōngxīn fánhuá de gāoxīn-jìshù ruǎnjiàn chǎnyè yuánqū nèi.',
      'Trụ sở chính toàn cầu của công ty công nghệ internet xuyên quốc gia này tọa lạc bên trong khu công nghiệp phần mềm công nghệ cao sầm uất ở trung tâm thành phố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家跨国互联网科技公司的全球总部坐落在市中心繁华的高新技术软件产业园区内。', 'Zhè jiā kuàguó hùliánwǎng kējì gōngsī de quánqiú zǒngbù zuòluò zài shìzhōngxīn fánhuá de gāoxīn-jìshù ruǎnjiàn chǎnyè yuánqū nèi.', 'Trụ sở chính toàn cầu của công ty công nghệ internet xuyên quốc gia này tọa lạc bên trong khu công nghiệp phần mềm công nghệ cao sầm uất ở trung tâm thành phố.', 'basic', 1),
      (v_id, '国际大都市出台专项财税与人才配套扶持政策，积极吸引跨国财富五百强企业亚太地区综合运营总部与研发创新中心入驻。', 'Guójì dà-dūshì chūtái zhuānxiàng cái-shuì yǔ réncái pèitào fǔchí zhèngcè, jījí xīyǐn kuàguó Cáifù Wǔbǎi Qiáng qǐyè Yà-Tài dìqū zōnghé yùnyíng zǒngbù yǔ yánfā chuàngxīn zhōngxīn rùzhù.', 'Đại đô thị quốc tế đã ban hành chính sách hỗ trợ ưu đãi tài chính thuế và đồng bộ nhân tài chuyên đề, tích cực thu hút trụ sở vận hành tổng hợp khu vực Châu Á - Thái Bình Dương và trung tâm đổi mới R&D của các doanh nghiệp Fortune 500 đa quốc gia đến định vị.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3582] [总共] (zǒnggòng) - tổng cộng, cả thảy [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '总共' AND pinyin = 'zǒnggòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总共' AND pinyin = 'zǒnggòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '总共'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总共'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'zǒnggòng',
      meaning_vi = 'tổng cộng, cả thảy',
      example_hanzi = '收银员核对完购物车里的所有日用品后微笑着说，您买的这些东西总共是一百八十元。',
      example_pinyin = 'Shōuyínyuán héduì wán gòuwùchē lǐ de suǒyǒu rìyòngpǐn hòu wēixiào zhe shuō, nín mǎi de zhèxiē dōngxi zǒnggòng shì yībǎi bāshí yuán.',
      example_vi = 'Nhân viên thu ngân sau khi đối chiếu toàn bộ đồ dùng sinh hoạt trong xe mua sắm đã mỉm cười nói: "Những thứ quý khách mua đây tổng cộng là 180 tệ ạ".'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '总共',
      'zǒnggòng',
      'tổng cộng, cả thảy',
      'Phó từ',
      'HSK 5',
      '收银员核对完购物车里的所有日用品后微笑着说，您买的这些东西总共是一百八十元。',
      'Shōuyínyuán héduì wán gòuwùchē lǐ de suǒyǒu rìyòngpǐn hòu wēixiào zhe shuō, nín mǎi de zhèxiē dōngxi zǒnggòng shì yībǎi bāshí yuán.',
      'Nhân viên thu ngân sau khi đối chiếu toàn bộ đồ dùng sinh hoạt trong xe mua sắm đã mỉm cười nói: "Những thứ quý khách mua đây tổng cộng là 180 tệ ạ".'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '收银员核对完购物车里的所有日用品后微笑着说，您买的这些东西总共是一百八十元。', 'Shōuyínyuán héduì wán gòuwùchē lǐ de suǒyǒu rìyòngpǐn hòu wēixiào zhe shuō, nín mǎi de zhèxiē dōngxi zǒnggòng shì yībǎi bāshí yuán.', 'Nhân viên thu ngân sau khi đối chiếu toàn bộ đồ dùng sinh hoạt trong xe mua sắm đã mỉm cười nói: "Những thứ quý khách mua đây tổng cộng là 180 tệ ạ".', 'basic', 1),
      (v_id, '国家重大水利枢纽主体工程耗时八年顺利竣工，项目总共消耗高标号特种抗裂大坝混凝土超过一千二百万立方米。', 'Guójiā zhòngdà shuǐlì shūniǔ zhǔtǐ gōngchéng hàoshí bā nián shùnlì jùngōng, xiàngmù zǒnggòng xiāohào gāobiāohào tèzhǒng kàngliè dàbà hùnníngtǔ chāoguò yìqiān èrbǎi wàn lìfāngmǐ.', 'Công trình chính của đầu mối thủy lợi trọng đại quốc gia mất 8 năm đã khánh thành thuận lợi, dự án tổng cộng tiêu hao hơn 12 triệu mét khối bê tông mác cao chống nứt đặc chủng cho đập lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3583] [总数] (zǒngshù) - tổng số [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '总数' AND pinyin = 'zǒngshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总数' AND pinyin = 'zǒngshù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '总数'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总数'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zǒngshù',
      meaning_vi = 'tổng số',
      example_hanzi = '教务处统计数据显示，今年报考该大学硕士研究生招生考试的考生总数突破了一万五千人。',
      example_pinyin = 'Jiàowùchù tǒngjì shùjù xiǎnshì, jīnnián bàokǎo gāi dàxué shuòshì yánjiūshēng zhāoshēng kǎoshì de kǎoshēng zǒngshù tūpò le yíwàn wǔqiān rén.',
      example_vi = 'Số liệu thống kê của phòng giáo vụ cho thấy tổng số thí sinh đăng ký dự thi tuyển sinh thạc sĩ của trường đại học đó năm nay đã vượt mốc 15.000 người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '总数',
      'zǒngshù',
      'tổng số',
      'Danh từ',
      'HSK 5',
      '教务处统计数据显示，今年报考该大学硕士研究生招生考试的考生总数突破了一万五千人。',
      'Jiàowùchù tǒngjì shùjù xiǎnshì, jīnnián bàokǎo gāi dàxué shuòshì yánjiūshēng zhāoshēng kǎoshì de kǎoshēng zǒngshù tūpò le yíwàn wǔqiān rén.',
      'Số liệu thống kê của phòng giáo vụ cho thấy tổng số thí sinh đăng ký dự thi tuyển sinh thạc sĩ của trường đại học đó năm nay đã vượt mốc 15.000 người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '教务处统计数据显示，今年报考该大学硕士研究生招生考试的考生总数突破了一万五千人。', 'Jiàowùchù tǒngjì shùjù xiǎnshì, jīnnián bàokǎo gāi dàxué shuòshì yánjiūshēng zhāoshēng kǎoshì de kǎoshēng zǒngshù tūpò le yíwàn wǔqiān rén.', 'Số liệu thống kê của phòng giáo vụ cho thấy tổng số thí sinh đăng ký dự thi tuyển sinh thạc sĩ của trường đại học đó năm nay đã vượt mốc 15.000 người.', 'basic', 1),
      (v_id, '全球有效发明专利授权总数的持续攀升，客观反映了战略科技力量在新一代信息通信与生物制造底层核心专利上的主导地位。', 'Quánqiú yǒuxiào fāmíng zhuānlì shòuquán zǒngshù de chíxù pānshēng, kèguān fǎnyìng le zhànlüè kējì lìliang zài xīn-yídài xìnxī tōngxìn yǔ shēngwù zhìzào dǐcéng héxīn zhuānlì shang de zhǔdǎo dìwèi.', 'Tổng số bằng độc quyền sáng chế phát minh còn hiệu lực toàn cầu liên tục tăng vọt đã phản ánh khách quan vị thế chủ đạo của lực lượng khoa học công nghệ chiến lược trong các bằng sáng chế cốt lõi tầng dưới về thông tin truyền thông thế hệ mới và sản xuất sinh học.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3584] [总体] (zǒngtǐ) - tổng thể, toàn cục [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '总体' AND pinyin = 'zǒngtǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总体' AND pinyin = 'zǒngtǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '总体'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总体'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'zǒngtǐ',
      meaning_vi = 'tổng thể, toàn cục',
      example_hanzi = '虽然个别章节的语法知识掌握得还不够熟练，但班级同学在期末模拟考试中的总体成绩相当不错。',
      example_pinyin = 'Suīrán gèbié zhāngjié de yǔfǎ zhīshi zhǎngwò de hái bú gòu shúliàn, dàn bānjí tóngxué zài qīmò mónǐ kǎoshì zhōng de zǒngtǐ chéngjì xiāngdāng búcuò.',
      example_vi = 'Tuy rằng kiến thức ngữ pháp của một vài chương nắm bắt còn chưa thật thành thạo, nhưng thành tích tổng thể của học sinh cả lớp trong kỳ thi thử cuối kỳ là khá tốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '总体',
      'zǒngtǐ',
      'tổng thể, toàn cục',
      'Danh từ / Tính từ',
      'HSK 5',
      '虽然个别章节的语法知识掌握得还不够熟练，但班级同学在期末模拟考试中的总体成绩相当不错。',
      'Suīrán gèbié zhāngjié de yǔfǎ zhīshi zhǎngwò de hái bú gòu shúliàn, dàn bānjí tóngxué zài qīmò mónǐ kǎoshì zhōng de zǒngtǐ chéngjì xiāngdāng búcuò.',
      'Tuy rằng kiến thức ngữ pháp của một vài chương nắm bắt còn chưa thật thành thạo, nhưng thành tích tổng thể của học sinh cả lớp trong kỳ thi thử cuối kỳ là khá tốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '虽然个别章节的语法知识掌握得还不够熟练，但班级同学在期末模拟考试中的总体成绩相当不错。', 'Suīrán gèbié zhāngjié de yǔfǎ zhīshi zhǎngwò de hái bú gòu shúliàn, dàn bānjí tóngxué zài qīmò mónǐ kǎoshì zhōng de zǒngtǐ chéngjì xiāngdāng búcuò.', 'Tuy rằng kiến thức ngữ pháp của một vài chương nắm bắt còn chưa thật thành thạo, nhưng thành tích tổng thể của học sinh cả lớp trong kỳ thi thử cuối kỳ là khá tốt.', 'basic', 1),
      (v_id, '中央经济工作会议明确指出当前宏观经济运行总体平稳、稳中有进，必须统筹扩大内需和深化供给侧结构性改革。', 'Zhōngyāng Jīngjì Gōngzuò Huìyì míngquè zhǐchū dāngqián hóngguān jīngjì yùnxíng zǒngtǐ píngwěn, wěnzhōng-yǒujìn, bìxū tǒngchóu kuòdà nèixū hé shēnhuà gōngjǐcè jiégòuxìng gǎigé.', 'Hội nghị Công tác Kinh tế Trung ương chỉ rõ rằng vận hành kinh tế vĩ mô hiện nay về mặt tổng thể ổn định, trong ổn định có tiến bộ, bắt buộc phải quy hoạch thống nhất mở rộng nội cầu và làm sâu sắc thêm cải cách cơ cấu bên phía cung.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3585] [总统] (zǒngtǒng) - tổng thống [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '总统' AND pinyin = 'zǒngtǒng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总统' AND pinyin = 'zǒngtǒng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '总统'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总统'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zǒngtǒng',
      meaning_vi = 'tổng thống',
      example_hanzi = '在友好访问期间，外国总统在总统府大礼堂热情接见了我国文化青年交流代表团全体成员。',
      example_pinyin = 'Zài yǒuhǎo fǎngwèn qījiān, wàiguó zǒngtǒng zài zǒngtǒngfǔ dà-lǐtáng rèqíng jiējiàn le wǒguó wénhuà qīngnián jiāoliú dàibiǎotuán quántǐ chéngyuán.',
      example_vi = 'Trong thời gian chuyến thăm hữu nghị, vị tổng thống nước ngoài đã nhiệt tình tiếp kiến toàn thể thành viên đoàn đại biểu giao lưu thanh niên văn hóa nước ta tại lễ đường lớn của phủ tổng thống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '总统',
      'zǒngtǒng',
      'tổng thống',
      'Danh từ',
      'HSK 5',
      '在友好访问期间，外国总统在总统府大礼堂热情接见了我国文化青年交流代表团全体成员。',
      'Zài yǒuhǎo fǎngwèn qījiān, wàiguó zǒngtǒng zài zǒngtǒngfǔ dà-lǐtáng rèqíng jiējiàn le wǒguó wénhuà qīngnián jiāoliú dàibiǎotuán quántǐ chéngyuán.',
      'Trong thời gian chuyến thăm hữu nghị, vị tổng thống nước ngoài đã nhiệt tình tiếp kiến toàn thể thành viên đoàn đại biểu giao lưu thanh niên văn hóa nước ta tại lễ đường lớn của phủ tổng thống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在友好访问期间，外国总统在总统府大礼堂热情接见了我国文化青年交流代表团全体成员。', 'Zài yǒuhǎo fǎngwèn qījiān, wàiguó zǒngtǒng zài zǒngtǒngfǔ dà-lǐtáng rèqíng jiējiàn le wǒguó wénhuà qīngnián jiāoliú dàibiǎotuán quántǐ chéngyuán.', 'Trong thời gian chuyến thăm hữu nghị, vị tổng thống nước ngoài đã nhiệt tình tiếp kiến toàn thể thành viên đoàn đại biểu giao lưu thanh niên văn hóa nước ta tại lễ đường lớn của phủ tổng thống.', 'basic', 1),
      (v_id, '两国总统举行正式双边战略会谈并共同签署了关于应对气候变化、深化清洁能源与和平利用外层空间合作的联合声明。', 'Liǎng guó zǒngtǒng jǔxíng zhèngshì shuāngbiān zhànlüè huìtán bìng gòngtóng qiānshǔ le guānyú yìngduì qìhòu biànhuà, shēnhuà qīngjié néngyuán yǔ hépíng lìyòng wàicéng kōngjiān hézuò de liánhé shēngmíng.', 'Tổng thống hai nước đã tổ chức hội đàm chiến lược song phương chính thức và cùng ký tuyên bố chung về việc ứng phó với biến đổi khí hậu, làm sâu sắc thêm hợp tác năng lượng sạch và sử dụng hòa bình không gian vũ trụ ngoài tầng khí quyển.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3586] [总之] (zǒngzhī) - tóm lại, nói tóm lại [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '总之' AND pinyin = 'zǒngzhī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总之' AND pinyin = 'zǒngzhī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '总之'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '总之'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'zǒngzhī',
      meaning_vi = 'tóm lại, nói tóm lại',
      example_hanzi = '无论是背诵词汇、练习听力还是开口朗读，总之，学好一门外语离不开日积月累的持之以恒。',
      example_pinyin = 'Wúlùn shì bèisòng cíhuì, liànxí tīnglì háishì kāikǒu lǎngdú, zǒngzhī, xué hǎo yì mén wàiyǔ lí bù kāi rì-jī-yuè-lěi de chízhī-yǐhéng.',
      example_vi = 'Bất luận là học thuộc lòng từ vựng, luyện nghe hay mở miệng đọc to, tóm lại, học tốt một ngoại ngữ không thể tách rời sự kiên trì tích lũy ngày qua tháng lại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '总之',
      'zǒngzhī',
      'tóm lại, nói tóm lại',
      'Liên từ',
      'HSK 5',
      '无论是背诵词汇、练习听力还是开口朗读，总之，学好一门外语离不开日积月累的持之以恒。',
      'Wúlùn shì bèisòng cíhuì, liànxí tīnglì háishì kāikǒu lǎngdú, zǒngzhī, xué hǎo yì mén wàiyǔ lí bù kāi rì-jī-yuè-lěi de chízhī-yǐhéng.',
      'Bất luận là học thuộc lòng từ vựng, luyện nghe hay mở miệng đọc to, tóm lại, học tốt một ngoại ngữ không thể tách rời sự kiên trì tích lũy ngày qua tháng lại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论是背诵词汇、练习听力还是开口朗读，总之，学好一门外语离不开日积月累的持之以恒。', 'Wúlùn shì bèisòng cíhuì, liànxí tīnglì háishì kāikǒu lǎngdú, zǒngzhī, xué hǎo yì mén wàiyǔ lí bù kāi rì-jī-yuè-lěi de chízhī-yǐhéng.', 'Bất luận là học thuộc lòng từ vựng, luyện nghe hay mở miệng đọc to, tóm lại, học tốt một ngoại ngữ không thể tách rời sự kiên trì tích lũy ngày qua tháng lại.', 'basic', 1),
      (v_id, '总之，唯有坚持以科技自主创新为核心驱动力，加快培育新质生产力，才能在波谲云诡的全球新一轮产业变革中赢得战略主动权。', 'Zǒngzhī, wéiyǒu jiānchí yǐ kējì zìzhǔ chuàngxīn wéi héxīn qūdònglì, jiākuài péiyù xīnzhì shēngchǎnlì, cáinéng zài bōjué-yúnguǐ de quánqiú xīn-yì-lún chǎnyè biàngé zhōng yíngdé zhànlüè zhǔdòngquán.', 'Nói tóm lại, duy chỉ có kiên trì lấy đổi mới sáng tạo công nghệ tự chủ làm động lực cốt lõi, đẩy nhanh ươm mầm lực lượng sản xuất chất lượng mới thì mới có thể giành quyền chủ động chiến lược trong cuộc biến cách công nghiệp vòng mới biến đổi khôn lường trên toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3587] [租金] (zūjīn) - tiền thuê, tiền thuê nhà [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '租金' AND pinyin = 'zūjīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '租金' AND pinyin = 'zūjīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '租金'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '租金'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zūjīn',
      meaning_vi = 'tiền thuê, tiền thuê nhà',
      example_hanzi = '按照房屋租赁合同的约定，租客应当在每个月五号之前通过手机银行足额支付当月的房屋租金。',
      example_pinyin = 'Ànzhào fángwū zūlìn hétong de yuēdìng, zūkè yīngdāng zài měi ge yuè wǔ hào zhīqián tōngguò shǒujī yínháng zú''é zhīfù dāngyuè de fángwū zūjīn.',
      example_vi = 'Theo đúng thỏa thuận trong hợp đồng thuê nhà, người thuê trọ nên chuyển khoản trả đủ số tiền thuê nhà tháng đó qua ứng dụng ngân hàng di động trước ngày mùng 5 hàng tháng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '租金',
      'zūjīn',
      'tiền thuê, tiền thuê nhà',
      'Danh từ',
      'HSK 5',
      '按照房屋租赁合同的约定，租客应当在每个月五号之前通过手机银行足额支付当月的房屋租金。',
      'Ànzhào fángwū zūlìn hétong de yuēdìng, zūkè yīngdāng zài měi ge yuè wǔ hào zhīqián tōngguò shǒujī yínháng zú''é zhīfù dāngyuè de fángwū zūjīn.',
      'Theo đúng thỏa thuận trong hợp đồng thuê nhà, người thuê trọ nên chuyển khoản trả đủ số tiền thuê nhà tháng đó qua ứng dụng ngân hàng di động trước ngày mùng 5 hàng tháng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '按照房屋租赁合同的约定，租客应当在每个月五号之前通过手机银行足额支付当月的房屋租金。', 'Ànzhào fángwū zūlìn hétong de yuēdìng, zūkè yīngdāng zài měi ge yuè wǔ hào zhīqián tōngguò shǒujī yínháng zú''é zhīfù dāngyuè de fángwū zūjīn.', 'Theo đúng thỏa thuận trong hợp đồng thuê nhà, người thuê trọ nên chuyển khoản trả đủ số tiền thuê nhà tháng đó qua ứng dụng ngân hàng di động trước ngày mùng 5 hàng tháng.', 'basic', 1),
      (v_id, '高科技产业园区通过财政专项贴息与减免前两年标准厂房租金等一揽子综合扶持举措，大幅降低了硬科技初创企业的早期运营成本。', 'Gāokējì chǎnyè yuánqū tōngguò cáizhèng zhuānxiàng tiēxī yǔ jiǎnmiǎn qián liǎng nián biāozhǔn chǎngfáng zūjīn děng yìlǎnzǐ zōnghé fǔchí jǔcuò, dàfú jiàngdī le yìng-kējì chūchuàng qǐyè de zǎoqī yùnyíng chéngběn.', 'Khu công nghiệp công nghệ cao thông qua gói biện pháp hỗ trợ tổng hợp như trợ cấp lãi suất tài chính chuyên đề và miễn giảm tiền thuê nhà xưởng tiêu chuẩn trong hai năm đầu, đã hạ giảm rất lớn chi phí vận hành giai đoạn đầu cho các doanh nghiệp khởi nghiệp công nghệ lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3588] [族] (zú) - tộc, giới, nhóm người (ví dụ: 上班族, 民族, 贵族) [Danh từ / Hậu tố]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '族' AND pinyin = 'zú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '族' AND pinyin = 'zú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '族'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '族'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Hậu tố',
      pinyin = 'zú',
      meaning_vi = 'tộc, giới, nhóm người (ví dụ: 上班族, 民族, 贵族)',
      example_hanzi = '每天清晨在地铁车站里行色匆匆的年轻上班族，都在为了美好的生活而努力拼搏。',
      example_pinyin = 'Měitiān qīngchén zài dìtiě chēzhàn lǐ xíngsè-cōngcōng de niánqīng shàngbānzú, dōu zài wèile měihǎo de shēnghuó ér nǔlì pīnbó.',
      example_vi = 'Mỗi buổi sáng sớm, giới nhân viên đi làm trẻ tuổi bước đi vội vã trong ga tàu điện ngầm đều đang nỗ lực phấn đấu vì một cuộc sống tươi đẹp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '族',
      'zú',
      'tộc, giới, nhóm người (ví dụ: 上班族, 民族, 贵族)',
      'Danh từ / Hậu tố',
      'HSK 5',
      '每天清晨在地铁车站里行色匆匆的年轻上班族，都在为了美好的生活而努力拼搏。',
      'Měitiān qīngchén zài dìtiě chēzhàn lǐ xíngsè-cōngcōng de niánqīng shàngbānzú, dōu zài wèile měihǎo de shēnghuó ér nǔlì pīnbó.',
      'Mỗi buổi sáng sớm, giới nhân viên đi làm trẻ tuổi bước đi vội vã trong ga tàu điện ngầm đều đang nỗ lực phấn đấu vì một cuộc sống tươi đẹp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天清晨在地铁车站里行色匆匆的年轻上班族，都在为了美好的生活而努力拼搏。', 'Měitiān qīngchén zài dìtiě chēzhàn lǐ xíngsè-cōngcōng de niánqīng shàngbānzú, dōu zài wèile měihǎo de shēnghuó ér nǔlì pīnbó.', 'Mỗi buổi sáng sớm, giới nhân viên đi làm trẻ tuổi bước đi vội vã trong ga tàu điện ngầm đều đang nỗ lực phấn đấu vì một cuộc sống tươi đẹp.', 'basic', 1),
      (v_id, '在新一轮消费浪潮中，被称为银发族的老年群体与追求个性化体验的年轻一代成为引领品质康养与文化消费升级的生力军。', 'Zài xīn-yì-lún xiāofèi làngcháo zhōng, bèi chēngwéi yínfàzú de lǎonián qúntǐ yǔ zhuīqiú gèxìnghuà tǐyàn de niánqīng yídài chéngwéi yǐnlǐng pǐnzhì kāngyǎng yǔ wénhuà xiāofèi shēngjí de shēnglìjūn.', 'Trong làn sóng tiêu dùng mới, nhóm người cao tuổi được gọi là "giới tóc bạc" cùng thế hệ trẻ theo đuổi trải nghiệm cá nhân hóa đã trở thành lực lượng nòng cốt dẫn dắt việc nâng cấp tiêu dùng văn hóa và an dưỡng chăm sóc sức khỏe chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3589] [足够] (zúgòu) - đầy đủ, đủ [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '足够' AND pinyin = 'zúgòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '足够' AND pinyin = 'zúgòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '足够'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '足够'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'zúgòu',
      meaning_vi = 'đầy đủ, đủ',
      example_hanzi = '出门长途旅行前，请务必在背包里准备好足够的新鲜饮用水、高能量零食和常备急救药品。',
      example_pinyin = 'Chūmén chángtú lǚxíng qián, qǐng wùbì zài bèibāo lǐ zhǔnbèi hǎo zúgòu de xīnxiān yǐnyòngshuǐ, gāo-néngliàng língshí hé chángbèi jíjiù yàopǐn.',
      example_vi = 'Trước khi lên đường đi du lịch đường dài, xin hãy chuẩn bị đầy đủ nước uống sạch tươi mát, đồ ăn vặt giàu năng lượng và các loại thuốc cấp cứu thông dụng trong ba lô.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '足够',
      'zúgòu',
      'đầy đủ, đủ',
      'Tính từ / Động từ',
      'HSK 5',
      '出门长途旅行前，请务必在背包里准备好足够的新鲜饮用水、高能量零食和常备急救药品。',
      'Chūmén chángtú lǚxíng qián, qǐng wùbì zài bèibāo lǐ zhǔnbèi hǎo zúgòu de xīnxiān yǐnyòngshuǐ, gāo-néngliàng língshí hé chángbèi jíjiù yàopǐn.',
      'Trước khi lên đường đi du lịch đường dài, xin hãy chuẩn bị đầy đủ nước uống sạch tươi mát, đồ ăn vặt giàu năng lượng và các loại thuốc cấp cứu thông dụng trong ba lô.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出门长途旅行前，请务必在背包里准备好足够的新鲜饮用水、高能量零食和常备急救药品。', 'Chūmén chángtú lǚxíng qián, qǐng wùbì zài bèibāo lǐ zhǔnbèi hǎo zúgòu de xīnxiān yǐnyòngshuǐ, gāo-néngliàng língshí hé chángbèi jíjiù yàopǐn.', 'Trước khi lên đường đi du lịch đường dài, xin hãy chuẩn bị đầy đủ nước uống sạch tươi mát, đồ ăn vặt giàu năng lượng và các loại thuốc cấp cứu thông dụng trong ba lô.', 'basic', 1),
      (v_id, '央行通过公开市场操作向银行间金融体系投放充裕流动性，确保满足商业银行季度末监管考核与实体经济信贷投放的足够流动性需求。', 'Yāngháng tōngguò gōngkāi shìchǎng cāozuò xiàng yínhángjiān jīnróng tǐxì tóufàng chōngyù liúdòngxìng, quèbǎo mǎnzú shāngyè yínháng jìdùmò jiānguǎn kǎohé yǔ shítǐ jīngjì xìndài tóufàng de zúgòu liúdòngxìng xūqiú.', 'Ngân hàng Trung ương thông qua nghiệp vụ thị trường mở bơm thanh khoản dồi dào vào hệ thống tài chính liên ngân hàng, bảo đảm đáp ứng đầy đủ nhu cầu thanh khoản cho các ngân hàng thương mại kỳ sát hạch giám sát cuối quý và cấp tín dụng cho nền kinh tế thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3590] [组成] (zǔchéng) - tạo thành, cấu thành, hợp thành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '组成' AND pinyin = 'zǔchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '组成' AND pinyin = 'zǔchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '组成'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '组成'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zǔchéng',
      meaning_vi = 'tạo thành, cấu thành, hợp thành',
      example_hanzi = '我们班级一共由来自全国十二个不同省份的四十位优秀青年学生共同组成。',
      example_pinyin = 'Wǒmen bānjí yígòng yóu láizì quánguó shí''èr ge bùtóng shěngfèn de sìshí wèi yōuxiù qīngnián xuésheng gòngtóng zǔchéng.',
      example_vi = 'Lớp học của chúng tôi gồm tổng cộng 40 bạn sinh viên thanh niên ưu tú đến từ 12 tỉnh thành khác nhau trên toàn quốc cùng hợp thành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '组成',
      'zǔchéng',
      'tạo thành, cấu thành, hợp thành',
      'Động từ',
      'HSK 5',
      '我们班级一共由来自全国十二个不同省份的四十位优秀青年学生共同组成。',
      'Wǒmen bānjí yígòng yóu láizì quánguó shí''èr ge bùtóng shěngfèn de sìshí wèi yōuxiù qīngnián xuésheng gòngtóng zǔchéng.',
      'Lớp học của chúng tôi gồm tổng cộng 40 bạn sinh viên thanh niên ưu tú đến từ 12 tỉnh thành khác nhau trên toàn quốc cùng hợp thành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们班级一共由来自全国十二个不同省份的四十位优秀青年学生共同组成。', 'Wǒmen bānjí yígòng yóu láizì quánguó shí''èr ge bùtóng shěngfèn de sìshí wèi yōuxiù qīngnián xuésheng gòngtóng zǔchéng.', 'Lớp học của chúng tôi gồm tổng cộng 40 bạn sinh viên thanh niên ưu tú đến từ 12 tỉnh thành khác nhau trên toàn quốc cùng hợp thành.', 'basic', 1),
      (v_id, '国家空间站核心实验舱由推进舱、气闸舱与节点舱等多个高精尖密封增压功能舱段精密对接组成。', 'Guójiā kōngjiānzhàn héxīn shíyàncāng yóu tuījìncāng, qìzhácāng yǔ jiédiǎncāng děng duō ge gāojīngjiān mìfēng zēngyā gōngnéng cāngduàn jīngmì duìjiē zǔchéng.', 'Khoang thí nghiệm cốt lõi của trạm vũ trụ không gian quốc gia do nhiều khoang chức năng tăng áp kín khí tinh vi như khoang đẩy, khoang khóa khí và khoang nút kết nối cơ học chính xác hợp thành.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3591] [组合] (zǔhé) - kết hợp, phối hợp; tổ hợp [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '组合' AND pinyin = 'zǔhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '组合' AND pinyin = 'zǔhé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '组合'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '组合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zǔhé',
      meaning_vi = 'kết hợp, phối hợp; tổ hợp',
      example_hanzi = '在校园合唱艺术节上，四位不同声部的同学自发组合成了一个完美的无伴奏混声合唱小组。',
      example_pinyin = 'Zài xiàoyuán héchàng yìshùjié shang, sì wèi bùtóng shēngbù de tóngxué zìfā zǔhé chéng le yí ge wánměi de wúbànzòu hùnshēng héchàng xiǎozǔ.',
      example_vi = 'Tại liên hoan nghệ thuật hợp xướng trường học, bốn bạn học sinh thuộc các bè giọng khác nhau đã tự giác phối hợp thành một nhóm hợp xướng hòa thanh không nhạc đệm (acappella) hoàn hảo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '组合',
      'zǔhé',
      'kết hợp, phối hợp; tổ hợp',
      'Động từ / Danh từ',
      'HSK 5',
      '在校园合唱艺术节上，四位不同声部的同学自发组合成了一个完美的无伴奏混声合唱小组。',
      'Zài xiàoyuán héchàng yìshùjié shang, sì wèi bùtóng shēngbù de tóngxué zìfā zǔhé chéng le yí ge wánměi de wúbànzòu hùnshēng héchàng xiǎozǔ.',
      'Tại liên hoan nghệ thuật hợp xướng trường học, bốn bạn học sinh thuộc các bè giọng khác nhau đã tự giác phối hợp thành một nhóm hợp xướng hòa thanh không nhạc đệm (acappella) hoàn hảo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在校园合唱艺术节上，四位不同声部的同学自发组合成了一个完美的无伴奏混声合唱小组。', 'Zài xiàoyuán héchàng yìshùjié shang, sì wèi bùtóng shēngbù de tóngxué zìfā zǔhé chéng le yí ge wánměi de wúbànzòu hùnshēng héchàng xiǎozǔ.', 'Tại liên hoan nghệ thuật hợp xướng trường học, bốn bạn học sinh thuộc các bè giọng khác nhau đã tự giác phối hợp thành một nhóm hợp xướng hòa thanh không nhạc đệm (acappella) hoàn hảo.', 'basic', 1),
      (v_id, '现代投资组合理论指导基金经理在宏观利率波动周期中通过动态优化权益类与固定收益类资产组合，有效对冲非系统性市场风险。', 'Xiàndài tóuzī zǔhé lǐlùn zhǐdǎo jījīn jīnglǐ zài hóngguān lìlǜ bōdòng zhōuqī zhōng tōngguò dòngtài yōuhuà quányìlèi yǔ gùdìng-shōuyìlèi zīchǎn zǔhé, yǒuxiào duìchōng fēi-xìtǒngxìng shìchǎng fēngxiǎn.', 'Lý thuyết danh mục đầu tư hiện đại chỉ dẫn cho nhà quản lý quỹ trong chu kỳ biến động lãi suất vĩ mô thông qua việc tối ưu hóa linh hoạt danh mục tài sản cổ phiếu và tài sản thu nhập cố định để phòng vệ hiệu quả các rủi ro thị trường phi hệ thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3592] [阻止] (zǔzhǐ) - ngăn cản, ngăn chặn, cản trở [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '阻止' AND pinyin = 'zǔzhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '阻止' AND pinyin = 'zǔzhǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '阻止'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '阻止'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zǔzhǐ',
      meaning_vi = 'ngăn cản, ngăn chặn, cản trở',
      example_hanzi = '当发现有调皮的小朋友打算攀爬湖边危险的护栏时，热心的巡逻保安立即上前严厉阻止。',
      example_pinyin = 'Dāng fāxiàn yǒu tiáopí de xiǎopéngyou dǎsuàn pānpá húbiān wēixiǎn de hùlán shí, rèxīn de xúnluó bǎo''ān lìjí shàngqián yánlì zǔzhǐ.',
      example_vi = 'Khi phát hiện có em nhỏ nghịch ngợm định trèo lên lan can nguy hiểm ven hồ, nhân viên bảo vệ tuần tra nhiệt tình đã lập tức bước lên phía trước nghiêm khắc ngăn cản.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '阻止',
      'zǔzhǐ',
      'ngăn cản, ngăn chặn, cản trở',
      'Động từ',
      'HSK 5',
      '当发现有调皮的小朋友打算攀爬湖边危险的护栏时，热心的巡逻保安立即上前严厉阻止。',
      'Dāng fāxiàn yǒu tiáopí de xiǎopéngyou dǎsuàn pānpá húbiān wēixiǎn de hùlán shí, rèxīn de xúnluó bǎo''ān lìjí shàngqián yánlì zǔzhǐ.',
      'Khi phát hiện có em nhỏ nghịch ngợm định trèo lên lan can nguy hiểm ven hồ, nhân viên bảo vệ tuần tra nhiệt tình đã lập tức bước lên phía trước nghiêm khắc ngăn cản.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '当发现有调皮的小朋友打算攀爬湖边危险的护栏时，热心的巡逻保安立即上前严厉阻止。', 'Dāng fāxiàn yǒu tiáopí de xiǎopéngyou dǎsuàn pānpá húbiān wēixiǎn de hùlán shí, rèxīn de xúnluó bǎo''ān lìjí shàngqián yánlì zǔzhǐ.', 'Khi phát hiện có em nhỏ nghịch ngợm định trèo lên lan can nguy hiểm ven hồ, nhân viên bảo vệ tuần tra nhiệt tình đã lập tức bước lên phía trước nghiêm khắc ngăn cản.', 'basic', 1),
      (v_id, '国际公海核安全监督公约赋予国际原子能机构合法权限，采取一切必要法律与外交手段坚决阻止放射性污染核废水擅自向公海排海。', 'Guójì gōnghǎi hé-ānquán jiāndū gōngyuē fùyǔ Guójì Yuánzǐnéng Jīgòu héfǎ quánxiàn, cǎiqǔ yíqiè bìyào fǎlǜ yǔ wàijiāo shǒuduàn jiānjué zǔzhǐ fàngshèxìng wūrǎn hé-fèishuǐ shànzì xiàng gōnghǎi páihǎi.', 'Công ước giám sát an toàn hạt nhân vùng biển quốc tế trao quyền hạn pháp lý hợp pháp cho Cơ quan Năng lượng Nguyên tử Quốc tế áp dụng mọi biện pháp pháp luật và ngoại giao cần thiết để kiên quyết ngăn chặn việc tự ý xả nước thải hạt nhân ô nhiễm phóng xạ ra vùng biển quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3593] [组织] (zǔzhī) - tổ chức, cơ quan tổ chức; cấu trúc mô học [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '组织' AND pinyin = 'zǔzhī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '组织' AND pinyin = 'zǔzhī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '组织'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '组织'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'zǔzhī',
      meaning_vi = 'tổ chức, cơ quan tổ chức; cấu trúc mô học',
      example_hanzi = '学校学生会下周六将组织全体大一新生参观市历史博物馆与现代科技馆。',
      example_pinyin = 'Xuéxiào xuéshenghuì xià zhōuliù jiāng zǔzhī quántǐ dàyī xīnshēng cānguān shì lìshǐ bówùguǎn yǔ xiàndài kējìguǎn.',
      example_vi = 'Hội sinh viên nhà trường thứ Bảy tuần tới sẽ tổ chức cho toàn thể tân sinh viên năm nhất đi tham quan bảo tàng lịch sử và bảo tàng công nghệ hiện đại của thành phố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '组织',
      'zǔzhī',
      'tổ chức, cơ quan tổ chức; cấu trúc mô học',
      'Động từ / Danh từ',
      'HSK 5',
      '学校学生会下周六将组织全体大一新生参观市历史博物馆与现代科技馆。',
      'Xuéxiào xuéshenghuì xià zhōuliù jiāng zǔzhī quántǐ dàyī xīnshēng cānguān shì lìshǐ bówùguǎn yǔ xiàndài kējìguǎn.',
      'Hội sinh viên nhà trường thứ Bảy tuần tới sẽ tổ chức cho toàn thể tân sinh viên năm nhất đi tham quan bảo tàng lịch sử và bảo tàng công nghệ hiện đại của thành phố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校学生会下周六将组织全体大一新生参观市历史博物馆与现代科技馆。', 'Xuéxiào xuéshenghuì xià zhōuliù jiāng zǔzhī quántǐ dàyī xīnshēng cānguān shì lìshǐ bówùguǎn yǔ xiàndài kējìguǎn.', 'Hội sinh viên nhà trường thứ Bảy tuần tới sẽ tổ chức cho toàn thể tân sinh viên năm nhất đi tham quan bảo tàng lịch sử và bảo tàng công nghệ hiện đại của thành phố.', 'basic', 1),
      (v_id, '现代再生医学通过三维生物打印技术精确重构具有活体血管网络的人体复杂器官软组织，为终末期器官衰竭移植带来了革命性曙光。', 'Xiàndài zàishēng yīxué tōngguò sānwéi shēngwù dǎyìn jìshù jīngquè chónggòu jùyǒu huótǐ xiěguǎn wǎngluò de réntǐ fùzá qìguān ruǎnzǔzhī, wèi zhōngmòqī qìguān shuāijié yízhí dài lái le gémìngxìng shǔguāng.', 'Y học tái tạo hiện đại thông qua công nghệ in sinh học 3D tái tạo chuẩn xác các mô mềm nội tạng phức tạp của cơ thể người có mạng lưới mạch máu sống, đem lại ánh sáng bình minh mang tính cách mạng cho việc cấy ghép suy nội tạng giai đoạn cuối.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3594] [嘴巴] (zuǐba) - mồm, miệng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '嘴巴' AND pinyin = 'zuǐba'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '嘴巴' AND pinyin = 'zuǐba'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '嘴巴'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '嘴巴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zuǐba',
      meaning_vi = 'mồm, miệng',
      example_hanzi = '小婴儿喝完温热的母乳之后，用肥嘟嘟的小手揉了揉嘴巴，甜甜地进入了梦乡。',
      example_pinyin = 'Xiǎo yīng''ér hē wán wēnrè de mǔrǔ zhīhòu, yòng féidūdū de xiǎoshǒu róu le róu zuǐba, tiántián de jìnrù le mèngxiāng.',
      example_vi = 'Em bé sơ sinh sau khi uống xong dòng sữa mẹ ấm áp, dùng bàn tay nhỏ mập mạp dụi dụi cái miệng xinh rồi ngọt ngào đi vào giấc ngủ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '嘴巴',
      'zuǐba',
      'mồm, miệng',
      'Danh từ',
      'HSK 5',
      '小婴儿喝完温热的母乳之后，用肥嘟嘟的小手揉了揉嘴巴，甜甜地进入了梦乡。',
      'Xiǎo yīng''ér hē wán wēnrè de mǔrǔ zhīhòu, yòng féidūdū de xiǎoshǒu róu le róu zuǐba, tiántián de jìnrù le mèngxiāng.',
      'Em bé sơ sinh sau khi uống xong dòng sữa mẹ ấm áp, dùng bàn tay nhỏ mập mạp dụi dụi cái miệng xinh rồi ngọt ngào đi vào giấc ngủ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小婴儿喝完温热的母乳之后，用肥嘟嘟的小手揉了揉嘴巴，甜甜地进入了梦乡。', 'Xiǎo yīng''ér hē wán wēnrè de mǔrǔ zhīhòu, yòng féidūdū de xiǎoshǒu róu le róu zuǐba, tiántián de jìnrù le mèngxiāng.', 'Em bé sơ sinh sau khi uống xong dòng sữa mẹ ấm áp, dùng bàn tay nhỏ mập mạp dụi dụi cái miệng xinh rồi ngọt ngào đi vào giấc ngủ.', 'basic', 1),
      (v_id, '语言病理学与神经生物学研究证实，中枢脑卒中后患者嘴巴面部神经肌肉功能障碍可通过精准经颅磁刺激得到有效神经重塑恢复。', 'Yǔyán bìnglǐxué yǔ shénjīng-shēngwùxué yánjiū zhèngshí, zhōngshū nǎozùzhòng hòu huànzhě zuǐba miànbù shénjīng-jīròu gōngnéng zhàng''ài kě tōngguò jīngzhǔn jīnglú cícìjī dédào yǒuxiào shénjīng chóngsù huīfù.', 'Nghiên cứu sinh học thần kinh và bệnh lý học ngôn ngữ chứng minh rằng rối loạn chức năng thần kinh cơ mặt miệng của bệnh nhân sau đột quỵ não trung khu có thể phục hồi tái tạo thần kinh hiệu quả thông qua kích thích từ xuyên sọ chuẩn xác.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3595] [醉] (zuì) - say, say rượu; say mê, đắm chìm [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '醉' AND pinyin = 'zuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '醉' AND pinyin = 'zuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '醉'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '醉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'zuì',
      meaning_vi = 'say, say rượu; say mê, đắm chìm',
      example_hanzi = '老朋友多年未见格外亲切，虽然桌上只备了一瓶陈年美酒，大家却都沉醉在温馨的回忆之中。',
      example_pinyin = 'Lǎo péngyou duō nián wèi jiàn géwài qīnqiè, suīrán zhuō shang zhǐ bèi le yì píng chénnián měijiǔ, dàjiā què dōu chénzuì zài wēnxīn de huíyì zhīzhōng.',
      example_vi = 'Những người bạn cũ nhiều năm không gặp vô cùng thân thiết, dẫu trên bàn chỉ chuẩn bị một chai rượu ngon lâu năm, mọi người lại đều say đắm trong những kỷ niệm ấm áp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '醉',
      'zuì',
      'say, say rượu; say mê, đắm chìm',
      'Động từ / Tính từ',
      'HSK 5',
      '老朋友多年未见格外亲切，虽然桌上只备了一瓶陈年美酒，大家却都沉醉在温馨的回忆之中。',
      'Lǎo péngyou duō nián wèi jiàn géwài qīnqiè, suīrán zhuō shang zhǐ bèi le yì píng chénnián měijiǔ, dàjiā què dōu chénzuì zài wēnxīn de huíyì zhīzhōng.',
      'Những người bạn cũ nhiều năm không gặp vô cùng thân thiết, dẫu trên bàn chỉ chuẩn bị một chai rượu ngon lâu năm, mọi người lại đều say đắm trong những kỷ niệm ấm áp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老朋友多年未见格外亲切，虽然桌上只备了一瓶陈年美酒，大家却都沉醉在温馨的回忆之中。', 'Lǎo péngyou duō nián wèi jiàn géwài qīnqiè, suīrán zhuō shang zhǐ bèi le yì píng chénnián měijiǔ, dàjiā què dōu chénzuì zài wēnxīn de huíyì zhīzhōng.', 'Những người bạn cũ nhiều năm không gặp vô cùng thân thiết, dẫu trên bàn chỉ chuẩn bị một chai rượu ngon lâu năm, mọi người lại đều say đắm trong những kỷ niệm ấm áp.', 'basic', 1),
      (v_id, '国家刑法修正案以严格的零容忍法定态度严厉打击酒驾与醉驾危险驾驶犯罪行为，坚决守护亿万公众的道路出行生命安全。', 'Guójiā xíngfǎ xiūzhèng''àn yǐ yángé de líng-róngrěn fǎdìng tàidù yánlì dǎjī jiǔjià yǔ zuìjià wēixiǎn jiàshǐ fànzuì xíngwéi, jiānjué shǒuhù yìwàn gōngzhòng de dàolù chūxíng shēngmìng ānquán.', 'Luật hình sự sửa đổi quốc gia với thái độ pháp định không khoan nhượng nghiêm ngặt trừng trị thẳng tay các hành vi tội phạm lái xe nguy hiểm khi lái xe sau khi uống rượu và lái xe trong tình trạng say xỉn, kiên quyết bảo vệ an toàn tính mạng khi tham gia giao thông đường bộ của hàng ức người dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3596] [最初] (zuìchū) - lúc đầu, ban đầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '最初' AND pinyin = 'zuìchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '最初' AND pinyin = 'zuìchū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '最初'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '最初'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'zuìchū',
      meaning_vi = 'lúc đầu, ban đầu',
      example_hanzi = '他在刚刚开始学中文最初的那几个星期里，连最简单的声调平仄都常常分不清楚。',
      example_pinyin = 'Tā zài gānggāng kāishǐ xué Zhōngwén zuìchū de nà jǐ ge xīngqī lǐ, lián zuì jiǎndān de shēngdiào píngzè dōu chángcháng fēn bu qīngchu.',
      example_vi = 'Trong mấy tuần đầu tiên lúc anh ấy mới bắt đầu học tiếng Trung, ngay cả những thanh điệu bằng trắc đơn giản nhất cũng thường xuyên không phân biệt rõ được.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '最初',
      'zuìchū',
      'lúc đầu, ban đầu',
      'Danh từ',
      'HSK 5',
      '他在刚刚开始学中文最初的那几个星期里，连最简单的声调平仄都常常分不清楚。',
      'Tā zài gānggāng kāishǐ xué Zhōngwén zuìchū de nà jǐ ge xīngqī lǐ, lián zuì jiǎndān de shēngdiào píngzè dōu chángcháng fēn bu qīngchu.',
      'Trong mấy tuần đầu tiên lúc anh ấy mới bắt đầu học tiếng Trung, ngay cả những thanh điệu bằng trắc đơn giản nhất cũng thường xuyên không phân biệt rõ được.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在刚刚开始学中文最初的那几个星期里，连最简单的声调平仄都常常分不清楚。', 'Tā zài gānggāng kāishǐ xué Zhōngwén zuìchū de nà jǐ ge xīngqī lǐ, lián zuì jiǎndān de shēngdiào píngzè dōu chángcháng fēn bu qīngchu.', 'Trong mấy tuần đầu tiên lúc anh ấy mới bắt đầu học tiếng Trung, ngay cả những thanh điệu bằng trắc đơn giản nhất cũng thường xuyên không phân biệt rõ được.', 'basic', 1),
      (v_id, '从最初几名青年科学家的车库简陋算法模型到成长为估值数千亿的全球人工智能领军独角兽，企业始终秉持着最初以技术造福人类的创新初心。', 'Cóng zuìchū jǐ míng qīngnián kēxuéjiā de chēkù jiǎnlòu suànfǎ móxíng dào chéngzhǎng wéi gūzhí shùqiānyì de quánqiú réngōng zhìnéng lǐngjūn dújiǎoshòu, qǐyè shǐzhōng bǐngchí zhe zuìchū yǐ jìshù zàofú rénlèi de chuàngxīn chūxīn.', 'Từ mô hình thuật toán sơ sài trong nhà để xe của vài nhà khoa học trẻ tuổi ban đầu cho đến khi phát triển thành kỳ lân dẫn dắt trí tuệ nhân tạo toàn cầu được định giá hàng trăm tỷ, doanh nghiệp vẫn luôn giữ vững tâm nguyện ban đầu về việc dùng công nghệ tạo phúc cho nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3597] [最佳] (zuìjiā) - tốt nhất, tối ưu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '最佳' AND pinyin = 'zuìjiā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '最佳' AND pinyin = 'zuìjiā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '最佳'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '最佳'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'zuìjiā',
      meaning_vi = 'tốt nhất, tối ưu',
      example_hanzi = '他在本次全国高校计算机编程大赛决赛中凭借巧妙的代码设计与极低的运行延迟荣获最佳算法奖。',
      example_pinyin = 'Tā zài běncì quánguó gāoxiào jìsuànjī biānchéng dàsài juésài zhōng píngjiè qiàomiǎo de dàimǎ shèjì yǔ jí dī de yùnxíng yánchí rónghuò zuìjiā suànfǎ jiǎng.',
      example_vi = 'Trong trận chung kết cuộc thi lập trình máy tính các trường đại học toàn quốc lần này, anh ấy dựa vào thiết kế mã nguồn khéo léo và độ trễ vận hành cực thấp đã vinh dự đoạt giải thuật toán xuất sắc nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '最佳',
      'zuìjiā',
      'tốt nhất, tối ưu',
      'Tính từ',
      'HSK 5',
      '他在本次全国高校计算机编程大赛决赛中凭借巧妙的代码设计与极低的运行延迟荣获最佳算法奖。',
      'Tā zài běncì quánguó gāoxiào jìsuànjī biānchéng dàsài juésài zhōng píngjiè qiàomiǎo de dàimǎ shèjì yǔ jí dī de yùnxíng yánchí rónghuò zuìjiā suànfǎ jiǎng.',
      'Trong trận chung kết cuộc thi lập trình máy tính các trường đại học toàn quốc lần này, anh ấy dựa vào thiết kế mã nguồn khéo léo và độ trễ vận hành cực thấp đã vinh dự đoạt giải thuật toán xuất sắc nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在本次全国高校计算机编程大赛决赛中凭借巧妙的代码设计与极低的运行延迟荣获最佳算法奖。', 'Tā zài běncì quánguó gāoxiào jìsuànjī biānchéng dàsài juésài zhōng píngjiè qiàomiǎo de dàimǎ shèjì yǔ jí dī de yùnxíng yánchí rónghuò zuìjiā suànfǎ jiǎng.', 'Trong trận chung kết cuộc thi lập trình máy tính các trường đại học toàn quốc lần này, anh ấy dựa vào thiết kế mã nguồn khéo léo và độ trễ vận hành cực thấp đã vinh dự đoạt giải thuật toán xuất sắc nhất.', 'basic', 1),
      (v_id, '新能源微电网能量管理系统利用强化学习算法实时计算风光储联合出力的最佳调度策略，实现电网综合运行成本与碳排放的全局最优。', 'Xīn-néngyuán wēidiànwǎng néngliàng guǎnlǐ xìtǒng lìyòng qiánghuà xuéxí suànfǎ shíshí jìsuàn fēng guāng chǔ liánhé chūlì de zuìjiā diàodù cèlüè, shíxiàn diànwǎng zōnghé yùnxíng chéngběn yǔ tàn-páifàng de quánjú zuìyōu.', 'Hệ thống quản lý năng lượng lưới điện vi mô năng lượng mới vận dụng thuật toán học tăng cường tính toán theo thời gian thực chiến lược điều độ tối ưu công suất kết hợp điện gió - mặt trời - lưu trữ, hiện thực hóa mức tối ưu toàn cục về chi phí vận hành tổng hợp và phát thải carbon của lưới điện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3598] [尊敬] (zūnjìng) - tôn kính, kính trọng [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '尊敬' AND pinyin = 'zūnjìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尊敬' AND pinyin = 'zūnjìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '尊敬'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '尊敬'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'zūnjìng',
      meaning_vi = 'tôn kính, kính trọng',
      example_hanzi = '张老师从教四十年桃李满天下，深受全校每一位师生发自肺腑的衷心尊敬与爱戴。',
      example_pinyin = 'Zhāng lǎoshī cóngjiào sìshí nián táolǐ-mǎn-tiānxià, shēnshòu quán xiào měi yí wèi shīshēng fāzì-fèifǔ de zhōngxīn zūnjìng yǔ àidài.',
      example_vi = 'Thầy giáo Trương dạy học bốn mươi năm học trò đầy thiên hạ, nhận được sự kính trọng và yêu mến xuất phát từ tận đáy lòng của mỗi thầy trò trong toàn trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '尊敬',
      'zūnjìng',
      'tôn kính, kính trọng',
      'Động từ / Tính từ',
      'HSK 5',
      '张老师从教四十年桃李满天下，深受全校每一位师生发自肺腑的衷心尊敬与爱戴。',
      'Zhāng lǎoshī cóngjiào sìshí nián táolǐ-mǎn-tiānxià, shēnshòu quán xiào měi yí wèi shīshēng fāzì-fèifǔ de zhōngxīn zūnjìng yǔ àidài.',
      'Thầy giáo Trương dạy học bốn mươi năm học trò đầy thiên hạ, nhận được sự kính trọng và yêu mến xuất phát từ tận đáy lòng của mỗi thầy trò trong toàn trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '张老师从教四十年桃李满天下，深受全校每一位师生发自肺腑的衷心尊敬与爱戴。', 'Zhāng lǎoshī cóngjiào sìshí nián táolǐ-mǎn-tiānxià, shēnshòu quán xiào měi yí wèi shīshēng fāzì-fèifǔ de zhōngxīn zūnjìng yǔ àidài.', 'Thầy giáo Trương dạy học bốn mươi năm học trò đầy thiên hạ, nhận được sự kính trọng và yêu mến xuất phát từ tận đáy lòng của mỗi thầy trò trong toàn trường.', 'basic', 1),
      (v_id, '国际社会普遍公认并坚定维护《联合国宪章》宗旨和原则，主张相互尊重国家主权与领土完整，切实尊重各国自主选择的发展道路与社会制度。', 'Guójì shèhuì pǔbiàn gōngrèn bìng jiāndìng wéihù "Liánhéguó Xiànzhāng" zōngzhǐ hé yuánzé, zhǔzhāng xiānghù zūnzhòng guójiā zhǔquán yǔ lǐngtǔ wánzhěng, qièshí zūnjìng gèguó zìzhǔ xuǎnzé de fāzhǎn dàolù yǔ shèhuì zhìdù.', 'Cộng đồng quốc tế thừa nhận rộng rãi và kiên định gìn giữ tôn chỉ và nguyên tắc của Hiến chương Liên Hợp Quốc, chủ trương tôn trọng lẫn nhau về chủ quyền quốc gia và toàn vẹn lãnh thổ, tôn trọng thực chất con đường phát triển và chế độ xã hội mà mỗi quốc gia tự chủ lựa chọn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3599] [遵守] (zūnshǒu) - tuân thủ, tuân theo [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '遵守' AND pinyin = 'zūnshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '遵守' AND pinyin = 'zūnshǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '遵守'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '遵守'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zūnshǒu',
      meaning_vi = 'tuân thủ, tuân theo',
      example_hanzi = '无论行人还是机动车驾驶员，在城市道路上通行时都必须严格遵守交通信号灯与交通规则。',
      example_pinyin = 'Wúlùn xíngrén háishì jīdòngchē jiàshǐyuán, zài chéngshì dàolù shang tōngxíng shí dōu bìxū yángé zūnshǒu jiāotōng xìnhàodēng yǔ jiāotōng guīzé.',
      example_vi = 'Bất luận người đi bộ hay người điều khiển xe cơ giới, khi lưu thông trên đường bộ thành phố đều phải tuân thủ nghiêm ngặt đèn tín hiệu giao thông và luật lệ giao thông.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '遵守',
      'zūnshǒu',
      'tuân thủ, tuân theo',
      'Động từ',
      'HSK 5',
      '无论行人还是机动车驾驶员，在城市道路上通行时都必须严格遵守交通信号灯与交通规则。',
      'Wúlùn xíngrén háishì jīdòngchē jiàshǐyuán, zài chéngshì dàolù shang tōngxíng shí dōu bìxū yángé zūnshǒu jiāotōng xìnhàodēng yǔ jiāotōng guīzé.',
      'Bất luận người đi bộ hay người điều khiển xe cơ giới, khi lưu thông trên đường bộ thành phố đều phải tuân thủ nghiêm ngặt đèn tín hiệu giao thông và luật lệ giao thông.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论行人还是机动车驾驶员，在城市道路上通行时都必须严格遵守交通信号灯与交通规则。', 'Wúlùn xíngrén háishì jīdòngchē jiàshǐyuán, zài chéngshì dàolù shang tōngxíng shí dōu bìxū yángé zūnshǒu jiāotōng xìnhàodēng yǔ jiāotōng guīzé.', 'Bất luận người đi bộ hay người điều khiển xe cơ giới, khi lưu thông trên đường bộ thành phố đều phải tuân thủ nghiêm ngặt đèn tín hiệu giao thông và luật lệ giao thông.', 'basic', 1),
      (v_id, '涉外民商事仲裁严格要求跨境跨国商事主体必须恪守诚实信用原则并全面遵守国际商业惯例与双边投资协定法定条款。', 'Shèwài mín-shāngshì zhòngcái yángé yāoqiú kuàjìng kuàguó shāngshì zhǔtǐ bìxū kèshǒu chéngshí xìnyòng yuánzé bìng quánmiàn zūnshǒu guójì shāngyè guànlì yǔ shuāngbiān tóuzī xiédìng fǎdìng tiáokuǎn.', 'Trọng tài dân sự thương mại đối ngoại yêu cầu nghiêm ngặt các chủ thể thương mại xuyên biên giới xuyên quốc gia phải nghiêm cẩn tuân thủ nguyên tắc trung thực chữ tín và chấp hành toàn diện các tập quán thương mại quốc tế cùng các điều khoản pháp định của hiệp định đầu tư song phương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3600] [作出] (zuòchū) - đưa ra, làm ra (đóng góp, phán quyết, nỗ lực, quyết định) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '作出' AND pinyin = 'zuòchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '作出' AND pinyin = 'zuòchū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '作出'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '作出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'zuòchū',
      meaning_vi = 'đưa ra, làm ra (đóng góp, phán quyết, nỗ lực, quyết định)',
      example_hanzi = '经过连续几个通宵的论证与权衡，项目委员会终于对新厂区的选址方案作出了最终的审慎决定。',
      example_pinyin = 'Jīngguò liánxù jǐ ge tōngxiāo de lùnzhèng yǔ quánhéng, xiàngmù wěiyuánhuì zhōngyú duì xīn chǎngqū de xuǎnzhǐ fāng''àn zuòchū le zuìzhōng de shěnshèn juédìng.',
      example_vi = 'Trải qua mấy đêm thức trắng liên tục để chứng minh và cân nhắc, ban quản lý dự án rốt cuộc đã đưa ra quyết định thận trọng cuối cùng đối với phương án lựa chọn địa điểm xây dựng khu nhà xưởng mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '作出',
      'zuòchū',
      'đưa ra, làm ra (đóng góp, phán quyết, nỗ lực, quyết định)',
      'Động từ',
      'HSK 5',
      '经过连续几个通宵的论证与权衡，项目委员会终于对新厂区的选址方案作出了最终的审慎决定。',
      'Jīngguò liánxù jǐ ge tōngxiāo de lùnzhèng yǔ quánhéng, xiàngmù wěiyuánhuì zhōngyú duì xīn chǎngqū de xuǎnzhǐ fāng''àn zuòchū le zuìzhōng de shěnshèn juédìng.',
      'Trải qua mấy đêm thức trắng liên tục để chứng minh và cân nhắc, ban quản lý dự án rốt cuộc đã đưa ra quyết định thận trọng cuối cùng đối với phương án lựa chọn địa điểm xây dựng khu nhà xưởng mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过连续几个通宵的论证与权衡，项目委员会终于对新厂区的选址方案作出了最终的审慎决定。', 'Jīngguò liánxù jǐ ge tōngxiāo de lùnzhèng yǔ quánhéng, xiàngmù wěiyuánhuì zhōngyú duì xīn chǎngqū de xuǎnzhǐ fāng''àn zuòchū le zuìzhōng de shěnshèn juédìng.', 'Trải qua mấy đêm thức trắng liên tục để chứng minh và cân nhắc, ban quản lý dự án rốt cuộc đã đưa ra quyết định thận trọng cuối cùng đối với phương án lựa chọn địa điểm xây dựng khu nhà xưởng mới.', 'basic', 1),
      (v_id, '该科研先锋团队凭借在高温超导量子通信与前沿芯片底层架构上的原始理论突破，为人类前沿基础科学的发展作出了不可磨灭的历史性重大贡献。', 'Gāi kēyán xiānfēng tuánduì píngjiè zài gāowēn chāodǎo liàngzǐ tōngxìn yǔ qiányán xīnpiàn dǐcéng jiàgòu shang de yuánshǐ lǐlùn tūpò, wèi rénlèi qiányán jīchǔ kēxué de fāzhǎn zuòchū le bùkě-mómì de lìshǐxìng zhòngdà gòngxiàn.', 'Đội ngũ tiên phong nghiên cứu khoa học đó dựa vào những đột phá lý thuyết nguyên bản về thông tin lượng tử siêu dẫn nhiệt độ cao và kiến trúc tầng đáy chip mũi nhọn, đã đưa ra những cống hiến trọng đại mang tính lịch sử không thể phai mờ cho sự phát triển khoa học cơ bản tiên phong của nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn tất cập nhật HSK 5 - Batch 16 (Final Batch)! Tổng số từ đã xử lý: %', v_count;
END $$;
