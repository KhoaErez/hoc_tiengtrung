-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 3 (100 TỪ)
-- Phạm vi: #1201 [分数] (fēnshù) -> #1300 [护士] (hùshi)
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
  -- [分数] (fēnshù) - điểm số, điểm thi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '分数' AND pinyin = 'fēnshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '分数'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fēnshù',
      meaning_vi = 'điểm số, điểm thi',
      example_hanzi = '这次期末考试他的汉语听力拿到了满分的高分数。',
      example_pinyin = 'Zhè cì qīmò kǎoshì tā de Hànyǔ tīnglì ná dào le mǎnfēn de gāo fēnshù.',
      example_vi = 'Kỳ thi cuối kỳ lần này điểm thi nghe tiếng Trung của anh ấy đạt điểm tuyệt đối.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这次期末考试他的汉语听力拿到了满分的高分数。', 'Zhè cì qīmò kǎoshì tā de Hànyǔ tīnglì ná dào le mǎnfēn de gāo fēnshù.', 'Kỳ thi cuối kỳ lần này điểm thi nghe tiếng Trung của anh ấy đạt điểm tuyệt đối.', 'basic', 1),
        (v_id, '学校评价学生的综合素养时，不应该仅仅单纯看卷面考试分数，更要注重实践创新能力。', 'Xuéxiào píngjià xuésheng de zōnghé sùyǎng shí, bù yīnggāi jǐnjǐn dānchún kàn juànmiàn kǎoshì fēnshù, gèng yào zhùzhòng shíjiàn chuàngxīn nénglì.', 'Khi nhà trường đánh giá tố chất tổng hợp của học sinh, không nên chỉ đơn thuần nhìn vào điểm số bài thi trên giấy, mà càng phải coi trọng năng lực thực hành đổi mới sáng tạo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [分为] (fēnwéi) - chia thành, phân làm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '分为' AND pinyin = 'fēnwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '分为'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fēnwéi',
      meaning_vi = 'chia thành, phân làm',
      example_hanzi = '这篇课文一共分为三个自然段，请大家朗读第一段。',
      example_pinyin = 'Zhè piān kèwén yígòng fēnwéi sān gè zìránduàn, qǐng dàjiā lǎngdú dì-yī duàn.',
      example_vi = 'Bài khóa này được chia thành tất cả ba đoạn văn tự nhiên, mời mọi người đọc to đoạn thứ nhất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这篇课文一共分为三个自然段，请大家朗读第一段。', 'Zhè piān kèwén yígòng fēnwéi sān gè zìránduàn, qǐng dàjiā lǎngdú dì-yī duàn.', 'Bài khóa này được chia thành tất cả ba đoạn văn tự nhiên, mời mọi người đọc to đoạn thứ nhất.', 'basic', 1),
        (v_id, '该培训项目根据学员的语言实际水平分为初级、中级与高级三个递进阶段。', 'Gāi péixùn xiàngmù gēnjù xuéyuán de yǔyán shíjì shuǐpíng fēnwéi chūjí, zhōngjí yǔ gāojí sān gè dìjìn jiēduàn.', 'Dự án đào tạo này căn cứ theo trình độ ngôn ngữ thực tế của học viên để chia thành ba giai đoạn tịnh tiến: sơ cấp, trung cấp và cao cấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [份] (fèn) - phần, bản, suất (suất ăn, bản hợp đồng) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '份' AND pinyin = 'fèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '份'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'fèn',
      meaning_vi = 'phần, bản, suất (suất ăn, bản hợp đồng)',
      example_hanzi = '服务员，请帮我们再加一份米饭和两份餐具。',
      example_pinyin = 'Fúwùyuán, qǐng bāng wǒmen zài jiā yí fèn mǐfàn hé liǎng fèn cānjù.',
      example_vi = 'Phục vụ ơi, vui lòng cho chúng tôi thêm một suất cơm và hai bộ bát đũa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '服务员，请帮我们再加一份米饭和两份餐具。', 'Fúwùyuán, qǐng bāng wǒmen zài jiā yí fèn mǐfàn hé liǎng fèn cānjù.', 'Phục vụ ơi, vui lòng cho chúng tôi thêm một suất cơm và hai bộ bát đũa.', 'basic', 1),
        (v_id, '请把这份刚刚起草完成的商业合作意向书打印三份并送交总经理审阅。', 'Qǐng bǎ zhè fèn gānggāng qǐcǎo wánchéng de shāngyè hézuò yìxiàngshū dǎyìn sān fèn bìng sòngjiāo zǒngjīnglǐ shěnyuè.', 'Xin hãy in ba bản thư ngỏ ý hợp tác kinh doanh vừa mới soạn thảo này và gửi lên tổng giám đốc xét duyệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [丰富] (fēngfù) - phong phú, dồi dào; làm phong phú [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '丰富' AND pinyin = 'fēngfù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '丰富'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'fēngfù',
      meaning_vi = 'phong phú, dồi dào; làm phong phú',
      example_hanzi = '图书馆里收藏了非常丰富的中外文学书籍。',
      example_pinyin = 'Túshūguǎn lǐ shōucáng le fēicháng fēngfù de zhōngwài wénxué shūjí.',
      example_vi = 'Trong thư viện lưu trữ những đầu sách văn học Trung Quốc và nước ngoài vô cùng phong phú.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '图书馆里收藏了非常丰富的中外文学书籍。', 'Túshūguǎn lǐ shōucáng le fēicháng fēngfù de zhōngwài wénxué shūjí.', 'Trong thư viện lưu trữ những đầu sách văn học Trung Quốc và nước ngoài vô cùng phong phú.', 'basic', 1),
        (v_id, '利用业余时间多参加公益志愿活动，不仅能拓宽人际视野，还能极大丰富人生阅历。', 'Lìyòng yèyú shíjiān duō cānjiā gōngyì zhìyuàn huódòng, bùjǐn néng tuòkuān rénjì shìyě, hái néng jídà fēngfù rénshēng yuèlì.', 'Tận dụng thời gian rảnh rỗi tham gia nhiều hoạt động tình nguyện công ích không chỉ mở rộng tầm nhìn giao tiếp, mà còn làm phong phú đáng kể trải nghiệm cuộc đời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [风景] (fēngjǐng) - phong cảnh, cảnh đẹp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '风景' AND pinyin = 'fēngjǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '风景'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fēngjǐng',
      meaning_vi = 'phong cảnh, cảnh đẹp',
      example_hanzi = '西湖的优美风景吸引了成千上万的海内外游客。',
      example_pinyin = 'Xīhú de yōuměi fēngjǐng xīyǐn le chéngqiān-shàngwàn de hǎinèiwài yóukè.',
      example_vi = 'Phong cảnh tuyệt đẹp của Tây Hồ đã thu hút hàng vạn du khách trong và ngoài nước.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '西湖的优美风景吸引了成千上万的海内外游客。', 'Xīhú de yōuměi fēngjǐng xīyǐn le chéngqiān-shàngwàn de hǎinèiwài yóukè.', 'Phong cảnh tuyệt đẹp của Tây Hồ đã thu hút hàng vạn du khách trong và ngoài nước.', 'basic', 1),
        (v_id, '登上山顶极目远眺，层峦叠嶂与蓝天白云相映成趣，眼前的自然风景令人心旷神怡。', 'Dēng shàng shāndǐng jímù yuǎntiào, céngluán-diézhàng yǔ lántiān-báiyún xiāngyìng-chéngqù, yǎnqián de zìrán fēngjǐng lìng rén xīnxuàng-shényí.', 'Lên đến đỉnh núi phóng tầm mắt ra xa, các tầng núi điệp trùng cùng trời xanh mây trắng hòa quyện tuyệt đẹp, cảnh quan thiên nhiên trước mắt khiến lòng người khoan khoái nhẹ nhõm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [否则] (fǒuzé) - nếu không thì, bằng không [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '否则' AND pinyin = 'fǒuzé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '否则'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'fǒuzé',
      meaning_vi = 'nếu không thì, bằng không',
      example_hanzi = '我们必须马上动身出发，否则就赶不上最后一趟高铁了。',
      example_pinyin = 'Wǒmen bìxū mǎshàng dòngshēn chūfā, fǒuzé jiù gǎnbushàng zuìhòu yí tàng gāotiě le.',
      example_vi = 'Chúng ta phải lập tức lên đường khởi hành, nếu không thì sẽ không kịp chuyến tàu cao tốc cuối cùng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们必须马上动身出发，否则就赶不上最后一趟高铁了。', 'Wǒmen bìxū mǎshàng dòngshēn chūfā, fǒuzé jiù gǎnbushàng zuìhòu yí tàng gāotiě le.', 'Chúng ta phải lập tức lên đường khởi hành, nếu không thì sẽ không kịp chuyến tàu cao tốc cuối cùng.', 'basic', 1),
        (v_id, '合同文本在正式签署前务必交由法务团队严谨审核，否则一旦发生法律纠纷将难以维权。', 'Hétong wénběn zài zhèngshì qiānshǔ qián wùbì jiāo yóu fǎwù tuánduì yánjǐn shěnhé, fǒuzé yídàn fāshēng fǎlǜ jiūfēn jiāng nányǐ wéiquán.', 'Văn bản hợp đồng trước khi ký kết chính thức nhất thiết phải giao cho đội ngũ pháp chế rà soát cẩn thận, bằng không một khi phát sinh tranh chấp pháp lý sẽ rất khó bảo vệ quyền lợi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [幅] (fú) - bức, tấm (tranh, ảnh, khẩu hiệu) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '幅' AND pinyin = 'fú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '幅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'fú',
      meaning_vi = 'bức, tấm (tranh, ảnh, khẩu hiệu)',
      example_hanzi = '客厅的白墙上挂着一幅充满中国韵味的水墨山水画。',
      example_pinyin = 'Kètīng de bái qiáng shang guà zhe yì fú chōngmǎn Zhōngguó yùnwèi de shuǐmò shānshuǐhuà.',
      example_vi = 'Trên bức tường trắng phòng khách treo một bức tranh sơn thủy thủy mặc đậm đà phong vị Trung Hoa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '客厅的白墙上挂着一幅充满中国韵味的水墨山水画。', 'Kètīng de bái qiáng shang guà zhe yì fú chōngmǎn Zhōngguó yùnwèi de shuǐmò shānshuǐhuà.', 'Trên bức tường trắng phòng khách treo một bức tranh sơn thủy thủy mặc đậm đà phong vị Trung Hoa.', 'basic', 1),
        (v_id, '这幅出自当代著名艺术大师之手的油画杰作，在国际艺术品拍卖会上拍出了创纪录的天价。', 'Zhè fú chūzì dāngdài zhùmíng yìshù dàshī zhī shǒu de yóuhuà jiézuò, zài guójì yìshùpǐn pàimàihuì shang pāi chū le chuàng jìlù de tiānjià.', 'Kiệt tác tranh sơn dầu xuất phát từ tay đại sư nghệ thuật đương đại nổi tiếng này đã được đấu giá mức kỷ lục trên sàn đấu giá tác phẩm nghệ thuật quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [符合] (fúhé) - phù hợp, khớp với, đáp ứng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '符合' AND pinyin = 'fúhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '符合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fúhé',
      meaning_vi = 'phù hợp, khớp với, đáp ứng',
      example_hanzi = '他的专业技能完全符合这家外资公司的招聘条件。',
      example_pinyin = 'Tā de zhuānyè jìnéng wánquán fúhé zhè jiā wàizī gōngsī de zhāopìn tiáojiàn.',
      example_vi = 'Kỹ năng chuyên môn của anh ấy hoàn toàn phù hợp với điều kiện tuyển dụng của công ty vốn nước ngoài này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的专业技能完全符合这家外资公司的招聘条件。', 'Tā de zhuānyè jìnéng wánquán fúhé zhè jiā wàizī gōngsī de zhāopìn tiáojiàn.', 'Kỹ năng chuyên môn của anh ấy hoàn toàn phù hợp với điều kiện tuyển dụng của công ty vốn nước ngoài này.', 'basic', 1),
        (v_id, '新推出的这一系列环保智能产品严格符合国家最新出台的绿色能耗标准。', 'Xīn tuīchū de zhè yí xìliè huánbǎo zhìnéng chǎnpǐn yángé fúhé guójiā zuìxīn chūtái de lǜsè nénghào biāozhǔn.', 'Dòng sản phẩm thông minh bảo vệ môi trường mới ra mắt này hoàn toàn đáp ứng nghiêm ngặt các tiêu chuẩn tiêu hao năng lượng xanh mới ban hành của quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [付] (fù) - trả, chi trả, thanh toán [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '付' AND pinyin = 'fù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '付'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fù',
      meaning_vi = 'trả, chi trả, thanh toán',
      example_hanzi = '结账的时候，你可以选择用手机微信扫码付钱。',
      example_pinyin = 'Jiézhàng de shíhou, nǐ kěyǐ xuǎnzé yòng shǒujī Wēixìn sǎomǎ fù qián.',
      example_vi = 'Lúc thanh toán tiền, bạn có thể chọn quét mã WeChat trên điện thoại di động để trả tiền.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '结账的时候，你可以选择用手机微信扫码付钱。', 'Jiézhàng de shíhou, nǐ kěyǐ xuǎnzé yòng shǒujī Wēixìn sǎomǎ fù qián.', 'Lúc thanh toán tiền, bạn có thể chọn quét mã WeChat trên điện thoại di động để trả tiền.', 'basic', 1),
        (v_id, '为了如期实现企业的战略转型与自主研发突破，他们付出了巨大的时间与资金代价。', 'Wèile rúqī shíxiàn qǐyè de zhànlüè zhuǎnxíng yǔ zìzhǔ yánfā tūpò, tāmen fùchū le jùdà de shíjiān yǔ zījīn dàijià.', 'Để đạt được chuyển đổi chiến lược và đột phá nghiên cứu độc lập đúng kỳ hạn của doanh nghiệp, họ đã phải trả cái giá rất lớn về thời gian và vốn đầu tư.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [父母] (fùmǔ) - cha mẹ, bố mẹ, phụ mẫu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '父母' AND pinyin = 'fùmǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '父母'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fùmǔ',
      meaning_vi = 'cha mẹ, bố mẹ, phụ mẫu',
      example_hanzi = '无论工作有多忙碌，周末他都会抽空陪伴年迈的父母。',
      example_pinyin = 'Wúlùn gōngzuò yǒu duō mánglù, zhōumò tā dōu huì chōukòng péibàn niánmài de fùmǔ.',
      example_vi = 'Bất kể công việc bận rộn đến đâu, cuối tuần anh ấy đều tranh thủ thời gian bầu bạn với cha mẹ già.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '无论工作有多忙碌，周末他都会抽空陪伴年迈的父母。', 'Wúlùn gōngzuò yǒu duō mánglù, zhōumò tā dōu huì chōukòng péibàn niánmài de fùmǔ.', 'Bất kể công việc bận rộn đến đâu, cuối tuần anh ấy đều tranh thủ thời gian bầu bạn với cha mẹ già.', 'basic', 1),
        (v_id, '父母良好的言传身教对于孩子健全人格与独立思维的培养起着至关重要的启蒙作用。', 'Fùmǔ liánghǎo de yánchuán-shēnjiào duìyú háizi jiànquán réngé yǔ dúlì sīwéi de péiyǎng qǐ zhe zhìguān zhòngyào de qǐméng zuòyòng.', 'Lời dạy bảo và hành động gương mẫu tốt đẹp của cha mẹ đóng vai trò khai sáng vô cùng thiết yếu đối với việc bồi dưỡng nhân cách toàn diện và tư duy độc lập của con trẻ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [父女] (fùnǚ) - cha và con gái, bố con gái [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '父女' AND pinyin = 'fùnǚ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '父女'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fùnǚ',
      meaning_vi = 'cha và con gái, bố con gái',
      example_hanzi = '他们父女俩长得很像，笑起来都有两个可爱的小酒窝。',
      example_pinyin = 'Tāmen fùnǚ liǎ zhǎng de hěn xiàng, xiào qǐlai dōu yǒu liǎng gè kě’ài de xiǎo jiǔwō.',
      example_vi = 'Hai cha con họ trông rất giống nhau, khi cười đều có hai má lúm đồng tiền rất đáng yêu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他们父女俩长得很像，笑起来都有两个可爱的小酒窝。', 'Tāmen fùnǚ liǎ zhǎng de hěn xiàng, xiào qǐlai dōu yǒu liǎng gè kě’ài de xiǎo jiǔwō.', 'Hai cha con họ trông rất giống nhau, khi cười đều có hai má lúm đồng tiền rất đáng yêu.', 'basic', 1),
        (v_id, '即使分隔大洋两岸多年，深深的父女深情与默契并没有因时间和空间的距离而减弱分毫。', 'Jíshǐ fēngé dàyáng liǎng’àn duō nián, shēnshēn de fùnǚ shēnqíng yǔ mòqì bìng méiyǒu yīn shíjiān hé kōngjiān de jùlí ér jiǎnruò fēnháo.', 'Dẫu cho xa cách hai bờ đại dương nhiều năm, tình cảm cha con sâu đậm và sự thấu hiểu ngầm không hề giảm bớt chút nào bởi khoảng cách thời gian và không gian.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [父亲] (fùqīn) - cha, người cha, thân phụ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '父亲' AND pinyin = 'fùqīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '父亲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fùqīn',
      meaning_vi = 'cha, người cha, thân phụ',
      example_hanzi = '在我的印象中，父亲是一位性格温和且十分有耐心的长辈。',
      example_pinyin = 'Zài wǒ de yìnxiàng zhōng, fùqīn shì yí wèi xìnggé wēnhé qiě shífēn yǒu nàixīn de zhǎngbèi.',
      example_vi = 'Trong ấn tượng của tôi, cha là một bậc trưởng bối tính cách hiền hòa và hết sức kiên nhẫn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在我的印象中，父亲是一位性格温和且十分有耐心的长辈。', 'Zài wǒ de yìnxiàng zhōng, fùqīn shì yí wèi xìnggé wēnhé qiě shífēn yǒu nàixīn de zhǎngbèi.', 'Trong ấn tượng của tôi, cha là một bậc trưởng bối tính cách hiền hòa và hết sức kiên nhẫn.', 'basic', 1),
        (v_id, '父亲常常告诫我们在为人处世上要秉持诚信正直的品格，不可因眼前蝇头微利而丧失原则底线。', 'Fùqīn chángcháng gàojiè wǒmen zài wéirén-chǔshì shang yào bǐngchí chéngxìn zhèngzhí de pǐngé, bù kě yīn yǎnqián yíngtóu wēilì ér sàngshī yuánzé dǐxiàn.', 'Cha thường răn dạy chúng tôi trong việc đối nhân xử thế phải giữ vững phẩm cách chân thành chính trực, không được vì chút món lợi nhỏ trước mắt mà đánh mất nguyên tắc đạo đức.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [复印] (fùyìn) - photocopy, sao chụp văn bản [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '复印' AND pinyin = 'fùyìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '复印'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fùyìn',
      meaning_vi = 'photocopy, sao chụp văn bản',
      example_hanzi = '请把身份证正面和反面都复印在一张白纸上。',
      example_pinyin = 'Qǐng bǎ shēnfènzhèng zhèngmiàn hé fǎnmiàn dōu fùyìn zài yì zhāng bái zhǐ shang.',
      example_vi = 'Xin hãy photo cả mặt trước lẫn mặt sau chứng minh thư lên trên một tờ giấy trắng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把身份证正面和反面都复印在一张白纸上。', 'Qǐng bǎ shēnfènzhèng zhèngmiàn hé fǎnmiàn dōu fùyìn zài yì zhāng bái zhǐ shang.', 'Xin hãy photo cả mặt trước lẫn mặt sau chứng minh thư lên trên một tờ giấy trắng.', 'basic', 1),
        (v_id, '办理跨国业务签证时，使馆要求申请人提供所有财务资信证明材料的清晰复印件并加盖公章。', 'Bànlǐ kuàguó yèwù qiānzhèng shí, shǐguǎn yāoqiú shēnqǐngrén tígōng suǒyǒu cáiwù zīxìn zhèngmíng cáiliào de qīngxī fùyìnjiàn bìng jiā gài gōngzhāng.', 'Khi làm thủ tục xin visa công tác đa quốc gia, đại sứ quán yêu cầu người nộp đơn cung cấp bản photo rõ nét tất cả giấy tờ chứng minh năng lực tài chính và đóng dấu giáp lai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [复杂] (fùzá) - phức tạp, rắc rối [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '复杂' AND pinyin = 'fùzá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '复杂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'fùzá',
      meaning_vi = 'phức tạp, rắc rối',
      example_hanzi = '这个问题背后的原因相当复杂，不是三言两语能解释清楚的。',
      example_pinyin = 'Zhè gè wèntí bèihòu de yuányīn xiāngdāng fùzá, bú shì sānyán-liǎngyǔ néng jiěshì qīngchu de.',
      example_vi = 'Nguyên nhân đằng sau vấn đề này tương đối phức tạp, không phải ba lời hai câu là có thể giải thích rõ ràng được.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个问题背后的原因相当复杂，不是三言两语能解释清楚的。', 'Zhè gè wèntí bèihòu de yuányīn xiāngdāng fùzá, bú shì sānyán-liǎngyǔ néng jiěshì qīngchu de.', 'Nguyên nhân đằng sau vấn đề này tương đối phức tạp, không phải ba lời hai câu là có thể giải thích rõ ràng được.', 'basic', 1),
        (v_id, '面对复杂多变的国际宏观经济环境，外贸企业需要提高抗风险能力并积极拓宽多元化市场。', 'Miànduì fùzá duōbiàn de guójì hóngguān jīngjì huánjìng, wàimào qǐyè xūyào tígāo kàng-fēngxiǎn nénglì bìng jījí tuòkuān duōyuánhuà shìchǎng.', 'Đối mặt với môi trường kinh tế vĩ mô quốc tế phức tạp nhiều biến động, các doanh nghiệp ngoại thương cần nâng cao năng lực chống chịu rủi ro và tích cực mở rộng thị trường đa dạng hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [负责] (fùzé) - phụ trách, chịu trách nhiệm; có tinh thần trách nhiệm [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '负责' AND pinyin = 'fùzé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '负责'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'fùzé',
      meaning_vi = 'phụ trách, chịu trách nhiệm; có tinh thần trách nhiệm',
      example_hanzi = '王经理负责整个华东区域的销售与客户服务业务。',
      example_pinyin = 'Wáng jīnglǐ fùzé zhěnggè Huádōng qūyù de xiāoshòu yǔ kèhù fúwù yèwù.',
      example_vi = 'Giám đốc Vương phụ trách toàn bộ hoạt động bán hàng và dịch vụ khách hàng khu vực Hoa Đông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '王经理负责整个华东区域的销售与客户服务业务。', 'Wáng jīnglǐ fùzé zhěnggè Huádōng qūyù de xiāoshòu yǔ kèhù fúwù yèwù.', 'Giám đốc Vương phụ trách toàn bộ hoạt động bán hàng và dịch vụ khách hàng khu vực Hoa Đông.', 'basic', 1),
        (v_id, '一个真正负责任的团队主管，在遇到意外突发状况时会主动担当并迅速提出应急解决方案。', 'Yí gè zhēnzhèng fùzérèn de tuánduì zhǔguǎn, zài yù dào yìwài tūfā zhuàngkuàng shí huì zhǔdòng dāndāng bìng xùnsù tíchū yìngjí jiějué fāng’àn.', 'Một người trưởng nhóm thực sự có trách nhiệm, khi gặp phải tình huống phát sinh ngoài ý muốn sẽ chủ động gánh vác và nhanh chóng đưa ra giải pháp ứng phó khẩn cấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [负责人] (fùzérén) - người phụ trách, người đứng đầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '负责人' AND pinyin = 'fùzérén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '负责人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fùzérén',
      meaning_vi = 'người phụ trách, người đứng đầu',
      example_hanzi = '请问谁是这个展会的现场负责人？我有重要的事情要反映。',
      example_pinyin = 'Qǐngwèn shéi shì zhè gè zhǎnhuì de xiànchǎng fùzérén? Wǒ yǒu zhòngyào de shìqing yào fǎnyìng.',
      example_vi = 'Xin hỏi ai là người phụ trách hiện trường của hội chợ triển lãm này? Tôi có việc quan trọng cần phản ánh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请问谁是这个展会的现场负责人？我有重要的事情要反映。', 'Qǐngwèn shéi shì zhè gè zhǎnhuì de xiànchǎng fùzérén? Wǒ yǒu zhòngyào de shìqing yào fǎnyìng.', 'Xin hỏi ai là người phụ trách hiện trường của hội chợ triển lãm này? Tôi có việc quan trọng cần phản ánh.', 'basic', 1),
        (v_id, '各业务部门负责人应在每月初定期向执行董事会提交详细的工作进度汇报及风险评估报告。', 'Gè yèwù bùmén fùzérén yīng zài měi yuèchū dìngqī xiàng zhíxíng dǒngshìhuì tíjiāo xiángxì de gōngzuò jìndù huìbào jí fēngxiǎn pínggū bàogào.', 'Người phụ trách các bộ phận kinh doanh cần định kỳ nộp báo cáo tiến độ công việc chi tiết và báo cáo đánh giá rủi ro lên Hội đồng quản trị điều hành vào đầu mỗi tháng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [父子] (fùzǐ) - cha và con trai, bố con trai [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '父子' AND pinyin = 'fùzǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '父子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fùzǐ',
      meaning_vi = 'cha và con trai, bố con trai',
      example_hanzi = '星期天下午，他们父子俩常常在小区的球场上一起踢足球。',
      example_pinyin = 'Xīngqītiān xiàwǔ, tāmen fùzǐ liǎ chángcháng zài xiǎoqū de qiúchǎng shang yìqǐ tī zúqiú.',
      example_vi = 'Chiều Chủ nhật, hai cha con họ thường cùng nhau đá bóng trên sân bóng khu chung cư.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '星期天下午，他们父子俩常常在小区的球场上一起踢足球。', 'Xīngqītiān xiàwǔ, tāmen fùzǐ liǎ chángcháng zài xiǎoqū de qiúchǎng shang yìqǐ tī zúqiú.', 'Chiều Chủ nhật, hai cha con họ thường cùng nhau đá bóng trên sân bóng khu chung cư.', 'basic', 1),
        (v_id, '经过多年并肩创业打拼，这对父子不仅把家族传统手工艺作坊成功打造成了现代化驰名企业，还建立了深厚的信任。', 'Jīngguò duō nián bìngjiān chuàngyè dǎpīn, zhè duì fùzǐ bùjǐn bǎ jiāzú chuántǒng shǒugōngyì zuòfang chénggōng dǎzào chéng le xiàndàihuà chímíng qǐyè, hái jiànlì le shēnhòu de xìnrèn.', 'Trải qua nhiều năm kề vai sát cánh khởi nghiệp bươn chải, hai cha con này không những xây dựng thành công xưởng thủ công truyền thống của gia tộc thành doanh nghiệp nức tiếng hiện đại, mà còn gây dựng được niềm tin sâu sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [改] (gǎi) - sửa, thay đổi, đổi sang [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '改' AND pinyin = 'gǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '改'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'gǎi',
      meaning_vi = 'sửa, thay đổi, đổi sang',
      example_hanzi = '因为突然下大雨，原定今天下午的户外活动改到了明天进行。',
      example_pinyin = 'Yīnwèi tūrán xià dàyǔ, yuándìng jīntiān xiàwǔ de hùwài huódòng gǎi dào le míngtiān jìnxíng.',
      example_vi = 'Do trời bất ngờ đổ mưa to, hoạt động ngoài trời dự kiến chiều nay đã được đổi sang tiến hành vào ngày mai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '因为突然下大雨，原定今天下午的户外活动改到了明天进行。', 'Yīnwèi tūrán xià dàyǔ, yuándìng jīntiān xiàwǔ de hùwài huódòng gǎi dào le míngtiān jìnxíng.', 'Do trời bất ngờ đổ mưa to, hoạt động ngoài trời dự kiến chiều nay đã được đổi sang tiến hành vào ngày mai.', 'basic', 1),
        (v_id, '作者根据特邀审稿专家的建设性修改意见，对学术论文的核心论证部分进行了大幅修改与完善。', 'Zuòzhě gēnjù tèyāo shěngǎo zhuānjiā de jiànshèxìng xiūgǎi yìjiàn, duì xuéshù lùnwén de héxīn lùnzhèng bùfen jìnxíng le dàfú xiūgǎi yǔ wánshàn.', 'Tác giả dựa theo các ý kiến sửa đổi mang tính xây dựng của chuyên gia thẩm định đặc biệt để tiến hành sửa đổi và hoàn thiện đáng kể phần lập luận cốt lõi của luận văn học thuật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [改变] (gǎibiàn) - thay đổi, chuyển biến [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '改变' AND pinyin = 'gǎibiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '改变'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'gǎibiàn',
      meaning_vi = 'thay đổi, chuyển biến',
      example_hanzi = '移动互联网的飞速普及彻底改变了人们的日常生活习惯。',
      example_pinyin = 'Yídòng hùliánwǎng de fēisù pǔjí chèdǐ gǎibiàn le rénmen de rìcháng shēnghuó xíguàn.',
      example_vi = 'Sự phổ cập thần tốc của internet di động đã thay đổi hoàn toàn thói quen sinh hoạt hàng ngày của con người.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '移动互联网的飞速普及彻底改变了人们的日常生活习惯。', 'Yídòng hùliánwǎng de fēisù pǔjí chèdǐ gǎibiàn le rénmen de rìcháng shēnghuó xíguàn.', 'Sự phổ cập thần tốc của internet di động đã thay đổi hoàn toàn thói quen sinh hoạt hàng ngày của con người.', 'basic', 1),
        (v_id, '在这个知识爆炸与人工智能时代，唯有坚持终身学习才能积极应对环境变化并改变个人职业发展轨迹。', 'Zài zhè gè zhīshi bàozhà yǔ réngōng zhìnéng shídài, wéiyǒu jiānchí zhōngshēn xuéxí cái néng jījí yìngduì huánjìng biànhuà bìng gǎibiàn gèrén zhíyè fāzhǎn guǐjì.', 'Trong thời đại bùng nổ tri thức và trí tuệ nhân tạo này, chỉ có kiên trì học tập suốt đời mới có thể chủ động thích ứng với biến chuyển môi trường và thay đổi quỹ đạo phát triển nghề nghiệp cá nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [干] (gān) - khô, cạn, ráo [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '干' AND pinyin = 'gān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '干'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'gān',
      meaning_vi = 'khô, cạn, ráo',
      example_hanzi = '今天天气晴朗而且风很大，挂在阳台上的衣服很快就晒干了。',
      example_pinyin = 'Jīntiān tiānqì qínglǎng érqiě fēng hěn dà, guà zài yángtái shang de yīfu hěn kuài jiù shài gān le.',
      example_vi = 'Hôm nay thời tiết nắng ráo lại có gió to, quần áo phơi ngoài ban công rất nhanh đã khô rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天天气晴朗而且风很大，挂在阳台上的衣服很快就晒干了。', 'Jīntiān tiānqì qínglǎng érqiě fēng hěn dà, guà zài yángtái shang de yīfu hěn kuài jiù shài gān le.', 'Hôm nay thời tiết nắng ráo lại có gió to, quần áo phơi ngoài ban công rất nhanh đã khô rồi.', 'basic', 1),
        (v_id, '北方冬季的气候十分干燥寒冷，室内通常需要开启加湿器以缓解皮肤干裂和呼吸道不适。', 'Běifāng dōngjì de qìhòu shífēn gānzào hánlěng, shìnèi tōngcháng xūyào kāiqǐ jiāshīqì yǐ huǎnjiě pífū gānliè hé hūxīdào bùshì.', 'Khí hậu mùa đông ở miền Bắc vô cùng khô hanh và lạnh giá, trong phòng thường cần bật máy tạo ẩm để làm dịu tình trạng nứt nẻ da và khó chịu đường hô hấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [干杯] (gānbēi) - cạn ly, cụng ly, chúc mừng (cheers) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '干杯' AND pinyin = 'gānbēi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '干杯'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'gānbēi',
      meaning_vi = 'cạn ly, cụng ly, chúc mừng (cheers)',
      example_hanzi = '为了庆祝你顺利通过HSK考试，让我们一起举杯干杯！',
      example_pinyin = 'Wèile qìngzhù nǐ shùnlì tōngguò HSK kǎoshì, ràng wǒmen yìqǐ jǔbēi gānbēi!',
      example_vi = 'Để chúc mừng bạn vượt qua kỳ thi HSK thuận lợi, chúng ta hãy cùng nâng ly cạn chén!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了庆祝你顺利通过HSK考试，让我们一起举杯干杯！', 'Wèile qìngzhù nǐ shùnlì tōngguò HSK kǎoshì, ràng wǒmen yìqǐ jǔbēi gānbēi!', 'Để chúc mừng bạn vượt qua kỳ thi HSK thuận lợi, chúng ta hãy cùng nâng ly cạn chén!', 'basic', 1),
        (v_id, '在隆重热烈的年终晚宴上，公司董事长向全体辛勤付出的员工敬酒干杯并致以最诚挚的新春祝福。', 'Zài lóngzhòng rèliè de niánzhōng wǎnyàn shang, gōngsī dǒngshìzhǎng xiàng quántǐ xīnqín fùchū de yuángōng jìngjiǔ gānbēi bìng zhì yǐ zuì chéngzhì de xīnchūn zhùfú.', 'Trong buổi tiệc tất niên trang trọng và ấm cúng, Chủ tịch hội đồng quản trị công ty đã nâng ly cụng chén chúc rượu toàn thể nhân viên đã cống hiến hết mình và gửi lời chúc mừng năm mới chân thành nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [赶] (gǎn) - đuổi theo, vội vã, chạy đua (thời gian, tiến độ) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '赶' AND pinyin = 'gǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'gǎn',
      meaning_vi = 'đuổi theo, vội vã, chạy đua (thời gian, tiến độ)',
      example_hanzi = '你起得太晚了，现在得赶紧跑去地铁站才能赶上早班车。',
      example_pinyin = 'Nǐ qǐ de tài wǎn le, xiànzài děi gǎnjǐn pǎo qù dìtiězhàn cái néng gǎnshang zǎobānchē.',
      example_vi = 'Bạn dậy muộn quá rồi, bây giờ phải vội vàng chạy ra ga tàu điện ngầm mới kịp chuyến xe sớm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你起得太晚了，现在得赶紧跑去地铁站才能赶上早班车。', 'Nǐ qǐ de tài wǎn le, xiànzài děi gǎnjǐn pǎo qù dìtiězhàn cái néng gǎnshang zǎobānchē.', 'Bạn dậy muộn quá rồi, bây giờ phải vội vàng chạy ra ga tàu điện ngầm mới kịp chuyến xe sớm.', 'basic', 1),
        (v_id, '为了在客户规定的截止日期前完成项目交付，全体工程师连续加班加点赶工期。', 'Wèile zài kèhù guīdìng de jiézhǐ rìqī qián wánchéng xiàngmù jiāofù, quántǐ gōngchéngshī liánxù jiābān-jiādiǎn gǎn gōngqī.', 'Để hoàn thành bàn giao dự án trước thời hạn chót khách hàng quy định, toàn thể kỹ sư đã liên tục tăng ca dồn sức chạy đua với tiến độ công trình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [敢] (gǎn) - dám [Động từ năng nguyện]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '敢' AND pinyin = 'gǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '敢'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ năng nguyện',
      pinyin = 'gǎn',
      meaning_vi = 'dám',
      example_hanzi = '他性格比较内向害羞，在公共场合不敢当众公开发言。',
      example_pinyin = 'Tā xìnggé bǐjiào nèixiàng hàixiū, zài gōnggòng chǎnghé bù gǎn dāngzhòng gōngkāi fāyán.',
      example_vi = 'Tính tình anh ấy khá hướng nội e thẹn, ở nơi công cộng không dám phát biểu công khai trước đám đông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他性格比较内向害羞，在公共场合不敢当众公开发言。', 'Tā xìnggé bǐjiào nèixiàng hàixiū, zài gōnggòng chǎnghé bù gǎn dāngzhòng gōngkāi fāyán.', 'Tính tình anh ấy khá hướng nội e thẹn, ở nơi công cộng không dám phát biểu công khai trước đám đông.', 'basic', 1),
        (v_id, '真正的创新者要有敢为人先的开拓魄力，敢于跳出固有思维框架尝试未经检验的全新路径。', 'Zhēnzhèng de chuàngxīnzhě yào yǒu gǎnwéirénxiān de kāituò pòlì, gǎnyú tiàochū gùyǒu sīwéi kuàngjià chángshì wèijīng jiǎnyàn de quánxīn lùjìng.', 'Người đổi mới sáng tạo thực sự cần có khí phách dám đi tiên phong, dám bứt phá khỏi khuôn khổ tư duy lối mòn để thử nghiệm những lộ trình hoàn toàn mới chưa từng qua kiểm chứng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感] (gǎn) - cảm giác, cảm thấy, ý thức (trách nhiệm, thành tựu) [Hậu tố / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '感' AND pinyin = 'gǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Hậu tố / Động từ',
      pinyin = 'gǎn',
      meaning_vi = 'cảm giác, cảm thấy, ý thức (trách nhiệm, thành tựu)',
      example_hanzi = '圆满完成这项艰巨的任务后，他内心油然而生一种强烈的自豪感。',
      example_pinyin = 'Yuánmǎn wánchéng zhè xiàng jiānjù de rènwu hòu, tā nèixīn yóurán’érshēng yì zhǒng qiángliè de zìháogǎn.',
      example_vi = 'Sau khi hoàn thành viên mãn nhiệm vụ gian truân này, trong lòng anh ấy dâng trào một cảm giác tự hào mạnh mẽ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '圆满完成这项艰巨的任务后，他内心油然而生一种强烈的自豪感。', 'Yuánmǎn wánchéng zhè xiàng jiānjù de rènwu hòu, tā nèixīn yóurán’érshēng yì zhǒng qiángliè de zìháogǎn.', 'Sau khi hoàn thành viên mãn nhiệm vụ gian truân này, trong lòng anh ấy dâng trào một cảm giác tự hào mạnh mẽ.', 'basic', 1),
        (v_id, '卓越的领导者善于培养团队成员的归属感与使命感，激发大家为共同战略目标而拼搏。', 'Zhuóyuè de lǐngdǎozhě shànyú péiyǎng tuánduì chéngyuán de guīshǔgǎn yǔ shǐmìnggǎn, jīfā dàjiā wèi gòngtóng zhànlüè mùbiāo ér pīnbó.', 'Người lãnh đạo kiệt xuất rất giỏi vun đắp cảm giác thuộc về tập thể và ý thức sứ mệnh cho các thành viên, khích lệ mọi người cùng dốc sức phấn đấu vì mục tiêu chiến lược chung.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感动] (gǎndòng) - cảm động, xúc động; làm xúc động [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '感动' AND pinyin = 'gǎndòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'gǎndòng',
      meaning_vi = 'cảm động, xúc động; làm xúc động',
      example_hanzi = '听到朋友们为他精心准备的生日祝福，他感动得热泪盈眶。',
      example_pinyin = 'Tīng dào péngyoumen wèi tā jīngxīn zhǔnbèi de shēngrì zhùfú, tā gǎndòng de rèlèi-yíngkuàng.',
      example_vi = 'Nghe những lời chúc sinh nhật bạn bè đã dày công chuẩn bị cho mình, anh ấy xúc động đến rơm rớm nước mắt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到朋友们为他精心准备的生日祝福，他感动得热泪盈眶。', 'Tīng dào péngyoumen wèi tā jīngxīn zhǔnbèi de shēngrì zhùfú, tā gǎndòng de rèlèi-yíngkuàng.', 'Nghe những lời chúc sinh nhật bạn bè đã dày công chuẩn bị cho mình, anh ấy xúc động đến rơm rớm nước mắt.', 'basic', 1),
        (v_id, '支教老师扎根偏远山区十几年默默奉献的感人事迹，深深感动了全社会的无数公众。', 'Zhījiào lǎoshī zhāgēn piānyuǎn shānqū shí jǐ nián mòmò fèngxiàn de gǎnrén shìjì, shēnshēn gǎndòng le quán shèhuì de wúshù gōngzhòng.', 'Hành động xúc động của người giáo viên tình nguyện gắn bó cống hiến thầm lặng hơn mười năm nơi vùng núi hẻo lánh đã làm rung động sâu sắc vô số người dân trong toàn xã hội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [赶紧] (gǎnjǐn) - mau chóng, gấp rút, nhanh chóng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '赶紧' AND pinyin = 'gǎnjǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶紧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'gǎnjǐn',
      meaning_vi = 'mau chóng, gấp rút, nhanh chóng',
      example_hanzi = '天快要下暴雨了，你赶紧把晾在外面的衣服收进来。',
      example_pinyin = 'Tiān kuài yào xià bàoyǔ le, nǐ gǎnjǐn bǎ liàng zài wàimiàn de yīfu shōu jìnlái.',
      example_vi = 'Trời sắp đổ mưa to rồi, bạn mau chóng thu quần áo đang phơi ngoài trời vào đi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '天快要下暴雨了，你赶紧把晾在外面的衣服收进来。', 'Tiān kuài yào xià bàoyǔ le, nǐ gǎnjǐn bǎ liàng zài wàimiàn de yīfu shōu jìnlái.', 'Trời sắp đổ mưa to rồi, bạn mau chóng thu quần áo đang phơi ngoài trời vào đi.', 'basic', 1),
        (v_id, '发现线上系统出现数据异常漏洞后，技术运维团队赶紧启动了最高级别应急修复预案。', 'Fāxiàn xiànshàng xìtǒng chūxiàn shùjù yìcháng lòudòng hòu, jìshù yùnwéi tuánduì gǎnjǐn qǐdòng le zuì gāo jíbié yìngjí xiūfù yù’àn.', 'Sau khi phát hiện hệ thống trực tuyến có lỗ hổng dữ liệu bất thường, đội ngũ vận hành kỹ thuật đã gấp rút kích hoạt phương án sửa chữa khẩn cấp cấp độ cao nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感觉] (gǎnjué) - cảm giác; cảm thấy [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '感觉' AND pinyin = 'gǎnjué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感觉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'gǎnjué',
      meaning_vi = 'cảm giác; cảm thấy',
      example_hanzi = '吃完感冒药并睡了一觉之后，我感觉身体轻松多了。',
      example_pinyin = 'Chī wán gǎnmàoyào bìng shuì le yí jiào zhīhòu, wǒ gǎnjué shēntǐ qīngsōng duō le.',
      example_vi = 'Sau khi uống thuốc cảm và ngủ một giấc, tôi cảm thấy cơ thể nhẹ nhõm hơn nhiều.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '吃完感冒药并睡了一觉之后，我感觉身体轻松多了。', 'Chī wán gǎnmàoyào bìng shuì le yí jiào zhīhòu, wǒ gǎnjué shēntǐ qīngsōng duō le.', 'Sau khi uống thuốc cảm và ngủ một giấc, tôi cảm thấy cơ thể nhẹ nhõm hơn nhiều.', 'basic', 1),
        (v_id, '这家科技旗舰店的室内空间设计极具未来感，带给进店顾客极其舒适惬意的沉浸式体验。', 'Zhè jiā kējì qíjiàndiàn de shìnèi kōngjiān shèjì jí jù wèiláigǎn, dài gěi jìn diàn gùkè jíqí shūshì qièyì de chénjìnshì tǐyàn.', 'Thiết kế không gian nội thất của cửa hàng công nghệ cao này đậm chất tương lai, mang lại cho khách hàng bước vào cảm giác trải nghiệm đắm chìm vô cùng thoải mái và dễ chịu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [赶快] (gǎnkuài) - nhanh chóng, khẩn trương [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '赶快' AND pinyin = 'gǎnkuài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶快'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'gǎnkuài',
      meaning_vi = 'nhanh chóng, khẩn trương',
      example_hanzi = '电影马上就要开场了，我们赶快检票进放映厅吧。',
      example_pinyin = 'Diànyǐng mǎshàng jiù yào kāichǎng le, wǒmen gǎnkuài jiǎnpiào jìn fàngyìngtīng ba.',
      example_vi = 'Bộ phim sắp sửa chiếu rồi, chúng ta nhanh chóng soát vé vào rạp chiếu thôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '电影马上就要开场了，我们赶快检票进放映厅吧。', 'Diànyǐng mǎshàng jiù yào kāichǎng le, wǒmen gǎnkuài jiǎnpiào jìn fàngyìngtīng ba.', 'Bộ phim sắp sửa chiếu rồi, chúng ta nhanh chóng soát vé vào rạp chiếu thôi.', 'basic', 1),
        (v_id, '新政策出台后的政策红利期非常短暂，企业必须赶快调整产品战略以抢占市场先机。', 'Xīn zhèngcè chūtái hòu de zhèngcè hónglì qī fēicháng duǎnzàn, qǐyè bìxū gǎnkuài tiáozhěng chǎnpǐn zhànlüè yǐ qiǎngzhàn shìchǎng xiānjī.', 'Giai đoạn hưởng lợi chính sách sau khi quy định mới ban hành rất ngắn ngủi, doanh nghiệp phải khẩn trương điều chỉnh chiến lược sản phẩm để chớp lấy thời cơ thị trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感情] (gǎnqíng) - tình cảm, cảm xúc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '感情' AND pinyin = 'gǎnqíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感情'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gǎnqíng',
      meaning_vi = 'tình cảm, cảm xúc',
      example_hanzi = '他们两人从小一起长大，彼此之间的感情深厚如亲兄弟。',
      example_pinyin = 'Tāmen liǎng rén cóngxiǎo yìqǐ zhǎngdà, bǐcǐ zhījiān de gǎnqíng shēnhòu rú qīn xiōngdì.',
      example_vi = 'Hai người họ từ nhỏ cùng lớn lên với nhau, tình cảm gắn bó giữa họ sâu nặng như anh em ruột.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他们两人从小一起长大，彼此之间的感情深厚如亲兄弟。', 'Tāmen liǎng rén cóngxiǎo yìqǐ zhǎngdà, bǐcǐ zhījiān de gǎnqíng shēnhòu rú qīn xiōngdì.', 'Hai người họ từ nhỏ cùng lớn lên với nhau, tình cảm gắn bó giữa họ sâu nặng như anh em ruột.', 'basic', 1),
        (v_id, '在商业谈判中既要以专业理性的数据为基准，也要注重顾及双方长期建立的合作感情与互信。', 'Zài shāngyè tánpàn zhōng jì yào yǐ zhuānyè lǐxìng de shùjù wéi jīzhǔn, yě yào zhùzhòng gùjí shuāngfāng chángqī jiànlì de hézuò gǎnqíng yǔ hùxìn.', 'Trong đàm phán thương mại vừa cần lấy số liệu lý tính chuyên nghiệp làm chuẩn tắc, vừa cần chú trọng bồi đắp tình cảm hợp tác và sự tin tưởng lẫn nhau đã xây dựng lâu dài giữa hai bên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感人] (gǎnrén) - cảm động, truyền cảm hứng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '感人' AND pinyin = 'gǎnrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'gǎnrén',
      meaning_vi = 'cảm động, truyền cảm hứng',
      example_hanzi = '这部电影讲述了一个十分感人的关于亲情守护的故事。',
      example_pinyin = 'Zhè bù diànyǐng jiǎngshù le yí gè shífēn gǎnrén de guānyú qīnqíng shǒuhù de gùshi.',
      example_vi = 'Bộ phim này kể về một câu chuyện hết sức cảm động xoay quanh sự chở che của tình thân gia đình.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这部电影讲述了一个十分感人的关于亲情守护的故事。', 'Zhè bù diànyǐng jiǎngshù le yí gè shífēn gǎnrén de guānyú qīnqíng shǒuhù de gùshi.', 'Bộ phim này kể về một câu chuyện hết sức cảm động xoay quanh sự chở che của tình thân gia đình.', 'basic', 1),
        (v_id, '他在毕业典礼上发表了一篇真情实感、极具感染力的感人演讲，赢得全场师生雷鸣般的掌声。', 'Tā zài bìyè diǎnlǐ shang fābiǎo le yì piān zhēnqíng-shígǎn, jí jù gǎnrǎnlì de gǎnrén yǎnjiǎng, yíngdé quánchǎng shīshēng léimíng bān de zhǎngshēng.', 'Anh ấy đã có một bài phát biểu cảm động đầy ắp chân tình và sức lan tỏa mạnh mẽ trong lễ tốt nghiệp, giành được tràng pháo tay giòn giã như sấm của toàn thể thầy trò.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [赶上] (gǎnshàng) - đuổi kịp, bắt kịp; gặp dịp, rơi vào dịp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '赶上' AND pinyin = 'gǎnshàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '赶上'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'gǎnshàng',
      meaning_vi = 'đuổi kịp, bắt kịp; gặp dịp, rơi vào dịp',
      example_hanzi = '路上虽然堵车严重，但他跑步前进，终于还是赶上了航班登机。',
      example_pinyin = 'Lùshang suīrán dǔchē yánzhòng, dàn tā pǎobù qiánjìn, zhōngyú hái shì gǎnshàng le hángbān dēngjī.',
      example_vi = 'Dọc đường tuy tắc đường nghiêm trọng nhưng anh ấy đã chạy bộ tới, cuối cùng vẫn kịp giờ lên máy bay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '路上虽然堵车严重，但他跑步前进，终于还是赶上了航班登机。', 'Lùshang suīrán dǔchē yánzhòng, dàn tā pǎobù qiánjìn, zhōngyú hái shì gǎnshàng le hángbān dēngjī.', 'Dọc đường tuy tắc đường nghiêm trọng nhưng anh ấy đã chạy bộ tới, cuối cùng vẫn kịp giờ lên máy bay.', 'basic', 1),
        (v_id, '中国新能源汽车产业抓住了技术变革的关键机遇，在核心电池与智能驾驶领域已经成功赶上甚至超越了国际前列。', 'Zhōngguó xīnnéngyuán qìchē chǎnyè zhuāzhù le jìshù biàngé de guānjiàn jīyù, zài héxīn diànchí yǔ zhìnéng jiàshǐ lǐngyù yǐjīng chénggōng gǎnshàng shènzhì chāoyuè le guójì qiánliè.', 'Ngành công nghiệp ô tô năng lượng mới của Trung Quốc đã nắm bắt cơ hội then chốt của đổi mới công nghệ, thành công bắt kịp thậm chí vượt lên hàng đầu quốc tế trong lĩnh vực pin cốt lõi và lái tự động.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感受] (gǎnshòu) - cảm nhận, trải nghiệm; cảm nghĩ [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '感受' AND pinyin = 'gǎnshòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感受'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'gǎnshòu',
      meaning_vi = 'cảm nhận, trải nghiệm; cảm nghĩ',
      example_hanzi = '来到这座历史文化名城，能切身感受到浓厚深沉的古老韵味。',
      example_pinyin = 'Lái dào zhè zuò lìshǐ wénhuà míngchéng, néng qièshēn gǎnshòu dào nónghòu shēnchén de gǔlǎo yùnwèi.',
      example_vi = 'Đến với thành phố danh tiếng lịch sử văn hóa này, người ta có thể đích thân cảm nhận được phong vị cổ xưa trầm mặc đậm đà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '来到这座历史文化名城，能切身感受到浓厚深沉的古老韵味。', 'Lái dào zhè zuò lìshǐ wénhuà míngchéng, néng qièshēn gǎnshòu dào nónghòu shēnchén de gǔlǎo yùnwèi.', 'Đến với thành phố danh tiếng lịch sử văn hóa này, người ta có thể đích thân cảm nhận được phong vị cổ xưa trầm mặc đậm đà.', 'basic', 1),
        (v_id, '产品经理必须经常站在终端真实用户的视角去换位思考，深刻体会并照顾使用者的切身感受。', 'Chǎnpǐn jīnglǐ bìxū chángcháng zhàn zài zhōngduān zhēnshí yònghù de shìjiǎo qù huànwèi sīkǎo, shēnkè tǐhuì bìng zhàogù shǐyòngzhě de qièshēn gǎnshòu.', 'Giám đốc sản phẩm cần thường xuyên đứng ở góc nhìn của người dùng thực tế cuối cùng để đổi vị trí suy nghĩ, thấu hiểu sâu sắc và quan tâm đến cảm nhận trực tiếp của người sử dụng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感谢] (gǎnxiè) - cảm ơn, tri ân, biết ơn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '感谢' AND pinyin = 'gǎnxiè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '感谢'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'gǎnxiè',
      meaning_vi = 'cảm ơn, tri ân, biết ơn',
      example_hanzi = '非常感谢您在过去一年里对我工作的大力支持与热心帮助。',
      example_pinyin = 'Fēicháng gǎnxiè nín zài guòqù yì nián lǐ duì wǒ gōngzuò de dàlì zhīchí yǔ rèxīn bāngzhù.',
      example_vi = 'Vô cùng cảm ơn anh đã hết lòng ủng hộ và nhiệt tình giúp đỡ công việc của tôi trong suốt một năm qua.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '非常感谢您在过去一年里对我工作的大力支持与热心帮助。', 'Fēicháng gǎnxiè nín zài guòqù yì nián lǐ duì wǒ gōngzuò de dàlì zhīchí yǔ rèxīn bāngzhù.', 'Vô cùng cảm ơn anh đã hết lòng ủng hộ và nhiệt tình giúp đỡ công việc của tôi trong suốt một năm qua.', 'basic', 1),
        (v_id, '借此公司成立十周年庆典之际，我们向所有长期风雨同舟的战略合作伙伴致以最诚挚的感谢。', 'Jiè cǐ gōngsī chénglì shí zhōunián qìngdiǎn zhī jì, wǒmen xiàng suǒyǒu chángqī fēngyǔ-tóngzhōu de zhànlüè hézuò huǒbàn zhì yǐ zuì chéngzhì de gǎnxiè.', 'Nhân dịp đại lễ kỷ niệm mười năm thành lập công ty lần này, chúng tôi xin gửi lời cảm ơn chân thành sâu sắc nhất tới toàn thể đối tác chiến lược đã cùng kề vai vượt khó suốt thời gian qua.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [干活儿] (gànhuór) - làm việc, làm lụng việc tay chân [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '干活儿' AND pinyin = 'gànhuór'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '干活儿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'gànhuór',
      meaning_vi = 'làm việc, làm lụng việc tay chân',
      example_hanzi = '工人们一大早就顶着朝阳在建筑工地上忙碌地干活儿了。',
      example_pinyin = 'Gōngrénmen yí dà zǎo jiù dǐng zhe zhāoyáng zài jiànzhù gōngdì shang mánglù de gànhuór le.',
      example_vi = 'Các công nhân từ sáng sớm tinh mơ đã đón ánh ban mai bận rộn làm việc trên công trường xây dựng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '工人们一大早就顶着朝阳在建筑工地上忙碌地干活儿了。', 'Gōngrénmen yí dà zǎo jiù dǐng zhe zhāoyáng zài jiànzhù gōngdì shang mánglù de gànhuór le.', 'Các công nhân từ sáng sớm tinh mơ đã đón ánh ban mai bận rộn làm việc trên công trường xây dựng.', 'basic', 1),
        (v_id, '他为人踏实稳重，在车间一线干活儿总是手脚麻利且精益求精，多次荣获年度劳模称号。', 'Tā wéirén tāshi wěnzhòng, zài chējiān yīxiàn gànhuór zǒngshì shǒujiǎo máli qiě jīngyìqiújīng, duō cì rónghuò niándù láomó chēnghào.', 'Anh ấy làm người chắc chắn vững vàng, làm việc trực tiếp nơi tuyến đầu phân xưởng luôn thoăn thoắt khéo léo và không ngừng cầu toàn, nhiều lần đạt danh hiệu lao động tiên tiến của năm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [钢琴] (gāngqín) - đàn piano, dương cầm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '钢琴' AND pinyin = 'gāngqín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '钢琴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gāngqín',
      meaning_vi = 'đàn piano, dương cầm',
      example_hanzi = '妹妹从六岁起就开始坚持每天练习弹钢琴。',
      example_pinyin = 'Mèimei cóng liù suì qǐ jiù kāishǐ jiānchí měitiān liànxí tán gāngqín.',
      example_vi = 'Em gái từ lúc sáu tuổi đã bắt đầu kiên trì luyện tập đánh đàn piano mỗi ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '妹妹从六岁起就开始坚持每天练习弹钢琴。', 'Mèimei cóng liù suì qǐ jiù kāishǐ jiānchí měitiān liànxí tán gāngqín.', 'Em gái từ lúc sáu tuổi đã bắt đầu kiên trì luyện tập đánh đàn piano mỗi ngày.', 'basic', 1),
        (v_id, '这位青年演奏家在维也纳音乐金色大厅成功举办了独奏音乐会，黑白钢琴键盘在他指尖流淌出天籁之音。', 'Zhè wèi qīngnián yǎnzòujiā zài Wéiyěnà yīnyuè Jīnsè Dàtīng chénggōng jǔbàn le dúzòu yīnyuèhuì, hēibái gāngqín jiànpán zài tā zhǐjiān liútǎng chū tiānlài zhī yīn.', 'Nghệ sĩ biểu diễn trẻ tuổi này đã tổ chức thành công buổi hòa nhạc độc tấu tại Phòng hòa nhạc Vàng Vienna, từng phím đàn piano đen trắng dưới ngón tay anh tuôn trào những âm thanh tuyệt diệu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [高价] (gāojià) - giá cao, giá đắt đỏ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '高价' AND pinyin = 'gāojià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高价'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gāojià',
      meaning_vi = 'giá cao, giá đắt đỏ',
      example_hanzi = '节假日旅游旺季期间，热门景区的酒店常常开出极高的高价。',
      example_pinyin = 'Jiéjiàrì lǚyóu wàngjì qījiān, rèmén jǐngqū de jiǔdiàn chángcháng kāi chū jí gāo de gāojià.',
      example_vi = 'Trong mùa cao điểm du lịch dịp lễ tết, các khách sạn tại khu thắng cảnh nổi tiếng thường đưa ra mức giá rất cao.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '节假日旅游旺季期间，热门景区的酒店常常开出极高的高价。', 'Jiéjiàrì lǚyóu wàngjì qījiān, rèmén jǐngqū de jiǔdiàn chángcháng kāi chū jí gāo de gāojià.', 'Trong mùa cao điểm du lịch dịp lễ tết, các khách sạn tại khu thắng cảnh nổi tiếng thường đưa ra mức giá rất cao.', 'basic', 1),
        (v_id, '尽管这家跨国制药企业为收购核心专利技术支付了不菲的高价，但从长远市场战略来看十分划算。', 'Jǐnguǎn zhè jiā kuàguó zhìyào qǐyè wèi shōugòu héxīn zhuānlì jìshù zhīfù le bùfěi de gāojià, dàn cóng chángyuǎn shìchǎng zhànlüè lái kàn shífēn huásuàn.', 'Dù cho doanh nghiệp dược phẩm đa quốc gia này phải trả mức giá rất cao để mua lại công nghệ sáng chế cốt lõi, nhưng xét từ chiến lược thị trường lâu dài thì vô cùng xứng đáng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [高考] (gāokǎo) - kỳ thi tuyển sinh đại học (gaokao) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '高考' AND pinyin = 'gāokǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高考'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gāokǎo',
      meaning_vi = 'kỳ thi tuyển sinh đại học (gaokao)',
      example_hanzi = '高三同学们正在争分夺秒地复习，准备迎接即将到来的全国高考。',
      example_pinyin = 'Gāosān tóngxuémen zhèngzài zhēngfēn-duómiǎo de fùxí, zhǔnbèi yíngjiē jíjiāng dàolái de quánguó gāokǎo.',
      example_vi = 'Các bạn học sinh lớp 12 đang tranh thủ từng phút từng giây ôn tập chuẩn bị nghênh đón kỳ thi tuyển sinh đại học toàn quốc sắp tới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '高三同学们正在争分夺秒地复习，准备迎接即将到来的全国高考。', 'Gāosān tóngxuémen zhèngzài zhēngfēn-duómiǎo de fùxí, zhǔnbèi yíngjiē jíjiāng dàolái de quánguó gāokǎo.', 'Các bạn học sinh lớp 12 đang tranh thủ từng phút từng giây ôn tập chuẩn bị nghênh đón kỳ thi tuyển sinh đại học toàn quốc sắp tới.', 'basic', 1),
        (v_id, '高考不仅是检验高中阶段学业知识的决定性考试，更是锤炼青少年心理素质与意志毅力的重要人生节点。', 'Gāokǎo bùjǐn shì jiǎnyàn gāozhōng jiēduàn xuéyè zhīshi de juédìngxìng kǎoshì, gèng shì chuíliàn qīngshàonián xīnlǐ sùzhì yǔ yìzhì yìlì de zhòngyào rénshēng jiédiǎn.', 'Kỳ thi đại học không chỉ là bài kiểm tra mang tính quyết định đo lường kiến thức học tập bậc THPT, mà còn là mốc son cuộc đời quan trọng tôi luyện tố chất tâm lý và ý chí kiên định của tuổi trẻ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [高速] (gāosù) - tốc độ cao; đường cao tốc (gọi tắt của 高速公路) [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '高速' AND pinyin = 'gāosù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高速'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'gāosù',
      meaning_vi = 'tốc độ cao; đường cao tốc (gọi tắt của 高速公路)',
      example_hanzi = '上了高速公路以后，汽车行驶的速度就明显快多了。',
      example_pinyin = 'Shàng le gāosù gōnglù yǐhòu, qìchē xíngshǐ de sùdù jiù míngxiǎn kuài duō le.',
      example_vi = 'Sau khi lên đường cao tốc, tốc độ lưu thông của xe ô tô nhanh hơn trông thấy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '上了高速公路以后，汽车行驶的速度就明显快多了。', 'Shàng le gāosù gōnglù yǐhòu, qìchē xíngshǐ de sùdù jiù míngxiǎn kuài duō le.', 'Sau khi lên đường cao tốc, tốc độ lưu thông của xe ô tô nhanh hơn trông thấy.', 'basic', 1),
        (v_id, '随着新一代高速宽带与5G通信技术的全面覆盖，远程数字办公与高清流媒体传输变得前所未有的流畅。', 'Suízhe xīn yídài gāosù kuāndài yǔ wǔ-G tōngxìn jìshù de quánmiàn fùgài, yuǎnchéng shùzì bàngōng yǔ gāoqīng liúméitǐ chuānshū biàn de qiánsuǒwèiyǒu de liúchàng.', 'Cùng với sự phủ sóng toàn diện của mạng băng thông rộng tốc độ cao thế hệ mới và công nghệ truyền thông 5G, làm việc kỹ thuật số từ xa và truyền phát đa phương tiện độ nét cao đã trở nên mượt mà chưa từng có.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [高温] (gāowēn) - nhiệt độ cao, thời tiết nắng nóng gay gắt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '高温' AND pinyin = 'gāowēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高温'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gāowēn',
      meaning_vi = 'nhiệt độ cao, thời tiết nắng nóng gay gắt',
      example_hanzi = '气象台今天发布了红色高温预警，户外气温高达四十度。',
      example_pinyin = 'Qìxiàngtái jīntiān fābù le hóngsè gāowēn yùjǐng, hùwài qìwēn gāo dá sìshí dù.',
      example_vi = 'Đài khí tượng hôm nay đã phát cảnh báo nhiệt độ cao cấp độ màu đỏ, nhiệt độ ngoài trời lên tới bốn mươi độ C.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '气象台今天发布了红色高温预警，户外气温高达四十度。', 'Qìxiàngtái jīntiān fābù le hóngsè gāowēn yùjǐng, hùwài qìwēn gāo dá sìshí dù.', 'Đài khí tượng hôm nay đã phát cảnh báo nhiệt độ cao cấp độ màu đỏ, nhiệt độ ngoài trời lên tới bốn mươi độ C.', 'basic', 1),
        (v_id, '在持续极端高温酷暑天气下，工厂管理部门应当合理缩短户外露天作业时长并为职工发放防暑降温物资。', 'Zài chíxù jíduān gāowēn kùshǔ tiānqì xià, gōngchǎng guǎnlǐ bùmén yīngdāng hélǐ suōduǎn hùwài lùtiān zuòyè shícháng bìng wèi zhígōng fāfàng fángshǔ jiàngwēn wùzī.', 'Dưới thời tiết nắng nóng gay gắt cực đoan kéo dài, bộ phận quản lý nhà máy cần rút ngắn thời gian làm việc ngoài trời một cách hợp lý và phát đồ bảo hộ phòng chống say nắng cho công nhân viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [高于] (gāoyú) - cao hơn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '高于' AND pinyin = 'gāoyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '高于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'gāoyú',
      meaning_vi = 'cao hơn',
      example_hanzi = '今年公司的销售额明显高于去年同期的水平。',
      example_pinyin = 'Jīnnián gōngsī de xiāoshòu’é míngxiǎn gāoyú qùnián tóngqī de shuǐpíng.',
      example_vi = 'Doanh số bán hàng năm nay của công ty cao hơn rõ rệt so với mức cùng kỳ năm ngoái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今年公司的销售额明显高于去年同期的水平。', 'Jīnnián gōngsī de xiāoshòu’é míngxiǎn gāoyú qùnián tóngqī de shuǐpíng.', 'Doanh số bán hàng năm nay của công ty cao hơn rõ rệt so với mức cùng kỳ năm ngoái.', 'basic', 1),
        (v_id, '科技创新型企业的研发投入占总营业收入比重，往往显著高于传统劳动密集型制造行业。', 'Kējì chuàngxīnxíng qǐyè de yánfā tóurù zhàn zǒng yíngyè shōurù bǐzhòng, wǎngwǎng xiǎnzhù gāoyú chuántǒng láodòng mìjíxíng zhìzàohángyè.', 'Tỷ trọng đầu tư cho nghiên cứu phát triển trên tổng doanh thu hoạt động của doanh nghiệp đổi mới công nghệ thường cao hơn rõ rệt so với ngành sản xuất thâm dụng lao động truyền thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [胳膊] (gēbo) - cánh tay [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '胳膊' AND pinyin = 'gēbo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '胳膊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gēbo',
      meaning_vi = 'cánh tay',
      example_hanzi = '他昨天打篮球时不小心摔倒，扭伤了左胳膊。',
      example_pinyin = 'Tā zuótiān dǎ lánqiú shí bù xiǎoxīn shuāidǎo, niǔshāng le zuǒ gēbo.',
      example_vi = 'Hôm qua khi chơi bóng rổ anh ấy sơ ý ngã, bị trật khớp cánh tay trái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他昨天打篮球时不小心摔倒，扭伤了左胳膊。', 'Tā zuótiān dǎ lánqiú shí bù xiǎoxīn shuāidǎo, niǔshāng le zuǒ gēbo.', 'Hôm qua khi chơi bóng rổ anh ấy sơ ý ngã, bị trật khớp cánh tay trái.', 'basic', 1),
        (v_id, '医生在仔细检查并拍摄X光片后确认他的右胳膊只是肌肉拉伤，骨骼并未发生骨折，只需静养两周。', 'Yīshēng zài zǐxì jiǎnchá bìng pāishè X-guāng piàn hòu quèrèn tā de yòu gēbo zhǐ shì jīròu lāshāng, gǔgé bìng wèi fāshēng gǔzhé, zhǐ xū jìngyǎng liǎng zhōu.', 'Bác sĩ sau khi khám kỹ lưỡng và chụp X-quang xác nhận cánh tay phải của anh ấy chỉ bị căng cơ, xương cốt không hề rạn gãy, chỉ cần nghỉ ngơi dưỡng sức hai tuần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [歌声] (gēshēng) - tiếng hát, tiếng ca [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '歌声' AND pinyin = 'gēshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '歌声'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gēshēng',
      meaning_vi = 'tiếng hát, tiếng ca',
      example_hanzi = '从邻居家飘来一阵悠扬动听的歌声。',
      example_pinyin = 'Cóng línjū jiā piāo lái yí zhèn yōuyáng dòngtīng de gēshēng.',
      example_vi = 'Từ nhà người hàng xóm thoảng bay tới một làn điệu tiếng hát du dương êm tai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '从邻居家飘来一阵悠扬动听的歌声。', 'Cóng línjū jiā piāo lái yí zhèn yōuyáng dòngtīng de gēshēng.', 'Từ nhà người hàng xóm thoảng bay tới một làn điệu tiếng hát du dương êm tai.', 'basic', 1),
        (v_id, '当舞台灯光缓缓暗下，深情婉转的歌声在现代化音乐厅穹顶回荡，令全场数千名听众如痴如醉。', 'Dāng wǔtái dēngguāng huǎnhuǎn àn xià, shēnqíng wǎnzhuǎn de gēshēng zài xiàndàihuà yīnyuètīng qióngdǐng huídàng, lìng quánchǎng shù qiān míng tīngzhòng rúchī-rúzuì.', 'Khi ánh đèn sân khấu từ từ dịu xuống, tiếng hát trầm bổng da diết vang vọng dưới vòm sảnh hòa nhạc hiện đại, làm say đắm hàng nghìn thính giả có mặt trong khán phòng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [歌手] (gēshǒu) - ca sĩ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '歌手' AND pinyin = 'gēshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '歌手'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gēshǒu',
      meaning_vi = 'ca sĩ',
      example_hanzi = '她是一位非常有才华的新人原创流行歌手。',
      example_pinyin = 'Tā shì yí wèi fēicháng yǒu cáihuá de xīnrén yuánchuàng liúxíng gēshǒu.',
      example_vi = 'Cô ấy là một nữ ca sĩ nhạc pop trẻ tuổi đầy tài năng kiêm sáng tác.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '她是一位非常有才华的新人原创流行歌手。', 'Tā shì yí wèi fēicháng yǒu cáihuá de xīnrén yuánchuàng liúxíng gēshǒu.', 'Cô ấy là một nữ ca sĩ nhạc pop trẻ tuổi đầy tài năng kiêm sáng tác.', 'basic', 1),
        (v_id, '这位实力派独立歌手凭借卓越的唱功和深刻的词曲创作，荣获了本届华语流行音乐金曲大奖。', 'Zhè wèi shílìpài dúlì gēshǒu píngjiè zhuóyuè de chànggōng hé shēnkè de cíqǔ chuàngzuò, rónghuò le běn jiè Huáyǔ liúxíng yīnyuè Jīnqǔ dàjiǎng.', 'Ca sĩ độc lập trường phái thực lực này nhờ vào kỹ thuật thanh nhạc xuất sắc cùng khả năng sáng tác ca từ sâu lắng đã vinh dự giành giải thưởng Ca khúc Vàng nhạc Pop Hoa ngữ kỳ này.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [各] (gè) - các, mỗi (các giới, mỗi bên) [Đại từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '各' AND pinyin = 'gè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ / Phó từ',
      pinyin = 'gè',
      meaning_vi = 'các, mỗi (các giới, mỗi bên)',
      example_hanzi = '大家各抒己见，会议室里的讨论气氛非常热烈。',
      example_pinyin = 'Dàjiā gèshū-jǐjiàn, huìyìshì lǐ de tǎolùn qìfēn fēicháng rèliè.',
      example_vi = 'Mọi người mỗi người một ý bày tỏ quan điểm riêng, không khí thảo luận trong phòng họp rất sôi nổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家各抒己见，会议室里的讨论气氛非常热烈。', 'Dàjiā gèshū-jǐjiàn, huìyìshì lǐ de tǎolùn qìfēn fēicháng rèliè.', 'Mọi người mỗi người một ý bày tỏ quan điểm riêng, không khí thảo luận trong phòng họp rất sôi nổi.', 'basic', 1),
        (v_id, '在签署框架协议后，各合作方应根据合同细则严格履行各自承担的法定义务与投资责任。', 'Zài qiānshǔ kuàngjià xiéyì hòu, gè hézuò fāng yīng gēnjù hétong xìzé yángé lǚxíng gèzì chéngdān de fǎdìng yiwù yǔ tóuzī zérèn.', 'Sau khi ký kết thỏa thuận khung, các bên hợp tác cần căn cứ theo điều khoản hợp đồng thực hiện nghiêm ngặt các nghĩa vụ pháp lý và trách nhiệm đầu tư do mỗi bên đảm nhiệm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [各地] (gèdì) - các nơi, khắp nơi, mọi miền [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '各地' AND pinyin = 'gèdì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各地'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gèdì',
      meaning_vi = 'các nơi, khắp nơi, mọi miền',
      example_hanzi = '每年春天，来自全国各地的游客都会去武汉观赏樱花。',
      example_pinyin = 'Měi nián chūntiān, láizì quánguó gèdì de yóukè dōu huì qù Wǔhàn guānshǎng yīnghuā.',
      example_vi = 'Mỗi năm vào mùa xuân, du khách đến từ khắp mọi miền đất nước đều tới Vũ Hán để ngắm hoa anh đào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年春天，来自全国各地的游客都会去武汉观赏樱花。', 'Měi nián chūntiān, láizì quánguó gèdì de yóukè dōu huì qù Wǔhàn guānshǎng yīnghuā.', 'Mỗi năm vào mùa xuân, du khách đến từ khắp mọi miền đất nước đều tới Vũ Hán để ngắm hoa anh đào.', 'basic', 1),
        (v_id, '跨国电商物流网络的健全完善，使得世界各地的优质特色商品能够高效快捷地配送至普通消费者手中。', 'Kuàguó diànshāng wùliú wǎngluò de jiànquán wánshàn, shǐde shìjiè gèdì de yōuzhì tèsè shāngpǐn nénggòu gāoxiào kuàijié de pèisòng zhì pǔtōng xiāofèizhě shǒuzhōng.', 'Mạng lưới logistics thương mại điện tử xuyên biên giới hoàn thiện kiện toàn đã giúp các mặt hàng đặc sản chất lượng cao từ khắp nơi trên thế giới được giao đến tay người tiêu dùng bình dân một cách hiệu quả và mau chóng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [各个] (gègè) - từng cái, mỗi một, các [Đại từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '各个' AND pinyin = 'gègè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各个'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ / Phó từ',
      pinyin = 'gègè',
      meaning_vi = 'từng cái, mỗi một, các',
      example_hanzi = '老师逐一检查了各个小组提交的作业。',
      example_pinyin = 'Lǎoshī zhúyī jiǎnchá le gègè xiǎozǔ tíjiāo de zuòyè.',
      example_vi = 'Thầy giáo đã lần lượt kiểm tra bài tập nộp lên của từng nhóm một.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师逐一检查了各个小组提交的作业。', 'Lǎoshī zhúyī jiǎnchá le gègè xiǎozǔ tíjiāo de zuòyè.', 'Thầy giáo đã lần lượt kiểm tra bài tập nộp lên của từng nhóm một.', 'basic', 1),
        (v_id, '在推进数字化转型的全流程中，企业必须对各个业务环节的数据安全隐患开展地毯式排查。', 'Zài tuījìn shùzìhuà zhuǎnxíng de quán liúchéng zhōng, qǐyè bìxū duì gègè yèwù huánjié de shùjù ānquán yǐnhuàn kāizhǎn dìtǎnshì páichá.', 'Trong toàn bộ quy trình đẩy mạnh chuyển đổi số, doanh nghiệp phải triển khai rà soát toàn diện từng mắt xích nghiệp vụ về những nguy cơ tiềm ẩn đối với an toàn dữ liệu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [各位] (gèwèi) - các vị, quý vị, mọi người [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '各位' AND pinyin = 'gèwèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各位'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ',
      pinyin = 'gèwèi',
      meaning_vi = 'các vị, quý vị, mọi người',
      example_hanzi = '各位来宾、各位朋友，大家晚上好！',
      example_pinyin = 'Gèwèi láibīn, gèwèi péngyou, dàjiā wǎnshang hǎo!',
      example_vi = 'Kính thưa quý vị quan khách, các bạn hữu, chúc mọi người một buổi tối tốt lành!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '各位来宾、各位朋友，大家晚上好！', 'Gèwèi láibīn, gèwèi péngyou, dàjiā wǎnshang hǎo!', 'Kính thưa quý vị quan khách, các bạn hữu, chúc mọi người một buổi tối tốt lành!', 'basic', 1),
        (v_id, '各位与会代表在年度股东大会上就集团未来的全球并购战略展开了充分而深入的探讨。', 'Gèwèi yùhuì dàibiǎo zài niándù gǔdōng dàhuì shang jiù jítuán wèilái de quánqiú bìnggòu zhànlüè zhānkāi le chōngfèn ér shēnrù de tàntǎo.', 'Các đại biểu tham dự hội nghị tại Đại hội cổ đông thường niên đã tiến hành thảo luận đầy đủ và sâu sắc về chiến lược mua bán sáp nhập toàn cầu trong tương lai của tập đoàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [各种] (gèzhǒng) - các loại, đủ loại, các thứ [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '各种' AND pinyin = 'gèzhǒng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '各种'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ',
      pinyin = 'gèzhǒng',
      meaning_vi = 'các loại, đủ loại, các thứ',
      example_hanzi = '这家大型超市里摆满了各种各样的新鲜热带水果。',
      example_pinyin = 'Zhè jiā dàxíng chāoshì lǐ bǎi mǎn le gèzhǒng-gèyàng de xīnxiān rèdài shuǐguǒ.',
      example_vi = 'Trong siêu thị quy mô lớn này bày đầy đủ các loại hoa quả nhiệt đới tươi ngon.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家大型超市里摆满了各种各样的新鲜热带水果。', 'Zhè jiā dàxíng chāoshì lǐ bǎi mǎn le gèzhǒng-gèyàng de xīnxiān rèdài shuǐguǒ.', 'Trong siêu thị quy mô lớn này bày đầy đủ các loại hoa quả nhiệt đới tươi ngon.', 'basic', 1),
        (v_id, '面对复杂市场环境中出现的各种不可预见风险，企业应当建立健全敏捷高效的危机应对机制。', 'Miànduì fùzá shìchǎng huánjìng zhōng chūxiàn de gèzhǒng bùkě-yùjiàn fēngxiǎn, qǐyè yīngdāng jiànlì jiànquán mǐnjié gāoxiào de wēijī yìngduì jīzhì.', 'Đối mặt với các loại rủi ro khôn lường xuất hiện trong môi trường thị trường phức tạp, doanh nghiệp cần thiết lập kiện toàn cơ chế phản ứng khủng hoảng linh hoạt và hiệu quả.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [更加] (gèngjiā) - càng, càng thêm, hơn nữa [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '更加' AND pinyin = 'gèngjiā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '更加'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'gèngjiā',
      meaning_vi = 'càng, càng thêm, hơn nữa',
      example_hanzi = '经过几个月的刻苦锻炼，他的身体变得更加强壮健康了。',
      example_pinyin = 'Jīngguò jǐ gè yuè de kèkǔ duànliàn, tā de shēntǐ biàn de gèngjiā qiángzhuàng jiànkāng le.',
      example_vi = 'Trải qua mấy tháng khổ luyện, cơ thể của anh ấy đã trở nên cường tráng khỏe mạnh hơn hẳn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过几个月的刻苦锻炼，他的身体变得更加强壮健康了。', 'Jīngguò jǐ gè yuè de kèkǔ duànliàn, tā de shēntǐ biàn de gèngjiā qiángzhuàng jiànkāng le.', 'Trải qua mấy tháng khổ luyện, cơ thể của anh ấy đã trở nên cường tráng khỏe mạnh hơn hẳn.', 'basic', 1),
        (v_id, '引入先进的人工智能算法后，该平台的数据检索与智能推荐精度得到了更加显著的提升。', 'Yǐnrù xiānjìn de réngōng zhìnéng suànfǎ hòu, gāi píngtái de shùjù jiǎnsuǒ yǔ zhìnéng tuījiàn jīngdù dédào le gèngjiā xiǎnzhù de tíshēng.', 'Sau khi đưa vào các thuật toán trí tuệ nhân tạo tiên tiến, độ chuẩn xác trong việc truy xuất dữ liệu và đề xuất thông minh của nền tảng đã đạt được sự nâng tầm càng thêm rõ nét.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [工厂] (gōngchǎng) - nhà máy, xưởng sản xuất [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '工厂' AND pinyin = 'gōngchǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '工厂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gōngchǎng',
      meaning_vi = 'nhà máy, xưởng sản xuất',
      example_hanzi = '这家汽车制造工厂坐落在城市郊区的工业开发区内。',
      example_pinyin = 'Zhè jiā qìchē zhìzào gōngchǎng zuòluò zài chéngshì jiāoqū de gōngyè kāifāqū nèi.',
      example_vi = 'Nhà máy sản xuất xe hơi này tọa lạc trong khu phát triển công nghiệp ở vùng ngoại ô thành phố.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家汽车制造工厂坐落在城市郊区的工业开发区内。', 'Zhè jiā qìchē zhìzào gōngchǎng zuòluò zài chéngshì jiāoqū de gōngyè kāifāqū nèi.', 'Nhà máy sản xuất xe hơi này tọa lạc trong khu phát triển công nghiệp ở vùng ngoại ô thành phố.', 'basic', 1),
        (v_id, '为了提高产能并降低废弃物排放，该现代智能工厂全面部署了自动化工业机器人生产线。', 'Wèile tígāo chǎnnéng bìng jiàngdī fèiqìwù páifàng, gāi xiàndài zhìnéng gōngchǎng quánmiàn bùshǔ le zìdònghuà gōngyè jīqìrén shēngchǎnxiàn.', 'Để nâng cao năng lực sản xuất và hạ thấp lượng xả thải chất thải, nhà máy thông minh hiện đại này đã triển khai toàn diện dây chuyền sản xuất robot công nghiệp tự động hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [功夫] (gōngfu) - kung fu, võ thuật; công phu, công sức bỏ ra [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '功夫' AND pinyin = 'gōngfu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '功夫'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gōngfu',
      meaning_vi = 'kung fu, võ thuật; công phu, công sức bỏ ra',
      example_hanzi = '许多外国朋友是因为喜爱中国功夫而开始学习汉语的。',
      example_pinyin = 'Xǔduō wàiguó péngyou shì yīnwèi xǐ’ài Zhōngguó gōngfu ér kāishǐ xuéxí Hànyǔ de.',
      example_vi = 'Rất nhiều người bạn nước ngoài vì yêu mến kung fu Trung Hoa mà bắt đầu học tiếng Trung.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '许多外国朋友是因为喜爱中国功夫而开始学习汉语的。', 'Xǔduō wàiguó péngyou shì yīnwèi xǐ’ài Zhōngguó gōngfu ér kāishǐ xuéxí Hànyǔ de.', 'Rất nhiều người bạn nước ngoài vì yêu mến kung fu Trung Hoa mà bắt đầu học tiếng Trung.', 'basic', 1),
        (v_id, '俗话说“只要功夫深，铁杵磨成针”，任何专业技能的精通都离不开日复一日的刻苦磨砺。', 'Súhuà shuō “zhǐyào gōngfu shēn, tiěchǔ mó chéng zhēn”, rènhé zhuānyè jìnéng de jīngtōng dōu líbukāi rìfùyírì de kèkǔ mólì.', 'Tục ngữ có câu "Có công mài sắt, có ngày nên kim", sự tinh thông của bất kỳ kỹ năng chuyên môn nào cũng đều gắn liền với sự trau dồi khổ luyện ngày này qua tháng khác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [公共] (gōnggòng) - công cộng, chung [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '公共' AND pinyin = 'gōnggòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '公共'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'gōnggòng',
      meaning_vi = 'công cộng, chung',
      example_hanzi = '在图书馆和医院等公共场所，我们应当保持安静。',
      example_pinyin = 'Zài túshūguǎn hé yīyuàn děng gōnggòng chǎngsuǒ, wǒmen yīngdāng bǎochí ānjìng.',
      example_vi = 'Tại các địa điểm công cộng như thư viện và bệnh viện, chúng ta nên giữ trật tự im lặng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在图书馆和医院等公共场所，我们应当保持安静。', 'Zài túshūguǎn hé yīyuàn děng gōnggòng chǎngsuǒ, wǒmen yīngdāng bǎochí ānjìng.', 'Tại các địa điểm công cộng như thư viện và bệnh viện, chúng ta nên giữ trật tự im lặng.', 'basic', 1),
        (v_id, '完善城市公共交通网络不仅能缓解交通拥堵，更是践行绿色低碳环保出行的核心举措。', 'Wánshàn chéngshì gōnggòng jiāotōng wǎngluò bùjǐn néng huǎnjiě jiāotōng yōngdǔ, gèng shì jiànxíng lǜsè dītàn huánbǎo chūxíng de héxīn jǔcuò.', 'Kiện toàn mạng lưới giao thông công cộng đô thị không chỉ xoa dịu ùn tắc đường xá, mà còn là giải pháp cốt lõi để hiện thực hóa việc đi lại xanh, giảm phát thải carbon và thân thiện với môi trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [功课] (gōngkè) - bài vở, bài tập ở trường; sự chuẩn bị tìm hiểu kỹ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '功课' AND pinyin = 'gōngkè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '功课'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gōngkè',
      meaning_vi = 'bài vở, bài tập ở trường; sự chuẩn bị tìm hiểu kỹ',
      example_hanzi = '每天放学回家后，小明都会按时把当天的功课认真做完。',
      example_pinyin = 'Měitiān fàngxué huí jiā hòu, Xiǎomíng dōu huì ànshí bǎ dāngtiān de gōngkè rènzhēn zuò wán.',
      example_vi = 'Mỗi ngày sau khi tan học về nhà, Tiểu Minh đều đúng giờ hoàn thành nghiêm túc bài vở của ngày hôm đó.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天放学回家后，小明都会按时把当天的功课认真做完。', 'Měitiān fàngxué huí jiā hòu, Xiǎomíng dōu huì ànshí bǎ dāngtiān de gōngkè rènzhēn zuò wán.', 'Mỗi ngày sau khi tan học về nhà, Tiểu Minh đều đúng giờ hoàn thành nghiêm túc bài vở của ngày hôm đó.', 'basic', 1),
        (v_id, '在参加这次重要的海外商务考察之前，团队提前做足了针对当地市场法律环境的功课。', 'Zài cānjiā zhè cì zhòngyào de hǎiwài shāngyè kǎochá zhīqián, tuánduì tíqián zuò zú le zhēnduì dāngdì shìchǎng fǎlǜ huánjìng de gōngkè.', 'Trước khi tham gia chuyến khảo sát thương mại hải ngoại quan trọng lần này, đội ngũ đã làm bài tập tìm hiểu chuẩn bị vô cùng kỹ lưỡng về môi trường pháp lý của thị trường sở tại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [公里] (gōnglǐ) - ki-lô-mét (km) [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '公里' AND pinyin = 'gōnglǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '公里'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'gōnglǐ',
      meaning_vi = 'ki-lô-mét (km)',
      example_hanzi = '学校离我住的地方大约有五公里路程。',
      example_pinyin = 'Xuéxiào lí wǒ zhù de dìfang dàyuē yǒu wǔ gōnglǐ lùchéng.',
      example_vi = 'Trường học cách nơi tôi ở khoảng chừng năm cây số.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学校离我住的地方大约有五公里路程。', 'Xuéxiào lí wǒ zhù de dìfang dàyuē yǒu wǔ gōnglǐ lùchéng.', 'Trường học cách nơi tôi ở khoảng chừng năm cây số.', 'basic', 1),
        (v_id, '中国高速铁路列车的最高商业运营时速已达每小时三百五十公里，极大地缩短了城际通行时间。', 'Zhōngguó gāosù tiělù lièchē de zuì gāo shāngyè yùnyíng shísù yǐ dá měi xiǎoshí sān bǎi wǔshí gōnglǐ, jí dà de suōduǎn le chéngjì tōngxíng shíjiān.', 'Vận tốc vận hành thương mại tối đa của các đoàn tàu đường sắt cao tốc Trung Quốc đã đạt tới 350 km/h, rút ngắn đáng kể thời gian di chuyển liên thành phố.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [公路] (gōnglù) - đường quốc lộ, đường bộ, đường cái [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '公路' AND pinyin = 'gōnglù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '公路'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gōnglù',
      meaning_vi = 'đường quốc lộ, đường bộ, đường cái',
      example_hanzi = '沿着这条盘山公路一直往前开，就能到达风景优美的山顶观景台。',
      example_pinyin = 'Yánzhe zhè tiáo pánshān gōnglù yìzhí wǎng qián kāi, jiù néng dàodá fēngjǐng yōuměi de shāndǐng guānjǐngtái.',
      example_vi = 'Cứ lái men theo con đường quanh núi này đi thẳng về phía trước là có thể đến đài ngắm cảnh phong cảnh tuyệt đẹp trên đỉnh núi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '沿着这条盘山公路一直往前开，就能到达风景优美的山顶观景台。', 'Yánzhe zhè tiáo pánshān gōnglù yìzhí wǎng qián kāi, jiù néng dàodá fēngjǐng yōuměi de shāndǐng guānjǐngtái.', 'Cứ lái men theo con đường quanh núi này đi thẳng về phía trước là có thể đến đài ngắm cảnh phong cảnh tuyệt đẹp trên đỉnh núi.', 'basic', 1),
        (v_id, '国家近年来持续加大对中西部偏远乡村公路基础设施建设的资金扶持力度，畅通了农村特色农产品物流运输通道。', 'Guójiā jìnniánlái chíxù jiàdà duì zhōng-xībù piānyuǎn xiāngcūn gōnglù jīchǔ shèshī jiànshè de zījīn fúchí lìdù, chàngtōng le nóngcūn tèsè nóngchǎnpǐn wùliú yùnshū tōngdào.', 'Những năm gần đây nhà nước không ngừng tăng cường nguồn vốn hỗ trợ xây dựng cơ sở hạ tầng đường bộ nông thôn vùng sâu vùng xa miền Trung Tây, thông suốt các tuyến đường vận tải logistics nông sản đặc sản vùng miền.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [工人] (gōngrén) - công nhân, người lao động [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '工人' AND pinyin = 'gōngrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '工人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gōngrén',
      meaning_vi = 'công nhân, người lao động',
      example_hanzi = '车间里的工人们正在熟练地操作机器组装电子元件。',
      example_pinyin = 'Chējiān lǐ de gōngrénmen zhèngzài shúliàn de cāozuò jīqì zǔzhuāng diànzǐ yuánjiàn.',
      example_vi = 'Các công nhân trong phân xưởng đang thuần thục thao tác máy móc lắp ráp linh kiện điện tử.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '车间里的工人们正在熟练地操作机器组装电子元件。', 'Chējiān lǐ de gōngrénmen zhèngzài shúliàn de cāozuò jīqì zǔzhuāng diànzǐ yuánjiàn.', 'Các công nhân trong phân xưởng đang thuần thục thao tác máy móc lắp ráp linh kiện điện tử.', 'basic', 1),
        (v_id, '企业不仅要为技术工人提供公平合理的薪酬福利待遇，更要建立畅通的技术晋升与职业培训通道。', 'Qǐyè bùjǐn yào wèi jìshù gōngrén tígōng gōngpíng hélǐ de xīnchóu fúlì dàiyù, gèng yào jiànlì chàngtōng de jìshù jìnshēng yǔ zhíyè péixùn tōngdào.', 'Doanh nghiệp không những cần đem lại chế độ đãi ngộ lương bổng và phúc lợi công bằng hợp lý cho công nhân kỹ thuật, mà còn phải thiết lập lộ trình đào tạo nghề và thăng tiến kỹ thuật thông suốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [工资] (gōngzī) - tiền lương, tiền công [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '工资' AND pinyin = 'gōngzī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '工资'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gōngzī',
      meaning_vi = 'tiền lương, tiền công',
      example_hanzi = '公司通常在每个月的十号准时发放员工工资。',
      example_pinyin = 'Gōngsī tōngcháng zài měi gè yuè de shí hào zhǔnshí fāfàng yuángōng gōngzī.',
      example_vi = 'Công ty thường phát tiền lương cho nhân viên đúng hẹn vào ngày mùng 10 hàng tháng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '公司通常在每个月的十号准时发放员工工资。', 'Gōngsī tōngcháng zài měi gè yuè de shí hào zhǔnshí fāfàng yuángōng gōngzī.', 'Công ty thường phát tiền lương cho nhân viên đúng hẹn vào ngày mùng 10 hàng tháng.', 'basic', 1),
        (v_id, '在这项全面薪酬改革方案中，员工的绩效奖金与基本基本工资紧密挂钩，以充分激发团队的创新活力。', 'Zài zhè xiàng quánmiàn xīnchóu gǎigé fāng’àn zhōng, yuángōng de jìxiào jiǎngjīn yǔ jīběn gōngzī jǐnmì guàgōu, yǐ chōngfèn jīfā tuánduì de chuàngxīn huólì.', 'Trong phương án cải cách tiền lương toàn diện này, tiền thưởng hiệu suất của nhân viên gắn kết chặt chẽ với mức lương cơ bản, nhằm khơi dậy trọn vẹn sức sống đổi mới sáng tạo của đội ngũ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [共] (gòng) - tổng cộng, cùng nhau [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '共' AND pinyin = 'gòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '共'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'gòng',
      meaning_vi = 'tổng cộng, cùng nhau',
      example_hanzi = '这本书一共有二十个单元，适合作为中级精读教材。',
      example_pinyin = 'Zhè běn shū yígòng yǒu èrshí gè dānyuán, shìhé zuòwéi zhōngjí jīngdú jiàocái.',
      example_vi = 'Cuốn sách này có tổng cộng hai mươi bài, thích hợp làm giáo trình đọc hiểu chuyên sâu trình độ trung cấp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这本书一共有二十个单元，适合作为中级精读教材。', 'Zhè běn shū yígòng yǒu èrshí gè dānyuán, shìhé zuòwéi zhōngjí jīngdú jiàocái.', 'Cuốn sách này có tổng cộng hai mươi bài, thích hợp làm giáo trình đọc hiểu chuyên sâu trình độ trung cấp.', 'basic', 1),
        (v_id, '此次跨国科技交流峰会共有来自全球五十多个国家和地区的顶尖行业学者与商界领袖出席。', 'Cǐ cì kuàguó kējì jiāoliú fēnghuì gòng yǒu láizì quánqiú wǔshí duō gè guójiā hé dìqū de dǐngjiān hángyè xuézhě yǔ shāngjiè lǐngxiù chūxí.', 'Hội nghị thượng đỉnh giao lưu khoa học công nghệ xuyên quốc gia lần này có tổng cộng các học giả hàng đầu ngành và giới lãnh đạo thương trường đến từ hơn 50 quốc gia và vùng lãnh thổ trên thế giới tham dự.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [共同] (gòngtóng) - chung, cùng nhau [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '共同' AND pinyin = 'gòngtóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '共同'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'gòngtóng',
      meaning_vi = 'chung, cùng nhau',
      example_hanzi = '保护地球生态环境是我们全人类共同的责任。',
      example_pinyin = 'Bǎohù Dìqiú shēngtài huánjìng shì wǒmen quán rénlèi gòngtóng de zérèn.',
      example_vi = 'Bảo vệ môi trường sinh thái Trái đất là trách nhiệm chung của toàn thể nhân loại chúng ta.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '保护地球生态环境是我们全人类共同的责任。', 'Bǎohù Dìqiú shēngtài huánjìng shì wǒmen quán rénlèi gòngtóng de zérèn.', 'Bảo vệ môi trường sinh thái Trái đất là trách nhiệm chung của toàn thể nhân loại chúng ta.', 'basic', 1),
        (v_id, '双方企业基于互利共赢的原则签署了战略协议，旨在共同研发新一代环保低碳新能源电池。', 'Shuāngfāng qǐyè jīyú hùlì-gòngyíng de yuánzé qiānshǔ le zhànlüè xiéyì, zhǐ zài gòngtóng yánfā xīn yídài huánbǎo dītàn xīnnéngyuán diànchí.', 'Doanh nghiệp hai bên trên nguyên tắc đôi bên cùng có lợi đã ký kết thỏa thuận chiến lược, hướng tới mục tiêu cùng nhau hợp tác nghiên cứu phát triển thế hệ pin năng lượng mới giảm phát thải thân thiện với môi trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [够] (gòu) - đủ; khá, chán [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '够' AND pinyin = 'gòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '够'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Phó từ',
      pinyin = 'gòu',
      meaning_vi = 'đủ; khá, chán',
      example_hanzi = '桌上的饭菜已经够大家吃了，不用再加菜了。',
      example_pinyin = 'Zhuō shang de fàncài yǐjīng gòu dàjiā chī le, bú yòng zài jiā cài le.',
      example_vi = 'Cơm canh trên bàn đã đủ cho mọi người ăn rồi, không cần gọi thêm món nữa đâu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '桌上的饭菜已经够大家吃了，不用再加菜了。', 'Zhuō shang de fàncài yǐjīng gòu dàjiā chī le, bú yòng zài jiā cài le.', 'Cơm canh trên bàn đã đủ cho mọi người ăn rồi, không cần gọi thêm món nữa đâu.', 'basic', 1),
        (v_id, '要想在竞争异常激烈的商业竞争中立于不败之地，光有雄厚的资本运作是远远不够的，还必须具备持续的技术创新壁垒。', 'Yào xiǎng zài jìngzhēng yìcháng jīliè de shāngyè jìngzhēng zhōng lìyú-búbàizhīdì, guāng yǒu xiónghòu de zīběn yùnzuò shì yuǎnyuǎn bú gòu de, hái bìxū jùbèi chíxù de jìshù chuàngxīn bìlěi.', 'Muốn đứng vững ở thế bất bại trong cuộc cạnh tranh thương trường khốc liệt khôn cùng, chỉ có vận hành nguồn vốn dồi dào thôi thì còn lâu mới đủ, mà còn phải có rào cản đổi mới công nghệ liên tục.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [购买] (gòumǎi) - mua, thu mua, mua sắm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '购买' AND pinyin = 'gòumǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '购买'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'gòumǎi',
      meaning_vi = 'mua, thu mua, mua sắm',
      example_hanzi = '很多年轻人习惯在网络电商平台上购买生活日用品。',
      example_pinyin = 'Hěn duō qīngniánrén xíguàn zài wǎngluò diànshāng píngtái shang gòumǎi shēnghuó rìyòngpǐn.',
      example_vi = 'Rất nhiều người trẻ tuổi quen mua sắm đồ dùng thiết yếu hàng ngày trên các nền tảng thương mại điện tử trực tuyến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '很多年轻人习惯在网络电商平台上购买生活日用品。', 'Hěn duō qīngniánrén xíguàn zài wǎngluò diànshāng píngtái shang gòumǎi shēnghuó rìyòngpǐn.', 'Rất nhiều người trẻ tuổi quen mua sắm đồ dùng thiết yếu hàng ngày trên các nền tảng thương mại điện tử trực tuyến.', 'basic', 1),
        (v_id, '消费者在购买大额商业保险产品时，应当逐条仔细核对合同保险责任与免责除外条款。', 'Xiāofèizhě zài gòumǎi dà’é shāngyè bǎoxiǎn chǎnpǐn shí, yīngdāng zhútáo zǐxì héduì hétong bǎoxiǎn zérèn yǔ miǎnzé chúwài tiáokuǎn.', 'Người tiêu dùng khi mua các gói sản phẩm bảo hiểm thương mại giá trị lớn cần đối chiếu kỹ từng điều khoản trách nhiệm bảo hiểm và trường hợp loại trừ miễn trừ trách nhiệm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [购物] (gòuwù) - mua sắm, shopping [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '购物' AND pinyin = 'gòuwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '购物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'gòuwù',
      meaning_vi = 'mua sắm, shopping',
      example_hanzi = '周末市中心的商业街上到处都是出来购物逛街的人潮。',
      example_pinyin = 'Zhōumò shìzhōngxīn de shāngyèjiē shang dàochù dōu shì chūlái gòuwù guàngjiē de réncháo.',
      example_vi = 'Cuối tuần trên phố thương mại ở trung tâm thành phố đâu đâu cũng là dòng người đi mua sắm dạo phố.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末市中心的商业街上到处都是出来购物逛街的人潮。', 'Zhōumò shìzhōngxīn de shāngyèjiē shang dàochù dōu shì chūlái gòuwù guàngjiē de réncháo.', 'Cuối tuần trên phố thương mại ở trung tâm thành phố đâu đâu cũng là dòng người đi mua sắm dạo phố.', 'basic', 1),
        (v_id, '现代大型城市综合体将购物消费、文化娱乐以及特色餐饮深度融合，为消费者提供了全方位的沉浸式体验。', 'Xiàndài dàxíng chéngshì zōnghétǐ jiāng gòuwù xiāofèi, wénhuà yúlè yǐjí tèsè cānyǐn shēndù rónghé, wèi xiāofèizhě tígōng le quánfāngwèi de chénjìnshì tǐyàn.', 'Khu phức hợp đô thị quy mô lớn hiện đại kết hợp sâu sắc giữa tiêu dùng mua sắm, giải trí văn hóa cũng như ẩm thực đặc sản, đem lại trải nghiệm đắm chìm toàn diện cho người tiêu dùng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [估计] (gūjì) - ước tính, dự đoán; sự ước lượng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '估计' AND pinyin = 'gūjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '估计'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'gūjì',
      meaning_vi = 'ước tính, dự đoán; sự ước lượng',
      example_hanzi = '路上有点堵车，我估计半个小时以后才能赶到餐厅。',
      example_pinyin = 'Lùshang yǒudiǎn dǔchē, wǒ gūjì bàn gè xiǎoshí yǐhòu cái néng gǎndào cāntīng.',
      example_vi = 'Dọc đường hơi tắc xe, tôi ước tính nửa tiếng nữa mới có thể đến được nhà hàng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '路上有点堵车，我估计半个小时以后才能赶到餐厅。', 'Lùshang yǒudiǎn dǔchē, wǒ gūjì bàn gè xiǎoshí yǐhòu cái néng gǎndào cāntīng.', 'Dọc đường hơi tắc xe, tôi ước tính nửa tiếng nữa mới có thể đến được nhà hàng.', 'basic', 1),
        (v_id, '据权威国际金融机构保守估计，该高科技行业的全球市场规模在未来五年内将保持两位数的复合增长率。', 'Jù quánwēi guójì jīnróng jīgòu bǎoshǒu gūjì, gāi gāokējì hángyè de quánqiú shìchǎng guīmó zài wèilái wǔ nián nèi jiāng bǎochí liǎngwèishù de fùhé zēngzhǎnglǜ.', 'Theo ước tính dè dặt của cơ quan tài chính quốc tế uy tín, quy mô thị trường toàn cầu của ngành công nghệ cao này trong 5 năm tới sẽ duy trì tốc độ tăng trưởng kép hai con số.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [姑娘] (gūniang) - cô gái, thiếu nữ, cô nương [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '姑娘' AND pinyin = 'gūniang'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '姑娘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gūniang',
      meaning_vi = 'cô gái, thiếu nữ, cô nương',
      example_hanzi = '那位在图书馆认真读书的年轻姑娘笑起来十分甜美。',
      example_pinyin = 'Nà wèi zài túshūguǎn rènzhēn dúshū de niánqīng gūniang xiào qǐlai shífēn tiánměi.',
      example_vi = 'Cô gái trẻ đang chăm chú đọc sách trong thư viện đó khi cười trông vô cùng ngọt ngào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '那位在图书馆认真读书的年轻姑娘笑起来十分甜美。', 'Nà wèi zài túshūguǎn rènzhēn dúshū de niánqīng gūniang xiào qǐlai shífēn tiánměi.', 'Cô gái trẻ đang chăm chú đọc sách trong thư viện đó khi cười trông vô cùng ngọt ngào.', 'basic', 1),
        (v_id, '这位来自乡村的年轻姑娘凭借自强不息的拼搏精神考取了名牌大学博士，成为全村人的骄傲。', 'Zhè wèi láizì xiāngcūn de niánqīng gūniang píngjiè zìqiáng-bùxī de pīnbó jīngshén kǎoqǔ le míngpái dàxué bóshì, chéngwéi quán cūnrén de jiāo’ào.', 'Cô gái trẻ đến từ vùng nông thôn này nhờ vào tinh thần tự lực tự cường phấn đấu không ngừng nghỉ đã đỗ tiến sĩ trường đại học danh tiếng, trở thành niềm tự hào của cả làng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [鼓励] (gǔlì) - khích lệ, động viên; lời cổ vũ [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '鼓励' AND pinyin = 'gǔlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '鼓励'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'gǔlì',
      meaning_vi = 'khích lệ, động viên; lời cổ vũ',
      example_hanzi = '在老师和父母的热情鼓励下，他终于勇敢地报了名参加演讲比赛。',
      example_pinyin = 'Zài lǎoshī hé fùmǔ de rèqíng gǔlì xià, tā zhōngyú yǒnggǎn de bào le míng cānjiā yǎnjiǎng bǐsài.',
      example_vi = 'Dưới sự động viên nhiệt tình của thầy cô và cha mẹ, cuối cùng cậu ấy đã dũng cảm đăng ký tham gia cuộc thi diễn thuyết.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在老师和父母的热情鼓励下，他终于勇敢地报了名参加演讲比赛。', 'Zài lǎoshī hé fùmǔ de rèqíng gǔlì xià, tā zhōngyú yǒnggǎn de bào le míng cānjiā yǎnjiǎng bǐsài.', 'Dưới sự động viên nhiệt tình của thầy cô và cha mẹ, cuối cùng cậu ấy đã dũng cảm đăng ký tham gia cuộc thi diễn thuyết.', 'basic', 1),
        (v_id, '政府出台了一系列税收优惠与资金补贴政策，积极鼓励中小微科技型企业加大自主研发创新投入。', 'Zhèngfǔ chūtái le yí xìliè shuìshōu yōuhuì yǔ zījīn bǔtiē zhèngcè, jījí gǔlì zhōng-xiǎo-wēi kējìxíng qǐyè jiàdà zìzhǔ yánfā chuàngxīn tóurù.', 'Chính phủ đã ban hành một loạt chính sách ưu đãi thuế và trợ cấp tài chính, tích cực khuyến khích các doanh nghiệp công nghệ vừa, nhỏ và siêu nhỏ gia tăng đầu tư nghiên cứu phát triển đổi mới độc lập.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [顾客] (gùkè) - khách hàng, người mua hàng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '顾客' AND pinyin = 'gùkè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '顾客'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gùkè',
      meaning_vi = 'khách hàng, người mua hàng',
      example_hanzi = '服务员耐心地向顾客解答关于手机各项功能的疑问。',
      example_pinyin = 'Fúwùyuán nàixīn de xiàng gùkè jiědá guānyú shǒujī gè xiàng gōngnéng de yíwèn.',
      example_vi = 'Nhân viên phục vụ kiên nhẫn giải đáp thắc mắc của khách hàng về từng tính năng của chiếc điện thoại di động.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '服务员耐心地向顾客解答关于手机各项功能的疑问。', 'Fúwùyuán nàixīn de xiàng gùkè jiědá guānyú shǒujī gè xiàng gōngnéng de yíwèn.', 'Nhân viên phục vụ kiên nhẫn giải đáp thắc mắc của khách hàng về từng tính năng của chiếc điện thoại di động.', 'basic', 1),
        (v_id, '优秀的服务型企业始终践行“顾客至上”的服务理念，致力于为每一位顾客提供个性化的高品质体验。', 'Yōuxiù de fúwùxíng qǐyè shǐzhōng jiànxíng “gùkè zhìshàng” de fúwù lǐniàn, zhìlìyú wèi měi yí wèi gùkè tígōng gèxìnghuà de gāo pǐnzhì tǐyàn.', 'Doanh nghiệp dịch vụ xuất sắc luôn thực thi triết lý phục vụ "Khách hàng là thượng đế", dốc lòng đem lại trải nghiệm cá nhân hóa chất lượng cao cho từng khách hàng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [故意] (gùyì) - cố ý, cố tình [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '故意' AND pinyin = 'gùyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '故意'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'gùyì',
      meaning_vi = 'cố ý, cố tình',
      example_hanzi = '对不起，我刚才真不是故意踩到你的脚的。',
      example_pinyin = 'Duìbuqǐ, wǒ gāngcái zhēn bú shì gùyì cǎi dào nǐ de jiǎo de.',
      example_vi = 'Xin lỗi nhé, lúc nãy tôi thật sự không phải cố ý dẫm trúng chân bạn đâu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '对不起，我刚才真不是故意踩到你的脚的。', 'Duìbuqǐ, wǒ gāngcái zhēn bú shì gùyì cǎi dào nǐ de jiǎo de.', 'Xin lỗi nhé, lúc nãy tôi thật sự không phải cố ý dẫm trúng chân bạn đâu.', 'basic', 1),
        (v_id, '经监管部门核查证实，该上市公司存在故意隐瞒重大资产亏损的违规行为，依法将面临巨额行政处罚。', 'Jīng jiānguǎn bùmén héchá zhèngshí, gāi shàngshì gōngsī cúnzài gùyì yǐnmán zhòngdà zīchǎn kuīsǔn de wéiguī xíngwéi, yīfǎ jiāng miànlín jù’é xíngzhèng chǔfá.', 'Qua xác minh của cơ quan giám sát, công ty niêm yết này có hành vi vi phạm cố tình che giấu thua lỗ tài sản nghiêm trọng, theo pháp luật sẽ phải đối mặt với mức xử phạt hành chính khổng lồ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [挂] (guà) - treo; cúp máy (điện thoại); đăng ký khám (挂号) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '挂' AND pinyin = 'guà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '挂'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'guà',
      meaning_vi = 'treo; cúp máy (điện thoại); đăng ký khám (挂号)',
      example_hanzi = '回到家后，他顺手把外套挂在门后的衣帽架上。',
      example_pinyin = 'Huí dào jiā hòu, tā shùnshǒu bǎ wàitào guà zài mén hòu de yīmàojià shang.',
      example_vi = 'Sau khi về tới nhà, anh ấy thuận tay treo chiếc áo khoác lên cây treo mũ áo phía sau cánh cửa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '回到家后，他顺手把外套挂在门后的衣帽架上。', 'Huí dào jiā hòu, tā shùnshǒu bǎ wàitào guà zài mén hòu de yīmàojià shang.', 'Sau khi về tới nhà, anh ấy thuận tay treo chiếc áo khoác lên cây treo mũ áo phía sau cánh cửa.', 'basic', 1),
        (v_id, '在就医数字化改革推行后，市民只需在手机应用上提前预约挂号，便能避免排队拥挤。', 'Zài jiùyī shùzìhuà gǎigé tuīxíng hòu, shìmín zhǐ xū zài shǒujī yìngyòng shang tíqián yùyuē guàhào, biàn néng bìmiǎn páiduì yōngjǐ.', 'Sau khi cải cách số hóa quy trình khám chữa bệnh được triển khai, người dân chỉ cần đăng ký lấy số khám trước trên ứng dụng di động là có thể tránh được cảnh xếp hàng chen chúc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [关键] (guānjiàn) - then chốt, mấu chốt, điểm mấu chốt [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '关键' AND pinyin = 'guānjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '关键'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'guānjiàn',
      meaning_vi = 'then chốt, mấu chốt, điểm mấu chốt',
      example_hanzi = '掌握科学的学习方法是提高汉语水平的关键所在。',
      example_pinyin = 'Zhǎngwò kēxué de xuéxí fāngfǎ shì tígāo Hànyǔ shuǐpíng de guānjiàn suǒzài.',
      example_vi = 'Nắm vững phương pháp học tập khoa học chính là then chốt để nâng cao trình độ tiếng Trung.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '掌握科学的学习方法是提高汉语水平的关键所在。', 'Zhǎngwò kēxué de xuéxí fāngfǎ shì tígāo Hànyǔ shuǐpíng de guānjiàn suǒzài.', 'Nắm vững phương pháp học tập khoa học chính là then chốt để nâng cao trình độ tiếng Trung.', 'basic', 1),
        (v_id, '在决定企业未来生存走向的关键时刻，管理团队果断做出了剥离低效传统资产的战略抉择。', 'Zài juédìng qǐyè wèilái shēngcún zǒuxiàng de guānjiàn shíkè, guǎnlǐ tuánduì guǒduàn zuò chū le bōlí dīxiào chuántǒng zīchǎn de zhànlüè juézé.', 'Ở thời khắc mấu chốt quyết định hướng đi sinh tồn tương lai của doanh nghiệp, ban điều hành đã dứt khoát đưa ra quyết sách chiến lược thoái vốn khỏi các tài sản truyền thống kém hiệu quả.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [观看] (guānkàn) - xem, theo dõi, quan sát [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '观看' AND pinyin = 'guānkàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '观看'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'guānkàn',
      meaning_vi = 'xem, theo dõi, quan sát',
      example_hanzi = '昨晚全家人围坐在客厅的电视机前观看精彩的足球比赛。',
      example_pinyin = 'Zuówǎn quán jiā rén wéizuò zài kètīng de diànshìjī qián guānkàn jīngcǎi de zúqiú bǐsài.',
      example_vi = 'Tối qua cả gia đình quây quần ngồi trước màn hình tivi phòng khách theo dõi trận bóng đá đặc sắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昨晚全家人围坐在客厅的电视机前观看精彩的足球比赛。', 'Zuówǎn quán jiā rén wéizuò zài kètīng de diànshìjī qián guānkàn jīngcǎi de zúqiú bǐsài.', 'Tối qua cả gia đình quây quần ngồi trước màn hình tivi phòng khách theo dõi trận bóng đá đặc sắc.', 'basic', 1),
        (v_id, '数以亿计的全球观众通过高清网络直播同步观看了国际冬季奥运会盛大的开幕式。', 'Shù yǐ yì jì de quánqiú guānzhòng tōngguò gāoqīng wǎngluò zhībō tóngbù guānkàn le guójì Dōngjì Àoyùnhuì shèngdà de kāimùshì.', 'Hàng trăm triệu khán giả trên toàn cầu đã đồng thời xem lễ khai mạc hoành tráng của Thế vận hội Mùa đông quốc tế qua phát sóng trực tiếp trực tuyến độ nét cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [观众] (guānzhòng) - khán giả, người xem [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '观众' AND pinyin = 'guānzhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '观众'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'guānzhòng',
      meaning_vi = 'khán giả, người xem',
      example_hanzi = '精彩的话剧表演结束后，台下的观众爆发出热烈的掌声。',
      example_pinyin = 'Jīngcǎi de huàjù biǎoyǎn jiéshù hòu, tái xià de guānzhòng bàofā chū rèliè de zhǎngshēng.',
      example_vi = 'Sau khi buổi biểu diễn kịch nói đặc sắc khép lại, khán giả dưới khán phòng đã bùng nổ những tràng pháo tay nhiệt liệt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '精彩的话剧表演结束后，台下的观众爆发出热烈的掌声。', 'Jīngcǎi de huàjù biǎoyǎn jiéshù hòu, tái xià de guānzhòng bàofā chū rèliè de zhǎngshēng.', 'Sau khi buổi biểu diễn kịch nói đặc sắc khép lại, khán giả dưới khán phòng đã bùng nổ những tràng pháo tay nhiệt liệt.', 'basic', 1),
        (v_id, '这部电影凭借深邃深刻的人文关怀与出色的视听特效，赢得了专业影评人与普通观众的一致赞誉。', 'Zhè bù diànyǐng píngjiè shēnsuì shēnkè de rénwén guānhuái yǔ chūsè de shìtīng tèxiào, yíngdé le zhuānyè yǐngpíngrén yǔ pǔtōng guānzhòng de yízhì zànyù.', 'Bộ phim này nhờ vào sự quan tâm nhân văn sâu sắc cùng hiệu ứng nghe nhìn xuất sắc đã giành được lời ngợi khen đồng thuận từ giới phê bình phim chuyên nghiệp lẫn khán giả đại chúng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [管] (guǎn) - quản, quản lý, trông nom; bận tâm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '管' AND pinyin = 'guǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '管'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'guǎn',
      meaning_vi = 'quản, quản lý, trông nom; bận tâm',
      example_hanzi = '李阿姨平时不仅要忙自己的工作，还要负责管家里的生活开支。',
      example_pinyin = 'Lǐ āyí píngshí bùjǐn yào máng zìjǐ de gōngzuò, hái yào fùzé guǎn jiā lǐ de shēnghuó kāizhī.',
      example_vi = 'Dì Lý ngày thường không chỉ bận việc riêng mà còn phải phụ trách quản lý mọi khoản chi tiêu sinh hoạt trong gia đình.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '李阿姨平时不仅要忙自己的工作，还要负责管家里的生活开支。', 'Lǐ āyí píngshí bùjǐn yào máng zìjǐ de gōngzuò, hái yào fùzé guǎn jiā lǐ de shēnghuó kāizhī.', 'Dì Lý ngày thường không chỉ bận việc riêng mà còn phải phụ trách quản lý mọi khoản chi tiêu sinh hoạt trong gia đình.', 'basic', 1),
        (v_id, '作为资深项目总监，他不仅管整个研发团队的日常工作，更要对交付成果的质量全权把关。', 'Zuòwéi zīshēn xiàngmù zǒngjiān, tā bùjǐn guǎn zhěnggè yánfā tuánduì de rìcháng gōngzuò, gèng yào duì jiāofù chéngguǒ de zhìliàng quánquán bǎguān.', 'Với tư cách là giám đốc dự án kỳ cựu, anh ấy không chỉ quản lý công việc hàng ngày của toàn bộ đội ngũ R&D, mà còn toàn quyền kiểm soát gác cổng chất lượng cho thành quả bàn giao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [管理] (guǎnlǐ) - quản lý; ban quản trị [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '管理' AND pinyin = 'guǎnlǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '管理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'guǎnlǐ',
      meaning_vi = 'quản lý; ban quản trị',
      example_hanzi = '她在大学里攻读的是工商企业管理专业。',
      example_pinyin = 'Tā zài dàxué lǐ gōngdú de shì gōngshāng qǐyè guǎnlǐ zhuānyè.',
      example_vi = 'Ở trường đại học, cô ấy theo học chuyên ngành Quản trị kinh doanh doanh nghiệp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '她在大学里攻读的是工商企业管理专业。', 'Tā zài dàxué lǐ gōngdú de shì gōngshāng qǐyè guǎnlǐ zhuānyè.', 'Ở trường đại học, cô ấy theo học chuyên ngành Quản trị kinh doanh doanh nghiệp.', 'basic', 1),
        (v_id, '现代企业应当引入精益管理理念，通过数字化流程优化全面消除各个环节的资源浪费。', 'Xiàndài qǐyè yīngdāng yǐnrù jīngyì guǎnlǐ lǐniàn, tōngguò shùzìhuà liúchéng yōuhuà quánmiàn xiāochú gègè huánjié de zīyuán làngfèi.', 'Doanh nghiệp hiện đại cần đưa vào triết lý quản lý tinh gọn (lean management), thông qua tối ưu hóa quy trình số hóa để xóa bỏ triệt để sự lãng phí tài nguyên ở mọi mắt xích.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [光] (guāng) - ánh sáng; chỉ, riêng; hết sạch; trọc [Danh từ / Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '光' AND pinyin = 'guāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '光'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phó từ / Tính từ',
      pinyin = 'guāng',
      meaning_vi = 'ánh sáng; chỉ, riêng; hết sạch; trọc',
      example_hanzi = '清晨温暖柔和的阳光洒在绿色的草坪上。',
      example_pinyin = 'Qīngchén wēnnuǎn róuhé de yángguāng sǎ zài lǜsè de cǎopíng shang.',
      example_vi = 'Ánh nắng ban mai ấm áp dịu dàng rải trên thảm cỏ xanh mướt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清晨温暖柔和的阳光洒在绿色的草坪上。', 'Qīngchén wēnnuǎn róuhé de yángguāng sǎ zài lǜsè de cǎopíng shang.', 'Ánh nắng ban mai ấm áp dịu dàng rải trên thảm cỏ xanh mướt.', 'basic', 1),
        (v_id, '学好一门外语光靠死记硬背单词是行不通的，必须在真实的语境中高频输入与实践输出。', 'Xué hǎo yì mén wàiyǔ guāng kào sǐjì-yìngbèi dāncí shì xíngbutōng de, bìxū zài zhēnshí de yǔjìng zhōng gāopín shūrù yǔ shíjiàn shūchū.', 'Học giỏi một ngoại ngữ nếu chỉ dựa vào học vẹt từ vựng thì không ăn thua, bắt buộc phải nạp vào liên tục với tần suất cao và thực hành diễn đạt trong ngữ cảnh đời thực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [广播] (guǎngbō) - phát thanh, truyền thanh; đài phát thanh [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '广播' AND pinyin = 'guǎngbō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '广播'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'guǎngbō',
      meaning_vi = 'phát thanh, truyền thanh; đài phát thanh',
      example_hanzi = '车站的大厅里响起了提醒乘客检票上车的中文广播。',
      example_pinyin = 'Chēzhàn de dàtīng lǐ xiǎngqǐ le tíxǐng chéngkè jiǎnpiào shàng chē de Zhōngwén guǎngbō.',
      example_vi = 'Trong đại sảnh nhà ga vang lên tiếng phát thanh bằng tiếng Trung nhắc nhở hành khách soát vé lên tàu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '车站的大厅里响起了提醒乘客检票上车的中文广播。', 'Chēzhàn de dàtīng lǐ xiǎngqǐ le tíxǐng chéngkè jiǎnpiào shàng chē de Zhōngwén guǎngbō.', 'Trong đại sảnh nhà ga vang lên tiếng phát thanh bằng tiếng Trung nhắc nhở hành khách soát vé lên tàu.', 'basic', 1),
        (v_id, '尽管融媒体时代网络资讯极其丰富，但在偏远山区或突发自然灾害时，无线电应急广播依然是最可靠的信息生命线。', 'Jǐnguǎn róngméitǐ shídài wǎngluò zīxùn jíqí fēngfù, dàn zài piānyuǎn shānqū huò tūfā zìrán zāihài shí, wúxiàndiàn yìngjí guǎngbō yīrán shì zuì kěkào de xìnxī shēngmìngxiàn.', 'Dù cho trong thời đại truyền thông tích hợp thông tin trực tuyến vô cùng phong phú, nhưng tại các vùng núi xa xôi hoặc khi xảy ra thiên tai bất ngờ, phát thanh vô tuyến khẩn cấp vẫn là đường dây thông tin huyết mạch đáng tin cậy nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [广告] (guǎnggào) - quảng cáo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '广告' AND pinyin = 'guǎnggào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '广告'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'guǎnggào',
      meaning_vi = 'quảng cáo',
      example_hanzi = '地铁车厢的屏幕上正在循环播放这款新手机的宣传广告。',
      example_pinyin = 'Dìtiě chēxiāng de píngmù shang zhèngzài xúnhuán bōfàng zhè kuǎn xīn shǒujī de xuānchuán guǎnggào.',
      example_vi = 'Trên màn hình toa tàu điện ngầm đang phát lặp lại đoạn quảng cáo tuyên truyền của mẫu điện thoại mới này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '地铁车厢的屏幕上正在循环播放这款新手机的宣传广告。', 'Dìtiě chēxiāng de píngmù shang zhèngzài xúnhuán bōfàng zhè kuǎn xīn shǒujī de xuānchuán guǎnggào.', 'Trên màn hình toa tàu điện ngầm đang phát lặp lại đoạn quảng cáo tuyên truyền của mẫu điện thoại mới này.', 'basic', 1),
        (v_id, '品牌营销团队在各大主流社交媒体平台精准投放数字化广告，使得新品上市当季的曝光量与转化率大幅攀升。', 'Pǐnpái yíngxiāo tuánduì zài gè dà zhǔliú shèjiāo méitǐ píngtái jīngzhǔn tóufàng shùzìhuà guǎnggào, shǐde xīnpǐn shàngshì dāngjì de bàoguāngliàng yǔ zhuǎnhuàlǜ dàfú pānshēng.', 'Đội ngũ tiếp thị thương hiệu đã đặt quảng cáo số hóa chính xác trên các nền tảng mạng xã hội chủ lưu, giúp lượng hiển thị và tỷ lệ chuyển đổi của sản phẩm mới trong quý ra mắt tăng vọt đáng kể.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [逛] (guàng) - dạo, đi dạo, lượn phố, dạo chơi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '逛' AND pinyin = 'guàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '逛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'guàng',
      meaning_vi = 'dạo, đi dạo, lượn phố, dạo chơi',
      example_hanzi = '周末我常常和好朋友一起去公园散步，或者去附近的商场逛逛。',
      example_pinyin = 'Zhōumò wǒ chángcháng hé hǎo péngyou yìqǐ qù gōngyuán sànbù, huòzhě qù fùjìn de shāngchǎng guàngguang.',
      example_vi = 'Cuối tuần tôi thường cùng bạn thân đi dạo công viên, hoặc đến trung tâm thương mại gần đó dạo chơi mua sắm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末我常常和好朋友一起去公园散步，或者去附近的商场逛逛。', 'Zhōumò wǒ chángcháng hé hǎo péngyou yìqǐ qù gōngyuán sànbù, huòzhě qù fùjìn de shāngchǎng guàngguang.', 'Cuối tuần tôi thường cùng bạn thân đi dạo công viên, hoặc đến trung tâm thương mại gần đó dạo chơi mua sắm.', 'basic', 1),
        (v_id, '漫步在具有数百年历史的古老水乡小镇，游客们悠闲地逛着青石板街两旁琳琅满目的手工艺品小店。', 'Mànbù zài jùyǒu shù bǎi nián lìshǐ de gǔlǎo shuǐxiāng xiǎozhèn, yóukèmen yōuxián de guàng zhe qīngshíbǎn jiē liǎngpáng línláng-mǎnmù de shǒugōngyìpǐn xiǎodiàn.', 'Rảo bước trên thị trấn sông nước cổ kính có lịch sử hàng trăm năm, du khách thong thả dạo ngắm những cửa tiệm thủ công mỹ nghệ phong phú đa dạng ở hai bên con phố lát đá xanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [规定] (guīdìng) - quy định; đặt ra quy định [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '规定' AND pinyin = 'guīdìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '规定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'guīdìng',
      meaning_vi = 'quy định; đặt ra quy định',
      example_hanzi = '图书馆明文规定馆内严禁吸烟和大声喧哗。',
      example_pinyin = 'Túshūguǎn míngwén guīdìng guǎn nèi yánjìn xīyān hé dàshēng xuānhuá.',
      example_vi = 'Thư viện quy định rõ bằng văn bản nghiêm cấm hút thuốc và làm ồn lớn tiếng trong khuôn viên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '图书馆明文规定馆内严禁吸烟和大声喧哗。', 'Túshūguǎn míngwén guīdìng guǎn nèi yánjìn xīyān hé dàshēng xuānhuá.', 'Thư viện quy định rõ bằng văn bản nghiêm cấm hút thuốc và làm ồn lớn tiếng trong khuôn viên.', 'basic', 1),
        (v_id, '依据最新出台的网络数据安全管理规定，所有互联网科技企业必须严格保护消费者的个人敏感隐私信息。', 'Yījù zuìxīn chūtái de wǎngluò shùjù ānquán guǎnlǐ guīdìng, suǒyǒu hùliánwǎng kējì qǐyè bìxū yángé bǎohù xiāofèizhě de gèrén mǐngǎn yǐnsī xìnxī.', 'Căn cứ theo quy định quản lý an toàn dữ liệu mạng mới ban hành, tất cả doanh nghiệp công nghệ internet phải bảo vệ nghiêm ngặt thông tin đời tư nhạy cảm của người tiêu dùng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [国籍] (guójí) - quốc tịch [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '国籍' AND pinyin = 'guójí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '国籍'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'guójí',
      meaning_vi = 'quốc tịch',
      example_hanzi = '填写入境登记卡的时候，请务必准确写明自己的姓名和国籍。',
      example_pinyin = 'Tiánxiě rùjìng dēngjìkǎ de shíhou, qǐng wùbì zhǔnquè xiěmíng zìjǐ de xìngmíng hé guójí.',
      example_vi = 'Khi điền vào tờ khai nhập cảnh, xin quý vị hãy ghi rõ chính xác họ tên và quốc tịch của mình.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '填写入境登记卡的时候，请务必准确写明自己的姓名和国籍。', 'Tiánxiě rùjìng dēngjìkǎ de shíhou, qǐng wùbì zhǔnquè xiěmíng zìjǐ de xìngmíng hé guójí.', 'Khi điền vào tờ khai nhập cảnh, xin quý vị hãy ghi rõ chính xác họ tên và quốc tịch của mình.', 'basic', 1),
        (v_id, '在这所著名国际学校里，师生来自三十多个不同的国籍，多元文化在此交流互鉴融合共生。', 'Zài zhè suǒ zhùmíng guójì xuéxiào lǐ, shīshēng láizì sānshí duō gè bùtóng de guójí, duōyuán wénhuà zài cǐ jiāoliú hùjiàn rónghé gòngshēng.', 'Tại ngôi trường quốc tế danh tiếng này, thầy trò đến từ hơn 30 quốc tịch khác nhau, các nền văn hóa đa dạng tại đây giao lưu học hỏi và hòa quyện cùng phát triển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [国际] (guójì) - quốc tế [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '国际' AND pinyin = 'guójì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '国际'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'guójì',
      meaning_vi = 'quốc tế',
      example_hanzi = '北京首都国际机场每天起降数百架次往返世界各地的航班。',
      example_pinyin = 'Běijīng Shǒudū Guójì Jīchǎng měitiān qǐjiàng shù bǎi jiàcì wǎngfǎn shìjiè gèdì de hángbān.',
      example_vi = 'Sân bay Quốc tế Thủ đô Bắc Kinh mỗi ngày có hàng trăm lượt chuyến bay cất hạ cánh đi và đến khắp nơi trên thế giới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '北京首都国际机场每天起降数百架次往返世界各地的航班。', 'Běijīng Shǒudū Guójì Jīchǎng měitiān qǐjiàng shù bǎi jiàcì wǎngfǎn shìjiè gèdì de hángbān.', 'Sân bay Quốc tế Thủ đô Bắc Kinh mỗi ngày có hàng trăm lượt chuyến bay cất hạ cánh đi và đến khắp nơi trên thế giới.', 'basic', 1),
        (v_id, '中国积极推动构建人类命运共同体，并在维护多边贸易体制与应对全球气候变化中发挥着负责任的国际大国作用。', 'Zhōngguó jījí tuīdòng gòujiàn rénlèi mìngyùn gòngtóngtǐ, bìng zài wéihù duōbiān màoyì tǐzhì yǔ yìngduì quánqiú qìhòu biànhuà zhōng fāhuī zhe fùzérèn de guójì dàguó zuòyòng.', 'Trung Quốc tích cực thúc đẩy xây dựng cộng đồng chung vận mệnh nhân loại, và phát huy vai trò nước lớn quốc tế có trách nhiệm trong việc duy trì thể chế thương mại đa phương và ứng phó với biến đổi khí hậu toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [果汁] (guǒzhī) - nước ép trái cây, nước hoa quả [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '果汁' AND pinyin = 'guǒzhī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '果汁'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'guǒzhī',
      meaning_vi = 'nước ép trái cây, nước hoa quả',
      example_hanzi = '夏天喝一杯冰镇鲜榨橙子果汁，感觉非常清凉解渴。',
      example_pinyin = 'Xiàtiān hē yì bēi bīngzhèn xiānzhà chéngzi guǒzhī, gǎnjué fēicháng qīngliáng jiěkě.',
      example_vi = 'Mùa hè uống một ly nước ép cam tươi ướp lạnh, cảm thấy vô cùng thanh mát đã khát.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夏天喝一杯冰镇鲜榨橙子果汁，感觉非常清凉解渴。', 'Xiàtiān hē yì bēi bīngzhèn xiānzhà chéngzi guǒzhī, gǎnjué fēicháng qīngliáng jiěkě.', 'Mùa hè uống một ly nước ép cam tươi ướp lạnh, cảm thấy vô cùng thanh mát đã khát.', 'basic', 1),
        (v_id, '随着当代公众健康养生意识的不断增强，不添加任何人工糖分与防腐剂的百分之百纯鲜果汁在市场上越来越受青睐。', 'Suízhe dāngdài gōngzhòng jiànkāng yǎngshēng yìshí de bùduàn zēngqiáng, bù tiānjiā rènhé réngōng tángfèn yǔ fángfǔjì de bǎifēnzhībǎi chún xiān guǒzhī zài shìchǎng shang yuèláiyuè shòu qīnglài.', 'Cùng với ý thức dưỡng sinh chăm sóc sức khỏe của công chúng đương đại ngày càng nâng cao, nước ép hoa quả tươi nguyên chất 100% không chứa đường nhân tạo và chất bảo quản ngày càng được ưa chuộng trên thị trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [过程] (guòchéng) - quá trình, tiến trình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '过程' AND pinyin = 'guòchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '过程'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'guòchéng',
      meaning_vi = 'quá trình, tiến trình',
      example_hanzi = '学习语言是一个需要持之以恒、循序渐进的长期过程。',
      example_pinyin = 'Xuéxí yǔyán shì yí gè xūyào chízhīyǐhéng, xúnxù-jiànjìn de chángqī guòchéng.',
      example_vi = 'Học tập ngôn ngữ là một quá trình lâu dài đòi hỏi phải kiên trì bền bỉ và tuần tự từng bước một.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学习语言是一个需要持之以恒、循序渐进的长期过程。', 'Xuéxí yǔyán shì yí gè xūyào chízhīyǐhéng, xúnxù-jiànjìn de chángqī guòchéng.', 'Học tập ngôn ngữ là một quá trình lâu dài đòi hỏi phải kiên trì bền bỉ và tuần tự từng bước một.', 'basic', 1),
        (v_id, '在重大工程项目的研发全过程中，项目经理必须对每一个关键节点的测试验收数据实施严格全流程质量监控。', 'Zài zhòngdà gōngchéng xiàngmù de yánfā quán guòchéng zhōng, xiàngmù jīnglǐ bìxū duì měi yí gè guānjiàn jiédiǎn de cèshì yànshōu shùjù shíshī yángé quán liúchéng zhìliàng jiānkòng.', 'Trong toàn bộ quá trình nghiên cứu phát triển dự án công trình trọng điểm, giám đốc dự án phải thực thi giám sát chất lượng toàn quy trình chặt chẽ đối với số liệu nghiệm thu kiểm thử tại từng mắt xích then chốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [海洋] (hǎiyáng) - đại dương, biển cả [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '海洋' AND pinyin = 'hǎiyáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '海洋'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hǎiyáng',
      meaning_vi = 'đại dương, biển cả',
      example_hanzi = '辽阔深邃的海洋里生活着成千上万种神奇的动植物。',
      example_pinyin = 'Liáokuò shēnsuì de hǎiyáng lǐ shēnghuó zhe chéngqiān-shàngwàn zhǒng shénqí de dòngzhíwù.',
      example_vi = 'Nơi đại dương mênh mông sâu thẳm có hàng vạn loài động thực vật kỳ diệu sinh sống.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '辽阔深邃的海洋里生活着成千上万种神奇的动植物。', 'Liáokuò shēnsuì de hǎiyáng lǐ shēnghuó zhe chéngqiān-shàngwàn zhǒng shénqí de dòngzhíwù.', 'Nơi đại dương mênh mông sâu thẳm có hàng vạn loài động thực vật kỳ diệu sinh sống.', 'basic', 1),
        (v_id, '国际社会呼吁各国通力协作减少塑料垃圾入海排放，切实保护珍贵脆弱的海洋生态环境与生物多样性。', 'Guójì shèhuì hūyù gè guó tōnglì xiézuò jiǎnshǎo sùliào lājī rù hǎi páifàng, qièshí bǎohù zhēnguì cuìruò de hǎiyáng shēngtài huánjìng yǔ shēngwù duōyàngxìng.', 'Cộng đồng quốc tế kêu gọi các nước chung tay hợp tác giảm xả rác thải nhựa ra biển, bảo vệ thiết thực môi trường sinh thái đại dương và sự đa dạng sinh học vô cùng quý giá và mong manh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [害羞] (hàixiū) - ngại ngùng, thẹn thùng, e thẹn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '害羞' AND pinyin = 'hàixiū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '害羞'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'hàixiū',
      meaning_vi = 'ngại ngùng, thẹn thùng, e thẹn',
      example_hanzi = '小女孩一见到生人就有些害羞，悄悄躲到了妈妈的身后。',
      example_pinyin = 'Xiǎo nǚhái yí jiàn dào shēngrén jiù yǒuxiē hàixiū, qiāoqiāo duǒ dào le māma de shēnhòu.',
      example_vi = 'Bé gái hễ gặp người lạ là có phần thẹn thùng, khẽ nép mình trốn sau lưng mẹ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小女孩一见到生人就有些害羞，悄悄躲到了妈妈的身后。', 'Xiǎo nǚhái yí jiàn dào shēngrén jiù yǒuxiē hàixiū, qiāoqiāo duǒ dào le māma de shēnhòu.', 'Bé gái hễ gặp người lạ là có phần thẹn thùng, khẽ nép mình trốn sau lưng mẹ.', 'basic', 1),
        (v_id, '在跨文化商务沟通场合，初入职场的新人应当克服害羞畏缩的心理，自信大方地展示个人专业见解。', 'Zài kuà-wénhuà shāngwù gōutōng chǎnghé, chū rù zhíchǎng de xīnrén yīngdāng kèfú hàixiū wèisuō de xīnlǐ, zìxìn dàfāng de zhǎnshì gèrén zhuānyè jiànjiě.', 'Trong các dịp giao tiếp thương mại đa văn hóa, người mới bước chân vào chốn công sở nên khắc phục tâm lý ngại ngùng rụt rè, tự tin đĩnh đạc thể hiện kiến giải chuyên môn của bản thân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [寒假] (hánjià) - kỳ nghỉ đông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '寒假' AND pinyin = 'hánjià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '寒假'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hánjià',
      meaning_vi = 'kỳ nghỉ đông',
      example_hanzi = '今年寒假我打算去北方著名的冰城哈尔滨看冰雕展览。',
      example_pinyin = 'Jīnnián hánjià wǒ dǎsuàn qù běifāng zhùmíng de bīngchéng Hā’ěrbīn kàn bīngdiāo zhǎnlǎn.',
      example_vi = 'Kỳ nghỉ đông năm nay tôi dự định đi thành phố băng Cáp Nhĩ Tân nổi tiếng ở phương Bắc để xem triển lãm điêu khắc băng tuyết.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今年寒假我打算去北方著名的冰城哈尔滨看冰雕展览。', 'Jīnnián hánjià wǒ dǎsuàn qù běifāng zhùmíng de bīngchéng Hā’ěrbīn kàn bīngdiāo zhǎnlǎn.', 'Kỳ nghỉ đông năm nay tôi dự định đi thành phố băng Cáp Nhĩ Tân nổi tiếng ở phương Bắc để xem triển lãm điêu khắc băng tuyết.', 'basic', 1),
        (v_id, '许多大学生选择在充实的寒假期间前往知名企业参与专业实习，以此积累宝贵的行业职场实践经验。', 'Xǔduō dàxuésheng xuǎnzé zài chōngshí de hánjià qījiān qiánwǎng zhìmíng qǐyè cānyù zhuānyè shíxí, yǐ cǐ jīlěi bǎoguì de hángyè zhíchǎng shíjiàn jīngyàn.', 'Nhiều sinh viên đại học lựa chọn đến các doanh nghiệp nổi tiếng tham gia thực tập chuyên ngành trong kỳ nghỉ đông bổ ích, nhằm tích lũy kinh nghiệm thực tế quý báu nơi thương trường công sở.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [寒冷] (hánlěng) - lạnh giá, rét buốt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '寒冷' AND pinyin = 'hánlěng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '寒冷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'hánlěng',
      meaning_vi = 'lạnh giá, rét buốt',
      example_hanzi = '冬天的早晨非常寒冷，河面上已经结了一层厚厚的冰。',
      example_pinyin = 'Dōngtiān de zǎochén fēicháng hánlěng, hémiàn shang yǐjīng jié le yì céng hòuhòu de bīng.',
      example_vi = 'Buổi sáng mùa đông vô cùng lạnh giá, trên mặt sông đã đóng một lớp băng dày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '冬天的早晨非常寒冷，河面上已经结了一层厚厚的冰。', 'Dōngtiān de zǎochén fēicháng hánlěng, hémiàn shang yǐjīng jié le yì céng hòuhòu de bīng.', 'Buổi sáng mùa đông vô cùng lạnh giá, trên mặt sông đã đóng một lớp băng dày.', 'basic', 1),
        (v_id, '在常年极度寒冷的极地科学考察站，科研人员凭借坚韧不拔的钢铁毅力开展了一系列前沿科学探测。', 'Zài chángnián jídù hánlěng de jídì kēxué kǎocházhàn, kēyán rényuán píngjiè jiānrèn-bùbá de gāngtiě yìlì kāizhǎn le yí xìliè qiányán kēxué tàncè.', 'Tại trạm khảo sát khoa học vùng cực quanh năm cực kỳ rét buốt, các nhà nghiên cứu khoa học nhờ vào ý chí gang thép kiên cường bất khuất đã triển khai một loạt thăm dò khoa học tiên phong.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [喊] (hǎn) - hét, la to, gọi to [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '喊' AND pinyin = 'hǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '喊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'hǎn',
      meaning_vi = 'hét, la to, gọi to',
      example_hanzi = '球场上的观众大声为自己支持的球队加油呐喊。',
      example_pinyin = 'Qiúchǎng shang de guānzhòng dàshēng wèi zìjǐ zhīchí de qiúduì jiāyóu nàhǎn.',
      example_vi = 'Khán giả trên sân vận động lớn tiếng hô to hò reo cổ vũ cho đội bóng mà mình ủng hộ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '球场上的观众大声为自己支持的球队加油呐喊。', 'Qiúchǎng shang de guānzhòng dàshēng wèi zìjǐ zhīchí de qiúduì jiāyóu nàhǎn.', 'Khán giả trên sân vận động lớn tiếng hô to hò reo cổ vũ cho đội bóng mà mình ủng hộ.', 'basic', 1),
        (v_id, '在喧闹嘈杂的火灾救援现场，消防指挥员拿着扩音喇叭大声喊着疏散指令，引导被困群众有序安全撤离。', 'Zài xuānnào cáozá de huǒzāi jiùyuán xiànchǎng, xiāofáng zhǐhuīyuán názhe kuòyīn lǎba dàshēng hǎn zhe shūsàn zhǐlìng, yǐndǎo bèikùn qúnzhòng yǒuxù ānquán chèlí.', 'Tại hiện trường cứu nạn hỏa hoạn ồn ào hỗn loạn, người chỉ huy phòng cháy cầm loa phóng thanh hét lớn các mệnh lệnh sơ tán, hướng dẫn người dân bị kẹt rút lui an toàn có trật tự.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [汗] (hàn) - mồ hôi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '汗' AND pinyin = 'hàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '汗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hàn',
      meaning_vi = 'mồ hôi',
      example_hanzi = '在炎热的太阳底下跑步跑了半小时，他浑身都出了大汗。',
      example_pinyin = 'Zài yánrè de tàiyáng dǐxià pǎobù pǎo le bàn xiǎoshí, tā húnshēn dōu chū le dà hàn.',
      example_vi = 'Chạy bộ dưới ánh mặt trời gay gắt suốt nửa tiếng đồng hồ, khắp người anh ấy toát đầy mồ hôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在炎热的太阳底下跑步跑了半小时，他浑身都出了大汗。', 'Zài yánrè de tàiyáng dǐxià pǎobù pǎo le bàn xiǎoshí, tā húnshēn dōu chū le dà hàn.', 'Chạy bộ dưới ánh mặt trời gay gắt suốt nửa tiếng đồng hồ, khắp người anh ấy toát đầy mồ hôi.', 'basic', 1),
        (v_id, '每一座拔地而起的现代化宏伟建筑，无不凝结着千千万万普通一线建设者辛勤耕耘的辛劳汗水与智慧心血。', 'Měi yí zuò bádì’érqǐ de xiàndàihuà hóngwěi jiànzhù, wúbù níngjié zhe qiānqiān-wànwàn pǔtōng yīxiàn jiànshèzhě xīnqín gēngyún de xīnláo hànshuǐ yǔ zhìhuì xīnxuè.', 'Mỗi công trình kiến trúc hiện đại nguy nga mọc lên từ mặt đất, không nơi nào là không kết tinh từ những giọt mồ hôi lao khổ và tâm huyết trí tuệ miệt mài của muôn vàn người thợ xây dựng tuyến đầu bình dị.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [航班] (hángbān) - chuyến bay [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '航班' AND pinyin = 'hángbān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '航班'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hángbān',
      meaning_vi = 'chuyến bay',
      example_hanzi = '请旅客朋友们注意，飞往上海的CA1835次航班现在开始登机了。',
      example_pinyin = 'Qǐng lǚkè péngyoumen zhùyì, fēi wǎng Shànghǎi de CA1835 cì hángbān xiànzài kāishǐ dēngjī le.',
      example_vi = 'Xin quý hành khách chú ý, chuyến bay số hiệu CA1835 bay tới Thượng Hải hiện tại bắt đầu lên máy bay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请旅客朋友们注意，飞往上海的CA1835次航班现在开始登机了。', 'Qǐng lǚkè péngyoumen zhùyì, fēi wǎng Shànghǎi de CA1835 cì hángbān xiànzài kāishǐ dēngjī le.', 'Xin quý hành khách chú ý, chuyến bay số hiệu CA1835 bay tới Thượng Hải hiện tại bắt đầu lên máy bay.', 'basic', 1),
        (v_id, '由于目的地机场出现突发强雷暴极端恶劣天气，航空公司不得不临时取消或推迟部分国际客运航班。', 'Yóuyú mùdìdì jīchǎng chūxiàn tūfā qiáng léibào jíduān èliè tiānqì, hángkōng gōngsī bùdébù línshí qǔxiāo huò tuīchí bùfen guójì kèyùn hángbān.', 'Do sân bay điểm đến bất ngờ xuất hiện thời tiết cực đoan giông bão mạnh, hãng hàng không buộc phải tạm thời hủy hoặc lùi giờ một số chuyến bay chở khách quốc tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [好处] (hǎochù) - lợi ích, điểm tốt, điểm có lợi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '好处' AND pinyin = 'hǎochù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '好处'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hǎochù',
      meaning_vi = 'lợi ích, điểm tốt, điểm có lợi',
      example_hanzi = '养成早睡早起的好习惯对身体健康有极大的好处。',
      example_pinyin = 'Yǎngchéng zǎoshuì-zǎoqǐ de hǎo xíguàn duì shēntǐ jiànkāng yǒu jídà de hǎochù.',
      example_vi = 'Rèn luyện thói quen tốt ngủ sớm dậy sớm có lợi ích vô cùng to lớn đối với sức khỏe thể chất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '养成早睡早起的好习惯对身体健康有极大的好处。', 'Yǎngchéng zǎoshuì-zǎoqǐ de hǎo xíguàn duì shēntǐ jiànkāng yǒu jídà de hǎochù.', 'Rèn luyện thói quen tốt ngủ sớm dậy sớm có lợi ích vô cùng to lớn đối với sức khỏe thể chất.', 'basic', 1),
        (v_id, '引入全自动化现代智能流水线，不仅能大幅降低企业的人力用工成本，更长远的好处在于全面提升产品良品率与质量稳定性。', 'Yǐnrù quán zìdònghuà xiàndài zhìnéng liúshuǐxiàn, bùjǐn néng dàfú jiàngdī qǐyè de rénlì yònggōng chéngběn, gèng chángyuǎn de hǎochù zàiyú quánmiàn tíshēng chǎnpǐn liángpǐnlǜ yǔ zhìliàng wěndìngxìng.', 'Đưa vào dây chuyền thông minh hiện đại hoàn toàn tự động không chỉ cắt giảm đáng kể chi phí nhân công của doanh nghiệp, mà điểm có lợi lâu dài hơn là nâng cao toàn diện tỷ lệ đạt chuẩn của sản phẩm và độ ổn định chất lượng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [好好] (hǎohǎo) - tử tế, cẩn thận, chu đáo, hết mình (làm tốt) [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '好好' AND pinyin = 'hǎohǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '好好'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Tính từ',
      pinyin = 'hǎohǎo',
      meaning_vi = 'tử tế, cẩn thận, chu đáo, hết mình (làm tốt)',
      example_hanzi = '周末你辛苦工作了一周，应该在家里好好休息放松一下。',
      example_pinyin = 'Zhōumò nǐ xīnkǔ gōngzuò le yì zhōu, yīnggāi zài jiā lǐ hǎohǎo xiūxi fàngsōng yíxià.',
      example_vi = 'Cuối tuần bạn đã làm việc vất vả suốt cả tuần, nên ở nhà nghỉ ngơi thư giãn thật tử tế một chút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末你辛苦工作了一周，应该在家里好好休息放松一下。', 'Zhōumò nǐ xīnkǔ gōngzuò le yì zhōu, yīnggāi zài jiā lǐ hǎohǎo xiūxi fàngsōng yíxià.', 'Cuối tuần bạn đã làm việc vất vả suốt cả tuần, nên ở nhà nghỉ ngơi thư giãn thật tử tế một chút.', 'basic', 1),
        (v_id, '在正式向投资人路演之前，创业团队应当好好梳理商业计划书中的核心商业模式与财务预测数据。', 'Zài zhèngshì xiàng tóuzīrén lùyǎn zhīqián, chuàngyè tuánduì yīngdāng hǎohǎo shūlǐ shāngyè jìhuàshū zhōng de héxīn shāngyè móshì yǔ cáiwù yùcè shùjù.', 'Trước khi chính thức thuyết trình gọi vốn trước các nhà đầu tư, nhóm khởi nghiệp nên rà soát thật kỹ lưỡng mô hình kinh doanh cốt lõi và số liệu dự báo tài chính trong bản kế hoạch kinh doanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [好笑] (hǎoxiào) - buồn cười, nực cười, hài hước [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '好笑' AND pinyin = 'hǎoxiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '好笑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'hǎoxiào',
      meaning_vi = 'buồn cười, nực cười, hài hước',
      example_hanzi = '他刚才讲的那个幽默笑话实在太好笑了，把全班同学都逗乐了。',
      example_pinyin = 'Tā gāngcái jiǎng de nà gè yōumò xiàohua shízài tài hǎoxiào le, bǎ quán bān tóngxué dōu dòulè le.',
      example_vi = 'Câu chuyện cười hài hước anh ấy vừa kể thực sự quá buồn cười, khiến cả lớp ai nấy đều bật cười khoái chí.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他刚才讲的那个幽默笑话实在太好笑了，把全班同学都逗乐了。', 'Tā gāngcái jiǎng de nà gè yōumò xiàohua shízài tài hǎoxiào le, bǎ quán bān tóngxué dōu dòulè le.', 'Câu chuyện cười hài hước anh ấy vừa kể thực sự quá buồn cười, khiến cả lớp ai nấy đều bật cười khoái chí.', 'basic', 1),
        (v_id, '这部喜剧电影通过一系列荒诞好笑的情节反差，深刻讽刺了现实生活中盲目跟风与虚荣浮夸的社会现象。', 'Zhè bù xǐjù diànyǐng tōngguò yí xìliè huāngdàn hǎoxiào de qíngjié fǎnchà, shēnkè fěngcì le xiànshí shēnghuó zhōng mángmù gēnfēng yǔ xūróng fúkuā de shèhuì xiànxiàng.', 'Bộ phim hài kịch này thông qua một loạt tình tiết tương phản hoang đường buồn cười đã châm biếm sâu cay hiện tượng xã hội a dua mù quáng và khoe khoang phù phiếm trong đời sống thực tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [合格] (hégé) - đạt chuẩn, hợp cách, đủ tiêu chuẩn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '合格' AND pinyin = 'hégé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '合格'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'hégé',
      meaning_vi = 'đạt chuẩn, hợp cách, đủ tiêu chuẩn',
      example_hanzi = '经过三个月的岗前培训与考核，他终于成为了一名合格的软件工程师。',
      example_pinyin = 'Jīngguò sān gè yuè de gǎngqián péixùn yǔ kǎohé, tā zhōngyú chéngwéi le yì míng hégé de ruǎnjiàn gōngchéngshī.',
      example_vi = 'Trải qua ba tháng đào tạo tiền công tác và sát hạch, cuối cùng anh ấy đã trở thành một kỹ sư phần mềm đạt chuẩn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过三个月的岗前培训与考核，他终于成为了一名合格的软件工程师。', 'Jīngguò sān gè yuè de gǎngqián péixùn yǔ kǎohé, tā zhōngyú chéngwéi le yì míng hégé de ruǎnjiàn gōngchéngshī.', 'Trải qua ba tháng đào tạo tiền công tác và sát hạch, cuối cùng anh ấy đã trở thành một kỹ sư phần mềm đạt chuẩn.', 'basic', 1),
        (v_id, '出厂检验部门严格把控产品品质，任何未达到国家安全卫生标准的不合格产品一律严禁流入消费市场。', 'Chūchǎng jiǎnyàn bùmén yángé bǎkòng chǎnpǐn pǐnzhì, rènhé wèi dádào guójiā ānquán wèishēng biāozhǔn de bù hégé chǎnpǐn yílǜ yánjìn liúrù xiāofèi shìchǎng.', 'Bộ phận kiểm nghiệm xuất xưởng kiểm soát chặt chẽ phẩm chất sản phẩm, bất kỳ sản phẩm không đạt chuẩn nào chưa đáp ứng tiêu chuẩn an toàn vệ sinh quốc gia đều bị nghiêm cấm tuồn ra thị trường tiêu dùng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [盒子] (hézi) - cái hộp, chiếc hộp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '盒子' AND pinyin = 'hézi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '盒子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hézi',
      meaning_vi = 'cái hộp, chiếc hộp',
      example_hanzi = '他把精美的项链小心翼翼地放进了一个红色的首饰盒子里。',
      example_pinyin = 'Tā bǎ jīngměi de xiàngliàn xiǎoxīn-yìyì de fàng jìn le yí gè hóngsè de shǒushì hézi lǐ.',
      example_vi = 'Anh ấy cẩn thận từng li từng tí đặt chiếc dây chuyền tinh xảo vào trong một chiếc hộp trang sức màu đỏ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他把精美的项链小心翼翼地放进了一个红色的首饰盒子里。', 'Tā bǎ jīngměi de xiàngliàn xiǎoxīn-yìyì de fàng jìn le yí gè hóngsè de shǒushì hézi lǐ.', 'Anh ấy cẩn thận từng li từng tí đặt chiếc dây chuyền tinh xảo vào trong một chiếc hộp trang sức màu đỏ.', 'basic', 1),
        (v_id, '这家高端糕点品牌特别设计了融入中国传统剪纸艺术元素的精美礼品包装盒子，深受节日送礼市场的欢迎。', 'Zhè jiā gāoduān gāodiǎn pǐnpái tèbié shèjì le róngrù Zhōngguó chuántǒng jiǎnzhǐ yìshù yuánsù de jīngměi lǐpǐn bāozhuāng hézi, shēn shòu jiérì sònglǐ shìchǎng de huānyíng.', 'Thương hiệu bánh ngọt cao cấp này đã đặc biệt thiết kế chiếc hộp bao bì quà tặng tinh xảo lồng ghép các yếu tố nghệ thuật cắt giấy truyền thống Trung Hoa, rất được thị trường quà biếu lễ tết hoan nghênh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [红包] (hóngbāo) - lì xì, phong bao đỏ, tiền mừng tuổi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '红包' AND pinyin = 'hóngbāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '红包'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hóngbāo',
      meaning_vi = 'lì xì, phong bao đỏ, tiền mừng tuổi',
      example_hanzi = '每年除夕夜，长辈们都会给小孩子们发装满压岁钱的红包。',
      example_pinyin = 'Měi nián chúxīyè, zhǎngbèimen dōu huì gěi xiǎoháizimen fā zhuāng mǎn yàsuìqián de hóngbāo.',
      example_vi = 'Vào đêm giao thừa mỗi năm, các bậc trưởng bối đều phát phong bao lì xì đựng đầy tiền mừng tuổi cho con cháu nhỏ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年除夕夜，长辈们都会给小孩子们发装满压岁钱的红包。', 'Měi nián chúxīyè, zhǎngbèimen dōu huì gěi xiǎoháizimen fā zhuāng mǎn yàsuìqián de hóngbāo.', 'Vào đêm giao thừa mỗi năm, các bậc trưởng bối đều phát phong bao lì xì đựng đầy tiền mừng tuổi cho con cháu nhỏ.', 'basic', 1),
        (v_id, '在互联网时代，除夕春晚期间在手机社交软件上抢数字电子红包，已经演变成当代中国家庭极具趣味的新民俗。', 'Zài hùliánwǎng shídài, chúxī chūnwǎn qījiān zài shǒujī shèjiāo ruǎnjiàn shang qiǎng shùzì diànzǐ hóngbāo, yǐjīng yǎnbiàn chéng dāngdài Zhōngguó jiātíng jí jù qùwèi de xīn mínsú.', 'Trong thời đại internet, việc giật bao lì xì điện tử kỹ thuật số trên ứng dụng mạng xã hội điện thoại trong chương trình Gala đêm giao thừa đã phát triển thành một phong tục tập quán mới đầy thú vị của các gia đình Trung Quốc đương đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [厚] (hòu) - dày; sâu đậm (tình cảm) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '厚' AND pinyin = 'hòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '厚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'hòu',
      meaning_vi = 'dày; sâu đậm (tình cảm)',
      example_hanzi = '冬天出门的时候要多穿一件厚外套，注意防寒保暖。',
      example_pinyin = 'Dōngtiān chūmén de shíhou yào duō chuān yí jiàn hòu wàitào, zhùyì fánghán bǎonuǎn.',
      example_vi = 'Mùa đông khi ra ngoài phải mặc thêm một chiếc áo khoác dày, chú ý chống rét giữ ấm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '冬天出门的时候要多穿一件厚外套，注意防寒保暖。', 'Dōngtiān chūmén de shíhou yào duō chuān yí jiàn hòu wàitào, zhùyì fánghán bǎonuǎn.', 'Mùa đông khi ra ngoài phải mặc thêm một chiếc áo khoác dày, chú ý chống rét giữ ấm.', 'basic', 1),
        (v_id, '这本地理学术专著足足有七百多页厚，详尽系统地记录了我国近半个世纪以来地质变迁的第一手珍贵观测数据。', 'Zhè běn dìlǐ xuéshù zhuānzhù zúzú yǒu qī bǎi duō yè hòu, xiángjìn xìtǒng de jìlù le wǒ guó jìn bàn gè shìjì yǐlái dìzhì biànqiān de dì-yī shǒu zhēnguì guāncè shùjù.', 'Cuốn chuyên khảo học thuật địa lý này dày tới hơn 700 trang, ghi chép một cách tường tận có hệ thống những số liệu quan sát quý giá trực tiếp về biến đổi địa chất nước ta trong suốt gần nửa thế kỷ qua.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [后悔] (hòuhuǐ) - hối hận, ân hận [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '后悔' AND pinyin = 'hòuhuǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '后悔'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'hòuhuǐ',
      meaning_vi = 'hối hận, ân hận',
      example_hanzi = '他非常后悔当初没有听从父母和老师的善意劝告。',
      example_pinyin = 'Tā fēicháng hòuhuǐ dāngchū méiyǒu tīngcóng fùmǔ hé lǎoshī de shànyì quàngào.',
      example_vi = 'Anh ấy vô cùng hối hận vì lúc ban đầu đã không nghe theo lời khuyên bảo thiện chí của cha mẹ và thầy cô.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他非常后悔当初没有听从父母和老师的善意劝告。', 'Tā fēicháng hòuhuǐ dāngchū méiyǒu tīngcóng fùmǔ hé lǎoshī de shànyì quàngào.', 'Anh ấy vô cùng hối hận vì lúc ban đầu đã không nghe theo lời khuyên bảo thiện chí của cha mẹ và thầy cô.', 'basic', 1),
        (v_id, '青年人在做重大的职业抉择与人生规划时应当深思熟虑，切忌盲目跟风盲从，免得日后追悔莫及。', 'Qīngniánrén zài zuò zhòngdà de zhíyè juézé yǔ rénshēng guīhuà shí yīngdāng shēnsī-shúlǜ, qièjì mángmù gēnfēng mángcóng, miǎnde rìhòu zhuīhuǐ-mòjí.', 'Người trẻ tuổi khi đưa ra những quyết sách nghề nghiệp và định hướng cuộc đời trọng đại cần suy nghĩ chín chắn thấu đáo, tránh học đòi a dua mù quáng kẻo sau này hối hận không kịp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [忽然] (hūrán) - đột nhiên, bỗng nhiên, bỗng chốc [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '忽然' AND pinyin = 'hūrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '忽然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'hūrán',
      meaning_vi = 'đột nhiên, bỗng nhiên, bỗng chốc',
      example_hanzi = '刚才还是晴空万里，忽然天空中刮起了一阵狂风。',
      example_pinyin = 'Gāngcái hái shì qíngkōng-wànlǐ, hūrán tiānkōng zhōng guā qǐ le yí zhèn kuángfēng.',
      example_vi = 'Mới ban nãy bầu trời còn quang đãng vạn dặm, bỗng nhiên giữa tầng không nổi lên một cơn cuồng phong.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '刚才还是晴空万里，忽然天空中刮起了一阵狂风。', 'Gāngcái hái shì qíngkōng-wànlǐ, hūrán tiānkōng zhōng guā qǐ le yí zhèn kuángfēng.', 'Mới ban nãy bầu trời còn quang đãng vạn dặm, bỗng nhiên giữa tầng không nổi lên một cơn cuồng phong.', 'basic', 1),
        (v_id, '在实验室通宵达旦反复攻关的关键时刻，他脑海中忽然闪现出一个全新算法的灵感，从而一举攻克了核心技术难题。', 'Zài shíyànshì tōngxiāo-dádàn fǎnfù gōngguān de guānjiàn shíkè, tā nǎohǎi zhōng hūrán shǎnxiàn chū yí gè quánxīn suànfǎ de línggǎn, cóng’ér yījǔ gōngkè le héxīn jìshù nántí.', 'Vào thời khắc then chốt thức thâu đêm suốt sáng liên tục đột phá trong phòng thí nghiệm, trong tâm trí anh ấy bỗng lóe lên nguồn cảm hứng về một thuật toán hoàn toàn mới, nhờ đó đánh bại được vấn đề kỹ thuật cốt lõi trong một lần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [互联网] (hùliánwǎng) - internet, mạng internet [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '互联网' AND pinyin = 'hùliánwǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '互联网'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hùliánwǎng',
      meaning_vi = 'internet, mạng internet',
      example_hanzi = '如今人们足不出户就可以通过互联网轻松购物和浏览新闻。',
      example_pinyin = 'Rújīn rénmen zúbùchūhù jiù kěyǐ tōngguò hùliánwǎng qīngsōng gòuwù hé liúlǎn xīnwén.',
      example_vi = 'Ngày nay người ta không cần bước chân ra khỏi cửa là đã có thể dễ dàng mua sắm và đọc tin tức qua mạng internet.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如今人们足不出户就可以通过互联网轻松购物和浏览新闻。', 'Rújīn rénmen zúbùchūhù jiù kěyǐ tōngguò hùliánwǎng qīngsōng gòuwù hé liúlǎn xīnwén.', 'Ngày nay người ta không cần bước chân ra khỏi cửa là đã có thể dễ dàng mua sắm và đọc tin tức qua mạng internet.', 'basic', 1),
        (v_id, '“互联网+”与实体经济的深度融合，正在深刻重塑传统制造业、现代物流业以及金融服务的产业生态模式。', '“Hùliánwǎng jia” yǔ shítǐ jīngjì de shēndù rónghé, zhèngzài shēnkè chóngsù chuántǒng zhìzàoyè, xiàndài wùliúyè yǐjí jīnróng fúwù de chǎnyè shēngtài móshì.', 'Sự kết hợp sâu sắc giữa "Internet+" và nền kinh tế thực đang tái định hình sâu rộng mô hình hệ sinh thái công nghiệp của ngành sản xuất truyền thống, logistics hiện đại cũng như dịch vụ tài chính.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [护士] (hùshi) - y tá, điều dưỡng viên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '护士' AND pinyin = 'hùshi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '护士'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hùshi',
      meaning_vi = 'y tá, điều dưỡng viên',
      example_hanzi = '病房里的护士态度非常温和耐心，细致地为病人测量体温和换药。',
      example_pinyin = 'Bìngfáng lǐ de hùshi tàidu fēicháng wēnhé nàixīn, xìzhì de wèi bìngrén cèliáng tǐwēn hé huànyào.',
      example_vi = 'Y tá trong phòng bệnh thái độ vô cùng hòa nhã kiên nhẫn, tỉ mỉ đo nhiệt độ và thay thuốc cho người bệnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '病房里的护士态度非常温和耐心，细致地为病人测量体温和换药。', 'Bìngfáng lǐ de hùshi tàidu fēicháng wēnhé nàixīn, xìzhì de wèi bìngrén cèliáng tǐwēn hé huànyào.', 'Y tá trong phòng bệnh thái độ vô cùng hòa nhã kiên nhẫn, tỉ mỉ đo nhiệt độ và thay thuốc cho người bệnh.', 'basic', 1),
        (v_id, '广大医务工作者特别是临床一线护士在疫情防控与危重症救治中不畏艰险白衣执甲，践行了崇高的救死扶伤人道主义精神。', 'Guǎngdà yīwù gōngzuòzhě tèbié shì línchuáng yīxiàn hùshi zài yìqíng fángkòng yǔ wēizhòngzhèng jiùzhì zhōng bú wèi jiānxiǎn bái yī zhí jiǎ, jiànxíng le chónggāo de jiùsǐ-fúshāng réndàozhǔyì jīngshén.', 'Đông đảo cán bộ nhân viên y tế đặc biệt là điều dưỡng viên tuyến đầu lâm sàng trong công tác phòng chống dịch bệnh và cứu chữa bệnh nặng nguy kịch không quản ngại hiểm nguy khoác áo blouse trắng xông pha, hiện thực hóa tinh thần nhân đạo cứu người cao quý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 3: #1201 -> #1300)!', v_count;
END $$;
