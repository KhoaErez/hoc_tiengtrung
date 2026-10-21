-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 4 (100 TỪ)
-- Phạm vi: #1301 [互相] (hùxiāng) -> #1400 [警察] (jǐngchá)
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
  -- [互相] (hùxiāng) - lẫn nhau, với nhau [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '互相' AND pinyin = 'hùxiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '互相'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'hùxiāng',
      meaning_vi = 'lẫn nhau, với nhau',
      example_hanzi = '在学习外语的过程中，同学们应该互相帮助、共同进步。',
      example_pinyin = 'Zài xuéxí wàiyǔ de guòchéng zhōng, tóngxuémen yīnggāi hùxiāng bāngzhù, gòngtóng jìnbù.',
      example_vi = 'Trong quá trình học ngoại ngữ, các bạn học sinh nên giúp đỡ lẫn nhau và cùng nhau tiến bộ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在学习外语的过程中，同学们应该互相帮助、共同进步。', 'Zài xuéxí wàiyǔ de guòchéng zhōng, tóngxuémen yīnggāi hùxiāng bāngzhù, gòngtóng jìnbù.', 'Trong quá trình học ngoại ngữ, các bạn học sinh nên giúp đỡ lẫn nhau và cùng nhau tiến bộ.', 'basic', 1),
        (v_id, '跨部门协作项目成功的关键，在于团队成员之间能否坦诚沟通并互相给予充分的专业信任。', 'Kuà-bùmén xiézuò xiàngmù chénggōng de guānjiàn, zàiyú tuánduì chéngyuán zhījiān néngfǒu tǎnchéng gōutōng bìng hùxiāng jǐyǔ chōngfèn de zhuānyè xìnrèn.', 'Then chốt thành công của dự án hợp tác liên phòng ban nằm ở chỗ các thành viên trong đội ngũ có thể giao tiếp thẳng thắn và trao cho nhau sự tin tưởng chuyên môn trọn vẹn hay không.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [话剧] (huàjù) - kịch nói [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '话剧' AND pinyin = 'huàjù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '话剧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'huàjù',
      meaning_vi = 'kịch nói',
      example_hanzi = '周末我和朋友一起去国家大剧院看了一场经典话剧。',
      example_pinyin = 'Zhōumò wǒ hé péngyou yìqǐ qù Guójiā Dà Jùyuàn kàn le yì chǎng jīngdiǎn huàjù.',
      example_vi = 'Cuối tuần tôi cùng bạn đi Nhà hát Lớn Quốc gia xem một vở kịch nói kinh điển.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末我和朋友一起去国家大剧院看了一场经典话剧。', 'Zhōumò wǒ hé péngyou yìqǐ qù Guójiā Dà Jùyuàn kàn le yì chǎng jīngdiǎn huàjù.', 'Cuối tuần tôi cùng bạn đi Nhà hát Lớn Quốc gia xem một vở kịch nói kinh điển.', 'basic', 1),
        (v_id, '这部现实主义先锋话剧通过精妙绝伦的台词对白，深刻剖析了当代都市青年在理想与现实之间的心理博弈。', 'Zhè bù xiànshízhǔyì xiānfēng huàjù tōngguò jīngmiào-juélún de táicí duìbái, shēnkè pōuxī le dāngdài dūshì qīngnián zài lǐxiǎng yǔ xiànshí zhījiān de xīnlǐ bóyì.', 'Vở kịch nói tiên phong theo chủ nghĩa hiện thực này thông qua những lời thoại đối đáp tuyệt diệu đã mổ xẻ sâu sắc cuộc giằng xé tâm lý giữa lý tưởng và hiện thực của giới trẻ đô thị đương đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [怀疑] (huáiyí) - hoài nghi, nghi ngờ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '怀疑' AND pinyin = 'huáiyí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '怀疑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'huáiyí',
      meaning_vi = 'hoài nghi, nghi ngờ',
      example_hanzi = '没有任何真凭实据之前，我们不应该随便怀疑自己的朋友。',
      example_pinyin = 'Méiyǒu rènhé zhēnpíng-shíjù zhīqián, wǒmen bù yīnggāi suíbiàn huáiyí zìjǐ de péngyou.',
      example_vi = 'Trước khi chưa có bất kỳ chứng cứ xác thực nào, chúng ta không nên tùy tiện nghi ngờ bạn bè của mình.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '没有任何真凭实据之前，我们不应该随便怀疑自己的朋友。', 'Méiyǒu rènhé zhēnpíng-shíjù zhīqián, wǒmen bù yīnggāi suíbiàn huáiyí zìjǐ de péngyou.', 'Trước khi chưa có bất kỳ chứng cứ xác thực nào, chúng ta không nên tùy tiện nghi ngờ bạn bè của mình.', 'basic', 1),
        (v_id, '面对突如其来的挫折与质疑，优秀的创业者绝不会轻易怀疑自己的战略眼光，而是会客观复盘寻找突破口。', 'Miànduì tūrúqílái de cuòzhé yǔ zhìyí, yōuxiù de chuàngyèzhě jué bú huì qīngyì huáiyí zìjǐ de zhànlüè yǎnguāng, ér shì huì kèguān fùpán xúnzhǎo tūpòkǒu.', 'Đối mặt với những trắc trở và chất vấn bất ngờ ập tới, người khởi nghiệp xuất sắc quyết không dễ dàng nghi ngờ tầm nhìn chiến lược của bản thân, mà sẽ khách quan nhìn nhận đánh giá lại để tìm kiếm điểm đột phá.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [坏处] (huàichù) - điểm xấu, tác hại, điều bất lợi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '坏处' AND pinyin = 'huàichù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '坏处'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'huàichù',
      meaning_vi = 'điểm xấu, tác hại, điều bất lợi',
      example_hanzi = '经常熬夜玩手机对视力和身体健康有很大的坏处。',
      example_pinyin = 'Jīngcháng áoyè wán shǒujī duì shìlì hé shēntǐ jiànkāng yǒu hěn dà de huàichù.',
      example_vi = 'Thường xuyên thức khuya nghịch điện thoại có tác hại rất lớn đối với thị lực và sức khỏe cơ thể.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经常熬夜玩手机对视力和身体健康有很大的坏处。', 'Jīngcháng áoyè wán shǒujī duì shìlì hé shēntǐ jiànkāng yǒu hěn dà de huàichù.', 'Thường xuyên thức khuya nghịch điện thoại có tác hại rất lớn đối với thị lực và sức khỏe cơ thể.', 'basic', 1),
        (v_id, '盲目跟风扩张业务规模而忽视内部现金流周转，其潜在的资金链断裂坏处远远超过短期的账面收益。', 'Mángmù gēnfēng kuòzhāng yèwù guīmó ér hūshì nèibù xiànjīnliú zhōuzhuǎn, qí qiánzài de zījīnliàn duànliè huàichù yuǎnyuǎn chāoguò duǎnqī de zhàngmiàn shōuyì.', 'Mù quáng chạy đua mở rộng quy mô kinh doanh mà phớt lờ việc luân chuyển dòng tiền nội bộ, điều bất lợi tiềm ẩn về việc đứt gãy chuỗi vốn sẽ vượt xa khoản lợi nhuận trên sổ sách ngắn hạn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [环保] (huánbǎo) - bảo vệ môi trường, thân thiện môi trường [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '环保' AND pinyin = 'huánbǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '环保'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'huánbǎo',
      meaning_vi = 'bảo vệ môi trường, thân thiện môi trường',
      example_hanzi = '出门购物时自带布袋是一种非常环保的好习惯。',
      example_pinyin = 'Chūmén gòuwù shí zì dài bùdài shì yì zhǒng fēicháng huánbǎo de hǎo xíguàn.',
      example_vi = 'Khi ra ngoài mua sắm tự mang theo túi vải là một thói quen tốt rất thân thiện với môi trường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出门购物时自带布袋是一种非常环保的好习惯。', 'Chūmén gòuwù shí zì dài bùdài shì yì zhǒng fēicháng huánbǎo de hǎo xíguàn.', 'Khi ra ngoài mua sắm tự mang theo túi vải là một thói quen tốt rất thân thiện với môi trường.', 'basic', 1),
        (v_id, '企业通过全面升级环保节能生产装备并推行绿色低碳循环生产，显著降低了工业废弃物排放量。', 'Qǐyè tōngguò quánmiàn shēngjí huánbǎo jiénéng shēngchǎn zhuāngbèi bìng tuīxíng lǜsè dītàn xúnhuán shēngchǎn, xiǎnzhù jiàngdī le gōngyè fèiqìwù páifàngliàng.', 'Doanh nghiệp thông qua việc nâng cấp toàn diện thiết bị sản xuất tiết kiệm năng lượng bảo vệ môi trường và áp dụng sản xuất tuần hoàn xanh ít phát thải carbon, đã làm giảm đáng kể lượng xả thải chất thải công nghiệp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [换乘] (huànchéng) - chuyển tuyến, đổi chuyến (tàu xe) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '换乘' AND pinyin = 'huànchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '换乘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'huànchéng',
      meaning_vi = 'chuyển tuyến, đổi chuyến (tàu xe)',
      example_hanzi = '去首都国际机场需要坐地铁二号线到东直门站换乘机场专线。',
      example_pinyin = 'Qù Shǒudū Guójì Jīchǎng xūyào zuò dìtiě èrhào xiàn dào Dōngzhímén zhàn huànchéng jīchǎng zhuānxiàn.',
      example_vi = 'Đi sân bay quốc tế Thủ đô cần đi tuyến tàu điện ngầm số 2 đến ga Đông Trực Môn để đổi sang tuyến chuyên dụng sân bay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '去首都国际机场需要坐地铁二号线到东直门站换乘机场专线。', 'Qù Shǒudū Guójì Jīchǎng xūyào zuò dìtiě èrhào xiàn dào Dōngzhímén zhàn huànchéng jīchǎng zhuānxiàn.', 'Đi sân bay quốc tế Thủ đô cần đi tuyến tàu điện ngầm số 2 đến ga Đông Trực Môn để đổi sang tuyến chuyên dụng sân bay.', 'basic', 1),
        (v_id, '新建成的现代化综合交通枢纽实现了高铁、地铁、公交以及出租车的无缝立体换乘，极大方便了跨城通勤旅客。', 'Xīnjiàn chéng de xiàndàihuà zōnghé jiāotōng shūniǔ shíxiàn le gāotiě, dìtiě, gōngjiāo yǐjí chūzūchē de wúfèng lìtǐ huànchéng, jí dà fāngbiàn le kuàchéng tōngqín lǚkè.', 'Đầu mối giao thông tổng hợp hiện đại mới xây dựng đã hiện thực hóa việc đổi tuyến không gian 3 chiều liền mạch giữa đường sắt cao tốc, tàu điện ngầm, xe buýt và taxi, đem lại sự thuận tiện tột bậc cho hành khách đi lại giữa các đô thị.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [回复] (huífù) - trả lời, hồi đáp (tin nhắn, email) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '回复' AND pinyin = 'huífù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '回复'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'huífù',
      meaning_vi = 'trả lời, hồi đáp (tin nhắn, email)',
      example_hanzi = '收到客户的询问邮件后，请在二十四小时之内给予正式回复。',
      example_pinyin = 'Shōudào kèhù de xúnwèn yóujiàn hòu, qǐng zài èrshísì xiǎoshí zhīnèi jǐyǔ zhèngshì huífù.',
      example_vi = 'Sau khi nhận được email hỏi thăm của khách hàng, xin vui lòng đưa ra phản hồi chính thức trong vòng 24 giờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '收到客户的询问邮件后，请在二十四小时之内给予正式回复。', 'Shōudào kèhù de xúnwèn yóujiàn hòu, qǐng zài èrshísì xiǎoshí zhīnèi jǐyǔ zhèngshì huífù.', 'Sau khi nhận được email hỏi thăm của khách hàng, xin vui lòng đưa ra phản hồi chính thức trong vòng 24 giờ.', 'basic', 1),
        (v_id, '人力资源部门在对所有面试候选人进行全方位评估后，统一通过邮件系统回复了录用决策通知。', 'Rénlì zīyuán bùmén zài duì suǒyǒu miànshì hòuxuǎnrén jìnxíng quánfāngwèi pínggū hòu, tǒngyī tōngguò yóujiàn xìtǒng huífù le lùyòng juécè tōngzhī.', 'Phòng nhân sự sau khi tiến hành đánh giá toàn diện tất cả các ứng viên phỏng vấn, đã đồng loạt phản hồi thông báo quyết định tuyển dụng qua hệ thống thư điện tử.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [回信] (huíxìn) - viết thư trả lời; thư hồi đáp [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '回信' AND pinyin = 'huíxìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '回信'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'huíxìn',
      meaning_vi = 'viết thư trả lời; thư hồi đáp',
      example_hanzi = '好朋友寄来了明信片，我今天晚上准备给她写一封回信。',
      example_pinyin = 'Hǎo péngyou jì lái le míngxìnpiàn, wǒ jīntiān wǎnshang zhǔnbèi gěi tā xiě yì fēng huíxìn.',
      example_vi = 'Bạn thân gửi bưu thiếp tới, tối nay tôi chuẩn bị viết một bức thư trả lời cho cô ấy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '好朋友寄来了明信片，我今天晚上准备给她写一封回信。', 'Hǎo péngyou jì lái le míngxìnpiàn, wǒ jīntiān wǎnshang zhǔnbèi gěi tā xiě yì fēng huíxìn.', 'Bạn thân gửi bưu thiếp tới, tối nay tôi chuẩn bị viết một bức thư trả lời cho cô ấy.', 'basic', 1),
        (v_id, '高校招生办公室在认真审核完全部奖学金申请材料后，逐一向申请人寄发了正式录取与资助确认回信。', 'Gāoxiào zhāoshēng bàngōngshì zài rènzhēn shěnhé wán quánbù jiǎngxuéjīn shēnqǐng cáiliào hòu, zhúyī xiàng shēnqǐngrén jìfā le zhèngshì lùqǔ yǔ zīzhù quèrèn huíxìn.', 'Văn phòng tuyển sinh đại học sau khi thẩm định kỹ lưỡng toàn bộ hồ sơ xin học bổng, đã lần lượt gửi thư hồi đáp xác nhận trợ cấp và trúng tuyển chính thức tới các ứng viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [回忆] (huíyì) - nhớ lại, hồi tưởng; ký ức, kỷ niệm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '回忆' AND pinyin = 'huíyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '回忆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'huíyì',
      meaning_vi = 'nhớ lại, hồi tưởng; ký ức, kỷ niệm',
      example_hanzi = '大学毕业合影总能勾起我对校园美好时光的温馨回忆。',
      example_pinyin = 'Dàxué bìyè héyǐng zǒng néng gōuqǐ wǒ duì xiàoyuán měihǎo shíguāng de wēnxīn huíyì.',
      example_vi = 'Bức ảnh chụp chung tốt nghiệp đại học luôn có thể gợi lại trong tôi những ký ức ấm áp về khoảng thời gian tươi đẹp nơi giảng đường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大学毕业合影总能勾起我对校园美好时光的温馨回忆。', 'Dàxué bìyè héyǐng zǒng néng gōuqǐ wǒ duì xiàoyuán měihǎo shíguāng de wēnxīn huíyì.', 'Bức ảnh chụp chung tốt nghiệp đại học luôn có thể gợi lại trong tôi những ký ức ấm áp về khoảng thời gian tươi đẹp nơi giảng đường.', 'basic', 1),
        (v_id, '老科学家在自己出版的晚年回忆录中，深情回忆了老一辈科研团队在极其艰苦条件下攻克重大科技难关的奋斗岁月。', 'Lǎo kēxuéjiā zài zìjǐ chūbǎn de wǎnnián huíyìlù zhōng, shēnqíng huíyì le lǎo yí bèi kēyán tuánduì zài jíqí jiānkǔ tiáojiàn xià gōngkè zhòngdà kējì nánguān de fèndòu suìyuè.', 'Nhà khoa học lão thành trong cuốn hồi ký xuất bản những năm tuổi già của mình đã bồi hồi nhớ lại những năm tháng phấn đấu của thế hệ đội ngũ nghiên cứu đi trước vượt qua các cửa ải khoa học công nghệ trọng đại trong điều kiện vô cùng gian khổ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [会员] (huìyuán) - hội viên, thành viên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '会员' AND pinyin = 'huìyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '会员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'huìyuán',
      meaning_vi = 'hội viên, thành viên',
      example_hanzi = '注册成为这家书店的普通会员，买书可以享受九折优惠。',
      example_pinyin = 'Zhùcè chéngwéi zhè jiā shūdiàn de pǔtōng huìyuán, mǎi shū kěyǐ xiǎngshòu jiǔzhé yōuhuì.',
      example_vi = 'Đăng ký trở thành thành viên phổ thông của hiệu sách này, mua sách có thể được hưởng ưu đãi giảm giá 10%.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '注册成为这家书店的普通会员，买书可以享受九折优惠。', 'Zhùcè chéngwéi zhè jiā shūdiàn de pǔtōng huìyuán, mǎi shū kěyǐ xiǎngshòu jiǔzhé yōuhuì.', 'Đăng ký trở thành thành viên phổ thông của hiệu sách này, mua sách có thể được hưởng ưu đãi giảm giá 10%.', 'basic', 1),
        (v_id, '为了提高核心高净值客户的忠诚度与活跃度，该高端俱乐部推出了涵盖全球机场贵宾厅和私人理财咨询的专属会员权益体系。', 'Wèile tígāo héxīn gāojìngzhí kèhù de zhōngchéngdù yǔ huóyuèdù, gāi gāoduān jùlèbù tuīchū le hángài quánqiú jīchǎng guìbīntīng hé sīrén lǐcái zīxún de zhuānshǔ huìyuán quányì tǐxì.', 'Để nâng cao độ trung thành và sự gắn kết của nhóm khách hàng giá trị tài sản ròng cao cốt lõi, câu lạc bộ cao cấp này đã tung ra hệ sinh thái quyền lợi hội viên độc quyền bao gồm phòng chờ thương gia sân bay toàn cầu và tư vấn quản lý tài chính cá nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [活] (huó) - sống; linh hoạt; công việc [Động từ / Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '活' AND pinyin = 'huó'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '活'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ / Danh từ',
      pinyin = 'huó',
      meaning_vi = 'sống; linh hoạt; công việc',
      example_hanzi = '学语言的方法必须灵活多变，不能死读书。',
      example_pinyin = 'Xué yǔyán de fāngfǎ bìxū línghuó duōbiàn, bù néng sǐ dúshū.',
      example_vi = 'Phương pháp học ngôn ngữ cần phải linh hoạt biến hóa, không thể học một cách rập khuôn cứng nhắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学语言的方法必须灵活多变，不能死读书。', 'Xué yǔyán de fāngfǎ bìxū línghuó duōbiàn, bù néng sǐ dúshū.', 'Phương pháp học ngôn ngữ cần phải linh hoạt biến hóa, không thể học một cách rập khuôn cứng nhắc.', 'basic', 1),
        (v_id, '车间里的老师傅不仅手里的细活干得极其漂亮，而且在带徒弟时善于引导年轻人开拓活泛的工程创新思路。', 'Chējiān lǐ de lǎoshīfu bùjǐn shǒu lǐ de xìhuó gàn de jíqí piàoliang, érqiě zài dài túdi shí shànyú yǐndǎo qīngniánrén kāituò huófan de gōngchéng chuàngxīn sīlù.', 'Người thợ cả giàu kinh nghiệm trong phân xưởng không chỉ làm những công việc đòi hỏi sự tỉ mỉ tinh xảo cực kỳ đẹp mắt, mà khi dẫn dắt đệ tử còn rất giỏi khơi gợi người trẻ mở rộng tư duy đổi mới kỹ thuật linh hoạt sáng tạo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [活动] (huódòng) - hoạt động; vận động cơ thể [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '活动' AND pinyin = 'huódòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '活动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'huódòng',
      meaning_vi = 'hoạt động; vận động cơ thể',
      example_hanzi = '在电脑前坐久了，应该站起来活动一下肩膀和腰部。',
      example_pinyin = 'Zài diànnǎo qián zuò jiǔ le, yīnggāi zhàn qǐlai huódong yíxià jiānbǎng hé yāobù.',
      example_vi = 'Ngồi lâu trước máy tính, nên đứng dậy vận động một chút vai và eo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在电脑前坐久了，应该站起来活动一下肩膀和腰部。', 'Zài diànnǎo qián zuò jiǔ le, yīnggāi zhàn qǐlai huódong yíxià jiānbǎng hé yāobù.', 'Ngồi lâu trước máy tính, nên đứng dậy vận động một chút vai và eo.', 'basic', 1),
        (v_id, '学校团委在金秋十月组织开展了丰富多彩的校园文化节系列活动，吸引了全校数千名师生踊跃参与。', 'Xuéxiào tuánwěi zài jīnqiū shíyuè zǔzhī kāizhǎn le fēngfù-duōcǎi de xiàoyuán wénhuàjié xìliè huódòng, xīyǐn le quán xiào shù qiān míng shīshēng yǒngyuè cānyù.', 'Đoàn trường vào tháng Mười mùa thu vàng đã tổ chức triển khai chuỗi hoạt động lễ hội văn hóa học đường muôn màu muôn vẻ, thu hút hàng nghìn thầy trò toàn trường hào hứng tham gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [活泼] (huópō) - hoạt bát, sinh động, nhanh nhẹn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '活泼' AND pinyin = 'huópō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '活泼'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'huópō',
      meaning_vi = 'hoạt bát, sinh động, nhanh nhẹn',
      example_hanzi = '那个性格活泼开朗的小男孩总是能给大家带来欢声笑语。',
      example_pinyin = 'Nà gè xìnggé huópō kāilǎng de xiǎo nánhái zǒngshì néng gěi dàjiā dài lái huānshēng-xiàoyǔ.',
      example_vi = 'Cậu bé có tính cách hoạt bát cởi mở đó luôn có thể mang lại tiếng cười vui vẻ cho mọi người.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '那个性格活泼开朗的小男孩总是能给大家带来欢声笑语。', 'Nà gè xìnggé huópō kāilǎng de xiǎo nánhái zǒngshì néng gěi dàjiā dài lái huānshēng-xiàoyǔ.', 'Cậu bé có tính cách hoạt bát cởi mở đó luôn có thể mang lại tiếng cười vui vẻ cho mọi người.', 'basic', 1),
        (v_id, '少儿汉语教学应当摒弃枯燥生硬的灌输模式，采用生动活泼的情景游戏与多媒体互动激发儿童的学习兴趣。', 'Shào’ér Hànyǔ jiàoxué yīngdāng bǐngqì kūzào shēngyìng de guànshū móshì, cǎiyòng shēngdòng huópō de qíngjǐng yóuxì yǔ duōméitǐ hùdòng jīfā értóng de xuéxí xìngqù.', 'Giảng dạy tiếng Trung thiếu nhi cần từ bỏ mô hình nhồi nhét khô khan gượng ép, áp dụng các trò chơi tình huống sinh động hoạt bát và tương tác đa phương tiện để khơi dậy hứng thú học tập của trẻ thơ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [火] (huǒ) - lửa; thịnh hành, nổi tiếng, hot; bốc hỏa, nổi giận [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '火' AND pinyin = 'huǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '火'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'huǒ',
      meaning_vi = 'lửa; thịnh hành, nổi tiếng, hot; bốc hỏa, nổi giận',
      example_hanzi = '这首充满国风韵味的新歌曲最近在网络上特别火。',
      example_pinyin = 'Zhè shǒu chōngmǎn guófēng yùnwèi de xīn gēqǔ zuìjìn zài wǎngluò shang tèbié huǒ.',
      example_vi = 'Bài hát mới đậm phong vị truyền thống dân tộc này dạo gần đây cực kỳ hot trên mạng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这首充满国风韵味的新歌曲最近在网络上特别火。', 'Zhè shǒu chōngmǎn guófēng yùnwèi de xīn gēqǔ zuìjìn zài wǎngluò shang tèbié huǒ.', 'Bài hát mới đậm phong vị truyền thống dân tộc này dạo gần đây cực kỳ hot trên mạng.', 'basic', 1),
        (v_id, '在干燥的大风季节，森林防火巡逻队伍严密监控林区火险隐患，严禁携带一切火种进入森林保护区。', 'Zài gānzào de dàfēng jìjié, sēnlín fánghuǒ xúnluó duìwǔ yánmì jiānkòng línqū huǒxiǎn yǐnhuàn, yánjìn xiédài yíqiè huǒzhǒng jìnrù sēnlín bǎohùqū.', 'Vào mùa khô gió lớn, đội tuần tra phòng cháy chữa cháy rừng giám sát chặt chẽ các nguy cơ cháy tiềm ẩn trong khu vực rừng, nghiêm cấm mang theo bất kỳ nguồn lửa nào vào khu bảo tồn rừng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [货] (huò) - hàng hóa, sản phẩm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '货' AND pinyin = 'huò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '货'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'huò',
      meaning_vi = 'hàng hóa, sản phẩm',
      example_hanzi = '快递员刚刚把网购的生鲜百货送到了家门口。',
      example_pinyin = 'Kuàidìyuán gānggāng bǎ wǎnggòu de shēngxiān bǎihuò sòng dào le jiā ménkǒu.',
      example_vi = 'Nhân viên chuyển phát nhanh vừa giao hàng bách hóa tươi sống mua qua mạng đến trước cửa nhà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '快递员刚刚把网购的生鲜百货送到了家门口。', 'Kuàidìyuán gānggāng bǎ wǎnggòu de shēngxiān bǎihuò sòng dào le jiā ménkǒu.', 'Nhân viên chuyển phát nhanh vừa giao hàng bách hóa tươi sống mua qua mạng đến trước cửa nhà.', 'basic', 1),
        (v_id, '受国际海运港口罢工影响，这批重要的精密仪器外贸订单在物流中转仓压货延误了近两周时间。', 'Shòu guójì hǎiyùn gǎngkǒu bàgōng yǐngxiǎng, zhè pī zhòngyào de jīngmì yíqì wàimào dìngdān zài wùliú zhōngzhuǎncāng yāhuò yánwù le jìn liǎng zhōu shíjiān.', 'Do ảnh hưởng từ cuộc bãi công tại các cảng vận tải biển quốc tế, lô đơn hàng ngoại thương thiết bị tinh vi quan trọng này đã bị ứ đọng hàng tại kho trung chuyển logistics và chậm trễ gần hai tuần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [获得] (huòdé) - giành được, đạt được, nhận được [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '获得' AND pinyin = 'huòdé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '获得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'huòdé',
      meaning_vi = 'giành được, đạt được, nhận được',
      example_hanzi = '他在大学期间连续三年获得了国家励志奖学金。',
      example_pinyin = 'Tā zài dàxué qījiān liánxù sān nián huòdé le guójiā lìzhì jiǎngxuéjīn.',
      example_vi = 'Trong thời gian học đại học, anh ấy ba năm liên tiếp đạt được học bổng khuyến học quốc gia.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在大学期间连续三年获得了国家励志奖学金。', 'Tā zài dàxué qījiān liánxù sān nián huòdé le guójiā lìzhì jiǎngxuéjīn.', 'Trong thời gian học đại học, anh ấy ba năm liên tiếp đạt được học bổng khuyến học quốc gia.', 'basic', 1),
        (v_id, '这家年轻的高科技初创公司凭借突破性的专利算法，在激烈的市场竞争中成功获得了数千万美元的风险投资。', 'Zhè jiā niánqīng de gāokējì chūchuàng gōngsī píngjiè tūpòxìng de zhuānlì suànfǎ, zài jīliè de shìchǎng jìngzhēng zhōng chénggōng huòdé le shù qiānwàn Měiyuán de fēngxiǎn tóuzī.', 'Công ty khởi nghiệp công nghệ cao trẻ tuổi này nhờ vào thuật toán sáng chế mang tính đột phá, đã giành được thành công hàng chục triệu đô la vốn đầu tư mạo hiểm giữa cuộc cạnh tranh thị trường khốc liệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [获奖] (huòjiǎng) - đoạt giải, nhận giải thưởng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '获奖' AND pinyin = 'huòjiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '获奖'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'huòjiǎng',
      meaning_vi = 'đoạt giải, nhận giải thưởng',
      example_hanzi = '他的摄影作品在本次国际青年摄影大赛中荣获了一等奖。',
      example_pinyin = 'Tā de shèyǐng zuòpǐn zài běn cì guójì qīngnián shèyǐng dàsài zhōng rónghuò le yīděngjiǎng.',
      example_vi = 'Tác phẩm nhiếp ảnh của anh ấy đã vinh dự đạt giải nhất trong cuộc thi nhiếp ảnh thanh niên quốc tế lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的摄影作品在本次国际青年摄影大赛中荣获了一等奖。', 'Tā de shèyǐng zuòpǐn zài běn cì guójì qīngnián shèyǐng dàsài zhōng rónghuò le yīděngjiǎng.', 'Tác phẩm nhiếp ảnh của anh ấy đã vinh dự đạt giải nhất trong cuộc thi nhiếp ảnh thanh niên quốc tế lần này.', 'basic', 1),
        (v_id, '组委会在颁奖典礼现场集中展示了所有获奖科技项目的商业落地成果与核心发明专利。', 'Zǔwěihuì zài bānjiǎng diǎnlǐ xiànchǎng jízhōng zhǎnshì le suǒyǒu huòjiǎng kējì xiàngmù de shāngyè luòdì chéngguǒ yǔ héxīn fāmíng zhuānlì.', 'Ban tổ chức tại hiện trường lễ trao giải đã trưng bày tập trung các thành quả ứng dụng thương mại và bằng phát minh sáng chế cốt lõi của tất cả các dự án khoa học công nghệ đoạt giải.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [获取] (huòqǔ) - thu được, lấy được, thu thập (thông tin, dữ liệu) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '获取' AND pinyin = 'huòqǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '获取'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'huòqǔ',
      meaning_vi = 'thu được, lấy được, thu thập (thông tin, dữ liệu)',
      example_hanzi = '如今人们可以通过智能手机随时随地获取最新的资讯。',
      example_pinyin = 'Rújīn rénmen kěyǐ tōngguò zhìnéng shǒujī suíshí-suídì huòqǔ zuìxīn de zīxùn.',
      example_vi = 'Ngày nay người ta có thể thông qua điện thoại thông minh mọi lúc mọi nơi để thu thập các thông tin tin tức mới nhất.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如今人们可以通过智能手机随时随地获取最新的资讯。', 'Rújīn rénmen kěyǐ tōngguò zhìnéng shǒujī suíshí-suídì huòqǔ zuìxīn de zīxùn.', 'Ngày nay người ta có thể thông qua điện thoại thông minh mọi lúc mọi nơi để thu thập các thông tin tin tức mới nhất.', 'basic', 1),
        (v_id, '在大数据时代，企业在利用网络爬虫技术获取海量用户行为数据的同时，必须严格遵守个人隐私信息保护法。', 'Zài dàshùjù shídài, qǐyè zài lìyòng wǎngluò páchóng jìshù huòqǔ hǎiliàng yònghù xíngwéi shùjù de tóngshí, bìxū yángé zūnshǒu gèrén yǐnsī xìnxī bǎohùfǎ.', 'Trong thời đại dữ liệu lớn, các doanh nghiệp khi sử dụng công nghệ thu thập dữ liệu web để lấy lượng lớn dữ liệu hành vi người dùng, đồng thời bắt buộc phải tuân thủ nghiêm ngặt luật bảo vệ thông tin quyền riêng tư cá nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [基本] (jīběn) - cơ bản; nhìn chung, căn bản [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '基本' AND pinyin = 'jīběn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '基本'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'jīběn',
      meaning_vi = 'cơ bản; nhìn chung, căn bản',
      example_hanzi = '掌握汉语拼音和汉字笔顺是学好中文的基本功。',
      example_pinyin = 'Zhǎngwò Hànyǔ pīnyīn hé Hànzì bǐshùn shì xué hǎo Zhōngwén de jīběn gōng.',
      example_vi = 'Nắm vững phiên âm tiếng Trung và quy tắc nét chữ Hán là kỹ năng cơ bản để học tốt tiếng Trung.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '掌握汉语拼音和汉字笔顺是学好中文的基本功。', 'Zhǎngwò Hànyǔ pīnyīn hé Hànzì bǐshùn shì xué hǎo Zhōngwén de jīběn gōng.', 'Nắm vững phiên âm tiếng Trung và quy tắc nét chữ Hán là kỹ năng cơ bản để học tốt tiếng Trung.', 'basic', 1),
        (v_id, '双方代表团经过数轮艰苦磋商，已经在知识产权保护与市场准入等基本原则问题上达成了高度一致。', 'Shuāngfāng dàibiǎotuán jīngguò shù lún jiānkǔ cuōshāng, yǐjīng zài zhīshi chǎnquán bǎohù yǔ shìchǎng zhǔnrù děng jīběn yuánzé wèntí shang dáchéng le gāodù yízhì.', 'Đoàn đại biểu hai bên sau nhiều vòng thương lượng gian khó đã đạt được sự nhất trí cao trong các vấn đề nguyên tắc cơ bản như bảo hộ sở hữu trí tuệ và tiếp cận thị trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [基本上] (jīběnshàng) - về cơ bản, nhìn chung [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '基本上' AND pinyin = 'jīběnshàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '基本上'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'jīběnshàng',
      meaning_vi = 'về cơ bản, nhìn chung',
      example_hanzi = '经过全组同学的共同努力，这项调研任务基本上已经完成了。',
      example_pinyin = 'Jīngguò quán zǔ tóngxué de gòngtóng nǔlì, zhè xiàng diàoyán rènwu jīběnshàng yǐjīng wánchéng le.',
      example_vi = 'Trải qua sự nỗ lực chung của cả nhóm bạn học, nhiệm vụ điều tra nghiên cứu này về cơ bản đã hoàn thành rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全组同学的共同努力，这项调研任务基本上已经完成了。', 'Jīngguò quán zǔ tóngxué de gòngtóng nǔlì, zhè xiàng diàoyán rènwu jīběnshàng yǐjīng wánchéng le.', 'Trải qua sự nỗ lực chung của cả nhóm bạn học, nhiệm vụ điều tra nghiên cứu này về cơ bản đã hoàn thành rồi.', 'basic', 1),
        (v_id, '公司本年度制定的各项核心财务营收目标目前已经基本上实现，管理层正着手规划明年的拓展战略。', 'Gōngsī běn niándù zhìdìng de gè xiàng héxīn cáiwù yíngshōu mùbiāo mùqián yǐjīng jīběnshàng shíxiàn, guǎnlǐcéng zhèng zhuóshǒu guīhuà míngnián de tuòzhǎn zhànlüè.', 'Các mục tiêu doanh thu tài chính cốt lõi do công ty đề ra trong năm tài khóa này hiện nay về cơ bản đã đạt được, ban quản lý đang bắt tay vào quy hoạch chiến lược mở rộng cho năm sau.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [基础] (jīchǔ) - nền tảng, cơ sở [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '基础' AND pinyin = 'jīchǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '基础'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jīchǔ',
      meaning_vi = 'nền tảng, cơ sở',
      example_hanzi = '万丈高楼平地起，打好扎实的基础才能学得更加深入。',
      example_pinyin = 'Wànzhàng gāolóu píngdì qǐ, dǎ hǎo zhāshi de jīchǔ cái néng xué de gèngjiā shēnrù.',
      example_vi = 'Tòa nhà vạn trượng mọc lên từ đất bằng, xây dựng nền tảng vững chắc mới có thể học tập càng thêm sâu sắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '万丈高楼平地起，打好扎实的基础才能学得更加深入。', 'Wànzhàng gāolóu píngdì qǐ, dǎ hǎo zhāshi de jīchǔ cái néng xué de gèngjiā shēnrù.', 'Tòa nhà vạn trượng mọc lên từ đất bằng, xây dựng nền tảng vững chắc mới có thể học tập càng thêm sâu sắc.', 'basic', 1),
        (v_id, '国家加大对基础科学研究的长期财政扶持，是保障战略前沿核心技术自主可控的坚实基石。', 'Guójiā jiàdà duì jīchǔ kēxué yánjiū de chángqī cáizhèng fúchí, shì bǎozhàng zhànlüè qiányán héxīn jìshù zìzhǔ kěkòng de jiānshí jīshí.', 'Nhà nước gia tăng hỗ trợ tài chính dài hạn đối với nghiên cứu khoa học cơ bản chính là hòn đá tảng vững chãi đảm bảo cho các công nghệ cốt lõi tiên phong chiến lược được tự chủ và có thể kiểm soát.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [激动] (jīdòng) - kích động, xúc động hồi hộp; làm xúc động [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '激动' AND pinyin = 'jīdòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '激动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'jīdòng',
      meaning_vi = 'kích động, xúc động hồi hộp; làm xúc động',
      example_hanzi = '听到自己顺利通过面试被录取的喜讯，他激动得跳了起来。',
      example_pinyin = 'Tīng dào zìjǐ shùnlì tōngguò miànshì bèi lùqǔ de xǐxùn, tā jīdòng de tiào le qǐlai.',
      example_vi = 'Nghe được tin vui mình đã vượt qua buổi phỏng vấn thuận lợi và được nhận vào làm, anh ấy xúc động mừng rỡ nhảy cẫng lên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听到自己顺利通过面试被录取的喜讯，他激动得跳了起来。', 'Tīng dào zìjǐ shùnlì tōngguò miànshì bèi lùqǔ de xǐxùn, tā jīdòng de tiào le qǐlai.', 'Nghe được tin vui mình đã vượt qua buổi phỏng vấn thuận lợi và được nhận vào làm, anh ấy xúc động mừng rỡ nhảy cẫng lên.', 'basic', 1),
        (v_id, '当五星红旗在国际奥林匹克赛场伴随着庄严国歌冉冉升起时，全场华侨华人无不心情澎湃、激动万分。', 'Dāng wǔxīng-hóngqí zài guójì Àolínpǐkè sàichǎng bànsuí zhe zhuāngyán guógē rǎnrǎn shēngqǐ shí, quánchǎng Huáqiáo-Huárén wúbù xīnqíng péngpài, jīdòng-wànfēn.', 'Khi lá cờ đỏ năm sao từ từ bay lên nơi đấu trường Olympic quốc tế cùng tiếng quốc ca trang nghiêm, kiều bào Hoa kiều toàn khán phòng ai nấy đều dâng trào cảm xúc và vô cùng xúc động.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [积极] (jījí) - tích cực, chủ động hăng hái [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '积极' AND pinyin = 'jījí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '积极'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'jījí',
      meaning_vi = 'tích cực, chủ động hăng hái',
      example_hanzi = '他上课时总是积极举手发言，回答老师提出的问题。',
      example_pinyin = 'Tā shàngkè shí zǒngshì jījí jǔshǒu fāyán, huídá lǎoshī tíchū de wèntí.',
      example_vi = 'Cậu ấy trong giờ học luôn tích cực giơ tay phát biểu, trả lời những câu hỏi mà thầy cô đưa ra.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他上课时总是积极举手发言，回答老师提出的问题。', 'Tā shàngkè shí zǒngshì jījí jǔshǒu fāyán, huídá lǎoshī tíchū de wèntí.', 'Cậu ấy trong giờ học luôn tích cực giơ tay phát biểu, trả lời những câu hỏi mà thầy cô đưa ra.', 'basic', 1),
        (v_id, '保持积极乐观的豁达心态并采取切实可行的有效行动，是我们在职业生涯中化解逆境危机的最佳途径。', 'Bǎochí jījí lèguān de huòdá xīntài bìng cǎiqǔ qièshí-kěxíng de yǒuxiào xíngdòng, shì wǒmen zài zhíyè shēngyá zhōng huàjiě nìjìng wēijī de zuì jiā tújìng.', 'Giữ vững tâm thái tích cực lạc quan khoáng đạt và áp dụng các hành động thiết thực khả thi chính là con đường tốt nhất để chúng ta hóa giải các nghịch cảnh và khủng hoảng trong sự nghiệp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [积累] (jīlěi) - tích lũy; sự tích lũy [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '积累' AND pinyin = 'jīlěi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '积累'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'jīlěi',
      meaning_vi = 'tích lũy; sự tích lũy',
      example_hanzi = '学好外语需要日积月累，每天坚持背几个生词。',
      example_pinyin = 'Xué hǎo wàiyǔ xūyào rìjī-yuèlěi, měitiān jiānchí bèi jǐ gè shēngcí.',
      example_vi = 'Học tốt ngoại ngữ cần phải tích lũy qua ngày tháng, mỗi ngày kiên trì học thuộc vài từ mới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学好外语需要日积月累，每天坚持背几个生词。', 'Xué hǎo wàiyǔ xūyào rìjī-yuèlěi, měitiān jiānchí bèi jǐ gè shēngcí.', 'Học tốt ngoại ngữ cần phải tích lũy qua ngày tháng, mỗi ngày kiên trì học thuộc vài từ mới.', 'basic', 1),
        (v_id, '青年科研人员在博士后流动站期间积累的扎实实验数据与跨学科合作经验，为其独立领衔重大项目奠定了基石。', 'Qīngnián kēyán rényuán zài bóshìhòu liúdòngzhàn qījiān jīlěi de zhāshi shíyàn shùjù yǔ kuà-xuékē hézuò jīngyàn, wèi qí dúlì lǐngxián zhòngdà xiàngmù diàndìng le jīshí.', 'Số liệu thực nghiệm vững chắc và kinh nghiệm hợp tác liên ngành mà các nhà nghiên cứu trẻ tuổi tích lũy được trong thời gian làm việc tại trạm lưu động sau tiến sĩ đã đặt nền móng cho việc độc lập dẫn dắt các dự án trọng điểm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [及时] (jíshí) - kịp thời, đúng lúc [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '及时' AND pinyin = 'jíshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '及时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'jíshí',
      meaning_vi = 'kịp thời, đúng lúc',
      example_hanzi = '多亏医生抢救及时，病人才脱离了生命危险。',
      example_pinyin = 'Duōkuī yīshēng qiǎngjiù jíshí, bìngrén cái tuōlí le shēngmìng wēixiǎn.',
      example_vi = 'Nhờ có bác sĩ cấp cứu kịp thời, bệnh nhân mới qua khỏi cơn nguy kịch tính mạng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '多亏医生抢救及时，病人才脱离了生命危险。', 'Duōkuī yīshēng qiǎngjiù jíshí, bìngrén cái tuōlí le shēngmìng wēixiǎn.', 'Nhờ có bác sĩ cấp cứu kịp thời, bệnh nhân mới qua khỏi cơn nguy kịch tính mạng.', 'basic', 1),
        (v_id, '在金融市场出现剧烈非理性波动时，中央银行及时出台流动性支持政策，有效稳定了投资者的市场预期。', 'Zài jīnróng shìchǎng chūxiàn jùliè fēi-lǐxìng bōdòng shí, zhōngyāng yínháng jíshí chūtái liúdòngxìng zhīchí zhèngcè, yǒuxiào wěndìng le tóuzīzhě de shìchǎng yùqī.', 'Khi thị trường tài chính xuất hiện những đợt biến động phi lý trí dữ dội, Ngân hàng Trung ương đã kịp thời ban hành chính sách hỗ trợ thanh khoản, ổn định hiệu quả kỳ vọng thị trường của giới đầu tư.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [即使] (jíshǐ) - cho dù, dẫu cho, ngay cả khi [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '即使' AND pinyin = 'jíshǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '即使'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'jíshǐ',
      meaning_vi = 'cho dù, dẫu cho, ngay cả khi',
      example_hanzi = '即使明天下大雪，我们原定的训练计划也不会改变。',
      example_pinyin = 'Jíshǐ míngtiān xià dàxuě, wǒmen yuándìng de xùnliàn jìhuà yě bú huì gǎibiàn.',
      example_vi = 'Cho dù ngày mai có rơi tuyết lớn, kế hoạch huấn luyện như đã định của chúng tôi cũng sẽ không thay đổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '即使明天下大雪，我们原定的训练计划也不会改变。', 'Jíshǐ míngtiān xià dàxuě, wǒmen yuándìng de xùnliàn jìhuà yě bú huì gǎibiàn.', 'Cho dù ngày mai có rơi tuyết lớn, kế hoạch huấn luyện như đã định của chúng tôi cũng sẽ không thay đổi.', 'basic', 1),
        (v_id, '即使当前面临严峻的市场竞争与供应链压力，企业也必须坚守诚信经营与产品质量底线，绝不偷工减料。', 'Jíshǐ dāngqián miànlín yánjùn de shìchǎng jìngzhēng yǔ gōngyìngliàn yālì, qǐyè yě bìxū jiānshǒu chéngxìn jīngyíng yǔ chǎnpǐn zhìliàng dǐxiàn, jué bù tōugōng-jiǎnliào.', 'Cho dù hiện tại phải đối mặt với sự cạnh tranh thị trường gay gắt và áp lực chuỗi cung ứng, doanh nghiệp cũng nhất quyết phải giữ vững nguyên tắc kinh doanh chữ tín và chất lượng sản phẩm, tuyệt đối không bớt xén quy trình hay vật liệu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [既] (jì) - vừa... (既...又/也...); đã [Phó từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '既' AND pinyin = 'jì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '既'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Liên từ',
      pinyin = 'jì',
      meaning_vi = 'vừa... (既...又/也...); đã',
      example_hanzi = '这家餐厅的菜肴既地道美味，价格又非常实惠亲民。',
      example_pinyin = 'Zhè jiā cāntīng de càiyáo jì dìdao měiwèi, jiàgé yòu fēicháng shíhuì qīnmín.',
      example_vi = 'Món ăn của nhà hàng này vừa chuẩn vị thơm ngon, giá cả lại rất phải chăng hợp túi tiền.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家餐厅的菜肴既地道美味，价格又非常实惠亲民。', 'Zhè jiā cāntīng de càiyáo jì dìdao měiwèi, jiàgé yòu fēicháng shíhuì qīnmín.', 'Món ăn của nhà hàng này vừa chuẩn vị thơm ngon, giá cả lại rất phải chăng hợp túi tiền.', 'basic', 1),
        (v_id, '新一代智能交通系统既能实时缓解早晚高峰的道路拥堵，也能显著降低机动车尾气排放对空气质量的影响。', 'Xīn yídài zhìnéng jiāotōng xìtǒng jì néng shíshí huǎnjiě zǎowǎn gāofēng de dàolù yōngdǔ, yě néng xiǎnzhù jiàngdī jīdòngchē wěiqì páifàng duì kōngqì zhìliàng de yǐngxiǎng.', 'Hệ thống giao thông thông minh thế hệ mới vừa có thể giải tỏa kịp thời tình trạng tắc nghẽn đường xá giờ cao điểm sáng tối, cũng có thể giảm đáng kể ảnh hưởng của khí thải xe cơ giới đối với chất lượng không khí.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [寄] (jì) - gửi (thư, bưu phẩm, chuyển phát) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '寄' AND pinyin = 'jì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '寄'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jì',
      meaning_vi = 'gửi (thư, bưu phẩm, chuyển phát)',
      example_hanzi = '请帮我把这个包裹用顺丰速运寄到广州去。',
      example_pinyin = 'Qǐng bāng wǒ bǎ zhè gè bāoguǒ yòng Shùnfēng sùyùn jì dào Guǎngzhōu qù.',
      example_vi = 'Xin hãy giúp tôi gửi bưu kiện này bằng dịch vụ chuyển phát nhanh Thuận Phong tới Quảng Châu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请帮我把这个包裹用顺丰速运寄到广州去。', 'Qǐng bāng wǒ bǎ zhè gè bāoguǒ yòng Shùnfēng sùyùn jì dào Guǎngzhōu qù.', 'Xin hãy giúp tôi gửi bưu kiện này bằng dịch vụ chuyển phát nhanh Thuận Phong tới Quảng Châu.', 'basic', 1),
        (v_id, '签署完成的商业保密合同原件已通过特快专递安全寄往跨国战略合作伙伴设在法兰克福的总部法务处。', 'Qiānshǔ wánchéng de shāngyè bǎomì hétong yuánjiàn yǐ tōngguò tèkuài zhuāndì ānquán jì wǎng kuàguó zhànlüè hézuò huǒbàn shè zài Fǎlánkèfú de zǒngbù fǎwùchù.', 'Bản gốc hợp đồng bảo mật thương mại đã ký kết xong xuôi được chuyển phát nhanh an toàn tới văn phòng pháp chế trụ sở chính đặt tại Frankfurt của đối tác chiến lược đa quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [计划] (jìhuà) - kế hoạch; lên kế hoạch [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '计划' AND pinyin = 'jìhuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '计划'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'jìhuà',
      meaning_vi = 'kế hoạch; lên kế hoạch',
      example_hanzi = '做事情之前一定要有周密的计划，切忌盲目行动。',
      example_pinyin = 'Zuò shìqing zhīqián yídìng yào yǒu zhōumì de jìhuà, qièjì mángmù xíngdòng.',
      example_vi = 'Trước khi làm việc nhất định phải có kế hoạch chu đáo, tránh hành động một cách mù quáng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '做事情之前一定要有周密的计划，切忌盲目行动。', 'Zuò shìqing zhīqián yídìng yào yǒu zhōumì de jìhuà, qièjì mángmù xíngdòng.', 'Trước khi làm việc nhất định phải có kế hoạch chu đáo, tránh hành động một cách mù quáng.', 'basic', 1),
        (v_id, '该高新技术产业园区计划在未来三年内引进上百家人工智能和高端装备制造领军企业。', 'Gāi gāoxīnjìshù chǎnyè yuánqū jìhuà zài wèilái sān nián nèi yǐnjìn shàng bǎi jiā réngōng zhìnéng hé gāoduān zhuāngbèi zhìzào lǐngjūn qǐyè.', 'Khu công nghiệp công nghệ cao này lên kế hoạch trong vòng 3 năm tới sẽ thu hút hơn một trăm doanh nghiệp đầu ngành sản xuất thiết bị cao cấp và trí tuệ nhân tạo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [既然] (jìrán) - đã... thì, một khi đã [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '既然' AND pinyin = 'jìrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '既然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'jìrán',
      meaning_vi = 'đã... thì, một khi đã',
      example_hanzi = '既然你已经下定决心学好中文，就要持之以恒地坚持下去。',
      example_pinyin = 'Jìrán nǐ yǐjīng xiàdìng juéxīn xué hǎo Zhōngwén, jiù yào chízhīyǐhéng de jiānchí xiàqu.',
      example_vi = 'Một khi bạn đã hạ quyết tâm học giỏi tiếng Trung, thì phải kiên trì bền bỉ đến cùng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '既然你已经下定决心学好中文，就要持之以恒地坚持下去。', 'Jìrán nǐ yǐjīng xiàdìng juéxīn xué hǎo Zhōngwén, jiù yào chízhīyǐhéng de jiānchí xiàqu.', 'Một khi bạn đã hạ quyết tâm học giỏi tiếng Trung, thì phải kiên trì bền bỉ đến cùng.', 'basic', 1),
        (v_id, '既然双方对项目合作框架协议的主要条款达成了高度共识，我们应当趁热打铁尽快启动法律文本的签署程序。', 'Jìrán shuāngfāng duì xiàngmù hézuò kuàngjià xiéyì de zhǔyào tiáokuǎn dáchéng le gāodù gòngshí, wǒmen yīngdāng chènrè-dǎtiě jǐnkuài qǐdòng fǎlǜ wénběn de qiānshǔ chéngxù.', 'Một khi hai bên đã đạt được sự đồng thuận cao về các điều khoản chủ yếu của thỏa thuận khung hợp tác dự án, chúng ta nên thừa thắng xông lên khởi động sớm quy trình ký kết văn bản pháp lý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [技术] (jìshù) - kỹ thuật, công nghệ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '技术' AND pinyin = 'jìshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '技术'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jìshù',
      meaning_vi = 'kỹ thuật, công nghệ',
      example_hanzi = '师傅的修理汽车技术非常高超，很快就找出了故障原因。',
      example_pinyin = 'Shīfu de xiūlǐ qìchē jìshù fēicháng gāochāo, hěn kuài jiù zhǎo chū le gùzhàng yuányīn.',
      example_vi = 'Kỹ thuật sửa chữa xe hơi của bác thợ vô cùng cao siêu, rất nhanh đã tìm ra nguyên nhân hỏng hóc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '师傅的修理汽车技术非常高超，很快就找出了故障原因。', 'Shīfu de xiūlǐ qìchē jìshù fēicháng gāochāo, hěn kuài jiù zhǎo chū le gùzhàng yuányīn.', 'Kỹ thuật sửa chữa xe hơi của bác thợ vô cùng cao siêu, rất nhanh đã tìm ra nguyên nhân hỏng hóc.', 'basic', 1),
        (v_id, '掌握拥有自主知识产权的核心技术是高科技企业在全球产业竞争中立足的命脉所在。', 'Zhǎngwò yōngyǒu zìzhǔ zhīshi chǎnquán de héxīn jìshù shì gāokējì qǐyè zài quánqiú chǎnyè jìngzhēng zhōng lìzú de mìngmài suǒzài.', 'Nắm vững công nghệ cốt lõi sở hữu quyền sở hữu trí tuệ độc lập chính là mạch sống đứng vững của các doanh nghiệp công nghệ cao trong cuộc cạnh tranh công nghiệp toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [继续] (jìxù) - tiếp tục [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '继续' AND pinyin = 'jìxù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '继续'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jìxù',
      meaning_vi = 'tiếp tục',
      example_hanzi = '休息十分钟以后，我们接着继续开始第二节课的学习。',
      example_pinyin = 'Xiūxi shí fēnzhōng yǐhòu, wǒmen jiēzhe jìxù kāishǐ dì-èr jié kè de xuéxí.',
      example_vi = 'Sau khi nghỉ ngơi 10 phút, chúng ta sẽ tiếp tục bắt đầu buổi học tiết thứ hai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '休息十分钟以后，我们接着继续开始第二节课的学习。', 'Xiūxi shí fēnzhōng yǐhòu, wǒmen jiēzhe jìxù kāishǐ dì-èr jié kè de xuéxí.', 'Sau khi nghỉ ngơi 10 phút, chúng ta sẽ tiếp tục bắt đầu buổi học tiết thứ hai.', 'basic', 1),
        (v_id, '尽管外部宏观经济面临多重不确定性挑战，公司董事会依然决定继续加大对新一代芯片架构的研发资金投入。', 'Jǐnguǎn wàibù hóngguān jīngjì miànlín duōchóng bùquèdìngxìng tiǎozhàn, gōngsī dǒngshìhuì yīrán juédìng jìxù jiàdà duì xīn yídài xīnpiàn jiàgòu de yánfā zījīn tóurù.', 'Dù cho nền kinh tế vĩ mô bên ngoài phải đối mặt với nhiều thách thức bất định, hội đồng quản trị công ty vẫn quyết định tiếp tục tăng nguồn vốn đầu tư R&D cho kiến trúc chip thế hệ mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [记者] (jìzhě) - phóng viên, nhà báo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '记者' AND pinyin = 'jìzhě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '记者'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jìzhě',
      meaning_vi = 'phóng viên, nhà báo',
      example_hanzi = '新闻发布会现场坐满了来自世界各大媒体的新闻记者。',
      example_pinyin = 'Xīnwén fābùhuì xiànchǎng zuò mǎn le láizì shìjiè gè dà méitǐ de xīnwén jìzhě.',
      example_vi = 'Tại hiện trường cuộc họp báo ngồi kín các phóng viên nhà báo đến từ các cơ quan truyền thông lớn trên thế giới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '新闻发布会现场坐满了来自世界各大媒体的新闻记者。', 'Xīnwén fābùhuì xiànchǎng zuò mǎn le láizì shìjiè gè dà méitǐ de xīnwén jìzhě.', 'Tại hiện trường cuộc họp báo ngồi kín các phóng viên nhà báo đến từ các cơ quan truyền thông lớn trên thế giới.', 'basic', 1),
        (v_id, '优秀的新闻调查记者应当恪守客观中立的职业道德，深入一线挖掘事实真相并维护社会公平正义。', 'Yōuxiù de xīnwén diàochá jìzhě yīngdāng kèshǒu kèguān zhōnglì de zhíyè dàodé, shēnrù yīxiàn wājué shìshí zhēnxiàng bìng wéihù shèhuì gōngpíng zhèngyì.', 'Nhà báo điều tra tin tức xuất sắc cần tuân thủ nghiêm ngặt đạo đức nghề nghiệp khách quan trung lập, thâm nhập tuyến đầu khai thác sự thật và giữ gìn công bằng chính nghĩa cho xã hội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [加班] (jiābān) - tăng ca, làm thêm giờ (overtime) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '加班' AND pinyin = 'jiābān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加班'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiābān',
      meaning_vi = 'tăng ca, làm thêm giờ (overtime)',
      example_hanzi = '今晚因为要赶一份紧急商业报告，他不得不在办公室加班两个小时。',
      example_pinyin = 'Jīnwǎn yīnwèi yào gǎn yí fèn jǐnjí shāngyè bàogào, tā bùdébù zài bàngōngshì jiābān liǎng gè xiǎoshí.',
      example_vi = 'Tối nay do phải gấp rút hoàn thành một bản báo cáo thương mại khẩn cấp, anh ấy buộc phải tăng ca hai tiếng trong văn phòng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今晚因为要赶一份紧急商业报告，他不得不在办公室加班两个小时。', 'Jīnwǎn yīnwèi yào gǎn yí fèn jǐnjí shāngyè bàogào, tā bùdébù zài bàngōngshì jiābān liǎng gè xiǎoshí.', 'Tối nay do phải gấp rút hoàn thành một bản báo cáo thương mại khẩn cấp, anh ấy buộc phải tăng ca hai tiếng trong văn phòng.', 'basic', 1),
        (v_id, '企业管理层应当建立科学合理的人力调配机制，避免常态化无效加班，保障员工身心健康与工作生活平衡。', 'Qǐyè guǎnlǐcéng yīngdāng jiànlì kēxué hélǐ de rénlì tiáopèi jīzhì, bìmiǎn chángtàihuà wúxiào jiābān, bǎozhàng yuángōng shēnxīn jiànkāng yǔ gōngzuò shēnghuó pínghéng.', 'Ban lãnh đạo doanh nghiệp cần thiết lập cơ chế điều phối nhân lực khoa học hợp lý, tránh việc tăng ca vô hiệu hóa trở thành thường nhật, bảo đảm sức khỏe thể chất tinh thần và cân bằng cuộc sống công việc cho nhân viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [家具] (jiājù) - đồ nội thất, đồ gia dụng (bàn ghế, giường tủ) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '家具' AND pinyin = 'jiājù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '家具'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiājù',
      meaning_vi = 'đồ nội thất, đồ gia dụng (bàn ghế, giường tủ)',
      example_hanzi = '搬进新家之后，他们去商场选购了一套简约风格的实木家具。',
      example_pinyin = 'Bān jìn xīn jiā zhīhòu, tāmen qù shāngchǎng xuǎngòu le yí tào jiǎnyuē fēnggé de shímù jiājù.',
      example_vi = 'Sau khi dọn vào nhà mới, họ đã đi trung tâm thương mại chọn mua một bộ đồ nội thất gỗ tự nhiên theo phong cách tối giản.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '搬进新家之后，他们去商场选购了一套简约风格的实木家具。', 'Bān jìn xīn jiā zhīhòu, tāmen qù shāngchǎng xuǎngòu le yí tào jiǎnyuē fēnggé de shímù jiājù.', 'Sau khi dọn vào nhà mới, họ đã đi trung tâm thương mại chọn mua một bộ đồ nội thất gỗ tự nhiên theo phong cách tối giản.', 'basic', 1),
        (v_id, '智能家居系统的普及促使传统家具制造企业加速转型，推出融入物联网传感器与人体工程学的创新智能家具产品。', 'Zhìnéng jiājū xìtǒng de pǔjí cùshǐ chuántǒng jiājù zhìzào qǐyè jiāsù zhuǎnxíng, tuīchū róngrù wùliánwǎng chuángǎnqì yǔ réntǐ gōngchéngxué de chuàngxīn zhìnéng jiājù chǎnpǐn.', 'Sự phổ cập của hệ thống nhà thông minh thúc đẩy các doanh nghiệp sản xuất đồ nội thất truyền thống đẩy nhanh chuyển đổi, tung ra các sản phẩm nội thất thông minh sáng tạo kết hợp cảm biến IoT và công thái học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [加快] (jiākuài) - đẩy nhanh, tăng tốc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '加快' AND pinyin = 'jiākuài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加快'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiākuài',
      meaning_vi = 'đẩy nhanh, tăng tốc',
      example_hanzi = '快迟到了，我们得加快脚步往前走。',
      example_pinyin = 'Kuài chídào le, wǒmen děi jiākuài jiǎobù wǎng qián zǒu.',
      example_vi = 'Sắp muộn rồi, chúng ta phải đẩy nhanh bước chân rảo bước về phía trước thôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '快迟到了，我们得加快脚步往前走。', 'Kuài chídào le, wǒmen děi jiākuài jiǎobù wǎng qián zǒu.', 'Sắp muộn rồi, chúng ta phải đẩy nhanh bước chân rảo bước về phía trước thôi.', 'basic', 1),
        (v_id, '为了抓住新一轮产业革命的重大契机，地方政府正在加快推进高新技术产业园区的数字化配套基础设施建设。', 'Wèile zhuāzhù xīn yì lún chǎnyè gémìng de zhòngdà qìjī, dìfāng zhèngfǔ zhèngzài jiākuài tuījìn gāoxīnjìshù chǎnyè yuánqū de shùzìhuà pèitào jīchǔ shèshī jiànshè.', 'Để nắm bắt thời cơ trọng đại của làn sóng cách mạng công nghiệp mới, chính quyền địa phương đang đẩy nhanh thúc đẩy việc xây dựng cơ sở hạ tầng bổ trợ số hóa cho khu công nghệ cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [加强] (jiāqiáng) - tăng cường, củng cố [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '加强' AND pinyin = 'jiāqiáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加强'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiāqiáng',
      meaning_vi = 'tăng cường, củng cố',
      example_hanzi = '平时我们要加强身体锻炼，提高免疫力。',
      example_pinyin = 'Píngshí wǒmen yào jiāqiáng shēntǐ duànliàn, tígāo miǎnyìlì.',
      example_vi = 'Ngày thường chúng ta phải tăng cường rèn luyện thể chất, nâng cao sức đề kháng miễn dịch.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '平时我们要加强身体锻炼，提高免疫力。', 'Píngshí wǒmen yào jiāqiáng shēntǐ duànliàn, tígāo miǎnyìlì.', 'Ngày thường chúng ta phải tăng cường rèn luyện thể chất, nâng cao sức đề kháng miễn dịch.', 'basic', 1),
        (v_id, '金融监管机构决定全面加强对跨国跨境资本异常流动的实时监测与风险防范处置。', 'Jīnróng jiānguǎn jīgòu juédìng quánmiàn jiāqiáng duì kuàguó kuàjìng zīběn yìcháng liúdòng de shíshí jiāncè yǔ fēngxiǎn fángfàn chǔzhì.', 'Cơ quan giám sát tài chính quyết định tăng cường toàn diện việc giám sát theo thời gian thực và phòng ngừa xử lý rủi ro đối với dòng vốn bất thường xuyên biên giới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [加入] (jiārù) - gia nhập, tham gia; cho thêm vào [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '加入' AND pinyin = 'jiārù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加入'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiārù',
      meaning_vi = 'gia nhập, tham gia; cho thêm vào',
      example_hanzi = '欢迎你加入我们中文学习兴趣俱乐部！',
      example_pinyin = 'Huānyíng nǐ jiārù wǒmen Zhōngwén xuéxí xìngqù jùlèbù!',
      example_vi = 'Chào mừng bạn gia nhập câu lạc bộ sở thích học tiếng Trung của chúng tôi!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '欢迎你加入我们中文学习兴趣俱乐部！', 'Huānyíng nǐ jiārù wǒmen Zhōngwén xuéxí xìngqù jùlèbù!', 'Chào mừng bạn gia nhập câu lạc bộ sở thích học tiếng Trung của chúng tôi!', 'basic', 1),
        (v_id, '随着多位全球顶尖计算机科学家与算法专家的全职加入，该人工智能实验室的研发实力得到了空前增强。', 'Suízhe duō wèi quánqiú dǐngjiān jìsuànjī kēxuéjiā yǔ suànfǎ zhuānjiā de quánzhí jiārù, gāi réngōng zhìnéng shíyànshì de yánfā shílì dédào le kōngqián zēngqiáng.', 'Cùng với sự gia nhập toàn thời gian của nhiều nhà khoa học máy tính và chuyên gia thuật toán hàng đầu thế giới, thực lực R&D của phòng thí nghiệm AI này đã được củng cố mạnh mẽ chưa từng thấy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [加上] (jiāshàng) - cộng thêm, thêm vào đó, cùng với [Liên từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '加上' AND pinyin = 'jiāshàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加上'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ / Động từ',
      pinyin = 'jiāshàng',
      meaning_vi = 'cộng thêm, thêm vào đó, cùng với',
      example_hanzi = '三加二等于五。',
      example_pinyin = 'Sān jiā èr děngyú wǔ.',
      example_vi = 'Ba cộng hai bằng năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '三加二等于五。', 'Sān jiā èr děngyú wǔ.', 'Ba cộng hai bằng năm.', 'basic', 1),
        (v_id, '产品过硬的品质，加上健全完善的售后服务网络，使得该国产品牌迅速赢得了海内外消费者的广泛认可。', 'Chǎnpǐn guòyìng de pǐnzhì, jiāshàng jiànquán wánshàn de shòuhòu fúwù wǎngluò, shǐde gāi guóchǎn pǐnpái xùnsù yíngdé le hǎinèiwài xiāofèizhě de guǎngfàn rènkě.', 'Phẩm chất vững vàng của sản phẩm, cộng thêm mạng lưới dịch vụ hậu mãi hoàn thiện kiện toàn, đã giúp thương hiệu nội địa này nhanh chóng giành được sự công nhận rộng rãi của người tiêu dùng trong và ngoài nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [家庭] (jiātíng) - gia đình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '家庭' AND pinyin = 'jiātíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '家庭'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiātíng',
      meaning_vi = 'gia đình',
      example_hanzi = '他出生在一个充满温馨和谐氛围的知识分子家庭。',
      example_pinyin = 'Tā chūshēng zài yí gè chōngmǎn wēnxīn héxié fēnwéi de zhīshi fènzǐ jiātíng.',
      example_vi = 'Anh ấy sinh ra trong một gia đình trí thức tràn ngập bầu không khí ấm cúng hòa thuận.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他出生在一个充满温馨和谐氛围的知识分子家庭。', 'Tā chūshēng zài yí gè chōngmǎn wēnxīn héxié fēnwéi de zhīshi fènzǐ jiātíng.', 'Anh ấy sinh ra trong một gia đình trí thức tràn ngập bầu không khí ấm cúng hòa thuận.', 'basic', 1),
        (v_id, '良好的家庭教育是青少年树立正确世界观、人生观和价值观的坚实第一基石。', 'Liánghǎo de jiātíng jiàoyù shì qīngshàonián shùlì zhèngquè shìjièguān, rénshēngguān hé jiàzhíguān de jiānshí dì-yī jīshí.', 'Giáo dục gia đình tốt đẹp chính là nền tảng đầu tiên vững chãi để thanh thiếu niên xây dựng thế giới quan, nhân sinh quan và giá trị quan đúng đắn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [家乡] (jiāxiāng) - quê hương, quê nhà [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '家乡' AND pinyin = 'jiāxiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '家乡'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiāxiāng',
      meaning_vi = 'quê hương, quê nhà',
      example_hanzi = '每逢中秋佳节，身在异乡的游子都格外思念远方的家乡。',
      example_pinyin = 'Měi féng Zhōngqiū jiājié, shēn zài yìxiāng de yóuzǐ dōu géwài sīniàn yuǎnfāng de jiāxiāng.',
      example_vi = 'Mỗi độ Tết Trung thu đến, người con xa xứ ở đất khách quê người đều nhớ da diết về quê nhà nơi phương xa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每逢中秋佳节，身在异乡的游子都格外思念远方的家乡。', 'Měi féng Zhōngqiū jiājié, shēn zài yìxiāng de yóuzǐ dōu géwài sīniàn yuǎnfāng de jiāxiāng.', 'Mỗi độ Tết Trung thu đến, người con xa xứ ở đất khách quê người đều nhớ da diết về quê nhà nơi phương xa.', 'basic', 1),
        (v_id, '许多在外学有所成的青年才俊积极响应国家号召返乡创业，为家乡的乡村振兴与特色产业发展注入了强劲动力。', 'Xǔduō zài wài xuéyǒusuǒchéng de qīngnián cáijùn jījí xiǎngyìng guójiā hàozhào fǎnxiāng chuàngyè, wèi jiāxiāng de xiāngcūn zhènxīng yǔ tèsè chǎnyè fāzhǎn zhùrù le qiángjìn dònglì.', 'Rất nhiều tài năng trẻ tuổi học hành thành đạt ở bên ngoài đã tích cực hưởng ứng lời kêu gọi của quốc gia trở về quê hương khởi nghiệp, tiếp thêm động lực mạnh mẽ cho công cuộc chấn hưng nông thôn và phát triển ngành nghề đặc thù của quê nhà.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [加油] (jiāyóu) - đổ xăng; cố lên, nỗ lực lên [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '加油' AND pinyin = 'jiāyóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加油'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiāyóu',
      meaning_vi = 'đổ xăng; cố lên, nỗ lực lên',
      example_hanzi = '比赛马上就要开始了，大家一起为选手们加油助威！',
      example_pinyin = 'Bǐsài mǎshàng jiù yào kāishǐ le, dàjiā yìqǐ wèi xuǎnshǒumen jiāyóu zhùwēi!',
      example_vi = 'Cuộc thi sắp sửa bắt đầu rồi, mọi người hãy cùng cổ vũ tiếp thêm sức mạnh cho các tuyển thủ nào!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '比赛马上就要开始了，大家一起为选手们加油助威！', 'Bǐsài mǎshàng jiù yào kāishǐ le, dàjiā yìqǐ wèi xuǎnshǒumen jiāyóu zhùwēi!', 'Cuộc thi sắp sửa bắt đầu rồi, mọi người hãy cùng cổ vũ tiếp thêm sức mạnh cho các tuyển thủ nào!', 'basic', 1),
        (v_id, '在汽车长途自驾旅行前，驾驶员务必提前规划好路线并在沿途高速服务区及时为车辆加油。', 'Zài qìchē chángtú zìjià lǚxíng qián, jiàshǐyuán wùbì tíqián guīhuà hǎo lùxiàn bìng zài yántú gāosù fúwùqū jíshí wèi chēliàng jiāyóu.', 'Trước chuyến du lịch tự lái xe đường dài, người lái xe nhất thiết phải lên kế hoạch lộ trình từ trước và kịp thời tiếp thêm nhiên liệu cho xe tại các trạm dừng chân cao tốc dọc đường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [加油站] (jiāyóuzhàn) - trạm xăng, cây xăng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '加油站' AND pinyin = 'jiāyóuzhàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '加油站'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiāyóuzhàn',
      meaning_vi = 'trạm xăng, cây xăng',
      example_hanzi = '前面五百米处的高速公路出口右侧有一座二十四小时营业的加油站。',
      example_pinyin = 'Qiánmiàn wǔ bǎi mǐ chù de gāosù gōnglù chūkǒu yòucè yǒu yí zuò èrshísì xiǎoshí yíngyè de jiāyóuzhàn.',
      example_vi = 'Phía trước cách 500 mét bên phải lối ra đường cao tốc có một trạm xăng mở cửa phục vụ 24/24.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '前面五百米处的高速公路出口右侧有一座二十四小时营业的加油站。', 'Qiánmiàn wǔ bǎi mǐ chù de gāosù gōnglù chūkǒu yòucè yǒu yí zuò èrshísì xiǎoshí yíngyè de jiāyóuzhàn.', 'Phía trước cách 500 mét bên phải lối ra đường cao tốc có một trạm xăng mở cửa phục vụ 24/24.', 'basic', 1),
        (v_id, '随着新能源汽车渗透率的快速提高，传统综合加油站纷纷加快转型，加装高压快充充电桩以打造多元化能源补给站。', 'Suízhe xīnnéngyuán qìchē shèntòulǜ de kuàisù tígāo, chuántǒng zōnghé jiāyóuzhàn fēnfēn jiākuài zhuǎnxíng, jiāzhuāng gāoyā kuàichōng chōngdiànzhuāng yǐ dǎzào duōyuánhuà néngyuán bǔjǐzhàn.', 'Cùng với tỷ lệ thâm nhập của xe ô tô năng lượng mới tăng nhanh, các trạm xăng tổng hợp truyền thống đang rầm rộ đẩy nhanh chuyển đổi, lắp đặt thêm trụ sạc siêu nhanh cao áp để xây dựng thành trạm tiếp năng lượng đa dạng hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [家长] (jiāzhǎng) - phụ huynh, bậc cha mẹ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '家长' AND pinyin = 'jiāzhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '家长'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiāzhǎng',
      meaning_vi = 'phụ huynh, bậc cha mẹ',
      example_hanzi = '学校定于本周五下午召开新学期的第一次全校家长会。',
      example_pinyin = 'Xuéxiào dìng yú běn zhōuwǔ xiàwǔ zhàokāi xīn xuéqī de dì-yī cì quán xiào jiāzhǎnghuì.',
      example_vi = 'Nhà trường ấn định chiều thứ Sáu tuần này sẽ triệu tập buổi họp phụ huynh toàn trường lần thứ nhất của học kỳ mới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学校定于本周五下午召开新学期的第一次全校家长会。', 'Xuéxiào dìng yú běn zhōuwǔ xiàwǔ zhàokāi xīn xuéqī de dì-yī cì quán xiào jiāzhǎnghuì.', 'Nhà trường ấn định chiều thứ Sáu tuần này sẽ triệu tập buổi họp phụ huynh toàn trường lần thứ nhất của học kỳ mới.', 'basic', 1),
        (v_id, '学校与家庭之间应当保持常态化顺畅沟通，引导广大家长树立科学理性的育儿观念，共同促进孩子身心全面发展。', 'Xuéxiào yǔ jiātíng zhījiān yīngdāng bǎochí chángtàihuà shùnchàng gōutōng, yǐndǎo guǎngdà jiāzhǎng shùlì kēxué lǐxìng de yù’ér guānniàn, gòngtóng cùjìn háizi shēnxīn quánmiàn fāzhǎn.', 'Giữa nhà trường và gia đình cần duy trì sự kết nối thông suốt thường xuyên, hướng dẫn đông đảo phụ huynh xác lập quan niệm nuôi dạy con cái khoa học lý tính, cùng nhau thúc đẩy sự phát triển toàn diện cả thể chất lẫn tâm hồn của trẻ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [假] (jiǎ) - giả, giả tạo, không thật [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '假' AND pinyin = 'jiǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '假'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'jiǎ',
      meaning_vi = 'giả, giả tạo, không thật',
      example_hanzi = '大家在购买贵重商品时一定要仔细鉴别，防止买到假货。',
      example_pinyin = 'Dàjiā zài gòumǎi guìzhòng shāngpǐn shí yídìng yào zǐxì jiànbié, fángzhǐ mǎi dào jiǎhuò.',
      example_vi = 'Mọi người khi mua hàng hóa đắt tiền nhất định phải cẩn thận giám định phân biệt, phòng ngừa mua phải hàng giả.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家在购买贵重商品时一定要仔细鉴别，防止买到假货。', 'Dàjiā zài gòumǎi guìzhòng shāngpǐn shí yídìng yào zǐxì jiànbié, fángzhǐ mǎi dào jiǎhuò.', 'Mọi người khi mua hàng hóa đắt tiền nhất định phải cẩn thận giám định phân biệt, phòng ngừa mua phải hàng giả.', 'basic', 1),
        (v_id, '市场监管部门重拳出击严厉打击制售假冒伪劣产品的违法犯罪行为，切实维护广大消费者的合法权益与市场公平竞争秩序。', 'Shìchǎng jiānguǎn bùmén zhòngquán chūjī yánlì dǎjī zhì-shòu jiǎmào wěiliè chǎnpǐn de wéifǎ fànzuì xíngwéi, qièshí wéihù guǎngdà xiāofèizhě de héfǎ quányì yǔ shìchǎng gōngpíng jìngzhēng zhìxù.', 'Cơ quan giám sát thị trường đã tung đòn mạnh tay trừng trị nghiêm khắc các hành vi phạm pháp sản xuất buôn bán hàng giả hàng nhái kém chất lượng, bảo vệ thiết thực quyền lợi hợp pháp của người tiêu dùng và trật tự cạnh tranh công bằng trên thị trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [价格] (jiàgé) - giá cả, mức giá [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '价格' AND pinyin = 'jiàgé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '价格'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiàgé',
      meaning_vi = 'giá cả, mức giá',
      example_hanzi = '这家超市的新鲜蔬菜不仅品质好，而且价格也相当公道。',
      example_pinyin = 'Zhè jiā chāoshì de xīnxiān shūcài bùjǐn pǐnzhì hǎo, érqiě jiàgé yě xiāngdāng gōngdao.',
      example_vi = 'Rau xanh tươi của siêu thị này không chỉ chất lượng tốt mà giá cả cũng tương đối phải chăng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家超市的新鲜蔬菜不仅品质好，而且价格也相当公道。', 'Zhè jiā chāoshì de xīnxiān shūcài bùjǐn pǐnzhì hǎo, érqiě jiàgé yě xiāngdāng gōngdao.', 'Rau xanh tươi của siêu thị này không chỉ chất lượng tốt mà giá cả cũng tương đối phải chăng.', 'basic', 1),
        (v_id, '国际大宗商品价格受地缘政治局势和供求关系等多重宏观因素影响，在短期内呈现出剧烈震荡的态势。', 'Guójì dàzōng shāngpǐn jiàgé shòu dìyuán zhèngzhì júshì hé gōngqiú guānxì děng duōchóng hóngguān yīnsù yǐngxiǎng, zài duǎnqī nèi chéngxiàn chū jùliè zhèndàng de tàishì.', 'Giá cả hàng hóa giao dịch quy mô lớn quốc tế chịu ảnh hưởng bởi nhiều nhân tố vĩ mô như cục diện địa chính trị và quan hệ cung cầu, trong ngắn hạn đang thể hiện xu thế biến động dữ dội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [价钱] (jiàqián) - giá tiền, tiền giá [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '价钱' AND pinyin = 'jiàqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '价钱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiàqián',
      meaning_vi = 'giá tiền, tiền giá',
      example_hanzi = '请问这条羊毛围巾的价钱是多少？',
      example_pinyin = 'Qǐngwèn zhè tiáo yángmáo wéijīn de jiàqián shì duōshao?',
      example_vi = 'Xin hỏi chiếc khăn quàng cổ lông cừu này giá tiền là bao nhiêu?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请问这条羊毛围巾的价钱是多少？', 'Qǐngwèn zhè tiáo yángmáo wéijīn de jiàqián shì duōshao?', 'Xin hỏi chiếc khăn quàng cổ lông cừu này giá tiền là bao nhiêu?', 'basic', 1),
        (v_id, '消费者在追求价钱实惠的同时，越来越看重商品的原材料品质、环保属性以及商家的售后保障承诺。', 'Xiāofèizhě zài zhuīqiú jiàqián shíhuì de tóngshí, yuèláiyuè kànzhòng shāngpǐn de yuáncáiliào pǐnzhì, huánbǎo shǔxìng yǐjí shāngjiā de shòuhòu bǎozhàng chéngnuò.', 'Người tiêu dùng trong khi theo đuổi giá tiền vừa túi, thì ngày càng coi trọng chất lượng nguyên vật liệu, đặc tính thân thiện môi trường và cam kết bảo hành hậu mãi của người bán.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [假日] (jiàrì) - ngày nghỉ, kỳ nghỉ lễ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '假日' AND pinyin = 'jiàrì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '假日'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiàrì',
      meaning_vi = 'ngày nghỉ, kỳ nghỉ lễ',
      example_hanzi = '每逢法定假日，许多家庭都会选择出门自驾游。',
      example_pinyin = 'Měi féng fǎdìng jiàrì, xǔduō jiātíng dōu huì xuǎnzé chūmén zìjiàyóu.',
      example_vi = 'Mỗi độ kỳ nghỉ lễ theo luật định, nhiều gia đình đều lựa chọn lái xe đi du lịch dã ngoại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每逢法定假日，许多家庭都会选择出门自驾游。', 'Měi féng fǎdìng jiàrì, xǔduō jiātíng dōu huì xuǎnzé chūmén zìjiàyóu.', 'Mỗi độ kỳ nghỉ lễ theo luật định, nhiều gia đình đều lựa chọn lái xe đi du lịch dã ngoại.', 'basic', 1),
        (v_id, '文化旅游部门在小长假期间通过丰富文旅产品供给与发放消费券，有效激活了假日文旅消费市场的强劲活力。', 'Wénhuà lǚyóu bùmén zài xiǎochángjià qījiān tōngguò fēngfù wénlǚ chǎnpǐn gōngjǐ yǔ fāfàng xiāofèiquàn, yǒuxiào jīhuó le jiàrì wénlǚ xiāofèi shìchǎng de qiángjìn huólì.', 'Ngành văn hóa du lịch trong kỳ nghỉ lễ ngắn thông qua việc làm phong phú nguồn cung sản phẩm du lịch văn hóa và phát hành phiếu ưu đãi tiêu dùng, đã kích hoạt hiệu quả sức sống mạnh mẽ của thị trường tiêu dùng du lịch ngày nghỉ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [减] (jiǎn) - giảm, bớt; trừ (toán học) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '减' AND pinyin = 'jiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '减'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiǎn',
      meaning_vi = 'giảm, bớt; trừ (toán học)',
      example_hanzi = '十减去四等于六。',
      example_pinyin = 'Shí jiǎn qù sì děngyú liù.',
      example_vi = 'Mười trừ đi bốn bằng sáu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '十减去四等于六。', 'Shí jiǎn qù sì děngyú liù.', 'Mười trừ đi bốn bằng sáu.', 'basic', 1),
        (v_id, '政府出台的一揽子减税降费扶持政策，有效帮助广大中小微企业减轻了生产经营过程中的资金负担。', 'Zhèngfǔ chūtái de yì lǎnzǐ jiǎnshuì-jiàngfèi fúchí zhèngcè, yǒuxiào bāngzhù guǎngdà zhōng-xiǎo-wēi qǐyè jiǎnqīng le shēngchǎn jīngyíng guòchéng zhōng de zījīn fùdān.', 'Gói chính sách hỗ trợ giảm thuế hạ phí của chính phủ đã giúp đỡ hiệu quả đông đảo doanh nghiệp vừa, nhỏ và siêu nhỏ giảm bớt gánh nặng tài chính trong quá trình sản xuất kinh doanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [减轻] (jiǎnqīng) - giảm nhẹ, làm dịu bớt (gánh nặng, nỗi đau) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '减轻' AND pinyin = 'jiǎnqīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '减轻'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiǎnqīng',
      meaning_vi = 'giảm nhẹ, làm dịu bớt (gánh nặng, nỗi đau)',
      example_hanzi = '吃完药休息了一会儿之后，他的头痛明显减轻了许多。',
      example_pinyin = 'Chī wán yào xiūxi le yíhuìr zhīhòu, tā de tóutòng míngxiǎn jiǎnqīng le xǔduō.',
      example_vi = 'Sau khi uống thuốc nghỉ ngơi một lát, cơn đau đầu của anh ấy đã giảm nhẹ đi rất nhiều.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '吃完药休息了一会儿之后，他的头痛明显减轻了许多。', 'Chī wán yào xiūxi le yíhuìr zhīhòu, tā de tóutòng míngxiǎn jiǎnqīng le xǔduō.', 'Sau khi uống thuốc nghỉ ngơi một lát, cơn đau đầu của anh ấy đã giảm nhẹ đi rất nhiều.', 'basic', 1),
        (v_id, '为了切实减轻义务教育阶段中小学生的过重作业负担，教育管理部门在全国范围内深入推行了“双减”政策。', 'Wèile qièshí jiǎnqīng yìwù jiàoyù jiēduàn zhōng-xiǎoxuéshēng de guòzhòng zuòyè fùdān, jiàoyù guǎnlǐ bùmén zài quánguó fànwéi nèi shēnrù tuīxíng le “shuāngjiǎn” zhèngcè.', 'Để giảm bớt thiết thực gánh nặng bài tập quá tải của học sinh tiểu học và trung học cơ sở trong giai đoạn giáo dục bắt buộc, ngành giáo dục đã triển khai sâu rộng chính sách "giảm kép" trên phạm vi toàn quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [减少] (jiǎnshǎo) - giảm bớt, sụt giảm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '减少' AND pinyin = 'jiǎnshǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '减少'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiǎnshǎo',
      meaning_vi = 'giảm bớt, sụt giảm',
      example_hanzi = '为了保持健康，我们平时应当尽量减少高糖和油炸食品的摄入。',
      example_pinyin = 'Wèile bǎochí jiànkāng, wǒmen píngshí yīngdāng jǐnliàng jiǎnshǎo gāotáng hé yóuzhá shípǐn de shèrù.',
      example_vi = 'Để giữ gìn sức khỏe, ngày thường chúng ta nên cố gắng giảm bớt lượng thức ăn nhiều đường và đồ chiên rán nạp vào cơ thể.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了保持健康，我们平时应当尽量减少高糖和油炸食品的摄入。', 'Wèile bǎochí jiànkāng, wǒmen píngshí yīngdāng jǐnliàng jiǎnshǎo gāotáng hé yóuzhá shípǐn de shèrù.', 'Để giữ gìn sức khỏe, ngày thường chúng ta nên cố gắng giảm bớt lượng thức ăn nhiều đường và đồ chiên rán nạp vào cơ thể.', 'basic', 1),
        (v_id, '通过引进精益生产流水线与全流程数字化质量追溯，工厂在过去一年里将次品不良率减少了近百分之四十。', 'Tōngguò yǐnjìn jīngyì shēngchǎn liúshuǐxiàn yǔ quán liúchéng shùzìhuà zhìliàng zhuīsù, gōngchǎng zài guòqù yì nián lǐ jiāng cìpǐn bùliánglǜ jiǎnshǎo le jìn bǎifēnzhī sìshí.', 'Thông qua việc đưa vào dây chuyền sản xuất tinh gọn và truy xuất chất lượng số hóa toàn quy trình, nhà máy trong một năm qua đã giảm tỷ lệ phế phẩm lỗi xuống gần 40%.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [健身] (jiànshēn) - tập thể hình, rèn luyện sức khỏe (fitness) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '健身' AND pinyin = 'jiànshēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '健身'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiànshēn',
      meaning_vi = 'tập thể hình, rèn luyện sức khỏe (fitness)',
      example_hanzi = '他坚持每周去三次健身房进行器械力量健身训练。',
      example_pinyin = 'Tā jiānchí měi zhōu qù sān cì jiànshēnfáng jìnxíng qìxiè lìliàng jiànshēn xùnliàn.',
      example_vi = 'Anh ấy kiên trì mỗi tuần đến phòng gym ba lần để tập luyện thể hình nâng tạ tăng cường thể lực.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他坚持每周去三次健身房进行器械力量健身训练。', 'Tā jiānchí měi zhōu qù sān cì jiànshēnfáng jìnxíng qìxiè lìliàng jiànshēn xùnliàn.', 'Anh ấy kiên trì mỗi tuần đến phòng gym ba lần để tập luyện thể hình nâng tạ tăng cường thể lực.', 'basic', 1),
        (v_id, '随着全民健身国家战略的深入实施，越来越多的城市居民在业余时间积极投入到跑步、瑜伽及科学健身运动中。', 'Suízhe quánmín jiànshēn guójiā zhànlüè de shēnrù shíshī, yuèláiyuè duō de chéngshì jūmín zài yèyú shíjiān jījí tóurù dào pǎobù, yújiā jí kēxué jiànshēn yùndòng zhōng.', 'Cùng với việc triển khai sâu rộng chiến lược quốc gia rèn luyện thể thao toàn dân, ngày càng nhiều cư dân đô thị trong thời gian rảnh rỗi đã tích cực tham gia vào việc chạy bộ, yoga và tập thể hình khoa học.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [健身房] (jiànshēnfáng) - phòng tập gym, phòng tập thể hình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '健身房' AND pinyin = 'jiànshēnfáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '健身房'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiànshēnfáng',
      meaning_vi = 'phòng tập gym, phòng tập thể hình',
      example_hanzi = '我们公司楼下新开了一家设施十分齐全的二十四小时智能健身房。',
      example_pinyin = 'Wǒmen gōngsī lóuxià xīn kāi le yì jiā shèshī shífēn qíquán de èrshísì xiǎoshí zhìnéng jiànshēnfáng.',
      example_vi = 'Dưới chân tòa nhà công ty chúng tôi mới mở một phòng gym thông minh 24/24 với trang thiết bị vô cùng đầy đủ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们公司楼下新开了一家设施十分齐全的二十四小时智能健身房。', 'Wǒmen gōngsī lóuxià xīn kāi le yì jiā shèshī shífēn qíquán de èrshísì xiǎoshí zhìnéng jiànshēnfáng.', 'Dưới chân tòa nhà công ty chúng tôi mới mở một phòng gym thông minh 24/24 với trang thiết bị vô cùng đầy đủ.', 'basic', 1),
        (v_id, '现代高端社区往往在会所内配备专业健身房与室内恒温游泳池，为业主提供全方位的健康休闲生活空间。', 'Xiàndài gāoduān shèqū wǎngwǎng zài huìsuǒ nèi pèibèi zhuānyè jiànshēnfáng yǔ shìnèi héngwēn yóuyǒngchí, wèi yèzhǔ tígōng quánfāngwèi de jiànkāng xiūxián shēnghuó kōngjiān.', 'Các khu đô thị cao cấp hiện đại thường trang bị phòng gym chuyên nghiệp và bể bơi nước ấm trong nhà trong khu clubhouse, đem lại không gian sinh hoạt nghỉ dưỡng sức khỏe toàn diện cho gia chủ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [建议] (jiànyì) - kiến nghị, gợi ý, đề xuất; lời khuyên [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '建议' AND pinyin = 'jiànyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '建议'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiànyì',
      meaning_vi = 'kiến nghị, gợi ý, đề xuất; lời khuyên',
      example_hanzi = '如果喉咙不舒服，我建议你多喝温开水并早点休息。',
      example_pinyin = 'Rúguǒ hóulóng bù shūfu, wǒ jiànyì nǐ duō hē wēn kāishuǐ bìng zǎo diǎn xiūxi.',
      example_vi = 'Nếu cổ họng không dễ chịu, tôi khuyên bạn nên uống nhiều nước ấm và nghỉ ngơi sớm một chút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如果喉咙不舒服，我建议你多喝温开水并早点休息。', 'Rúguǒ hóulóng bù shūfu, wǒ jiànyì nǐ duō hē wēn kāishuǐ bìng zǎo diǎn xiūxi.', 'Nếu cổ họng không dễ chịu, tôi khuyên bạn nên uống nhiều nước ấm và nghỉ ngơi sớm một chút.', 'basic', 1),
        (v_id, '行业咨询专家在深入调研后，针对企业数字化转型过程中面临的痛点提出了极具可操作性的前瞻性建议。', 'Hángyè zīxún zhuānjiā zài shēnrù diàoyán hòu, zhēnduì qǐyè shùzìhuà zhuǎnxíng guòchéng zhōng miànlín de tòngdiǎn tíchū le jí jù kě-cāozuòxìng de qiánzhānxìng jiànyì.', 'Các chuyên gia tư vấn ngành sau khi khảo sát sâu sát, đã đưa ra những đề xuất mang tính đón đầu và có khả năng thao tác cao nhằm vào những điểm nghẽn đau đầu mà doanh nghiệp gặp phải trong chuyển đổi số.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [江] (jiāng) - sông, con sông lớn (Trường Giang, Hoàng Phố) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '江' AND pinyin = 'jiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '江'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiāng',
      meaning_vi = 'sông, con sông lớn (Trường Giang, Hoàng Phố)',
      example_hanzi = '夜晚漫步在外滩，黄浦江两岸璀璨的灯光夜景美不胜收。',
      example_pinyin = 'Yèwǎn mànbù zài Wàitān, Huángpǔ Jiāng liǎng’àn cuǐcàn de dēngguāng yèjǐng měibùshèngshōu.',
      example_vi = 'Đêm tối dạo bước trên Bến Thượng Hải, cảnh đêm ánh đèn rực rỡ đôi bờ sông Hoàng Phố đẹp không sao tả xiết.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '夜晚漫步在外滩，黄浦江两岸璀璨的灯光夜景美不胜收。', 'Yèwǎn mànbù zài Wàitān, Huángpǔ Jiāng liǎng’àn cuǐcàn de dēngguāng yèjǐng měibùshèngshōu.', 'Đêm tối dạo bước trên Bến Thượng Hải, cảnh đêm ánh đèn rực rỡ đôi bờ sông Hoàng Phố đẹp không sao tả xiết.', 'basic', 1),
        (v_id, '长江作为中华民族的母亲河之一，不仅孕育了悠久深厚的荆楚与江南文化，更在全国生态安全与经济协同发展中居于关键地位。', 'Cháng Jiāng zuòwéi Zhōnghuá mínzú de mǔqīn hé zhīyī, bùjǐn yùnyù le yōujiǔ shēnhòu de Jīng-Chǔ yǔ Jiāngnán wénhuà, gèng zài quánguó shēngtài ānquán yǔ jīngjì xiétóng fāzhǎn zhōng jūyú guānjiàn dìwèi.', 'Sông Trường Giang với tư cách là một trong những dòng sông mẹ của dân tộc Trung Hoa, không chỉ nuôi dưỡng nền văn hóa Kinh Sở và Giang Nam sâu lắng lâu đời, mà còn giữ vị thế then chốt trong an ninh sinh thái và phát triển kinh tế hiệp đồng toàn quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [将] (jiāng) - sẽ (tương lai); đem, lấy (tương đương 把) [Phó từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '将' AND pinyin = 'jiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '将'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Giới từ',
      pinyin = 'jiāng',
      meaning_vi = 'sẽ (tương lai); đem, lấy (tương đương 把)',
      example_hanzi = '新学期的开学典礼将于下周一上午九点在学校大礼堂准时举行。',
      example_pinyin = 'Xīn xuéqī de kāixué diǎnlǐ jiāng yú xià zhōuyī shàngwǔ jiǔ diǎn zài xuéxiào dà lǐtáng zhǔnshí jǔxíng.',
      example_vi = 'Lễ khai giảng của học kỳ mới sẽ được tổ chức đúng 9 giờ sáng thứ Hai tuần tới tại hội trường lớn của trường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '新学期的开学典礼将于下周一上午九点在学校大礼堂准时举行。', 'Xīn xuéqī de kāixué diǎnlǐ jiāng yú xià zhōuyī shàngwǔ jiǔ diǎn zài xuéxiào dà lǐtáng zhǔnshí jǔxíng.', 'Lễ khai giảng của học kỳ mới sẽ được tổ chức đúng 9 giờ sáng thứ Hai tuần tới tại hội trường lớn của trường.', 'basic', 1),
        (v_id, '企业计划在未来五年内将年营业收入的百分之十以上持续投入到基础材料与芯片设计的前沿研发中。', 'Qǐyè jìhuà zài wèilái wǔ nián nèi jiāng nián yíngyè shōurù de bǎifēnzhī shí yǐshàng chíxù tóurù dào jīchǔ cáiliào yǔ xīnpiàn shèjì de qiányán yánfā zhōng.', 'Doanh nghiệp lên kế hoạch trong vòng 5 năm tới sẽ đem trên 10% doanh thu hàng năm liên tục đầu tư vào nghiên cứu phát triển tiên phong về vật liệu cơ bản và thiết kế chip.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [将来] (jiānglái) - tương lai, sau này [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '将来' AND pinyin = 'jiānglái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '将来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiānglái',
      meaning_vi = 'tương lai, sau này',
      example_hanzi = '你将来大学毕业之后打算从事什么样的工作？',
      example_pinyin = 'Nǐ jiānglái dàxué bìyè zhīhòu dǎsuàn cóngshì shénmeyàng de gōngzuò?',
      example_vi = 'Sau này khi tốt nghiệp đại học bạn dự định làm công việc như thế nào?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你将来大学毕业之后打算从事什么样的工作？', 'Nǐ jiānglái dàxué bìyè zhīhòu dǎsuàn cóngshì shénmeyàng de gōngzuò?', 'Sau này khi tốt nghiệp đại học bạn dự định làm công việc như thế nào?', 'basic', 1),
        (v_id, '青年一代唯有在当下脚踏实地练就过硬本领，将来才能在激烈的全球化竞争中勇挑重担、大有作为。', 'Qīngnián yídài wéiyǒu zài dāngxià jiǎotà-shídì liàn jiù guòyìng běnlǐng, jiānglái cái néng zài jīliè de quánqiúhuà jìngzhēng zhōng yǒng tiāo zhòngdàn, dàyǒu-zuòwéi.', 'Thế hệ trẻ chỉ có ngay trong hiện tại vững bước rèn luyện bản lĩnh thực thụ, thì tương lai mới có thể dũng cảm gánh vác trọng trách và làm nên việc lớn giữa cuộc cạnh tranh toàn cầu hóa khốc liệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [将要] (jiāngyào) - sắp, sẽ (sắp sửa diễn ra) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '将要' AND pinyin = 'jiāngyào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '将要'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'jiāngyào',
      meaning_vi = 'sắp, sẽ (sắp sửa diễn ra)',
      example_hanzi = '天空中乌云密布，一场倾盆大雨将要来临。',
      example_pinyin = 'Tiānkōng zhōng wūyún-mìbù, yì chǎng qīngpén-dàyǔ jiāngyào láilín.',
      example_vi = 'Trên bầu trời mây đen giăng kín, một trận mưa to như trút nước sắp sửa ập đến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '天空中乌云密布，一场倾盆大雨将要来临。', 'Tiānkōng zhōng wūyún-mìbù, yì chǎng qīngpén-dàyǔ jiāngyào láilín.', 'Trên bầu trời mây đen giăng kín, một trận mưa to như trút nước sắp sửa ập đến.', 'basic', 1),
        (v_id, '这家具有百年历史的制造巨头将要在下个月正式对外公布其史上规模最大的全球资产重组与业务剥离方案。', 'Zhè jiā jùyǒu bǎinián lìshǐ de zhìzào jùtóu jiāngyào zài xià gè yuè zhèngshì duìwài gōngbù qí shǐshàng guīmó zuì dà de quánqiú zīchǎn chóngzǔ yǔ yèwù bōlí fāng’àn.', 'Gã khổng lồ sản xuất có bề dày lịch sử trăm năm này sẽ chính thức công bố ra bên ngoài vào tháng tới phương án tái cơ cấu tài sản và thoái vốn kinh doanh quy mô lớn nhất trong lịch sử của mình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [奖] (jiǎng) - giải thưởng, phần thưởng; khen thưởng [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '奖' AND pinyin = 'jiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '奖'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'jiǎng',
      meaning_vi = 'giải thưởng, phần thưởng; khen thưởng',
      example_hanzi = '他在本次全国中学生数学奥林匹克竞赛中荣获了一等奖。',
      example_pinyin = 'Tā zài běn cì quánguó zhōngxuéshēng shùxué Àolínpǐkè jìngsài zhōng rónghuò le yīděngjiǎng.',
      example_vi = 'Cậu ấy đã đoạt giải nhất trong kỳ thi Olympic Toán học học sinh trung học toàn quốc lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在本次全国中学生数学奥林匹克竞赛中荣获了一等奖。', 'Tā zài běn cì quánguó zhōngxuéshēng shùxué Àolínpǐkè jìngsài zhōng rónghuò le yīděngjiǎng.', 'Cậu ấy đã đoạt giải nhất trong kỳ thi Olympic Toán học học sinh trung học toàn quốc lần này.', 'basic', 1),
        (v_id, '科学技术奖励制度的持续完善与重奖杰出创新团队，在全社会营造了崇尚科学、尊重人才的浓厚氛围。', 'Kēxué jìshù jiǎnglì zhìdù de chíxù wánshàn yǔ zhòngjiǎng jiéchū chuàngxīn tuánduì, zài quán shèhuì yíngzào le chóngshàng kēxué, zūnzhòng réncái de nónghòu fēnwéi.', 'Sự hoàn thiện liên tục của chế độ khen thưởng khoa học công nghệ cùng việc trọng thưởng các đội ngũ đổi mới kiệt xuất đã tạo dựng bầu không khí đậm nét tôn sùng khoa học và trọng dụng nhân tài trong toàn xã hội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [奖金] (jiǎngjīn) - tiền thưởng, tiền thưởng thành tích [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '奖金' AND pinyin = 'jiǎngjīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '奖金'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiǎngjīn',
      meaning_vi = 'tiền thưởng, tiền thưởng thành tích',
      example_hanzi = '因为这个季度业绩出色，公司给每个团队成员都发放了一笔丰厚的奖金。',
      example_pinyin = 'Yīnwèi zhè gè jīdù yèjì chūsè, gōngsī gěi měi gè tuánduì chéngyuán dōu fāfàng le yì bǐ fēnghòu de jiǎngjīn.',
      example_vi = 'Vì quý này thành tích xuất sắc, công ty đã phát cho mỗi thành viên trong đội ngũ một khoản tiền thưởng hậu hĩnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '因为这个季度业绩出色，公司给每个团队成员都发放了一笔丰厚的奖金。', 'Yīnwèi zhè gè jīdù yèjì chūsè, gōngsī gěi měi gè tuánduì chéngyuán dōu fāfàng le yì bǐ fēnghòu de jiǎngjīn.', 'Vì quý này thành tích xuất sắc, công ty đã phát cho mỗi thành viên trong đội ngũ một khoản tiền thưởng hậu hĩnh.', 'basic', 1),
        (v_id, '企业在年终考核中将研发人员的项目阶段性攻关成果与重大专项奖金紧密挂钩，充分调动了骨干工程师的钻研积极性。', 'Qǐyè zài niánzhōng kǎohé zhōng jiāng yánfā rényuán de xiàngmù jiēduànxìng gōngguān chéngguǒ yǔ zhòngdà zhuānxiàng jiǎngjīn jǐnmì guàgōu, chōngfèn diàodòng le gǔgàn gōngchéngshī de zuānyán jījíxìng.', 'Doanh nghiệp trong đợt đánh giá cuối năm đã gắn kết chặt chẽ thành quả đột phá theo giai đoạn của nhân viên R&D với các khoản tiền thưởng chuyên đề lớn, khơi dậy mạnh mẽ sự hăng say nghiên cứu của các kỹ sư nòng cốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [奖学金] (jiǎngxuéjīn) - học bổng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '奖学金' AND pinyin = 'jiǎngxuéjīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '奖学金'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiǎngxuéjīn',
      meaning_vi = 'học bổng',
      example_hanzi = '凭借优异的学习成绩，她在大二学年成功申请到了全额奖学金。',
      example_pinyin = 'Píngjiè yōuyì de xuéxí chéngjì, tā zài dà’èr xuénián chénggōng shēnqǐng dào le quán’é jiǎngxuéjīn.',
      example_vi = 'Dựa vào thành tích học tập xuất sắc, cô ấy trong năm thứ hai đại học đã xin được học bổng toàn phần thành công.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '凭借优异的学习成绩，她在大二学年成功申请到了全额奖学金。', 'Píngjiè yōuyì de xuéxí chéngjì, tā zài dà’èr xuénián chénggōng shēnqǐng dào le quán’é jiǎngxuéjīn.', 'Dựa vào thành tích học tập xuất sắc, cô ấy trong năm thứ hai đại học đã xin được học bổng toàn phần thành công.', 'basic', 1),
        (v_id, '为吸引全球顶尖青年学者前来攻读博士学位，该知名大学设立了涵盖学费全免与丰厚生活津贴的高额国际研究生奖学金。', 'Wèi xīyǐn quánqiú dǐngjiān qīngnián xuézhě qiánlái gōngdú bóshì xuéwèi, gāi zhìmíng dàxué shèlì le hángài xuéfèi quánmiǎn yǔ fēnghòu shēnghuó jīntiē de gāo’é guójì yánjiūshēng jiǎngxuéjīn.', 'Để thu hút các học giả trẻ tuổi hàng đầu toàn cầu đến theo học tiến sĩ, trường đại học danh tiếng này đã thiết lập quỹ học bổng nghiên cứu sinh quốc tế giá trị cao bao gồm miễn toàn bộ học phí cùng khoản trợ cấp sinh hoạt hậu hĩnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [降] (jiàng) - hạ xuống, rơi xuống, tụt dốc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '降' AND pinyin = 'jiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '降'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiàng',
      meaning_vi = 'hạ xuống, rơi xuống, tụt dốc',
      example_hanzi = '随着北方一股强冷空气南下，明天气温将大幅下降八度左右。',
      example_pinyin = 'Suízhe běifāng yì gǔ qiáng lěng kōngqì nánxià, míngtiān qìwēn jiāng dàfú xiàjiàng bā dù zuǒyòu.',
      example_vi = 'Cùng với luồng không khí lạnh mạnh từ phương Bắc tràn xuống phía Nam, nhiệt độ ngày mai sẽ giảm mạnh khoảng tám độ C.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '随着北方一股强冷空气南下，明天气温将大幅下降八度左右。', 'Suízhe běifāng yì gǔ qiáng lěng kōngqì nánxià, míngtiān qìwēn jiāng dàfú xiàjiàng bā dù zuǒyòu.', 'Cùng với luồng không khí lạnh mạnh từ phương Bắc tràn xuống phía Nam, nhiệt độ ngày mai sẽ giảm mạnh khoảng tám độ C.', 'basic', 1),
        (v_id, '在经历连续几个月的原材料供给短缺后，国际大宗原油与铜金属价格终于迎来了企稳降温的回落走势。', 'Zài jīnglì liánxù jǐ gè yuè de yuáncáiliào gōngjǐ duǎnquē hòu, guójì dàzōng yuányóu yǔ tóng jīnshǔ jiàgé zhōngyú yínglái le qǐwěn jiàngwēn de huíluò zǒushì.', 'Sau khi trải qua nhiều tháng liên tiếp khan hiếm nguồn cung nguyên vật liệu, giá dầu thô và kim loại đồng quy mô lớn quốc tế cuối cùng đã đón nhận xu thế hạ nhiệt và điều chỉnh ổn định.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [降低] (jiàngdī) - hạ thấp, làm giảm bớt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '降低' AND pinyin = 'jiàngdī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '降低'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiàngdī',
      meaning_vi = 'hạ thấp, làm giảm bớt',
      example_hanzi = '平时养成少吃油腻的健康饮食习惯，有助于降低血液中的胆固醇。',
      example_pinyin = 'Píngshí yǎngchéng shǎo chī yóunì de jiànkāng yǐnshí xíguàn, yǒuzhùyú jiàngdī xièyè zhōng de dǎngùchún.',
      example_vi = 'Ngày thường rèn luyện thói quen ăn uống lành mạnh ít đồ dầu mỡ có ích trong việc làm giảm lượng cholesterol trong máu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '平时养成少吃油腻的健康饮食习惯，有助于降低血液中的胆固醇。', 'Píngshí yǎngchéng shǎo chī yóunì de jiànkāng yǐnshí xíguàn, yǒuzhùyú jiàngdī xièyè zhōng de dǎngùchún.', 'Ngày thường rèn luyện thói quen ăn uống lành mạnh ít đồ dầu mỡ có ích trong việc làm giảm lượng cholesterol trong máu.', 'basic', 1),
        (v_id, '制造型企业通过全面引入自动化生产线和供应链协同管理，不仅显著降低了生产运营成本，而且极大提高了产品良品率。', 'Zhìzàoxíng qǐyè tōngguò quánmiàn yǐnrù zìdònghuà shēngchǎnxiàn hé gōngyìngliàn xiétóng guǎnlǐ, bùjǐn xiǎnzhù jiàngdī le shēngchǎn yùnyíng chéngběn, érqiě jí dà tígāo le chǎnpǐn liángpǐnlǜ.', 'Doanh nghiệp sản xuất thông qua việc đưa vào đồng bộ dây chuyền sản xuất tự động hóa và quản lý hiệp đồng chuỗi cung ứng, không những làm giảm đáng kể chi phí vận hành sản xuất mà còn nâng cao rất lớn tỷ lệ sản phẩm đạt chuẩn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [降价] (jiàngjià) - hạ giá, giảm giá [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '降价' AND pinyin = 'jiàngjià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '降价'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiàngjià',
      meaning_vi = 'hạ giá, giảm giá',
      example_hanzi = '每年年底商场都会搞大型促销活动，许多知名品牌服装都会大幅降价。',
      example_pinyin = 'Měi nián niándǐ shāngchǎng dōu huì gǎo dàxíng cùxiāo huódòng, xǔduō zhìmíng pǐnpái fúzhuāng dōu huì dàfú jiàngjià.',
      example_vi = 'Mỗi dịp cuối năm trung tâm thương mại đều tổ chức chương trình khuyến mãi lớn, nhiều thương hiệu trang phục nổi tiếng đều giảm giá mạnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年年底商场都会搞大型促销活动，许多知名品牌服装都会大幅降价。', 'Měi nián niándǐ shāngchǎng dōu huì gǎo dàxíng cùxiāo huódòng, xǔduō zhìmíng pǐnpái fúzhuāng dōu huì dàfú jiàngjià.', 'Mỗi dịp cuối năm trung tâm thương mại đều tổ chức chương trình khuyến mãi lớn, nhiều thương hiệu trang phục nổi tiếng đều giảm giá mạnh.', 'basic', 1),
        (v_id, '面对主要竞争对手发起的新一轮降价促销价格战，该汽车厂商决定通过提升售后服务增值体验而非盲目跟进降价来稳固市场份额。', 'Miànduì zhǔyào jìngzhēng duìshǒu fāqǐ de xīn yì lún jiàngjià cùxiāo jiàgézhàn, gāi qìchē chǎngshāng juédìng tōngguò tíshēng shòuhòu fúwù zēngzhí tǐyàn ér fēi mángmù gēnjìn jiàngjià lái wěngù shìchǎng fèn’é.', 'Đối mặt với cuộc chiến giá cả giảm giá khuyến mãi vòng mới do đối thủ cạnh tranh chủ chốt phát động, hãng ô tô này quyết định nâng cao trải nghiệm gia tăng giá trị dịch vụ hậu mãi thay vì chạy theo giảm giá mù quáng để giữ vững thị phần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [降落] (jiàngluò) - hạ cánh, tiếp đất (máy bay) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '降落' AND pinyin = 'jiàngluò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '降落'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiàngluò',
      meaning_vi = 'hạ cánh, tiếp đất (máy bay)',
      example_hanzi = '各位旅客请系好安全带，我们的飞机马上就要在首都国际机场降落了。',
      example_pinyin = 'Gèwèi lǚkè qǐng jì hǎo ānquándài, wǒmen de fēijī mǎshàng jiù yào zài Shǒudū Guójì Jīchǎng jiàngluò le.',
      example_vi = 'Kính thưa quý hành khách xin vui lòng thắt dây an toàn, máy bay của chúng ta sắp sửa hạ cánh xuống Sân bay Quốc tế Thủ đô.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '各位旅客请系好安全带，我们的飞机马上就要在首都国际机场降落了。', 'Gèwèi lǚkè qǐng jì hǎo ānquándài, wǒmen de fēijī mǎshàng jiù yào zài Shǒudū Guójì Jīchǎng jiàngluò le.', 'Kính thưa quý hành khách xin vui lòng thắt dây an toàn, máy bay của chúng ta sắp sửa hạ cánh xuống Sân bay Quốc tế Thủ đô.', 'basic', 1),
        (v_id, '在遭遇突发雷暴强气流的极端复杂气象条件下，机长凭借娴熟精湛的飞行驾驶技术驾驶客机平稳降落在备降机场跑道上。', 'Zài zāoyù tūfā léibào qiáng qìliú de jíduān fùzá qìxiàng tiáojiàn xià, jīzhǎng píngjiè xiánshú jīngzhàn de fēixíng jiàshǐ jìshù jiàshǐ kèjī píngwěn jiàngluò zài bèijiàng jīchǎng pǎodào shang.', 'Dưới điều kiện khí tượng cực kỳ phức tạp khi gặp phải luồng khí giông bão mạnh bất ngờ, cơ trưởng nhờ vào kỹ thuật lái bay điêu luyện chuẩn xác đã điều khiển máy bay chở khách hạ cánh êm thuận xuống đường băng sân bay dự phòng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [降温] (jiàngwēn) - giảm nhiệt, hạ nhiệt độ; hạ nhiệt (cơn sốt, thị trường) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '降温' AND pinyin = 'jiàngwēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '降温'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiàngwēn',
      meaning_vi = 'giảm nhiệt, hạ nhiệt độ; hạ nhiệt (cơn sốt, thị trường)',
      example_hanzi = '明天受冷空气影响北方地区将普遍降温，出门请注意增添衣物。',
      example_pinyin = 'Míngtiān shòu lěng kōngqì yǐngxiǎng běifāng dìqū jiāng pǔbiàn jiàngwēn, chūmén qǐng zhùyì zēngtiān yīwù.',
      example_vi = 'Ngày mai chịu ảnh hưởng của không khí lạnh các khu vực miền Bắc sẽ đồng loạt hạ nhiệt, khi ra ngoài xin chú ý mặc thêm quần áo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '明天受冷空气影响北方地区将普遍降温，出门请注意增添衣物。', 'Míngtiān shòu lěng kōngqì yǐngxiǎng běifāng dìqū jiāng pǔbiàn jiàngwēn, chūmén qǐng zhùyì zēngtiān yīwù.', 'Ngày mai chịu ảnh hưởng của không khí lạnh các khu vực miền Bắc sẽ đồng loạt hạ nhiệt, khi ra ngoài xin chú ý mặc thêm quần áo.', 'basic', 1),
        (v_id, '在政府接连出台多项房地产宏观调控与信贷紧缩政策后，此前过热的一线城市二手房交易市场迎来了实质性降温。', 'Zài zhèngfǔ jiēlián chūtái duō xiàng fángdìchǎn hóngguān tiáokòng yǔ xìndài jǐnsuō zhèngcè hòu, cǐqián guòrè de yīxiàn chéngshì èrshǒufáng jiāoyì shìchǎng yínglái le shízhìxìng jiàngwēn.', 'Sau khi chính phủ liên tiếp ban hành nhiều chính sách điều tiết vĩ mô bất động sản và thắt chặt tín dụng, thị trường giao dịch nhà cũ từng quá nóng trước đây tại các thành phố tuyến 1 đã đón nhận sự hạ nhiệt thực chất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [交] (jiāo) - nộp, giao; kết giao (bạn bè) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '交' AND pinyin = 'jiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '交'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiāo',
      meaning_vi = 'nộp, giao; kết giao (bạn bè)',
      example_hanzi = '请大家在明天下午放学之前把写好的中文作业交上来。',
      example_pinyin = 'Qǐng dàjiā zài míngtiān xiàwǔ fàngxué zhīqián bǎ xiě hǎo de Zhōngwén zuòyè jiāo shànglái.',
      example_vi = 'Xin mời mọi người trước giờ tan học chiều mai nộp bài tập tiếng Trung đã làm xong lên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请大家在明天下午放学之前把写好的中文作业交上来。', 'Qǐng dàjiā zài míngtiān xiàwǔ fàngxué zhīqián bǎ xiě hǎo de Zhōngwén zuòyè jiāo shànglái.', 'Xin mời mọi người trước giờ tan học chiều mai nộp bài tập tiếng Trung đã làm xong lên.', 'basic', 1),
        (v_id, '在跨文化国际学术交流会议上，他结交了许多志同道合的海内外前沿学者并达成了多项科研合作意向。', 'Zài kuà-wénhuà guójì xuéshù jiāoliú huìyì shang, tā jiéjiāo le xǔduō zhìtóng-dàohé de hǎinèiwài qiányán xuézhě bìng dáchéng le duō xiàng kēyán hézuò yìxiàng.', 'Tại hội nghị giao lưu học thuật quốc tế đa văn hóa, anh ấy đã kết giao được với rất nhiều học giả tiên phong trong và ngoài nước cùng chung chí hướng và đạt được nhiều ý định hợp tác nghiên cứu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [骄傲] (jiāo’ào) - kiêu ngạo, tự đắc; tự hào, niềm hãnh diện [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '骄傲' AND pinyin = 'jiāo’ào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '骄傲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'jiāo’ào',
      meaning_vi = 'kiêu ngạo, tự đắc; tự hào, niềm hãnh diện',
      example_hanzi = '俗话说“虚心使人进步，骄傲使人落后”，我们要时刻保持谦虚。',
      example_pinyin = 'Súhuà shuō “xūxīn shǐ rén jìnbù, jiāo’ào shǐ rén luòhòu”, wǒmen yào shíkè bǎochí qiānxū.',
      example_vi = 'Tục ngữ có câu "Khiêm tốn giúp người ta tiến bộ, kiêu ngạo khiến người ta tụt lùi", chúng ta phải luôn giữ lòng khiêm tốn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '俗话说“虚心使人进步，骄傲使人落后”，我们要时刻保持谦虚。', 'Súhuà shuō “xūxīn shǐ rén jìnbù, jiāo’ào shǐ rén luòhòu”, wǒmen yào shíkè bǎochí qiānxū.', 'Tục ngữ có câu "Khiêm tốn giúp người ta tiến bộ, kiêu ngạo khiến người ta tụt lùi", chúng ta phải luôn giữ lòng khiêm tốn.', 'basic', 1),
        (v_id, '她代表国家在世界技能大赛中摘得金牌，不仅为全校师生争得了崇高荣誉，更是祖国和人民的骄傲。', 'Tā dàibiǎo guójiā zài Shìjiè Jìnéng Dàsài zhōng zhāi dé jīnpái, bùjǐn wèi quán xiào shīshēng zhēngdé le chónggāo róngyù, gèng shì zǔguó hé rénmín de jiāo’ào.', 'Cô ấy đại diện quốc gia giành huy chương vàng tại Đại hội Kỹ năng Thế giới, không những đem lại vinh dự cao quý cho thầy trò toàn trường, mà còn là niềm tự hào của tổ quốc và nhân dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [交警] (jiāojǐng) - cảnh sát giao thông (CSGT) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '交警' AND pinyin = 'jiāojǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '交警'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiāojǐng',
      meaning_vi = 'cảnh sát giao thông (CSGT)',
      example_hanzi = '十字路口的交通信号灯出了故障，交警正在现场指挥车辆有序通行。',
      example_pinyin = 'Shízìlùkǒu de jiāotōng xìnhàodēng chū le gùzhàng, jiāojǐng zhèngzài xiànchǎng zhǐhuī chēliàng yǒuxù tōngxíng.',
      example_vi = 'Đèn tín hiệu giao thông ở ngã tư bị trục trặc, cảnh sát giao thông đang có mặt trực tiếp tại hiện trường phân luồng xe cộ qua lại có trật tự.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '十字路口的交通信号灯出了故障，交警正在现场指挥车辆有序通行。', 'Shízìlùkǒu de jiāotōng xìnhàodēng chū le gùzhàng, jiāojǐng zhèngzài xiànchǎng zhǐhuī chēliàng yǒuxù tōngxíng.', 'Đèn tín hiệu giao thông ở ngã tư bị trục trặc, cảnh sát giao thông đang có mặt trực tiếp tại hiện trường phân luồng xe cộ qua lại có trật tự.', 'basic', 1),
        (v_id, '无论严寒酷暑还是暴雨倾盆，坚守在交通咽喉要道的交警始终恪尽职守，全力保障广大市民出行的道路畅通与交通安全。', 'Wúlùn yánhán-kùshǔ háishì bàoyǔ-qīngpén, jiānshǒu zài jiāotōng yānhóu yàodào de jiāojǐng shǐzhōng kèjìnzhíshǒu, quánlì bǎozhàng guǎngdà shìmín chūxíng de dàolù chàngtōng yǔ jiāotōng ānquán.', 'Bất kể giá rét gay gắt hay mưa to tầm tã, những người chiến sĩ cảnh sát giao thông kiên trì cắm chốt tại các tuyến đường huyết mạch luôn tận tụy với chức trách, dốc toàn lực bảo đảm đường xá thông suốt và an toàn giao thông cho đông đảo người dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [交流] (jiāoliú) - giao lưu, trao đổi [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '交流' AND pinyin = 'jiāoliú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '交流'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiāoliú',
      meaning_vi = 'giao lưu, trao đổi',
      example_hanzi = '多跟中文母语者面对面交流，是提高口语流利度的最好方法。',
      example_pinyin = 'Duō gēn Zhōngwén mǔyǔzhě miànduìmiàn jiāoliú, shì tígāo kǒuyǔ liúlìdù de zuì hǎo fāngfǎ.',
      example_vi = 'Giao tiếp mặt đối mặt nhiều với người bản ngữ tiếng Trung là phương pháp tốt nhất để nâng cao độ trôi chảy khẩu ngữ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '多跟中文母语者面对面交流，是提高口语流利度的最好方法。', 'Duō gēn Zhōngwén mǔyǔzhě miànduìmiàn jiāoliú, shì tígāo kǒuyǔ liúlìdù de zuì hǎo fāngfǎ.', 'Giao tiếp mặt đối mặt nhiều với người bản ngữ tiếng Trung là phương pháp tốt nhất để nâng cao độ trôi chảy khẩu ngữ.', 'basic', 1),
        (v_id, '“一带一路”国际合作高峰论坛为沿线国家提供了深化政策沟通、设施联通、贸易畅通与文化交流的高端国际多边平台。', '“Yídài Yílù” guójì hézuò gāofēng lùntán wèi yánxiàn guójiā tígōng le shēnhuà zhèngcè gōutōng, shèshī liántōng, màoyì chàngtōng yǔ wénhuà jiāoliú de gāoduān guójì duōbiān píngtái.', 'Diễn đàn cấp cao Hợp tác Quốc tế "Vành đai và Con đường" đã đem lại cho các quốc gia dọc tuyến một diễn đàn đa phương quốc tế cao cấp nhằm làm sâu sắc thêm việc kết nối chính sách, liên thông hạ tầng, thông suốt thương mại và giao lưu văn hóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [郊区] (jiāoqū) - vùng ngoại ô, ngoại thành [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '郊区' AND pinyin = 'jiāoqū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '郊区'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiāoqū',
      meaning_vi = 'vùng ngoại ô, ngoại thành',
      example_hanzi = '周末很多市民喜欢开车去环境优美的郊区农家乐体验田园生活。',
      example_pinyin = 'Zhōumò hěn duō shìmín xǐhuan kāichē qù huánjìng yōuměi de jiāoqū nóngjiālè tǐyàn tiányuán shēnghuó.',
      example_vi = 'Cuối tuần rất nhiều thị dân thích lái xe về vùng ngoại ô có môi trường tuyệt đẹp để trải nghiệm mô hình du lịch nông nghiệp làng quê sinh thái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末很多市民喜欢开车去环境优美的郊区农家乐体验田园生活。', 'Zhōumò hěn duō shìmín xǐhuan kāichē qù huánjìng yōuměi de jiāoqū nóngjiālè tǐyàn tiányuán shēnghuó.', 'Cuối tuần rất nhiều thị dân thích lái xe về vùng ngoại ô có môi trường tuyệt đẹp để trải nghiệm mô hình du lịch nông nghiệp làng quê sinh thái.', 'basic', 1),
        (v_id, '随着连接城市中心与偏远郊区的城际轨道交通网络全面贯通，郊区新型生态产业新城正成为吸纳高素质人才落户的生力军。', 'Suízhe liánjiē chéngshì zhōngxīn yǔ piānyuǎn jiāoqū de chéngjì guǐdào jiāotōng wǎngluò quánmiàn guàntōng, jiāoqū xīnxíng shēngtài chǎnyè xīnchéng zhèng chéngwéi xīnà gāosùzhì réncái luòhù de shēnglìjūn.', 'Cùng với việc thông xe toàn diện mạng lưới đường sắt đô thị kết nối trung tâm thành phố với vùng ngoại ô xa, khu đô thị công nghiệp sinh thái mới vùng ngoại ô đang trở thành lực lượng nòng cốt thu hút nhân tài chất lượng cao về an cư lập nghiệp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [交通] (jiāotōng) - giao thông, đi lại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '交通' AND pinyin = 'jiāotōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '交通'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiāotōng',
      meaning_vi = 'giao thông, đi lại',
      example_hanzi = '上下班早晚高峰期市中心的道路交通非常拥堵。',
      example_pinyin = 'Shàngxiàbān zǎowǎn gāofēngqī shìzhōngxīn de dàolù jiāotōng fēicháng yōngdǔ.',
      example_vi = 'Vào giờ cao điểm sáng tối lúc đi làm và tan sở, giao thông đường bộ trung tâm thành phố vô cùng ùn tắc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '上下班早晚高峰期市中心的道路交通非常拥堵。', 'Shàngxiàbān zǎowǎn gāofēngqī shìzhōngxīn de dàolù jiāotōng fēicháng yōngdǔ.', 'Vào giờ cao điểm sáng tối lúc đi làm và tan sở, giao thông đường bộ trung tâm thành phố vô cùng ùn tắc.', 'basic', 1),
        (v_id, '现代智慧城市建设通过融合人工智能与大数据算法，构建起能够根据实时车流自适应调节信号配时的智能交通指挥系统。', 'Xiàndài zhìhuì chéngshì jiànshè tōngguò rónghé réngōng zhìnéng yǔ dàshùjù suànfǎ, gòujiàn qǐ nénggòu gēnjù shíshí chēliú zìshìyìng tiáojié xìnhào pèishí de zhìnéng jiāotōng zhǐhuī xìtǒng.', 'Xây dựng đô thị thông minh hiện đại thông qua việc tích hợp trí tuệ nhân tạo và thuật toán dữ liệu lớn, đã thiết lập nên hệ thống điều khiển giao thông thông minh có khả năng tự động thích ứng điều chỉnh thời lượng đèn tín hiệu theo lưu lượng xe thực tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [教练] (jiàoliàn) - huấn luyện viên (HLV) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '教练' AND pinyin = 'jiàoliàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '教练'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiàoliàn',
      meaning_vi = 'huấn luyện viên (HLV)',
      example_hanzi = '游泳教练非常耐心地教初学者掌握换气的技巧。',
      example_pinyin = 'Yóuyǒng jiàoliàn fēicháng nàixīn de jiāo chūxuézhě zhǎngwò huànqì de jìqiǎo.',
      example_vi = 'Huấn luyện viên bơi lội rất kiên nhẫn dạy người mới học nắm vững kỹ năng lấy hơi đổi khí.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '游泳教练非常耐心地教初学者掌握换气的技巧。', 'Yóuyǒng jiàoliàn fēicháng nàixīn de jiāo chūxuézhě zhǎngwò huànqì de jìqiǎo.', 'Huấn luyện viên bơi lội rất kiên nhẫn dạy người mới học nắm vững kỹ năng lấy hơi đổi khí.', 'basic', 1),
        (v_id, '主教练在半场休息期间对球队的战术防守站位进行了针对性调整，最终带领全队在下半场上演了惊险大逆转。', 'Zhǔjiàoliàn zài bànchǎng xiūxi qījiān duì qiúduì de zhànshù fángshǒu zhànwèi jìnxíng le zhēnduìxìng tiáozhěng, zuìzhōng dàilǐng quánduì zài xiàbànchǎng shàngyǎn le jīngxiǎn dà nìzhuǎn.', 'Huấn luyện viên trưởng trong giờ nghỉ giữa hiệp đã điều chỉnh có mục tiêu vị trí đứng phòng ngự chiến thuật của toàn đội, cuối cùng dẫn dắt cả đội tạo nên cú lội ngược dòng ngoạn mục đầy kịch tính ở hiệp hai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [教师] (jiàoshī) - giáo viên, nhà giáo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '教师' AND pinyin = 'jiàoshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '教师'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiàoshī',
      meaning_vi = 'giáo viên, nhà giáo',
      example_hanzi = '每年九月十日是中国的教师节，同学们纷纷给老师送上鲜花与祝福。',
      example_pinyin = 'Měi nián jiǔ yuè shí rì shì Zhōngguó de Jiàoshījié, tóngxuémen fēnfēn gěi lǎoshī sòng shàng xiānhuā yǔ zhùfú.',
      example_vi = 'Ngày 10 tháng 9 hàng năm là ngày Nhà giáo Trung Quốc, các bạn học sinh đua nhau gửi tặng hoa tươi và lời chúc mừng tới thầy cô.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每年九月十日是中国的教师节，同学们纷纷给老师送上鲜花与祝福。', 'Měi nián jiǔ yuè shí rì shì Zhōngguó de Jiàoshījié, tóngxuémen fēnfēn gěi lǎoshī sòng shàng xiānhuā yǔ zhùfú.', 'Ngày 10 tháng 9 hàng năm là ngày Nhà giáo Trung Quốc, các bạn học sinh đua nhau gửi tặng hoa tươi và lời chúc mừng tới thầy cô.', 'basic', 1),
        (v_id, '人民教师不仅承担着传道受业解惑的崇高职责，更是引导青年学生树立远大理想与健全品格的人生筑梦导师。', 'Rénmín jiàoshī bùjǐn chéngdān zhe chuándào-shòuyè-jiěhuò de chónggāo zhízé, gèng shì yǐndǎo qīngnián xuésheng shùlì yuǎndà lǐxiǎng yǔ jiànquán pǐngé de rénshēng zhùmèng dǎoshī.', 'Người giáo viên nhân dân không chỉ gánh vác trọng trách cao cả truyền đạo dạy nghề giải đáp khúc mắc, mà còn là người thầy xây đắp ước mơ cuộc đời dẫn dắt các bạn trẻ xác lập lý tưởng cao xa và nhân cách toàn diện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [教授] (jiàoshòu) - giáo sư; giảng dạy [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '教授' AND pinyin = 'jiàoshòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '教授'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'jiàoshòu',
      meaning_vi = 'giáo sư; giảng dạy',
      example_hanzi = '李教授正在给研究生上一堂生动的古代汉语语法课。',
      example_pinyin = 'Lǐ jiàoshòu zhèngzài gěi yánjiūshēng shàng yí táng shēngdòng de gǔdài Hànyǔ yǔfǎ kè.',
      example_vi = 'Giáo sư Lý đang giảng cho các bạn học viên cao học một tiết học ngữ pháp tiếng Hán cổ đại rất sinh động.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '李教授正在给研究生上一堂生动的古代汉语语法课。', 'Lǐ jiàoshòu zhèngzài gěi yánjiūshēng shàng yí táng shēngdòng de gǔdài Hànyǔ yǔfǎ kè.', 'Giáo sư Lý đang giảng cho các bạn học viên cao học một tiết học ngữ pháp tiếng Hán cổ đại rất sinh động.', 'basic', 1),
        (v_id, '该终身特聘教授在国际顶级学术期刊发表了重磅论文，系统阐释了量子计算核心纠缠态控制的全新理论模型。', 'Gāi zhōngshēn tèpìn jiàoshòu zài guójì dǐngjí xuéshù qīkān fābiǎo le zhòngbàng lùnwén, xìtǒng chǎnshì le liàngzǐ jìsuàn héxīn jiūchántài kòngzhì de quánxīn lǐlùn móxíng.', 'Vị giáo sư đặc nhiệm trọn đời này đã công bố bài luận văn tầm cỡ trên tạp chí học thuật hàng đầu thế giới, giải thích một cách có hệ thống mô hình lý thuyết hoàn toàn mới về kiểm soát trạng thái vướng víu lượng tử cốt lõi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [教学] (jiàoxué) - giảng dạy, dạy học; việc dạy và học [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '教学' AND pinyin = 'jiàoxué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '教学'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'jiàoxué',
      meaning_vi = 'giảng dạy, dạy học; việc dạy và học',
      example_hanzi = '学校配备了非常先进的现代化多媒体数字教学设备。',
      example_pinyin = 'Xuéxiào pèibèi le fēicháng xiānjìn de xiàndàihuà duōméitǐ shùzì jiàoxué shèbèi.',
      example_vi = 'Nhà trường trang bị các thiết bị giảng dạy kỹ thuật số đa phương tiện hiện đại vô cùng tiên tiến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学校配备了非常先进的现代化多媒体数字教学设备。', 'Xuéxiào pèibèi le fēicháng xiānjìn de xiàndàihuà duōméitǐ shùzì jiàoxué shèbèi.', 'Nhà trường trang bị các thiết bị giảng dạy kỹ thuật số đa phương tiện hiện đại vô cùng tiên tiến.', 'basic', 1),
        (v_id, '高等教育改革强调以学生为中心，积极推动翻转课堂与人工智能辅助个性化教学模式的深度融合实践。', 'Gāoděng jiàoyù gǎigé qiángdiào yǐ xuésheng wéi zhōngxīn, jījí tuīdòng fānzhuǎn kètáng yǔ réngōng zhìnéng fùzhù gèxìnghuà jiàoxué móshì de shēndù rónghé shíjiàn.', 'Cải cách giáo dục đại học nhấn mạnh lấy học sinh làm trung tâm, tích cực thúc đẩy thực hành tích hợp sâu sắc mô hình lớp học đảo ngược và giảng dạy cá nhân hóa có trí tuệ nhân tạo hỗ trợ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [教育] (jiàoyù) - giáo dục; giáo dục bồi dưỡng [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '教育' AND pinyin = 'jiàoyù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '教育'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'jiàoyù',
      meaning_vi = 'giáo dục; giáo dục bồi dưỡng',
      example_hanzi = '父母非常重视孩子的早期启蒙教育和阅读习惯养成。',
      example_pinyin = 'Fùmǔ fēicháng zhòngshì háizi de zǎoqī qǐméng jiàoyù hé yuèdú xíguàn yǎngchéng.',
      example_vi = 'Cha mẹ vô cùng coi trọng việc giáo dục khai sáng thời thơ ấu và rèn luyện thói quen đọc sách cho con trẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '父母非常重视孩子的早期启蒙教育和阅读习惯养成。', 'Fùmǔ fēicháng zhòngshì háizi de zǎoqī qǐméng jiàoyù hé yuèdú xíguàn yǎngchéng.', 'Cha mẹ vô cùng coi trọng việc giáo dục khai sáng thời thơ ấu và rèn luyện thói quen đọc sách cho con trẻ.', 'basic', 1),
        (v_id, '百年大计，教育为本；持续加大国家财政性教育经费投入，是提升全民族综合素养与国家核心竞争力的根本大计。', 'Bǎinián dàjì, jiàoyù wéi běn; chíxù jiàdà guójiā cáizhèngxìng jiàoyù jīngfèi tóurù, shì tíshēng quán mínzú zōnghé sùyǎng yǔ guójiā héxīn jìngzhēnglì de gēnběn dàjì.', 'Kế sách trăm năm, giáo dục là gốc; liên tục tăng cường đầu tư kinh phí tài chính nhà nước cho giáo dục chính là kế sách căn bản để nâng cao tố chất tổng hợp của toàn dân tộc và sức cạnh tranh cốt lõi của quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [叫作] (jiàozuò) - gọi là, được gọi là [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '叫作' AND pinyin = 'jiàozuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '叫作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiàozuò',
      meaning_vi = 'gọi là, được gọi là',
      example_hanzi = '这种生活在长江流域的国家珍稀水生野生动物叫作中华鲟。',
      example_pinyin = 'Zhè zhǒng shēnghuó zài Cháng Jiāng liúyù de guójiā zhēnxī shuǐshēng yěshēng dòngwù jiàozuò Zhōnghuáxún.',
      example_vi = 'Loài động vật hoang dã thủy sinh quý hiếm cấp quốc gia sinh sống ở lưu vực sông Trường Giang này được gọi là cá tầm Trung Hoa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这种生活在长江流域的国家珍稀水生野生动物叫作中华鲟。', 'Zhè zhǒng shēnghuó zài Cháng Jiāng liúyù de guójiā zhēnxī shuǐshēng yěshēng dòngwù jiàozuò Zhōnghuáxún.', 'Loài động vật hoang dã thủy sinh quý hiếm cấp quốc gia sinh sống ở lưu vực sông Trường Giang này được gọi là cá tầm Trung Hoa.', 'basic', 1),
        (v_id, '在经济学理论体系中，当物价总水平出现持续且普遍性的大幅上涨时，这种宏观经济失衡现象通常被叫作通货膨胀。', 'Zài jīngjìxué lǐlùn tǐxì zhōng, dāng wùjià zǒng shuǐpíng chūxiàn chíxù qiě pǔbiànxìng de dàfú shàngzhǎng shí, zhè zhǒng hóngguān jīngjì shīhéng xiànxiàng tōngcháng bèi jiàozuò tōnghuò-péngzhàng.', 'Trong hệ thống lý thuyết kinh tế học, khi mặt bằng giá cả chung xuất hiện sự tăng vọt kéo dài và mang tính phổ biến, hiện tượng mất cân đối kinh tế vĩ mô này thường được gọi là lạm phát.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [街道] (jiēdào) - đường phố, phố xá; phường (đơn vị hành chính) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '街道' AND pinyin = 'jiēdào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '街道'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiēdào',
      meaning_vi = 'đường phố, phố xá; phường (đơn vị hành chính)',
      example_hanzi = '清晨的街道非常干净整洁，环卫工人正在认真清扫落叶。',
      example_pinyin = 'Qīngchén de jiēdào fēicháng gānjìng zhěngjié, huánwèi gōngrén zhèngzài rènzhēn qīngsǎo luòyè.',
      example_vi = 'Đường phố buổi sáng sớm vô cùng sạch sẽ ngăn nắp, công nhân vệ sinh môi trường đang chăm chú quét dọn lá rụng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清晨的街道非常干净整洁，环卫工人正在认真清扫落叶。', 'Qīngchén de jiēdào fēicháng gānjìng zhěngjié, huánwèi gōngrén zhèngzài rènzhēn qīngsǎo luòyè.', 'Đường phố buổi sáng sớm vô cùng sạch sẽ ngăn nắp, công nhân vệ sinh môi trường đang chăm chú quét dọn lá rụng.', 'basic', 1),
        (v_id, '基层街道办事处通过搭建社区网格化数字便民服务平台，极大打通了城市基层社会精细化治理的“最后一公里”。', 'Jīcéng jiēdào bànshìchù tōngguò dājiàn shèqū wǎnggéhuà shùzì biànmín fúwù píngtái, jí dà dǎtōng le chéngshì jīcéng shèhuì jīngxìhuà zhìlǐ de “zuìhòu yì gōnglǐ”.', 'Ủy ban nhân dân cấp phường cơ sở thông qua việc dựng nền tảng dịch vụ tiện dân kỹ thuật số hóa theo ô lưới cộng đồng, đã khai thông đáng kể "một cây số cuối cùng" của công tác quản trị tinh vi xã hội cấp cơ sở đô thị.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [接受] (jiēshòu) - tiếp nhận, tiếp thu, chấp nhận [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '接受' AND pinyin = 'jiēshòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '接受'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiēshòu',
      meaning_vi = 'tiếp nhận, tiếp thu, chấp nhận',
      example_hanzi = '他非常虚心地接受了老师和同学们提出的宝贵批评意见。',
      example_pinyin = 'Tā fēicháng xūxīn de jiēshòu le lǎoshī hé tóngxuémen tíchū de bǎoguì pīpíng yìjiàn.',
      example_vi = 'Cậu ấy hết sức khiêm tốn tiếp thu những ý kiến phê bình quý báu do thầy cô và các bạn đưa ra.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他非常虚心地接受了老师和同学们提出的宝贵批评意见。', 'Tā fēicháng xūxīn de jiēshòu le lǎoshī hé tóngxuémen tíchū de bǎoguì pīpíng yìjiàn.', 'Cậu ấy hết sức khiêm tốn tiếp thu những ý kiến phê bình quý báu do thầy cô và các bạn đưa ra.', 'basic', 1),
        (v_id, '在快速迭代的数字化转型浪潮中，企业必须敢于打破传统路径依赖，主动接受并拥抱人工智能带来的范式变革。', 'Zài kuàisù diédài de shùzìhuà zhuǎnxíng làngcháo zhōng, qǐyè bìxū gǎnyú dǎpò chuántǒng lùjìng yīlài, zhǔdòng jiēshòu bìng yōngbào réngōng zhìnéng dài lái de fànshì biàngé.', 'Giữa làn sóng chuyển đổi số thay đổi lặp lại nhanh chóng, doanh nghiệp phải dám phá vỡ sự phụ thuộc vào lối mòn truyền thống, chủ động đón nhận và mở rộng vòng tay đón nhận sự chuyển đổi mô hình do trí tuệ nhân tạo mang lại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [接着] (jiēzhe) - tiếp tục, tiếp theo đó; bắt lấy (vật ném tới) [Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '接着' AND pinyin = 'jiēzhe'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '接着'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Phó từ',
      pinyin = 'jiēzhe',
      meaning_vi = 'tiếp tục, tiếp theo đó; bắt lấy (vật ném tới)',
      example_hanzi = '大家先认真听老师讲解语法，接着再做练习题。',
      example_pinyin = 'Dàjiā xiān rènzhēn tīng lǎoshī jiǎngjiě yǔfǎ, jiēzhe zài zuò liànxítí.',
      example_vi = 'Mọi người hãy chăm chú nghe thầy giáo giảng giải ngữ pháp trước, tiếp theo đó mới làm bài tập luyện tập.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家先认真听老师讲解语法，接着再做练习题。', 'Dàjiā xiān rènzhēn tīng lǎoshī jiǎngjiě yǔfǎ, jiēzhe zài zuò liànxítí.', 'Mọi người hãy chăm chú nghe thầy giáo giảng giải ngữ pháp trước, tiếp theo đó mới làm bài tập luyện tập.', 'basic', 1),
        (v_id, '研发团队圆满攻克了核心芯片的底层架构设计难题，接着将紧锣密鼓地投入到第一代工程样片的封装流片测试中。', 'Yánfā tuánduì yuánmǎn gōngkè le héxīn xīnpiàn de dǐcéng jiàgòu shèjì nántí, jiēzhe jiāng jǐnluó-mìgǔ de tóurù dào dì-yī dài gōngchéng yàngpiàn de fēngzhuāng liúpiàn cèshì zhōng.', 'Đội ngũ R&D đã giải quyết viên mãn bài toán hóc búa thiết kế kiến trúc tầng đáy của chip cốt lõi, tiếp đó sẽ khẩn trương ráo riết dồn sức vào khâu thử nghiệm đóng gói và sản xuất mẫu chip thử nghiệm kỹ thuật thế hệ thứ nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [结果] (jiéguǒ) - kết quả; kết quả là, rốt cuộc [Danh từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '结果' AND pinyin = 'jiéguǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '结果'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Liên từ',
      pinyin = 'jiéguǒ',
      meaning_vi = 'kết quả; kết quả là, rốt cuộc',
      example_hanzi = '经过一个星期的焦急等待，体检结果终于出来了，指标一切正常。',
      example_pinyin = 'Jīngguò yí gè xīngqī de jiāojí děngdài, tǐjiǎn jiéguǒ zhōngyú chūlái le, zhǐbiāo yíqiè zhèngcháng.',
      example_vi = 'Trải qua một tuần chờ đợi lo âu, kết quả khám sức khỏe cuối cùng đã có rồi, các chỉ số đều hoàn toàn bình thường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过一个星期的焦急等待，体检结果终于出来了，指标一切正常。', 'Jīngguò yí gè xīngqī de jiāojí děngdài, tǐjiǎn jiéguǒ zhōngyú chūlái le, zhǐbiāo yíqiè zhèngcháng.', 'Trải qua một tuần chờ đợi lo âu, kết quả khám sức khỏe cuối cùng đã có rồi, các chỉ số đều hoàn toàn bình thường.', 'basic', 1),
        (v_id, '在激烈的市场竞争中，管理者既要紧盯最终的商业考核结果，更要全流程深度把控战略执行的质量与细节。', 'Zài jīliè de shìchǎng jìngzhēng zhōng, guǎnlǐzhě jì yào jǐndīng zuìzhōng de shāngyè kǎohé jiéguǒ, gèng yào quán liúchéng shēndù bǎkòng zhànlüè zhíxíng de zhìliàng yǔ xìjié.', 'Trong cuộc cạnh tranh thị trường khốc liệt, người quản lý vừa phải bám sát kết quả đánh giá thương mại cuối cùng, nhưng quan trọng hơn là phải kiểm soát sâu sắc toàn quy trình đối với chất lượng và chi tiết của việc thực thi chiến lược.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [节假日] (jiéjiàrì) - các ngày lễ tết, dịp nghỉ lễ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '节假日' AND pinyin = 'jiéjiàrì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '节假日'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jiéjiàrì',
      meaning_vi = 'các ngày lễ tết, dịp nghỉ lễ',
      example_hanzi = '每逢春节和国庆节等重大法定节假日，高速公路对小型客车免费通行。',
      example_pinyin = 'Měi féng Chūnjié hé Guóqìngjié děng zhòngdà fǎdìng jiéjiàrì, gāosù gōnglù duì xiǎoxíng kèchē miǎnfèi tōngxíng.',
      example_vi = 'Mỗi dịp nghỉ lễ tết theo luật định trọng đại như Tết Nguyên Đán và Quốc khánh, đường cao tốc miễn phí lưu thông cho xe chở khách cỡ nhỏ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每逢春节和国庆节等重大法定节假日，高速公路对小型客车免费通行。', 'Měi féng Chūnjié hé Guóqìngjié děng zhòngdà fǎdìng jiéjiàrì, gāosù gōnglù duì xiǎoxíng kèchē miǎnfèi tōngxíng.', 'Mỗi dịp nghỉ lễ tết theo luật định trọng đại như Tết Nguyên Đán và Quốc khánh, đường cao tốc miễn phí lưu thông cho xe chở khách cỡ nhỏ.', 'basic', 1),
        (v_id, '文旅消费在重大节假日期间呈现爆发式增长，有力带动了交通运输、餐饮住宿以及文博演艺等全产业链的繁荣复苏。', 'Wénlǚ xiāofèi zài zhòngdà jiéjiàrì qījiān chéngxiàn bàofāshì zēngzhǎng, yǒulì dàidòng le jiāotōng yùnshū, cānyǐn zhùsù yǐjí wénbó yǎnyì děng quán chǎnyèliàn de fánróng fùsū.', 'Tiêu dùng du lịch văn hóa trong các dịp nghỉ lễ tết lớn thể hiện mức tăng trưởng bùng nổ, thúc đẩy mạnh mẽ sự phục hồi phồn vinh của toàn bộ chuỗi ngành nghề từ giao thông vận tải, ăn uống lưu trú đến bảo tàng biểu diễn nghệ thuật.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [节约] (jiéyuē) - tiết kiệm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '节约' AND pinyin = 'jiéyuē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '节约'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiéyuē',
      meaning_vi = 'tiết kiệm',
      example_hanzi = '我们要从小养成节约用水、随手关灯的好习惯。',
      example_pinyin = 'Wǒmen yào cóngxiǎo yǎngchéng jiéyuē yòngshuǐ, suíshǒu guāndēng de hǎo xíguàn.',
      example_vi = 'Chúng ta cần từ nhỏ rèn luyện thói quen tốt tiết kiệm nước và thuận tay tắt đèn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们要从小养成节约用水、随手关灯的好习惯。', 'Wǒmen yào cóngxiǎo yǎngchéng jiéyuē yòngshuǐ, suíshǒu guāndēng de hǎo xíguàn.', 'Chúng ta cần từ nhỏ rèn luyện thói quen tốt tiết kiệm nước và thuận tay tắt đèn.', 'basic', 1),
        (v_id, '企业通过在全厂区推行数字化能源精细管理与余热循环利用系统，每年可为公司节约数百万元的电费开支。', 'Qǐyè tōngguò zài quán chǎngqū tuīxíng shùzìhuà néngyuán jīngxì guǎnlǐ yǔ yúrè xúnhuán lìyòng xìtǒng, měi nián kě wèi gōngsī jiéyuē shù bǎi wàn yuán de diànfèi kāizhī.', 'Doanh nghiệp thông qua việc áp dụng hệ thống quản lý tinh tế năng lượng số hóa và tái sử dụng tuần hoàn nhiệt dư trong toàn khu nhà máy, mỗi năm có thể tiết kiệm hàng triệu nhân dân tệ chi phí tiền điện cho công ty.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [结账] (jiézhàng) - thanh toán, tính tiền (bill) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '结账' AND pinyin = 'jiézhàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '结账'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiézhàng',
      meaning_vi = 'thanh toán, tính tiền (bill)',
      example_hanzi = '服务员，请问我们这一桌一共消费多少钱？我们要结账。',
      example_pinyin = 'Fúwùyuán, qǐngwèn wǒmen zhè yì zhuō yígòng xiāofèi duōshao qián? Wǒmen yào jiézhàng.',
      example_vi = 'Phục vụ ơi, xin hỏi bàn của chúng tôi tiêu hết tổng cộng bao nhiêu tiền? Chúng tôi muốn thanh toán hóa đơn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '服务员，请问我们这一桌一共消费多少钱？我们要结账。', 'Fúwùyuán, qǐngwèn wǒmen zhè yì zhuō yígòng xiāofèi duōshao qián? Wǒmen yào jiézhàng.', 'Phục vụ ơi, xin hỏi bàn của chúng tôi tiêu hết tổng cộng bao nhiêu tiền? Chúng tôi muốn thanh toán hóa đơn.', 'basic', 1),
        (v_id, '现代智慧零售商超普遍引入了无人自助结账通道和人脸识别支付系统，极大缩短了顾客在收银台前的排队等候时间。', 'Xiàndài zhìhuì língshòu shāngchāo pǔbiàn yǐnrù le wúrén zìzhù jiézhàng tōngdào hé rénliǎn shíbié zhīfù xìtǒng, jí dà suōduǎn le gùkè zài shōuyíntái qián de páiduì děnghòu shíjiān.', 'Các siêu thị bán lẻ thông minh hiện đại đã phổ biến đưa vào luồng thanh toán tự phục vụ không người và hệ thống thanh toán nhận diện khuôn mặt, rút ngắn đáng kể thời gian khách hàng phải xếp hàng chờ đợi trước quầy thu ngân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [解释] (jiěshì) - giải thích, phân trần; lời giải thích [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '解释' AND pinyin = 'jiěshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '解释'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiěshì',
      meaning_vi = 'giải thích, phân trần; lời giải thích',
      example_hanzi = '遇到双方有误会的时候，一定要心平气和地向对方解释清楚。',
      example_pinyin = 'Yù dào shuāngfāng yǒu wùhuì de shíhou, yídìng yào xīnpíng-qìhé de xiàng duìfāng jiěshì qīngchu.',
      example_vi = 'Khi gặp phải hiểu lầm giữa hai bên, nhất định phải bình tâm nhã nhặn giải thích rõ ràng cho đối phương hiểu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到双方有误会的时候，一定要心平气和地向对方解释清楚。', 'Yù dào shuāngfāng yǒu wùhuì de shíhou, yídìng yào xīnpíng-qìhé de xiàng duìfāng jiěshì qīngchu.', 'Khi gặp phải hiểu lầm giữa hai bên, nhất định phải bình tâm nhã nhặn giải thích rõ ràng cho đối phương hiểu.', 'basic', 1),
        (v_id, '研发总监在国际学术研讨会上，用详实严谨的实验对照数据对该新型抗癌药物的核心作用机理作出了令人信服的科学解释。', 'Yánfā zǒngjiān zài guójì xuéshù yántǎohuì shang, yòng xiángshí yánjǐn de shíyàn duìzhào shùjù duì gāi xīnxíng kàng’ái yàowù de héxīn zuòyòng jīlǐ zuò chū le lìng rén xìnfú de kēxué jiěshì.', 'Giám đốc R&D tại hội thảo học thuật quốc tế đã dùng các dữ liệu đối chứng thực nghiệm tường tận và chặt chẽ để đưa ra lời giải thích khoa học đầy tính thuyết phục về cơ chế tác dụng cốt lõi của loại thuốc chống ung thư kiểu mới này.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [今后] (jīnhòu) - từ nay về sau, trong tương lai [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '今后' AND pinyin = 'jīnhòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '今后'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jīnhòu',
      meaning_vi = 'từ nay về sau, trong tương lai',
      example_hanzi = '今后在工作中一定要更加细心谨慎，杜绝类似低级失误。',
      example_pinyin = 'Jīnhòu zài gōngzuò zhōng yídìng yào gèngjiā xìxīn jǐnshèn, dùjué lèisì dījī shīwù.',
      example_vi = 'Từ nay về sau trong công việc nhất định phải càng cẩn thận chu đáo hơn, triệt tiêu những sai sót ngớ ngẩn tương tự.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今后在工作中一定要更加细心谨慎，杜绝类似低级失误。', 'Jīnhòu zài gōngzuò zhōng yídìng yào gèngjiā xìxīn jǐnshèn, dùjué lèisì dījī shīwù.', 'Từ nay về sau trong công việc nhất định phải càng cẩn thận chu đáo hơn, triệt tiêu những sai sót ngớ ngẩn tương tự.', 'basic', 1),
        (v_id, '绿色低碳发展与人工智能深度赋能，将成为指导我国制造业今后十至十五年转型升级的重大战略方向。', 'Lǜsè dītàn fāzhǎn yǔ réngōng zhìnéng shēndù fùnéng, jiāng chéngwéi zhǐdǎo wǒ guó zhìzàoyè jīnhòu shí zhì shíwǔ nián zhuǎnxíng shēngjí de zhòngdà zhànlüè fāngxiàng.', 'Phát triển xanh ít phát thải carbon và trao quyền sâu sắc từ trí tuệ nhân tạo sẽ trở thành phương hướng chiến lược trọng đại dẫn dắt sự chuyển đổi nâng cấp của ngành chế tạo nước ta trong từ mười đến mười lăm năm tới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [仅] (jǐn) - chỉ, vẻn vẹn [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '仅' AND pinyin = 'jǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '仅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'jǐn',
      meaning_vi = 'chỉ, vẻn vẹn',
      example_hanzi = '他仅用了一个月的时间，就顺利通过了难度很高的中文水平考试。',
      example_pinyin = 'Tā jǐn yòng le yí gè yuè de shíjiān, jiù shùnlì tōngguò le nándù hěn gāo de Zhōngwén shuǐpíng kǎoshì.',
      example_vi = 'Anh ấy chỉ dùng thời gian vẻn vẹn một tháng đã vượt qua kỳ thi năng lực tiếng Trung có độ khó rất cao một cách thuận lợi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他仅用了一个月的时间，就顺利通过了难度很高的中文水平考试。', 'Tā jǐn yòng le yí gè yuè de shíjiān, jiù shùnlì tōngguò le nándù hěn gāo de Zhōngwén shuǐpíng kǎoshì.', 'Anh ấy chỉ dùng thời gian vẻn vẹn một tháng đã vượt qua kỳ thi năng lực tiếng Trung có độ khó rất cao một cách thuận lợi.', 'basic', 1),
        (v_id, '本次跨国峰会不仅聚焦于传统的双边经贸往来，更在绿色能源转型与数字安全标准等新兴前沿领域达成了多项突破性合作协议。', 'Běn cì kuàguó fēnghuì bùjǐn jiùjiāo yú chuántǒng de shuāngbiān jīngmào wǎnglái, gèng zài lǜsè néngyuán zhuǎnxíng yǔ shùzì ānquán biāozhǔn děng xīnxīng qiányán lǐngyù dáchéng le duō xiàng tūpòxìng hézuò xiéyì.', 'Hội nghị thượng đỉnh xuyên quốc gia lần này không chỉ hội tụ vào giao thương kinh tế thương mại song phương truyền thống, mà còn đạt được nhiều hiệp định hợp tác đột phá trong các lĩnh vực tiên phong mới nổi như chuyển đổi năng lượng xanh và tiêu chuẩn an toàn số.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [尽管] (jǐnguǎn) - cho dù, mặc dù; cứ việc, tha hồ [Liên từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '尽管' AND pinyin = 'jǐnguǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '尽管'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ / Phó từ',
      pinyin = 'jǐnguǎn',
      meaning_vi = 'cho dù, mặc dù; cứ việc, tha hồ',
      example_hanzi = '尽管外面下着瓢泼大雨，他依然准时赶到了会议室参加谈判。',
      example_pinyin = 'Jǐnguǎn wàimiàn xià zhe piáopō-dàyǔ, tā yīrán zhǔnshí gǎndào le huìyìshì cānjiā tánpàn.',
      example_vi = 'Mặc dù bên ngoài đang mưa to như trút, anh ấy vẫn đến phòng họp đúng giờ để tham gia đàm phán.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '尽管外面下着瓢泼大雨，他依然准时赶到了会议室参加谈判。', 'Jǐnguǎn wàimiàn xià zhe piáopō-dàyǔ, tā yīrán zhǔnshí gǎndào le huìyìshì cānjiā tánpàn.', 'Mặc dù bên ngoài đang mưa to như trút, anh ấy vẫn đến phòng họp đúng giờ để tham gia đàm phán.', 'basic', 1),
        (v_id, '如果有任何关于产品使用方法或售后技术维护的疑问，您尽管随时联系我们的二十四小时专家客服热线。', 'Rúguǒ yǒu rènhé guānyú chǎnpǐn shǐyòng fāngfǎ huò shòuhòu jìshù wéihù de yíwèn, nín jǐnguǎn suíshí liánxì wǒmen de èrshísì xiǎoshí zhuānjiā kèfù rèxiàn.', 'Nếu quý khách có bất kỳ thắc mắc nào về phương pháp sử dụng sản phẩm hay bảo dưỡng kỹ thuật hậu mãi, quý khách cứ việc liên hệ bất cứ lúc nào với đường dây nóng chăm sóc khách hàng chuyên gia 24/24 của chúng tôi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [仅仅] (jǐnjǐn) - chỉ, chỉ vỏn vẹn, duy chỉ [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '仅仅' AND pinyin = 'jǐnjǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '仅仅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'jǐnjǐn',
      meaning_vi = 'chỉ, chỉ vỏn vẹn, duy chỉ',
      example_hanzi = '学习语言仅仅停留在书本上是不够的，必须在现实生活中勤加练习。',
      example_pinyin = 'Xuéxí yǔyán jǐnjǐn tíngliú zài shūběn shang shì bú gòu de, bìxū zài xiànshí shēnghuó zhōng qín jiā liànxí.',
      example_vi = 'Học tập ngôn ngữ chỉ dừng lại trên sách vở là không đủ, bắt buộc phải chăm chỉ luyện tập trong đời sống thực tế.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学习语言仅仅停留在书本上是不够的，必须在现实生活中勤加练习。', 'Xuéxí yǔyán jǐnjǐn tíngliú zài shūběn shang shì bú gòu de, bìxū zài xiànshí shēnghuó zhōng qín jiā liànxí.', 'Học tập ngôn ngữ chỉ dừng lại trên sách vở là không đủ, bắt buộc phải chăm chỉ luyện tập trong đời sống thực tế.', 'basic', 1),
        (v_id, '企业的长期核心竞争力绝不仅仅取决于短期的营销宣传噱头，更深层依赖于过硬的技术自主研发实力与卓越的产品品质。', 'Qǐyè de chángqī héxīn jìngzhēnglì jué jǐnjǐn qǔjué yú duǎnqī de yíngxiāo xuānchuán xuètóu, gèng shēncéng yīlài yú guòyìng de jìshù zìzhǔ yánfā shílì yǔ zhuóyuè de chǎnpǐn pǐnzhì.', 'Sức cạnh tranh cốt lõi lâu dài của doanh nghiệp tuyệt đối không chỉ phụ thuộc vào những chiêu trò tuyên truyền tiếp thị ngắn hạn, mà phụ thuộc sâu sắc hơn vào thực lực tự chủ R&D công nghệ vững vàng và chất lượng sản phẩm vượt trội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [紧张] (jǐnzhāng) - căng thẳng, hồi hộp; khan hiếm (tài nguyên, thời gian) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '紧张' AND pinyin = 'jǐnzhāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '紧张'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'jǐnzhāng',
      meaning_vi = 'căng thẳng, hồi hộp; khan hiếm (tài nguyên, thời gian)',
      example_hanzi = '上台参加演讲比赛之前，他的手心里全是汗，心里非常紧张。',
      example_pinyin = 'Shàngtái cānjiā yǎnjiǎng bǐsài zhīqián, tā de shǒuxīn lǐ quán shì hàn, xīnlǐ fēicháng jǐnzhāng.',
      example_vi = 'Trước khi bước lên sân khấu tham gia cuộc thi diễn thuyết, lòng bàn tay cậu ấy ướt đẫm mồ hôi, trong lòng vô cùng căng thẳng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '上台参加演讲比赛之前，他的手心里全是汗，心里非常紧张。', 'Shàngtái cānjiā yǎnjiǎng bǐsài zhīqián, tā de shǒuxīn lǐ quán shì hàn, xīnlǐ fēicháng jǐnzhāng.', 'Trước khi bước lên sân khấu tham gia cuộc thi diễn thuyết, lòng bàn tay cậu ấy ướt đẫm mồ hôi, trong lòng vô cùng căng thẳng.', 'basic', 1),
        (v_id, '春运期间全国跨省客运火车票源极其紧张，铁路运营部门全面增开了多趟夜间动车组列车以保障广大旅客顺利返乡。', 'Chūnyùn qījiān quánguó kuàshěng kèyùn huǒchē piàoyuán jíqí jǐnzhāng, tiělù yùnyíng bùmén quánmiàn zēngkāi le duō tàng yèjiān dòngchēzǔ lièchē yǐ bǎozhàng guǎngdà lǚkè shùnlì fǎnxiāng.', 'Vào đợt cao điểm đi lại dịp Tết nguồn vé tàu chở khách liên tỉnh trên toàn quốc cực kỳ khan hiếm căng thẳng, ngành vận tải đường sắt đã cho tăng cường thêm nhiều chuyến tàu động lực cao tốc đêm để đảm bảo hành khách về quê thuận lợi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [进入] (jìnrù) - bước vào, đi vào, tiến vào [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '进入' AND pinyin = 'jìnrù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '进入'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jìnrù',
      meaning_vi = 'bước vào, đi vào, tiến vào',
      example_hanzi = '进入图书馆和自习室后，请自觉将手机调成静音状态。',
      example_pinyin = 'Jìnrù túshūguǎn hé zìxíshì hòu, qǐng zìjué jiāng shǒujī tiáo chéng jìngyīn zhuàngtài.',
      example_vi = 'Sau khi bước vào thư viện và phòng tự học, xin tự giác chuyển điện thoại sang chế độ im lặng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '进入图书馆和自习室后，请自觉将手机调成静音状态。', 'Jìnrù túshūguǎn hé zìxíshì hòu, qǐng zìjué jiāng shǒujī tiáo chéng jìngyīn zhuàngtài.', 'Sau khi bước vào thư viện và phòng tự học, xin tự giác chuyển điện thoại sang chế độ im lặng.', 'basic', 1),
        (v_id, '随着新一轮人工智能与生成式大模型的爆发式发展，全球数字化经济已经全面进入了深度重塑传统行业格局的全新阶段。', 'Suízhe xīn yì lún réngōng zhìnéng yǔ shēngchéngxìng dà móxíng de bàofāshì fāzhǎn, quánqiú shùzìhuà jīngjì yǐjīng quánmiàn jìnrù le shēndù chóngsù chuántǒng hángyè géjú de quánxīn jiēduàn.', 'Cùng với sự phát triển bùng nổ của làn sóng trí tuệ nhân tạo và mô hình lớn tạo sinh thế hệ mới, nền kinh tế số hóa toàn cầu đã bước vào giai đoạn hoàn toàn mới tái định hình sâu rộng cục diện các ngành truyền thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [进行] (jìnxíng) - tiến hành, thực hiện [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '进行' AND pinyin = 'jìnxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '进行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jìnxíng',
      meaning_vi = 'tiến hành, thực hiện',
      example_hanzi = '双方商务代表正在会议室里就合同细节进行深入友好的磋商。',
      example_pinyin = 'Shuāngfāng shāngwù dàibiǎo zhèngzài huìyìshì lǐ jiù hétong xìjié jìnxíng shēnrù yǒuhǎo de cuōshāng.',
      example_vi = 'Đại diện thương mại hai bên đang tiến hành thương lượng sâu sắc thân thiện về các điều khoản chi tiết của hợp đồng trong phòng họp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '双方商务代表正在会议室里就合同细节进行深入友好的磋商。', 'Shuāngfāng shāngwù dàibiǎo zhèngzài huìyìshì lǐ jiù hétong xìjié jìnxíng shēnrù yǒuhǎo de cuōshāng.', 'Đại diện thương mại hai bên đang tiến hành thương lượng sâu sắc thân thiện về các điều khoản chi tiết của hợp đồng trong phòng họp.', 'basic', 1),
        (v_id, '针对近期线上金融系统暴露出的一起数据异常安全隐患，技术安全专家委员会正在进行全天候全方位深度技术排查。', 'Zhēnduì jìnqī xiànshàng jīnróng xìtǒng bàolù chū de yì qǐ shùjù yìcháng ānquán yǐnhuàn, jìshù ānquán zhuānjiā wěiyuánhuì zhèngzài jìnxíng quántiānhòu quánfāngwèi shēndù jìshù páichá.', 'Nhằm vào một nguy cơ tiềm ẩn mất an toàn dữ liệu bất thường lộ ra gần đây trên hệ thống tài chính trực tuyến, ủy ban chuyên gia an toàn kỹ thuật đang tiến hành rà soát kỹ thuật chuyên sâu toàn diện suốt ngày đêm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [禁止] (jìnzhǐ) - nghiêm cấm, cấm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '禁止' AND pinyin = 'jìnzhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '禁止'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jìnzhǐ',
      meaning_vi = 'nghiêm cấm, cấm',
      example_hanzi = '加油站内严禁使用明火，严禁在站内拨打手机。',
      example_pinyin = 'Jiāyóuzhàn nèi yánjìn shǐyòng mínghuǒ, yánjìn zài zhàn nèi bōdǎ shǒujī.',
      example_vi = 'Bên trong trạm xăng nghiêm cấm sử dụng lửa trần, nghiêm cấm nghe gọi điện thoại di động trong khu vực trạm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '加油站内严禁使用明火，严禁在站内拨打手机。', 'Jiāyóuzhàn nèi yánjìn shǐyòng mínghuǒ, yánjìn zài zhàn nèi bōdǎ shǒujī.', 'Bên trong trạm xăng nghiêm cấm sử dụng lửa trần, nghiêm cấm nghe gọi điện thoại di động trong khu vực trạm.', 'basic', 1),
        (v_id, '国家证券法律法规明令禁止任何金融机构及其从业人员利用未公开内幕信息从事股票内幕交易活动。', 'Guójiā zhèngquàn fǎlǜ fǎguī mínglìng jìnzhǐ rènhé jīnróng jīgòu jí qí cóngyè rényuán lìyòng wèigōngkāi nèimù xìnxī cóngshì gǔpiào nèimù jiāoyì huódòng.', 'Các quy định pháp luật chứng khoán quốc gia ban lệnh nghiêm cấm bất kỳ tổ chức tài chính và nhân viên hành nghề nào lợi dụng thông tin nội gián chưa công khai để tiến hành hoạt động giao dịch nội gián cổ phiếu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [精彩] (jīngcǎi) - đặc sắc, xuất sắc, tuyệt vời [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '精彩' AND pinyin = 'jīngcǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '精彩'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'jīngcǎi',
      meaning_vi = 'đặc sắc, xuất sắc, tuyệt vời',
      example_hanzi = '昨晚两支顶级强队的足球决赛踢得极其精彩，令球迷们大呼过瘾。',
      example_pinyin = 'Zuówǎn liǎng zhī dǐngjí qiángduì de zúqiú juésài tī de jíqí jīngcǎi, lìng qiúmǐmen dà hū guòyǐn.',
      example_vi = 'Trận chung kết bóng đá tối qua giữa hai đội tuyển hàng đầu đá vô cùng đặc sắc, khiến người hâm mộ không khỏi trầm trồ thỏa mãn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '昨晚两支顶级强队的足球决赛踢得极其精彩，令球迷们大呼过瘾。', 'Zuówǎn liǎng zhī dǐngjí qiángduì de zúqiú juésài tī de jíqí jīngcǎi, lìng qiúmǐmen dà hū guòyǐn.', 'Trận chung kết bóng đá tối qua giữa hai đội tuyển hàng đầu đá vô cùng đặc sắc, khiến người hâm mộ không khỏi trầm trồ thỏa mãn.', 'basic', 1),
        (v_id, '著名经济学家在国际论坛上发表了一场高屋建瓴、见解深刻的精彩学术演讲，引发了与会各界专家的强烈共鸣与热烈讨论。', 'Zhùmíng jīngjìxuéjiā zài guójì lùntán shang fābiǎo le yì chǎng gāowū-jiànlíng, jiànjiě shēnkè de jīngcǎi xuéshù yǎnjiǎng, yǐnfā le yùhuì gèjiè zhuānjiā de qiángliè gòngmíng yǔ rèliè tǎolùn.', 'Nhà kinh tế học nổi tiếng tại diễn đàn quốc tế đã có một bài phát biểu học thuật xuất sắc với tầm nhìn bao quát và nhận định sâu sắc, dấy lên sự đồng cảm mạnh mẽ và thảo luận sôi nổi từ giới chuyên gia các ngành tham dự.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [经济] (jīngjì) - kinh tế; tiết kiệm, kinh tế [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '经济' AND pinyin = 'jīngjì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '经济'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Tính từ',
      pinyin = 'jīngjì',
      meaning_vi = 'kinh tế; tiết kiệm, kinh tế',
      example_hanzi = '这座海滨城市近年来对外贸易非常繁荣，当地经济发展十分迅速。',
      example_pinyin = 'Zhè zuò hǎibīn chéngshì jìnniánlái duìwài màoyì fēicháng fánróng, dāngdì jīngjì fāzhǎn shífēn xùnsù.',
      example_vi = 'Thành phố ven biển này những năm gần đây ngoại thương vô cùng phồn thịnh, kinh tế địa phương phát triển rất mau chóng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这座海滨城市近年来对外贸易非常繁荣，当地经济发展十分迅速。', 'Zhè zuò hǎibīn chéngshì jìnniánlái duìwài màoyì fēicháng fánróng, dāngdì jīngjì fāzhǎn shífēn xùnsù.', 'Thành phố ven biển này những năm gần đây ngoại thương vô cùng phồn thịnh, kinh tế địa phương phát triển rất mau chóng.', 'basic', 1),
        (v_id, '面对复杂严峻的全球宏观经济下行压力，国家坚持实施积极的财政政策和稳健的货币政策，着力激发实体经济微观市场主体的活力。', 'Miànduì fùzá yánjùn de quánqiú hóngguān jīngjì xiàxíng yālì, guójiā jiānchí shíshī jījí de cáizhèng zhèngcè hé wěnjiàn de huòbì zhèngcè, zhuólì jīfā shítǐ jīngjì wēiguān shìchǎng zhǔtǐ de huólì.', 'Đối mặt với áp lực suy giảm kinh tế vĩ mô toàn cầu phức tạp và gay gắt, nhà nước kiên trì thực thi chính sách tài khóa tích cực và chính sách tiền tệ vững chắc, chú trọng khơi dậy sức sống cho các chủ thể thị trường vi mô của nền kinh tế thực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [京剧] (jīngjù) - Kinh kịch (nghệ thuật sân khấu truyền thống Bắc Kinh) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '京剧' AND pinyin = 'jīngjù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '京剧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jīngjù',
      meaning_vi = 'Kinh kịch (nghệ thuật sân khấu truyền thống Bắc Kinh)',
      example_hanzi = '京剧被誉为中国的“国粹”，拥有两百多年的悠久历史。',
      example_pinyin = 'Jīngjù bèi yù wéi Zhōngguó de “guócuì”, yōngyǒu liǎng bǎi duō nián de yōujiǔ lìshǐ.',
      example_vi = 'Kinh kịch được ca ngợi là "quốc hồn quốc túy" của Trung Quốc, sở hữu bề dày lịch sử hơn 200 năm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '京剧被誉为中国的“国粹”，拥有两百多年的悠久历史。', 'Jīngjù bèi yù wéi Zhōngguó de “guócuì”, yōngyǒu liǎng bǎi duō nián de yōujiǔ lìshǐ.', 'Kinh kịch được ca ngợi là "quốc hồn quốc túy" của Trung Quốc, sở hữu bề dày lịch sử hơn 200 năm.', 'basic', 1),
        (v_id, '梅兰芳等京剧艺术大师通过独特的唱念做打艺术表演体系，将中国传统戏曲美学的写意神韵推向了世界艺术舞台的高峰。', 'Méi Lánfāng děng Jīngjù yìshù dàshī tōngguò dútè de chàng-niàn-zuò-dǎ yìshù biǎoyǎn tǐxì, jiāng Zhōngguó chuántǒng xìqǔ měixué de xièyì shényùn tuī xiàng le shìjiè yìshù wǔtái de gāofēng.', 'Các đại sư nghệ thuật Kinh kịch như Mai Lan Phương thông qua hệ thống biểu diễn nghệ thuật xướng niệm tác đả độc đáo, đã đưa cái thần tả ý của mỹ học hý kịch truyền thống Trung Hoa lên tới đỉnh cao của vũ đài nghệ thuật thế giới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [经历] (jīnglì) - trải qua, từng trải; trải nghiệm, quá trình từng trải [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '经历' AND pinyin = 'jīnglì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '经历'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'jīnglì',
      meaning_vi = 'trải qua, từng trải; trải nghiệm, quá trình từng trải',
      example_hanzi = '他在年轻时曾有过在偏远乡村支教两年的宝贵人生经历。',
      example_pinyin = 'Tā zài niánqīng shí céng yǒuguò zài piānyuǎn xiāngcūn zhījiào liǎng nián de bǎoguì rénshēng jīnglì.',
      example_vi = 'Thời trẻ anh ấy từng có trải nghiệm cuộc đời quý báu hai năm đi dạy học tình nguyện tại một vùng nông thôn xa xôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在年轻时曾有过在偏远乡村支教两年的宝贵人生经历。', 'Tā zài niánqīng shí céng yǒuguò zài piānyuǎn xiāngcūn zhījiào liǎng nián de bǎoguì rénshēng jīnglì.', 'Thời trẻ anh ấy từng có trải nghiệm cuộc đời quý báu hai năm đi dạy học tình nguyện tại một vùng nông thôn xa xôi.', 'basic', 1),
        (v_id, '唯有经历过狂风暴雨的残酷洗礼，一个企业才能在动荡不安的现代商业市场中锻造出百折不挠的抗风险韧性。', 'Wéiyǒu jīnglì guò kuángfēng-bàoyǔ de cánkù xǐlǐ, yí gè qǐyè cái néng zài dòngdàng-bù’ān de xiàndài shāngyè shìchǎng zhōng duànzào chū bǎizhé-bùnáo de kàng-fēngxiǎn rènxìng.', 'Chỉ khi trải qua sự thanh lọc tàn khốc của mưa gió bão bùng, một doanh nghiệp mới có thể tôi luyện nên sức bền chống chọi rủi ro kiên cường bất khuất trong thị trường thương mại hiện đại đầy biến động bất an.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [经验] (jīngyàn) - kinh nghiệm, kỹ năng từng trải [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '经验' AND pinyin = 'jīngyàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '经验'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jīngyàn',
      meaning_vi = 'kinh nghiệm, kỹ năng từng trải',
      example_hanzi = '李工程师在机械制造领域工作了三十年，积累了非常丰富的实践经验。',
      example_pinyin = 'Lǐ gōngchéngshī zài jīxiè zhìzào lǐngyù gōngzuò le sānshí nián, jīlěi le fēicháng fēngfù de shíjiàn jīngyàn.',
      example_vi = 'Kỹ sư Lý đã làm việc ba mươi năm trong lĩnh vực chế tạo cơ khí, tích lũy được kinh nghiệm thực hành vô cùng phong phú.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '李工程师在机械制造领域工作了三十年，积累了非常丰富的实践经验。', 'Lǐ gōngchéngshī zài jīxiè zhìzào lǐngyù gōngzuò le sānshí nián, jīlěi le fēicháng fēngfù de shíjiàn jīngyàn.', 'Kỹ sư Lý đã làm việc ba mươi năm trong lĩnh vực chế tạo cơ khí, tích lũy được kinh nghiệm thực hành vô cùng phong phú.', 'basic', 1),
        (v_id, '在快速变化的高科技产业中，青年创业者既要虚心学习吸收行业前辈的宝贵成功经验，更要勇于打破固有经验主义的思维桎梏。', 'Zài kuàisù biànhuà de gāokējì chǎnyè zhōng, qīngnián chuàngyèzhě jì yào xūxīn xuéxí xīshōu hángyè qiánbèi de bǎoguì chénggōng jīngyàn, gèng yào yǒngyú dǎpò gùyǒu jīngyànzhǔyì de sīwéi zhìgù.', 'Trong ngành công nghệ cao biến đổi mau lẹ, các nhà khởi nghiệp trẻ vừa cần khiêm tốn học hỏi tiếp thu kinh nghiệm thành công quý giá của các bậc tiền bối trong ngành, nhưng càng phải dũng cảm phá vỡ gông cùm tư duy chủ nghĩa kinh nghiệm cố hữu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [警察] (jǐngchá) - cảnh sát, công an [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '警察' AND pinyin = 'jǐngchá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '警察'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jǐngchá',
      meaning_vi = 'cảnh sát, công an',
      example_hanzi = '遇到任何紧急突发危险情况，请第一时间拨打110报警电话联系警察。',
      example_pinyin = 'Yù dào rènhé jǐnjí tūfā wēixiǎn qíngkuàng, qǐng dì-yī shíjiān bōdǎ yāoyāolíng bàojǐng diànhuà liánxì jǐngchá.',
      example_vi = 'Gặp bất kỳ tình huống nguy hiểm khẩn cấp bất ngờ nào, xin vui lòng gọi ngay lập tức tới số điện thoại báo án 110 để liên hệ với cảnh sát.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到任何紧急突发危险情况，请第一时间拨打110报警电话联系警察。', 'Yù dào rènhé jǐnjí tūfā wēixiǎn qíngkuàng, qǐng dì-yī shíjiān bōdǎ yāoyāolíng bàojǐng diànhuà liánxì jǐngchá.', 'Gặp bất kỳ tình huống nguy hiểm khẩn cấp bất ngờ nào, xin vui lòng gọi ngay lập tức tới số điện thoại báo án 110 để liên hệ với cảnh sát.', 'basic', 1),
        (v_id, '人民警察日夜巡逻坚守在城市社区和偏远国境线上，用忠诚担当与无私奉献默默守护着社会的和谐安宁与万家灯火。', 'Rénmín jǐngchá rìyè xúnluó jiānshǒu zài chéngshì shèqū hé piānyuǎn guójìngxiàn shang, yòng zhōngchéng dāndāng yǔ wúsī fèngxiàn mòmò shǒuhù zhe shèhuì de héxié ānníng yǔ wànjiādēnghuǒ.', 'Lực lượng Cảnh sát nhân dân ngày đêm tuần tra túc trực nơi các khu phố đô thị và tuyến biên giới xa xôi, dùng tinh thần trung thành trách nhiệm và cống hiến quên mình thầm lặng bảo vệ sự bình yên hòa hợp của xã hội và ánh sáng ấm áp nơi vạn mái ấm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 4: #1301 -> #1400)!', v_count;
END $$;
