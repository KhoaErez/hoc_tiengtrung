-- ====================================================================
-- MIGRATION SEED: BỔ SUNG 149 MỤC TỪ VỰNG HSK 1 ĐẠT CHUẨN 300/300 HSK 3.0
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn - Công bố 11/2025)
-- Đặc điểm: 
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - ON CONFLICT (hanzi, pinyin) DO UPDATE: Idempotent, không tạo bản ghi trùng
--   - Không làm thay đổi ID cũ của vocabularies, bảo toàn user_vocabularies / Flashcards
--   - Nạp tự động 2 câu ví dụ vào vocabulary_examples và sync ví dụ 1 vào vocabularies
--   - Cập nhật đúng cấp độ cho 21 từ cũ sang HSK 2 để HSK 1 đạt chuẩn tuyệt đối 300/300
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN

  -- ------------------------------------------------------------------
  -- BƯỚC 1: BẢO VỆ TIẾN ĐỘ & PHÂN LOẠI ĐÚNG CẤP ĐỘ CHO 21 TỪ HSK 2.0 CŨ
  -- (Không xóa bản ghi nào, giữ nguyên ID để bảo toàn user_vocabularies)
  -- 21 từ này thuộc HSK 2 trong đề cương HSK 3.0 mới
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level = 'HSK 2',
    hsk_level_v3 = 'HSK 2',
    hsk_version = 'hsk3.0'
  WHERE hanzi IN (
    '不大', '别', '别人', '别的', '前面', '包', '北', '北京', '北边',
    '半天', '半年', '后面', '小姐', '帮', '帮忙', '本子', '杯', '比',
    '班', '病人', '白'
  )
  AND (hsk_level = 'HSK 1' OR hsk_level IS NULL);

  -- ------------------------------------------------------------------
  -- BƯỚC 2: ĐỒNG BỘ VERSION CHO 151 TỪ VỰNG CHUẨN HIỆN CÓ
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0'
  WHERE hsk_level = 'HSK 1';

  -- ------------------------------------------------------------------
  -- BƯỚC 3: BỔ SUNG 149 TỪ VỰNG CHUẨN HSK 1 VÀ 298 CÂU VÍ DỤ CHẤT LƯỢNG CAO
  -- ------------------------------------------------------------------
  -- [边] (biān) - bên, phía [Danh từ / Hậu tố]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '边',
    'biān',
    'bên, phía',
    'Danh từ / Hậu tố',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '河边有很多树。',
    'Hé biān yǒu hěn duō shù.',
    'Bên bờ sông có rất nhiều cây.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '河边有很多树。', 'Hé biān yǒu hěn duō shù.', 'Bên bờ sông có rất nhiều cây.', 'basic', 1),
      (v_id, '请大家往左边走。', 'Qǐng dàjiā wǎng zuǒbian zǒu.', 'Xin mời mọi người đi về phía bên trái.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不要] (búyào) - đừng, không muốn [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不要',
    'búyào',
    'đừng, không muốn',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你不要大声说话。',
    'Nǐ búyào dàshēng shuōhuà.',
    'Bạn đừng nói chuyện lớn tiếng.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你不要大声说话。', 'Nǐ búyào dàshēng shuōhuà.', 'Bạn đừng nói chuyện lớn tiếng.', 'basic', 1),
      (v_id, '今天太累了，我不要去超市。', 'Jīntiān tài lèi le, wǒ búyào qù chāoshì.', 'Hôm nay mệt quá rồi, tôi không muốn đi siêu thị nữa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [唱] (chàng) - hát [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '唱',
    'chàng',
    'hát',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '她很会唱中文歌。',
    'Tā hěn huì chàng Zhōngwén gē.',
    'Cô ấy rất biết hát bài hát tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '她很会唱中文歌。', 'Tā hěn huì chàng Zhōngwén gē.', 'Cô ấy rất biết hát bài hát tiếng Trung.', 'basic', 1),
      (v_id, '我们一起唱这首歌吧。', 'Wǒmen yìqǐ chàng zhè shǒu gē ba.', 'Chúng mình cùng nhau hát bài hát này nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [超市] (chāoshì) - siêu thị [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '超市',
    'chāoshì',
    'siêu thị',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '学校旁边有一家超市。',
    'Xuéxiào pángbiān yǒu yì jiā chāoshì.',
    'Bên cạnh trường học có một siêu thị.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '学校旁边有一家超市。', 'Xuéxiào pángbiān yǒu yì jiā chāoshì.', 'Bên cạnh trường học có một siêu thị.', 'basic', 1),
      (v_id, '我们去超市买水果吧。', 'Wǒmen qù chāoshì mǎi shuǐguǒ ba.', 'Chúng ta đi siêu thị mua hoa quả đi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [车] (chē) - xe, xe cộ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '车',
    'chē',
    'xe, xe cộ',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这是我爸爸的车。',
    'Zhè shì wǒ bàba de chē.',
    'Đây là xe của bố tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这是我爸爸的车。', 'Zhè shì wǒ bàba de chē.', 'Đây là xe của bố tôi.', 'basic', 1),
      (v_id, '路上的车真多。', 'Lù shang de chē zhēn duō.', 'Xe cộ trên đường thật là đông.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [穿] (chuān) - mặc (quần áo), đi (giày dép) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '穿',
    'chuān',
    'mặc (quần áo), đi (giày dép)',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他穿了一件新衣服。',
    'Tā chuān le yí jiàn xīn yīfu.',
    'Anh ấy mặc một chiếc áo mới.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他穿了一件新衣服。', 'Tā chuān le yí jiàn xīn yīfu.', 'Anh ấy mặc một chiếc áo mới.', 'basic', 1),
      (v_id, '今天天气冷，多穿点儿衣服吧。', 'Jīntiān tiānqì lěng, duō chuān diǎnr yīfu ba.', 'Hôm nay trời lạnh, mặc nhiều quần áo vào một chút nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [大家] (dàjiā) - mọi người, cả nhà [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '大家',
    'dàjiā',
    'mọi người, cả nhà',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '大家好！',
    'Dàjiā hǎo!',
    'Chào mọi người!'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '大家好！', 'Dàjiā hǎo!', 'Chào mọi người!', 'basic', 1),
      (v_id, '大家都喜欢吃中国菜。', 'Dàjiā dōu xǐhuan chī Zhōngguó cài.', 'Mọi người đều thích ăn món ăn Trung Quốc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [大学] (dàxué) - trường đại học [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '大学',
    'dàxué',
    'trường đại học',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '北京大学很有名。',
    'Běijīng Dàxué hěn yǒumíng.',
    'Đại học Bắc Kinh rất nổi tiếng.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '北京大学很有名。', 'Běijīng Dàxué hěn yǒumíng.', 'Đại học Bắc Kinh rất nổi tiếng.', 'basic', 1),
      (v_id, '哥哥在大学里学中文。', 'Gēge zài dàxué lǐ xué Zhōngwén.', 'Anh trai học tiếng Trung ở trường đại học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [大学生] (dàxuéshēng) - sinh viên đại học [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '大学生',
    'dàxuéshēng',
    'sinh viên đại học',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我姐姐是大学生。',
    'Wǒ jiějie shì dàxuéshēng.',
    'Chị gái tôi là sinh viên đại học.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我姐姐是大学生。', 'Wǒ jiějie shì dàxuéshēng.', 'Chị gái tôi là sinh viên đại học.', 'basic', 1),
      (v_id, '这里的大学生都很努力。', 'Zhèlǐ de dàxuéshēng dōu hěn nǔlì.', 'Sinh viên đại học ở đây đều rất chăm chỉ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [到] (dào) - đến, tới nơi [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '到',
    'dào',
    'đến, tới nơi',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们到家了。',
    'Wǒmen dào jiā le.',
    'Chúng ta về đến nhà rồi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们到家了。', 'Wǒmen dào jiā le.', 'Chúng ta về đến nhà rồi.', 'basic', 1),
      (v_id, '火车下午两点到北京。', 'Huǒchē xiàwǔ liǎng diǎn dào Běijīng.', 'Tàu hỏa đến Bắc Kinh lúc hai giờ chiều.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [第] (dì) - thứ (chỉ số thứ tự: thứ nhất, thứ hai...) [Tiền tố]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '第',
    'dì',
    'thứ (chỉ số thứ tự: thứ nhất, thứ hai...)',
    'Tiền tố',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这是第一课。',
    'Zhè shì dì-yī kè.',
    'Đây là bài học thứ nhất.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这是第一课。', 'Zhè shì dì-yī kè.', 'Đây là bài học thứ nhất.', 'basic', 1),
      (v_id, '他是第一个来的学生。', 'Tā shì dì-yī gè lái de xuésheng.', 'Cậu ấy là học sinh đầu tiên đến lớp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [弟弟] (dìdi) - em trai [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '弟弟',
    'dìdi',
    'em trai',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我有一个弟弟。',
    'Wǒ yǒu yí gè dìdi.',
    'Tôi có một người em trai.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我有一个弟弟。', 'Wǒ yǒu yí gè dìdi.', 'Tôi có một người em trai.', 'basic', 1),
      (v_id, '我弟弟今年八岁，上小学。', 'Wǒ dìdi jīnnián bā suì, shàng xiǎoxué.', 'Em trai tôi năm nay tám tuổi, đang học tiểu học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [店] (diàn) - cửa hàng, quán [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '店',
    'diàn',
    'cửa hàng, quán',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这家店卖衣服。',
    'Zhè jiā diàn mài yīfu.',
    'Cửa hàng này bán quần áo.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这家店卖衣服。', 'Zhè jiā diàn mài yīfu.', 'Cửa hàng này bán quần áo.', 'basic', 1),
      (v_id, '学校门前有一家茶店。', 'Xuéxiào ménqián yǒu yì jiā chádiàn.', 'Trước cổng trường có một quán trà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [电话] (diànhuà) - điện thoại, cuộc gọi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '电话',
    'diànhuà',
    'điện thoại, cuộc gọi',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你的电话是多少？',
    'Nǐ de diànhuà shì duōshao?',
    'Số điện thoại của bạn là bao nhiêu?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你的电话是多少？', 'Nǐ de diànhuà shì duōshao?', 'Số điện thoại của bạn là bao nhiêu?', 'basic', 1),
      (v_id, '他正在给妈妈打电话。', 'Tā zhèngzài gěi māma dǎ diànhuà.', 'Anh ấy đang gọi điện thoại cho mẹ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [电影院] (diànyǐngyuàn) - rạp chiếu phim [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '电影院',
    'diànyǐngyuàn',
    'rạp chiếu phim',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们去电影院看电影吧。',
    'Wǒmen qù diànyǐngyuàn kàn diànyǐng ba.',
    'Chúng mình đến rạp chiếu phim xem phim đi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们去电影院看电影吧。', 'Wǒmen qù diànyǐngyuàn kàn diànyǐng ba.', 'Chúng mình đến rạp chiếu phim xem phim đi.', 'basic', 1),
      (v_id, '这个电影院离我家不远。', 'Zhè ge diànyǐngyuàn lí wǒ jiā bù yuǎn.', 'Rạp chiếu phim này cách nhà tôi không xa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [读书] (dúshū) - đọc sách, đi học [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '读书',
    'dúshū',
    'đọc sách, đi học',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我喜欢每天晚上读书。',
    'Wǒ xǐhuan měitiān wǎnshang dúshū.',
    'Tôi thích đọc sách vào mỗi buổi tối.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我喜欢每天晚上读书。', 'Wǒ xǐhuan měitiān wǎnshang dúshū.', 'Tôi thích đọc sách vào mỗi buổi tối.', 'basic', 1),
      (v_id, '弟弟正在北京的一所大学读书。', 'Dìdi zhèngzài Běijīng de yì suǒ dàxué dúshū.', 'Em trai đang học tại một trường đại học ở Bắc Kinh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [对] (duì) - đúng, chính xác; đối với [Tính từ / Giới từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '对',
    'duì',
    'đúng, chính xác; đối với',
    'Tính từ / Giới từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你说得很对。',
    'Nǐ shuō de hěn duì.',
    'Bạn nói rất đúng.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你说得很对。', 'Nǐ shuō de hěn duì.', 'Bạn nói rất đúng.', 'basic', 1),
      (v_id, '常喝茶对身体很好。', 'Cháng hē chá duì shēntǐ hěn hǎo.', 'Thường xuyên uống trà rất tốt cho sức khỏe.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [饭] (fàn) - cơm, bữa ăn [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '饭',
    'fàn',
    'cơm, bữa ăn',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你吃饭了吗？',
    'Nǐ chī fàn le ma?',
    'Bạn đã ăn cơm chưa?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你吃饭了吗？', 'Nǐ chī fàn le ma?', 'Bạn đã ăn cơm chưa?', 'basic', 1),
      (v_id, '今天的晚饭非常丰盛。', 'Jīntiān de wǎnfàn fēicháng fēngshèng.', 'Bữa cơm tối hôm nay rất phong phú.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [房间] (fángjiān) - căn phòng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '房间',
    'fángjiān',
    'căn phòng',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这是我的房间。',
    'Zhè shì wǒ de fángjiān.',
    'Đây là căn phòng của tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这是我的房间。', 'Zhè shì wǒ de fángjiān.', 'Đây là căn phòng của tôi.', 'basic', 1),
      (v_id, '这个房间很大很干净。', 'Zhè ge fángjiān hěn dà hěn gānjìng.', 'Căn phòng này rất to và sạch sẽ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [非常] (fēicháng) - vô cùng, rất, hết sức [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '非常',
    'fēicháng',
    'vô cùng, rất, hết sức',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这本书非常好看。',
    'Zhè běn shū fēicháng hǎokàn.',
    'Quyển sách này vô cùng hay.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这本书非常好看。', 'Zhè běn shū fēicháng hǎokàn.', 'Quyển sách này vô cùng hay.', 'basic', 1),
      (v_id, '今天天气非常好，我们出去玩吧。', 'Jīntiān tiānqì fēicháng hǎo, wǒmen chūqu wán ba.', 'Hôm nay thời tiết rất đẹp, chúng ta ra ngoài chơi đi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [分] (fēn) - phút; điểm số; xu [Danh từ / Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '分',
    'fēn',
    'phút; điểm số; xu',
    'Danh từ / Lượng từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '现在是八点十分。',
    'Xiànzài shì bā diǎn shí fēn.',
    'Bây giờ là tám giờ mười phút.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '现在是八点十分。', 'Xiànzài shì bā diǎn shí fēn.', 'Bây giờ là tám giờ mười phút.', 'basic', 1),
      (v_id, '请等我五分钟。', 'Qǐng děng wǒ wǔ fēnzhōng.', 'Làm ơn đợi tôi năm phút nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [歌] (gē) - bài hát, ca khúc [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '歌',
    'gē',
    'bài hát, ca khúc',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这首歌真好听。',
    'Zhè shǒu gē zhēn hǎotīng.',
    'Bài hát này thật hay.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这首歌真好听。', 'Zhè shǒu gē zhēn hǎotīng.', 'Bài hát này thật hay.', 'basic', 1),
      (v_id, '你喜欢听什么歌？', 'Nǐ xǐhuan tīng shénme gē?', 'Bạn thích nghe bài hát gì?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [哥哥] (gēge) - anh trai [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '哥哥',
    'gēge',
    'anh trai',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我哥哥是医生。',
    'Wǒ gēge shì yīshēng.',
    'Anh trai tôi là bác sĩ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我哥哥是医生。', 'Wǒ gēge shì yīshēng.', 'Anh trai tôi là bác sĩ.', 'basic', 1),
      (v_id, '哥哥每天开车去上班。', 'Gēge měitiān kāichē qù shàngbān.', 'Anh trai mỗi ngày đều lái xe đi làm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [给] (gěi) - cho, đưa cho; cho ai [Động từ / Giới từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '给',
    'gěi',
    'cho, đưa cho; cho ai',
    'Động từ / Giới từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '请给我一杯水。',
    'Qǐng gěi wǒ yì bēi shuǐ.',
    'Làm ơn cho tôi một cốc nước.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请给我一杯水。', 'Qǐng gěi wǒ yì bēi shuǐ.', 'Làm ơn cho tôi một cốc nước.', 'basic', 1),
      (v_id, '爸爸给我买了一本中文书。', 'Bàba gěi wǒ mǎi le yì běn Zhōngwén shū.', 'Bố mua cho tôi một quyển sách tiếng Trung.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [公司] (gōngsī) - công ty [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '公司',
    'gōngsī',
    'công ty',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他在一家中国公司工作。',
    'Tā zài yì jiā Zhōngguó gōngsī gōngzuò.',
    'Anh ấy làm việc ở một công ty Trung Quốc.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他在一家中国公司工作。', 'Tā zài yì jiā Zhōngguó gōngsī gōngzuò.', 'Anh ấy làm việc ở một công ty Trung Quốc.', 'basic', 1),
      (v_id, '这家公司离我家很近。', 'Zhè jiā gōngsī lí wǒ jiā hěn jìn.', 'Công ty này cách nhà tôi rất gần.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [贵] (guì) - đắt, quý [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '贵',
    'guì',
    'đắt, quý',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这个苹果不贵。',
    'Zhè ge píngguǒ bú guì.',
    'Quả táo này không đắt.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个苹果不贵。', 'Zhè ge píngguǒ bú guì.', 'Quả táo này không đắt.', 'basic', 1),
      (v_id, '那件衣服太贵了，我不买。', 'Nà jiàn yīfu tài guì le, wǒ bù mǎi.', 'Chiếc áo kia đắt quá rồi, tôi không mua đâu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [国] (guó) - nước, quốc gia [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '国',
    'guó',
    'nước, quốc gia',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你是哪国人？',
    'Nǐ shì nǎ guó rén?',
    'Bạn là người nước nào?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你是哪国人？', 'Nǐ shì nǎ guó rén?', 'Bạn là người nước nào?', 'basic', 1),
      (v_id, '中国是一个美丽的国家。', 'Zhōngguó shì yí gè měilì de guójiā.', 'Trung Quốc là một quốc gia tươi đẹp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [还] (hái) - vẫn, còn [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '还',
    'hái',
    'vẫn, còn',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他还在睡觉。',
    'Tā hái zài shuìjiào.',
    'Anh ấy vẫn đang ngủ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他还在睡觉。', 'Tā hái zài shuìjiào.', 'Anh ấy vẫn đang ngủ.', 'basic', 1),
      (v_id, '你还要买别的吗？', 'Nǐ hái yào mǎi biéde ma?', 'Bạn còn muốn mua thứ gì khác không?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [孩子] (háizi) - con cái, đứa trẻ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '孩子',
    'háizi',
    'con cái, đứa trẻ',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这个孩子很聪明。',
    'Zhè ge háizi hěn cōngmíng.',
    'Đứa trẻ này rất thông minh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个孩子很聪明。', 'Zhè ge háizi hěn cōngmíng.', 'Đứa trẻ này rất thông minh.', 'basic', 1),
      (v_id, '孩子们在公园里高兴地玩。', 'Háizimen zài gōngyuán lǐ gāoxìng de wán.', 'Lũ trẻ vui vẻ chơi đùa trong công viên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [汉字] (hànzì) - chữ Hán [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '汉字',
    'hànzì',
    'chữ Hán',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '学汉字很有意思。',
    'Xué hànzì hěn yǒu yìsi.',
    'Học chữ Hán rất thú vị.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '学汉字很有意思。', 'Xué hànzì hěn yǒu yìsi.', 'Học chữ Hán rất thú vị.', 'basic', 1),
      (v_id, '我会写三百个汉字。', 'Wǒ huì xiě sān bǎi gè hànzì.', 'Tôi biết viết ba trăm chữ Hán.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [好吃] (hǎochī) - ngon, ngon miệng [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '好吃',
    'hǎochī',
    'ngon, ngon miệng',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '妈妈做的菜很好吃。',
    'Māma zuò de cài hěn hǎochī.',
    'Món mẹ nấu rất ngon.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '妈妈做的菜很好吃。', 'Māma zuò de cài hěn hǎochī.', 'Món mẹ nấu rất ngon.', 'basic', 1),
      (v_id, '这个包子真好吃，你想尝尝吗？', 'Zhè ge bāozi zhēn hǎochī, nǐ xiǎng chángchang ma?', 'Cái bánh bao này ngon thật, bạn muốn nếm thử không?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [好看] (hǎokàn) - đẹp, hay (sách, phim) [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '好看',
    'hǎokàn',
    'đẹp, hay (sách, phim)',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这件衣服真好看。',
    'Zhè jiàn yīfu zhēn hǎokàn.',
    'Chiếc áo này thật là đẹp.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这件衣服真好看。', 'Zhè jiàn yīfu zhēn hǎokàn.', 'Chiếc áo này thật là đẹp.', 'basic', 1),
      (v_id, '那部电影非常好看。', 'Nà bù diànyǐng fēicháng hǎokàn.', 'Bộ phim kia vô cùng hay.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [好听] (hǎotīng) - hay, êm tai (nhạc, giọng nói) [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '好听',
    'hǎotīng',
    'hay, êm tai (nhạc, giọng nói)',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这首歌很好听。',
    'Zhè shǒu gē hěn hǎotīng.',
    'Bài hát này rất hay.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这首歌很好听。', 'Zhè shǒu gē hěn hǎotīng.', 'Bài hát này rất hay.', 'basic', 1),
      (v_id, '老师的声音真好听。', 'Lǎoshī de shēngyīn zhēn hǎotīng.', 'Giọng nói của cô giáo thật là êm tai.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [好玩儿] (hǎowánr) - vui, vui nhộn, thú vị [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '好玩儿',
    'hǎowánr',
    'vui, vui nhộn, thú vị',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这个游戏很好玩儿。',
    'Zhè ge yóuxì hěn hǎowánr.',
    'Trò chơi này rất vui.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个游戏很好玩儿。', 'Zhè ge yóuxì hěn hǎowánr.', 'Trò chơi này rất vui.', 'basic', 1),
      (v_id, '北京有很多好玩儿的地方。', 'Běijīng yǒu hěn duō hǎowánr de dìfang.', 'Bắc Kinh có rất nhiều địa điểm thú vị để vui chơi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [后] (hòu) - sau, phía sau, sau khi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '后',
    'hòu',
    'sau, phía sau, sau khi',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '两天后见。',
    'Liǎng tiān hòu jiàn.',
    'Hẹn gặp lại sau hai ngày nữa.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '两天后见。', 'Liǎng tiān hòu jiàn.', 'Hẹn gặp lại sau hai ngày nữa.', 'basic', 1),
      (v_id, '下课后我想去书店。', 'Xiàkè hòu wǒ xiǎng qù shūdiàn.', 'Sau khi tan học tôi muốn đến hiệu sách.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [火车] (huǒchē) - tàu hỏa, xe lửa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '火车',
    'huǒchē',
    'tàu hỏa, xe lửa',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们坐火车去北京。',
    'Wǒmen zuò huǒchē qù Běijīng.',
    'Chúng tôi ngồi tàu hỏa đi Bắc Kinh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们坐火车去北京。', 'Wǒmen zuò huǒchē qù Běijīng.', 'Chúng tôi ngồi tàu hỏa đi Bắc Kinh.', 'basic', 1),
      (v_id, '火车站离这里有多远？', 'Huǒchēzhàn lí zhèlǐ yǒu duō yuǎn?', 'Ga tàu hỏa cách đây bao xa?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [鸡蛋] (jīdàn) - trứng gà [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '鸡蛋',
    'jīdàn',
    'trứng gà',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '早上我吃了一个鸡蛋。',
    'Zǎoshang wǒ chī le yí gè jīdàn.',
    'Buổi sáng tôi đã ăn một quả trứng gà.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '早上我吃了一个鸡蛋。', 'Zǎoshang wǒ chī le yí gè jīdàn.', 'Buổi sáng tôi đã ăn một quả trứng gà.', 'basic', 1),
      (v_id, '妈妈买了很多新鲜的鸡蛋。', 'Māma mǎi le hěn duō xīnxiān de jīdàn.', 'Mẹ đã mua rất nhiều trứng gà tươi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [家人] (jiārén) - người nhà, người thân trong gia đình [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '家人',
    'jiārén',
    'người nhà, người thân trong gia đình',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我爱我的家人。',
    'Wǒ ài wǒ de jiārén.',
    'Tôi yêu người thân trong gia đình tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我爱我的家人。', 'Wǒ ài wǒ de jiārén.', 'Tôi yêu người thân trong gia đình tôi.', 'basic', 1),
      (v_id, '周末我和家人一起吃饭。', 'Zhōumò wǒ hé jiārén yìqǐ chīfàn.', 'Cuối tuần tôi ăn cơm cùng với người nhà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [见] (jiàn) - gặp, thấy [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '见',
    'jiàn',
    'gặp, thấy',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '明天见！',
    'Míngtiān jiàn!',
    'Ngày mai gặp nhé!'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '明天见！', 'Míngtiān jiàn!', 'Ngày mai gặp nhé!', 'basic', 1),
      (v_id, '很高兴见到你。', 'Hěn gāoxìng jiàndào nǐ.', 'Rất vui được gặp bạn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [件] (jiàn) - chiếc, cái (áo, sự việc) [Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '件',
    'jiàn',
    'chiếc, cái (áo, sự việc)',
    'Lượng từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我想买一件衣服。',
    'Wǒ xiǎng mǎi yí jiàn yīfu.',
    'Tôi muốn mua một chiếc áo.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我想买一件衣服。', 'Wǒ xiǎng mǎi yí jiàn yīfu.', 'Tôi muốn mua một chiếc áo.', 'basic', 1),
      (v_id, '这件事情很重要。', 'Zhè jiàn shìqing hěn zhòngyào.', 'Sự việc này rất quan trọng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [饺子] (jiǎozi) - sủi cảo, bánh chẻo [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '饺子',
    'jiǎozi',
    'sủi cảo, bánh chẻo',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '中国人喜欢吃饺子。',
    'Zhōngguórén xǐhuan chī jiǎozi.',
    'Người Trung Quốc thích ăn sủi cảo.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '中国人喜欢吃饺子。', 'Zhōngguórén xǐhuan chī jiǎozi.', 'Người Trung Quốc thích ăn sủi cảo.', 'basic', 1),
      (v_id, '妈妈今天包了牛肉饺子。', 'Māma jīntiān bāo le niúròu jiǎozi.', 'Hôm nay mẹ gói sủi cảo thịt bò.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [姐姐] (jiějie) - chị gái [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '姐姐',
    'jiějie',
    'chị gái',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我姐姐二十岁。',
    'Wǒ jiějie èrshí suì.',
    'Chị gái tôi hai mươi tuổi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我姐姐二十岁。', 'Wǒ jiějie èrshí suì.', 'Chị gái tôi hai mươi tuổi.', 'basic', 1),
      (v_id, '姐姐在北京的一家医院当护士。', 'Jiějie zài Běijīng de yì jiā yīyuàn dāng hùshi.', 'Chị gái làm y tá ở một bệnh viện tại Bắc Kinh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [今年] (jīnnián) - năm nay [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '今年',
    'jīnnián',
    'năm nay',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我今年学中文。',
    'Wǒ jīnnián xué Zhōngwén.',
    'Năm nay tôi học tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我今年学中文。', 'Wǒ jīnnián xué Zhōngwén.', 'Năm nay tôi học tiếng Trung.', 'basic', 1),
      (v_id, '今年夏天北京天气比较热。', 'Jīnnián xiàtiān Běijīng tiānqì bǐjiào rè.', 'Mùa hè năm nay thời tiết Bắc Kinh khá nóng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [觉得] (juéde) - cảm thấy, thấy rằng [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '觉得',
    'juéde',
    'cảm thấy, thấy rằng',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我觉得今天很冷。',
    'Wǒ juéde jīntiān hěn lěng.',
    'Tôi thấy hôm nay rất lạnh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我觉得今天很冷。', 'Wǒ juéde jīntiān hěn lěng.', 'Tôi thấy hôm nay rất lạnh.', 'basic', 1),
      (v_id, '你觉得这个菜怎么样？', 'Nǐ juéde zhè ge cài zěnmeyàng?', 'Bạn thấy món ăn này thế nào?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [开车] (kāichē) - lái xe [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '开车',
    'kāichē',
    'lái xe',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '爸爸每天开车去上班。',
    'Bàba měitiān kāichē qù shàngbān.',
    'Bố mỗi ngày đều lái xe đi làm.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '爸爸每天开车去上班。', 'Bàba měitiān kāichē qù shàngbān.', 'Bố mỗi ngày đều lái xe đi làm.', 'basic', 1),
      (v_id, '你会开车吗？', 'Nǐ huì kāichē ma?', 'Bạn biết lái xe không?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [看病] (kànbìng) - khám bệnh, đi khám [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '看病',
    'kànbìng',
    'khám bệnh, đi khám',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他生病了，要去医院看病。',
    'Tā shēngbìng le, yào qù yīyuàn kànbìng.',
    'Anh ấy bị ốm rồi, phải đến bệnh viện khám bệnh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他生病了，要去医院看病。', 'Tā shēngbìng le, yào qù yīyuàn kànbìng.', 'Anh ấy bị ốm rồi, phải đến bệnh viện khám bệnh.', 'basic', 1),
      (v_id, '医生正在给病人看病。', 'Yīshēng zhèngzài gěi bìngrén kànbìng.', 'Bác sĩ đang khám bệnh cho bệnh nhân.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [可以] (kěyǐ) - có thể, được [Động từ năng nguyện]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '可以',
    'kěyǐ',
    'có thể, được',
    'Động từ năng nguyện',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我可以坐在这里吗？',
    'Wǒ kěyǐ zuò zài zhèlǐ ma?',
    'Tôi có thể ngồi ở đây không?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我可以坐在这里吗？', 'Wǒ kěyǐ zuò zài zhèlǐ ma?', 'Tôi có thể ngồi ở đây không?', 'basic', 1),
      (v_id, '你现在可以走了。', 'Nǐ xiànzài kěyǐ zǒu le.', 'Bây giờ bạn có thể đi rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [课] (kè) - tiết học, bài học, môn học [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '课',
    'kè',
    'tiết học, bài học, môn học',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天我们有三节课。',
    'Jīntiān wǒmen yǒu sān jié kè.',
    'Hôm nay chúng tôi có ba tiết học.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天我们有三节课。', 'Jīntiān wǒmen yǒu sān jié kè.', 'Hôm nay chúng tôi có ba tiết học.', 'basic', 1),
      (v_id, '中文课很有意思。', 'Zhōngwén kè hěn yǒu yìsi.', 'Giờ học tiếng Trung rất thú vị.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [口] (kǒu) - người (lượng từ gia đình); miệng [Lượng từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '口',
    'kǒu',
    'người (lượng từ gia đình); miệng',
    'Lượng từ / Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我家有四口人。',
    'Wǒ jiā yǒu sì kǒu rén.',
    'Gia đình tôi có bốn người.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我家有四口人。', 'Wǒ jiā yǒu sì kǒu rén.', 'Gia đình tôi có bốn người.', 'basic', 1),
      (v_id, '他喝了一口水。', 'Tā hē le yì kǒu shuǐ.', 'Anh ấy uống một ngụm nước.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [两] (liǎng) - hai, đôi [Số từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '两',
    'liǎng',
    'hai, đôi',
    'Số từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我有两个朋友。',
    'Wǒ yǒu liǎng gè péngyou.',
    'Tôi có hai người bạn.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我有两个朋友。', 'Wǒ yǒu liǎng gè péngyou.', 'Tôi có hai người bạn.', 'basic', 1),
      (v_id, '我想买两本书。', 'Wǒ xiǎng mǎi liǎng běn shū.', 'Tôi muốn mua hai quyển sách.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [零] (líng) - số không (0) [Số từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '零',
    'líng',
    'số không (0)',
    'Số từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '现在温度是零度。',
    'Xiànzài wēndù shì líng dù.',
    'Bây giờ nhiệt độ là không độ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '现在温度是零度。', 'Xiànzài wēndù shì líng dù.', 'Bây giờ nhiệt độ là không độ.', 'basic', 1),
      (v_id, '我的房间号是一零八。', 'Wǒ de fángjiān hào shì yī líng bā.', 'Số phòng của tôi là 108.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [卖] (mài) - bán [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '卖',
    'mài',
    'bán',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '超市卖很多水果。',
    'Chāoshì mài hěn duō shuǐguǒ.',
    'Siêu thị bán rất nhiều hoa quả.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '超市卖很多水果。', 'Chāoshì mài hěn duō shuǐguǒ.', 'Siêu thị bán rất nhiều hoa quả.', 'basic', 1),
      (v_id, '这个苹果怎么卖？', 'Zhè ge píngguǒ zěnme mài?', 'Táo này bán thế nào vậy?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [忙] (máng) - bận, bận rộn [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '忙',
    'máng',
    'bận, bận rộn',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我今天很忙。',
    'Wǒ jīntiān hěn máng.',
    'Hôm nay tôi rất bận.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我今天很忙。', 'Wǒ jīntiān hěn máng.', 'Hôm nay tôi rất bận.', 'basic', 1),
      (v_id, '你在忙什么呢？', 'Nǐ zài máng shénme ne?', 'Bạn đang bận việc gì thế?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [没事] (méi shì) - không có gì, không sao [Cụm từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '没事',
    'méi shì',
    'không có gì, không sao',
    'Cụm từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '对不起！——没事。',
    'Duìbuqǐ! —— Méi shì.',
    'Xin lỗi! —— Không sao đâu.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '对不起！——没事。', 'Duìbuqǐ! —— Méi shì.', 'Xin lỗi! —— Không sao đâu.', 'basic', 1),
      (v_id, '你生病了吗？——没事，我已经好了。', 'Nǐ shēngbìng le ma? —— Méi shì, wǒ yǐjīng hǎo le.', 'Bạn ốm à? —— Không sao, tôi đã khỏi rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [妹妹] (mèimei) - em gái [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '妹妹',
    'mèimei',
    'em gái',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我妹妹很可爱。',
    'Wǒ mèimei hěn kě’ài.',
    'Em gái tôi rất đáng yêu.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我妹妹很可爱。', 'Wǒ mèimei hěn kě’ài.', 'Em gái tôi rất đáng yêu.', 'basic', 1),
      (v_id, '妹妹今年上小学一年级。', 'Mèimei jīnnián shàng xiǎoxué yī niánjí.', 'Năm nay em gái vào học lớp một tiểu học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [们] (men) - các, chúng (hậu tố số nhiều: 我们, 你们, 学生们) [Hậu tố]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '们',
    'men',
    'các, chúng (hậu tố số nhiều: 我们, 你们, 学生们)',
    'Hậu tố',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们都是学生。',
    'Wǒmen dōu shì xuésheng.',
    'Chúng tôi đều là học sinh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们都是学生。', 'Wǒmen dōu shì xuésheng.', 'Chúng tôi đều là học sinh.', 'basic', 1),
      (v_id, '朋友们今天都来了。', 'Péngyoumen jīntiān dōu lái le.', 'Các bạn bè hôm nay đều đã đến.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [面包] (miànbāo) - bánh mì [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '面包',
    'miànbāo',
    'bánh mì',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '早饭我吃面包。',
    'Zǎofàn wǒ chī miànbāo.',
    'Bữa sáng tôi ăn bánh mì.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '早饭我吃面包。', 'Zǎofàn wǒ chī miànbāo.', 'Bữa sáng tôi ăn bánh mì.', 'basic', 1),
      (v_id, '这家店的面包又香又好吃。', 'Zhè jiā diàn de miànbāo yòu xiāng yòu hǎochī.', 'Bánh mì của quán này vừa thơm vừa ngon.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [面条儿] (miàntiáor) - mì, mì sợi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '面条儿',
    'miàntiáor',
    'mì, mì sợi',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '中午我想吃面条儿。',
    'Zhōngwǔ wǒ xiǎng chī miàntiáor.',
    'Buổi trưa tôi muốn ăn mì sợi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '中午我想吃面条儿。', 'Zhōngwǔ wǒ xiǎng chī miàntiáor.', 'Buổi trưa tôi muốn ăn mì sợi.', 'basic', 1),
      (v_id, '妈妈做的牛肉面条儿最好吃。', 'Māma zuò de niúròu miàntiáor zuì hǎochī.', 'Món mì bò do mẹ nấu là ngon nhất.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [明年] (míngnián) - năm sau, năm tới [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '明年',
    'míngnián',
    'năm sau, năm tới',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我明年去中国。',
    'Wǒ míngnián qù Zhōngguó.',
    'Năm sau tôi đi Trung Quốc.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我明年去中国。', 'Wǒ míngnián qù Zhōngguó.', 'Năm sau tôi đi Trung Quốc.', 'basic', 1),
      (v_id, '哥哥明年大学毕业。', 'Gēge míngnián dàxué bìyè.', 'Năm sau anh trai tốt nghiệp đại học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [哪个] (nǎ ge) - cái nào, người nào [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '哪个',
    'nǎ ge',
    'cái nào, người nào',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '哪个杯子是你的？',
    'Nǎ ge bēizi shì nǐ de?',
    'Chiếc cốc nào là của bạn?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '哪个杯子是你的？', 'Nǎ ge bēizi shì nǐ de?', 'Chiếc cốc nào là của bạn?', 'basic', 1),
      (v_id, '你想买哪本书？', 'Nǐ xiǎng mǎi nǎ běn shū?', 'Bạn muốn mua quyển sách nào?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [哪里] (nǎlǐ) - ở đâu, đâu [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '哪里',
    'nǎlǐ',
    'ở đâu, đâu',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你去哪里？',
    'Nǐ qù nǎlǐ?',
    'Bạn đi đâu thế?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你去哪里？', 'Nǐ qù nǎlǐ?', 'Bạn đi đâu thế?', 'basic', 1),
      (v_id, '你的家在哪里？', 'Nǐ de jiā zài nǎlǐ?', 'Nhà của bạn ở đâu?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [哪些] (nǎxiē) - những cái nào, những ai [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '哪些',
    'nǎxiē',
    'những cái nào, những ai',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你想买哪些书？',
    'Nǐ xiǎng mǎi nǎxiē shū?',
    'Bạn muốn mua những quyển sách nào?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你想买哪些书？', 'Nǐ xiǎng mǎi nǎxiē shū?', 'Bạn muốn mua những quyển sách nào?', 'basic', 1),
      (v_id, '哪些人明天去北京？', 'Nǎxiē rén míngtiān qù Běijīng?', 'Những ai ngày mai sẽ đi Bắc Kinh?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [那边] (nàbian) - bên kia, phía bên đó [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '那边',
    'nàbian',
    'bên kia, phía bên đó',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '超市在那边。',
    'Chāoshì zài nàbian.',
    'Siêu thị ở phía bên kia.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '超市在那边。', 'Chāoshì zài nàbian.', 'Siêu thị ở phía bên kia.', 'basic', 1),
      (v_id, '我们去那边坐坐吧。', 'Wǒmen qù nàbian zuòzuo ba.', 'Chúng ta sang bên kia ngồi một lát đi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [那个] (nà ge) - cái đó, người đó [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '那个',
    'nà ge',
    'cái đó, người đó',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '那个包很漂亮。',
    'Nà ge bāo hěn piàoliang.',
    'Chiếc túi đó rất đẹp.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '那个包很漂亮。', 'Nà ge bāo hěn piàoliang.', 'Chiếc túi đó rất đẹp.', 'basic', 1),
      (v_id, '那个人是我的老师。', 'Nà ge rén shì wǒ de lǎoshī.', 'Người đó là giáo viên của tôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [那里] (nàlǐ) - ở đó, đằng kia [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '那里',
    'nàlǐ',
    'ở đó, đằng kia',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我的书在那里。',
    'Wǒ de shū zài nàlǐ.',
    'Sách của tôi ở đằng kia.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我的书在那里。', 'Wǒ de shū zài nàlǐ.', 'Sách của tôi ở đằng kia.', 'basic', 1),
      (v_id, '那里有很多中国学生。', 'Nàlǐ yǒu hěn duō Zhōngguó xuésheng.', 'Ở đó có rất nhiều du học sinh Trung Quốc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [那儿] (nàr) - chỗ đó, nơi đó [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '那儿',
    'nàr',
    'chỗ đó, nơi đó',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他在那儿等你。',
    'Tā zài nàr děng nǐ.',
    'Anh ấy đang đợi bạn ở chỗ đó.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他在那儿等你。', 'Tā zài nàr děng nǐ.', 'Anh ấy đang đợi bạn ở chỗ đó.', 'basic', 1),
      (v_id, '那儿的天气很舒服。', 'Nàr de tiānqì hěn shūfu.', 'Thời tiết ở nơi đó rất dễ chịu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [那些] (nàxiē) - những cái đó, những người đó [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '那些',
    'nàxiē',
    'những cái đó, những người đó',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '那些苹果很甜。',
    'Nàxiē píngguǒ hěn tián.',
    'Những quả táo đó rất ngọt.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '那些苹果很甜。', 'Nàxiē píngguǒ hěn tián.', 'Những quả táo đó rất ngọt.', 'basic', 1),
      (v_id, '那些书都是我的。', 'Nàxiē shū dōu shì wǒ de.', 'Những cuốn sách đó đều là của tôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [男] (nán) - nam, phái nam [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '男',
    'nán',
    'nam, phái nam',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们班有八个男同学。',
    'Wǒmen bān yǒu bā gè nán tóngxué.',
    'Lớp chúng tôi có tám bạn học nam.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们班有八个男同学。', 'Wǒmen bān yǒu bā gè nán tóngxué.', 'Lớp chúng tôi có tám bạn học nam.', 'basic', 1),
      (v_id, '那个穿白衣服的男人是谁？', 'Nà ge chuān bái yīfu de nánrén shì shéi?', 'Người đàn ông mặc áo trắng đó là ai vậy?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [男朋友] (nánpéngyou) - bạn trai [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '男朋友',
    'nánpéngyou',
    'bạn trai',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这是我的男朋友。',
    'Zhè shì wǒ de nánpéngyou.',
    'Đây là bạn trai của tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这是我的男朋友。', 'Zhè shì wǒ de nánpéngyou.', 'Đây là bạn trai của tôi.', 'basic', 1),
      (v_id, '她男朋友在中国工作。', 'Tā nánpéngyou zài Zhōngguó gōngzuò.', 'Bạn trai cô ấy làm việc ở Trung Quốc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [你好] (nǐ hǎo) - xin chào [Cụm từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '你好',
    'nǐ hǎo',
    'xin chào',
    'Cụm từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你好！很高兴认识你。',
    'Nǐ hǎo! Hěn gāoxìng rènshi nǐ.',
    'Xin chào! Rất vui được quen biết bạn.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你好！很高兴认识你。', 'Nǐ hǎo! Hěn gāoxìng rènshi nǐ.', 'Xin chào! Rất vui được quen biết bạn.', 'basic', 1),
      (v_id, '老师，您好！', 'Lǎoshī, nín hǎo!', 'Em chào thầy/cô ạ!', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [你们] (nǐmen) - các bạn, các anh/chị [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '你们',
    'nǐmen',
    'các bạn, các anh/chị',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你们想喝什么？',
    'Nǐmen xiǎng hē shénme?',
    'Các bạn muốn uống gì?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你们想喝什么？', 'Nǐmen xiǎng hē shénme?', 'Các bạn muốn uống gì?', 'basic', 1),
      (v_id, '明天你们几点去学校？', 'Míngtiān nǐmen jǐ diǎn qù xuéxiào?', 'Ngày mai mấy giờ các bạn đến trường?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [您] (nín) - ngài, ông, bà (đại từ tôn kính) [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '您',
    'nín',
    'ngài, ông, bà (đại từ tôn kính)',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '老师，您好！',
    'Lǎoshī, nín hǎo!',
    'Kính chào thầy cô ạ!'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '老师，您好！', 'Lǎoshī, nín hǎo!', 'Kính chào thầy cô ạ!', 'basic', 1),
      (v_id, '请问您需要什么？', 'Qǐngwèn nín xūyào shénme?', 'Xin hỏi ngài cần gì ạ?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [牛奶] (niúnǎi) - sữa bò, sữa tươi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '牛奶',
    'niúnǎi',
    'sữa bò, sữa tươi',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '早上我喝了一杯牛奶。',
    'Zǎoshang wǒ hē le yì bēi niúnǎi.',
    'Buổi sáng tôi đã uống một cốc sữa tươi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '早上我喝了一杯牛奶。', 'Zǎoshang wǒ hē le yì bēi niúnǎi.', 'Buổi sáng tôi đã uống một cốc sữa tươi.', 'basic', 1),
      (v_id, '这个牛奶很新鲜。', 'Zhè ge niúnǎi hěn xīnxiān.', 'Hộp sữa này rất tươi ngon.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [女] (nǚ) - nữ, phái nữ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '女',
    'nǚ',
    'nữ, phái nữ',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们班有很多女同学。',
    'Wǒmen bān yǒu hěn duō nǚ tóngxué.',
    'Lớp chúng tôi có rất nhiều bạn học nữ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们班有很多女同学。', 'Wǒmen bān yǒu hěn duō nǚ tóngxué.', 'Lớp chúng tôi có rất nhiều bạn học nữ.', 'basic', 1),
      (v_id, '那个女孩长得很漂亮。', 'Nà ge nǚhái zhǎng de hěn piàoliang.', 'Cô bé đó trông rất xinh xắn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [女朋友] (nǚpéngyou) - bạn gái [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '女朋友',
    'nǚpéngyou',
    'bạn gái',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这是我的女朋友。',
    'Zhè shì wǒ de nǚpéngyou.',
    'Đây là bạn gái của tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这是我的女朋友。', 'Zhè shì wǒ de nǚpéngyou.', 'Đây là bạn gái của tôi.', 'basic', 1),
      (v_id, '哥哥和他的女朋友一起去旅游。', 'Gēge hé tā de nǚpéngyou yìqǐ qù lǚyóu.', 'Anh trai cùng bạn gái đi du lịch.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [女士] (nǚshì) - quý bà, quý cô, phụ nữ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '女士',
    'nǚshì',
    'quý bà, quý cô, phụ nữ',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '王女士是一位老师。',
    'Wáng nǚshì shì yí wèi lǎoshī.',
    'Cô Vương là một giáo viên.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '王女士是一位老师。', 'Wáng nǚshì shì yí wèi lǎoshī.', 'Cô Vương là một giáo viên.', 'basic', 1),
      (v_id, '女士们、先生们，大家晚上好！', 'Nǚshìmen, xiānshengmen, dàjiā wǎnshang hǎo!', 'Kính thưa quý bà, quý ông, chúc mọi người một buổi tối tốt lành!', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [便宜] (piányi) - rẻ, giá rẻ [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '便宜',
    'piányi',
    'rẻ, giá rẻ',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这件衣服很便宜。',
    'Zhè jiàn yīfu hěn piányi.',
    'Chiếc áo này rất rẻ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这件衣服很便宜。', 'Zhè jiàn yīfu hěn piányi.', 'Chiếc áo này rất rẻ.', 'basic', 1),
      (v_id, '超市里的水果比外面便宜。', 'Chāoshì lǐ de shuǐguǒ bǐ wàimiàn piányi.', 'Hoa quả trong siêu thị rẻ hơn bên ngoài.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [起床] (qǐchuáng) - thức dậy, ngủ dậy [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '起床',
    'qǐchuáng',
    'thức dậy, ngủ dậy',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我早上六点起床。',
    'Wǒ zǎoshang liù diǎn qǐchuáng.',
    'Buổi sáng tôi thức dậy lúc sáu giờ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我早上六点起床。', 'Wǒ zǎoshang liù diǎn qǐchuáng.', 'Buổi sáng tôi thức dậy lúc sáu giờ.', 'basic', 1),
      (v_id, '明天我们要早起，别睡太晚。', 'Míngtiān wǒmen yào zǎoqǐ, bié shuì tài wǎn.', 'Ngày mai chúng ta phải dậy sớm, đừng ngủ muộn quá.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [千] (qiān) - nghìn, ngàn (1000) [Số từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '千',
    'qiān',
    'nghìn, ngàn (1000)',
    'Số từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这台电脑三千块。',
    'Zhè tái diànnǎo sān qiān kuài.',
    'Chiếc máy tính này ba nghìn tệ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这台电脑三千块。', 'Zhè tái diànnǎo sān qiān kuài.', 'Chiếc máy tính này ba nghìn tệ.', 'basic', 1),
      (v_id, '学校里有一千多个学生。', 'Xuéxiào lǐ yǒu yì qiān duō gè xuésheng.', 'Trong trường có hơn một nghìn học sinh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [前] (qián) - trước, phía trước, trước khi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '前',
    'qián',
    'trước, phía trước, trước khi',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '学校在前面。',
    'Xuéxiào zài qiánmian.',
    'Trường học ở phía trước.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '学校在前面。', 'Xuéxiào zài qiánmian.', 'Trường học ở phía trước.', 'basic', 1),
      (v_id, '三天前我买了一本书。', 'Sān tiān qián wǒ mǎi le yì běn shū.', 'Ba ngày trước tôi đã mua một quyển sách.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [请问] (qǐngwèn) - xin hỏi, làm ơn cho hỏi [Cụm từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '请问',
    'qǐngwèn',
    'xin hỏi, làm ơn cho hỏi',
    'Cụm từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '请问，图书馆在哪里？',
    'Qǐngwèn, túshūguǎn zài nǎlǐ?',
    'Xin hỏi, thư viện ở đâu ạ?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请问，图书馆在哪里？', 'Qǐngwèn, túshūguǎn zài nǎlǐ?', 'Xin hỏi, thư viện ở đâu ạ?', 'basic', 1),
      (v_id, '请问，现在几点了？', 'Qǐngwèn, xiànzài jǐ diǎn le?', 'Xin hỏi, bây giờ là mấy giờ rồi ạ?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [去年] (qùnián) - năm ngoái [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '去年',
    'qùnián',
    'năm ngoái',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我去年去了北京。',
    'Wǒ qùnián qù le Běijīng.',
    'Năm ngoái tôi đã đi Bắc Kinh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我去年去了北京。', 'Wǒ qùnián qù le Běijīng.', 'Năm ngoái tôi đã đi Bắc Kinh.', 'basic', 1),
      (v_id, '去年我开始学中文。', 'Qùnián wǒ kāishǐ xué Zhōngwén.', 'Năm ngoái tôi bắt đầu học tiếng Trung.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [日] (rì) - ngày, mặt trời [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '日',
    'rì',
    'ngày, mặt trời',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天是十月一日。',
    'Jīntiān shì shí yuè yī rì.',
    'Hôm nay là ngày 1 tháng 10.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天是十月一日。', 'Jīntiān shì shí yuè yī rì.', 'Hôm nay là ngày 1 tháng 10.', 'basic', 1),
      (v_id, '我的生日是五月五日。', 'Wǒ de shēngrì shì wǔ yuè wǔ rì.', 'Sinh nhật của tôi là ngày 5 tháng 5.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [上班] (shàngbān) - đi làm [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '上班',
    'shàngbān',
    'đi làm',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '爸爸早上八点去上班。',
    'Bàba zǎoshang bā diǎn qù shàngbān.',
    'Bố tám giờ sáng đi làm.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '爸爸早上八点去上班。', 'Bàba zǎoshang bā diǎn qù shàngbān.', 'Bố tám giờ sáng đi làm.', 'basic', 1),
      (v_id, '今天星期天，我不上班。', 'Jīntiān xīngqītiān, wǒ bú shàngbān.', 'Hôm nay chủ nhật, tôi không phải đi làm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [上课] (shàngkè) - vào học, lên lớp [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '上课',
    'shàngkè',
    'vào học, lên lớp',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们八点开始上课。',
    'Wǒmen bā diǎn kāishǐ shàngkè.',
    'Chúng tôi tám giờ bắt đầu vào học.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们八点开始上课。', 'Wǒmen bā diǎn kāishǐ shàngkè.', 'Chúng tôi tám giờ bắt đầu vào học.', 'basic', 1),
      (v_id, '老师正在给学生们上课。', 'Lǎoshī zhèngzài gěi xuéshengmen shàngkè.', 'Thầy giáo đang giảng bài lên lớp cho học sinh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [上学] (shàngxué) - đi học [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '上学',
    'shàngxué',
    'đi học',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '妹妹每天早上走路上学。',
    'Mèimei měitiān zǎoshang zǒulù shàngxué.',
    'Mỗi buổi sáng em gái đều đi bộ đi học.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '妹妹每天早上走路上学。', 'Mèimei měitiān zǎoshang zǒulù shàngxué.', 'Mỗi buổi sáng em gái đều đi bộ đi học.', 'basic', 1),
      (v_id, '他八岁开始上学。', 'Tā bā suì kāishǐ shàngxué.', 'Cậu ấy tám tuổi bắt đầu đi học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [生病] (shēngbìng) - bị ốm, đổ bệnh [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '生病',
    'shēngbìng',
    'bị ốm, đổ bệnh',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他生病了，不能来学校。',
    'Tā shēngbìng le, bù néng lái xuéxiào.',
    'Cậu ấy bị ốm rồi, không thể đến trường.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他生病了，不能来学校。', 'Tā shēngbìng le, bù néng lái xuéxiào.', 'Cậu ấy bị ốm rồi, không thể đến trường.', 'basic', 1),
      (v_id, '天冷了，你要注意身体，别生病。', 'Tiān lěng le, nǐ yào zhùyì shēntǐ, bié shēngbìng.', 'Trời lạnh rồi, bạn nhớ chú ý sức khỏe, đừng để bị ốm nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [时间] (shíjiān) - thời gian [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '时间',
    'shíjiān',
    'thời gian',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你今天有时间吗？',
    'Nǐ jīntiān yǒu shíjiān ma?',
    'Hôm nay bạn có thời gian không?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你今天有时间吗？', 'Nǐ jīntiān yǒu shíjiān ma?', 'Hôm nay bạn có thời gian không?', 'basic', 1),
      (v_id, '时间过得真快！', 'Shíjiān guò de zhēn kuài!', 'Thời gian trôi qua thật nhanh!', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [事] (shì) - việc, chuyện, sự việc [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '事',
    'shì',
    'việc, chuyện, sự việc',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你找我有什么事？',
    'Nǐ zhǎo wǒ yǒu shénme shì?',
    'Bạn tìm tôi có việc gì thế?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你找我有什么事？', 'Nǐ zhǎo wǒ yǒu shénme shì?', 'Bạn tìm tôi có việc gì thế?', 'basic', 1),
      (v_id, '这件事情明天再说吧。', 'Zhè jiàn shìqing míngtiān zài shuō ba.', 'Chuyện này ngày mai hãy nói tiếp nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [手机] (shǒujī) - điện thoại di động [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '手机',
    'shǒujī',
    'điện thoại di động',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这是我的新手机。',
    'Zhè shì wǒ de xīn shǒujī.',
    'Đây là chiếc điện thoại di động mới của tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这是我的新手机。', 'Zhè shì wǒ de xīn shǒujī.', 'Đây là chiếc điện thoại di động mới của tôi.', 'basic', 1),
      (v_id, '他在用手机看中文新闻。', 'Tā zài yòng shǒujī kàn Zhōngwén xīnwén.', 'Anh ấy đang dùng điện thoại xem tin tức tiếng Trung.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [书店] (shūdiàn) - hiệu sách, nhà sách [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '书店',
    'shūdiàn',
    'hiệu sách, nhà sách',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我想去书店买书。',
    'Wǒ xiǎng qù shūdiàn mǎi shū.',
    'Tôi muốn đến hiệu sách mua sách.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我想去书店买书。', 'Wǒ xiǎng qù shūdiàn mǎi shū.', 'Tôi muốn đến hiệu sách mua sách.', 'basic', 1),
      (v_id, '学校旁边有一家很大的书店。', 'Xuéxiào pángbiān yǒu yì jiā hěn dà de shūdiàn.', 'Bên cạnh trường học có một hiệu sách rất to.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [睡] (shuì) - ngủ [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '睡',
    'shuì',
    'ngủ',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '快去睡吧，很晚了。',
    'Kuài qù shuì ba, hěn wǎn le.',
    'Mau đi ngủ đi, muộn lắm rồi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '快去睡吧，很晚了。', 'Kuài qù shuì ba, hěn wǎn le.', 'Mau đi ngủ đi, muộn lắm rồi.', 'basic', 1),
      (v_id, '他每天晚上十点睡。', 'Tā měitiān wǎnshang shí diǎn shuì.', 'Mỗi tối mười giờ anh ấy đi ngủ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [说话] (shuōhuà) - nói chuyện, trò chuyện [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '说话',
    'shuōhuà',
    'nói chuyện, trò chuyện',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他们正在说话。',
    'Tāmen zhèngzài shuōhuà.',
    'Họ đang nói chuyện với nhau.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他们正在说话。', 'Tāmen zhèngzài shuōhuà.', 'Họ đang nói chuyện với nhau.', 'basic', 1),
      (v_id, '上课的时候不要大声说话。', 'Shàngkè de shíhou búyào dàshēng shuōhuà.', 'Lúc học bài đừng nói chuyện to tiếng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [它] (tā) - nó (chỉ đồ vật, con vật) [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '它',
    'tā',
    'nó (chỉ đồ vật, con vật)',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '那是一只猫，它很可爱。',
    'Nà shì yì zhī māo, tā hěn kě’ài.',
    'Đó là một con mèo, nó rất đáng yêu.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '那是一只猫，它很可爱。', 'Nà shì yì zhī māo, tā hěn kě’ài.', 'Đó là một con mèo, nó rất đáng yêu.', 'basic', 1),
      (v_id, '小狗在哪里？它在桌子下。', 'Xiǎogǒu zài nǎlǐ? Tā zài zhuōzi xià.', 'Chú cún ở đâu? Nó ở dưới gầm bàn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [他们] (tāmen) - họ, bọn họ (nam/chung) [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '他们',
    'tāmen',
    'họ, bọn họ (nam/chung)',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他们是我的同学。',
    'Tāmen shì wǒ de tóngxué.',
    'Họ là bạn học của tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他们是我的同学。', 'Tāmen shì wǒ de tóngxué.', 'Họ là bạn học của tôi.', 'basic', 1),
      (v_id, '他们明天要去北京旅游。', 'Tāmen míngtiān yào qù Běijīng lǚyóu.', 'Ngày mai họ sẽ đi du lịch Bắc Kinh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [它们] (tāmen) - chúng, chúng nó (đồ vật/động vật) [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '它们',
    'tāmen',
    'chúng, chúng nó (đồ vật/động vật)',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '院子里有两只狗，它们都很小。',
    'Yuànzi lǐ yǒu liǎng zhī gǒu, tāmen dōu hěn xiǎo.',
    'Trong sân có hai chú chó, chúng đều rất nhỏ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '院子里有两只狗，它们都很小。', 'Yuànzi lǐ yǒu liǎng zhī gǒu, tāmen dōu hěn xiǎo.', 'Trong sân có hai chú chó, chúng đều rất nhỏ.', 'basic', 1),
      (v_id, '这些鸟真漂亮，它们在唱歌。', 'Zhèxiē niǎo zhēn piàoliang, tāmen zài chànggē.', 'Những chú chim này thật đẹp, chúng đang ca hát.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [她们] (tāmen) - họ, các cô ấy (toàn nữ) [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '她们',
    'tāmen',
    'họ, các cô ấy (toàn nữ)',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '她们都在学中文。',
    'Tāmen dōu zài xué Zhōngwén.',
    'Các cô ấy đều đang học tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '她们都在学中文。', 'Tāmen dōu zài xué Zhōngwén.', 'Các cô ấy đều đang học tiếng Trung.', 'basic', 1),
      (v_id, '姐姐和她的朋友们，她们去超市了。', 'Jiějie hé tā de péngyoumen, tāmen qù chāoshì le.', 'Chị gái và các bạn của chị, họ đã đi siêu thị rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [天] (tiān) - trời, ngày [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '天',
    'tiān',
    'trời, ngày',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天天气很好。',
    'Jīntiān tiānqì hěn hǎo.',
    'Hôm nay thời tiết rất đẹp.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天天气很好。', 'Jīntiān tiānqì hěn hǎo.', 'Hôm nay thời tiết rất đẹp.', 'basic', 1),
      (v_id, '我们在北京玩了三天。', 'Wǒmen zài Běijīng wán le sān tiān.', 'Chúng tôi đã chơi ở Bắc Kinh ba ngày.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [听见] (tīngjiàn) - nghe thấy, nghe được [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '听见',
    'tīngjiàn',
    'nghe thấy, nghe được',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你听见了吗？',
    'Nǐ tīngjiàn le ma?',
    'Bạn có nghe thấy không?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你听见了吗？', 'Nǐ tīngjiàn le ma?', 'Bạn có nghe thấy không?', 'basic', 1),
      (v_id, '我听见有人在唱歌。', 'Wǒ tīngjiàn yǒu rén zài chànggē.', 'Tôi nghe thấy có người đang hát.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [外] (wài) - ngoài, bên ngoài [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '外',
    'wài',
    'ngoài, bên ngoài',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他在门外等你。',
    'Tā zài mén wài děng nǐ.',
    'Anh ấy đang đợi bạn ở ngoài cửa.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他在门外等你。', 'Tā zài mén wài děng nǐ.', 'Anh ấy đang đợi bạn ở ngoài cửa.', 'basic', 1),
      (v_id, '外面在下雨，不要出去。', 'Wàimiàn zài xiàyǔ, búyào chūqu.', 'Bên ngoài đang mưa, đừng đi ra ngoài.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [外边] (wàibian) - bên ngoài, phía ngoài [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '外边',
    'wàibian',
    'bên ngoài, phía ngoài',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '外边很冷，多穿点儿衣服。',
    'Wàibian hěn lěng, duō chuān diǎnr yīfu.',
    'Bên ngoài rất lạnh, mặc nhiều áo vào một chút.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '外边很冷，多穿点儿衣服。', 'Wàibian hěn lěng, duō chuān diǎnr yīfu.', 'Bên ngoài rất lạnh, mặc nhiều áo vào một chút.', 'basic', 1),
      (v_id, '孩子们在外边高兴地玩。', 'Háizimen zài wàibian gāoxìng de wán.', 'Lũ trẻ vui vẻ chơi đùa ở phía ngoài.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [玩] (wán) - chơi, vui chơi [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '玩',
    'wán',
    'chơi, vui chơi',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我想去公园玩。',
    'Wǒ xiǎng qù gōngyuán wán.',
    'Tôi muốn đến công viên chơi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我想去公园玩。', 'Wǒ xiǎng qù gōngyuán wán.', 'Tôi muốn đến công viên chơi.', 'basic', 1),
      (v_id, '周末你来我家玩吧。', 'Zhōumò nǐ lái wǒ jiā wán ba.', 'Cuối tuần bạn đến nhà tôi chơi nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [晚] (wǎn) - muộn, trễ [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '晚',
    'wǎn',
    'muộn, trễ',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '现在太晚了，我们走吧。',
    'Xiànzài tài wǎn le, wǒmen zǒu ba.',
    'Bây giờ muộn quá rồi, chúng mình đi thôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '现在太晚了，我们走吧。', 'Xiànzài tài wǎn le, wǒmen zǒu ba.', 'Bây giờ muộn quá rồi, chúng mình đi thôi.', 'basic', 1),
      (v_id, '他今天来晚了十分钟。', 'Tā jīntiān lái wǎn le shí fēnzhōng.', 'Hôm nay anh ấy đến muộn mười phút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [晚饭] (wǎnfàn) - bữa cơm tối [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '晚饭',
    'wǎnfàn',
    'bữa cơm tối',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们晚上七点吃晚饭。',
    'Wǒmen wǎnshang qī diǎn chī wǎnfàn.',
    'Chúng tôi bảy giờ tối ăn cơm tối.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们晚上七点吃晚饭。', 'Wǒmen wǎnshang qī diǎn chī wǎnfàn.', 'Chúng tôi bảy giờ tối ăn cơm tối.', 'basic', 1),
      (v_id, '今天的晚饭很好吃。', 'Jīntiān de wǎnfàn hěn hǎochī.', 'Cơm tối hôm nay rất ngon.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [晚上] (wǎnshang) - buổi tối [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '晚上',
    'wǎnshang',
    'buổi tối',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '晚上我经常看书。',
    'Wǎnshang wǒ jīngcháng kànshū.',
    'Buổi tối tôi thường hay đọc sách.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '晚上我经常看书。', 'Wǎnshang wǒ jīngcháng kànshū.', 'Buổi tối tôi thường hay đọc sách.', 'basic', 1),
      (v_id, '晚上你想去哪里吃饭？', 'Wǎnshang nǐ xiǎng qù nǎlǐ chīfàn?', 'Buổi tối bạn muốn đi đâu ăn cơm?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [喂] (wèi) - alo (khi nghe điện thoại) [Thán từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '喂',
    'wèi',
    'alo (khi nghe điện thoại)',
    'Thán từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '喂，请问王老师在吗？',
    'Wèi, qǐngwèn Wáng lǎoshī zài ma?',
    'Alo, xin hỏi thầy Vương có ở đó không ạ?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '喂，请问王老师在吗？', 'Wèi, qǐngwèn Wáng lǎoshī zài ma?', 'Alo, xin hỏi thầy Vương có ở đó không ạ?', 'basic', 1),
      (v_id, '喂，我是大卫，你在哪里？', 'Wèi, wǒ shì Dàwèi, nǐ zài nǎlǐ?', 'Alo, tôi là David đây, bạn đang ở đâu thế?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [问] (wèn) - hỏi [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '问',
    'wèn',
    'hỏi',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我可以问你一个问题吗？',
    'Wǒ kěyǐ wèn nǐ yí gè wèntí ma?',
    'Tôi có thể hỏi bạn một câu hỏi không?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我可以问你一个问题吗？', 'Wǒ kěyǐ wèn nǐ yí gè wèntí ma?', 'Tôi có thể hỏi bạn một câu hỏi không?', 'basic', 1),
      (v_id, '他去问老师这道题怎么做。', 'Tā qù wèn lǎoshī zhè dào tí zěnme zuò.', 'Cậu ấy đến hỏi thầy giáo bài này làm như thế nào.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [问题] (wèntí) - câu hỏi, vấn đề [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '问题',
    'wèntí',
    'câu hỏi, vấn đề',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '没问题，我帮你！',
    'Méi wèntí, wǒ bāng nǐ!',
    'Không thành vấn đề, tôi giúp bạn!'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '没问题，我帮你！', 'Méi wèntí, wǒ bāng nǐ!', 'Không thành vấn đề, tôi giúp bạn!', 'basic', 1),
      (v_id, '这个汉语问题有点儿难。', 'Zhè ge Hànyǔ wèntí yǒudiǎnr nán.', 'Câu hỏi tiếng Hán này hơi khó một chút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [午饭] (wǔfàn) - bữa trưa, cơm trưa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '午饭',
    'wǔfàn',
    'bữa trưa, cơm trưa',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我们中午十二点吃午饭。',
    'Wǒmen zhōngwǔ shí’èr diǎn chī wǔfàn.',
    'Chúng tôi mười hai giờ trưa ăn cơm trưa.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们中午十二点吃午饭。', 'Wǒmen zhōngwǔ shí’èr diǎn chī wǔfàn.', 'Chúng tôi mười hai giờ trưa ăn cơm trưa.', 'basic', 1),
      (v_id, '今天午饭我想吃米饭和鸡蛋。', 'Jīntiān wǔfàn wǒ xiǎng chī mǐfàn hé jīdàn.', 'Cơm trưa hôm nay tôi muốn ăn cơm và trứng gà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [下班] (xiàbān) - tan làm, tan sở [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '下班',
    'xiàbān',
    'tan làm, tan sở',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我下午五点下班。',
    'Wǒ xiàwǔ wǔ diǎn xiàbān.',
    'Tôi năm giờ chiều tan làm.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我下午五点下班。', 'Wǒ xiàwǔ wǔ diǎn xiàbān.', 'Tôi năm giờ chiều tan làm.', 'basic', 1),
      (v_id, '下班后我们去喝茶吧。', 'Xiàbān hòu wǒmen qù hē chá ba.', 'Tan làm rồi chúng mình đi uống trà nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [下课] (xiàkè) - tan học, tan tiết [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '下课',
    'xiàkè',
    'tan học, tan tiết',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '现在下课了，大家休息吧。',
    'Xiànzài xiàkè le, dàjiā xiūxi ba.',
    'Bây giờ tan học rồi, mọi người nghỉ giải lao đi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '现在下课了，大家休息吧。', 'Xiànzài xiàkè le, dàjiā xiūxi ba.', 'Bây giờ tan học rồi, mọi người nghỉ giải lao đi.', 'basic', 1),
      (v_id, '下课后我想去图书馆借书。', 'Xiàkè hòu wǒ xiǎng qù túshūguǎn jiè shū.', 'Tan học xong tôi muốn đến thư viện mượn sách.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [小朋友] (xiǎopéngyou) - em nhỏ, cháu bé, bạn nhỏ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '小朋友',
    'xiǎopéngyou',
    'em nhỏ, cháu bé, bạn nhỏ',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '那个小朋友真可爱。',
    'Nà ge xiǎopéngyou zhēn kě’ài.',
    'Em nhỏ đó thật đáng yêu.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '那个小朋友真可爱。', 'Nà ge xiǎopéngyou zhēn kě’ài.', 'Em nhỏ đó thật đáng yêu.', 'basic', 1),
      (v_id, '公园里有很多小朋友在玩。', 'Gōngyuán lǐ yǒu hěn duō xiǎopéngyou zài wán.', 'Trong công viên có rất nhiều em nhỏ đang chơi đùa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [小时] (xiǎoshí) - tiếng, giờ đồng hồ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '小时',
    'xiǎoshí',
    'tiếng, giờ đồng hồ',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我学了一个小时中文。',
    'Wǒ xué le yí gè xiǎoshí Zhōngwén.',
    'Tôi đã học tiếng Trung suốt một tiếng đồng hồ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我学了一个小时中文。', 'Wǒ xué le yí gè xiǎoshí Zhōngwén.', 'Tôi đã học tiếng Trung suốt một tiếng đồng hồ.', 'basic', 1),
      (v_id, '坐火车去北京需要两个小时。', 'Zuò huǒchē qù Běijīng xūyào liǎng gè xiǎoshí.', 'Ngồi tàu hỏa đi Bắc Kinh cần hai tiếng đồng hồ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [小学] (xiǎoxué) - trường tiểu học [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '小学',
    'xiǎoxué',
    'trường tiểu học',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这所小学离我家很近。',
    'Zhè suǒ xiǎoxué lí wǒ jiā hěn jìn.',
    'Ngôi trường tiểu học này cách nhà tôi rất gần.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这所小学离我家很近。', 'Zhè suǒ xiǎoxué lí wǒ jiā hěn jìn.', 'Ngôi trường tiểu học này cách nhà tôi rất gần.', 'basic', 1),
      (v_id, '弟弟在这个小学读书。', 'Dìdi zài zhè ge xiǎoxué dúshū.', 'Em trai học ở trường tiểu học này.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [小学生] (xiǎoxuéshēng) - học sinh tiểu học [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '小学生',
    'xiǎoxuéshēng',
    'học sinh tiểu học',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我妹妹是小学生。',
    'Wǒ mèimei shì xiǎoxuéshēng.',
    'Em gái tôi là học sinh tiểu học.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我妹妹是小学生。', 'Wǒ mèimei shì xiǎoxuéshēng.', 'Em gái tôi là học sinh tiểu học.', 'basic', 1),
      (v_id, '小学生们排队走进学校。', 'Xiǎoxuéshēngmen páiduì zǒujìn xuéxiào.', 'Các bạn học sinh tiểu học xếp hàng bước vào trường.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [新] (xīn) - mới [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '新',
    'xīn',
    'mới',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我买了一本新书。',
    'Wǒ mǎi le yì běn xīn shū.',
    'Tôi đã mua một cuốn sách mới.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我买了一本新书。', 'Wǒ mǎi le yì běn xīn shū.', 'Tôi đã mua một cuốn sách mới.', 'basic', 1),
      (v_id, '这是我们班的新同学。', 'Zhè shì wǒmen bān de xīn tóngxué.', 'Đây là người bạn học mới của lớp chúng mình.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [星期日] (xīngqīrì) - chủ nhật [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '星期日',
    'xīngqīrì',
    'chủ nhật',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天是星期日。',
    'Jīntiān shì xīngqīrì.',
    'Hôm nay là ngày chủ nhật.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天是星期日。', 'Jīntiān shì xīngqīrì.', 'Hôm nay là ngày chủ nhật.', 'basic', 1),
      (v_id, '星期日我和朋友去公园。', 'Xīngqīrì wǒ hé péngyou qù gōngyuán.', 'Chủ nhật tôi cùng bạn bè đến công viên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [星期天] (xīngqītiān) - chủ nhật [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '星期天',
    'xīngqītiān',
    'chủ nhật',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '星期天你打算做什么？',
    'Xīngqītiān nǐ dǎsuan zuò shénme?',
    'Chủ nhật bạn dự định làm gì?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '星期天你打算做什么？', 'Xīngqītiān nǐ dǎsuan zuò shénme?', 'Chủ nhật bạn dự định làm gì?', 'basic', 1),
      (v_id, '星期天我不上班，在家休息。', 'Xīngqītiān wǒ bú shàngbān, zài jiā xiūxi.', 'Chủ nhật tôi không đi làm, ở nhà nghỉ ngơi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [休息] (xiūxi) - nghỉ ngơi [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '休息',
    'xiūxi',
    'nghỉ ngơi',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '累了就休息一会儿吧。',
    'Lèi le jiù xiūxi yíhuìr ba.',
    'Mệt rồi thì nghỉ ngơi một chút đi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '累了就休息一会儿吧。', 'Lèi le jiù xiūxi yíhuìr ba.', 'Mệt rồi thì nghỉ ngơi một chút đi.', 'basic', 1),
      (v_id, '周末我喜欢在家里休息。', 'Zhōumò wǒ xǐhuan zài jiā lǐ xiūxi.', 'Cuối tuần tôi thích ở trong nhà nghỉ ngơi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [学] (xué) - học, học tập [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '学',
    'xué',
    'học, học tập',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我想学中文。',
    'Wǒ xiǎng xué Zhōngwén.',
    'Tôi muốn học tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我想学中文。', 'Wǒ xiǎng xué Zhōngwén.', 'Tôi muốn học tiếng Trung.', 'basic', 1),
      (v_id, '他在大学学中国历史。', 'Tā zài dàxué xué Zhōngguó lìshǐ.', 'Cậu ấy học lịch sử Trung Quốc ở trường đại học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [雪] (xuě) - tuyết [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '雪',
    'xuě',
    'tuyết',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天下雪了。',
    'Jīntiān xiàxuě le.',
    'Hôm nay trời đổ tuyết rồi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天下雪了。', 'Jīntiān xiàxuě le.', 'Hôm nay trời đổ tuyết rồi.', 'basic', 1),
      (v_id, '北京冬天的雪非常漂亮。', 'Běijīng dōngtiān de xuě fēicháng piàoliang.', 'Tuyết mùa đông ở Bắc Kinh vô cùng đẹp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [要] (yào) - muốn, cần, phải [Động từ / Động từ năng nguyện]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '要',
    'yào',
    'muốn, cần, phải',
    'Động từ / Động từ năng nguyện',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我要买一瓶水。',
    'Wǒ yào mǎi yì píng shuǐ.',
    'Tôi muốn mua một chai nước.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我要买一瓶水。', 'Wǒ yào mǎi yì píng shuǐ.', 'Tôi muốn mua một chai nước.', 'basic', 1),
      (v_id, '明天我要去北京出差。', 'Míngtiān wǒ yào qù Běijīng chūchāi.', 'Ngày mai tôi phải đi công tác Bắc Kinh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [也] (yě) - cũng [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '也',
    'yě',
    'cũng',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我也是学生。',
    'Wǒ yě shì xuésheng.',
    'Tôi cũng là học sinh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我也是学生。', 'Wǒ yě shì xuésheng.', 'Tôi cũng là học sinh.', 'basic', 1),
      (v_id, '他也喜欢吃北京烤鸭。', 'Tā yě xǐhuan chī Běijīng kǎoyā.', 'Anh ấy cũng thích ăn vịt quay Bắc Kinh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [一半] (yíbàn) - một nửa [Danh từ / Số từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '一半',
    'yíbàn',
    'một nửa',
    'Danh từ / Số từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这块西瓜分你一半。',
    'Zhè kuài xīguā fēn nǐ yíbàn.',
    'Miếng dưa hấu này chia cho bạn một nửa nhé.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这块西瓜分你一半。', 'Zhè kuài xīguā fēn nǐ yíbàn.', 'Miếng dưa hấu này chia cho bạn một nửa nhé.', 'basic', 1),
      (v_id, '这本书我已经看了一半。', 'Zhè běn shū wǒ yǐjīng kàn le yíbàn.', 'Quyển sách này tôi đã đọc được một nửa rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [一下] (yíxià) - một chút, một lát [Lượng từ động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '一下',
    'yíxià',
    'một chút, một lát',
    'Lượng từ động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '请等一下。',
    'Qǐng děng yíxià.',
    'Làm ơn đợi một lát.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请等一下。', 'Qǐng děng yíxià.', 'Làm ơn đợi một lát.', 'basic', 1),
      (v_id, '你能帮我看一眼这个句子吗？', 'Nǐ néng bāng wǒ kàn yì yǎn zhè ge jùzi ma?', 'Bạn có thể giúp tôi xem qua câu này một chút không?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [一些] (yìxiē) - một số, một vài, một ít [Lượng từ / Số từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '一些',
    'yìxiē',
    'một số, một vài, một ít',
    'Lượng từ / Số từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我想买一些苹果。',
    'Wǒ xiǎng mǎi yìxiē píngguǒ.',
    'Tôi muốn mua một ít táo.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我想买一些苹果。', 'Wǒ xiǎng mǎi yìxiē píngguǒ.', 'Tôi muốn mua một ít táo.', 'basic', 1),
      (v_id, '桌子上有一些中文书。', 'Zhuōzi shang yǒu yìxiē Zhōngwén shū.', 'Trên bàn có một vài quyển sách tiếng Trung.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [有的] (yǒude) - có cái, có người, có những [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '有的',
    'yǒude',
    'có cái, có người, có những',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '有的学生喜欢学汉语。',
    'Yǒude xuésheng xǐhuan xué Hànyǔ.',
    'Có những học sinh thích học tiếng Hán.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '有的学生喜欢学汉语。', 'Yǒude xuésheng xǐhuan xué Hànyǔ.', 'Có những học sinh thích học tiếng Hán.', 'basic', 1),
      (v_id, '这些苹果，有的是红的，有的是绿的。', 'Zhèxiē píngguǒ, yǒude shì hóng de, yǒude shì lǜ de.', 'Những quả táo này, có quả màu đỏ, có quả màu xanh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [有点儿] (yǒudiǎnr) - hơi, một chút (thường mang sắc thái tiêu cực nhẹ) [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '有点儿',
    'yǒudiǎnr',
    'hơi, một chút (thường mang sắc thái tiêu cực nhẹ)',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天有点儿冷。',
    'Jīntiān yǒudiǎnr lěng.',
    'Hôm nay hơi lạnh một chút.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天有点儿冷。', 'Jīntiān yǒudiǎnr lěng.', 'Hôm nay hơi lạnh một chút.', 'basic', 1),
      (v_id, '这个菜有点儿辣。', 'Zhè ge cài yǒudiǎnr là.', 'Món ăn này hơi cay một chút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [有些] (yǒuxiē) - có một số, có phần, hơi [Đại từ / Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '有些',
    'yǒuxiē',
    'có một số, có phần, hơi',
    'Đại từ / Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '有些汉字很难写。',
    'Yǒuxiē hànzì hěn nán xiě.',
    'Có một số chữ Hán rất khó viết.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '有些汉字很难写。', 'Yǒuxiē hànzì hěn nán xiě.', 'Có một số chữ Hán rất khó viết.', 'basic', 1),
      (v_id, '听到这个消息，他有些高兴。', 'Tīngdào zhè ge xiāoxi, tā yǒuxiē gāoxìng.', 'Nghe được tin này, anh ấy có phần vui mừng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [雨] (yǔ) - mưa, cơn mưa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '雨',
    'yǔ',
    'mưa, cơn mưa',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天外面在下雨。',
    'Jīntiān wàimiàn zài xiàyǔ.',
    'Hôm nay bên ngoài đang mưa.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天外面在下雨。', 'Jīntiān wàimiàn zài xiàyǔ.', 'Hôm nay bên ngoài đang mưa.', 'basic', 1),
      (v_id, '雨停了，我们走吧。', 'Yǔ tíng le, wǒmen zǒu ba.', 'Mưa tạnh rồi, chúng mình đi thôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [元] (yuán) - đồng (nhân dân tệ - văn viết) [Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '元',
    'yuán',
    'đồng (nhân dân tệ - văn viết)',
    'Lượng từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这本书五十元。',
    'Zhè běn shū wǔshí yuán.',
    'Quyển sách này năm mươi nhân dân tệ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这本书五十元。', 'Zhè běn shū wǔshí yuán.', 'Quyển sách này năm mươi nhân dân tệ.', 'basic', 1),
      (v_id, '这瓶水两元钱。', 'Zhè píng shuǐ liǎng yuán qián.', 'Chai nước này hai tệ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [再] (zài) - lại, nữa (hành động lặp lại trong tương lai) [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '再',
    'zài',
    'lại, nữa (hành động lặp lại trong tương lai)',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '欢迎下次再来！',
    'Huānyíng xià cì zài lái!',
    'Hoan nghênh lần sau lại ghé thăm!'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '欢迎下次再来！', 'Huānyíng xià cì zài lái!', 'Hoan nghênh lần sau lại ghé thăm!', 'basic', 1),
      (v_id, '请你说得慢一点儿，再说一遍。', 'Qǐng nǐ shuō de màn yìdiǎnr, zài shuō yí biàn.', 'Làm ơn nói chậm một chút và nói lại một lần nữa nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [早] (zǎo) - sớm; chào buổi sáng [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '早',
    'zǎo',
    'sớm; chào buổi sáng',
    'Tính từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '老师，早上好！——你早！',
    'Lǎoshī, zǎoshang hǎo! —— Nǐ zǎo!',
    'Chào buổi sáng cô giáo! —— Chào em!'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '老师，早上好！——你早！', 'Lǎoshī, zǎoshang hǎo! —— Nǐ zǎo!', 'Chào buổi sáng cô giáo! —— Chào em!', 'basic', 1),
      (v_id, '今天早上他来得非常早。', 'Jīntiān zǎoshang tā lái de fēicháng zǎo.', 'Sáng nay anh ấy đến rất sớm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [早饭] (zǎofàn) - bữa sáng, cơm sáng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '早饭',
    'zǎofàn',
    'bữa sáng, cơm sáng',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '早饭我吃包子和牛奶。',
    'Zǎofàn wǒ chī bāozi hé niúnǎi.',
    'Bữa sáng tôi ăn bánh bao và sữa tươi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '早饭我吃包子和牛奶。', 'Zǎofàn wǒ chī bāozi hé niúnǎi.', 'Bữa sáng tôi ăn bánh bao và sữa tươi.', 'basic', 1),
      (v_id, '你今天吃早饭了吗？', 'Nǐ jīntiān chī zǎofàn le ma?', 'Hôm nay bạn đã ăn bữa sáng chưa?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [早上] (zǎoshang) - buổi sáng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '早上',
    'zǎoshang',
    'buổi sáng',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '早上好！',
    'Zǎoshang hǎo!',
    'Chào buổi sáng!'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '早上好！', 'Zǎoshang hǎo!', 'Chào buổi sáng!', 'basic', 1),
      (v_id, '我每天早上七点起床跑步。', 'Wǒ měitiān zǎoshang qī diǎn qǐchuáng pǎobù.', 'Mỗi sáng bảy giờ tôi thức dậy chạy bộ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [找] (zhǎo) - tìm, kiếm; thối tiền thừa [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '找',
    'zhǎo',
    'tìm, kiếm; thối tiền thừa',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '你在找什么？',
    'Nǐ zài zhǎo shénme?',
    'Bạn đang tìm kiếm cái gì thế?'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你在找什么？', 'Nǐ zài zhǎo shénme?', 'Bạn đang tìm kiếm cái gì thế?', 'basic', 1),
      (v_id, '我找不到我的手机了。', 'Wǒ zhǎobudào wǒ de shǒujī le.', 'Tôi không tìm thấy chiếc điện thoại của mình rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [这边] (zhèbian) - bên này, phía này [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '这边',
    'zhèbian',
    'bên này, phía này',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '请往这边走。',
    'Qǐng wǎng zhèbian zǒu.',
    'Làm ơn đi về phía bên này.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请往这边走。', 'Qǐng wǎng zhèbian zǒu.', 'Làm ơn đi về phía bên này.', 'basic', 1),
      (v_id, '这边坐着很多人。', 'Zhèbian zuò zhe hěn duō rén.', 'Phía bên này đang có rất nhiều người ngồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [这个] (zhè ge) - cái này, việc này [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '这个',
    'zhè ge',
    'cái này, việc này',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这个苹果很甜。',
    'Zhè ge píngguǒ hěn tián.',
    'Quả táo này rất ngọt.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个苹果很甜。', 'Zhè ge píngguǒ hěn tián.', 'Quả táo này rất ngọt.', 'basic', 1),
      (v_id, '这个字怎么读？', 'Zhè ge zì zěnme dú?', 'Chữ này đọc như thế nào vậy?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [这里] (zhèlǐ) - ở đây, chỗ này [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '这里',
    'zhèlǐ',
    'ở đây, chỗ này',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这里是北京大学。',
    'Zhèlǐ shì Běijīng Dàxué.',
    'Đây là Đại học Bắc Kinh.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这里是北京大学。', 'Zhèlǐ shì Běijīng Dàxué.', 'Đây là Đại học Bắc Kinh.', 'basic', 1),
      (v_id, '这里的天气比我家乡冷。', 'Zhèlǐ de tiānqì bǐ wǒ jiāxiāng lěng.', 'Thời tiết ở đây lạnh hơn quê tôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [这儿] (zhèr) - chỗ này, đây [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '这儿',
    'zhèr',
    'chỗ này, đây',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '请坐在聘儿。',
    'Qǐng zuò zài zhèr.',
    'Xin mời ngồi ở chỗ này.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请坐在聘儿。', 'Qǐng zuò zài zhèr.', 'Xin mời ngồi ở chỗ này.', 'basic', 1),
      (v_id, '这儿有一家很好的中国餐厅。', 'Zhèr yǒu yì jiā hěn hǎo de Zhōngguó cāntīng.', 'Ở đây có một nhà hàng Trung Quốc rất ngon.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [这些] (zhèxiē) - những cái này, những thứ này [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '这些',
    'zhèxiē',
    'những cái này, những thứ này',
    'Đại từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这些书是我的。',
    'Zhèxiē shū shì wǒ de.',
    'Những cuốn sách này là của tôi.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这些书是我的。', 'Zhèxiē shū shì wǒ de.', 'Những cuốn sách này là của tôi.', 'basic', 1),
      (v_id, '这些水果非常新鲜。', 'Zhèxiē shuǐguǒ fēicháng xīnxiān.', 'Những hoa quả này rất tươi ngon.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [真] (zhēn) - thật, thật là [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '真',
    'zhēn',
    'thật, thật là',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '今天天气真好！',
    'Jīntiān tiānqì zhēn hǎo!',
    'Hôm nay thời tiết thật là đẹp!'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天天气真好！', 'Jīntiān tiānqì zhēn hǎo!', 'Hôm nay thời tiết thật là đẹp!', 'basic', 1),
      (v_id, '这道菜真好吃。', 'Zhè dào cài zhēn hǎochī.', 'Món ăn này thật là ngon.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [正在] (zhèngzài) - đang (chỉ hành động đang diễn ra) [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '正在',
    'zhèngzài',
    'đang (chỉ hành động đang diễn ra)',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '他正在睡觉。',
    'Tā zhèngzài shuìjiào.',
    'Anh ấy đang ngủ.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他正在睡觉。', 'Tā zhèngzài shuìjiào.', 'Anh ấy đang ngủ.', 'basic', 1),
      (v_id, '老师正在给我们讲课。', 'Lǎoshī zhèngzài gěi wǒmen jiǎngkè.', 'Cô giáo đang giảng bài cho chúng tôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [只] (zhǐ) - chỉ, chỉ có [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '只',
    'zhǐ',
    'chỉ, chỉ có',
    'Phó từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我只有一个苹果。',
    'Wǒ zhǐ yǒu yí gè píngguǒ.',
    'Tôi chỉ có một quả táo.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我只有一个苹果。', 'Wǒ zhǐ yǒu yí gè píngguǒ.', 'Tôi chỉ có một quả táo.', 'basic', 1),
      (v_id, '他只会说一点儿中文。', 'Tā zhǐ huì shuō yìdiǎnr Zhōngwén.', 'Anh ấy chỉ biết nói một chút tiếng Trung thôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [知道] (zhīdào) - biết, hiểu rõ [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '知道',
    'zhīdào',
    'biết, hiểu rõ',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我知道他的名字。',
    'Wǒ zhīdào tā de míngzi.',
    'Tôi biết tên của anh ấy.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我知道他的名字。', 'Wǒ zhīdào tā de míngzi.', 'Tôi biết tên của anh ấy.', 'basic', 1),
      (v_id, '你知道去火车站怎么走吗？', 'Nǐ zhīdào qù huǒchēzhàn zěnme zǒu ma?', 'Bạn có biết đường đi đến ga tàu hỏa đi như thế nào không?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [中文] (Zhōngwén) - tiếng Trung, Trung văn [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '中文',
    'Zhōngwén',
    'tiếng Trung, Trung văn',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我喜欢学中文。',
    'Wǒ xǐhuan xué Zhōngwén.',
    'Tôi thích học tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我喜欢学中文。', 'Wǒ xǐhuan xué Zhōngwén.', 'Tôi thích học tiếng Trung.', 'basic', 1),
      (v_id, '他会说流利的中文。', 'Tā huì shuō liúlì de Zhōngwén.', 'Anh ấy có thể nói tiếng Trung rất lưu loát.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [中学] (zhōngxué) - trường trung học (cấp 2, cấp 3) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '中学',
    'zhōngxué',
    'trường trung học (cấp 2, cấp 3)',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '这是一所中学。',
    'Zhè shì yì suǒ zhōngxué.',
    'Đây là một ngôi trường trung học.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这是一所中学。', 'Zhè shì yì suǒ zhōngxué.', 'Đây là một ngôi trường trung học.', 'basic', 1),
      (v_id, '哥哥在这所中学当数学老师。', 'Gēge zài zhè suǒ zhōngxué dāng shùxué lǎoshī.', 'Anh trai làm giáo viên toán ở trường trung học này.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [中学生] (zhōngxuéshēng) - học sinh trung học [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '中学生',
    'zhōngxuéshēng',
    'học sinh trung học',
    'Danh từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '我哥哥是中学生。',
    'Wǒ gēge shì zhōngxuéshēng.',
    'Anh trai tôi là học sinh trung học.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我哥哥是中学生。', 'Wǒ gēge shì zhōngxuéshēng.', 'Anh trai tôi là học sinh trung học.', 'basic', 1),
      (v_id, '这些中学生每天都起得很早。', 'Zhèxiē zhōngxuéshēng měitiān dōu qǐ de hěn zǎo.', 'Các bạn học sinh trung học này mỗi ngày đều dậy rất sớm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [做饭] (zuòfàn) - nấu cơm, nấu ăn [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '做饭',
    'zuòfàn',
    'nấu cơm, nấu ăn',
    'Động từ',
    'HSK 1',
    'HSK 1',
    'hsk3.0',
    '妈妈正在厨房做饭。',
    'Māma zhèngzài chúfáng zuòfàn.',
    'Mẹ đang nấu cơm trong bếp.'
  )
  ON CONFLICT (hanzi, pinyin) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level = 'HSK 1',
    hsk_level_v3 = 'HSK 1',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '妈妈正在厨房做饭。', 'Māma zhèngzài chúfáng zuòfàn.', 'Mẹ đang nấu cơm trong bếp.', 'basic', 1),
      (v_id, '周末我经常自己在家做饭吃。', 'Zhōumò wǒ jīngcháng zìjǐ zài jiā zuòfàn chī.', 'Cuối tuần tôi thường tự nấu cơm ăn ở nhà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  RAISE NOTICE 'Đã bổ sung và đồng bộ thành công % từ vựng HSK 1 mới!', v_count;
END $$;
