-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 3 (100 TỪ TIẾP THEO)
-- Phạm vi: #2202 [从前] (cóngqián) -> #2301 [短处] (duǎnchu)
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
  -- [2202] [从前] (cóngqián) - ngày xưa, trước đây, thuở trước [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '从前' AND pinyin = 'cóngqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '从前' AND pinyin = 'cóngqián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '从前'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '从前'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'cóngqián',
      meaning_vi = 'ngày xưa, trước đây, thuở trước',
      example_hanzi = '从前这里是一片荒芜的沙漠，如今已经变成了郁郁葱葱的绿洲。',
      example_pinyin = 'Cóngqián zhèlǐ shì yí piàn huāngwú de shāmò, rújīn yǐjīng biànchéng le yùyù-cōngcōng de lǜzhōu.',
      example_vi = 'Ngày xưa nơi đây từng là một vùng sa mạc hoang vu, ngày nay đã biến thành một ốc đảo cây cối xanh tươi mơn mởn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '从前',
      'cóngqián',
      'ngày xưa, trước đây, thuở trước',
      'Danh từ',
      'HSK 5',
      '从前这里是一片荒芜的沙漠，如今已经变成了郁郁葱葱的绿洲。',
      'Cóngqián zhèlǐ shì yí piàn huāngwú de shāmò, rújīn yǐjīng biànchéng le yùyù-cōngcōng de lǜzhōu.',
      'Ngày xưa nơi đây từng là một vùng sa mạc hoang vu, ngày nay đã biến thành một ốc đảo cây cối xanh tươi mơn mởn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '从前这里是一片荒芜的沙漠，如今已经变成了郁郁葱葱的绿洲。',
        'Cóngqián zhèlǐ shì yí piàn huāngwú de shāmò, rújīn yǐjīng biànchéng le yùyù-cōngcōng de lǜzhōu.',
        'Ngày xưa nơi đây từng là một vùng sa mạc hoang vu, ngày nay đã biến thành một ốc đảo cây cối xanh tươi mơn mởn.',
        'basic',
        1
      ),
      (
        v_id,
        '老人们常常坐在村头的大槐树下，摇着蒲扇给围坐在一起的晚辈们讲述从前那些艰苦奋斗的传奇岁月。',
        'Lǎorénmen chángcháng zuò zài cūntóu de dà huáishù xià, yáo zhe púshàn gěi wéizuò zài yìqǐ de wǎnbèimen jiǎngshù cóngqián nàxiē jiānkǔ fèndòu de chuánqí suìyuè.',
        'Các cụ già thường ngồi dưới tán cây hòe lớn đầu làng, phe phẩy chiếc quạt bồ đề kể lại cho con cháu quây quần nghe về những tháng năm huyền thoại phấn đấu gian khổ thuở trước.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2203] [从事] (cóngshì) - làm, dấn thân làm, dốc sức vào (nghề nghiệp, công tác chuyên môn) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '从事' AND pinyin = 'cóngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '从事' AND pinyin = 'cóngshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '从事'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '从事'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cóngshì',
      meaning_vi = 'làm, dấn thân làm, dốc sức vào (nghề nghiệp, công tác chuyên môn)',
      example_hanzi = '大学毕业后，他一直从事对外汉语国际教育教学工作。',
      example_pinyin = 'Dàxué bìyè hòu, tā yìzhí cóngshì duìwài Hànyǔ guójì jiàoyù jiàoxué gōngzuò.',
      example_vi = 'Sau khi tốt nghiệp đại học, anh ấy luôn làm công tác giảng dạy giáo dục tiếng Hán quốc tế đối ngoại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '从事',
      'cóngshì',
      'làm, dấn thân làm, dốc sức vào (nghề nghiệp, công tác chuyên môn)',
      'Động từ',
      'HSK 5',
      '大学毕业后，他一直从事对外汉语国际教育教学工作。',
      'Dàxué bìyè hòu, tā yìzhí cóngshì duìwài Hànyǔ guójì jiàoyù jiàoxué gōngzuò.',
      'Sau khi tốt nghiệp đại học, anh ấy luôn làm công tác giảng dạy giáo dục tiếng Hán quốc tế đối ngoại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '大学毕业后，他一直从事对外汉语国际教育教学工作。',
        'Dàxué bìyè hòu, tā yìzhí cóngshì duìwài Hànyǔ guójì jiàoyù jiàoxué gōngzuò.',
        'Sau khi tốt nghiệp đại học, anh ấy luôn làm công tác giảng dạy giáo dục tiếng Hán quốc tế đối ngoại.',
        'basic',
        1
      ),
      (
        v_id,
        '在这家跨国高新技术研发中心，数百位顶尖科学家与算法工程师正全力从事前沿生成式人工智能核心模型的创新研发。',
        'Zài zhè jiā kuàguó gāoxīn jìshù yánfā zhōngxīn, shù bǎi wèi dǐngjiān kēxuéjiā yǔ suànfǎ gōngchéngshī zhèng quánlì cóngshì qiányán shēngchéngxìng réngōng zhìnéng héxīn móxíng de chuàngxīn yánfā.',
        'Tại trung tâm nghiên cứu và phát triển công nghệ cao đa quốc gia này, hàng trăm nhà khoa học và kỹ sư thuật toán đỉnh cao đang dốc toàn lực làm công tác nghiên cứu phát triển sáng tạo mô hình cốt lõi trí tuệ nhân tạo tạo sinh tiên phong.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2204] [促进] (cùjìn) - thúc đẩy, đẩy mạnh (phát triển kinh tế, giao lưu hữu nghị) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '促进' AND pinyin = 'cùjìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '促进' AND pinyin = 'cùjìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '促进'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '促进'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cùjìn',
      meaning_vi = 'thúc đẩy, đẩy mạnh (phát triển kinh tế, giao lưu hữu nghị)',
      example_hanzi = '开展丰富多彩的体育活动有助于促进青少年的身心健康。',
      example_pinyin = 'Kāizhǎn fēngfù-duōcǎi de tǐyù huódòng yǒuzhùyú cùjìn qīngshàonián de shēnxīn jiànkāng.',
      example_vi = 'Triển khai các hoạt động thể dục thể thao phong phú đa dạng giúp thúc đẩy sức khỏe thể chất và tinh thần của thanh thiếu niên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '促进',
      'cùjìn',
      'thúc đẩy, đẩy mạnh (phát triển kinh tế, giao lưu hữu nghị)',
      'Động từ',
      'HSK 5',
      '开展丰富多彩的体育活动有助于促进青少年的身心健康。',
      'Kāizhǎn fēngfù-duōcǎi de tǐyù huódòng yǒuzhùyú cùjìn qīngshàonián de shēnxīn jiànkāng.',
      'Triển khai các hoạt động thể dục thể thao phong phú đa dạng giúp thúc đẩy sức khỏe thể chất và tinh thần của thanh thiếu niên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '开展丰富多彩的体育活动有助于促进青少年的身心健康。',
        'Kāizhǎn fēngfù-duōcǎi de tǐyù huódòng yǒuzhùyú cùjìn qīngshàonián de shēnxīn jiànkāng.',
        'Triển khai các hoạt động thể dục thể thao phong phú đa dạng giúp thúc đẩy sức khỏe thể chất và tinh thần của thanh thiếu niên.',
        'basic',
        1
      ),
      (
        v_id,
        '共建“一带一路”高质量国际经贸合作倡议，不仅极大地促进了沿线发展中国家的基础设施联通，更为全球经济复苏注入了强劲动力。',
        'Gòngjiàn “Yídài-Yílù” gāo zhìliàng guójì jīng-mào hézuò chàngyì, bùjǐn jí dà de cùjìn le yánxiàn fāzhǎnzhōng guójiā de jīchǔ shèshī liántōng, gèng wèi quánqiú jīngjì fùsū zhùrù le qiángjìn dònglì.',
        'Sáng kiến hợp tác kinh tế thương mại quốc tế chất lượng cao cùng xây dựng “Vành đai và Con đường” không chỉ thúc đẩy mạnh mẽ sự liên thông cơ sở hạ tầng của các nước đang phát triển dọc tuyến, mà còn tiếp thêm động lực mạnh mẽ cho sự phục hồi kinh tế toàn cầu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2205] [促使] (cùshǐ) - thúc giục, khiến cho, tạo động lực thúc đẩy (dẫn tới hành động) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '促使' AND pinyin = 'cùshǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '促使' AND pinyin = 'cùshǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '促使'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '促使'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cùshǐ',
      meaning_vi = 'thúc giục, khiến cho, tạo động lực thúc đẩy (dẫn tới hành động)',
      example_hanzi = '正是对未知神秘世界的强烈好奇心，促使年轻的科学家不断探索求真。',
      example_pinyin = 'Zhèng shì duì wèizhī shénmì shìjiè de qiángliè hàoqíxīn, cùshǐ niánqīng de kēxuéjiā búduàn tànsuǒ qiúzhēn.',
      example_vi = 'Chính lòng hiếu kỳ mãnh liệt đối với thế giới bí ẩn chưa biết đã thôi thúc nhà khoa học trẻ không ngừng tìm tòi khám phá chân lý.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '促使',
      'cùshǐ',
      'thúc giục, khiến cho, tạo động lực thúc đẩy (dẫn tới hành động)',
      'Động từ',
      'HSK 5',
      '正是对未知神秘世界的强烈好奇心，促使年轻的科学家不断探索求真。',
      'Zhèng shì duì wèizhī shénmì shìjiè de qiángliè hàoqíxīn, cùshǐ niánqīng de kēxuéjiā búduàn tànsuǒ qiúzhēn.',
      'Chính lòng hiếu kỳ mãnh liệt đối với thế giới bí ẩn chưa biết đã thôi thúc nhà khoa học trẻ không ngừng tìm tòi khám phá chân lý.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '正是对未知神秘世界的强烈好奇心，促使年轻的科学家不断探索求真。',
        'Zhèng shì duì wèizhī shénmì shìjiè de qiángliè hàoqíxīn, cùshǐ niánqīng de kēxuéjiā búduàn tànsuǒ qiúzhēn.',
        'Chính lòng hiếu kỳ mãnh liệt đối với thế giới bí ẩn chưa biết đã thôi thúc nhà khoa học trẻ không ngừng tìm tòi khám phá chân lý.',
        'basic',
        1
      ),
      (
        v_id,
        '全球消费者对绿色低碳环保生活理念的高度认可，有力促使各大传统跨国汽车巨头纷纷加速向纯电动智能化车型全面转型。',
        'Quánqiú xiāofèizhě duì lǜsè dītàn huánbǎo shēnghuó lǐniàn de gāodù rènkě, yǒulì cùshǐ gè dà chuántǒng kuàguó qìchē jùtóu fēnfēn jiāsù xiàng chún diàndòng zhìnénghuà chēxíng quánmiàn zhuǎnxíng.',
        'Sự đồng thuận cao độ của người tiêu dùng toàn cầu đối với quan niệm sống xanh ít carbon bảo vệ môi trường đã thúc đẩy mạnh mẽ các tập đoàn ô tô đa quốc gia truyền thống lớn đồng loạt đẩy nhanh chuyển đổi toàn diện sang các dòng xe thuần điện thông minh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2206] [促销] (cùxiāo) - khuyến mãi, kích cầu tiêu thụ, xúc tiến bán hàng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '促销' AND pinyin = 'cùxiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '促销' AND pinyin = 'cùxiāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '促销'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '促销'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'cùxiāo',
      meaning_vi = 'khuyến mãi, kích cầu tiêu thụ, xúc tiến bán hàng',
      example_hanzi = '各大百货商场在国庆黄金周期间推出了全场满减打折促销活动。',
      example_pinyin = 'Gè dà bǎihuò shāngchǎng zài Guóqìng huángjīnzhōu qījiān tuīchū le quánchǎng mǎnjiǎn dǎzhé cùxiāo huódòng.',
      example_vi = 'Các trung tâm thương mại bách hóa lớn trong tuần lễ vàng Quốc khánh đã tung ra chương trình khuyến mãi giảm giá trừ tiền toàn sàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '促销',
      'cùxiāo',
      'khuyến mãi, kích cầu tiêu thụ, xúc tiến bán hàng',
      'Động từ / Danh từ',
      'HSK 5',
      '各大百货商场在国庆黄金周期间推出了全场满减打折促销活动。',
      'Gè dà bǎihuò shāngchǎng zài Guóqìng huángjīnzhōu qījiān tuīchū le quánchǎng mǎnjiǎn dǎzhé cùxiāo huódòng.',
      'Các trung tâm thương mại bách hóa lớn trong tuần lễ vàng Quốc khánh đã tung ra chương trình khuyến mãi giảm giá trừ tiền toàn sàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '各大百货商场在国庆黄金周期间推出了全场满减打折促销活动。',
        'Gè dà bǎihuò shāngchǎng zài Guóqìng huángjīnzhōu qījiān tuīchū le quánchǎng mǎnjiǎn dǎzhé cùxiāo huódòng.',
        'Các trung tâm thương mại bách hóa lớn trong tuần lễ vàng Quốc khánh đã tung ra chương trình khuyến mãi giảm giá trừ tiền toàn sàn.',
        'basic',
        1
      ),
      (
        v_id,
        '面对激烈的线上电商节日竞争，该美妆品牌结合短视频直播带货与限时限量赠礼策略，打造了一场转化率极高的年终大促销售活动。',
        'Miànduì jīliè de xiànshàng diànshāng jiérì jìngzhēng, gāi měizhuāng pǐnpái jiéhé duǎnshìpín zhíbō dàihuò yǔ xiànshí xiànliàng zènglǐ cèlüè, dǎzào le yì chǎng zhuǎnhuàlǜ jí gāo de niánzhōng dà cùxiāo huódòng.',
        'Trước sự cạnh tranh ngày lễ mua sắm thương mại điện tử trực tuyến gay gắt, thương hiệu mỹ phẩm này đã kết hợp phát sóng trực tiếp bán hàng qua video ngắn cùng chiến lược tặng quà giới hạn thời gian và số lượng, tạo nên một đợt đại khuyến mãi cuối năm có tỷ lệ chuyển đổi cực cao.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2207] [催] (cuī) - giục, hối thúc, thúc giục [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '催' AND pinyin = 'cuī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '催' AND pinyin = 'cuī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '催'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '催'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cuī',
      meaning_vi = 'giục, hối thúc, thúc giục',
      example_hanzi = '妈妈每天早晨都要催促还在被窝里赖床的孩子快点儿起床洗漱。',
      example_pinyin = 'Māma měitiān zǎochén dōu yào cuīcù hái zài bèiwō lǐ làichuáng de háizi kuài diǎnr qǐchuáng xǐshù.',
      example_vi = 'Mẹ mỗi buổi sáng đều phải hối thúc đứa trẻ còn đang nướng trong chăn mau mau dậy rửa mặt chải đầu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '催',
      'cuī',
      'giục, hối thúc, thúc giục',
      'Động từ',
      'HSK 5',
      '妈妈每天早晨都要催促还在被窝里赖床的孩子快点儿起床洗漱。',
      'Māma měitiān zǎochén dōu yào cuīcù hái zài bèiwō lǐ làichuáng de háizi kuài diǎnr qǐchuáng xǐshù.',
      'Mẹ mỗi buổi sáng đều phải hối thúc đứa trẻ còn đang nướng trong chăn mau mau dậy rửa mặt chải đầu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '妈妈每天早晨都要催促还在被窝里赖床的孩子快点儿起床洗漱。',
        'Māma měitiān zǎochén dōu yào cuīcù hái zài bèiwō lǐ làichuáng de háizi kuài diǎnr qǐchuáng xǐshù.',
        'Mẹ mỗi buổi sáng đều phải hối thúc đứa trẻ còn đang nướng trong chăn mau mau dậy rửa mặt chải đầu.',
        'basic',
        1
      ),
      (
        v_id,
        '眼看临近工程交付的最后合同截止期限，项目总监天天给物料供应商打电话催促务必按时保质交付特种建筑材料。',
        'Yǎnkàn línjìn gōngchéng jiāofù de zuìhòu hétong jiézhǐ qīxiàn, xiàngmù zǒngjiān tiāntiān gěi wùliào gōngyìngshāng dǎ diànhuà cuīcù wùbì ànshí bǎozhì jiāofù tèzhǒng jiànzhù cáiliào.',
        'Trông thấy hạn chót hợp đồng bàn giao công trình cuối cùng sắp tới, giám đốc dự án ngày nào cũng gọi điện cho nhà cung cấp vật liệu giục giã nhất định phải bàn giao vật liệu xây dựng đặc chủng đúng hạn bảo đảm chất lượng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2208] [存放] (cúnfàng) - cất giữ, gửi gắm, lưu trữ (hành lý, tiền bạc, hồ sơ hiện vật) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '存放' AND pinyin = 'cúnfàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '存放' AND pinyin = 'cúnfàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '存放'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '存放'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'cúnfàng',
      meaning_vi = 'cất giữ, gửi gắm, lưu trữ (hành lý, tiền bạc, hồ sơ hiện vật)',
      example_hanzi = '火车站候车大厅设有全自动智能行李寄存柜，旅客可以方便地存放随身物品。',
      example_pinyin = 'Huǒchēzhàn hòuchē dàtīng shèyǒu quánzìdòng zhìnéng xíngli jìcúnguì, lǚkè kěyǐ fāngbiàn de cúnfàng suíshēn wùpǐn.',
      example_vi = 'Sảnh chờ ga tàu hỏa có trang bị tủ gửi hành lý thông minh tự động hoàn toàn, hành khách có thể cất giữ đồ đạc mang theo người một cách tiện lợi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '存放',
      'cúnfàng',
      'cất giữ, gửi gắm, lưu trữ (hành lý, tiền bạc, hồ sơ hiện vật)',
      'Động từ',
      'HSK 5',
      '火车站候车大厅设有全自动智能行李寄存柜，旅客可以方便地存放随身物品。',
      'Huǒchēzhàn hòuchē dàtīng shèyǒu quánzìdòng zhìnéng xíngli jìcúnguì, lǚkè kěyǐ fāngbiàn de cúnfàng suíshēn wùpǐn.',
      'Sảnh chờ ga tàu hỏa có trang bị tủ gửi hành lý thông minh tự động hoàn toàn, hành khách có thể cất giữ đồ đạc mang theo người một cách tiện lợi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '火车站候车大厅设有全自动智能行李寄存柜，旅客可以方便地存放随身物品。',
        'Huǒchēzhàn hòuchē dàtīng shèyǒu quánzìdòng zhìnéng xíngli jìcúnguì, lǚkè kěyǐ fāngbiàn de cúnfàng suíshēn wùpǐn.',
        'Sảnh chờ ga tàu hỏa có trang bị tủ gửi hành lý thông minh tự động hoàn toàn, hành khách có thể cất giữ đồ đạc mang theo người một cách tiện lợi.',
        'basic',
        1
      ),
      (
        v_id,
        '化学试剂管理规定明确要求，易燃易爆有毒有害危险化学品必须分类密封存放在具备防爆通风条件的专用危化品仓库中。',
        'Huàxué shìjì guǎnlǐ guīdìng míngquè yāoqiú, yìrán-yìbào yǒudú-yǒuhài wēixiǎn huàxuépǐn bìxū fēnlèi mìmìng cúnfàng zài jùbèi fángbào tōngfēng tiáojiàn de zhuānyòng wēihuàpǐn cāngkù zhōng.',
        'Quy định quản lý hóa chất thử nghiệm nêu rõ yêu cầu, hóa chất nguy hiểm dễ cháy nổ độc hại bắt buộc phải phân loại niêm phong cất giữ trong kho hóa chất nguy hiểm chuyên dụng đáp ứng điều kiện thông gió chống cháy nổ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2209] [存款] (cúnkuǎn) - tiền gửi tiết kiệm; gửi tiền vào tài khoản ngân hàng [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '存款' AND pinyin = 'cúnkuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '存款' AND pinyin = 'cúnkuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '存款'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '存款'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'cúnkuǎn',
      meaning_vi = 'tiền gửi tiết kiệm; gửi tiền vào tài khoản ngân hàng',
      example_hanzi = '爷爷每个月领到养老金后，都会把一部分钱存入银行作为定期存款。',
      example_pinyin = 'Yéye měi gè yuè lǐngdào yǎnglǎojīn hòu, dōu huì bǎ yí bùfen qián cúnrù yínháng zuòwéi dìngqī cúnkuǎn.',
      example_vi = 'Ông nội mỗi tháng sau khi nhận lương hưu đều sẽ gửi một phần tiền vào ngân hàng làm tiền gửi tiết kiệm định kỳ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '存款',
      'cúnkuǎn',
      'tiền gửi tiết kiệm; gửi tiền vào tài khoản ngân hàng',
      'Danh từ / Động từ',
      'HSK 5',
      '爷爷每个月领到养老金后，都会把一部分钱存入银行作为定期存款。',
      'Yéye měi gè yuè lǐngdào yǎnglǎojīn hòu, dōu huì bǎ yí bùfen qián cúnrù yínháng zuòwéi dìngqī cúnkuǎn.',
      'Ông nội mỗi tháng sau khi nhận lương hưu đều sẽ gửi một phần tiền vào ngân hàng làm tiền gửi tiết kiệm định kỳ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '爷爷每个月领到养老金后，都会把一部分钱存入银行作为定期存款。',
        'Yéye měi gè yuè lǐngdào yǎnglǎojīn hòu, dōu huì bǎ yí bùfen qián cúnrù yínháng zuòwéi dìngqī cúnkuǎn.',
        'Ông nội mỗi tháng sau khi nhận lương hưu đều sẽ gửi một phần tiền vào ngân hàng làm tiền gửi tiết kiệm định kỳ.',
        'basic',
        1
      ),
      (
        v_id,
        '国家实行法定存款保险制度，依法全方位保障广大个人储户在中资商业银行中的合法存款本金与利息安全。',
        'Guójiā shíxíng fǎdìng cúnkuǎn bǎoxiǎn zhìdù, yīfǎ quán fāngwèi bǎozhàng guǎngdà gèrén chǔhù zài zhōngzī shāngyè yínháng zhōng de héfǎ cúnkuǎn běnjīn yǔ lìxī ānquán.',
        'Nhà nước thực hiện chế độ bảo hiểm tiền gửi theo luật định, bảo vệ toàn diện theo đúng pháp luật sự an toàn của tiền gốc và lãi suất gửi tiết kiệm hợp pháp của đông đảo người gửi tiền cá nhân tại các ngân hàng thương mại có vốn Trung Quốc.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2210] [存在] (cúnzài) - tồn tại; sự tồn tại, hiện diện [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '存在' AND pinyin = 'cúnzài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '存在' AND pinyin = 'cúnzài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '存在'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '存在'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'cúnzài',
      meaning_vi = 'tồn tại; sự tồn tại, hiện diện',
      example_hanzi = '我们必须正视现实工作中客观存在的各种困难与问题。',
      example_pinyin = 'Wǒmen bìxū zhèngshì xiànshí gōngzuò zhōng kèguān cúnzài de gè zhǒng kùnnan yǔ wèntí.',
      example_vi = 'Chúng ta bắt buộc phải nhìn thẳng vào mọi khó khăn và vấn đề đang tồn tại khách quan trong công việc thực tế.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '存在',
      'cúnzài',
      'tồn tại; sự tồn tại, hiện diện',
      'Động từ / Danh từ',
      'HSK 5',
      '我们必须正视现实工作中客观存在的各种困难与问题。',
      'Wǒmen bìxū zhèngshì xiànshí gōngzuò zhōng kèguān cúnzài de gè zhǒng kùnnan yǔ wèntí.',
      'Chúng ta bắt buộc phải nhìn thẳng vào mọi khó khăn và vấn đề đang tồn tại khách quan trong công việc thực tế.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我们必须正视现实工作中客观存在的各种困难与问题。',
        'Wǒmen bìxū zhèngshì xiànshí gōngzuò zhōng kèguān cúnzài de gè zhǒng kùnnan yǔ wèntí.',
        'Chúng ta bắt buộc phải nhìn thẳng vào mọi khó khăn và vấn đề đang tồn tại khách quan trong công việc thực tế.',
        'basic',
        1
      ),
      (
        v_id,
        '安全生产责任重于泰山，任何企业如果在隐患排查中敷衍了事、允许安全漏洞长期存在，必将付出惨痛沉重的法律代价。',
        'Ānquán shēngchǎn zérèn zhòng yú Tàishān, rènhé qǐyè rúguǒ zài yǐnhuàn páichá zhōng fūyǎn-liǎoshì, yǔnxǔ ānquán lòudòng chángqī cúnzài, bì jiāng fùchū cǎntòng chénzhòng de fǎlǜ dàijià.',
        'Trách nhiệm an toàn sản xuất nặng hơn núi Thái Sơn, bất kỳ doanh nghiệp nào nếu làm việc qua loa chiếu lệ trong rà soát nguy cơ rủi ro và để lỗ hổng an toàn tồn tại lâu dài thì ắt sẽ phải trả cái giá pháp lý đau đớn nặng nề.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2211] [措施] (cuòshī) - biện pháp, phương sách giải quyết vấn đề [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '措施' AND pinyin = 'cuòshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '措施' AND pinyin = 'cuòshī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '措施'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '措施'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'cuòshī',
      meaning_vi = 'biện pháp, phương sách giải quyết vấn đề',
      example_hanzi = '学校采取了多项有力措施来改善校园周边交通拥堵状况。',
      example_pinyin = 'Xuéxiào cǎiqǔ le duō xiàng yǒulì cuòshī lái gǎishàn xiàoyuán zhōubiān jiāotōng yōngdǔ zhuàngkuàng.',
      example_vi = 'Nhà trường đã áp dụng nhiều biện pháp mạnh mẽ để cải thiện tình trạng ùn tắc giao thông xung quanh khuôn viên trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '措施',
      'cuòshī',
      'biện pháp, phương sách giải quyết vấn đề',
      'Danh từ',
      'HSK 5',
      '学校采取了多项有力措施来改善校园周边交通拥堵状况。',
      'Xuéxiào cǎiqǔ le duō xiàng yǒulì cuòshī lái gǎishàn xiàoyuán zhōubiān jiāotōng yōngdǔ zhuàngkuàng.',
      'Nhà trường đã áp dụng nhiều biện pháp mạnh mẽ để cải thiện tình trạng ùn tắc giao thông xung quanh khuôn viên trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '学校采取了多项有力措施来改善校园周边交通拥堵状况。',
        'Xuéxiào cǎiqǔ le duō xiàng yǒulì cuòshī lái gǎishàn xiàoyuán zhōubiān jiāotōng yōngdǔ zhuàngkuàng.',
        'Nhà trường đã áp dụng nhiều biện pháp mạnh mẽ để cải thiện tình trạng ùn tắc giao thông xung quanh khuôn viên trường.',
        'basic',
        1
      ),
      (
        v_id,
        '面对突如其来的全球供应链断裂风险，跨国制造企业迅速出台了一揽子涵盖本地化替代采购与多源仓储储备的应急保障措施。',
        'Miànduì tūrúqílái de quánqiú gōngyìngliàn duànliè fēngxiǎn, kuàguó zhìzào qǐyè xùnsù chūtái le yì lǎnzǐ hángài běndìhuà tìdài cǎigòu yǔ duōyuán cāngchǔ chǔbèi de yìngjí bǎozhàng cuòshī.',
        'Đối mặt với nguy cơ đứt gãy chuỗi cung ứng toàn cầu ập đến bất ngờ, doanh nghiệp sản xuất đa quốc gia đã nhanh chóng ban hành gói các biện pháp bảo đảm ứng phó khẩn cấp bao gồm thu mua thay thế bản địa hóa và dự trữ kho bãi đa nguồn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2212] [达成] (dáchéng) - đạt được (thỏa thuận, hiệp định, nhận thức chung, mục tiêu) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '达成' AND pinyin = 'dáchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '达成' AND pinyin = 'dáchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '达成'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '达成'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dáchéng',
      meaning_vi = 'đạt được (thỏa thuận, hiệp định, nhận thức chung, mục tiêu)',
      example_hanzi = '经过多轮友好协商，合作双方终于达成了互利共赢的合作意向。',
      example_pinyin = 'Jīngguò duō lún yǒuhǎo xiéshāng, hézuò shuāngfāng zhōngyú dáchéng le hùlì-gòngyíng de hézuò yìxiàng.',
      example_vi = 'Qua nhiều vòng thương lượng hữu nghị, hai bên hợp tác cuối cùng đã đạt được ý định hợp tác đôi bên cùng có lợi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '达成',
      'dáchéng',
      'đạt được (thỏa thuận, hiệp định, nhận thức chung, mục tiêu)',
      'Động từ',
      'HSK 5',
      '经过多轮友好协商，合作双方终于达成了互利共赢的合作意向。',
      'Jīngguò duō lún yǒuhǎo xiéshāng, hézuò shuāngfāng zhōngyú dáchéng le hùlì-gòngyíng de hézuò yìxiàng.',
      'Qua nhiều vòng thương lượng hữu nghị, hai bên hợp tác cuối cùng đã đạt được ý định hợp tác đôi bên cùng có lợi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '经过多轮友好协商，合作双方终于达成了互利共赢的合作意向。',
        'Jīngguò duō lún yǒuhǎo xiéshāng, hézuò shuāngfāng zhōngyú dáchéng le hùlì-gòngyíng de hézuò yìxiàng.',
        'Qua nhiều vòng thương lượng hữu nghị, hai bên hợp tác cuối cùng đã đạt được ý định hợp tác đôi bên cùng có lợi.',
        'basic',
        1
      ),
      (
        v_id,
        '在联合国气候变化大会经过艰苦的通宵谈判后，近两百个与会国最终在削减温室气体排放和设立气候损失基金上达成了历史性协议。',
        'Zài Liánhéguó qìhòu biànhuà dàhuì jīngguò jiānkǔ de tōngxiāo tánpàn hòu, jìn liǎng bǎi gè yùhuìguó zuìzhōng zài xuējiǎn wēnshì qìtǐ páifàng hé shèlì qìhòu sǔnshī jījīn shàng dáchéng le lìshǐxìng xiéyì.',
        'Tại hội nghị biến đổi khí hậu Liên Hợp Quốc sau cuộc đàm phán xuyên đêm gian khổ, gần hai trăm quốc gia tham dự cuối cùng đã đạt được thỏa thuận mang tính lịch sử về cắt giảm phát thải khí nhà kính và thành lập quỹ tổn thất khí hậu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2213] [打扮] (dǎban) - trang điểm, chải chuốt, ăn diện; cách ăn mặc trang phục [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '打扮' AND pinyin = 'dǎban'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打扮' AND pinyin = 'dǎban'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '打扮'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打扮'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'dǎban',
      meaning_vi = 'trang điểm, chải chuốt, ăn diện; cách ăn mặc trang phục',
      example_hanzi = '今天去参加好朋友的婚礼，她特意把自己精心打扮了一番。',
      example_pinyin = 'Jīntiān qù cānjiā hǎo péngyou de hūnlǐ, tā tèyì bǎ zìjǐ jīngxīn dǎban le yì fān.',
      example_vi = 'Hôm nay đi dự lễ cưới của bạn thân, cô ấy đã đặc biệt trang điểm chải chuốt cho bản thân vô cùng kỹ lưỡng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '打扮',
      'dǎban',
      'trang điểm, chải chuốt, ăn diện; cách ăn mặc trang phục',
      'Động từ / Danh từ',
      'HSK 5',
      '今天去参加好朋友的婚礼，她特意把自己精心打扮了一番。',
      'Jīntiān qù cānjiā hǎo péngyou de hūnlǐ, tā tèyì bǎ zìjǐ jīngxīn dǎban le yì fān.',
      'Hôm nay đi dự lễ cưới của bạn thân, cô ấy đã đặc biệt trang điểm chải chuốt cho bản thân vô cùng kỹ lưỡng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '今天去参加好朋友的婚礼，她特意把自己精心打扮了一番。',
        'Jīntiān qù cānjiā hǎo péngyou de hūnlǐ, tā tèyì bǎ zìjǐ jīngxīn dǎban le yì fān.',
        'Hôm nay đi dự lễ cưới của bạn thân, cô ấy đã đặc biệt trang điểm chải chuốt cho bản thân vô cùng kỹ lưỡng.',
        'basic',
        1
      ),
      (
        v_id,
        '戏剧舞台上的演员们身着绚丽的传统刺绣古装戏服，生动的古代书生与将帅打扮赢得了全场戏迷观众的齐声喝彩。',
        'Xìjù wǔtái shàng de yǎnyuánmen shēnzhuó xuànlì de chuántǒng cìxiù gǔzhuāng xìfú, shēngdòng de gǔdài shūshēng yǔ jiàngshuài dǎban yíngdé le quánchǎng xìmí guānzhòng de qíshēng hècǎi.',
        'Các diễn viên trên sân khấu kịch mặc những bộ trang phục cổ trang thêu truyền thống rực rỡ, tạo hình ăn mặc sinh động hóa thân thành thư sinh và tướng soái thời xưa đã giành được sự hò reo khen ngợi đồng thanh của toàn bộ khán giả mê kịch.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2214] [打包] (dǎbāo) - đóng gói mang về (đồ ăn thừa ở nhà hàng); đóng gói (hành lý, kiện hàng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '打包' AND pinyin = 'dǎbāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打包' AND pinyin = 'dǎbāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '打包'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打包'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dǎbāo',
      meaning_vi = 'đóng gói mang về (đồ ăn thừa ở nhà hàng); đóng gói (hành lý, kiện hàng)',
      example_hanzi = '在外面的餐馆吃完饭后，倡导将吃不完的饭菜打包带走。',
      example_pinyin = 'Zài wàimiàn de cānguǎn chī wán fàn hòu, chàngdǎo jiāng chī bù wán de fàncài dǎbāo dài zǒu.',
      example_vi = 'Sau khi ăn xong tại quán ăn bên ngoài, kêu gọi mọi người đóng gói thức ăn thừa mang về.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '打包',
      'dǎbāo',
      'đóng gói mang về (đồ ăn thừa ở nhà hàng); đóng gói (hành lý, kiện hàng)',
      'Động từ',
      'HSK 5',
      '在外面的餐馆吃完饭后，倡导将吃不完的饭菜打包带走。',
      'Zài wàimiàn de cānguǎn chī wán fàn hòu, chàngdǎo jiāng chī bù wán de fàncài dǎbāo dài zǒu.',
      'Sau khi ăn xong tại quán ăn bên ngoài, kêu gọi mọi người đóng gói thức ăn thừa mang về.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在外面的餐馆吃完饭后，倡导将吃不完的饭菜打包带走。',
        'Zài wàimiàn de cānguǎn chī wán fàn hòu, chàngdǎo jiāng chī bù wán de fàncài dǎbāo dài zǒu.',
        'Sau khi ăn xong tại quán ăn bên ngoài, kêu gọi mọi người đóng gói thức ăn thừa mang về.',
        'basic',
        1
      ),
      (
        v_id,
        '临近搬家，全家人齐心协力把所有书本、衣物和易碎瓷器用厚纸箱仔细分类打包并贴好标签，以便搬运公司装车。',
        'Línjìn bānjiā, quán jiārén qíxīn-xiélì bǎ suǒyǒu shūběn, yīwù hé yìsuì cíqì yòng hòu zhǐxiāng zǐxì fēnlèi dǎbāo bìng tiē hǎo biāoqiān, yǐbiàn bānyùn gōngsī zhuāngchē.',
        'Sắp đến ngày chuyển nhà, cả gia đình đồng lòng chung sức dùng thùng các tông dày đóng gói phân loại cẩn thận tất cả sách vở, quần áo và đồ gốm sứ dễ vỡ rồi dán nhãn đầy đủ để công ty vận chuyển tiện bốc dỡ lên xe.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2215] [打断] (dǎduàn) - ngắt lời, chen ngang; làm đứt gãy, làm gián đoạn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '打断' AND pinyin = 'dǎduàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打断' AND pinyin = 'dǎduàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '打断'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打断'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dǎduàn',
      meaning_vi = 'ngắt lời, chen ngang; làm đứt gãy, làm gián đoạn',
      example_hanzi = '在别人专心讲话阐述观点时，请不要随意插话打断。',
      example_pinyin = 'Zài biérén zhuānxīn jiǎnghuà chǎnshù guāndiǎn shí, qǐng bú yào suíyì chāhuà dǎduàn.',
      example_vi = 'Khi người khác đang chuyên tâm nói chuyện trình bày quan điểm, xin đừng tùy tiện chen ngang ngắt lời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '打断',
      'dǎduàn',
      'ngắt lời, chen ngang; làm đứt gãy, làm gián đoạn',
      'Động từ',
      'HSK 5',
      '在别人专心讲话阐述观点时，请不要随意插话打断。',
      'Zài biérén zhuānxīn jiǎnghuà chǎnshù guāndiǎn shí, qǐng bú yào suíyì chāhuà dǎduàn.',
      'Khi người khác đang chuyên tâm nói chuyện trình bày quan điểm, xin đừng tùy tiện chen ngang ngắt lời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在别人专心讲话阐述观点时，请不要随意插话打断。',
        'Zài biérén zhuānxīn jiǎnghuà chǎnshù guāndiǎn shí, qǐng bú yào suíyì chāhuà dǎduàn.',
        'Khi người khác đang chuyên tâm nói chuyện trình bày quan điểm, xin đừng tùy tiện chen ngang ngắt lời.',
        'basic',
        1
      ),
      (
        v_id,
        '主持人礼貌而果断地打断了某位参会代表偏离议题且超时漫长的发言，以确保国际高峰论坛各环节议程按时推进。',
        'Zhǔchírén lǐmào ér guǒduàn de dǎduàn le mǒu wèi cānhuì dàibiǎo piānlí yìtí qiě chāoshí màncháng de fāyán, yǐ quèbǎo guójì gāofēng lùntán gè huánjié yìchéng ànshí tuījìn.',
        'Người dẫn chương trình đã lịch sự nhưng dứt khoát ngắt lời bài phát biểu lệch khỏi chủ đề và kéo dài quá giờ của một đại biểu tham dự, nhằm bảo đảm lịch trình các phiên của diễn đàn cấp cao quốc tế được diễn ra đúng giờ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2216] [打破] (dǎpò) - phá vỡ, đập vỡ (kỷ lục thế giới, sự im lặng, sự phong tỏa độc quyền) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '打破' AND pinyin = 'dǎpò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打破' AND pinyin = 'dǎpò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '打破'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打破'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dǎpò',
      meaning_vi = 'phá vỡ, đập vỡ (kỷ lục thế giới, sự im lặng, sự phong tỏa độc quyền)',
      example_hanzi = '调皮的小猫在客厅玩耍时不小心打破了一个精美的花瓶。',
      example_pinyin = 'Tiáopí de xiǎomāo zài kètīng wánshuǎ shí bù xiǎoxīn dǎpò le yí gè jīngměi de huāpíng.',
      example_vi = 'Chú mèo con tinh nghịch trong lúc đùa nghịch ở phòng khách đã vô ý làm vỡ một chiếc bình hoa tinh xảo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '打破',
      'dǎpò',
      'phá vỡ, đập vỡ (kỷ lục thế giới, sự im lặng, sự phong tỏa độc quyền)',
      'Động từ',
      'HSK 5',
      '调皮的小猫在客厅玩耍时不小心打破了一个精美的花瓶。',
      'Tiáopí de xiǎomāo zài kètīng wánshuǎ shí bù xiǎoxīn dǎpò le yí gè jīngměi de huāpíng.',
      'Chú mèo con tinh nghịch trong lúc đùa nghịch ở phòng khách đã vô ý làm vỡ một chiếc bình hoa tinh xảo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '调皮的小猫在客厅玩耍时不小心打破了一个精美的花瓶。',
        'Tiáopí de xiǎomāo zài kètīng wánshuǎ shí bù xiǎoxīn dǎpò le yí gè jīngměi de huāpíng.',
        'Chú mèo con tinh nghịch trong lúc đùa nghịch ở phòng khách đã vô ý làm vỡ một chiếc bình hoa tinh xảo.',
        'basic',
        1
      ),
      (
        v_id,
        '我国年轻的百米短跑名将在世界田径锦标赛决赛中一举打破了保持多年的亚洲纪录，成功斩获金牌。',
        'Wǒ guó niánqīng de bǎimǐ duǎnpǎo míngjiàng zài shìjiè tiánjìng jǐnbiāosài juésài zhōng yì jǔ dǎpò le bǎochí duō nián de Yàzhōu jìlù, chénggōng zhǎnhuò jīnpái.',
        'Ngôi sao chạy cự ly ngắn một trăm mét trẻ tuổi của nước ta trong trận chung kết giải vô địch điền kinh thế giới đã xuất sắc phá vỡ kỷ lục châu Á được duy trì nhiều năm qua, thành công đoạt huy chương vàng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2217] [打听] (dǎting) - thăm dò, nghe ngóng, hỏi han tin tức [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '打听' AND pinyin = 'dǎting'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打听' AND pinyin = 'dǎting'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '打听'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '打听'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dǎting',
      meaning_vi = 'thăm dò, nghe ngóng, hỏi han tin tức',
      example_hanzi = '初到一个陌生的地方，他礼貌地向路边的好心交警打听去火车站的方向。',
      example_pinyin = 'Chū dào yí gè mòshēng de dìfang, tā lǐmào de xiàng lùbiān de hǎoxīn jiāojǐng dǎting qù huǒchēzhàn de fāngxiàng.',
      example_vi = 'Mới đặt chân tới một nơi xa lạ, anh ấy lịch sự hỏi han người cảnh sát giao thông tốt bụng bên đường hướng đi đến ga tàu hỏa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '打听',
      'dǎting',
      'thăm dò, nghe ngóng, hỏi han tin tức',
      'Động từ',
      'HSK 5',
      '初到一个陌生的地方，他礼貌地向路边的好心交警打听去火车站的方向。',
      'Chū dào yí gè mòshēng de dìfang, tā lǐmào de xiàng lùbiān de hǎoxīn jiāojǐng dǎting qù huǒchēzhàn de fāngxiàng.',
      'Mới đặt chân tới một nơi xa lạ, anh ấy lịch sự hỏi han người cảnh sát giao thông tốt bụng bên đường hướng đi đến ga tàu hỏa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '初到一个陌生的地方，他礼貌地向路边的好心交警打听去火车站的方向。',
        'Chū dào yí gè mòshēng de dìfang, tā lǐmào de xiàng lùbiān de hǎoxīn jiāojǐng dǎting qù huǒchēzhàn de fāngxiàng.',
        'Mới đặt chân tới một nơi xa lạ, anh ấy lịch sự hỏi han người cảnh sát giao thông tốt bụng bên đường hướng đi đến ga tàu hỏa.',
        'basic',
        1
      ),
      (
        v_id,
        '为了掌握第一手真实的市场行情，新成立的房产中介经理走访了周边数十个居民小区，到处打听近期二手房成交价格趋势。',
        'Wèile zhǎngwò dì-yī shǒu zhēnshí de shìchǎng hángqíng, xīn chénglì de fángchǎn zhōngjiè jīnglǐ zǒufǎng le zhōubiān shù shí gè jūmín xiǎoqū, dàochù dǎting jìnqī èrshǒufáng chéngjiāo jiàgé qūshì.',
        'Để nắm được diễn biến thị trường chân thực tận gốc, người quản lý môi giới bất động sản mới thành lập đã đi thăm dò hàng chục khu dân cư xung quanh, nghe ngóng khắp nơi xu hướng giá giao dịch nhà thứ cấp thời gian gần đây.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2218] [大胆] (dàdǎn) - táo bạo, can đảm, bạo dạn, dũng cảm [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大胆' AND pinyin = 'dàdǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大胆' AND pinyin = 'dàdǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大胆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大胆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'dàdǎn',
      meaning_vi = 'táo bạo, can đảm, bạo dạn, dũng cảm',
      example_hanzi = '上课回答老师提问时要自信大胆，即使说错了也没关系。',
      example_pinyin = 'Shàngkè huídá lǎoshī tíwèn shí yào zìxìn dàdǎn, jíshǐ shuō cuò le yě méi guānxi.',
      example_vi = 'Khi trả lời câu hỏi của thầy cô trên lớp cần tự tin và bạo dạn, cho dù nói sai cũng không sao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大胆',
      'dàdǎn',
      'táo bạo, can đảm, bạo dạn, dũng cảm',
      'Tính từ',
      'HSK 5',
      '上课回答老师提问时要自信大胆，即使说错了也没关系。',
      'Shàngkè huídá lǎoshī tíwèn shí yào zìxìn dàdǎn, jíshǐ shuō cuò le yě méi guānxi.',
      'Khi trả lời câu hỏi của thầy cô trên lớp cần tự tin và bạo dạn, cho dù nói sai cũng không sao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '上课回答老师提问时要自信大胆，即使说错了也没关系。',
        'Shàngkè huídá lǎoshī tíwèn shí yào zìxìn dàdǎn, jíshǐ shuō cuò le yě méi guānxi.',
        'Khi trả lời câu hỏi của thầy cô trên lớp cần tự tin và bạo dạn, cho dù nói sai cũng không sao.',
        'basic',
        1
      ),
      (
        v_id,
        '青年建筑设计师大胆打破了传统的四方形空间思维定势，运用极富现代张力的流线型仿生曲面打造出了震撼人心的城市新地标。',
        'Qīngnián jiànzhù shèjìshī dàdǎn dǎpò le chuántǒng de sìfāngxíng kōngjiān sīwéi dìngshì, yùnyòng jífù xiàndài zhānglì de liúxiànxíng fǎngshēng qūmiàn dǎzào chū le zhènhàn rénxīn de chéngshì xīn dìbiāo.',
        'Kiến trúc sư trẻ đã mạnh dạn táo bạo phá vỡ lối mòn tư duy không gian vuông vức truyền thống, vận dụng những đường cong phỏng sinh học dạng khí động học mang đậm sức căng hiện đại để tạo nên một biểu tượng kiến trúc đô thị mới làm chấn động lòng người.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2219] [大多] (dàduō) - phần lớn, hầu hết, đa phần [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大多' AND pinyin = 'dàduō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大多' AND pinyin = 'dàduō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大多'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大多'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'dàduō',
      meaning_vi = 'phần lớn, hầu hết, đa phần',
      example_hanzi = '参加今天这场国际青年学术讲座的听众大多是本校的研究生。',
      example_pinyin = 'Cānjiā jīntiān zhè chǎng guójì qīngnián xuéshù jiǎngzuò de tīngzhòng dàduō shì běnxiào de yánjiūshēng.',
      example_vi = 'Thính giả tham gia buổi tọa đàm học thuật thanh niên quốc tế hôm nay phần lớn là học viên cao học của trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大多',
      'dàduō',
      'phần lớn, hầu hết, đa phần',
      'Phó từ',
      'HSK 5',
      '参加今天这场国际青年学术讲座的听众大多是本校的研究生。',
      'Cānjiā jīntiān zhè chǎng guójì qīngnián xuéshù jiǎngzuò de tīngzhòng dàduō shì běnxiào de yánjiūshēng.',
      'Thính giả tham gia buổi tọa đàm học thuật thanh niên quốc tế hôm nay phần lớn là học viên cao học của trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '参加今天这场国际青年学术讲座的听众大多是本校的研究生。',
        'Cānjiā jīntiān zhè chǎng guójì qīngnián xuéshù jiǎngzuò de tīngzhòng dàduō shì běnxiào de yánjiūshēng.',
        'Thính giả tham gia buổi tọa đàm học thuật thanh niên quốc tế hôm nay phần lớn là học viên cao học của trường.',
        'basic',
        1
      ),
      (
        v_id,
        '调研报告显示，新一代年轻消费者在选购家用智能家电时，大多更加青睐外观时尚、操作智能且具备绿色低碳环保标识的知名国潮品牌。',
        'Diàoyán bàogào xiǎnshì, xīn yídài niánqīng xiāofèizhě zài xuǎngòu jiāyòng zhìnéng jiādiàn shí, dàduō gèngjiā qīnglài wàiguān shíshàng, cāozuò zhìnéng qiě jùbèi lǜsè dītàn huánbǎo biāozhì de zhùmíng guócháo pǐnpái.',
        'Báo cáo khảo sát chỉ ra rằng, người tiêu dùng trẻ thế hệ mới khi chọn mua đồ gia dụng thông minh gia đình, đa phần đều ưa chuộng hơn các thương hiệu nội địa nổi tiếng có vẻ ngoài thời thượng, thao tác thông minh và có chứng nhận bảo vệ môi trường xanh phát thải thấp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2220] [大会] (dàhuì) - đại hội, hội nghị toàn thể quy mô lớn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大会' AND pinyin = 'dàhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大会' AND pinyin = 'dàhuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大会'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大会'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàhuì',
      meaning_vi = 'đại hội, hội nghị toàn thể quy mô lớn',
      example_hanzi = '全校师生员工在体育馆隆重举行了新学年开学典礼大会。',
      example_pinyin = 'Quán xiào shīshēng yuángōng zài tǐyùguǎn lóngzhòng jǔxíng le xīn xuénián kāixué diǎnlǐ dàhuì.',
      example_vi = 'Toàn thể giáo viên, học sinh và nhân viên toàn trường đã long trọng tổ chức đại hội lễ khai giảng năm học mới tại nhà thi đấu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大会',
      'dàhuì',
      'đại hội, hội nghị toàn thể quy mô lớn',
      'Danh từ',
      'HSK 5',
      '全校师生员工在体育馆隆重举行了新学年开学典礼大会。',
      'Quán xiào shīshēng yuángōng zài tǐyùguǎn lóngzhòng jǔxíng le xīn xuénián kāixué diǎnlǐ dàhuì.',
      'Toàn thể giáo viên, học sinh và nhân viên toàn trường đã long trọng tổ chức đại hội lễ khai giảng năm học mới tại nhà thi đấu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '全校师生员工在体育馆隆重举行了新学年开学典礼大会。',
        'Quán xiào shīshēng yuángōng zài tǐyùguǎn lóngzhòng jǔxíng le xīn xuénián kāixué diǎnlǐ dàhuì.',
        'Toàn thể giáo viên, học sinh và nhân viên toàn trường đã long trọng tổ chức đại hội lễ khai giảng năm học mới tại nhà thi đấu.',
        'basic',
        1
      ),
      (
        v_id,
        '联合国世界卫生大会一致表决通过了关于在全球范围内加强传染病大流行预警防范与疫苗应急公平分配的历史性决议。',
        'Liánhéguó Shìjiè Wèishēng Dàhuì yízhì biǎojué tōngguò le guānyú zài quánqiú fànwéi nèi jiāqiáng chuánrǎnbìng dà liúxíng yùjǐng fángfàn yǔ yìmiáo yìngjí gōngpíng fēnpèi de lìshǐxìng juéyì.',
        'Đại hội đồng Y tế Thế giới của Liên Hợp Quốc đã nhất trí biểu quyết thông qua nghị quyết lịch sử về việc tăng cường cảnh báo phòng ngừa đại dịch bệnh truyền nhiễm và phân phối vắc xin khẩn cấp công bằng trên phạm vi toàn cầu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2221] [大力] (dàlì) - ra sức, dốc sức, hết sức mạnh mẽ (ủng hộ, thúc đẩy) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大力' AND pinyin = 'dàlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大力' AND pinyin = 'dàlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'dàlì',
      meaning_vi = 'ra sức, dốc sức, hết sức mạnh mẽ (ủng hộ, thúc đẩy)',
      example_hanzi = '各级政府大力支持并积极推进农村偏远地区公共图书馆和体育设施建设。',
      example_pinyin = 'Gè jí zhèngfǔ dàlì zhīchí bìng jījí tuījìn nóngcūn piānyuǎn dìqū gōnggòng túshūguǎn hé tǐyù shèshī jiànshè.',
      example_vi = 'Chính quyền các cấp ra sức ủng hộ và tích cực thúc đẩy xây dựng thư viện công cộng và cơ sở thể thao tại các vùng nông thôn hẻo lánh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大力',
      'dàlì',
      'ra sức, dốc sức, hết sức mạnh mẽ (ủng hộ, thúc đẩy)',
      'Phó từ',
      'HSK 5',
      '各级政府大力支持并积极推进农村偏远地区公共图书馆和体育设施建设。',
      'Gè jí zhèngfǔ dàlì zhīchí bìng jījí tuījìn nóngcūn piānyuǎn dìqū gōnggòng túshūguǎn hé tǐyù shèshī jiànshè.',
      'Chính quyền các cấp ra sức ủng hộ và tích cực thúc đẩy xây dựng thư viện công cộng và cơ sở thể thao tại các vùng nông thôn hẻo lánh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '各级政府大力支持并积极推进农村偏远地区公共图书馆和体育设施建设。',
        'Gè jí zhèngfǔ dàlì zhīchí bìng jījí tuījìn nóngcūn piānyuǎn dìqū gōnggòng túshūguǎn hé tǐyù shèshī jiànshè.',
        'Chính quyền các cấp ra sức ủng hộ và tích cực thúc đẩy xây dựng thư viện công cộng và cơ sở thể thao tại các vùng nông thôn hẻo lánh.',
        'basic',
        1
      ),
      (
        v_id,
        '国家出台了一揽子专项财税扶持与金融补贴政策，大力鼓励和引导广大制造企业加快数字化技术改造与智能装备升级换代。',
        'Guójiā chūtái le yì lǎnzǐ zhuānxiàng cái-shuì fúchí yǔ jīnróng bǔtiē zhèngcè, dàlì gǔlì hé yǐndǎo guǎngdà zhìzào qǐyè jiākuài shùzìhuà jìshù gǎizào yǔ zhìnéng zhuāngbèi shēngjí-huàndài.',
        'Nhà nước đã ban hành gói các chính sách hỗ trợ tài chính thuế khóa và trợ cấp tài chính chuyên ngành, dốc sức khuyến khích và dẫn dắt đông đảo các doanh nghiệp chế tạo đẩy nhanh cải tạo công nghệ kỹ thuật số và nâng cấp thay thế thiết bị thông minh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2222] [大妈] (dàmā) - bác gái, thím (cách xưng hô thân mật phụ nữ lớn tuổi) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大妈' AND pinyin = 'dàmā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大妈' AND pinyin = 'dàmā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大妈'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大妈'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàmā',
      meaning_vi = 'bác gái, thím (cách xưng hô thân mật phụ nữ lớn tuổi)',
      example_hanzi = '热心肠的居委会王大妈每天都主动在小区巡查楼道卫生与消防通道。',
      example_pinyin = 'Rèxīncháng de jūwěihuì Wáng dàmā měitiān dōu zhǔdòng zài xiǎoqū xúnchá lóudào wèishēng yǔ xiāofáng tōngdào.',
      example_vi = 'Bác gái Vương nhiệt tình ở ban quản lý tổ dân phố mỗi ngày đều chủ động tuần tra vệ sinh hành lang và lối thoát hiểm phòng cháy trong khu chung cư.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大妈',
      'dàmā',
      'bác gái, thím (cách xưng hô thân mật phụ nữ lớn tuổi)',
      'Danh từ',
      'HSK 5',
      '热心肠的居委会王大妈每天都主动在小区巡查楼道卫生与消防通道。',
      'Rèxīncháng de jūwěihuì Wáng dàmā měitiān dōu zhǔdòng zài xiǎoqū xúnchá lóudào wèishēng yǔ xiāofáng tōngdào.',
      'Bác gái Vương nhiệt tình ở ban quản lý tổ dân phố mỗi ngày đều chủ động tuần tra vệ sinh hành lang và lối thoát hiểm phòng cháy trong khu chung cư.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '热心肠的居委会王大妈每天都主动在小区巡查楼道卫生与消防通道。',
        'Rèxīncháng de jūwěihuì Wáng dàmā měitiān dōu zhǔdòng zài xiǎoqū xúnchá lóudào wèishēng yǔ xiāofáng tōngdào.',
        'Bác gái Vương nhiệt tình ở ban quản lý tổ dân phố mỗi ngày đều chủ động tuần tra vệ sinh hành lang và lối thoát hiểm phòng cháy trong khu chung cư.',
        'basic',
        1
      ),
      (
        v_id,
        '傍晚的市民文化休闲广场上，随着欢快的民族乐曲节奏，一群精神矍铄、动作整齐划一的大妈们正在充满活力地跳着广场舞。',
        'Bàngwǎn de shìmín wénhuà xiūxián guǎngchǎng shàng, suízhe huānkuài de mínzú yuèqǔ jiézòu, yì qún jīngshén-juéshuò, dòngzuò zhěngqí-huàyī de dàmāmen zhèngzài chōngmǎn huólì de tiào zhe guǎngchǎngwǔ.',
        'Trên quảng trường văn hóa giải trí của người dân vào lúc chập tối, hòa cùng nhịp điệu rộn ràng của bản nhạc dân tộc, một nhóm các bác gái tinh thần quắc thước với động tác đều tăm tắp đang tràn đầy năng lượng nhảy múa vũ điệu quảng trường.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2223] [大米] (dàmǐ) - gạo (lương thực chính) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大米' AND pinyin = 'dàmǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大米' AND pinyin = 'dàmǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大米'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大米'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàmǐ',
      meaning_vi = 'gạo (lương thực chính)',
      example_hanzi = '在亚洲许多国家和地区，大米是千家万户餐桌上最重要、最不可或缺的主食。',
      example_pinyin = 'Zài Yàzhōu xǔduō guójiā hé dìqū, dàmǐ shì qiānjiā-wànhù cānzhuō shàng zuì zhòngyào, zuì bùkě-huòquē de zhǔshí.',
      example_vi = 'Tại nhiều quốc gia và vùng lãnh thổ ở châu Á, gạo là lương thực chính quan trọng nhất và không thể thiếu trên bàn ăn của muôn vạn gia đình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大米',
      'dàmǐ',
      'gạo (lương thực chính)',
      'Danh từ',
      'HSK 5',
      '在亚洲许多国家和地区，大米是千家万户餐桌上最重要、最不可或缺的主食。',
      'Zài Yàzhōu xǔduō guójiā hé dìqū, dàmǐ shì qiānjiā-wànhù cānzhuō shàng zuì zhòngyào, zuì bùkě-huòquē de zhǔshí.',
      'Tại nhiều quốc gia và vùng lãnh thổ ở châu Á, gạo là lương thực chính quan trọng nhất và không thể thiếu trên bàn ăn của muôn vạn gia đình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在亚洲许多国家和地区，大米是千家万户餐桌上最重要、最不可或缺的主食。',
        'Zài Yàzhōu xǔduō guójiā hé dìqū, dàmǐ shì qiānjiā-wànhù cānzhuō shàng zuì zhòngyào, zuì bùkě-huòquē de zhǔshí.',
        'Tại nhiều quốc gia và vùng lãnh thổ ở châu Á, gạo là lương thực chính quan trọng nhất và không thể thiếu trên bàn ăn của muôn vạn gia đình.',
        'basic',
        1
      ),
      (
        v_id,
        '东北黑土地昼夜温差大且灌溉水源纯净优质，所产出的有机五常大米颗粒饱满圆润、煮出的米饭油亮清香且软糯筋道。',
        'Dōngběi hēitǔdì zhòuyè wēnchā dà qiě guàngài shuǐyuán chúnjìng yōuzhì, suǒ chǎnchū de yǒujī Wǔcháng dàmǐ kēlì bǎomǎn yuánrùn, zhǔ chū de mǐfàn yóuliàng qīngxiāng qiě ruǎannuò jīndào.',
        'Đất đen vùng Đông Bắc có chênh lệch nhiệt độ ngày đêm lớn lại có nguồn nước tưới tiêu thanh khiết chất lượng cao, gạo hữu cơ Ngũ Thường sản xuất ra hạt mẩy tròn trịa, cơm nấu ra bóng ngậy thơm dịu vừa dẻo vừa dai bùi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2224] [大脑] (dànǎo) - đại não, bộ não; cơ quan đầu não chỉ huy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大脑' AND pinyin = 'dànǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大脑' AND pinyin = 'dànǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大脑'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大脑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dànǎo',
      meaning_vi = 'đại não, bộ não; cơ quan đầu não chỉ huy',
      example_hanzi = '充足的深度睡眠能够让疲惫的人体大脑得到充分的休息与记忆修复。',
      example_pinyin = 'Chōngzú de shēndù shuìmián nénggòu ràng píbèi de réntǐ dànǎo dédào chōngfèn de xiūxi yǔ jìyì xiūfù.',
      example_vi = 'Giấc ngủ sâu đầy đủ có thể giúp bộ não mệt mỏi của cơ thể con người được nghỉ ngơi đầy đủ và phục hồi trí nhớ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大脑',
      'dànǎo',
      'đại não, bộ não; cơ quan đầu não chỉ huy',
      'Danh từ',
      'HSK 5',
      '充足的深度睡眠能够让疲惫的人体大脑得到充分的休息与记忆修复。',
      'Chōngzú de shēndù shuìmián nénggòu ràng píbèi de réntǐ dànǎo dédào chōngfèn de xiūxi yǔ jìyì xiūfù.',
      'Giấc ngủ sâu đầy đủ có thể giúp bộ não mệt mỏi của cơ thể con người được nghỉ ngơi đầy đủ và phục hồi trí nhớ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '充足的深度睡眠能够让疲惫的人体大脑得到充分的休息与记忆修复。',
        'Chōngzú de shēndù shuìmián nénggòu ràng píbèi de réntǐ dànǎo dédào chōngfèn de xiūxi yǔ jìyì xiūfù.',
        'Giấc ngủ sâu đầy đủ có thể giúp bộ não mệt mỏi của cơ thể con người được nghỉ ngơi đầy đủ và phục hồi trí nhớ.',
        'basic',
        1
      ),
      (
        v_id,
        '脑机接口前沿科技通过精确采集并解码人体大脑皮层的生物微弱电信号，实现了无需肢体动作即可用意念直接操控外骨骼机器人。',
        'Nǎo-jī jiēkǒu qiányán kējì tōngguò jīngquè cǎijí bìng jiěmǎ réntǐ dànǎo pícéng de shēngwù wēiruò diànxìnhào, shíxiàn le wúxū zhītǐ dòngzuò jí kě yòng yìniàn zhíjiē cāokòng wàigǔgé jīqìrén.',
        'Công nghệ tiên phong giao diện não - máy tính (BCI) thông qua việc thu thập chuẩn xác và giải mã các tín hiệu điện sinh học siêu yếu của vỏ đại não người, đã thực hiện được việc không cần động tác tay chân vẫn dùng ý nghĩ điều khiển trực tiếp robot khung xương ngoài.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2225] [大批] (dàpī) - số lượng lớn, hàng loạt, quy mô đông đảo [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大批' AND pinyin = 'dàpī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大批' AND pinyin = 'dàpī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大批'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大批'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'dàpī',
      meaning_vi = 'số lượng lớn, hàng loạt, quy mô đông đảo',
      example_hanzi = '每逢春季招聘黄金期，大批优秀的高校毕业生纷纷走向人才市场求职。',
      example_pinyin = 'Měi féng chūnjì zhāopìn huángjīnqī, dàpī yōuxiù de gāoxiào bìyèshēng fēnfēn zǒuxiàng réncái shìchǎng qiúzhí.',
      example_vi = 'Mỗi dịp thời kỳ vàng tuyển dụng mùa xuân, đông đảo sinh viên tốt nghiệp đại học xuất sắc nườm nượp bước ra thị trường nhân tài tìm việc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大批',
      'dàpī',
      'số lượng lớn, hàng loạt, quy mô đông đảo',
      'Tính từ / Danh từ',
      'HSK 5',
      '每逢春季招聘黄金期，大批优秀的高校毕业生纷纷走向人才市场求职。',
      'Měi féng chūnjì zhāopìn huángjīnqī, dàpī yōuxiù de gāoxiào bìyèshēng fēnfēn zǒuxiàng réncái shìchǎng qiúzhí.',
      'Mỗi dịp thời kỳ vàng tuyển dụng mùa xuân, đông đảo sinh viên tốt nghiệp đại học xuất sắc nườm nượp bước ra thị trường nhân tài tìm việc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '每逢春季招聘黄金期，大批优秀的高校毕业生纷纷走向人才市场求职。',
        'Měi féng chūnjì zhāopìn huángjīnqī, dàpī yōuxiù de gāoxiào bìyèshēng fēnfēn zǒuxiàng réncái shìchǎng qiúzhí.',
        'Mỗi dịp thời kỳ vàng tuyển dụng mùa xuân, đông đảo sinh viên tốt nghiệp đại học xuất sắc nườm nượp bước ra thị trường nhân tài tìm việc.',
        'basic',
        1
      ),
      (
        v_id,
        '随着高水平对外开放政策的持续深化落实，大批具有全球竞争优势的跨国龙头企业纷纷将亚太地区研发总部设在海南自贸港。',
        'Suízhe gāo shuǐpíng duìwài kāifàng zhèngcè de chíxù shēnhuà luòshí, dàpī jùyǒu quánqiú jìngzhēng yōushì de kuàguó lóngtóu qǐyè fēnfēn jiāng Yà-Tài dìqū yánfā zǒngbù shè zài Hǎinán Zìmàogǎng.',
        'Cùng với việc các chính sách mở cửa đối ngoại trình độ cao liên tục được đi sâu triển khai, hàng loạt các doanh nghiệp đầu ngành đa quốc gia có ưu thế cạnh tranh toàn cầu đã đồng loạt đặt trụ sở nghiên cứu phát triển khu vực châu Á - Thái Bình Dương tại Cảng Thương mại Tự do Hải Nam.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2226] [大厦] (dàshà) - tòa cao ốc, tòa nhà chọc trời đồ sộ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大厦' AND pinyin = 'dàshà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大厦' AND pinyin = 'dàshà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大厦'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大厦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàshà',
      meaning_vi = 'tòa cao ốc, tòa nhà chọc trời đồ sộ',
      example_hanzi = '市中心商业金融街上矗立着一栋栋气派宏伟的现代化高层商务大厦。',
      example_pinyin = 'Shì zhōngxīn shāngyè jīnróngjiē shàng chùlì zhe yí dòngdòng qìpài hóngwěi de xiàndàihuà gāocéng shāngwù dàshà.',
      example_vi = 'Trên tuyến phố tài chính thương mại trung tâm thành phố sừng sững những tòa cao ốc thương mại cao tầng hiện đại đồ sộ hoành tráng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大厦',
      'dàshà',
      'tòa cao ốc, tòa nhà chọc trời đồ sộ',
      'Danh từ',
      'HSK 5',
      '市中心商业金融街上矗立着一栋栋气派宏伟的现代化高层商务大厦。',
      'Shì zhōngxīn shāngyè jīnróngjiē shàng chùlì zhe yí dòngdòng qìpài hóngwěi de xiàndàihuà gāocéng shāngwù dàshà.',
      'Trên tuyến phố tài chính thương mại trung tâm thành phố sừng sững những tòa cao ốc thương mại cao tầng hiện đại đồ sộ hoành tráng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '市中心商业金融街上矗立着一栋栋气派宏伟的现代化高层商务大厦。',
        'Shì zhōngxīn shāngyè jīnróngjiē shàng chùlì zhe yí dòngdòng qìpài hóngwěi de xiàndàihuà gāocéng shāngwù dàshà.',
        'Trên tuyến phố tài chính thương mại trung tâm thành phố sừng sững những tòa cao ốc thương mại cao tầng hiện đại đồ sộ hoành tráng.',
        'basic',
        1
      ),
      (
        v_id,
        '新建成的绿色低碳智慧地标大厦全面采用了太阳能光伏建筑一体化系统与雨水智能回收循环技术，被国际专业机构评定为超低能耗建筑典范。',
        'Xīnjiàn chéng de lǜsè dītàn zhìhuì dìbiāo dàshà quánmiàn cǎiyòng le tàiyángnéng guāngfú jiànzhù yītǐhuà xìtǒng yǔ yǔshuǐ zhìnéng huíshōu xúnhuán jìshù, bèi guójì zhuānyè jīgòu píngdìng wéi chāodī nénghào jiànzhù diǎnfàn.',
        'Tòa nhà cao ốc biểu tượng thông minh phát thải thấp xanh mới xây áp dụng toàn diện hệ thống tích hợp quang điện mặt trời vào tòa nhà và công nghệ tuần hoàn thu gom nước mưa thông minh, được cơ quan chuyên môn quốc tế công nhận là hình mẫu kiến trúc tiêu hao năng lượng siêu thấp.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2227] [大事] (dàshì) - đại sự, việc lớn, sự kiện trọng đại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大事' AND pinyin = 'dàshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大事' AND pinyin = 'dàshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大事'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大事'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàshì',
      meaning_vi = 'đại sự, việc lớn, sự kiện trọng đại',
      example_hanzi = '结婚买房是人生旅途中的一桩大事，需要慎重考虑和周密规划。',
      example_pinyin = 'Jiéhūn mǎi fáng shì rénshēng lǚtú zhōng de yì zhuāng dàshì, xūyào shènzhòng kǎolǜ hé zhōumì guīhuà.',
      example_vi = 'Kết hôn mua nhà là một việc đại sự trên đường đời, cần phải cân nhắc thận trọng và lên kế hoạch chu đáo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大事',
      'dàshì',
      'đại sự, việc lớn, sự kiện trọng đại',
      'Danh từ',
      'HSK 5',
      '结婚买房是人生旅途中的一桩大事，需要慎重考虑和周密规划。',
      'Jiéhūn mǎi fáng shì rénshēng lǚtú zhōng de yì zhuāng dàshì, xūyào shènzhòng kǎolǜ hé zhōumì guīhuà.',
      'Kết hôn mua nhà là một việc đại sự trên đường đời, cần phải cân nhắc thận trọng và lên kế hoạch chu đáo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '结婚买房是人生旅途中的一桩大事，需要慎重考虑和周密规划。',
        'Jiéhūn mǎi fáng shì rénshēng lǚtú zhōng de yì zhuāng dàshì, xūyào shènzhòng kǎolǜ hé zhōumì guīhuà.',
        'Kết hôn mua nhà là một việc đại sự trên đường đời, cần phải cân nhắc thận trọng và lên kế hoạch chu đáo.',
        'basic',
        1
      ),
      (
        v_id,
        '保障十四亿多人民群众的粮食安全是关乎国计民生的头等大事，任何时候都容不得丝毫麻痹大意。',
        'Bǎozhàng shísì yì duō rénmín qúnzhòng de liángshi ānquán shì guānhū guójì-mínshēng de tóuděng dàshì, rènhé shíhou dōu róngbùdé sīháo mábì-dàyì.',
        'Bảo đảm an ninh lương thực cho hơn một tỷ bốn trăm triệu nhân dân là đại sự hàng đầu liên quan đến quốc kế dân sinh, trong bất kỳ thời điểm nào cũng không cho phép có một chút lơ là mất cảnh giác.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2228] [大象] (dàxiàng) - con voi (loài động vật có vú trên cạn lớn nhất) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大象' AND pinyin = 'dàxiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大象' AND pinyin = 'dàxiàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大象'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大象'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàxiàng',
      meaning_vi = 'con voi (loài động vật có vú trên cạn lớn nhất)',
      example_hanzi = '在动物园里，温顺可爱的大象正在用长长的鼻子卷起香蕉喂进嘴里。',
      example_pinyin = 'Zài dòngwùyuán lǐ, wēnshùn kě’ài de dàxiàng zhèngzài yòng chángcháng de bízi juǎn qǐ xiāngjiāo wèi jìn zuǐ lǐ.',
      example_vi = 'Trong sở thú, chú voi ngoan ngoãn đáng yêu đang dùng chiếc vòi dài ngoằng cuộn quả chuối cho vào miệng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大象',
      'dàxiàng',
      'con voi (loài động vật có vú trên cạn lớn nhất)',
      'Danh từ',
      'HSK 5',
      '在动物园里，温顺可爱的大象正在用长长的鼻子卷起香蕉喂进嘴里。',
      'Zài dòngwùyuán lǐ, wēnshùn kě’ài de dàxiàng zhèngzài yòng chángcháng de bízi juǎn qǐ xiāngjiāo wèi jìn zuǐ lǐ.',
      'Trong sở thú, chú voi ngoan ngoãn đáng yêu đang dùng chiếc vòi dài ngoằng cuộn quả chuối cho vào miệng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在动物园里，温顺可爱的大象正在用长长的鼻子卷起香蕉喂进嘴里。',
        'Zài dòngwùyuán lǐ, wēnshùn kě’ài de dàxiàng zhèngzài yòng chángcháng de bízi juǎn qǐ xiāngjiāo wèi jìn zuǐ lǐ.',
        'Trong sở thú, chú voi ngoan ngoãn đáng yêu đang dùng chiếc vòi dài ngoằng cuộn quả chuối cho vào miệng.',
        'basic',
        1
      ),
      (
        v_id,
        '云南西双版纳热带雨林野生亚洲象种群的北移南归传奇之旅，生动展现了中国在生物多样性保护与人象和谐共生方面取得的卓越成效。',
        'Yúnnán Xīshuāngbǎnnà rèdài yǔlín yěshēng Yàzhōuxiàng zhǒngqún de běiyí nánguī chuánqí zhī lǚ, shēngdòng zhǎnxiàn le Zhōngguó zài shēngwù duōyàngxìng bǎohù yǔ rén xiàng héxié gòngshēng fāngmiàn qǔdé de zhuóyuè chéngxiào.',
        'Chuyến hành trình huyền thoại di chuyển lên phía bắc rồi quay về phía nam của đàn voi châu Á hoang dã ở rừng mưa nhiệt đới Tây Song Bản Nạp tỉnh Vân Nam, đã thể hiện sinh động những thành quả vượt bậc mà Trung Quốc đạt được trong việc bảo vệ đa dạng sinh học và con người cùng chung sống hài hòa với loài voi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2229] [大型] (dàxíng) - quy mô lớn, cỡ lớn (doanh nghiệp, hội nghị, triển lãm, thiết bị) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大型' AND pinyin = 'dàxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大型' AND pinyin = 'dàxíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大型'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大型'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'dàxíng',
      meaning_vi = 'quy mô lớn, cỡ lớn (doanh nghiệp, hội nghị, triển lãm, thiết bị)',
      example_hanzi = '市中心新建了一家集购物、餐饮和休闲娱乐于一体的大型商业综合体。',
      example_pinyin = 'Shì zhōngxīn xīnjiàn le yì jiā jí gòuwù, cānyǐn hé xiūxián yúlè yú yītǐ de dàxíng shāngyè zōnghètǐ.',
      example_vi = 'Trung tâm thành phố mới xây dựng một khu phức hợp thương mại quy mô lớn tích hợp mua sắm, ẩm thực và vui chơi giải trí vào làm một.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大型',
      'dàxíng',
      'quy mô lớn, cỡ lớn (doanh nghiệp, hội nghị, triển lãm, thiết bị)',
      'Tính từ',
      'HSK 5',
      '市中心新建了一家集购物、餐饮和休闲娱乐于一体的大型商业综合体。',
      'Shì zhōngxīn xīnjiàn le yì jiā jí gòuwù, cānyǐn hé xiūxián yúlè yú yītǐ de dàxíng shāngyè zōnghètǐ.',
      'Trung tâm thành phố mới xây dựng một khu phức hợp thương mại quy mô lớn tích hợp mua sắm, ẩm thực và vui chơi giải trí vào làm một.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '市中心新建了一家集购物、餐饮和休闲娱乐于一体的大型商业综合体。',
        'Shì zhōngxīn xīnjiàn le yì jiā jí gòuwù, cānyǐn hé xiūxián yúlè yú yītǐ de dàxíng shāngyè zōnghètǐ.',
        'Trung tâm thành phố mới xây dựng một khu phức hợp thương mại quy mô lớn tích hợp mua sắm, ẩm thực và vui chơi giải trí vào làm một.',
        'basic',
        1
      ),
      (
        v_id,
        '由多国顶尖科研团队联合攻关的大型强子对撞机粒子物理实验，在揭示宇宙早期微观粒子演化规律方面再次取得重大科研突破。',
        'Yóu duō guó dǐngjiān kēyán tuánduì liánhé gōngguān de dàxíng qiángzǐ duìzhuàngjī lìzǐ wùlǐ shíyàn, zài jiēshì yǔzhòu zǎoqī wēiguān lìzǐ yǎnhuà guīlǜ fāngmiàn zàicì qǔdé zhòngdà kēyán tūpò.',
        'Thí nghiệm vật lý hạt máy gia tốc va chạm hadron cỡ lớn do các đội ngũ nghiên cứu khoa học đỉnh cao nhiều nước cùng hợp tác giải quyết, đã một lần nữa giành được bước đột phá khoa học trọng đại trong việc làm sáng tỏ quy luật tiến hóa hạt vi mô thời kỳ sơ khai của vũ trụ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2230] [大爷] (dàye) - bác, cụ, ông bác (cách xưng hô kính trọng, thân mật với người già nam giới) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大爷' AND pinyin = 'dàye'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大爷' AND pinyin = 'dàye'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大爷'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大爷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàye',
      meaning_vi = 'bác, cụ, ông bác (cách xưng hô kính trọng, thân mật với người già nam giới)',
      example_hanzi = '看门房的张大爷为人热心和善，平时总是乐呵呵地帮邻居们代收快递。',
      example_pinyin = 'Kānménfáng de Zhāng dàye wéirén rèxīn héshàn, píngshí zǒngshì lèhēhē de bāng línjūmen dàishōu kuàidì.',
      example_vi = 'Bác Trương trông phòng gác cổng tính tình nhiệt tình hòa nhã, ngày thường luôn tươi cười hớn hở giúp đỡ bà con lối xóm nhận bưu phẩm hộ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大爷',
      'dàye',
      'bác, cụ, ông bác (cách xưng hô kính trọng, thân mật với người già nam giới)',
      'Danh từ',
      'HSK 5',
      '看门房的张大爷为人热心和善，平时总是乐呵呵地帮邻居们代收快递。',
      'Kānménfáng de Zhāng dàye wéirén rèxīn héshàn, píngshí zǒngshì lèhēhē de bāng línjūmen dàishōu kuàidì.',
      'Bác Trương trông phòng gác cổng tính tình nhiệt tình hòa nhã, ngày thường luôn tươi cười hớn hở giúp đỡ bà con lối xóm nhận bưu phẩm hộ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '看门房的张大爷为人热心和善，平时总是乐呵呵地帮邻居们代收快递。',
        'Kānménfáng de Zhāng dàye wéirén rèxīn héshàn, píngshí zǒngshì lèhēhē de bāng línjūmen dàishōu kuàidì.',
        'Bác Trương trông phòng gác cổng tính tình nhiệt tình hòa nhã, ngày thường luôn tươi cười hớn hở giúp đỡ bà con lối xóm nhận bưu phẩm hộ.',
        'basic',
        1
      ),
      (
        v_id,
        '在早晨喧闹的便民早市上，一位白发苍苍的老大爷熟练地挑选着新鲜蔬菜，时不时跟摊主亲切唠着家常。',
        'Zài zǎochén xuānnào de biànmín zǎoshì shàng, yí wèi báifà-cāngcāng de lǎo dàye shúliàn de tiāoxuǎn zhe xīnxiān shūcài, shíbùshí gēn tānzhǔ qīnqiè lào zhe jiācháng.',
        'Tại khu chợ sớm dân sinh ồn ào lúc bình minh, một cụ ông tóc hoa râm thành thạo chọn lựa rau tươi, thỉnh thoảng lại trò chuyện tâm sự chuyện đời thường thân mật cùng chủ quầy hàng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2231] [大于] (dàyú) - lớn hơn, vượt trội hơn (toán học, so sánh tỷ lệ) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大于' AND pinyin = 'dàyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大于' AND pinyin = 'dàyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dàyú',
      meaning_vi = 'lớn hơn, vượt trội hơn (toán học, so sánh tỷ lệ)',
      example_hanzi = '数学常识告诉我们，在直角三角形中，斜边的长度一定大于任何一条直角边。',
      example_pinyin = 'Shùxué chángshí gàosu wǒmen, zài zhíjiǎo sānjiǎoxíng zhōng, xiébiān de chángdù yídìng dàyú rènhé yì tiáo zhíjiǎobiān.',
      example_vi = 'Thường thức toán học cho chúng ta biết, trong một tam giác vuông, chiều dài của cạnh huyền nhất định lớn hơn bất kỳ cạnh góc vuông nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大于',
      'dàyú',
      'lớn hơn, vượt trội hơn (toán học, so sánh tỷ lệ)',
      'Động từ',
      'HSK 5',
      '数学常识告诉我们，在直角三角形中，斜边的长度一定大于任何一条直角边。',
      'Shùxué chángshí gàosu wǒmen, zài zhíjiǎo sānjiǎoxíng zhōng, xiébiān de chángdù yídìng dàyú rènhé yì tiáo zhíjiǎobiān.',
      'Thường thức toán học cho chúng ta biết, trong một tam giác vuông, chiều dài của cạnh huyền nhất định lớn hơn bất kỳ cạnh góc vuông nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '数学常识告诉我们，在直角三角形中，斜边的长度一定大于任何一条直角边。',
        'Shùxué chángshí gàosu wǒmen, zài zhíjiǎo sānjiǎoxíng zhōng, xiébiān de chángdù yídìng dàyú rènhé yì tiáo zhíjiǎobiān.',
        'Thường thức toán học cho chúng ta biết, trong một tam giác vuông, chiều dài của cạnh huyền nhất định lớn hơn bất kỳ cạnh góc vuông nào.',
        'basic',
        1
      ),
      (
        v_id,
        '风险评估专家指出，在重大跨国商业并购决策中，如果潜在的不可控整合风险成本大于预期市场协同收益，则该方案应当审慎叫停。',
        'Fēngxiǎn pínggū zhuānjiā zhǐchū, zài zhòngdà kuàguó shāngyè bìnggòu juécè zhōng, rúguǒ qiánzài de bùkěkòng zhěnghé fēngxiǎn chéngběn dàyú yùqī shìchǎng xiétóng shòuyì, zé gāi fāng’àn yīngdāng shěnshèn jiàotíng.',
        'Chuyên gia đánh giá rủi ro chỉ rõ rằng, trong quyết sách sáp nhập mua lại thương mại xuyên quốc gia trọng đại, nếu chi phí rủi ro sáp nhập tiềm ẩn không thể kiểm soát lớn hơn lợi ích hiệp đồng thị trường dự kiến, thì phương án này nên dừng lại một cách thận trọng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2232] [大众] (dàzhòng) - đại chúng, đông đảo quần chúng nhân dân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '大众' AND pinyin = 'dàzhòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大众' AND pinyin = 'dàzhòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '大众'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '大众'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàzhòng',
      meaning_vi = 'đại chúng, đông đảo quần chúng nhân dân',
      example_hanzi = '科普读物应当语言通俗易懂，便于广大人民大众阅读和理解。',
      example_pinyin = 'Kēpǔ dúwù yīngdāng yǔyán tōngsú-yìdǒng, biànyú guǎngdà rénmín dàzhòng yuèdú hé lǐjiě.',
      example_vi = 'Sách phổ biến khoa học nên dùng ngôn ngữ bình dân dễ hiểu, tạo thuận lợi cho đông đảo quần chúng nhân dân đọc và thấu hiểu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '大众',
      'dàzhòng',
      'đại chúng, đông đảo quần chúng nhân dân',
      'Danh từ',
      'HSK 5',
      '科普读物应当语言通俗易懂，便于广大人民大众阅读和理解。',
      'Kēpǔ dúwù yīngdāng yǔyán tōngsú-yìdǒng, biànyú guǎngdà rénmín dàzhòng yuèdú hé lǐjiě.',
      'Sách phổ biến khoa học nên dùng ngôn ngữ bình dân dễ hiểu, tạo thuận lợi cho đông đảo quần chúng nhân dân đọc và thấu hiểu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '科普读物应当语言通俗易懂，便于广大人民大众阅读和理解。',
        'Kēpǔ dúwù yīngdāng yǔyán tōngsú-yìdǒng, biànyú guǎngdà rénmín dàzhòng yuèdú hé lǐjiě.',
        'Sách phổ biến khoa học nên dùng ngôn ngữ bình dân dễ hiểu, tạo thuận lợi cho đông đảo quần chúng nhân dân đọc và thấu hiểu.',
        'basic',
        1
      ),
      (
        v_id,
        '公共文化服务体系建设必须始终坚持面向基层、服务大众的根本导向，大力推进全民阅读与公共文化场馆免费开放。',
        'Gōnggòng wénhuà fúwù tǐxì jiànshè bìxū shǐzhōng jiānchí miànxiàng jīcéng, fúwù dàzhòng de gēnběn dǎoxiàng, dàlì tuījìn quánmín yuèdú yǔ gōnggòng wénhuà chǎngguǎn miǎnfèi kāifàng.',
        'Xây dựng hệ thống dịch vụ văn hóa công cộng bắt buộc phải luôn kiên trì định hướng căn bản là hướng về cơ sở và phục vụ quảng đại quần chúng, ra sức thúc đẩy toàn dân đọc sách và mở cửa miễn phí các nhà văn hóa công cộng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2233] [代] (dài) - thế hệ, triều đại, thời đại; thay thế, đại diện làm thay [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '代' AND pinyin = 'dài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '代' AND pinyin = 'dài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '代'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '代'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'dài',
      meaning_vi = 'thế hệ, triều đại, thời đại; thay thế, đại diện làm thay',
      example_hanzi = '每一代年轻人都有属于自己的历史使命与责任担当。',
      example_pinyin = 'Měi yí dài niánqīngrén dōu yǒu shǔyú zìjǐ de lìshǐ shǐmìng yǔ zérèn dāndāng.',
      example_vi = 'Mỗi một thế hệ người trẻ tuổi đều có sứ mệnh lịch sử và trách nhiệm gánh vác thuộc về riêng mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '代',
      'dài',
      'thế hệ, triều đại, thời đại; thay thế, đại diện làm thay',
      'Danh từ / Động từ',
      'HSK 5',
      '每一代年轻人都有属于自己的历史使命与责任担当。',
      'Měi yí dài niánqīngrén dōu yǒu shǔyú zìjǐ de lìshǐ shǐmìng yǔ zérèn dāndāng.',
      'Mỗi một thế hệ người trẻ tuổi đều có sứ mệnh lịch sử và trách nhiệm gánh vác thuộc về riêng mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '每一代年轻人都有属于自己的历史使命与责任担当。',
        'Měi yí dài niánqīngrén dōu yǒu shǔyú zìjǐ de lìshǐ shǐmìng yǔ zérèn dāndāng.',
        'Mỗi một thế hệ người trẻ tuổi đều có sứ mệnh lịch sử và trách nhiệm gánh vác thuộc về riêng mình.',
        'basic',
        1
      ),
      (
        v_id,
        '王经理出差去外地参加商务谈判期间，所有日常行政审批文件均由李副经理全权代为签署办理。',
        'Wáng jīnglǐ chūchāi qù wàidì cānjiā shāngwù tánpàn qījiān, suǒyǒu rìcháng xíngzhèng shěnpī wénjiàn jūn yóu Lǐ fù jīnglǐ quánquán dài wéi qiānshǔ bànlǐ.',
        'Trong thời gian giám đốc Vương đi công tác ngoại tỉnh tham gia đàm phán thương mại, tất cả các văn bản phê duyệt hành chính thường nhật đều do phó giám đốc Lý toàn quyền đại diện ký duyệt xử lý.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2234] [代表] (dàibiǎo) - đại biểu, người đại diện; đại diện cho, tiêu biểu cho [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '代表' AND pinyin = 'dàibiǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '代表' AND pinyin = 'dàibiǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '代表'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '代表'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'dàibiǎo',
      meaning_vi = 'đại biểu, người đại diện; đại diện cho, tiêu biểu cho',
      example_hanzi = '他作为优秀学生代表在毕业典礼上发表了感人肺腑的毕业致辞。',
      example_pinyin = 'Tā zuòwéi yōuxiù xuésheng dàibiǎo zài bìyè diǎnlǐ shàng fābiǎo le gǎnrén-fèifǔ de bìyè zhìcí.',
      example_vi = 'Bạn ấy với tư cách đại biểu học sinh xuất sắc đã phát biểu bài diễn văn tốt nghiệp lay động lòng người tại buổi lễ ra trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '代表',
      'dàibiǎo',
      'đại biểu, người đại diện; đại diện cho, tiêu biểu cho',
      'Danh từ / Động từ',
      'HSK 5',
      '他作为优秀学生代表在毕业典礼上发表了感人肺腑的毕业致辞。',
      'Tā zuòwéi yōuxiù xuésheng dàibiǎo zài bìyè diǎnlǐ shàng fābiǎo le gǎnrén-fèifǔ de bìyè zhìcí.',
      'Bạn ấy với tư cách đại biểu học sinh xuất sắc đã phát biểu bài diễn văn tốt nghiệp lay động lòng người tại buổi lễ ra trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他作为优秀学生代表在毕业典礼上发表了感人肺腑的毕业致辞。',
        'Tā zuòwéi yōuxiù xuésheng dàibiǎo zài bìyè diǎnlǐ shàng fābiǎo le gǎnrén-fèifǔ de bìyè zhìcí.',
        'Bạn ấy với tư cách đại biểu học sinh xuất sắc đã phát biểu bài diễn văn tốt nghiệp lay động lòng người tại buổi lễ ra trường.',
        'basic',
        1
      ),
      (
        v_id,
        '全权外交特派代表在联合国多边和平斡旋谈判中严正重申了我国在维护地区和平稳定上的客观公正立场。',
        'Quánquán wàijiāo tèpài dàibiǎo zài Liánhéguó duōbiān hépíng wòxuán tánpàn zhōng yánzhèng chóngshēn le wǒ guó zài wéihù dìqū hépíng wěndìng shàng de kèguān gōngzhèng lìchǎng.',
        'Đại diện đặc phái ngoại giao toàn quyền trong các cuộc đàm phán hòa giải hòa bình đa phương của Liên Hợp Quốc đã nghiêm túc tái khẳng định lập trường khách quan công chính của nước ta trong việc giữ gìn hòa bình ổn định khu vực.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2235] [带动] (dàidòng) - dẫn dắt, kéo theo, thúc đẩy cùng phát triển (kinh tế, chuỗi ngành) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '带动' AND pinyin = 'dàidòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '带动' AND pinyin = 'dàidòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '带动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '带动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dàidòng',
      meaning_vi = 'dẫn dắt, kéo theo, thúc đẩy cùng phát triển (kinh tế, chuỗi ngành)',
      example_hanzi = '大企业落户当地后，有力带动了周边乡村第三产业的快速发展。',
      example_pinyin = 'Dà qǐyè luòhù dāngdì hòu, yǒulì dàidòng le zhōubiān xiāngcūn dì-sān chǎnyè de kuàisù fāzhǎn.',
      example_vi = 'Sau khi các doanh nghiệp lớn đặt trụ sở tại địa phương, đã kéo theo sự phát triển nhanh chóng của ngành dịch vụ thứ ba tại các làng quê xung quanh một cách mạnh mẽ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '带动',
      'dàidòng',
      'dẫn dắt, kéo theo, thúc đẩy cùng phát triển (kinh tế, chuỗi ngành)',
      'Động từ',
      'HSK 5',
      '大企业落户当地后，有力带动了周边乡村第三产业的快速发展。',
      'Dà qǐyè luòhù dāngdì hòu, yǒulì dàidòng le zhōubiān xiāngcūn dì-sān chǎnyè de kuàisù fāzhǎn.',
      'Sau khi các doanh nghiệp lớn đặt trụ sở tại địa phương, đã kéo theo sự phát triển nhanh chóng của ngành dịch vụ thứ ba tại các làng quê xung quanh một cách mạnh mẽ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '大企业落户当地后，有力带动了周边乡村第三产业的快速发展。',
        'Dà qǐyè luòhù dāngdì hòu, yǒulì dàidòng le zhōubiān xiāngcūn dì-sān chǎnyè de kuàisù fāzhǎn.',
        'Sau khi các doanh nghiệp lớn đặt trụ sở tại địa phương, đã kéo theo sự phát triển nhanh chóng của ngành dịch vụ thứ ba tại các làng quê xung quanh một cách mạnh mẽ.',
        'basic',
        1
      ),
      (
        v_id,
        '国家级高新区龙头骨干企业通过开放技术研发平台与外包核心零部件订单，成功带动了上下游上千家中小微企业协同创新发展。',
        'Guójiājí gāoxīnqū lóngtóu gǔgàn qǐyè tōngguò kāifàng jìshù yánfā píngtái yǔ wàibāo héxīn língbùjiàn dìngdān, chénggōng dàidòng le shàng-xiàyóu shàng qiān jiā zhōngxiǎowēi qǐyè xiétóng chuàngxīn fāzhǎn.',
        'Doanh nghiệp đầu tàu nòng cốt tại khu công nghệ cao cấp quốc gia thông qua việc mở nền tảng nghiên cứu phát triển công nghệ và giao thầu đơn hàng linh kiện then chốt, đã thành công dẫn dắt hàng ngàn doanh nghiệp vừa, nhỏ và siêu nhỏ ở thượng hạ nguồn cùng đổi mới phát triển đồng bộ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2236] [代替] (dàitì) - thay thế, thế chỗ, thay cho [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '代替' AND pinyin = 'dàitì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '代替' AND pinyin = 'dàitì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '代替'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '代替'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dàitì',
      meaning_vi = 'thay thế, thế chỗ, thay cho',
      example_hanzi = '李老师今天生病请假了，由王老师暂时代替他来给大家上这堂数学课。',
      example_pinyin = 'Lǐ lǎoshī jīntiān shēngbìng qǐngjià le, yóu Wáng lǎoshī zànshí dàitì tā lái gěi dàjiā shàng zhè táng shùxuékè.',
      example_vi = 'Hôm nay thầy Lý bị ốm xin nghỉ phép, do thầy Vương tạm thời thay thế thầy dạy tiết toán này cho các bạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '代替',
      'dàitì',
      'thay thế, thế chỗ, thay cho',
      'Động từ',
      'HSK 5',
      '李老师今天生病请假了，由王老师暂时代替他来给大家上这堂数学课。',
      'Lǐ lǎoshī jīntiān shēngbìng qǐngjià le, yóu Wáng lǎoshī zànshí dàitì tā lái gěi dàjiā shàng zhè táng shùxuékè.',
      'Hôm nay thầy Lý bị ốm xin nghỉ phép, do thầy Vương tạm thời thay thế thầy dạy tiết toán này cho các bạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '李老师今天生病请假了，由王老师暂时代替他来给大家上这堂数学课。',
        'Lǐ lǎoshī jīntiān shēngbìng qǐngjià le, yóu Wáng lǎoshī zànshí dàitì tā lái gěi dàjiā shàng zhè táng shùxuékè.',
        'Hôm nay thầy Lý bị ốm xin nghỉ phép, do thầy Vương tạm thời thay thế thầy dạy tiết toán này cho các bạn.',
        'basic',
        1
      ),
      (
        v_id,
        '尽管生成式人工智能在辅助编程和文字撰写方面展现出强大的效率，但依然无法完全代替人类艺术家所独有的深沉情感与原创直觉。',
        'Jǐnguǎn shēngchéngxìng réngōng zhìnéng zài fǔzhù biānchéng hé wénzì zhuànxiě fāngmiàn zhǎnxiàn chū qiángdà de xiàolǜ, dàn yīrán wúfǎ wánquán dàitì rénlèi yìshùjiā suǒ dúyǒu de shēnchén qínggǎn yǔ yuánchuàng zhíjué.',
        'Mặc dù trí tuệ nhân tạo tạo sinh trong việc hỗ trợ lập trình và soạn thảo văn bản thể hiện hiệu suất mạnh mẽ, nhưng vẫn không tài nào thay thế được hoàn toàn cảm xúc sâu lắng và trực giác sáng tạo độc bản vốn có của các nghệ sĩ con người.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2237] [待遇] (dàiyù) - chế độ đãi ngộ (tiền lương, phúc lợi, bổng lộc, sự tiếp đãi) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '待遇' AND pinyin = 'dàiyù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '待遇' AND pinyin = 'dàiyù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '待遇'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '待遇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàiyù',
      meaning_vi = 'chế độ đãi ngộ (tiền lương, phúc lợi, bổng lộc, sự tiếp đãi)',
      example_hanzi = '这家外企为员工提供了优厚的薪资待遇和完善的带薪休假福利。',
      example_pinyin = 'Zhè jiā wàiqǐ wèi yuángōng tígōng le yōuhòu de xīnzī dàiyù hé wánshàn de dàixīn xiūjià fúlì.',
      example_vi = 'Doanh nghiệp nước ngoài này cung cấp cho nhân viên chế độ đãi ngộ tiền lương hậu hĩnh và phúc lợi nghỉ phép có lương hoàn thiện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '待遇',
      'dàiyù',
      'chế độ đãi ngộ (tiền lương, phúc lợi, bổng lộc, sự tiếp đãi)',
      'Danh từ',
      'HSK 5',
      '这家外企为员工提供了优厚的薪资待遇和完善的带薪休假福利。',
      'Zhè jiā wàiqǐ wèi yuángōng tígōng le yōuhòu de xīnzī dàiyù hé wánshàn de dàixīn xiūjià fúlì.',
      'Doanh nghiệp nước ngoài này cung cấp cho nhân viên chế độ đãi ngộ tiền lương hậu hĩnh và phúc lợi nghỉ phép có lương hoàn thiện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这家外企为员工提供了优厚的薪资待遇和完善的带薪休假福利。',
        'Zhè jiā wàiqǐ wèi yuángōng tígōng le yōuhòu de xīnzī dàiyù hé wánshàn de dàixīn xiūjià fúlì.',
        'Doanh nghiệp nước ngoài này cung cấp cho nhân viên chế độ đãi ngộ tiền lương hậu hĩnh và phúc lợi nghỉ phép có lương hoàn thiện.',
        'basic',
        1
      ),
      (
        v_id,
        '为了在全球范围内延揽顶尖科技战略人才，该国家实验室不仅开出了极具行业竞争力的薪酬待遇，还全方位解决了家属落户与子女优质入学问题。',
        'Wèile zài quánqiú fànwéi nèi yánlǎn dǐngjiān kējì zhànlüè réncái, gāi guójiā shíyànshì bùjǐn kāi chū le jí jù hángyè jìngzhēnglì de xīnchóu dàiyù, hái quán fāngwèi jiějué le jiāshǔ luòhù yǔ zǐnǚ yōuzhì rùxué wèntí.',
        'Để chiêu mộ nhân tài chiến lược khoa học công nghệ đỉnh cao trên quy mô toàn cầu, phòng thí nghiệm quốc gia này không chỉ đưa ra mức đãi ngộ tiền lương cực kỳ có sức cạnh tranh trong ngành, mà còn giải quyết toàn diện vấn đề nhập hộ khẩu cho gia đình và cho con cái vào học trường chất lượng cao.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2238] [单] (dān) - đơn độc, lẻ loi; hóa đơn, danh sách giấy tờ [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '单' AND pinyin = 'dān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '单' AND pinyin = 'dān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '单'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '单'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'dān',
      meaning_vi = 'đơn độc, lẻ loi; hóa đơn, danh sách giấy tờ',
      example_hanzi = '吃完饭结账后，服务员礼貌地把详细的消费账单递到了顾客面前。',
      example_pinyin = 'Chī wán fàn jiézhàng hòu, fúwùyuán lǐmào de bǎ xiángxì de xiāofèi zhàngdān dì dào le gùkè miànqián.',
      example_vi = 'Sau khi ăn cơm xong thanh toán, nhân viên phục vụ lịch sự đưa hóa đơn thanh toán tiêu dùng chi tiết đến trước mặt khách hàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '单',
      'dān',
      'đơn độc, lẻ loi; hóa đơn, danh sách giấy tờ',
      'Tính từ / Danh từ',
      'HSK 5',
      '吃完饭结账后，服务员礼貌地把详细的消费账单递到了顾客面前。',
      'Chī wán fàn jiézhàng hòu, fúwùyuán lǐmào de bǎ xiángxì de xiāofèi zhàngdān dì dào le gùkè miànqián.',
      'Sau khi ăn cơm xong thanh toán, nhân viên phục vụ lịch sự đưa hóa đơn thanh toán tiêu dùng chi tiết đến trước mặt khách hàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '吃完饭结账后，服务员礼貌地把详细的消费账单递到了顾客面前。',
        'Chī wán fàn jiézhàng hòu, fúwùyuán lǐmào de bǎ xiángxì de xiāofèi zhàngdān dì dào le gùkè miànqián.',
        'Sau khi ăn cơm xong thanh toán, nhân viên phục vụ lịch sự đưa hóa đơn thanh toán tiêu dùng chi tiết đến trước mặt khách hàng.',
        'basic',
        1
      ),
      (
        v_id,
        '在现代社会复杂的经济往来中，任何大宗商业采购合同都必须附带经过严格法律合规审核的货物验收清单与发票凭证。',
        'Zài xiàndài shèhuì fùzá de jīngjì wǎnglái zhōng, rènhé dàzōng shāngyè cǎigòu hétong dōu bìxū fùdài jīngguò yángé fǎlǜ hégī shěnchá de huòwù yànshōu qīngdān yǔ fāpiào píngzhèng.',
        'Trong các mối giao dịch kinh tế phức tạp của xã hội hiện đại, bất kỳ hợp đồng thu mua thương mại khối lượng lớn nào cũng bắt buộc phải đính kèm danh mục nghiệm thu hàng hóa và chứng từ hóa đơn đã qua xét duyệt tuân thủ pháp luật nghiêm ngặt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2239] [单独] (dāndú) - một mình, đơn độc, riêng rẽ độc lập [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '单独' AND pinyin = 'dāndú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '单独' AND pinyin = 'dāndú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '单独'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '单独'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'dāndú',
      meaning_vi = 'một mình, đơn độc, riêng rẽ độc lập',
      example_hanzi = '由于年纪太小，父母严禁小孩子单独前往水库或河边游泳。',
      example_pinyin = 'Yóuyú niánjì tài xiǎo, fùmǔ yánjìn xiǎo háizi dāndú qiánwǎng shuǐkù huò hébiān yóuyǒng.',
      example_vi = 'Vì tuổi còn quá nhỏ, cha mẹ nghiêm cấm trẻ con một mình đi ra hồ chứa nước hoặc bờ sông bơi lội.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '单独',
      'dāndú',
      'một mình, đơn độc, riêng rẽ độc lập',
      'Phó từ',
      'HSK 5',
      '由于年纪太小，父母严禁小孩子单独前往水库或河边游泳。',
      'Yóuyú niánjì tài xiǎo, fùmǔ yánjìn xiǎo háizi dāndú qiánwǎng shuǐkù huò hébiān yóuyǒng.',
      'Vì tuổi còn quá nhỏ, cha mẹ nghiêm cấm trẻ con một mình đi ra hồ chứa nước hoặc bờ sông bơi lội.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '由于年纪太小，父母严禁小孩子单独前往水库或河边游泳。',
        'Yóuyú niánjì tài xiǎo, fùmǔ yánjìn xiǎo háizi dāndú qiánwǎng shuǐkù huò hébiān yóuyǒng.',
        'Vì tuổi còn quá nhỏ, cha mẹ nghiêm cấm trẻ con một mình đi ra hồ chứa nước hoặc bờ sông bơi lội.',
        'basic',
        1
      ),
      (
        v_id,
        '在跨国并购反垄断审查过程中，主管机构要求涉案外资企业必须对争议业务板块设立单独法人的财务核算与运营实体。',
        'Zài kuàguó bìnggòu fǎn-lǒngduàn shěnchá guòchéng zhōng, zhǔguǎn jīgòu yāoqiú shè’àn wàizī qǐyè bìxū duì zhēngyì yèwù bǎikuài shèlì dāndú fǎrén de cáiwù hésuàn yǔ yùnyíng shítǐ.',
        'Trong quá trình xét duyệt chống độc quyền của thương vụ mua lại xuyên quốc gia, cơ quan chủ quản yêu cầu doanh nghiệp vốn nước ngoài liên quan bắt buộc phải thành lập một thực thể vận hành và hạch toán tài chính pháp nhân riêng rẽ cho mảng nghiệp vụ còn tranh cãi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2240] [担任] (dānrèn) - đảm nhiệm, giữ chức vụ, phụ trách chức vụ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '担任' AND pinyin = 'dānrèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '担任' AND pinyin = 'dānrèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '担任'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '担任'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dānrèn',
      meaning_vi = 'đảm nhiệm, giữ chức vụ, phụ trách chức vụ',
      example_hanzi = '他在大学期间连续三年担任学生会主席，工作能力得到了老师和同学们的一致认可。',
      example_pinyin = 'Tā zài dàxué qījiān liánxù sān nián dānrèn xuéshenghuì zhǔxí, gōngzuò nénglì dédào le lǎoshī hé tóngxuémen de yízhì rènkě.',
      example_vi = 'Thời đại học bạn ấy đã giữ chức chủ tịch hội sinh viên liên tục ba năm, năng lực công tác nhận được sự công nhận nhất trí từ thầy cô và bạn bè.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '担任',
      'dānrèn',
      'đảm nhiệm, giữ chức vụ, phụ trách chức vụ',
      'Động từ',
      'HSK 5',
      '他在大学期间连续三年担任学生会主席，工作能力得到了老师和同学们的一致认可。',
      'Tā zài dàxué qījiān liánxù sān nián dānrèn xuéshenghuì zhǔxí, gōngzuò nénglì dédào le lǎoshī hé tóngxuémen de yízhì rènkě.',
      'Thời đại học bạn ấy đã giữ chức chủ tịch hội sinh viên liên tục ba năm, năng lực công tác nhận được sự công nhận nhất trí từ thầy cô và bạn bè.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他在大学期间连续三年担任学生会主席，工作能力得到了老师和同学们的一致认可。',
        'Tā zài dàxué qījiān liánxù sān nián dānrèn xuéshenghuì zhǔxí, gōngzuò nénglì dédào le lǎoshī hé tóngxuémen de yízhì rènkě.',
        'Thời đại học bạn ấy đã giữ chức chủ tịch hội sinh viên liên tục ba năm, năng lực công tác nhận được sự công nhận nhất trí từ thầy cô và bạn bè.',
        'basic',
        1
      ),
      (
        v_id,
        '经过董事会审慎考察与民主投票表决，决定聘任具有深厚国际金融从业背景的张博士正式担任集团首席财务执行官。',
        'Jīngguò dǒngshìhuì shènzhòng kǎochá yǔ mínzhǔ tóupiào biǎojué, juédìng pìnrèn jùyǒu shēnhòu guójì jīnróng cóngyè bèijǐng de Zhāng bóshì zhèngshì dānrèn jítuán shǒuxí cáiwù zhíxíngguān.',
        'Qua sự khảo sát thận trọng và bỏ phiếu biểu quyết dân chủ của hội đồng quản trị, đã quyết định bổ nhiệm tiến sĩ Trương - người có bề dày kinh nghiệm sâu sắc trong lĩnh vực tài chính quốc tế - chính thức đảm nhiệm chức vụ Giám đốc Tài chính (CFO) của tập đoàn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2241] [单一] (dānyī) - đơn nhất, đơn điệu, một vẻ (nguồn cung, mô hình, cấu trúc) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '单一' AND pinyin = 'dānyī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '单一' AND pinyin = 'dānyī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '单一'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '单一'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'dānyī',
      meaning_vi = 'đơn nhất, đơn điệu, một vẻ (nguồn cung, mô hình, cấu trúc)',
      example_hanzi = '如果一个地方的经济仅仅依赖单一的煤炭采掘产业，抵御外部市场风险的能力就会非常脆弱。',
      example_pinyin = 'Rúguǒ yí gè dìfang de jīngjì jǐnjǐn yīlài dānyī de méitàn cǎijué chǎnyè, dǐyù wàibù shìchǎng fēngxiǎn de nénglì jiù huì fēicháng cuìruò.',
      example_vi = 'Nếu nền kinh tế của một địa phương chỉ phụ thuộc vào ngành công nghiệp khai thác than đá đơn nhất, thì năng lực chống đỡ rủi ro thị trường bên ngoài sẽ vô cùng mong manh yếu ớt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '单一',
      'dānyī',
      'đơn nhất, đơn điệu, một vẻ (nguồn cung, mô hình, cấu trúc)',
      'Tính từ',
      'HSK 5',
      '如果一个地方的经济仅仅依赖单一的煤炭采掘产业，抵御外部市场风险的能力就会非常脆弱。',
      'Rúguǒ yí gè dìfang de jīngjì jǐnjǐn yīlài dānyī de méitàn cǎijué chǎnyè, dǐyù wàibù shìchǎng fēngxiǎn de nénglì jiù huì fēicháng cuìruò.',
      'Nếu nền kinh tế của một địa phương chỉ phụ thuộc vào ngành công nghiệp khai thác than đá đơn nhất, thì năng lực chống đỡ rủi ro thị trường bên ngoài sẽ vô cùng mong manh yếu ớt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '如果一个地方的经济仅仅依赖单一的煤炭采掘产业，抵御外部市场风险的能力就会非常脆弱。',
        'Rúguǒ yí gè dìfang de jīngjì jǐnjǐn yīlài dānyī de méitàn cǎijué chǎnyè, dǐyù wàibù shìchǎng fēngxiǎn de nénglì jiù huì fēicháng cuìruò.',
        'Nếu nền kinh tế của một địa phương chỉ phụ thuộc vào ngành công nghiệp khai thác than đá đơn nhất, thì năng lực chống đỡ rủi ro thị trường bên ngoài sẽ vô cùng mong manh yếu ớt.',
        'basic',
        1
      ),
      (
        v_id,
        '为了摆脱过去依赖单一出口退税驱动的被动贸易局面，沿海各省积极引导跨境电商企业实施多元化全球市场布局与自主品牌直销战略。',
        'Wèile bǎituō guòqù yīlài dānyī chūkǒu tuìshuì qūdòng de bèidòng màoyì júmiàn, yánhǎi gè shěng jījí yǐndǎo kuàjìng diànshāng qǐyè shíshī duōyuánhuà quánqiú shìchǎng bùjú yǔ zìzhǔ pǐnpái zhíxiāo zhànlüè.',
        'Để thoát khỏi cục diện thương mại thụ động trước đây vốn chỉ dựa vào động lực hoàn thuế xuất khẩu đơn nhất, các tỉnh ven biển đã tích cực hướng dẫn doanh nghiệp thương mại điện tử xuyên biên giới thực hiện chiến lược bố cục thị trường toàn cầu đa dạng hóa và bán hàng trực tiếp bằng thương hiệu tự chủ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2242] [单元] (dānyuán) - đơn nguyên, căn hộ cầu thang; bài học/chủ điểm (trong sách giáo khoa) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '单元' AND pinyin = 'dānyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '单元' AND pinyin = 'dānyuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '单元'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '单元'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dānyuán',
      meaning_vi = 'đơn nguyên, căn hộ cầu thang; bài học/chủ điểm (trong sách giáo khoa)',
      example_hanzi = '中文教材的每个单元都围绕着一个贴近实际生活的主题展开生动的情景对话教学。',
      example_pinyin = 'Zhōngwén jiàocái de měi gè dānyuán dōu wéirào zhe yí gè tiējìn shíjì shēnghuó de zhǔtí zhǎnkāi shēngdòng de qíngjǐng duìhuà jiàoxué.',
      example_vi = 'Mỗi một bài học/chủ điểm của giáo trình tiếng Trung đều xoay quanh một chủ đề gần gũi với đời sống thực tế để triển khai giảng dạy đối thoại tình huống sinh động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '单元',
      'dānyuán',
      'đơn nguyên, căn hộ cầu thang; bài học/chủ điểm (trong sách giáo khoa)',
      'Danh từ',
      'HSK 5',
      '中文教材的每个单元都围绕着一个贴近实际生活的主题展开生动的情景对话教学。',
      'Zhōngwén jiàocái de měi gè dānyuán dōu wéirào zhe yí gè tiējìn shíjì shēnghuó de zhǔtí zhǎnkāi shēngdòng de qíngjǐng duìhuà jiàoxué.',
      'Mỗi một bài học/chủ điểm của giáo trình tiếng Trung đều xoay quanh một chủ đề gần gũi với đời sống thực tế để triển khai giảng dạy đối thoại tình huống sinh động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '中文教材的每个单元都围绕着一个贴近实际生活的主题展开生动的情景对话教学。',
        'Zhōngwén jiàocái de měi gè dānyuán dōu wéirào zhe yí gè tiējìn shíjì shēnghuó de zhǔtí zhǎnkāi shēngdòng de qíngjǐng duìhuà jiàoxué.',
        'Mỗi một bài học/chủ điểm của giáo trình tiếng Trung đều xoay quanh một chủ đề gần gũi với đời sống thực tế để triển khai giảng dạy đối thoại tình huống sinh động.',
        'basic',
        1
      ),
      (
        v_id,
        '高层现代化智慧住宅小区对每个单元门都安装了集成指纹防伪、动态人脸识别与可视云对讲的安全门禁安防管理系统。',
        'Gāocéng xiàndàihuà zhìhuì zhùzhái xiǎoqū duì měi gè dānyuánmén dōu ānzhuāng le jíchéng zhǐwén fángwěi, dòngtài rénliǎn shíbié yǔ kěshì yún duìjiǎng de ānquán ménjìn ānfáng guǎnlǐ xìtǒng.',
        'Khu chung cư thông minh hiện đại cao tầng đã lắp đặt hệ thống quản lý an ninh cửa vào an toàn tích hợp chống giả mạo vân tay, nhận diện khuôn mặt động và đàm thoại video đám mây cho từng cửa căn hộ/cầu thang chung.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2243] [胆小] (dǎnxiǎo) - nhát gan, nhút nhát, sợ sệt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '胆小' AND pinyin = 'dǎnxiǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胆小' AND pinyin = 'dǎnxiǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '胆小'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胆小'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'dǎnxiǎo',
      meaning_vi = 'nhát gan, nhút nhát, sợ sệt',
      example_hanzi = '妹妹从小就很胆小，天一黑甚至连自己一个人去洗手间都不敢。',
      example_pinyin = 'Mèimei cóngxiǎo jiù hěn dǎnxiǎo, tiān yì hēi shènzhì lián zìjǐ yí gè rén qù xǐshǒujiān dōu bù gǎn.',
      example_vi = 'Em gái từ nhỏ đã rất nhút nhát, trời vừa tối thậm chí ngay cả một mình đi vào nhà vệ sinh cũng không dám.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '胆小',
      'dǎnxiǎo',
      'nhát gan, nhút nhát, sợ sệt',
      'Tính từ',
      'HSK 5',
      '妹妹从小就很胆小，天一黑甚至连自己一个人去洗手间都不敢。',
      'Mèimei cóngxiǎo jiù hěn dǎnxiǎo, tiān yì hēi shènzhì lián zìjǐ yí gè rén qù xǐshǒujiān dōu bù gǎn.',
      'Em gái từ nhỏ đã rất nhút nhát, trời vừa tối thậm chí ngay cả một mình đi vào nhà vệ sinh cũng không dám.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '妹妹从小就很胆小，天一黑甚至连自己一个人去洗手间都不敢。',
        'Mèimei cóngxiǎo jiù hěn dǎnxiǎo, tiān yì hēi shènzhì lián zìjǐ yí gè rén qù xǐshǒujiān dōu bù gǎn.',
        'Em gái từ nhỏ đã rất nhút nhát, trời vừa tối thậm chí ngay cả một mình đi vào nhà vệ sinh cũng không dám.',
        'basic',
        1
      ),
      (
        v_id,
        '面对充满未知风险的新兴蓝海商业赛道，一味畏首畏尾、过度胆小保守的企业终将在飞速迭代的市场竞争浪潮中错失宝贵的发展黄金期。',
        'Miànduì chōngmǎn wèizhī fēngxiǎn de xīnxīng lánhǎi shāngyè sàidào, yíwèi wèishǒu-wèiwěi, guòdù dǎnxiǎo bǎoshǒu de qǐyè zhōng jiāng zài fēisù diédài de shìchǎng jìngzhēng làngcháo zhōng cuòshī bǎoguì de fāzhǎn huángjīnqī.',
        'Đối mặt với đường đua kinh doanh đại dương xanh mới nổi đầy ắp rủi ro chưa biết, những doanh nghiệp một mực sợ đầu sợ đuôi, quá đỗi nhút nhát bảo thủ rốt cuộc sẽ bỏ lỡ thời kỳ vàng phát triển quý báu trong làn sóng cạnh tranh thị trường đổi mới với tốc độ chóng mặt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2244] [淡] (dàn) - nhạt (vị giác, màu sắc); mờ nhạt, hờ hững (tình cảm, quan hệ) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '淡' AND pinyin = 'dàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '淡' AND pinyin = 'dàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '淡'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '淡'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'dàn',
      meaning_vi = 'nhạt (vị giác, màu sắc); mờ nhạt, hờ hững (tình cảm, quan hệ)',
      example_hanzi = '医生叮嘱高血压患者平时饮食一定要少油少盐，保持清淡。',
      example_pinyin = 'Yīshēng dīngzhǔ gāoxuèyā huànzhě píngshí yǐnshí yídìng yào shǎo yóu shǎo yán, bǎochí qīngdàn.',
      example_vi = 'Bác sĩ dặn dò người bệnh cao huyết áp chế độ ăn uống hằng ngày nhất định phải ít dầu ít muối, giữ cho thanh đạm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '淡',
      'dàn',
      'nhạt (vị giác, màu sắc); mờ nhạt, hờ hững (tình cảm, quan hệ)',
      'Tính từ',
      'HSK 5',
      '医生叮嘱高血压患者平时饮食一定要少油少盐，保持清淡。',
      'Yīshēng dīngzhǔ gāoxuèyā huànzhě píngshí yǐnshí yídìng yào shǎo yóu shǎo yán, bǎochí qīngdàn.',
      'Bác sĩ dặn dò người bệnh cao huyết áp chế độ ăn uống hằng ngày nhất định phải ít dầu ít muối, giữ cho thanh đạm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '医生叮嘱高血压患者平时饮食一定要少油少盐，保持清淡。',
        'Yīshēng dīngzhǔ gāoxuèyā huànzhě píngshí yǐnshí yídìng yào shǎo yóu shǎo yán, bǎochí qīngdàn.',
        'Bác sĩ dặn dò người bệnh cao huyết áp chế độ ăn uống hằng ngày nhất định phải ít dầu ít muối, giữ cho thanh đạm.',
        'basic',
        1
      ),
      (
        v_id,
        '在快节奏的现代都市商业生活中，人与人之间的纯粹友情不能因追逐功利而逐渐变淡疏远，需要经常真诚走动与心灵关照。',
        'Zài kuàijièzòu de xiàndài dūshì shāngyè shēnghuó zhōng, rén yǔ rén zhījiān de chúncuì yǒuqíng bù néng yīn zhuīzhú gōnglì ér zhújiàn biàn dàn shūyuǎn, xūyào jīngcháng zhēnchéng zǒudòng yǔ xīnlíng guānzhào.',
        'Trong đời sống thương nghiệp đô thị hiện đại nhịp sống hối hả, tình bạn thuần khiết giữa con người với nhau không thể vì mải mê theo đuổi danh lợi mà dần dà trở nên nhạt nhẽo xa cách, mà cần phải thường xuyên chân thành qua lại thăm hỏi và thấu hiểu lòng nhau.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2245] [当地] (dāngdì) - địa phương sở tại, bản xứ, bản địa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '当地' AND pinyin = 'dāngdì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当地' AND pinyin = 'dāngdì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '当地'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当地'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dāngdì',
      meaning_vi = 'địa phương sở tại, bản xứ, bản địa',
      example_hanzi = '每到一个新的城市旅游，他都喜欢走进当地的传统集市去感受最真实的市井烟火气息。',
      example_pinyin = 'Měi dào yí gè xīn de chéngshì lǚyóu, tā dōu xǐhuan zǒu jìn dāngdì de chuántǒng jíshì qù gǎnshòu zuì zhēnshí de shìjǐng yānhuǒ qìxī.',
      example_vi = 'Mỗi khi đến một thành phố mới du lịch, anh ấy đều thích bước vào khu chợ truyền thống địa phương để cảm nhận bầu không khí đời sống chợ búa bình dị chân thực nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '当地',
      'dāngdì',
      'địa phương sở tại, bản xứ, bản địa',
      'Danh từ',
      'HSK 5',
      '每到一个新的城市旅游，他都喜欢走进当地的传统集市去感受最真实的市井烟火气息。',
      'Měi dào yí gè xīn de chéngshì lǚyóu, tā dōu xǐhuan zǒu jìn dāngdì de chuántǒng jíshì qù gǎnshòu zuì zhēnshí de shìjǐng yānhuǒ qìxī.',
      'Mỗi khi đến một thành phố mới du lịch, anh ấy đều thích bước vào khu chợ truyền thống địa phương để cảm nhận bầu không khí đời sống chợ búa bình dị chân thực nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '每到一个新的城市旅游，他都喜欢走进当地的传统集市去感受最真实的市井烟火气息。',
        'Měi dào yí gè xīn de chéngshì lǚyóu, tā dōu xǐhuan zǒu jìn dāngdì de chuántǒng jíshì qù gǎnshòu zuì zhēnshí de shìjǐng yānhuǒ qìxī.',
        'Mỗi khi đến một thành phố mới du lịch, anh ấy đều thích bước vào khu chợ truyền thống địa phương để cảm nhận bầu không khí đời sống chợ búa bình dị chân thực nhất.',
        'basic',
        1
      ),
      (
        v_id,
        '跨国企业在外派员工前往海外新兴投资目的地前，必须组织系统的跨文化跨国培训，教育员工自觉尊重当地的宗教民俗风情与法律法规。',
        'Kuàguó qǐyè zài wàipài yuángōng qiánwǎng hǎiwài xīnxīng tóuzī mùdìdì qián, bìxū zǔzhī xìtǒng de kuà wénhuà kuàguó péixùn, jiàoyù yuángōng zìjué zūnzhòng dāngdì de zōngjiào mínsú fēngqíng yǔ fǎlǜ fǎguī.',
        'Doanh nghiệp đa quốc gia trước khi phái cử nhân viên ra nước ngoài đến các điểm đến đầu tư mới nổi, bắt buộc phải tổ chức các khóa đào tạo liên văn hóa xuyên quốc gia có hệ thống, giáo dục nhân viên tự giác tôn trọng phong tục tập quán tôn giáo và luật pháp quy định của địa phương sở tại.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2246] [当年] (dāngnián) - năm đó, năm ấy; thời tuổi trẻ xuân thì [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '当年' AND pinyin = 'dāngnián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当年' AND pinyin = 'dāngnián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '当年'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dāngnián',
      meaning_vi = 'năm đó, năm ấy; thời tuổi trẻ xuân thì',
      example_hanzi = '回忆起当年刚进大学校园时的青涩模样，老同学们感慨万千。',
      example_pinyin = 'Huíyì qǐ dāngnián gāng jìn dàxué xiàoyuán shí de qīngsè múyàng, lǎo tóngxuémen gǎnkǎi-wànqiān.',
      example_vi = 'Nhớ lại dáng vẻ ngây ngô non nớt năm ấy lúc mới bước chân vào khuôn viên đại học, những người bạn học cũ bùi ngùi xúc động muôn vàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '当年',
      'dāngnián',
      'năm đó, năm ấy; thời tuổi trẻ xuân thì',
      'Danh từ',
      'HSK 5',
      '回忆起当年刚进大学校园时的青涩模样，老同学们感慨万千。',
      'Huíyì qǐ dāngnián gāng jìn dàxué xiàoyuán shí de qīngsè múyàng, lǎo tóngxuémen gǎnkǎi-wànqiān.',
      'Nhớ lại dáng vẻ ngây ngô non nớt năm ấy lúc mới bước chân vào khuôn viên đại học, những người bạn học cũ bùi ngùi xúc động muôn vàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '回忆起当年刚进大学校园时的青涩模样，老同学们感慨万千。',
        'Huíyì qǐ dāngnián gāng jìn dàxué xiàoyuán shí de qīngsè múyàng, lǎo tóngxuémen gǎnkǎi-wànqiān.',
        'Nhớ lại dáng vẻ ngây ngô non nớt năm ấy lúc mới bước chân vào khuôn viên đại học, những người bạn học cũ bùi ngùi xúc động muôn vàn.',
        'basic',
        1
      ),
      (
        v_id,
        '这位老红军战士指着军事博物馆里展陈的一件件老旧装备，神采奕奕地向青年一代重温当年抗战烽火连天岁月里的英雄悲壮历程。',
        'Zhè wèi lǎo hóngjūn zhànshì zhǐ zhe jūnshì bówùguǎn lǐ zhǎnchén de yí jiànjiàn lǎojiù zhuāngbèi, shéncǎi-yìyì de xiàng qīngnián yídài chóngwēn dāngnián kàngzhàn fēnghuǒ-liántiān suìyuè lǐ de yīngxióng bēizhuàng lìchéng.',
        'Người chiến sĩ Hồng quân năm xưa chỉ vào từng hiện vật trang bị cũ kỹ được trưng bày trong bảo tàng quân sự, thần thái ngời ngời cùng thế hệ trẻ ôn lại chặng đường bi tráng anh hùng trong những năm tháng kháng chiến lửa khói ngập trời năm nào.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2247] [当前] (dāngqián) - hiện tại, trước mắt, thời điểm hiện nay [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '当前' AND pinyin = 'dāngqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当前' AND pinyin = 'dāngqián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '当前'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当前'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dāngqián',
      meaning_vi = 'hiện tại, trước mắt, thời điểm hiện nay',
      example_hanzi = '做好毕业论文答辩和求职面试是我们当前阶段最紧迫的核心任务。',
      example_pinyin = 'Zuò hǎo bìyè lùnwén dábiàn hé qiúzhí miànshì shì wǒmen dāngqián jiēduàn zuì jǐnpò de héxīn rènwu.',
      example_vi = 'Làm tốt việc bảo vệ khóa luận tốt nghiệp và phỏng vấn xin việc là nhiệm vụ cốt lõi cấp bách nhất trong giai đoạn hiện nay của chúng ta.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '当前',
      'dāngqián',
      'hiện tại, trước mắt, thời điểm hiện nay',
      'Danh từ',
      'HSK 5',
      '做好毕业论文答辩和求职面试是我们当前阶段最紧迫的核心任务。',
      'Zuò hǎo bìyè lùnwén dábiàn hé qiúzhí miànshì shì wǒmen dāngqián jiēduàn zuì jǐnpò de héxīn rènwu.',
      'Làm tốt việc bảo vệ khóa luận tốt nghiệp và phỏng vấn xin việc là nhiệm vụ cốt lõi cấp bách nhất trong giai đoạn hiện nay của chúng ta.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '做好毕业论文答辩和求职面试是我们当前阶段最紧迫的核心任务。',
        'Zuò hǎo bìyè lùnwén dábiàn hé qiúzhí miànshì shì wǒmen dāngqián jiēduàn zuì jǐnpò de héxīn rènwu.',
        'Làm tốt việc bảo vệ khóa luận tốt nghiệp và phỏng vấn xin việc là nhiệm vụ cốt lõi cấp bách nhất trong giai đoạn hiện nay của chúng ta.',
        'basic',
        1
      ),
      (
        v_id,
        '面对当前错综复杂的国际地缘政治格局与全球通货膨胀上行压力，各国唯有坚持多边主义对话协商，才能共同化解危机难题。',
        'Miànduì dāngqián cuòzōng-fùzá de guójì dìyuán zhèngzhì géjú yǔ quánqiú tōnghuò péngzhàng shàngxíng yālì, gè guó wéi yǒu jiānchí duōbiānzhǔyì duìhuà xiéshāng, cái néng gòngtóng huàjiě wēijī nántí.',
        'Đối mặt với cục diện địa chính trị quốc tế đan xen phức tạp cùng áp lực lạm phát toàn cầu gia tăng hiện nay, các nước chỉ khi kiên trì đối thoại hiệp thương chủ nghĩa đa phương thì mới có thể cùng nhau hóa giải những bài toán khủng hoảng hóc búa.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2248] [当中] (dāngzhōng) - ở giữa, ở trong số đó, trong quá trình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '当中' AND pinyin = 'dāngzhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当中' AND pinyin = 'dāngzhōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '当中'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当中'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dāngzhōng',
      meaning_vi = 'ở giữa, ở trong số đó, trong quá trình',
      example_hanzi = '在今天参加复试的数十位优秀应聘者当中，只有两位最终能够获得正式录用通知。',
      example_pinyin = 'Zài jīntiān cānjiā fùshì de shù shí wèi yōuxiù yìngpìnzhě dāngzhōng, zhǐyǒu liǎng wèi zuìzhōng nénggòu huòdé zhèngshì lùyòng tōngzhī.',
      example_vi = 'Trong số hàng chục ứng viên xuất sắc tham gia vòng phỏng vấn thứ hai hôm nay, chỉ có hai người rốt cuộc nhận được thông báo tuyển dụng chính thức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '当中',
      'dāngzhōng',
      'ở giữa, ở trong số đó, trong quá trình',
      'Danh từ',
      'HSK 5',
      '在今天参加复试的数十位优秀应聘者当中，只有两位最终能够获得正式录用通知。',
      'Zài jīntiān cānjiā fùshì de shù shí wèi yōuxiù yìngpìnzhě dāngzhōng, zhǐyǒu liǎng wèi zuìzhōng nénggòu huòdé zhèngshì lùyòng tōngzhī.',
      'Trong số hàng chục ứng viên xuất sắc tham gia vòng phỏng vấn thứ hai hôm nay, chỉ có hai người rốt cuộc nhận được thông báo tuyển dụng chính thức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在今天参加复试的数十位优秀应聘者当中，只有两位最终能够获得正式录用通知。',
        'Zài jīntiān cānjiā fùshì de shù shí wèi yōuxiù yìngpìnzhě dāngzhōng, zhǐyǒu liǎng wèi zuìzhōng nénggòu huòdé zhèngshì lùyòng tōngzhī.',
        'Trong số hàng chục ứng viên xuất sắc tham gia vòng phỏng vấn thứ hai hôm nay, chỉ có hai người rốt cuộc nhận được thông báo tuyển dụng chính thức.',
        'basic',
        1
      ),
      (
        v_id,
        '高水平科研攻关在具体推进当中难免会遇到无数不可预知的技术瓶颈与失败挫折，唯有咬定青山不放松的韧劲才能攀登科学巅峰。',
        'Gāo shuǐpíng kēyán gōngguān zài jùtǐ tuījìn dāngzhōng nánmiǎn huì yùdào wúshù bùkě-yùzhī de jìshù píngjǐng yǔ shībài cuòzhé, wéi yǒu yǎodìng qīngshān bù fàngsōng de rènjìn cái néng pāndēng kēxué diānfēng.',
        'Việc khắc phục nghiên cứu khoa học trình độ cao trong quá trình triển khai cụ thể khó tránh khỏi gặp vô số nút thắt công nghệ không thể lường trước cùng thất bại trắc trở, chỉ có sự kiên cường sắt đá không buông lơi mới có thể leo lên đỉnh cao khoa học.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2249] [挡] (dǎng) - ngăn, chắn, che khuất (gió, mưa, ánh sáng, tầm nhìn) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '挡' AND pinyin = 'dǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挡' AND pinyin = 'dǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '挡'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挡'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dǎng',
      meaning_vi = 'ngăn, chắn, che khuất (gió, mưa, ánh sáng, tầm nhìn)',
      example_hanzi = '夏天的阳光太刺眼了，妈妈赶紧戴上墨镜来挡住刺目的强光。',
      example_pinyin = 'Xiàtiān de yángguāng tài cìyǎn le, māma gǎnjǐn dài shàng mòjìng lái dǎngzhù cìmù de qiángguāng.',
      example_vi = 'Ánh nắng mùa hè chói mắt quá, mẹ mau chóng đeo kính râm để che chắn ánh sáng chói chang gay gắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '挡',
      'dǎng',
      'ngăn, chắn, che khuất (gió, mưa, ánh sáng, tầm nhìn)',
      'Động từ',
      'HSK 5',
      '夏天的阳光太刺眼了，妈妈赶紧戴上墨镜来挡住刺目的强光。',
      'Xiàtiān de yángguāng tài cìyǎn le, māma gǎnjǐn dài shàng mòjìng lái dǎngzhù cìmù de qiángguāng.',
      'Ánh nắng mùa hè chói mắt quá, mẹ mau chóng đeo kính râm để che chắn ánh sáng chói chang gay gắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '夏天的阳光太刺眼了，妈妈赶紧戴上墨镜来挡住刺目的强光。',
        'Xiàtiān de yángguāng tài cìyǎn le, māma gǎnjǐn dài shàng mòjìng lái dǎngzhù cìmù de qiángguāng.',
        'Ánh nắng mùa hè chói mắt quá, mẹ mau chóng đeo kính râm để che chắn ánh sáng chói chang gay gắt.',
        'basic',
        1
      ),
      (
        v_id,
        '任何逆全球化的贸易壁垒和技术单边封锁，都绝对无法阻挡人类追求科技共同进步与共享开放发展繁荣的浩荡历史潮流。',
        'Rènhé nì quánqiúhuà de màoyì bìlěi hé jìshù dānbiān fēngsuǒ, dōu juéduì wúfǎ zǔdǎng rénlèi zhuīqiú kējì gòngtóng jìnbù yǔ gòngxiǎng kāifàng fāzhǎn fánróng de hàodàng lìshǐ cháoliú.',
        'Bất kỳ hàng rào thương mại đi ngược toàn cầu hóa và sự phong tỏa công nghệ đơn phương nào cũng tuyệt đối không tài nào ngăn cản được dòng thác lịch sử cuồn cuộn của loài người trên con đường mưu cầu tiến bộ công nghệ chung và cùng chia sẻ phát triển phồn vinh cởi mở.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2250] [当] (dāng) - làm, đảm nhiệm (nghề nghiệp, chức vụ); vào lúc, khi (thời gian) [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '当' AND pinyin = 'dāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当' AND pinyin = 'dāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '当'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Giới từ',
      pinyin = 'dāng',
      meaning_vi = 'làm, đảm nhiệm (nghề nghiệp, chức vụ); vào lúc, khi (thời gian)',
      example_hanzi = '他从小立志长大后要当一名救死扶伤的人民医生。',
      example_pinyin = 'Tā cóngxiǎo lìzhì zhǎngdà hòu yào dāng yì míng jiùsǐ-fúshāng de rénmín yīshēng.',
      example_vi = 'Từ nhỏ bạn ấy đã lập chí sau khi lớn lên sẽ làm một người bác sĩ nhân dân cứu chữa người bệnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '当',
      'dāng',
      'làm, đảm nhiệm (nghề nghiệp, chức vụ); vào lúc, khi (thời gian)',
      'Động từ / Giới từ',
      'HSK 5',
      '他从小立志长大后要当一名救死扶伤的人民医生。',
      'Tā cóngxiǎo lìzhì zhǎngdà hòu yào dāng yì míng jiùsǐ-fúshāng de rénmín yīshēng.',
      'Từ nhỏ bạn ấy đã lập chí sau khi lớn lên sẽ làm một người bác sĩ nhân dân cứu chữa người bệnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他从小立志长大后要当一名救死扶伤的人民医生。',
        'Tā cóngxiǎo lìzhì zhǎngdà hòu yào dāng yì míng jiùsǐ-fúshāng de rénmín yīshēng.',
        'Từ nhỏ bạn ấy đã lập chí sau khi lớn lên sẽ làm một người bác sĩ nhân dân cứu chữa người bệnh.',
        'basic',
        1
      ),
      (
        v_id,
        '当历史的接力棒传递到新一代青年建设者手中时，大家以实际行动在各自平凡岗位上书写了不平凡的奉献篇章。',
        'Dāng lìshǐ de jiēlìbàng chuándì dào xīn yídài qīngnián jiànshèzhě shǒuzhōng shí, dàjiā yǐ shíjì xíngdòng zài gèzì píngfán gǎngwèi shàng shūxiě le bù píngfán de fèngxiàn piānzhāng.',
        'Khi chiếc gậy tiếp sức lịch sử được trao vào tay thế hệ những người xây dựng trẻ tuổi mới, mọi người đã lấy hành động thực tế viết nên những trang cống hiến không tầm thường ngay tại từng vị trí bình dị của mình.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2251] [当成] (dàngchéng) - coi là, coi như, xem như là [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '当成' AND pinyin = 'dàngchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当成' AND pinyin = 'dàngchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '当成'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当成'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dàngchéng',
      meaning_vi = 'coi là, coi như, xem như là',
      example_hanzi = '老师总是把学生当成自己的孩子一样悉心关怀与严格要求。',
      example_pinyin = 'Lǎoshī zǒngshì bǎ xuésheng dàngchéng zìjǐ de háizi yíyàng xīxīn guānhuái yǔ yángé yāoqiú.',
      example_vi = 'Thầy cô luôn coi học sinh như con ruột của mình để hết lòng quan tâm và nghiêm khắc chỉ dạy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '当成',
      'dàngchéng',
      'coi là, coi như, xem như là',
      'Động từ',
      'HSK 5',
      '老师总是把学生当成自己的孩子一样悉心关怀与严格要求。',
      'Lǎoshī zǒngshì bǎ xuésheng dàngchéng zìjǐ de háizi yíyàng xīxīn guānhuái yǔ yángé yāoqiú.',
      'Thầy cô luôn coi học sinh như con ruột của mình để hết lòng quan tâm và nghiêm khắc chỉ dạy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '老师总是把学生当成自己的孩子一样悉心关怀与严格要求。',
        'Lǎoshī zǒngshì bǎ xuésheng dàngchéng zìjǐ de háizi yíyàng xīxīn guānhuái yǔ yángé yāoqiú.',
        'Thầy cô luôn coi học sinh như con ruột của mình để hết lòng quan tâm và nghiêm khắc chỉ dạy.',
        'basic',
        1
      ),
      (
        v_id,
        '优秀的创业领军人才从不把暂时的挫折和技术测试失败当成不可逾越的终点，而是将其当成淬炼团队坚韧意志的宝贵财富。',
        'Yōuxiù de chuàngyè lǐngjūn réncái cóngbù bǎ zànshí de cuòzhé hé jìshù cèshì shībài dàngchéng bùkě yúyuè de zhōngdiǎn, ér shì jiāng qí dàngchéng cuìliàn tuánduì jiānrèn yìzhì de bǎoguì cáifù.',
        'Người lãnh đạo khởi nghiệp xuất sắc không bao giờ xem những trắc trở tạm thời hay thất bại trong thử nghiệm công nghệ là điểm kết thúc không thể vượt qua, mà xem đó là vốn tài sản quý giá để tôi luyện ý chí kiên định kiên cường của toàn đội ngũ.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2252] [当作] (dàngzuò) - coi như, xem như là, xem như [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '当作' AND pinyin = 'dàngzuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当作' AND pinyin = 'dàngzuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '当作'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '当作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dàngzuò',
      meaning_vi = 'coi như, xem như là, xem như',
      example_hanzi = '在求学道路上，我们要把每一次考试失误当作查漏补缺的绝佳契机。',
      example_pinyin = 'Zài qiúxué dàolù shàng, wǒmen yào bǎ měi yí cì kǎoshì shīwù dàngzuò chá lòu bǔ quē de juéjiā qìjī.',
      example_vi = 'Trên con đường học tập, chúng ta phải xem mỗi một lần sai sót trong thi cử như một cơ hội tuyệt vời để rà soát lỗ hổng bù đắp thiếu sót.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '当作',
      'dàngzuò',
      'coi như, xem như là, xem như',
      'Động từ',
      'HSK 5',
      '在求学道路上，我们要把每一次考试失误当作查漏补缺的绝佳契机。',
      'Zài qiúxué dàolù shàng, wǒmen yào bǎ měi yí cì kǎoshì shīwù dàngzuò chá lòu bǔ quē de juéjiā qìjī.',
      'Trên con đường học tập, chúng ta phải xem mỗi một lần sai sót trong thi cử như một cơ hội tuyệt vời để rà soát lỗ hổng bù đắp thiếu sót.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在求学道路上，我们要把每一次考试失误当作查漏补缺的绝佳契机。',
        'Zài qiúxué dàolù shàng, wǒmen yào bǎ měi yí cì kǎoshì shīwù dàngzuò chá lòu bǔ quē de juéjiā qìjī.',
        'Trên con đường học tập, chúng ta phải xem mỗi một lần sai sót trong thi cử như một cơ hội tuyệt vời để rà soát lỗ hổng bù đắp thiếu sót.',
        'basic',
        1
      ),
      (
        v_id,
        '老一辈革命艺术家把为人民大众奉献精美精神食粮当作毕生最高追求，这种崇高品格永远值得后人铭记学习。',
        'Lǎo yíbèi gémìng yìshùjiā bǎ wèi rénmín dàzhòng fèngxiàn jīngměi jīngshén shíliáng dàngzuò bìshēng zuì gāo zhuīqiú, zhè zhǒng chónggāo pǐngé yǒngyuǎn zhíde hòurén míngjì xuéxí.',
        'Thế hệ nghệ sĩ cách mạng tiền bối xem việc cống hiến món ăn tinh thần tinh xảo cho quảng đại quần chúng nhân dân là sự theo đuổi cao nhất suốt cuộc đời, phẩm cách cao đẹp này mãi mãi xứng đáng để hậu thế khắc ghi noi theo.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2253] [倒] (dǎo) - ngã, đổ (dǎo); rót nước, lùi xe, trái lại (dào) [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '倒' AND pinyin = 'dǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '倒' AND pinyin = 'dǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '倒'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '倒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Phó từ',
      pinyin = 'dǎo',
      meaning_vi = 'ngã, đổ (dǎo); rót nước, lùi xe, trái lại (dào)',
      example_hanzi = '昨夜的一阵狂风把路边几棵刚栽不久的小树吹倒了。',
      example_pinyin = 'Zuóyè de yí zhèn kuángfēng bǎ lùbiān jǐ kē gāng zāi bù jiǔ de xiǎoshù chuī dǎo le.',
      example_vi = 'Trận gió lốc đêm qua đã thổi ngã đổ mấy cây non mới trồng bên đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '倒',
      'dǎo',
      'ngã, đổ (dǎo); rót nước, lùi xe, trái lại (dào)',
      'Động từ / Phó từ',
      'HSK 5',
      '昨夜的一阵狂风把路边几棵刚栽不久的小树吹倒了。',
      'Zuóyè de yí zhèn kuángfēng bǎ lùbiān jǐ kē gāng zāi bù jiǔ de xiǎoshù chuī dǎo le.',
      'Trận gió lốc đêm qua đã thổi ngã đổ mấy cây non mới trồng bên đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '昨夜的一阵狂风把路边几棵刚栽不久的小树吹倒了。',
        'Zuóyè de yí zhèn kuángfēng bǎ lùbiān jǐ kē gāng zāi bù jiǔ de xiǎoshù chuī dǎo le.',
        'Trận gió lốc đêm qua đã thổi ngã đổ mấy cây non mới trồng bên đường.',
        'basic',
        1
      ),
      (
        v_id,
        '司机在狭窄拥挤的巷子里倒车时，必须由副驾驶下车站在安全区域仔细指挥，谨防撞到行人和障碍物。',
        'Sījī zài xiázhǎi yōngjǐ de xiàngzi lǐ dào chē shí, bìxū yóu fùjiàshǐ xiàchē zhàn zài ānquán qūyù zǐxì zhǐhuī, jǐnfáng zhuàng dào xíngrén hé zhàng’àiwù.',
        'Tài xế khi lùi xe trong con hẻm chật hẹp đông đúc, bắt buộc phải có người ngồi bên cạnh xuống xe đứng tại khu vực an toàn cẩn thận xi nhan hướng dẫn, cẩn phòng va chạm vào người đi bộ và chướng ngại vật.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2254] [导演] (dǎoyǎn) - đạo diễn; dàn dựng đạo diễn (phim ảnh, sân khấu) [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '导演' AND pinyin = 'dǎoyǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '导演' AND pinyin = 'dǎoyǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '导演'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '导演'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'dǎoyǎn',
      meaning_vi = 'đạo diễn; dàn dựng đạo diễn (phim ảnh, sân khấu)',
      example_hanzi = '著名导演在电影首映式上与观众热情分享拍摄幕后的难忘故事。',
      example_pinyin = 'Zhùmíng dǎoyǎn zài diànyǐng shǒuyìngshì shàng yǔ guānzhòng rèqíng fēnxiǎng pāishè mùhòu de nánwàng gùshì.',
      example_vi = 'Vị đạo diễn nổi tiếng tại buổi lễ công chiếu phim đầu tiên đã nhiệt tình chia sẻ cùng khán giả những câu chuyện khó quên phía sau ống kính trường quay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '导演',
      'dǎoyǎn',
      'đạo diễn; dàn dựng đạo diễn (phim ảnh, sân khấu)',
      'Danh từ / Động từ',
      'HSK 5',
      '著名导演在电影首映式上与观众热情分享拍摄幕后的难忘故事。',
      'Zhùmíng dǎoyǎn zài diànyǐng shǒuyìngshì shàng yǔ guānzhòng rèqíng fēnxiǎng pāishè mùhòu de nánwàng gùshì.',
      'Vị đạo diễn nổi tiếng tại buổi lễ công chiếu phim đầu tiên đã nhiệt tình chia sẻ cùng khán giả những câu chuyện khó quên phía sau ống kính trường quay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '著名导演在电影首映式上与观众热情分享拍摄幕后的难忘故事。',
        'Zhùmíng dǎoyǎn zài diànyǐng shǒuyìngshì shàng yǔ guānzhòng rèqíng fēnxiǎng pāishè mùhòu de nánwàng gùshì.',
        'Vị đạo diễn nổi tiếng tại buổi lễ công chiếu phim đầu tiên đã nhiệt tình chia sẻ cùng khán giả những câu chuyện khó quên phía sau ống kính trường quay.',
        'basic',
        1
      ),
      (
        v_id,
        '这位青年杰出导演巧妙运用非线性叙事蒙太奇手法与极富意境的光影构图，把这部历史传记影片导演得荡气回肠、极具艺术感染力。',
        'Zhè wèi qīngnián jiéchū dǎoyǎn qiǎomiào yùnyòng fēixiànxìng xùshì méngtàiqí shǒufǎ yǔ jífù yìjìng de guāngyǐng gòutú, bǎ zhè bù lìshǐ zhuànjì yǐngpiàn dǎoyǎn de dàngqì-huícháng, jí jù yìshù gǎnrǎnlì.',
        'Vị đạo diễn trẻ xuất sắc này khéo léo vận dụng thủ pháp dựng phim tự sự phi tuyến tính cùng bố cục ánh sáng và bóng tối giàu chất thơ, dàn dựng bộ phim tiểu sử lịch sử này một cách hào hùng lay động lòng người, mang sức truyền cảm nghệ thuật cực lớn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2255] [导致] (dǎozhì) - dẫn đến, gây ra, dẫn tới (kết quả xấu, hậu quả tai hại) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '导致' AND pinyin = 'dǎozhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '导致' AND pinyin = 'dǎozhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '导致'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '导致'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dǎozhì',
      meaning_vi = 'dẫn đến, gây ra, dẫn tới (kết quả xấu, hậu quả tai hại)',
      example_hanzi = '长期缺乏体育锻炼和不规律饮食容易导致身体机能下降。',
      example_pinyin = 'Chángqī quēfá tǐyù duànliàn hé bù guīlǜ yǐnshí róngyì dǎozhì shēntǐ jīnéng xiàjiàng.',
      example_vi = 'Thiếu rèn luyện thể thao kéo dài và ăn uống không điều độ rất dễ dẫn đến thể trạng cơ thể suy giảm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '导致',
      'dǎozhì',
      'dẫn đến, gây ra, dẫn tới (kết quả xấu, hậu quả tai hại)',
      'Động từ',
      'HSK 5',
      '长期缺乏体育锻炼和不规律饮食容易导致身体机能下降。',
      'Chángqī quēfá tǐyù duànliàn hé bù guīlǜ yǐnshí róngyì dǎozhì shēntǐ jīnéng xiàjiàng.',
      'Thiếu rèn luyện thể thao kéo dài và ăn uống không điều độ rất dễ dẫn đến thể trạng cơ thể suy giảm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '长期缺乏体育锻炼和不规律饮食容易导致身体机能下降。',
        'Chángqī quēfá tǐyù duànliàn hé bù guīlǜ yǐnshí róngyì dǎozhì shēntǐ jīnéng xiàjiàng.',
        'Thiếu rèn luyện thể thao kéo dài và ăn uống không điều độ rất dễ dẫn đến thể trạng cơ thể suy giảm.',
        'basic',
        1
      ),
      (
        v_id,
        '极端异常干旱气候导致跨流域水力发电量大幅锐减，直接加剧了该工业区在盛夏用电高峰期间的供电紧张局面。',
        'Jíduān yìcháng gānhàn qìhòu dǎozhì kuà liùyù shuǐlì fādiànliàng dà fú ruìjiǎn, zhíjiē jiājù le gāi gōngyèqū zài shèngxià yòngdiàn gāofēng qījiān de gōngdiàn jǐnzhāng júmiàn.',
        'Khí hậu khô hạn bất thường cực đoan đã khiến sản lượng thủy điện liên lưu vực sụt giảm mạnh mẽ, trực tiếp làm trầm trọng thêm tình trạng căng thẳng về cung cấp điện trong đợt cao điểm dùng điện giữa mùa hè của khu công nghiệp này.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2256] [到达] (dàodá) - đến nơi, tới đích, cập bến (địa điểm, trình độ mục tiêu) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '到达' AND pinyin = 'dàodá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '到达' AND pinyin = 'dàodá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '到达'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '到达'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dàodá',
      meaning_vi = 'đến nơi, tới đích, cập bến (địa điểm, trình độ mục tiêu)',
      example_hanzi = '列车将于今天下午三点半准时到达终点站北京南站。',
      example_pinyin = 'Lièchē jiāng yú jīntiān xiàwǔ sān diǎn bàn zhǔnshí dàodá zhōngdiǎnzhàn Běijīng Nán Zhàn.',
      example_vi = 'Đoàn tàu hỏa sẽ đến ga cuối Ga Nam Bắc Kinh đúng ba giờ rưỡi chiều nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '到达',
      'dàodá',
      'đến nơi, tới đích, cập bến (địa điểm, trình độ mục tiêu)',
      'Động từ',
      'HSK 5',
      '列车将于今天下午三点半准时到达终点站北京南站。',
      'Lièchē jiāng yú jīntiān xiàwǔ sān diǎn bàn zhǔnshí dàodá zhōngdiǎnzhàn Běijīng Nán Zhàn.',
      'Đoàn tàu hỏa sẽ đến ga cuối Ga Nam Bắc Kinh đúng ba giờ rưỡi chiều nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '列车将于今天下午三点半准时到达终点站北京南站。',
        'Lièchē jiāng yú jīntiān xiàwǔ sān diǎn bàn zhǔnshí dàodá zhōngdiǎnzhàn Běijīng Nán Zhàn.',
        'Đoàn tàu hỏa sẽ đến ga cuối Ga Nam Bắc Kinh đúng ba giờ rưỡi chiều nay.',
        'basic',
        1
      ),
      (
        v_id,
        '由多国经验丰富的登山家组成的联合科考探险队，历经千辛万苦终于成功到达了世界最高峰珠穆朗玛峰的峰顶。',
        'Yóu duō guó jīngyàn fēngfù de dēngshānjiā zǔchéng de liánhé kēkǎo tànxiǎnduì, lìjīng qiānxīn-wànkǔ zhōngyú chénggōng dàodá le shìjiè zuì gāofēng Zhūmùlǎngmǎ Fēng de fēngdǐng.',
        'Đội thám hiểm khảo sát khoa học liên hợp gồm các nhà leo núi dày dặn kinh nghiệm đến từ nhiều nước, trải qua muôn vàn gian khổ cuối cùng đã thành công đặt chân tới đỉnh núi Everest - đỉnh núi cao nhất thế giới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2257] [道理] (dàolǐ) - đạo lý, lẽ phải, nguyên lý quy luật [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '道理' AND pinyin = 'dàolǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '道理' AND pinyin = 'dàolǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '道理'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '道理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dàolǐ',
      meaning_vi = 'đạo lý, lẽ phải, nguyên lý quy luật',
      example_hanzi = '通过这篇简短的寓言故事，孩子们懂得了做人要谦虚诚实的深刻道理。',
      example_pinyin = 'Tōngguò zhè piān jiǎnduǎn de yùyán gùshì, háizimen dǒngdé le zuòrén yào qiānxū chéngshí de shēnkè dàolǐ.',
      example_vi = 'Thông qua câu chuyện ngụ ngôn ngắn gọn này, các em nhỏ đã hiểu được đạo lý sâu sắc rằng làm người cần phải khiêm tốn và thật thà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '道理',
      'dàolǐ',
      'đạo lý, lẽ phải, nguyên lý quy luật',
      'Danh từ',
      'HSK 5',
      '通过这篇简短的寓言故事，孩子们懂得了做人要谦虚诚实的深刻道理。',
      'Tōngguò zhè piān jiǎnduǎn de yùyán gùshì, háizimen dǒngdé le zuòrén yào qiānxū chéngshí de shēnkè dàolǐ.',
      'Thông qua câu chuyện ngụ ngôn ngắn gọn này, các em nhỏ đã hiểu được đạo lý sâu sắc rằng làm người cần phải khiêm tốn và thật thà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '通过这篇简短的寓言故事，孩子们懂得了做人要谦虚诚实的深刻道理。',
        'Tōngguò zhè piān jiǎnduǎn de yùyán gùshì, háizimen dǒngdé le zuòrén yào qiānxū chéngshí de shēnkè dàolǐ.',
        'Thông qua câu chuyện ngụ ngôn ngắn gọn này, các em nhỏ đã hiểu được đạo lý sâu sắc rằng làm người cần phải khiêm tốn và thật thà.',
        'basic',
        1
      ),
      (
        v_id,
        '“欲速则不达”的古训深刻揭示了事物遵循循序渐进客观演变的基本道理，在科技自主创新中切忌急功近利。',
        '“Yù sù zé bù dá” de gǔxùn shēnkè jiēshì le shìwù zūnxún xúnxù-jiànjìn kèguān yǎnbiàn de jīběn dàolǐ, zài kējì zìzhǔ chuàngxīn zhōng qièjì jígōng-jìnlì.',
        'Lời dạy xưa “Dục tốc bất đạt” đã làm sáng tỏ sâu sắc đạo lý cơ bản của sự vật luôn tuân theo diễn biến khách quan tuần tự từng bước, trong tự chủ đổi mới khoa học công nghệ tối kỵ nóng vội ham thành công nhanh trước mắt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2258] [到期] (dàoqī) - đến hạn, hết hạn (hợp đồng, visa, giấy tờ, thẻ ngân hàng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '到期' AND pinyin = 'dàoqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '到期' AND pinyin = 'dàoqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '到期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '到期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dàoqī',
      meaning_vi = 'đến hạn, hết hạn (hợp đồng, visa, giấy tờ, thẻ ngân hàng)',
      example_hanzi = '我的护照将于下个月到期，必须提前前往出入境管理部门申请换发。',
      example_pinyin = 'Wǒ de hùzhào jiāng yú xià gè yuè dàoqī, bìxū tíqián qiánwǎng chūrùjìng guǎnlǐ bùmén shēnqǐng huànfā.',
      example_vi = 'Hộ chiếu của tôi sẽ hết hạn vào tháng tới, bắt buộc phải đến cơ quan quản lý xuất nhập cảnh trước để làm thủ tục xin cấp đổi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '到期',
      'dàoqī',
      'đến hạn, hết hạn (hợp đồng, visa, giấy tờ, thẻ ngân hàng)',
      'Động từ',
      'HSK 5',
      '我的护照将于下个月到期，必须提前前往出入境管理部门申请换发。',
      'Wǒ de hùzhào jiāng yú xià gè yuè dàoqī, bìxū tíqián qiánwǎng chūrùjìng guǎnlǐ bùmén shēnqǐng huànfā.',
      'Hộ chiếu của tôi sẽ hết hạn vào tháng tới, bắt buộc phải đến cơ quan quản lý xuất nhập cảnh trước để làm thủ tục xin cấp đổi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我的护照将于下个月到期，必须提前前往出入境管理部门申请换发。',
        'Wǒ de hùzhào jiāng yú xià gè yuè dàoqī, bìxū tíqián qiánwǎng chūrùjìng guǎnlǐ bùmén shēnqǐng huànfā.',
        'Hộ chiếu của tôi sẽ hết hạn vào tháng tới, bắt buộc phải đến cơ quan quản lý xuất nhập cảnh trước để làm thủ tục xin cấp đổi.',
        'basic',
        1
      ),
      (
        v_id,
        '鉴于双方为期三年的排他性商业代理合同即将正式到期，法务部门需在续约磋商中重新评估市场分成比例与违约赔偿条款。',
        'Jiànyú shuāngfāng wéiqī sān nián de páitāxìng shāngyè dàilǐ hétong jíjiāng zhèngshì dàoqī, fǎwù bùmén xū zài xùyuē cuōshāng zhōng chóngxīn pínggū shìchǎng fēnchéng bǐlì yǔ wéiyuē péicháng tiáokuǎn.',
        'Xét thấy hợp đồng đại lý thương mại độc quyền có thời hạn ba năm giữa hai bên sắp chính thức đến hạn, phòng pháp chế cần đánh giá lại tỷ lệ chia hoa hồng thị trường và điều khoản bồi thường vi phạm hợp đồng trong đợt đàm phán gia hạn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2259] [登] (dēng) - trèo lên, bước lên (núi, máy bay); đăng tải (báo chí, tạp chí) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '登' AND pinyin = 'dēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '登' AND pinyin = 'dēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '登'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '登'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dēng',
      meaning_vi = 'trèo lên, bước lên (núi, máy bay); đăng tải (báo chí, tạp chí)',
      example_hanzi = '重阳节这一天，许多市民按照传统民俗携全家老小外出登高望远。',
      example_pinyin = 'Chóngyángjié zhè yì tiān, xǔduō shìmín ànzhào chuántǒng mínsú xié quánjiā lǎoxiǎo wàichū dēnggāo-wàngyuǎn.',
      example_vi = 'Vào ngày tết Trùng Cửu, nhiều người dân theo phong tục truyền thống dắt díu cả già trẻ trong gia đình ra ngoài leo núi lên cao ngắm cảnh xa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '登',
      'dēng',
      'trèo lên, bước lên (núi, máy bay); đăng tải (báo chí, tạp chí)',
      'Động từ',
      'HSK 5',
      '重阳节这一天，许多市民按照传统民俗携全家老小外出登高望远。',
      'Chóngyángjié zhè yì tiān, xǔduō shìmín ànzhào chuántǒng mínsú xié quánjiā lǎoxiǎo wàichū dēnggāo-wàngyuǎn.',
      'Vào ngày tết Trùng Cửu, nhiều người dân theo phong tục truyền thống dắt díu cả già trẻ trong gia đình ra ngoài leo núi lên cao ngắm cảnh xa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '重阳节这一天，许多市民按照传统民俗携全家老小外出登高望远。',
        'Chóngyángjié zhè yì tiān, xǔduō shìmín ànzhào chuántǒng mínsú xié quánjiā lǎoxiǎo wàichū dēnggāo-wàngyuǎn.',
        'Vào ngày tết Trùng Cửu, nhiều người dân theo phong tục truyền thống dắt díu cả già trẻ trong gia đình ra ngoài leo núi lên cao ngắm cảnh xa.',
        'basic',
        1
      ),
      (
        v_id,
        '国家自然科学基金重点资助项目的原创性突破理论成果，今天在国际权威顶级学术期刊封面文章上全文刊登。',
        'Guójiā zìrán kēxué jījīn zhòngdiǎn zīzhù xiàngmù de yuánchuàngxìng tūpò lǐlùn chéngguǒ, jīntiān zài guójì quánwēi dǐngjí xuéshù qíkān fēngmiàn wénzhāng shàng quánwén kāndēng.',
        'Thành quả lý luận đột phá mang tính độc bản của dự án được quỹ khoa học tự nhiên quốc gia trọng điểm tài trợ, hôm nay đã được đăng tải toàn văn trên bài viết trang bìa của tạp chí học thuật đỉnh cao uy tín quốc tế.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2260] [灯光] (dēngguāng) - ánh đèn, ánh sáng đèn chiếu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '灯光' AND pinyin = 'dēngguāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '灯光' AND pinyin = 'dēngguāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '灯光'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '灯光'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dēngguāng',
      meaning_vi = 'ánh đèn, ánh sáng đèn chiếu',
      example_hanzi = '舞台上的灯光随着音乐的节奏不断变换着绚丽的色彩。',
      example_pinyin = 'Wǔtái shàng de dēngguāng suízhe yīnyuè de jiézòu búduàn biànhuàn zhe xuànlì de sècǎi.',
      example_vi = 'Ánh đèn trên sân khấu liên tục biến đổi màu sắc rực rỡ theo nhịp điệu của âm nhạc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '灯光',
      'dēngguāng',
      'ánh đèn, ánh sáng đèn chiếu',
      'Danh từ',
      'HSK 5',
      '舞台上的灯光随着音乐的节奏不断变换着绚丽的色彩。',
      'Wǔtái shàng de dēngguāng suízhe yīnyuè de jiézòu búduàn biànhuàn zhe xuànlì de sècǎi.',
      'Ánh đèn trên sân khấu liên tục biến đổi màu sắc rực rỡ theo nhịp điệu của âm nhạc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '舞台上的灯光随着音乐的节奏不断变换着绚丽的色彩。',
        'Wǔtái shàng de dēngguāng suízhe yīnyuè de jiézòu búduàn biànhuàn zhe xuànlì de sècǎi.',
        'Ánh đèn trên sân khấu liên tục biến đổi màu sắc rực rỡ theo nhịp điệu của âm nhạc.',
        'basic',
        1
      ),
      (
        v_id,
        '夜幕降临，浦江两岸数十座超高层摩天大楼的璀璨景观灯光交相辉映，勾勒出国际大都市如梦如幻的流金夜景。',
        'Yèmù jiànglín, Pǔjiāng liǎng’àn shù shí zuò chāogāocéng mótiāndàlóu de cuǐcàn jǐngguān dēngguāng jiāoxiāng-huìyìng, gōulè chū guójì dà dūshì rúmèng-rúhuàn de liújīn yèjǐng.',
        'Màn đêm buông xuống, ánh đèn chiếu cảnh quan rực rỡ của hàng chục tòa nhà chọc trời siêu cao tầng đôi bờ sông Hoàng Phố tỏa sáng đan xen nhau, khắc họa nên cảnh đêm dát vàng ảo diệu tựa trong mơ của một đại đô thị quốc tế.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2261] [登记] (dēngjì) - đăng ký, ghi danh, vào sổ lưu trữ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '登记' AND pinyin = 'dēngjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '登记' AND pinyin = 'dēngjì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '登记'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '登记'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dēngjì',
      meaning_vi = 'đăng ký, ghi danh, vào sổ lưu trữ',
      example_hanzi = '外来访客进入居民小区前，必须在门卫保安处如实登记个人有效信息。',
      example_pinyin = 'Wàilái fǎngkè jìnrù jūmín xiǎoqū qián, bìxū zài ménwèi bǎo’ān chù rúshí dēngjì gèrén yǒuxiào xìnxī.',
      example_vi = 'Khách ngoài đến trước khi vào khu dân cư, bắt buộc phải đăng ký thông tin cá nhân hợp lệ một cách trung thực tại quầy bảo vệ cổng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '登记',
      'dēngjì',
      'đăng ký, ghi danh, vào sổ lưu trữ',
      'Động từ',
      'HSK 5',
      '外来访客进入居民小区前，必须在门卫保安处如实登记个人有效信息。',
      'Wàilái fǎngkè jìnrù jūmín xiǎoqū qián, bìxū zài ménwèi bǎo’ān chù rúshí dēngjì gèrén yǒuxiào xìnxī.',
      'Khách ngoài đến trước khi vào khu dân cư, bắt buộc phải đăng ký thông tin cá nhân hợp lệ một cách trung thực tại quầy bảo vệ cổng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '外来访客进入居民小区前，必须在门卫保安处如实登记个人有效信息。',
        'Wàilái fǎngkè jìnrù jūmín xiǎoqū qián, bìxū zài ménwèi bǎo’ān chù rúshí dēngjì gèrén yǒuxiào xìnxī.',
        'Khách ngoài đến trước khi vào khu dân cư, bắt buộc phải đăng ký thông tin cá nhân hợp lệ một cách trung thực tại quầy bảo vệ cổng.',
        'basic',
        1
      ),
      (
        v_id,
        '新人在民政局婚姻登记处依法庄严登记结婚并领取结婚证，标志着双方在法律上确立了神圣合法的夫妻权利义务关系。',
        'Xīnrén zài mínzhèngjú hūnyīn dēngjìchù yīfǎ zhuāngyán dēngjì jiéhūn bìng lǐngqǔ jiéhūnzhèng, biāozhì zhe shuāngfāng zài fǎlǜ shàng quèlì le shénshèng héfǎ de fūqī quánlì yìwù guānxì.',
        'Cặp đôi mới tại phòng đăng ký kết hôn thuộc cục dân chính đã trang nghiêm đăng ký kết hôn và nhận giấy chứng nhận kết hôn theo đúng luật, đánh dấu việc hai bên đã xác lập mối quan hệ quyền và nghĩa vụ vợ chồng hợp pháp thiêng liêng về mặt pháp luật.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2262] [登录] (dēnglù) - đăng nhập (tài khoản hệ thống, trang web, ứng dụng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '登录' AND pinyin = 'dēnglù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '登录' AND pinyin = 'dēnglù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '登录'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '登录'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dēnglù',
      meaning_vi = 'đăng nhập (tài khoản hệ thống, trang web, ứng dụng)',
      example_hanzi = '用户可以通过输入手机验证码或密码快速登录该在线学习平台。',
      example_pinyin = 'Yònghù kěyǐ tōngguò shūrù shǒujī yànzhèngmǎ huò mìmǎ kuàisù dēnglù gāi zàixiàn xuéxí píngtái.',
      example_vi = 'Người dùng có thể đăng nhập nhanh chóng vào nền tảng học tập trực tuyến này thông qua nhập mã xác minh điện thoại hoặc mật khẩu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '登录',
      'dēnglù',
      'đăng nhập (tài khoản hệ thống, trang web, ứng dụng)',
      'Động từ',
      'HSK 5',
      '用户可以通过输入手机验证码或密码快速登录该在线学习平台。',
      'Yònghù kěyǐ tōngguò shūrù shǒujī yànzhèngmǎ huò mìmǎ kuàisù dēnglù gāi zàixiàn xuéxí píngtái.',
      'Người dùng có thể đăng nhập nhanh chóng vào nền tảng học tập trực tuyến này thông qua nhập mã xác minh điện thoại hoặc mật khẩu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '用户可以通过输入手机验证码或密码快速登录该在线学习平台。',
        'Yònghù kěyǐ tōngguò shūrù shǒujī yànzhèngmǎ huò mìmǎ kuàisù dēnglù gāi zàixiàn xuéxí píngtái.',
        'Người dùng có thể đăng nhập nhanh chóng vào nền tảng học tập trực tuyến này thông qua nhập mã xác minh điện thoại hoặc mật khẩu.',
        'basic',
        1
      ),
      (
        v_id,
        '为了全方位守护用户的金融资产安全，网上银行移动端全面升级了指纹识别与动态短信双重身份验证的登录安全防护体系。',
        'Wèile quán fāngwèi shǒuhù yònghù de jīnróng zīchǎn ānquán, wǎngshàng yínháng yídòngduān quánmiàn shēngjí le zhǐwén shíbié yǔ dòngtài duǎnxìn shuāngchóng shēnfèn yànzhèng de dēnglù ānquán fánghù tǐxì.',
        'Nhằm bảo vệ toàn diện an toàn tài sản tài chính của người dùng, ứng dụng di động ngân hàng trực tuyến đã nâng cấp toàn diện hệ thống phòng hộ an toàn đăng nhập với xác thực danh tính kép bằng nhận diện vân tay và tin nhắn SMS động.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2263] [等待] (děngdài) - chờ đợi, ngóng chờ (kết quả, thời cơ, người thân) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '等待' AND pinyin = 'děngdài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '等待' AND pinyin = 'děngdài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '等待'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '等待'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'děngdài',
      meaning_vi = 'chờ đợi, ngóng chờ (kết quả, thời cơ, người thân)',
      example_hanzi = '考生们坐在考场外焦急地等待着高考录取分数线的正式公布。',
      example_pinyin = 'Kǎoshēngmen zuò zài kǎochǎng wài jiāojí de děngdài zhe gāokǎo lùqǔ fēnshùxiàn de zhèngshì gōngbù.',
      example_vi = 'Các thí sinh ngồi ngoài phòng thi sốt ruột chờ đợi điểm chuẩn trúng tuyển kỳ thi đại học được chính thức công bố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '等待',
      'děngdài',
      'chờ đợi, ngóng chờ (kết quả, thời cơ, người thân)',
      'Động từ',
      'HSK 5',
      '考生们坐在考场外焦急地等待着高考录取分数线的正式公布。',
      'Kǎoshēngmen zuò zài kǎochǎng wài jiāojí de děngdài zhe gāokǎo lùqǔ fēnshùxiàn de zhèngshì gōngbù.',
      'Các thí sinh ngồi ngoài phòng thi sốt ruột chờ đợi điểm chuẩn trúng tuyển kỳ thi đại học được chính thức công bố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '考生们坐在考场外焦急地等待着高考录取分数线的正式公布。',
        'Kǎoshēngmen zuò zài kǎochǎng wài jiāojí de děngdài zhe gāokǎo lùqǔ fēnshùxiàn de zhèngshì gōngbù.',
        'Các thí sinh ngồi ngoài phòng thi sốt ruột chờ đợi điểm chuẩn trúng tuyển kỳ thi đại học được chính thức công bố.',
        'basic',
        1
      ),
      (
        v_id,
        '面对充满巨大不确定性的资本市场震荡，成熟理智的长期价值投资者往往会保持超常耐心，静静等待最佳买入估值时机的到来。',
        'Miànduì chōngmǎn jùdà bùquèdìngxìng de zīběn shìchǎng zhèndàng, chéngshú lǐzhì de chángqī jiàzhí tóuzīzhě wǎngwǎng huì bǎochí chāocháng nàixīn, jìngjìng děngdài zuì jiā mǎirù gūzhí shíjī de dàolái.',
        'Trước những biến động đầy rủi ro bất định to lớn của thị trường vốn, các nhà đầu tư giá trị dài hạn chín chắn lý trí thường giữ sự kiên nhẫn phi thường, tĩnh lặng chờ đợi thời cơ định giá mua vào tối ưu nhất tìm đến.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2264] [等候] (děnghòu) - chờ đón, đợi chờ (ở một địa điểm cụ thể) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '等候' AND pinyin = 'děnghòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '等候' AND pinyin = 'děnghòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '等候'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '等候'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'děnghòu',
      meaning_vi = 'chờ đón, đợi chờ (ở một địa điểm cụ thể)',
      example_hanzi = '接机口的大厅里站满了手捧鲜花、等候海外亲朋好友归来的热心市民。',
      example_pinyin = 'Jiējīkǒu de dàtīng lǐ zhàn mǎn le shǒu pěng xiānhuā, děnghòu hǎiwài qīnpéng-hǎoyǒu guīlái de rèxīn shìmín.',
      example_vi = 'Tại sảnh cửa đón máy bay đứng chật kín người dân nhiệt tình tay ôm hoa tươi chờ đón người thân bạn bè ở nước ngoài trở về.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '等候',
      'děnghòu',
      'chờ đón, đợi chờ (ở một địa điểm cụ thể)',
      'Động từ',
      'HSK 5',
      '接机口的大厅里站满了手捧鲜花、等候海外亲朋好友归来的热心市民。',
      'Jiējīkǒu de dàtīng lǐ zhàn mǎn le shǒu pěng xiānhuā, děnghòu hǎiwài qīnpéng-hǎoyǒu guīlái de rèxīn shìmín.',
      'Tại sảnh cửa đón máy bay đứng chật kín người dân nhiệt tình tay ôm hoa tươi chờ đón người thân bạn bè ở nước ngoài trở về.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '接机口的大厅里站满了手捧鲜花、等候海外亲朋好友归来的热心市民。',
        'Jiējīkǒu de dàtīng lǐ zhàn mǎn le shǒu pěng xiānhuā, děnghòu hǎiwài qīnpéng-hǎoyǒu guīlái de rèxīn shìmín.',
        'Tại sảnh cửa đón máy bay đứng chật kín người dân nhiệt tình tay ôm hoa tươi chờ đón người thân bạn bè ở nước ngoài trở về.',
        'basic',
        1
      ),
      (
        v_id,
        '三甲医院门诊导医台通过开通全流程电子叫号与手机实时排队提醒系统，极大缩短了病患及家属在各科室门外的无效等候时间。',
        'Sānjiǎ yīyuàn ménzhěn dǎoyītái tōngguò kāitōng quán liúchéng diànzǐ jiàohào yǔ shǒujī shíshí páiduì tíxǐng xìtǒng, jí dà suōduǎn le bìnghuàn jí jiāshǔ zài gè kēshì ménwài de wúxiào děnghòu shíjiān.',
        'Bàn hướng dẫn khám bệnh ngoại trú bệnh viện hạng ba tuyến đầu thông qua mở hệ thống gọi số điện tử toàn quy trình và nhắc nhở xếp hàng thời gian thực qua điện thoại di động, đã rút ngắn đáng kể thời gian chờ đợi vô ích bên ngoài cửa các khoa phòng của người bệnh và người nhà.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2265] [等于] (děngyú) - bằng với, bằng; tương đương với (nghĩa bóng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '等于' AND pinyin = 'děngyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '等于' AND pinyin = 'děngyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '等于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '等于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'děngyú',
      meaning_vi = 'bằng với, bằng; tương đương với (nghĩa bóng)',
      example_hanzi = '在初等算术中，四加五等于九。',
      example_pinyin = 'Zài chūděng suànshù zhōng, sì jiā wǔ děngyú jiǔ.',
      example_vi = 'Trong số học sơ cấp, bốn cộng năm bằng chín.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '等于',
      'děngyú',
      'bằng với, bằng; tương đương với (nghĩa bóng)',
      'Động từ',
      'HSK 5',
      '在初等算术中，四加五等于九。',
      'Zài chūděng suànshù zhōng, sì jiā wǔ děngyú jiǔ.',
      'Trong số học sơ cấp, bốn cộng năm bằng chín.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在初等算术中，四加五等于九。',
        'Zài chūděng suànshù zhōng, sì jiā wǔ děngyú jiǔ.',
        'Trong số học sơ cấp, bốn cộng năm bằng chín.',
        'basic',
        1
      ),
      (
        v_id,
        '安全生产责任重于泰山，在任何施工操作环节中的违章马虎大意，都无异于拿国家财产与工友宝贵生命当儿戏。',
        'Ānquán shēngchǎn zérèn zhòng yú Tàishān, zài rènhé shīgōng cāozuò huánjié zhōng de wéizhāng mǎhu-dàyì, dōu wúyì yú ná guójiā cáichǎn yǔ gōngyǒu bǎoguì shēngmìng dāng érxì.',
        'Trách nhiệm an toàn sản xuất nặng hơn núi Thái Sơn, sự bất cẩn cẩu thả vi phạm quy trình trong bất kỳ khâu thao tác thi công nào cũng chẳng khác nào đem tài sản nhà nước và tính mạng quý báu của anh em công nhân ra làm trò đùa.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2266] [低头] (dītóu) - cúi đầu; chịu thua, khuất phục trước gian nan thế lực [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '低头' AND pinyin = 'dītóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '低头' AND pinyin = 'dītóu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '低头'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '低头'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dītóu',
      meaning_vi = 'cúi đầu; chịu thua, khuất phục trước gian nan thế lực',
      example_hanzi = '在地铁里随处可见低头专注看手机的“低头族”乘客。',
      example_pinyin = 'Zài dìtiě lǐ suíchù kějiàn dītóu zhuānzhù kàn shǒujī de “dītóuzú” chéngkè.',
      example_vi = 'Trong tàu điện ngầm khắp nơi đều có thể bắt gặp các hành khách “tộc cúi đầu” chăm chú cúi mặt nhìn điện thoại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '低头',
      'dītóu',
      'cúi đầu; chịu thua, khuất phục trước gian nan thế lực',
      'Động từ',
      'HSK 5',
      '在地铁里随处可见低头专注看手机的“低头族”乘客。',
      'Zài dìtiě lǐ suíchù kějiàn dītóu zhuānzhù kàn shǒujī de “dītóuzú” chéngkè.',
      'Trong tàu điện ngầm khắp nơi đều có thể bắt gặp các hành khách “tộc cúi đầu” chăm chú cúi mặt nhìn điện thoại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在地铁里随处可见低头专注看手机的“低头族”乘客。',
        'Zài dìtiě lǐ suíchù kějiàn dītóu zhuānzhù kàn shǒujī de “dītóuzú” chéngkè.',
        'Trong tàu điện ngầm khắp nơi đều có thể bắt gặp các hành khách “tộc cúi đầu” chăm chú cúi mặt nhìn điện thoại.',
        'basic',
        1
      ),
      (
        v_id,
        '面对帝国主义的野蛮封锁与极限施压，英雄的中华民族以钢铁般的意志挺起脊梁，从来不曾向任何强权霸凌低头妥协。',
        'Miànduì dìguózhǔyì de yěmán fēngsuǒ yǔ jíxiàn shīyā, yīngxióng de Zhōnghuá mínzú yǐ gāngtiě bān de yìzhì tǐng qǐ jǐliáng, cónglái bù céng xiàng rènhé qiángquán bàlíng dītóu tuǒxié.',
        'Đối mặt với sự phong tỏa dã man và gây sức ép tột cùng của chủ nghĩa đế quốc, dân tộc Trung Hoa anh hùng đã dùng ý chí sắt đá ngẩng cao đầu ưỡn thẳng sống lưng, chưa bao giờ cúi đầu thỏa hiệp trước bất kỳ cường quyền bắt nạt nào.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2267] [的确] (díquè) - thực sự, quả thực, đúng là như vậy [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '的确' AND pinyin = 'díquè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '的确' AND pinyin = 'díquè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '的确'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '的确'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'díquè',
      meaning_vi = 'thực sự, quả thực, đúng là như vậy',
      example_hanzi = '经过长期的科学治理，这里的空气质量现在的确得到了极其显著的改善。',
      example_pinyin = 'Jīngguò chángqī de kēxué zhìlǐ, zhèlǐ de kōngqì zhìliàng xiànzài díquè dédào le jíqí xiǎnzhù de gǎishàn.',
      example_vi = 'Trải qua quá trình xử lý khoa học lâu dài, chất lượng không khí ở nơi đây hiện tại quả thực đã đạt được sự cải thiện vô cùng rõ nét.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '的确',
      'díquè',
      'thực sự, quả thực, đúng là như vậy',
      'Phó từ',
      'HSK 5',
      '经过长期的科学治理，这里的空气质量现在的确得到了极其显著的改善。',
      'Jīngguò chángqī de kēxué zhìlǐ, zhèlǐ de kōngqì zhìliàng xiànzài díquè dédào le jíqí xiǎnzhù de gǎishàn.',
      'Trải qua quá trình xử lý khoa học lâu dài, chất lượng không khí ở nơi đây hiện tại quả thực đã đạt được sự cải thiện vô cùng rõ nét.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '经过长期的科学治理，这里的空气质量现在的确得到了极其显著的改善。',
        'Jīngguò chángqī de kēxué zhìlǐ, zhèlǐ de kōngqì zhìliàng xiànzài díquè dédào le jíqí xiǎnzhù de gǎishàn.',
        'Trải qua quá trình xử lý khoa học lâu dài, chất lượng không khí ở nơi đây hiện tại quả thực đã đạt được sự cải thiện vô cùng rõ nét.',
        'basic',
        1
      ),
      (
        v_id,
        '这份详尽客观的独立第三方可行性调研报告，的确为集团董事会科学决策提供了极其坚实可信的数据支撑。',
        'Zhè fèn xiángjìn kèguān de dúlì dì-sānfāng kěxíngxìng diàoyán bàogào, díquè wèi jítuán dǒngshìhuì kēxué juécè tígōng le jíqí jiānshí kěxìn de shùjù zhīchēng.',
        'Bản báo cáo khảo sát tính khả thi của bên thứ ba độc lập cặn kẽ khách quan này quả thực đã cung cấp điểm tựa số liệu vô cùng vững chắc và đáng tin cậy cho quyết sách khoa học của hội đồng quản trị tập đoàn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2268] [敌人] (dírén) - kẻ thù, quân địch (quân sự, đối thủ tranh đoạt) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '敌人' AND pinyin = 'dírén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '敌人' AND pinyin = 'dírén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '敌人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '敌人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dírén',
      meaning_vi = 'kẻ thù, quân địch (quân sự, đối thủ tranh đoạt)',
      example_hanzi = '在艰苦卓绝的战争年代，英雄的战士们英勇作战，彻底消灭了侵略者敌人。',
      example_pinyin = 'Zài jiānkǔ-zhuójué de zhànzhēng niándài, yīngxióng de zhànshìmen yīngyǒng zuòzhàn, chèdǐ xiāomiè le qīnlüèzhě dírén.',
      example_vi = 'Trong những năm tháng chiến tranh gian khổ cùng cực, các chiến sĩ anh hùng đã chiến đấu quả cảm, tiêu diệt triệt để kẻ thù xâm lược.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '敌人',
      'dírén',
      'kẻ thù, quân địch (quân sự, đối thủ tranh đoạt)',
      'Danh từ',
      'HSK 5',
      '在艰苦卓绝的战争年代，英雄的战士们英勇作战，彻底消灭了侵略者敌人。',
      'Zài jiānkǔ-zhuójué de zhànzhēng niándài, yīngxióng de zhànshìmen yīngyǒng zuòzhàn, chèdǐ xiāomiè le qīnlüèzhě dírén.',
      'Trong những năm tháng chiến tranh gian khổ cùng cực, các chiến sĩ anh hùng đã chiến đấu quả cảm, tiêu diệt triệt để kẻ thù xâm lược.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在艰苦卓绝的战争年代，英雄的战士们英勇作战，彻底消灭了侵略者敌人。',
        'Zài jiānkǔ-zhuójué de zhànzhēng niándài, yīngxióng de zhànshìmen yīngyǒng zuòzhàn, chèdǐ xiāomiè le qīnlüèzhě dírén.',
        'Trong những năm tháng chiến tranh gian khổ cùng cực, các chiến sĩ anh hùng đã chiến đấu quả cảm, tiêu diệt triệt để kẻ thù xâm lược.',
        'basic',
        1
      ),
      (
        v_id,
        '骄傲自满与故步自封是科学攀登道路上最危险致命的隐形敌人，唯有时刻保持谦虚敬畏才能不断勇攀科技新高峰。',
        'Jiāo’ào zìmǎn yǔ gùbù-zìfēng shì kēxué pāndēng dàolù shàng zuì wēixiǎn zhìmìng de yǐnxíng dírén, wéi yǒu shíkè bǎochí qiānxū jìngwèi cái néng búduàn yǒng pān kējì xīn gāofēng.',
        'Kiêu ngạo tự mãn và dậm chân tại chỗ bảo thủ là kẻ thù vô hình nguy hiểm chí mạng nhất trên con đường chinh phục khoa học, chỉ có luôn giữ sự khiêm nhường kính sợ thì mới có thể không ngừng dũng cảm trèo lên những đỉnh cao công nghệ mới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2269] [递] (dì) - đưa, chuyển cho, trao tận tay (đồ vật, tài liệu) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '递' AND pinyin = 'dì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '递' AND pinyin = 'dì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '递'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '递'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dì',
      meaning_vi = 'đưa, chuyển cho, trao tận tay (đồ vật, tài liệu)',
      example_hanzi = '请帮我把桌子角上的那本英汉词典递过来一下。',
      example_pinyin = 'Qǐng bāng wǒ bǎ zhuōzi jiǎo shàng de nà běn Yīng-Hàn cídiǎn dì guòlái yíxià.',
      example_vi = 'Làm ơn giúp tôi đưa quyển từ điển Anh - Hán ở góc bàn qua đây một chút.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '递',
      'dì',
      'đưa, chuyển cho, trao tận tay (đồ vật, tài liệu)',
      'Động từ',
      'HSK 5',
      '请帮我把桌子角上的那本英汉词典递过来一下。',
      'Qǐng bāng wǒ bǎ zhuōzi jiǎo shàng de nà běn Yīng-Hàn cídiǎn dì guòlái yíxià.',
      'Làm ơn giúp tôi đưa quyển từ điển Anh - Hán ở góc bàn qua đây một chút.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '请帮我把桌子角上的那本英汉词典递过来一下。',
        'Qǐng bāng wǒ bǎ zhuōzi jiǎo shàng de nà běn Yīng-Hàn cídiǎn dì guòlái yíxià.',
        'Làm ơn giúp tôi đưa quyển từ điển Anh - Hán ở góc bàn qua đây một chút.',
        'basic',
        1
      ),
      (
        v_id,
        '求职者双手恭敬地向各位主考官递上精心装订的个人简历与学术成果证明材料，展现了良好的职业礼仪修养。',
        'Qiúzhízhě shuāngshǒu gōngjìng de xiàng gè wèi zhǔkǎoguān dì shàng jīngxīn zhuāngdìng de gèrén jiǎnlì yǔ xuéshù chéngguǒ zhèngmíng cáiliào, zhǎnxiàn le liánghǎo de zhíyè lǐyí xiūyǎng.',
        'Người tìm việc dùng cả hai tay cung kính đưa tập hồ sơ sơ yếu lý lịch và giấy tờ chứng nhận thành quả học thuật được đóng tập tinh tế lên trước mặt các vị chủ khảo, thể hiện sự tu dưỡng lễ nghi nghề nghiệp rất tốt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2270] [地理] (dìlǐ) - địa lý, môn học địa lý; vị trí địa lý tự nhiên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '地理' AND pinyin = 'dìlǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地理' AND pinyin = 'dìlǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '地理'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dìlǐ',
      meaning_vi = 'địa lý, môn học địa lý; vị trí địa lý tự nhiên',
      example_hanzi = '在初中地理课堂上，老师指导大家在世界地图上准确查找各大洋与各大洲。',
      example_pinyin = 'Zài chūzhōng dìlǐ kètáng shàng, lǎoshī zhǐdǎo dàjiā zài shìjiè dìtú shàng zhǔnquè zhǎochá gè dàyáng yǔ gè dàzhōu.',
      example_vi = 'Trong lớp học môn địa lý cấp hai, thầy giáo hướng dẫn mọi người tìm chuẩn xác các đại dương và các châu lục trên bản đồ thế giới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '地理',
      'dìlǐ',
      'địa lý, môn học địa lý; vị trí địa lý tự nhiên',
      'Danh từ',
      'HSK 5',
      '在初中地理课堂上，老师指导大家在世界地图上准确查找各大洋与各大洲。',
      'Zài chūzhōng dìlǐ kètáng shàng, lǎoshī zhǐdǎo dàjiā zài shìjiè dìtú shàng zhǔnquè zhǎochá gè dàyáng yǔ gè dàzhōu.',
      'Trong lớp học môn địa lý cấp hai, thầy giáo hướng dẫn mọi người tìm chuẩn xác các đại dương và các châu lục trên bản đồ thế giới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在初中地理课堂上，老师指导大家在世界地图上准确查找各大洋与各大洲。',
        'Zài chūzhōng dìlǐ kètáng shàng, lǎoshī zhǐdǎo dàjiā zài shìjiè dìtú shàng zhǔnquè zhǎochá gè dàyáng yǔ gè dàzhōu.',
        'Trong lớp học môn địa lý cấp hai, thầy giáo hướng dẫn mọi người tìm chuẩn xác các đại dương và các châu lục trên bản đồ thế giới.',
        'basic',
        1
      ),
      (
        v_id,
        '该自由贸易试验区地处连接内陆与海外的沿海黄金枢纽节点，得天独厚的地缘交通地理优势为其打造现代国际综合物流港提供了极佳支撑。',
        'Gāi zìyóu màoyì shìyànqū dìchǔ liánjiē nèilù yǔ hǎiwài de yánhǎi huángjīn shūniǔ jiédiǎn, détiāndúhòu de dìyuán jiāotōng dìlǐ yōushì wèi qí dǎzào xiàndài guójì zōnghé wùliúgǎng tígōng le jí jiā zhīchēng.',
        'Khu thí điểm thương mại tự do này tọa lạc tại nút giao thông đầu mối vàng ven biển kết nối đất liền với hải ngoại, ưu thế địa lý giao thông địa duyên đắc địa trời ban đã cung cấp sự tương trợ tuyệt vời để xây dựng cảng logistics tổng hợp quốc tế hiện đại.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2271] [地面] (dìmiàn) - mặt đất, mặt sàn, sàn nhà [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '地面' AND pinyin = 'dìmiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地面' AND pinyin = 'dìmiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '地面'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地面'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dìmiàn',
      meaning_vi = 'mặt đất, mặt sàn, sàn nhà',
      example_hanzi = '保洁人员刚刚拖洗干净的地面比较湿滑，请大家行走时注意脚下安全。',
      example_pinyin = 'Bǎojié rényuán gānggāng tuōxǐ gānjìng de dìmiàn bǐjiào shīhuá, qǐng dàjiā xíngzǒu shí zhùyì jiǎoxià ānquán.',
      example_vi = 'Mặt sàn vừa được nhân viên lau dọn lau chùi sạch sẽ còn tương đối ướt trơn, xin mọi người khi đi lại chú ý an toàn dưới chân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '地面',
      'dìmiàn',
      'mặt đất, mặt sàn, sàn nhà',
      'Danh từ',
      'HSK 5',
      '保洁人员刚刚拖洗干净的地面比较湿滑，请大家行走时注意脚下安全。',
      'Bǎojié rényuán gānggāng tuōxǐ gānjìng de dìmiàn bǐjiào shīhuá, qǐng dàjiā xíngzǒu shí zhùyì jiǎoxià ānquán.',
      'Mặt sàn vừa được nhân viên lau dọn lau chùi sạch sẽ còn tương đối ướt trơn, xin mọi người khi đi lại chú ý an toàn dưới chân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '保洁人员刚刚拖洗干净的地面比较湿滑，请大家行走时注意脚下安全。',
        'Bǎojié rényuán gānggāng tuōxǐ gānjìng de dìmiàn bǐjiào shīhuá, qǐng dàjiā xíngzǒu shí zhùyì jiǎoxià ānquán.',
        'Mặt sàn vừa được nhân viên lau dọn lau chùi sạch sẽ còn tương đối ướt trơn, xin mọi người khi đi lại chú ý an toàn dưới chân.',
        'basic',
        1
      ),
      (
        v_id,
        '我国高精度航天返回舱在圆满完成各项预定空间站实验任务后，安全平稳降落在了预定着陆场的戈壁地面上。',
        'Wǒ guó gāojīngdù hángtiān fǎnhuí cāng zài yuánmǎn wánchéng gè xiàng yùdìng kōngjiānzhàn shíyàn rènwu hòu, ānquán píngwěn jiàngluò zài le yùdìng zhuólùchǎng de gēbì dìmiàn shàng.',
        'Khoang phi thuyền vũ trụ quay trở lại có độ chính xác cao của nước ta sau khi hoàn thành viên mãn các nhiệm vụ thí nghiệm trạm không gian dự định, đã hạ cánh an toàn êm ái xuống mặt đất sa mạc Gobi của bãi đáp chỉ định.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2272] [地区] (dìqū) - khu vực, vùng lãnh thổ địa phương [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '地区' AND pinyin = 'dìqū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地区' AND pinyin = 'dìqū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '地区'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地区'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dìqū',
      meaning_vi = 'khu vực, vùng lãnh thổ địa phương',
      example_hanzi = '我国幅员辽阔，不同地理地区的气候特征与生活习惯差异很大。',
      example_pinyin = 'Wǒ guó fúyuán-liáokuò, bù tóng dìlǐ dìqū de qìhòu tèzhēng yǔ shēnghuó xíguàn chāyì hěn dà.',
      example_vi = 'Nước ta đất đai rộng lớn bao la, đặc trưng khí hậu và tập quán sinh hoạt của các vùng miền địa lý khác nhau có sự chênh lệch rất lớn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '地区',
      'dìqū',
      'khu vực, vùng lãnh thổ địa phương',
      'Danh từ',
      'HSK 5',
      '我国幅员辽阔，不同地理地区的气候特征与生活习惯差异很大。',
      'Wǒ guó fúyuán-liáokuò, bù tóng dìlǐ dìqū de qìhòu tèzhēng yǔ shēnghuó xíguàn chāyì hěn dà.',
      'Nước ta đất đai rộng lớn bao la, đặc trưng khí hậu và tập quán sinh hoạt của các vùng miền địa lý khác nhau có sự chênh lệch rất lớn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '我国幅员辽阔，不同地理地区的气候特征与生活习惯差异很大。',
        'Wǒ guó fúyuán-liáokuò, bù tóng dìlǐ dìqū de qìhòu tèzhēng yǔ shēnghuó xíguàn chāyì hěn dà.',
        'Nước ta đất đai rộng lớn bao la, đặc trưng khí hậu và tập quán sinh hoạt của các vùng miền địa lý khác nhau có sự chênh lệch rất lớn.',
        'basic',
        1
      ),
      (
        v_id,
        '国家持续深入实施西部大开发战略，在交通水利重大基建、特色优势产业培育以及生态涵养补偿机制方面对西部民族地区给予倾斜支持。',
        'Guójiā chíxù shēnrù shíshī xībù dà kāifā zhànlüè, zài jiāotōng shuǐlì zhòngdà jījiàn, tèsè yōushì chǎnyè péiyù yǐjí shēngtài hán’yǎng bǔcháng jīzhì fāngmiàn duì xībù mínzú dìqū jǐyǔ qīngxié zhīchí.',
        'Nhà nước tiếp tục đi sâu thực hiện chiến lược đại phát triển miền Tây, dành sự ưu tiên hỗ trợ cho các khu vực dân tộc miền Tây trong các công trình hạ tầng trọng điểm giao thông thủy lợi, ươm mầm các ngành công nghiệp ưu thế đặc sắc cùng cơ chế bù đắp bảo tồn sinh thái.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2273] [地位] (dìwèi) - địa vị, vị thế (xã hội, chính trị, kinh tế, học thuật) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '地位' AND pinyin = 'dìwèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地位' AND pinyin = 'dìwèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '地位'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地位'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dìwèi',
      meaning_vi = 'địa vị, vị thế (xã hội, chính trị, kinh tế, học thuật)',
      example_hanzi = '在现代法治社会中，所有公民在法律面前一律享有平等的法律地位。',
      example_pinyin = 'Zài xiàndài fǎzhì shèhuì zhōng, suǒyǒu gōngmín zài fǎlǜ miànqián yílǜ xiǎngyǒu píngděng de fǎlǜ dìwèi.',
      example_vi = 'Trong xã hội pháp quyền hiện đại, tất cả mọi công dân trước pháp luật đều được hưởng địa vị pháp lý bình đẳng như nhau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '地位',
      'dìwèi',
      'địa vị, vị thế (xã hội, chính trị, kinh tế, học thuật)',
      'Danh từ',
      'HSK 5',
      '在现代法治社会中，所有公民在法律面前一律享有平等的法律地位。',
      'Zài xiàndài fǎzhì shèhuì zhōng, suǒyǒu gōngmín zài fǎlǜ miànqián yílǜ xiǎngyǒu píngděng de fǎlǜ dìwèi.',
      'Trong xã hội pháp quyền hiện đại, tất cả mọi công dân trước pháp luật đều được hưởng địa vị pháp lý bình đẳng như nhau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在现代法治社会中，所有公民在法律面前一律享有平等的法律地位。',
        'Zài xiàndài fǎzhì shèhuì zhōng, suǒyǒu gōngmín zài fǎlǜ miànqián yílǜ xiǎngyǒu píngděng de fǎlǜ dìwèi.',
        'Trong xã hội pháp quyền hiện đại, tất cả mọi công dân trước pháp luật đều được hưởng địa vị pháp lý bình đẳng như nhau.',
        'basic',
        1
      ),
      (
        v_id,
        '该高科技企业通过连续多年将营业收入的百分之二十投入基础芯片架构研发，成功奠定了在全球移动通信半导体领域的举足轻重领先地位。',
        'Gāi gāokējì qǐyè tōngguò liánxù duō nián jiāng yíngyè shōurù de bǎifēnzhī èrshí tóurù jīchǔ xīnpiàn jiàgòu yánfā, chénggōng diàndìng le zài quánqiú yídòng tōngxìn bàndǎotǐ lǐngyù de jǔzú-qīngzhòng lǐngxiān dìwèi.',
        'Doanh nghiệp công nghệ cao này thông qua việc liên tục nhiều năm đem hai mươi phần trăm doanh thu đổ vào nghiên cứu kiến trúc chip cơ bản, đã thành công đặt nền móng cho vị thế dẫn đầu có sức nặng then chốt trong lĩnh vực bán dẫn viễn thông di động toàn cầu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2274] [地下] (dìxià) - dưới mặt đất, lòng đất; ngầm, bí mật [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '地下' AND pinyin = 'dìxià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地下' AND pinyin = 'dìxià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '地下'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地下'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'dìxià',
      meaning_vi = 'dưới mặt đất, lòng đất; ngầm, bí mật',
      example_hanzi = '商场地下一层开设有大型生鲜便民超级市场。',
      example_pinyin = 'Shāngchǎng dìxià yī céng kāishè yǒu dàxíng shēngxiān biànmín chāojí shìchǎng.',
      example_vi = 'Tầng hầm một của trung tâm thương mại có mở một siêu thị thực phẩm tươi sống tiện ích lớn cho người dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '地下',
      'dìxià',
      'dưới mặt đất, lòng đất; ngầm, bí mật',
      'Danh từ / Tính từ',
      'HSK 5',
      '商场地下一层开设有大型生鲜便民超级市场。',
      'Shāngchǎng dìxià yī céng kāishè yǒu dàxíng shēngxiān biànmín chāojí shìchǎng.',
      'Tầng hầm một của trung tâm thương mại có mở một siêu thị thực phẩm tươi sống tiện ích lớn cho người dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '商场地下一层开设有大型生鲜便民超级市场。',
        'Shāngchǎng dìxià yī céng kāishè yǒu dàxíng shēngxiān biànmín chāojí shìchǎng.',
        'Tầng hầm một của trung tâm thương mại có mở một siêu thị thực phẩm tươi sống tiện ích lớn cho người dân.',
        'basic',
        1
      ),
      (
        v_id,
        '地质勘探队利用先进的三维地震成像探测技术，在数千米深的地下复杂岩层中探明了储量极其庞大的特大型清洁天然气田。',
        'Dìzhì kāntànduì lìyòng xiānjìn de sānwéi dìzhèn chéngxiàng tàncè jìshù, zài shù qiān mǐ shēn de dìxià fùzá yáncéng zhōng tànmíng le chǔliàng jíqí pángdà de tèdàxíng qīngjié tiānránqìtián.',
        'Đội thăm dò địa chất sử dụng kỹ thuật thám trắc tạo ảnh địa chấn 3D tiên tiến, đã phát hiện và xác minh được mỏ khí đốt tự nhiên sạch quy mô đặc biệt lớn với trữ lượng cực kỳ đồ sộ trong tầng đá phức tạp sâu hàng nghìn mét dưới lòng đất.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2275] [地震] (dìzhèn) - động đất, địa chấn; rung chuyển [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '地震' AND pinyin = 'dìzhèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地震' AND pinyin = 'dìzhèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '地震'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '地震'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'dìzhèn',
      meaning_vi = 'động đất, địa chấn; rung chuyển',
      example_hanzi = '学校每学期都会组织全体师生开展防震减灾应急疏散演练。',
      example_pinyin = 'Xuéxiào měi xuéqī dōu huì zǔzhī quántǐ shīshēng kāizhǎn fángzhèn-jiǎnzāi yìngjí shūsàn yǎnliàn.',
      example_vi = 'Trường học mỗi học kỳ đều sẽ tổ chức cho toàn thể thầy cô và học sinh diễn tập sơ tán khẩn cấp phòng chống giảm nhẹ thảm họa động đất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '地震',
      'dìzhèn',
      'động đất, địa chấn; rung chuyển',
      'Danh từ / Động từ',
      'HSK 5',
      '学校每学期都会组织全体师生开展防震减灾应急疏散演练。',
      'Xuéxiào měi xuéqī dōu huì zǔzhī quántǐ shīshēng kāizhǎn fángzhèn-jiǎnzāi yìngjí shūsàn yǎnliàn.',
      'Trường học mỗi học kỳ đều sẽ tổ chức cho toàn thể thầy cô và học sinh diễn tập sơ tán khẩn cấp phòng chống giảm nhẹ thảm họa động đất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '学校每学期都会组织全体师生开展防震减灾应急疏散演练。',
        'Xuéxiào měi xuéqī dōu huì zǔzhī quántǐ shīshēng kāizhǎn fángzhèn-jiǎnzāi yìngjí shūsàn yǎnliàn.',
        'Trường học mỗi học kỳ đều sẽ tổ chức cho toàn thể thầy cô và học sinh diễn tập sơ tán khẩn cấp phòng chống giảm nhẹ thảm họa động đất.',
        'basic',
        1
      ),
      (
        v_id,
        '高烈度强震发生后，国家应急指挥部在第一时间调派专业地震救援队和空运救援物资直飞灾区，争分夺秒搜救被困群众。',
        'Gāo lièdù qiángzhèn fāshēng hòu, guójiā yìngjí zhǐhuībù zài dì-yī shíjiān diàopài zhuānyè dìzhèn jiùyuánduì hé kōngyùn jiùyuán wùzī zhí fēi zāiqū, zhēngfēn-duómiǎo sōujiù bèikùn qúnzhòng.',
        'Sau khi trận động đất mạnh cường độ cao xảy ra, ban chỉ huy ứng phó khẩn cấp quốc gia đã ngay lập tức điều động đội cứu nạn động đất chuyên nghiệp và vận tải hàng không hàng hóa cứu trợ bay thẳng tới vùng thiên tai, giành giật từng phút từng giây tìm kiếm cứu nạn đồng bào bị mắc kẹt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2276] [点心] (diǎnxin) - điểm tâm, món ăn nhẹ, bánh ngọt, đồ ăn vặt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '点心' AND pinyin = 'diǎnxin'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '点心' AND pinyin = 'diǎnxin'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '点心'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '点心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'diǎnxin',
      meaning_vi = 'điểm tâm, món ăn nhẹ, bánh ngọt, đồ ăn vặt',
      example_hanzi = '下午茶时间，妈妈端出了一盘亲手烘焙的热腾腾手工点心。',
      example_pinyin = 'Xiàwǔchá shíjiān, māma duān chū le yì pán qīnshǒu hōngbèi de rèténgténg shǒugōng diǎnxin.',
      example_vi = 'Đến giờ uống trà chiều, mẹ bưng ra một đĩa bánh ngọt làm bằng tay nóng hổi do chính tay mẹ nướng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '点心',
      'diǎnxin',
      'điểm tâm, món ăn nhẹ, bánh ngọt, đồ ăn vặt',
      'Danh từ',
      'HSK 5',
      '下午茶时间，妈妈端出了一盘亲手烘焙的热腾腾手工点心。',
      'Xiàwǔchá shíjiān, māma duān chū le yì pán qīnshǒu hōngbèi de rèténgténg shǒugōng diǎnxin.',
      'Đến giờ uống trà chiều, mẹ bưng ra một đĩa bánh ngọt làm bằng tay nóng hổi do chính tay mẹ nướng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '下午茶时间，妈妈端出了一盘亲手烘焙的热腾腾手工点心。',
        'Xiàwǔchá shíjiān, māma duān chū le yì pán qīnshǒu hōngbèi de rèténgténg shǒugōng diǎnxin.',
        'Đến giờ uống trà chiều, mẹ bưng ra một đĩa bánh ngọt làm bằng tay nóng hổi do chính tay mẹ nướng.',
        'basic',
        1
      ),
      (
        v_id,
        '广式传统茶楼的早茶点心制作极其讲究刀工与火候，晶莹剔透的水晶虾饺与酥脆香浓的蛋挞是广受海内外食客赞誉的经典美食。',
        'Guǎngshì chuántǒng chálóu de zǎochá diǎnxin zhìzuò jíqí jiǎngjiu dāogōng yǔ huǒhou, jīngyíng-tītòu de shuǐjīng xiājiǎo yǔ sūcuì xiāngnóng de dàntà shì guǎng shòu hǎinèiwài shíkè zànyù de jīngdiǎn měishí.',
        'Món bánh điểm tâm trà sớm tại các trà lâu truyền thống kiểu Quảng Đông được chế biến cực kỳ khắt khe về kỹ thuật dùng dao và canh lửa, há cảo tôm pha lê trong suốt long lanh và bánh tart trứng giòn xốp thơm lừng là những món ngon kinh điển được thực khách trong và ngoài nước hết lời ca ngợi.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2277] [点赞] (diǎnzàn) - thả tim, bấm like, khen ngợi biểu dương (trên mạng xã hội) [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '点赞' AND pinyin = 'diǎnzàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '点赞' AND pinyin = 'diǎnzàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '点赞'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '点赞'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'diǎnzàn',
      meaning_vi = 'thả tim, bấm like, khen ngợi biểu dương (trên mạng xã hội)',
      example_hanzi = '他在朋友圈分享的自制美食照片赢得了许多好友的纷纷点赞。',
      example_pinyin = 'Tā zài péngyouquān fēnxiǎng de zìzhì měishí zhàopiàn yíngdé le xǔduō hǎoyǒu de fēnfēn diǎnzàn.',
      example_vi = 'Những bức ảnh chụp món ngon tự làm được anh ấy chia sẻ trên mạng xã hội đã nhận được vô số lượt thả tim bấm like từ bạn bè.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '点赞',
      'diǎnzàn',
      'thả tim, bấm like, khen ngợi biểu dương (trên mạng xã hội)',
      'Động từ / Danh từ',
      'HSK 5',
      '他在朋友圈分享的自制美食照片赢得了许多好友的纷纷点赞。',
      'Tā zài péngyouquān fēnxiǎng de zìzhì měishí zhàopiàn yíngdé le xǔduō hǎoyǒu de fēnfēn diǎnzàn.',
      'Những bức ảnh chụp món ngon tự làm được anh ấy chia sẻ trên mạng xã hội đã nhận được vô số lượt thả tim bấm like từ bạn bè.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他在朋友圈分享的自制美食照片赢得了许多好友的纷纷点赞。',
        'Tā zài péngyouquān fēnxiǎng de zìzhì měishí zhàopiàn yíngdé le xǔduō hǎoyǒu de fēnfēn diǎnzàn.',
        'Những bức ảnh chụp món ngon tự làm được anh ấy chia sẻ trên mạng xã hội đã nhận được vô số lượt thả tim bấm like từ bạn bè.',
        'basic',
        1
      ),
      (
        v_id,
        '交警冒着暴风雪在冰冻路面上全力推移被困故障车辆的感人事迹被路人拍下后发到网络上，获得了数百万网友的起立点赞与由衷致敬。',
        'Jiāojǐng mào zhe bàofēngxuě zài bīngdòng lùmiàn shàng quánlì tuīyí bèikùn gùzhàng chēliàng de gǎnrén shìjì bèi lùrén pāi xià hòu fā dào wǎngluò shàng, huòdé le shù bǎi wàn wǎngyǒu de qǐlì diǎnzàn yǔ yóuzhōng zhìjìng.',
        'Hành động cảm động của người chiến sĩ cảnh sát giao thông đội bão tuyết dốc toàn lực đẩy chiếc xe gặp sự cố bị mắc kẹt trên mặt đường đóng băng được người đi đường chụp lại đăng lên mạng, đã nhận được hàng triệu lượt bấm like và sự kính trọng chân thành của cộng đồng mạng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2278] [电池] (diànchí) - pin, ắc quy (thiết bị tích trữ năng lượng điện) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '电池' AND pinyin = 'diànchí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电池' AND pinyin = 'diànchí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '电池'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电池'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'diànchí',
      meaning_vi = 'pin, ắc quy (thiết bị tích trữ năng lượng điện)',
      example_hanzi = '电视机遥控器里的干电池没电了，需要换两节新的。',
      example_pinyin = 'Diànshìjī yáokòngqì lǐ de gāndiànchí méi diàn le, xūyào huàn liǎng jié xīn de.',
      example_vi = 'Pin khô trong điều khiển tivi hết điện rồi, cần thay hai viên pin mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '电池',
      'diànchí',
      'pin, ắc quy (thiết bị tích trữ năng lượng điện)',
      'Danh từ',
      'HSK 5',
      '电视机遥控器里的干电池没电了，需要换两节新的。',
      'Diànshìjī yáokòngqì lǐ de gāndiànchí méi diàn le, xūyào huàn liǎng jié xīn de.',
      'Pin khô trong điều khiển tivi hết điện rồi, cần thay hai viên pin mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '电视机遥控器里的干电池没电了，需要换两节新的。',
        'Diànshìjī yáokòngqì lǐ de gāndiànchí méi diàn le, xūyào huàn liǎng jié xīn de.',
        'Pin khô trong điều khiển tivi hết điện rồi, cần thay hai viên pin mới.',
        'basic',
        1
      ),
      (
        v_id,
        '我国动力电池研发科研人员在固态电池高能量密度与超长循环使用寿命技术上取得颠覆性突破，为全球新能源汽车产业升级注入了澎湃活力。',
        'Wǒ guó dònglì diànchí yánfā kēyán rényuán zài gùtài diànchí gāo néngliàng mìdù yǔ chāocháng xúnhuán shǐyòng shòumìng jìshù shàng qǔdé diānfùxìng tūpò, wèi quánqiú xīn néngyuán qìchē chǎnyè shēngjí zhùrù le péngpài huólì.',
        'Các cán bộ nghiên cứu khoa học pin động lực nước ta đã giành được đột phá mang tính cách mạng trong công nghệ mật độ năng lượng cao và tuổi thọ chu kỳ sử dụng siêu dài của pin thể rắn, tiếp thêm nguồn sinh lực cuộn trào cho sự nâng cấp của ngành công nghiệp ô tô năng lượng mới toàn cầu.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2279] [电动] (diàndòng) - chạy bằng điện, dùng động cơ điện (xe đạp, ô tô, đồ chơi) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '电动' AND pinyin = 'diàndòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电动' AND pinyin = 'diàndòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '电动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'diàndòng',
      meaning_vi = 'chạy bằng điện, dùng động cơ điện (xe đạp, ô tô, đồ chơi)',
      example_hanzi = '骑电动自行车上下班既方便省时又绿色低碳环保。',
      example_pinyin = 'Qí diàndòng zìxíngchē shàng-xiàbān jì fāngbiàn shěngshí yòu lǜsè dītàn huánbǎo.',
      example_vi = 'Đi xe đạp điện đi làm và tan ca vừa tiện lợi tiết kiệm thời gian, lại vừa xanh, ít phát thải và bảo vệ môi trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '电动',
      'diàndòng',
      'chạy bằng điện, dùng động cơ điện (xe đạp, ô tô, đồ chơi)',
      'Tính từ',
      'HSK 5',
      '骑电动自行车上下班既方便省时又绿色低碳环保。',
      'Qí diàndòng zìxíngchē shàng-xiàbān jì fāngbiàn shěngshí yòu lǜsè dītàn huánbǎo.',
      'Đi xe đạp điện đi làm và tan ca vừa tiện lợi tiết kiệm thời gian, lại vừa xanh, ít phát thải và bảo vệ môi trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '骑电动自行车上下班既方便省时又绿色低碳环保。',
        'Qí diàndòng zìxíngchē shàng-xiàbān jì fāngbiàn shěngshí yòu lǜsè dītàn huánbǎo.',
        'Đi xe đạp điện đi làm và tan ca vừa tiện lợi tiết kiệm thời gian, lại vừa xanh, ít phát thải và bảo vệ môi trường.',
        'basic',
        1
      ),
      (
        v_id,
        '随着全国充电桩补能基础设施的高速完善与以旧换新补贴落地，纯电动汽车在国内汽车零售新车渗透率中连续数月突破百分之五十。',
        'Suízhe quánguó chōngdiànzhuāng bǔnéng jīchǔ shèshī de gāosù wánshàn yǔ yǐjiù-huànxīn bǔtiē luòdì, chún diàndòng qìchē zài guónèi qìchē língshòu xīnchē shèntòulǜ zhōng liánxù shù yuè tūpò bǎifēnzhī wǔshí.',
        'Cùng với sự hoàn thiện thần tốc của cơ sở hạ tầng trụ sạc năng lượng trên toàn quốc và chính sách trợ cấp thu cũ đổi mới đi vào thực tế, tỷ lệ thâm nhập của xe ô tô thuần điện trong lượng xe mới bán lẻ nội địa đã liên tiếp nhiều tháng vượt mốc năm mươi phần trăm.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2280] [电器] (diànqì) - đồ điện gia dụng, thiết bị điện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '电器' AND pinyin = 'diànqì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电器' AND pinyin = 'diànqì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '电器'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电器'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'diànqì',
      meaning_vi = 'đồ điện gia dụng, thiết bị điện',
      example_hanzi = '长时间出门远行前，一定要把家里所有不常用电器的电源插头拔掉。',
      example_pinyin = 'Cháng shíjiān chūmén yuǎnxíng qián, yídìng yào bǎ jiā lǐ suǒyǒu bù chángyòng diànqì de diànyuán chātóu bá diào.',
      example_vi = 'Trước khi đi xa nhà trong thời gian dài, nhất định phải rút hết phích cắm nguồn điện của tất cả các đồ điện không thường dùng trong nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '电器',
      'diànqì',
      'đồ điện gia dụng, thiết bị điện',
      'Danh từ',
      'HSK 5',
      '长时间出门远行前，一定要把家里所有不常用电器的电源插头拔掉。',
      'Cháng shíjiān chūmén yuǎnxíng qián, yídìng yào bǎ jiā lǐ suǒyǒu bù chángyòng diànqì de diànyuán chātóu bá diào.',
      'Trước khi đi xa nhà trong thời gian dài, nhất định phải rút hết phích cắm nguồn điện của tất cả các đồ điện không thường dùng trong nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '长时间出门远行前，一定要把家里所有不常用电器的电源插头拔掉。',
        'Cháng shíjiān chūmén yuǎnxíng qián, yídìng yào bǎ jiā lǐ suǒyǒu bù chángyòng diànqì de diànyuán chātóu bá diào.',
        'Trước khi đi xa nhà trong thời gian dài, nhất định phải rút hết phích cắm nguồn điện của tất cả các đồ điện không thường dùng trong nhà.',
        'basic',
        1
      ),
      (
        v_id,
        '全屋智能互联家居控制系统支持用户使用一部智能手机集中遥控全套智能家用电器，实现照明、温控与安防一键场景化联动。',
        'Quán wū zhìnéng hùlián jiājū kòngzhì xìtǒng zhīchí yònghù shǐyòng yí bù zhìnéng shǒujī jízhōng yáokòng quán tào zhìnéng jiāyòng diànqì, shíxiàn zhàomíng, wēnkòng yǔ ānfáng yíjiàn chǎngjǐnghuà liándòng.',
        'Hệ thống điều khiển nhà ở kết nối thông minh toàn căn nhà hỗ trợ người dùng dùng một chiếc điện thoại thông minh điều khiển từ xa tập trung toàn bộ thiết bị điện gia dụng thông minh, thực hiện liên kết theo ngữ cảnh một chạm giữa chiếu sáng, điều hòa nhiệt độ và an ninh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2281] [电商] (diànshāng) - thương mại điện tử (viết tắt của diànzǐ shāngwù) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '电商' AND pinyin = 'diànshāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电商' AND pinyin = 'diànshāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '电商'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电商'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'diànshāng',
      meaning_vi = 'thương mại điện tử (viết tắt của diànzǐ shāngwù)',
      example_hanzi = '如今越来越多的老百姓习惯在电商平台上在线选购生活日用品。',
      example_pinyin = 'Rújīn yuèláiyuèduō de lǎobǎixìng xíguàn zài diànshāng píngtái shàng zàixiàn xuǎngòu shēnghuó rìyòngpǐn.',
      example_vi = 'Ngày nay ngày càng có nhiều người dân hình thành thói quen chọn mua đồ dùng sinh hoạt hằng ngày trực tuyến trên các sàn thương mại điện tử.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '电商',
      'diànshāng',
      'thương mại điện tử (viết tắt của diànzǐ shāngwù)',
      'Danh từ',
      'HSK 5',
      '如今越来越多的老百姓习惯在电商平台上在线选购生活日用品。',
      'Rújīn yuèláiyuèduō de lǎobǎixìng xíguàn zài diànshāng píngtái shàng zàixiàn xuǎngòu shēnghuó rìyòngpǐn.',
      'Ngày nay ngày càng có nhiều người dân hình thành thói quen chọn mua đồ dùng sinh hoạt hằng ngày trực tuyến trên các sàn thương mại điện tử.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '如今越来越多的老百姓习惯在电商平台上在线选购生活日用品。',
        'Rújīn yuèláiyuèduō de lǎobǎixìng xíguàn zài diànshāng píngtái shàng zàixiàn xuǎngòu shēnghuó rìyòngpǐn.',
        'Ngày nay ngày càng có nhiều người dân hình thành thói quen chọn mua đồ dùng sinh hoạt hằng ngày trực tuyến trên các sàn thương mại điện tử.',
        'basic',
        1
      ),
      (
        v_id,
        '跨境电商零售进口监管模式的持续创新与综合试验区扩容，为优质海外消费品直接进入千家万户打通了一条极为高效便捷的阳光通道。',
        'Kuàjìng diànshāng língshòu jìnkǒu jiānguǎn móshì de chíxù chuàngxīn yǔ zōnghé shìyànqū kuòróng, wèi yōuzhì hǎiwài xiāofèipǐn zhíjiē jìnrù qiānjiā-wànhù dǎtōng le yì tiáo jíwéi gāoxiào biànjié de yángguāng tōngdào.',
        'Sự đổi mới không ngừng của mô hình giám sát nhập khẩu bán lẻ thương mại điện tử xuyên biên giới và việc mở rộng các khu thí điểm tổng hợp, đã khai thông một hành lang thông suốt cực kỳ hiệu quả và thuận tiện để hàng tiêu dùng chất lượng cao ở nước ngoài vào thẳng hàng vạn mái ấm.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2282] [电视台] (diànshìtái) - đài truyền hình (cơ quan truyền thông phát thanh truyền hình) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '电视台' AND pinyin = 'diànshìtái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电视台' AND pinyin = 'diànshìtái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '电视台'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电视台'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'diànshìtái',
      meaning_vi = 'đài truyền hình (cơ quan truyền thông phát thanh truyền hình)',
      example_hanzi = '国家电视台新闻频道每天准时向全国观众播报最新的国际热点新闻。',
      example_pinyin = 'Guójiā diànshìtái xīnwén píndào měitiān zhǔnshí xiàng quánguó guānzhòng bōbào zuìxīn de guójì rèdiǎn xīnwén.',
      example_vi = 'Kênh tin tức đài truyền hình quốc gia mỗi ngày đều phát sóng đúng giờ các tin tức nóng quốc tế mới nhất cho khán giả cả nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '电视台',
      'diànshìtái',
      'đài truyền hình (cơ quan truyền thông phát thanh truyền hình)',
      'Danh từ',
      'HSK 5',
      '国家电视台新闻频道每天准时向全国观众播报最新的国际热点新闻。',
      'Guójiā diànshìtái xīnwén píndào měitiān zhǔnshí xiàng quánguó guānzhòng bōbào zuìxīn de guójì rèdiǎn xīnwén.',
      'Kênh tin tức đài truyền hình quốc gia mỗi ngày đều phát sóng đúng giờ các tin tức nóng quốc tế mới nhất cho khán giả cả nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '国家电视台新闻频道每天准时向全国观众播报最新的国际热点新闻。',
        'Guójiā diànshìtái xīnwén píndào měitiān zhǔnshí xiàng quánguó guānzhòng bōbào zuìxīn de guójì rèdiǎn xīnwén.',
        'Kênh tin tức đài truyền hình quốc gia mỗi ngày đều phát sóng đúng giờ các tin tức nóng quốc tế mới nhất cho khán giả cả nước.',
        'basic',
        1
      ),
      (
        v_id,
        '为了应对新媒体形态的猛烈冲击，省级广播电视台大力推进媒体深度融合战略转型，全力打造涵盖广播、电视与客户端的全媒体矩阵。',
        'Wèile yìngduì xīn méitǐ xíngtài de měngliè chōngjī, shěngjí guǎngbō diànshìtái dàlì tuījìn méitǐ shēndù rónghé zhànlüè zhuǎnxíng, quánlì dǎzào hángài guǎngbō, diànshì yǔ kèhùduān de quán méitǐ jùzhèn.',
        'Nhằm ứng phó với sự va đập dữ dội của các hình thái truyền thông mới, đài phát thanh và truyền hình cấp tỉnh đã ra sức đẩy mạnh chuyển đổi chiến lược tích hợp sâu truyền thông, dốc toàn lực xây dựng ma trận toàn truyền thông bao gồm phát thanh, truyền hình và ứng dụng di động.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2283] [电子版] (diànzǐbǎn) - bản điện tử (sách điện tử, tập tin văn bản số, file mềm) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '电子版' AND pinyin = 'diànzǐbǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电子版' AND pinyin = 'diànzǐbǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '电子版'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '电子版'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'diànzǐbǎn',
      meaning_vi = 'bản điện tử (sách điện tử, tập tin văn bản số, file mềm)',
      example_hanzi = '购书者可以在官方网站上直接付费下载教材的电子版文件以便在平板电脑上阅读。',
      example_pinyin = 'Gòushūzhě kěyǐ zài guānfāng wǎngzhàn shàng zhíjiē fùfèi xiàzài jiàocái de diànzǐbǎn wénjiàn yǐbiàn zài píngbǎn diànnǎo shàng yuèdú.',
      example_vi = 'Người mua sách có thể trực tiếp trả phí tải tệp tin bản điện tử của giáo trình trên trang web chính thức để đọc trên máy tính bảng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '电子版',
      'diànzǐbǎn',
      'bản điện tử (sách điện tử, tập tin văn bản số, file mềm)',
      'Danh từ',
      'HSK 5',
      '购书者可以在官方网站上直接付费下载教材的电子版文件以便在平板电脑上阅读。',
      'Gòushūzhě kěyǐ zài guānfāng wǎngzhàn shàng zhíjiē fùfèi xiàzài jiàocái de diànzǐbǎn wénjiàn yǐbiàn zài píngbǎn diànnǎo shàng yuèdú.',
      'Người mua sách có thể trực tiếp trả phí tải tệp tin bản điện tử của giáo trình trên trang web chính thức để đọc trên máy tính bảng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '购书者可以在官方网站上直接付费下载教材的电子版文件以便在平板电脑上阅读。',
        'Gòushūzhě kěyǐ zài guānfāng wǎngzhàn shàng zhíjiē fùfèi xiàzài jiàocái de diànzǐbǎn wénjiàn yǐbiàn zài píngbǎn diànnǎo shàng yuèdú.',
        'Người mua sách có thể trực tiếp trả phí tải tệp tin bản điện tử của giáo trình trên trang web chính thức để đọc trên máy tính bảng.',
        'basic',
        1
      ),
      (
        v_id,
        '政务服务大厅大力推行无纸化网上审批改革，市民与企业申请人只需在线提交加盖合格数字证书的电子版申请材料即可完成审批办结。',
        'Zhèngwù fúwù dàtīng dàlì tuīxíng wúzǐhuà wǎngshàng shěnpī gǎigé, shìmín yǔ qǐyè shēnqǐngrén zhǐ xū zàixiàn tíjiāo jiāgài hégé shùzì zhèngshū de diànzǐbǎn shēnqǐng cáiliào jí kě wánchéng shěnpī bànjié.',
        'Sảnh dịch vụ hành chính công ra sức thúc đẩy cải cách phê duyệt trực tuyến không giấy tờ, người dân và doanh nghiệp nộp đơn chỉ cần nộp trực tuyến tài liệu hồ sơ bản điện tử có đóng dấu chứng thư số hợp lệ là có thể hoàn thành việc phê duyệt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2284] [调] (diào) - điều động, thuyên chuyển, hoán đổi (diào); điều chỉnh, chỉnh lý (tiáo) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '调' AND pinyin = 'diào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调' AND pinyin = 'diào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '调'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'diào',
      meaning_vi = 'điều động, thuyên chuyển, hoán đổi (diào); điều chỉnh, chỉnh lý (tiáo)',
      example_hanzi = '因工作业务发展需要，公司领导决定把他从市场销售部调往海外事业部。',
      example_pinyin = 'Yīn gōngzuò yèwù fāzhǎn xūyào, gōngsī lǐngdǎo juédìng bǎ tā cóng shìchǎng xiāoshòubù diào wǎng hǎiwài shìyèbù.',
      example_vi = 'Do nhu cầu phát triển nghiệp vụ công việc, lãnh đạo công ty đã quyết định điều động anh ấy từ phòng kinh doanh thị trường sang bộ phận kinh doanh hải ngoại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '调',
      'diào',
      'điều động, thuyên chuyển, hoán đổi (diào); điều chỉnh, chỉnh lý (tiáo)',
      'Động từ',
      'HSK 5',
      '因工作业务发展需要，公司领导决定把他从市场销售部调往海外事业部。',
      'Yīn gōngzuò yèwù fāzhǎn xūyào, gōngsī lǐngdǎo juédìng bǎ tā cóng shìchǎng xiāoshòubù diào wǎng hǎiwài shìyèbù.',
      'Do nhu cầu phát triển nghiệp vụ công việc, lãnh đạo công ty đã quyết định điều động anh ấy từ phòng kinh doanh thị trường sang bộ phận kinh doanh hải ngoại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '因工作业务发展需要，公司领导决定把他从市场销售部调往海外事业部。',
        'Yīn gōngzuò yèwù fāzhǎn xūyào, gōngsī lǐngdǎo juédìng bǎ tā cóng shìchǎng xiāoshòubù diào wǎng hǎiwài shìyèbù.',
        'Do nhu cầu phát triển nghiệp vụ công việc, lãnh đạo công ty đã quyết định điều động anh ấy từ phòng kinh doanh thị trường sang bộ phận kinh doanh hải ngoại.',
        'basic',
        1
      ),
      (
        v_id,
        '面对局部突发极端洪涝险情，国家防汛抗旱应急指挥部迅速调派专业水域救援骨干力量携重型排水抢险装备赶赴一线支援。',
        'Miànduì júbù tūfā jíduān hónglào xiǎnqíng, guójiā fángxùn-kànghàn yìngjí zhǐhuībù xùnsù diàopài zhuānyè shuǐyù jiùyuán gǔgàn lìliàng xié zhòngxíng páishuǐ qiǎngxiǎn zhuāngbèi gǎnfù yīxiàn zhīyuán.',
        'Đối mặt với tình thế lũ lụt cực đoan cục bộ bất ngờ ập đến, ban chỉ huy ứng phó khẩn cấp phòng chống bão lụt hạn hán quốc gia đã nhanh chóng điều động lực lượng nòng cốt cứu nạn vùng nước chuyên nghiệp mang theo trang thiết bị tiêu úng ứng cứu hạng nặng đến ngay tuyến đầu chi viện.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2285] [调研] (diàoyán) - điều tra nghiên cứu, khảo sát thực tế chuyên sâu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '调研' AND pinyin = 'diàoyán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调研' AND pinyin = 'diàoyán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '调研'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '调研'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'diàoyán',
      meaning_vi = 'điều tra nghiên cứu, khảo sát thực tế chuyên sâu',
      example_hanzi = '在撰写毕业论文开题报告之前，他深入几所农村小学开展了为期两周的实地调研。',
      example_pinyin = 'Zài zhuànxiě bìyè lùnwén kāití bàogào zhīqián, tā shēnrù jǐ suǒ nóngcūn xiǎoxué kāizhǎn le wéiqī liǎng zhōu de shídì diàoyán.',
      example_vi = 'Trước khi viết báo cáo đề cương khóa luận tốt nghiệp, anh ấy đã đi sâu vào một số trường tiểu học nông thôn triển khai đợt khảo sát thực địa trong hai tuần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '调研',
      'diàoyán',
      'điều tra nghiên cứu, khảo sát thực tế chuyên sâu',
      'Động từ / Danh từ',
      'HSK 5',
      '在撰写毕业论文开题报告之前，他深入几所农村小学开展了为期两周的实地调研。',
      'Zài zhuànxiě bìyè lùnwén kāití bàogào zhīqián, tā shēnrù jǐ suǒ nóngcūn xiǎoxué kāizhǎn le wéiqī liǎng zhōu de shídì diàoyán.',
      'Trước khi viết báo cáo đề cương khóa luận tốt nghiệp, anh ấy đã đi sâu vào một số trường tiểu học nông thôn triển khai đợt khảo sát thực địa trong hai tuần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '在撰写毕业论文开题报告之前，他深入几所农村小学开展了为期两周的实地调研。',
        'Zài zhuànxiě bìyè lùnwén kāití bàogào zhīqián, tā shēnrù jǐ suǒ nóngcūn xiǎoxué kāizhǎn le wéiqī liǎng zhōu de shídì diàoyán.',
        'Trước khi viết báo cáo đề cương khóa luận tốt nghiệp, anh ấy đã đi sâu vào một số trường tiểu học nông thôn triển khai đợt khảo sát thực địa trong hai tuần.',
        'basic',
        1
      ),
      (
        v_id,
        '国家发改委宏观经济专家组深入长三角先进制造业基地开展专题调研，为国家制定新一代战略性新兴产业中长期扶持政策摸清真实底数。',
        'Guójiā Fāgǎiwěi hóngguān jīngjì zhuānjiāzǔ shēnrù Chángsānjiǎo xiānjìn zhìzàoyè jīdì kāizhǎn zhuāntí diàoyán, wèi guójiā zhìdìng xīn yídài zhànlüèxìng xīnxīng chǎnyè zhōng-chángqī fúchí zhèngcè mō qīng zhēnshí dǐshù.',
        'Tổ chuyên gia kinh tế vĩ mô của Ủy ban Cải cách và Phát triển Quốc gia đã đi sâu vào căn cứ công nghiệp chế tạo tiên tiến vùng đồng bằng sông Dương Tử triển khai đợt khảo sát chuyên đề, nhằm nắm bắt chính xác số liệu thực tế phục vụ nhà nước hoạch định chính sách hỗ trợ trung và dài hạn cho các ngành công nghiệp mới nổi mang tính chiến lược thế hệ mới.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2286] [定期] (dìngqī) - định kỳ, theo kỳ hạn cố định đều đặn [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '定期' AND pinyin = 'dìngqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '定期' AND pinyin = 'dìngqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '定期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '定期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'dìngqī',
      meaning_vi = 'định kỳ, theo kỳ hạn cố định đều đặn',
      example_hanzi = '医生建议成年人每年都应该前往正规专业医疗机构进行一次全面的定期体检。',
      example_pinyin = 'Yīshēng jiànyì chéngniánrén měi nián dōu yīnggāi qiánwǎng zhèngguī zhuānyè yīliáo jīgòu jìnxíng yí cì quánmiàn de dìngqī tǐjiǎn.',
      example_vi = 'Bác sĩ khuyến cáo người trưởng thành mỗi năm đều nên đến cơ sở y tế chuyên nghiệp chính quy để làm một lần khám sức khỏe định kỳ toàn diện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '定期',
      'dìngqī',
      'định kỳ, theo kỳ hạn cố định đều đặn',
      'Tính từ / Phó từ',
      'HSK 5',
      '医生建议成年人每年都应该前往正规专业医疗机构进行一次全面的定期体检。',
      'Yīshēng jiànyì chéngniánrén měi nián dōu yīnggāi qiánwǎng zhèngguī zhuānyè yīliáo jīgòu jìnxíng yí cì quánmiàn de dìngqī tǐjiǎn.',
      'Bác sĩ khuyến cáo người trưởng thành mỗi năm đều nên đến cơ sở y tế chuyên nghiệp chính quy để làm một lần khám sức khỏe định kỳ toàn diện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '医生建议成年人每年都应该前往正规专业医疗机构进行一次全面的定期体检。',
        'Yīshēng jiànyì chéngniánrén měi nián dōu yīnggāi qiánwǎng zhèngguī zhuānyè yīliáo jīgòu jìnxíng yí cì quánmiàn de dìngqī tǐjiǎn.',
        'Bác sĩ khuyến cáo người trưởng thành mỗi năm đều nên đến cơ sở y tế chuyên nghiệp chính quy để làm một lần khám sức khỏe định kỳ toàn diện.',
        'basic',
        1
      ),
      (
        v_id,
        '航空安全管理规定严格明确，商业客运民航飞机必须在飞行达到指定小时数后，按照技术规程进行彻底的定期深度检修保养与关键部件无损探伤。',
        'Hángkōng ānquán guǎnlǐ guīdìng yángé míngquè, shāngyè kèyùn mínháng fēijī bìxū zài fēixíng dádào zhǐdìng xiǎoshíshù hòu, ànzhào jìshù guīchéng jìnxíng chèdǐ de dìngqī shēndù jiǎnxiū bǎoyǎng yǔ guānjiàn bùjiàn wúsǔn tànshāng.',
        'Quy định quản lý an toàn hàng không nêu rõ nghiêm ngặt, máy bay hàng không dân dụng thương mại bắt buộc sau khi bay đạt đủ số giờ quy định phải theo đúng quy trình kỹ thuật tiến hành đợt bảo dưỡng sửa chữa định kỳ chuyên sâu triệt để và dò tìm khuyết tật không phá hủy các linh kiện then chốt.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2287] [丢失] (diūshī) - làm mất, thất lạc, đánh rơi mất [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '丢失' AND pinyin = 'diūshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '丢失' AND pinyin = 'diūshī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '丢失'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '丢失'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'diūshī',
      meaning_vi = 'làm mất, thất lạc, đánh rơi mất',
      example_hanzi = '他在乘坐出租车时不慎将随身携带的黑色公文包丢失在后座上了。',
      example_pinyin = 'Tā zài chéngzuò chūzūchē shí búshèn jiāng suíshēn xiédài de hēisè gōngwénbāo diūshī zài hòuzuò shàng le.',
      example_vi = 'Trong lúc đi taxi anh ấy đã sơ ý làm thất lạc chiếc cặp tài liệu màu đen mang theo trên băng ghế sau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '丢失',
      'diūshī',
      'làm mất, thất lạc, đánh rơi mất',
      'Động từ',
      'HSK 5',
      '他在乘坐出租车时不慎将随身携带的黑色公文包丢失在后座上了。',
      'Tā zài chéngzuò chūzūchē shí búshèn jiāng suíshēn xiédài de hēisè gōngwénbāo diūshī zài hòuzuò shàng le.',
      'Trong lúc đi taxi anh ấy đã sơ ý làm thất lạc chiếc cặp tài liệu màu đen mang theo trên băng ghế sau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '他在乘坐出租车时不慎将随身携带的黑色公文包丢失在后座上了。',
        'Tā zài chéngzuò chūzūchē shí búshèn jiāng suíshēn xiédài de hēisè gōngwénbāo diūshī zài hòuzuò shàng le.',
        'Trong lúc đi taxi anh ấy đã sơ ý làm thất lạc chiếc cặp tài liệu màu đen mang theo trên băng ghế sau.',
        'basic',
        1
      ),
      (
        v_id,
        '针对突发的机房断电事故，该分布式云数据库凭借强大的跨数据中心多节点冗余备份机制，实现了核心财务金融交易数据零丢失与秒级自动恢复。',
        'Zhēnduì tūfā de jīfáng duàndiàn shìgù, gāi fēnbùshì yún shùjùkù píngjiè qiángdà de kuà shùjù zhōngxīn duō jiédiǎn rǒngyú bèifèn jīzhì, shíxiàn le héxīn cáiwù jīnróng jiāoyì shùjù líng diūshī yǔ miǎojí zìdòng huīfù.',
        'Trước sự cố mất điện phòng máy chủ bất ngờ ập đến, cơ sở dữ liệu đám mây phân tán này dựa vào cơ chế sao lưu dự phòng đa nút xuyên trung tâm dữ liệu mạnh mẽ, đã thực hiện được việc không làm mất bất kỳ dữ liệu giao dịch tài chính cốt lõi nào và tự động khôi phục trong tích tắc chỉ vài giây.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2288] [冻] (dòng) - đông lại, đóng băng; cóng, lạnh cóng, làm đông lạnh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '冻' AND pinyin = 'dòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '冻' AND pinyin = 'dòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '冻'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '冻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dòng',
      meaning_vi = 'đông lại, đóng băng; cóng, lạnh cóng, làm đông lạnh',
      example_hanzi = '寒冬腊月气温降到了零下十五度，湖面早已经冻结成了一层坚硬的厚冰。',
      example_pinyin = 'Hándōng-làyuè qìwēn jiàng dào le língxià shíwǔ dù, húmiàn zǎo yǐjīng dòngjié chéng le yì céng jiānyìng de hòu bīng.',
      example_vi = 'Tháng chạp mùa đông giá rét nhiệt độ tụt xuống âm mười lăm độ, mặt hồ từ sớm đã đóng băng đông lại thành một lớp băng dày cứng cỏi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '冻',
      'dòng',
      'đông lại, đóng băng; cóng, lạnh cóng, làm đông lạnh',
      'Động từ',
      'HSK 5',
      '寒冬腊月气温降到了零下十五度，湖面早已经冻结成了一层坚硬的厚冰。',
      'Hándōng-làyuè qìwēn jiàng dào le língxià shíwǔ dù, húmiàn zǎo yǐjīng dòngjié chéng le yì céng jiānyìng de hòu bīng.',
      'Tháng chạp mùa đông giá rét nhiệt độ tụt xuống âm mười lăm độ, mặt hồ từ sớm đã đóng băng đông lại thành một lớp băng dày cứng cỏi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '寒冬腊月气温降到了零下十五度，湖面早已经冻结成了一层坚硬的厚冰。',
        'Hándōng-làyuè qìwēn jiàng dào le língxià shíwǔ dù, húmiàn zǎo yǐjīng dòngjié chéng le yì céng jiānyìng de hòu bīng.',
        'Tháng chạp mùa đông giá rét nhiệt độ tụt xuống âm mười lăm độ, mặt hồ từ sớm đã đóng băng đông lại thành một lớp băng dày cứng cỏi.',
        'basic',
        1
      ),
      (
        v_id,
        '冷链物流冷库采用国际先进的多级超低温速冻保鲜制冷技术，将新鲜深海金枪鱼在零下六十度极速急冻，完好保留其鲜美口感与全部营养成分。',
        'Lěngliàn wùliú lěngkù cǎiyòng guójì xiānjìn de duōjí chāodīwēn sùdòng bǎoxiān zhìlěng jìshù, jiāng xīnxiān shēnhǎi jīnbāngyú zài língxià liùshí dù jísù jídòng, wánhǎo bǎoliú qí xiānměi kǒugǎn yǔ quánbù yíngyǎng chéngfèn.',
        'Kho lạnh vận tải chuỗi cung ứng lạnh áp dụng kỹ thuật làm lạnh cấp đông nhanh giữ tươi siêu nhiệt độ âm nhiều cấp tiên tiến quốc tế, đem cá ngừ đại dương tươi sống cấp đông cực nhanh ở âm sáu mươi độ, giữ gìn trọn vẹn vị tươi ngon và toàn bộ thành phần dinh dưỡng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2289] [洞] (dòng) - cái hang, cái lỗ, lỗ thủng, hang động [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '洞' AND pinyin = 'dòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '洞' AND pinyin = 'dòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '洞'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '洞'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dòng',
      meaning_vi = 'cái hang, cái lỗ, lỗ thủng, hang động',
      example_hanzi = '毛衣的胳膊肘处被钉子勾破了一个小洞。',
      example_pinyin = 'Máoyī de gēbozhǒu chù bèi dīngzi gōupò le yí gè xiǎo dòng.',
      example_vi = 'Chỗ khuỷu tay của chiếc áo len bị đinh cào rách một lỗ thủng nhỏ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '洞',
      'dòng',
      'cái hang, cái lỗ, lỗ thủng, hang động',
      'Danh từ',
      'HSK 5',
      '毛衣的胳膊肘处被钉子勾破了一个小洞。',
      'Máoyī de gēbozhǒu chù bèi dīngzi gōupò le yí gè xiǎo dòng.',
      'Chỗ khuỷu tay của chiếc áo len bị đinh cào rách một lỗ thủng nhỏ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '毛衣的胳膊肘处被钉子勾破了一个小洞。',
        'Máoyī de gēbozhǒu chù bèi dīngzi gōupò le yí gè xiǎo dòng.',
        'Chỗ khuỷu tay của chiếc áo len bị đinh cào rách một lỗ thủng nhỏ.',
        'basic',
        1
      ),
      (
        v_id,
        '这处位于西南喀斯特地貌深处的天然大型溶洞内布满了千姿百态的钟乳石与地下暗河，宛如一座巧夺天工的大自然地下艺术宫殿。',
        'Zhè chù wèiyú xīnán kāsītè dìmào shēnchù de tiānrán dàxíng róngdòng nèi bù mǎn le qiānzī-bǎitài de zhōngrǔshí yǔ dìxià ànhé, wǎnrú yí zuò qiǎoduó-tiāngōng de dàzìrán dìxià yìshù gōngdiàn.',
        'Bên trong hang động đá vôi tự nhiên quy mô lớn nằm sâu trong địa mạo karst vùng tây nam này phủ kín các thạch nhũ muôn hình vạn trạng cùng dòng sông ngầm dưới lòng đất, tựa như một cung điện nghệ thuật dưới lòng đất của mẹ thiên nhiên tuyệt mỹ vô song.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2290] [动画] (dònghuà) - phim hoạt hình, tranh hoạt họa, kỹ xảo hoạt hình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '动画' AND pinyin = 'dònghuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '动画' AND pinyin = 'dònghuà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '动画'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '动画'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dònghuà',
      meaning_vi = 'phim hoạt hình, tranh hoạt họa, kỹ xảo hoạt hình',
      example_hanzi = '周末晚上，爸爸妈妈陪着小女儿一起在电影院看新上映的国产儿童动画电影。',
      example_pinyin = 'Zhōumò wǎnshang, bàba māma péi zhe xiǎo nǚ’ér yìqǐ zài diànyǐngyuàn kàn xīn shàngyìng de guóchǎn értóng dònghuà diànyǐng.',
      example_vi = 'Tối cuối tuần, bố mẹ cùng con gái nhỏ đi xem bộ phim hoạt hình thiếu nhi trong nước mới ra rạp tại rạp chiếu phim.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '动画',
      'dònghuà',
      'phim hoạt hình, tranh hoạt họa, kỹ xảo hoạt hình',
      'Danh từ',
      'HSK 5',
      '周末晚上，爸爸妈妈陪着小女儿一起在电影院看新上映的国产儿童动画电影。',
      'Zhōumò wǎnshang, bàba māma péi zhe xiǎo nǚ’ér yìqǐ zài diànyǐngyuàn kàn xīn shàngyìng de guóchǎn értóng dònghuà diànyǐng.',
      'Tối cuối tuần, bố mẹ cùng con gái nhỏ đi xem bộ phim hoạt hình thiếu nhi trong nước mới ra rạp tại rạp chiếu phim.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '周末晚上，爸爸妈妈陪着小女儿一起在电影院看新上映的国产儿童动画电影。',
        'Zhōumò wǎnshang, bàba māma péi zhe xiǎo nǚ’ér yìqǐ zài diànyǐngyuàn kàn xīn shàngyìng de guóchǎn értóng dònghuà diànyǐng.',
        'Tối cuối tuần, bố mẹ cùng con gái nhỏ đi xem bộ phim hoạt hình thiếu nhi trong nước mới ra rạp tại rạp chiếu phim.',
        'basic',
        1
      ),
      (
        v_id,
        '该动画制作团队巧妙融合中国传统水墨水彩艺术风格与前沿三维数字电脑图像合成渲染技术，打造出了蜚声海内外的国产神话史诗经典动画力作。',
        'Gāi dònghuà zhìzuò tuánduì qiǎomiào rónghé Zhōngguó chuántǒng shuǐmò shuǐcǎi yìshù fēnggé yǔ qiányán sānwéi shùzì diànnǎo túxiàng héchéng xuànrǎn jìshù, dǎzào chū le fēishēng hǎinèiwài de guóchǎn shénhuà shǐshī jīngdiǎn dònghuà lìzuò.',
        'Đội ngũ sản xuất phim hoạt hình này đã khéo léo kết hợp phong cách nghệ thuật màu nước thủy mặc truyền thống Trung Hoa với công nghệ kết xuất đồ họa máy tính 3D kỹ thuật số tiên phong, tạo dựng nên một tác phẩm phim hoạt hình kinh điển sử thi thần thoại trong nước vang danh trong và ngoài nước.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2291] [动人] (dòngrén) - làm say đắm lòng người, cảm động lòng người, xúc động [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '动人' AND pinyin = 'dòngrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '动人' AND pinyin = 'dòngrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '动人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '动人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'dòngrén',
      meaning_vi = 'làm say đắm lòng người, cảm động lòng người, xúc động',
      example_hanzi = '她用清脆悠扬的甜美嗓音深情演唱了一首十分动人的抒情民歌。',
      example_pinyin = 'Tā yòng qīngcuì yōuyáng de tiánměi sǎngyīn shēnqíng yǎnchàng le yì shǒu shífēn dòngrén de shūqíng míngē.',
      example_vi = 'Cô ấy dùng chất giọng trong trẻo du dương ngọt ngào cất tiếng hát truyền cảm một bài dân ca trữ tình vô cùng lay động lòng người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '动人',
      'dòngrén',
      'làm say đắm lòng người, cảm động lòng người, xúc động',
      'Tính từ',
      'HSK 5',
      '她用清脆悠扬的甜美嗓音深情演唱了一首十分动人的抒情民歌。',
      'Tā yòng qīngcuì yōuyáng de tiánměi sǎngyīn shēnqíng yǎnchàng le yì shǒu shífēn dòngrén de shūqíng míngē.',
      'Cô ấy dùng chất giọng trong trẻo du dương ngọt ngào cất tiếng hát truyền cảm một bài dân ca trữ tình vô cùng lay động lòng người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '她用清脆悠扬的甜美嗓音深情演唱了一首十分动人的抒情民歌。',
        'Tā yòng qīngcuì yōuyáng de tiánměi sǎngyīn shēnqíng yǎnchàng le yì shǒu shífēn dòngrén de shūqíng míngē.',
        'Cô ấy dùng chất giọng trong trẻo du dương ngọt ngào cất tiếng hát truyền cảm một bài dân ca trữ tình vô cùng lay động lòng người.',
        'basic',
        1
      ),
      (
        v_id,
        '这部现实题材电影通过平凡百姓在困境中守望相助的生动细节，讲述了一个真实感人、催人泪下的动人故事，深深触动了千万影迷的心弦。',
        'Zhè bù xiànshí tícái diànyǐng tōngguò píngfán bǎixìng zài kùnjìng zhōng shǒuwàng-xiāngzhù de shēngdòng xìjié, jiǎngshù le yí gè zhēnshí gǎnrén, cuī rén lèi xià de dòngrén gùshì, shēnshēn chùdòng le qiān wàn yǐngmí de xīnxián.',
        'Bộ phim đề tài hiện thực này thông qua những chi tiết sinh động về những người dân bình dị cùng chia ngọt sẻ bùi đùm bọc lẫn nhau trong nghịch cảnh, đã kể lại một câu chuyện lay động chân thực đến rơi nước mắt, chạm sâu sắc vào dây đàn con tim của hàng vạn người hâm mộ điện ảnh.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2292] [动手] (dòngshǒu) - bắt tay vào làm việc; động chân động tay, ẩu đả đánh nhau [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '动手' AND pinyin = 'dòngshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '动手' AND pinyin = 'dòngshǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '动手'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '动手'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'dòngshǒu',
      meaning_vi = 'bắt tay vào làm việc; động chân động tay, ẩu đả đánh nhau',
      example_hanzi = '光在脑子里空想是没有用的，唯有立刻动手去做才能把梦想变成现实。',
      example_pinyin = 'Guāng zài nǎozi lǐ kōngxiǎng shì méiyǒu yòng de, wéi yǒu lìkè dòngshǒu qù zuò cái néng bǎ mèngxiǎng biànchéng xiànshí.',
      example_vi = 'Chỉ nghĩ viển vông trong đầu suông là vô ích, chỉ có lập tức bắt tay vào làm thì mới có thể biến ước mơ thành hiện thực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '动手',
      'dòngshǒu',
      'bắt tay vào làm việc; động chân động tay, ẩu đả đánh nhau',
      'Động từ',
      'HSK 5',
      '光在脑子里空想是没有用的，唯有立刻动手去做才能把梦想变成现实。',
      'Guāng zài nǎozi lǐ kōngxiǎng shì méiyǒu yòng de, wéi yǒu lìkè dòngshǒu qù zuò cái néng bǎ mèngxiǎng biànchéng xiànshí.',
      'Chỉ nghĩ viển vông trong đầu suông là vô ích, chỉ có lập tức bắt tay vào làm thì mới có thể biến ước mơ thành hiện thực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '光在脑子里空想是没有用的，唯有立刻动手去做才能把梦想变成现实。',
        'Guāng zài nǎozi lǐ kōngxiǎng shì méiyǒu yòng de, wéi yǒu lìkè dòngshǒu qù zuò cái néng bǎ mèngxiǎng biànchéng xiànshí.',
        'Chỉ nghĩ viển vông trong đầu suông là vô ích, chỉ có lập tức bắt tay vào làm thì mới có thể biến ước mơ thành hiện thực.',
        'basic',
        1
      ),
      (
        v_id,
        '遇到矛盾纠纷时双方必须保持绝对理智并通过法律途径和平解决，切忌意气用事甚至冲动动手殴打他人触犯刑法。',
        'Yùdào máodùn jiūfēn shí shuāngfāng bìxū bǎochí juéduì lǐzhì bìng tōngguò fǎlǜ tújìng hépíng jiějué, qièjì yìqì-yòngshì shènzhì chōngdòng dòngshǒu ōudǎ tārén chùfàn xíngfǎ.',
        'Khi gặp mâu thuẫn tranh chấp, hai bên bắt buộc phải giữ lý trí tuyệt đối và giải quyết hòa bình thông qua con đường pháp luật, kiên quyết tránh việc hành động theo cảm tính thậm chí bốc đồng động thủ đánh đập người khác vi phạm luật hình sự.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2293] [豆腐] (dòufu) - đậu phụ, đậu hũ (thực phẩm làm từ đậu nành) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '豆腐' AND pinyin = 'dòufu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '豆腐' AND pinyin = 'dòufu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '豆腐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '豆腐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dòufu',
      meaning_vi = 'đậu phụ, đậu hũ (thực phẩm làm từ đậu nành)',
      example_hanzi = '麻婆豆腐是一道麻辣鲜香、口感细腻的中国四川传统名菜。',
      example_pinyin = 'Mápó dòufu shì yí dào málà xiānxiāng, kǒugǎn xìnì de Zhōngguó Sìchuān chuántǒng míngcài.',
      example_vi = 'Đậu phụ Ma Bà là một món ăn danh tiếng truyền thống Tứ Xuyên Trung Quốc có vị tê cay thơm ngon và kết cấu mềm mịn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '豆腐',
      'dòufu',
      'đậu phụ, đậu hũ (thực phẩm làm từ đậu nành)',
      'Danh từ',
      'HSK 5',
      '麻婆豆腐是一道麻辣鲜香、口感细腻的中国四川传统名菜。',
      'Mápó dòufu shì yí dào málà xiānxiāng, kǒugǎn xìnì de Zhōngguó Sìchuān chuántǒng míngcài.',
      'Đậu phụ Ma Bà là một món ăn danh tiếng truyền thống Tứ Xuyên Trung Quốc có vị tê cay thơm ngon và kết cấu mềm mịn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '麻婆豆腐是一道麻辣鲜香、口感细腻的中国四川传统名菜。',
        'Mápó dòufu shì yí dào málà xiānxiāng, kǒugǎn xìnì de Zhōngguó Sìchuān chuántǒng míngcài.',
        'Đậu phụ Ma Bà là một món ăn danh tiếng truyền thống Tứ Xuyên Trung Quốc có vị tê cay thơm ngon và kết cấu mềm mịn.',
        'basic',
        1
      ),
      (
        v_id,
        '豆腐起源于中国古代且已有两千多年的悠久制作历史，因富含优质植物植物蛋白而深受全球健康素食主义者的广泛推崇。',
        'Dòufu qǐyuán yú Zhōngguó gǔdài qiě yǐ yǒu liǎng qiān duō nián de yōujiǔ zhìzuò lìshǐ, yīn fùhán yōuzhì zhíwù dànbái ér shēn shòu quánqiú jiànkāng sùshí zhǔyìzhě de guǎngfàn tuīchóng.',
        'Đậu phụ có nguồn gốc từ thời cổ đại Trung Quốc và đã có lịch sử chế biến lâu đời hơn hai nghìn năm, nhờ giàu protein thực vật chất lượng cao mà được đông đảo những người theo chủ nghĩa ăn chay lành mạnh trên toàn thế giới hết sức tôn sùng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2294] [豆浆] (dòujiāng) - sữa đậu nành, nước đậu nành [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '豆浆' AND pinyin = 'dòujiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '豆浆' AND pinyin = 'dòujiāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '豆浆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '豆浆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dòujiāng',
      meaning_vi = 'sữa đậu nành, nước đậu nành',
      example_hanzi = '热气腾腾的现磨鲜豆浆搭配刚出锅的香脆油条是中国北方百姓最喜爱的经典传统早餐。',
      example_pinyin = 'Rèqì-téngténg de xiànmó xiān dòujiāng dāpèi gāng chū guō de xiāngcuì yóutiáo shì Zhōngguó běifāng bǎixìng zuì xǐ’ài de jīngdiǎn chuántǒng zǎocān.',
      example_vi = 'Sữa đậu nành tươi xay nóng hổi kết hợp cùng quẩy giòn thơm vừa vớt ra khỏi chảo là bữa sáng truyền thống kinh điển được người dân miền bắc Trung Quốc ưa chuộng nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '豆浆',
      'dòujiāng',
      'sữa đậu nành, nước đậu nành',
      'Danh từ',
      'HSK 5',
      '热气腾腾的现磨鲜豆浆搭配刚出锅的香脆油条是中国北方百姓最喜爱的经典传统早餐。',
      'Rèqì-téngténg de xiànmó xiān dòujiāng dāpèi gāng chū guō de xiāngcuì yóutiáo shì Zhōngguó běifāng bǎixìng zuì xǐ’ài de jīngdiǎn chuántǒng zǎocān.',
      'Sữa đậu nành tươi xay nóng hổi kết hợp cùng quẩy giòn thơm vừa vớt ra khỏi chảo là bữa sáng truyền thống kinh điển được người dân miền bắc Trung Quốc ưa chuộng nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '热气腾腾的现磨鲜豆浆搭配刚出锅的香脆油条是中国北方百姓最喜爱的经典传统早餐。',
        'Rèqì-téngténg de xiànmó xiān dòujiāng dāpèi gāng chū guō de xiāngcuì yóutiáo shì Zhōngguó běifāng bǎixìng zuì xǐ’ài de jīngdiǎn chuántǒng zǎocān.',
        'Sữa đậu nành tươi xay nóng hổi kết hợp cùng quẩy giòn thơm vừa vớt ra khỏi chảo là bữa sáng truyền thống kinh điển được người dân miền bắc Trung Quốc ưa chuộng nhất.',
        'basic',
        1
      ),
      (
        v_id,
        '营养学家特别提示，生大豆中含有抗胰蛋白酶等天然抗营养因子，家庭自制生鲜豆浆必须彻底煮沸充分熟透后方可安全饮用。',
        'Yíngyǎngxuéjiā tèbié tíshì, shēng dàdòu zhōng hányǒu kàng yídànbáiméi děng tiānrán kàng yíngyǎng yīnzǐ, jiātíng zìzhì shēngxiān dòujiāng bìxū chèdǐ zhǔfèi chōngfèn shútòu hòu fāng kě ānquán yǐnyòng.',
        'Các chuyên gia dinh dưỡng đặc biệt khuyến cáo, trong hạt đậu tương sống có chứa các yếu tố kháng dinh dưỡng tự nhiên như chất kháng trypsin, sữa đậu nành tươi tự làm tại nhà bắt buộc phải đun sôi sùng sục chín kỹ hoàn toàn thì mới có thể uống an toàn.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2295] [独立] (dúlì) - độc lập, tự chủ (tính cách, quốc gia, tư duy) [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '独立' AND pinyin = 'dúlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '独立' AND pinyin = 'dúlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '独立'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '独立'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'dúlì',
      meaning_vi = 'độc lập, tự chủ (tính cách, quốc gia, tư duy)',
      example_hanzi = '上大学后离开父母生活，锻炼了年轻人独立自主生活与管理时间的能力。',
      example_pinyin = 'Shàng dàxué hòu líkāi fùmǔ shēnghuó, duànliàn le niánqīngrén dúlì-zìzhǔ shēnghuó yǔ guǎnlǐ shíjiān de nénglì.',
      example_vi = 'Sau khi vào đại học rời xa cha mẹ tự lập cuộc sống, đã rèn luyện cho người trẻ năng lực tự chủ cuộc sống độc lập và quản lý thời gian.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '独立',
      'dúlì',
      'độc lập, tự chủ (tính cách, quốc gia, tư duy)',
      'Tính từ / Động từ',
      'HSK 5',
      '上大学后离开父母生活，锻炼了年轻人独立自主生活与管理时间的能力。',
      'Shàng dàxué hòu líkāi fùmǔ shēnghuó, duànliàn le niánqīngrén dúlì-zìzhǔ shēnghuó yǔ guǎnlǐ shíjiān de nénglì.',
      'Sau khi vào đại học rời xa cha mẹ tự lập cuộc sống, đã rèn luyện cho người trẻ năng lực tự chủ cuộc sống độc lập và quản lý thời gian.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '上大学后离开父母生活，锻炼了年轻人独立自主生活与管理时间的能力。',
        'Shàng dàxué hòu líkāi fùmǔ shēnghuó, duànliàn le niánqīngrén dúlì-zìzhǔ shēnghuó yǔ guǎnlǐ shíjiān de nénglì.',
        'Sau khi vào đại học rời xa cha mẹ tự lập cuộc sống, đã rèn luyện cho người trẻ năng lực tự chủ cuộc sống độc lập và quản lý thời gian.',
        'basic',
        1
      ),
      (
        v_id,
        '在学术科学研究领域，青年学者切忌人云亦云盲从权威，必须具备敏锐的问题意识和独立客观的批判性审辨思维。',
        'Zài xuéshù kēxué yánjiū lǐngyù, qīngnián xuézhě qièjì rényún-yìyún mángcóng quánwēi, bìxū jùbèi mǐnruì de wèntí yìshí hé dúlì kèguān de pīpànxìng shěnbiàn sīwéi.',
        'Trong lĩnh vực nghiên cứu khoa học học thuật, các học giả trẻ tối kỵ việc gió chiều nào xuôi chiều ấy mù quáng nghe theo quyền uy, mà bắt buộc phải có ý thức vấn đề nhạy bén và tư duy phản biện độc lập khách quan.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2296] [独特] (dútè) - độc đáo, đặc sắc riêng biệt, có một không hai [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '独特' AND pinyin = 'dútè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '独特' AND pinyin = 'dútè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '独特'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '独特'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'dútè',
      meaning_vi = 'độc đáo, đặc sắc riêng biệt, có một không hai',
      example_hanzi = '这座古城因其独特的历史文化底蕴和精美的传统民居建筑风格而吸引了世界各地的游客。',
      example_pinyin = 'Zhè zuò gǔchéng yīn qí dútè de lìshǐ wénhuà dǐyùn hé jīngměi de chuántǒng mínjū jiànzhù fēnggé ér xīyǐn le shìjiè gèdì de yóukè.',
      example_vi = 'Cổ trấn này nhờ bề dày văn hóa lịch sử độc đáo và phong cách kiến trúc nhà ở dân gian truyền thống tinh xảo mà thu hút khách du lịch khắp nơi trên thế giới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '独特',
      'dútè',
      'độc đáo, đặc sắc riêng biệt, có một không hai',
      'Tính từ',
      'HSK 5',
      '这座古城因其独特的历史文化底蕴和精美的传统民居建筑风格而吸引了世界各地的游客。',
      'Zhè zuò gǔchéng yīn qí dútè de lìshǐ wénhuà dǐyùn hé jīngměi de chuántǒng mínjū jiànzhù fēnggé ér xīyǐn le shìjiè gèdì de yóukè.',
      'Cổ trấn này nhờ bề dày văn hóa lịch sử độc đáo và phong cách kiến trúc nhà ở dân gian truyền thống tinh xảo mà thu hút khách du lịch khắp nơi trên thế giới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '这座古城因其独特的历史文化底蕴和精美的传统民居建筑风格而吸引了世界各地的游客。',
        'Zhè zuò gǔchéng yīn qí dútè de lìshǐ wénhuà dǐyùn hé jīngměi de chuántǒng mínjū jiànzhù fēnggé ér xīyǐn le shìjiè gèdì de yóukè.',
        'Cổ trấn này nhờ bề dày văn hóa lịch sử độc đáo và phong cách kiến trúc nhà ở dân gian truyền thống tinh xảo mà thu hút khách du lịch khắp nơi trên thế giới.',
        'basic',
        1
      ),
      (
        v_id,
        '该高科技企业在激烈的全球产业赛道中不走同质化低价恶性竞争老路，而是凭借独特原创的核心算法架构筑牢了牢不可破的专利技术护城河。',
        'Gāi gāokējì qǐyè zài jīliè de quánqiú chǎnyè sàidào zhōng bù zǒu tóngzhìhuà dījià èxìng jìngzhēng lǎolù, ér shì píngjiè dútè yuánchuàng de héxīn suànfǎ jiàgòu zhù láo le láobùkěpò de zhuānlì jìshù hùchénghé.',
        'Doanh nghiệp công nghệ cao này trong đường đua ngành nghề toàn cầu khốc liệt không đi theo lối mòn cạnh tranh giá rẻ độc hại tương đồng, mà dựa vào cấu trúc thuật toán cốt lõi độc đáo nguyên bản để xây đắp nên hào bảo vệ công nghệ sáng chế vững như bàn thạch.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2297] [读音] (dúyīn) - cách đọc, phát âm (của chữ Hán, từ ngữ) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '读音' AND pinyin = 'dúyīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '读音' AND pinyin = 'dúyīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '读音'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '读音'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'dúyīn',
      meaning_vi = 'cách đọc, phát âm (của chữ Hán, từ ngữ)',
      example_hanzi = '初学汉语时，要反复练习四声声调以掌握汉字的正确读音。',
      example_pinyin = 'Chūxué Hànyǔ shí, yào fǎnfù liànxí sì shēng shēngdiào yǐ zhǎngwò Hànzì de zhèngquè dúyīn.',
      example_vi = 'Khi mới bắt đầu học tiếng Hán, cần phải luyện tập lặp đi lặp lại bốn thanh điệu để nắm vững cách phát âm chuẩn xác của chữ Hán.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '读音',
      'dúyīn',
      'cách đọc, phát âm (của chữ Hán, từ ngữ)',
      'Danh từ',
      'HSK 5',
      '初学汉语时，要反复练习四声声调以掌握汉字的正确读音。',
      'Chūxué Hànyǔ shí, yào fǎnfù liànxí sì shēng shēngdiào yǐ zhǎngwò Hànzì de zhèngquè dúyīn.',
      'Khi mới bắt đầu học tiếng Hán, cần phải luyện tập lặp đi lặp lại bốn thanh điệu để nắm vững cách phát âm chuẩn xác của chữ Hán.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '初学汉语时，要反复练习四声声调以掌握汉字的正确读音。',
        'Chūxué Hànyǔ shí, yào fǎnfù liànxí sì shēng shēngdiào yǐ zhǎngwò Hànzì de zhèngquè dúyīn.',
        'Khi mới bắt đầu học tiếng Hán, cần phải luyện tập lặp đi lặp lại bốn thanh điệu để nắm vững cách phát âm chuẩn xác của chữ Hán.',
        'basic',
        1
      ),
      (
        v_id,
        '在现代标准普通话规范审音词典中，语言学家对多音字在不同具体语境词性下的标准规范读音进行了极其严谨权威的界定。',
        'Zài xiàndài biāozhǔn Pǔtōnghuà guīfàn shěnyīn cídiǎn zhōng, yǔyánxuéjiā duì duōyīnzì zài bù tóng jùtǐ yǔjìng cíxìng xià de biāozhǔn guīfàn dúyīn jìnxíng le jíqí yánjǐn quánwēi de jièdìng.',
        'Trong từ điển thẩm định âm quy phạm tiếng Phổ thông tiêu chuẩn hiện đại, các nhà ngôn ngữ học đã tiến hành định nghĩa cực kỳ nghiêm cẩn uy tín về cách phát âm quy phạm chuẩn xác của các chữ Hán đa âm dưới các từ tính ngữ cảnh cụ thể khác nhau.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2298] [独自] (dúzì) - một mình, đơn độc (hành động) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '独自' AND pinyin = 'dúzì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '独自' AND pinyin = 'dúzì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '独自'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '独自'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'dúzì',
      meaning_vi = 'một mình, đơn độc (hành động)',
      example_hanzi = '傍晚，他一个人独自漫步在海风习习的金黄色沙滩上。',
      example_pinyin = 'Bàngwǎn, tā yí gè rén dúzì mànbù zài hǎifēng-xíxí de jīnhuángsè shātān shàng.',
      example_vi = 'Hoàng hôn, anh ấy một mình thả bộ thong dong trên bãi cát vàng óng gió biển thổi hiu hiu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '独自',
      'dúzì',
      'một mình, đơn độc (hành động)',
      'Phó từ',
      'HSK 5',
      '傍晚，他一个人独自漫步在海风习习的金黄色沙滩上。',
      'Bàngwǎn, tā yí gè rén dúzì mànbù zài hǎifēng-xíxí de jīnhuángsè shātān shàng.',
      'Hoàng hôn, anh ấy một mình thả bộ thong dong trên bãi cát vàng óng gió biển thổi hiu hiu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '傍晚，他一个人独自漫步在海风习习的金黄色沙滩上。',
        'Bàngwǎn, tā yí gè rén dúzì mànbù zài hǎifēng-xíxí de jīnhuángsè shātān shàng.',
        'Hoàng hôn, anh ấy một mình thả bộ thong dong trên bãi cát vàng óng gió biển thổi hiu hiu.',
        'basic',
        1
      ),
      (
        v_id,
        '经过长期的严谨求证与无数次孤独寂寞的实验室攻关，这位年轻的青年学者独自推导完成了这一困扰国际数学界数十年的猜想证明。',
        'Jīngguò chángqī de yánjǐn qiúzhèng yǔ wúshù cì gūdú jìmò de shíyànshì gōngguān, zhè wèi niánqīng de qīngnián xuézhě dúzì tuīdǎo wánchéng le zhè yí kùnrǎo guójì shùxuéjiè shù shí nián de cāixiǎng zhèngmíng.',
        'Sau thời gian dài chứng minh nghiêm ngặt và vô số lần nghiên cứu cô đơn tịch mịch trong phòng thí nghiệm, học giả trẻ tuổi này đã một mình suy diễn hoàn thành chứng minh giả thuyết toán học từng làm đau đầu giới toán học quốc tế suốt hàng chục năm qua.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2299] [堵] (dǔ) - tắc nghẽn, kẹt (giao thông); bịt, chặn lại; bức tường (lượng từ) [Động từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '堵' AND pinyin = 'dǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '堵' AND pinyin = 'dǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '堵'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '堵'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Lượng từ',
      pinyin = 'dǔ',
      meaning_vi = 'tắc nghẽn, kẹt (giao thông); bịt, chặn lại; bức tường (lượng từ)',
      example_hanzi = '下班高峰期市中心的高架路上车辆排成长龙，堵得水泄不通。',
      example_pinyin = 'Xiàbān gāofēngqī shì zhōngxīn de gāojiàlù shàng chēliàng pái chéng chánglóng, dǔ de shuǐxiè-bùtōng.',
      example_vi = 'Vào giờ cao điểm tan tầm trên đường trên cao ở trung tâm thành phố xe cộ xếp thành hàng dài như rồng, tắc nghẽn đến mức nước chảy không lọt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '堵',
      'dǔ',
      'tắc nghẽn, kẹt (giao thông); bịt, chặn lại; bức tường (lượng từ)',
      'Động từ / Lượng từ',
      'HSK 5',
      '下班高峰期市中心的高架路上车辆排成长龙，堵得水泄不通。',
      'Xiàbān gāofēngqī shì zhōngxīn de gāojiàlù shàng chēliàng pái chéng chánglóng, dǔ de shuǐxiè-bùtōng.',
      'Vào giờ cao điểm tan tầm trên đường trên cao ở trung tâm thành phố xe cộ xếp thành hàng dài như rồng, tắc nghẽn đến mức nước chảy không lọt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '下班高峰期市中心的高架路上车辆排成长龙，堵得水泄不通。',
        'Xiàbān gāofēngqī shì zhōngxīn de gāojiàlù shàng chēliàng pái chéng chánglóng, dǔ de shuǐxiè-bùtōng.',
        'Vào giờ cao điểm tan tầm trên đường trên cao ở trung tâm thành phố xe cộ xếp thành hàng dài như rồng, tắc nghẽn đến mức nước chảy không lọt.',
        'basic',
        1
      ),
      (
        v_id,
        '城市智慧交通管理指挥中心通过大数据算法动态调控全路网信号灯绿波带，有效疏导化解了核心商圈多个主干道交叉口的严重交通拥堵问题。',
        'Chéngshì zhìhuì jiāotōng guǎnlǐ zhǐhuī zhōngxīn tōngguò dàshùjù suànfǎ dòngtài tiáokòng quán lùwǎng xìnhàodēng lǜbōdài, yǒuxiào shūdǎo huàjiě le héxīn shāngquān duō gè zhǔgàndào jiāochākǒu de yánzhòng jiāotōng yōngdǔ wèntí.',
        'Trung tâm chỉ huy quản lý giao thông thông minh thành phố thông qua thuật toán dữ liệu lớn điều tiết động dải sóng xanh đèn tín hiệu toàn mạng lưới đường sá, giải tỏa và hóa giải hiệu quả vấn đề kẹt xe nghiêm trọng tại các nút giao đường trục chính thuộc khu thương mại trung tâm.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2300] [度] (dù) - độ (nhiệt độ, nồng độ, góc độ); mức độ, giới hạn; lần [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '度' AND pinyin = 'dù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '度' AND pinyin = 'dù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'dù',
      meaning_vi = 'độ (nhiệt độ, nồng độ, góc độ); mức độ, giới hạn; lần',
      example_hanzi = '今天白天的最高气温将达到三十五摄氏度，出门要注意做好防暑防晒。',
      example_pinyin = 'Jīntiān báitiān de zuì gāo qìwēn jiāng dádào sānshíwǔ shèshìdù, chūmén yào zhùyì zuò hǎo fángshǔ fángshài.',
      example_vi = 'Nhiệt độ cao nhất ban ngày hôm nay sẽ lên tới ba mươi lăm độ C, ra ngoài cần chú ý phòng chống nắng và say nắng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '度',
      'dù',
      'độ (nhiệt độ, nồng độ, góc độ); mức độ, giới hạn; lần',
      'Danh từ / Lượng từ',
      'HSK 5',
      '今天白天的最高气温将达到三十五摄氏度，出门要注意做好防暑防晒。',
      'Jīntiān báitiān de zuì gāo qìwēn jiāng dádào sānshíwǔ shèshìdù, chūmén yào zhùyì zuò hǎo fángshǔ fángshài.',
      'Nhiệt độ cao nhất ban ngày hôm nay sẽ lên tới ba mươi lăm độ C, ra ngoài cần chú ý phòng chống nắng và say nắng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '今天白天的最高气温将达到三十五摄氏度，出门要注意做好防暑防晒。',
        'Jīntiān báitiān de zuì gāo qìwēn jiāng dádào sānshíwǔ shèshìdù, chūmén yào zhùyì zuò hǎo fángshǔ fángshài.',
        'Nhiệt độ cao nhất ban ngày hôm nay sẽ lên tới ba mươi lăm độ C, ra ngoài cần chú ý phòng chống nắng và say nắng.',
        'basic',
        1
      ),
      (
        v_id,
        '为人处事既要有坚守原则的尺度，也要有待人宽容的气度，凡事掌握好分寸方能行稳致远。',
        'Wéirén chǔshì jì yào yǒu jiānshǒu yuánzé de chǐdù, yě yào yǒu dàirén kuānróng de qìdù, fánshì zhǎngwò hǎo fēncun fāng néng xíngwěn-zhìyuǎn.',
        'Làm người xử sự vừa phải có chuẩn mực thước đo kiên định giữ vững nguyên tắc, lại cũng phải có phong độ khí phách bao dung hòa nhã với mọi người, mọi việc nắm vững chừng mực thì mới có thể tiến xa và vững vàng.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  -- [2301] [短处] (duǎnchu) - sở đoản, điểm yếu, khuyết điểm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '短处' AND pinyin = 'duǎnchu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '短处' AND pinyin = 'duǎnchu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '短处'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '短处'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'duǎnchu',
      meaning_vi = 'sở đoản, điểm yếu, khuyết điểm',
      example_hanzi = '人无完人，我们要学会用欣赏的眼光看别人的长处，包容别人的短处。',
      example_pinyin = 'Rén wú wánrén, wǒmen yào xuéhuì yòng xīnshǎng de yǎnguāng kàn biérén de chángchu, bāoróng biérén de duǎnchu.',
      example_vi = 'Nhân vô thập toàn, chúng ta cần học cách dùng ánh mắt trân trọng để nhìn vào sở trường của người khác, và bao dung với những điểm yếu của người ta.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '短处',
      'duǎnchu',
      'sở đoản, điểm yếu, khuyết điểm',
      'Danh từ',
      'HSK 5',
      '人无完人，我们要学会用欣赏的眼光看别人的长处，包容别人的短处。',
      'Rén wú wánrén, wǒmen yào xuéhuì yòng xīnshǎng de yǎnguāng kàn biérén de chángchu, bāoróng biérén de duǎnchu.',
      'Nhân vô thập toàn, chúng ta cần học cách dùng ánh mắt trân trọng để nhìn vào sở trường của người khác, và bao dung với những điểm yếu của người ta.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (
        v_id,
        '人无完人，我们要学会用欣赏的眼光看别人的长处，包容别人的短处。',
        'Rén wú wánrén, wǒmen yào xuéhuì yòng xīnshǎng de yǎnguāng kàn biérén de chángchu, bāoróng biérén de duǎnchu.',
        'Nhân vô thập toàn, chúng ta cần học cách dùng ánh mắt trân trọng để nhìn vào sở trường của người khác, và bao dung với những điểm yếu của người ta.',
        'basic',
        1
      ),
      (
        v_id,
        '一个高素质的职业经理人不仅要清醒地认清自身的性格短处并在实践中持续克服，更要通过组建优势互补的高效管理团队来克服个人能力的局限。',
        'Yí gè gāo sùzhì de zhíyè jīnglǐrén bùjǐn yào qīngxǐng de rènqīng zìshēn de xìnggé duǎnchu bìng zài shíjiàn zhōng chíxù kèfú, gèng yào tōngguò zǔjiàn yōushì hùbǔ de gāoxiào guǎnlǐ tuánduì lái kèfú gèrén nénglì de júxiàn.',
        'Một nhà quản lý chuyên nghiệp có tố chất cao không chỉ phải tỉnh táo nhìn rõ điểm yếu tính cách của bản thân và liên tục khắc phục trong thực tiễn, mà càng phải thông qua việc xây dựng một đội ngũ quản lý hiệu suất cao có các ưu thế tương hỗ lẫn nhau nhằm bù đắp cho những hạn chế về năng lực của cá nhân.',
        'applied',
        2
      );

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp câu ví dụ HSK 5 - Batch 3: đã xử lý % từ vựng.', v_count;
END $$;
