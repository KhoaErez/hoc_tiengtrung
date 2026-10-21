-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 4 (100 TỪ TIẾP THEO)
-- Phạm vi: #2302 [短期] (duǎnqī) -> #2401 [个性] (gèxìng)
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
  -- [2302] [短期] (duǎnqī) - ngắn hạn, thời gian ngắn [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '短期' AND pinyin = 'duǎnqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '短期' AND pinyin = 'duǎnqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '短期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '短期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'duǎnqī',
      meaning_vi = 'ngắn hạn, thời gian ngắn',
      example_hanzi = '他在大学期间报名参加了为期一个月的短期法语培训班。',
      example_pinyin = 'Tā zài dàxué qījiān bàomíng cānjiā le wéiqī yí gè yuè de duǎnqī Fǎyǔ péixùnbān.',
      example_vi = 'Trong thời gian học đại học, anh ấy đã đăng ký tham gia một lớp đào tạo tiếng Pháp ngắn hạn kéo dài một tháng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '短期',
      'duǎnqī',
      'ngắn hạn, thời gian ngắn',
      'Danh từ / Tính từ',
      'HSK 5',
      '他在大学期间报名参加了为期一个月的短期法语培训班。',
      'Tā zài dàxué qījiān bàomíng cānjiā le wéiqī yí gè yuè de duǎnqī Fǎyǔ péixùnbān.',
      'Trong thời gian học đại học, anh ấy đã đăng ký tham gia một lớp đào tạo tiếng Pháp ngắn hạn kéo dài một tháng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在大学期间报名参加了为期一个月的短期法语培训班。', 'Tā zài dàxué qījiān bàomíng cānjiā le wéiqī yí gè yuè de duǎnqī Fǎyǔ péixùnbān.', 'Trong thời gian học đại học, anh ấy đã đăng ký tham gia một lớp đào tạo tiếng Pháp ngắn hạn kéo dài một tháng.', 'basic', 1),
      (v_id, '企业在制定战略时不能只顾追求短期利润，更应注重长期品牌价值的积累与科研创新投入。', 'Qǐyè zài zhìdìng zhànlüè shí bù néng zhǐ gù zhuīqiú duǎnqī lìrùn, gèng yīng zhùzhòng chángqī pǐnpái jiàzhí de jīlěi yǔ kēyán chuàngxīn tóurù.', 'Doanh nghiệp khi hoạch định chiến lược không thể chỉ mải mê theo đuổi lợi nhuận ngắn hạn, mà càng cần phải coi trọng việc tích lũy giá trị thương hiệu lâu dài và đầu tư cho đổi mới nghiên cứu khoa học.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2303] [断] (duàn) - đứt, ngắt, cắt đứt, gián đoạn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '断' AND pinyin = 'duàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '断' AND pinyin = 'duàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '断'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '断'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'duàn',
      meaning_vi = 'đứt, ngắt, cắt đứt, gián đoạn',
      example_hanzi = '由于暴风雨的袭击，这根高压电线被大树砸断了。',
      example_pinyin = 'Yóuyú bàofēngyǔ de xíjī, zhè gēn gāoyā diànxiàn bèi dàshù zá duàn le.',
      example_vi = 'Do bị cơn bão tấn công, đường dây điện cao thế này đã bị cây to đè đứt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '断',
      'duàn',
      'đứt, ngắt, cắt đứt, gián đoạn',
      'Động từ',
      'HSK 5',
      '由于暴风雨的袭击，这根高压电线被大树砸断了。',
      'Yóuyú bàofēngyǔ de xíjī, zhè gēn gāoyā diànxiàn bèi dàshù zá duàn le.',
      'Do bị cơn bão tấn công, đường dây điện cao thế này đã bị cây to đè đứt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '由于暴风雨的袭击，这根高压电线被大树砸断了。', 'Yóuyú bàofēngyǔ de xíjī, zhè gēn gāoyā diànxiàn bèi dàshù zá duàn le.', 'Do bị cơn bão tấn công, đường dây điện cao thế này đã bị cây to đè đứt.', 'basic', 1),
      (v_id, '突如其来的地震导致当地交通与通信网络彻底中断，救援队正克服重重困难全力抢通生命通道。', 'Tūrúqílái de dìzhèn dǎozhì dāngdì jiāotōng yǔ tōngxìn wǎngluò chèdǐ zhōngduàn, jiùyuánduì zhèng kèfú chóngchóng kùnnan quánlì qiǎngtōng shēngmìng tōngdào.', 'Trận động đất bất ngờ ập đến khiến mạng lưới giao thông và viễn thông địa phương bị gián đoạn hoàn toàn, đội cứu hộ đang vượt qua muôn vàn khó khăn dốc toàn lực khai thông huyết mạch sự sống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2304] [堆] (duī) - đống, chất đống, đắp (tuyết) [Động từ / Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '堆' AND pinyin = 'duī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '堆' AND pinyin = 'duī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '堆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '堆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ / Lượng từ',
      pinyin = 'duī',
      meaning_vi = 'đống, chất đống, đắp (tuyết)',
      example_hanzi = '冬天下大雪的时候，孩子们最喜欢在院子里堆雪人。',
      example_pinyin = 'Dōngtiān xià dàxuě de shíhou, háizimen zuì xǐhuan zài yuànzi lǐ duī xuěrén.',
      example_vi = 'Vào mùa đông khi tuyết rơi dày, lũ trẻ thích nhất là đắp người tuyết trong sân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '堆',
      'duī',
      'đống, chất đống, đắp (tuyết)',
      'Động từ / Danh từ / Lượng từ',
      'HSK 5',
      '冬天下大雪的时候，孩子们最喜欢在院子里堆雪人。',
      'Dōngtiān xià dàxuě de shíhou, háizimen zuì xǐhuan zài yuànzi lǐ duī xuěrén.',
      'Vào mùa đông khi tuyết rơi dày, lũ trẻ thích nhất là đắp người tuyết trong sân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬天下大雪的时候，孩子们最喜欢在院子里堆雪人。', 'Dōngtiān xià dàxuě de shíhou, háizimen zuì xǐhuan zài yuànzi lǐ duī xuěrén.', 'Vào mùa đông khi tuyết rơi dày, lũ trẻ thích nhất là đắp người tuyết trong sân.', 'basic', 1),
      (v_id, '办公桌上堆满了各部门刚刚递交上来的年度总结报告，等待总经理逐一审核批复。', 'Bàngōngzhuō shàng duī mǎn le gè bùmén gānggāng dìjiāo shànglái de niándù zǒngjié bàogào, děngdài zǒngjīnglǐ zhúyī shěnhè pīfù.', 'Trên bàn làm việc chất đầy các báo cáo tổng kết thường niên do các phòng ban vừa nộp lên, đang chờ tổng giám đốc xem xét duyệt từng bản một.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2305] [对比] (duìbǐ) - so sánh, đối chiếu, sự tương phản [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '对比' AND pinyin = 'duìbǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '对比' AND pinyin = 'duìbǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '对比'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '对比'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'duìbǐ',
      meaning_vi = 'so sánh, đối chiếu, sự tương phản',
      example_hanzi = '把这两份方案放在一起对比，优缺点就一目了然了。',
      example_pinyin = 'Bǎ zhè liǎng fèn fāng’àn fàng zài yìqǐ duìbǐ, yōukuēdiǎn jiù yí mù liǎorán le.',
      example_vi = 'Đặt hai phương án này cùng nhau so sánh đối chiếu thì ưu khuyết điểm sẽ rõ ràng ngay tức khắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '对比',
      'duìbǐ',
      'so sánh, đối chiếu, sự tương phản',
      'Động từ / Danh từ',
      'HSK 5',
      '把这两份方案放在一起对比，优缺点就一目了然了。',
      'Bǎ zhè liǎng fèn fāng’àn fàng zài yìqǐ duìbǐ, yōukuēdiǎn jiù yí mù liǎorán le.',
      'Đặt hai phương án này cùng nhau so sánh đối chiếu thì ưu khuyết điểm sẽ rõ ràng ngay tức khắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '把这两份方案放在一起对比，优缺点就一目了然了。', 'Bǎ zhè liǎng fèn fāng’àn fàng zài yìqǐ duìbǐ, yōukuēdiǎn jiù yí mù liǎorán le.', 'Đặt hai phương án này cùng nhau so sánh đối chiếu thì ưu khuyết điểm sẽ rõ ràng ngay tức khắc.', 'basic', 1),
      (v_id, '经过严谨的数据横向对比与回归分析，研究团队终于找到了导致设备运行故障的核心原因。', 'Jīngguò yǎnjǐn de shùjù héngxiàng duìbǐ yǔ huíguī fēnxī, yánjiū tuánduì zhōngyú zhǎodào le dǎozhì shèbèi yùnxíng gùzhàng de héxīn yuányīn.', 'Qua quá trình đối chiếu ngang dữ liệu và phân tích hồi quy chặt chẽ, nhóm nghiên cứu cuối cùng đã tìm ra nguyên nhân cốt lõi dẫn đến sự cố vận hành của thiết bị.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2306] [对待] (duìdài) - đối xử, đối đãi, nhìn nhận thái độ đối với [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '对待' AND pinyin = 'duìdài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '对待' AND pinyin = 'duìdài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '对待'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '对待'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'duìdài',
      meaning_vi = 'đối xử, đối đãi, nhìn nhận thái độ đối với',
      example_hanzi = '无论面对什么职业的人，我们都应该平等、礼貌地对待。',
      example_pinyin = 'Wúlùn miànduì shénme zhíyè de rén, wǒmen dōu yīnggāi píngděng, lǐmào de duìdài.',
      example_vi = 'Bất luận đối mặt với người làm nghề nghiệp gì, chúng ta đều nên đối xử một cách bình đẳng và lịch sự.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '对待',
      'duìdài',
      'đối xử, đối đãi, nhìn nhận thái độ đối với',
      'Động từ',
      'HSK 5',
      '无论面对什么职业的人，我们都应该平等、礼貌地对待。',
      'Wúlùn miànduì shénme zhíyè de rén, wǒmen dōu yīnggāi píngděng, lǐmào de duìdài.',
      'Bất luận đối mặt với người làm nghề nghiệp gì, chúng ta đều nên đối xử một cách bình đẳng và lịch sự.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论面对什么职业的人，我们都应该平等、礼貌地对待。', 'Wúlùn miànduì shénme zhíyè de rén, wǒmen dōu yīnggāi píngděng, lǐmào de duìdài.', 'Bất luận đối mặt với người làm nghề nghiệp gì, chúng ta đều nên đối xử một cách bình đẳng và lịch sự.', 'basic', 1),
      (v_id, '优秀的科研人员应当以极其严谨务实的科学态度对待每一次实验数据中的微小偏差。', 'Yōuxiù de kēyán rényuán yīngdāng yǐ jíqí yǎnjǐn wùshí de kēxué tàidù duìdài měi yí cì shíyàn shùjù zhōng de wēixiǎo piānchā.', 'Những nhân sự nghiên cứu khoa học xuất sắc cần phải nhìn nhận đối đãi với từng sai số nhỏ nhặt trong số liệu thí nghiệm bằng thái độ khoa học cực kỳ cẩn trọng và thực tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2307] [对手] (duìshǒu) - đối thủ, địch thủ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '对手' AND pinyin = 'duìshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '对手' AND pinyin = 'duìshǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '对手'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '对手'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'duìshǒu',
      meaning_vi = 'đối thủ, địch thủ',
      example_hanzi = '在明天的羽毛球决赛中，他将遭遇实力强劲的老对手。',
      example_pinyin = 'Zài míngtiān de yǔmáoqiú juésài zhōng, tā jiāng zāoyù shílì qiángjìng de lǎo duìshǒu.',
      example_vi = 'Trong trận chung kết cầu lông ngày mai, anh ấy sẽ đụng độ người đối thủ kỳ cựu có thực lực rất đáng gờm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '对手',
      'duìshǒu',
      'đối thủ, địch thủ',
      'Danh từ',
      'HSK 5',
      '在明天的羽毛球决赛中，他将遭遇实力强劲的老对手。',
      'Zài míngtiān de yǔmáoqiú juésài zhōng, tā jiāng zāoyù shílì qiángjìng de lǎo duìshǒu.',
      'Trong trận chung kết cầu lông ngày mai, anh ấy sẽ đụng độ người đối thủ kỳ cựu có thực lực rất đáng gờm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在明天的羽毛球决赛中，他将遭遇实力强劲的老对手。', 'Zài míngtiān de yǔmáoqiú juésài zhōng, tā jiāng zāoyù shílì qiángjìng de lǎo duìshǒu.', 'Trong trận chung kết cầu lông ngày mai, anh ấy sẽ đụng độ người đối thủ kỳ cựu có thực lực rất đáng gờm.', 'basic', 1),
      (v_id, '在竞争日益白热化的全球新能源汽车市场上，尊重对手并持续自我革新是立于不败之地的根本之道。', 'Zài jìngzhēng rìyì báirèhuà de quánqiú xīn néngyuán qìchē shìchǎng shàng, zūnzhòng duìshǒu bìng chíxù zìwǒ géxīn shì lì yú búbàizhīdì de gēnběn zhī dào.', 'Trên thị trường xe năng lượng mới toàn cầu cạnh tranh ngày càng gay gắt, tôn trọng đối thủ và không ngừng tự đổi mới chính là con đường căn bản để đứng vững ở thế bất bại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2308] [队伍] (duìwu) - đội ngũ, hàng ngũ, đoàn người [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '队伍' AND pinyin = 'duìwu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '队伍' AND pinyin = 'duìwu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '队伍'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '队伍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'duìwu',
      meaning_vi = 'đội ngũ, hàng ngũ, đoàn người',
      example_hanzi = '运动会开幕式上，各班级的方阵队伍迈着整齐的步伐走过主席台。',
      example_pinyin = 'Yùndònghuì kāimùshì shàng, gè bānjí de fāngzhèn duìwu màizhe zhěngqí de bùfá zǒuguò zhǔxítái.',
      example_vi = 'Tại lễ khai mạc đại hội thể thao, các đội hình khối của từng lớp bước đi đều tăm tắp qua lễ đài.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '队伍',
      'duìwu',
      'đội ngũ, hàng ngũ, đoàn người',
      'Danh từ',
      'HSK 5',
      '运动会开幕式上，各班级的方阵队伍迈着整齐的步伐走过主席台。',
      'Yùndònghuì kāimùshì shàng, gè bānjí de fāngzhèn duìwu màizhe zhěngqí de bùfá zǒuguò zhǔxítái.',
      'Tại lễ khai mạc đại hội thể thao, các đội hình khối của từng lớp bước đi đều tăm tắp qua lễ đài.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '运动会开幕式上，各班级的方阵队伍迈着整齐的步伐走过主席台。', 'Yùndònghuì kāimùshì shàng, gè bānjí de fāngzhèn duìwu màizhe zhěngqí de bùfá zǒuguò zhǔxítái.', 'Tại lễ khai mạc đại hội thể thao, các đội hình khối của từng lớp bước đi đều tăm tắp qua lễ đài.', 'basic', 1),
      (v_id, '为了迎接数字化转型带来的机遇与挑战，集团决定花大力气建设一支高水平的跨国技术人才队伍。', 'Wèile yíngjiē shùzìhuà zhuǎnxíng dài lái de jīyù yǔ tiǎozhàn, jítuán juédìng huā dà lìqi jiànshè yì zhī gāoshuǐpíng de kuàguó jìshù réncái duìwu.', 'Nhằm đón đầu cơ hội và thách thức do chuyển đổi số mang lại, tập đoàn quyết định bỏ ra nhiều tâm sức để xây dựng một đội ngũ nhân tài công nghệ xuyên quốc gia trình độ cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2309] [对象] (duìxiàng) - đối tượng, người yêu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '对象' AND pinyin = 'duìxiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '对象' AND pinyin = 'duìxiàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '对象'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '对象'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'duìxiàng',
      meaning_vi = 'đối tượng, người yêu',
      example_hanzi = '他工作一直很忙，至今还没有找对象。',
      example_pinyin = 'Tā gōngzuò yìzhí hěn máng, zhìjīn hái méiyǒu zhǎo duìxiàng.',
      example_vi = 'Công việc của anh ấy lúc nào cũng bận rộn, đến nay vẫn chưa tìm đối tượng người yêu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '对象',
      'duìxiàng',
      'đối tượng, người yêu',
      'Danh từ',
      'HSK 5',
      '他工作一直很忙，至今还没有找对象。',
      'Tā gōngzuò yìzhí hěn máng, zhìjīn hái méiyǒu zhǎo duìxiàng.',
      'Công việc của anh ấy lúc nào cũng bận rộn, đến nay vẫn chưa tìm đối tượng người yêu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他工作一直很忙，至今还没有找对象。', 'Tā gōngzuò yìzhí hěn máng, zhìjīn hái méiyǒu zhǎo duìxiàng.', 'Công việc của anh ấy lúc nào cũng bận rộn, đến nay vẫn chưa tìm đối tượng người yêu.', 'basic', 1),
      (v_id, '本次问卷调查的主要研究对象是在一线城市自主创业的青年群体。', 'Běn cì wènjuàn diàochá de zhǔyào yánjiū duìxiàng shì zài yīxiàn chéngshì zìzhǔ chuàngyè de qīngnián qúntǐ.', 'Đối tượng nghiên cứu chính của cuộc khảo sát bảng hỏi lần này là nhóm thanh niên tự thân khởi nghiệp tại các thành phố hạng nhất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2310] [吨] (dūn) - tấn (đơn vị đo khối lượng) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '吨' AND pinyin = 'dūn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '吨' AND pinyin = 'dūn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '吨'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '吨'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ',
      pinyin = 'dūn',
      meaning_vi = 'tấn (đơn vị đo khối lượng)',
      example_hanzi = '这辆重型卡车的最大荷载量是三十吨。',
      example_pinyin = 'Zhè liàng zhòngxíng kǎchē de zuìdà hèzǎiliàng shì sānshí dūn.',
      example_vi = 'Tải trọng tối đa của chiếc xe tải hạng nặng này là ba mươi tấn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '吨',
      'dūn',
      'tấn (đơn vị đo khối lượng)',
      'Lượng từ',
      'HSK 5',
      '这辆重型卡车的最大荷载量是三十吨。',
      'Zhè liàng zhòngxíng kǎchē de zuìdà hèzǎiliàng shì sānshí dūn.',
      'Tải trọng tối đa của chiếc xe tải hạng nặng này là ba mươi tấn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这辆重型卡车的最大荷载量是三十吨。', 'Zhè liàng zhòngxíng kǎchē de zuìdà hèzǎiliàng shì sānshí dūn.', 'Tải trọng tối đa của chiếc xe tải hạng nặng này là ba mươi tấn.', 'basic', 1),
      (v_id, '该钢铁集团今年通过节能减排技术改造，年节约标煤达数十万吨，大幅降低了碳排放总量。', 'Gāi gāngtiě jítuán jīnnián tōngguò jiénéng jiǎnpái jìshù gǎizào, nián jiéyuē biāoméi dá shù shí wàn dūn, dàfú jiàngdī le tàn páifàng zǒngliàng.', 'Tập đoàn gang thép này năm nay thông qua cải tạo kỹ thuật tiết kiệm năng lượng giảm phát thải, đã tiết kiệm được hàng trăm nghìn tấn than tiêu chuẩn mỗi năm, giảm mạnh tổng lượng phát thải carbon.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2311] [朵] (duǒ) - đóa, bông, đám (mây) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '朵' AND pinyin = 'duǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '朵' AND pinyin = 'duǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '朵'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '朵'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ',
      pinyin = 'duǒ',
      meaning_vi = 'đóa, bông, đám (mây)',
      example_hanzi = '蓝蓝的天空上飘着几朵洁白的白云，景色美极了。',
      example_pinyin = 'Lánlán de tiānkōng shàng piāo zhe jǐ duǒ jiébái de báiyún, jǐngsè měi jí le.',
      example_vi = 'Trên bầu trời trong xanh lơ lửng vài đám mây trắng tinh khôi, phong cảnh đẹp tuyệt trần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '朵',
      'duǒ',
      'đóa, bông, đám (mây)',
      'Lượng từ',
      'HSK 5',
      '蓝蓝的天空上飘着几朵洁白的白云，景色美极了。',
      'Lánlán de tiānkōng shàng piāo zhe jǐ duǒ jiébái de báiyún, jǐngsè měi jí le.',
      'Trên bầu trời trong xanh lơ lửng vài đám mây trắng tinh khôi, phong cảnh đẹp tuyệt trần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '蓝蓝的天空上飘着几朵洁白的白云，景色美极了。', 'Lánlán de tiānkōng shàng piāo zhe jǐ duǒ jiébái de báiyún, jǐngsè měi jí le.', 'Trên bầu trời trong xanh lơ lửng vài đám mây trắng tinh khôi, phong cảnh đẹp tuyệt trần.', 'basic', 1),
      (v_id, '在毕业典礼上，学生代表手捧一朵朵盛开的鲜花，恭敬地献给辛勤耕耘的恩师们。', 'Zài bìyè diǎnlǐ shàng, xuésheng dàibiǎo shǒu pěng yì duǒ duǒ shèngkāi de xiānhuā, gōngjìng de xiàn gěi xīnqín gēngyún de ēnshī men.', 'Tại lễ tốt nghiệp, các đại diện học sinh hai tay nâng từng đóa hoa tươi nở rộ, cung kính dâng tặng những người thầy cô ơn sâu đã miệt mài gieo mầm tri thức.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2312] [躲] (duǒ) - trốn, né tránh, ẩn náu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '躲' AND pinyin = 'duǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '躲' AND pinyin = 'duǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '躲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '躲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'duǒ',
      meaning_vi = 'trốn, né tránh, ẩn náu',
      example_hanzi = '突然下起了倾盆大雨，路上的行人们纷纷跑进商店屋檐下躲雨。',
      example_pinyin = 'Tūrán xià qǐ le qīngpén dàyǔ, lù shàng de xíngrénmen fēnfēn pǎo jìn shāngdiàn wūyán xià duǒ yǔ.',
      example_vi = 'Bất chợt đổ mưa rào như trút nước, người đi bộ trên đường tới tấp chạy vào dưới mái hiên cửa hàng để trú mưa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '躲',
      'duǒ',
      'trốn, né tránh, ẩn náu',
      'Động từ',
      'HSK 5',
      '突然下起了倾盆大雨，路上的行人们纷纷跑进商店屋檐下躲雨。',
      'Tūrán xià qǐ le qīngpén dàyǔ, lù shàng de xíngrénmen fēnfēn pǎo jìn shāngdiàn wūyán xià duǒ yǔ.',
      'Bất chợt đổ mưa rào như trút nước, người đi bộ trên đường tới tấp chạy vào dưới mái hiên cửa hàng để trú mưa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '突然下起了倾盆大雨，路上的行人们纷纷跑进商店屋檐下躲雨。', 'Tūrán xià qǐ le qīngpén dàyǔ, lù shàng de xíngrénmen fēnfēn pǎo jìn shāngdiàn wūyán xià duǒ yǔ.', 'Bất chợt đổ mưa rào như trút nước, người đi bộ trên đường tới tấp chạy vào dưới mái hiên cửa hàng để trú mưa.', 'basic', 1),
      (v_id, '面对工作中的失误与责任，成熟的职场人应该勇于承担并提出解决方案，而不是一味地逃避和躲藏。', 'Miànduì gōngzuò zhōng de shīwù yǔ zérèn, chéngshú de zhíchǎngrén yīnggāi yǒngyú chéngdān bìng tíchū jiějué fāng’àn, ér búshì yíwèi de táobì hé duǒcáng.', 'Khi đối mặt với sai sót và trách nhiệm trong công việc, người đi làm chín chắn nên dũng cảm gánh vác và đưa ra phương án giải quyết, chứ không phải một mực trốn tránh và lẩn trốn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2313] [儿女] (érnǚ) - con cái, con trai con gái [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '儿女' AND pinyin = 'érnǚ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '儿女' AND pinyin = 'érnǚ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '儿女'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '儿女'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'érnǚ',
      meaning_vi = 'con cái, con trai con gái',
      example_hanzi = '父母含辛茹苦一辈子，最大的心愿就是看着儿女健康平安。',
      example_pinyin = 'Fùmǔ hánxīnrǔkǔ yíbèizi, zuì dà de xīnyuàn jiù shì kàn zhe érnǚ jiànkāng píng’ān.',
      example_vi = 'Cha mẹ ngậm đắng nuốt cay cả một đời, tâm nguyện lớn nhất chính là nhìn con cái khỏe mạnh bình an.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '儿女',
      'érnǚ',
      'con cái, con trai con gái',
      'Danh từ',
      'HSK 5',
      '父母含辛茹苦一辈子，最大的心愿就是看着儿女健康平安。',
      'Fùmǔ hánxīnrǔkǔ yíbèizi, zuì dà de xīnyuàn jiù shì kàn zhe érnǚ jiànkāng píng’ān.',
      'Cha mẹ ngậm đắng nuốt cay cả một đời, tâm nguyện lớn nhất chính là nhìn con cái khỏe mạnh bình an.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '父母含辛茹苦一辈子，最大的心愿就是看着儿女健康平安。', 'Fùmǔ hánxīnrǔkǔ yíbèizi, zuì dà de xīnyuàn jiù shì kàn zhe érnǚ jiànkāng píng’ān.', 'Cha mẹ ngậm đắng nuốt cay cả một đời, tâm nguyện lớn nhất chính là nhìn con cái khỏe mạnh bình an.', 'basic', 1),
      (v_id, '中华儿女在面对外来挑战与自然灾害时，总能万众一心、众志成城，展现出无比坚韧的民族凝聚力。', 'Zhōnghuá érnǚ zài miànduì wàilái tiǎozhàn yǔ zìrán zāihài shí, zǒng néng wànzhòngyīxīn, zhòngzhìchéngchéng, zhǎnxiàn chū wúbǐ jiānrèn de mínzú níngjùlì.', 'Những người con đất nước khi đối mặt với thách thức từ bên ngoài và thiên tai địch họa, luôn có thể muôn người như một, triệu người đồng lòng, thể hiện sức mạnh gắn kết dân tộc kiên cường khôn xiết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2314] [二手] (èrshǒu) - cũ, qua tay, đồ đã qua sử dụng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '二手' AND pinyin = 'èrshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '二手' AND pinyin = 'èrshǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '二手'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '二手'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'èrshǒu',
      meaning_vi = 'cũ, qua tay, đồ đã qua sử dụng',
      example_hanzi = '为了省钱，他在二手交易平台上买了一辆成色不错的山地自行车。',
      example_pinyin = 'Wèile shěngqián, tā zài èrshǒu jiāoyì píngtái shàng mǎi le yí liàng chéngsè búcuò de shāndì zìxíngchē.',
      example_vi = 'Để tiết kiệm tiền, anh ấy đã mua một chiếc xe đạp leo núi còn khá mới trên nền tảng giao dịch đồ cũ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '二手',
      'èrshǒu',
      'cũ, qua tay, đồ đã qua sử dụng',
      'Tính từ',
      'HSK 5',
      '为了省钱，他在二手交易平台上买了一辆成色不错的山地自行车。',
      'Wèile shěngqián, tā zài èrshǒu jiāoyì píngtái shàng mǎi le yí liàng chéngsè búcuò de shāndì zìxíngchē.',
      'Để tiết kiệm tiền, anh ấy đã mua một chiếc xe đạp leo núi còn khá mới trên nền tảng giao dịch đồ cũ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了省钱，他在二手交易平台上买了一辆成色不错的山地自行车。', 'Wèile shěngqián, tā zài èrshǒu jiāoyì píngtái shàng mǎi le yí liàng chéngsè búcuò de shāndì zìxíngchē.', 'Để tiết kiệm tiền, anh ấy đã mua một chiếc xe đạp leo núi còn khá mới trên nền tảng giao dịch đồ cũ.', 'basic', 1),
      (v_id, '二手车电商平台通过引入第三方专业机构的严格检测机制，有效解决了买卖双方之间的信息不对称难题。', 'Èrshǒuchē diànshāng píngtái tōngguò yǐnrù dì-sān fāng zhuānyè jīgòu de yángé jiǎncè jīzhì, yǒuxiào jiějué le mǎimài shuāngfāng zhījiān de xìnxī bú duìchèn nántí.', 'Sàn thương mại điện tử xe ô tô cũ thông qua việc đưa vào cơ chế kiểm định nghiêm ngặt từ cơ quan chuyên môn bên thứ ba, đã giải quyết hiệu quả bài toán bất cân xứng thông tin giữa hai bên mua bán.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2315] [二维码] (èrwéimǎ) - mã QR, mã hai chiều [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '二维码' AND pinyin = 'èrwéimǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '二维码' AND pinyin = 'èrwéimǎ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '二维码'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '二维码'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'èrwéimǎ',
      meaning_vi = 'mã QR, mã hai chiều',
      example_hanzi = '请您打开手机微信扫描收银台上的二维码完成付款。',
      example_pinyin = 'Qǐng nín dǎkāi shǒujī Wēixìn sǎomiáo shōuyíntái shàng de èrwéimǎ wánchéng fùkuǎn.',
      example_vi = 'Xin mời quý khách mở WeChat trên điện thoại quét mã QR trên quầy thu ngân để hoàn tất thanh toán.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '二维码',
      'èrwéimǎ',
      'mã QR, mã hai chiều',
      'Danh từ',
      'HSK 5',
      '请您打开手机微信扫描收银台上的二维码完成付款。',
      'Qǐng nín dǎkāi shǒujī Wēixìn sǎomiáo shōuyíntái shàng de èrwéimǎ wánchéng fùkuǎn.',
      'Xin mời quý khách mở WeChat trên điện thoại quét mã QR trên quầy thu ngân để hoàn tất thanh toán.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请您打开手机微信扫描收银台上的二维码完成付款。', 'Qǐng nín dǎkāi shǒujī Wēixìn sǎomiáo shōuyíntái shàng de èrwéimǎ wánchéng fùkuǎn.', 'Xin mời quý khách mở WeChat trên điện thoại quét mã QR trên quầy thu ngân để hoàn tất thanh toán.', 'basic', 1),
      (v_id, '随着移动互联技术的普及，动态加密二维码在身份认证、电子门禁以及跨境移动支付等场景中得到了广泛应用。', 'Suízhe yídòng hùlián jìshù de pǔjí, dòngtài jiāmì èrwéimǎ zài shēnfèn rènzhèng, diànzǐ ménjìn yǐjí kuàjìng yídòng zhìfù děng chǎngjǐng zhōng dédào le guǎngfàn yìngyòng.', 'Cùng với sự phổ cập của công nghệ Internet di động, mã QR mã hóa động đã được ứng dụng rộng rãi trong các bối cảnh xác thực danh tính, kiểm soát cửa điện tử cũng như thanh toán di động xuyên biên giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2316] [发表] (fābiǎo) - phát biểu, công bố, đăng bài [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '发表' AND pinyin = 'fābiǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发表' AND pinyin = 'fābiǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '发表'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发表'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fābiǎo',
      meaning_vi = 'phát biểu, công bố, đăng bài',
      example_hanzi = '校长在毕业典礼上发表了热情洋溢的讲话，激励毕业生勇往直前。',
      example_pinyin = 'Xiàozhǎng zài bìyè diǎnlǐ shàng fābiǎo le rèqíng yángyì de jiǎnghuà, jīlì bìyèshēng yǒngwǎngzhíqián.',
      example_vi = 'Hiệu trưởng đã có bài phát biểu tràn đầy nhiệt huyết tại lễ tốt nghiệp, khích lệ các sinh viên tốt nghiệp dũng cảm tiến về phía trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '发表',
      'fābiǎo',
      'phát biểu, công bố, đăng bài',
      'Động từ',
      'HSK 5',
      '校长在毕业典礼上发表了热情洋溢的讲话，激励毕业生勇往直前。',
      'Xiàozhǎng zài bìyè diǎnlǐ shàng fābiǎo le rèqíng yángyì de jiǎnghuà, jīlì bìyèshēng yǒngwǎngzhíqián.',
      'Hiệu trưởng đã có bài phát biểu tràn đầy nhiệt huyết tại lễ tốt nghiệp, khích lệ các sinh viên tốt nghiệp dũng cảm tiến về phía trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '校长在毕业典礼上发表了热情洋溢的讲话，激励毕业生勇往直前。', 'Xiàozhǎng zài bìyè diǎnlǐ shàng fābiǎo le rèqíng yángyì de jiǎnghuà, jīlì bìyèshēng yǒngwǎngzhíqián.', 'Hiệu trưởng đã có bài phát biểu tràn đầy nhiệt huyết tại lễ tốt nghiệp, khích lệ các sinh viên tốt nghiệp dũng cảm tiến về phía trước.', 'basic', 1),
      (v_id, '该科研团队关于新型高效太阳能电池的研究成果已在国际顶级学术期刊上正式发表。', 'Gāi kēyán tuánduì guānyú xīnxíng gāoxiào tàiyángnéng diànchí de yánjiū chéngguǒ yǐ zài guójì dǐngjí xuéshù qīkān shàng zhèngshì fābiǎo.', 'Thành quả nghiên cứu về pin năng lượng mặt trời hiệu suất cao kiểu mới của nhóm nghiên cứu khoa học này đã chính thức được đăng tải trên tạp chí học thuật hàng đầu thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2317] [发布] (fābù) - phát hành, công bố (tin tức, sản phẩm, thông báo) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '发布' AND pinyin = 'fābù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发布' AND pinyin = 'fābù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '发布'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发布'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fābù',
      meaning_vi = 'phát hành, công bố (tin tức, sản phẩm, thông báo)',
      example_hanzi = '气象台刚刚发布了暴雨黄色预警信号，提醒市民出行注意安全。',
      example_pinyin = 'Qìxiàngtái gānggāng fābù le bàoyǔ huángsè yùjǐng xìnhào, tíxǐng shìmín chūxíng zhùyì ānquán.',
      example_vi = 'Đài khí tượng vừa mới phát đi tín hiệu cảnh báo mưa bão màu vàng, nhắc nhở người dân ra đường chú ý an toàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '发布',
      'fābù',
      'phát hành, công bố (tin tức, sản phẩm, thông báo)',
      'Động từ',
      'HSK 5',
      '气象台刚刚发布了暴雨黄色预警信号，提醒市民出行注意安全。',
      'Qìxiàngtái gānggāng fābù le bàoyǔ huángsè yùjǐng xìnhào, tíxǐng shìmín chūxíng zhùyì ānquán.',
      'Đài khí tượng vừa mới phát đi tín hiệu cảnh báo mưa bão màu vàng, nhắc nhở người dân ra đường chú ý an toàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '气象台刚刚发布了暴雨黄色预警信号，提醒市民出行注意安全。', 'Qìxiàngtái gānggāng fābù le bàoyǔ huángsè yùjǐng xìnhào, tíxǐng shìmín chūxíng zhùyì ānquán.', 'Đài khí tượng vừa mới phát đi tín hiệu cảnh báo mưa bão màu vàng, nhắc nhở người dân ra đường chú ý an toàn.', 'basic', 1),
      (v_id, '在今晚举行的新品全球发布会上，该科技巨头正式对外发布了搭载最新自主研发人工智能芯片的旗舰手机。', 'Zài jīnwǎn jǔxíng de xīnpǐn quánqiú fābùhuì shàng, gāi kējì jùtóu zhèngshì duìwài fābù le dāzǎi zuìxīn zìzhǔ yánfā réngōng zhìnéng xīanpiàn de qíjiàn shǒujī.', 'Tại buổi lễ ra mắt sản phẩm mới toàn cầu tổ chức tối nay, gã khổng lồ công nghệ này đã chính thức công bố chiếc điện thoại flagship trang bị chip trí tuệ nhân tạo mới nhất do chính họ tự nghiên cứu phát triển.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2318] [发达] (fādá) - phát triển, phát đạt, hưng thịnh [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '发达' AND pinyin = 'fādá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发达' AND pinyin = 'fādá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '发达'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发达'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'fādá',
      meaning_vi = 'phát triển, phát đạt, hưng thịnh',
      example_hanzi = '沿海城市由于地理位置优越，交通网络和对外贸易都非常发达。',
      example_pinyin = 'Yánhǎi chéngshì yóuyú dìlǐ wèizhì yōuyuè, jiāotōng wǎngluò hé duìwài màoyì dōu fēicháng fādá.',
      example_vi = 'Các thành phố ven biển nhờ vị trí địa lý đắc địa nên mạng lưới giao thông và ngoại thương đều hết sức phát triển.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '发达',
      'fādá',
      'phát triển, phát đạt, hưng thịnh',
      'Tính từ / Động từ',
      'HSK 5',
      '沿海城市由于地理位置优越，交通网络和对外贸易都非常发达。',
      'Yánhǎi chéngshì yóuyú dìlǐ wèizhì yōuyuè, jiāotōng wǎngluò hé duìwài màoyì dōu fēicháng fādá.',
      'Các thành phố ven biển nhờ vị trí địa lý đắc địa nên mạng lưới giao thông và ngoại thương đều hết sức phát triển.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '沿海城市由于地理位置优越，交通网络和对外贸易都非常发达。', 'Yánhǎi chéngshì yóuyú dìlǐ wèizhì yōuyuè, jiāotōng wǎngluò hé duìwài màoyì dōu fēicháng fādá.', 'Các thành phố ven biển nhờ vị trí địa lý đắc địa nên mạng lưới giao thông và ngoại thương đều hết sức phát triển.', 'basic', 1),
      (v_id, '凭借高度发达的高端制造业产业链与雄厚的科研实力，该工业园区已成为全国重要的现代创新高地。', 'Píngjiè gāodù fādá de gāoduān zhìzàoyè chǎnyèliàn yǔ xiónghòu de kēyán shílì, gāi gōngyè yuánqū yǐ chéngwéi quánguó zhòngyào de xiàndài chuàngxīn gāodì.', 'Nhờ chuỗi công nghiệp chế tạo cao cấp phát triển tột bậc cùng tiềm lực nghiên cứu khoa học hùng hậu, khu công nghiệp này đã trở thành vùng đất trọng điểm đổi mới sáng tạo hiện đại quan trọng của cả nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2319] [发挥] (fāhuī) - phát huy, vận dụng tối đa [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '发挥' AND pinyin = 'fāhuī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发挥' AND pinyin = 'fāhuī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '发挥'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发挥'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fāhuī',
      meaning_vi = 'phát huy, vận dụng tối đa',
      example_hanzi = '在明天的比赛中，只要大家发挥出平时的正常训练水平就能取得好成绩。',
      example_pinyin = 'Zài míngtiān de bǐsài zhōng, zhǐyào dàjiā fāhuī chū píngshí de zhèngcháng xùnliàn shuǐpíng jiù néng qǔdé hǎo chéngjì.',
      example_vi = 'Trong trận đấu ngày mai, chỉ cần mọi người phát huy được đúng trình độ rèn luyện bình thường là có thể đạt thành tích tốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '发挥',
      'fāhuī',
      'phát huy, vận dụng tối đa',
      'Động từ',
      'HSK 5',
      '在明天的比赛中，只要大家发挥出平时的正常训练水平就能取得好成绩。',
      'Zài míngtiān de bǐsài zhōng, zhǐyào dàjiā fāhuī chū píngshí de zhèngcháng xùnliàn shuǐpíng jiù néng qǔdé hǎo chéngjì.',
      'Trong trận đấu ngày mai, chỉ cần mọi người phát huy được đúng trình độ rèn luyện bình thường là có thể đạt thành tích tốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在明天的比赛中，只要大家发挥出平时的正常训练水平就能取得好成绩。', 'Zài míngtiān de bǐsài zhōng, zhǐyào dàjiā fāhuī chū píngshí de zhèngcháng xùnliàn shuǐpíng jiù néng qǔdé hǎo chéngjì.', 'Trong trận đấu ngày mai, chỉ cần mọi người phát huy được đúng trình độ rèn luyện bình thường là có thể đạt thành tích tốt.', 'basic', 1),
      (v_id, '团队管理者要善于发现每位员工的独特优势，创造良好环境以充分发挥团队成员的创新潜能。', 'Tuánduì guǎnlǐzhě yào shànyú fāxiàn měi wèi yuángōng de dútè yōushì, chuàngzào liánghǎo huánjìng yǐ chōngfèn fāhuī tuánduì chéngyuán de chuàngxīn qiánnéng.', 'Người quản lý đội ngũ cần phải biết cách nhìn ra ưu thế độc đáo của từng nhân viên, tạo dựng môi trường thuận lợi nhằm phát huy trọn vẹn tiềm năng đổi mới sáng tạo của các thành viên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2320] [发明] (fāmíng) - phát minh, sáng chế [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '发明' AND pinyin = 'fāmíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发明' AND pinyin = 'fāmíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '发明'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发明'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'fāmíng',
      meaning_vi = 'phát minh, sáng chế',
      example_hanzi = '造纸术是中国古代四大发明之一，对人类文明产生了深远影响。',
      example_pinyin = 'Zàozhǐshù shì Zhōngguó gǔdài sì dà fāmíng zhī yī, duì rénlèi wénmíng chǎnshēng le shēnyuǎn yǐngxiǎng.',
      example_vi = 'Nghệ thuật làm giấy là một trong bốn phát minh lớn thời cổ đại của Trung Quốc, đã tạo ra ảnh hưởng sâu xa đối với nền văn minh nhân loại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '发明',
      'fāmíng',
      'phát minh, sáng chế',
      'Động từ / Danh từ',
      'HSK 5',
      '造纸术是中国古代四大发明之一，对人类文明产生了深远影响。',
      'Zàozhǐshù shì Zhōngguó gǔdài sì dà fāmíng zhī yī, duì rénlèi wénmíng chǎnshēng le shēnyuǎn yǐngxiǎng.',
      'Nghệ thuật làm giấy là một trong bốn phát minh lớn thời cổ đại của Trung Quốc, đã tạo ra ảnh hưởng sâu xa đối với nền văn minh nhân loại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '造纸术是中国古代四大发明之一，对人类文明产生了深远影响。', 'Zàozhǐshù shì Zhōngguó gǔdài sì dà fāmíng zhī yī, duì rénlèi wénmíng chǎnshēng le shēnyuǎn yǐngxiǎng.', 'Nghệ thuật làm giấy là một trong bốn phát minh lớn thời cổ đại của Trung Quốc, đã tạo ra ảnh hưởng sâu xa đối với nền văn minh nhân loại.', 'basic', 1),
      (v_id, '该科研团队历时五年发明的新型环保降解材料，已成功申请国家发明专利并投入规模化产业量产。', 'Gāi kēyán tuánduì lìshí wǔ nián fāmíng de xīnxíng huánbǎo jiàngjiě cáiliào, yǐ chénggōng shēnqǐng guójiā fāmíng zhuānlì bìng tóurù guīmóhuà chǎnyè liàngchǎn.', 'Vật liệu tự phân hủy thân thiện môi trường kiểu mới do nhóm nghiên cứu phát minh sau 5 năm đã được cấp bằng sáng chế phát minh cấp quốc gia và đưa vào sản xuất hàng loạt quy mô công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2321] [发起] (fāqǐ) - phát động, khởi xướng, đứng ra tổ chức [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '发起' AND pinyin = 'fāqǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发起' AND pinyin = 'fāqǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '发起'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发起'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fāqǐ',
      meaning_vi = 'phát động, khởi xướng, đứng ra tổ chức',
      example_hanzi = '学生会向全校师生发起了一次为贫困山区小学捐赠图书的爱心倡议。',
      example_pinyin = 'Xuéshēnghuì xiàng quán xiào shīshēng fāqǐ le yí cì wèi pínkùn shānqū xiǎoxué juānzèng túshū de àixīn chàngyì.',
      example_vi = 'Hội sinh viên đã phát động tới toàn thể giáo viên và học sinh toàn trường một sáng kiến nhân ái quyên góp sách cho trường tiểu học vùng núi nghèo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '发起',
      'fāqǐ',
      'phát động, khởi xướng, đứng ra tổ chức',
      'Động từ',
      'HSK 5',
      '学生会向全校师生发起了一次为贫困山区小学捐赠图书的爱心倡议。',
      'Xuéshēnghuì xiàng quán xiào shīshēng fāqǐ le yí cì wèi pínkùn shānqū xiǎoxué juānzèng túshū de àixīn chàngyì.',
      'Hội sinh viên đã phát động tới toàn thể giáo viên và học sinh toàn trường một sáng kiến nhân ái quyên góp sách cho trường tiểu học vùng núi nghèo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学生会向全校师生发起了一次为贫困山区小学捐赠图书的爱心倡议。', 'Xuéshēnghuì xiàng quán xiào shīshēng fāqǐ le yí cì wèi pínkùn shānqū xiǎoxué juānzèng túshū de àixīn chàngyì.', 'Hội sinh viên đã phát động tới toàn thể giáo viên và học sinh toàn trường một sáng kiến nhân ái quyên góp sách cho trường tiểu học vùng núi nghèo.', 'basic', 1),
      (v_id, '由多家行业领军企业联合发起成立的绿色低碳产业联盟，旨在共同制定国际领先的可持续发展行业标准。', 'Yóu duō jiā hángyè lǐngjūn qǐyè liánhé fāqǐ chénglì de lǜsè dītàn chǎnyè liánméng, zhǐ zài gòngtóng zhìdìng guójì lǐngxiān de kěchíxù fāzhǎn hángyè biāozhǔn.', 'Liên minh ngành công nghiệp carbon thấp xanh do nhiều doanh nghiệp dẫn đầu trong ngành phối hợp khởi xướng thành lập, hướng tới mục tiêu cùng nhau xây dựng các tiêu chuẩn ngành phát triển bền vững đi đầu quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2322] [发言] (fāyán) - phát biểu ý kiến, lời phát biểu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '发言' AND pinyin = 'fāyán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发言' AND pinyin = 'fāyán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '发言'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发言'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'fāyán',
      meaning_vi = 'phát biểu ý kiến, lời phát biểu',
      example_hanzi = '如果在课堂讨论中有不同意见，欢迎大家积极举手发言。',
      example_pinyin = 'Rúguǒ zài kètáng tǎolùn zhōng yǒu bùtóng yìjiàn, huānyíng dàjiā jījí jǔshǒu fāyán.',
      example_vi = 'Nếu trong buổi thảo luận trên lớp có ý kiến bất đồng, hoan nghênh mọi người tích cực giơ tay phát biểu ý kiến.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '发言',
      'fāyán',
      'phát biểu ý kiến, lời phát biểu',
      'Động từ / Danh từ',
      'HSK 5',
      '如果在课堂讨论中有不同意见，欢迎大家积极举手发言。',
      'Rúguǒ zài kètáng tǎolùn zhōng yǒu bùtóng yìjiàn, huānyíng dàjiā jījí jǔshǒu fāyán.',
      'Nếu trong buổi thảo luận trên lớp có ý kiến bất đồng, hoan nghênh mọi người tích cực giơ tay phát biểu ý kiến.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果在课堂讨论中有不同意见，欢迎大家积极举手发言。', 'Rúguǒ zài kètáng tǎolùn zhōng yǒu bùtóng yìjiàn, huānyíng dàjiā jījí jǔshǒu fāyán.', 'Nếu trong buổi thảo luận trên lớp có ý kiến bất đồng, hoan nghênh mọi người tích cực giơ tay phát biểu ý kiến.', 'basic', 1),
      (v_id, '外交部新闻发言人在例行记者会上严正阐明了中方的基本立场，并就热点国际事务回答了各国记者的提问。', 'Wàijiāobù xīnwén fāyánrén zài lìxíng jìzhěhuì shàng yánzhèng chǎnmíng le Zhōngfāng de jīběn lìchǎng, bìng jiù rèdiǎn guójì shìwù huídá le gè guó jìzhě de tíwèn.', 'Người phát ngôn bộ ngoại giao tại buổi họp báo thường kỳ đã nêu rõ lập trường cơ bản nghiêm minh của phía Trung Quốc và trả lời câu hỏi của các phóng viên quốc tế về các vấn đề thời sự thế giới nóng bỏng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2323] [发音] (fāyīn) - phát âm, cách đọc âm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '发音' AND pinyin = 'fāyīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发音' AND pinyin = 'fāyīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '发音'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '发音'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'fāyīn',
      meaning_vi = 'phát âm, cách đọc âm',
      example_hanzi = '每天坚持跟着录音大声朗读，能够有效纠正外语的发音。',
      example_pinyin = 'Měitiān jiānchí gēn zhe lùyīn dàshēng lǎngdú, nénggòu yǒuxiào jiūzhèng wàiyǔ de fāyīn.',
      example_vi = 'Mỗi ngày kiên trì đọc to theo băng ghi âm có thể sửa phát âm ngoại ngữ một cách hiệu quả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '发音',
      'fāyīn',
      'phát âm, cách đọc âm',
      'Động từ / Danh từ',
      'HSK 5',
      '每天坚持跟着录音大声朗读，能够有效纠正外语的发音。',
      'Měitiān jiānchí gēn zhe lùyīn dàshēng lǎngdú, nénggòu yǒuxiào jiūzhèng wàiyǔ de fāyīn.',
      'Mỗi ngày kiên trì đọc to theo băng ghi âm có thể sửa phát âm ngoại ngữ một cách hiệu quả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天坚持跟着录音大声朗读，能够有效纠正外语的发音。', 'Měitiān jiānchí gēn zhe lùyīn dàshēng lǎngdú, nénggòu yǒuxiào jiūzhèng wàiyǔ de fāyīn.', 'Mỗi ngày kiên trì đọc to theo băng ghi âm có thể sửa phát âm ngoại ngữ một cách hiệu quả.', 'basic', 1),
      (v_id, '该语音评测系统利用深度神经网络算法，能够精准识别学习者在声调与元音发音细节上的细微偏差并给予专业指导。', 'Gāi yǔyīn píngcè xìtǒng lìyòng shēndù shénjīng wǎngluò suànfǎ, nénggòu jīngzhǔn shíbié xuéxízhě zài shēngdiào yǔ yuányīn fāyīn xìjié shàng de xìwēi piānchā bìng jǐyǔ zhuānyè zhǐdǎo.', 'Hệ thống đánh giá giọng nói này áp dụng thuật toán mạng nơ-ron sâu, có khả năng nhận diện chuẩn xác những độ lệch tinh vi trong chi tiết phát âm thanh điệu và nguyên âm của người học và đưa ra hướng dẫn chuyên nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2324] [罚] (fá) - phạt, trừng phạt, xử phạt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '罚' AND pinyin = 'fá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '罚' AND pinyin = 'fá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '罚'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '罚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fá',
      meaning_vi = 'phạt, trừng phạt, xử phạt',
      example_hanzi = '司机如果酒后驾驶机动车，必将受到交通法规的严厉处罚。',
      example_pinyin = 'Sījī rúguǒ jiǔhòu jiàshǐ jīdòngchē, bì jiāng shòudào jiāotōng fǎguī de yánlì chǔfá.',
      example_vi = 'Tài xế nếu lái xe cơ giới sau khi uống rượu bia thì chắc chắn sẽ bị pháp luật an toàn giao thông xử phạt nghiêm khắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '罚',
      'fá',
      'phạt, trừng phạt, xử phạt',
      'Động từ',
      'HSK 5',
      '司机如果酒后驾驶机动车，必将受到交通法规的严厉处罚。',
      'Sījī rúguǒ jiǔhòu jiàshǐ jīdòngchē, bì jiāng shòudào jiāotōng fǎguī de yánlì chǔfá.',
      'Tài xế nếu lái xe cơ giới sau khi uống rượu bia thì chắc chắn sẽ bị pháp luật an toàn giao thông xử phạt nghiêm khắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '司机如果酒后驾驶机动车，必将受到交通法规的严厉处罚。', 'Sījī rúguǒ jiǔhòu jiàshǐ jīdòngchē, bì jiāng shòudào jiāotōng fǎguī de yánlì chǔfá.', 'Tài xế nếu lái xe cơ giới sau khi uống rượu bia thì chắc chắn sẽ bị pháp luật an toàn giao thông xử phạt nghiêm khắc.', 'basic', 1),
      (v_id, '监管机构对于任何从事内幕交易、操纵证券市场的违法犯罪行为，都将依法从严查处、顶格重罚。', 'Jiānguǎn jīgòu duìyú rènhé cóngshì nèimù jiāoyì, cāozòng zhèngquàn shìchǎng de wéifǎ fànzuì xíngwéi, dōu jiāng yīfǎ cóngyán cháchǔ, dǐnggé zhòngfá.', 'Cơ quan giám sát đối với bất kỳ hành vi phạm pháp nào liên quan đến giao dịch nội gián hay thao túng thị trường chứng khoán, đều sẽ xử lý nghiêm theo pháp luật và phạt nặng ở khung kịch trần.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2325] [罚款] (fákuǎn) - phạt tiền, tiền phạt [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '罚款' AND pinyin = 'fákuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '罚款' AND pinyin = 'fákuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '罚款'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '罚款'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'fákuǎn',
      meaning_vi = 'phạt tiền, tiền phạt',
      example_hanzi = '他在禁止停车的路段违规停车，被交警依法处以两百元罚款。',
      example_pinyin = 'Tā zài jìnzhǐ tíngchē de lùduàn wéiguī tíngchē, bèi jiāojǐng yīfǎ chǔ yǐ liǎng bǎi yuán fákuǎn.',
      example_vi = 'Anh ấy đỗ xe trái quy định ở đoạn đường cấm đỗ, đã bị cảnh sát giao thông phạt tiền 200 tệ theo luật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '罚款',
      'fákuǎn',
      'phạt tiền, tiền phạt',
      'Động từ / Danh từ',
      'HSK 5',
      '他在禁止停车的路段违规停车，被交警依法处以两百元罚款。',
      'Tā zài jìnzhǐ tíngchē de lùduàn wéiguī tíngchē, bèi jiāojǐng yīfǎ chǔ yǐ liǎng bǎi yuán fákuǎn.',
      'Anh ấy đỗ xe trái quy định ở đoạn đường cấm đỗ, đã bị cảnh sát giao thông phạt tiền 200 tệ theo luật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在禁止停车的路段违规停车，被交警依法处以两百元罚款。', 'Tā zài jìnzhǐ tíngchē de lùduàn wéiguī tíngchē, bèi jiāojǐng yīfǎ chǔ yǐ liǎng bǎi yuán fákuǎn.', 'Anh ấy đỗ xe trái quy định ở đoạn đường cấm đỗ, đã bị cảnh sát giao thông phạt tiền 200 tệ theo luật.', 'basic', 1),
      (v_id, '对屡次违反环保排污标准且拒不整改的工业企业，环保行政执法部门开出了高达数百万元的天价罚款单。', 'Duì lǚcì wéifǎn huánbǎo páiwū biāozhǔn qiě jùbù zhěnggǎi de gōngyè qǐyè, huánbǎo xíngzhèng zhífǎ bùmén kāi chū le gāodá shù bǎi wàn yuán de tiānjià fákuǎndān.', 'Đối với những doanh nghiệp công nghiệp nhiều lần vi phạm tiêu chuẩn xả thải môi trường và kiên quyết không khắc phục, cơ quan thực thi pháp luật hành chính môi trường đã đưa ra mức án phạt tiền cao chót vót lên tới hàng triệu tệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2326] [法院] (fǎyuàn) - tòa án [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '法院' AND pinyin = 'fǎyuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '法院' AND pinyin = 'fǎyuàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '法院'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '法院'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fǎyuàn',
      meaning_vi = 'tòa án',
      example_hanzi = '双方就房屋买卖合同产生了严重分歧，最终决定向人民法院提起诉讼。',
      example_pinyin = 'Shuāngfāng jiù fángwū mǎimài hétong chǎnshēng le yánzhòng fēnqí, zuìzhōng juédìng xiàng rénmín fǎyuàn tíqǐ sùsòng.',
      example_vi = 'Hai bên đã nảy sinh bất đồng nghiêm trọng về hợp đồng mua bán nhà đất, cuối cùng quyết định khởi kiện lên tòa án nhân dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '法院',
      'fǎyuàn',
      'tòa án',
      'Danh từ',
      'HSK 5',
      '双方就房屋买卖合同产生了严重分歧，最终决定向人民法院提起诉讼。',
      'Shuāngfāng jiù fángwū mǎimài hétong chǎnshēng le yánzhòng fēnqí, zuìzhōng juédìng xiàng rénmín fǎyuàn tíqǐ sùsòng.',
      'Hai bên đã nảy sinh bất đồng nghiêm trọng về hợp đồng mua bán nhà đất, cuối cùng quyết định khởi kiện lên tòa án nhân dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '双方就房屋买卖合同产生了严重分歧，最终决定向人民法院提起诉讼。', 'Shuāngfāng jiù fángwū mǎimài hétong chǎnshēng le yánzhòng fēnqí, zuìzhōng juédìng xiàng rénmín fǎyuàn tíqǐ sùsòng.', 'Hai bên đã nảy sinh bất đồng nghiêm trọng về hợp đồng mua bán nhà đất, cuối cùng quyết định khởi kiện lên tòa án nhân dân.', 'basic', 1),
      (v_id, '知识产权法院经过公开透明的法庭审理，依法作出了责令侵权方立即停止侵权行为并全额赔偿经济损失的终审判决。', 'Zhīshi chǎnquán fǎyuàn jīngguò gōngkāi tòumíng de fǎtíng shěnlǐ, yīfǎ zuòchū le zélìng qīnquán fāng lìjí tíngzhǐ qīnquán xíngwéi bìng quán’é péicháng jīngjì sǔnshī de zhōngshěn pànjué.', 'Tòa án sở hữu trí tuệ qua phiên xét xử công khai minh bạch đã đưa ra phán quyết chung thẩm theo luật yêu cầu bên xâm phạm quyền ngay lập tức dừng hành vi vi phạm và bồi thường toàn bộ tổn thất kinh tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2327] [翻] (fān) - lật, dịch, trèo qua, nhân lên gấp bội [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '翻' AND pinyin = 'fān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '翻' AND pinyin = 'fān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '翻'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '翻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fān',
      meaning_vi = 'lật, dịch, trèo qua, nhân lên gấp bội',
      example_hanzi = '他坐在书桌前，一边喝着热茶，一边轻轻翻看着那本厚厚的相册。',
      example_pinyin = 'Tā zuò zài shūzhuō qián, yìbiān hē zhe rèchá, yìbiān qīngqīng fānkàn zhe nà běn hòuhòu de xiàngcè.',
      example_vi = 'Anh ấy ngồi trước bàn sách, vừa uống trà nóng vừa nhẹ nhàng lật xem cuốn album ảnh dày cộp kia.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '翻',
      'fān',
      'lật, dịch, trèo qua, nhân lên gấp bội',
      'Động từ',
      'HSK 5',
      '他坐在书桌前，一边喝着热茶，一边轻轻翻看着那本厚厚的相册。',
      'Tā zuò zài shūzhuō qián, yìbiān hē zhe rèchá, yìbiān qīngqīng fānkàn zhe nà běn hòuhòu de xiàngcè.',
      'Anh ấy ngồi trước bàn sách, vừa uống trà nóng vừa nhẹ nhàng lật xem cuốn album ảnh dày cộp kia.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他坐在书桌前，一边喝着热茶，一边轻轻翻看着那本厚厚的相册。', 'Tā zuò zài shūzhuō qián, yìbiān hē zhe rèchá, yìbiān qīngqīng fānkàn zhe nà běn hòuhòu de xiàngcè.', 'Anh ấy ngồi trước bàn sách, vừa uống trà nóng vừa nhẹ nhàng lật xem cuốn album ảnh dày cộp kia.', 'basic', 1),
      (v_id, '通过拓展海外跨境电商业务与优化供应链管理，这家民营制造企业的年净利润比三年前翻了一番。', 'Tōngguò tuòzhǎn hǎiwài kuàjìng diànshāng yèwù yǔ yōuhuà gōngyìngliàn guǎnlǐ, zhè jiā mínyíng zhìzào qǐyè de nián jìnglìrùn bǐ sān nián qián fān le yì fān.', 'Thông qua việc mở rộng mảng thương mại điện tử xuyên biên giới ra nước ngoài và tối ưu hóa quản lý chuỗi cung ứng, lợi nhuận ròng hàng năm của doanh nghiệp sản xuất tư nhân này đã tăng gấp đôi so với ba năm trước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2328] [番茄] (fānqié) - cà chua [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '番茄' AND pinyin = 'fānqié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '番茄' AND pinyin = 'fānqié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '番茄'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '番茄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fānqié',
      meaning_vi = 'cà chua',
      example_hanzi = '番茄炒鸡蛋是一道深受大众喜爱的中国传统家常菜。',
      example_pinyin = 'Fānqié chǎo jīdàn shì yí dào shēnshòu dàzhòng xǐ’ài de Zhōngguó chuántǒng jiāchángcài.',
      example_vi = 'Trứng xào cà chua là một món ăn gia đình truyền thống Trung Quốc được đông đảo mọi người yêu thích.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '番茄',
      'fānqié',
      'cà chua',
      'Danh từ',
      'HSK 5',
      '番茄炒鸡蛋是一道深受大众喜爱的中国传统家常菜。',
      'Fānqié chǎo jīdàn shì yí dào shēnshòu dàzhòng xǐ’ài de Zhōngguó chuántǒng jiāchángcài.',
      'Trứng xào cà chua là một món ăn gia đình truyền thống Trung Quốc được đông đảo mọi người yêu thích.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '番茄炒鸡蛋是一道深受大众喜爱的中国传统家常菜。', 'Fānqié chǎo jīdàn shì yí dào shēnshòu dàzhòng xǐ’ài de Zhōngguó chuántǒng jiāchángcài.', 'Trứng xào cà chua là một món ăn gia đình truyền thống Trung Quốc được đông đảo mọi người yêu thích.', 'basic', 1),
      (v_id, '现代智慧农业温室利用无土栽培技术与物联网滴灌控制，培育出的有机高品质番茄远销国内外各大高端生鲜超市。', 'Xiàndài zhìhuì nóngyè wēnshì lìyòng wútǔ zāipéi jìshù yǔ wùliánwǎng dīguàn kòngzhì, péiyù chū de yǒujī gāopǐnzhì fānqié yuǎnxiāo guónèi wài gè dà gāoduān shēngxiān chāoshì.', 'Nhà kính nông nghiệp thông minh hiện đại áp dụng kỹ thuật canh tác không dùng đất và kiểm soát tưới nhỏ giọt qua mạng vạn vật kết nối (IoT), ươm trồng ra những quả cà chua hữu cơ chất lượng cao xuất bán tới các chuỗi siêu thị thực phẩm tươi sống cao cấp trong và ngoài nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2329] [繁荣] (fánróng) - phồn vinh, thịnh vượng, phát đạt [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '繁荣' AND pinyin = 'fánróng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '繁荣' AND pinyin = 'fánróng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '繁荣'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '繁荣'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'fánróng',
      meaning_vi = 'phồn vinh, thịnh vượng, phát đạt',
      example_hanzi = '节日期间的市中心步行街张灯结彩，呈现出一片繁荣热闹的景象。',
      example_pinyin = 'Jiérì qījiān de shìzhōngxīn bùxíngjiē zhāngdēngjiécǎi, chéngxiàn chū yí piàn fánróng rènào de jǐngxiàng.',
      example_vi = 'Khu phố đi bộ trung tâm thành phố trong dịp lễ giăng đèn kết hoa, hiện lên một khung cảnh phồn vinh náo nhiệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '繁荣',
      'fánróng',
      'phồn vinh, thịnh vượng, phát đạt',
      'Tính từ / Động từ',
      'HSK 5',
      '节日期间的市中心步行街张灯结彩，呈现出一片繁荣热闹的景象。',
      'Jiérì qījiān de shìzhōngxīn bùxíngjiē zhāngdēngjiécǎi, chéngxiàn chū yí piàn fánróng rènào de jǐngxiàng.',
      'Khu phố đi bộ trung tâm thành phố trong dịp lễ giăng đèn kết hoa, hiện lên một khung cảnh phồn vinh náo nhiệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '节日期间的市中心步行街张灯结彩，呈现出一片繁荣热闹的景象。', 'Jiérì qījiān de shìzhōngxīn bùxíngjiē zhāngdēngjiécǎi, chéngxiàn chū yí piàn fánróng rènào de jǐngxiàng.', 'Khu phố đi bộ trung tâm thành phố trong dịp lễ giăng đèn kết hoa, hiện lên một khung cảnh phồn vinh náo nhiệt.', 'basic', 1),
      (v_id, '深化区域经济一体化合作与推动高水平对外开放，是持续促进亚太地区经贸长期繁荣稳定的重要基石。', 'Shēnhuà qūyù jīngjì yītǐhuà hézuò yǔ tuīdòng gāoshuǐpíng duìwài kāifàng, shì chíxù cùjìn Yà-Tài dìqū jīngmào chángqī fánróng wěndìng de zhòngyào jīshí.', 'Làm sâu sắc thêm hợp tác hội nhập kinh tế khu vực và thúc đẩy mở cửa đối ngoại mức độ cao chính là nền tảng quan trọng nhằm tiếp tục thúc đẩy kinh tế thương mại khu vực Châu Á - Thái Bình Dương phồn vinh ổn định lâu dài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2330] [反] (fǎn) - ngược, trái, đối lập, trái lại [Tính từ / Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '反' AND pinyin = 'fǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反' AND pinyin = 'fǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '反'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ / Phó từ',
      pinyin = 'fǎn',
      meaning_vi = 'ngược, trái, đối lập, trái lại',
      example_hanzi = '你今天出门太着急，连外套里面的毛衣都穿反了。',
      example_pinyin = 'Nǐ jīntiān chūmén tài zháojí, lián wàitào lǐmiàn de máoyī dōu chuān fǎn le.',
      example_vi = 'Hôm nay bạn ra khỏi nhà vội vàng quá, đến áo len bên trong áo khoác cũng mặc ngược mất rồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '反',
      'fǎn',
      'ngược, trái, đối lập, trái lại',
      'Tính từ / Động từ / Phó từ',
      'HSK 5',
      '你今天出门太着急，连外套里面的毛衣都穿反了。',
      'Nǐ jīntiān chūmén tài zháojí, lián wàitào lǐmiàn de máoyī dōu chuān fǎn le.',
      'Hôm nay bạn ra khỏi nhà vội vàng quá, đến áo len bên trong áo khoác cũng mặc ngược mất rồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '你今天出门太着急，连外套里面的毛衣都穿反了。', 'Nǐ jīntiān chūmén tài zháojí, lián wàitào lǐmiàn de máoyī dōu chuān fǎn le.', 'Hôm nay bạn ra khỏi nhà vội vàng quá, đến áo len bên trong áo khoác cũng mặc ngược mất rồi.', 'basic', 1),
      (v_id, '盲目跟风炒作往往适得其反，投资者必须保持理性的批判性思维与风险防控意识。', 'Mángmù gēnfēng chǎozuò wǎngwǎng shìdéqífǎn, tóuzīzhě bìxū bǎochí lǐxìng de pīpànxìng sīwéi yǔ fēngxiǎn fángkòng yìshí.', 'Mù quáng chạy theo trào lưu đầu cơ thường sẽ lợi bất cập hại (cho kết quả ngược lại), các nhà đầu tư nhất định phải duy trì tư duy phản biện lý tính và ý thức phòng ngừa kiểm soát rủi ro.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2331] [反而] (fǎn’ér) - trái lại, ngược lại [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '反而' AND pinyin = 'fǎn’ér'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反而' AND pinyin = 'fǎn’ér'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '反而'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反而'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'fǎn’ér',
      meaning_vi = 'trái lại, ngược lại',
      example_hanzi = '吃了医生开的退烧药后，他的体温不但没降，反而升得更高了。',
      example_pinyin = 'Chī le yīshēng kāi de tuìshāoyào hòu, tā de tǐwēn búdàn méi jiàng, fǎn’ér shēng de gèng gāo le.',
      example_vi = 'Sau khi uống thuốc hạ sốt bác sĩ kê, nhiệt độ cơ thể anh ấy chẳng những không giảm mà ngược lại còn sốt cao hơn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '反而',
      'fǎn’ér',
      'trái lại, ngược lại',
      'Phó từ',
      'HSK 5',
      '吃了医生开的退烧药后，他的体温不但没降，反而升得更高了。',
      'Chī le yīshēng kāi de tuìshāoyào hòu, tā de tǐwēn búdàn méi jiàng, fǎn’ér shēng de gèng gāo le.',
      'Sau khi uống thuốc hạ sốt bác sĩ kê, nhiệt độ cơ thể anh ấy chẳng những không giảm mà ngược lại còn sốt cao hơn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '吃了医生开的退烧药后，他的体温不但没降，反而升得更高了。', 'Chī le yīshēng kāi de tuìshāoyào hòu, tā de tǐwēn búdàn méi jiàng, fǎn’ér shēng de gèng gāo le.', 'Sau khi uống thuốc hạ sốt bác sĩ kê, nhiệt độ cơ thể anh ấy chẳng những không giảm mà ngược lại còn sốt cao hơn.', 'basic', 1),
      (v_id, '面对突如其来的市场剧烈波动，经验丰富的基金经理不仅没有惊慌失措抛售资产，反而抓住时机逢低建仓优质潜力股。', 'Miànduì tūrúqílái de shìchǎng jùliè bōdòng, jīngyàn fēngfù de jījīn jīnglǐ bùjǐn méiyǒu jīnghuāngshīcuò pāoshòu zīchǎn, fǎn’ér zhuāzhù shíjī féng dī jiàncāng yōuzhì qiánlì gǔ.', 'Đối mặt với sự biến động dữ dội bất ngờ của thị trường, người quản lý quỹ giàu kinh nghiệm chẳng những không hoảng loạn bán tháo tài sản, mà ngược lại còn chớp lấy thời cơ gom vào các cổ phiếu tiềm năng chất lượng cao ở vùng giá thấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2332] [反复] (fǎnfù) - lặp đi lặp lại, nhiều lần, sự tráo trở [Phó từ / Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '反复' AND pinyin = 'fǎnfù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反复' AND pinyin = 'fǎnfù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '反复'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反复'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Động từ / Danh từ',
      pinyin = 'fǎnfù',
      meaning_vi = 'lặp đi lặp lại, nhiều lần, sự tráo trở',
      example_hanzi = '经过反复推敲和多次修改，这篇演讲稿终于定稿了。',
      example_pinyin = 'Jīngguò fǎnfù tuīqiāo hé duō cì xiūgǎi, zhè piān yǎnjiǎnggǎo zhōngyú dìnggǎo le.',
      example_vi = 'Sau khi cân nhắc kỹ lưỡng lặp đi lặp lại và nhiều lần sửa đổi, bản thảo bài diễn thuyết này cuối cùng đã hoàn thiện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '反复',
      'fǎnfù',
      'lặp đi lặp lại, nhiều lần, sự tráo trở',
      'Phó từ / Động từ / Danh từ',
      'HSK 5',
      '经过反复推敲和多次修改，这篇演讲稿终于定稿了。',
      'Jīngguò fǎnfù tuīqiāo hé duō cì xiūgǎi, zhè piān yǎnjiǎnggǎo zhōngyú dìnggǎo le.',
      'Sau khi cân nhắc kỹ lưỡng lặp đi lặp lại và nhiều lần sửa đổi, bản thảo bài diễn thuyết này cuối cùng đã hoàn thiện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过反复推敲和多次修改，这篇演讲稿终于定稿了。', 'Jīngguò fǎnfù tuīqiāo hé duō cì xiūgǎi, zhè piān yǎnjiǎnggǎo zhōngyú dìnggǎo le.', 'Sau khi cân nhắc kỹ lưỡng lặp đi lặp lại và nhiều lần sửa đổi, bản thảo bài diễn thuyết này cuối cùng đã hoàn thiện.', 'basic', 1),
      (v_id, '在极端复杂多变的国际地缘政治博弈中，谈判各方围绕核心利益条款展开了长达数月的反复磋商与艰难博弈。', 'Zài jíduān fùzá duōbiàn de guójì dìyuán zhèngzhì bóyì zhōng, tánpàn gè fāng wéirào héxīn lìyì tiáokuǎn zhǎnkāi le chángdá shù yuè de fǎnfù cuōshāng yǔ jiānnán bóyì.', 'Trong cuộc cờ địa chính trị quốc tế hết sức phức tạp và biến đổi không lường, các bên đàm phán đã tiến hành nhiều tháng thương lượng lặp đi lặp lại và tranh đấu cam go xoay quanh các điều khoản lợi ích cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2333] [返回] (fǎnhuí) - quay về, trở về, trả về [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '返回' AND pinyin = 'fǎnhuí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '返回' AND pinyin = 'fǎnhuí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '返回'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '返回'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fǎnhuí',
      meaning_vi = 'quay về, trở về, trả về',
      example_hanzi = '在国外留学深造三年之后，他毅然决定返回祖国参加工作。',
      example_pinyin = 'Zài guówài liúxué shēnzào sān nián zhīhòu, tā yìrán juédìng fǎnhuí zǔguó cānjiā gōngzuò.',
      example_vi = 'Sau ba năm đi du học nâng cao ở nước ngoài, anh ấy đã dứt khoát quyết định quay về tổ quốc tham gia làm việc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '返回',
      'fǎnhuí',
      'quay về, trở về, trả về',
      'Động từ',
      'HSK 5',
      '在国外留学深造三年之后，他毅然决定返回祖国参加工作。',
      'Zài guówài liúxué shēnzào sān nián zhīhòu, tā yìrán juédìng fǎnhuí zǔguó cānjiā gōngzuò.',
      'Sau ba năm đi du học nâng cao ở nước ngoài, anh ấy đã dứt khoát quyết định quay về tổ quốc tham gia làm việc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在国外留学深造三年之后，他毅然决定返回祖国参加工作。', 'Zài guówài liúxué shēnzào sān nián zhīhòu, tā yìrán juédìng fǎnhuí zǔguó cānjiā gōngzuò.', 'Sau ba năm đi du học nâng cao ở nước ngoài, anh ấy đã dứt khoát quyết định quay về tổ quốc tham gia làm việc.', 'basic', 1),
      (v_id, '搭载三名宇航员的载人飞船返回舱在内蒙古预定着陆场成功着陆，标志着本次空间站载人飞行任务取得圆满成功。', 'Dāzǎi sān míng yǔhángyuán de zàirén fēichuán fǎnhuícāng zài Nèiměnggǔ yùdìng zhuólùchǎng chénggōng zhuólù, biāozhì zhe běn cì kōngjiānzhàn zàirén fēixíng rènwù qǔdé yuánmǎn chénggōng.', 'Khoang hồi quyển của tàu vũ trụ có người lái chở theo ba nhà du hành vũ trụ đã hạ cánh thành công tại bãi đáp dự kiến ở Nội Mông Cổ, đánh dấu nhiệm vụ bay có người lái lên trạm vũ trụ lần này đạt thành công viên mãn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2334] [反应] (fǎnyìng) - phản ứng, đáp ứng, sự phản hồi [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '反应' AND pinyin = 'fǎnyìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反应' AND pinyin = 'fǎnyìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '反应'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反应'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'fǎnyìng',
      meaning_vi = 'phản ứng, đáp ứng, sự phản hồi',
      example_hanzi = '这位羽毛球运动员在比赛场上的临场反应极其敏捷。',
      example_pinyin = 'Zhè wèi yǔmáoqiú yùndòngyuán zài bǐsài chǎng shàng de línchǎng fǎnyìng jíqí mǐnjié.',
      example_vi = 'Vận động viên cầu lông này có phản ứng xử lý tình huống trên sân đấu cực kỳ nhanh nhạy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '反应',
      'fǎnyìng',
      'phản ứng, đáp ứng, sự phản hồi',
      'Động từ / Danh từ',
      'HSK 5',
      '这位羽毛球运动员在比赛场上的临场反应极其敏捷。',
      'Zhè wèi yǔmáoqiú yùndòngyuán zài bǐsài chǎng shàng de línchǎng fǎnyìng jíqí mǐnjié.',
      'Vận động viên cầu lông này có phản ứng xử lý tình huống trên sân đấu cực kỳ nhanh nhạy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位羽毛球运动员在比赛场上的临场反应极其敏捷。', 'Zhè wèi yǔmáoqiú yùndòngyuán zài bǐsài chǎng shàng de línchǎng fǎnyìng jíqí mǐnjié.', 'Vận động viên cầu lông này có phản ứng xử lý tình huống trên sân đấu cực kỳ nhanh nhạy.', 'basic', 1),
      (v_id, '新药临床试验数据显示，极少数受试者在注射该疫苗后出现了轻微的局部皮肤过敏不良反应。', 'Xīnyào línchuáng shìyàn shùjù xiǎnshì, jí shǎoshù shòushìzhě zài zhùshè gāi yìmiáo hòu chūxiàn le qīngwēi de júbù pífū guòmǐn bùliáng fǎnyìng.', 'Số liệu thử nghiệm lâm sàng của thuốc mới cho thấy, một số lượng rất ít người tham gia thử nghiệm sau khi tiêm vắc-xin này đã xuất hiện phản ứng bất lợi dị ứng da cục bộ ở mức độ nhẹ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2335] [反映] (fǎnyìng) - phản ánh, phản chiếu, truyền đạt phản hồi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '反映' AND pinyin = 'fǎnyìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反映' AND pinyin = 'fǎnyìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '反映'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反映'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fǎnyìng',
      meaning_vi = 'phản ánh, phản chiếu, truyền đạt phản hồi',
      example_hanzi = '居民们向居委会反映了小区夜间路灯亮度不足的安全隐患。',
      example_pinyin = 'Jūmínmen xiàng jūwěihuì fǎnyìng le xiǎoqū yèjiān lùdēng liàngdù bùzú de ānquán yǐnhuàn.',
      example_vi = 'Cư dân đã phản ánh với ban quản lý khu phố về nguy cơ mất an toàn do độ sáng đèn đường ban đêm không đủ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '反映',
      'fǎnyìng',
      'phản ánh, phản chiếu, truyền đạt phản hồi',
      'Động từ',
      'HSK 5',
      '居民们向居委会反映了小区夜间路灯亮度不足的安全隐患。',
      'Jūmínmen xiàng jūwěihuì fǎnyìng le xiǎoqū yèjiān lùdēng liàngdù bùzú de ānquán yǐnhuàn.',
      'Cư dân đã phản ánh với ban quản lý khu phố về nguy cơ mất an toàn do độ sáng đèn đường ban đêm không đủ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '居民们向居委会反映了小区夜间路灯亮度不足的安全隐患。', 'Jūmínmen xiàng jūwěihuì fǎnyìng le xiǎoqū yèjiān lùdēng liàngdù bùzú de ānquán yǐnhuàn.', 'Cư dân đã phản ánh với ban quản lý khu phố về nguy cơ mất an toàn do độ sáng đèn đường ban đêm không đủ.', 'basic', 1),
      (v_id, '采购经理人指数（PMI）作为衡量宏观经济发展活力的晴雨表，真实客观地反映了当前制造业市场需求景气程度。', 'Cǎigòu jīnglǐrén zhǐshù (PMI) zuòwéi héngliáng hóngguān jīngjì fāzhǎn huólì de qíngyǔbiǎo, zhēnshí kèguān de fǎnyìng le dāngqián zhìzàoyè shìchǎng xūqiú jǐngqì chéngdù.', 'Chỉ số nhà quản trị mua hàng (PMI) với tư cách là phong vũ biểu đo lường sức sống phát triển kinh tế vĩ mô, đã phản ánh chân thực và khách quan mức độ khởi sắc của nhu cầu thị trường chế tạo hiện nay.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2336] [反正] (fǎnzhèng) - dù sao thì, đằng nào thì [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '反正' AND pinyin = 'fǎnzhèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反正' AND pinyin = 'fǎnzhèng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '反正'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '反正'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'fǎnzhèng',
      meaning_vi = 'dù sao thì, đằng nào thì',
      example_hanzi = '你不管去不去，反正我明天一定要去图书馆查阅论文资料。',
      example_pinyin = 'Nǐ bùguǎn qù bu qù, fǎnzhèng wǒ míngtiān yídìng yào qù túshūguǎn cháyuè lùnwén zīliào.',
      example_vi = 'Bạn bất kể có đi hay không, dù sao thì ngày mai tôi nhất định sẽ đến thư viện tra cứu tài liệu luận văn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '反正',
      'fǎnzhèng',
      'dù sao thì, đằng nào thì',
      'Phó từ',
      'HSK 5',
      '你不管去不去，反正我明天一定要去图书馆查阅论文资料。',
      'Nǐ bùguǎn qù bu qù, fǎnzhèng wǒ míngtiān yídìng yào qù túshūguǎn cháyuè lùnwén zīliào.',
      'Bạn bất kể có đi hay không, dù sao thì ngày mai tôi nhất định sẽ đến thư viện tra cứu tài liệu luận văn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '你不管去不去，反正我明天一定要去图书馆查阅论文资料。', 'Nǐ bùguǎn qù bu qù, fǎnzhèng wǒ míngtiān yídìng yào qù túshūguǎn cháyuè lùnwén zīliào.', 'Bạn bất kể có đi hay không, dù sao thì ngày mai tôi nhất định sẽ đến thư viện tra cứu tài liệu luận văn.', 'basic', 1),
      (v_id, '既然整体项目方向已经由董事会最终表决敲定，大家就别再犹豫纠结了，反正执行细节还可以在后续敏捷迭代中持续优化。', 'Jìrán zhěngtǐ xiàngmù fāngxiàng yǐjīng yóu dǒngshìhuì zuìzhōng biǎojué qiāodìng, dàjiā jiù bié zài yóuyù jiūjié le, fǎnzhèng zhíxíng xìjié hái kěyǐ zài hòuxù mǐnjié diédài zhōng chíxù yōuhuà.', 'Một khi phương hướng tổng thể của dự án đã được hội đồng quản trị biểu quyết chốt hạ cuối cùng, mọi người đừng do dự giằng xé nữa, đằng nào thì các chi tiết thực thi vẫn có thể liên tục tối ưu trong các chu kỳ lặp linh hoạt (Agile) tiếp theo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2337] [范围] (fànwéi) - phạm vi, quy mô giới hạn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '范围' AND pinyin = 'fànwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '范围' AND pinyin = 'fànwéi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '范围'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '范围'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fànwéi',
      meaning_vi = 'phạm vi, quy mô giới hạn',
      example_hanzi = '期末考试的复习范围主要集中在教材的前五章核心内容。',
      example_pinyin = 'Qīmò kǎoshì de fùxí fànwéi zhǔyào jízhōng zài jiàocái de qián wǔ zhāng héxīn nèiróng.',
      example_vi = 'Phạm vi ôn tập thi cuối kỳ chủ yếu tập trung vào nội dung cốt lõi của năm chương đầu sách giáo khoa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '范围',
      'fànwéi',
      'phạm vi, quy mô giới hạn',
      'Danh từ',
      'HSK 5',
      '期末考试的复习范围主要集中在教材的前五章核心内容。',
      'Qīmò kǎoshì de fùxí fànwéi zhǔyào jízhōng zài jiàocái de qián wǔ zhāng héxīn nèiróng.',
      'Phạm vi ôn tập thi cuối kỳ chủ yếu tập trung vào nội dung cốt lõi của năm chương đầu sách giáo khoa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '期末考试的复习范围主要集中在教材的前五章核心内容。', 'Qīmò kǎoshì de fùxí fànwéi zhǔyào jízhōng zài jiàocái de qián wǔ zhāng héxīn nèiróng.', 'Phạm vi ôn tập thi cuối kỳ chủ yếu tập trung vào nội dung cốt lõi của năm chương đầu sách giáo khoa.', 'basic', 1),
      (v_id, '该跨国协议不仅大幅拓宽了两国在经贸投资领域的合作范围，更将数字经济与绿色转型纳入长期战略对话机制。', 'Gāi kuàguó xiéyì bùjǐn dàfú tuòkuān le liǎng guó zài jīngmào tóuzī lǐngyù de hézuò fànwéi, gèng jiāng shùzì jīngjì yǔ lǜsè zhuǎnxíng nàrù chángqī zhànlüè duìhuà jīzhì.', 'Hiệp định xuyên quốc gia này không chỉ mở rộng mạnh mẽ phạm vi hợp tác giữa hai nước trong lĩnh vực kinh tế thương mại và đầu tư, mà còn đưa cả kinh tế số và chuyển đổi xanh vào cơ chế đối thoại chiến lược dài hạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2338] [方] (fāng) - vuông; phương, phía, bên, phương hướng [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '方' AND pinyin = 'fāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '方' AND pinyin = 'fāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '方'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '方'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'fāng',
      meaning_vi = 'vuông; phương, phía, bên, phương hướng',
      example_hanzi = '客厅中央摆放着一张古色古香的红木方桌。',
      example_pinyin = 'Kètīng zhōngyāng bǎifàng zhe yì zhāng gǔsègǔxiāng de hóngmù fāngzhuō.',
      example_vi = 'Chính giữa phòng khách đặt một chiếc bàn vuông bằng gỗ gụ mang phong cách cổ kính.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '方',
      'fāng',
      'vuông; phương, phía, bên, phương hướng',
      'Tính từ / Danh từ',
      'HSK 5',
      '客厅中央摆放着一张古色古香的红木方桌。',
      'Kètīng zhōngyāng bǎifàng zhe yì zhāng gǔsègǔxiāng de hóngmù fāngzhuō.',
      'Chính giữa phòng khách đặt một chiếc bàn vuông bằng gỗ gụ mang phong cách cổ kính.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '客厅中央摆放着一张古色古香的红木方桌。', 'Kètīng zhōngyāng bǎifàng zhe yì zhāng gǔsègǔxiāng de hóngmù fāngzhuō.', 'Chính giữa phòng khách đặt một chiếc bàn vuông bằng gỗ gụ mang phong cách cổ kính.', 'basic', 1),
      (v_id, '在本次跨国商业并购谈判中，买卖双方本着互利共赢的原则，就知识产权归属达成了高度共识。', 'Zài běn cì kuàguó shāngyè bìnggòu tánpàn zhōng, mǎimài shuāngfāng běnzhe hùlì-gòngyíng de yuánzé, jiù zhīshi chǎnquán guīshǔ dáchéng le gāodù gòngshí.', 'Trong cuộc đàm phán sáp nhập mua lại thương mại xuyên quốc gia lần này, hai bên mua bán trên nguyên tắc cùng có lợi đã đạt được sự đồng thuận cao độ về quyền sở hữu trí tuệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2339] [方案] (fāng’àn) - phương án, kế hoạch giải pháp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '方案' AND pinyin = 'fāng’àn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '方案' AND pinyin = 'fāng’àn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '方案'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '方案'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fāng’àn',
      meaning_vi = 'phương án, kế hoạch giải pháp',
      example_hanzi = '设计团队今晚将向客户正式提交三套不同的室内装修设计方案。',
      example_pinyin = 'Shèjì tuánduì jīnwǎn jiāng xiàng kèhù zhèngshì tíjiāo sān tào bùtóng de shìnèi zhuāngxiū shèjì fāng’àn.',
      example_vi = 'Đội ngũ thiết kế tối nay sẽ chính thức đệ trình lên khách hàng ba bộ phương án thiết kế trang trí nội thất khác nhau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '方案',
      'fāng’àn',
      'phương án, kế hoạch giải pháp',
      'Danh từ',
      'HSK 5',
      '设计团队今晚将向客户正式提交三套不同的室内装修设计方案。',
      'Shèjì tuánduì jīnwǎn jiāng xiàng kèhù zhèngshì tíjiāo sān tào bùtóng de shìnèi zhuāngxiū shèjì fāng’àn.',
      'Đội ngũ thiết kế tối nay sẽ chính thức đệ trình lên khách hàng ba bộ phương án thiết kế trang trí nội thất khác nhau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '设计团队今晚将向客户正式提交三套不同的室内装修设计方案。', 'Shèjì tuánduì jīnwǎn jiāng xiàng kèhù zhèngshì tíjiāo sān tào bùtóng de shìnèi zhuāngxiū shèjì fāng’àn.', 'Đội ngũ thiết kế tối nay sẽ chính thức đệ trình lên khách hàng ba bộ phương án thiết kế trang trí nội thất khác nhau.', 'basic', 1),
      (v_id, '专家组经过充分论证，最终通过了这项兼顾生态环境保护与经济可持续发展的城市综合交通枢纽建设方案。', 'Zhuānjiāzǔ jīngguò chōngfèn lùnzhèng, zuìzhōng tōngguò le zhè xiàng jiāngù shēngtài huánjìng bǎohù yǔ jīngjì kěchíxù fāzhǎn de chéngshì zōnghé jiāotōng shūniǔ jiànshè fāng’àn.', 'Tổ chuyên gia sau khi lập luận chứng minh đầy đủ, cuối cùng đã thông qua phương án xây dựng đầu mối giao thông tích hợp đô thị hài hòa giữa bảo vệ môi trường sinh thái và phát triển kinh tế bền vững này.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2340] [防] (fáng) - phòng, phòng chống, đề phòng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '防' AND pinyin = 'fáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '防' AND pinyin = 'fáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '防'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '防'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fáng',
      meaning_vi = 'phòng, phòng chống, đề phòng',
      example_hanzi = '夏天去野外露营一定要随身携带驱蚊液，做好防蚊虫叮咬的准备。',
      example_pinyin = 'Xiàtiān qù yěwài lùyíng yídìng yào suíshēn xiédài qūwényè, zuò hǎo fáng wénchóng dīngyǎo de zhǔnbèi.',
      example_vi = 'Mùa hè đi cắm trại ngoài trời nhất định phải mang theo thuốc chống muỗi bên mình, chuẩn bị tốt việc phòng muỗi và côn trùng cắn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '防',
      'fáng',
      'phòng, phòng chống, đề phòng',
      'Động từ',
      'HSK 5',
      '夏天去野外露营一定要随身携带驱蚊液，做好防蚊虫叮咬的准备。',
      'Xiàtiān qù yěwài lùyíng yídìng yào suíshēn xiédài qūwényè, zuò hǎo fáng wénchóng dīngyǎo de zhǔnbèi.',
      'Mùa hè đi cắm trại ngoài trời nhất định phải mang theo thuốc chống muỗi bên mình, chuẩn bị tốt việc phòng muỗi và côn trùng cắn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夏天去野外露营一定要随身携带驱蚊液，做好防蚊虫叮咬的准备。', 'Xiàtiān qù yěwài lùyíng yídìng yào suíshēn xiédài qūwényè, zuò hǎo fáng wénchóng dīngyǎo de zhǔnbèi.', 'Mùa hè đi cắm trại ngoài trời nhất định phải mang theo thuốc chống muỗi bên mình, chuẩn bị tốt việc phòng muỗi và côn trùng cắn.', 'basic', 1),
      (v_id, '各级金融监管机构必须未雨绸缪，筑牢金融安全防火墙，坚决防范化解系统性金融风险。', 'Gè jí jīnróng jiānguǎn jīgòu bìxū wèiyǔchóumóu, zhù láo jīnróng ānquán fánghuǒqiáng, jiānjué fángfàn huàjiě xìtǒngxìng jīnróng fēngxiǎn.', 'Cơ quan giám sát tài chính các cấp phải lo liệu phòng ngừa từ sớm, xây vững bức tường lửa an toàn tài chính, kiên quyết phòng ngừa và hóa giải các rủi ro tài chính mang tính hệ thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2341] [房屋] (fángwū) - nhà cửa, nhà ở [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '房屋' AND pinyin = 'fángwū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '房屋' AND pinyin = 'fángwū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '房屋'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '房屋'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fángwū',
      meaning_vi = 'nhà cửa, nhà ở',
      example_hanzi = '在签订房屋租赁合同之前，租客应当仔细核对房产证原件及各项物业条款。',
      example_pinyin = 'Zài qiāndìng fángwū zūlìn hétong zhīqián, zūkè yīngdāng zǐxì héduì fángchǎnzhèng yuánjiàn jí gè xiàng wùyè tiáokuǎn.',
      example_vi = 'Trước khi ký kết hợp đồng thuê nhà, người thuê nên kiểm tra đối chiếu kỹ lưỡng bản gốc sổ đỏ và các điều khoản phí dịch vụ quản lý.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '房屋',
      'fángwū',
      'nhà cửa, nhà ở',
      'Danh từ',
      'HSK 5',
      '在签订房屋租赁合同之前，租客应当仔细核对房产证原件及各项物业条款。',
      'Zài qiāndìng fángwū zūlìn hétong zhīqián, zūkè yīngdāng zǐxì héduì fángchǎnzhèng yuánjiàn jí gè xiàng wùyè tiáokuǎn.',
      'Trước khi ký kết hợp đồng thuê nhà, người thuê nên kiểm tra đối chiếu kỹ lưỡng bản gốc sổ đỏ và các điều khoản phí dịch vụ quản lý.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在签订房屋租赁合同之前，租客应当仔细核对房产证原件及各项物业条款。', 'Zài qiāndìng fángwū zūlìn hétong zhīqián, zūkè yīngdāng zǐxì héduì fángchǎnzhèng yuánjiàn jí gè xiàng wùyè tiáokuǎn.', 'Trước khi ký kết hợp đồng thuê nhà, người thuê nên kiểm tra đối chiếu kỹ lưỡng bản gốc sổ đỏ và các điều khoản phí dịch vụ quản lý.', 'basic', 1),
      (v_id, '当地政府启动了老旧小区改造工程，对具有安全隐患的危险房屋进行了全面的抗震加固与节能保温翻新。', 'Dāngdì zhèngfǔ qǐdòng le lǎojiù xiǎoqū gǎizào gōngchéng, duì jùyǒu ānquán yǐnhuàn de wēixiǎn fángwū jìnxíng le quánmiàn de kàngzhèn jiāgù yǔ jiénéng bǎowēn fānxīn.', 'Chính quyền địa phương đã khởi động công trình cải tạo các khu tập thể cũ, tiến hành gia cố chống động đất toàn diện và tân trang cách nhiệt tiết kiệm năng lượng cho các ngôi nhà có nguy cơ mất an toàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2342] [防止] (fángzhǐ) - phòng ngừa, ngăn ngừa, phòng tránh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '防止' AND pinyin = 'fángzhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '防止' AND pinyin = 'fángzhǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '防止'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '防止'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fángzhǐ',
      meaning_vi = 'phòng ngừa, ngăn ngừa, phòng tránh',
      example_hanzi = '过马路时千万不要低头看手机，以防止发生交通事故。',
      example_pinyin = 'Guò mǎlù shí qiānwàn bú yào dītóu kàn shǒujī, yǐ fángzhǐ fāshēng jiāotōng shìgù.',
      example_vi = 'Khi qua đường tuyệt đối không được cúi đầu xem điện thoại để phòng ngừa xảy ra tai nạn giao thông.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '防止',
      'fángzhǐ',
      'phòng ngừa, ngăn ngừa, phòng tránh',
      'Động từ',
      'HSK 5',
      '过马路时千万不要低头看手机，以防止发生交通事故。',
      'Guò mǎlù shí qiānwàn bú yào dītóu kàn shǒujī, yǐ fángzhǐ fāshēng jiāotōng shìgù.',
      'Khi qua đường tuyệt đối không được cúi đầu xem điện thoại để phòng ngừa xảy ra tai nạn giao thông.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '过马路时千万不要低头看手机，以防止发生交通事故。', 'Guò mǎlù shí qiānwàn bú yào dītóu kàn shǒujī, yǐ fángzhǐ fāshēng jiāotōng shìgù.', 'Khi qua đường tuyệt đối không được cúi đầu xem điện thoại để phòng ngừa xảy ra tai nạn giao thông.', 'basic', 1),
      (v_id, '工业生产车间必须严格执行安全规程并安装自动监测报警系统，以切实防止有毒有害气体泄漏事故的发生。', 'Gōngyè shēngchǎn chējiān bìxū yángé zhíxíng ānquán guīchéng bìng ānzhuāng zìdòng jiāncè bàojǐng xìtǒng, yǐ qièshí fángzhǐ yǒudú yǒuhài qìtǐ xièlòu shìgù de fāshēng.', 'Xưởng sản xuất công nghiệp phải chấp hành nghiêm ngặt quy trình an toàn và lắp đặt hệ thống cảnh báo giám sát tự động để phòng tránh một cách thiết thực sự cố rò rỉ khí độc hại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2343] [仿佛] (fǎngfú) - dường như, tựa như, ngỡ như [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '仿佛' AND pinyin = 'fǎngfú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '仿佛' AND pinyin = 'fǎngfú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '仿佛'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '仿佛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'fǎngfú',
      meaning_vi = 'dường như, tựa như, ngỡ như',
      example_hanzi = '听到这首熟悉的童谣，我仿佛又回到了无忧无虑的童年时代。',
      example_pinyin = 'Tīng dào zhè shǒu shúxī de tóngyáo, wǒ fǎngfú yòu huídào le wúyōuwúlǜ de tóngnián shídài.',
      example_vi = 'Nghe bài đồng dao quen thuộc này, tôi dường như lại được trở về thời thơ ấu vô lo vô nghĩ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '仿佛',
      'fǎngfú',
      'dường như, tựa như, ngỡ như',
      'Phó từ',
      'HSK 5',
      '听到这首熟悉的童谣，我仿佛又回到了无忧无虑的童年时代。',
      'Tīng dào zhè shǒu shúxī de tóngyáo, wǒ fǎngfú yòu huídào le wúyōuwúlǜ de tóngnián shídài.',
      'Nghe bài đồng dao quen thuộc này, tôi dường như lại được trở về thời thơ ấu vô lo vô nghĩ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听到这首熟悉的童谣，我仿佛又回到了无忧无虑的童年时代。', 'Tīng dào zhè shǒu shúxī de tóngyáo, wǒ fǎngfú yòu huídào le wúyōuwúlǜ de tóngnián shídài.', 'Nghe bài đồng dao quen thuộc này, tôi dường như lại được trở về thời thơ ấu vô lo vô nghĩ.', 'basic', 1),
      (v_id, '站在虚拟现实全景体验舱中，高精度的三维渲染让人仿佛身临其境般置身于浩瀚无垠的宇宙星河之中。', 'Zhàn zài xūnǐ xiànshí quánjǐng tǐyàncāng zhōng, gāojīngdù de sānwéi xuànrǎn ràng rén fǎngfú shēnlínqíjìng bān zhìshēn yú hàohàn-wúyín de yǔzhòu xīnghé zhī zhōng.', 'Đứng trong buồng trải nghiệm toàn cảnh thực tế ảo (VR), các hình ảnh dựng 3D độ nét cao khiến người ta ngỡ như được đích thân đặt mình giữa dải ngân hà vũ trụ bao la vô tận.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2344] [访问] (fǎngwèn) - thăm, viếng thăm, truy cập (website) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '访问' AND pinyin = 'fǎngwèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '访问' AND pinyin = 'fǎngwèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '访问'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '访问'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fǎngwèn',
      meaning_vi = 'thăm, viếng thăm, truy cập (website)',
      example_hanzi = '你可以直接访问学校官方网站查询最新发布的硕士招生简章。',
      example_pinyin = 'Nǐ kěyǐ zhíjiē fǎngwèn xuéxiào guānfāng wǎngzhàn cháxún zuìxīn fābù de shuòshì zhāoshēng jiǎnzhāng.',
      example_vi = 'Bạn có thể trực tiếp truy cập vào trang web chính thức của nhà trường để tra cứu thông báo tuyển sinh thạc sĩ mới nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '访问',
      'fǎngwèn',
      'thăm, viếng thăm, truy cập (website)',
      'Động từ',
      'HSK 5',
      '你可以直接访问学校官方网站查询最新发布的硕士招生简章。',
      'Nǐ kěyǐ zhíjiē fǎngwèn xuéxiào guānfāng wǎngzhàn cháxún zuìxīn fābù de shuòshì zhāoshēng jiǎnzhāng.',
      'Bạn có thể trực tiếp truy cập vào trang web chính thức của nhà trường để tra cứu thông báo tuyển sinh thạc sĩ mới nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '你可以直接访问学校官方网站查询最新发布的硕士招生简章。', 'Nǐ kěyǐ zhíjiē fǎngwèn xuéxiào guānfāng wǎngzhàn cháxún zuìxīn fābù de shuòshì zhāoshēng jiǎnzhāng.', 'Bạn có thể trực tiếp truy cập vào trang web chính thức của nhà trường để tra cứu thông báo tuyển sinh thạc sĩ mới nhất.', 'basic', 1),
      (v_id, '应东道国领导人盛情邀请，国家元首率领高级政府代表团抵达首都，展开为期三天的国事正式访问。', 'Yìng dōngdàoguó lǐngdǎorén shèngqíng yāoqǐng, guójiā yuánshǒu shuàilǐng gāojí zhèngfǔ dàibiǎotuán dǐdá shǒudū, zhǎnkāi wéiqī sān tiān de guóshì zhèngshì fǎngwèn.', 'Nhận lời mời nồng nhiệt của nhà lãnh đạo nước chủ nhà, nguyên thủ quốc gia đã dẫn đầu đoàn đại biểu cấp cao chính phủ đến thủ đô, bắt đầu chuyến thăm cấp nhà nước chính thức kéo dài ba ngày.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2345] [飞行] (fēixíng) - bay, phi hành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '飞行' AND pinyin = 'fēixíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '飞行' AND pinyin = 'fēixíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '飞行'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '飞行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fēixíng',
      meaning_vi = 'bay, phi hành',
      example_hanzi = '经过十多个小时的长途飞行，国际航班平稳降落在北京大兴国际机场。',
      example_pinyin = 'Jīngguò shí duō gè xiǎoshí de chángtú fēixíng, guójì hángbān píngwěn jiàngluò zài Běijīng Dàxīng Guójì Jīchǎng.',
      example_vi = 'Sau hơn mười tiếng đồng hồ bay đường dài, chuyến bay quốc tế đã hạ cánh êm thuận tại Sân bay quốc tế Đại Hưng Bắc Kinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '飞行',
      'fēixíng',
      'bay, phi hành',
      'Động từ',
      'HSK 5',
      '经过十多个小时的长途飞行，国际航班平稳降落在北京大兴国际机场。',
      'Jīngguò shí duō gè xiǎoshí de chángtú fēixíng, guójì hángbān píngwěn jiàngluò zài Běijīng Dàxīng Guójì Jīchǎng.',
      'Sau hơn mười tiếng đồng hồ bay đường dài, chuyến bay quốc tế đã hạ cánh êm thuận tại Sân bay quốc tế Đại Hưng Bắc Kinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过十多个小时的长途飞行，国际航班平稳降落在北京大兴国际机场。', 'Jīngguò shí duō gè xiǎoshí de chángtú fēixíng, guójì hángbān píngwěn jiàngluò zài Běijīng Dàxīng Guójì Jīchǎng.', 'Sau hơn mười tiếng đồng hồ bay đường dài, chuyến bay quốc tế đã hạ cánh êm thuận tại Sân bay quốc tế Đại Hưng Bắc Kinh.', 'basic', 1),
      (v_id, '新一代民用干线客机在极限高寒高原环境下成功完成了多项高难度试飞任务，全面验证了其卓越的飞行性能。', 'Xīn yí dài mínyòng gànxiàn kèjī zài jíxiàn gāohán gāoyuán huánjìng xià chénggōng wánchéng le duō xiàng gāonándù shìfēi rènwù, quánmiàn yànzhèng le qí zhuóyuè de fēixíng xìngnéng.', 'Máy bay chở khách chặng chính dân dụng thế hệ mới đã hoàn thành xuất sắc nhiều bài bay thử nghiệm độ khó cao trong môi trường cao nguyên cực kỳ rét buốt, kiểm chứng toàn diện tính năng bay vượt trội của nó.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2346] [飞行员] (fēixíngyuán) - phi công [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '飞行员' AND pinyin = 'fēixíngyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '飞行员' AND pinyin = 'fēixíngyuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '飞行员'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '飞行员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fēixíngyuán',
      meaning_vi = 'phi công',
      example_hanzi = '他从小就立志当一名民航飞行员，驾驶客机在蓝天白云间穿梭。',
      example_pinyin = 'Tā cóngxiǎo jiù lìzhì dāng yì míng mínháng fēixíngyuán, jiàshǐ kèjī zài lántiān báiyún jiān chuānsuō.',
      example_vi = 'Từ nhỏ anh ấy đã lập chí trở thành một phi công hàng không dân dụng, lái máy bay chở khách lướt đi giữa trời xanh mây trắng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '飞行员',
      'fēixíngyuán',
      'phi công',
      'Danh từ',
      'HSK 5',
      '他从小就立志当一名民航飞行员，驾驶客机在蓝天白云间穿梭。',
      'Tā cóngxiǎo jiù lìzhì dāng yì míng mínháng fēixíngyuán, jiàshǐ kèjī zài lántiān báiyún jiān chuānsuō.',
      'Từ nhỏ anh ấy đã lập chí trở thành một phi công hàng không dân dụng, lái máy bay chở khách lướt đi giữa trời xanh mây trắng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他从小就立志当一名民航飞行员，驾驶客机在蓝天白云间穿梭。', 'Tā cóngxiǎo jiù lìzhì dāng yì míng mínháng fēixíngyuán, jiàshǐ kèjī zài lántiān báiyún jiān chuānsuō.', 'Từ nhỏ anh ấy đã lập chí trở thành một phi công hàng không dân dụng, lái máy bay chở khách lướt đi giữa trời xanh mây trắng.', 'basic', 1),
      (v_id, '在突发单侧发动机故障的极端险情下，机长与副飞行员凭借过硬的专业心理素质与娴熟的操作技巧化险为夷，确保了机上数百名乘客的安全。', 'Zài tūfā dāncè fādòngjī gùzhàng de jíduān xiǎnqíng xià, jīzhǎng yǔ fù fēixíngyuán píngjiè guòyìng de zhuānyè xīnlǐ sùzhì yǔ xiánshú de cāozuò jìqiǎo huàxiǎnwéiyí, quèbǎo le jī shàng shù bǎi míng chéngkè de ānquán.', 'Dưới tình huống cực kỳ hiểm nghèo khi một bên động cơ bất ngờ gặp sự cố, cơ trưởng cùng cơ phó đã dựa vào tố chất tâm lý chuyên nghiệp vững vàng và kỹ năng thao tác thuần thục để chuyển nguy thành an, bảo đảm tính mạng cho hàng trăm hành khách trên máy bay.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2347] [非洲] (Fēizhōu) - Châu Phi [Danh từ riêng / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '非洲' AND pinyin = 'Fēizhōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '非洲' AND pinyin = 'Fēizhōu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '非洲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '非洲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ riêng / Danh từ',
      pinyin = 'Fēizhōu',
      meaning_vi = 'Châu Phi',
      example_hanzi = '非洲大草原上生活着成群的斑马、长颈鹿和大象。',
      example_pinyin = 'Fēizhōu dà cǎoyuán shàng shēnghuó zhe chéngqún de bānmǎ, chángjǐnglù hé dàxiàng.',
      example_vi = 'Trên thảo nguyên bao la Châu Phi có từng đàn ngựa vằn, hươu cao cổ và voi sinh sống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '非洲',
      'Fēizhōu',
      'Châu Phi',
      'Danh từ riêng / Danh từ',
      'HSK 5',
      '非洲大草原上生活着成群的斑马、长颈鹿和大象。',
      'Fēizhōu dà cǎoyuán shàng shēnghuó zhe chéngqún de bānmǎ, chángjǐnglù hé dàxiàng.',
      'Trên thảo nguyên bao la Châu Phi có từng đàn ngựa vằn, hươu cao cổ và voi sinh sống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '非洲大草原上生活着成群的斑马、长颈鹿和大象。', 'Fēizhōu dà cǎoyuán shàng shēnghuó zhe chéngqún de bānmǎ, chángjǐnglù hé dàxiàng.', 'Trên thảo nguyên bao la Châu Phi có từng đàn ngựa vằn, hươu cao cổ và voi sinh sống.', 'basic', 1),
      (v_id, '近年来中非双方在基础设施互联互通、清洁能源开发以及农业技术转让等领域的务实合作结出了丰硕成果。', 'Jìnniánlái Zhōng-Fēi shuāngfāng zài jīchǔ shèshī hùliánhùtōng, qīngjié néngyuán kāifā yǐjí nóngyè jìshù zhuǎnràng děng lǐngyù de wùshí hézuò jié chū le fēngshuò chéngguǒ.', 'Những năm gần đây sự hợp tác thực chất giữa Trung Quốc và Châu Phi trong các lĩnh vực kết nối cơ sở hạ tầng, phát triển năng lượng sạch cũng như chuyển giao công nghệ nông nghiệp đã gặt hái nhiều thành quả bội thu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2348] [分别] (fēnbié) - chia tay; lần lượt, tương ứng; phân biệt, sự khác biệt [Động từ / Phó từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '分别' AND pinyin = 'fēnbié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分别' AND pinyin = 'fēnbié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '分别'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分别'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Phó từ / Danh từ',
      pinyin = 'fēnbié',
      meaning_vi = 'chia tay; lần lượt, tương ứng; phân biệt, sự khác biệt',
      example_hanzi = '大学毕业典礼结束后，同学们依依不舍地互相道别，踏上了分别的人生旅程。',
      example_pinyin = 'Dàxué bìyè diǎnlǐ jiéshù hòu, tóngxuémen yīyībùshě de hùxiāng dàobié, tà shàng le fēnbié de rénshēng lǚchéng.',
      example_vi = 'Sau khi lễ tốt nghiệp đại học kết thúc, các bạn học quyến luyến bịn rịn nói lời chia tay nhau, bước lên những hành trình cuộc đời riêng biệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '分别',
      'fēnbié',
      'chia tay; lần lượt, tương ứng; phân biệt, sự khác biệt',
      'Động từ / Phó từ / Danh từ',
      'HSK 5',
      '大学毕业典礼结束后，同学们依依不舍地互相道别，踏上了分别的人生旅程。',
      'Dàxué bìyè diǎnlǐ jiéshù hòu, tóngxuémen yīyībùshě de hùxiāng dàobié, tà shàng le fēnbié de rénshēng lǚchéng.',
      'Sau khi lễ tốt nghiệp đại học kết thúc, các bạn học quyến luyến bịn rịn nói lời chia tay nhau, bước lên những hành trình cuộc đời riêng biệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大学毕业典礼结束后，同学们依依不舍地互相道别，踏上了分别的人生旅程。', 'Dàxué bìyè diǎnlǐ jiéshù hòu, tóngxuémen yīyībùshě de hùxiāng dàobié, tà shàng le fēnbié de rénshēng lǚchéng.', 'Sau khi lễ tốt nghiệp đại học kết thúc, các bạn học quyến luyến bịn rịn nói lời chia tay nhau, bước lên những hành trình cuộc đời riêng biệt.', 'basic', 1),
      (v_id, '根据最新季度财报，该公司在亚洲、欧洲和北美三大区域市场的营收占比分别达到了百分之四十五、百分之三十和百分之二十五。', 'Gēnjù zuìxīn jìdù cáibào, gāi gōngsī zài Yàzhōu, Ōuzhōu hé Běiměi sān dà qūyù shìchǎng de yíngshōu zhànbǐ fēnbié dádào le bǎifēnzhī sìshíwǔ, bǎifēnzhī sānshí hé bǎifēnzhī èrshíwǔ.', 'Theo báo cáo tài chính quý mới nhất, tỷ trọng doanh thu của công ty này tại ba thị trường khu vực lớn là Châu Á, Châu Âu và Bắc Mỹ lần lượt đạt mức 45%, 30% và 25%.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2349] [分布] (fēnbù) - phân bố, rải rác [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '分布' AND pinyin = 'fēnbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分布' AND pinyin = 'fēnbù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '分布'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分布'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fēnbù',
      meaning_vi = 'phân bố, rải rác',
      example_hanzi = '这种珍稀野生植物主要分布在云南和四川两省的高海拔原始森林中。',
      example_pinyin = 'Zhè zhǒng zhēnxī yěshēng zhíwù zhǔyào fēnbù zài Yúnnán hé Sìchuān liǎng shěng de gāo hǎibá yuánshǐ sēnlín zhōng.',
      example_vi = 'Loại thực vật hoang dã quý hiếm này chủ yếu phân bố trong các khu rừng nguyên sinh độ cao lớn ở hai tỉnh Vân Nam và Tứ Xuyên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '分布',
      'fēnbù',
      'phân bố, rải rác',
      'Động từ',
      'HSK 5',
      '这种珍稀野生植物主要分布在云南和四川两省的高海拔原始森林中。',
      'Zhè zhǒng zhēnxī yěshēng zhíwù zhǔyào fēnbù zài Yúnnán hé Sìchuān liǎng shěng de gāo hǎibá yuánshǐ sēnlín zhōng.',
      'Loại thực vật hoang dã quý hiếm này chủ yếu phân bố trong các khu rừng nguyên sinh độ cao lớn ở hai tỉnh Vân Nam và Tứ Xuyên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这种珍稀野生植物主要分布在云南和四川两省的高海拔原始森林中。', 'Zhè zhǒng zhēnxī yěshēng zhíwù zhǔyào fēnbù zài Yúnnán hé Sìchuān liǎng shěng de gāo hǎibá yuánshǐ sēnlín zhōng.', 'Loại thực vật hoang dã quý hiếm này chủ yếu phân bố trong các khu rừng nguyên sinh độ cao lớn ở hai tỉnh Vân Nam và Tứ Xuyên.', 'basic', 1),
      (v_id, '为优化全球供应链响应速度，该跨国物流集团在沿海各大核心枢纽港口合理分布了数十个现代自动化立体智能仓储中心。', 'Wèi yōuhuà quánqiú gōngyìngliàn xiǎngyìng sùdù, gāi kuàguó wùliú jítuán zài yánhǎi gè dà héxīn shūniǔ gǎngkǒu hélǐ fēnbù le shù shí gè xiàndài zìdònghuà lìtǐ zhìnéng cāngchǔ zhōngxīn.', 'Nhằm tối ưu hóa tốc độ phản hồi của chuỗi cung ứng toàn cầu, tập đoàn hậu cần logistics xuyên quốc gia này đã phân bố hợp lý hàng chục trung tâm kho bãi thông minh đa tầng tự động hóa hiện đại tại khắp các cảng đầu mối ven biển cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2350] [纷纷] (fēnfēn) - tới tấp, dồn dập, rầm rộ, nối tiếp nhau [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '纷纷' AND pinyin = 'fēnfēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纷纷' AND pinyin = 'fēnfēn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '纷纷'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纷纷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'fēnfēn',
      meaning_vi = 'tới tấp, dồn dập, rầm rộ, nối tiếp nhau',
      example_hanzi = '深秋时节微风吹拂，金黄色的银杏树叶纷纷飘落下来。',
      example_pinyin = 'Shēnqiū shíjié wēifēng chuīfú, jīnhuángsè de yínxìng shùyè fēnfēn piāoluò xiàlái.',
      example_vi = 'Tiết trời cuối thu gió thoảng nhẹ, những chiếc lá ngân hạnh màu vàng óng nối tiếp nhau bay lượn rơi xuống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '纷纷',
      'fēnfēn',
      'tới tấp, dồn dập, rầm rộ, nối tiếp nhau',
      'Tính từ / Phó từ',
      'HSK 5',
      '深秋时节微风吹拂，金黄色的银杏树叶纷纷飘落下来。',
      'Shēnqiū shíjié wēifēng chuīfú, jīnhuángsè de yínxìng shùyè fēnfēn piāoluò xiàlái.',
      'Tiết trời cuối thu gió thoảng nhẹ, những chiếc lá ngân hạnh màu vàng óng nối tiếp nhau bay lượn rơi xuống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '深秋时节微风吹拂，金黄色的银杏树叶纷纷飘落下来。', 'Shēnqiū shíjié wēifēng chuīfú, jīnhuángsè de yínxìng shùyè fēnfēn piāoluò xiàlái.', 'Tiết trời cuối thu gió thoảng nhẹ, những chiếc lá ngân hạnh màu vàng óng nối tiếp nhau bay lượn rơi xuống.', 'basic', 1),
      (v_id, '随着扶持科技创新政策的重磅出台，各家风险投资基金纷纷将战略目光聚焦在具身智能与低空经济赛道。', 'Suízhe fúchí kējì chuàngxīn zhèngcè de zhòngbàng chūtái, gè jiā fēngxiǎn tóuzī jījīn fēnfēn jiāng zhànlüè mùguāng jùjiāo zài jùshēn zhìnéng yǔ dīkōng jīngjì sàidào.', 'Cùng với sự ra đời đầy sức nặng của các chính sách trợ lực đổi mới công nghệ, các quỹ đầu tư mạo hiểm đã rầm rộ hướng tầm nhìn chiến lược tập trung vào đường đua trí tuệ hiện thân (embodied AI) và kinh tế tầm bay thấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2351] [分类] (fēnlèi) - phân loại, sự phân loại [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '分类' AND pinyin = 'fēnlèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分类' AND pinyin = 'fēnlèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '分类'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分类'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'fēnlèi',
      meaning_vi = 'phân loại, sự phân loại',
      example_hanzi = '积极做好生活垃圾分类，是每一个公民践行环保生活的文明举动。',
      example_pinyin = 'Jījí zuò hǎo shēnghuó lājī fēnlèi, shì měi yí gè gōngmín jiànxíng huánbǎo shēnghuó de wénmíng jǔdòng.',
      example_vi = 'Tích cực làm tốt việc phân loại rác thải sinh hoạt là hành vi văn minh của mỗi một công dân trong việc thực hành lối sống bảo vệ môi trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '分类',
      'fēnlèi',
      'phân loại, sự phân loại',
      'Động từ / Danh từ',
      'HSK 5',
      '积极做好生活垃圾分类，是每一个公民践行环保生活的文明举动。',
      'Jījí zuò hǎo shēnghuó lājī fēnlèi, shì měi yí gè gōngmín jiànxíng huánbǎo shēnghuó de wénmíng jǔdòng.',
      'Tích cực làm tốt việc phân loại rác thải sinh hoạt là hành vi văn minh của mỗi một công dân trong việc thực hành lối sống bảo vệ môi trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '积极做好生活垃圾分类，是每一个公民践行环保生活的文明举动。', 'Jījí zuò hǎo shēnghuó lājī fēnlèi, shì měi yí gè gōngmín jiànxíng huánbǎo shēnghuó de wénmíng jǔdòng.', 'Tích cực làm tốt việc phân loại rác thải sinh hoạt là hành vi văn minh của mỗi một công dân trong việc thực hành lối sống bảo vệ môi trường.', 'basic', 1),
      (v_id, '该电商大数据引擎通过多模态深度学习算法，实现了海量非结构化商品图像与属性标签的自动化高精准智能分类。', 'Gāi diànshāng dàshùjù yǐnqíng tōngguò duōmótài shēndù xuéxí suànfǎ, shíxiàn le hǎiliàng fēi jiégòuhuà shāngpǐn túxiàng yǔ shǔxìng biāoqiān de zìdònghuà gāojīngzhǔn zhìnéng fēnlèi.', 'Bộ máy dữ liệu lớn thương mại điện tử này thông qua thuật toán học sâu đa phương thức, đã thực hiện việc phân loại thông minh chuẩn xác cao tự động hóa đối với lượng lớn hình ảnh sản phẩm phi cấu trúc và nhãn thuộc tính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2352] [分离] (fēnlí) - chia lìa, tách rời, phân ly [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '分离' AND pinyin = 'fēnlí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分离' AND pinyin = 'fēnlí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '分离'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分离'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fēnlí',
      meaning_vi = 'chia lìa, tách rời, phân ly',
      example_hanzi = '长时间与家人分离，让他常常在异国他乡的深夜里感到格外孤独。',
      example_pinyin = 'Cháng shíjiān yǔ jiārén fēnlí, ràng tā chángcháng zài yìguó tāxiāng de shēnyè lǐ gǎndào géwài gūdú.',
      example_vi = 'Việc phải chia lìa người thân trong thời gian dài khiến anh ấy thường cảm thấy vô cùng cô đơn giữa đêm khuya nơi đất khách quê người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '分离',
      'fēnlí',
      'chia lìa, tách rời, phân ly',
      'Động từ',
      'HSK 5',
      '长时间与家人分离，让他常常在异国他乡的深夜里感到格外孤独。',
      'Cháng shíjiān yǔ jiārén fēnlí, ràng tā chángcháng zài yìguó tāxiāng de shēnyè lǐ gǎndào géwài gūdú.',
      'Việc phải chia lìa người thân trong thời gian dài khiến anh ấy thường cảm thấy vô cùng cô đơn giữa đêm khuya nơi đất khách quê người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长时间与家人分离，让他常常在异国他乡的深夜里感到格外孤独。', 'Cháng shíjiān yǔ jiārén fēnlí, ràng tā chángcháng zài yìguó tāxiāng de shēnyè lǐ gǎndào géwài gūdú.', 'Việc phải chia lìa người thân trong thời gian dài khiến anh ấy thường cảm thấy vô cùng cô đơn giữa đêm khuya nơi đất khách quê người.', 'basic', 1),
      (v_id, '实验室采用了最新的离心萃取技术，成功从植物提取液中将两种具有高药用价值的有效成分彻底分离。', 'Shíyànshì cǎiyòng le zuìxīn de líxīn cuìqǔ jìshù, chénggōng cóng zhíwù tíqǔyè zhōng jiāng liǎng zhǒng jùyǒu gāo yàoyòng jiàzhí de yǒuxiào chéngfèn chèdǐ fēnlí.', 'Phòng thí nghiệm đã áp dụng công nghệ chiết ly tâm mới nhất, tách rời triệt để thành công hai thành phần hữu hiệu có giá trị dược liệu cao từ dịch chiết thực vật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2353] [分配] (fēnpèi) - phân bổ, phân phối, phân chia [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '分配' AND pinyin = 'fēnpèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分配' AND pinyin = 'fēnpèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '分配'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分配'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fēnpèi',
      meaning_vi = 'phân bổ, phân phối, phân chia',
      example_hanzi = '项目经理根据团队成员各自的专业特长合理分配了每周的工作任务。',
      example_pinyin = 'Xiàngmù jīnglǐ gēnjù tuánduì chéngyuán gèzì de zhuānyè tècháng hélǐ fēnpèi le měi zhōu de gōngzuò rènwu.',
      example_vi = 'Người quản lý dự án đã phân bổ hợp lý nhiệm vụ công việc mỗi tuần dựa theo thế mạnh chuyên môn của từng thành viên trong nhóm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '分配',
      'fēnpèi',
      'phân bổ, phân phối, phân chia',
      'Động từ',
      'HSK 5',
      '项目经理根据团队成员各自的专业特长合理分配了每周的工作任务。',
      'Xiàngmù jīnglǐ gēnjù tuánduì chéngyuán gèzì de zhuānyè tècháng hélǐ fēnpèi le měi zhōu de gōngzuò rènwu.',
      'Người quản lý dự án đã phân bổ hợp lý nhiệm vụ công việc mỗi tuần dựa theo thế mạnh chuyên môn của từng thành viên trong nhóm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '项目经理根据团队成员各自的专业特长合理分配了每周的工作任务。', 'Xiàngmù jīnglǐ gēnjù tuánduì chéngyuán gèzì de zhuānyè tècháng hélǐ fēnpèi le měi zhōu de gōngzuò rènwu.', 'Người quản lý dự án đã phân bổ hợp lý nhiệm vụ công việc mỗi tuần dựa theo thế mạnh chuyên môn của từng thành viên trong nhóm.', 'basic', 1),
      (v_id, '在年终股东大会上，董事会审议并通过了关于本年度税后净利润分配与员工股权激励的综合方案。', 'Zài niánzhōng gǔdōng dàhuì shang, dǒngshìhuì shěnyì bìng tōngguò le guānyú běn niándù shuìhòu jìnglìrùn fēnpèi yǔ yuángōng gǔquán jīlì de zōnghé fāng’àn.', 'Tại đại hội cổ đông cuối năm, hội đồng quản trị đã xem xét và thông qua phương án tổng thể về phân chia lợi nhuận ròng sau thuế và khuyến khích cổ phần cho nhân viên trong năm nay.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2354] [分手] (fēnshǒu) - chia tay, từ biệt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '分手' AND pinyin = 'fēnshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分手' AND pinyin = 'fēnshǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '分手'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分手'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fēnshǒu',
      meaning_vi = 'chia tay, từ biệt',
      example_hanzi = '他们因为性格不合，在深思熟虑后和平分手了。',
      example_pinyin = 'Tāmen yīnwèi xìnggé bùhé, zài shēnsī-shúlǜ hòu hépíng fēnshǒu le.',
      example_vi = 'Họ vì tính cách không hợp nên sau khi suy nghĩ chín chắn đã quyết định chia tay trong hòa bình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '分手',
      'fēnshǒu',
      'chia tay, từ biệt',
      'Động từ',
      'HSK 5',
      '他们因为性格不合，在深思熟虑后和平分手了。',
      'Tāmen yīnwèi xìnggé bùhé, zài shēnsī-shúlǜ hòu hépíng fēnshǒu le.',
      'Họ vì tính cách không hợp nên sau khi suy nghĩ chín chắn đã quyết định chia tay trong hòa bình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他们因为性格不合，在深思熟虑后和平分手了。', 'Tāmen yīnwèi xìnggé bùhé, zài shēnsī-shúlǜ hòu hépíng fēnshǒu le.', 'Họ vì tính cách không hợp nên sau khi suy nghĩ chín chắn đã quyết định chia tay trong hòa bình.', 'basic', 1),
      (v_id, '在大学毕业典礼结束后，朝夕相处四年的同窗好友们在校门口依依不舍地握手拥抱，挥泪分手。', 'Zài dàxué bìyè diǎnlǐ jiéshù hòu, zhāoxī-xiāngchǔ sì nián de tóngchuāng hǎoyǒu men zài xiàomén kǒu yīyī-bùshě de wòshǒu yōngbào, huī lèi fēnshǒu.', 'Sau khi lễ tốt nghiệp đại học kết thúc, những người bạn đồng môn gắn bó sớm tối suốt bốn năm đã bịn rịn bắt tay ôm nhau, gạt nước mắt chia tay ngay tại cổng trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2355] [分析] (fēnxī) - phân tích [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '分析' AND pinyin = 'fēnxī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分析' AND pinyin = 'fēnxī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '分析'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分析'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'fēnxī',
      meaning_vi = 'phân tích',
      example_hanzi = '在做最终决定之前，我们必须对市场调查问卷收集到的数据进行仔细分析。',
      example_pinyin = 'Zài zuò zuìzhōng juédìng zhīqián, wǒmen bìxū duì shìchǎng diàochá wènjuàn shǒují dào de shùjù jìnxíng zǐxì fēnxī.',
      example_vi = 'Trước khi đưa ra quyết định cuối cùng, chúng ta nhất định phải tiến hành phân tích kỹ lưỡng dữ liệu thu thập được từ bảng khảo sát thị trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '分析',
      'fēnxī',
      'phân tích',
      'Động từ / Danh từ',
      'HSK 5',
      '在做最终决定之前，我们必须对市场调查问卷收集到的数据进行仔细分析。',
      'Zài zuò zuìzhōng juédìng zhīqián, wǒmen bìxū duì shìchǎng diàochá wènjuàn shǒují dào de shùjù jìnxíng zǐxì fēnxī.',
      'Trước khi đưa ra quyết định cuối cùng, chúng ta nhất định phải tiến hành phân tích kỹ lưỡng dữ liệu thu thập được từ bảng khảo sát thị trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在做最终决定之前，我们必须对市场调查问卷收集到的数据进行仔细分析。', 'Zài zuò zuìzhōng juédìng zhīqián, wǒmen bìxū duì shìchǎng diàochá wènjuàn shǒují dào de shùjù jìnxíng zǐxì fēnxī.', 'Trước khi đưa ra quyết định cuối cùng, chúng ta nhất định phải tiến hành phân tích kỹ lưỡng dữ liệu thu thập được từ bảng khảo sát thị trường.', 'basic', 1),
      (v_id, '资深行业分析师结合宏观经济走势与行业产业链动态，深入分析了该新能源科技企业未来的核心竞争优势与潜在财务风险。', 'Zīshēn hángyè fēnxīshī jiéhé hóngguān jīngjì zǒushì yǔ hángyè chǎnyèliàn dòngtài, shēnrù fēnxī le gāi xīnnéngyuán kējì qǐyè wèilái de héxīn jìngzhēng yōushì yǔ qiánzài cáiwù fēngxiǎn.', 'Chuyên gia phân tích ngành kỳ cựu kết hợp xu thế kinh tế vĩ mô và biến động chuỗi cung ứng ngành, đã phân tích sâu sắc lợi thế cạnh tranh cốt lõi cùng những rủi ro tài chính tiềm ẩn trong tương lai của doanh nghiệp công nghệ năng lượng mới này.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2356] [分享] (fēnxiǎng) - chia sẻ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '分享' AND pinyin = 'fēnxiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分享' AND pinyin = 'fēnxiǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '分享'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '分享'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fēnxiǎng',
      meaning_vi = 'chia sẻ',
      example_hanzi = '他非常乐意把自己学好外语的心得体会和实用的备考方法分享给同学们。',
      example_pinyin = 'Tā fēicháng lèyì bǎ zìjǐ xué hǎo wàiyǔ de xīndé tǐhuì hé shíyòng de bèikǎo fāngfǎ fēnxiǎng gěi tóngxué men.',
      example_vi = 'Anh ấy rất sẵn lòng chia sẻ với các bạn cùng lớp những trải nghiệm tâm đắc khi học tốt ngoại ngữ và các phương pháp ôn thi thiết thực của mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '分享',
      'fēnxiǎng',
      'chia sẻ',
      'Động từ',
      'HSK 5',
      '他非常乐意把自己学好外语的心得体会和实用的备考方法分享给同学们。',
      'Tā fēicháng lèyì bǎ zìjǐ xué hǎo wàiyǔ de xīndé tǐhuì hé shíyòng de bèikǎo fāngfǎ fēnxiǎng gěi tóngxué men.',
      'Anh ấy rất sẵn lòng chia sẻ với các bạn cùng lớp những trải nghiệm tâm đắc khi học tốt ngoại ngữ và các phương pháp ôn thi thiết thực của mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他非常乐意把自己学好外语的心得体会和实用的备考方法分享给同学们。', 'Tā fēicháng lèyì bǎ zìjǐ xué hǎo wàiyǔ de xīndé tǐhuì hé shíyòng de bèikǎo fāngfǎ fēnxiǎng gěi tóngxué men.', 'Anh ấy rất sẵn lòng chia sẻ với các bạn cùng lớp những trải nghiệm tâm đắc khi học tốt ngoại ngữ và các phương pháp ôn thi thiết thực của mình.', 'basic', 1),
      (v_id, '在国际青年创业者交流论坛上，多位独角兽企业创始人不仅分享了商业模式创新的宝贵实战经验，还慷慨分享了面对行业低谷时的心理调适智慧。', 'Zài guójì qīngnián chuàngyèzhě jiāoliú lùntán shang, duō wèi dújiǎoshòu qǐyè chuàngshǐrén bùjǐn fēnxiǎng le shāngyè móshì chuàngxīn de bǎoguì shízhàn jīngyàn, hái kāngkǎi fēnxiǎng le miànduì hángyè dīgǔ shí de xīnlǐ tiáoshì zhìhuì.', 'Tại diễn đàn giao lưu các nhà khởi nghiệp trẻ quốc tế, nhiều nhà sáng lập doanh nghiệp kỳ lân không chỉ chia sẻ kinh nghiệm thực chiến quý báu về đổi mới mô hình kinh doanh, mà còn hào phóng chia sẻ trí tuệ điều chỉnh tâm lý khi đối mặt với giai đoạn chạm đáy của ngành.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2357] [奋斗] (fèndòu) - phấn đấu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '奋斗' AND pinyin = 'fèndòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '奋斗' AND pinyin = 'fèndòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '奋斗'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '奋斗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'fèndòu',
      meaning_vi = 'phấn đấu',
      example_hanzi = '只要为了心中的崇高理想而不懈奋斗，平凡的人生也能绽放出耀眼的光芒。',
      example_pinyin = 'Zhǐyào wèile xīnzhōng de chónggāo lǐxiǎng ér búxiè fèndòu, píngfán de rénshēng yě néng zhànfàng chū yàoyǎn de guāngmáng.',
      example_vi = 'Chỉ cần không ngừng phấn đấu vì lý tưởng cao đẹp trong tim, cuộc đời bình dị cũng có thể tỏa ra ánh hào quang rực rỡ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '奋斗',
      'fèndòu',
      'phấn đấu',
      'Động từ / Danh từ',
      'HSK 5',
      '只要为了心中的崇高理想而不懈奋斗，平凡的人生也能绽放出耀眼的光芒。',
      'Zhǐyào wèile xīnzhōng de chónggāo lǐxiǎng ér búxiè fèndòu, píngfán de rénshēng yě néng zhànfàng chū yàoyǎn de guāngmáng.',
      'Chỉ cần không ngừng phấn đấu vì lý tưởng cao đẹp trong tim, cuộc đời bình dị cũng có thể tỏa ra ánh hào quang rực rỡ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只要为了心中的崇高理想而不懈奋斗，平凡的人生也能绽放出耀眼的光芒。', 'Zhǐyào wèile xīnzhōng de chónggāo lǐxiǎng ér búxiè fèndòu, píngfán de rénshēng yě néng zhànfàng chū yàoyǎn de guāngmáng.', 'Chỉ cần không ngừng phấn đấu vì lý tưởng cao đẹp trong tim, cuộc đời bình dị cũng có thể tỏa ra ánh hào quang rực rỡ.', 'basic', 1),
      (v_id, '老一辈航天科研工作者隐姓埋名数十年，在荒芜戈壁滩上艰苦奋斗，终于攻克了一道道国家级战略重大科技难题。', 'Lǎo yí bèi hángtiān kēyán gōngzuòzhě yǐnxìng-máimíng shù shí nián, zài huāngwú gēbìtān shang jiānkǔ fèndòu, zhōngyú gōngkè le yídàodào guójiājí zhànlüè zhòngdà kējì nántí.', 'Thế hệ những nhà nghiên cứu khoa học hàng không vũ trụ đi trước đã mai danh ẩn tích suốt hàng chục năm, gian khổ phấn đấu trên bãi sa mạc hoang vu, cuối cùng đã chinh phục thành công hàng loạt bài toán nan giải về công nghệ chiến lược cấp quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2358] [丰富多彩] (fēngfù-duōcǎi) - phong phú đa dạng, muôn màu muôn vẻ [Thành ngữ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '丰富多彩' AND pinyin = 'fēngfù-duōcǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '丰富多彩' AND pinyin = 'fēngfù-duōcǎi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '丰富多彩'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '丰富多彩'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thành ngữ / Tính từ',
      pinyin = 'fēngfù-duōcǎi',
      meaning_vi = 'phong phú đa dạng, muôn màu muôn vẻ',
      example_hanzi = '学校为学生们安排了丰富多彩的课外社团活动与体育比赛。',
      example_pinyin = 'Xuéxiào wèi xuésheng men ānpái le fēngfù-duōcǎi de kèwài shètuán huódòng yǔ tǐyù bǐsài.',
      example_vi = 'Nhà trường đã sắp xếp cho các bạn học sinh những hoạt động câu lạc bộ ngoại khóa và các trận thi đấu thể thao phong phú đa dạng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '丰富多彩',
      'fēngfù-duōcǎi',
      'phong phú đa dạng, muôn màu muôn vẻ',
      'Thành ngữ / Tính từ',
      'HSK 5',
      '学校为学生们安排了丰富多彩的课外社团活动与体育比赛。',
      'Xuéxiào wèi xuésheng men ānpái le fēngfù-duōcǎi de kèwài shètuán huódòng yǔ tǐyù bǐsài.',
      'Nhà trường đã sắp xếp cho các bạn học sinh những hoạt động câu lạc bộ ngoại khóa và các trận thi đấu thể thao phong phú đa dạng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校为学生们安排了丰富多彩的课外社团活动与体育比赛。', 'Xuéxiào wèi xuésheng men ānpái le fēngfù-duōcǎi de kèwài shètuán huódòng yǔ tǐyù bǐsài.', 'Nhà trường đã sắp xếp cho các bạn học sinh những hoạt động câu lạc bộ ngoại khóa và các trận thi đấu thể thao phong phú đa dạng.', 'basic', 1),
      (v_id, '这座历史文化名城不仅保留着古朴典雅的传统街巷风貌，更通过现代艺术节、音乐会和非遗体验项目，展现出丰富多彩的城市文化活力。', 'Zhè zuò lìshǐ wénhuà míngchéng bùjǐn bǎoliú zhe gǔpǔ diǎnyǎ de chuántǒng jiēxiàng fēngmào, gèng tōngguò xiàndài yìshùjié, yīnyuèhuì hé fēiyí tǐyàn xiàngmù, zhǎnxiàn chū fēngfù-duōcǎi de chéngshì wénhuà huólì.', 'Thành phố lịch sử văn hóa nổi tiếng này không chỉ lưu giữ diện mạo phố phường cổ kính tao nhã, mà còn thể hiện sức sống văn hóa đô thị muôn màu muôn vẻ thông qua các lễ hội nghệ thuật hiện đại, buổi hòa nhạc và dự án trải nghiệm di sản văn hóa phi vật thể.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2359] [风格] (fēnggé) - phong cách [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '风格' AND pinyin = 'fēnggé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '风格' AND pinyin = 'fēnggé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '风格'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '风格'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fēnggé',
      meaning_vi = 'phong cách',
      example_hanzi = '这位室内设计师的作品风格简约现代，非常受年轻业主的青睐。',
      example_pinyin = 'Zhè wèi shìnèi shèjìshī de zuòpǐn fēnggé jiǎnyuē xiàndài, fēicháng shòu niánqīng yèzhǔ de qīnglài.',
      example_vi = 'Tác phẩm của nhà thiết kế nội thất này mang phong cách tối giản và hiện đại, rất được lòng các chủ nhà trẻ tuổi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '风格',
      'fēnggé',
      'phong cách',
      'Danh từ',
      'HSK 5',
      '这位室内设计师的作品风格简约现代，非常受年轻业主的青睐。',
      'Zhè wèi shìnèi shèjìshī de zuòpǐn fēnggé jiǎnyuē xiàndài, fēicháng shòu niánqīng yèzhǔ de qīnglài.',
      'Tác phẩm của nhà thiết kế nội thất này mang phong cách tối giản và hiện đại, rất được lòng các chủ nhà trẻ tuổi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位室内设计师的作品风格简约现代，非常受年轻业主的青睐。', 'Zhè wèi shìnèi shèjìshī de zuòpǐn fēnggé jiǎnyuē xiàndài, fēicháng shòu niánqīng yèzhǔ de qīnglài.', 'Tác phẩm của nhà thiết kế nội thất này mang phong cách tối giản và hiện đại, rất được lòng các chủ nhà trẻ tuổi.', 'basic', 1),
      (v_id, '这位当代作家在长篇叙事小说中巧妙融合了古典文学的典雅含蓄与现代意识流技巧，形成了独树一帜的文学语言风格。', 'Zhè wèi dāngdài zuòjiā zài chángpiān xùshì xiǎoshuō zhōng qiǎomiào rónghé le gǔdiǎn wénxué de diǎnyǎ hánxù yǔ xiàndài yìshíliú jìqiǎo, xíngchéng le dúshù-yízhì de wénxué yǔyán fēnggé.', 'Nhà văn đương đại này đã khéo léo dung hòa nét tao nhã hàm súc của văn học cổ điển cùng kỹ thuật dòng ý thức hiện đại trong cuốn tiểu thuyết tự sự dài tập, tạo nên phong cách ngôn ngữ văn học độc đáo riêng biệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2360] [疯狂] (fēngkuáng) - điên cuồng, cuồng nhiệt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '疯狂' AND pinyin = 'fēngkuáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '疯狂' AND pinyin = 'fēngkuáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '疯狂'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '疯狂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'fēngkuáng',
      meaning_vi = 'điên cuồng, cuồng nhiệt',
      example_hanzi = '听见主队在比赛最后十秒完成逆转绝杀，全场球迷顿时陷入了疯狂的欢呼中。',
      example_pinyin = 'Tīngjiàn zhǔduì zài bǐsài zuìhòu shí miǎo wánchéng nìzhuǎn juéshā, quánchǎng qiúmí dùnshí xiànrù le fēngkuáng de huānhū zhōng.',
      example_vi = 'Nghe thấy đội nhà lội ngược dòng ghi bàn ấn định chiến thắng ở mười giây cuối trận, toàn thể cổ động viên trên sân lập tức rơi vào sự hò reo cuồng nhiệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '疯狂',
      'fēngkuáng',
      'điên cuồng, cuồng nhiệt',
      'Tính từ',
      'HSK 5',
      '听见主队在比赛最后十秒完成逆转绝杀，全场球迷顿时陷入了疯狂的欢呼中。',
      'Tīngjiàn zhǔduì zài bǐsài zuìhòu shí miǎo wánchéng nìzhuǎn juéshā, quánchǎng qiúmí dùnshí xiànrù le fēngkuáng de huānhū zhōng.',
      'Nghe thấy đội nhà lội ngược dòng ghi bàn ấn định chiến thắng ở mười giây cuối trận, toàn thể cổ động viên trên sân lập tức rơi vào sự hò reo cuồng nhiệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听见主队在比赛最后十秒完成逆转绝杀，全场球迷顿时陷入了疯狂的欢呼中。', 'Tīngjiàn zhǔduì zài bǐsài zuìhòu shí miǎo wánchéng nìzhuǎn juéshā, quánchǎng qiúmí dùnshí xiànrù le fēngkuáng de huānhū zhōng.', 'Nghe thấy đội nhà lội ngược dòng ghi bàn ấn định chiến thắng ở mười giây cuối trận, toàn thể cổ động viên trên sân lập tức rơi vào sự hò reo cuồng nhiệt.', 'basic', 1),
      (v_id, '监管机构对短期内资金过度涌入投机性金融衍生品领域的疯狂炒作行为发布了严正风险警示，以维护资本市场稳健运行。', 'Jiānguǎn jīgòu duì duǎnqī nèi zījīn guòdù yǒngrù tóujīxìng jīnróng yǎnshēngpǐn lǐngyù de fēngkuáng chǎozuò xíngwéi fābù le yánzhèng fēngxiǎn jǐngshì, yǐ wéihù zīběn shìchǎng wěnjiàn yùnxíng.', 'Cơ quan quản lý đã phát đi cảnh báo rủi ro nghiêm khắc đối với hành vi đầu cơ thổi giá điên cuồng do dòng tiền ồ ạt đổ vào lĩnh vực sản phẩm phái sinh tài chính trong thời gian ngắn, nhằm bảo vệ thị trường vốn vận hành ổn định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2361] [风俗] (fēngsú) - phong tục, tập quán [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '风俗' AND pinyin = 'fēngsú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '风俗' AND pinyin = 'fēngsú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '风俗'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '风俗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fēngsú',
      meaning_vi = 'phong tục, tập quán',
      example_hanzi = '每逢春节，贴春联、吃年夜饭和拜年都是中华民族悠久的传统风俗。',
      example_pinyin = 'Měiféng Chūnjié, tiē chūnlián, chī niányèfàn hé bàinián dōu shì Zhōnghuá mínzú yōujiǔ de chuántǒng fēngsú.',
      example_vi = 'Mỗi dịp Tết Nguyên Đán, dán câu đối đỏ, ăn cơm tất niên và chúc Tết đều là những phong tục truyền thống lâu đời của dân tộc Trung Hoa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '风俗',
      'fēngsú',
      'phong tục, tập quán',
      'Danh từ',
      'HSK 5',
      '每逢春节，贴春联、吃年夜饭和拜年都是中华民族悠久的传统风俗。',
      'Měiféng Chūnjié, tiē chūnlián, chī niányèfàn hé bàinián dōu shì Zhōnghuá mínzú yōujiǔ de chuántǒng fēngsú.',
      'Mỗi dịp Tết Nguyên Đán, dán câu đối đỏ, ăn cơm tất niên và chúc Tết đều là những phong tục truyền thống lâu đời của dân tộc Trung Hoa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每逢春节，贴春联、吃年夜饭和拜年都是中华民族悠久的传统风俗。', 'Měiféng Chūnjié, tiē chūnlián, chī niányèfàn hé bàinián dōu shì Zhōnghuá mínzú yōujiǔ de chuántǒng fēngsú.', 'Mỗi dịp Tết Nguyên Đán, dán câu đối đỏ, ăn cơm tất niên và chúc Tết đều là những phong tục truyền thống lâu đời của dân tộc Trung Hoa.', 'basic', 1),
      (v_id, '民俗学者深入偏远少数民族村寨进行田野调查，系统记录并抢救整理了包括古老婚丧礼仪与岁时节令在内的一大批珍贵民间风俗。', 'Mínsú xuézhě shēnrù piānyuǎn shǎoshù mínzú cūnzhài jìnxíng tiányě diàochá, xìtǒng jìlù bìng qiǎngjiù zhěnglǐ le bāokuò gǔlǎo hūnsāng lǐyí yǔ suìshí jiélìng zài nèi de yí dà pī zhēnguì mínjiān fēngsú.', 'Nhà nghiên cứu phong tục học đã đi sâu vào các thôn bản vùng sâu dân tộc thiểu số để khảo sát thực địa, ghi chép có hệ thống và giải cứu thu thập một lượng lớn phong tục dân gian quý giá bao gồm cả nghi lễ cưới hỏi ma chay cổ xưa lẫn tiết khí mùa màng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2362] [风险] (fēngxiǎn) - rủi ro, mạo hiểm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '风险' AND pinyin = 'fēngxiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '风险' AND pinyin = 'fēngxiǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '风险'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '风险'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fēngxiǎn',
      meaning_vi = 'rủi ro, mạo hiểm',
      example_hanzi = '任何投资理财都有收益与风险并存的特性，入市前必须谨慎评估自身承受能力。',
      example_pinyin = 'Rènhé tóuzī lǐcái dōu yǒu shōuyì yǔ fēngxiǎn bìngcún de tèxìng, rùshì qián bìxū jǐnshèn pínggū zìshēn chéngshòu nénglì.',
      example_vi = 'Bất kỳ hình thức đầu tư tài chính nào cũng đều có tính chất lợi nhuận đi đôi với rủi ro, trước khi gia nhập thị trường nhất định phải thận trọng đánh giá khả năng chịu đựng của bản thân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '风险',
      'fēngxiǎn',
      'rủi ro, mạo hiểm',
      'Danh từ',
      'HSK 5',
      '任何投资理财都有收益与风险并存的特性，入市前必须谨慎评估自身承受能力。',
      'Rènhé tóuzī lǐcái dōu yǒu shōuyì yǔ fēngxiǎn bìngcún de tèxìng, rùshì qián bìxū jǐnshèn pínggū zìshēn chéngshòu nénglì.',
      'Bất kỳ hình thức đầu tư tài chính nào cũng đều có tính chất lợi nhuận đi đôi với rủi ro, trước khi gia nhập thị trường nhất định phải thận trọng đánh giá khả năng chịu đựng của bản thân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '任何投资理财都有收益与风险并存的特性，入市前必须谨慎评估自身承受能力。', 'Rènhé tóuzī lǐcái dōu yǒu shōuyì yǔ fēngxiǎn bìngcún de tèxìng, rùshì qián bìxū jǐnshèn pínggū zìshēn chéngshòu nénglì.', 'Bất kỳ hình thức đầu tư tài chính nào cũng đều có tính chất lợi nhuận đi đôi với rủi ro, trước khi gia nhập thị trường nhất định phải thận trọng đánh giá khả năng chịu đựng của bản thân.', 'basic', 1),
      (v_id, '商业银行建立了全流程数字化智能风控模型，实时监测跨境大额资金流向，有效防范并化解潜在的系统性金融信用违约风险。', 'Shāngyè yínháng jiànlì le quán liúchéng shùzìhuà zhìnéng fēngkòng móxíng, shíshí jiāncè kuàjìng dà’é zījīn liúxiàng, yǒuxiào fángfàn bìng huàjiě qiánzài de xìtǒngxìng jīnróng xìnyòng wéiyuē fēngxiǎn.', 'Ngân hàng thương mại đã thiết lập mô hình kiểm soát rủi ro thông minh số hóa toàn quy trình, giám sát theo thời gian thực dòng tiền lớn xuyên biên giới, phòng ngừa và hóa giải hiệu quả rủi ro vi phạm nghĩa vụ tín dụng tài chính mang tính hệ thống tiềm ẩn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2363] [否定] (fǒudìng) - phủ định, bác bỏ, tiêu cực [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '否定' AND pinyin = 'fǒudìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '否定' AND pinyin = 'fǒudìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '否定'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '否定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'fǒudìng',
      meaning_vi = 'phủ định, bác bỏ, tiêu cực',
      example_hanzi = '我们不能因为一次偶然的考试失利就全盘否定自己过去的努力。',
      example_pinyin = 'Wǒmen bù néng yīnwèi yí cì ǒurán de kǎoshì shīlì jiù quánpán fǒudìng zìjǐ guòqù de nǔlì.',
      example_vi = 'Chúng ta không thể vì một lần thi trượt ngẫu nhiên mà phủ định hoàn toàn mọi nỗ lực trong quá khứ của chính mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '否定',
      'fǒudìng',
      'phủ định, bác bỏ, tiêu cực',
      'Động từ / Tính từ',
      'HSK 5',
      '我们不能因为一次偶然的考试失利就全盘否定自己过去的努力。',
      'Wǒmen bù néng yīnwèi yí cì ǒurán de kǎoshì shīlì jiù quánpán fǒudìng zìjǐ guòqù de nǔlì.',
      'Chúng ta không thể vì một lần thi trượt ngẫu nhiên mà phủ định hoàn toàn mọi nỗ lực trong quá khứ của chính mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们不能因为一次偶然的考试失利就全盘否定自己过去的努力。', 'Wǒmen bù néng yīnwèi yí cì ǒurán de kǎoshì shīlì jiù quánpán fǒudìng zìjǐ guòqù de nǔlì.', 'Chúng ta không thể vì một lần thi trượt ngẫu nhiên mà phủ định hoàn toàn mọi nỗ lực trong quá khứ của chính mình.', 'basic', 1),
      (v_id, '经过严谨的双盲对照临床试验与统计学验证，专家评审委员会以压倒性多数给出了否定结论，推翻了该新药具有显著抗衰老疗效的最初假说。', 'Jīngguò yánjǐn de shuāngmáng duìzhào línchuáng shìyàn yǔ tǒngjìxué yànzhèng, zhuānjiā píngshěn wěiyuánhuì yǐ yādǎoxìng duōshù gěichū le fǒudìng jiélùn, tuīfān le gāi xīnyào jùyǒu xiǎnzhù kàngshuāilǎo liáoxiào de zuìchū jiǎshuō.', 'Sau các thử nghiệm lâm sàng mù đôi đối chứng và kiểm chứng thống kê học nghiêm ngặt, hội đồng chuyên gia thẩm định đã đưa ra kết luận phủ định với tỷ lệ áp đảo, bác bỏ giả thuyết ban đầu cho rằng loại thuốc mới này có hiệu quả chống lão hóa rõ rệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2364] [否认] (fǒurèn) - phủ nhận, chối bỏ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '否认' AND pinyin = 'fǒurèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '否认' AND pinyin = 'fǒurèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '否认'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '否认'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fǒurèn',
      meaning_vi = 'phủ nhận, chối bỏ',
      example_hanzi = '不可否认，持续的学习与广泛的阅读是开阔眼界最有效的途径。',
      example_pinyin = 'Bù kě fǒurèn, chíxù de xuéxí yǔ guǎngfàn de yuèdú shì kāikuò yǎnjiè zuì yǒuxiào de tújìng.',
      example_vi = 'Không thể phủ nhận rằng, việc không ngừng học hỏi và đọc sách rộng rãi là con đường hiệu quả nhất để mở rộng tầm mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '否认',
      'fǒurèn',
      'phủ nhận, chối bỏ',
      'Động từ',
      'HSK 5',
      '不可否认，持续的学习与广泛的阅读是开阔眼界最有效的途径。',
      'Bù kě fǒurèn, chíxù de xuéxí yǔ guǎngfàn de yuèdú shì kāikuò yǎnjiè zuì yǒuxiào de tújìng.',
      'Không thể phủ nhận rằng, việc không ngừng học hỏi và đọc sách rộng rãi là con đường hiệu quả nhất để mở rộng tầm mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '不可否认，持续的学习与广泛的阅读是开阔眼界最有效的途径。', 'Bù kě fǒurèn, chíxù de xuéxí yǔ guǎngfàn de yuèdú shì kāikuò yǎnjiè zuì yǒuxiào de tújìng.', 'Không thể phủ nhận rằng, việc không ngừng học hỏi và đọc sách rộng rãi là con đường hiệu quả nhất để mở rộng tầm mắt.', 'basic', 1),
      (v_id, '在大量确凿的监控录像与不可篡改的电子交易数据铁证面前，犯罪嫌疑人最终低头认罪，无法再矢口否认自己的贪腐行为。', 'Zài dàliàng quèzáo de jiānkòng lùxiàng yǔ bùkě cuàngǎi de diànzǐ jiāoyì shùjù tiězhèng miànqián, fànzuì xiányírén zuìzhōng dītóu rènzuì, wúfǎ zài shǐkǒu fǒurèn zìjǐ de tānfǔ xíngwéi.', 'Trước lượng lớn chứng cứ thép như video giám sát xác thực và dữ liệu giao dịch điện tử không thể làm giả, kẻ tình nghi phạm tội rốt cuộc đã cúi đầu nhận tội, không thể tiếp tục khăng khăng chối bỏ hành vi tham nhũng của mình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2365] [夫妇] (fūfù) - vợ chồng, phu phụ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '夫妇' AND pinyin = 'fūfù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '夫妇' AND pinyin = 'fūfù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '夫妇'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '夫妇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fūfù',
      meaning_vi = 'vợ chồng, phu phụ',
      example_hanzi = '这对年轻夫妇携手并进，在异国他乡共同创办了一家颇受好评的面包烘焙坊。',
      example_pinyin = 'Zhè duì niánqīng fūfù xiéshǒu bìngjìn, zài yìguó tāxiāng gòngtóng chuàngbàn le yì jiā pō shòu hǎopíng de miànbāo hōngbèifāng.',
      example_vi = 'Cặp vợ chồng trẻ này đồng cam cộng khổ sát cánh bên nhau, cùng sáng lập nên một tiệm bánh mì nướng rất được khen ngợi nơi đất khách quê người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '夫妇',
      'fūfù',
      'vợ chồng, phu phụ',
      'Danh từ',
      'HSK 5',
      '这对年轻夫妇携手并进，在异国他乡共同创办了一家颇受好评的面包烘焙坊。',
      'Zhè duì niánqīng fūfù xiéshǒu bìngjìn, zài yìguó tāxiāng gòngtóng chuàngbàn le yì jiā pō shòu hǎopíng de miànbāo hōngbèifāng.',
      'Cặp vợ chồng trẻ này đồng cam cộng khổ sát cánh bên nhau, cùng sáng lập nên một tiệm bánh mì nướng rất được khen ngợi nơi đất khách quê người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这对年轻夫妇携手并进，在异国他乡共同创办了一家颇受好评的面包烘焙坊。', 'Zhè duì niánqīng fūfù xiéshǒu bìngjìn, zài yìguó tāxiāng gòngtóng chuàngbàn le yì jiā pō shòu hǎopíng de miànbāo hōngbèifāng.', 'Cặp vợ chồng trẻ này đồng cam cộng khổ sát cánh bên nhau, cùng sáng lập nên một tiệm bánh mì nướng rất được khen ngợi nơi đất khách quê người.', 'basic', 1),
      (v_id, '诺贝尔生理学或医学奖得主屠呦呦研究团队及众多杰出科学家夫妇的故事表明，学术志向上的志同道合与相互支持是取得突破性科研成果的强大动力。', 'Nuòbèi’ěr shēnglǐxué huò yīxuéjiǎng dézhǔ Tú Yōuyōu yánjiū tuánduì jí zhòngduō jiéchū kēxuéjiā fūfù de gùshì biǎomíng, xuéshù zhìxiàng shang de zhìtóng-dàohé yǔ xiānghù zhīchí shì qǔdé tūpòxìng kēyán chéngguǒ de qiángdà dònglì.', 'Câu chuyện của đội ngũ nghiên cứu của nhà khoa học đoạt giải Nobel Y học Đồ U U cùng nhiều cặp vợ chồng nhà khoa học kiệt xuất cho thấy, sự đồng lòng chung chí hướng và nâng đỡ lẫn nhau trong học thuật là động lực mạnh mẽ để giành lấy những thành quả nghiên cứu khoa học mang tính đột phá.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2366] [扶] (fú) - đỡ, vịn, dắt, nâng đỡ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '扶' AND pinyin = 'fú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '扶' AND pinyin = 'fú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '扶'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '扶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fú',
      meaning_vi = 'đỡ, vịn, dắt, nâng đỡ',
      example_hanzi = '看到老奶奶提着沉重的东西过马路，他连忙上前热心地扶着老人走过去。',
      example_pinyin = 'Kàndào lǎonǎinai tízhe chénzhòng de dōngxi guò mǎlù, tā liánmáng shàngqián rèxīn de fúzhe lǎorén zǒu guòqù.',
      example_vi = 'Nhìn thấy cụ bà xách đồ nặng đi qua đường, anh ấy vội vàng tiến lên phía trước nhiệt tình đỡ cụ bước qua.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '扶',
      'fú',
      'đỡ, vịn, dắt, nâng đỡ',
      'Động từ',
      'HSK 5',
      '看到老奶奶提着沉重的东西过马路，他连忙上前热心地扶着老人走过去。',
      'Kàndào lǎonǎinai tízhe chénzhòng de dōngxi guò mǎlù, tā liánmáng shàngqián rèxīn de fúzhe lǎorén zǒu guòqù.',
      'Nhìn thấy cụ bà xách đồ nặng đi qua đường, anh ấy vội vàng tiến lên phía trước nhiệt tình đỡ cụ bước qua.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '看到老奶奶提着沉重的东西过马路，他连忙上前热心地扶着老人走过去。', 'Kàndào lǎonǎinai tízhe chénzhòng de dōngxi guò mǎlù, tā liánmáng shàngqián rèxīn de fúzhe lǎorén zǒu guòqù.', 'Nhìn thấy cụ bà xách đồ nặng đi qua đường, anh ấy vội vàng tiến lên phía trước nhiệt tình đỡ cụ bước qua.', 'basic', 1),
      (v_id, '国家出台了一系列乡村振兴扶持优惠政策，精准扶贫扶志，重点扶持特色农业产业园与农村电商物流基础设施建设。', 'Guójiā chūtái le yí xìliè xiāngcūn zhènxīng fúchí yōuhuì zhèngcè, jīngzhǔn fúpín fúzhì, zhòngdiǎn fúchí tèsè nóngyè chǎnyèyuán yǔ nóngcūn diànshāng wùliú jīchǔ shèshī jiànshè.', 'Nhà nước đã ban hành một loạt chính sách ưu đãi nâng đỡ chấn hưng nông thôn, xóa đói giảm nghèo và bồi dưỡng ý chí chuẩn xác, trọng điểm nâng đỡ xây dựng các khu công nghiệp nông nghiệp đặc sắc cùng cơ sở hạ tầng logistics thương mại điện tử nông thôn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2367] [福] (fú) - phúc, hạnh phúc, điều tốt lành [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '福' AND pinyin = 'fú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '福' AND pinyin = 'fú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '福'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '福'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fú',
      meaning_vi = 'phúc, hạnh phúc, điều tốt lành',
      example_hanzi = '除夕之夜，家家户户都在大门上倒贴“福”字，寓意“福气已到”。',
      example_pinyin = 'Chúxī zhī yè, jiājiā-hùhù dōu zài dàmén shang dào tiē “fú” zì, yùyì “fúqì yǐ dào”.',
      example_vi = 'Vào đêm trừ tịch, nhà nhà đều dán ngược chữ "Phúc" trên cổng lớn, mang ngụ ý "phúc khí đã đến".'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '福',
      'fú',
      'phúc, hạnh phúc, điều tốt lành',
      'Danh từ',
      'HSK 5',
      '除夕之夜，家家户户都在大门上倒贴“福”字，寓意“福气已到”。',
      'Chúxī zhī yè, jiājiā-hùhù dōu zài dàmén shang dào tiē “fú” zì, yùyì “fúqì yǐ dào”.',
      'Vào đêm trừ tịch, nhà nhà đều dán ngược chữ "Phúc" trên cổng lớn, mang ngụ ý "phúc khí đã đến".'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '除夕之夜，家家户户都在大门上倒贴“福”字，寓意“福气已到”。', 'Chúxī zhī yè, jiājiā-hùhù dōu zài dàmén shang dào tiē “fú” zì, yùyì “fúqì yǐ dào”.', 'Vào đêm trừ tịch, nhà nhà đều dán ngược chữ "Phúc" trên cổng lớn, mang ngụ ý "phúc khí đã đến".', 'basic', 1),
      (v_id, '老科学家在荣休典礼上感慨地说，能够把毕生精力奉献给祖国的水利防洪事业，造福千万黎民百姓，是他此生最大的幸福与荣光。', 'Lǎo kēxuéjiā zài róngxiū diǎnlǐ shang gǎnkǎi de shuō, nénggòu bǎ bìshēng jīnglì fèngxiàn gěi zǔguó de shuǐlì fánghóng shìyè, zàofú qiānwàn límín bǎixìng, shì tā cǐshēng zuì dà de xìngfú yǔ róngguāng.', 'Nhà khoa học lão thành trong buổi lễ vinh hưu đã xúc động chia sẻ rằng, có thể cống hiến trọn vẹn sức lực cả đời cho sự nghiệp thủy lợi phòng chống lũ lụt của tổ quốc, tạo phúc cho hàng triệu dân chúng, chính là niềm hạnh phúc và vinh quang lớn nhất đời ông.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2368] [服装] (fúzhuāng) - trang phục, quần áo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '服装' AND pinyin = 'fúzhuāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '服装' AND pinyin = 'fúzhuāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '服装'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '服装'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fúzhuāng',
      meaning_vi = 'trang phục, quần áo',
      example_hanzi = '在正式的商务招待宴会上，所有受邀出席的人员都必须穿着符合礼仪的得体服装。',
      example_pinyin = 'Zài zhèngshì de shāngwù zhāodài yànhuì shang, suǒyǒu shòuyāo chūxí de rényuán dōu bìxū chuānzhuó fúhé lǐyí de détǐ fúzhuāng.',
      example_vi = 'Tại các bữa tiệc chiêu đãi thương mại chính thức, mọi nhân viên được mời tham dự đều bắt buộc phải mặc trang phục đúng mực phù hợp với nghi thức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '服装',
      'fúzhuāng',
      'trang phục, quần áo',
      'Danh từ',
      'HSK 5',
      '在正式的商务招待宴会上，所有受邀出席的人员都必须穿着符合礼仪的得体服装。',
      'Zài zhèngshì de shāngwù zhāodài yànhuì shang, suǒyǒu shòuyāo chūxí de rényuán dōu bìxū chuānzhuó fúhé lǐyí de détǐ fúzhuāng.',
      'Tại các bữa tiệc chiêu đãi thương mại chính thức, mọi nhân viên được mời tham dự đều bắt buộc phải mặc trang phục đúng mực phù hợp với nghi thức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在正式的商务招待宴会上，所有受邀出席的人员都必须穿着符合礼仪的得体服装。', 'Zài zhèngshì de shāngwù zhāodài yànhuì shang, suǒyǒu shòuyāo chūxí de rényuán dōu bìxū chuānzhuó fúhé lǐyí de détǐ fúzhuāng.', 'Tại các bữa tiệc chiêu đãi thương mại chính thức, mọi nhân viên được mời tham dự đều bắt buộc phải mặc trang phục đúng mực phù hợp với nghi thức.', 'basic', 1),
      (v_id, '中国国际时装周汇聚了全球新锐设计师，他们将传统刺绣扎染工艺与现代环保纤维面料巧妙结合，引领了新中式国潮服装设计的新风尚。', 'Zhōngguó guójì shízhuāngzhōu huìjù le quánqiú xīnrùì shèjìshī, tāmen jiāng chuántǒng cìxiù zānrǎn gōngyì yǔ xiàndài huánbǎo xiānwéi miànliào qiǎomiào jiéhé, yǐnlǐng le xīn zhōngshì guócháo fúzhuāng shèjì de xīn fēngshàng.', 'Tuần lễ thời trang quốc tế Trung Quốc đã quy tụ các nhà thiết kế mới nổi toàn cầu, họ kết hợp khéo léo thủ công thêu thùa nhuộm buộc truyền thống với các chất liệu vải sợi bảo vệ môi trường hiện đại, dẫn đầu xu hướng mới của thiết kế trang phục trào lưu phong cách Trung Hoa mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2369] [副] (fù) - phó (chức vụ); bộ, đôi (lượng từ) [Tính từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '副' AND pinyin = 'fù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '副' AND pinyin = 'fù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '副'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '副'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Lượng từ',
      pinyin = 'fù',
      meaning_vi = 'phó (chức vụ); bộ, đôi (lượng từ)',
      example_hanzi = '为了在户外强光下保护视力，他出门前特意戴上了一副高品质的防紫外线太阳镜。',
      example_pinyin = 'Wèile zài hùwài qiángguāng xià bǎohù shìlì, tā chūmén qián tèyì dài shàng le yí fù gāo pǐnzhì de fáng zǐwàixiàn tàiyángjìng.',
      example_vi = 'Để bảo vệ thị lực dưới ánh nắng gắt ngoài trời, trước khi ra khỏi cửa anh ấy đã cố tình đeo một cặp kính râm chống tia cực tím chất lượng cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '副',
      'fù',
      'phó (chức vụ); bộ, đôi (lượng từ)',
      'Tính từ / Lượng từ',
      'HSK 5',
      '为了在户外强光下保护视力，他出门前特意戴上了一副高品质的防紫外线太阳镜。',
      'Wèile zài hùwài qiángguāng xià bǎohù shìlì, tā chūmén qián tèyì dài shàng le yí fù gāo pǐnzhì de fáng zǐwàixiàn tàiyángjìng.',
      'Để bảo vệ thị lực dưới ánh nắng gắt ngoài trời, trước khi ra khỏi cửa anh ấy đã cố tình đeo một cặp kính râm chống tia cực tím chất lượng cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了在户外强光下保护视力，他出门前特意戴上了一副高品质的防紫外线太阳镜。', 'Wèile zài hùwài qiángguāng xià bǎohù shìlì, tā chūmén qián tèyì dài shàng le yí fù gāo pǐnzhì de fáng zǐwàixiàn tàiyángjìng.', 'Để bảo vệ thị lực dưới ánh nắng gắt ngoài trời, trước khi ra khỏi cửa anh ấy đã cố tình đeo một cặp kính râm chống tia cực tím chất lượng cao.', 'basic', 1),
      (v_id, '张教授凭借卓越的学术声望和跨学科协作领导力，被全票推选为国家重点实验室常务副主任兼首席研究员。', 'Zhāng jiàoshòu píngjiè zhuóyuè de xuéshù shēngwàng hé kuà xuékē xiézuò lǐngdǎolì, bèi quánpiào tuīxuǎn wéi guójiā zhòngdiǎn shíyànshì chángwù fùzhǔrèn jiān shǒuxí yánjiūyuán.', 'Giáo sư Trương dựa vào danh vọng học thuật xuất chúng và năng lực lãnh đạo hợp tác liên ngành, đã được nhất trí tuyệt đối bầu làm Phó giám đốc thường trực kiêm nhà nghiên cứu trưởng phòng thí nghiệm trọng điểm quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2370] [富] (fù) - giàu, giàu có, dồi dào [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '富' AND pinyin = 'fù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '富' AND pinyin = 'fù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '富'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '富'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'fù',
      meaning_vi = 'giàu, giàu có, dồi dào',
      example_hanzi = '这片广袤的黑土地土壤肥沃，蕴藏着丰富的矿产和水利资源。',
      example_pinyin = 'Zhè piàn guǎngmào de hēitǔdì tǔrǎng féiwò, yùncáng zhe fēngfù de kuàngchǎn hé shuǐlì zīyuán.',
      example_vi = 'Vùng đất đen màu mỡ bao la này ẩn chứa nguồn tài nguyên khoáng sản và thủy lợi vô cùng phong phú giàu có.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '富',
      'fù',
      'giàu, giàu có, dồi dào',
      'Tính từ',
      'HSK 5',
      '这片广袤的黑土地土壤肥沃，蕴藏着丰富的矿产和水利资源。',
      'Zhè piàn guǎngmào de hēitǔdì tǔrǎng féiwò, yùncáng zhe fēngfù de kuàngchǎn hé shuǐlì zīyuán.',
      'Vùng đất đen màu mỡ bao la này ẩn chứa nguồn tài nguyên khoáng sản và thủy lợi vô cùng phong phú giàu có.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这片广袤的黑土地土壤肥沃，蕴藏着丰富的矿产和水利资源。', 'Zhè piàn guǎngmào de hēitǔdì tǔrǎng féiwò, yùncáng zhe fēngfù de kuàngchǎn hé shuǐlì zīyuán.', 'Vùng đất đen màu mỡ bao la này ẩn chứa nguồn tài nguyên khoáng sản và thủy lợi vô cùng phong phú giàu có.', 'basic', 1),
      (v_id, '乡村要实现全面振兴，不仅要带领乡亲们发展特色产业富口袋，更要加强乡村精神文明建设以富脑袋。', 'Xiāngcūn yào shíxiàn quánmiàn zhènxīng, bùjǐn yào dàilǐng xiāngqīn men fāzhǎn tèsè chǎnyè fù kǒudài, gèng yào jiāqiáng xiāngcūn jīngshén wénmíng jiànshè yǐ fù nǎodai.', 'Nông thôn muốn thực hiện chấn hưng toàn diện, không chỉ cần dẫn dắt bà con phát triển sản nghiệp đặc trưng để làm giàu túi tiền, mà càng phải đẩy mạnh xây dựng văn minh tinh thần nông thôn để làm giàu trí tuệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2371] [付出] (fùchū) - bỏ ra, trả giá, cống hiến, hy sinh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '付出' AND pinyin = 'fùchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '付出' AND pinyin = 'fùchū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '付出'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '付出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fùchū',
      meaning_vi = 'bỏ ra, trả giá, cống hiến, hy sinh',
      example_hanzi = '一份耕耘，一份收获；只要肯付出辛勤的汗水，就一定能换来理想的成绩。',
      example_pinyin = 'Yí fèn gēngyún, yí fèn shōuhuò; zhǐyào kěn fùchū xīnqín de hànshuǐ, jiù yídìng néng huàn lái lǐxiǎng de chéngjì.',
      example_vi = 'Một phần cày cấy, một phần gặt hái; chỉ cần chịu bỏ ra mồ hôi công sức cần cù, thì nhất định sẽ đổi lại được thành tích lý tưởng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '付出',
      'fùchū',
      'bỏ ra, trả giá, cống hiến, hy sinh',
      'Động từ',
      'HSK 5',
      '一份耕耘，一份收获；只要肯付出辛勤的汗水，就一定能换来理想的成绩。',
      'Yí fèn gēngyún, yí fèn shōuhuò; zhǐyào kěn fùchū xīnqín de hànshuǐ, jiù yídìng néng huàn lái lǐxiǎng de chéngjì.',
      'Một phần cày cấy, một phần gặt hái; chỉ cần chịu bỏ ra mồ hôi công sức cần cù, thì nhất định sẽ đổi lại được thành tích lý tưởng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一份耕耘，一份收获；只要肯付出辛勤的汗水，就一定能换来理想的成绩。', 'Yí fèn gēngyún, yí fèn shōuhuò; zhǐyào kěn fùchū xīnqín de hànshuǐ, jiù yídìng néng huàn lái lǐxiǎng de chéngjì.', 'Một phần cày cấy, một phần gặt hái; chỉ cần chịu bỏ ra mồ hôi công sức cần cù, thì nhất định sẽ đổi lại được thành tích lý tưởng.', 'basic', 1),
      (v_id, '在救援抗震救灾的最前线，广大消防官兵与医护人员付出了常人难以想象的心血与代价，日夜奋战搜救受困同胞。', 'Zài jiùyuán kàngzhèn jiùzāi de zuì qiánxiàn, guǎngdà xiāofáng guānbīng yǔ yīhù rényuán fùchū le chángrén nányǐ xiǎngxiàng de xīnxuè yǔ dàijià, rìyè fènzhàn sōujiù shòukùn tóngbāo.', 'Nơi tiền tuyến cứu viện cứu trợ động đất chống thiên tai, đông đảo cán bộ chiến sĩ cứu hỏa và nhân viên y tế đã bỏ ra tâm huyết và cái giá mà người thường khó lòng tưởng tượng nổi, ngày đêm chiến đấu để tìm kiếm giải cứu đồng bào gặp nạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2372] [负担] (fùdān) - gánh nặng; gánh vác [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '负担' AND pinyin = 'fùdān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '负担' AND pinyin = 'fùdān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '负担'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '负担'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'fùdān',
      meaning_vi = 'gánh nặng; gánh vác',
      example_hanzi = '父母为了供三个孩子上大学，默默承担着极其沉重的经济负担。',
      example_pinyin = 'Fùmǔ wèile gōng sān gè háizi shàng dàxué, mòmò chéngdān zhe jíqí chénzhòng de jīngjì fùdān.',
      example_vi = 'Cha mẹ để nuôi ba người con học đại học, đã âm thầm gánh vác gánh nặng kinh tế vô cùng nặng nề.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '负担',
      'fùdān',
      'gánh nặng; gánh vác',
      'Danh từ / Động từ',
      'HSK 5',
      '父母为了供三个孩子上大学，默默承担着极其沉重的经济负担。',
      'Fùmǔ wèile gōng sān gè háizi shàng dàxué, mòmò chéngdān zhe jíqí chénzhòng de jīngjì fùdān.',
      'Cha mẹ để nuôi ba người con học đại học, đã âm thầm gánh vác gánh nặng kinh tế vô cùng nặng nề.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '父母为了供三个孩子上大学，默默承担着极其沉重的经济负担。', 'Fùmǔ wèile gōng sān gè háizi shàng dàxué, mòmò chéngdān zhe jíqí chénzhòng de jīngjì fùdān.', 'Cha mẹ để nuôi ba người con học đại học, đã âm thầm gánh vác gánh nặng kinh tế vô cùng nặng nề.', 'basic', 1),
      (v_id, '政府推行教育“双减”政策与普惠性医疗报销改革，旨在切实减轻广大家庭过重的校外培训支出与重大疾病医疗负担。', 'Zhèngfǔ tuīxíng jiàoyù “shuāng jiǎn” zhèngcè yǔ pǔhuìxìng yīliáo bàoxiāo gǎigé, zhǐzài qièshí jiǎnqīng guǎngdà jiātíng guòzhòng de xiàowài péixùn zhīchū yǔ zhòngdà jíbìng yīliáo fùdān.', 'Chính phủ triển khai chính sách giáo dục "giảm kép" và cải cách thanh toán bảo hiểm y tế phổ cập, nhằm mục đích giảm nhẹ thiết thực các khoản chi đào tạo ngoài trường quá mức cùng gánh nặng y tế khi mắc bệnh hiểm nghèo của đông đảo các gia đình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2373] [妇女] (fùnǚ) - phụ nữ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '妇女' AND pinyin = 'fùnǚ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '妇女' AND pinyin = 'fùnǚ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '妇女'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '妇女'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'fùnǚ',
      meaning_vi = 'phụ nữ',
      example_hanzi = '每年的三月八日是国际劳动妇女节，全社会都应当尊重并维护妇女的合法权益。',
      example_pinyin = 'Měinián de sān yuè bā rì shì Guójì Láodòng Fùnǚjié, quán shèhuì dōu yīngdāng zūnzhòng bìng wéihù fùnǚ de héfǎ quányì.',
      example_vi = 'Ngày tám tháng ba hàng năm là Ngày Quốc tế Phụ nữ Lao động, toàn xã hội đều nên tôn trọng và bảo vệ quyền lợi hợp pháp của phụ nữ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '妇女',
      'fùnǚ',
      'phụ nữ',
      'Danh từ',
      'HSK 5',
      '每年的三月八日是国际劳动妇女节，全社会都应当尊重并维护妇女的合法权益。',
      'Měinián de sān yuè bā rì shì Guójì Láodòng Fùnǚjié, quán shèhuì dōu yīngdāng zūnzhòng bìng wéihù fùnǚ de héfǎ quányì.',
      'Ngày tám tháng ba hàng năm là Ngày Quốc tế Phụ nữ Lao động, toàn xã hội đều nên tôn trọng và bảo vệ quyền lợi hợp pháp của phụ nữ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每年的三月八日是国际劳动妇女节，全社会都应当尊重并维护妇女的合法权益。', 'Měinián de sān yuè bā rì shì Guójì Láodòng Fùnǚjié, quán shèhuì dōu yīngdāng zūnzhòng bìng wéihù fùnǚ de héfǎ quányì.', 'Ngày tám tháng ba hàng năm là Ngày Quốc tế Phụ nữ Lao động, toàn xã hội đều nên tôn trọng và bảo vệ quyền lợi hợp pháp của phụ nữ.', 'basic', 1),
      (v_id, '联合国大会发布的全球性别平等评估报告强调，保障妇女在政治决策参与、商业企业管理及高等科学工程领域的平等权利，是推动可持续发展不可或缺的基石。', 'Liánhéguó Dàhuì fābù de quánqiú xìngbié píngděng pínggū bàogào qiángdiào, bǎozhàng fùnǚ zài zhèngzhì juécè cānyù, shāngyè qǐyè guǎnlǐ jí gāoděng kēxué gōngchéng lǐngyù de píngděng quánlì, shì tuīdòng kěchíxù fāzhǎn bùkě huòquē de jīshí.', 'Báo cáo đánh giá bình đẳng giới toàn cầu do Đại hội đồng Liên Hợp Quốc công bố nhấn mạnh rằng, việc bảo đảm quyền bình đẳng của phụ nữ trong tham gia quyết sách chính trị, quản lý doanh nghiệp thương mại và các lĩnh vực khoa học kỹ thuật bậc cao là nền tảng không thể thiếu để thúc đẩy phát triển bền vững.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2374] [富有] (fùyǒu) - giàu có; dồi dào, tràn đầy (đặc tính) [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '富有' AND pinyin = 'fùyǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '富有' AND pinyin = 'fùyǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '富有'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '富有'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'fùyǒu',
      meaning_vi = 'giàu có; dồi dào, tràn đầy (đặc tính)',
      example_hanzi = '他不仅物质生活富裕，更是一个精神世界极其富有且乐于助人的人。',
      example_pinyin = 'Tā bùjǐn wùzhì shēnghuó fùyù, gèng shì yí gè jīngshén shìjiè jíqí fùyǒu qiě lèyú zhùrén de rén.',
      example_vi = 'Anh ấy không chỉ có đời sống vật chất giàu có, mà còn là một người có thế giới tinh thần vô cùng phong phú và luôn sẵn lòng giúp đỡ người khác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '富有',
      'fùyǒu',
      'giàu có; dồi dào, tràn đầy (đặc tính)',
      'Tính từ / Động từ',
      'HSK 5',
      '他不仅物质生活富裕，更是一个精神世界极其富有且乐于助人的人。',
      'Tā bùjǐn wùzhì shēnghuó fùyù, gèng shì yí gè jīngshén shìjiè jíqí fùyǒu qiě lèyú zhùrén de rén.',
      'Anh ấy không chỉ có đời sống vật chất giàu có, mà còn là một người có thế giới tinh thần vô cùng phong phú và luôn sẵn lòng giúp đỡ người khác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他不仅物质生活富裕，更是一个精神世界极其富有且乐于助人的人。', 'Tā bùjǐn wùzhì shēnghuó fùyù, gèng shì yí gè jīngshén shìjiè jíqí fùyǒu qiě lèyú zhùrén de rén.', 'Anh ấy không chỉ có đời sống vật chất giàu có, mà còn là một người có thế giới tinh thần vô cùng phong phú và luôn sẵn lòng giúp đỡ người khác.', 'basic', 1),
      (v_id, '这部由青年导演执导的话剧台词幽默犀利、情节跌宕起伏，富有强烈的时代气息与深刻的社会批判哲学思考。', 'Zhè bù yóu qīngnián dǎoyǎn zhídǎo de huàjù táicí yōumò xīlì, qíngjié diēdàng-qǐfú, fùyǒu qiángliè de shídài qìxī yǔ shēnkè de shèhuì pīpàn zhéxué sīkǎo.', 'Vở kịch nói do đạo diễn trẻ chỉ đạo này có lời thoại hài hước sắc sảo, tình tiết thăng trầm lôi cuốn, tràn đầy hơi thở thời đại mạnh mẽ và những suy tư triết học phê phán xã hội sâu sắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2375] [复制] (fùzhì) - sao chép, copy, nhân bản [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '复制' AND pinyin = 'fùzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '复制' AND pinyin = 'fùzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '复制'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '复制'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'fùzhì',
      meaning_vi = 'sao chép, copy, nhân bản',
      example_hanzi = '在电脑上只要按下快捷键就可以轻松复制选中的文字与图片。',
      example_pinyin = 'Zài diànnǎo shang zhǐyào ànxià kuàijièjiàn jiù kěyǐ qīngsōng fùzhì xuǎnzhòng de wénzì yǔ túpiàn.',
      example_vi = 'Trên máy tính chỉ cần nhấn phím tắt là có thể dễ dàng sao chép văn bản và hình ảnh đã chọn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '复制',
      'fùzhì',
      'sao chép, copy, nhân bản',
      'Động từ',
      'HSK 5',
      '在电脑上只要按下快捷键就可以轻松复制选中的文字与图片。',
      'Zài diànnǎo shang zhǐyào ànxià kuàijièjiàn jiù kěyǐ qīngsōng fùzhì xuǎnzhòng de wénzì yǔ túpiàn.',
      'Trên máy tính chỉ cần nhấn phím tắt là có thể dễ dàng sao chép văn bản và hình ảnh đã chọn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在电脑上只要按下快捷键就可以轻松复制选中的文字与图片。', 'Zài diànnǎo shang zhǐyào ànxià kuàijièjiàn jiù kěyǐ qīngsōng fùzhì xuǎnzhòng de wénzì yǔ túpiàn.', 'Trên máy tính chỉ cần nhấn phím tắt là có thể dễ dàng sao chép văn bản và hình ảnh đã chọn.', 'basic', 1),
      (v_id, '成功的商业模式往往具有极强的标准化与可复制性，使得该零售连锁品牌能够在短短两年内将门店迅速拓展至全国上百座城市。', 'Chénggōng de shāngyè móshì wǎngwǎng jùyǒu jí qiáng de biāozhǔnhuà yǔ kěfùzhìxìng, shǐdé gāi língshòu liánsuǒ pǐnpái nénggòu zài duǎnduǎn liǎng nián nèi jiāng méndiàn xùnsù tuòzhǎn zhì quánguó shàng bǎi zuò chéngshì.', 'Một mô hình kinh doanh thành công thường có tính chuẩn hóa và khả năng sao chép nhân rộng cực kỳ mạnh mẽ, giúp thương hiệu chuỗi bán lẻ này có thể nhanh chóng mở rộng cửa hàng tới hàng trăm thành phố trên toàn quốc chỉ trong vỏn vẹn hai năm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2376] [改革] (gǎigé) - cải cách [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '改革' AND pinyin = 'gǎigé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改革' AND pinyin = 'gǎigé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '改革'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改革'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'gǎigé',
      meaning_vi = 'cải cách',
      example_hanzi = '学校正在积极推行课堂教学改革，倡导以学生为中心的互动式教学模式。',
      example_pinyin = 'Xuéxiào zhèngzài jījí tuīxíng kètáng jiàoxué gǎigé, chàngdǎo yǐ xuésheng wéi zhōngxīn de hùdòngshì jiàoxué móshì.',
      example_vi = 'Nhà trường đang tích cực đẩy mạnh cải cách giảng dạy trên lớp, khởi xướng mô hình dạy học tương tác lấy học sinh làm trung tâm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '改革',
      'gǎigé',
      'cải cách',
      'Động từ / Danh từ',
      'HSK 5',
      '学校正在积极推行课堂教学改革，倡导以学生为中心的互动式教学模式。',
      'Xuéxiào zhèngzài jījí tuīxíng kètáng jiàoxué gǎigé, chàngdǎo yǐ xuésheng wéi zhōngxīn de hùdòngshì jiàoxué móshì.',
      'Nhà trường đang tích cực đẩy mạnh cải cách giảng dạy trên lớp, khởi xướng mô hình dạy học tương tác lấy học sinh làm trung tâm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校正在积极推行课堂教学改革，倡导以学生为中心的互动式教学模式。', 'Xuéxiào zhèngzài jījí tuīxíng kètáng jiàoxué gǎigé, chàngdǎo yǐ xuésheng wéi zhōngxīn de hùdòngshì jiàoxué móshì.', 'Nhà trường đang tích cực đẩy mạnh cải cách giảng dạy trên lớp, khởi xướng mô hình dạy học tương tác lấy học sinh làm trung tâm.', 'basic', 1),
      (v_id, '改革开放四十多年来，中国通过持续深化经济体制机制改革与不断扩大对外高水平开放，综合国力与人民生活水平实现了历史性飞跃。', 'Gǎigé kāifàng sìshí duō nián lái, Zhōngguó tōngguò chíxù shēnhuà jīngjì tǐzhì jīzhì gǎigé yǔ bùduàn kuòdà duìwài gāo shuǐpíng kāifàng, zōnghé guólì yǔ rénmín shēnghuó shuǐpíng shíxiàn le lìshǐxìng fēiyuè.', 'Hơn bốn mươi năm cải cách mở cửa đến nay, Trung Quốc thông qua việc không ngừng làm sâu sắc thêm cải cách thể chế cơ chế kinh tế và liên tục mở rộng mở cửa đối ngoại trình độ cao, đã giúp sức mạnh tổng hợp quốc gia và mức sống của nhân dân thực hiện bước nhảy vọt lịch sử.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2377] [改进] (gǎijìn) - cải tiến, đổi mới nâng cao [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '改进' AND pinyin = 'gǎijìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改进' AND pinyin = 'gǎijìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '改进'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改进'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gǎijìn',
      meaning_vi = 'cải tiến, đổi mới nâng cao',
      example_hanzi = '技术研发团队认真听取了用户反馈，对软件的操作界面和运行算法进行了全面改进。',
      example_pinyin = 'Jìshù yánfā tuánduì rènzhēn tīngqǔ le yònghù fǎnkuì, duì ruǎnjiàn de cāozuò jièmiàn hé yùnxíng suànfǎ jìnxíng le quánmiàn gǎijìn.',
      example_vi = 'Đội ngũ nghiên cứu phát triển kỹ thuật đã nghiêm túc lắng nghe phản hồi của người dùng, tiến hành cải tiến toàn diện giao diện thao tác và thuật toán vận hành của phần mềm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '改进',
      'gǎijìn',
      'cải tiến, đổi mới nâng cao',
      'Động từ',
      'HSK 5',
      '技术研发团队认真听取了用户反馈，对软件的操作界面和运行算法进行了全面改进。',
      'Jìshù yánfā tuánduì rènzhēn tīngqǔ le yònghù fǎnkuì, duì ruǎnjiàn de cāozuò jièmiàn hé yùnxíng suànfǎ jìnxíng le quánmiàn gǎijìn.',
      'Đội ngũ nghiên cứu phát triển kỹ thuật đã nghiêm túc lắng nghe phản hồi của người dùng, tiến hành cải tiến toàn diện giao diện thao tác và thuật toán vận hành của phần mềm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '技术研发团队认真听取了用户反馈，对软件的操作界面和运行算法进行了全面改进。', 'Jìshù yánfā tuánduì rènzhēn tīngqǔ le yònghù fǎnkuì, duì ruǎnjiàn de cāozuò jièmiàn hé yùnxíng suànfǎ jìnxíng le quánmiàn gǎijìn.', 'Đội ngũ nghiên cứu phát triển kỹ thuật đã nghiêm túc lắng nghe phản hồi của người dùng, tiến hành cải tiến toàn diện giao diện thao tác và thuật toán vận hành của phần mềm.', 'basic', 1),
      (v_id, '通过持续改进制造工艺流程与引入精密数控机床，工厂不仅大幅降低了次品率，还使整条装配线的生产综合能耗下降了百分之十五。', 'Tōngguò chíxù gǎijìn zhìzào gōngyì liúchéng yǔ yǐnrù jīngmì shùkòng jīchuáng, gōngchǎng bùjǐn dàfú jiàngdī le cìpǐnlǜ, hái shǐ zhěng tiáo zhuāngpèixiàn de shēngchǎn zōnghé nénghào xiàjiàng le bǎifēnzhī shíwǔ.', 'Thông qua việc không ngừng cải tiến quy trình công nghệ chế tạo và đưa vào các máy công cụ điều khiển số chính xác, nhà máy không chỉ giảm mạnh tỷ lệ hàng thứ phẩm, mà còn khiến mức tiêu hao năng lượng tổng hợp trên toàn bộ dây chuyền lắp ráp giảm mười lăm phần trăm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2378] [改善] (gǎishàn) - cải thiện, làm cho tốt hơn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '改善' AND pinyin = 'gǎishàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改善' AND pinyin = 'gǎishàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '改善'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改善'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gǎishàn',
      meaning_vi = 'cải thiện, làm cho tốt hơn',
      example_hanzi = '随着城市绿化工程的推进，市民日常居住环境和空气质量得到了明显改善。',
      example_pinyin = 'Suízhe chéngshì lǜhuà gōngchéng de tuījìn, shìmín rìcháng jūzhù huánjìng hé kōngqì zhìliàng dédào le míngxiǎn gǎishàn.',
      example_vi = 'Cùng với việc xúc tiến công trình phủ xanh đô thị, môi trường cư trú thường nhật và chất lượng không khí của người dân thành phố đã được cải thiện rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '改善',
      'gǎishàn',
      'cải thiện, làm cho tốt hơn',
      'Động từ',
      'HSK 5',
      '随着城市绿化工程的推进，市民日常居住环境和空气质量得到了明显改善。',
      'Suízhe chéngshì lǜhuà gōngchéng de tuījìn, shìmín rìcháng jūzhù huánjìng hé kōngqì zhìliàng dédào le míngxiǎn gǎishàn.',
      'Cùng với việc xúc tiến công trình phủ xanh đô thị, môi trường cư trú thường nhật và chất lượng không khí của người dân thành phố đã được cải thiện rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着城市绿化工程的推进，市民日常居住环境和空气质量得到了明显改善。', 'Suízhe chéngshì lǜhuà gōngchéng de tuījìn, shìmín rìcháng jūzhù huánjìng hé kōngqì zhìliàng dédào le míngxiǎn gǎishàn.', 'Cùng với việc xúc tiến công trình phủ xanh đô thị, môi trường cư trú thường nhật và chất lượng không khí của người dân thành phố đã được cải thiện rõ rệt.', 'basic', 1),
      (v_id, '地方政府加大对偏远山区寄宿制学校食堂膳食营养与供暖设施的财政专项补贴力度，切实改善了数万名山区留守儿童的学习生活条件。', 'Dìfāng zhèngfǔ jiàdà duì piānyuǎn shānqū jìsùzhì xuéxiào shítáng shànshí yíngyǎng yǔ gōngnuǎn shèshī de cáizhèng zhuānxiàng bǔtiē lìdù, qièshí gǎishàn le shù wàn míng shānqū liúshǒu értóng de xuéxí shēnghuó tiáojiàn.', 'Chính quyền địa phương tăng cường trợ cấp ngân sách chuyên dụng cho dinh dưỡng bữa ăn ở căng tin và cơ sở sưởi ấm của các trường nội trú vùng núi xa xôi, cải thiện thiết thực điều kiện học tập sinh hoạt của hàng vạn trẻ em vùng cao xa cha mẹ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2379] [改天] (gǎitiān) - hôm khác, bữa khác, dịp khác [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '改天' AND pinyin = 'gǎitiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改天' AND pinyin = 'gǎitiān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '改天'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改天'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'gǎitiān',
      meaning_vi = 'hôm khác, bữa khác, dịp khác',
      example_hanzi = '我今天下午还有一个紧急会议要参加，咱们改天再约着一起喝茶聊天吧。',
      example_pinyin = 'Wǒ jīntiān xiàwǔ hái yǒu yí gè jǐnjí huìyì yào cānjiā, zánmen gǎitiān zài yuē zhe yìqǐ hē chá liáotiān ba.',
      example_vi = 'Chiều nay tôi còn phải tham gia một cuộc họp khẩn cấp nữa, chúng ta hẹn hôm khác cùng nhau uống trà trò chuyện nhé.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '改天',
      'gǎitiān',
      'hôm khác, bữa khác, dịp khác',
      'Phó từ',
      'HSK 5',
      '我今天下午还有一个紧急会议要参加，咱们改天再约着一起喝茶聊天吧。',
      'Wǒ jīntiān xiàwǔ hái yǒu yí gè jǐnjí huìyì yào cānjiā, zánmen gǎitiān zài yuē zhe yìqǐ hē chá liáotiān ba.',
      'Chiều nay tôi còn phải tham gia một cuộc họp khẩn cấp nữa, chúng ta hẹn hôm khác cùng nhau uống trà trò chuyện nhé.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我今天下午还有一个紧急会议要参加，咱们改天再约着一起喝茶聊天吧。', 'Wǒ jīntiān xiàwǔ hái yǒu yí gè jǐnjí huìyì yào cānjiā, zánmen gǎitiān zài yuē zhe yìqǐ hē chá liáotiān ba.', 'Chiều nay tôi còn phải tham gia một cuộc họp khẩn cấp nữa, chúng ta hẹn hôm khác cùng nhau uống trà trò chuyện nhé.', 'basic', 1),
      (v_id, '王总由于突发航班延误未能如期出席签约仪式，双方商务代表在电话中亲切致意，并协商决定改天在总部重新举行正式签约活动。', 'Wáng zǒng yóuyú tūfā hángbān yánwù wèi néng rúqī chūxí qiānyuē yíshì, shuāngfāng shāngwù dàibiǎo zài diànhuà zhōng qīnqiè zhìyì, bìng xiéshāng juédìng gǎitiān zài zǒngbù chóngxīn jǔxíng zhèngshì qiānyuē huódòng.', 'Tổng giám đốc Vương do chuyến bay bất ngờ bị trễ nên không thể có mặt đúng hẹn tại buổi lễ ký kết, đại diện thương mại hai bên đã gọi điện chào hỏi thân thiết và nhất trí thương lượng dời sang hôm khác để tổ chức lại lễ ký kết chính thức tại trụ sở chính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2380] [改正] (gǎizhèng) - sửa chữa, sửa đổi (sai sót, lỗi lầm) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '改正' AND pinyin = 'gǎizhèng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改正' AND pinyin = 'gǎizhèng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '改正'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '改正'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gǎizhèng',
      meaning_vi = 'sửa chữa, sửa đổi (sai sót, lỗi lầm)',
      example_hanzi = '知错能改，善莫大焉；只要能虚心听取批评并及时改正缺点就是好学生。',
      example_pinyin = 'Zhī cuò néng gǎi, shàn mò dà yān; zhǐyào néng xūxīn tīngqǔ pīpíng bìng jíshí gǎizhèng quēdiǎn jiù shì hǎo xuésheng.',
      example_vi = 'Biết sai mà biết sửa là điều tốt đẹp vô cùng; chỉ cần biết khiêm tốn lắng nghe phê bình và kịp thời sửa chữa khuyết điểm thì đều là học sinh tốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '改正',
      'gǎizhèng',
      'sửa chữa, sửa đổi (sai sót, lỗi lầm)',
      'Động từ',
      'HSK 5',
      '知错能改，善莫大焉；只要能虚心听取批评并及时改正缺点就是好学生。',
      'Zhī cuò néng gǎi, shàn mò dà yān; zhǐyào néng xūxīn tīngqǔ pīpíng bìng jíshí gǎizhèng quēdiǎn jiù shì hǎo xuésheng.',
      'Biết sai mà biết sửa là điều tốt đẹp vô cùng; chỉ cần biết khiêm tốn lắng nghe phê bình và kịp thời sửa chữa khuyết điểm thì đều là học sinh tốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '知错能改，善莫大焉；只要能虚心听取批评并及时改正缺点就是好学生。', 'Zhī cuò néng gǎi, shàn mò dà yān; zhǐyào néng xūxīn tīngqǔ pīpíng bìng jíshí gǎizhèng quēdiǎn jiù shì hǎo xuésheng.', 'Biết sai mà biết sửa là điều tốt đẹp vô cùng; chỉ cần biết khiêm tốn lắng nghe phê bình và kịp thời sửa chữa khuyết điểm thì đều là học sinh tốt.', 'basic', 1),
      (v_id, '企业在收到国家税务与市场监管部门下发的合规检查审计通知书后，立即责令财务审计部门对账目核算流程中存在的违规瑕疵进行限期全面改正。', 'Qǐyè zài shòudào guójiā shuìwù yǔ shìchǎng jiānguǎn bùmén xiàfā de hégūi jiǎnchá shěnjì tōngzhīshū hòu, lìjí zélìng cáiwù shěnjì bùmén duì zhàngmù hésuàn liúchéng zhōng cúnzài de wéiguī xiácī jìnxíng xiànqī quánmiàn gǎizhèng.', 'Sau khi nhận được thông báo kiểm tra kiểm toán tuân thủ do cơ quan thuế và giám sát thị trường quốc gia ban hành, doanh nghiệp đã lập tức yêu cầu bộ phận kiểm toán tài chính tiến hành sửa chữa toàn diện có thời hạn các sai phạm còn tồn tại trong quy trình hạch toán sổ sách.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2381] [盖] (gài) - đậy, phủ, xây (nhà), đóng (dấu); cái nắp [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '盖' AND pinyin = 'gài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '盖' AND pinyin = 'gài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '盖'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '盖'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'gài',
      meaning_vi = 'đậy, phủ, xây (nhà), đóng (dấu); cái nắp',
      example_hanzi = '天气转凉了，晚上睡觉时记得多盖一床厚被子以防感冒。',
      example_pinyin = 'Tiānqì zhuǎn liáng le, wǎnshang shuìjiào shí jìde duō gài yì chuáng hòu bèizi yǐfáng gǎnmào.',
      example_vi = 'Trời chuyển lạnh rồi, buổi tối đi ngủ nhớ đắp thêm một chiếc chăn dày để phòng tránh bị cảm cúm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '盖',
      'gài',
      'đậy, phủ, xây (nhà), đóng (dấu); cái nắp',
      'Động từ / Danh từ',
      'HSK 5',
      '天气转凉了，晚上睡觉时记得多盖一床厚被子以防感冒。',
      'Tiānqì zhuǎn liáng le, wǎnshang shuìjiào shí jìde duō gài yì chuáng hòu bèizi yǐfáng gǎnmào.',
      'Trời chuyển lạnh rồi, buổi tối đi ngủ nhớ đắp thêm một chiếc chăn dày để phòng tránh bị cảm cúm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天气转凉了，晚上睡觉时记得多盖一床厚被子以防感冒。', 'Tiānqì zhuǎn liáng le, wǎnshang shuìjiào shí jìde duō gài yì chuáng hòu bèizi yǐfáng gǎnmào.', 'Trời chuyển lạnh rồi, buổi tối đi ngủ nhớ đắp thêm một chiếc chăn dày để phòng tránh bị cảm cúm.', 'basic', 1),
      (v_id, '双方在房屋产权转让买卖合同的每一页骑缝处均正式签字并加盖公司公章与法定代表人印鉴，确保合同具备完全的法律效力。', 'Shuāngfāng zài fángwū chǎnquán zhuǎnràng mǎimài hétong de měi yí yè qíféng chù jūn zhèngshì qiānzì bìng jiāgài gōngsī gōngzhāng yǔ fǎdìng dàibiǎorén yìnjiàn, quèbǎo hétong jùbèi wánquán de fǎlǜ xiàolì.', 'Hai bên đều chính thức ký tên và đóng dấu giáp lai của công ty cùng con dấu của người đại diện theo pháp luật trên từng trang của hợp đồng mua bán chuyển nhượng quyền sở hữu nhà ở, đảm bảo hợp đồng có đầy đủ hiệu lực pháp lý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2382] [概括] (gàikuò) - khái quát, tóm tắt [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '概括' AND pinyin = 'gàikuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '概括' AND pinyin = 'gàikuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '概括'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '概括'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'gàikuò',
      meaning_vi = 'khái quát, tóm tắt',
      example_hanzi = '请同学们用简明扼要的三句话概括出这篇文章的中心思想与作者情感。',
      example_pinyin = 'Qǐng tóngxué men yòng jiǎnmíng-èyào de sān jù huà gàikuò chū zhè piān wénzhāng de zhōngxīn sīxiǎng yǔ zuòzhě qínggǎn.',
      example_vi = 'Mời các bạn học sinh dùng ba câu ngắn gọn súc tích để khái quát tư tưởng trung tâm và tình cảm của tác giả trong bài văn này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '概括',
      'gàikuò',
      'khái quát, tóm tắt',
      'Động từ / Tính từ',
      'HSK 5',
      '请同学们用简明扼要的三句话概括出这篇文章的中心思想与作者情感。',
      'Qǐng tóngxué men yòng jiǎnmíng-èyào de sān jù huà gàikuò chū zhè piān wénzhāng de zhōngxīn sīxiǎng yǔ zuòzhě qínggǎn.',
      'Mời các bạn học sinh dùng ba câu ngắn gọn súc tích để khái quát tư tưởng trung tâm và tình cảm của tác giả trong bài văn này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请同学们用简明扼要的三句话概括出这篇文章的中心思想与作者情感。', 'Qǐng tóngxué men yòng jiǎnmíng-èyào de sān jù huà gàikuò chū zhè piān wénzhāng de zhōngxīn sīxiǎng yǔ zuòzhě qínggǎn.', 'Mời các bạn học sinh dùng ba câu ngắn gọn súc tích để khái quát tư tưởng trung tâm và tình cảm của tác giả trong bài văn này.', 'basic', 1),
      (v_id, '著名历史学教授在开篇总论中，以宏阔的历史纵深视野高度概括了中华文明五千年薪火相传、兼收并蓄的发展演进脉络。', 'Zhùmíng lìshǐxué jiàoshòu zài kāipiān zǒnglùn zhōng, yǐ hóngkuò de lìshǐ zòngshēn shìyě gāodù gàikuò le Zhōnghuá wénmíng wǔqiān nián xīnhuǒ-xiāngchuán, jiānshōu-bìngxù de fāzhǎn yǎnjìn màiluò.', 'Giáo sư sử học nổi tiếng trong bài tổng luận mở đầu, với tầm nhìn sâu rộng về chiều dài lịch sử, đã khái quát ở mức độ cao mạch nguồn phát triển và tiếp biến năm nghìn năm ngọn lửa truyền đời, dung nạp đa dạng của nền văn minh Trung Hoa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2383] [概念] (gàiniàn) - khái niệm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '概念' AND pinyin = 'gàiniàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '概念' AND pinyin = 'gàiniàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '概念'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '概念'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gàiniàn',
      meaning_vi = 'khái niệm',
      example_hanzi = '老师通过生动有趣的日常实例，帮助初学者轻松理解了物理学中抽象的重力加速度概念。',
      example_pinyin = 'Lǎoshī tōngguò shēngdòng yǒuqù de rìcháng shílì, bāngzhù chūxuézhě qīngsōng lǐjiě le wùlǐxué zhōng chōuxiàng de zhònglì jiāsùdù gàiniàn.',
      example_vi = 'Thầy giáo thông qua các ví dụ đời sống thường nhật sinh động thú vị, đã giúp người mới bắt đầu dễ dàng thấu hiểu khái niệm gia tốc trọng trường trừu tượng trong vật lý học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '概念',
      'gàiniàn',
      'khái niệm',
      'Danh từ',
      'HSK 5',
      '老师通过生动有趣的日常实例，帮助初学者轻松理解了物理学中抽象的重力加速度概念。',
      'Lǎoshī tōngguò shēngdòng yǒuqù de rìcháng shílì, bāngzhù chūxuézhě qīngsōng lǐjiě le wùlǐxué zhōng chōuxiàng de zhònglì jiāsùdù gàiniàn.',
      'Thầy giáo thông qua các ví dụ đời sống thường nhật sinh động thú vị, đã giúp người mới bắt đầu dễ dàng thấu hiểu khái niệm gia tốc trọng trường trừu tượng trong vật lý học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老师通过生动有趣的日常实例，帮助初学者轻松理解了物理学中抽象的重力加速度概念。', 'Lǎoshī tōngguò shēngdòng yǒuqù de rìcháng shílì, bāngzhù chūxuézhě qīngsōng lǐjiě le wùlǐxué zhōng chōuxiàng de zhònglì jiāsùdù gàiniàn.', 'Thầy giáo thông qua các ví dụ đời sống thường nhật sinh động thú vị, đã giúp người mới bắt đầu dễ dàng thấu hiểu khái niệm gia tốc trọng trường trừu tượng trong vật lý học.', 'basic', 1),
      (v_id, '本届国际车展上展出的全新未来智能概念车，融合了固态电池超长续航与全自动无人驾驶技术，重新定义了绿色智慧出行的全新概念。', 'Běnjiè guójì chēzhǎn shang zhǎnchū de quánxīn wèilái zhìnéng gàiniànchē, rónghé le gùtài diànchí chāocháng xùháng yǔ quánzìdòng wúrén jiàshǐ jìshù, chóngxīn dìngyì le lǜsè zhìhuì chūxíng de quánxīn gàiniàn.', 'Chiếc xe ý niệm (concept car) thông minh tương lai hoàn toàn mới được trưng bày tại triển lãm ô tô quốc tế kỳ này, kết hợp thời lượng pin thể rắn siêu dài cùng công nghệ lái xe tự động hoàn toàn không người lái, đã định nghĩa lại khái niệm hoàn toàn mới về phương thức di chuyển xanh thông minh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2384] [敢于] (gǎnyú) - dám, dũng cảm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '敢于' AND pinyin = 'gǎnyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '敢于' AND pinyin = 'gǎnyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '敢于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '敢于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gǎnyú',
      meaning_vi = 'dám, dũng cảm',
      example_hanzi = '年轻人要敢于挑战未知的新事物，在一次次实践尝试中积累宝贵经验。',
      example_pinyin = 'Niánqīngrén yào gǎnyú tiǎozhàn wèizhī de xīn shìwù, zài yícìcì shíjiàn chángshì zhōng jīlěi bǎoguì jīngyàn.',
      example_vi = 'Người trẻ tuổi cần dám thách thức những điều mới mẻ chưa từng biết, tích lũy kinh nghiệm quý báu qua từng lần thử nghiệm thực tiễn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '敢于',
      'gǎnyú',
      'dám, dũng cảm',
      'Động từ',
      'HSK 5',
      '年轻人要敢于挑战未知的新事物，在一次次实践尝试中积累宝贵经验。',
      'Niánqīngrén yào gǎnyú tiǎozhàn wèizhī de xīn shìwù, zài yícìcì shíjiàn chángshì zhōng jīlěi bǎoguì jīngyàn.',
      'Người trẻ tuổi cần dám thách thức những điều mới mẻ chưa từng biết, tích lũy kinh nghiệm quý báu qua từng lần thử nghiệm thực tiễn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '年轻人要敢于挑战未知的新事物，在一次次实践尝试中积累宝贵经验。', 'Niánqīngrén yào gǎnyú tiǎozhàn wèizhī de xīn shìwù, zài yícìcì shíjiàn chángshì zhōng jīlěi bǎoguì jīngyàn.', 'Người trẻ tuổi cần dám thách thức những điều mới mẻ chưa từng biết, tích lũy kinh nghiệm quý báu qua từng lần thử nghiệm thực tiễn.', 'basic', 1),
      (v_id, '在激烈的全球高科技自主创新竞争中，科研工作者必须敢于打破传统思维定势的束缚，敢于涉足学术无人区，勇攀世界科学技术最高峰。', 'Zài jīliè de quánqiú gāokējì zìzhǔ chuàngxīn jìngzhēng zhōng, kēyán gōngzuòzhě bìxū gǎnyú dǎpò chuántǒng sīwéi dìngshì de shùfù, gǎnyú shèzú xuéshù wúrénqū, yǒng pān shìjiè kēxué jìshù zuì gāofēng.', 'Trong cuộc cạnh tranh đổi mới sáng tạo tự chủ công nghệ cao toàn cầu khốc liệt, những người làm công tác nghiên cứu khoa học nhất định phải dám phá bỏ sự trói buộc của lối mòn tư duy truyền thống, dám dấn thân vào vùng đất học thuật chưa ai khai phá, dũng cảm leo lên đỉnh cao nhất của khoa học công nghệ thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2385] [刚好] (gānghǎo) - vừa hay, vừa đúng lúc, vừa vặn [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '刚好' AND pinyin = 'gānghǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '刚好' AND pinyin = 'gānghǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '刚好'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '刚好'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Tính từ',
      pinyin = 'gānghǎo',
      meaning_vi = 'vừa hay, vừa đúng lúc, vừa vặn',
      example_hanzi = '我刚走出地铁站天空就下起了大雨，刚好包里带了一把折叠伞。',
      example_pinyin = 'Wǒ gāng zǒuchū dìtiězhàn tiānkōng jiù xià qǐ le dàyǔ, gānghǎo bāo lǐ dài le yì bǎ zhédié sǎn.',
      example_vi = 'Tôi vừa bước ra khỏi ga tàu điện ngầm thì trời đổ mưa lớn, vừa hay trong túi lại có mang theo một chiếc ô gập.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '刚好',
      'gānghǎo',
      'vừa hay, vừa đúng lúc, vừa vặn',
      'Phó từ / Tính từ',
      'HSK 5',
      '我刚走出地铁站天空就下起了大雨，刚好包里带了一把折叠伞。',
      'Wǒ gāng zǒuchū dìtiězhàn tiānkōng jiù xià qǐ le dàyǔ, gānghǎo bāo lǐ dài le yì bǎ zhédié sǎn.',
      'Tôi vừa bước ra khỏi ga tàu điện ngầm thì trời đổ mưa lớn, vừa hay trong túi lại có mang theo một chiếc ô gập.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我刚走出地铁站天空就下起了大雨，刚好包里带了一把折叠伞。', 'Wǒ gāng zǒuchū dìtiězhàn tiānkōng jiù xià qǐ le dàyǔ, gānghǎo bāo lǐ dài le yì bǎ zhédié sǎn.', 'Tôi vừa bước ra khỏi ga tàu điện ngầm thì trời đổ mưa lớn, vừa hay trong túi lại có mang theo một chiếc ô gập.', 'basic', 1),
      (v_id, '两家高新技术企业在产业链上下游的研发技术储备与全球营销渠道布局上优势互补，此次战略并购刚好达成了无缝对接的协同双赢效应。', 'Liǎng jiā gāoxīn jìshù qǐyè zài chǎnyèliàn shàngxiàyóu de yánfā jìshù chǔbèi yǔ quánqiú yíngxiāo qúdào bùjú shang yōushì hùbǔ, cǐcì zhànlüè bìnggòu gānghǎo dáchéng le wúfèng duìjiē de xiétóng shuāngyíng xiàoyìng.', 'Hai doanh nghiệp công nghệ cao bù trừ ưu thế cho nhau về mặt tích lũy công nghệ nghiên cứu phát triển và bố trí kênh tiếp thị toàn cầu ở cả thượng nguồn lẫn hạ nguồn chuỗi ngành nghề, thương vụ mua bán sáp nhập chiến lược lần này vừa vặn tạo nên hiệu ứng kết nối liền mạch hiệp đồng đôi bên cùng có lợi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2386] [高大] (gāodà) - cao lớn, đồ sộ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '高大' AND pinyin = 'gāodà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高大' AND pinyin = 'gāodà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '高大'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高大'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'gāodà',
      meaning_vi = 'cao lớn, đồ sộ',
      example_hanzi = '道路两旁栽种着一排排高大挺拔的白杨树，在炎炎夏日为行人投下一片清凉的树荫。',
      example_pinyin = 'Dàolù liǎngpáng zāizhòng zhe yì páipái gāodà tǐngbá de báiyángshù, zài yányán xiàrì wèi xíngrén tóuxià yí piàn qīngliáng de shùyīn.',
      example_vi = 'Hai bên đường trồng những hàng cây bạch dương cao lớn sừng sững, tỏa bóng râm mát rượi cho người đi đường trong những ngày hè oi ả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '高大',
      'gāodà',
      'cao lớn, đồ sộ',
      'Tính từ',
      'HSK 5',
      '道路两旁栽种着一排排高大挺拔的白杨树，在炎炎夏日为行人投下一片清凉的树荫。',
      'Dàolù liǎngpáng zāizhòng zhe yì páipái gāodà tǐngbá de báiyángshù, zài yányán xiàrì wèi xíngrén tóuxià yí piàn qīngliáng de shùyīn.',
      'Hai bên đường trồng những hàng cây bạch dương cao lớn sừng sững, tỏa bóng râm mát rượi cho người đi đường trong những ngày hè oi ả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '道路两旁栽种着一排排高大挺拔的白杨树，在炎炎夏日为行人投下一片清凉的树荫。', 'Dàolù liǎngpáng zāizhòng zhe yì páipái gāodà tǐngbá de báiyángshù, zài yányán xiàrì wèi xíngrén tóuxià yí piàn qīngliáng de shùyīn.', 'Hai bên đường trồng những hàng cây bạch dương cao lớn sừng sững, tỏa bóng râm mát rượi cho người đi đường trong những ngày hè oi ả.', 'basic', 1),
      (v_id, '漫步在中央商务区的摩天大楼森林中，一座座高大现代的地标性建筑直插云霄，彰显着这座现代化国际大都市蓬勃雄浑的发展气象。', 'Mànbù zài zhōngyāng shāngwùqū de mótiān dàlóu sēnlín zhōng, yízuòzuò gāodà xiàndài de dìbiāoxìng jiànzhù zhíchā yúnxiāo, zhāngxiǎn zhe zhè zuò xiàndàihuà guójì dà dūshì péngbó xiónghún de fāzhǎn qìxiàng.', 'Tản bộ giữa rừng tòa nhà chọc trời của khu trung tâm thương mại, từng tòa kiến trúc biểu tượng cao lớn hiện đại đâm thẳng lên mây xanh, thể hiện rõ khí thế phát triển phồn thịnh và hùng tráng của siêu đô thị quốc tế hiện đại này.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2387] [高档] (gāodàng) - cao cấp, sang trọng, thượng hạng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '高档' AND pinyin = 'gāodàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高档' AND pinyin = 'gāodàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '高档'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高档'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'gāodàng',
      meaning_vi = 'cao cấp, sang trọng, thượng hạng',
      example_hanzi = '这家位于市中心的高档餐厅环境优雅清静，服务十分周到细致。',
      example_pinyin = 'Zhè jiā wèiyú shìzhōngxīn de gāodàng cāntīng huánjìng yōuyǎ qīngjìng, fúwù shífēn zhōudào xìzhì.',
      example_vi = 'Nhà hàng cao cấp nằm ở trung tâm thành phố này có môi trường tao nhã thanh tịnh, phục vụ vô cùng chu đáo và tỉ mỉ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '高档',
      'gāodàng',
      'cao cấp, sang trọng, thượng hạng',
      'Tính từ',
      'HSK 5',
      '这家位于市中心的高档餐厅环境优雅清静，服务十分周到细致。',
      'Zhè jiā wèiyú shìzhōngxīn de gāodàng cāntīng huánjìng yōuyǎ qīngjìng, fúwù shífēn zhōudào xìzhì.',
      'Nhà hàng cao cấp nằm ở trung tâm thành phố này có môi trường tao nhã thanh tịnh, phục vụ vô cùng chu đáo và tỉ mỉ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家位于市中心的高档餐厅环境优雅清静，服务十分周到细致。', 'Zhè jiā wèiyú shìzhōngxīn de gāodàng cāntīng huánjìng yōuyǎ qīngjìng, fúwù shífēn zhōudào xìzhì.', 'Nhà hàng cao cấp nằm ở trung tâm thành phố này có môi trường tao nhã thanh tịnh, phục vụ vô cùng chu đáo và tỉ mỉ.', 'basic', 1),
      (v_id, '随着中产阶层消费群体的壮大与消费理念的升级，消费者对于智能家居产品由单纯追求性价比，逐步转向青睐高档品质、健康环保与人性化交互设计。', 'Suízhe zhōngchǎn jiēcéng xiāofèi qúntǐ de zhuàngdà yǔ xiāofèi lǐniàn de shēngjí, xiāofèizhě duìyú zhìnéng jiājū chǎnpǐn yóu dānchún zhuīqiú xìngjiàbǐ, zhúbù zhuǎnxiàng qīnglài gāodàng pǐnzhì, jiànkāng huánbǎo yǔ rénxìnghuà jiāohù shèjì.', 'Cùng với sự lớn mạnh của tầng lớp trung lưu và sự nâng cấp quan niệm tiêu dùng, người tiêu dùng đối với các sản phẩm nhà thông minh từ chỗ đơn thuần theo đuổi tỷ lệ hiệu năng trên giá cả đã dần chuyển sang ưa chuộng chất lượng cao cấp, bảo vệ môi trường cho sức khỏe cùng thiết kế tương tác giàu tính nhân văn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2388] [高度] (gāodù) - độ cao, chiều cao; mức độ cao, cao độ [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '高度' AND pinyin = 'gāodù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高度' AND pinyin = 'gāodù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '高度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Phó từ',
      pinyin = 'gāodù',
      meaning_vi = 'độ cao, chiều cao; mức độ cao, cao độ',
      example_hanzi = '客机目前正平稳飞行在巡航高度，窗外的蓝天与白云清晰可见。',
      example_pinyin = 'Kèjī mùqián zhèng píngwěn fēixíng zài xúnháng gāodù, chuāngwài de lántiān yǔ báiyún qīngxī kějiàn.',
      example_vi = 'Máy bay chở khách hiện đang bay ổn định ở độ cao hành trình, bầu trời xanh và mây trắng ngoài cửa sổ có thể nhìn thấy rất rõ ràng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '高度',
      'gāodù',
      'độ cao, chiều cao; mức độ cao, cao độ',
      'Danh từ / Phó từ',
      'HSK 5',
      '客机目前正平稳飞行在巡航高度，窗外的蓝天与白云清晰可见。',
      'Kèjī mùqián zhèng píngwěn fēixíng zài xúnháng gāodù, chuāngwài de lántiān yǔ báiyún qīngxī kějiàn.',
      'Máy bay chở khách hiện đang bay ổn định ở độ cao hành trình, bầu trời xanh và mây trắng ngoài cửa sổ có thể nhìn thấy rất rõ ràng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '客机目前正平稳飞行在巡航高度，窗外的蓝天与白云清晰可见。', 'Kèjī mùqián zhèng píngwěn fēixíng zài xúnháng gāodù, chuāngwài de lántiān yǔ báiyún qīngxī kějiàn.', 'Máy bay chở khách hiện đang bay ổn định ở độ cao hành trình, bầu trời xanh và mây trắng ngoài cửa sổ có thể nhìn thấy rất rõ ràng.', 'basic', 1),
      (v_id, '出席峰会的各国元首高度赞赏了倡议在促进全球基础设施互联互通、消除贫困与应对气候变化方面所取得的丰硕务实合作成果。', 'Chūxí fēnghuì de gè guó yuánshǒu gāodù zànshǎng le chàngyì zài cùjìn quánqiú jīchǔ shèshī hùlián-hùtōng, xiāochú pínkùn yǔ yìngduì qìhòu biànhuà fāngmiàn suǒ qǔdé de fēngshuò wùshí hézuò chéngguǒ.', 'Nguyên thủ các nước tham dự hội nghị thượng đỉnh đánh giá cao độ những thành quả hợp tác thực chất phong phú mà sáng kiến đã đạt được trong việc thúc đẩy kết nối cơ sở hạ tầng toàn cầu, xóa đói giảm nghèo và ứng phó với biến đổi khí hậu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2389] [高级] (gāojí) - cao cấp, bậc cao [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '高级' AND pinyin = 'gāojí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高级' AND pinyin = 'gāojí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '高级'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高级'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'gāojí',
      meaning_vi = 'cao cấp, bậc cao',
      example_hanzi = '通过多年的勤学苦练，他已经顺利获得了国家高级西点烹饪师资格证书。',
      example_pinyin = 'Tōngguò duō nián de qínxué-kǔliàn, tā yǐjīng shùnlì huòdé le guójiā gāojí xīdiǎn pēngrènshī zīgé zhèngshū.',
      example_vi = 'Thông qua nhiều năm chăm chỉ học tập và khổ luyện, anh ấy đã thuận lợi nhận được chứng chỉ tư cách đầu bếp làm bánh ngọt phương Tây bậc cao cấp quốc gia.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '高级',
      'gāojí',
      'cao cấp, bậc cao',
      'Tính từ',
      'HSK 5',
      '通过多年的勤学苦练，他已经顺利获得了国家高级西点烹饪师资格证书。',
      'Tōngguò duō nián de qínxué-kǔliàn, tā yǐjīng shùnlì huòdé le guójiā gāojí xīdiǎn pēngrènshī zīgé zhèngshū.',
      'Thông qua nhiều năm chăm chỉ học tập và khổ luyện, anh ấy đã thuận lợi nhận được chứng chỉ tư cách đầu bếp làm bánh ngọt phương Tây bậc cao cấp quốc gia.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '通过多年的勤学苦练，他已经顺利获得了国家高级西点烹饪师资格证书。', 'Tōngguò duō nián de qínxué-kǔliàn, tā yǐjīng shùnlì huòdé le guójiā gāojí xīdiǎn pēngrènshī zīgé zhèngshū.', 'Thông qua nhiều năm chăm chỉ học tập và khổ luyện, anh ấy đã thuận lợi nhận được chứng chỉ tư cách đầu bếp làm bánh ngọt phương Tây bậc cao cấp quốc gia.', 'basic', 1),
      (v_id, '这家跨国制药企业面向全球公开发布高级研究员招募计划，开出丰厚的股权期权与顶尖的科研实验平台，吸引了数十位海内外院士级科学家加盟。', 'Zhè jiā kuàguó zhìyào qǐyè miànxiàng quánqiú gōngkāi fābù gāojí yánjiūyuán zhāomù jìhuà, kāichū fēnghòu de gǔquán qīquán yǔ dǐngjiān de kēyán shíyàn píngtái, xīyǐn le shù shí wèi hǎinèiwài yuànshìjí kēxuéjiā jiāméng.', 'Doanh nghiệp dược phẩm đa quốc gia này đã công bố kế hoạch chiêu mộ nghiên cứu viên cao cấp hướng tới toàn cầu, đưa ra quyền chọn cổ phần hậu hĩnh cùng nền tảng thí nghiệm nghiên cứu khoa học đỉnh cao, thu hút hàng chục nhà khoa học cấp viện sĩ trong và ngoài nước gia nhập.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2390] [高科技] (gāokējì) - công nghệ cao [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '高科技' AND pinyin = 'gāokējì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高科技' AND pinyin = 'gāokējì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '高科技'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高科技'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gāokējì',
      meaning_vi = 'công nghệ cao',
      example_hanzi = '现代现代农业依托温室大棚和高科技物联网传感器，实现了农作物全天候智能灌溉与施肥。',
      example_pinyin = 'Xiàndài nóngyè yītuō wēnshì dàpéng hé gāokējì wùliánwǎng chuángǎnqì, shíxiàn le nóngzuòwù quántiānhòu zhìnéng guàngài yǔ shīféi.',
      example_vi = 'Nông nghiệp hiện đại dựa vào nhà kính nhà màng và các cảm biến vạn vật kết nối công nghệ cao, đã thực hiện việc tưới tiêu và bón phân thông minh mọi lúc cho cây trồng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '高科技',
      'gāokējì',
      'công nghệ cao',
      'Danh từ',
      'HSK 5',
      '现代现代农业依托温室大棚和高科技物联网传感器，实现了农作物全天候智能灌溉与施肥。',
      'Xiàndài nóngyè yītuō wēnshì dàpéng hé gāokējì wùliánwǎng chuángǎnqì, shíxiàn le nóngzuòwù quántiānhòu zhìnéng guàngài yǔ shīféi.',
      'Nông nghiệp hiện đại dựa vào nhà kính nhà màng và các cảm biến vạn vật kết nối công nghệ cao, đã thực hiện việc tưới tiêu và bón phân thông minh mọi lúc cho cây trồng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现代现代农业依托温室大棚和高科技物联网传感器，实现了农作物全天候智能灌溉与施肥。', 'Xiàndài nóngyè yītuō wēnshì dàpéng hé gāokējì wùliánwǎng chuángǎnqì, shíxiàn le nóngzuòwù quántiānhòu zhìnéng guàngài yǔ shīféi.', 'Nông nghiệp hiện đại dựa vào nhà kính nhà màng và các cảm biến vạn vật kết nối công nghệ cao, đã thực hiện việc tưới tiêu và bón phân thông minh mọi lúc cho cây trồng.', 'basic', 1),
      (v_id, '国家级高新区积极打造集前沿基础研究、高科技成果转化与天使风险投资基金于一体的完整创新孵化生态链，培育了一大批专精特新“小巨人”企业。', 'Guójiājí gāoxīnqū jījí dǎzào jí qiányán jīchǔ yánjiū, gāokējì chéngguǒ zhuǎnhuà yǔ tiānshǐ fēngxiǎn tóuzī jījīn yú yītǐ de wánzhěng chuàngxīn fūhuà shēngtàiliàn, péiyù le yí dà pī zhuānjīngtèxīn “xiǎo jùrén” qǐyè.', 'Khu công nghệ cao cấp quốc gia tích cực xây dựng chuỗi sinh thái ươm tạo đổi mới hoàn chỉnh kết hợp giữa nghiên cứu cơ bản mũi nhọn, chuyển giao thành quả công nghệ cao và quỹ đầu tư mạo hiểm thiên thần, bồi dưỡng nên một lượng lớn các doanh nghiệp "người khổng lồ tí hon" chuyên sâu tinh nhuệ đặc sắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2391] [高效] (gāoxiào) - hiệu quả cao, năng suất cao [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '高效' AND pinyin = 'gāoxiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高效' AND pinyin = 'gāoxiào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '高效'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '高效'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'gāoxiào',
      meaning_vi = 'hiệu quả cao, năng suất cao',
      example_hanzi = '养成良好的时间管理习惯有助于我们在日常工作中保持专注与高效。',
      example_pinyin = 'Yǎngchéng liánghǎo de shíjiān guǎnlǐ xíguàn yǒuzhù yú wǒmen zài rìcháng gōngzuò zhōng bǎochí zhuānzhù yǔ gāoxiào.',
      example_vi = 'Xây dựng thói quen quản lý thời gian tốt sẽ giúp chúng ta duy trì được sự tập trung và hiệu suất cao trong công việc hàng ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '高效',
      'gāoxiào',
      'hiệu quả cao, năng suất cao',
      'Tính từ',
      'HSK 5',
      '养成良好的时间管理习惯有助于我们在日常工作中保持专注与高效。',
      'Yǎngchéng liánghǎo de shíjiān guǎnlǐ xíguàn yǒuzhù yú wǒmen zài rìcháng gōngzuò zhōng bǎochí zhuānzhù yǔ gāoxiào.',
      'Xây dựng thói quen quản lý thời gian tốt sẽ giúp chúng ta duy trì được sự tập trung và hiệu suất cao trong công việc hàng ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '养成良好的时间管理习惯有助于我们在日常工作中保持专注与高效。', 'Yǎngchéng liánghǎo de shíjiān guǎnlǐ xíguàn yǒuzhù yú wǒmen zài rìcháng gōngzuò zhōng bǎochí zhuānzhù yǔ gāoxiào.', 'Xây dựng thói quen quản lý thời gian tốt sẽ giúp chúng ta duy trì được sự tập trung và hiệu suất cao trong công việc hàng ngày.', 'basic', 1),
      (v_id, '自动化智能立体仓储系统凭借无人搬运机器人AGV与高效智能分拣算法的深度协作，将包裹出入库周转效率提升了近三倍。', 'Zìdònghuà zhìnéng lìtǐ cāngchǔ xìtǒng píngjiè wúrén bānyùn jīqìrén AGV yǔ gāoxiào zhìnéng fēnjiǎn suànfǎ de shēndù xiézuò, jiāng bāoguǒ chūrùkù zhōuzhuǎn xiàolǜ tíshēng le jìn sān bèi.', 'Hệ thống kho bãi thông minh tự động đa tầng dựa vào sự hợp tác chuyên sâu giữa robot vận chuyển tự hành AGV và thuật toán phân loại thông minh hiệu quả cao, đã nâng cao hiệu suất luân chuyển xuất nhập kho kiện hàng lên gần ba lần.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2392] [搞] (gǎo) - làm, tiến hành, xử lý, lo liệu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '搞' AND pinyin = 'gǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '搞' AND pinyin = 'gǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '搞'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '搞'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gǎo',
      meaning_vi = 'làm, tiến hành, xử lý, lo liệu',
      example_hanzi = '经过大家连续几个晚上的加班整理，终于把这次大型活动的所有策划方案搞定了。',
      example_pinyin = 'Jīngguò dàjiā liánxù jǐ gè wǎnshang de jiābān zhěnglǐ, zhōngyú bǎ zhè cì dàxíng huódòng de suǒyǒu cèhuà fāng’àn gǎodìng le.',
      example_vi = 'Trải qua mấy đêm liên tục tăng ca sắp xếp của mọi người, rốt cuộc đã làm xong ổn thỏa toàn bộ phương án kế hoạch cho sự kiện lớn lần này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '搞',
      'gǎo',
      'làm, tiến hành, xử lý, lo liệu',
      'Động từ',
      'HSK 5',
      '经过大家连续几个晚上的加班整理，终于把这次大型活动的所有策划方案搞定了。',
      'Jīngguò dàjiā liánxù jǐ gè wǎnshang de jiābān zhěnglǐ, zhōngyú bǎ zhè cì dàxíng huódòng de suǒyǒu cèhuà fāng’àn gǎodìng le.',
      'Trải qua mấy đêm liên tục tăng ca sắp xếp của mọi người, rốt cuộc đã làm xong ổn thỏa toàn bộ phương án kế hoạch cho sự kiện lớn lần này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过大家连续几个晚上的加班整理，终于把这次大型活动的所有策划方案搞定了。', 'Jīngguò dàjiā liánxù jǐ gè wǎnshang de jiābān zhěnglǐ, zhōngyú bǎ zhè cì dàxíng huódòng de suǒyǒu cèhuà fāng’àn gǎodìng le.', 'Trải qua mấy đêm liên tục tăng ca sắp xếp của mọi người, rốt cuộc đã làm xong ổn thỏa toàn bộ phương án kế hoạch cho sự kiện lớn lần này.', 'basic', 1),
      (v_id, '基层行政管理工作一定要尊重客观经济规律，坚决戒除形式主义，切忌脱离群众实际需求去搞劳民伤财的所谓“形象工程”。', 'Jīcéng xíngzhèng guǎnlǐ gōngzuò yídìng yào zūnzhòng kèguān jīngjì guīlǜ, jiānjué jièchú xíngshì zhǔyì, qièjì tuōlí qúnzhòng shíjì xūqiú qù gǎo láomín-shāngcái de suǒwèi “xíngxiàng gōngchéng”.', 'Công tác quản lý hành chính cấp cơ sở nhất định phải tôn trọng quy luật kinh tế khách quan, kiên quyết từ bỏ chủ nghĩa hình thức, tuyệt đối tránh xa việc xa rời nhu cầu thực tế của quần chúng mà đi làm những cái gọi là "công trình hình ảnh" tốn công hao của.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2393] [告别] (gàobié) - từ biệt, chia tay, cáo biệt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '告别' AND pinyin = 'gàobié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '告别' AND pinyin = 'gàobié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '告别'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '告别'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gàobié',
      meaning_vi = 'từ biệt, chia tay, cáo biệt',
      example_hanzi = '火车即将缓缓启动，站台上的亲友们纷纷挥手向即将远行的游子告别。',
      example_pinyin = 'Huǒchē jíjiāng huǎnhuǎn qǐdòng, zhàntái shang de qīnyǒu men fēnfēn huīshǒu xiàng jíjiāng yuǎnxíng de yóuzǐ gàobié.',
      example_vi = 'Chuyến tàu sắp sửa từ từ lăn bánh, người thân và bạn bè trên sân ga đồng loạt vẫy tay từ biệt người con sắp đi xa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '告别',
      'gàobié',
      'từ biệt, chia tay, cáo biệt',
      'Động từ',
      'HSK 5',
      '火车即将缓缓启动，站台上的亲友们纷纷挥手向即将远行的游子告别。',
      'Huǒchē jíjiāng huǎnhuǎn qǐdòng, zhàntái shang de qīnyǒu men fēnfēn huīshǒu xiàng jíjiāng yuǎnxíng de yóuzǐ gàobié.',
      'Chuyến tàu sắp sửa từ từ lăn bánh, người thân và bạn bè trên sân ga đồng loạt vẫy tay từ biệt người con sắp đi xa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '火车即将缓缓启动，站台上的亲友们纷纷挥手向即将远行的游子告别。', 'Huǒchē jíjiāng huǎnhuǎn qǐdòng, zhàntái shang de qīnyǒu men fēnfēn huīshǒu xiàng jíjiāng yuǎnxíng de yóuzǐ gàobié.', 'Chuyến tàu sắp sửa từ từ lăn bánh, người thân và bạn bè trên sân ga đồng loạt vẫy tay từ biệt người con sắp đi xa.', 'basic', 1),
      (v_id, '随着高标准脱贫攻坚战役取得全面胜利，昔日深度贫困山区的百万农户彻底告别了土坯危房与泥泞土路，搬进了宽敞明亮、配套完善的现代化新居。', 'Suízhe gāo biāozhǔn tuōpín gōngjiān zhànyì qǔdé quánmiàn shènglì, xīrì shēndù pínkùn shānqū de bǎi wàn nónghù chèdǐ gàobié le tǔpī wēifáng yǔ nínìng tǔlù, bān jìn le kuānchǎng míngliàng, pèitào wánshàn de xiàndàihuà xīnjū.', 'Cùng với thắng lợi toàn diện của chiến dịch xóa đói giảm nghèo tiêu chuẩn cao, hàng triệu hộ nông dân vùng núi nghèo khó sâu năm nào đã hoàn toàn vĩnh biệt những căn nhà đất xiêu vẹo cùng đường đất bùn lầy, dọn vào những ngôi nhà mới hiện đại khang trang sáng sủa với tiện ích đồng bộ hoàn thiện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2394] [歌词] (gēcí) - lời bài hát [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '歌词' AND pinyin = 'gēcí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '歌词' AND pinyin = 'gēcí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '歌词'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '歌词'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gēcí',
      meaning_vi = 'lời bài hát',
      example_hanzi = '这首流行民谣的歌词优美动人，写出了许多在外漂泊奋斗年轻人的真实心声。',
      example_pinyin = 'Zhè shǒu liúxíng mínyáo de gēcí yōuměi dòngrén, xiě chū le xǔduō zài wài piāobó fèndòu niánqīngrén de zhēnshí xīnshēng.',
      example_vi = 'Lời bài hát của ca khúc dân ca thịnh hành này đẹp đẽ và xúc động lòng người, viết nên tiếng lòng chân thực của biết bao người trẻ tuổi đang bôn ba phấn đấu nơi đất khách.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '歌词',
      'gēcí',
      'lời bài hát',
      'Danh từ',
      'HSK 5',
      '这首流行民谣的歌词优美动人，写出了许多在外漂泊奋斗年轻人的真实心声。',
      'Zhè shǒu liúxíng mínyáo de gēcí yōuměi dòngrén, xiě chū le xǔduō zài wài piāobó fèndòu niánqīngrén de zhēnshí xīnshēng.',
      'Lời bài hát của ca khúc dân ca thịnh hành này đẹp đẽ và xúc động lòng người, viết nên tiếng lòng chân thực của biết bao người trẻ tuổi đang bôn ba phấn đấu nơi đất khách.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这首流行民谣的歌词优美动人，写出了许多在外漂泊奋斗年轻人的真实心声。', 'Zhè shǒu liúxíng mínyáo de gēcí yōuměi dòngrén, xiě chū le xǔduō zài wài piāobó fèndòu niánqīngrén de zhēnshí xīnshēng.', 'Lời bài hát của ca khúc dân ca thịnh hành này đẹp đẽ và xúc động lòng người, viết nên tiếng lòng chân thực của biết bao người trẻ tuổi đang bôn ba phấn đấu nơi đất khách.', 'basic', 1),
      (v_id, '词曲作者深情挖掘古典诗词的意境之美，在歌词创作中化用了李白与苏轼的千古绝句，使得整首国风音乐作品韵味悠长且意蕴深远。', 'Cíqǔ zuòzhě shēnqíng wājué gǔdiǎn shīcí de yìjìng zhī měi, zài gēcí chuàngzuò zhōng huàyòng le Lǐ Bái yǔ Sū Shì de qiāngǔ juéjù, shǐdé zhěng shǒu guófēng yīnyuè zuòpǐn yùnwèi yōucháng qiě yìyùn shēnyuǎn.', 'Nhạc sĩ sáng tác lời và nhạc đã đào sâu vẻ đẹp ý cảnh của thơ từ cổ điển, khéo léo vận dụng những câu thơ tuyệt cú ngàn đời của Lý Bạch và Tô Thức vào sáng tác lời bài hát, khiến toàn bộ tác phẩm âm nhạc phong cách dân gian mang đậm dư vị lắng đọng và ý tứ sâu xa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2395] [歌曲] (gēqǔ) - bài hát, ca khúc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '歌曲' AND pinyin = 'gēqǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '歌曲' AND pinyin = 'gēqǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '歌曲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '歌曲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gēqǔ',
      meaning_vi = 'bài hát, ca khúc',
      example_hanzi = '每当听到这首熟悉的经典老歌，他的脑海中就会不由自主地浮现出童年的欢乐时光。',
      example_pinyin = 'Měidāng tīngdào zhè shǒu shúxī de jīngdiǎn lǎogē, tā de nǎohǎi zhōng jiù huì bùyóuzìzhǔ de fúxiàn chū tóngnián de huānlè shíguāng.',
      example_vi = 'Mỗi khi nghe thấy bài hát cũ kinh điển quen thuộc này, trong tâm trí anh ấy lại bất giác hiện lên những khoảng thời gian ấu thơ vui tươi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '歌曲',
      'gēqǔ',
      'bài hát, ca khúc',
      'Danh từ',
      'HSK 5',
      '每当听到这首熟悉的经典老歌，他的脑海中就会不由自主地浮现出童年的欢乐时光。',
      'Měidāng tīngdào zhè shǒu shúxī de jīngdiǎn lǎogē, tā de nǎohǎi zhōng jiù huì bùyóuzìzhǔ de fúxiàn chū tóngnián de huānlè shíguāng.',
      'Mỗi khi nghe thấy bài hát cũ kinh điển quen thuộc này, trong tâm trí anh ấy lại bất giác hiện lên những khoảng thời gian ấu thơ vui tươi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每当听到这首熟悉的经典老歌，他的脑海中就会不由自主地浮现出童年的欢乐时光。', 'Měidāng tīngdào zhè shǒu shúxī de jīngdiǎn lǎogē, tā de nǎohǎi zhōng jiù huì bùyóuzìzhǔ de fúxiàn chū tóngnián de huānlè shíguāng.', 'Mỗi khi nghe thấy bài hát cũ kinh điển quen thuộc này, trong tâm trí anh ấy lại bất giác hiện lên những khoảng thời gian ấu thơ vui tươi.', 'basic', 1),
      (v_id, '由多国顶尖音乐家联袂创作的主题公益歌曲，以跨越国界与种族的崇高艺术感染力，呼吁全人类团结携手保护生物多样性与共同赖以生存的地球家园。', 'Yóu duō guó dǐngjiān yīnyuèjiā liánmèi chuàngzuò de zhǔtí gōngyì gēqǔ, yǐ kuàyuè guójiè yǔ zhǒngzú de chónggāo yìshù gǎnrǎnlì, hūyù quán rénlèi tuánjié xiéshǒu bǎohù shēngwù duōyàngxìng yǔ gòngtóng làiyǐ shēngcún de dìqiú jiāyuán.', 'Ca khúc công ích chủ đề do các nhạc sĩ đỉnh cao của nhiều quốc gia phối hợp sáng tác, với sức truyền cảm nghệ thuật cao cả vượt qua biên giới quốc gia và sắc tộc, đã kêu gọi toàn nhân loại đoàn kết chung tay bảo vệ tính đa dạng sinh học và ngôi nhà Trái Đất cùng chung sống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2396] [隔] (gé) - cách, cách nhau, ngăn cách [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '隔' AND pinyin = 'gé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '隔' AND pinyin = 'gé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '隔'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '隔'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gé',
      meaning_vi = 'cách, cách nhau, ngăn cách',
      example_hanzi = '医生叮嘱他每隔四个小时按时服用一次消炎药，并多喝温开水休息。',
      example_pinyin = 'Yīshēng dīngzhǔ tā měi gé sì gè xiǎoshí ànshí fúyòng yí cì xiāoyányào, bìng duō hē wēn kāishuǐ xiūxi.',
      example_vi = 'Bác sĩ dặn dò anh ấy cứ cách bốn tiếng lại uống thuốc chống viêm đúng giờ một lần, đồng thời uống nhiều nước ấm để nghỉ ngơi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '隔',
      'gé',
      'cách, cách nhau, ngăn cách',
      'Động từ',
      'HSK 5',
      '医生叮嘱他每隔四个小时按时服用一次消炎药，并多喝温开水休息。',
      'Yīshēng dīngzhǔ tā měi gé sì gè xiǎoshí ànshí fúyòng yí cì xiāoyányào, bìng duō hē wēn kāishuǐ xiūxi.',
      'Bác sĩ dặn dò anh ấy cứ cách bốn tiếng lại uống thuốc chống viêm đúng giờ một lần, đồng thời uống nhiều nước ấm để nghỉ ngơi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '医生叮嘱他每隔四个小时按时服用一次消炎药，并多喝温开水休息。', 'Yīshēng dīngzhǔ tā měi gé sì gè xiǎoshí ànshí fúyòng yí cì xiāoyányào, bìng duō hē wēn kāishuǐ xiūxi.', 'Bác sĩ dặn dò anh ấy cứ cách bốn tiếng lại uống thuốc chống viêm đúng giờ một lần, đồng thời uống nhiều nước ấm để nghỉ ngơi.', 'basic', 1),
      (v_id, '尽管两地相隔数千公里的重山险阻与大洋阻隔，但日新月异的高速铁路网络与超高速卫星通信链路，已将天涯海角拉近为近在咫尺的数字化生活圈。', 'Jǐnguǎn liǎng dì xiānggé shù qiān gōnglǐ de zhòngshān xiǎnzǔ yǔ dàyáng zǔgé, dàn rìxīn-yuèyì de gāosù tiělù wǎngluò yǔ chāogāosù wèixīng tōngxìn liànlù, yǐ jiāng tiānyá-hǎijiǎo lājìn wéi jìn zài zhǐchǐ de shùzìhuà shēnghuóquān.', 'Dù cho hai nơi cách nhau hàng nghìn cây số núi non hiểm trở cùng đại dương chia cắt, nhưng mạng lưới đường sắt cao tốc biến đổi từng ngày và tuyến liên lạc vệ tinh siêu tốc độ đã kéo góc bể chân trời lại gần chỉ trong gang tấc của vòng tròn cuộc sống số hóa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2397] [格外] (géwài) - đặc biệt, hết sức, vô cùng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '格外' AND pinyin = 'géwài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '格外' AND pinyin = 'géwài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '格外'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '格外'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'géwài',
      meaning_vi = 'đặc biệt, hết sức, vô cùng',
      example_hanzi = '秋雨过后，天空放晴，远处的香山红叶在明媚的阳光照耀下显得格外绚丽夺目。',
      example_pinyin = 'Qiūyǔ guòhòu, tiānkōng fàngqíng, yuǎnchù de Xiāngshān hóngyè zài míngmèi de yángguāng zhàoyào xià xiǎnde géwài xuànlì duómù.',
      example_vi = 'Sau cơn mưa thu, trời quang mây tạnh, lá đỏ núi Hương Sơn ở đằng xa dưới ánh nắng rực rỡ chiếu rọi trông vô cùng lộng lẫy và bắt mắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '格外',
      'géwài',
      'đặc biệt, hết sức, vô cùng',
      'Phó từ',
      'HSK 5',
      '秋雨过后，天空放晴，远处的香山红叶在明媚的阳光照耀下显得格外绚丽夺目。',
      'Qiūyǔ guòhòu, tiānkōng fàngqíng, yuǎnchù de Xiāngshān hóngyè zài míngmèi de yángguāng zhàoyào xià xiǎnde géwài xuànlì duómù.',
      'Sau cơn mưa thu, trời quang mây tạnh, lá đỏ núi Hương Sơn ở đằng xa dưới ánh nắng rực rỡ chiếu rọi trông vô cùng lộng lẫy và bắt mắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '秋雨过后，天空放晴，远处的香山红叶在明媚的阳光照耀下显得格外绚丽夺目。', 'Qiūyǔ guòhòu, tiānkōng fàngqíng, yuǎnchù de Xiāngshān hóngyè zài míngmèi de yángguāng zhàoyào xià xiǎnde géwài xuànlì duómù.', 'Sau cơn mưa thu, trời quang mây tạnh, lá đỏ núi Hương Sơn ở đằng xa dưới ánh nắng rực rỡ chiếu rọi trông vô cùng lộng lẫy và bắt mắt.', 'basic', 1),
      (v_id, '面对世界百年未有之大变局与复杂严峻的外部地缘政治经济环境，保持战略定力并扎实做好国内实体经济高质量发展显得格外重要且紧迫。', 'Miànduì shìjiè bǎinián wèiyǒu zhī dà biànjú yǔ fùzá yánjùn de wàibù dìyuán zhèngzhì jīngjì huánjìng, bǎochí zhànlüè dìnglì bìng zhāshí zuò hǎo guónèi shítǐ jīngjì gāo zhìliàng fāzhǎn xiǎnde géwài zhòngyào qiě jǐnpò.', 'Đứng trước cục diện biến đổi lớn trăm năm chưa từng có của thế giới và môi trường kinh tế địa chính trị bên ngoài phức tạp gay gắt, việc giữ vững định lực chiến lược và làm tốt vững chắc phát triển kinh tế thực chất lượng cao trong nước trở nên vô cùng quan trọng và cấp bách.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2398] [个别] (gèbié) - cá biệt, riêng lẻ, một vài [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '个别' AND pinyin = 'gèbié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '个别' AND pinyin = 'gèbié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '个别'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '个别'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Tính từ',
      pinyin = 'gèbié',
      meaning_vi = 'cá biệt, riêng lẻ, một vài',
      example_hanzi = '除了个别偏远山区的包裹由于道路塌方需要稍作延误外，绝大部分快递都已按期送达。',
      example_pinyin = 'Chúle gèbié piānyuǎn shānqū de bāoguǒ yóuyú dàolù tāfāng xūyào shāo zuò yánwù wài, juédàbùfen kuàidì dōu yǐ ànqī sòngdá.',
      example_vi = 'Ngoại trừ một vài kiện hàng ở vùng núi xa xôi do sạt lở đường sá cần phải chậm lại một chút ra, tuyệt đại đa số bưu kiện chuyển phát nhanh đều đã được giao đúng hạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '个别',
      'gèbié',
      'cá biệt, riêng lẻ, một vài',
      'Phó từ / Tính từ',
      'HSK 5',
      '除了个别偏远山区的包裹由于道路塌方需要稍作延误外，绝大部分快递都已按期送达。',
      'Chúle gèbié piānyuǎn shānqū de bāoguǒ yóuyú dàolù tāfāng xūyào shāo zuò yánwù wài, juédàbùfen kuàidì dōu yǐ ànqī sòngdá.',
      'Ngoại trừ một vài kiện hàng ở vùng núi xa xôi do sạt lở đường sá cần phải chậm lại một chút ra, tuyệt đại đa số bưu kiện chuyển phát nhanh đều đã được giao đúng hạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '除了个别偏远山区的包裹由于道路塌方需要稍作延误外，绝大部分快递都已按期送达。', 'Chúle gèbié piānyuǎn shānqū de bāoguǒ yóuyú dàolù tāfāng xūyào shāo zuò yánwù wài, juédàbùfen kuàidì dōu yǐ ànqī sòngdá.', 'Ngoại trừ một vài kiện hàng ở vùng núi xa xôi do sạt lở đường sá cần phải chậm lại một chút ra, tuyệt đại đa số bưu kiện chuyển phát nhanh đều đã được giao đúng hạn.', 'basic', 1),
      (v_id, '监管检查组强调，虽然行业整体合规经营态势良好，但仍需高度警惕个别金融机构私自违规设立资金池与变相抬高小微企业融资成本等隐性问题。', 'Jiānguǎn jiǎncházǔ qiángdiào, suīrán hángyè zhěngtǐ hégūi jīngyíng tàishì liánghǎo, dàn réng xū gāodù jǐngtì gèbié jīnróng jīgòu sīzì wéiguī shèlì zījīncí yǔ biànxiàng táigāo xiǎowēi qǐyè róngzī chéngběn děng yǐnxìng wèntí.', 'Tổ kiểm tra giám sát nhấn mạnh rằng, mặc dù tình hình kinh doanh tuân thủ chung của toàn ngành là tốt, nhưng vẫn cần hết sức cảnh giác với những vấn đề tiềm ẩn mang tính cá biệt như việc một vài tổ chức tài chính tự ý vi phạm lập quỹ gom vốn và trá hình đội chi phí gọi vốn của doanh nghiệp nhỏ và siêu nhỏ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2399] [各行各业] (gèháng-gèyè) - các ngành các nghề, mọi ngành nghề [Cụm danh từ / Thành ngữ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '各行各业' AND pinyin = 'gèháng-gèyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '各行各业' AND pinyin = 'gèháng-gèyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '各行各业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '各行各业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Cụm danh từ / Thành ngữ',
      pinyin = 'gèháng-gèyè',
      meaning_vi = 'các ngành các nghề, mọi ngành nghề',
      example_hanzi = '无论身处各行各业的哪个工作岗位，只要脚踏实地精益求精，都能干出一流的业绩。',
      example_pinyin = 'Wúlùn shēnchǔ gèháng-gèyè de nǎ gè gōngzuò gǎngwèi, zhǐyào jiǎotà-shídì jīngyì-qiújīng, dōu néng gàn chū yīliú de yèjì.',
      example_vi = 'Bất luận ở cương vị công tác nào trong các ngành các nghề, chỉ cần làm việc thiết thực chắc chắn và không ngừng trau chuốt tinh tế, thì đều có thể tạo nên thành tích xuất sắc hàng đầu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '各行各业',
      'gèháng-gèyè',
      'các ngành các nghề, mọi ngành nghề',
      'Cụm danh từ / Thành ngữ',
      'HSK 5',
      '无论身处各行各业的哪个工作岗位，只要脚踏实地精益求精，都能干出一流的业绩。',
      'Wúlùn shēnchǔ gèháng-gèyè de nǎ gè gōngzuò gǎngwèi, zhǐyào jiǎotà-shídì jīngyì-qiújīng, dōu néng gàn chū yīliú de yèjì.',
      'Bất luận ở cương vị công tác nào trong các ngành các nghề, chỉ cần làm việc thiết thực chắc chắn và không ngừng trau chuốt tinh tế, thì đều có thể tạo nên thành tích xuất sắc hàng đầu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论身处各行各业的哪个工作岗位，只要脚踏实地精益求精，都能干出一流的业绩。', 'Wúlùn shēnchǔ gèháng-gèyè de nǎ gè gōngzuò gǎngwèi, zhǐyào jiǎotà-shídì jīngyì-qiújīng, dōu néng gàn chū yīliú de yèjì.', 'Bất luận ở cương vị công tác nào trong các ngành các nghề, chỉ cần làm việc thiết thực chắc chắn và không ngừng trau chuốt tinh tế, thì đều có thể tạo nên thành tích xuất sắc hàng đầu.', 'basic', 1),
      (v_id, '以生成式人工智能、大数据算法与工业物联网为代表的新一代信息技术，正以不可阻挡之势全面深度赋能各行各业，加速重构全球产业链的核心格局。', 'Yǐ shēngchéngxìng réngōng zhìnéng, dàshùjù suànfǎ yǔ gōngyè wùliánwǎng wéi dàibiǎo de xīn yídài xìnxī jìshù, zhèng yǐ bùkě zǔdǎng zhī shì quánmiàn shēndù fùnéng gèháng-gèyè, jiāsù chónggòu quánqiú chǎnyèliàn de héxīn gégú.', 'Thế hệ công nghệ thông tin mới mà tiêu biểu là trí tuệ nhân tạo tạo sinh, thuật toán dữ liệu lớn và vạn vật kết nối công nghiệp, đang với thế không thể ngăn cản tiếp thêm sức mạnh toàn diện chuyên sâu cho mọi ngành nghề, đẩy nhanh tái định hình cục diện cốt lõi của chuỗi ngành nghề toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2400] [个人] (gèrén) - cá nhân, bản thân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '个人' AND pinyin = 'gèrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '个人' AND pinyin = 'gèrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '个人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '个人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gèrén',
      meaning_vi = 'cá nhân, bản thân',
      example_hanzi = '在公共网络环境中切勿随意点击陌生链接，以防个人身份证号与银行密码遭到泄露。',
      example_pinyin = 'Zài gōnggòng wǎngluò huánjìng zhōng qièwù suíyì diǎnjī mòshēng liànjiē, yǐfáng gèrén shēnfènzhèng hào yǔ yínháng mìmǎ zāodào xièlòu.',
      example_vi = 'Trong môi trường mạng công cộng tuyệt đối không tùy tiện nhấp vào các đường link lạ, để phòng ngừa số chứng minh nhân dân cá nhân và mật khẩu ngân hàng bị rò rỉ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '个人',
      'gèrén',
      'cá nhân, bản thân',
      'Danh từ',
      'HSK 5',
      '在公共网络环境中切勿随意点击陌生链接，以防个人身份证号与银行密码遭到泄露。',
      'Zài gōnggòng wǎngluò huánjìng zhōng qièwù suíyì diǎnjī mòshēng liànjiē, yǐfáng gèrén shēnfènzhèng hào yǔ yínháng mìmǎ zāodào xièlòu.',
      'Trong môi trường mạng công cộng tuyệt đối không tùy tiện nhấp vào các đường link lạ, để phòng ngừa số chứng minh nhân dân cá nhân và mật khẩu ngân hàng bị rò rỉ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在公共网络环境中切勿随意点击陌生链接，以防个人身份证号与银行密码遭到泄露。', 'Zài gōnggòng wǎngluò huánjìng zhōng qièwù suíyì diǎnjī mòshēng liànjiē, yǐfáng gèrén shēnfènzhèng hào yǔ yínháng mìmǎ zāodào xièlòu.', 'Trong môi trường mạng công cộng tuyệt đối không tùy tiện nhấp vào các đường link lạ, để phòng ngừa số chứng minh nhân dân cá nhân và mật khẩu ngân hàng bị rò rỉ.', 'basic', 1),
      (v_id, '国家网络安全法与个人信息保护法明确划定了数字经济中企事业单位收集、存储和使用个人敏感数据的法定底线与严格合规边界。', 'Guójiā wǎngluò ānquánfǎ yǔ gèrén xìnxī bǎohùfǎ míngquè huàdìng le shùzì jīngjì zhōng qǐshìyè dānwèi shǒují, cúnchǔ hé shǐyòng gèrén mǐngǎn shùjù de fǎdìng dǐxiàn yǔ yángé hégūi biānjiè.', 'Luật An toàn mạng và Luật Bảo vệ thông tin cá nhân của nhà nước đã phân định rõ ràng ranh giới pháp lý tối thiểu và phạm vi tuân thủ nghiêm ngặt đối với việc thu thập, lưu trữ và sử dụng dữ liệu nhạy cảm cá nhân của các cơ quan doanh nghiệp trong nền kinh tế số.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2401] [个性] (gèxìng) - cá tính, nét tính cách độc đáo riêng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '个性' AND pinyin = 'gèxìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '个性' AND pinyin = 'gèxìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '个性'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '个性'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gèxìng',
      meaning_vi = 'cá tính, nét tính cách độc đáo riêng',
      example_hanzi = '优秀的家庭教育应当鼓励孩子自由探索，充分尊重并包容孩子独特的个性与兴趣发展。',
      example_pinyin = 'Yōuxiù de jiātíng jiàoyù yīngdāng gǔlì háizi zìyóu tànsuǒ, chōngfèn zūnzhòng bìng bāoróng háizi dútè de gèxìng yǔ xìngqù fāzhǎn.',
      example_vi = 'Giáo dục gia đình xuất sắc nên khuyến khích con trẻ tự do khám phá, tôn trọng đầy đủ và bao dung cho cá tính độc đáo cùng sự phát triển sở thích của con.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '个性',
      'gèxìng',
      'cá tính, nét tính cách độc đáo riêng',
      'Danh từ',
      'HSK 5',
      '优秀的家庭教育应当鼓励孩子自由探索，充分尊重并包容孩子独特的个性与兴趣发展。',
      'Yōuxiù de jiātíng jiàoyù yīngdāng gǔlì háizi zìyóu tànsuǒ, chōngfèn zūnzhòng bìng bāoróng háizi dútè de gèxìng yǔ xìngqù fāzhǎn.',
      'Giáo dục gia đình xuất sắc nên khuyến khích con trẻ tự do khám phá, tôn trọng đầy đủ và bao dung cho cá tính độc đáo cùng sự phát triển sở thích của con.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '优秀的家庭教育应当鼓励孩子自由探索，充分尊重并包容孩子独特的个性与兴趣发展。', 'Yōuxiù de jiātíng jiàoyù yīngdāng gǔlì háizi zìyóu tànsuǒ, chōngfèn zūnzhòng bìng bāoróng háizi dútè de gèxìng yǔ xìngqù fāzhǎn.', 'Giáo dục gia đình xuất sắc nên khuyến khích con trẻ tự do khám phá, tôn trọng đầy đủ và bao dung cho cá tính độc đáo cùng sự phát triển sở thích của con.', 'basic', 1),
      (v_id, '新一代年轻消费者在选购文创产品与智能电子设备时，越来越看重产品设计所彰显的文化认同感、审美情趣与鲜明的个性化生活主张。', 'Xīn yídài niánqīng xiāofèizhě zài xuǎngòu wénchuàng chǎnpǐn yǔ zhìnéng diànzǐ shèbèi shí, yuèláiyuè kànzhòng chǎnpǐn shèjì suǒ zhāngxiǎn de wénhuà rèntónggǎn, shěnměi qíngqù yǔ xiānmíng de gèxìnghuà shēnghuó zhǔzhāng.', 'Thế hệ người tiêu dùng trẻ mới khi chọn mua các sản phẩm văn hóa sáng tạo và thiết bị điện tử thông minh, ngày càng coi trọng cảm giác đồng thuận văn hóa, thị hiếu thẩm mỹ và tuyên ngôn lối sống cá tính hóa rõ nét được thể hiện qua thiết kế của sản phẩm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp Batch 4 HSK 5: % từ vựng đã được chuẩn hóa và thêm 200 câu ví dụ.', v_count;
END $$;
