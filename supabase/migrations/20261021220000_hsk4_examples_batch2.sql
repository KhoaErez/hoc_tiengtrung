-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 4 - BATCH 2 (100 TỪ)
-- Phạm vi: #1101 [此外] (cǐwài) -> #1200 [费用] (fèiyong)
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
  -- [此外] (cǐwài) - ngoài ra, hơn nữa [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '此外' AND pinyin = 'cǐwài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '此外'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'cǐwài',
      meaning_vi = 'ngoài ra, hơn nữa',
      example_hanzi = '他精通英语，此外还会说一些日常法语。',
      example_pinyin = 'Tā jīngtōng Yīngyǔ, cǐwài hái huì shuō yìxiē rìcháng Fǎyǔ.',
      example_vi = 'Anh ấy thông thạo tiếng Anh, ngoài ra còn biết nói một chút tiếng Pháp giao tiếp hàng ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他精通英语，此外还会说一些日常法语。', 'Tā jīngtōng Yīngyǔ, cǐwài hái huì shuō yìxiē rìcháng Fǎyǔ.', 'Anh ấy thông thạo tiếng Anh, ngoài ra còn biết nói một chút tiếng Pháp giao tiếp hàng ngày.', 'basic', 1),
        (v_id, '这份合作方案不仅能大幅削减运营成本，此外还能有效提高团队的跨部门协作效率。', 'Zhè fèn hézuò fāng’àn bùjǐn néng dàfú xuējiǎn yùnyíng chéngběn, cǐwài hái néng yǒuxiào tígāo tuánduì de kuà-bùmén xiézuò xiàolǜ.', 'Phương án hợp tác này không chỉ cắt giảm đáng kể chi phí vận hành, ngoài ra còn nâng cao hiệu quả phối hợp liên phòng ban của đội ngũ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [从此] (cóngcǐ) - từ đó, từ nay về sau [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '从此' AND pinyin = 'cóngcǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '从此'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'cóngcǐ',
      meaning_vi = 'từ đó, từ nay về sau',
      example_hanzi = '大学毕业后他留在了上海工作，从此定居在这座现代化大都市。',
      example_pinyin = 'Dàxué bìyè hòu tā liú zài le Shànghǎi gōngzuò, cóngcǐ dìngjū zài zhè zuò xiàndàihuà dà dūshì.',
      example_vi = 'Sau khi tốt nghiệp đại học anh ấy ở lại Thượng Hải làm việc, từ đó định cư tại đô thị hiện đại này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大学毕业后他留在了上海工作，从此定居在这座现代化大都市。', 'Dàxué bìyè hòu tā liú zài le Shànghǎi gōngzuò, cóngcǐ dìngjū zài zhè zuò xiàndàihuà dà dūshì.', 'Sau khi tốt nghiệp đại học anh ấy ở lại Thượng Hải làm việc, từ đó định cư tại đô thị hiện đại này.', 'basic', 1),
        (v_id, '经历了那次惨痛的失败教训，他从此痛定思痛，做事变得格外严谨谨慎。', 'Jīnglì le nà cì cǎntòng de shībài jiàoxùn, tā cóngcǐ tòngdìng-sītòng, zuò shì biàn de géwài yánjǐn jǐnshèn.', 'Trải qua bài học thất bại cay đắng lần đó, từ đó về sau anh ấy rút kinh nghiệm sâu sắc, làm việc trở nên vô cùng cẩn trọng chu đáo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [从来] (cónglái) - từ trước đến nay, luôn luôn [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '从来' AND pinyin = 'cónglái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '从来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'cónglái',
      meaning_vi = 'từ trước đến nay, luôn luôn',
      example_hanzi = '他对待工作一向认真负责，从来不迟到早退。',
      example_pinyin = 'Tā duìdài gōngzuò yíxiàng rènzhēn fùzé, cónglái bù chídào zǎotuì.',
      example_vi = 'Anh ấy đối với công việc luôn nghiêm túc có trách nhiệm, từ trước đến nay không hề đi muộn về sớm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他对待工作一向认真负责，从来不迟到早退。', 'Tā duìdài gōngzuò yíxiàng rènzhēn fùzé, cónglái bù chídào zǎotuì.', 'Anh ấy đối với công việc luôn nghiêm túc có trách nhiệm, từ trước đến nay không hề đi muộn về sớm.', 'basic', 1),
        (v_id, '真正的成功从来不是一蹴而就的，它需要长年累月的坚持不懈与默默积累。', 'Zhēnzhèng de chénggōng cónglái bú shì yícù’érjiù de, tā xūyào chángnián-lěiyuè de jiānchí-búxiè yǔ mòmò jīlěi.', 'Thành công thực sự từ trước tới nay không bao giờ đạt được trong một sớm một chiều, nó đòi hỏi sự kiên trì bền bỉ và tích lũy âm thầm qua năm tháng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [从中] (cóngzhōng) - từ đó, trong đó [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '从中' AND pinyin = 'cóngzhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '从中'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'cóngzhōng',
      meaning_vi = 'từ đó, trong đó',
      example_hanzi = '阅读优秀文学作品不仅能开阔眼界，更能让我们从中汲取丰富的人生智慧。',
      example_pinyin = 'Yuèdú yōuxiù wénxué zuòpǐn bùjǐn néng kāikuò yǎnjiè, gèng néng ràng wǒmen cóngzhōng jíqǔ fēngfù de rénshēng zhìhuì.',
      example_vi = 'Đọc các tác phẩm văn học ưu tú không chỉ mở rộng tầm mắt mà còn giúp chúng ta tiếp thu được trí tuệ nhân sinh phong phú từ trong đó.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '阅读优秀文学作品不仅能开阔眼界，更能让我们从中汲取丰富的人生智慧。', 'Yuèdú yōuxiù wénxué zuòpǐn bùjǐn néng kāikuò yǎnjiè, gèng néng ràng wǒmen cóngzhōng jíqǔ fēngfù de rénshēng zhìhuì.', 'Đọc các tác phẩm văn học ưu tú không chỉ mở rộng tầm mắt mà còn giúp chúng ta tiếp thu được trí tuệ nhân sinh phong phú từ trong đó.', 'basic', 1),
        (v_id, '善于在复盘中总结失败的原因，并从中找到破局之策，是优秀管理者必备的素养。', 'Shànyú zài fùpán zhōng zǒngjié shībài de yuányīn, bìng cóngzhōng zhǎodào pòjú zhī cè, shì yōuxiù guǎnlǐzhě bìbèi de sùyǎng.', 'Biết tổng kết nguyên nhân thất bại sau mỗi lần nhìn nhận lại và tìm ra sách lược khai thông từ đó là tố chất cần có của nhà quản lý xuất sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [粗] (cū) - thô, to, dày, vụng về [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '粗' AND pinyin = 'cū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '粗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'cū',
      meaning_vi = 'thô, to, dày, vụng về',
      example_hanzi = '院子里那棵参天大树的树干非常粗，两个人才能勉强合抱过来。',
      example_pinyin = 'Yuànzi lǐ nà kē cāntiān dàshù de shùgàn fēicháng cū, liǎng gè rén cái néng miǎnqiǎng hébào guòlái.',
      example_vi = 'Thân cây đại thụ chọc trời trong sân to lắm, phải hai người mới ôm xuể.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '院子里那棵参天大树的树干非常粗，两个人才能勉强合抱过来。', 'Yuànzi lǐ nà kē cāntiān dàshù de shùgàn fēicháng cū, liǎng gè rén cái néng miǎnqiǎng hébào guòlái.', 'Thân cây đại thụ chọc trời trong sân to lắm, phải hai người mới ôm xuể.', 'basic', 1),
        (v_id, '做工粗糙的低劣产品很难在竞争日益激烈的国际高端市场上赢得立足之地。', 'Zuògōng cūcāo de dīliè chǎnpǐn hěn nán zài jìngzhēng rìyì jīliè de guójì gāoduān shìchǎng shang yíngdé lìzú-zhīdì.', 'Các sản phẩm chất lượng thấp gia công thô kệch rất khó có thể giành được chỗ đứng trên thị trường quốc tế cao cấp đang cạnh tranh ngày càng gay gắt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [粗心] (cūxīn) - sơ ý, cẩu thả, bất cẩn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '粗心' AND pinyin = 'cūxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '粗心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'cūxīn',
      meaning_vi = 'sơ ý, cẩu thả, bất cẩn',
      example_hanzi = '因为考试时太粗心，他把一道很简单的数学计算题算错了。',
      example_pinyin = 'Yīnwèi kǎoshì shí tài cūxīn, tā bǎ yí dào hěn jiǎndān de shùxué jìsuàn tí suàn cuò le.',
      example_vi = 'Vì lúc thi quá bất cẩn, cậu ấy đã tính sai một câu tính toán toán học rất đơn giản.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '因为考试时太粗心，他把一道很简单的数学计算题算错了。', 'Yīnwèi kǎoshì shí tài cūxīn, tā bǎ yí dào hěn jiǎndān de shùxué jìsuàn tí suàn cuò le.', 'Vì lúc thi quá bất cẩn, cậu ấy đã tính sai một câu tính toán toán học rất đơn giản.', 'basic', 1),
        (v_id, '医疗和航天等高精密行业容不得半点粗心大意，细微的疏忽都可能引发难以挽回的灾难。', 'Yīliáo hé hángtiān děng gāo jīngmì hángyè róng bu dé bàndiǎnr cūxīn-dàyì, xìwēi de shūhu dōu kěnéng yǐnfā nányǐ wǎnhuí de zāinàn.', 'Các ngành có độ chính xác cao như y tế và hàng không vũ trụ không chấp nhận bất kỳ sự cẩu thả nào, một sơ suất nhỏ đều có thể gây ra thảm họa khôn lường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [村] (cūn) - làng, thôn, xã [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '村' AND pinyin = 'cūn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '村'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'cūn',
      meaning_vi = 'làng, thôn, xã',
      example_hanzi = '我的爷爷奶奶一辈子都生活在宁静美丽的乡村里。',
      example_pinyin = 'Wǒ de yéye nǎinai yíbèizi dōu shēnghuó zài níngjìng měilì de xiāngcūn lǐ.',
      example_vi = 'Ông bà nội tôi cả đời đều sinh sống ở vùng làng quê thanh bình tươi đẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我的爷爷奶奶一辈子都生活在宁静美丽的乡村里。', 'Wǒ de yéye nǎinai yíbèizi dōu shēnghuó zài níngjìng měilì de xiāngcūn lǐ.', 'Ông bà nội tôi cả đời đều sinh sống ở vùng làng quê thanh bình tươi đẹp.', 'basic', 1),
        (v_id, '随着乡村振兴战略的稳步推进，许多偏远贫困的小山村如今通了公路，面貌焕然一新。', 'Suízhe xiāngcūn zhènxīng zhànlüè de wěnbù tuījìn, xǔduō piānyuǎn pínkùn de xiǎoshāncūn rújīn tōng le gōnglù, miànmào huànrán-yìxīn.', 'Cùng với sự thúc đẩy vững chắc của chiến lược phục hưng nông thôn, nhiều thôn bản miền núi hẻo lánh nay đã có đường nhựa, diện mạo đổi mới hoàn toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [存] (cún) - gửi, cất, lưu trữ, để dành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '存' AND pinyin = 'cún'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '存'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'cún',
      meaning_vi = 'gửi, cất, lưu trữ, để dành',
      example_hanzi = '每个月发了工资后，他都会存一部分钱到银行里。',
      example_pinyin = 'Měi gè yuè fā le gōngzī hòu, tā dōu huì cún yí bùfen qián dào yínháng lǐ.',
      example_vi = 'Mỗi tháng sau khi nhận lương, anh ấy đều gửi một phần tiền vào ngân hàng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每个月发了工资后，他都会存一部分钱到银行里。', 'Měi gè yuè fā le gōngzī hòu, tā dōu huì cún yí bùfen qián dào yínháng lǐ.', 'Mỗi tháng sau khi nhận lương, anh ấy đều gửi một phần tiền vào ngân hàng.', 'basic', 1),
        (v_id, '在公共电脑上编辑完重要工作文档后，务必及时将其保存并备份到个人安全云盘。', 'Zài gōnggòng diànnǎo shang biānjí wán zhòngyào gōngzuò wéndàng hòu, wùbì jíshí jiāng qí bǎocún bìng bèifèn dào gèrén ānquán yúnpán.', 'Sau khi chỉnh sửa xong tài liệu công việc quan trọng trên máy tính công cộng, nhất định phải kịp thời lưu lại và sao lưu lên đám mây an toàn cá nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [错过] (cuòguò) - bỏ lỡ, để lỡ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '错过' AND pinyin = 'cuòguò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '错过'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'cuòguò',
      meaning_vi = 'bỏ lỡ, để lỡ',
      example_hanzi = '路上堵车太严重，他最终错过了开往北京的高铁。',
      example_pinyin = 'Lù shang dǔchē tài yánzhòng, tā zuìzhōng cuòguò le kāi wǎng Běijīng de gāotiě.',
      example_vi = 'Đường tắc nghiêm trọng quá, cuối cùng cậu ấy đã bỏ lỡ chuyến tàu cao tốc đi Bắc Kinh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '路上堵车太严重，他最终错过了开往北京的高铁。', 'Lù shang dǔchē tài yánzhòng, tā zuìzhōng cuòguò le kāi wǎng Běijīng de gāotiě.', 'Đường tắc nghiêm trọng quá, cuối cùng cậu ấy đã bỏ lỡ chuyến tàu cao tốc đi Bắc Kinh.', 'basic', 1),
        (v_id, '机不可失，失不再来，面对稍纵即逝的宝贵人生机遇，我们绝不能轻易错过。', 'Jībùkěshī, shībúzàilái, miànduì shāozòng-jíshì de bǎoguì rénshēng jīyù, wǒmen jué bù néng qīngyì cuòguò.', 'Thời cơ hiếm có, mất đi không lấy lại được, đứng trước cơ hội cuộc đời quý giá thoáng qua mau, chúng ta tuyệt đối không thể dễ dàng bỏ lỡ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [错误] (cuòwù) - sai sót, lỗi lầm; sai [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '错误' AND pinyin = 'cuòwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '错误'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'cuòwù',
      meaning_vi = 'sai sót, lỗi lầm; sai',
      example_hanzi = '发现了试卷中的书写错误后，他立刻用橡皮擦掉并订正过来。',
      example_pinyin = 'Fāxiàn le shìjuàn zhōng de shūxiě cuòwù hòu, tā lìkè yòng xiàngpí cā diào bìng dìngzhèng guòlái.',
      example_vi = 'Sau khi phát hiện lỗi viết sai trong bài thi, cậu ấy lập tức dùng tẩy xóa đi và sửa lại cho đúng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '发现了试卷中的书写错误后，他立刻用橡皮擦掉并订正过来。', 'Fāxiàn le shìjuàn zhōng de shūxiě cuòwù hòu, tā lìkè yòng xiàngpí cā diào bìng dìngzhèng guòlái.', 'Sau khi phát hiện lỗi viết sai trong bài thi, cậu ấy lập tức dùng tẩy xóa đi và sửa lại cho đúng.', 'basic', 1),
        (v_id, '勇于正视自身的缺点与错误，并从中汲取有益的成长营养，才是一个人走向成熟的标志。', 'Yǒngyú zhèngshì zìshēn de quēdiǎn yǔ cuòwù, bìng cóngzhōng jíqǔ yǒuyì de chéngzhǎng yíngyǎng, cái shì yí gè rén zǒuxiàng chéngshú de biāozhì.', 'Dũng cảm nhìn thẳng vào khuyết điểm lỗi lầm của bản thân và rút ra bài học phát triển từ đó mới là dấu hiệu một người bước tới sự trưởng thành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [答应] (dāying) - đồng ý, hứa; trả lời, đáp lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '答应' AND pinyin = 'dāying'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '答应'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dāying',
      meaning_vi = 'đồng ý, hứa; trả lời, đáp lại',
      example_hanzi = '既然你已经答应了别人的事情，就一定要信守诺言尽力做到。',
      example_pinyin = 'Jìrán nǐ yǐjīng dāying le biérén de shìqing, jiù yídìng yào xìnshǒu nuòyán jìnlì zuò dào.',
      example_vi = 'Một khi bạn đã hứa với người khác thì nhất định phải giữ lời và dốc sức làm cho bằng được.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '既然你已经答应了别人的事情，就一定要信守诺言尽力做到。', 'Jìrán nǐ yǐjīng dāying le biérén de shìqing, jiù yídìng yào xìnshǒu nuòyán jìnlì zuò dào.', 'Một khi bạn đã hứa với người khác thì nhất định phải giữ lời và dốc sức làm cho bằng được.', 'basic', 1),
        (v_id, '无论我在走廊这头怎么大声呼喊他的名字，他都全神贯注沉浸在实验中没有答应。', 'Wúlùn wǒ zài zǒuláng zhè tóu zěnme dàshēng hūhǎn tā de míngzi, tā dōu quánshén-guànzhù chénjìn zài shíyàn zhōng méiyǒu dāying.', 'Dù tôi ở đầu hành lang này gọi to tên anh ấy thế nào, anh ấy đều tập trung cao độ chìm đắm trong thí nghiệm mà không hề đáp lại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [答] (dá) - trả lời, hồi đáp, giải đáp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '答' AND pinyin = 'dá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '答'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dá',
      meaning_vi = 'trả lời, hồi đáp, giải đáp',
      example_hanzi = '这道考题比较难，考场里大部分同学一时都答不上来。',
      example_pinyin = 'Zhè dào kǎotí bǐjiào nán, kǎochǎng lǐ dà bùfen tóngxué yìshí dōu dá bu shànglái.',
      example_vi = 'Câu hỏi thi này khá khó, phần lớn các bạn học trong phòng thi nhất thời đều không trả lời được.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这道考题比较难，考场里大部分同学一时都答不上来。', 'Zhè dào kǎotí bǐjiào nán, kǎochǎng lǐ dà bùfen tóngxué yìshí dōu dá bu shànglái.', 'Câu hỏi thi này khá khó, phần lớn các bạn học trong phòng thi nhất thời đều không trả lời được.', 'basic', 1),
        (v_id, '在新闻发布会上，新闻发言人沉着冷静地逐一回答了中外记者的关切提问。', 'Zài xīnwén fābùhuì shang, xīnwén fāyánrén chénzhuó lěngjìng de zhúyī huídá le zhōng-wài jìzhě de guānqiè tíwèn.', 'Tại buổi họp báo, người phát ngôn tin tức đã điềm đạm bình tĩnh trả lời từng câu hỏi chất vấn của các phóng viên trong và ngoài nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [答案] (dá’àn) - đáp án, câu trả lời [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '答案' AND pinyin = 'dá’àn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '答案'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dá’àn',
      meaning_vi = 'đáp án, câu trả lời',
      example_hanzi = '请把做完的练习题答案和课本附录对照一下。',
      example_pinyin = 'Qǐng bǎ zuò wán de liànxí tí dá’àn hé kèběn fùlù duìzhào yíxià.',
      example_vi = 'Xin hãy đối chiếu đáp án bài tập đã làm với phần phụ lục sách giáo khoa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把做完的练习题答案和课本附录对照一下。', 'Qǐng bǎ zuò wán de liànxí tí dá’àn hé kèběn fùlù duìzhào yíxià.', 'Xin hãy đối chiếu đáp án bài tập đã làm với phần phụ lục sách giáo khoa.', 'basic', 1),
        (v_id, '面对复杂多变的商业竞争环境，并没有放之四海而皆准的唯一现成标准答案。', 'Miànduì fùzá duōbiàn de shāngyè jìngzhēng huánjìng, bìng méiyǒu fàngzhīsìhǎi’érjiēzhǔn de wéiyī xiànchéng biāozhǔn dá’àn.', 'Đứng trước môi trường cạnh tranh thương mại biến hóa khôn lường, không hề có đáp án chuẩn mực duy nhất nào đúng cho mọi trường hợp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [达到] (dádào) - đạt được, đạt tới [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '达到' AND pinyin = 'dádào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '达到'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dádào',
      meaning_vi = 'đạt được, đạt tới',
      example_hanzi = '经过全组员工的努力，公司的月销售额终于达到了既定目标。',
      example_pinyin = 'Jīngguò quán zǔ yuángōng de nǔlì, gōngsī de yuè xiāoshòu’é zhōngyú dádào le jìdìng mùbiāo.',
      example_vi = 'Nhờ nỗ lực của toàn thể nhân viên nhóm, doanh số tháng của công ty rốt cuộc đã đạt được mục tiêu đề ra.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全组员工的努力，公司的月销售额终于达到了既定目标。', 'Jīngguò quán zǔ yuángōng de nǔlì, gōngsī de yuè xiāoshòu’é zhōngyú dádào le jìdìng mùbiāo.', 'Nhờ nỗ lực của toàn thể nhân viên nhóm, doanh số tháng của công ty rốt cuộc đã đạt được mục tiêu đề ra.', 'basic', 1),
        (v_id, '只有当汉语综合运用能力达到一定深度时，才能无障碍地阅读中国古典名著。', 'Zhǐyào dāng Hànyǔ zōnghé yùnyòng nénglì dádào yídìng shēndù shí, cái néng wúzhàng’ài de yuèdú Zhōngguó gǔdiǎn míngzhù.', 'Chỉ khi năng lực vận dụng tổng hợp Hán ngữ đạt tới độ sâu nhất định mới có thể đọc các danh tác cổ điển Trung Hoa mà không gặp rào cản.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打招呼] (dǎ zhāohu) - chào hỏi, chào [Cụm từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '打招呼' AND pinyin = 'dǎ zhāohu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打招呼'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Cụm từ / Động từ',
      pinyin = 'dǎ zhāohu',
      meaning_vi = 'chào hỏi, chào',
      example_hanzi = '每天早晨在走廊里遇到老师和同学，他都会礼貌地微笑着打招呼。',
      example_pinyin = 'Měitiān zǎochén zài zǒuláng lǐ yùdào lǎoshī hé tóngxué, tā dōu huì lǐmào de wēixiào zhe dǎ zhāohu.',
      example_vi = 'Mỗi buổi sáng khi gặp thầy cô và bạn học ở hành lang, cậu ấy đều mỉm cười lễ phép chào hỏi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每天早晨在走廊里遇到老师和同学，他都会礼貌地微笑着打招呼。', 'Měitiān zǎochén zài zǒuláng lǐ yùdào lǎoshī hé tóngxué, tā dōu huì lǐmào de wēixiào zhe dǎ zhāohu.', 'Mỗi buổi sáng khi gặp thầy cô và bạn học ở hành lang, cậu ấy đều mỉm cười lễ phép chào hỏi.', 'basic', 1),
        (v_id, '主动向邻里邻居热情打招呼不仅是礼貌的体现，更能拉近人与人之间的心灵距离。', 'Zhǔdòng xiàng línlǐ línjū rèqíng dǎ zhāohu bùjǐn shì lǐmào de tǐxiàn, gèng néng lājìn rén yǔ rén zhījiān de xīnlíng jùlí.', 'Chủ động nhiệt tình chào hỏi bà con lối xóm không chỉ là biểu hiện lịch sự mà còn kéo gần khoảng cách tâm hồn giữa người với người.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打败] (dǎbài) - đánh bại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '打败' AND pinyin = 'dǎbài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打败'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dǎbài',
      meaning_vi = 'đánh bại',
      example_hanzi = '在这场激烈的乒乓球决赛中，年轻的小将以三比一的比分打败了卫冕冠军。',
      example_pinyin = 'Zài zhè chǎng jīliè de pīngpāngqiú juésài zhōng, niánqīng de xiǎojiàng yǐ sān bǐ yī de bǐfēn dǎbài le wèimiǎn guànjūn.',
      example_vi = 'Trong trận chung kết bóng bàn kịch tính này, tay vợt trẻ đã đánh bại đương kim vô địch với tỷ số ba-một.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在这场激烈的乒乓球决赛中，年轻的小将以三比一的比分打败了卫冕冠军。', 'Zài zhè chǎng jīliè de pīngpāngqiú juésài zhōng, niánqīng de xiǎojiàng yǐ sān bǐ yī de bǐfēn dǎbài le wèimiǎn guànjūn.', 'Trong trận chung kết bóng bàn kịch tính này, tay vợt trẻ đã đánh bại đương kim vô địch với tỷ số ba-một.', 'basic', 1),
        (v_id, '在人生的漫长赛道上，能够真正打败我们的往往不是强大的竞争对手，而是自身的怯懦与自满。', 'Zài rénshēng de màncháng sàidào shang, nénggòu zhēnzhèng dǎbài wǒmen de wǎngwǎng bú shì qiángdà de jìngzhēng duìshǒu, ér shì zìshēn de qiènuò yǔ zìmǎn.', 'Trên đường đua dài của cuộc đời, thứ có thể thực sự đánh bại chúng ta thường không phải đối thủ cạnh tranh mạnh mẽ mà chính là sự nhu nhược tự mãn của bản thân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打工] (dǎgōng) - làm thuê, làm thêm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '打工' AND pinyin = 'dǎgōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打工'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dǎgōng',
      meaning_vi = 'làm thuê, làm thêm',
      example_hanzi = '许多大学生在周末和暑假期间去咖啡店打工以赚取生活费。',
      example_pinyin = 'Xǔduō dàxuéshēng zài zhōumò hé shǔjià qījiān qù kāfēidiàn dǎgōng yǐ zhuànqǔ shēnghuófèi.',
      example_vi = 'Nhiều sinh viên đại học vào cuối tuần và kỳ nghỉ hè đi làm thêm ở quán cà phê để trang trải chi phí sinh hoạt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '许多大学生在周末和暑假期间去咖啡店打工以赚取生活费。', 'Xǔduō dàxuéshēng zài zhōumò hé shǔjià qījiān qù kāfēidiàn dǎgōng yǐ zhuànqǔ shēnghuófèi.', 'Nhiều sinh viên đại học vào cuối tuần và kỳ nghỉ hè đi làm thêm ở quán cà phê để trang trải chi phí sinh hoạt.', 'basic', 1),
        (v_id, '课余适度打工不仅能够减轻家庭的经济负担，更是一次宝贵提前接触社会的实践经历。', 'Kèyú shìdù dǎgōng bùjǐn nénggòu jiǎnqīng jiātíng de jīngjì fùdān, gèng shì yí cì bǎoguì tíqián jiēchù shèhuì de shíjiàn jīnglì.', 'Đi làm thêm chừng mực ngoài giờ học không những san sẻ được gánh nặng kinh tế gia đình mà còn là một trải nghiệm thực tế quý giá giúp tiếp xúc sớm với xã hội.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打扰] (dǎrǎo) - làm phiền, quấy rầy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '打扰' AND pinyin = 'dǎrǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打扰'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dǎrǎo',
      meaning_vi = 'làm phiền, quấy rầy',
      example_hanzi = '真不好意思，百忙之中打扰您几分钟时间向您请教个问题。',
      example_pinyin = 'Zhēn bù hǎoyìsi, bǎimáng-zhīzhōng dǎrǎo nín jǐ fēnzhōng shíjiān xiàng nín qǐngjiào gè wèntí.',
      example_vi = 'Thực sự ngại quá, giữa lúc trăm công nghìn việc xin làm phiền anh vài phút để thỉnh giáo một vấn đề.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '真不好意思，百忙之中打扰您几分钟时间向您请教个问题。', 'Zhēn bù hǎoyìsi, bǎimáng-zhīzhōng dǎrǎo nín jǐ fēnzhōng shíjiān xiàng nín qǐngjiào gè wèntí.', 'Thực sự ngại quá, giữa lúc trăm công nghìn việc xin làm phiền anh vài phút để thỉnh giáo một vấn đề.', 'basic', 1),
        (v_id, '图书馆是公共自主学习的安静场所，进出时请勿大声喧哗打扰他人阅读思考。', 'Túshūguǎn shì gōnggòng zìzhǔ xuéxí de ānjìng chǎngsuǒ, jìn-chū shí qǐng wù dàshēng xuānhuá dǎrǎo tārén yuèdú sīkǎo.', 'Thư viện là nơi chốn công cộng yên tĩnh để tự học, khi ra vào xin đừng làm ồn lớn tiếng quấy rầy người khác đọc sách tư duy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打印] (dǎyìn) - in ấn, in [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '打印' AND pinyin = 'dǎyìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打印'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dǎyìn',
      meaning_vi = 'in ấn, in',
      example_hanzi = '请把这份明天会议要用到的发言材料打印十份。',
      example_pinyin = 'Qǐng bǎ zhè fèn míngtiān huìyì yào yòng dào de fāyán cáiliào dǎyìn shí fèn.',
      example_vi = 'Xin hãy in mười bản tài liệu phát biểu cần dùng cho cuộc họp ngày mai này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把这份明天会议要用到的发言材料打印十份。', 'Qǐng bǎ zhè fèn míngtiān huìyì yào yòng dào de fāyán cáiliào dǎyìn shí fèn.', 'Xin hãy in mười bản tài liệu phát biểu cần dùng cho cuộc họp ngày mai này.', 'basic', 1),
        (v_id, '为了贯彻无纸化低碳绿色办公理念，非必要内部交流文件建议尽量不要打印纸质版本。', 'Wèile guànchè wúzǐhuà dītàn lǜsè bàngōng lǐniàn, fēi bìyào nèibù jiāoliú wénjiàn jiànyì jǐnliàng bú yào dǎyìn zhǐzhì bǎnběn.', 'Nhằm quán triệt tư tưởng văn phòng xanh giảm carbon không giấy tờ, những văn bản trao đổi nội bộ không cần thiết khuyến nghị hạn chế in ấn bản giấy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打印机] (dǎyìnjī) - máy in [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '打印机' AND pinyin = 'dǎyìnjī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打印机'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dǎyìnjī',
      meaning_vi = 'máy in',
      example_hanzi = '办公室的激光打印机没墨了，需要更换新的墨盒。',
      example_pinyin = 'Bàngōngshì de jīguāng dǎyìnjī méi mò le, xūyào gēnghuàn xīn de mòhé.',
      example_vi = 'Chiếc máy in laser ở văn phòng hết mực rồi, cần phải thay hộp mực mới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '办公室的激光打印机没墨了，需要更换新的墨盒。', 'Bàngōngshì de jīguāng dǎyìnjī méi mò le, xūyào gēnghuàn xīn de mòhé.', 'Chiếc máy in laser ở văn phòng hết mực rồi, cần phải thay hộp mực mới.', 'basic', 1),
        (v_id, '这台新型多功能一体化无线打印机集打印、扫描和彩色复印等多种功能于一身。', 'Zhè tái xīnxíng duōgōngnéng yītǐhuà wúxiàn dǎyìnjī jí dǎyìn, sǎomiáo hé cǎisè fùyìn děng duō zhǒng gōngnéng yú yì shēn.', 'Chiếc máy in không dây đa chức năng kiểu mới này tích hợp trọn vẹn nhiều tính năng như in ấn, scan và photocopy màu trong một thân máy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打折] (dǎzhé) - giảm giá, chiết khấu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '打折' AND pinyin = 'dǎzhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打折'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dǎzhé',
      meaning_vi = 'giảm giá, chiết khấu',
      example_hanzi = '商场正在举办换季大促销活动，全场男女服装一律打八折。',
      example_pinyin = 'Shāngchǎng zhèngzài jǔbàn huànjì dà cùxiāo huódòng, quánchǎng nán-nǚ fúzhuāng yílǜ dǎ bā zhé.',
      example_vi = 'Trung tâm mua sắm đang tổ chức đợt xả hàng lớn chuyển mùa, toàn bộ trang phục nam nữ đồng loạt giảm giá hai mươi phần trăm (tính tám mươi phần trăm giá gốc).'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '商场正在举办换季大促销活动，全场男女服装一律打八折。', 'Shāngchǎng zhèngzài jǔbàn huànjì dà cùxiāo huódòng, quánchǎng nán-nǚ fúzhuāng yílǜ dǎ bā zhé.', 'Trung tâm mua sắm đang tổ chức đợt xả hàng lớn chuyển mùa, toàn bộ trang phục nam nữ đồng loạt giảm giá hai mươi phần trăm (tính tám mươi phần trăm giá gốc).', 'basic', 1),
        (v_id, '虽然商品标价打折力度很大，但消费者在网购付款前仍需保持理性，避免盲目囤货。', 'Suīrán shāngpǐn biāojià dǎzhé lìdù hěn dà, dàn xiāofèizhě zài wǎnggòu fùkuǎn qián réng xū bǎochí lǐxìng, bìmiǎn mángmù túnhuò.', 'Dù mức độ giảm giá niêm yết của hàng hóa rất sâu, người tiêu dùng trước khi thanh toán mua hàng qua mạng vẫn cần giữ sự tỉnh táo, tránh tích trữ mù quáng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打针] (dǎzhēn) - tiêm thuốc, chích thuốc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '打针' AND pinyin = 'dǎzhēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '打针'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dǎzhēn',
      meaning_vi = 'tiêm thuốc, chích thuốc',
      example_hanzi = '小妹妹从小就很勇敢，去社区医院生病打针时从来不哭。',
      example_pinyin = 'Xiǎo mèimei cóngxiǎo jiù hěn yǒnggǎn, qù shèqū yīyuàn shēngbìng dǎzhēn shí cónglái bù kū.',
      example_vi = 'Em gái nhỏ từ bé đã rất dũng cảm, khi đi bệnh viện khu phố tiêm thuốc lúc ốm không bao giờ khóc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小妹妹从小就很勇敢，去社区医院生病打针时从来不哭。', 'Xiǎo mèimei cóngxiǎo jiù hěn yǒnggǎn, qù shèqū yīyuàn shēngbìng dǎzhēn shí cónglái bù kū.', 'Em gái nhỏ từ bé đã rất dũng cảm, khi đi bệnh viện khu phố tiêm thuốc lúc ốm không bao giờ khóc.', 'basic', 1),
        (v_id, '按时前往专业医疗卫生机构接种预防各类传染病的疫苗打针，是构筑群体免疫屏障的有力手段。', 'Ànshí qiánwǎng zhuānyè yīliáo wèishēng jīgòu jiēzhòng yùfáng gè lèi chuánrǎnbìng de yìmiáo dǎzhēn, shì gòuzhù qúntǐ miǎnyì píngzhàng de yǒulì shǒuduàn.', 'Đến các cơ sở y tế chuyên môn tiêm vắc xin phòng ngừa các bệnh truyền nhiễm đúng hẹn là biện pháp hữu hiệu để xây dựng lá chắn miễn dịch cộng đồng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [大巴] (dàbā) - xe khách cỡ lớn, xe buýt du lịch [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '大巴' AND pinyin = 'dàbā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大巴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dàbā',
      meaning_vi = 'xe khách cỡ lớn, xe buýt du lịch',
      example_hanzi = '全体师生准时在校门口集合，乘坐豪华大巴前往野生动物园春游。',
      example_pinyin = 'Quántǐ shīshēng zhǔnshí zài xiàomén kǒu jíhé, chéngzuò háohuá dàbā qiánwǎng yěshēng dòngwùyuán chūnyóu.',
      example_vi = 'Toàn thể thầy trò tập trung đúng giờ ở cổng trường, lên xe khách du lịch sang trọng đi dã ngoại mùa xuân tại vườn thú hoang dã.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '全体师生准时在校门口集合，乘坐豪华大巴前往野生动物园春游。', 'Quántǐ shīshēng zhǔnshí zài xiàomén kǒu jíhé, chéngzuò háohuá dàbā qiánwǎng yěshēng dòngwùyuán chūnyóu.', 'Toàn thể thầy trò tập trung đúng giờ ở cổng trường, lên xe khách du lịch sang trọng đi dã ngoại mùa xuân tại vườn thú hoang dã.', 'basic', 1),
        (v_id, '为了方便偏远乡村村民往返县城，客运公司特意增开了每日多班次的惠民长途大巴。', 'Wèile fāngbiàn piānyuǎn xiāngcūn cūnmín wǎngfǎn xiànchéng, kèyùn gōngsī tèyì zēngkāi le měirì duō bāncì de huìmín chángtú dàbā.', 'Nhằm tạo thuận tiện cho bà con nông thôn vùng xa đi lại huyện lỵ, công ty vận tải hành khách đã tăng cường thêm nhiều chuyến xe khách đường dài trợ giá mỗi ngày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [大大] (dàdà) - rất lớn, vô cùng, hết sức [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '大大' AND pinyin = 'dàdà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大大'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'dàdà',
      meaning_vi = 'rất lớn, vô cùng, hết sức',
      example_hanzi = '经过近两个月的高强度集中强化，他的汉语听力与阅读能力大大提高了。',
      example_pinyin = 'Jīngguò jìn liǎng gè yuè de gāoxiàngdù jízhōng qiánghuà, tā de Hànyǔ tīnglì yǔ yuèdú nénglì dàdà tígāo le.',
      example_vi = 'Trải qua gần hai tháng rèn luyện tập trung cường độ cao, năng lực nghe hiểu và đọc hiểu tiếng Trung của cậu ấy đã tiến bộ vượt bậc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过近两个月的高强度集中强化，他的汉语听力与阅读能力大大提高了。', 'Jīngguò jìn liǎng gè yuè de gāoxiàngdù jízhōng qiánghuà, tā de Hànyǔ tīnglì yǔ yuèdú nénglì dàdà tígāo le.', 'Trải qua gần hai tháng rèn luyện tập trung cường độ cao, năng lực nghe hiểu và đọc hiểu tiếng Trung của cậu ấy đã tiến bộ vượt bậc.', 'basic', 1),
        (v_id, '高速铁路网络的密集覆盖与全线贯通，大大缩短了沿线各大城市之间的时空通勤距离。', 'Gāosù tiělù wǎngluò de mìmí fùgài yǔ quánxiàn guàntōng, dàdà suōduǎn le yánxiàn gè dà chéngshì zhījiān de shíkōng tōngqín jùlí.', 'Mạng lưới đường sắt cao tốc phủ kín và thông tuyến toàn diện đã rút ngắn rất nhiều khoảng cách thời gian đi lại giữa các đô thị lớn dọc tuyến.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [大夫] (dàifu) - bác sĩ, thầy thuốc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '大夫' AND pinyin = 'dàifu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大夫'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dàifu',
      meaning_vi = 'bác sĩ, thầy thuốc',
      example_hanzi = '张大夫医术精湛，对待每一位前来看病的病患都和蔼可亲。',
      example_pinyin = 'Zhāng dàifu yīshù jīngzhàn, duìdài měi yí wèi qiánlái kànbìng de bìnghuàn dōu hé’ǎi-kěqīn.',
      example_vi = 'Bác sĩ Trương y thuật cao minh, đối đãi với từng người bệnh tới khám đều hiền từ niềm nở.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '张大夫医术精湛，对待每一位前来看病的病患都和蔼可亲。', 'Zhāng dàifu yīshù jīngzhàn, duìdài měi yí wèi qiánlái kànbìng de bìnghuàn dōu hé’ǎi-kěqīn.', 'Bác sĩ Trương y thuật cao minh, đối đãi với từng người bệnh tới khám đều hiền từ niềm nở.', 'basic', 1),
        (v_id, '经过值班主治大夫与医护团队连夜数小时的争分夺秒全力抢救，危重病人终于脱离了生命危险。', 'Jīngguò zhíbān zhǔzhì dàifu yǔ yīhù tuánduì liányè shù xiǎoshí de zhēngfēn-duómiǎo quánlì qiǎngjiù, wēizhòng bìngrén zhōngyú tuōlí le shēngmìng wēixiǎn.', 'Trải qua nhiều giờ tranh thủ từng phút từng giây cấp cứu thâu đêm của bác sĩ trực ca và kíp điều dưỡng, bệnh nhân nguy kịch rốt cuộc đã qua cơn hiểm nghèo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [大量] (dàliàng) - số lượng lớn, nhiều [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '大量' AND pinyin = 'dàliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'dàliàng',
      meaning_vi = 'số lượng lớn, nhiều',
      example_hanzi = '剧烈运动之后体内水分大量流失，需要及时补充淡盐水。',
      example_pinyin = 'Jùliè yùndòng zhīhòu tǐnèi shuǐfèn dàliàng liúshī, xūyào jíshí bǔchōng dàn yánshuǐ.',
      example_vi = 'Sau khi vận động mạnh lượng nước trong cơ thể thất thoát rất nhiều, cần bù đắp nước muối loãng kịp thời.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '剧烈运动之后体内水分大量流失，需要及时补充淡盐水。', 'Jùliè yùndòng zhīhòu tǐnèi shuǐfèn dàliàng liúshī, xūyào jíshí bǔchōng dàn yánshuǐ.', 'Sau khi vận động mạnh lượng nước trong cơ thể thất thoát rất nhiều, cần bù đắp nước muối loãng kịp thời.', 'basic', 1),
        (v_id, '该研究课题的深入开展必须建立在对海量历史文献和一手实地考察数据的大量科学分析之上。', 'Gāi yánjiū kètí de shēnrù kāizhǎn bìxū jiànlì zài duì hǎiliàng lìshǐ wénxiàn hé yìshǒu shídì kǎochá shùjù de dàliàng kēxué fēnxī zhīshàng.', 'Việc triển khai sâu rộng đề tài nghiên cứu này phải được xây dựng trên cơ sở phân tích khoa học khối lượng lớn đối với tư liệu lịch sử đồ sộ và số liệu khảo sát thực địa sơ cấp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [大赛] (dàsài) - cuộc thi lớn, giải đấu lớn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '大赛' AND pinyin = 'dàsài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大赛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dàsài',
      meaning_vi = 'cuộc thi lớn, giải đấu lớn',
      example_hanzi = '来自全国顶尖高校的青年学子在这次创新创业大赛中大放异彩。',
      example_pinyin = 'Láizì quán guó dǐngjiān gāoxiào de qīngnián xuézǐ zài zhè cì chuàngxīn chuàngyè dàsài zhōng dà fàng yìcǎi.',
      example_vi = 'Các bạn trẻ sinh viên đến từ những trường đại học tốp đầu trên cả nước đã tỏa sáng rực rỡ tại giải thi đấu đổi mới khởi nghiệp lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '来自全国顶尖高校的青年学子在这次创新创业大赛中大放异彩。', 'Láizì quán guó dǐngjiān gāoxiào de qīngnián xuézǐ zài zhè cì chuàngxīn chuàngyè dàsài zhōng dà fàng yìcǎi.', 'Các bạn trẻ sinh viên đến từ những trường đại học tốp đầu trên cả nước đã tỏa sáng rực rỡ tại giải thi đấu đổi mới khởi nghiệp lần này.', 'basic', 1),
        (v_id, '四年一届的国际奥林匹克体育大赛是全人类弘扬和平友谊与拼搏竞技精神的共同盛会。', 'Sì nián yí jiè de guójì àolínpǐkè tǐyù dàsài shì quán rénlèi hóngyáng hépíng yǒuyì yǔ pīnbó jìngjì jīngshén de gòngtóng shènghuì.', 'Đại hội thể thao Olympic quốc tế bốn năm một lần là ngày hội chung của toàn nhân loại nhằm tôn vinh tình hữu nghị hòa bình và tinh thần thể thao thi đấu quả cảm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [大厅] (dàtīng) - đại sảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '大厅' AND pinyin = 'dàtīng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大厅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dàtīng',
      meaning_vi = 'đại sảnh',
      example_hanzi = '宾馆一楼宽敞明亮的服务大厅里摆放着美丽的鲜花与舒适的沙发。',
      example_pinyin = 'Bīnguǎn yī lóu kuānchǎng míngliàng de fúwù dàtīng lǐ bǎifàng zhe měilì de xiānhuā yǔ shūshì de shāfā.',
      example_vi = 'Trong đại sảnh phục vụ rộng rãi sáng sủa tầng một khách sạn bài trí những bình hoa tươi đẹp mắt và ghế sofa êm ái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '宾馆一楼宽敞明亮的服务大厅里摆放着美丽的鲜花与舒适的沙发。', 'Bīnguǎn yī lóu kuānchǎng míngliàng de fúwù dàtīng lǐ bǎifàng zhe měilì de xiānhuā yǔ shūshì de shāfā.', 'Trong đại sảnh phục vụ rộng rãi sáng sủa tầng một khách sạn bài trí những bình hoa tươi đẹp mắt và ghế sofa êm ái.', 'basic', 1),
        (v_id, '新落成的现代综合政务服务大厅推行全流程数字化导引，极大缩短了市民前来办事的等候时间。', 'Xīn luòchéng de xiàndài zōnghé zhèngwù fúwù dàtīng tuīxíng quán liúchéng shùzìhuà dǎoyǐn, jídà suōduǎn le shìmín qiánlái bànshì de děnghòu shíjiān.', 'Đại sảnh dịch vụ hành chính tổng hợp hiện đại mới hoàn thành áp dụng chỉ dẫn số hóa toàn bộ quy trình, rút ngắn đáng kể thời gian chờ đợi của người dân đến làm việc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [大约] (dàyuē) - khoảng chừng, ước chừng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '大约' AND pinyin = 'dàyuē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大约'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'dàyuē',
      meaning_vi = 'khoảng chừng, ước chừng',
      example_hanzi = '从我家步行到最近的地铁站大约需要十五分钟左右。',
      example_pinyin = 'Cóng wǒ jiā bùxíng dào zuì jìn de dìtiězhàn dàyuē xūyào shíwǔ fēnzhōng zuǒyòu.',
      example_vi = 'Từ nhà tôi đi bộ tới ga tàu điện ngầm gần nhất mất khoảng chừng mười lăm phút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '从我家步行到最近的地铁站大约需要十五分钟左右。', 'Cóng wǒ jiā bùxíng dào zuì jìn de dìtiězhàn dàyuē xūyào shíwǔ fēnzhōng zuǒyòu.', 'Từ nhà tôi đi bộ tới ga tàu điện ngầm gần nhất mất khoảng chừng mười lăm phút.', 'basic', 1),
        (v_id, '根据最新的人口统计学普查报告显示，该市目前的常住外籍人员规模大约在五万人上下。', 'Gēnjù zuìxīn de rénkǒu tǒngjìxué pǔchá bàogào xiǎnshì, gāi shì mùqián de chángzhù wàijí rényuán guīmó dàyuē zài wǔ wàn rén shàngxià.', 'Theo báo cáo điều tra thống kê dân số mới nhất cho thấy, quy mô người nước ngoài thường trú tại thành phố này hiện nay vào khoảng chừng năm vạn người.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [大自然] (dàzìrán) - mẹ thiên nhiên, tự nhiên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '大自然' AND pinyin = 'dàzìrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '大自然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dàzìrán',
      meaning_vi = 'mẹ thiên nhiên, tự nhiên',
      example_hanzi = '周末远离城市的喧嚣，走进大自然呼吸新鲜空气能彻底放松身心。',
      example_pinyin = 'Zhōumò yuǎnlí chéngshì de xuānxiāo, zǒujìn dàzìrán hūxī xīnxiān kōngqì néng chèdǐ fàngsōng shēnxīn.',
      example_vi = 'Cuối tuần tránh xa tiếng ồn ào của thành phố, bước vào thiên nhiên hít thở không khí trong lành có thể thư giãn hoàn toàn cả thể xác lẫn tâm hồn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末远离城市的喧嚣，走进大自然呼吸新鲜空气能彻底放松身心。', 'Zhōumò yuǎnlí chéngshì de xuānxiāo, zǒujìn dàzìrán hūxī xīnxiān kōngqì néng chèdǐ fàngsōng shēnxīn.', 'Cuối tuần tránh xa tiếng ồn ào của thành phố, bước vào thiên nhiên hít thở không khí trong lành có thể thư giãn hoàn toàn cả thể xác lẫn tâm hồn.', 'basic', 1),
        (v_id, '人类应当树立尊重自然、顺应自然与保护大自然的生态文明理念，走人与自然和谐共生的可持续发展道路。', 'Rénlèi yīngdāng shùlì zūnzhòng zìrán, shùnyìng zìrán yǔ bǎohù dàzìrán de shēngtài wénmíng lǐniàn, zǒu rén yǔ zìrán héxié-gòngshēng de kěchíxù fāzhǎn dàolù.', 'Con người cần xác lập quan niệm văn minh sinh thái tôn trọng tự nhiên, hòa hợp với tự nhiên và bảo vệ mẹ thiên nhiên, đi trên con đường phát triển bền vững người và tự nhiên chung sống hòa hợp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [待] (dāi) - ở lại, lưu lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '待' AND pinyin = 'dāi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '待'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dāi',
      meaning_vi = 'ở lại, lưu lại',
      example_hanzi = '北京的秋天景色太迷人了，他打算在这里多待一个星期再回国。',
      example_pinyin = 'Běijīng de qiūtiān jǐngsè tài mírén le, tā dǎsuàn zài zhèlǐ duō dāi yí gè xīngqī zài huíguó.',
      example_vi = 'Cảnh thu Bắc Kinh mê hoặc quá, anh ấy dự định ở lại đây thêm một tuần rồi mới về nước.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '北京的秋天景色太迷人了，他打算在这里多待一个星期再回国。', 'Běijīng de qiūtiān jǐngsè tài mírén le, tā dǎsuàn zài zhèlǐ duō dāi yí gè xīngqī zài huíguó.', 'Cảnh thu Bắc Kinh mê hoặc quá, anh ấy dự định ở lại đây thêm một tuần rồi mới về nước.', 'basic', 1),
        (v_id, '整日足不出户待在狭窄房间里盯着电子屏幕容易产生心理疲劳，建议多去户外亲近阳光。', 'Zhěngrì zúbùchūhù dāi zài xiázhǎi fángjiān lǐ dīng zhe diànzǐ píngmù róngyì chǎnshēng xīnlǐ píláo, jiànyì duō qù hùwài qīnjìn yángguāng.', 'Suốt ngày ru rú trong nhà ở lì trong căn phòng chật chội nhìn chằm chằm màn hình điện tử rất dễ gây mệt mỏi tâm lý, khuyên nên ra ngoài trời gần gũi với ánh nắng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [戴] (dài) - đeo, đội, mang (mũ, kính, găng tay, đồng hồ, trang sức) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '戴' AND pinyin = 'dài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '戴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dài',
      meaning_vi = 'đeo, đội, mang (mũ, kính, găng tay, đồng hồ, trang sức)',
      example_hanzi = '冬天早晨骑自行车出门时，一定要戴好保暖的手套和帽子。',
      example_pinyin = 'Dōngtiān zǎochén qí zìxíngchē chūmén shí, yídìng yào dài hǎo bǎonuǎn de shǒutào hé màozi.',
      example_vi = 'Mùa đông buổi sáng đạp xe ra ngoài, nhất định phải đeo găng tay và đội mũ giữ ấm chu đáo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '冬天早晨骑自行车出门时，一定要戴好保暖的手套和帽子。', 'Dōngtiān zǎochén qí zìxíngchē chūmén shí, yídìng yào dài hǎo bǎonuǎn de shǒutào hé màozi.', 'Mùa đông buổi sáng đạp xe ra ngoài, nhất định phải đeo găng tay và đội mũ giữ ấm chu đáo.', 'basic', 1),
        (v_id, '进入建筑施工现场，所有人员均必须严格按照安全规范全程佩戴安全头盔。', 'Jìnrù jiànzhù shīgōng xiànchǎng, suǒyǒu rényuán jūn bìxū yángé ànzhào ānquán guīfàn quánchéng pèidài ānquán tóukuī.', 'Khi đi vào công trường thi công xây dựng, toàn bộ nhân sự đều phải đội mũ bảo hiểm trong suốt thời gian theo đúng quy chuẩn an toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [袋子] (dàizi) - túi, bao, bì [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '袋子' AND pinyin = 'dàizi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '袋子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dàizi',
      meaning_vi = 'túi, bao, bì',
      example_hanzi = '去超市买菜时自己携带环保布袋子，既实用又能减少白色塑料污染。',
      example_pinyin = 'Qù chāoshì mǎi cài shí zìjǐ xiédài huánbǎo bù dàizi, jì shíyòng yòu néng jiǎnshǎo báisè sùliào wūrǎn.',
      example_vi = 'Khi đi siêu thị mua thức ăn tự mình mang theo túi vải thân thiện môi trường, vừa tiện dụng vừa giảm ô nhiễm rác thải nhựa trắng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '去超市买菜时自己携带环保布袋子，既实用又能减少白色塑料污染。', 'Qù chāoshì mǎi cài shí zìjǐ xiédài huánbǎo bù dàizi, jì shíyòng yòu néng jiǎnshǎo báisè sùliào wūrǎn.', 'Khi đi siêu thị mua thức ăn tự mình mang theo túi vải thân thiện môi trường, vừa tiện dụng vừa giảm ô nhiễm rác thải nhựa trắng.', 'basic', 1),
        (v_id, '他手里提着两个沉甸甸的大袋子，里面装满了老家父母亲手采摘的新鲜特产土产。', 'Tā shǒu lǐ tí zhe liǎng gè chéndiàndiàn de dà dàizi, lǐmiàn zhuāng mǎn le lǎojiā fùmǔ qīnshǒu cǎizhāi de xīnxiān tèsǎn tǔchǎn.', 'Trên tay anh ấy xách hai chiếc túi to nặng trĩu, bên trong đựng đầy đặc sản tươi ngon do chính tay bố mẹ ở quê nhà hái gửi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [单位] (dānwèi) - đơn vị, cơ quan; đơn vị đo lường [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '单位' AND pinyin = 'dānwèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '单位'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dānwèi',
      meaning_vi = 'đơn vị, cơ quan; đơn vị đo lường',
      example_hanzi = '他在一家外资商业银行单位从事财务审计工作。',
      example_pinyin = 'Tā zài yì jiā wàizī shāngyè yínháng dānwèi cóngshì cáiwù shěnjì gōngzuò.',
      example_vi = 'Anh ấy làm công việc kiểm toán tài chính tại một cơ quan ngân hàng thương mại vốn nước ngoài.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在一家外资商业银行单位从事财务审计工作。', 'Tā zài yì jiā wàizī shāngyè yínháng dānwèi cóngshì cáiwù shěnjì gōngzuò.', 'Anh ấy làm công việc kiểm toán tài chính tại một cơ quan ngân hàng thương mại vốn nước ngoài.', 'basic', 1),
        (v_id, '国际标准化组织统一制定了全球通用的物理度量衡计算单位，确保了跨国科学研究与工业生产的无缝对接。', 'Guójì biāozhǔnhuà zǔzhī tǒngyī zhìdìng le quánqiú tōngyòng de wùlǐ dùliànghéng jìsuàn dānwèi, quèbǎo le kuàguó kēxué yánjiū yǔ gōngyè shēngchǎn de wúféng duìjiē.', 'Tổ chức Tiêu chuẩn hóa Quốc tế đã thống nhất đặt ra các đơn vị tính toán đo lường vật lý dùng chung toàn cầu, bảo đảm sự khớp nối hoàn hảo trong nghiên cứu khoa học và sản xuất công nghiệp xuyên quốc gia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [当] (dāng) - làm, đảm nhiệm; khi, vào lúc [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '当' AND pinyin = 'dāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '当'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Giới từ',
      pinyin = 'dāng',
      meaning_vi = 'làm, đảm nhiệm; khi, vào lúc',
      example_hanzi = '当清晨的第一缕金色阳光洒满大地时，整座城市渐渐苏醒过来。',
      example_pinyin = 'Dāng qīngchén de dì-yī lǚ jīnsè yángguāng sǎ mǎn dàdì shí, zhěng zuò chéngshì jiànjiàn sūxǐng guòlái.',
      example_vi = 'Khi tia nắng vàng đầu tiên của sớm mai rải khắp mặt đất, toàn bộ thành phố dần dần thức giấc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '当清晨的第一缕金色阳光洒满大地时，整座城市渐渐苏醒过来。', 'Dāng qīngchén de dì-yī lǚ jīnsè yángguāng sǎ mǎn dàdì shí, zhěng zuò chéngshì jiànjiàn sūxǐng guòlái.', 'Khi tia nắng vàng đầu tiên của sớm mai rải khắp mặt đất, toàn bộ thành phố dần dần thức giấc.', 'basic', 1),
        (v_id, '她立志在大学毕业后回到家乡山区当一名乡村教师，为贫困山区的教育事业贡献青春力量。', 'Tā lìzhì zài dàxué bìyè hòu huí dào jiāxiāng shānqū dāng yì míng xiāngcūn jiàoshī, wèi pínkùn shānqū de jiàoyù shìyè gòngxiàn qīngchūn lìliang.', 'Cô ấy lập chí sau khi tốt nghiệp đại học sẽ trở về vùng núi quê hương làm một giáo viên làng, cống hiến sức trẻ cho sự nghiệp giáo dục vùng núi nghèo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [当时] (dāngshí) - lúc đó, khi đó, đương thời [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '当时' AND pinyin = 'dāngshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '当时'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dāngshí',
      meaning_vi = 'lúc đó, khi đó, đương thời',
      example_hanzi = '事发当时路上光线昏暗，没有目击证人看清肇事车辆的车牌号码。',
      example_pinyin = 'Shìfā dāngshí lù shang guāngxiàn hūn’àn, méiyǒu mùjī zhèngrén kàn qīng zhàoshì chēliàng de chēpái hàomǎ.',
      example_vi = 'Khi sự việc xảy ra ánh sáng trên đường nhá nhem tối, không có nhân chứng nào nhìn rõ biển số của chiếc xe gây tai nạn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '事发当时路上光线昏暗，没有目击证人看清肇事车辆的车牌号码。', 'Shìfā dāngshí lù shang guāngxiàn hūn’àn, méiyǒu mùjī zhèngrén kàn qīng zhàoshì chēliàng de chēpái hàomǎ.', 'Khi sự việc xảy ra ánh sáng trên đường nhá nhem tối, không có nhân chứng nào nhìn rõ biển số của chiếc xe gây tai nạn.', 'basic', 1),
        (v_id, '面对当时极端复杂的国际金融危机风暴，政府果断出台了一系列行之有效的稳就业扩内需宏观调控政策。', 'Miànduì dāngshí jíduān fùzá de guójì jīnróng wēijī fēngbào, zhèngfǔ guǒduàn chūtái le yí xìliè xíngzhīyǒuxiào de wěn jiùyè kuò nèixū hóngguān tiáokòng zhèngcè.', 'Đứng trước cơn bão khủng hoảng tài chính quốc tế cực kỳ phức tạp vào thời điểm đó, chính phủ đã kiên quyết ban hành một loạt chính sách điều tiết vĩ mô ổn định việc làm và mở rộng tiêu dùng nội địa rất hiệu quả.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [刀] (dāo) - con dao, dao [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '刀' AND pinyin = 'dāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '刀'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dāo',
      meaning_vi = 'con dao, dao',
      example_hanzi = '切水果时请注意拿稳水果刀，小心别割伤了手指。',
      example_pinyin = 'Qiē shuǐguǒ shí qǐng zhùyì ná wěn shuǐguǒ dāo, xiǎoxīn bié gēshāng le shǒuzhǐ.',
      example_vi = 'Khi gọt hoa quả xin chú ý cầm chắc con dao gọt, cẩn thận đừng để cắt vào ngón tay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '切水果时请注意拿稳水果刀，小心别割伤了手指。', 'Qiē shuǐguǒ shí qǐng zhùyì ná wěn shuǐguǒ dāo, xiǎoxīn bié gēshāng le shǒuzhǐ.', 'Khi gọt hoa quả xin chú ý cầm chắc con dao gọt, cẩn thận đừng để cắt vào ngón tay.', 'basic', 1),
        (v_id, '一把做工锋利精良的手术刀，在外科专家沉着精湛的操作下挽救了无数患者的生命。', 'Yì bǎ zuògōng fēnglì jīngliáng de shǒushù dāo, zài wàikē zhuānjiā chénzhuó jīngzhàn de cāozuò xià wǎnjiù le wúshù huànzhě de shēngmìng.', 'Một con dao mổ sắc bén tinh xảo, dưới thao tác điềm tĩnh thuần thục của chuyên gia ngoại khoa đã cứu vớt sinh mệnh của vô số bệnh nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [导游] (dǎoyóu) - hướng dẫn viên du lịch; dẫn tour [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '导游' AND pinyin = 'dǎoyóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '导游'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'dǎoyóu',
      meaning_vi = 'hướng dẫn viên du lịch; dẫn tour',
      example_hanzi = '这位经验丰富的地接导游生动有趣地为大家讲解了古长城的修筑历史。',
      example_pinyin = 'Zhè wèi jīngyàn fēngfù de dìjiē dǎoyóu shēngdòng yǒuqù de wèi dàjiā jiǎngjiě le gǔ Chángchéng de xiūzhù lìshǐ.',
      example_vi = 'Người hướng dẫn viên du lịch địa phương dày dặn kinh nghiệm này đã giảng giải về lịch sử xây dựng Vạn Lý Trường Thành cổ cho mọi người một cách sinh động thú vị.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这位经验丰富的地接导游生动有趣地为大家讲解了古长城的修筑历史。', 'Zhè wèi jīngyàn fēngfù de dìjiē dǎoyóu shēngdòng yǒuqù de wèi dàjiā jiǎngjiě le gǔ Chángchéng de xiūzhù lìshǐ.', 'Người hướng dẫn viên du lịch địa phương dày dặn kinh nghiệm này đã giảng giải về lịch sử xây dựng Vạn Lý Trường Thành cổ cho mọi người một cách sinh động thú vị.', 'basic', 1),
        (v_id, '一名合格优秀的涉外国际导游不仅需要精通两门以上外语，更需要深谙中外文化风俗礼仪。', 'Yì míng hégé yōuxiù de shèwài guójì dǎoyóu bùjǐn xūyào jīngtōng liǎng mén yǐshàng wàiyǔ, gèng xūyào shēn’ān zhōng-wài wénhuà fēngsú lǐyí.', 'Một hướng dẫn viên quốc tế đạt chuẩn ưu tú không chỉ cần thông thạo từ hai ngoại ngữ trở lên, mà càng cần am hiểu sâu sắc phong tục tập quán lễ nghi văn hóa trong và ngoài nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [倒] (dào) - rót (nước), đổ (rác); lùi (xe); đảo ngược [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '倒' AND pinyin = 'dào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '倒'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dào',
      meaning_vi = 'rót (nước), đổ (rác); lùi (xe); đảo ngược',
      example_hanzi = '客人进屋后，主人热情地上前为他倒了一杯热气腾腾的乌龙茶。',
      example_pinyin = 'Kèrén jìn wū hòu, zhǔrén rèqíng de shàngqián wèi tā dào le yì bēi rèqì-téngténg de wūlóngchá.',
      example_vi = 'Sau khi khách vào nhà, chủ nhà nhiệt tình bước tới rót cho anh ấy một chén trà Ô Long nóng hổi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '客人进屋后，主人热情地上前为他倒了一杯热气腾腾的乌龙茶。', 'Kèrén jìn wū hòu, zhǔrén rèqíng de shàngqián wèi tā dào le yì bēi rèqì-téngténg de wūlóngchá.', 'Sau khi khách vào nhà, chủ nhà nhiệt tình bước tới rót cho anh ấy một chén trà Ô Long nóng hổi.', 'basic', 1),
        (v_id, '出门上班前请顺手把厨房门口分类好的生活垃圾倒进小区的指定分类回收箱。', 'Chūmén shàngbān qián qǐng shùnshǒu bǎ chúfáng ménkǒu fēnlèi hǎo de shēnghuó lājī dào jìn xiǎoqū de zhǐdìng fēnlèi huíshōuxiāng.', 'Trước khi ra ngoài đi làm xin thuận tay mang rác sinh hoạt đã phân loại ở cửa bếp đổ vào thùng thu gom phân loại chỉ định của khu dân cư.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [道] (dào) - con đường, đạo lý; món (ăn), câu (hỏi), vệt (ánh sáng) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '道' AND pinyin = 'dào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '道'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'dào',
      meaning_vi = 'con đường, đạo lý; món (ăn), câu (hỏi), vệt (ánh sáng)',
      example_hanzi = '今天的期末考试试卷上一共有五道综合应用数学大题。',
      example_pinyin = 'Jīntiān de qīmò kǎoshì shìjuàn shang yígòng yǒu wǔ dào zōnghé yìngyòng shùxué dàtí.',
      example_vi = 'Trên đề thi học kỳ hôm nay tổng cộng có năm câu hỏi toán học ứng dụng tổng hợp lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天的期末考试试卷上一共有五道综合应用数学大题。', 'Jīntiān de qīmò kǎoshì shìjuàn shang yígòng yǒu wǔ dào zōnghé yìngyòng shùxué dàtí.', 'Trên đề thi học kỳ hôm nay tổng cộng có năm câu hỏi toán học ứng dụng tổng hợp lớn.', 'basic', 1),
        (v_id, '这家具有百年传承历史的鲁菜老字号餐馆，每一道传统名菜都讲究选料精良与火候纯正。', 'Zhè jiā jùyǒu bǎinián chuánchéng lìshǐ de Lǔcài lǎozìhào cānguǎn, měi yí dào chuántǒng míngcài dōu jiǎngjiu xuǎnliào jīngliáng yǔ huǒhou chúnzhèng.', 'Quán ăn ẩm thực Sơn Đông danh tiếng lâu đời hàng trăm năm này, mỗi một món ăn truyền thống nổi tiếng đều chú trọng nguyên liệu tinh chọn và độ lửa chuẩn mực.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [到底] (dàodǐ) - rốt cuộc, suy cho cùng; đến cùng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '到底' AND pinyin = 'dàodǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '到底'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'dàodǐ',
      meaning_vi = 'rốt cuộc, suy cho cùng; đến cùng',
      example_hanzi = '大家讨论了这么久，到底哪一种解决实施方案更加稳妥可行？',
      example_pinyin = 'Dàjiā tǎolùn le zhème jiǔ, dàodǐ nǎ yì zhǒng jiějué shíshī fāng’àn gèngjiā wěntuǒ kěxíng?',
      example_vi = 'Mọi người đã thảo luận lâu như vậy, rốt cuộc phương án thực hiện giải quyết nào ổn thỏa khả thi hơn?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大家讨论了这么久，到底哪一种解决实施方案更加稳妥可行？', 'Dàjiā tǎolùn le zhème jiǔ, dàodǐ nǎ yì zhǒng jiějué shíshī fāng’àn gèngjiā wěntuǒ kěxíng?', 'Mọi người đã thảo luận lâu như vậy, rốt cuộc phương án thực hiện giải quyết nào ổn thỏa khả thi hơn?', 'basic', 1),
        (v_id, '在追求科学真理与学术卓越的崎岖道路上，只有坚持到底永不轻言放弃的人才能领略巅峰的无限风光。', 'Zài zhuīqiú kēxué zhēnlǐ yǔ xuéshù zhuóyuè de qíqū dàolù shang, zhǐyào jiānchí dàodǐ yǒng bù qīngyán fàngqì de rén cái néng lǐnglüè diānfēng de wúxiàn fēngguāng.', 'Trên con đường gập ghềnh theo đuổi chân lý khoa học và sự xuất sắc học thuật, chỉ người kiên trì đến cùng không bao giờ nói từ bỏ mới có thể chiêm ngưỡng phong cảnh vô tận nơi đỉnh cao.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [到来] (dàolái) - đến, tới (thời điểm, sự kiện) [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '到来' AND pinyin = 'dàolái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '到来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'dàolái',
      meaning_vi = 'đến, tới (thời điểm, sự kiện)',
      example_hanzi = '春天的到来让漫山遍野的大地重新换上了生机勃勃的绿装。',
      example_pinyin = 'Chūntiān de dàolái ràng mànshān-biànyě de dàdì chóngxīn huàn shàng le shēngjī-bóbó de lǜzhuāng.',
      example_vi = 'Mùa xuân tới khiến mặt đất khắp núi đồi bạt ngàn lại khoác lên mình chiếc áo xanh căng tràn sức sống.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '春天的到来让漫山遍野的大地重新换上了生机勃勃的绿装。', 'Chūntiān de dàolái ràng mànshān-biànyě de dàdì chóngxīn huàn shàng le shēngjī-bóbó de lǜzhuāng.', 'Mùa xuân tới khiến mặt đất khắp núi đồi bạt ngàn lại khoác lên mình chiếc áo xanh căng tràn sức sống.', 'basic', 1),
        (v_id, '全校师生满怀喜悦与激动之情，在礼堂热烈欢迎远道而来的国际友好交流代表团。', 'Quán xiào shīshēng mǎnhuái xǐyuè yǔ jīdòng zhī qíng, zài lǐtáng rèliè huānyíng yuǎndào’érlái de guójì yǒuhǎo jiāoliú dàibiǎotuán.', 'Toàn thể thầy trò trong trường tràn ngập niềm vui và sự xúc động, nồng nhiệt chào đón đoàn đại biểu giao lưu hữu nghị quốc tế từ phương xa tới thăm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [道路] (dàolù) - con đường, tuyến đường, lộ trình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '道路' AND pinyin = 'dàolù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '道路'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dàolù',
      meaning_vi = 'con đường, tuyến đường, lộ trình',
      example_hanzi = '暴风雪过后，市政除雪工人正在全力以赴清理道路上的结冰积雪。',
      example_pinyin = 'Bàofēngxuě guòhòu, shìzhèng chúxuě gōngrén zhèngzài quánlì-yǐfù qīnglǐ dàolù shang de jiébīng jīxuě.',
      example_vi = 'Sau trận bão tuyết, các công nhân dọn tuyết của đô thị đang dốc toàn lực dọn dẹp băng đóng và tuyết đọng trên mặt đường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '暴风雪过后，市政除雪工人正在全力以赴清理道路上的结冰积雪。', 'Bàofēngxuě guòhòu, shìzhèng chúxuě gōngrén zhèngzài quánlì-yǐfù qīnglǐ dàolù shang de jiébīng jīxuě.', 'Sau trận bão tuyết, các công nhân dọn tuyết của đô thị đang dốc toàn lực dọn dẹp băng đóng và tuyết đọng trên mặt đường.', 'basic', 1),
        (v_id, '中国坚定不移地奉行独立自主的和平外交政策，坚定不移走和平发展道路。', 'Zhōngguó jiāndìng-bùyí de fèngxíng dúlì-zìzhǔ de hépíng wàijiāo zhèngcè, jiāndìng-bùyí zǒu hépíng fāzhǎn dàolù.', 'Trung Quốc kiên định không dời thực thi chính sách đối ngoại hòa bình độc lập tự chủ, kiên định không dời bước đi trên con đường phát triển hòa bình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [道歉] (dàoqiàn) - xin lỗi, tạ lỗi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '道歉' AND pinyin = 'dàoqiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '道歉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dàoqiàn',
      meaning_vi = 'xin lỗi, tạ lỗi',
      example_hanzi = '他不小心打碎了借来的花瓶，连忙向房东诚恳地道歉。',
      example_pinyin = 'Tā bù xiǎoxīn dǎ suì le jiè lái de huāpíng, liánmáng xiàng fángdōng chéngkěn de dàoqiàn.',
      example_vi = 'Cậu ấy lỡ tay làm vỡ chiếc bình hoa mượn của chủ nhà, vội vàng xin lỗi chân thành.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他不小心打碎了借来的花瓶，连忙向房东诚恳地道歉。', 'Tā bù xiǎoxīn dǎ suì le jiè lái de huāpíng, liánmáng xiàng fángdōng chéngkěn de dàoqiàn.', 'Cậu ấy lỡ tay làm vỡ chiếc bình hoa mượn của chủ nhà, vội vàng xin lỗi chân thành.', 'basic', 1),
        (v_id, '主动向因自身过失而受到伤害的人公开赔礼道歉，不仅需要真诚的勇气，更是成熟担当的体现。', 'Zhǔdòng xiàng yīn zìshēn guòshī ér shòudào shānghài de rén gōngkāi péilǐ dàoqiàn, bùjǐn xūyào zhēnchéng de yǒngqì, gèng shì chéngshú dāndāng de tǐxiàn.', 'Chủ động công khai tạ lỗi xin lỗi với người bị tổn thương bởi sai sót của bản thân không chỉ đòi hỏi sự dũng cảm chân thành mà càng là biểu hiện của tinh thần gánh vác trưởng thành.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [得意] (déyì) - đắc ý, đắc chí, tự hào [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '得意' AND pinyin = 'déyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '得意'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'déyì',
      meaning_vi = 'đắc ý, đắc chí, tự hào',
      example_hanzi = '看到自己的画作在比赛中荣获一等奖，他脸上露出了得意的笑容。',
      example_pinyin = 'Kàn dào zìjǐ de huàzuò zài bǐsài zhōng rónghuò yīděngjiǎng, tā liǎn shang lù chū le déyì de xiàoróng.',
      example_vi = 'Nhìn thấy tác phẩm hội họa của mình vinh dự đoạt giải nhất trong cuộc thi, trên gương mặt cậu ấy nở nụ cười đắc ý.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '看到自己的画作在比赛中荣获一等奖，他脸上露出了得意的笑容。', 'Kàn dào zìjǐ de huàzuò zài bǐsài zhōng rónghuò yīděngjiǎng, tā liǎn shang lù chū le déyì de xiàoróng.', 'Nhìn thấy tác phẩm hội họa của mình vinh dự đoạt giải nhất trong cuộc thi, trên gương mặt cậu ấy nở nụ cười đắc ý.', 'basic', 1),
        (v_id, '取得阶段性的优异成绩固然可喜，但切不可骄傲自满忘乎所以，洋洋得意往往容易导致后劲不足。', 'Qǔdé jiēduànxìng de yōuyì chéngjì gùrán kěxǐ, dàn qiè bù kě jiāo’ào-zìmǎn wànghū-suǒyǐ, yángyáng-déyì wǎngwǎng róngyì dǎozhì hòujìn bùzú.', 'Đạt được thành tích xuất sắc giai đoạn dẫu đáng mừng, nhưng tuyệt đối không được kiêu ngạo tự mãn quên hết tất cả, đắc ý vênh váo thường dễ dẫn đến hụt hơi về sau.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [登机] (dēngjī) - lên máy bay [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '登机' AND pinyin = 'dēngjī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '登机'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dēngjī',
      meaning_vi = 'lên máy bay',
      example_hanzi = '请飞往东京的乘客携带好随身行李前往第十二号登机口登机。',
      example_pinyin = 'Qǐng fēi wǎng Dōngjīng de chéngkè xiédài hǎo suíshēn xíngli qiánwǎng dì shí’èr hào dēngjīkǒu dēngjī.',
      example_vi = 'Xin các hành khách bay đi Tokyo mang theo hành lý xách tay tới cửa số 12 để lên máy bay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请飞往东京的乘客携带好随身行李前往第十二号登机口登机。', 'Qǐng fēi wǎng Dōngjīng de chéngkè xiédài hǎo suíshēn xíngli qiánwǎng dì shí’èr hào dēngjīkǒu dēngjī.', 'Xin các hành khách bay đi Tokyo mang theo hành lý xách tay tới cửa số 12 để lên máy bay.', 'basic', 1),
        (v_id, '国际航班通常在起飞前半小时准时关闭登机口，请各位旅客合理规划好市内交通时间提前到达机场。', 'Guójì hángbān tōngcháng zài qǐfēi qián bàn xiǎoshí zhǔnshí guānbì dēngjīkǒu, qǐng gèwèi lǚkè hélǐ guīhuà hǎo shìnèi jiāotōng shíjiān tíqián dàodá jīchǎng.', 'Các chuyến bay quốc tế thông thường sẽ đóng cửa lên máy bay trước giờ cất cánh nửa tiếng, xin quý khách thu xếp giờ giấc đi lại trong thành phố hợp lý để tới sân bay sớm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [等] (děng) - vân vân (liệt kê); đợi, chờ [Trợ từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '等' AND pinyin = 'děng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '等'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Trợ từ / Động từ',
      pinyin = 'děng',
      meaning_vi = 'vân vân (liệt kê); đợi, chờ',
      example_hanzi = '超市里陈列着苹果、香蕉、橙子、西瓜等各种新鲜应季水果。',
      example_pinyin = 'Chāoshì lǐ chénliè zhe píngguǒ, xiāngjiāo, chéngzi, xīguā děng gè zhǒng xīnxiān yìngjì shuǐguǒ.',
      example_vi = 'Trong siêu thị bày la liệt các loại hoa quả tươi đúng mùa như táo, chuối, cam, dưa hấu, v.v.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '超市里陈列着苹果、香蕉、橙子、西瓜等各种新鲜应季水果。', 'Chāoshì lǐ chénliè zhe píngguǒ, xiāngjiāo, chéngzi, xīguā děng gè zhǒng xīnxiān yìngjì shuǐguǒ.', 'Trong siêu thị bày la liệt các loại hoa quả tươi đúng mùa như táo, chuối, cam, dưa hấu, v.v.', 'basic', 1),
        (v_id, '该学术研讨会深入探讨了人工智能、大数据、云计算等前沿数字技术在未来智慧医疗领域的创新融合应用。', 'Gāi xuéshù yántǎohuì shēnrù tàntǎo le réngōng zhìnéng, dàshùjù, yúnjìsuàn děng qiányán shùzì jìshù zài wèilái zhìhuì yīliáo lǐngyù de chuàngxīn rónghé yìngyòng.', 'Hội thảo học thuật này đã đi sâu thảo luận về sự ứng dụng tích hợp đổi mới sáng tạo của các công nghệ số tiên phong như trí tuệ nhân tạo, dữ liệu lớn, điện toán đám mây v.v. trong lĩnh vực y tế thông minh tương lai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [等到] (děngdào) - đợi đến khi, chờ tới lúc [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '等到' AND pinyin = 'děngdào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '等到'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'děngdào',
      meaning_vi = 'đợi đến khi, chờ tới lúc',
      example_hanzi = '等到今年暑假放假的时候，我一定要回老家看望亲爱的爷爷奶奶。',
      example_pinyin = 'Děngdào jīnnián shǔjià fàngjià de shíhou, wǒ yídìng yào huí lǎojiā kànwàng qīn’ài de yéye nǎinai.',
      example_vi = 'Chờ đến khi kỳ nghỉ hè năm nay bắt đầu, tôi nhất định sẽ về quê thăm ông bà nội kính yêu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '等到今年暑假放假的时候，我一定要回老家看望亲爱的爷爷奶奶。', 'Děngdào jīnnián shǔjià fàngjià de shíhou, wǒ yídìng yào huí lǎojiā kànwàng qīn’ài de yéye nǎinai.', 'Chờ đến khi kỳ nghỉ hè năm nay bắt đầu, tôi nhất định sẽ về quê thăm ông bà nội kính yêu.', 'basic', 1),
        (v_id, '不要总是把重要的事情无限期拖延，不要等到问题积重难返才追悔莫及。', 'Bú yào zǒngshì bǎ zhòngyào de shìqing wúxiànqī tuōyán, bú yào děngdào wèntí jīzhòng-nánfǎn cái zhuīhuǐ-mòjí.', 'Đừng bao giờ trì hoãn những công việc trọng đại vô thời hạn, đừng chờ đến lúc vấn đề chồng chất khó giải quyết mới hối hận khôn nguôi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [低] (dī) - thấp; cúi, hạ thấp [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '低' AND pinyin = 'dī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '低'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'dī',
      meaning_vi = 'thấp; cúi, hạ thấp',
      example_hanzi = '由于这几天气温很低，外出时一定要多穿几件防寒外套。',
      example_pinyin = 'Yóuyú zhè jǐ tiān qìwēn hěn dī, wàichū shí yídìng yào duō chuān jǐ jiàn fánghán wàitào.',
      example_vi = 'Do nhiệt độ mấy ngày nay rất thấp, khi ra ngoài nhất định phải mặc thêm vài chiếc áo khoác ấm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '由于这几天气温很低，外出时一定要多穿几件防寒外套。', 'Yóuyú zhè jǐ tiān qìwēn hěn dī, wàichū shí yídìng yào duō chuān jǐ jiàn fánghán wàitào.', 'Do nhiệt độ mấy ngày nay rất thấp, khi ra ngoài nhất định phải mặc thêm vài chiếc áo khoác ấm.', 'basic', 1),
        (v_id, '听到老师当众指出自己的缺点与失误，他惭愧地低下了头，下定决心努力改正。', 'Tīng dào lǎoshī dāngzhòng zhǐchū zìjǐ de quēdiǎn yǔ shīwù, tā cánkuì de dī xià le tóu, xiàdìng juéxīn nǔlì gǎizhèng.', 'Nghe thầy giáo chỉ ra khuyết điểm và sai sót của mình trước lớp, cậu ấy xấu hổ cúi gằm đầu xuống, hạ quyết tâm cố gắng sửa đổi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [低价] (dījià) - giá thấp, giá rẻ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '低价' AND pinyin = 'dījià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '低价'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dījià',
      meaning_vi = 'giá thấp, giá rẻ',
      example_hanzi = '这家批发市场以低价薄利多销的经营模式吸引了成千上万的小商贩。',
      example_pinyin = 'Zhè jiā pīfā shìchǎng yǐ dījià bólì-duōxiāo de jīngyíng móshì xīyǐn le chéngqiān-shàngwàn de xiǎoshāngfàn.',
      example_vi = 'Khu chợ đầu mối bán buôn này thu hút hàng ngàn hàng vạn tiểu thương nhờ mô hình kinh doanh giá rẻ lấy lãi ít bán nhiều.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家批发市场以低价薄利多销的经营模式吸引了成千上万的小商贩。', 'Zhè jiā pīfā shìchǎng yǐ dījià bólì-duōxiāo de jīngyíng móshì xīyǐn le chéngqiān-shàngwàn de xiǎoshāngfàn.', 'Khu chợ đầu mối bán buôn này thu hút hàng ngàn hàng vạn tiểu thương nhờ mô hình kinh doanh giá rẻ lấy lãi ít bán nhiều.', 'basic', 1),
        (v_id, '消费者在网上选购低价促销电子数码产品时，应当格外警惕假冒伪劣以及翻新机陷阱。', 'Xiāofèizhě zài wǎngshang xuǎngòu dījià cùxiāo diànzǐ shùmǎ chǎnpǐn shí, yīngdāng géwài jǐngtì jiǎmào-wěiliè yǐjí fānxīnjī xiànjǐng.', 'Người tiêu dùng khi chọn mua các sản phẩm kỹ thuật số điện tử giá rẻ khuyến mãi trên mạng nên hết sức cảnh giác với hàng giả hàng nhái cũng như cạm bẫy máy tân trang lại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [低温] (dīwēn) - nhiệt độ thấp, nhiệt độ giá lạnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '低温' AND pinyin = 'dīwēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '低温'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dīwēn',
      meaning_vi = 'nhiệt độ thấp, nhiệt độ giá lạnh',
      example_hanzi = '北方地区入冬之后经常遭遇连续多天的零下极度低温严寒天气。',
      example_pinyin = 'Běifāng dìqū rù dōng zhīhòu jīngcháng zāoyù liánxù duō tiān de língxià jídù dīwēn yánhán tiānqì.',
      example_vi = 'Khu vực miền Bắc sau khi vào đông thường gặp phải thời tiết giá rét nhiệt độ cực thấp dưới 0 độ kéo dài nhiều ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '北方地区入冬之后经常遭遇连续多天的零下极度低温严寒天气。', 'Běifāng dìqū rù dōng zhīhòu jīngcháng zāoyù liánxù duō tiān de língxià jídù dīwēn yánhán tiānqì.', 'Khu vực miền Bắc sau khi vào đông thường gặp phải thời tiết giá rét nhiệt độ cực thấp dưới 0 độ kéo dài nhiều ngày.', 'basic', 1),
        (v_id, '这批生物医用疫苗在长途运输和仓储保管过程中，必须全程放置于零下七十度的特种低温冷链环境中。', 'Zhè pī shēngwù yīyòng yìmiáo zài chángtú yùnshū hé cāngchǔ bǎoguǎn guòchéng zhōng, bìxū quánchéng fàngzhì yú língxià qīshí dù de tèzhǒng dīwēn lěngliàn huánjìng zhōng.', 'Lô vắc xin y sinh này trong quá trình vận chuyển đường dài và lưu kho bảo quản bắt buộc phải đặt trong môi trường chuỗi lạnh nhiệt độ thấp đặc chủng âm bảy mươi độ C.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [低于] (dīyú) - thấp hơn, dưới [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '低于' AND pinyin = 'dīyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '低于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dīyú',
      meaning_vi = 'thấp hơn, dưới',
      example_hanzi = '今天夜间市区的最低气温预计将低于零摄氏度。',
      example_pinyin = 'Jīntiān yèjiān shìqū de zuìdī qìwēn yùjì jiāng dīyú líng shèshìdù.',
      example_vi = 'Dự báo nhiệt độ thấp nhất trong nội thành đêm nay sẽ xuống dưới không độ C.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天夜间市区的最低气温预计将低于零摄氏度。', 'Jīntiān yèjiān shìqū de zuìdī qìwēn yùjì jiāng dīyú líng shèshìdù.', 'Dự báo nhiệt độ thấp nhất trong nội thành đêm nay sẽ xuống dưới không độ C.', 'basic', 1),
        (v_id, '凡是考试综合总成绩低于及格基准线的考生，必须参加下学期初统一组织的重考补考。', 'Fánshì kǎoshì zōnghé zǒng chéngjì dīyú jígé jīzhǔnxiàn de kǎoshēng, bìxū cānjiā xià xuéqī chū tǒngyī zǔzhī de chóngkǎo bǔkǎo.', 'Hễ thí sinh nào có tổng điểm thi tổng hợp dưới điểm chuẩn đạt yêu cầu đều bắt buộc phải tham gia kỳ thi lại tổ chức tập trung vào đầu học kỳ sau.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [底] (dǐ) - đáy, phần dưới, cuối (tháng, năm) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '底' AND pinyin = 'dǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '底'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dǐ',
      meaning_vi = 'đáy, phần dưới, cuối (tháng, năm)',
      example_hanzi = '清澈见底的湖水里，一群群五彩斑斓的小鱼正在欢快地游来游去。',
      example_pinyin = 'Qīngchè jiàn dǐ de húshuǐ lǐ, yì qúnqún wǔcǎi-bānlán de xiǎoyú zhèngzài huānkuài de yóulái-yóuqù.',
      example_vi = 'Trong làn nước hồ trong vắt nhìn thấu tận đáy, từng đàn cá nhỏ sặc sỡ sắc màu đang vui vẻ bơi qua bơi lại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '清澈见底的湖水里，一群群五彩斑斓的小鱼正在欢快地游来游去。', 'Qīngchè jiàn dǐ de húshuǐ lǐ, yì qúnqún wǔcǎi-bānlán de xiǎoyú zhèngzài huānkuài de yóulái-yóuqù.', 'Trong làn nước hồ trong vắt nhìn thấu tận đáy, từng đàn cá nhỏ sặc sỡ sắc màu đang vui vẻ bơi qua bơi lại.', 'basic', 1),
        (v_id, '每到接近年底的收尾阶段，公司财务部门都要连夜加班对全年的账目进行系统结算审计。', 'Měi dào jiējìn niándǐ de shōuwěi jiēduàn, gōngsī cáiwù bùmén dōu yào liányè jiābān duì quán nián de zhàngmù jìnxíng xìtǒng jiésuàn shěnjì.', 'Mỗi khi tới giai đoạn chốt sổ cuối năm, phòng tài chính công ty đều phải tăng ca thâu đêm để quyết toán kiểm toán có hệ thống các sổ sách cả năm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [底下] (dǐxia) - dưới, bên dưới, phía dưới [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '底下' AND pinyin = 'dǐxia'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '底下'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dǐxia',
      meaning_vi = 'dưới, bên dưới, phía dưới',
      example_hanzi = '可爱的小花猫正蜷缩在客厅的木桌底下香甜地打瞌睡。',
      example_pinyin = 'Kě’ài de xiǎohuāmāo zhèng quánsuō zài kètīng de mùzhuō dǐxia xiāngtián de dǎkēshuì.',
      example_vi = 'Chú mèo hoa đáng yêu đang cuộn tròn dưới gầm bàn gỗ phòng khách ngủ gật ngon lành.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '可爱的小花猫正蜷缩在客厅的木桌底下香甜地打瞌睡。', 'Kě’ài de xiǎohuāmāo zhèng quánsuō zài kètīng de mùzhuō dǐxia xiāngtián de dǎkēshuì.', 'Chú mèo hoa đáng yêu đang cuộn tròn dưới gầm bàn gỗ phòng khách ngủ gật ngon lành.', 'basic', 1),
        (v_id, '烈日当空的中午，工人们坐在高大浓密的绿树底下乘凉避暑，畅谈着家长里短。', 'Lièrì dāngkōng de zhōngwǔ, gōngrénmen zuò zài gāodà nóngmì de lǜshù dǐxia chéngliáng bìshǔ, chàngtán zhe jiācháng-lǐduǎn.', 'Buổi trưa nắng gắt chang chang trên đầu, các công nhân ngồi dưới tán cây xanh rợp bóng mát mẻ hóng gió tránh nóng, rôm rả trò chuyện chuyện nhà chuyện cửa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [地球] (dìqiú) - Trái Đất, địa cầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '地球' AND pinyin = 'dìqiú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '地球'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dìqiú',
      meaning_vi = 'Trái Đất, địa cầu',
      example_hanzi = '地球是目前已知全宇宙中唯一孕育着丰富智慧生命的蓝色星球。',
      example_pinyin = 'Dìqiú shì mùqián yǐzhī quán yǔzhòu zhōng wéiyī yùnyù zhe fēngfù zhìhuì shēngmìng de lánsè xīngqiú.',
      example_vi = 'Trái Đất là hành tinh xanh duy nhất nuôi dưỡng sự sống thông minh phong phú trong toàn vũ trụ được biết tới hiện nay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '地球是目前已知全宇宙中唯一孕育着丰富智慧生命的蓝色星球。', 'Dìqiú shì mùqián yǐzhī quán yǔzhòu zhōng wéiyī yùnyù zhe fēngfù zhìhuì shēngmìng de lánsè xīngqiú.', 'Trái Đất là hành tinh xanh duy nhất nuôi dưỡng sự sống thông minh phong phú trong toàn vũ trụ được biết tới hiện nay.', 'basic', 1),
        (v_id, '保护地球生态平衡是关乎人类文明兴衰存亡的宏伟伟业，需要全世界各国携手同舟共济。', 'Bǎohù dìqiú shēngtài pínghéng shì guānhū rénlèi wénmíng xīngshuāi cúnwáng de hóngwěi wěiyè, xūyào quán shìjiè gè guó xiéshǒu tóngzhōu-gòngjì.', 'Bảo vệ cân bằng sinh thái Trái Đất là sự nghiệp vĩ đại liên quan tới sự hưng vong mất còn của văn minh nhân loại, đòi hỏi các quốc gia trên toàn thế giới cùng chung tay đồng cam cộng khổ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [地址] (dìzhǐ) - địa chỉ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '地址' AND pinyin = 'dìzhǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '地址'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dìzhǐ',
      meaning_vi = 'địa chỉ',
      example_hanzi = '请把您接收快递包裹的详细家庭住址发送给我。',
      example_pinyin = 'Qǐng bǎ nín jiēshōu kuàidì bāoguǒ de xiángxì jiātíng zhùzhǐ fāsòng gěi wǒ.',
      example_vi = 'Xin hãy gửi địa chỉ nhà ở chi tiết để nhận bưu kiện chuyển phát nhanh cho tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把您接收快递包裹的详细家庭住址发送给我。', 'Qǐng bǎ nín jiēshōu kuàidì bāoguǒ de xiángxì jiātíng zhùzhǐ fāsòng gěi wǒ.', 'Xin hãy gửi địa chỉ nhà ở chi tiết để nhận bưu kiện chuyển phát nhanh cho tôi.', 'basic', 1),
        (v_id, '在电商平台提交网购订单结算之前，务必仔细核对收件人姓名、联系电话以及送货具体地址。', 'Zài diànshāng píngtái tíjiāo wǎnggòu dìngdān jiésuàn zhīqián, wùbì zǐxì héduì shōujiànrén xìngmíng, liánxì diànhuà yǐjí sònghuò jùtǐ dìzhǐ.', 'Trước khi gửi đơn đặt hàng mua sắm qua mạng trên sàn thương mại điện tử để thanh toán, nhất thiết phải đối soát kỹ tên người nhận, số điện thoại liên hệ và địa chỉ giao hàng cụ thể.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [点名] (diǎnmíng) - điểm danh; gọi tên đích danh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '点名' AND pinyin = 'diǎnmíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '点名'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'diǎnmíng',
      meaning_vi = 'điểm danh; gọi tên đích danh',
      example_hanzi = '上课铃声响起后，任课老师开始按照学生花名册逐一点名。',
      example_pinyin = 'Shàngkè língshēng xiǎngqǐ hòu, rènkè lǎoshī kāishǐ ànzhào xuésheng huāmíngcè zhúyī diǎnmíng.',
      example_vi = 'Sau khi chuông vào lớp vang lên, thầy giáo phụ trách bắt đầu điểm danh từng người một theo danh sách học sinh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '上课铃声响起后，任课老师开始按照学生花名册逐一点名。', 'Shàngkè língshēng xiǎngqǐ hòu, rènkè lǎoshī kāishǐ ànzhào xuésheng huāmíngcè zhúyī diǎnmíng.', 'Sau khi chuông vào lớp vang lên, thầy giáo phụ trách bắt đầu điểm danh từng người một theo danh sách học sinh.', 'basic', 1),
        (v_id, '大型早会准时开始前，各部门负责人逐一核对员工到岗出勤情况并进行考勤点名。', 'Dàxíng zǎohuì zhǔnshí kāishǐ qián, gè bùmén fùzérén zhúyī héduì yuángōng dàogǎng chūqín qíngkuàng bìng jìnxíng kǎoqín diǎnmíng.', 'Trước khi cuộc họp giao ban sáng lớn bắt đầu đúng giờ, người phụ trách các bộ phận lần lượt kiểm tra tình hình nhân viên có mặt đi làm và tiến hành điểm danh chấm công.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [点头] (diǎntóu) - gật đầu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '点头' AND pinyin = 'diǎntóu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '点头'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'diǎntóu',
      meaning_vi = 'gật đầu',
      example_hanzi = '听完我的建议后，他微笑着用力点了点头表示赞同。',
      example_pinyin = 'Tīng wán wǒ de jiànyì hòu, tā wēixiào zhe yònglì diǎn le diǎn tóu biǎoshì zàntóng.',
      example_vi = 'Nghe xong đề xuất của tôi, anh ấy mỉm cười gật gật đầu mạnh mẽ tỏ ý tán thành.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '听完我的建议后，他微笑着用力点了点头表示赞同。', 'Tīng wán wǒ de jiànyì hòu, tā wēixiào zhe yònglì diǎn le diǎn tóu biǎoshì zàntóng.', 'Nghe xong đề xuất của tôi, anh ấy mỉm cười gật gật đầu mạnh mẽ tỏ ý tán thành.', 'basic', 1),
        (v_id, '在许多跨文化商务交流场合中，恰到好处的微笑与点头致意能够迅速化解彼此初次相识的尴尬。', 'Zài xǔduō kuà-wénhuà shāngwù jiāoliú chǎnghé zhōng, qiàdàohǎochù de wēixiào yǔ diǎntóu zhìyì nénggòu xùnsù huàjiě bǐcǐ chūcì xiāngshí de gāngà.', 'Trong nhiều hoàn cảnh giao tiếp thương mại xuyên văn hóa, nụ cười và cái gật đầu chào đúng mực có thể nhanh chóng xua tan sự ngượng ngùng khi lần đầu gặp gỡ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [电动车] (diàndòngchē) - xe đạp điện, xe máy điện, xe điện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '电动车' AND pinyin = 'diàndòngchē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '电动车'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'diàndòngchē',
      meaning_vi = 'xe đạp điện, xe máy điện, xe điện',
      example_hanzi = '他每天骑着小巧轻便的电动车穿梭于大街小巷上下班。',
      example_pinyin = 'Tā měitiān qí zhe xiǎoqiǎo qīngbiàn de diàndòngchē chuānsuō yú dàjiē-xiǎoxiàng shàng-xiàbān.',
      example_vi = 'Hàng ngày anh ấy đi chiếc xe điện nhỏ nhắn nhẹ nhàng luồn lách qua các phố lớn ngõ nhỏ đi làm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他每天骑着小巧轻便的电动车穿梭于大街小巷上下班。', 'Tā měitiān qí zhe xiǎoqiǎo qīngbiàn de diàndòngchē chuānsuō yú dàjiē-xiǎoxiàng shàng-xiàbān.', 'Hàng ngày anh ấy đi chiếc xe điện nhỏ nhắn nhẹ nhàng luồn lách qua các phố lớn ngõ nhỏ đi làm.', 'basic', 1),
        (v_id, '随着绿色低碳出行理念深入人心，以清洁电能为动力的两轮电动车已经成为市民短途通勤的主力工具。', 'Suízhe lǜsè dītàn chūxíng lǐniàn shēnrù-rénxīn, yǐ qīngjié diànnéng wéi dònglì de liǎnglún diàndòngchē yǐjīng chéngwéi shìmín duǎntú tōngqín de zhǔlì gōngjù.', 'Khi quan niệm đi lại xanh phát thải thấp thấm sâu vào lòng người, xe điện hai bánh chạy bằng điện năng sạch đã trở thành công cụ chủ lực đi lại cự ly ngắn của người dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [电视剧] (diànshìjù) - phim truyền hình, phim bộ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '电视剧' AND pinyin = 'diànshìjù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '电视剧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'diànshìjù',
      meaning_vi = 'phim truyền hình, phim bộ',
      example_hanzi = '晚饭后一家人围坐在客厅电视机前看精彩的电视剧。',
      example_pinyin = 'Wǎnfàn hòu yì jiā rén wéizuò zài kètīng diànshìjī qián kàn jīngcǎi de diànshìjù.',
      example_vi = 'Sau bữa tối cả nhà quây quần ngồi trước chiếc ti vi phòng khách xem bộ phim truyền hình hấp dẫn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '晚饭后一家人围坐在客厅电视机前看精彩的电视剧。', 'Wǎnfàn hòu yì jiā rén wéizuò zài kètīng diànshìjī qián kàn jīngcǎi de diànshìjù.', 'Sau bữa tối cả nhà quây quần ngồi trước chiếc ti vi phòng khách xem bộ phim truyền hình hấp dẫn.', 'basic', 1),
        (v_id, '这部改编自同名畅销历史小说的长篇历史题材电视剧，剧情跌宕起伏，自开播以来收视率一路领跑。', 'Zhè bù gǎibiān zì tóngmíng chàngxiāo lìshǐ xiǎoshuō de chángpiān lìshǐ tícái diànshìjù, jùqíng diēdàng-qǐfú, zì kāibō yǐlái shōushìlǜ yílù lǐngpǎo.', 'Bộ phim truyền hình dài tập đề tài lịch sử được chuyển thể từ tiểu thuyết lịch sử ăn khách cùng tên này có cốt truyện thăng trầm lôi cuốn, kể từ khi phát sóng tỷ suất người xem luôn dẫn đầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [掉] (diào) - rơi, rớt; mất, tụt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '掉' AND pinyin = 'diào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '掉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'diào',
      meaning_vi = 'rơi, rớt; mất, tụt',
      example_hanzi = '秋风吹过，枯黄的树叶纷纷从枝头掉落下来。',
      example_pinyin = 'Qiūfēng chuī guò, kūhuáng de shùyè fēnfēn cóng zhītóu diàoluò xiàlái.',
      example_vi = 'Gió thu thổi qua, những chiếc lá vàng úa lần lượt từ trên cành cây rơi rụng xuống.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '秋风吹过，枯黄的树叶纷纷从枝头掉落下来。', 'Qiūfēng chuī guò, kūhuáng de shùyè fēnfēn cóng zhītóu diàoluò xiàlái.', 'Gió thu thổi qua, những chiếc lá vàng úa lần lượt từ trên cành cây rơi rụng xuống.', 'basic', 1),
        (v_id, '由于平时忙于日常琐碎应酬而疏忽了系统复习，他的综合测试排名一下子掉了好几名。', 'Yóuyú píngshí mángyú rìcháng suǒsuì yìngchóu ér shūhū le xìtǒng fùxí, tā de zōnghé cèshì páimíng yíxiàzi diào le hǎo jǐ míng.', 'Do ngày thường bận rộn tiệc tùng tiếp khách vụn vặt mà lơ là việc ôn tập có hệ thống, thứ hạng kiểm tra tổng hợp của cậu ấy bỗng chốc tụt mất mấy bậc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [调查] (diàochá) - điều tra, khảo sát; cuộc điều tra [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '调查' AND pinyin = 'diàochá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '调查'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'diàochá',
      meaning_vi = 'điều tra, khảo sát; cuộc điều tra',
      example_hanzi = '市场研究团队正在针对消费者的购买习惯开展问卷调查。',
      example_pinyin = 'Shìchǎng yánjiū tuánduì zhèngzài zhēnduì xiāofèizhě de gòumǎi xíguàn kāizhǎn wènjuàn diàochá.',
      example_vi = 'Nhóm nghiên cứu thị trường đang triển khai cuộc khảo sát bằng bảng hỏi hướng tới thói quen mua sắm của người tiêu dùng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '市场研究团队正在针对消费者的购买习惯开展问卷调查。', 'Shìchǎng yánjiū tuánduì zhèngzài zhēnduì xiāofèizhě de gòumǎi xíguàn kāizhǎn wènjuàn diàochá.', 'Nhóm nghiên cứu thị trường đang triển khai cuộc khảo sát bằng bảng hỏi hướng tới thói quen mua sắm của người tiêu dùng.', 'basic', 1),
        (v_id, '深入基层开展实事求是的实地调查研究，是制定切实可行宏观决策的重要先决前提。', 'Shēnrù jīcéng kāizhǎn shíshìqiúshì de shídì diàochá yánjiū, shì zhìdìng qièshí kěxíng hóngguān juécè de zhòngyào xiānjué qiántí.', 'Đi sâu xuống cơ sở triển khai điều tra nghiên cứu thực địa cầu thị là tiền đề tiên quyết trọng đại để hoạch định các quyết sách vĩ mô thiết thực khả thi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [订] (dìng) - đặt trước (vé, phòng, hàng hóa) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '订' AND pinyin = 'dìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '订'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dìng',
      meaning_vi = 'đặt trước (vé, phòng, hàng hóa)',
      example_hanzi = '我们已经提前在网上订好了下周去三亚度假的双人往返机票。',
      example_pinyin = 'Wǒmen yǐjīng tíqián zài wǎngshang dìng hǎo le xià zhōu qù Sānyà dùjià de shuāngrén wǎngfǎn jīpiào.',
      example_vi = 'Chúng tôi đã đặt trước trên mạng vé máy bay khứ hồi đôi đi Tam Á nghỉ mát tuần tới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们已经提前在网上订好了下周去三亚度假的双人往返机票。', 'Wǒmen yǐjīng tíqián zài wǎngshang dìng hǎo le xià zhōu qù Sānyà dùjià de shuāngrén wǎngfǎn jīpiào.', 'Chúng tôi đã đặt trước trên mạng vé máy bay khứ hồi đôi đi Tam Á nghỉ mát tuần tới.', 'basic', 1),
        (v_id, '黄金周旅游旺季来临之前，各大热门风景名胜区周边的高品质精品民宿早已被游客预订一空。', 'Huángjīnzhōu lǚyóu wàngjì láilín zhīqián, gè dà rèmén fēngjǐng míngshèngqū zhōubiān de gāo pǐnzhì jīngpǐn mínsù zǎoyǐ bèi yóukè yùdìng yì kōng.', 'Trước khi mùa cao điểm du lịch tuần lễ vàng tới, các homestay cao cấp tinh chọn quanh các danh lam thắng cảnh đắt khách từ lâu đã được du khách đặt trước sạch trơn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [定] (dìng) - ấn định, quyết định, quy định [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '定' AND pinyin = 'dìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dìng',
      meaning_vi = 'ấn định, quyết định, quy định',
      example_hanzi = '双方商定于下周三上午在公司会议室正式签署战略合作协议。',
      example_pinyin = 'Shuāngfāng shāngdìng yú xià zhōusān shàngwǔ zài gōngsī huìyìshì zhèngshì qiānshǔ zhànlüè hézuò xiéyì.',
      example_vi = 'Hai bên thỏa thuận ấn định sáng thứ Tư tuần sau sẽ chính thức ký kết thỏa thuận hợp tác chiến lược tại phòng họp công ty.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '双方商定于下周三上午在公司会议室正式签署战略合作协议。', 'Shuāngfāng shāngdìng yú xià zhōusān shàngwǔ zài gōngsī huìyìshì zhèngshì qiānshǔ zhànlüè hézuò xiéyì.', 'Hai bên thỏa thuận ấn định sáng thứ Tư tuần sau sẽ chính thức ký kết thỏa thuận hợp tác chiến lược tại phòng họp công ty.', 'basic', 1),
        (v_id, '面对突如其来的危机变故，领导者必须保持沉着定力，果断定夺整体处置大局。', 'Miànduì tūrúqílái de wēijī biàngù, lǐngdǎozhě bìxū bǎochí chénzhuó dìnglì, guǒduàn dìngduó zhěngtǐ chǔzhì dàjú.', 'Đứng trước biến cố khủng hoảng bất ngờ, người lãnh đạo phải giữ được định lực điềm tĩnh, quyết đoán định đoạt đại cục xử lý toàn diện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [东部] (dōngbù) - miền đông, phía đông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '东部' AND pinyin = 'dōngbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '东部'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dōngbù',
      meaning_vi = 'miền đông, phía đông',
      example_hanzi = '中国东部沿海地区经济繁荣发达，对外贸易往来极其活跃。',
      example_pinyin = 'Zhōngguó dōngbù yánhǎi dìqū jīngjì fánróng fādá, duìwài màoyì wǎnglái jíqí huóyuè.',
      example_vi = 'Khu vực ven biển miền đông Trung Quốc kinh tế phồn vinh phát triển, giao thương ngoại thương vô cùng sôi động.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国东部沿海地区经济繁荣发达，对外贸易往来极其活跃。', 'Zhōngguó dōngbù yánhǎi dìqū jīngjì fánróng fādá, duìwài màoyì wǎnglái jíqí huóyuè.', 'Khu vực ven biển miền đông Trung Quốc kinh tế phồn vinh phát triển, giao thương ngoại thương vô cùng sôi động.', 'basic', 1),
        (v_id, '随着东西部协作战略的深度推进，东部沿海发达省份向西部地区源源不断输送了大量优势产业与技术人才。', 'Suízhe dōng-xībù xiézuò zhànlüè de shēndù tuījìn, dōngbù yánhǎi fādá shěngfèn xiàng xībù dìqū yuányuán-bùduàn shūsòng le dàliàng yōushì chǎnyè yǔ jìshù réncái.', 'Cùng với sự thúc đẩy sâu rộng chiến lược phối hợp đông - tây, các tỉnh phát triển ven biển miền đông không ngừng truyền tải khối lượng lớn các ngành công nghiệp mũi nhọn và nhân tài kỹ thuật tới vùng miền tây.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [动车] (dòngchē) - tàu động lực phân tán (tàu cao tốc loại D) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '动车' AND pinyin = 'dòngchē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '动车'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dòngchē',
      meaning_vi = 'tàu động lực phân tán (tàu cao tốc loại D)',
      example_hanzi = '为了节省出行预算，我们选择乘坐舒适快捷的动车二等座前往目的地。',
      example_pinyin = 'Wèile jiéshěng chūxíng yùsuàn, wǒmen xuǎnzé chéngzuò shūshì kuàijié de dòngchē èrděngzuò qiánwǎng mùdìdì.',
      example_vi = 'Nhằm tiết kiệm ngân sách đi lại, chúng tôi chọn đi ghế hạng hai của tàu cao tốc dòng D êm ái nhanh chóng tới điểm đến.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了节省出行预算，我们选择乘坐舒适快捷的动车二等座前往目的地。', 'Wèile jiéshěng chūxíng yùsuàn, wǒmen xuǎnzé chéngzuò shūshì kuàijié de dòngchē èrděngzuò qiánwǎng mùdìdì.', 'Nhằm tiết kiệm ngân sách đi lại, chúng tôi chọn đi ghế hạng hai của tàu cao tốc dòng D êm ái nhanh chóng tới điểm đến.', 'basic', 1),
        (v_id, '密集的城际动车公交化高频次开行，极大地推动了省会与周边卫星城市之间半小时同城生活圈的形成。', 'Mìmí de chéngjì dòngchē gōngjiāohuà gāopíncì kāixíng, jídà de tuīdòng le shěnghuì yǔ zhōubiān wèixīng chéngshì zhījiān bàn xiǎoshí tóngchéng shēnghuóquān de xíngchéng.', 'Các đoàn tàu động lực liên tỉnh vận hành dày đặc tần suất cao như xe buýt đã thúc đẩy mạnh mẽ sự hình thành vòng tròn sinh hoạt cùng thành phố nửa tiếng giữa thủ phủ tỉnh và các đô thị vệ tinh xung quanh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [动作] (dòngzuò) - động tác, hành động [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '动作' AND pinyin = 'dòngzuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '动作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dòngzuò',
      meaning_vi = 'động tác, hành động',
      example_hanzi = '太极拳的每个动作都讲究行云流水、刚柔并济。',
      example_pinyin = 'Tàijíquán de měi gè dòngzuò dōu jiǎngjiu xíngyún-liúshuǐ, gāngróu-bìngjì.',
      example_vi = 'Mỗi một động tác của Thái Cực Quyền đều chú trọng mượt mà uyển chuyển, cương nhu kết hợp hài hòa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '太极拳的每个动作都讲究行云流水、刚柔并济。', 'Tàijíquán de měi gè dòngzuò dōu jiǎngjiu xíngyún-liúshuǐ, gāngróu-bìngjì.', 'Mỗi một động tác của Thái Cực Quyền đều chú trọng mượt mà uyển chuyển, cương nhu kết hợp hài hòa.', 'basic', 1),
        (v_id, '这位功夫演员在动作电影中完成了一系列令人叹为观止的高难度特技飞跃动作。', 'Zhè wèi gōngfu yǎnyuán zài dòngzuò diànyǐng zhōng wánchéng le yí xìliè lìng rén tànwéiguānzhǐ de gāo nándù tèjì fēiyuè dòngzuò.', 'Diễn viên võ thuật này đã hoàn thành một loạt động tác bay nhảy nhào lộn kỹ xảo độ khó cao khiến người xem phải trầm trồ thán phục trong phim hành động.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [读者] (dúzhě) - độc giả, bạn đọc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '读者' AND pinyin = 'dúzhě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '读者'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dúzhě',
      meaning_vi = 'độc giả, bạn đọc',
      example_hanzi = '这本书自出版以来深受广大青年读者的热烈好评与喜爱。',
      example_pinyin = 'Zhè běn shū zì chūbǎn yǐlái shēn shòu guǎngdà qīngnián dúzhě de rèliè hǎopíng yǔ xǐ’ài.',
      example_vi = 'Cuốn sách này kể từ khi xuất bản tới nay nhận được sự đánh giá tích cực nồng nhiệt và yêu quý sâu sắc của đông đảo bạn đọc trẻ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这本书自出版以来深受广大青年读者的热烈好评与喜爱。', 'Zhè běn shū zì chūbǎn yǐlái shēn shòu guǎngdà qīngnián dúzhě de rèliè hǎopíng yǔ xǐ’ài.', 'Cuốn sách này kể từ khi xuất bản tới nay nhận được sự đánh giá tích cực nồng nhiệt và yêu quý sâu sắc của đông đảo bạn đọc trẻ.', 'basic', 1),
        (v_id, '知名作家在新书首发签售会上与来自全国各地的热心读者进行了面对面的深入互动交流。', 'Zhīmíng zuòjiā zài xīn shū shǒufā qiānshòuhuì shang yǔ láizì quán guó gè dì de rèxīn dúzhě jìnxíng le miànduìmiàn de shēnrù hùdòng jiāoliú.', 'Nhà văn tên tuổi trong buổi ký tặng ra mắt sách mới đã có buổi giao lưu tương tác sâu rộng trực tiếp mặt đối mặt với các độc giả nhiệt thành đến từ mọi miền đất nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [堵车] (dǔchē) - tắc đường, kẹt xe [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '堵车' AND pinyin = 'dǔchē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '堵车'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dǔchē',
      meaning_vi = 'tắc đường, kẹt xe',
      example_hanzi = '遇到周一早高峰严重堵车，许多上班族纷纷选择改乘地下铁道。',
      example_pinyin = 'Yù dào zhōuyī zǎogāofēng yánzhòng dǔchē, xǔduō shàngbānzú fēnfēn xuǎnzé gǎi chéng dìxià tiědào.',
      example_vi = 'Gặp kẹt xe nghiêm trọng vào giờ cao điểm sáng thứ Hai, nhiều dân công sở đồng loạt chọn chuyển sang đi tàu điện ngầm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '遇到周一早高峰严重堵车，许多上班族纷纷选择改乘地下铁道。', 'Yù dào zhōuyī zǎogāofēng yánzhòng dǔchē, xǔduō shàngbānzú fēnfēn xuǎnzé gǎi chéng dìxià tiědào.', 'Gặp kẹt xe nghiêm trọng vào giờ cao điểm sáng thứ Hai, nhiều dân công sở đồng loạt chọn chuyển sang đi tàu điện ngầm.', 'basic', 1),
        (v_id, '为了有效缓解主干道在节假日进出城高峰时段的堵车拥堵顽疾，交管部门制定了精细化的分流引流应急预案。', 'Wèile yǒuxiào huǎnjiě zhǔgàndào zài jiéjiàrì jìn-chū chéng gāofēng shíduàn de dǔchē yōngdǔ wánjí, jiāoguǎn bùmén zhìdìng le jīngxìhuà de fēnliú yǐnliú yīngjí yù’àn.', 'Nhằm giải quyết hiệu quả căn bệnh trầm kha tắc đường ùn ứ trên các trục đường huyết mạch vào giờ cao điểm ra vào thành phố dịp lễ tết, lực lượng quản lý giao thông đã lập phương án khẩn cấp phân luồng chi tiết.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [度假] (dùjià) - đi nghỉ mát, đi nghỉ dưỡng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '度假' AND pinyin = 'dùjià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '度假'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dùjià',
      meaning_vi = 'đi nghỉ mát, đi nghỉ dưỡng',
      example_hanzi = '我们一家人打算趁着暑假前往云南丽江古城度假两周。',
      example_pinyin = 'Wǒmen yì jiā rén dǎsuàn chèn zhe shǔjià qiánwǎng Yúnnán Lìjiāng gǔchéng dùjià liǎng zhōu.',
      example_vi = 'Gia đình chúng tôi dự định nhân dịp nghỉ hè sẽ tới cổ thành Lệ Giang tỉnh Vân Nam nghỉ mát hai tuần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们一家人打算趁着暑假前往云南丽江古城度假两周。', 'Wǒmen yì jiā rén dǎsuàn chèn zhe shǔjià qiánwǎng Yúnnán Lìjiāng gǔchéng dùjià liǎng zhōu.', 'Gia đình chúng tôi dự định nhân dịp nghỉ hè sẽ tới cổ thành Lệ Giang tỉnh Vân Nam nghỉ mát hai tuần.', 'basic', 1),
        (v_id, '随着大众健康休闲理念的升级，越来越多都市白领热衷于前往生态森林氧吧度假，远离职场疲惫。', 'Suízhe dàzhòng jiànkāng xiūxián lǐniàn de shēngjí, yuè lái yuè duō dūshì báilǐng rèzhōng yú qiánwǎng shēngtài sēnlín yǎngba dùjià, yuǎnlí zhíchǎng píbèi.', 'Cùng với sự nâng tầm quan niệm thư giãn sức khỏe của đại chúng, ngày càng nhiều nhân viên văn phòng thành thị chuộng đi nghỉ dưỡng tại các "quán oxy" rừng sinh thái, tránh xa nỗi mệt mỏi chốn công sở.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [肚子] (dùzi) - bụng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '肚子' AND pinyin = 'dùzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '肚子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dùzi',
      meaning_vi = 'bụng',
      example_hanzi = '他可能吃了不干净的街头小吃，下午肚子一直隐隐作痛。',
      example_pinyin = 'Tā kěnéng chī le bù gānjìng de jiētóu xiǎochī, xiàwǔ dùzi yìzhí yǐnyǐn-zuòtòng.',
      example_vi = 'Cậu ấy có thể đã ăn phải đồ ăn vặt vỉa hè không sạch sẽ, buổi chiều bụng cứ đau âm ỉ suốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他可能吃了不干净的街头小吃，下午肚子一直隐隐作痛。', 'Tā kěnéng chī le bù gānjìng de jiētóu xiǎochī, xiàwǔ dùzi yìzhí yǐnyǐn-zuòtòng.', 'Cậu ấy có thể đã ăn phải đồ ăn vặt vỉa hè không sạch sẽ, buổi chiều bụng cứ đau âm ỉ suốt.', 'basic', 1),
        (v_id, '听了他讲的那段滑稽风趣的小品包袱，全场观众都笑得前仰后合、肚子发疼。', 'Tīng le tā jiǎng de nà duàn huájī fēngqù de xiǎopǐn bāofu, quánchǎng guānzhòng dōu xiào de qiányǎng-hòuhé, dùzi fā téng.', 'Nghe xong mảng miếng hài hước hóm hỉnh trong tiểu phẩm của anh ấy, toàn bộ khán giả trong khán phòng đều cười nghiêng ngả, đau cả ruột.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [短信] (duǎnxìn) - tin nhắn (SMS) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '短信' AND pinyin = 'duǎnxìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '短信'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'duǎnxìn',
      meaning_vi = 'tin nhắn (SMS)',
      example_hanzi = '你收到银行发送过来的网上支付验证码短信了吗？',
      example_pinyin = 'Nǐ shōudào yínháng fāsòng guòlái de wǎngshang zhīfù yànzhèngmǎ duǎnxìn le ma?',
      example_vi = 'Bạn đã nhận được tin nhắn SMS mã xác thực thanh toán trực tuyến do ngân hàng gửi tới chưa?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你收到银行发送过来的网上支付验证码短信了吗？', 'Nǐ shōudào yínháng fāsòng guòlái de wǎngshang zhīfù yànzhèngmǎ duǎnxìn le ma?', 'Bạn đã nhận được tin nhắn SMS mã xác thực thanh toán trực tuyến do ngân hàng gửi tới chưa?', 'basic', 1),
        (v_id, '尽管各类即时通讯社交软件日益普及，但政务通知与金融安全验证短信依然扮演着不可替代的角色。', 'Jǐnguǎn gè lèi jíshí tōngxùn shèjiāo ruǎnjiàn rìyì pǔjí, dàn zhèngwù tōngzhī yǔ jīnróng ānquán yànzhèng duǎnxìn yīrán bànyǎn zhe bù kě tìdài de juésè.', 'Dù các loại phần mềm mạng xã hội nhắn tin tức thì ngày càng phổ biến, tin nhắn SMS thông báo dịch vụ công và xác thực an toàn tài chính vẫn giữ vai trò không thể thay thế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [队] (duì) - đội, hàng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '队' AND pinyin = 'duì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '队'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'duì',
      meaning_vi = 'đội, hàng',
      example_hanzi = '请买票的游客自觉在检票口外排成一队依次进场。',
      example_pinyin = 'Qǐng mǎi piào de yóukè zìjué zài jiǎnpiàokǒu wài pái chéng yí duì yīcì jìnchǎng.',
      example_vi = 'Xin các du khách mua vé tự giác xếp thành một hàng bên ngoài cửa soát vé để lần lượt vào rạp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请买票的游客自觉在检票口外排成一队依次进场。', 'Qǐng mǎi piào de yóukè zìjué zài jiǎnpiàokǒu wài pái chéng yí duì yīcì jìnchǎng.', 'Xin các du khách mua vé tự giác xếp thành một hàng bên ngoài cửa soát vé để lần lượt vào rạp.', 'basic', 1),
        (v_id, '一支具备强大战斗力与坚定信念的优秀科研攻坚队，总能在核心关键技术卡脖子领域取得重大突破。', 'Yì zhī jùbèi qiángdà zhàndòulì yǔ jiāndìng xìnniàn de yōuxiù kēyán gōngjiānduì, zǒng néng zài héxīn guānjiàn jìshù qiǎbózi lǐngyù qǔdé zhòngdà tūpò.', 'Một đội ngũ mũi nhọn nghiên cứu khoa học xuất sắc sở hữu sức chiến đấu mạnh mẽ và niềm tin kiên định luôn có thể tạo nên đột phá trọng đại tại các lĩnh vực công nghệ then chốt bị nghẽn cổ chai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [对方] (duìfāng) - đối phương, bên kia [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '对方' AND pinyin = 'duìfāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '对方'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'duìfāng',
      meaning_vi = 'đối phương, bên kia',
      example_hanzi = '在商务谈判过程中，我们应当耐心倾听对方提出的合理诉求。',
      example_pinyin = 'Zài shāngwù tánpàn guòchéng zhōng, wǒmen yīngdāng nàixīn qīngtīng duìfāng tíchū de hélǐ sùqiú.',
      example_vi = 'Trong quá trình đàm phán thương mại, chúng ta nên kiên nhẫn lắng nghe những nguyện vọng yêu cầu hợp lý do đối phương đưa ra.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在商务谈判过程中，我们应当耐心倾听对方提出的合理诉求。', 'Zài shāngwù tánpàn guòchéng zhōng, wǒmen yīngdāng nàixīn qīngtīng duìfāng tíchū de hélǐ sùqiú.', 'Trong quá trình đàm phán thương mại, chúng ta nên kiên nhẫn lắng nghe những nguyện vọng yêu cầu hợp lý do đối phương đưa ra.', 'basic', 1),
        (v_id, '无论发生何种分歧摩擦，唯有站在对方的角度设身处地换位思考，才能真正化解心结达成共赢。', 'Wúlùn fāshēng hé zhǒng fēnqí mócā, wéiyǒu zhàn zài duìfāng de jiǎodù shèshēnchǔdì huànwèi sīkǎo, cái néng zhēnzhèng huàjiě xīnjié dáchéng gòngyíng.', 'Cho dù xảy ra bất đồng va chạm gì, chỉ khi đứng trên góc độ của đối phương đặt mình vào vị trí người khác suy ngẫm mới có thể thực sự cởi bỏ nút thắt trong lòng để đạt tới cùng thắng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [对面] (duìmiàn) - đối diện, phía đối diện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '对面' AND pinyin = 'duìmiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '对面'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'duìmiàn',
      meaning_vi = 'đối diện, phía đối diện',
      example_hanzi = '马路对面新开了一家环境优雅的书店兼咖啡馆。',
      example_pinyin = 'Mǎlù duìmiàn xīn kāi le yì jiā huánjìng yōuyǎ de shūdiàn jiān kāfēiguǎn.',
      example_vi = 'Đối diện bên kia đường mới mở một tiệm sách kết hợp quán cà phê không gian thanh nhã.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '马路对面新开了一家环境优雅的书店兼咖啡馆。', 'Mǎlù duìmiàn xīn kāi le yì jiā huánjìng yōuyǎ de shūdiàn jiān kāfēiguǎn.', 'Đối diện bên kia đường mới mở một tiệm sách kết hợp quán cà phê không gian thanh nhã.', 'basic', 1),
        (v_id, '我们就坐在彼此对面静静品味着香浓的热茶，窗外车水马龙的繁华闹市丝毫不影响屋内的宁静祥和。', 'Wǒmen jiù zuò zài bǐcǐ duìmiàn jìngjìng pǐnwèi zhe xiāngnóng de rè chá, chuāngwài chēshuǐ-mǎlóng de fánhuá nàoshì sīháo bù yǐngxiǎng wū nèi de níngjìng xiánghé.', 'Chúng tôi ngồi đối diện nhau lặng lẽ thưởng thức tách trà nóng thơm nồng, phố thị phồn hoa xe cộ tấp nập ngoài cửa sổ mảy may không làm xáo trộn vẻ thanh bình an yên bên trong căn phòng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [对于] (duìyú) - đối với, về phần [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '对于' AND pinyin = 'duìyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '对于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'duìyú',
      meaning_vi = 'đối với, về phần',
      example_hanzi = '对于初学中文的外国朋友来说，准确掌握汉字的声调至关重要。',
      example_pinyin = 'Duìyú chūxué Zhōngwén de wàiguó péngyou lái shuō, zhǔnquè zhǎngwò Hànzì de shēngdiào zhìguān zhòngyào.',
      example_vi = 'Đối với những người bạn nước ngoài mới học tiếng Trung, nắm vững chuẩn xác thanh điệu chữ Hán là vô cùng then chốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '对于初学中文的外国朋友来说，准确掌握汉字的声调至关重要。', 'Duìyú chūxué Zhōngwén de wàiguó péngyou lái shuō, zhǔnquè zhǎngwò Hànzì de shēngdiào zhìguān zhòngyào.', 'Đối với những người bạn nước ngoài mới học tiếng Trung, nắm vững chuẩn xác thanh điệu chữ Hán là vô cùng then chốt.', 'basic', 1),
        (v_id, '对于企业而言，持续的技术创新与诚信立业的良好口碑是其在市场惊涛骇浪中基业长青的立身之本。', 'Duìyú qǐyè éryán, chíxù de jìshù chuàngxīn yǔ chéngxìn lìyè de liánghǎo kǒubēi shì qí zài shìchǎng jīngtāo-hàilàng zhōng jīyè-chángqīng de lìshēn zhī běn.', 'Đối với doanh nghiệp mà nói, đổi mới công nghệ liên tục và uy tín tiếng lành lập nghiệp bằng chữ tín là gốc rễ giữ vững sự trường tồn của cơ nghiệp giữa sóng to gió lớn thương trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [队员] (duìyuán) - đội viên, thành viên đội [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '队员' AND pinyin = 'duìyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '队员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'duìyuán',
      meaning_vi = 'đội viên, thành viên đội',
      example_hanzi = '足球队的全体队员每天下午都要进行高强度的体能体魄集训。',
      example_pinyin = 'Zúqiúduì de quántǐ duìyuán měitiān xiàwǔ dōu yào jìnxíng gāoxiàngdù de tǐnéng tǐpò jíxùn.',
      example_vi = 'Toàn thể đội viên đội bóng đá mỗi buổi chiều đều phải tập huấn thể lực thể hình cường độ cao.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '足球队的全体队员每天下午都要进行高强度的体能体魄集训。', 'Zúqiúduì de quántǐ duìyuán měitiān xiàwǔ dōu yào jìnxíng gāoxiàngdù de tǐnéng tǐpò jíxùn.', 'Toàn thể đội viên đội bóng đá mỗi buổi chiều đều phải tập huấn thể lực thể hình cường độ cao.', 'basic', 1),
        (v_id, '救援队的青年队员们冒着狂风暴雨挺进灾区一线，不分昼夜搜寻受困群众，彰显了无私大爱。', 'Jiùyuánduì de qīngnián duìyuánmen mào zhe kuángfēng-bàoyǔ tǐngjìn zāiqū yīxiàn, bù fēn zhòuyè sōuxún shòukùn qúnzhòng, zhāngxiǎn le wúsī dà’ài.', 'Các đội viên trẻ của đội cứu hộ đội mưa to gió lớn tiến vào tuyến đầu vùng thiên tai, không quản ngày đêm tìm kiếm quần chúng bị cô lập, ngời sáng tình yêu thương bao la vị tha.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [队长] (duìzhǎng) - đội trưởng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '队长' AND pinyin = 'duìzhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '队长'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'duìzhǎng',
      meaning_vi = 'đội trưởng',
      example_hanzi = '在队长的带领下，我们篮球队在最后的读秒绝杀中逆转赢得了总冠军。',
      example_pinyin = 'Zài duìzhǎng de dàilǐng xià, wǒmen lánqiúduì zài zuìhòu de dǒumiǎo juésā zhōng nìzhuǎn yíngdé le zǒng guànjūn.',
      example_vi = 'Dưới sự dẫn dắt của đội trưởng, đội bóng rổ chúng tôi đã lội ngược dòng giành ngôi vô địch chung cuộc trong giây phút ném bóng quyết định cuối cùng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在队长的带领下，我们篮球队在最后的读秒绝杀中逆转赢得了总冠军。', 'Zài duìzhǎng de dàilǐng xià, wǒmen lánqiúduì zài zuìhòu de dǒumiǎo juésā zhōng nìzhuǎn yíngdé le zǒng guànjūn.', 'Dưới sự dẫn dắt của đội trưởng, đội bóng rổ chúng tôi đã lội ngược dòng giành ngôi vô địch chung cuộc trong giây phút ném bóng quyết định cuối cùng.', 'basic', 1),
        (v_id, '作为一名合格出色的登山探险队长，不仅需要掌握精湛的专业户外生存技能，更要在生死关头果断决断全队去留。', 'Zuòwéi yì míng hégé chūsè de dēngshān tànxiǎn duìzhǎng, bùjǐn xūyào zhǎngwò jīngzhàn de zhuānyè hùwài shēngcún jìnéng, gèng yào zài shēngsǐ guāntóu guǒduàn juéduàn quánduì qù-liú.', 'Với tư cách là một người đội trưởng thám hiểm leo núi tài giỏi đạt chuẩn, không những cần nắm vững kỹ năng sinh tồn ngoài trời chuyên nghiệp đỉnh cao mà càng phải quyết đoán quyết định sự an nguy đi ở của toàn đội trong thời khắc sinh tử.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [顿] (dùn) - bữa (ăn); trận (mắng, đòn) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '顿' AND pinyin = 'dùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '顿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'dùn',
      meaning_vi = 'bữa (ăn); trận (mắng, đòn)',
      example_hanzi = '无论工作有多么繁忙，每天也要按时吃上一顿热乎乎的健康午餐。',
      example_pinyin = 'Wúlùn gōngzuò yǒu duōme fánmáng, měitiān yě yào ànshí chī shàng yí dùn rèhūhū de jiànkāng wǔcān.',
      example_vi = 'Cho dù công việc có bận rộn đến đâu, mỗi ngày cũng phải ăn đúng giờ một bữa trưa ấm nóng lành mạnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '无论工作有多么繁忙，每天也要按时吃上一顿热乎乎的健康午餐。', 'Wúlùn gōngzuò yǒu duōme fánmáng, měitiān yě yào ànshí chī shàng yí dùn rèhūhū de jiànkāng wǔcān.', 'Cho dù công việc có bận rộn đến đâu, mỗi ngày cũng phải ăn đúng giờ một bữa trưa ấm nóng lành mạnh.', 'basic', 1),
        (v_id, '因为考试粗心大意涂错了答题卡，小明回家后被严厉的父亲狠狠地训斥了一顿。', 'Yīnwèi kǎoshì cūxīn-dàyì tú cuò le dǎtíkǎ, Xiǎomíng huí jiā hòu bèi yánlì de fùqīn hěnhěn de xùnchì le yí dùn.', 'Vì đi thi cẩu thả bất cẩn tô nhầm phiếu trả lời trắc nghiệm, sau khi về nhà Tiểu Minh đã bị người cha nghiêm khắc mắng mỏ cho một trận tơi bời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [多么] (duōme) - biết bao, dường nào, xiết bao [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '多么' AND pinyin = 'duōme'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '多么'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'duōme',
      meaning_vi = 'biết bao, dường nào, xiết bao',
      example_hanzi = '站在这座高山之巅放眼远眺，祖国的大好河山是多么壮丽辽阔啊！',
      example_pinyin = 'Zhàn zài zhè zuò gāoshān zhī diān fàngyǎn yuǎntiào, zǔguó de dàhǎo héshān shì duōme zhuànglì liáokuò a!',
      example_vi = 'Đứng trên đỉnh ngọn núi cao này phóng tầm mắt nhìn xa, non sông gấm vóc của tổ quốc tráng lệ bao la biết nhường nào!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '站在这座高山之巅放眼远眺，祖国的大好河山是多么壮丽辽阔啊！', 'Zhàn zài zhè zuò gāoshān zhī diān fàngyǎn yuǎntiào, zǔguó de dàhǎo héshān shì duōme zhuànglì liáokuò a!', 'Đứng trên đỉnh ngọn núi cao này phóng tầm mắt nhìn xa, non sông gấm vóc của tổ quốc tráng lệ bao la biết nhường nào!', 'basic', 1),
        (v_id, '在外漂泊打拼多年的游子，每逢万家团聚的中秋佳节，心里是多么渴望早日回到温暖的故土家园啊！', 'Zài wài piāobó dǎpīn duō nián de yóuzǐ, měiféng wànjiā tuánjù de Zhōngqiū jiājié, xīnlǐ shì duōme kěwàng zǎorì huí dào wēnnuǎn de gùtǔ jiāyuán a!', 'Người con xa xứ bươn chải nổi trôi phương xa nhiều năm, mỗi dịp Tết Trung Thu muôn nhà sum vầy, trong lòng tha thiết mong mỏi sớm được trở về mái ấm quê hương xiết bao!', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [多数] (duōshù) - đa số, phần lớn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '多数' AND pinyin = 'duōshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '多数'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'duōshù',
      meaning_vi = 'đa số, phần lớn',
      example_hanzi = '经过全班举手表决，绝大多数同学赞同在下周六组织一次郊游烧烤活动。',
      example_pinyin = 'Jīngguò quán bān jǔshǒu biǎojué, jué dàduōshù tóngxué zàntóng zài xià zhōuliù zǔzhī yí cì jiāoyóu shāokǎo huódòng.',
      example_vi = 'Sau khi toàn lớp biểu quyết giơ tay, tuyệt đại đa số các bạn học đều đồng ý tổ chức một buổi dã ngoại nướng thịt vào thứ Bảy tuần tới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过全班举手表决，绝大多数同学赞同在下周六组织一次郊游烧烤活动。', 'Jīngguò quán bān jǔshǒu biǎojué, jué dàduōshù tóngxué zàntóng zài xià zhōuliù zǔzhī yí cì jiāoyóu shāokǎo huódòng.', 'Sau khi toàn lớp biểu quyết giơ tay, tuyệt đại đa số các bạn học đều đồng ý tổ chức một buổi dã ngoại nướng thịt vào thứ Bảy tuần tới.', 'basic', 1),
        (v_id, '民主决策机制的精髓在于既要充分尊重大多数人的意愿诉求，同时也要切实保护少数群体的合法正当权益。', 'Mínzhǔ juécè jīzhì de jīngsuǐ zàiyú jì yào chōngfèn zūnzhòng dàduōshù rén de yìyuàn sùqiú, tóngshí yě yào qièshí bǎohù shǎoshù qúntǐ de héfǎ zhèngdàng quányì.', 'Tinh hoa của cơ chế quyết sách dân chủ nằm ở chỗ vừa phải tôn trọng đầy đủ nguyện vọng yêu cầu của đại đa số người, đồng thời cũng phải bảo vệ thiết thực quyền lợi hợp pháp chính đáng của nhóm thiểu số.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [多样] (duōyàng) - đa dạng, nhiều kiểu dáng/chủng loại [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '多样' AND pinyin = 'duōyàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '多样'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'duōyàng',
      meaning_vi = 'đa dạng, nhiều kiểu dáng/chủng loại',
      example_hanzi = '这家自助餐厅提供的菜品风格多样，既有传统中餐也有西方西点。',
      example_pinyin = 'Zhè jiā zìzhù cāntīng tígōng de càipǐn fēnggé duōyàng, jì yǒu chuántǒng Zhōngcān yě yǒu xīfāng xīdiǎn.',
      example_vi = 'Các món ăn mà nhà hàng buffet này phục vụ có phong cách đa dạng, vừa có đồ ăn Trung Hoa truyền thống lại vừa có bánh ngọt phương Tây.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家自助餐厅提供的菜品风格多样，既有传统中餐也有西方西点。', 'Zhè jiā zìzhù cāntīng tígōng de càipǐn fēnggé duōyàng, jì yǒu chuántǒng Zhōngcān yě yǒu xīfāng xīdiǎn.', 'Các món ăn mà nhà hàng buffet này phục vụ có phong cách đa dạng, vừa có đồ ăn Trung Hoa truyền thống lại vừa có bánh ngọt phương Tây.', 'basic', 1),
        (v_id, '保持地球生物物种的多样性与生态系统结构的多样化，是维护全球生态安全防线的重要战略基石。', 'Bǎochí dìqiú shēngwù wùzhǒng de duōyàngxìng yǔ shēngtài xìtǒng jiégòu de duōyànghuà, shì wéihù quánqiú shēngtài ānquán fángxiàn de zhòngyào zhànlüè jīshí.', 'Gìn giữ tính đa dạng của các loài sinh vật trên Trái Đất và sự đa dạng hóa cấu trúc hệ sinh thái là nền tảng chiến lược trọng yếu để bảo vệ phòng tuyến an toàn sinh thái toàn cầu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [而] (ér) - và, mà, nhưng (liên từ nối biểu thị đẳng lập hoặc chuyển biến) [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '而' AND pinyin = 'ér'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '而'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'ér',
      meaning_vi = 'và, mà, nhưng (liên từ nối biểu thị đẳng lập hoặc chuyển biến)',
      example_hanzi = '学好一门外语不仅需要浓厚的兴趣，而且更要靠持之以恒的练习。',
      example_pinyin = 'Xué hǎo yì mén wàiyǔ bùjǐn xūyào nónghòu de xìngqù, érqiě gèng yào kào chízhīyǐhéng de liànxí.',
      example_vi = 'Học tốt một ngoại ngữ không chỉ cần sự hứng thú đậm đà, mà hơn nữa càng phải dựa vào sự luyện tập kiên trì không ngừng nghỉ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '学好一门外语不仅需要浓厚的兴趣，而且更要靠持之以恒的练习。', 'Xué hǎo yì mén wàiyǔ bùjǐn xūyào nónghòu de xìngqù, érqiě gèng yào kào chízhīyǐhéng de liànxí.', 'Học tốt một ngoại ngữ không chỉ cần sự hứng thú đậm đà, mà hơn nữa càng phải dựa vào sự luyện tập kiên trì không ngừng nghỉ.', 'basic', 1),
        (v_id, '有的人表面看似平凡质朴，而内心却蕴藏着无穷的智慧与坚不可摧的力量。', 'Yǒu de rén biǎomiàn kànsì píngfán zhìpǔ, ér nèixīn què yùncáng zhe wúqióng de zhìhuì yǔ jiānbùkěcuī de lìliang.', 'Có những người bề ngoài trông có vẻ bình dị mộc mạc, nhưng trong thâm tâm lại ẩn chứa trí tuệ vô biên và nguồn sức mạnh không thể phá vỡ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [儿童] (értóng) - nhi đồng, trẻ em [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '儿童' AND pinyin = 'értóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '儿童'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'értóng',
      meaning_vi = 'nhi đồng, trẻ em',
      example_hanzi = '六月一日国际儿童节是全世界所有小朋友共同的快乐节日。',
      example_pinyin = 'Liù yuè yī rì guójì értóngjié shì quán shìjiè suǒyǒu xiǎopéngyou gòngtóng de kuàilè jiérì.',
      example_vi = 'Ngày 1 tháng 6 Tết Thiếu nhi Quốc tế là ngày lễ vui vẻ chung của tất cả các bạn nhỏ trên toàn thế giới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '六月一日国际儿童节是全世界所有小朋友共同的快乐节日。', 'Liù yuè yī rì guójì értóngjié shì quán shìjiè suǒyǒu xiǎopéngyou gòngtóng de kuàilè jiérì.', 'Ngày 1 tháng 6 Tết Thiếu nhi Quốc tế là ngày lễ vui vẻ chung của tất cả các bạn nhỏ trên toàn thế giới.', 'basic', 1),
        (v_id, '全社会都应当高度重视儿童的身心健康成长，为其营造充满阳光、关爱与安全的良好社会环境。', 'Quán shèhuì dōu yīngdāng gāodù zhòngshì értóng de shēnxīn jiànkāng chéngzhǎng, wèi qí yíngzào chōngmǎn yángguāng, guān’ài yǔ ānquán de liánghǎo shèhuì huánjìng.', 'Toàn xã hội đều nên hết sức coi trọng sự phát triển sức khỏe thể chất và tâm hồn của trẻ em, tạo dựng cho các em một môi trường xã hội lành mạnh ngập tràn ánh nắng, tình yêu thương và sự an toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [发出] (fāchū) - phát ra, gửi đi, ban bố [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '发出' AND pinyin = 'fāchū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '发出'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fāchū',
      meaning_vi = 'phát ra, gửi đi, ban bố',
      example_hanzi = '求职信发出之后，他耐心地等待着招聘公司的面试回复。',
      example_pinyin = 'Qiúzhíxìn fāchū zhīhòu, tā nàixīn de děngdài zhe zhāopìn gōngsī de miànshì huífù.',
      example_vi = 'Sau khi thư xin việc được gửi đi, anh ấy kiên nhẫn chờ đợi phản hồi phỏng vấn của công ty tuyển dụng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '求职信发出之后，他耐心地等待着招聘公司的面试回复。', 'Qiúzhíxìn fāchū zhīhòu, tā nàixīn de děngdài zhe zhāopìn gōngsī de miànshì huífù.', 'Sau khi thư xin việc được gửi đi, anh ấy kiên nhẫn chờ đợi phản hồi phỏng vấn của công ty tuyển dụng.', 'basic', 1),
        (v_id, '气象预警中心针对即将登陆的特大强台风，紧急向沿海各大港口及渔船发出了最高级别红色预警信号。', 'Qìxiàng yùjǐng zhōngxīn zhēnduì jíjiāng dēnglù de tèdà qiáng táifēng, jǐnjí xiàng yánhǎi gè dà gǎngkǒu jí yúcchuán fāchū le zuìgāo jíbié hóngsè yùjǐng xìnhào.', 'Trung tâm cảnh báo khí tượng hướng tới cơn bão cực mạnh sắp đổ bộ đã khẩn cấp phát đi tín hiệu cảnh báo màu đỏ cấp cao nhất tới các cảng biển và tàu thuyền đánh cá ven biển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [发送] (fāsòng) - gửi, gửi đi, truyền tải [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '发送' AND pinyin = 'fāsòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '发送'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fāsòng',
      meaning_vi = 'gửi, gửi đi, truyền tải',
      example_hanzi = '我已经把修改后的项目合同电子文件通过电子邮件发送到了您的邮箱。',
      example_pinyin = 'Wǒ yǐjīng bǎ xiūgǎi hòu de xiàngmù hétong diànzǐ wénjiàn tōngguò diànzǐ yóujiàn fāsòng dào le nín de yóuxiāng.',
      example_vi = 'Tôi đã gửi tập tin điện tử hợp đồng dự án sau khi chỉnh sửa qua thư điện tử tới hòm thư của ngài.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我已经把修改后的项目合同电子文件通过电子邮件发送到了您的邮箱。', 'Wǒ yǐjīng bǎ xiūgǎi hòu de xiàngmù hétong diànzǐ wénjiàn tōngguò diànzǐ yóujiàn fāsòng dào le nín de yóuxiāng.', 'Tôi đã gửi tập tin điện tử hợp đồng dự án sau khi chỉnh sửa qua thư điện tử tới hòm thư của ngài.', 'basic', 1),
        (v_id, '遥感通信卫星能够将太空中拍摄的高分辨率对地观测数据实时精准地发送回地面接收总站。', 'Yáogǎn tōngxùn wèixīng nénggòu jiāng tàikōng zhōng pāishè de gāo fēnbànlǜ duì dì guāncè shùjù shíshí jīngzhǔn de fāsòng huí dìmiàn jiēshōu zǒngzhàn.', 'Vệ tinh viễn thông viễn thám có thể gửi dữ liệu quan trắc mặt đất độ phân giải cao chụp từ không gian về trạm tiếp nhận mặt đất theo thời gian thực một cách chuẩn xác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [法] (fǎ) - pháp luật; phương pháp, cách thức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '法' AND pinyin = 'fǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fǎ',
      meaning_vi = 'pháp luật; phương pháp, cách thức',
      example_hanzi = '我们做任何事情都必须在国家法律法规允许的框架内进行，决不能违法。',
      example_pinyin = 'Wǒmen zuò rènhé shìqing dōu bìxū zài guójiā fǎlǜ fǎguī yǔnxǔ de kuàngjià nèi jìnxíng, jué bù néng wéifǎ.',
      example_vi = 'Chúng ta làm bất kỳ điều gì cũng đều phải tiến hành trong khuôn khổ cho phép của pháp luật quy định nhà nước, tuyệt đối không được phạm pháp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们做任何事情都必须在国家法律法规允许的框架内进行，决不能违法。', 'Wǒmen zuò rènhé shìqing dōu bìxū zài guójiā fǎlǜ fǎguī yǔnxǔ de kuàngjià nèi jìnxíng, jué bù néng wéifǎ.', 'Chúng ta làm bất kỳ điều gì cũng đều phải tiến hành trong khuôn khổ cho phép của pháp luật quy định nhà nước, tuyệt đối không được phạm pháp.', 'basic', 1),
        (v_id, '面对复杂疑难的科研命题，必须打破陈旧观念束缚，大胆摸索创新解题之法。', 'Miànduì fùzá yínán de kēyán mìngtí, bìxū dǎpò chénjiù guānniàn shùfù, dàdǎn mōsuǒ chuàngxīn jiětí zhī fǎ.', 'Đứng trước các đề bài nghiên cứu khoa học phức tạp khó nhằn, bắt buộc phải phá bỏ xiềng xích quan niệm cũ kỹ, mạnh dạn tìm tòi phương pháp giải đề đổi mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [法律] (fǎlǜ) - pháp luật [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '法律' AND pinyin = 'fǎlǜ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '法律'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fǎlǜ',
      meaning_vi = 'pháp luật',
      example_hanzi = '每个人在法律面前都是一律平等的，没有任何超越法律的特权。',
      example_pinyin = 'Měi gè rén zài fǎlǜ miànqián dōu shì yílǜ píngděng de, méiyǒu rènhé chāoyuè fǎlǜ de tèquán.',
      example_vi = 'Mỗi một con người trước pháp luật đều bình đẳng như nhau, không có bất kỳ đặc quyền nào vượt trên pháp luật.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每个人在法律面前都是一律平等的，没有任何超越法律的特权。', 'Měi gè rén zài fǎlǜ miànqián dōu shì yílǜ píngděng de, méiyǒu rènhé chāoyuè fǎlǜ de tèquán.', 'Mỗi một con người trước pháp luật đều bình đẳng như nhau, không có bất kỳ đặc quyền nào vượt trên pháp luật.', 'basic', 1),
        (v_id, '增强全民学法、知法、守法、用法的法律意识，是全面推进依法治国战略的坚固基石。', 'Zēngqiáng quánmín xué fǎ, zhī fǎ, shǒu fǎ, yòng fǎ de fǎlǜ yìshí, shì quánmiàn tuījìn yīfǎ-zhìguó zhànlüè de jiāngù jīshí.', 'Nâng cao ý thức pháp luật học luật, hiểu luật, chấp hành luật và dùng luật của toàn dân là nền tảng vững chắc để thúc đẩy toàn diện chiến lược thượng tôn pháp luật quản trị đất nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [翻译] (fānyì) - dịch thuật, phiên dịch; dịch giả, bản dịch [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '翻译' AND pinyin = 'fānyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '翻译'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'fānyì',
      meaning_vi = 'dịch thuật, phiên dịch; dịch giả, bản dịch',
      example_hanzi = '请把这段精彩的中文成语典故翻译成流利地道的英语。',
      example_pinyin = 'Qǐng bǎ zhè duàn jīngcǎi de Zhōngwén chéngyǔ diǎngù fānyì chéng liúlì dìdao de Yīngyǔ.',
      example_vi = 'Xin hãy dịch đoạn điển cố thành ngữ tiếng Trung đặc sắc này sang tiếng Anh lưu loát bản ngữ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把这段精彩的中文成语典故翻译成流利地道的英语。', 'Qǐng bǎ zhè duàn jīngcǎi de Zhōngwén chéngyǔ diǎngù fānyì chéng liúlì dìdao de Yīngyǔ.', 'Xin hãy dịch đoạn điển cố thành ngữ tiếng Trung đặc sắc này sang tiếng Anh lưu loát bản ngữ.', 'basic', 1),
        (v_id, '一名优秀资深的高级同声传译翻译，不仅需要具备敏捷过人的双语转换反应，更需要博闻强识的百科全书式知识储备。', 'Yì míng yōuxiù zīshēn de gāojí tóngshēng-chuányì fānyì, bùjǐn xūyào jùbèi mǐnjié guòrén de shuāngyǔ zhuǎnhuàn fǎnyìng, gèng xūyào bówén-qiángzhì de bǎikē-quánshū shì zhīshi chǔbèi.', 'Một phiên dịch viên cabin dịch song song cao cấp dày dặn ưu tú không chỉ cần có phản xạ chuyển đổi song ngữ nhanh nhạy hơn người, mà càng cần kho tàng kiến thức bách khoa toàn thư uyên thâm hiểu rộng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [烦] (fán) - phiền muộn, chán ngấy; làm phiền [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '烦' AND pinyin = 'fán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '烦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'fán',
      meaning_vi = 'phiền muộn, chán ngấy; làm phiền',
      example_hanzi = '外面下了一整天连绵不断的阴雨，让人心里觉得格外心烦。',
      example_pinyin = 'Wàimiàn xià le yì zhěng tiān liánmián-búduàn de yīnyǔ, ràng rén xīnlǐ juéde géwài xīnfán.',
      example_vi = 'Bên ngoài trút cơn mưa dầm dề suốt cả ngày, khiến trong lòng người ta cảm thấy buồn bực phiền não lạ thường.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '外面下了一整天连绵不断的阴雨，让人心里觉得格外心烦。', 'Wàimiàn xià le yì zhěng tiān liánmián-búduàn de yīnyǔ, ràng rén xīnlǐ juéde géwài xīnfán.', 'Bên ngoài trút cơn mưa dầm dề suốt cả ngày, khiến trong lòng người ta cảm thấy buồn bực phiền não lạ thường.', 'basic', 1),
        (v_id, '他正在专注地排查一段极其复杂的程序底层代码，请大家先别去烦他。', 'Tā zhèngzài zhuānzhù de páichá yí duàn jíqí fùzá de chéngxù dǐcéng dàimǎ, qǐng dàjiā xiān bié qù fán tā.', 'Anh ấy đang chuyên chú rà soát một đoạn mã nguồn tầng đáy chương trình cực kỳ phức tạp, xin mọi người trước mắt đừng tới làm phiền anh ấy.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [烦恼] (fánnǎo) - phiền muộn, phiền não, nỗi lo [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '烦恼' AND pinyin = 'fánnǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '烦恼'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'fánnǎo',
      meaning_vi = 'phiền muộn, phiền não, nỗi lo',
      example_hanzi = '生活中有许多微不足道的烦恼，笑一笑就都会随风消散。',
      example_pinyin = 'Shēnghuó zhōng yǒu xǔduō wēibùzúdào de fánnǎo, xiào yí xiào jiù dōu huì suí fēng xiāosàn.',
      example_vi = 'Trong cuộc sống có rất nhiều nỗi phiền muộn cỏn con, chỉ cần cười một tiếng là tất thảy đều tan theo làn gió.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '生活中有许多微不足道的烦恼，笑一笑就都会随风消散。', 'Shēnghuó zhōng yǒu xǔduō wēibùzúdào de fánnǎo, xiào yí xiào jiù dōu huì suí fēng xiāosàn.', 'Trong cuộc sống có rất nhiều nỗi phiền muộn cỏn con, chỉ cần cười một tiếng là tất thảy đều tan theo làn gió.', 'basic', 1),
        (v_id, '面对成长路上的种种困惑与烦恼，多向值得信赖的师长朋友倾诉交流是舒缓心理压力的良方。', 'Miànduì chéngzhǎng lù shang de zhǒngzhǒng kùnhuò yǔ fánnǎo, duō xiàng zhídé xìnlài de shīzhǎng péngyou qīngsù jiāoliú shì shūhuǎn xīnlǐ yālì de liángfāng.', 'Đối mặt với những băn khoăn phiền muộn trên đường trưởng thành, tâm sự sẻ chia với thầy cô bạn bè đáng tin cậy là liều thuốc hữu hiệu để xoa dịu áp lực tâm lý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [反对] (fǎnduì) - phản đối [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '反对' AND pinyin = 'fǎnduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '反对'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fǎnduì',
      meaning_vi = 'phản đối',
      example_hanzi = '大部分居民坚决反对在生活小区附近修建高污染的化工厂。',
      example_pinyin = 'Dà bùfen jūmín jiānjué fǎnduì zài shēnghuó xiǎoqū fùjìn xiūjiàn gāo wūrǎn de huàgōngchǎng.',
      example_vi = 'Phần lớn người dân kiên quyết phản đối việc xây dựng nhà máy hóa chất gây ô nhiễm cao gần khu dân cư sinh sống.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '大部分居民坚决反对在生活小区附近修建高污染的化工厂。', 'Dà bùfen jūmín jiānjué fǎnduì zài shēnghuó xiǎoqū fùjìn xiūjiàn gāo wūrǎn de huàgōngchǎng.', 'Phần lớn người dân kiên quyết phản đối việc xây dựng nhà máy hóa chất gây ô nhiễm cao gần khu dân cư sinh sống.', 'basic', 1),
        (v_id, '国际社会绝大多数正义力量一致严正反对任何形式的单边霸凌霸道行径，坚定捍卫联合国宪章宗旨。', 'Guójì shèhuì jué dàduōshù zhèngyì lìliang yízhì yánzhèng fǎnduì rènhé xíngshì de dānbiān bàlíng bàdào xíngjìng, jiāndìng hànwèi Liánhéguó xiànzhāng zōngzhǐ.', 'Tuyệt đại đa số các lực lượng chính nghĩa trong cộng đồng quốc tế nhất trí nghiêm khắc phản đối bất kỳ hành vi bắt nạt đơn phương bá quyền nào, kiên định bảo vệ tôn chỉ của Hiến chương Liên Hợp Quốc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [方面] (fāngmiàn) - phương diện, mặt, khía cạnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '方面' AND pinyin = 'fāngmiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '方面'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fāngmiàn',
      meaning_vi = 'phương diện, mặt, khía cạnh',
      example_hanzi = '他在语言学习和体育运动方面都展现出了非凡过人的天赋。',
      example_pinyin = 'Tā zài yǔyán xuéxí hé tǐyù yùndòng fāngmiàn dōu zhǎnxiàn chū le fēifán guòrén de tiānfù.',
      example_vi = 'Cậu ấy ở cả hai phương diện học ngôn ngữ và vận động thể thao đều bộc lộ năng khiếu phi phàm hơn người.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在语言学习和体育运动方面都展现出了非凡过人的天赋。', 'Tā zài yǔyán xuéxí hé tǐyù yùndòng fāngmiàn dōu zhǎnxiàn chū le fēifán guòrén de tiānfù.', 'Cậu ấy ở cả hai phương diện học ngôn ngữ và vận động thể thao đều bộc lộ năng khiếu phi phàm hơn người.', 'basic', 1),
        (v_id, '在评估重大投资合作项目时，必须统筹综合考量其在经济收益、社会效益以及生态环境等多方面的综合影响。', 'Zài pínggū zhòngdà tóuzī hézuò xiàngmù shí, bìxū tǒngchóu zōnghé kǎoliàng qí zài jīngjì shōuyì, shèhuì xiàoyì yǐjí shēngtài huánjìng děng duō fāngmiàn de zōnghé yǐngxiǎng.', 'Khi đánh giá một dự án hợp tác đầu tư trọng đại, bắt buộc phải tính toán bao quát tổng hợp ảnh hưởng trên nhiều phương diện như lợi ích kinh tế, hiệu quả xã hội cũng như môi trường sinh thái.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [方式] (fāngshì) - phương thức, cách thức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '方式' AND pinyin = 'fāngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '方式'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fāngshì',
      meaning_vi = 'phương thức, cách thức',
      example_hanzi = '步行和骑自行车出行是现代都市人非常推崇的绿色健康生活方式。',
      example_pinyin = 'Bùxíng hé qí zìxíngchē chūxíng shì xiàndài dūshìrén fēicháng tuīchóng de lǜsè jiànkāng shēnghuó fāngshì.',
      example_vi = 'Đi bộ và đạp xe là lối sống lành mạnh xanh mà người thành thị hiện đại vô cùng ưa chuộng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '步行和骑自行车出行是现代都市人非常推崇的绿色健康生活方式。', 'Bùxíng hé qí zìxíngchē chūxíng shì xiàndài dūshìrén fēicháng tuīchóng de lǜsè jiànkāng shēnghuó fāngshì.', 'Đi bộ và đạp xe là lối sống lành mạnh xanh mà người thành thị hiện đại vô cùng ưa chuộng.', 'basic', 1),
        (v_id, '随着移动互联网的高速普及，移动扫码支付已经彻底改变了传统纸币现金交易的日常生活消费方式。', 'Suízhe yídòng hùliánwǎng de gāosù pǔjí, yídòng sǎomǎ zhīfù yǐjīng chèdǐ gǎibiàn le chuántǒng zhǐbì xiànjīn jiāoyì de rìcháng shēnghuó xiāofèi fāngshì.', 'Cùng với sự phổ biến nhanh chóng của internet di động, thanh toán quét mã trên điện thoại đã thay đổi triệt để phương thức tiêu dùng sinh hoạt hàng ngày bằng tiền mặt giấy truyền thống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [房东] (fángdōng) - chủ nhà (cho thuê nhà) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '房东' AND pinyin = 'fángdōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '房东'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fángdōng',
      meaning_vi = 'chủ nhà (cho thuê nhà)',
      example_hanzi = '我们的房东是一位十分和善热心的大妈，逢年过节总给我们送自制的水饺。',
      example_pinyin = 'Wǒmen de fángdōng shì yí wèi shífēn héshàn rèxīn de dàmā, féngnián-guòjié zǒng gěi wǒmen sòng zìzhì de shuǐjiǎo.',
      example_vi = 'Bác chủ nhà của chúng tôi là một bác gái rất hòa nhã nhiệt tình, mỗi dịp lễ tết luôn mang sang cho chúng tôi bánh sủi cảo tự làm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们的房东是一位十分和善热心的大妈，逢年过节总给我们送自制的水饺。', 'Wǒmen de fángdōng shì yí wèi shífēn héshàn rèxīn de dàmā, féngnián-guòjié zǒng gěi wǒmen sòng zìzhì de shuǐjiǎo.', 'Bác chủ nhà của chúng tôi là một bác gái rất hòa nhã nhiệt tình, mỗi dịp lễ tết luôn mang sang cho chúng tôi bánh sủi cảo tự làm.', 'basic', 1),
        (v_id, '租房双方在正式签约前，应当就房屋日常设施维保责任与房租支付节点同房东协商达成一致。', 'Zūfáng shuāngfāng zài zhèngshì qiānyuē qián, yīngdāng jiù fángwū rìcháng shèshī wéibǎo zérèn yǔ fángzū zhīfù jiédiǎn tóng fángdōng xiéshāng dáchéng yízhì.', 'Hai bên thuê nhà trước khi chính thức ký hợp đồng nên hiệp thương đạt sự thống nhất với chủ nhà về trách nhiệm bảo trì tiện nghi hàng ngày và kỳ hạn trả tiền thuê nhà.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [房租] (fángzū) - tiền thuê nhà [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '房租' AND pinyin = 'fángzū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '房租'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fángzū',
      meaning_vi = 'tiền thuê nhà',
      example_hanzi = '每个月五号之前，他都会准时通过网银转账向房东交付房租。',
      example_pinyin = 'Měi gè yuè wǔ hào zhīqián, tā dōu huì zhǔnshí tōngguò wǎngyín zhuǎnzhàng xiàng fángdōng jiāofù fángzū.',
      example_vi = 'Trước ngày mồng năm hàng tháng, cậu ấy đều chuyển khoản ngân hàng trả tiền thuê nhà cho chủ nhà đúng hẹn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每个月五号之前，他都会准时通过网银转账向房东交付房租。', 'Měi gè yuè wǔ hào zhīqián, tā dōu huì zhǔnshí tōngguò wǎngyín zhuǎnzhàng xiàng fángdōng jiāofù fángzū.', 'Trước ngày mồng năm hàng tháng, cậu ấy đều chuyển khoản ngân hàng trả tiền thuê nhà cho chủ nhà đúng hẹn.', 'basic', 1),
        (v_id, '大城市中心地段高昂的房租成本，是刚踏入社会的年轻大学毕业生面临的一大现实经济挑战。', 'Dà chéngshì zhōngxīn dìduàn gāo’áng de fángzū chéngběn, shì gāng tàrù shèhuì de niánqīng dàxué bìyèshēng miànlín de yí dà xiànshí jīngjì tiǎozhàn.', 'Chi phí thuê nhà đắt đỏ tại các vị trí trung tâm thành phố lớn là một thách thức kinh tế thực tế lớn mà những sinh viên đại học trẻ mới bước vào đời phải đối mặt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [放弃] (fàngqì) - từ bỏ, buông xuôi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '放弃' AND pinyin = 'fàngqì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '放弃'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fàngqì',
      meaning_vi = 'từ bỏ, buông xuôi',
      example_hanzi = '只要心中怀揣梦想，就永远不要在遇到困难时轻易说放弃。',
      example_pinyin = 'Zhǐyào xīn zhōng huáichuāi mèngxiǎng, jiù yǒngyuǎn bú yào zài yù dào kùnnan shí qīngyì shuō fàngqì.',
      example_vi = 'Chỉ cần trong lòng ấp ủ ước mơ thì vĩnh viễn đừng bao giờ dễ dàng nói từ bỏ khi gặp phải khó khăn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '只要心中怀揣梦想，就永远不要在遇到困难时轻易说放弃。', 'Zhǐyào xīn zhōng huáichuāi mèngxiǎng, jiù yǒngyuǎn bú yào zài yù dào kùnnan shí qīngyì shuō fàngqì.', 'Chỉ cần trong lòng ấp ủ ước mơ thì vĩnh viễn đừng bao giờ dễ dàng nói từ bỏ khi gặp phải khó khăn.', 'basic', 1),
        (v_id, '经历过无数次实验失败与挫折，科研人员凭借顽强坚毅的毅力始终未曾放弃对真理的探索。', 'Jīnglì guò wúshù cì shíyàn shībài yǔ cuòzhé, kēyán rényuán píngjiè wánqiáng jiānyì de yìlì shǐzhōng wèicéng fàngqì duì zhēnlǐ de tànsuǒ.', 'Trải qua vô số lần thí nghiệm thất bại và trắc trở, những người làm nghiên cứu khoa học dựa vào ý chí kiên định ngoan cường chưa bao giờ từ bỏ việc tìm kiếm chân lý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [放松] (fàngsōng) - thư giãn, thả lỏng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '放松' AND pinyin = 'fàngsōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '放松'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fàngsōng',
      meaning_vi = 'thư giãn, thả lỏng',
      example_hanzi = '经过一整天紧张忙碌的高压工作，听听舒缓的轻音乐有助于放松身心。',
      example_pinyin = 'Jīngguò yì zhěng tiān jǐnzhāng mánglù de gāoyā gōngzuò, tīngting shūhuǎn de qīngyīnyuè yǒuzhùyú fàngsōng shēnxīn.',
      example_vi = 'Sau cả ngày làm việc áp lực cao bận rộn căng thẳng, nghe chút nhạc nhẹ êm dịu rất có ích để thả lỏng thể xác và tinh thần.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过一整天紧张忙碌的高压工作，听听舒缓的轻音乐有助于放松身心。', 'Jīngguò yì zhěng tiān jǐnzhāng mánglù de gāoyā gōngzuò, tīngting shūhuǎn de qīngyīnyuè yǒuzhùyú fàngsōng shēnxīn.', 'Sau cả ngày làm việc áp lực cao bận rộn căng thẳng, nghe chút nhạc nhẹ êm dịu rất có ích để thả lỏng thể xác và tinh thần.', 'basic', 1),
        (v_id, '在重大体育赛事或关键考试登场前，保持适度放松的良好心态往往比盲目焦虑更能发挥出最佳竞技水平。', 'Zài zhòngdà tǐyù sàishì huò guānjiàn kǎoshì dēngchǎng qián, bǎochí shìdù fàngsōng de liánghǎo xīntài wǎngwǎng bǐ mángmù jiāolǜ gèng néng fāhuī chū zuì jiā jìngjì shuǐpíng.', 'Trước khi bước vào trận đấu thể thao lớn hay kỳ thi trọng đại, giữ vững tâm thái thả lỏng vừa phải thường phát huy được phong độ thi đấu đỉnh cao hơn nhiều so với việc lo lắng mù quáng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [费] (fèi) - tiền phí, lệ phí; tiêu tốn, hao tốn [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '费' AND pinyin = 'fèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'fèi',
      meaning_vi = 'tiền phí, lệ phí; tiêu tốn, hao tốn',
      example_hanzi = '每个月他都要在手机软件上按时缴纳家里的水费和电费。',
      example_pinyin = 'Měi gè yuè tā dōu yào zài shǒujī ruǎnjiàn shang ànshí jiǎonà jiālǐ de shuǐfèi hé diànfèi.',
      example_vi = 'Mỗi tháng anh ấy đều phải đóng tiền điện và tiền nước của gia đình đúng hạn trên ứng dụng di động.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '每个月他都要在手机软件上按时缴纳家里的水费和电费。', 'Měi gè yuè tā dōu yào zài shǒujī ruǎnjiàn shang ànshí jiǎonà jiālǐ de shuǐfèi hé diànfèi.', 'Mỗi tháng anh ấy đều phải đóng tiền điện và tiền nước của gia đình đúng hạn trên ứng dụng di động.', 'basic', 1),
        (v_id, '这项极其精密复杂的技术攻关费尽了全体研发工程师长达两年的心血与精力。', 'Zhè xiàng jíqí jīngmì fùzá de jìshù gōngguān fèi jìn le quántǐ yánfā gōngchéngshī cháng dá liǎng nián de xīnxuè yǔ jīnglì.', 'Đợt đột phá kỹ thuật cực kỳ tinh vi phức tạp này đã tiêu tốn biết bao tâm huyết và công sức suốt hai năm ròng của toàn thể kỹ sư nghiên cứu phát triển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [费用] (fèiyong) - chi phí, kinh phí [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 4' AND hanzi = '费用' AND pinyin = 'fèiyong'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 4' AND hanzi = '费用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'fèiyong',
      meaning_vi = 'chi phí, kinh phí',
      example_hanzi = '出差归来之后，他第一时间把交通和住宿的相关费用发票整理报销。',
      example_pinyin = 'Chūchāi guīlái zhīhòu, tā dì-yī shíjiān bǎ jiāotōng hé zhùsù de xiāngguān fèiyong fāpiào zhěnglǐ bàoxiāo.',
      example_vi = 'Sau khi đi công tác trở về, anh ấy lập tức sắp xếp hóa đơn các chi phí liên quan đến ăn ở và đi lại để thanh toán.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出差归来之后，他第一时间把交通和住宿的相关费用发票整理报销。', 'Chūchāi guīlái zhīhòu, tā dì-yī shíjiān bǎ jiāotōng hé zhùsù de xiāngguān fèiyong fāpiào zhěnglǐ bàoxiāo.', 'Sau khi đi công tác trở về, anh ấy lập tức sắp xếp hóa đơn các chi phí liên quan đến ăn ở và đi lại để thanh toán.', 'basic', 1),
        (v_id, '在制定新财年年度财务预算时，管理团队对各项市场推广及研发运营费用进行了严格精细的核算审查。', 'Zài zhìdìng xīn cái nián niándù cáiwù yùsuàn shí, guǎnlǐ tuánduì duì gè xiàng shìchǎng tuīguǎng jí yánfā yùnyíng fèiyong jìnxíng le yángé jīngxì de hésuàn shěnchá.', 'Khi lập dự toán tài chính thường niên cho năm tài khóa mới, đội ngũ quản lý đã tiến hành hạch toán thẩm định chặt chẽ chi tiết đối với mọi khoản chi phí xúc tiến thị trường cũng như vận hành nghiên cứu phát triển.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 200 câu ví dụ cho % từ vựng HSK 4 (Batch 2: #1101 -> #1200)!', v_count;
END $$;
