-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 3 - BATCH 1 (80 TỪ)
-- Phạm vi: Từ [一共] (yígòng) đến [季节] (jìjié)
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
  -- [一共] (yígòng) - tổng cộng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '一共'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'yígòng',
      example_hanzi = '这些苹果一共二十块钱。',
      example_pinyin = 'Zhèxiē píngguǒ yígòng èrshí kuài qián.',
      example_vi = 'Số táo này tổng cộng hai mươi tệ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这些苹果一共二十块钱。', 'Zhèxiē píngguǒ yígòng èrshí kuài qián.', 'Số táo này tổng cộng hai mươi tệ.', 'basic', 1),
        (v_id, '我们班一共有三十五个来自不同国家的学生。', 'Wǒmen bān yígòng yǒu sānshíwǔ gè láizì bù tóng guójiā de xuésheng.', 'Lớp chúng tôi tổng cộng có ba mươi lăm học sinh đến từ các quốc gia khác nhau.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [一定] (yídìng) - nhất định [Phó từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '一定'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ / Tính từ',
      pinyin = 'yídìng',
      example_hanzi = '明天你一定要按时来参加聚会。',
      example_pinyin = 'Míngtiān nǐ yídìng yào ànshí lái cānjiā jùhuì.',
      example_vi = 'Ngày mai bạn nhất định phải đến tham gia buổi tụ tập đúng giờ nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '明天你一定要按时来参加聚会。', 'Míngtiān nǐ yídìng yào ànshí lái cānjiā jùhuì.', 'Ngày mai bạn nhất định phải đến tham gia buổi tụ tập đúng giờ nhé.', 'basic', 1),
        (v_id, '只要坚持努力，你就一定能实现自己的理想。', 'Zhǐyào jiānchí nǔlì, nǐ jiù yídìng néng shíxiàn zìjǐ de lǐxiǎng.', 'Chỉ cần kiên trì nỗ lực, bạn nhất định có thể thực hiện được lý tưởng của mình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [一样] (yíyàng) - giống nhau, như nhau [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '一样'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'yíyàng',
      example_hanzi = '这两个书包的颜色完全一样。',
      example_pinyin = 'Zhè liǎng gè shūbāo de yánsè wánquán yíyàng.',
      example_vi = 'Màu sắc của hai chiếc cặp sách này hoàn toàn giống nhau.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这两个书包的颜色完全一样。', 'Zhè liǎng gè shūbāo de yánsè wánquán yíyàng.', 'Màu sắc của hai chiếc cặp sách này hoàn toàn giống nhau.', 'basic', 1),
        (v_id, '他和哥哥一样，也非常喜欢踢足球。', 'Tā hé gēge yíyàng, yě fēicháng xǐhuan tī zúqiú.', 'Cậu ấy cũng giống như anh trai, rất thích đá bóng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [一直] (yìzhí) - luôn luôn, suốt, thẳng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '一直'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'yìzhí',
      example_hanzi = '沿着这条路一直往走就是地铁站。',
      example_pinyin = 'Yánzhe zhè tiáo lù yìzhí wǎng qián zǒu jiù shì dìtiězhàn.',
      example_vi = 'Cứ đi thẳng theo con đường này về phía trước là tới ga tàu điện ngầm.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '沿着这条路一直往走就是地铁站。', 'Yánzhe zhè tiáo lù yìzhí wǎng qián zǒu jiù shì dìtiězhàn.', 'Cứ đi thẳng theo con đường này về phía trước là tới ga tàu điện ngầm.', 'basic', 1),
        (v_id, '这几天天气一直很晴朗，气温也很舒服。', 'Zhè jǐ tiān tiānqì yìzhí hěn qínglǎng, qìwēn yě hěn shūfu.', 'Mấy ngày nay thời tiết luôn nắng ráo, nhiệt độ cũng rất dễ chịu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [一般] (yìbān) - bình thường, thông thường, phổ biến [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '一般'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'yìbān',
      example_hanzi = '我周末一般都在家里看书休息。',
      example_pinyin = 'Wǒ zhōumò yìbān dōu zài jiālǐ kàn shū xiūxi.',
      example_vi = 'Cuối tuần tôi thông thường đều ở nhà đọc sách nghỉ ngơi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我周末一般都在家里看书休息。', 'Wǒ zhōumò yìbān dōu zài jiālǐ kàn shū xiūxi.', 'Cuối tuần tôi thông thường đều ở nhà đọc sách nghỉ ngơi.', 'basic', 1),
        (v_id, '这家餐馆的菜味道很一般，但是服务很热情。', 'Zhè jiā cānguǎn de cài wèidao hěn yìbān, dànshì fúwù hěn rèqíng.', 'Món ăn của nhà hàng này hương vị rất bình thường, nhưng phục vụ rất nhiệt tình.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [一边] (yìbiān) - vừa... vừa... (vừa làm việc này vừa làm việc kia) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '一边'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'yìbiān',
      example_hanzi = '他喜欢一边喝茶一边看报纸。',
      example_pinyin = 'Tā xǐhuan yìbiān hē chá yìbiān kàn bàozhǐ.',
      example_vi = 'Anh ấy thích vừa uống trà vừa đọc báo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他喜欢一边喝茶一边看报纸。', 'Tā xǐhuan yìbiān hē chá yìbiān kàn bàozhǐ.', 'Anh ấy thích vừa uống trà vừa đọc báo.', 'basic', 1),
        (v_id, '大家一边吃着美味的晚餐，一边愉快地聊天儿。', 'Dàjiā yìbiān chī zhe měiwèi de wǎncān, yìbiān yúkuài de liáotiānr.', 'Mọi người vừa ăn bữa tối ngon miệng vừa trò chuyện vui vẻ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [世界] (shìjiè) - thế giới [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '世界'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shìjiè',
      example_hanzi = '我想去世界各地旅行看风景。',
      example_pinyin = 'Wǒ xiǎng qù shìjiè gèdì lǚxíng kàn fēngjǐng.',
      example_vi = 'Tôi muốn đi du lịch ngắm cảnh khắp nơi trên thế giới.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我想去世界各地旅行看风景。', 'Wǒ xiǎng qù shìjiè gèdì lǚxíng kàn fēngjǐng.', 'Tôi muốn đi du lịch ngắm cảnh khắp nơi trên thế giới.', 'basic', 1),
        (v_id, '互联网让我们能够随时了解世界每天发生的重大新闻。', 'Hùliánwǎng ràng wǒmen nénggòu suíshí liǎojiě shìjiè měitiān fāshēng de zhòngdà xīnwén.', 'Internet giúp chúng ta có thể cập nhật những tin tức lớn xảy ra mỗi ngày trên thế giới mọi lúc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [东] (dōng) - phía đông, hướng đông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '东'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dōng',
      example_hanzi = '太阳从东方升起来。',
      example_pinyin = 'Tàiyáng cóng dōngfāng shēng qǐlái.',
      example_vi = 'Mặt trời mọc lên từ hướng đông.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '太阳从东方升起来。', 'Tàiyáng cóng dōngfāng shēng qǐlái.', 'Mặt trời mọc lên từ hướng đông.', 'basic', 1),
        (v_id, '我家住在学校的东边，步行大概十分钟。', 'Wǒ jiā zhù zài xuéxiào de dōngbian, bùxíng dàgài shí fēnzhōng.', 'Nhà tôi ở phía đông của trường, đi bộ chừng mười phút.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [中间] (zhōngjiān) - ở giữa, trung gian [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '中间'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhōngjiān',
      example_hanzi = '他坐在爸爸和妈妈中间。',
      example_pinyin = 'Tā zuò zài bàba hé māma zhōngjiān.',
      example_vi = 'Cậu bé ngồi ở giữa bố và mẹ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他坐在爸爸和妈妈中间。', 'Tā zuò zài bàba hé māma zhōngjiān.', 'Cậu bé ngồi ở giữa bố và mẹ.', 'basic', 1),
        (v_id, '桌子正中间放着一个装满鲜花的花瓶。', 'Zhuōzi zhèng zhōngjiān fàng zhe yí gè zhuāng mǎn xiānhuā de huāpíng.', 'Ngay chính giữa bàn đặt một bình hoa cắm đầy hoa tươi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [为] (wèi) - vì, cho, đối với [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '为'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'wèi',
      example_hanzi = '我们要为自己的未来努力学习。',
      example_pinyin = 'Wǒmen yào wèi zìjǐ de wèilái nǔlì xuéxí.',
      example_vi = 'Chúng ta phải chăm chỉ học tập vì tương lai của chính mình.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们要为自己的未来努力学习。', 'Wǒmen yào wèi zìjǐ de wèilái nǔlì xuéxí.', 'Chúng ta phải chăm chỉ học tập vì tương lai của chính mình.', 'basic', 1),
        (v_id, '大家举杯，为新朋友的到来干杯！', 'Dàjiā jǔ bēi, wèi xīn péngyou de dàolái gānbēi!', 'Mọi người nâng ly, cạn ly vì sự có mặt của những người bạn mới!', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [为了] (wèile) - để, nhằm mục đích [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '为了'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'wèile',
      example_hanzi = '为了身体健康，他每天坚持跑步。',
      example_pinyin = 'Wèile shēntǐ jiànkāng, tā měitiān jiānchí pǎobù.',
      example_vi = 'Để có sức khỏe tốt, anh ấy kiên trì chạy bộ mỗi ngày.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '为了身体健康，他每天坚持跑步。', 'Wèile shēntǐ jiànkāng, tā měitiān jiānchí pǎobù.', 'Để có sức khỏe tốt, anh ấy kiên trì chạy bộ mỗi ngày.', 'basic', 1),
        (v_id, '为了学好汉语，她报名参加了暑期强化培训班。', 'Wèile xué hǎo Hànyǔ, tā bàomíng cānjiā le shǔqī qiánghuà péixùnbān.', 'Để học tốt tiếng Trung, cô ấy đã đăng ký tham gia lớp bồi dưỡng cấp tốc mùa hè.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [主要] (zhǔyào) - chủ yếu, chính [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '主要'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Phó từ',
      pinyin = 'zhǔyào',
      example_hanzi = '这是我们今天会议的主要内容。',
      example_pinyin = 'Zhè shì wǒmen jīntiān huìyì de zhǔyào nèiróng.',
      example_vi = 'Đây là nội dung chủ yếu của cuộc họp chúng ta hôm nay.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这是我们今天会议的主要内容。', 'Zhè shì wǒmen jīntiān huìyì de zhǔyào nèiróng.', 'Đây là nội dung chủ yếu của cuộc họp chúng ta hôm nay.', 'basic', 1),
        (v_id, '他学习进步的主要原因是他平时肯下功夫。', 'Tā xuéxí jìnbù de zhǔyào yuányīn shì tā píngshí kěn xià gōngfu.', 'Nguyên nhân chính giúp việc học của anh ấy tiến bộ là nhờ bình thường chịu khó bỏ công sức.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [久] (jiǔ) - lâu, thời gian dài [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '久'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'jiǔ',
      example_hanzi = '我们在这里等了很久。',
      example_pinyin = 'Wǒmen zài zhèlǐ děng le hěn jiǔ.',
      example_vi = 'Chúng tôi đã đợi ở đây rất lâu rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我们在这里等了很久。', 'Wǒmen zài zhèlǐ děng le hěn jiǔ.', 'Chúng tôi đã đợi ở đây rất lâu rồi.', 'basic', 1),
        (v_id, '过了这么久，他依然清晰地记得童年发生的事情。', 'Guò le zhème jiǔ, tā yīrán qīngxī de jìde tóngnián fāshēng de shìqing.', 'Trải qua thời gian lâu như vậy, anh ấy vẫn nhớ rất rõ những chuyện xảy ra thời thơ ấu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [习惯] (xíguàn) - thói quen; quen với [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '习惯'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'xíguàn',
      example_hanzi = '早睡早起是一个很好的生活习惯。',
      example_pinyin = 'Zǎoshuì zǎoqǐ shì yí gè hěn hǎo de shēnghuó xíguàn.',
      example_vi = 'Ngủ sớm dậy sớm là một thói quen sinh hoạt rất tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '早睡早起是一个很好的生活习惯。', 'Zǎoshuì zǎoqǐ shì yí gè hěn hǎo de shēnghuó xíguàn.', 'Ngủ sớm dậy sớm là một thói quen sinh hoạt rất tốt.', 'basic', 1),
        (v_id, '来中国两个月后，他已经习惯了这里的饮食和气候。', 'Lái Zhōngguó liǎng gè yuè hòu, tā yǐjīng xíguàn le zhèlǐ de yǐnshí hé qìhòu.', 'Đến Trung Quốc hai tháng sau, anh ấy đã quen với ăn uống và khí hậu nơi đây.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [了解] (liǎojiě) - hiểu rõ, tìm hiểu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '了解'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'liǎojiě',
      example_hanzi = '我很了解他的脾气和性格。',
      example_pinyin = 'Wǒ hěn liǎojiě tā de píqi hé xìnggé.',
      example_vi = 'Tôi rất hiểu rõ tính khí và tính cách của anh ấy.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我很了解他的脾气和性格。', 'Wǒ hěn liǎojiě tā de píqi hé xìnggé.', 'Tôi rất hiểu rõ tính khí và tính cách của anh ấy.', 'basic', 1),
        (v_id, '去一个国家旅游之前，最好先了解一下当地的风俗习惯。', 'Qù yí gè guójiā lǚyóu zhīqián, zuìhǎo xiān liǎojiě yíxià dāngdì de fēngsú xíguàn.', 'Trước khi đến một quốc gia du lịch, tốt nhất nên tìm hiểu trước phong tục tập quán địa phương.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [以前] (yǐqián) - trước đây, trước khi [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '以前'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phó từ',
      pinyin = 'yǐqián',
      example_hanzi = '吃饭以前要把手洗干净。',
      example_pinyin = 'Chīfàn yǐqián yào bǎ shǒu xǐ gānjìng.',
      example_vi = 'Trước khi ăn cơm phải rửa tay sạch sẽ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '吃饭以前要把手洗干净。', 'Chīfàn yǐqián yào bǎ shǒu xǐ gānjìng.', 'Trước khi ăn cơm phải rửa tay sạch sẽ.', 'basic', 1),
        (v_id, '他以前在一所中学当老师，现在换了新的工作。', 'Tā yǐqián zài yì suǒ zhōngxué dāng lǎoshī, xiànzài huàn le xīn de gōngzuò.', 'Trước đây anh ấy làm giáo viên ở một trường cấp hai, hiện tại đã đổi công việc mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [会议] (huìyì) - cuộc họp, hội nghị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '会议'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'huìyì',
      example_hanzi = '下午的会议两点整准时开始。',
      example_pinyin = 'Xiàwǔ de huìyì liǎng diǎn zhěng zhǔnshí kāishǐ.',
      example_vi = 'Cuộc họp chiều nay đúng hai giờ sẽ chuẩn giờ bắt đầu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下午的会议两点整准时开始。', 'Xiàwǔ de huìyì liǎng diǎn zhěng zhǔnshí kāishǐ.', 'Cuộc họp chiều nay đúng hai giờ sẽ chuẩn giờ bắt đầu.', 'basic', 1),
        (v_id, '经理在会议上详细介绍了下一阶段的工作计划。', 'Jīnglǐ zài huìyì shang xiángxì jièshào le xià yí jiēduàn de gōngzuò jìhuà.', 'Giám đốc đã giới thiệu chi tiết kế hoạch công việc giai đoạn tiếp theo trong cuộc họp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [伞] (sǎn) - chiếc ô, cái dù [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '伞'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'sǎn',
      example_hanzi = '外面下大雨了，出门记得带把伞。',
      example_pinyin = 'Wàimiàn xià dà yǔ le, chūmén jìde dài bǎ sǎn.',
      example_vi = 'Bên ngoài trời mưa to rồi, ra ngoài nhớ mang theo cây dù.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '外面下大雨了，出门记得带把伞。', 'Wàimiàn xià dà yǔ le, chūmén jìde dài bǎ sǎn.', 'Bên ngoài trời mưa to rồi, ra ngoài nhớ mang theo cây dù.', 'basic', 1),
        (v_id, '夏天的太阳很晒，许多女生出门喜欢打遮阳伞。', 'Xiàtiān de tàiyáng hěn shài, xǔduō nǚshēng chūmén xǐhuan dǎ zhēyángsǎn.', 'Ánh nắng mùa hè rất gắt, nhiều bạn nữ ra ngoài thích che ô chống nắng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [体育] (tǐyù) - thể dục, thể thao [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '体育'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tǐyù',
      example_hanzi = '星期五下午我们有一节体育课。',
      example_pinyin = 'Xīngqīwǔ xiàwǔ wǒmen yǒu yì jié tǐyùkè.',
      example_vi = 'Chiều thứ sáu chúng tôi có một tiết thể dục.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '星期五下午我们有一节体育课。', 'Xīngqīwǔ xiàwǔ wǒmen yǒu yì jié tǐyùkè.', 'Chiều thứ sáu chúng tôi có một tiết thể dục.', 'basic', 1),
        (v_id, '经常参加体育锻炼可以强健体魄，减轻生活压力。', 'Jīngcháng cānjiā tǐyù duànliàn kěyǐ qiángjiàn tǐpò, jiǎnqīng shēnghuó yālì.', 'Thường xuyên tham gia rèn luyện thể thao có thể tăng cường thể lực và giảm bớt áp lực cuộc sống.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [作业] (zuòyè) - bài tập về nhà [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '作业'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zuòyè',
      example_hanzi = '今天的汉语作业你做完了吗？',
      example_pinyin = 'Jīntiān de Hànyǔ zuòyè nǐ zuò wán le ma?',
      example_vi = 'Bài tập tiếng Trung hôm nay bạn đã làm xong chưa?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天的汉语作业你做完了吗？', 'Jīntiān de Hànyǔ zuòyè nǐ zuò wán le ma?', 'Bài tập tiếng Trung hôm nay bạn đã làm xong chưa?', 'basic', 1),
        (v_id, '做完作业之后，还要认真检查一遍有没有错别字。', 'Zuò wán zuòyè zhīhòu, hái yào rènzhēn jiǎnchá yí biàn yǒu méiyǒu cuòbiézì.', 'Sau khi làm xong bài tập, còn phải cẩn thận kiểm tra lại một lượt xem có lỗi chính tả không.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [信用卡] (xìnyòngkǎ) - thẻ tín dụng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '信用卡'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'xìnyòngkǎ',
      example_hanzi = '在这家超市买东西可以用信用卡付款。',
      example_pinyin = 'Zài zhè jiā chāoshì mǎi dōngxi kěyǐ yòng xìnyòngkǎ fùkuǎn.',
      example_vi = 'Mua đồ ở siêu thị này có thể dùng thẻ tín dụng thanh toán.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '在这家超市买东西可以用信用卡付款。', 'Zài zhè jiā chāoshì mǎi dōngxi kěyǐ yòng xìnyòngkǎ fùkuǎn.', 'Mua đồ ở siêu thị này có thể dùng thẻ tín dụng thanh toán.', 'basic', 1),
        (v_id, '使用信用卡消费时，一定要按时还款以保持良好的信用记录。', 'Shǐyòng xìnyòngkǎ xiāofèi shí, yídìng yào ànshí huánkuǎn yǐ bǎochí liánghǎo de xìnyòng jìlù.', 'Khi chi tiêu bằng thẻ tín dụng, nhất định phải trả nợ đúng hạn để duy trì lịch sử tín dụng tốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [借] (jiè) - mượn, vay, cho mượn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '借'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'jiè',
      example_hanzi = '我可以借用一下你的铅笔吗？',
      example_pinyin = 'Wǒ kěyǐ jièyòng yíxià nǐ de qiānbǐ ma?',
      example_vi = 'Tôi có thể mượn dùng bút chì của bạn một chút được không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我可以借用一下你的铅笔吗？', 'Wǒ kěyǐ jièyòng yíxià nǐ de qiānbǐ ma?', 'Tôi có thể mượn dùng bút chì của bạn một chút được không?', 'basic', 1),
        (v_id, '我昨天在学校图书馆借了两本关于中国文化的书。', 'Wǒ zuótiān zài xuéxiào túshūguǎn jiè le liǎng běn guānyú Zhōngguó wénhuà de shū.', 'Hôm qua tôi đã mượn hai cuốn sách về văn hóa Trung Quốc ở thư viện trường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [健康] (jiànkāng) - khỏe mạnh, sức khỏe [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '健康'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Danh từ',
      pinyin = 'jiànkāng',
      example_hanzi = '多吃新鲜蔬菜水果对身体健康有好处。',
      example_pinyin = 'Duō chī xīnxiān shūcài shuǐguǒ duì shēntǐ jiànkāng yǒu hǎochu.',
      example_vi = 'Ăn nhiều rau quả tươi có lợi cho sức khỏe.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '多吃新鲜蔬菜水果对身体健康有好处。', 'Duō chī xīnxiān shūcài shuǐguǒ duì shēntǐ jiànkāng yǒu hǎochu.', 'Ăn nhiều rau quả tươi có lợi cho sức khỏe.', 'basic', 1),
        (v_id, '拥有健康的身体和乐观的心态是人生最大的财富。', 'Yōngyǒu jiànkāng de shēntǐ hé lèguān de xīntài shì rénshēng zuì dà de cáifù.', 'Sở hữu một cơ thể khỏe mạnh và tâm thái lạc quan là tài sản lớn nhất của đời người.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [像] (xiàng) - giống, giống như, dường như [Động từ / Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '像'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Giới từ',
      pinyin = 'xiàng',
      example_hanzi = '这孩子长得真像他的爸爸。',
      example_pinyin = 'Zhè háizi zhǎng de zhēn xiàng tā de bàba.',
      example_vi = 'Đứa bé này trông thật giống bố của nó.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这孩子长得真像他的爸爸。', 'Zhè háizi zhǎng de zhēn xiàng tā de bàba.', 'Đứa bé này trông thật giống bố của nó.', 'basic', 1),
        (v_id, '天空中飘着厚厚的白云，像一座座雪白的山峰。', 'Tiānkōng zhōng piāo zhe hòuhòu de báiyún, xiàng yí zuòzuò xuěbái de shānfēng.', 'Trên bầu trời trôi những đám mây trắng bồng bềnh, giống như từng đỉnh núi tuyết trắng xóa.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [先] (xiān) - trước, trước tiên [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '先'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'xiān',
      example_hanzi = '你先坐一会儿，我马上就来。',
      example_pinyin = 'Nǐ xiān zuò yíhuìr, wǒ mǎshàng jiù lái.',
      example_vi = 'Bạn ngồi trước một lát nhé, tôi đến ngay đây.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你先坐一会儿，我马上就来。', 'Nǐ xiān zuò yíhuìr, wǒ mǎshàng jiù lái.', 'Bạn ngồi trước một lát nhé, tôi đến ngay đây.', 'basic', 1),
        (v_id, '我们先去超市买菜，然后再回家做晚饭。', 'Wǒmen xiān qù chāoshì mǎi cài, ránhòu zài huí jiā zuò wǎnfàn.', 'Chúng ta đi siêu thị mua thức ăn trước, sau đó mới về nhà nấu bữa tối.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [公园] (gōngyuán) - công viên [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '公园'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gōngyuán',
      example_hanzi = '周末很多老人喜欢去公园散步。',
      example_pinyin = 'Zhōumò hěn duō lǎorén xǐhuan qù gōngyuán sànbù.',
      example_vi = 'Cuối tuần nhiều người già thích đi dạo trong công viên.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '周末很多老人喜欢去公园散步。', 'Zhōumò hěn duō lǎorén xǐhuan qù gōngyuán sànbù.', 'Cuối tuần nhiều người già thích đi dạo trong công viên.', 'basic', 1),
        (v_id, '春天一到，公园里的樱花和桃花竞相盛开，吸引了大量游人。', 'Chūntiān yí dào, gōngyuán lǐ de yīnghuā hé táohuā jìngxiāng shèngkāi, xīyǐn le dàliàng yóurén.', 'Mùa xuân vừa tới, hoa anh đào và hoa đào trong công viên đua nhau nở rộ, thu hút lượng lớn du khách.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [公斤] (gōngjīn) - ki-lô-gam (kg) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '公斤'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'gōngjīn',
      example_hanzi = '我买了三公斤新鲜的苹果。',
      example_pinyin = 'Wǒ mǎi le sān gōngjīn xīnxiān de píngguǒ.',
      example_vi = 'Tôi đã mua ba ki-lô-gam táo tươi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我买了三公斤新鲜的苹果。', 'Wǒ mǎi le sān gōngjīn xīnxiān de píngguǒ.', 'Tôi đã mua ba ki-lô-gam táo tươi.', 'basic', 1),
        (v_id, '经过半年的科学锻炼，他的体重成功减轻了五公斤。', 'Jīngguò bàn nián de kēxué duànliàn, tā de tǐzhòng chénggōng jiǎnqīng le wǔ gōngjīn.', 'Qua nửa năm rèn luyện khoa học, cân nặng của anh ấy đã giảm thành công 5 kg.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [关] (guān) - đóng (cửa), tắt (đèn/quạt/máy tính) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '关'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'guān',
      example_hanzi = '离开教室前请记得把灯关上。',
      example_pinyin = 'Líkāi jiàoshì qián qǐng jìde bǎ dēng guān shang.',
      example_vi = 'Trước khi rời khỏi lớp học xin nhớ tắt đèn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '离开教室前请记得把灯关上。', 'Líkāi jiàoshì qián qǐng jìde bǎ dēng guān shang.', 'Trước khi rời khỏi lớp học xin nhớ tắt đèn.', 'basic', 1),
        (v_id, '外面刮起了大风，快去把房间的窗户关紧。', 'Wàimiàn guā qǐ le dà fēng, kuài qù bǎ fángjiān de chuānghu guān jǐn.', 'Bên ngoài nổi gió to rồi, mau đi đóng chặt cửa sổ phòng lại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [关于] (guānyú) - về, liên quan đến [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '关于'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'guānyú',
      example_hanzi = '这是一本关于中国历史的书。',
      example_pinyin = 'Zhè shì yì běn guānyú Zhōngguó lìshǐ de shū.',
      example_vi = 'Đây là một cuốn sách viết về lịch sử Trung Quốc.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这是一本关于中国历史的书。', 'Zhè shì yì běn guānyú Zhōngguó lìshǐ de shū.', 'Đây là một cuốn sách viết về lịch sử Trung Quốc.', 'basic', 1),
        (v_id, '关于下周五文化节的具体活动安排，请参看公告栏。', 'Guānyú xià zhōuwǔ wénhuàjié de jùtǐ huódòng ānpái, qǐng cānkàn gōnggàolán.', 'Về lịch trình hoạt động cụ thể của ngày hội văn hóa thứ sáu tới, xin tham khảo bảng thông báo.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [关心] (guānxīn) - quan tâm, chăm lo [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '关心'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'guānxīn',
      example_hanzi = '老师非常关心每一位留学生的学习。',
      example_pinyin = 'Lǎoshī fēicháng guānxīn měi yí wèi liúxuéshēng de xuéxí.',
      example_vi = 'Thầy cô rất quan tâm đến việc học của từng bạn du học sinh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师非常关心每一位留学生的学习。', 'Lǎoshī fēicháng guānxīn měi yí wèi liúxuéshēng de xuéxí.', 'Thầy cô rất quan tâm đến việc học của từng bạn du học sinh.', 'basic', 1),
        (v_id, '生病住院期间，朋友们的悉心关心让他感到分外温暖。', 'Shēngbìng zhùyuàn qījiān, péngyoumen de xīxīn guānxīn ràng tā gǎndào fènwài wēnnuǎn.', 'Trong thời gian nằm viện vì ốm, sự quan tâm chu đáo của bạn bè khiến anh ấy cảm thấy vô cùng ấm áp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [关系] (guānxi) - mối quan hệ, liên can [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '关系'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'guānxi',
      example_hanzi = '没关系，这只是一件小事。',
      example_pinyin = 'Méi guānxi, zhè zhǐ shì yí jiàn xiǎoshì.',
      example_vi = 'Không sao đâu, đây chỉ là một chuyện nhỏ thôi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '没关系，这只是一件小事。', 'Méi guānxi, zhè zhǐ shì yí jiàn xiǎoshì.', 'Không sao đâu, đây chỉ là một chuyện nhỏ thôi.', 'basic', 1),
        (v_id, '他们俩不仅是工作上的同事，私下里关系也特别好。', 'Tāmen liǎ bùjǐn shì gōngzuò shang de tóngshì, sīxià lǐ guānxi yě tèbié hǎo.', 'Hai người họ không chỉ là đồng nghiệp trong công việc mà ngoài đời mối quan hệ cũng rất tốt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [其他] (qítā) - khác, người khác, cái khác [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '其他'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Đại từ',
      pinyin = 'qítā',
      example_hanzi = '除了小明，其他同学都按时到齐了。',
      example_pinyin = 'Chúle Xiǎomíng, qítā tóngxué dōu ànshí dào qí le.',
      example_vi = 'Ngoài Tiểu Minh ra, các bạn học khác đều đã đến đông đủ đúng giờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '除了小明，其他同学都按时到齐了。', 'Chúle Xiǎomíng, qítā tóngxué dōu ànshí dào qí le.', 'Ngoài Tiểu Minh ra, các bạn học khác đều đã đến đông đủ đúng giờ.', 'basic', 1),
        (v_id, '如果您对这个方案没有其他疑问，我们就可以正式签约了。', 'Rúguǒ nín duì zhè ge fāng’àn méiyǒu qítā yíwèn, wǒmen jiù kěyǐ zhèngshì qiānyuē le.', 'Nếu quý khách không còn thắc mắc gì khác về phương án này, chúng ta có thể chính thức ký hợp đồng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [其实] (qíshí) - thực ra, kỳ thực [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '其实'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'qíshí',
      example_hanzi = '这道题看着很难，其实一点儿也不难。',
      example_pinyin = 'Zhè dào tí kàn zhe hěn nán, qíshí yìdiǎnr yě bù nán.',
      example_vi = 'Câu này nhìn thì có vẻ khó, thực ra chẳng khó chút nào.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这道题看着很难，其实一点儿也不难。', 'Zhè dào tí kàn zhe hěn nán, qíshí yìdiǎnr yě bù nán.', 'Câu này nhìn thì có vẻ khó, thực ra chẳng khó chút nào.', 'basic', 1),
        (v_id, '他表面上看起来很严肃，其实私底下为人特别和气幽默。', 'Tā biǎomiàn shang kàn qǐlái hěn yánsù, qíshí sīdǐxià wéirén tèbié héqì yōumò.', 'Bề ngoài trông anh ấy rất nghiêm nghị, kỳ thực trong đời thường tính tình lại rất hòa nhã và hài hước.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [最后] (zuìhòu) - cuối cùng [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '最后'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phó từ',
      pinyin = 'zuìhòu',
      example_hanzi = '经过多次努力，他最后通过了考试。',
      example_pinyin = 'Jīngguò duō cì nǔlì, tā zuìhòu tōngguò le kǎoshì.',
      example_vi = 'Trải qua nhiều lần nỗ lực, cuối cùng anh ấy đã thi đỗ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '经过多次努力，他最后通过了考试。', 'Jīngguò duō cì nǔlì, tā zuìhòu tōngguò le kǎoshì.', 'Trải qua nhiều lần nỗ lực, cuối cùng anh ấy đã thi đỗ.', 'basic', 1),
        (v_id, '比赛进行到最后一分钟，我们队凭借默契配合逆转夺冠。', 'Bǐsài jìnxíng dào zuìhòu yì fēnzhōng, wǒmen duì píngjiè mòqì pèihé nìzhuǎn duó guàn.', 'Trận đấu bước vào phút thi đấu cuối cùng, đội chúng tôi nhờ sự phối hợp ăn ý đã lội ngược dòng đoạt chức vô địch.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [最近] (zuìjìn) - gần đây, dạo này [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '最近'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Phó từ',
      pinyin = 'zuìjìn',
      example_hanzi = '好久不见，你最近身体怎么样？',
      example_pinyin = 'Hǎojiǔ bú jiàn, nǐ zuìjìn shēntǐ zěnmeyàng?',
      example_vi = 'Lâu ngày không gặp, dạo này sức khỏe bạn thế nào?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '好久不见，你最近身体怎么样？', 'Hǎojiǔ bú jiàn, nǐ zuìjìn shēntǐ zěnmeyàng?', 'Lâu ngày không gặp, dạo này sức khỏe bạn thế nào?', 'basic', 1),
        (v_id, '最近一段时间公司业务很繁忙，大家经常加班到很晚。', 'Zuìjìn yí duàn shíjiān gōngsī yèwù hěn fánmáng, dàjiā jīngcháng jiābān dào hěn wǎn.', 'Khoảng thời gian gần đây việc công ty rất bận rộn, mọi người thường tăng ca đến khuya.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [冰箱] (bīngxiāng) - tủ lạnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '冰箱'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bīngxiāng',
      example_hanzi = '请把吃剩的西瓜放进冰箱保鲜。',
      example_pinyin = 'Qǐng bǎ chī shèng de xīguā fàng jìn bīngxiāng bǎoxiān.',
      example_vi = 'Xin hãy cho chỗ dưa hấu ăn thừa vào tủ lạnh để bảo quản.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把吃剩的西瓜放进冰箱保鲜。', 'Qǐng bǎ chī shèng de xīguā fàng jìn bīngxiāng bǎoxiān.', 'Xin hãy cho chỗ dưa hấu ăn thừa vào tủ lạnh để bảo quản.', 'basic', 1),
        (v_id, '夏天天气热，从冰箱里拿出一瓶冰镇酸奶喝真过瘾。', 'Xiàtiān tiānqì rè, cóng bīngxiāng lǐ ná chū yì píng bīngzhèn suānnǎi hē zhēn guòyǐn.', 'Mùa hè thời tiết nóng bức, lấy một chai sữa chua ướp lạnh từ tủ lạnh ra uống thật đã.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [决定] (juédìng) - quyết định [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '决定'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'juédìng',
      example_hanzi = '我决定毕业后去中国留学深造。',
      example_pinyin = 'Wǒ juédìng bìyè hòu qù Zhōngguó liúxué shēnzào.',
      example_vi = 'Tôi quyết định sau khi tốt nghiệp sẽ sang Trung Quốc du học nâng cao.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我决定毕业后去中国留学深造。', 'Wǒ juédìng bìyè hòu qù Zhōngguó liúxué shēnzào.', 'Tôi quyết định sau khi tốt nghiệp sẽ sang Trung Quốc du học nâng cao.', 'basic', 1),
        (v_id, '经过全家人的认真商量，大家一致决定下个月搬进新家。', 'Jīngguò quán jiā rén de rènzhēn shāngliang, dàjiā yízhì juédìng xià gè yuè bān jìn xīn jiā.', 'Sau khi cả nhà cùng bàn bạc kỹ lưỡng, mọi người nhất trí quyết định tháng sau chuyển về nhà mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [几乎] (jīhū) - hầu như, gần như [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '几乎'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'jīhū',
      example_hanzi = '今天全班同学几乎都按时到了。',
      example_pinyin = 'Jīntiān quán bān tóngxué jīhū dōu ànshí dào le.',
      example_vi = 'Hôm nay học sinh toàn lớp hầu như đều đã đến đúng giờ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '今天全班同学几乎都按时到了。', 'Jīntiān quán bān tóngxué jīhū dōu ànshí dào le.', 'Hôm nay học sinh toàn lớp hầu như đều đã đến đúng giờ.', 'basic', 1),
        (v_id, '离开家乡十几年，这座城市的变化大得让他几乎认不出来了。', 'Líkāi jiāxiāng shí jǐ nián, zhè zuò chéngshì de biànhuà dà de ràng tā jīhū rèn bù chūlái le.', 'Xa quê mười mấy năm, sự đổi thay của thành phố này lớn đến mức khiến anh ấy gần như không nhận ra.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [刚才] (gāngcái) - vừa mới, vừa nãy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '刚才'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'gāngcái',
      example_hanzi = '刚才谁敲门了？',
      example_pinyin = 'Gāngcái shéi qiāo mén le?',
      example_vi = 'Vừa nãy ai gõ cửa thế?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '刚才谁敲门了？', 'Gāngcái shéi qiāo mén le?', 'Vừa nãy ai gõ cửa thế?', 'basic', 1),
        (v_id, '刚才在走廊里我好像看见王老师从办公室走出来了。', 'Gāngcái zài zǒuláng lǐ wǒ hǎoxiàng kànjiàn Wáng lǎoshī cóng bàngōngshì zǒu chūlái le.', 'Vừa nãy ngoài hành lang hình như tôi nhìn thấy thầy Vương từ văn phòng bước ra.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [刻] (kè) - khắc (15 phút) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '刻'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'kè',
      example_hanzi = '现在是上午十点一刻。',
      example_pinyin = 'Xiànzài shì shàngwǔ shí diǎn yí kè.',
      example_vi = 'Bây giờ là mười giờ mười lăm phút sáng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '现在是上午十点一刻。', 'Xiànzài shì shàngwǔ shí diǎn yí kè.', 'Bây giờ là mười giờ mười lăm phút sáng.', 'basic', 1),
        (v_id, '还有一刻钟火车就要开出了，大家抓紧时间上车。', 'Hái yǒu yí kè zhōng huǒchē jiù yào kāi chū le, dàjiā zhuājǐn shíjiān shàng chē.', 'Còn mười lăm phút nữa tàu hỏa sẽ chuyển bánh, mọi người hãy khẩn trương lên tàu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [办公室] (bàngōngshì) - văn phòng, phòng làm việc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '办公室'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bàngōngshì',
      example_hanzi = '老师正在二楼办公室备课。',
      example_pinyin = 'Lǎoshī zhèngzài èr lóu bàngōngshì bèikè.',
      example_vi = 'Thầy giáo đang chuẩn bị giáo án ở văn phòng tầng hai.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '老师正在二楼办公室备课。', 'Lǎoshī zhèngzài èr lóu bàngōngshì bèikè.', 'Thầy giáo đang chuẩn bị giáo án ở văn phòng tầng hai.', 'basic', 1),
        (v_id, '进入办公室请轻声关门，保持良好的安静办公环境。', 'Jìnrù bàngōngshì qǐng qīngshēng guān mén, bǎochí liánghǎo de ānjìng bàngōng huánjìng.', 'Vào văn phòng xin nhẹ nhàng khép cửa, duy trì môi trường làm việc yên tĩnh.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [办法] (bànfǎ) - biện pháp, phương pháp, cách giải quyết [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '办法'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'bànfǎ',
      example_hanzi = '你想出一个解决问题的好办法了吗？',
      example_pinyin = 'Nǐ xiǎng chū yí gè jiějué wèntí de hǎo bànfǎ le ma?',
      example_vi = 'Bạn đã nghĩ ra biện pháp hay để giải quyết vấn đề chưa?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '你想出一个解决问题的好办法了吗？', 'Nǐ xiǎng chū yí gè jiějué wèntí de hǎo bànfǎ le ma?', 'Bạn đã nghĩ ra biện pháp hay để giải quyết vấn đề chưa?', 'basic', 1),
        (v_id, '遇到困难时别轻易退缩，总能找到克服它的好办法。', 'Yù dào kùnnan shí bié qīngyì tuìsuō, zǒng néng zhǎodào kèfú tā de hǎo bànfǎ.', 'Khi gặp khó khăn đừng vội chùn bước, luôn có thể tìm ra cách hay để khắc phục nó.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [动物] (dòngwù) - động vật, muông thú [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '动物'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dòngwù',
      example_hanzi = '小孩子一般都很喜欢小动物。',
      example_pinyin = 'Xiǎoháizi yìbān dōu hěn xǐhuan xiǎo dòngwù.',
      example_vi = 'Trẻ con thông thường đều rất thích động vật nhỏ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小孩子一般都很喜欢小动物。', 'Xiǎoháizi yìbān dōu hěn xǐhuan xiǎo dòngwù.', 'Trẻ con thông thường đều rất thích động vật nhỏ.', 'basic', 1),
        (v_id, '关爱野生动物、保护生态平衡是全人类共同的责任。', 'Guān’ài yěshēng dòngwù, bǎohù shēngtài pínghéng shì quán rénlèi gòngtóng de zérèn.', 'Quan tâm động vật hoang dã và bảo vệ cân bằng sinh thái là trách nhiệm chung của toàn nhân loại.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [努力] (nǔlì) - nỗ lực, cố gắng, chăm chỉ [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '努力'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ / Động từ',
      pinyin = 'nǔlì',
      example_hanzi = '他平时学习非常努力。',
      example_pinyin = 'Tā píngshí xuéxí fēicháng nǔlì.',
      example_vi = 'Bình thường anh ấy học tập rất chăm chỉ.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他平时学习非常努力。', 'Tā píngshí xuéxí fēicháng nǔlì.', 'Bình thường anh ấy học tập rất chăm chỉ.', 'basic', 1),
        (v_id, '只要从现在起脚踏实地努力，将来就一定能收获丰硕的成果。', 'Zhǐyào cóng xiànzài qǐ jiǎotàshídì nǔlì, jiānglái jiù yídìng néng shōuhuò fēngshuò de chéngguǒ.', 'Chỉ cần từ bây giờ nỗ lực thiết thực vững chắc, tương lai nhất định sẽ gặt hái thành quả rực rỡ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [北方] (běifāng) - miền bắc, phương bắc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '北方'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'běifāng',
      example_hanzi = '中国北方冬天的天气非常寒冷。',
      example_pinyin = 'Zhōngguó běifāng dōngtiān de tiānqì fēicháng hánlěng.',
      example_vi = 'Mùa đông ở miền bắc Trung Quốc thời tiết vô cùng giá lạnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国北方冬天的天气非常寒冷。', 'Zhōngguó běifāng dōngtiān de tiānqì fēicháng hánlěng.', 'Mùa đông ở miền bắc Trung Quốc thời tiết vô cùng giá lạnh.', 'basic', 1),
        (v_id, '北方人主食习惯吃面条和馒头，而南方人更偏爱米饭。', 'Běifāng rén zhǔshí xíguàn chī miàntiáo hé mántou, ér nánfāng rén gèng piān’ài mǐfàn.', 'Người miền bắc có thói quen ăn món chính là mì sợi và màn thầu, còn người miền nam lại chuộng cơm hơn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [南] (nán) - phía nam, hướng nam [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '南'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'nán',
      example_hanzi = '教室的门朝南开着。',
      example_pinyin = 'Jiàoshì de mén cháo nán kāi zhe.',
      example_vi = 'Cửa phòng học mở về hướng nam.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '教室的门朝南开着。', 'Jiàoshì de mén cháo nán kāi zhe.', 'Cửa phòng học mở về hướng nam.', 'basic', 1),
        (v_id, '车站向南走五百米有一家大型综合医院。', 'Chēzhàn xiàng nán zǒu wǔbǎi mǐ yǒu yì jiā dàxíng zōnghé yīyuàn.', 'Từ bến xe đi về phía nam năm trăm mét có một bệnh viện đa khoa lớn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [历史] (lìshǐ) - lịch sử [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '历史'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'lìshǐ',
      example_hanzi = '北京是一座有着三千多年历史的古城。',
      example_pinyin = 'Běijīng shì yí zuò yǒu zhe sānqiān duō nián lìshǐ de gǔchéng.',
      example_vi = 'Bắc Kinh là một cổ thành có hơn ba ngàn năm lịch sử.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '北京是一座有着三千多年历史的古城。', 'Běijīng shì yí zuò yǒu zhe sānqiān duō nián lìshǐ de gǔchéng.', 'Bắc Kinh là một cổ thành có hơn ba ngàn năm lịch sử.', 'basic', 1),
        (v_id, '学习悠久的历史可以让我们更好地认识过去并开创未来。', 'Xuéxí yōujiǔ de lìshǐ kěyǐ ràng wǒmen gèng hǎo de rènshi guòqù bìng kāichuàng wèilái.', 'Học tập lịch sử lâu đời có thể giúp chúng ta hiểu rõ hơn về quá khứ và mở ra tương lai.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [参加] (cānjiā) - tham gia, tham dự [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '参加'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'cānjiā',
      example_hanzi = '下个星期他要参加汉语水平考试。',
      example_pinyin = 'Xià gè xīngqī tā yào cānjiā Hànyǔ Shuǐpíng Kǎoshì.',
      example_vi = 'Tuần sau anh ấy phải tham gia kỳ thi kiểm tra trình độ tiếng Trung HSK.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '下个星期他要参加汉语水平考试。', 'Xià gè xīngqī tā yào cānjiā Hànyǔ Shuǐpíng Kǎoshì.', 'Tuần sau anh ấy phải tham gia kỳ thi kiểm tra trình độ tiếng Trung HSK.', 'basic', 1),
        (v_id, '欢迎大家积极参加学校举办的中华传统文化体验活动。', 'Huānyíng dàjiā jījí cānjiā xuéxiào jǔbàn de Zhōnghuá chuántǒng wénhuà tǐyàn huódòng.', 'Hoan nghênh mọi người tích cực tham gia hoạt động trải nghiệm văn hóa truyền thống do trường tổ chức.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [又] (yòu) - lại, vừa... lại... [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '又'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Phó từ',
      pinyin = 'yòu',
      example_hanzi = '这家饭馆的菜又便宜又好吃。',
      example_pinyin = 'Zhè jiā fànguǎn de cài yòu piányi yòu hǎochī.',
      example_vi = 'Món ăn của quán cơm này vừa rẻ lại vừa ngon miệng.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这家饭馆的菜又便宜又好吃。', 'Zhè jiā fànguǎn de cài yòu piányi yòu hǎochī.', 'Món ăn của quán cơm này vừa rẻ lại vừa ngon miệng.', 'basic', 1),
        (v_id, '今天早上下雨了，下午怎么又下起雪来了。', 'Jīntiān zǎoshang xiàyǔ le, xiàwǔ zěnme yòu xià qǐ xuě lái le.', 'Sáng nay trời vừa mưa xong, buổi chiều sao lại đổ tuyết xuống nữa rồi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [双] (shuāng) - đôi, cặp (giày, đũa, mắt) [Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '双'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Lượng từ',
      pinyin = 'shuāng',
      example_hanzi = '他买了一双黑色的新皮鞋。',
      example_pinyin = 'Tā mǎi le yì shuāng hēisè de xīn píxié.',
      example_vi = 'Anh ấy đã mua một đôi giày da mới màu đen.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他买了一双黑色的新皮鞋。', 'Tā mǎi le yì shuāng hēisè de xīn píxié.', 'Anh ấy đã mua một đôi giày da mới màu đen.', 'basic', 1),
        (v_id, '服务员，请给我们拿一双干净的筷子。', 'Fúwùyuán, qǐng gěi wǒmen ná yì shuāng gānjìng de kuàizi.', 'Phục vụ ơi, làm ơn lấy cho chúng tôi một đôi đũa sạch.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [发] (fā) - gửi (thư/tin nhắn), phát, phát ra [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '发'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fā',
      example_hanzi = '我已经把文件发到你的邮箱了。',
      example_pinyin = 'Wǒ yǐjīng bǎ wénjiàn fā dào nǐ de yóuxiāng le.',
      example_vi = 'Tôi đã gửi tài liệu vào hòm thư điện tử của bạn rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我已经把文件发到你的邮箱了。', 'Wǒ yǐjīng bǎ wénjiàn fā dào nǐ de yóuxiāng le.', 'Tôi đã gửi tài liệu vào hòm thư điện tử của bạn rồi.', 'basic', 1),
        (v_id, '到家以后记得给我发一条短信报个平安。', 'Dào jiā yǐhòu jìde gěi wǒ fā yì tiáo duǎnxìn bào gè píng’ān.', 'Về đến nhà rồi nhớ gửi cho tôi một tin nhắn báo bình an nhé.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [发烧] (fāshāo) - phát sốt, bị sốt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '发烧'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'fāshāo',
      example_hanzi = '他感冒了，身体一直在发烧。',
      example_pinyin = 'Tā gǎnmào le, shēntǐ yìzhí zài fāshāo.',
      example_vi = 'Cậu ấy bị cảm rồi, cơ thể cứ bị sốt suốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他感冒了，身体一直在发烧。', 'Tā gǎnmào le, shēntǐ yìzhí zài fāshāo.', 'Cậu ấy bị cảm rồi, cơ thể cứ bị sốt suốt.', 'basic', 1),
        (v_id, '如果体温超过三十八度五，发烧时要及时去医院看医生。', 'Rúguǒ tǐwēn chāoguò sānshíbā dù wǔ, fāshāo shí yào jíshí qù yīyuàn kàn yīshēng.', 'Nếu thân nhiệt vượt quá 38.5 độ, khi bị sốt cần kịp thời đến bệnh viện khám bác sĩ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [发现] (fāxiàn) - phát hiện, nhận ra [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '发现'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'fāxiàn',
      example_hanzi = '我刚才发现钥匙忘在桌子上了。',
      example_pinyin = 'Wǒ gāngcái fāxiàn yàoshi wàng zài zhuōzi shang le.',
      example_vi = 'Vừa nãy tôi phát hiện chìa khóa để quên trên bàn rồi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我刚才发现钥匙忘在桌子上了。', 'Wǒ gāngcái fāxiàn yàoshi wàng zài zhuōzi shang le.', 'Vừa nãy tôi phát hiện chìa khóa để quên trên bàn rồi.', 'basic', 1),
        (v_id, '经过细心观察，科学家在这个古老山洞里有了重大发现。', 'Jīngguò xìxīn guānchá, kēxuéjiā zài zhè ge gǔlǎo shāndòng lǐ yǒu le zhòngdà fāxiàn.', 'Qua quan sát tỉ mỉ, các nhà khoa học đã có phát hiện quan trọng trong hang động cổ này.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [叔叔] (shūshu) - chú, người đàn ông trạc tuổi chú [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '叔叔'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shūshu',
      example_hanzi = '叔叔送给我一本精美的画册。',
      example_pinyin = 'Shūshu sòng gěi wǒ yì běn jīngměi de huàcè.',
      example_vi = 'Chú tặng cho tôi một cuốn tập tranh tinh xảo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '叔叔送给我一本精美的画册。', 'Shūshu sòng gěi wǒ yì běn jīngměi de huàcè.', 'Chú tặng cho tôi một cuốn tập tranh tinh xảo.', 'basic', 1),
        (v_id, '在路上遇到熟识的长辈，要有礼貌地叫一声“叔叔好”。', 'Zài lù shang yù dào shúshí de zhǎngbèi, yào yǒu lǐmào de jiào yì shēng “shūshu hǎo”.', 'Trên đường gặp người lớn tuổi quen biết, cần lễ phép cất lời chào "cháu chào chú ạ".', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [变化] (biànhuà) - thay đổi, sự biến đổi [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '变化'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ / Động từ',
      pinyin = 'biànhuà',
      example_hanzi = '这几年家乡的发展变化真大。',
      example_pinyin = 'Zhè jǐ nián jiāxiāng de fāzhǎn biànhuà zhēn dà.',
      example_vi = 'Mấy năm nay sự phát triển đổi thay của quê hương thật to lớn.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这几年家乡的发展变化真大。', 'Zhè jǐ nián jiāxiāng de fāzhǎn biànhuà zhēn dà.', 'Mấy năm nay sự phát triển đổi thay của quê hương thật to lớn.', 'basic', 1),
        (v_id, '秋天到来时，随着气温逐渐下降，树叶的颜色也悄然发生着变化。', 'Qiūtiān dàolái shí, suízhe qìwēn zhújiàn xiàjiàng, shùyè de yánsè yě qiǎorán fāshēng zhe biànhuà.', 'Khi mùa thu tới, theo nhiệt độ dần hạ thấp, màu sắc của lá cây cũng lặng lẽ biến đổi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [句子] (jùzi) - câu, câu văn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '句子'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jùzi',
      example_hanzi = '请用这个新词造一个完整的句子。',
      example_pinyin = 'Qǐng yòng zhè ge xīn cí zào yí gè wánzhěng de jùzi.',
      example_vi = 'Xin hãy dùng từ mới này đặt một câu hoàn chỉnh.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请用这个新词造一个完整的句子。', 'Qǐng yòng zhè ge xīn cí zào yí gè wánzhěng de jùzi.', 'Xin hãy dùng từ mới này đặt một câu hoàn chỉnh.', 'basic', 1),
        (v_id, '通过熟读课文中的重点句子，我们可以更好地掌握汉语句型结构。', 'Tōngguò shú dú kèwén zhōng de zhòngdiǎn jùzi, wǒmen kěyǐ gèng hǎo de zhǎngwò Hànyǔ jùxíng jiégòu.', 'Nhờ đọc nhuần nhuyễn các câu trọng điểm trong bài khóa, chúng ta có thể nắm bắt tốt hơn cấu trúc mẫu câu tiếng Trung.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [可爱] (kě'ài) - đáng yêu, dễ thương [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '可爱'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'kě''ài',
      example_hanzi = '那只小猫长得真可爱。',
      example_pinyin = 'Nà zhī xiǎomāo zhǎng de zhēn kě’ài.',
      example_vi = 'Chú mèo con đó trông thật đáng yêu.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '那只小猫长得真可爱。', 'Nà zhī xiǎomāo zhǎng de zhēn kě’ài.', 'Chú mèo con đó trông thật đáng yêu.', 'basic', 1),
        (v_id, '动物园里的大熊猫慢悠悠吃竹子的样子非常憨厚可爱。', 'Dòngwùyuán lǐ de dàxióngmāo mànyōuyōu chī zhúzi de yàngzi fēicháng hānhou kě’ài.', 'Dáng vẻ chậm rãi ăn trúc của chú gấu trúc trong sở thú vô cùng ngây thơ dễ thương.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [司机] (sījī) - tài xế, lái xe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '司机'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'sījī',
      example_hanzi = '出租车司机的驾驶技术非常好。',
      example_pinyin = 'Chūzūchē sījī de jiàshǐ jìshù fēicháng hǎo.',
      example_vi = 'Kỹ thuật lái xe của tài xế taxi rất tốt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '出租车司机的驾驶技术非常好。', 'Chūzūchē sījī de jiàshǐ jìshù fēicháng hǎo.', 'Kỹ thuật lái xe của tài xế taxi rất tốt.', 'basic', 1),
        (v_id, '下公共汽车前，很多乘客都会礼貌地向司机师傅说一声谢谢。', 'Xià gōnggòng qìchē qián, hěn duō chéngkè dōu huì lǐmào de xiàng sījī shīfu shuō yì shēng xièxie.', 'Trước khi xuống xe buýt, nhiều hành khách đều lịch sự nói lời cảm ơn bác tài xế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [同事] (tóngshì) - đồng nghiệp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '同事'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tóngshì',
      example_hanzi = '我和办公室里的同事们相处得很融洽。',
      example_pinyin = 'Wǒ hé bàngōngshì lǐ de tóngshìmen xiāngchǔ de hěn róngqià.',
      example_vi = 'Tôi và các đồng nghiệp trong văn phòng chung sống rất hòa hợp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我和办公室里的同事们相处得很融洽。', 'Wǒ hé bàngōngshì lǐ de tóngshìmen xiāngchǔ de hěn róngqià.', 'Tôi và các đồng nghiệp trong văn phòng chung sống rất hòa hợp.', 'basic', 1),
        (v_id, '在工作中遇到困难时，热心的同事主动伸出援手给予帮助。', 'Zài gōngzuò zhōng yù dào kùnnan shí, rèxīn de tóngshì zhǔdòng shēn chū yuánshǒu jǐyǔ bāngzhù.', 'Khi gặp khó khăn trong công việc, người đồng nghiệp nhiệt tình đã chủ động chìa tay giúp đỡ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [同意] (tóngyì) - đồng ý, tán thành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '同意'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'tóngyì',
      example_hanzi = '我完全同意你刚才提出的建议。',
      example_pinyin = 'Wǒ wánquán tóngyì nǐ gāngcái tíchū de jiànyì.',
      example_vi = 'Tôi hoàn toàn đồng ý với kiến nghị bạn vừa đưa ra.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我完全同意你刚才提出的建议。', 'Wǒ wánquán tóngyì nǐ gāngcái tíchū de jiànyì.', 'Tôi hoàn toàn đồng ý với kiến nghị bạn vừa đưa ra.', 'basic', 1),
        (v_id, '经过全组讨论，大家都一致同意按照新的计划方案开展下一步工作。', 'Jīngguò quán zǔ tǎolùn, dàjiā dōu yízhì tóngyì ànzhào xīn de jìhuà fāng’àn kāizhǎn xià yí bù gōngzuò.', 'Qua thảo luận của toàn nhóm, mọi người đều nhất trí đồng ý triển khai bước công việc tiếp theo theo phương án kế hoạch mới.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [后来] (hòulái) - sau này, về sau (chỉ sự việc trong quá khứ) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '后来'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'hòulái',
      example_hanzi = '他起初学画画，后来喜欢上了书法。',
      example_pinyin = 'Tā qǐchū xué huàhuà, hòulái xǐhuan shang le shūfǎ.',
      example_vi = 'Ban đầu anh ấy học vẽ, về sau lại đem lòng yêu thích thư pháp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '他起初学画画，后来喜欢上了书法。', 'Tā qǐchū xué huàhuà, hòulái xǐhuan shang le shūfǎ.', 'Ban đầu anh ấy học vẽ, về sau lại đem lòng yêu thích thư pháp.', 'basic', 1),
        (v_id, '由于突然生病他没能参加考试，后来学校为他安排了补考。', 'Yóuyú tūrán shēngbìng tā méi néng cānjiā kǎoshì, hòulái xuéxiào wèi tā ānpái le bǔkǎo.', 'Do đột ngột bị ốm nên anh ấy không thể dự thi, sau này trường đã sắp xếp cho anh ấy thi bù.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [向] (xiàng) - hướng về, phía, tới [Giới từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '向'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Giới từ',
      pinyin = 'xiàng',
      example_hanzi = '从这里一直向前走就是图书馆。',
      example_pinyin = 'Cóng zhèlǐ yìzhí xiàng qián zǒu jiù shì túshūguǎn.',
      example_vi = 'Từ đây cứ đi thẳng về phía trước là tới thư viện.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '从这里一直向前走就是图书馆。', 'Cóng zhèlǐ yìzhí xiàng qián zǒu jiù shì túshūguǎn.', 'Từ đây cứ đi thẳng về phía trước là tới thư viện.', 'basic', 1),
        (v_id, '遇到学习上的疑难问题时，要虚心向老师和优秀的同学请教。', 'Yù dào xuéxí shang de yínán wèntí shí, yào xūxīn xiàng lǎoshī hé yōuxiù de tóngxué qǐngjiào.', 'Khi gặp khúc mắc trong học tập, cần khiêm tốn thỉnh giáo thầy cô và bạn học xuất sắc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [周末] (zhōumò) - cuối tuần [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '周末'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zhōumò',
      example_hanzi = '这个周末你有什么游玩打算？',
      example_pinyin = 'Zhè ge zhōumò nǐ yǒu shénme yóuwán dǎsuàn?',
      example_vi = 'Cuối tuần này bạn có dự định đi chơi gì không?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个周末你有什么游玩打算？', 'Zhè ge zhōumò nǐ yǒu shénme yóuwán dǎsuàn?', 'Cuối tuần này bạn có dự định đi chơi gì không?', 'basic', 1),
        (v_id, '平时工作很紧张，到了周末大家都喜欢放下烦恼好好放松一下。', 'Píngshí gōngzuò hěn jǐnzhāng, dào le zhōumò dàjiā dōu xǐhuan fàngxià fánnǎo hǎohāo fàngsōng yíxià.', 'Ngày thường công việc rất căng thẳng, đến cuối tuần mọi người đều thích gác lại muộn phiền để thư giãn.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [哭] (kū) - khóc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '哭'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ',
      pinyin = 'kū',
      example_hanzi = '小妹妹摔倒了，痛得大声哭了起来。',
      example_pinyin = 'Xiǎo mèimei shuāidǎo le, tòng de dàshēng kū le qǐlái.',
      example_vi = 'Em gái nhỏ bị ngã, đau quá òa khóc thật to.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小妹妹摔倒了，痛得大声哭了起来。', 'Xiǎo mèimei shuāidǎo le, tòng de dàshēng kū le qǐlái.', 'Em gái nhỏ bị ngã, đau quá òa khóc thật to.', 'basic', 1),
        (v_id, '这部电影的结局太感人了，好多观众都忍不住流下了眼泪。', 'Zhè bù diànyǐng de jiéjú tài gǎnrén le, hǎoduō guānzhòng dōu rěnbuzhù liú xià le yǎnlèi.', 'Cái kết của bộ phim này quá cảm động, rất nhiều khán giả đều không kìm được rơi nước mắt.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [啤酒] (píjiǔ) - bia [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '啤酒'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'píjiǔ',
      example_hanzi = '吃烧烤的时候喝一杯冰啤酒很过瘾。',
      example_pinyin = 'Chī shāokǎo de shíhou hē yì bēi bīng píjiǔ hěn guòyǐn.',
      example_vi = 'Khi ăn đồ nướng uống một cốc bia lạnh thật đã.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '吃烧烤的时候喝一杯冰啤酒很过瘾。', 'Chī shāokǎo de shíhou hē yì bēi bīng píjiǔ hěn guòyǐn.', 'Khi ăn đồ nướng uống một cốc bia lạnh thật đã.', 'basic', 1),
        (v_id, '请注意适量饮酒，开车的人千万不能喝啤酒。', 'Qǐng zhùyì shìliàng yǐnjiǔ, kāi chē de rén qiānwàn bù néng hē píjiǔ.', 'Xin hãy chú ý uống rượu bia điều độ, người lái xe tuyệt đối không được uống bia.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [嘴] (zuǐ) - miệng, mồm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '嘴'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'zuǐ',
      example_hanzi = '吃完饭后记得用纸巾把嘴擦干净。',
      example_pinyin = 'Chī wán fàn hòu jìde yòng zhǐjīn bǎ zuǐ cā gānjìng.',
      example_vi = 'Ăn cơm xong nhớ dùng khăn giấy lau sạch miệng nhé.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '吃完饭后记得用纸巾把嘴擦干净。', 'Chī wán fàn hòu jìde yòng zhǐjīn bǎ zuǐ cā gānjìng.', 'Ăn cơm xong nhớ dùng khăn giấy lau sạch miệng nhé.', 'basic', 1),
        (v_id, '张开嘴，深吸一口气，让医生仔细检查一下喉咙。', 'Zhāng kāi zuǐ, shēn xī yì kǒu qì, ràng yīshēng zǐxì jiǎnchá yíxià hóulóng.', 'Há to miệng ra, hít một hơi sâu để bác sĩ kiểm tra kỹ vùng họng.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [回答] (huídá) - trả lời, câu trả lời [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '回答'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'huídá',
      example_hanzi = '请你站起来回答老师的问题。',
      example_pinyin = 'Qǐng nǐ zhàn qǐlái huídá lǎoshī de wèntí.',
      example_vi = 'Xin mời bạn đứng dậy trả lời câu hỏi của thầy giáo.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请你站起来回答老师的问题。', 'Qǐng nǐ zhàn qǐlái huídá lǎoshī de wèntí.', 'Xin mời bạn đứng dậy trả lời câu hỏi của thầy giáo.', 'basic', 1),
        (v_id, '面对记者的提问，发言人做出了清晰而准确的正面回答。', 'Miànduì jìzhě de tíwèn, fāyánrén zuò chū le qīngxī ér zhǔnquè de zhèngmiàn huídá.', 'Đối diện với câu hỏi của phóng viên, người phát ngôn đã đưa ra câu trả lời trực diện rõ ràng và chuẩn xác.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [国家] (guójiā) - quốc gia, đất nước [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '国家'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'guójiā',
      example_hanzi = '中国是一个拥有悠久历史的国家。',
      example_pinyin = 'Zhōngguó shì yí gè yōngyǒu yōujiǔ lìshǐ de guójiā.',
      example_vi = 'Trung Quốc là một quốc gia có bề dày lịch sử lâu đời.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '中国是一个拥有悠久历史的国家。', 'Zhōngguó shì yí gè yōngyǒu yōujiǔ lìshǐ de guójiā.', 'Trung Quốc là một quốc gia có bề dày lịch sử lâu đời.', 'basic', 1),
        (v_id, '不同国家的人们携手合作，共同建设和平美好的地球家园。', 'Bù tóng guójiā de rénmen xiéshǒu hézuò, gòngtóng jiànshè hépíng měihǎo de dìqiú jiāyuán.', 'Người dân các quốc gia khác nhau cùng chung tay hợp tác xây dựng ngôi nhà Trái Đất hòa bình tốt đẹp.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [图书馆] (túshūguǎn) - thư viện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '图书馆'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'túshūguǎn',
      example_hanzi = '我经常在周末去图书馆自习。',
      example_pinyin = 'Wǒ jīngcháng zài zhōumò qù túshūguǎn zìxí.',
      example_vi = 'Cuối tuần tôi thường đến thư viện tự học.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '我经常在周末去图书馆自习。', 'Wǒ jīngcháng zài zhōumò qù túshūguǎn zìxí.', 'Cuối tuần tôi thường đến thư viện tự học.', 'basic', 1),
        (v_id, '大学图书馆里藏书丰富，为广大学生提供了良好的研究环境。', 'Dàxué túshūguǎn lǐ cángshū fēngfù, wèi guǎngdà xuésheng tígōng le liánghǎo de yánjiū huánjìng.', 'Trong thư viện trường đại học tàng thư phong phú, mang đến môi trường nghiên cứu tuyệt vời cho đông đảo sinh viên.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [地] (de) - trợ từ kết cấu (nối phó từ/trạng ngữ với động từ) [Trợ từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '地'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Trợ từ',
      pinyin = 'de',
      example_hanzi = '小鸟在树枝上快乐地歌唱。',
      example_pinyin = 'Xiǎoniǎo zài shùzhī shang kuàilè de gēchàng.',
      example_vi = 'Những chú chim nhỏ vui vẻ hót ca trên cành cây.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '小鸟在树枝上快乐地歌唱。', 'Xiǎoniǎo zài shùzhī shang kuàilè de gēchàng.', 'Những chú chim nhỏ vui vẻ hót ca trên cành cây.', 'basic', 1),
        (v_id, '听到顺利通过考试的消息，他兴奋地从椅子上跳了起来。', 'Tīng dào shùnlì tōngguò kǎoshì de xiāoxi, tā xīngfèn de cóng yǐzi shang tiào le qǐlái.', 'Nghe được tin thi đỗ thuận lợi, cậu ấy phấn khởi nhảy cẫng lên khỏi chiếc ghế.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [地图] (dìtú) - bản đồ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '地图'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dìtú',
      example_hanzi = '去陌生的城市旅游最好随身带一张地图。',
      example_pinyin = 'Qù mòshēng de chéngshì lǚyóu zuìhǎo suíshēn dài yì zhāng dìtú.',
      example_vi = 'Đi du lịch tới thành phố lạ tốt nhất nên mang theo một tấm bản đồ bên mình.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '去陌生的城市旅游最好随身带一张地图。', 'Qù mòshēng de chéngshì lǚyóu zuìhǎo suíshēn dài yì zhāng dìtú.', 'Đi du lịch tới thành phố lạ tốt nhất nên mang theo một tấm bản đồ bên mình.', 'basic', 1),
        (v_id, '手机上的电子地图能实时导航，极大地避免了在路上迷路。', 'Shǒujī shang de diànzǐ dìtú néng shíshí dǎoháng, jídà de bìmǐan le zài lù shang mílù.', 'Bản đồ điện tử trên điện thoại có thể định vị dẫn đường trực tiếp, tránh được việc lạc đường.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [地方] (dìfang) - nơi chốn, chỗ, địa phương [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '地方'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'dìfang',
      example_hanzi = '这个地方的风景十分美丽。',
      example_pinyin = 'Zhè ge dìfang de fēngjǐng shífēn měilì.',
      example_vi = 'Phong cảnh của nơi này vô cùng tươi đẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '这个地方的风景十分美丽。', 'Zhè ge dìfang de fēngjǐng shífēn měilì.', 'Phong cảnh của nơi này vô cùng tươi đẹp.', 'basic', 1),
        (v_id, '我们找个安静舒适的地方坐下来喝杯茶慢慢聊吧。', 'Wǒmen zhǎo gè ānjìng shūshì de dìfang zuò xiàlái hē bēi chá mànmàn liáo ba.', 'Chúng mình tìm một chỗ yên tĩnh dễ chịu ngồi xuống uống ly trà rồi từ từ nói chuyện nhé.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [城市] (chéngshì) - thành phố, đô thị [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '城市'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'chéngshì',
      example_hanzi = '北京是一座现代化的国际大城市。',
      example_pinyin = 'Běijīng shì yí zuò xiàndàihuà de guójì dà chéngshì.',
      example_vi = 'Bắc Kinh là một thành phố lớn quốc tế hiện đại.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '北京是一座现代化的国际大城市。', 'Běijīng shì yí zuò xiàndàihuà de guójì dà chéngshì.', 'Bắc Kinh là một thành phố lớn quốc tế hiện đại.', 'basic', 1),
        (v_id, '随着城市绿化建设的不断推进，街道两旁的环境越来越宜人。', 'Suízhe chéngshì lǜhuà jiànshè de búduàn tuījìn, jiēdào liǎngpáng de huánjìng yuèláiyuè yírén.', 'Cùng với việc không ngừng đẩy mạnh xây dựng mảng xanh đô thị, môi trường hai bên đường phố ngày càng trong lành dễ chịu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [声音] (shēngyīn) - âm thanh, tiếng động, giọng nói [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '声音'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'shēngyīn',
      example_hanzi = '请把电视的声音调小一点儿。',
      example_pinyin = 'Qǐng bǎ diànshì de shēngyīn tiáo xiǎo yìdiǎnr.',
      example_vi = 'Làm ơn chỉnh âm thanh của tivi nhỏ lại một chút.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '请把电视的声音调小一点儿。', 'Qǐng bǎ diànshì de shēngyīn tiáo xiǎo yìdiǎnr.', 'Làm ơn chỉnh âm thanh của tivi nhỏ lại một chút.', 'basic', 1),
        (v_id, '夜深人静的时候，窗外偶尔传来清脆的风吹树叶的声音。', 'Yèshēn rénjìng de shíhou, chuāngwài ǒu’ěr chuán lái qīngcuì de fēng chuī shùyè de shēngyīn.', 'Lúc đêm khuya người vắng, ngoài cửa sổ thi thoảng truyền vào tiếng gió lay cành lá xào xạc thanh thoát.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [复习] (fùxí) - ôn tập, ôn bài [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '复习'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Động từ / Danh từ',
      pinyin = 'fùxí',
      example_hanzi = '明天有考试，今晚我们要认真复习。',
      example_pinyin = 'Míngtiān yǒu kǎoshì, jīnwǎn wǒmen yào rènzhēn fùxí.',
      example_vi = 'Ngày mai có thi, tối nay chúng ta phải chăm chỉ ôn tập.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '明天有考试，今晚我们要认真复习。', 'Míngtiān yǒu kǎoshì, jīnwǎn wǒmen yào rènzhēn fùxí.', 'Ngày mai có thi, tối nay chúng ta phải chăm chỉ ôn tập.', 'basic', 1),
        (v_id, '课后及时复习学过的生词和语法，能大大提高学习效率。', 'Kèhòu jíshí fùxí xué guò de shēngcí hé yǔfǎ, néng dàdà tígāo xuéxí xiàolǜ.', 'Sau giờ học kịp thời ôn lại từ mới và ngữ pháp đã học có thể nâng cao đáng kể hiệu suất học tập.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [太阳] (tàiyáng) - mặt trời, ánh nắng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '太阳'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tàiyáng',
      example_hanzi = '早晨的太阳红彤彤的，非常好看。',
      example_pinyin = 'Zǎochén de tàiyáng hóngtōngtōng de, fēicháng hǎokàn.',
      example_vi = 'Mặt trời buổi sớm đỏ rực, rất đẹp mắt.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '早晨的太阳红彤彤的，非常好看。', 'Zǎochén de tàiyáng hóngtōngtōng de, fēicháng hǎokàn.', 'Mặt trời buổi sớm đỏ rực, rất đẹp mắt.', 'basic', 1),
        (v_id, '冬天坐在阳台上晒晒温暖的太阳，让人感到身心舒畅。', 'Dōngtiān zuò zài yángtái shang shàishai wēnnuǎn de tàiyáng, ràng rén gǎndào shēnxīn shūchàng.', 'Mùa đông ngồi ngoài ban công sưởi ánh nắng ấm áp khiến con người cảm thấy thư thái cả thể xác lẫn tinh thần.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [头发] (tóufa) - tóc, mái tóc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '头发'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'tóufa',
      example_hanzi = '她的头发又黑又长，非常漂亮。',
      example_pinyin = 'Tā de tóufa yòu hēi yòu cháng, fēicháng piàoliang.',
      example_vi = 'Mái tóc của cô ấy vừa đen vừa dài, rất đẹp.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '她的头发又黑又长，非常漂亮。', 'Tā de tóufa yòu hēi yòu cháng, fēicháng piàoliang.', 'Mái tóc của cô ấy vừa đen vừa dài, rất đẹp.', 'basic', 1),
        (v_id, '为了给炎热的夏天带来凉爽，他周末特意去理发店剪短了头发。', 'Wèile gěi yánrè de xiàtiān dài lái liángshuǎng, tā zhōumò tèyì qù lǐfàdiàn jiǎn duǎn le tóufa.', 'Để mang lại sự mát mẻ cho mùa hè oi bức, cuối tuần anh ấy đặc biệt đến tiệm cắt tóc cắt ngắn mái tóc.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [奇怪] (qíguài) - kỳ lạ, quái lạ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '奇怪'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Tính từ',
      pinyin = 'qíguài',
      example_hanzi = '真奇怪，我的手机怎么突然黑屏了？',
      example_pinyin = 'Zhēn qíguài, wǒ de shǒujī zěnme tūrán hēipíng le?',
      example_vi = 'Thật kỳ lạ, điện thoại của tôi sao đột nhiên tắt ngóm màn hình rồi?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '真奇怪，我的手机怎么突然黑屏了？', 'Zhēn qíguài, wǒ de shǒujī zěnme tūrán hēipíng le?', 'Thật kỳ lạ, điện thoại của tôi sao đột nhiên tắt ngóm màn hình rồi?', 'basic', 1),
        (v_id, '平时他每天都起得很早，今天到现在还没出门，真有点儿奇怪。', 'Píngshí tā měitiān dōu qǐ de hěn zǎo, jīntiān dào xiànzài hái méi chūmén, zhēn yǒudiǎnr qíguài.', 'Bình thường ngày nào anh ấy cũng dậy rất sớm, hôm nay đến giờ vẫn chưa ra khỏi cửa, thật có chút kỳ lạ.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [如果] (rúguǒ) - nếu như, nếu [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '如果'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Liên từ',
      pinyin = 'rúguǒ',
      example_hanzi = '如果明天不下雨，我们就去郊外爬山。',
      example_pinyin = 'Rúguǒ míngtiān bú xiàyǔ, wǒmen jiù qù jiāowài pá shān.',
      example_vi = 'Nếu ngày mai trời không mưa thì chúng mình sẽ đi ngoại ô leo núi.'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '如果明天不下雨，我们就去郊外爬山。', 'Rúguǒ míngtiān bú xiàyǔ, wǒmen jiù qù jiāowài pá shān.', 'Nếu ngày mai trời không mưa thì chúng mình sẽ đi ngoại ô leo núi.', 'basic', 1),
        (v_id, '如果你在学习汉语的过程中遇到任何困难，欢迎随时来找我探讨。', 'Rúguǒ nǐ zài xuéxí Hànyǔ de guòchéng zhōng yù dào rènhé kùnnan, huānyíng suíshí lái zhǎo wǒ tàntǎo.', 'Nếu bạn gặp bất kỳ khó khăn nào trong quá trình học tiếng Trung, hoan nghênh bạn bất cứ lúc nào đến tìm tôi trao đổi.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  -- [季节] (jìjié) - mùa, mùa màng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 3' AND hanzi = '季节'
  LIMIT 1;

  IF v_id IS NOT NULL THEN
    -- Cập nhật từ loại, pinyin chuẩn và câu ví dụ cơ bản vào bảng vocabularies
    UPDATE public.vocabularies
    SET 
      word_type = 'Danh từ',
      pinyin = 'jìjié',
      example_hanzi = '一年之中你最喜欢哪一个季节？',
      example_pinyin = 'Yì nián zhī zhōng nǐ zuì xǐhuan nǎ yí gè jìjié.',
      example_vi = 'Trong một năm bạn thích nhất mùa nào?'
    WHERE id = v_id;

    -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
      DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
      
      INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
      VALUES 
        (v_id, '一年之中你最喜欢哪一个季节？', 'Yì nián zhī zhōng nǐ zuì xǐhuan nǎ yí gè jìjié.', 'Trong một năm bạn thích nhất mùa nào?', 'basic', 1),
        (v_id, '秋天不仅是果实累累的收获季节，更是气候宜人的美好时节。', 'Qiūtiān bùjǐn shì guǒshí lěilěi de shōuhuò jìjié, gèng shì qìhòu yírén de měihǎo shíjié.', 'Mùa thu không chỉ là mùa gặt hái trĩu quả mà còn là thời khắc tuyệt đẹp với khí hậu dễ chịu.', 'applied', 2);
    END IF;

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp 160 câu ví dụ cho % từ vựng HSK 3 (Batch 1)!', v_count;
END $$;
