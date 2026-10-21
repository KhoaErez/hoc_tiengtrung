-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 3 - BATCH 2 (80 TỪ)
-- Phạm vi: Từ [安静] (ānjìng) đến [瘦] (shòu)
-- Tổng số câu ví dụ: 160 câu (2 câu/từ: 1 Cơ bản + 1 Ứng dụng thực tế)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Không tạo từ mới hay bản ghi trùng trong vocabularies
--   - Cập nhật chuẩn hóa cột word_type (Từ loại)
--   - Nạp chính xác 2 câu ví dụ vào bảng vocabulary_examples kèm Pinyin và dịch TV
--   - Đồng bộ cột tương thích ngược example_hanzi trên bảng vocabularies
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN
  -- [安静] (ānjìng) - yên tĩnh, trật tự [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '安静'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'ānjìng',
      example_hanzi = '请大家在图书馆里保持安静。',
      example_pinyin = 'Qǐng dàjiā zài túshūguǎn lǐ bǎochí ānjìng.',
      example_vi = 'Xin mọi người hãy giữ yên lặng trong thư viện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请大家在图书馆里保持安静。', 'Qǐng dàjiā zài túshūguǎn lǐ bǎochí ānjìng.', 'Xin mọi người hãy giữ yên lặng trong thư viện.', 'basic', 1),
        (v_id, '夜晚的公园格外安静，只能听到微风吹拂树叶的声音。', 'Yèwǎn de gōngyuán géwài ānjìng, zhǐ néng tīng dào wēifēng chuīfú shùyè de shēngyīn.', 'Công viên lúc về đêm vô cùng yên tĩnh, chỉ có thể nghe thấy tiếng gió thoảng lay động cành lá.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [完成] (wánchéng) - hoàn thành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '完成'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'wánchéng',
      example_hanzi = '他今天提前完成了所有的作业。',
      example_pinyin = 'Tā jīntiān tíqián wánchéng le suǒyǒu de zuòyè.',
      example_vi = 'Hôm nay cậu ấy đã hoàn thành trước hạn toàn bộ bài tập.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他今天提前完成了所有的作业。', 'Tā jīntiān tíqián wánchéng le suǒyǒu de zuòyè.', 'Hôm nay cậu ấy đã hoàn thành trước hạn toàn bộ bài tập.', 'basic', 1),
        (v_id, '经过全组同事的共同努力，我们顺利完成了这项艰巨的工作任务。', 'Jīngguò quán zǔ tóngshì de gòngtóng nǔlì, wǒmen shùnlì wánchéng le zhè xiàng jiānjù de gōngzuò rènwu.', 'Nhờ sự chung sức nỗ lực của toàn thể đồng nghiệp trong nhóm, chúng tôi đã hoàn thành thuận lợi nhiệm vụ công việc gian nan này.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [客人] (kèrén) - khách, khách khứa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '客人'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'kèrén',
      example_hanzi = '家里今天来了几位重要的客人。',
      example_pinyin = 'Jiālǐ jīntiān lái le jǐ wèi zhòngyào de kèrén.',
      example_vi = 'Hôm nay nhà tôi có vài vị khách quan trọng tới chơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '家里今天来了几位重要的客人。', 'Jiālǐ jīntiān lái le jǐ wèi zhòngyào de kèrén.', 'Hôm nay nhà tôi có vài vị khách quan trọng tới chơi.', 'basic', 1),
        (v_id, '主人热情地端出新鲜的水果和热茶招待前来的客人。', 'Zhǔrén rèqíng de duān chū xīnxiān de shuǐguǒ hé rè chá zhāodài qiánlái de kèrén.', 'Chủ nhà nhiệt tình bưng hoa quả tươi và trà nóng ra tiếp đãi những vị khách tới thăm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [害怕] (hàipà) - sợ hãi, sợ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '害怕'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'hàipà',
      example_hanzi = '小妹妹很害怕晚上一个人走夜路。',
      example_pinyin = 'Xiǎo mèimei hěn hàipà wǎnshang yí gè rén zǒu yèlù.',
      example_vi = 'Em gái nhỏ rất sợ đi đường đêm một mình vào buổi tối.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小妹妹很害怕晚上一个人走夜路。', 'Xiǎo mèimei hěn hàipà wǎnshang yí gè rén zǒu yèlù.', 'Em gái nhỏ rất sợ đi đường đêm một mình vào buổi tối.', 'basic', 1),
        (v_id, '面对生活中的未知挑战，我们不应该感到害怕，而要勇敢面对。', 'Miànduì shēnghuó zhōng de wèizhī tiǎozhàn, wǒmen bù yīnggāi gǎndào hàipà, ér yào yǒnggǎn miànduì.', 'Trước những thử thách chưa biết trong cuộc sống, chúng ta không nên sợ hãi mà phải dũng cảm đối diện.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [容易] (róngyì) - dễ, dễ dàng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '容易'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'róngyì',
      example_hanzi = '这道数学题其实很容易解答。',
      example_pinyin = 'Zhè dào shùxué tí qíshí hěn róngyì jiědá.',
      example_vi = 'Bài toán này thực ra rất dễ giải đáp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这道数学题其实很容易解答。', 'Zhè dào shùxué tí qíshí hěn róngyì jiědá.', 'Bài toán này thực ra rất dễ giải đáp.', 'basic', 1),
        (v_id, '学好一门外语并不容易，需要长期坚持不懈的练习与积累。', 'Xué hǎo yì mén wàiyǔ bìng bù róngyì, xūyào chángqī jiānchí búxiè de liànxí yǔ jīlěi.', 'Học tốt một ngoại ngữ không hề dễ dàng, đòi hỏi sự luyện tập và tích lũy bền bỉ lâu dài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [宾馆] (bīnguǎn) - khách sạn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '宾馆'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bīnguǎn',
      example_hanzi = '我们在火车站对面订了一家宾馆。',
      example_pinyin = 'Wǒmen zài huǒchēzhàn duìmiàn dìng le yì jiā bīnguǎn.',
      example_vi = 'Chúng tôi đã đặt một khách sạn ở đối diện ga tàu hỏa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们在火车站对面订了一家宾馆。', 'Wǒmen zài huǒchēzhàn duìmiàn dìng le yì jiā bīnguǎn.', 'Chúng tôi đã đặt một khách sạn ở đối diện ga tàu hỏa.', 'basic', 1),
        (v_id, '这家宾馆不仅房间干净整洁，而且前台服务态度也特别周到。', 'Zhè jiā bīnguǎn bùjǐn fángjiān gānjìng zhěngjié, érqiě qiántái fúwù tàidu yě tèbié zhōudào.', 'Khách sạn này không những phòng ốc sạch sẽ ngăn nắp mà thái độ phục vụ của lễ tân cũng rất chu đáo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [小心] (xiǎoxīn) - cẩn thận, coi chừng [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '小心'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'xiǎoxīn',
      example_hanzi = '路上有水，走慢点儿，小心路滑。',
      example_pinyin = 'Lù shang yǒu shuǐ, zǒu màn diǎnr, xiǎoxīn lù huá.',
      example_vi = 'Trên đường có nước, đi chậm chút nhé, coi chừng đường trơn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '路上有水，走慢点儿，小心路滑。', 'Lù shang yǒu shuǐ, zǒu màn diǎnr, xiǎoxīn lù huá.', 'Trên đường có nước, đi chậm chút nhé, coi chừng đường trơn.', 'basic', 1),
        (v_id, '过马路的时候一定要多加小心，遵守红绿灯的交通规则。', 'Guò mǎlù de shíhou yídìng yào duō jiā xiǎoxīn, zūnshǒu hóng-lǜdēng de jiāotōng guīzé.', 'Khi qua đường nhất định phải hết sức cẩn thận, tuân thủ quy tắc đèn giao thông.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [层] (céng) - tầng (nhà), lớp (băng, bụi) [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '层'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'céng',
      example_hanzi = '我们的教室在教学楼的三层。',
      example_pinyin = 'Wǒmen de jiàoshì zài jiàoxuélóu de sān céng.',
      example_vi = 'Lớp học của chúng tôi ở tầng ba tòa nhà giảng dạy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们的教室在教学楼的三层。', 'Wǒmen de jiàoshì zài jiàoxuélóu de sān céng.', 'Lớp học của chúng tôi ở tầng ba tòa nhà giảng dạy.', 'basic', 1),
        (v_id, '冬天的河面上结了一层厚厚结实的坚冰。', 'Dōngtiān de hémiàn shang jié le yì céng hòuhòu jiēshi de jiānbīng.', 'Mặt sông mùa đông đóng một lớp băng dày kiên cố.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [差] (chà) - kém, tồi; thiếu [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '差'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'chà',
      example_hanzi = '现在是差五分十二点。',
      example_pinyin = 'Xiànzài shì chà wǔ fēn shí’èr diǎn.',
      example_vi = 'Bây giờ là mười hai giờ kém năm phút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '现在是差五分十二点。', 'Xiànzài shì chà wǔ fēn shí’èr diǎn.', 'Bây giờ là mười hai giờ kém năm phút.', 'basic', 1),
        (v_id, '他最近身体状况比较差，医生建议他多休息少熬夜。', 'Tā zuìjìn shēntǐ zhuàngkuàng bǐjiào chà, yīshēng jiànyì tā duō xiūxi shǎo áoyè.', 'Dạo này tình trạng sức khỏe của anh ấy khá kém, bác sĩ khuyên nên nghỉ ngơi nhiều và bớt thức khuya.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [带] (dài) - mang theo, dẫn dắt, đeo [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '带'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dài',
      example_hanzi = '今天可能下雨，出门记得带把伞。',
      example_pinyin = 'Jīntiān kěnéng xiàyǔ, chūmén jìde dài bǎ sǎn.',
      example_vi = 'Hôm nay có thể mưa, ra ngoài nhớ mang theo cây dù.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天可能下雨，出门记得带把伞。', 'Jīntiān kěnéng xiàyǔ, chūmén jìde dài bǎ sǎn.', 'Hôm nay có thể mưa, ra ngoài nhớ mang theo cây dù.', 'basic', 1),
        (v_id, '周末爸爸打算带我们全家去郊外的森林公园散步野餐。', 'Zhōumò bàba dǎsuàn dài wǒmen quán jiā qù jiāowài de sēnlín gōngyuán sànbù yěcān.', 'Cuối tuần bố dự định dẫn cả nhà chúng tôi đến công viên rừng ở ngoại ô đi dạo dã ngoại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [帮助] (bāngzhù) - giúp đỡ, sự hỗ trợ [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '帮助'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'bāngzhù',
      example_hanzi = '非常感谢你在学习上给我的帮助。',
      example_pinyin = 'Fēicháng gǎnxiè nǐ zài xuéxí shang gěi wǒ de bāngzhù.',
      example_vi = 'Rất cảm ơn sự giúp đỡ của bạn dành cho tôi trong học tập.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '非常感谢你在学习上给我的帮助。', 'Fēicháng gǎnxiè nǐ zài xuéxí shang gěi wǒ de bāngzhù.', 'Rất cảm ơn sự giúp đỡ của bạn dành cho tôi trong học tập.', 'basic', 1),
        (v_id, '在生活中遇到困难时，互帮互助能让友谊更加深厚。', 'Zài shēnghuó zhōng yù dào kùnnan shí, hù bāng hù zhù néng ràng yǒuyì gèngjiā shēnhòu.', 'Khi gặp khó khăn trong cuộc sống, tương trợ lẫn nhau sẽ làm cho tình bạn thêm sâu sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [干净] (gānjìng) - sạch sẽ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '干净'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'gānjìng',
      example_hanzi = '同学们把教室打扫得干干净净。',
      example_pinyin = 'Tóngxuémen bǎ jiàoshì dǎsǎo de gāngānjìngjìng.',
      example_vi = 'Các bạn học quét dọn phòng học sạch sành sanh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '同学们把教室打扫得干干净净。', 'Tóngxuémen bǎ jiàoshì dǎsǎo de gāngānjìngjìng.', 'Các bạn học quét dọn phòng học sạch sành sanh.', 'basic', 1),
        (v_id, '饭前便后一定要用肥皂洗手，保持双手干净卫生。', 'Fàn qián biàn hòu yídìng yào yòng féizào xǐshǒu, bǎochí shuāngshǒu gānjìng wèishēng.', 'Trước khi ăn và sau khi đi vệ sinh nhất định phải rửa tay bằng xà phòng để giữ đôi tay sạch sẽ vệ sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [年级] (niánjí) - lớp, năm học, khối lớp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '年级'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'niánjí',
      example_hanzi = '我弟弟正在上小学三年级。',
      example_pinyin = 'Wǒ dìdi zhèngzài shàng xiǎoxué sān niánjí.',
      example_vi = 'Em trai tôi đang học lớp ba tiểu học.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我弟弟正在上小学三年级。', 'Wǒ dìdi zhèngzài shàng xiǎoxué sān niánjí.', 'Em trai tôi đang học lớp ba tiểu học.', 'basic', 1),
        (v_id, '新学期到了，高年级的学长们热情地帮助新生搬运行李。', 'Xīn xuéqī dào le, gāo niánjí de xuézhǎngmen rèqíng de bāngzhù xīnshēng bānyùn xíngli.', 'Học kỳ mới đến rồi, các anh chị khóa trên nhiệt tình giúp đỡ tân sinh viên vận chuyển hành lý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [年轻] (niánqīng) - trẻ tuổi, thanh xuân [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '年轻'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'niánqīng',
      example_hanzi = '她看起来比实际年龄年轻得多。',
      example_pinyin = 'Tā kàn qǐlái bǐ shíjì niánlíng niánqīng de duō.',
      example_vi = 'Cô ấy trông trẻ hơn tuổi thật rất nhiều.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '她看起来比实际年龄年轻得多。', 'Tā kàn qǐlái bǐ shíjì niánlíng niánqīng de duō.', 'Cô ấy trông trẻ hơn tuổi thật rất nhiều.', 'basic', 1),
        (v_id, '趁着年轻精力充沛，我们应该多读书、多开阔自己的眼界。', 'Chèn zhe niánqīng jīnglì chōngpèi, wǒmen yīnggāi duō dúshū, duō kāikuò zìjǐ de yǎnjiè.', 'Nhân lúc còn trẻ tuổi tràn đầy năng lượng, chúng ta nên đọc nhiều sách và mở rộng tầm mắt của bản thân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [应该] (yīnggāi) - nên, phải [Động từ năng nguyện]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '应该'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ năng nguyện',
      pinyin = 'yīnggāi',
      example_hanzi = '上课的时候应该认真听讲。',
      example_pinyin = 'Shàngkè de shíhou yīnggāi rènzhēn tīngjiǎng.',
      example_vi = 'Trong giờ học nên chăm chú nghe giảng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '上课的时候应该认真听讲。', 'Shàngkè de shíhou yīnggāi rènzhēn tīngjiǎng.', 'Trong giờ học nên chăm chú nghe giảng.', 'basic', 1),
        (v_id, '遇到别人需要帮助时，我们应该主动伸出援手。', 'Yù dào biérén xūyào bāngzhù shí, wǒmen yīnggāi zhǔdòng shēn chū yuánshǒu.', 'Khi gặp người khác cần giúp đỡ, chúng ta nên chủ động đưa tay hỗ trợ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [张] (zhāng) - tấm, tờ, chiếc (giấy, thẻ, bàn, vé) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '张'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'zhāng',
      example_hanzi = '请递给我一张白纸写笔记。',
      example_pinyin = 'Qǐng dì gěi wǒ yì zhāng bái zhǐ xiě bǐjì.',
      example_vi = 'Làm ơn đưa cho tôi một tờ giấy trắng để ghi chép.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请递给我一张白纸写笔记。', 'Qǐng dì gěi wǒ yì zhāng bái zhǐ xiě bǐjì.', 'Làm ơn đưa cho tôi một tờ giấy trắng để ghi chép.', 'basic', 1),
        (v_id, '他在网上预订了一张明天早上去北京的高铁车票。', 'Tā zài wǎng shang yùdìng le yì zhāng míngtiān zǎoshang qù Běijīng de gāotiě chēpiào.', 'Anh ấy đã đặt trước trên mạng một tấm vé tàu cao tốc đi Bắc Kinh vào sáng mai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [当然] (dāngrán) - đương nhiên, tất nhiên [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '当然'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'dāngrán',
      example_hanzi = '你遇到困难，我当然会尽力帮你。',
      example_pinyin = 'Nǐ yù dào kùnnan, wǒ dāngrán huì jìnlì bāng nǐ.',
      example_vi = 'Bạn gặp khó khăn thì đương nhiên tôi sẽ dốc sức giúp đỡ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你遇到困难，我当然会尽力帮你。', 'Nǐ yù dào kùnnan, wǒ dāngrán huì jìnlì bāng nǐ.', 'Bạn gặp khó khăn thì đương nhiên tôi sẽ dốc sức giúp đỡ.', 'basic', 1),
        (v_id, '要想在比赛中取得优异成绩，平时的刻苦训练当然是必不可少的。', 'Yào xiǎng zài bǐsài zhōng qǔdé yōuyì chéngjì, píngshí de kèkǔ xùnliàn dāngrán shì bì bù kě shǎo de.', 'Muốn giành được thành tích xuất sắc trong cuộc thi thì việc luyện tập chăm chỉ ngày thường đương nhiên là không thể thiếu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [影响] (yǐngxiǎng) - ảnh hưởng, tác động [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '影响'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'yǐngxiǎng',
      example_hanzi = '看电视声音太大，会影响别人休息。',
      example_pinyin = 'Kàn diànshì shēngyīn tài dà, huì yǐngxiǎng biérén xiūxi.',
      example_vi = 'Xem tivi âm thanh to quá sẽ ảnh hưởng đến người khác nghỉ ngơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '看电视声音太大，会影响别人休息。', 'Kàn diànshì shēngyīn tài dà, huì yǐngxiǎng biérén xiūxi.', 'Xem tivi âm thanh to quá sẽ ảnh hưởng đến người khác nghỉ ngơi.', 'basic', 1),
        (v_id, '父母的良好言行习惯对孩子的成长有着深远的影响。', 'Fùmǔ de liánghǎo yánxíng xíguàn duì háizi de chéngzhǎng yǒu zhe shēnyuǎn de yǐngxiǎng.', 'Thói quen lời nói và hành vi tốt đẹp của cha mẹ có ảnh hưởng sâu sắc đến sự trưởng thành của con trẻ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [必须] (bìxū) - phải, nhất thiết phải [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '必须'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'bìxū',
      example_hanzi = '今天的工作任务必须在下班前完成。',
      example_pinyin = 'Jīntiān de gōngzuò rènwu bìxū zài xiàbān qián wánchéng.',
      example_vi = 'Nhiệm vụ công việc hôm nay nhất thiết phải hoàn thành trước lúc tan sở.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天的工作任务必须在下班前完成。', 'Jīntiān de gōngzuò rènwu bìxū zài xiàbān qián wánchéng.', 'Nhiệm vụ công việc hôm nay nhất thiết phải hoàn thành trước lúc tan sở.', 'basic', 1),
        (v_id, '乘坐国际航班出行，登机时必须出示有效护照和机票。', 'Chéngzuò guójì hángbān chūxíng, dēngjī shí bìxū chūshì yǒuxiào hùzhào hé jīpiào.', 'Đi các chuyến bay quốc tế, khi lên máy bay nhất thiết phải xuất trình hộ chiếu hợp lệ và vé máy bay.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [忘记] (wàngjì) - quên, quên mất [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '忘记'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'wàngjì',
      example_hanzi = '出门时千万别忘记锁门。',
      example_pinyin = 'Chūmén shí qiānwàn bié wàngjì suǒ mén.',
      example_vi = 'Khi ra ngoài tuyệt đối đừng quên khóa cửa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出门时千万别忘记锁门。', 'Chūmén shí qiānwàn bié wàngjì suǒ mén.', 'Khi ra ngoài tuyệt đối đừng quên khóa cửa.', 'basic', 1),
        (v_id, '虽然毕业很多年了，但我永远不会忘记老师当年的教诲。', 'Suīrán bìyè hěn duō nián le, dàn wǒ yǒngyuǎn bú huì wàngjì lǎoshī dāngnián de jiàohuì.', 'Tuy đã tốt nghiệp nhiều năm rồi nhưng tôi vĩnh viễn không bao giờ quên lời dạy bảo của thầy cô năm xưa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [总是] (zǒngshì) - luôn luôn, lúc nào cũng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '总是'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'zǒngshì',
      example_hanzi = '他总是热心地帮助身边有困难的同学。',
      example_pinyin = 'Tā zǒngshì rèxīn de bāngzhù shēnbiān yǒu kùnnan de tóngxué.',
      example_vi = 'Anh ấy lúc nào cũng nhiệt tình giúp đỡ bạn học gặp khó khăn xung quanh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他总是热心地帮助身边有困难的同学。', 'Tā zǒngshì rèxīn de bāngzhù shēnbiān yǒu kùnnan de tóngxué.', 'Anh ấy lúc nào cũng nhiệt tình giúp đỡ bạn học gặp khó khăn xung quanh.', 'basic', 1),
        (v_id, '无论遇到多么繁重的工作，她的脸上总是带着自信温暖的微笑。', 'Wúlùn yù dào duōme fánzhòng de gōngzuò, tā de liǎn shang zǒngshì dài zhe zìxìn wēnnuǎn de wēixiào.', 'Bất luận gặp phải công việc bề bộn thế nào, trên gương mặt cô ấy luôn nở nụ cười tự tin và ấm áp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感兴趣] (gǎn xìngqù) - có hứng thú, thích thú [Cụm động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '感兴趣'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Cụm động từ',
      pinyin = 'gǎn xìngqù',
      example_hanzi = '我对学习中国传统茶文化很感兴趣。',
      example_pinyin = 'Wǒ duì xuéxí Zhōngguó chuántǒng chá wénhuà hěn gǎn xìngqù.',
      example_vi = 'Tôi rất có hứng thú với việc học hỏi văn hóa trà truyền thống Trung Hoa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我对学习中国传统茶文化很感兴趣。', 'Wǒ duì xuéxí Zhōngguó chuántǒng chá wénhuà hěn gǎn xìngqù.', 'Tôi rất có hứng thú với việc học hỏi văn hóa trà truyền thống Trung Hoa.', 'basic', 1),
        (v_id, '只要能找到自己真正感兴趣的专业方向，学习就会变成一件快乐的事情。', 'Zhǐyào néng zhǎodào zìjǐ zhēnzhèng gǎn xìngqù de zhuānyè fāngxiàng, xuéxí jiù huì biànchéng yí jiàn kuàilè de shìqing.', 'Chỉ cần tìm ra hướng chuyên ngành mà bản thân thực sự có hứng thú, việc học sẽ trở thành một điều đầy niềm vui.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [感冒] (gǎnmào) - cảm cúm, bị cảm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '感冒'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'gǎnmào',
      example_hanzi = '天气变冷了，多穿衣服别感冒了。',
      example_pinyin = 'Tiānqì biàn lěng le, duō chuān yīfu bié gǎnmào le.',
      example_vi = 'Thời tiết trở lạnh rồi, mặc nhiều áo vào kẻo bị cảm đấy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '天气变冷了，多穿衣服别感冒了。', 'Tiānqì biàn lěng le, duō chuān yīfu bié gǎnmào le.', 'Thời tiết trở lạnh rồi, mặc nhiều áo vào kẻo bị cảm đấy.', 'basic', 1),
        (v_id, '他最近不小心得了重感冒，伴有咳嗽发烧，在家里休息了两天。', 'Tā zuìjìn bù xiǎoxīn dé le zhòng gǎnmào, bàn yǒu késou fāshāo, zài jiālǐ xiūxi le liǎng tiān.', 'Dạo này anh ấy sơ ý bị cảm nặng kèm theo ho và sốt, đã ở nhà nghỉ ngơi hai ngày.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [愿意] (yuànyì) - bằng lòng, sẵn lòng, muốn [Động từ năng nguyện]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '愿意'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ năng nguyện',
      pinyin = 'yuànyì',
      example_hanzi = '你愿意和我一起去参加今晚的音乐会吗？',
      example_pinyin = 'Nǐ yuànyì hé wǒ yìqǐ qù cānjiā jīnwǎn de yīnyuèhuì ma?',
      example_vi = 'Bạn có bằng lòng cùng tôi đi tham dự buổi hòa nhạc tối nay không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你愿意和我一起去参加今晚的音乐会吗？', 'Nǐ yuànyì hé wǒ yìqǐ qù cānjiā jīnwǎn de yīnyuèhuì ma?', 'Bạn có bằng lòng cùng tôi đi tham dự buổi hòa nhạc tối nay không?', 'basic', 1),
        (v_id, '只要是能够为社会做贡献的事情，他都非常愿意全力以赴去做好。', 'Zhǐyào shì nénggòu wèi shèhuì zuò gòngxiàn de shìqing, tā dōu fēicháng yuànyì quánlìyǐfù qù zuò hǎo.', 'Chỉ cần là việc có thể cống hiến cho xã hội, anh ấy đều rất sẵn lòng dốc hết sức mình làm cho thật tốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [成绩] (chéngjì) - thành tích, kết quả, điểm số [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '成绩'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chéngjì',
      example_hanzi = '他在这次期末考试中取得了优秀的成绩。',
      example_pinyin = 'Tā zài zhè cì qīmò kǎoshì zhōng qǔdé le yōuxiù de chéngjì.',
      example_vi = 'Anh ấy đã đạt được thành tích xuất sắc trong kỳ thi cuối kỳ lần này.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在这次期末考试中取得了优秀的成绩。', 'Tā zài zhè cì qīmò kǎoshì zhōng qǔdé le yōuxiù de chéngjì.', 'Anh ấy đã đạt được thành tích xuất sắc trong kỳ thi cuối kỳ lần này.', 'basic', 1),
        (v_id, '付出多少努力就会收获多少成绩，学习容不得半点虚假。', 'Fùchū duōshao nǔlì jiù huì shōuhuò duōshao chéngjì, xuéxí róngbùdé bàndiǎn xūjiǎ.', 'Bỏ ra bao nhiêu nỗ lực sẽ thu về bấy nhiêu thành tích, việc học không cho phép chút giả tạo nào.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [或者] (huòzhě) - hoặc là, hoặc (dùng trong câu trần thuật) [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '或者'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'huòzhě',
      example_hanzi = '你可以乘坐地铁或者公交车去火车站。',
      example_pinyin = 'Nǐ kěyǐ chéngzuò dìtiě huòzhě gōngjiāochē qù huǒchēzhàn.',
      example_vi = 'Bạn có thể đi tàu điện ngầm hoặc xe buýt đến ga tàu hỏa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你可以乘坐地铁或者公交车去火车站。', 'Nǐ kěyǐ chéngzuò dìtiě huòzhě gōngjiāochē qù huǒchēzhàn.', 'Bạn có thể đi tàu điện ngầm hoặc xe buýt đến ga tàu hỏa.', 'basic', 1),
        (v_id, '周末我通常在家里看书自习，或者陪父母到公园散步散心。', 'Zhōumò wǒ tōngcháng zài jiālǐ kànshū zìxí, huòzhě péi fùmǔ dào gōngyuán sànbù sànxīn.', 'Cuối tuần tôi thường ở nhà đọc sách tự học, hoặc cùng cha mẹ ra công viên đi dạo ngắm cảnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打扫] (dǎsǎo) - quét dọn, dọn dẹp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '打扫'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'dǎsǎo',
      example_hanzi = '周末我们要把整个房间彻底打扫一遍。',
      example_pinyin = 'Zhōumò wǒmen yào bǎ zhěnggè fángjiān chèdǐ dǎsǎo yí biàn.',
      example_vi = 'Cuối tuần chúng tôi phải quét dọn triệt để toàn bộ căn phòng một lượt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末我们要把整个房间彻底打扫一遍。', 'Zhōumò wǒmen yào bǎ zhěnggè fángjiān chèdǐ dǎsǎo yí biàn.', 'Cuối tuần chúng tôi phải quét dọn triệt để toàn bộ căn phòng một lượt.', 'basic', 1),
        (v_id, '放假前，全班同学一起动手把教室打扫得窗明几净。', 'Fàngjià qián, quán bān tóngxué yìqǐ dòngshǒu bǎ jiàoshì dǎsǎo de chuāngmíng-jǐjìng.', 'Trước khi nghỉ lễ, cả lớp cùng nhau bắt tay quét dọn phòng học sáng sủa sạch sẽ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [打算] (dǎsuàn) - dự định, tính toán [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '打算'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'dǎsuàn',
      example_hanzi = '这个暑假你打算去哪儿旅游？',
      example_pinyin = 'Zhè ge shǔjià nǐ dǎsuàn qù nǎr lǚyóu?',
      example_vi = 'Kỳ nghỉ hè này bạn dự định đi đâu du lịch?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个暑假你打算去哪儿旅游？', 'Zhè ge shǔjià nǐ dǎsuàn qù nǎr lǚyóu?', 'Kỳ nghỉ hè này bạn dự định đi đâu du lịch?', 'basic', 1),
        (v_id, '大学毕业后，他打算先去企业实习两年再继续考研深造。', 'Dàxué bìyè hòu, tā dǎsuàn xiān qù qǐyè shíxí liǎng nián zài jìxù kǎoyán shēnzào.', 'Sau khi tốt nghiệp đại học, anh ấy dự định đến doanh nghiệp thực tập hai năm rồi mới tiếp tục thi thạc sĩ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [把] (bǎ) - đem, lấy (câu chữ 把); cái, chiếc (ghế, ô, thìa) [Giới từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '把'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ / Lượng từ',
      pinyin = 'bǎ',
      example_hanzi = '请把桌子上的书递给我。',
      example_pinyin = 'Qǐng bǎ zhuōzi shang de shū dì gěi wǒ.',
      example_vi = 'Làm ơn đưa cho tôi cuốn sách trên bàn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把桌子上的书递给我。', 'Qǐng bǎ zhuōzi shang de shū dì gěi wǒ.', 'Làm ơn đưa cho tôi cuốn sách trên bàn.', 'basic', 1),
        (v_id, '出门前他仔细把所有的门窗都关好，确保家里安全。', 'Chūmén qián tā zǐxì bǎ suǒyǒu de ménchuāng dōu guān hǎo, quèbǎo jiālǐ ānquán.', 'Trước khi ra ngoài anh ấy cẩn thận đóng chặt tất cả cửa nẻo để bảo đảm trong nhà an toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [护照] (hùzhào) - hộ chiếu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '护照'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hùzhào',
      example_hanzi = '出国旅游前请检查护照是否在有效期内。',
      example_pinyin = 'Chūguó lǚyóu qián qǐng jiǎnchá hùzhào shìfǒu zài yǒuxiàoqī nèi.',
      example_vi = 'Trước khi đi du lịch nước ngoài xin hãy kiểm tra xem hộ chiếu còn hạn sử dụng không.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出国旅游前请检查护照是否在有效期内。', 'Chūguó lǚyóu qián qǐng jiǎnchá hùzhào shìfǒu zài yǒuxiàoqī nèi.', 'Trước khi đi du lịch nước ngoài xin hãy kiểm tra xem hộ chiếu còn hạn sử dụng không.', 'basic', 1),
        (v_id, '在境外旅行期间，一定要随身妥善保管好个人的护照和重要证件。', 'Zài jìngwài lǚxíng qījiān, yídìng yào suíshēn tuǒshàn bǎoguǎn hǎo gèrén de hùzhào hé zhòngyào zhèngjiàn.', 'Trong thời gian du lịch ở nước ngoài, nhất định phải cất giữ bảo quản cẩn thận hộ chiếu cá nhân và giấy tờ quan trọng bên mình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [报纸] (bàozhǐ) - báo, tờ báo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '报纸'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bàozhǐ',
      example_hanzi = '爷爷每天早上都有读报纸的习惯。',
      example_pinyin = 'Yéye měitiān zǎoshang dōu yǒu dú bàozhǐ de xíguàn.',
      example_vi = 'Ông nội sáng nào cũng có thói quen đọc báo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爷爷每天早上都有读报纸的习惯。', 'Yéye měitiān zǎoshang dōu yǒu dú bàozhǐ de xíguàn.', 'Ông nội sáng nào cũng có thói quen đọc báo.', 'basic', 1),
        (v_id, '今天的当地报纸详细报道了昨天在我们社区举办的文化交流活动。', 'Jīntiān de dāngdì bàozhǐ xiángxì bàodào le zuótiān zài wǒmen shèqū jǔbàn de wénhuà jiāoliú huódòng.', 'Tờ báo địa phương hôm nay đã đưa tin chi tiết về hoạt động giao lưu văn hóa tổ chức tại khu phố chúng tôi ngày hôm qua.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [担心] (dānxīn) - lo lắng, bận tâm [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '担心'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'dānxīn',
      example_hanzi = '别担心，一切都会好起来的。',
      example_pinyin = 'Bié dānxīn, yíqiè dōu huì hǎo qǐlái de.',
      example_vi = 'Đừng lo lắng, mọi chuyện rồi sẽ tốt đẹp lên thôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '别担心，一切都会好起来的。', 'Bié dānxīn, yíqiè dōu huì hǎo qǐlái de.', 'Đừng lo lắng, mọi chuyện rồi sẽ tốt đẹp lên thôi.', 'basic', 1),
        (v_id, '孩子第一次独自出远门求学，做父母的心里难免感到牵挂担心。', 'Háizi dì-yī cì dúzì chū yuǎnmén qiúxué, zuò fùmǔ de xīnlǐ nánmiǎn gǎndào qiānguà dānxīn.', 'Con cái lần đầu tiên một mình đi học xa nhà, bậc làm cha mẹ trong lòng khó tránh khỏi cảm giác bận tâm lo lắng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [换] (huàn) - đổi, thay (quần áo, tiền, xe) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '换'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'huàn',
      example_hanzi = '我想去银行把这些美元换成人民币。',
      example_pinyin = 'Wǒ xiǎng qù yínháng bǎ zhèxiē Měiyuán huàn chéng Rénmínbì.',
      example_vi = 'Tôi muốn đến ngân hàng đổi số đô la Mỹ này sang đồng Nhân dân tệ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我想去银行把这些美元换成人民币。', 'Wǒ xiǎng qù yínháng bǎ zhèxiē Měiyuán huàn chéng Rénmínbì.', 'Tôi muốn đến ngân hàng đổi số đô la Mỹ này sang đồng Nhân dân tệ.', 'basic', 1),
        (v_id, '坐地铁到人民广场站换乘二号线，就能直接到达机场。', 'Zuò dìtiě dào Rénmín Guǎngchǎng zhàn huànchéng èr hào xiàn, jiù néng zhíjiē dàodá jīchǎng.', 'Đi tàu điện ngầm đến ga Quảng trường Nhân Dân chuyển sang tuyến số 2 là có thể đến thẳng sân bay.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [接] (jiē) - đón (người), nhận (điện thoại), tiếp nhận [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '接'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiē',
      example_hanzi = '下午四点我去机场接一位外国朋友。',
      example_pinyin = 'Xiàwǔ sì diǎn wǒ qù jīchǎng jiē yí wèi wàiguó péngyou.',
      example_vi = 'Bốn giờ chiều tôi ra sân bay đón một người bạn nước ngoài.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下午四点我去机场接一位外国朋友。', 'Xiàwǔ sì diǎn wǒ qù jīchǎng jiē yí wèi wàiguó péngyou.', 'Bốn giờ chiều tôi ra sân bay đón một người bạn nước ngoài.', 'basic', 1),
        (v_id, '他正在开一个重要会议，现在不方便接听私人电话。', 'Tā zhèngzài kāi yí gè zhòngyào huìyì, xiànzài bù fāngbiàn jiētīng sīrén diànhuà.', 'Anh ấy đang chủ trì một cuộc họp quan trọng, bây giờ không tiện nghe điện thoại riêng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [提高] (tígāo) - nâng cao, cải thiện [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '提高'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tígāo',
      example_hanzi = '多听多说能有效提高汉语口语水平。',
      example_pinyin = 'Duō tīng duō shuō néng yǒuxiào tígāo Hànyǔ kǒuyǔ shuǐpíng.',
      example_vi = 'Nghe nhiều nói nhiều có thể nâng cao hiệu quả trình độ khẩu ngữ tiếng Trung.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '多听多说能有效提高汉语口语水平。', 'Duō tīng duō shuō néng yǒuxiào tígāo Hànyǔ kǒuyǔ shuǐpíng.', 'Nghe nhiều nói nhiều có thể nâng cao hiệu quả trình độ khẩu ngữ tiếng Trung.', 'basic', 1),
        (v_id, '公司通过引进先进的生产设备，极大地提高了工人的工作效率。', 'Gōngsī tōngguò yǐnjìn xiānjìn de shēngchǎn shèbèi, jídà de tígāo le gōngrén de gōngzuò xiàolǜ.', 'Công ty thông qua việc áp dụng thiết bị sản xuất hiện đại đã nâng cao vượt bậc năng suất làm việc của công nhân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [搬] (bān) - dọn, chuyển, khiêng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '搬'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'bān',
      example_hanzi = '请帮我把这个重箱子搬到楼上去。',
      example_pinyin = 'Qǐng bāng wǒ bǎ zhè ge zhòng xiāngzi bān dào lóu shang qù.',
      example_vi = 'Làm ơn giúp tôi khiêng chiếc thùng nặng này lên trên tầng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请帮我把这个重箱子搬到楼上去。', 'Qǐng bāng wǒ bǎ zhè ge zhòng xiāngzi bān dào lóu shang qù.', 'Làm ơn giúp tôi khiêng chiếc thùng nặng này lên trên tầng.', 'basic', 1),
        (v_id, '下周我们要搬进新公寓了，这几天都在忙着整理打包行李。', 'Xià zhōu wǒmen yào bān jìn xīn gōngyù le, zhè jǐ tiān dōu zài máng zhe zhěnglǐ dǎbāo xíngli.', 'Tuần sau chúng tôi sẽ chuyển vào căn hộ mới rồi, mấy ngày nay đều bận rộn thu dọn đóng gói hành lý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [放] (fàng) - đặt, để, buông thả, cho vào [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '放'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fàng',
      example_hanzi = '请把书包放在旁边的椅子上。',
      example_pinyin = 'Qǐng bǎ shūbāo fàng zài pángbiān de yǐzi shang.',
      example_vi = 'Xin hãy để cặp sách lên chiếc ghế bên cạnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把书包放在旁边的椅子上。', 'Qǐng bǎ shūbāo fàng zài pángbiān de yǐzi shang.', 'Xin hãy để cặp sách lên chiếc ghế bên cạnh.', 'basic', 1),
        (v_id, '煮汤的时候只要放少许盐和姜丝，味道就很鲜美。', 'Zhǔ tāng de shíhou zhǐyào fàng shǎoxǔ yán hé jiāngsī, wèidao jiù hěn xiānměi.', 'Khi nấu canh chỉ cần cho chút muối và gừng thái sợi là hương vị đã rất thanh ngọt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [放心] (fàngxīn) - yên tâm [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '放心'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'fàngxīn',
      example_hanzi = '你放心吧，这件事情我一定会办好的。',
      example_pinyin = 'Nǐ fàngxīn ba, zhè jiàn shìqing wǒ yídìng huì bàn hǎo de.',
      example_vi = 'Bạn cứ yên tâm đi, chuyện này tôi nhất định sẽ giải quyết chu toàn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你放心吧，这件事情我一定会办好的。', 'Nǐ fàngxīn ba, zhè jiàn shìqing wǒ yídìng huì bàn hǎo de.', 'Bạn cứ yên tâm đi, chuyện này tôi nhất định sẽ giải quyết chu toàn.', 'basic', 1),
        (v_id, '看到孩子平安健康地回到家里，母亲悬着的心终于放了下来。', 'Kàndào háizi píng’ān jiànkāng de huí dào jiālǐ, mǔqīn xuán zhe de xīn zhōngyú fàng le xiàlái.', 'Nhìn thấy con cái bình an khỏe mạnh về tới nhà, tấm lòng thấp thỏm của người mẹ cuối cùng cũng yên lòng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [故事] (gùshi) - câu chuyện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '故事'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gùshi',
      example_hanzi = '睡觉前妈妈经常给我讲童话故事。',
      example_pinyin = 'Shuìjiào qián māma jīngcháng gěi wǒ jiǎng tónghuà gùshi.',
      example_vi = 'Trước khi đi ngủ mẹ thường kể cho tôi nghe các câu chuyện cổ tích.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '睡觉前妈妈经常给我讲童话故事。', 'Shuìjiào qián māma jīngcháng gěi wǒ jiǎng tónghuà gùshi.', 'Trước khi đi ngủ mẹ thường kể cho tôi nghe các câu chuyện cổ tích.', 'basic', 1),
        (v_id, '这位老人用生动幽默的语言，向大家讲述了许多有趣的民间历史故事。', 'Zhè wèi lǎorén yòng shēngdòng yōumò de yǔyán, xiàng dàjiā jiǎngshù le xǔduō yǒuqù de mínjiān lìshǐ gùshi.', 'Cụ già dùng ngôn ngữ sinh động và hóm hỉnh đã kể cho mọi người nghe nhiều câu chuyện lịch sử dân gian thú vị.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [数学] (shùxué) - môn toán, toán học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '数学'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shùxué',
      example_hanzi = '他在中学阶段最喜欢的科目就是数学。',
      example_pinyin = 'Tā zài zhōngxué jiēduàn zuì xǐhuan de kēmù jiù shì shùxué.',
      example_vi = 'Ở giai đoạn cấp hai môn học anh ấy yêu thích nhất chính là toán học.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他在中学阶段最喜欢的科目就是数学。', 'Tā zài zhōngxué jiēduàn zuì xǐhuan de kēmù jiù shì shùxué.', 'Ở giai đoạn cấp hai môn học anh ấy yêu thích nhất chính là toán học.', 'basic', 1),
        (v_id, '学好数学不仅能锻炼缜密的逻辑思维能力，对解决实际问题也大有帮助。', 'Xué hǎo shùxué bùjǐn néng duànliàn zhěnmì de luóji sīwéi nénglì, duì jiějué shíjì wèntí yě dà yǒu bāngzhù.', 'Học tốt môn toán không chỉ rèn luyện tư duy logic chặt chẽ mà còn giúp ích rất lớn cho việc giải quyết các vấn đề thực tế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [文化] (wénhuà) - văn hóa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '文化'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'wénhuà',
      example_hanzi = '中国传统书法是中华文化的重要组成部分。',
      example_pinyin = 'Zhōngguó chuántǒng shūfǎ shì Zhōnghuá wénhuà de zhòngyào zǔchéng bùfen.',
      example_vi = 'Thư pháp truyền thống Trung Quốc là bộ phận cấu thành quan trọng của văn hóa Trung Hoa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国传统书法是中华文化的重要组成部分。', 'Zhōngguó chuántǒng shūfǎ shì Zhōnghuá wénhuà de zhòngyào zǔchéng bùfen.', 'Thư pháp truyền thống Trung Quốc là bộ phận cấu thành quan trọng của văn hóa Trung Hoa.', 'basic', 1),
        (v_id, '了解不同民族的悠久历史与灿烂文化，能够促进各国人民之间的友谊。', 'Liǎojiě bù tóng mínzú de yōujiǔ lìshǐ yǔ cànlàn wénhuà, nénggòu cùjìn gè guó rénmín zhījiān de yǒuyì.', 'Tìm hiểu lịch sử lâu đời và nền văn hóa rực rỡ của các dân tộc khác nhau có thể thúc đẩy tình hữu nghị giữa nhân dân các nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [新闻] (xīnwén) - tin tức, thời sự [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '新闻'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xīnwén',
      example_hanzi = '爸爸每天晚上七点准时看电视新闻。',
      example_pinyin = 'Bàba měitiān wǎnshang qī diǎn zhǔnshí kàn diànshì xīnwén.',
      example_vi = 'Bố tôi mỗi tối bảy giờ đúng đều xem thời sự trên tivi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '爸爸每天晚上七点准时看电视新闻。', 'Bàba měitiān wǎnshang qī diǎn zhǔnshí kàn diànshì xīnwén.', 'Bố tôi mỗi tối bảy giờ đúng đều xem thời sự trên tivi.', 'basic', 1),
        (v_id, '现在人们可以通过手机客户端随时随地浏览来自全球的最新突发新闻。', 'Xiànzài rénmen kěyǐ tōngguò shǒujī kèhùduān suíshí suídì liúlǎn láizì quánqiú de zuìxīn tūfā xīnwén.', 'Hiện nay mọi người có thể thông qua ứng dụng di động lướt xem tin tức nóng sốt mới nhất từ khắp toàn cầu mọi lúc mọi nơi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [新鲜] (xīnxiān) - tươi, tươi mới, mới mẻ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '新鲜'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'xīnxiān',
      example_hanzi = '早市上的蔬菜和水果都特别新鲜。',
      example_pinyin = 'Zǎoshì shang de shūcài hé shuǐguǒ dōu tèbié xīnxiān.',
      example_vi = 'Rau củ và hoa quả ở chợ sớm đều đặc biệt tươi ngon.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '早市上的蔬菜和水果都特别新鲜。', 'Zǎoshì shang de shūcài hé shuǐguǒ dōu tèbié xīnxiān.', 'Rau củ và hoa quả ở chợ sớm đều đặc biệt tươi ngon.', 'basic', 1),
        (v_id, '清晨去郊外的树林里散步，呼吸一下新鲜纯净的空气，让人精神振奋。', 'Qīngchén qù jiāowài de shùlín lǐ sànbù, hūxī yíxià xīnxiān chúnjìng de kōngqì, ràng rén jīngshén zhènfèn.', 'Sáng sớm đến rừng cây ngoại ô dạo bước hít thở không khí trong lành tươi mới khiến con người phấn chấn tinh thần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [方便] (fāngbiàn) - thuận tiện, tiện lợi [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '方便'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'fāngbiàn',
      example_hanzi = '出门坐地铁出行非常快捷方便。',
      example_pinyin = 'Chūmén zuò dìtiě chūxíng fēicháng kuàijié fāngbiàn.',
      example_vi = 'Ra ngoài đi bằng tàu điện ngầm rất nhanh chóng và thuận tiện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出门坐地铁出行非常快捷方便。', 'Chūmén zuò dìtiě chūxíng fēicháng kuàijié fāngbiàn.', 'Ra ngoài đi bằng tàu điện ngầm rất nhanh chóng và thuận tiện.', 'basic', 1),
        (v_id, '现在手机移动支付十分发达，出门不用带现金也能非常方便地购物。', 'Xiànzài shǒujī yídòng zhīfù shífēn fādá, chūmén búyòng dài xiànjīn yě néng fēicháng fāngbiàn de gòuwù.', 'Hiện nay thanh toán di động trên điện thoại rất phát triển, ra ngoài không cần mang tiền mặt cũng có thể mua sắm vô cùng tiện lợi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [旧] (jiù) - cũ, cũ kỹ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '旧'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'jiù',
      example_hanzi = '虽然这件大衣已经很旧了，但他依然舍不得扔掉。',
      example_pinyin = 'Suīrán zhè jiàn dàyī yǐjīng hěn jiù le, dàn tā yīrán shěbude rēngdiào.',
      example_vi = 'Tuy chiếc áo khoác này đã rất cũ rồi nhưng anh ấy vẫn không nỡ vứt đi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '虽然这件大衣已经很旧了，但他依然舍不得扔掉。', 'Suīrán zhè jiàn dàyī yǐjīng hěn jiù le, dàn tā yīrán shěbude rēngdiào.', 'Tuy chiếc áo khoác này đã rất cũ rồi nhưng anh ấy vẫn không nỡ vứt đi.', 'basic', 1),
        (v_id, '搬进宽敞的新房后，家里的大部分旧家具都换成了现代风格的新款式。', 'Bān jìn kuānchǎng de xīn fáng hòu, jiālǐ de dà bùfen jiù jiājù dōu huàn chéng le xiàndài fēnggé de xīn kuǎnshì.', 'Sau khi dọn vào nhà mới rộng rãi, phần lớn đồ gỗ cũ trong nhà đều được đổi sang mẫu mã mới mang phong cách hiện đại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [明白] (míngbai) - hiểu, rõ ràng, sáng tỏ [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '明白'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'míngbai',
      example_hanzi = '经过老师的耐心点拨，大家终于完全明白了。',
      example_pinyin = 'Jīngguò lǎoshī de nàixīn diǎnbō, dàjiā zhōngyú wánquán míngbai le.',
      example_vi = 'Qua sự chỉ bảo kiên nhẫn của thầy giáo, mọi người cuối cùng đã hoàn toàn hiểu ra.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过老师的耐心点拨，大家终于完全明白了。', 'Jīngguò lǎoshī de nàixīn diǎnbō, dàjiā zhōngyú wánquán míngbai le.', 'Qua sự chỉ bảo kiên nhẫn của thầy giáo, mọi người cuối cùng đã hoàn toàn hiểu ra.', 'basic', 1),
        (v_id, '遇到听不懂的生词时，一定要礼貌地请对方解释直到自己真正明白为止。', 'Yù dào tīng bù dǒng de shēngcí shí, yídìng yào lǐmào de qǐng duìfāng jiěshì zhídào zìjǐ zhēnzhèng míngbai wéizhǐ.', 'Khi gặp từ mới nghe không hiểu, nhất định phải lịch sự nhờ đối phương giải thích cho tới khi bản thân thực sự hiểu rõ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [更] (gèng) - càng, hơn nữa [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '更'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'gèng',
      example_hanzi = '今天比昨天更冷，出门要多加件衣服。',
      example_pinyin = 'Jīntiān bǐ zuótiān gèng lěng, chūmén yào duō jiā jiàn yīfu.',
      example_vi = 'Hôm nay lạnh hơn hôm qua, ra ngoài cần mặc thêm một chiếc áo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天比昨天更冷，出门要多加件衣服。', 'Jīntiān bǐ zuótiān gèng lěng, chūmén yào duō jiā jiàn yīfu.', 'Hôm nay lạnh hơn hôm qua, ra ngoài cần mặc thêm một chiếc áo.', 'basic', 1),
        (v_id, '取得好成绩之后绝不能骄傲，在接下来的学习中要更加谦虚努力。', 'Qǔdé hǎo chéngjì zhīhòu jué bù néng jiāo’ào, zài jiē xiàlái de xuéxí zhōng yào gèngjiā qiānxū nǔlì.', 'Sau khi đạt được thành tích tốt tuyệt đối không được kiêu ngạo, trong học tập tiếp theo càng phải khiêm tốn chăm chỉ hơn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [月亮] (yuèliang) - mặt trăng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '月亮'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'yuèliang',
      example_hanzi = '今晚天空中挂着一轮皎洁明亮的圆月亮。',
      example_pinyin = 'Jīnwǎn tiānkōng zhōng guà zhe yì lún jiǎojié míngliàng de yuán yuèliang.',
      example_vi = 'Tối nay trên bầu trời treo một vầng trăng tròn vằng vặc sáng trong.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今晚天空中挂着一轮皎洁明亮的圆月亮。', 'Jīnwǎn tiānkōng zhōng guà zhe yì lún jiǎojié míngliàng de yuán yuèliang.', 'Tối nay trên bầu trời treo một vầng trăng tròn vằng vặc sáng trong.', 'basic', 1),
        (v_id, '每年八月十五中秋节，全家人都会欢聚在一起赏月亮、吃月饼。', 'Měinián bā yuè shíwǔ Zhōngqiūjié, quán jiā rén dōu huì huānjù zài yìqǐ shǎng yuèliang, chī yuèbǐng.', 'Hàng năm vào rằm tháng tám tết Trung thu, cả gia đình đều quây quần bên nhau cùng ngắm trăng ăn bánh trung thu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [有名] (yǒumíng) - nổi tiếng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '有名'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yǒumíng',
      example_hanzi = '故宫是中国乃至全世界非常有名的地方。',
      example_pinyin = 'Gùgōng shì Zhōngguó nǎizhì quán shìjiè fēicháng yǒumíng de dìfang.',
      example_vi = 'Cố Cung là một địa danh vô cùng nổi tiếng ở Trung Quốc cũng như trên toàn thế giới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '故宫是中国乃至全世界非常有名的地方。', 'Gùgōng shì Zhōngguó nǎizhì quán shìjiè fēicháng yǒumíng de dìfang.', 'Cố Cung là một địa danh vô cùng nổi tiếng ở Trung Quốc cũng như trên toàn thế giới.', 'basic', 1),
        (v_id, '这家老字号饭店烹饪的北京烤鸭味道地道，在海内外都享有盛誉，非常有名。', 'Zhè jiā lǎozìhào fàndiàn pēngrèn de Běijīng kǎoyā wèidao dìdao, zài hǎinèiwài dōu xiǎngyǒu shèngyù, fēicháng yǒumíng.', 'Món vịt quay Bắc Kinh do tiệm lâu đời này chế biến chuẩn vị thơm ngon, nức tiếng cả trong và ngoài nước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [机会] (jīhuì) - cơ hội, thời cơ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '机会'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jīhuì',
      example_hanzi = '这是一个很难得的学习交流机会。',
      example_pinyin = 'Zhè shì yí gè hěn nándé de xuéxí jiāoliú jīhuì.',
      example_vi = 'Đây là một cơ hội học tập giao lưu rất hiếm có.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这是一个很难得的学习交流机会。', 'Zhè shì yí gè hěn nándé de xuéxí jiāoliú jīhuì.', 'Đây là một cơ hội học tập giao lưu rất hiếm có.', 'basic', 1),
        (v_id, '机会往往留给有充分准备的人，平时多积累才能在关键时刻脱颖而出。', 'Jīhuì wǎngwǎng liú gěi yǒu chōngfèn zhǔnbèi de rén, píngshí duō jīlěi cái néng zài guānjiàn shíkè tuōyǐng’érchū.', 'Cơ hội thường chỉ dành cho người có sự chuẩn bị chu đáo, ngày thường tích lũy nhiều thì mới có thể nổi bật lúc then chốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [极] (jí) - cực kỳ, hết sức (thường đi với ...了) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '极'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'jí',
      example_hanzi = '今天的天气好极了，我们去公园散步吧。',
      example_pinyin = 'Jīntiān de tiānqì hǎo jí le, wǒmen qù gōngyuán sànbù ba.',
      example_vi = 'Hôm nay thời tiết tốt cực kỳ, chúng mình đi công viên dạo bộ nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天的天气好极了，我们去公园散步吧。', 'Jīntiān de tiānqì hǎo jí le, wǒmen qù gōngyuán sànbù ba.', 'Hôm nay thời tiết tốt cực kỳ, chúng mình đi công viên dạo bộ nhé.', 'basic', 1),
        (v_id, '看到孩子考上了心目中理想的大学，父母的心里高兴极了。', 'Kàndào háizi kǎoshàng le xīnmù zhōng lǐxiǎng de dàxué, fùmǔ de xīnlǐ gāoxìng jí le.', 'Nhìn thấy con thi đỗ vào trường đại học mơ ước, trong lòng cha mẹ mừng rỡ khôn xiết.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [树] (shù) - cây, cây cối [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '树'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shù',
      example_hanzi = '路边种着两排整齐翠绿的杨树。',
      example_pinyin = 'Lùbiān zhòng zhe liǎng pái zhěngqí cuìlǜ de yángshù.',
      example_vi = 'Bên đường trồng hai hàng cây dương ngay ngắn xanh tươi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '路边种着两排整齐翠绿的杨树。', 'Lùbiān zhòng zhe liǎng pái zhěngqí cuìlǜ de yángshù.', 'Bên đường trồng hai hàng cây dương ngay ngắn xanh tươi.', 'basic', 1),
        (v_id, '春天到来时，微风吹过，光秃秃的树枝上悄悄抽出了嫩绿的新芽。', 'Chūntiān dàolái shí, wēifēng chuī guò, guāngtūtū de shùzhī shang qiāoqiāo chōuchū le nènlǜ de xīnyá.', 'Mùa xuân tới khi làn gió thoảng qua, trên những cành cây khẳng khiu lặng lẽ đâm chồi những búp non xanh biếc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [校长] (xiàozhǎng) - hiệu trưởng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '校长'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xiàozhǎng',
      example_hanzi = '校长在开学典礼上向新生们发表了热情洋溢的讲话。',
      example_pinyin = 'Xiàozhǎng zài kāixué diǎnlǐ shang xiàng xīnshēngmen fābiǎo le rèqíng yángyì de jiǎnghuà.',
      example_vi = 'Thầy hiệu trưởng đã có bài phát biểu nồng nhiệt chào mừng tân sinh viên tại lễ khai giảng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '校长在开学典礼上向新生们发表了热情洋溢的讲话。', 'Xiàozhǎng zài kāixué diǎnlǐ shang xiàng xīnshēngmen fābiǎo le rèqíng yángyì de jiǎnghuà.', 'Thầy hiệu trưởng đã có bài phát biểu nồng nhiệt chào mừng tân sinh viên tại lễ khai giảng.', 'basic', 1),
        (v_id, '我们学校的校长治学严谨且十分关爱学生的日常生活。', 'Wǒmen xuéxiào de xiàozhǎng zhìxué yánjǐn qiě shífēn guān’ài xuésheng de rìcháng shēnghuó.', 'Hiệu trưởng trường chúng tôi phong cách làm việc nghiêm cẩn và hết mực quan tâm đến đời sống hàng ngày của học sinh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [根据] (gēnjù) - căn cứ vào, dựa theo; cơ sở [Giới từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '根据'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ / Danh từ',
      pinyin = 'gēnjù',
      example_hanzi = '请根据课文内容回答下面的几个问题。',
      example_pinyin = 'Qǐng gēnjù kèwén nèiróng huídá xiàmiàn de jǐ gè wèntí.',
      example_vi = 'Xin hãy căn cứ vào nội dung bài đọc để trả lời mấy câu hỏi phía dưới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请根据课文内容回答下面的几个问题。', 'Qǐng gēnjù kèwén nèiróng huídá xiàmiàn de jǐ gè wèntí.', 'Xin hãy căn cứ vào nội dung bài đọc để trả lời mấy câu hỏi phía dưới.', 'basic', 1),
        (v_id, '医生根据病人的体温、化验报告和具体症状，迅速制定出了科学有效的治疗方案。', 'Yīshēng gēnjù bìngrén de tǐwēn, huàyàn bàogào hé jùtǐ zhèngzhuàng, xùnsù zhìdìng chū le kēxué yǒuxiào de zhìliáo fāng’àn.', 'Bác sĩ căn cứ vào thân nhiệt, kết quả xét nghiệm và triệu chứng cụ thể của bệnh nhân đã nhanh chóng lập phác đồ điều trị hiệu quả.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [检查] (jiǎnchá) - kiểm tra, khám [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '检查'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiǎnchá',
      example_hanzi = '交卷前请仔细检查一遍有没有漏做的题目。',
      example_pinyin = 'Jiāojuàn qián qǐng zǐxì jiǎnchá yí biàn yǒu méiyǒu lòu zuò de tímù.',
      example_vi = 'Trước khi nộp bài xin hãy kiểm tra kỹ một lượt xem có câu nào làm sót không.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '交卷前请仔细检查一遍有没有漏做的题目。', 'Jiāojuàn qián qǐng zǐxì jiǎnchá yí biàn yǒu méiyǒu lòu zuò de tímù.', 'Trước khi nộp bài xin hãy kiểm tra kỹ một lượt xem có câu nào làm sót không.', 'basic', 1),
        (v_id, '医生细心给病人做完了全身检查，并嘱咐他平时要多注意休息。', 'Yīshēng xìxīn gěi bìngrén zuò wán le quánshēn jiǎnchá, bìng zhǔfù tā píngshí yào duō zhùyì xiūxi.', 'Bác sĩ cẩn thận làm xong kiểm tra toàn thân cho bệnh nhân và căn dặn ngày thường phải chú ý nghỉ ngơi nhiều.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [欢迎] (huānyíng) - hoan nghênh, chào đón [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '欢迎'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'huānyíng',
      example_hanzi = '热烈欢迎各位新同学来到我们大学学习！',
      example_pinyin = 'Rèliè huānyíng gèwèi xīn tóngxué lái dào wǒmen dàxué xuéxí!',
      example_vi = 'Nhiệt liệt hoan nghênh các bạn tân sinh viên đến trường đại học chúng tôi học tập!'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '热烈欢迎各位新同学来到我们大学学习！', 'Rèliè huānyíng gèwèi xīn tóngxué lái dào wǒmen dàxué xuéxí!', 'Nhiệt liệt hoan nghênh các bạn tân sinh viên đến trường đại học chúng tôi học tập!', 'basic', 1),
        (v_id, '这家书店环境优雅且图书齐全，开业以来一直深受广大读者的欢迎。', 'Zhè jiā shūdiàn huánjìng yōuyǎ qiě túshū qíquán, kāiyè yǐlái yìzhí shēn shòu guǎngdà dúzhě de huānyíng.', 'Hiệu sách này không gian tao nhã và sách vở đầy đủ, kể từ ngày khai trương luôn được đông đảo độc giả đón nhận.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [段] (duàn) - đoạn, khúc (văn, đường, thời gian) [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '段'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'duàn',
      example_hanzi = '请朗读课文的第二自然段。',
      example_pinyin = 'Qǐng lǎngdú kèwén de dì-èr zìránduàn.',
      example_vi = 'Xin hãy đọc to đoạn thứ hai của bài khóa.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请朗读课文的第二自然段。', 'Qǐng lǎngdú kèwén de dì-èr zìránduàn.', 'Xin hãy đọc to đoạn thứ hai của bài khóa.', 'basic', 1),
        (v_id, '在国外留学的这段宝贵时光，让他不仅开拓了眼界，更学会了独立生活。', 'Zài guówài liúxué de zhè duàn bǎoguì shíguāng, ràng tā bùjǐn kāituò le yǎnjiè, gèng xuéhuì le dúlì shēnghuó.', 'Quãng thời gian quý báu du học ở nước ngoài không chỉ giúp anh ấy mở rộng tầm mắt mà còn học được cách sống tự lập.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [比赛] (bǐsài) - trận đấu, cuộc thi; thi đấu [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '比赛'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'bǐsài',
      example_hanzi = '今晚有一场精彩激烈的足球比赛。',
      example_pinyin = 'Jīnwǎn yǒu yì chǎng jīngcǎi jīliè de zúqiú bǐsài.',
      example_vi = 'Tối nay có một trận đấu bóng đá vô cùng hấp dẫn và kịch tính.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今晚有一场精彩激烈的足球比赛。', 'Jīnwǎn yǒu yì chǎng jīngcǎi jīliè de zúqiú bǐsài.', 'Tối nay có một trận đấu bóng đá vô cùng hấp dẫn và kịch tính.', 'basic', 1),
        (v_id, '在全校举办的汉语演讲比赛中，他凭借标准流畅的发音赢得了评委的一致好评。', 'Zài quán xiào jǔbàn de Hànyǔ yǎnjiǎng bǐsài zhōng, tā píngjiè biāozhǔn liúchàng de fāyīn yíngdé le píngwěi de yízhì hǎopíng.', 'Trong cuộc thi hùng biện tiếng Trung toàn trường, cậu ấy nhờ phát âm chuẩn xác trôi chảy đã giành được lời khen ngợi của ban giám khảo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [比较] (bǐjiào) - tương đối, khá; so sánh [Phó từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '比较'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Động từ',
      pinyin = 'bǐjiào',
      example_hanzi = '我今天身体感觉比较舒服了。',
      example_pinyin = 'Wǒ jīntiān shēntǐ gǎnjué bǐjiào shūfu le.',
      example_vi = 'Hôm nay cơ thể tôi cảm thấy tương đối dễ chịu rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我今天身体感觉比较舒服了。', 'Wǒ jīntiān shēntǐ gǎnjué bǐjiào shūfu le.', 'Hôm nay cơ thể tôi cảm thấy tương đối dễ chịu rồi.', 'basic', 1),
        (v_id, '通过将两套学习方案进行细致的比较，我们终于选出了效率最高的一种。', 'Tōngguò jiāng liǎng tào xuéxí fāng’àn jìnxíng xìzhì de bǐjiào, wǒmen zhōngyú xuǎn chū le xiàolǜ zuì gāo de yì zhǒng.', 'Qua việc so sánh tỉ mỉ hai phương án học tập, chúng tôi cuối cùng đã chọn ra được phương án có hiệu quả cao nhất.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [水平] (shuǐpíng) - trình độ, mức độ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '水平'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shuǐpíng',
      example_hanzi = '通过一年努力，他的汉语听说水平有了很大提高。',
      example_pinyin = 'Tōngguò yì nián nǔlì, tā de Hànyǔ tīngshuō shuǐpíng yǒu le hěn dà tígāo.',
      example_vi = 'Qua một năm nỗ lực, trình độ nghe nói tiếng Trung của anh ấy đã tiến bộ rất nhiều.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '通过一年努力，他的汉语听说水平有了很大提高。', 'Tōngguò yì nián nǔlì, tā de Hànyǔ tīngshuō shuǐpíng yǒu le hěn dà tígāo.', 'Qua một năm nỗ lực, trình độ nghe nói tiếng Trung của anh ấy đã tiến bộ rất nhiều.', 'basic', 1),
        (v_id, '随着国家经济实力的不断增强，人民的生活水平得到了显著改善。', 'Suízhe guójiā jīngjì shílì de búduàn zēngqiáng, rénmín de shēnghuó shuǐpíng dédào le xiǎnzhù gǎishàn.', 'Cùng với thực lực kinh tế đất nước không ngừng lớn mạnh, mức sống của người dân đã được cải thiện rõ rệt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [注意] (zhùyì) - chú ý, để ý [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '注意'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'zhùyì',
      example_hanzi = '天气渐渐变冷了，大家出门要注意保暖。',
      example_pinyin = 'Tiānqì jiànjiàn biàn lěng le, dàjiā chūmén yào zhùyì bǎonuǎn.',
      example_vi = 'Thời tiết dần trở lạnh rồi, mọi người ra ngoài phải chú ý giữ ấm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '天气渐渐变冷了，大家出门要注意保暖。', 'Tiānqì jiànjiàn biàn lěng le, dàjiā chūmén yào zhùyì bǎonuǎn.', 'Thời tiết dần trở lạnh rồi, mọi người ra ngoài phải chú ý giữ ấm.', 'basic', 1),
        (v_id, '在实验室操作精密仪器时，必须高度集中注意力，严格遵守安全规程。', 'Zài shíyànshì cāozuò jīngmì yíqì shí, bìxū gāodù jízhōng zhùyìlì, yángé zūnshǒu ānquán guīchéng.', 'Khi thao tác thiết bị chuẩn xác trong phòng thí nghiệm, nhất thiết phải tập trung cao độ chú ý và tuân thủ quy tắc an toàn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [洗澡] (xǐzǎo) - tắm, tắm rửa [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '洗澡'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'xǐzǎo',
      example_hanzi = '运动出了一身汗，冲个热水澡真舒服。',
      example_pinyin = 'Yùndòng chū le yì shēn hàn, chōng gè rèshuǐ zǎo zhēn shūfu.',
      example_vi = 'Vận động toát mồ hôi đầm đìa, tắm một làn nước nóng thật là sảng khoái.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '运动出了一身汗，冲个热水澡真舒服。', 'Yùndòng chū le yì shēn hàn, chōng gè rèshuǐ zǎo zhēn shūfu.', 'Vận động toát mồ hôi đầm đìa, tắm một làn nước nóng thật là sảng khoái.', 'basic', 1),
        (v_id, '下班回家后，他习惯先舒舒服服地洗个澡，然后再和家人一起吃晚餐。', 'Xiàbān huí jiā hòu, tā xíguàn xiān shūshū-fūfū de xǐ gè zǎo, ránhòu zài hé jiārén yìqǐ chī wǎncān.', 'Sau khi tan sở về nhà, anh ấy có thói quen tắm rửa thật thoải mái trước rồi mới cùng gia đình ăn bữa tối.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [清楚] (qīngchu) - rõ ràng, rành mạch; hiểu rõ [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '清楚'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'qīngchu',
      example_hanzi = '黑板上的字写得很清楚。',
      example_pinyin = 'Hēibǎn shang de zì xiě de hěn qīngchu.',
      example_vi = 'Chữ viết trên bảng đen rất rõ ràng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '黑板上的字写得很清楚。', 'Hēibǎn shang de zì xiě de hěn qīngchu.', 'Chữ viết trên bảng đen rất rõ ràng.', 'basic', 1),
        (v_id, '老师的声音很洪亮，后排的同学也能听得清清楚楚。', 'Lǎoshī de shēngyīn hěn hóngliàng, hòupái de tóngxué yě néng tīng de qīngqīng-chǔchǔ.', 'Giọng của thầy giáo rất vang, các bạn học ở hàng ghế sau cũng nghe được rành rọt rõ ràng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [渴] (kě) - khát, khát nước [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '渴'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'kě',
      example_hanzi = '打完篮球后口渴得很，我想喝大杯冰水。',
      example_pinyin = 'Dǎ wán lánqiú hòu kǒu kě de hěn, wǒ xiǎng hē dà bēi bīng shuǐ.',
      example_vi = 'Sau khi chơi bóng rổ xong rất khát nước, tôi muốn uống một ly nước đá to.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '打完篮球后口渴得很，我想喝大杯冰水。', 'Dǎ wán lánqiú hòu kǒu kě de hěn, wǒ xiǎng hē dà bēi bīng shuǐ.', 'Sau khi chơi bóng rổ xong rất khát nước, tôi muốn uống một ly nước đá to.', 'basic', 1),
        (v_id, '在烈日下长途步行，又累又渴时喝上一瓶矿泉水简直是极大的享受。', 'Zài lièrì xià chángtú bùxíng, yòu lèi yòu kě shí hē shang yì píng kuàngquánshuǐ jiǎnzhí shì jí dà de xiǎngshòu.', 'Đi bộ đường dài dưới nắng gắt, lúc vừa mệt vừa khát uống được chai nước khoáng quả thực là sự tận hưởng tuyệt vời.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [游戏] (yóuxì) - trò chơi; chơi trò chơi [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '游戏'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'yóuxì',
      example_hanzi = '小朋友们在草地上开心地做游戏。',
      example_pinyin = 'Xiǎopéngyoumen zài cǎodì shang kāixīn de zuò yóuxì.',
      example_vi = 'Các em nhỏ vui vẻ chơi trò chơi trên bãi cỏ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小朋友们在草地上开心地做游戏。', 'Xiǎopéngyoumen zài cǎodì shang kāixīn de zuò yóuxì.', 'Các em nhỏ vui vẻ chơi trò chơi trên bãi cỏ.', 'basic', 1),
        (v_id, '适度玩电脑游戏可以放松心情，但过度沉迷就会影响正常的学习和生活。', 'Shìdù wán diànnǎo yóuxì kěyǐ fàngsōng xīnqíng, dàn guòdù chénmí jiù huì yǐngxiǎng zhèngcháng de xuéxí hé shēnghuó.', 'Chơi game vi tính điều độ có thể giúp thư giãn tâm trí, nhưng quá sa đà sẽ ảnh hưởng đến việc học và cuộc sống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [满意] (mǎnyì) - hài lòng, vừa ý [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '满意'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'mǎnyì',
      example_hanzi = '客户对我们这次提出的设计方案非常满意。',
      example_pinyin = 'Kèhù duì wǒmen zhè cì tíchū de shèjì fāng’àn fēicháng mǎnyì.',
      example_vi = 'Khách hàng rất hài lòng với phương án thiết kế lần này của chúng tôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '客户对我们这次提出的设计方案非常满意。', 'Kèhù duì wǒmen zhè cì tíchū de shèjì fāng’àn fēicháng mǎnyì.', 'Khách hàng rất hài lòng với phương án thiết kế lần này của chúng tôi.', 'basic', 1),
        (v_id, '经过多次细心修改，他终于交出了一份让自己和导师都十分满意的毕业论文。', 'Jīngguò duō cì xìxīn xiūgǎi, tā zhōngyú jiāo chū le yí fèn ràng zìjǐ hé dǎoshī dōu shífēn mǎnyì de bìyè lùnwén.', 'Qua nhiều lần sửa chữa tỉ mỉ, cuối cùng anh ấy đã nộp được một bài luận văn tốt nghiệp khiến cả bản thân lẫn giảng viên đều rất vừa ý.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [灯] (dēng) - đèn, ngọn đèn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '灯'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dēng',
      example_hanzi = '天黑了，请把房间里的灯打开。',
      example_pinyin = 'Tiān hēi le, qǐng bǎ fángjiān lǐ de dēng dǎkāi.',
      example_vi = 'Trời tối rồi, làm ơn bật đèn trong phòng lên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '天黑了，请把房间里的灯打开。', 'Tiān hēi le, qǐng bǎ fángjiān lǐ de dēng dǎkāi.', 'Trời tối rồi, làm ơn bật đèn trong phòng lên.', 'basic', 1),
        (v_id, '深夜的街道上，一盏盏明亮的路灯为夜行的路人照亮了回家的方向。', 'Shēnyè de jiēdào shang, yìzhǎnzhǎn míngliàng de lùdēng wèi yèxíng de lùrén zhào liàng le huí jiā de fāngxiàng.', 'Trên đường phố lúc đêm khuya, từng ngọn đèn đường sáng rực soi rọi hướng về nhà cho người đi đêm.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [热情] (rèqíng) - nhiệt tình, niềm nở [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '热情'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'rèqíng',
      example_hanzi = '这里的人们对待远方客人非常热情友好。',
      example_pinyin = 'Zhèlǐ de rénmen duìdài yuǎnfāng kèrén fēicháng rèqíng yǒuhǎo.',
      example_vi = 'Con người nơi đây đối đãi với khách phương xa rất nhiệt tình và thân thiện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这里的人们对待远方客人非常热情友好。', 'Zhèlǐ de rénmen duìdài yuǎnfāng kèrén fēicháng rèqíng yǒuhǎo.', 'Con người nơi đây đối đãi với khách phương xa rất nhiệt tình và thân thiện.', 'basic', 1),
        (v_id, '尽管旅途非常劳累，志愿者们依然带着满满的热情投入到迎新服务工作中。', 'Jǐnguǎn lǚtú fēicháng láolèi, zhìyuànzhěmen yīrán dài zhe mǎnmǎn de rèqíng tóurù dào yíngxīn fúwù gōngzuò zhōng.', 'Dù cho chặng đường đi rất vất vả mệt nhọc, các tình nguyện viên vẫn mang theo lòng nhiệt tình hăng hái bắt tay vào đón tân sinh viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [然后] (ránhòu) - sau đó, rồi thì [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '然后'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'ránhòu',
      example_hanzi = '我们先去吃午饭，然后去图书馆看书。',
      example_pinyin = 'Wǒmen xiān qù chī wǔfàn, ránhòu qù túshūguǎn kàn shū.',
      example_vi = 'Chúng mình đi ăn trưa trước, sau đó đến thư viện đọc sách.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们先去吃午饭，然后去图书馆看书。', 'Wǒmen xiān qù chī wǔfàn, ránhòu qù túshūguǎn kàn shū.', 'Chúng mình đi ăn trưa trước, sau đó đến thư viện đọc sách.', 'basic', 1),
        (v_id, '洗完新鲜蔬菜，然后切成小块放入热油锅中翻炒两分钟即可出锅。', 'Xǐ wán xīnxiān shūcài, ránhòu qiē chéng xiǎo kuài fàng rù rè yóuguō zhōng fānchǎo liǎng fēnzhōng jíkě chū guō.', 'Rửa sạch rau tươi rồi thái miếng nhỏ cho vào chảo dầu nóng đảo đều trong hai phút là có thể dọn ra đĩa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [照片] (zhàopiàn) - bức ảnh, tấm hình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '照片'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhàopiàn',
      example_hanzi = '这是我们全家人在海边度假时拍的照片。',
      example_pinyin = 'Zhè shì wǒmen quán jiā rén zài hǎibiān dùjià shí pāi de zhàopiàn.',
      example_vi = 'Đây là tấm ảnh cả gia đình tôi chụp khi đi nghỉ mát ở bãi biển.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这是我们全家人在海边度假时拍的照片。', 'Zhè shì wǒmen quán jiā rén zài hǎibiān dùjià shí pāi de zhàopiàn.', 'Đây là tấm ảnh cả gia đình tôi chụp khi đi nghỉ mát ở bãi biển.', 'basic', 1),
        (v_id, '翻看泛黄的老旧照片，童年时代那些美好温馨的记忆瞬间涌上心头。', 'Fānkàn fànhuáng de lǎojiù zhàopiàn, tóngnián shídài nàxiē měihǎo wēnxīn de jìyì shùnjiān yǒng shàng xīntóu.', 'Lật xem những bức ảnh cũ ố vàng, những kỷ niệm êm đềm tươi đẹp thời thơ ấu chốc lát lại ùa về trong tâm trí.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [照顾] (zhàogù) - chăm sóc, trông nom [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '照顾'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'zhàogù',
      example_hanzi = '奶奶生病了，妈妈每天在医院细心照顾她。',
      example_pinyin = 'Nǎinai shēngbìng le, māma měitiān zài yīyuàn xìxīn zhàogù tā.',
      example_vi = 'Bà nội bị ốm rồi, mẹ ngày nào cũng ở bệnh viện cẩn thận chăm sóc bà.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '奶奶生病了，妈妈每天在医院细心照顾她。', 'Nǎinai shēngbìng le, māma měitiān zài yīyuàn xìxīn zhàogù tā.', 'Bà nội bị ốm rồi, mẹ ngày nào cũng ở bệnh viện cẩn thận chăm sóc bà.', 'basic', 1),
        (v_id, '出门在外求学工作，不仅要刻苦努力，更要学会照顾好自己的身体和生活。', 'Chūmén zài wài qiúxué gōngzuò, bùjǐn yào kèkǔ nǔlì, gèng yào xuéhuì zhàogù hǎo zìjǐ de shēntǐ hé shēnghuó.', 'Xa nhà đi học đi làm, không chỉ cần nỗ lực chăm chỉ mà càng phải học cách chăm lo tốt cho sức khỏe và cuộc sống của bản thân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [特别] (tèbié) - đặc biệt, vô cùng [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '特别'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Tính từ',
      pinyin = 'tèbié',
      example_hanzi = '今天的天气特别晴朗舒服。',
      example_pinyin = 'Jīntiān de tiānqì tèbié qínglǎng shūfu.',
      example_vi = 'Thời tiết hôm nay đặc biệt nắng ráo dễ chịu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天的天气特别晴朗舒服。', 'Jīntiān de tiānqì tèbié qínglǎng shūfu.', 'Thời tiết hôm nay đặc biệt nắng ráo dễ chịu.', 'basic', 1),
        (v_id, '在众多的中国传统节日中，他对热闹喜庆的春节有着特别深厚的情感。', 'Zài zhòngduō de Zhōngguó chuántǒng jiérì zhōng, tā duì rènao xǐqìng de Chūnjié yǒu zhe tèbié shēnhòu de qínggǎn.', 'Trong rất nhiều ngày lễ truyền thống Trung Quốc, anh ấy có tình cảm đặc biệt sâu đậm với ngày tết Nguyên Đán rộn rã vui tươi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [环境] (huánjìng) - môi trường, hoàn cảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '环境'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'huánjìng',
      example_hanzi = '我们学校周围的绿化环境非常好。',
      example_pinyin = 'Wǒmen xuéxiào zhōuwéi de lǜhuà huánjìng fēicháng hǎo.',
      example_vi = 'Môi trường phủ xanh xung quanh trường học chúng tôi rất tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们学校周围的绿化环境非常好。', 'Wǒmen xuéxiào zhōuwéi de lǜhuà huánjìng fēicháng hǎo.', 'Môi trường phủ xanh xung quanh trường học chúng tôi rất tốt.', 'basic', 1),
        (v_id, '保护自然生态环境、减少白色塑料垃圾是每一个公民义不容辞的社会责任。', 'Bǎohù zìrán shēngtài huánjìng, jiǎnshǎo báisè sùliào lājī shì měi yí gè gōngmín yìbùróngcí de shèhuì zérèn.', 'Bảo vệ môi trường sinh thái tự nhiên và giảm thiểu rác thải nhựa là trách nhiệm xã hội không thể chối từ của mỗi công dân.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [瓶子] (píngzi) - cái chai, cái bình, cái lọ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '瓶子'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'píngzi',
      example_hanzi = '请把喝完的空矿泉水瓶子放进可回收垃圾桶。',
      example_pinyin = 'Qǐng bǎ hē wán de kōng kuàngquánshuǐ píngzi fàng jìn kě huíshōu lājītǒng.',
      example_vi = 'Làm ơn bỏ chai nước khoáng rỗng đã uống xong vào thùng rác tái chế.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把喝完的空矿泉水瓶子放进可回收垃圾桶。', 'Qǐng bǎ hē wán de kōng kuàngquánshuǐ píngzi fàng jìn kě huíshōu lājītǒng.', 'Làm ơn bỏ chai nước khoáng rỗng đã uống xong vào thùng rác tái chế.', 'basic', 1),
        (v_id, '桌子上摆着一个精致漂亮的玻璃瓶子，里面插着几朵盛开的红玫瑰。', 'Zhuōzi shang bǎi zhe yí gè jīngzhì piàoliang de bōli píngzi, lǐmiàn chā zhe jǐ duǒ shèngkāi de hóng méigui.', 'Trên bàn bày một chiếc bình thủy tinh tinh xảo xinh xắn, bên trong cắm mấy bông hồng đỏ đang nở rộ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [甜] (tián) - ngọt, ngọt ngào [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '甜'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'tián',
      example_hanzi = '这个红富士苹果又脆又甜。',
      example_pinyin = 'Zhè ge hóngfùshì píngguǒ yòu cuì yòu tián.',
      example_vi = 'Quả táo Phú Sĩ đỏ này vừa giòn vừa ngọt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个红富士苹果又脆又甜。', 'Zhè ge hóngfùshì píngguǒ yòu cuì yòu tián.', 'Quả táo Phú Sĩ đỏ này vừa giòn vừa ngọt.', 'basic', 1),
        (v_id, '夏天吃上一块冰镇多汁的甜西瓜，令人瞬间忘却了室外的炎热暑气。', 'Xiàtiān chī shang yí kuài bīngzhèn duōzhī de tián xīguā, lìng rén shùnjiān wàngquè le shìwài de yánrè shǔqì.', 'Mùa hè ăn một miếng dưa hấu ngọt ướp lạnh mọng nước khiến người ta ngay lập tức quên đi cái oi bức bên ngoài.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [生气] (shēngqì) - tức giận, giận dữ [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '生气'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Tính từ',
      pinyin = 'shēngqì',
      example_hanzi = '这只是一场误会，你千万别生气。',
      example_pinyin = 'Zhè zhǐ shì yì chǎng wùhuì, nǐ qiānwàn bié shēngqì.',
      example_vi = 'Đây chỉ là một sự hiểu lầm thôi, bạn tuyệt đối đừng giận nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这只是一场误会，你千万别生气。', 'Zhè zhǐ shì yì chǎng wùhuì, nǐ qiānwàn bié shēngqì.', 'Đây chỉ là một sự hiểu lầm thôi, bạn tuyệt đối đừng giận nhé.', 'basic', 1),
        (v_id, '遇到矛盾与分歧时，心平气和地沟通远比盲目生气更有助于解决问题。', 'Yù dào máodùn yǔ fēnqí shí, xīnpíng-qìhé de gōutōng yuǎn bǐ mángmù shēngqì gèng yǒuzhùyú jiějué wèntí.', 'Khi gặp phải mâu thuẫn bất đồng, bình tâm trao đổi giải quyết vấn đề hiệu quả hơn nhiều so với việc mù quáng giận dữ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [用] (yòng) - dùng, sử dụng [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '用'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Giới từ',
      pinyin = 'yòng',
      example_hanzi = '我可以用一下你的铅笔写几个字吗？',
      example_pinyin = 'Wǒ kěyǐ yòng yíxià nǐ de qiānbǐ xiě jǐ gè zì ma?',
      example_vi = 'Tôi có thể dùng bút chì của bạn viết mấy chữ được không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我可以用一下你的铅笔写几个字吗？', 'Wǒ kěyǐ yòng yíxià nǐ de qiānbǐ xiě jǐ gè zì ma?', 'Tôi có thể dùng bút chì của bạn viết mấy chữ được không?', 'basic', 1),
        (v_id, '在日常中文交流中，用词准确得体能够让对方感受到你的真诚与修养。', 'Zài rìcháng Zhōngwén jiāoliú zhōng, yòng cí zhǔnquè détǐ nénggòu ràng duìfāng gǎnshòu dào nǐ de zhēnchéng yǔ xiūyǎng.', 'Trong giao tiếp tiếng Trung hàng ngày, dùng từ chuẩn xác đúng mực có thể khiến đối phương cảm nhận được sự chân thành và tu dưỡng của bạn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [电梯] (diàntī) - thang máy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '电梯'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'diàntī',
      example_hanzi = '我们坐电梯直接上八楼开会。',
      example_pinyin = 'Wǒmen zuò diàntī zhíjiē shàng bā lóu kāihuì.',
      example_vi = 'Chúng ta đi thang máy lên thẳng tầng tám để họp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们坐电梯直接上八楼开会。', 'Wǒmen zuò diàntī zhíjiē shàng bā lóu kāihuì.', 'Chúng ta đi thang máy lên thẳng tầng tám để họp.', 'basic', 1),
        (v_id, '高峰期乘坐电梯时要注意先下后上，文明礼让老弱病残孕乘客。', 'Gāofēng qī chéngzuò diàntī shí yào zhùyì xiān xià hòu shàng, wénmíng lǐràng lǎoruòbìngcányùn chéngkè.', 'Khi đi thang máy vào giờ cao điểm cần chú ý người xuống trước người lên sau, văn minh nhường lối cho người già yếu và phụ nữ mang thai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [留学] (liúxué) - du học [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '留学'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'liúxué',
      example_hanzi = '他的梦想是去北京大学留学攻读硕士。',
      example_pinyin = 'Tā de mèngxiǎng shì qù Běijīng Dàxué liúxué gōngdú shuòshì.',
      example_vi = 'Ước mơ của anh ấy là sang Đại học Bắc Kinh du học thạc sĩ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他的梦想是去北京大学留学攻读硕士。', 'Tā de mèngxiǎng shì qù Běijīng Dàxué liúxué gōngdú shuòshì.', 'Ước mơ của anh ấy là sang Đại học Bắc Kinh du học thạc sĩ.', 'basic', 1),
        (v_id, '在海外留学的宝贵经历，不仅让他掌握了地道的外语，更培养了独立坚强的品格。', 'Zài hǎiwài liúxué de bǎoguì jīnglì, bùjǐn ràng tā zhǎngwò le dìdao de wàiyǔ, gèng péiyǎng le dúlì jiānqiáng de pǐngé.', 'Trải nghiệm du học quý báu ở nước ngoài không chỉ giúp anh ấy nắm vững ngoại ngữ chuẩn xác mà còn rèn luyện phẩm cách tự lập kiên cường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [瘦] (shòu) - gầy, gầy gò; nạc (thịt) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '瘦'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'shòu',
      example_hanzi = '几个月没见，他比以前瘦了很多。',
      example_pinyin = 'Jǐ gè yuè méi jiàn, tā bǐ yǐqián shòu le hěn duō.',
      example_vi = 'Mấy tháng không gặp, cậu ấy gầy hơn trước nhiều.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '几个月没见，他比以前瘦了很多。', 'Jǐ gè yuè méi jiàn, tā bǐ yǐqián shòu le hěn duō.', 'Mấy tháng không gặp, cậu ấy gầy hơn trước nhiều.', 'basic', 1),
        (v_id, '买猪肉时妈妈更偏爱买瘦肉，因为炒菜吃起来既清爽又健康。', 'Mǎi zhūròu shí māma gèng piān’ài mǎi shòuròu, yīnwèi chǎocài chī qǐlái jì qīngshuǎng yòu jiànkāng.', 'Khi mua thịt lợn mẹ chuộng mua thịt nạc hơn, vì xào lên ăn vừa thanh đạm lại vừa có lợi cho sức khỏe.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 160 câu ví dụ cho % từ vựng HSK 3 (Batch 2)!', v_count;
END $$;
