-- ====================================================================
-- SEED DATA: HSK 1 BATCH 1 (30 TỪ VỰNG & 60 CÂU VÍ DỤ CHUẨN ĐỀ CƯƠNG HSK 3.0)
-- Căn cứ Đề cương thi chính thức HSK 3.0 (CTI / chinesetest.cn - 11/2025)
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
BEGIN

  -- [爱] (ài) - yêu, thích
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '爱',
    'ài',
    'yêu, thích',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我爱我的家人。',
    'Wǒ ài wǒ de jiārén.',
    'Tôi yêu gia đình của tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我爱我的家人。', 'Wǒ ài wǒ de jiārén.', 'Tôi yêu gia đình của tôi.', 'basic', 1),
      (v_id, '他很爱吃中国菜。', 'Tā hěn ài chī Zhōngguó cài.', 'Anh ấy rất thích ăn món Trung Quốc.', 'applied', 2);
  END IF;

  -- [八] (bā) - tám (số 8)
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '八',
    'bā',
    'tám (số 8)',
    'Số từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我有八本书。',
    'Wǒ yǒu bā běn shū.',
    'Tôi có tám quyển sách.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我有八本书。', 'Wǒ yǒu bā běn shū.', 'Tôi có tám quyển sách.', 'basic', 1),
      (v_id, '我们明天早上八点见。', 'Wǒmen míngtiān zǎoshang bā diǎn jiàn.', 'Sáng mai tám giờ chúng ta gặp nhau nhé.', 'applied', 2);
  END IF;

  -- [爸爸] (bàba) - bố, cha, ba
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '爸爸',
    'bàba',
    'bố, cha, ba',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我爸爸是老师。',
    'Wǒ bàba shì lǎoshī.',
    'Bố tôi là giáo viên.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我爸爸是老师。', 'Wǒ bàba shì lǎoshī.', 'Bố tôi là giáo viên.', 'basic', 1),
      (v_id, '爸爸今天工作很忙。', 'Bàba jīntiān gōngzuò hěn máng.', 'Hôm nay bố làm việc rất bận.', 'applied', 2);
  END IF;

  -- [吧] (ba) - nhé, đi, thôi (dùng cuối câu cầu khiến/nghị luận)
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '吧',
    'ba',
    'nhé, đi, thôi (dùng cuối câu cầu khiến/nghị luận)',
    'Trợ từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们走吧。',
    'Wǒmen zǒu ba.',
    'Chúng ta đi thôi nào.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们走吧。', 'Wǒmen zǒu ba.', 'Chúng ta đi thôi nào.', 'basic', 1),
      (v_id, '这杯茶给你喝吧。', 'Zhè bēi chá gěi nǐ hē ba.', 'Cốc trà này cho bạn uống đấy.', 'applied', 2);
  END IF;

  -- [白] (bái) - trắng, màu trắng
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '白',
    'bái',
    'trắng, màu trắng',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '她有一件白衣服。',
    'Tā yǒu yí jiàn bái yīfu.',
    'Cô ấy có một chiếc áo trắng.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '她有一件白衣服。', 'Tā yǒu yí jiàn bái yīfu.', 'Cô ấy có một chiếc áo trắng.', 'basic', 1),
      (v_id, '那只白色的猫真可爱。', 'Nà zhī báisè de māo zhēn kě’ài.', 'Con mèo màu trắng kia thật là đáng yêu.', 'applied', 2);
  END IF;

  -- [白天] (báitiān) - ban ngày
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '白天',
    'báitiān',
    'ban ngày',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '白天这里很安静。',
    'Báitiān zhèlǐ hěn ānjìng.',
    'Ban ngày ở đây rất yên tĩnh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '白天这里很安静。', 'Báitiān zhèlǐ hěn ānjìng.', 'Ban ngày ở đây rất yên tĩnh.', 'basic', 1),
      (v_id, '他白天上班，晚上学中文。', 'Tā báitiān shàngbān, wǎnshang xué Zhōngwén.', 'Anh ấy ban ngày đi làm, buổi tối học tiếng Trung.', 'applied', 2);
  END IF;

  -- [百] (bǎi) - trăm (100)
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '百',
    'bǎi',
    'trăm (100)',
    'Số từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这本书一百块钱。',
    'Zhè běn shū yì bǎi kuài qián.',
    'Quyển sách này một trăm tệ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这本书一百块钱。', 'Zhè běn shū yì bǎi kuài qián.', 'Quyển sách này một trăm tệ.', 'basic', 1),
      (v_id, '这个学校有几百个学生。', 'Zhè ge xuéxiào yǒu jǐ bǎi gè xuésheng.', 'Trường học này có vài trăm học sinh.', 'applied', 2);
  END IF;

  -- [班] (bān) - lớp, ca làm
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '班',
    'bān',
    'lớp, ca làm',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们班有十五个人。',
    'Wǒmen bān yǒu shíwǔ gè rén.',
    'Lớp chúng tôi có mười lăm người.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们班有十五个人。', 'Wǒmen bān yǒu shíwǔ gè rén.', 'Lớp chúng tôi có mười lăm người.', 'basic', 1),
      (v_id, '我今天下午上晚班。', 'Wǒ jīntiān xiàwǔ shàng wǎnbān.', 'Chiều nay tôi làm ca tối.', 'applied', 2);
  END IF;

  -- [半] (bàn) - nửa, rưỡi
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '半',
    'bàn',
    'nửa, rưỡi',
    'Số từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '现在是三点半。',
    'Xiànzài shì sān diǎn bàn.',
    'Bây giờ là ba giờ rưỡi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '现在是三点半。', 'Xiànzài shì sān diǎn bàn.', 'Bây giờ là ba giờ rưỡi.', 'basic', 1),
      (v_id, '我吃半个苹果就饱了。', 'Wǒ chī bàn gè píngguǒ jiù bǎo le.', 'Tôi ăn nửa quả táo là đã no rồi.', 'applied', 2);
  END IF;

  -- [半年] (bànnián) - nửa năm
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '半年',
    'bànnián',
    'nửa năm',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他在北京住半年了。',
    'Tā zài Běijīng zhù bànnián le.',
    'Anh ấy sống ở Bắc Kinh nửa năm rồi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他在北京住半年了。', 'Tā zài Běijīng zhù bànnián le.', 'Anh ấy sống ở Bắc Kinh nửa năm rồi.', 'basic', 1),
      (v_id, '我学中文半年了，会说一点儿。', 'Wǒ xué Zhōngwén bànnián le, huì shuō yìdiǎnr.', 'Tôi học tiếng Trung nửa năm rồi, biết nói một chút.', 'applied', 2);
  END IF;

  -- [半天] (bàntiān) - nửa ngày, hồi lâu
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '半天',
    'bàntiān',
    'nửa ngày, hồi lâu',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我等了你半天。',
    'Wǒ děng le nǐ bàntiān.',
    'Tôi đợi bạn hồi lâu rồi đấy.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我等了你半天。', 'Wǒ děng le nǐ bàntiān.', 'Tôi đợi bạn hồi lâu rồi đấy.', 'basic', 1),
      (v_id, '今天下雨，我们在家看半天书。', 'Jīntiān xiàyǔ, wǒmen zài jiā kàn bàntiān shū.', 'Hôm nay trời mưa, chúng tôi ở nhà đọc sách suốt nửa ngày.', 'applied', 2);
  END IF;

  -- [帮] (bāng) - giúp, giúp đỡ
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '帮',
    'bāng',
    'giúp, giúp đỡ',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你能帮我一下吗？',
    'Nǐ néng bāng wǒ yíxià ma?',
    'Bạn có thể giúp tôi một chút không?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你能帮我一下吗？', 'Nǐ néng bāng wǒ yíxià ma?', 'Bạn có thể giúp tôi một chút không?', 'basic', 1),
      (v_id, '谢谢你帮我买水。', 'Xièxie nǐ bāng wǒ mǎi shuǐ.', 'Cảm ơn bạn đã giúp tôi mua nước.', 'applied', 2);
  END IF;

  -- [帮忙] (bāngmáng) - giúp đỡ, giúp một tay
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '帮忙',
    'bāngmáng',
    'giúp đỡ, giúp một tay',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '请大家来帮忙。',
    'Qǐng dàjiā lái bāngmáng.',
    'Xin mời mọi người đến giúp một tay.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请大家来帮忙。', 'Qǐng dàjiā lái bāngmáng.', 'Xin mời mọi người đến giúp một tay.', 'basic', 1),
      (v_id, '非常感谢你的帮忙！', 'Fēicháng gǎnxiè nǐ de bāngmáng!', 'Rất cảm ơn sự giúp đỡ của bạn!', 'applied', 2);
  END IF;

  -- [包] (bāo) - túi xách, cặp, túi
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '包',
    'bāo',
    'túi xách, cặp, túi',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这个包是红色的。',
    'Zhè ge bāo shì hóngsè de.',
    'Chiếc túi này màu đỏ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个包是红色的。', 'Zhè ge bāo shì hóngsè de.', 'Chiếc túi này màu đỏ.', 'basic', 1),
      (v_id, '我的手机在包里。', 'Wǒ de shǒujī zài bāo lǐ.', 'Điện thoại của tôi ở trong túi.', 'applied', 2);
  END IF;

  -- [包子] (bāozi) - bánh bao
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '包子',
    'bāozi',
    'bánh bao',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '早上我吃两个包子。',
    'Zǎoshang wǒ chī liǎng gè bāozi.',
    'Buổi sáng tôi ăn hai cái bánh bao.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '早上我吃两个包子。', 'Zǎoshang wǒ chī liǎng gè bāozi.', 'Buổi sáng tôi ăn hai cái bánh bao.', 'basic', 1),
      (v_id, '这家店的包子很好吃。', 'Zhè jiā diàn de bāozi hěn hǎochī.', 'Bánh bao của quán này rất ngon.', 'applied', 2);
  END IF;

  -- [杯] (bēi) - cốc, chén, ly
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '杯',
    'bēi',
    'cốc, chén, ly',
    'Lượng từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我想喝一杯水。',
    'Wǒ xiǎng hē yì bēi shuǐ.',
    'Tôi muốn uống một cốc nước.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我想喝一杯水。', 'Wǒ xiǎng hē yì bēi shuǐ.', 'Tôi muốn uống một cốc nước.', 'basic', 1),
      (v_id, '请给我一杯热茶。', 'Qǐng gěi wǒ yì bēi rè chá.', 'Làm ơn cho tôi một tách trà nóng.', 'applied', 2);
  END IF;

  -- [杯子] (bēizi) - cái cốc, cái ly
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '杯子',
    'bēizi',
    'cái cốc, cái ly',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '桌子上有一个杯子。',
    'Zhuōzi shang yǒu yí gè bēizi.',
    'Trên bàn có một cái cốc.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '桌子上有一个杯子。', 'Zhuōzi shang yǒu yí gè bēizi.', 'Trên bàn có một cái cốc.', 'basic', 1),
      (v_id, '这个杯子真漂亮。', 'Zhè ge bēizi zhēn piàoliang.', 'Chiếc cốc này thật đẹp.', 'applied', 2);
  END IF;

  -- [北] (běi) - hướng bắc, phía bắc
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '北',
    'běi',
    'hướng bắc, phía bắc',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '车站往北走就到了。',
    'Chēzhàn wǎng běi zǒu jiù dào le.',
    'Bến xe đi về phía bắc là tới nơi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '车站往北走就到了。', 'Chēzhàn wǎng běi zǒu jiù dào le.', 'Bến xe đi về phía bắc là tới nơi.', 'basic', 1),
      (v_id, '北方冬天的天气比较冷。', 'Běifāng dōngtiān de tiānqì bǐjiào lěng.', 'Thời tiết mùa đông ở phương bắc khá là lạnh.', 'applied', 2);
  END IF;

  -- [北京] (Běijīng) - Bắc Kinh
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '北京',
    'Běijīng',
    'Bắc Kinh',
    'Danh từ riêng',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我朋友住在北京。',
    'Wǒ péngyou zhù zài Běijīng.',
    'Bạn tôi sống ở Bắc Kinh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我朋友住在北京。', 'Wǒ péngyou zhù zài Běijīng.', 'Bạn tôi sống ở Bắc Kinh.', 'basic', 1),
      (v_id, '你想去北京旅游吗？', 'Nǐ xiǎng qù Běijīng lǚyóu ma?', 'Bạn có muốn đi du lịch Bắc Kinh không?', 'applied', 2);
  END IF;

  -- [北边] (běibian) - phía bắc, bên bắc
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '北边',
    'běibian',
    'phía bắc, bên bắc',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '学校的北边是公园。',
    'Xuéxiào de běibian shì gōngyuán.',
    'Phía bắc của trường học là công viên.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '学校的北边是公园。', 'Xuéxiào de běibian shì gōngyuán.', 'Phía bắc của trường học là công viên.', 'basic', 1),
      (v_id, '超市在医院的北边。', 'Chāoshì zài yīyuàn de běibian.', 'Siêu thị nằm ở phía bắc của bệnh viện.', 'applied', 2);
  END IF;

  -- [本] (běn) - quyển, cuốn
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '本',
    'běn',
    'quyển, cuốn',
    'Lượng từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我买了一本书。',
    'Wǒ mǎi le yì běn shū.',
    'Tôi đã mua một quyển sách.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我买了一本书。', 'Wǒ mǎi le yì běn shū.', 'Tôi đã mua một quyển sách.', 'basic', 1),
      (v_id, '这本中文书很有意思。', 'Zhè běn Zhōngwén shū hěn yǒu yìsi.', 'Quyển sách tiếng Trung này rất thú vị.', 'applied', 2);
  END IF;

  -- [本子] (běnzi) - vở, tập, cuốn sổ
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '本子',
    'běnzi',
    'vở, tập, cuốn sổ',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我的本子在桌上。',
    'Wǒ de běnzi zài zhuō shang.',
    'Quyển vở của tôi ở trên bàn.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我的本子在桌上。', 'Wǒ de běnzi zài zhuō shang.', 'Quyển vở của tôi ở trên bàn.', 'basic', 1),
      (v_id, '他把新单词写在小本子上。', 'Tā bǎ xīn dāncí xiě zài xiǎo běnzi shang.', 'Anh ấy viết từ mới vào một cuốn sổ nhỏ.', 'applied', 2);
  END IF;

  -- [比] (bǐ) - so với, hơn
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '比',
    'bǐ',
    'so với, hơn',
    'Giới từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天比昨天冷。',
    'Jīntiān bǐ zuótiān lěng.',
    'Hôm nay lạnh hơn hôm qua.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天比昨天冷。', 'Jīntiān bǐ zuótiān lěng.', 'Hôm nay lạnh hơn hôm qua.', 'basic', 1),
      (v_id, '哥哥比我大三岁。', 'Gēge bǐ wǒ dà sān suì.', 'Anh trai lớn hơn tôi ba tuổi.', 'applied', 2);
  END IF;

  -- [别] (bié) - đừng
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '别',
    'bié',
    'đừng',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你别说了。',
    'Nǐ bié shuō le.',
    'Bạn đừng nói nữa.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你别说了。', 'Nǐ bié shuō le.', 'Bạn đừng nói nữa.', 'basic', 1),
      (v_id, '天黑了，别在外面玩了。', 'Tiān hēi le, bié zài wàimiàn wán le.', 'Trời tối rồi, đừng chơi ở bên ngoài nữa.', 'applied', 2);
  END IF;

  -- [别的] (biéde) - cái khác, việc khác
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '别的',
    'biéde',
    'cái khác, việc khác',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你还要买别的吗？',
    'Nǐ hái yào mǎi biéde ma?',
    'Bạn còn muốn mua cái khác không?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你还要买别的吗？', 'Nǐ hái yào mǎi biéde ma?', 'Bạn còn muốn mua cái khác không?', 'basic', 1),
      (v_id, '我没有别的书了。', 'Wǒ méiyǒu biéde shū le.', 'Tôi không còn quyển sách nào khác nữa.', 'applied', 2);
  END IF;

  -- [别人] (biérén) - người khác
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '别人',
    'biérén',
    'người khác',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们要多听别人的意见。',
    'Wǒmen yào duō tīng biérén de yìjiàn.',
    'Chúng ta nên lắng nghe ý kiến của người khác nhiều hơn.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们要多听别人的意见。', 'Wǒmen yào duō tīng biérén de yìjiàn.', 'Chúng ta nên lắng nghe ý kiến của người khác nhiều hơn.', 'basic', 1),
      (v_id, '这是别人的手机，不是我的。', 'Zhè shì biérén de shǒujī, bú shì wǒ de.', 'Đây là điện thoại của người khác, không phải của tôi.', 'applied', 2);
  END IF;

  -- [病] (bìng) - ốm, bệnh, đau ốm
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '病',
    'bìng',
    'ốm, bệnh, đau ốm',
    'Danh từ / Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他今天生病了。',
    'Tā jīntiān shēngbìng le.',
    'Hôm nay anh ấy bị ốm rồi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他今天生病了。', 'Tā jīntiān shēngbìng le.', 'Hôm nay anh ấy bị ốm rồi.', 'basic', 1),
      (v_id, '你病好了吗？要多喝水。', 'Nǐ bìng hǎo le ma? Yào duō hē shuǐ.', 'Bạn đã khỏi ốm chưa? Nhớ uống nhiều nước nhé.', 'applied', 2);
  END IF;

  -- [病人] (bìngrén) - người bệnh, bệnh nhân
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '病人',
    'bìngrén',
    'người bệnh, bệnh nhân',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '医院里有很多病人。',
    'Yīyuàn lǐ yǒu hěn duō bìngrén.',
    'Trong bệnh viện có rất nhiều bệnh nhân.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '医院里有很多病人。', 'Yīyuàn lǐ yǒu hěn duō bìngrén.', 'Trong bệnh viện có rất nhiều bệnh nhân.', 'basic', 1),
      (v_id, '医生正在给病人看病。', 'Yīshēng zhèngzài gěi bìngrén kànbìng.', 'Bác sĩ đang khám bệnh cho bệnh nhân.', 'applied', 2);
  END IF;

  -- [不] (bù) - không, chẳng
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不',
    'bù',
    'không, chẳng',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我不是学生。',
    'Wǒ bú shì xuésheng.',
    'Tôi không phải là học sinh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我不是学生。', 'Wǒ bú shì xuésheng.', 'Tôi không phải là học sinh.', 'basic', 1),
      (v_id, '今天天气不太热。', 'Jīntiān tiānqì bú tài rè.', 'Hôm nay thời tiết không nóng lắm.', 'applied', 2);
  END IF;

  -- [不大] (búdà) - không to, không lớn lắm
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不大',
    'búdà',
    'không to, không lớn lắm',
    'Tính từ / Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这个房间不大。',
    'Zhè ge fángjiān búdà.',
    'Căn phòng này không lớn.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = EXCLUDED.hsk_level,
    hsk_level_v3 = EXCLUDED.hsk_level_v3,
    hsk_version = EXCLUDED.hsk_version,
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp câu ví dụ vào bảng vocabulary_examples nếu bảng tồn tại
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个房间不大。', 'Zhè ge fángjiān búdà.', 'Căn phòng này không lớn.', 'basic', 1),
      (v_id, '雨不大了，我们走吧。', 'Yǔ búdà le, wǒmen zǒu ba.', 'Mưa không còn to nữa rồi, chúng ta đi thôi.', 'applied', 2);
  END IF;

END $$;
