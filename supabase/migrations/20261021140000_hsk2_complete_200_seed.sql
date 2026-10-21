-- ====================================================================
-- MIGRATION SEED: HOÀN THIỆN 200/200 TỪ VỰNG MỚI HSK 2 CHUẨN ĐỀ CƯƠNG HSK 3.0
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn - Công bố 11/2025)
-- Cấp độ: HSK 2 (200 từ vựng mới, tổng tích lũy Cấp 1 + 2 = 500 từ vựng)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Điều chỉnh ràng buộc duy nhất để hỗ trợ từ đồng âm/đa nghĩa giữa các cấp (như '点')
--   - ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE: Idempotent, không sinh trùng
--   - Bảo toàn 100% dữ liệu học tập, tiến độ và Flashcards cũ của người dùng
--   - Nạp tự động 2 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng) vào vocabulary_examples
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
BEGIN

  -- ------------------------------------------------------------------
  -- BƯỚC 1: ĐIỀU CHỈNH RÀNG BUỘC DUY NHẤT ĐỂ HỖ TRỢ TỪ ĐA NGHĨA GIỮA CÁC CẤP HSK
  -- (Giúp từ '点' có thể tồn tại ở HSK 1 là lượng từ và HSK 2 là động từ)
  -- ------------------------------------------------------------------
  IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vocabularies_hanzi_pinyin_key') THEN
    ALTER TABLE public.vocabularies DROP CONSTRAINT vocabularies_hanzi_pinyin_key;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vocabularies_hanzi_pinyin_level_key') THEN
    ALTER TABLE public.vocabularies ADD CONSTRAINT vocabularies_hanzi_pinyin_level_key UNIQUE (hanzi, pinyin, hsk_level);
  END IF;

  -- ------------------------------------------------------------------
  -- BƯỚC 2: BẢO TOÀN DỮ LIỆU & ĐIỀU CHUYỂN 30 TỪ HSK 2 CŨ SANG HSK 3
  -- (Không xóa bản ghi nào, giữ nguyên UUID id để bảo toàn user_vocabularies)
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level = 'HSK 3',
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk2.0'
  WHERE id IN (
    'f0f794be-38d2-4255-b2a5-73950e179672',
    '0785476b-4e20-482c-b3a8-d432c332f964',
    '04b353ea-176d-43cf-bc4a-8255f670fcab',
    '4c5beb57-7dbe-4425-8bff-cd57f0bf4a2f',
    '0a7f985f-2335-4448-9dd4-5ca2f469336a',
    '0580bcd0-a580-4eab-a254-1709b9a23b63',
    '5db3d1d1-1a7b-46f8-89ab-ec3a864f28a6',
    'a3299854-9874-48ee-b1cf-0b12a1141c7f',
    '8c79a14a-5fba-4d70-9955-519787cdec96',
    'beddc2d8-c6a9-4689-9693-661fb8db7420',
    '76f142fc-d257-46f4-9ab2-5e0cd215f6b8',
    '87430450-e35a-4c8c-b9af-92e368475ac7',
    '0ced6c8c-9bdc-45ea-9bc8-acd766767957',
    'f8990119-7d2a-474d-9486-2aea4111715d',
    '62cfca9f-160a-43ce-9e1f-868ebe33bb0b',
    '5b4565a2-da5c-4df4-9630-caa2228d1be1',
    'd7783111-8025-48ec-8997-2d823f575d46',
    '84915592-1e2c-4c52-b7c8-ed036b7099f5',
    'ac0b1d3d-ded4-47c7-b424-f75e609bfc0e',
    'fa0f309b-7610-4c3e-b694-770a6a64e6a3',
    '3fe12ab0-3cfa-4134-b10d-5dc4139d4994',
    '7b24bf1b-3d6b-4420-bcfe-fa224d3df5eb',
    '3a4ee983-3999-414c-a9e5-8a35632d1fe3',
    '70661711-4ab4-4482-a2f2-9da29542cf39',
    '5bbcae6d-f70f-4d94-8078-fabf75683591',
    'd7cb7b10-6291-43b0-bd10-72e1242e7a7b',
    '6607e5d3-3816-4800-8c8d-29d3433c71e2',
    'c4c02e02-fd53-4a04-918c-bc6b49e82c54',
    '3c57a1b8-be0f-41dd-9906-e689220a1214',
    'ba37729b-7b8b-4bdf-ba95-a1e6ba75d016'
  );

  -- ------------------------------------------------------------------
  -- BƯỚC 3: ĐỒNG BỘ PHIÊN BẢN HSK 3.0 CHO CÁC TỪ VỰNG CHUẨN HIỆN CÓ CỦA HSK 2
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level_v3 = 'HSK 2',
    hsk_version = 'hsk3.0'
  WHERE hsk_level = 'HSK 2';

  -- ------------------------------------------------------------------
  -- BƯỚC 4: BỔ SUNG CÁC TỪ VỰNG HSK 2 VÀ CÂU VÍ DỤ CHẤT LƯỢNG CAO
  -- ------------------------------------------------------------------
  -- [啊] (a) - à, nhé, ư, đấy (trợ từ ngữ khí cuối câu) [Trợ từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '啊',
    'a',
    'à, nhé, ư, đấy (trợ từ ngữ khí cuối câu)',
    'Trợ từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '今天天气真好啊！',
    'Jīntiān tiānqì zhēn hǎo a!',
    'Hôm nay thời tiết thật là đẹp quá đi!'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '今天天气真好啊！', 'Jīntiān tiānqì zhēn hǎo a!', 'Hôm nay thời tiết thật là đẹp quá đi!', 'basic', 1),
      (v_id, '你走慢点儿啊，小心路滑。', 'Nǐ zǒu màn diǎnr a, xiǎoxīn lù huá.', 'Bạn đi chậm một chút nhé, cẩn thận đường trơn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [爱好] (àihào) - sở thích; yêu thích [Danh từ / Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '爱好',
    'àihào',
    'sở thích; yêu thích',
    'Danh từ / Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我的爱好是听音乐。',
    'Wǒ de àihào shì tīng yīnyuè.',
    'Sở thích của tôi là nghe nhạc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我的爱好是听音乐。', 'Wǒ de àihào shì tīng yīnyuè.', 'Sở thích của tôi là nghe nhạc.', 'basic', 1),
      (v_id, '他从小就爱好画画和下棋。', 'Tā cóngxiǎo jiù àihào huàhuà hé xiàqí.', 'Anh ấy từ nhỏ đã yêu thích vẽ tranh và đánh cờ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [白色] (báisè) - màu trắng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '白色',
    'báisè',
    'màu trắng',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我喜欢白色的衬衫。',
    'Wǒ xǐhuan báisè de chènshān.',
    'Tôi thích chiếc áo sơ mi màu trắng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我喜欢白色的衬衫。', 'Wǒ xǐhuan báisè de chènshān.', 'Tôi thích chiếc áo sơ mi màu trắng.', 'basic', 1),
      (v_id, '冬天的大山到处都是白色的雪。', 'Dōngtiān de dàshān dàochù dōu shì báisè de xuě.', 'Mùa đông khắp núi non đều bao phủ tuyết trắng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [笔] (bǐ) - bút, cây bút [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '笔',
    'bǐ',
    'bút, cây bút',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '借我一支笔好吗？',
    'Jiè wǒ yì zhī bǐ hǎo ma?',
    'Cho tôi mượn một cây bút được không?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '借我一支笔好吗？', 'Jiè wǒ yì zhī bǐ hǎo ma?', 'Cho tôi mượn một cây bút được không?', 'basic', 1),
      (v_id, '桌子上放着几支不同颜色的笔。', 'Zhuōzi shang fàngzhe jǐ zhī bùtóng yánsè de bǐ.', 'Trên bàn có để mấy cây bút màu khác nhau.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不错] (búcuò) - không tồi, rất tốt, đúng [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不错',
    'búcuò',
    'không tồi, rất tốt, đúng',
    'Tính từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这道菜的味道真不错。',
    'Zhè dào cài de wèidao zhēn búcuò.',
    'Mùi vị món ăn này thực sự rất ngon.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这道菜的味道真不错。', 'Zhè dào cài de wèidao zhēn búcuò.', 'Mùi vị món ăn này thực sự rất ngon.', 'basic', 1),
      (v_id, '他的中文水平很不错，交流完全没问题。', 'Tā de Zhōngwén shuǐpíng hěn búcuò, jiāoliú wánquán méi wèntí.', 'Trình độ tiếng Trung của anh ấy rất tốt, giao tiếp hoàn toàn không có trở ngại.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不好意思] (bùhǎoyìsi) - ngại ngùng, áy náy, xin lỗi [Cụm từ / Thán từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不好意思',
    'bùhǎoyìsi',
    'ngại ngùng, áy náy, xin lỗi',
    'Cụm từ / Thán từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '不好意思，打扰您了。',
    'Bùhǎoyìsi, dǎrǎo nín le.',
    'Thật ngại quá, đã làm phiền ngài rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '不好意思，打扰您了。', 'Bùhǎoyìsi, dǎrǎo nín le.', 'Thật ngại quá, đã làm phiền ngài rồi.', 'basic', 1),
      (v_id, '让你在外面等这么久，真不好意思。', 'Ràng nǐ zài wàimiàn děng zhème jiǔ, zhēn bùhǎoyìsi.', 'Để bạn phải đợi ở ngoài lâu như vậy, thật là áy náy quá.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [长] (cháng) - dài, lâu [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '长',
    'cháng',
    'dài, lâu',
    'Tính từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这条路很长。',
    'Zhè tiáo lù hěn cháng.',
    'Con đường này rất dài.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这条路很长。', 'Zhè tiáo lù hěn cháng.', 'Con đường này rất dài.', 'basic', 1),
      (v_id, '姐姐有一头乌黑漂亮的短发和一双大眼睛。', 'Jiějie yǒu yì tóu wūhēi piàoliang de chángfà hé yì shuāng dà yǎnjing.', 'Chị gái có mái tóc dài đen nhánh xinh đẹp và một đôi mắt to.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [车站] (chēzhàn) - bến xe, nhà ga [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '车站',
    'chēzhàn',
    'bến xe, nhà ga',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我在车站等你。',
    'Wǒ zài chēzhàn děng nǐ.',
    'Tôi đang đợi bạn ở bến xe.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我在车站等你。', 'Wǒ zài chēzhàn děng nǐ.', 'Tôi đang đợi bạn ở bến xe.', 'basic', 1),
      (v_id, '从这里往东走五百米就是公共汽车站。', 'Cóng zhèlǐ wǎng dōng zǒu wǔbǎi mǐ jiù shì gōnggòngqìchē zhàn.', 'Từ đây đi về phía đông năm trăm mét là tới trạm xe buýt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [出国] (chūguó) - xuất ngoại, đi nước ngoài [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '出国',
    'chūguó',
    'xuất ngoại, đi nước ngoài',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他下个月要出国留学。',
    'Tā xià ge yuè yào chūguó liúxué.',
    'Tháng sau anh ấy sẽ ra nước ngoài du học.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他下个月要出国留学。', 'Tā xià ge yuè yào chūguó liúxué.', 'Tháng sau anh ấy sẽ ra nước ngoài du học.', 'basic', 1),
      (v_id, '出国旅游之前需要准备好护照和签证。', 'Chūguó lǚyóu zhīqián xūyào zhǔnbèi hǎo hùzhào hé qiānzhèng.', 'Trước khi đi du lịch nước ngoài cần chuẩn bị sẵn hộ chiếu và visa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [出来] (chūlai) - ra đây, đi ra, xuất hiện [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '出来',
    'chūlai',
    'ra đây, đi ra, xuất hiện',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '太阳出来了。',
    'Tàiyáng chūlai le.',
    'Mặt trời đã mọc lên rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '太阳出来了。', 'Tàiyáng chūlai le.', 'Mặt trời đã mọc lên rồi.', 'basic', 1),
      (v_id, '你快出来看看，外面下大雪了！', 'Nǐ kuài chūlai kànkan, wàimiàn xià dàxuě le!', 'Bạn mau ra đây xem này, bên ngoài tuyết rơi dày quá!', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [出门] (chūmén) - ra khỏi nhà, đi xa [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '出门',
    'chūmén',
    'ra khỏi nhà, đi xa',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '爸爸早上七点出门上班。',
    'Bàba zǎoshang qī diǎn chūmén shàngbān.',
    'Bố bảy giờ sáng ra khỏi nhà đi làm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '爸爸早上七点出门上班。', 'Bàba zǎoshang qī diǎn chūmén shàngbān.', 'Bố bảy giờ sáng ra khỏi nhà đi làm.', 'basic', 1),
      (v_id, '今天天气很冷，出门记得带把伞。', 'Jīntiān tiānqì hěn lěng, chūmén jìde dài bǎ sǎn.', 'Hôm nay trời rất lạnh, ra ngoài nhớ mang theo một chiếc ô.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [出去] (chūqù) - đi ra ngoài [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '出去',
    'chūqù',
    'đi ra ngoài',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我们出去散散步吧。',
    'Wǒmen chūqù sànsanbù ba.',
    'Chúng mình cùng đi ra ngoài tản bộ nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我们出去散散步吧。', 'Wǒmen chūqù sànsanbù ba.', 'Chúng mình cùng đi ra ngoài tản bộ nhé.', 'basic', 1),
      (v_id, '房间里太热了，我想出去透透气。', 'Fángjiān lǐ tài rè le, wǒ xiǎng chūqù tòutòuqì.', 'Trong phòng ngột ngạt quá, tôi muốn đi ra ngoài hít thở không khí.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [床] (chuáng) - giường [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '床',
    'chuáng',
    'giường',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这张床非常舒服。',
    'Zhè zhāng chuáng fēicháng shūfu.',
    'Chiếc giường này rất êm và thoải mái.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这张床非常舒服。', 'Zhè zhāng chuáng fēicháng shūfu.', 'Chiếc giường này rất êm và thoải mái.', 'basic', 1),
      (v_id, '他生病了，整天都躺在床上休息。', 'Tā shēngbìng le, zhěngtiān dōu tǎng zài chuáng shang xiūxi.', 'Anh ấy bị ốm, cả ngày đều nằm trên giường nghỉ ngơi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [词] (cí) - từ, từ ngữ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '词',
    'cí',
    'từ, từ ngữ',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这个新词是什么意思？',
    'Zhè ge xīn cí shì shénme yìsi?',
    'Từ mới này có nghĩa là gì vậy?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这个新词是什么意思？', 'Zhè ge xīn cí shì shénme yìsi?', 'Từ mới này có nghĩa là gì vậy?', 'basic', 1),
      (v_id, '学汉语要多积累日常词汇和短语。', 'Xué Hànyǔ yào duō jīlěi rìcháng cíhuì hé duǎnyǔ.', 'Học tiếng Hán cần tích lũy nhiều từ vựng và cụm từ thường nhật.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [从小] (cóngxiǎo) - từ nhỏ, từ bé [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '从小',
    'cóngxiǎo',
    'từ nhỏ, từ bé',
    'Phó từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我从小就喜欢小动物。',
    'Wǒ cóngxiǎo jiù xǐhuan xiǎo dòngwù.',
    'Tôi từ nhỏ đã thích động vật nhỏ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我从小就喜欢小动物。', 'Wǒ cóngxiǎo jiù xǐhuan xiǎo dòngwù.', 'Tôi từ nhỏ đã thích động vật nhỏ.', 'basic', 1),
      (v_id, '他们俩从小就是同一个院子长大的好朋友。', 'Tāmen liǎ cóngxiǎo jiù shì tóng yí ge yuànzi zhǎngdà de hǎo péngyou.', 'Hai người họ từ nhỏ đã là bạn thân lớn lên cùng một khu tập thể.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [打] (dǎ) - đánh, đập, chơi (bóng), gọi (điện thoại) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '打',
    'dǎ',
    'đánh, đập, chơi (bóng), gọi (điện thoại)',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我晚上给你打电话。',
    'Wǒ wǎnshang gěi nǐ dǎ diànhuà.',
    'Tối nay tôi gọi điện thoại cho bạn nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我晚上给你打电话。', 'Wǒ wǎnshang gěi nǐ dǎ diànhuà.', 'Tối nay tôi gọi điện thoại cho bạn nhé.', 'basic', 1),
      (v_id, '周末大家经常一起去操场打羽毛球。', 'Zhōumò dàjiā jīngcháng yìqǐ qù cāochǎng dǎ yǔmáoqiú.', 'Cuối tuần mọi người thường cùng nhau ra sân chơi cầu lông.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [打车] (dǎchē) - bắt taxi, gọi xe [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '打车',
    'dǎchē',
    'bắt taxi, gọi xe',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '时间来不及了，我们打车吧。',
    'Shíjiān láibùjí le, wǒmen dǎchē ba.',
    'Không kịp giờ nữa rồi, chúng mình bắt taxi đi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '时间来不及了，我们打车吧。', 'Shíjiān láibùjí le, wǒmen dǎchē ba.', 'Không kịp giờ nữa rồi, chúng mình bắt taxi đi.', 'basic', 1),
      (v_id, '在下雨天用手机打车可能需要等一会儿。', 'Zài xiàyǔ tiān yòng shǒujī dǎchē kěnéng xūyào děng yíhuìr.', 'Vào ngày trời mưa gọi xe qua điện thoại có thể cần đợi một lát.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [打开] (dǎkāi) - mở ra, bật (thiết bị) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '打开',
    'dǎkāi',
    'mở ra, bật (thiết bị)',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请大家打开书，翻到第十页。',
    'Qǐng dàjiā dǎkāi shū, fān dào dì shí yè.',
    'Mời mọi người mở sách, lật đến trang 10.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请大家打开书，翻到第十页。', 'Qǐng dàjiā dǎkāi shū, fān dào dì shí yè.', 'Mời mọi người mở sách, lật đến trang 10.', 'basic', 1),
      (v_id, '屋里太闷了，把窗户打开透透气吧。', 'Wū lǐ tài mèn le, bǎ chuānghu dǎkāi tòutòuqì ba.', 'Trong nhà bí quá, mở cửa sổ ra cho thoáng khí đi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [但] (dàn) - nhưng, nhưng mà [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '但',
    'dàn',
    'nhưng, nhưng mà',
    'Liên từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '工作虽然累，但我很开心。',
    'Gōngzuò suīrán lèi, dàn wǒ hěn kāixīn.',
    'Công việc tuy mệt, nhưng tôi rất vui vẻ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '工作虽然累，但我很开心。', 'Gōngzuò suīrán lèi, dàn wǒ hěn kāixīn.', 'Công việc tuy mệt, nhưng tôi rất vui vẻ.', 'basic', 1),
      (v_id, '这件衣服很好看，但价格稍微有点贵。', 'Zhè jiàn yīfu hěn hǎokàn, dàn jiàgé shāowēi yǒudiǎnr guì.', 'Bộ quần áo này rất đẹp, nhưng giá hơi đắt một chút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [但是] (dànshì) - nhưng mà, thế nhưng [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '但是',
    'dànshì',
    'nhưng mà, thế nhưng',
    'Liên từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他很想去，但是没有时间。',
    'Tā hěn xiǎng qù, dànshì méiyǒu shíjiān.',
    'Anh ấy rất muốn đi, nhưng mà không có thời gian.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他很想去，但是没有时间。', 'Tā hěn xiǎng qù, dànshì méiyǒu shíjiān.', 'Anh ấy rất muốn đi, nhưng mà không có thời gian.', 'basic', 1),
      (v_id, '虽然汉语很难学，但是大家都很认真。', 'Suīrán Hànyǔ hěn nán xué, dànshì dàjiā dōu hěn rènzhēn.', 'Tuy rằng tiếng Hán khó học, nhưng mà mọi người đều rất chăm chỉ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [地] (de) - một cách (trợ từ trạng ngữ) [Trợ từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '地',
    'de',
    'một cách (trợ từ trạng ngữ)',
    'Trợ từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '小鸟高兴地唱着歌。',
    'Xiǎoniǎo gāoxìng de chàngzhe gē.',
    'Chú chim non vui vẻ hót ca.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '小鸟高兴地唱着歌。', 'Xiǎoniǎo gāoxìng de chàngzhe gē.', 'Chú chim non vui vẻ hót ca.', 'basic', 1),
      (v_id, '听到好消息，大家都开心地笑了起来。', 'Tīng dào hǎo xiāoxi, dàjiā dōu kāixīn de xiào le qǐlai.', 'Nghe được tin tốt, mọi người đều cười rạng rỡ một cách vui vẻ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [等] (děng) - chờ, đợi [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '等',
    'děng',
    'chờ, đợi',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请在这里等我五分钟。',
    'Qǐng zài zhèlǐ děng wǒ wǔ fēnzhōng.',
    'Xin hãy ở đây đợi tôi năm phút nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请在这里等我五分钟。', 'Qǐng zài zhèlǐ děng wǒ wǔ fēnzhōng.', 'Xin hãy ở đây đợi tôi năm phút nhé.', 'basic', 1),
      (v_id, '等雨停了，我们再一起出门去公园吧。', 'Děng yǔ tíng le, wǒmen zài yìqǐ chūmén qù gōngyuán ba.', 'Đợi trời tạnh mưa rồi chúng mình cùng ra công viên nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [地铁] (dìtiě) - tàu điện ngầm [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '地铁',
    'dìtiě',
    'tàu điện ngầm',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我每天坐地铁去公司。',
    'Wǒ měitiān zuò dìtiě qù gōngsī.',
    'Tôi mỗi ngày đều đi tàu điện ngầm đến công ty.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我每天坐地铁去公司。', 'Wǒ měitiān zuò dìtiě qù gōngsī.', 'Tôi mỗi ngày đều đi tàu điện ngầm đến công ty.', 'basic', 1),
      (v_id, '坐地铁既准时又不会遇到堵车。', 'Zuò dìtiě jì zhǔnshí yòu bú huì yù dào dǔchē.', 'Đi tàu điện ngầm vừa đúng giờ lại không bao giờ gặp tắc đường.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [点] (diǎn) - gọi món, điểm món, chọn [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '点',
    'diǎn',
    'gọi món, điểm món, chọn',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '服务员，我们要点菜。',
    'Fúwùyuán, wǒmen yào diǎncài.',
    'Phục vụ ơi, chúng tôi muốn gọi món.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '服务员，我们要点菜。', 'Fúwùyuán, wǒmen yào diǎncài.', 'Phục vụ ơi, chúng tôi muốn gọi món.', 'basic', 1),
      (v_id, '你喜欢吃辣的吗？今天你来点菜吧。', 'Nǐ xǐhuan chī là de ma? Jīntiān nǐ lái diǎncài ba.', 'Bạn thích ăn cay không? Hôm nay bạn gọi món nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [动] (dòng) - cử động, chuyển động, chạm vào [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '动',
    'dòng',
    'cử động, chuyển động, chạm vào',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '别动，让我看看你的眼睛。',
    'Bié dòng, ràng wǒ kànkan nǐ de yǎnjing.',
    'Đừng cử động, để tôi xem mắt của bạn nào.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '别动，让我看看你的眼睛。', 'Bié dòng, ràng wǒ kànkan nǐ de yǎnjing.', 'Đừng cử động, để tôi xem mắt của bạn nào.', 'basic', 1),
      (v_id, '爬完山之后，我累得连腿都动不了了。', 'Pá wán shān zhīhòu, wǒ lèi de lián tuǐ dōu dòng bù liǎo le.', 'Sau khi leo núi xong, tôi mệt đến mức chân cũng không nhấc nổi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [饭馆] (fànguǎn) - quán ăn, nhà hàng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '饭馆',
    'fànguǎn',
    'quán ăn, nhà hàng',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '学校旁边有一家好吃的饭馆。',
    'Xuéxiào pángbiān yǒu yì jiā hǎochī de fànguǎn.',
    'Bên cạnh trường học có một quán ăn rất ngon.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '学校旁边有一家好吃的饭馆。', 'Xuéxiào pángbiān yǒu yì jiā hǎochī de fànguǎn.', 'Bên cạnh trường học có một quán ăn rất ngon.', 'basic', 1),
      (v_id, '今天晚上我们去那家中餐馆聚餐吧。', 'Jīntiān wǎnshang wǒmen qù nà jiā Zhōngcān guǎn jùcān ba.', 'Tối nay chúng mình đến quán đồ Trung đó liên hoan nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [飞] (fēi) - bay [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '飞',
    'fēi',
    'bay',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '天空中有很多小鸟在飞。',
    'Tiānkōng zhōng yǒu hěn duō xiǎoniǎo zài fēi.',
    'Trên bầu trời có rất nhiều chú chim đang bay lượn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '天空中有很多小鸟在飞。', 'Tiānkōng zhōng yǒu hěn duō xiǎoniǎo zài fēi.', 'Trên bầu trời có rất nhiều chú chim đang bay lượn.', 'basic', 1),
      (v_id, '明天上午十点我们将飞往上海参加会议。', 'Míngtiān shàngwǔ shí diǎn wǒmen jiāng fēi wǎng Shànghǎi cānjiā huìyì.', 'Mười giờ sáng mai chúng tôi sẽ bay tới Thượng Hải tham gia hội nghị.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [高中] (gāozhōng) - trường trung học phổ thông, cấp 3 [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '高中',
    'gāozhōng',
    'trường trung học phổ thông, cấp 3',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他是一名高中学生。',
    'Tā shì yì míng gāozhōng xuésheng.',
    'Em ấy là một học sinh cấp ba.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他是一名高中学生。', 'Tā shì yì míng gāozhōng xuésheng.', 'Em ấy là một học sinh cấp ba.', 'basic', 1),
      (v_id, '高中毕业后，很多同学都考上了理想的大学。', 'Gāozhōng bìyè hòu, hěn duō tóngxué dōu kǎoshàng le lǐxiǎng de dàxué.', 'Sau khi tốt nghiệp cấp 3, nhiều bạn cùng lớp đã thi đỗ trường đại học mơ ước.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [个子] (gèzi) - dáng vóc, chiều cao [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '个子',
    'gèzi',
    'dáng vóc, chiều cao',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他的个子比我高一点儿。',
    'Tā de gèzi bǐ wǒ gāo yìdiǎnr.',
    'Chiều cao của anh ấy cao hơn tôi một chút.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他的个子比我高一点儿。', 'Tā de gèzi bǐ wǒ gāo yìdiǎnr.', 'Chiều cao của anh ấy cao hơn tôi một chút.', 'basic', 1),
      (v_id, '弟弟虽然年纪还小，但是个子长得很快。', 'Dìdi suīrán niánjì hái xiǎo, dànshì gèzi zhǎng de hěn kuài.', 'Em trai tuy tuổi còn nhỏ nhưng vóc dáng lớn rất nhanh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [跟] (gēn) - cùng, với, theo [Giới từ / Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '跟',
    'gēn',
    'cùng, với, theo',
    'Giới từ / Liên từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我想跟你一起去图书馆。',
    'Wǒ xiǎng gēn nǐ yìqǐ qù túshūguǎn.',
    'Tôi muốn cùng với bạn đến thư viện.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我想跟你一起去图书馆。', 'Wǒ xiǎng gēn nǐ yìqǐ qù túshūguǎn.', 'Tôi muốn cùng với bạn đến thư viện.', 'basic', 1),
      (v_id, '请大家跟着老师大声读课文。', 'Qǐng dàjiā gēnzhe lǎoshī dàshēng dú kèwén.', 'Xin mời mọi người đọc to bài học theo giáo viên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [公交车] (gōngjiāochē) - xe buýt công cộng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '公交车',
    'gōngjiāochē',
    'xe buýt công cộng',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '坐公交车很便宜。',
    'Zuò gōngjiāochē hěn piányi.',
    'Đi xe buýt rất rẻ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '坐公交车很便宜。', 'Zuò gōngjiāochē hěn piányi.', 'Đi xe buýt rất rẻ.', 'basic', 1),
      (v_id, '每天早高峰公交车上的人都非常多。', 'Měitiān zǎogāofēng gōngjiāochē shang de rén dōu fēicháng duō.', 'Mỗi buổi sáng giờ cao điểm người trên xe buýt đều rất đông.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [过] (guò) - qua, đón (sinh nhật, tết), trải qua [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '过',
    'guò',
    'qua, đón (sinh nhật, tết), trải qua',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '今天我过生日，大家一起来庆祝吧。',
    'Jīntiān wǒ guò shēngrì, dàjiā yìqǐ lái qìngzhù ba.',
    'Hôm nay tôi đón sinh nhật, mọi người cùng đến chúc mừng nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '今天我过生日，大家一起来庆祝吧。', 'Jīntiān wǒ guò shēngrì, dàjiā yìqǐ lái qìngzhù ba.', 'Hôm nay tôi đón sinh nhật, mọi người cùng đến chúc mừng nhé.', 'basic', 1),
      (v_id, '过马路的时候一定要看红绿灯。', 'Guò mǎlù de shíhou yídìng yào kàn hónglǜdēng.', 'Lúc băng qua đường nhất định phải chú ý đèn giao thông.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [过来] (guòlai) - qua đây, lại đây [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '过来',
    'guòlai',
    'qua đây, lại đây',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请你过来一下好吗？',
    'Qǐng nǐ guòlai yíxià hǎo ma?',
    'Xin mời bạn qua đây một lát được không?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请你过来一下好吗？', 'Qǐng nǐ guòlai yíxià hǎo ma?', 'Xin mời bạn qua đây một lát được không?', 'basic', 1),
      (v_id, '看到小狗跑过来，孩子们高兴地鼓掌。', 'Kàndào xiǎogǒu pǎo guòlai, háizimen gāoxìng de gǔzhǎng.', 'Trông thấy cún con chạy lại đây, các em nhỏ vui mừng vỗ tay.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [过年] (guònián) - ăn tết, đón năm mới [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '过年',
    'guònián',
    'ăn tết, đón năm mới',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '过年好！祝大家身体健康！',
    'Guònián hǎo! Zhù dàjiā shēntǐ jiànkāng!',
    'Chúc mừng năm mới! Chúc mọi người dồi dào sức khỏe!'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '过年好！祝大家身体健康！', 'Guònián hǎo! Zhù dàjiā shēntǐ jiànkāng!', 'Chúc mừng năm mới! Chúc mọi người dồi dào sức khỏe!', 'basic', 1),
      (v_id, '快要过年了，漂泊在外的人都要回家团圆。', 'Kuàiyào guònián le, piāobó zài wài de rén dōu yào huíjiā tuányuán.', 'Sắp tết rồi, những người con xa xứ đều trở về nhà sum họp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [过去] (guòqù) - đi qua đó; quá khứ, trước kia [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '过去',
    'guòqù',
    'đi qua đó; quá khứ, trước kia',
    'Động từ / Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '绿灯亮了，我们可以走过去了。',
    'Lǜdēng liàng le, wǒmen kěyǐ zǒu guòqù le.',
    'Đèn xanh sáng rồi, chúng mình có thể đi qua đường rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '绿灯亮了，我们可以走过去了。', 'Lǜdēng liàng le, wǒmen kěyǐ zǒu guòqù le.', 'Đèn xanh sáng rồi, chúng mình có thể đi qua đường rồi.', 'basic', 1),
      (v_id, '忘掉过去的不愉快，开始美好的新生活吧。', 'Wàngdiào guòqù de bù yúkuài, kāishǐ měihǎo de xīn shēnghuó ba.', 'Hãy quên đi những muộn phiền trong quá khứ và bắt đầu cuộc sống mới tốt đẹp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [过] (guo) - từng, đã từng (trợ từ động thái biểu thị kinh nghiệm) [Trợ từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '过',
    'guo',
    'từng, đã từng (trợ từ động thái biểu thị kinh nghiệm)',
    'Trợ từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '你去过中国吗？',
    'Nǐ qù guo Zhōngguó ma?',
    'Bạn đã từng đi Trung Quốc chưa?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '你去过中国吗？', 'Nǐ qù guo Zhōngguó ma?', 'Bạn đã từng đi Trung Quốc chưa?', 'basic', 1),
      (v_id, '这本小说我以前读过，情节非常有意思。', 'Zhè běn xiǎoshuō wǒ yǐqián dú guo, qíngjié fēicháng yǒu yìsi.', 'Cuốn tiểu thuyết này trước đây tôi từng đọc rồi, tình tiết rất thú vị.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [还是] (háishì) - hay là, vẫn là, hoặc là [Phó từ / Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '还是',
    'háishì',
    'hay là, vẫn là, hoặc là',
    'Phó từ / Liên từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '你想喝咖啡还是喝茶？',
    'Nǐ xiǎng hē kāfēi háishì hē chá?',
    'Bạn muốn uống cà phê hay là uống trà?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '你想喝咖啡还是喝茶？', 'Nǐ xiǎng hē kāfēi háishì hē chá?', 'Bạn muốn uống cà phê hay là uống trà?', 'basic', 1),
      (v_id, '虽然天气不太好，我们还是按时出发了。', 'Suīrán tiānqì bú tài hǎo, wǒmen háishì ànshí chūfā le.', 'Tuy rằng thời tiết không được tốt, chúng tôi vẫn xuất phát đúng giờ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [黑色] (hēisè) - màu đen [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '黑色',
    'hēisè',
    'màu đen',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他今天穿了一双黑色的鞋子。',
    'Tā jīntiān chuān le yì shuāng hēisè de xiézi.',
    'Hôm nay anh ấy đi một đôi giày màu đen.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他今天穿了一双黑色的鞋子。', 'Tā jīntiān chuān le yì shuāng hēisè de xiézi.', 'Hôm nay anh ấy đi một đôi giày màu đen.', 'basic', 1),
      (v_id, '这辆黑色的轿车开得很平稳。', 'Zhè liàng hēisè de jiàochē kāi de hěn píngwěn.', 'Chiếc xe hơi màu đen này chạy rất êm ái.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [红茶] (hóngchá) - trà đen, hồng trà [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '红茶',
    'hóngchá',
    'trà đen, hồng trà',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我想喝一杯热红茶。',
    'Wǒ xiǎng hē yì bēi rè hóngchá.',
    'Tôi muốn uống một tách hồng trà nóng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我想喝一杯热红茶。', 'Wǒ xiǎng hē yì bēi rè hóngchá.', 'Tôi muốn uống một tách hồng trà nóng.', 'basic', 1),
      (v_id, '午后喝点红茶吃些点心非常惬意。', 'Wǔhòu hē diǎnr hóngchá chī xiē diǎnxin fēicháng qièyì.', 'Buổi chiều uống chút hồng trà ăn chút điểm tâm thật là dễ chịu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [红色] (hóngsè) - màu đỏ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '红色',
    'hóngsè',
    'màu đỏ',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '妹妹选了一条红色的裙子。',
    'Mèimei xuǎn le yì tiáo hóngsè de qúnzi.',
    'Em gái đã chọn một chiếc váy màu đỏ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '妹妹选了一条红色的裙子。', 'Mèimei xuǎn le yì tiáo hóngsè de qúnzi.', 'Em gái đã chọn một chiếc váy màu đỏ.', 'basic', 1),
      (v_id, '在中国文化中，红色代表着喜庆和吉祥。', 'Zài Zhōngguó wénhuà zhōng, hóngsè dàibiǎo zhe xǐqìng hé jíxiáng.', 'Trong văn hóa Trung Hoa, màu đỏ tượng trưng cho hỷ sự và cát tường.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [花] (huā) - hoa, bông hoa; tiêu (tiền), tốn (thời gian) [Danh từ / Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '花',
    'huā',
    'hoa, bông hoa; tiêu (tiền), tốn (thời gian)',
    'Danh từ / Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '公园里开满了五颜六色的花。',
    'Gōngyuán lǐ kāi mǎn le wǔyánliùsè de huā.',
    'Trong công viên nở đầy những bông hoa muôn màu muôn vẻ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '公园里开满了五颜六色的花。', 'Gōngyuán lǐ kāi mǎn le wǔyánliùsè de huā.', 'Trong công viên nở đầy những bông hoa muôn màu muôn vẻ.', 'basic', 1),
      (v_id, '买这台电脑花了我一个月的工资。', 'Mǎi zhè tái diànnǎo huā le wǒ yí ge yuè de gōngzī.', 'Mua chiếc máy tính này tốn mất một tháng tiền lương của tôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [画] (huà) - vẽ; bức tranh, họa phẩm [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '画',
    'huà',
    'vẽ; bức tranh, họa phẩm',
    'Động từ / Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他在纸上画了一只可爱的小猫。',
    'Tā zài zhǐ shang huà le yì zhī kě&#x27;ài de xiǎomāo.',
    'Em ấy vẽ một chú mèo nhỏ đáng yêu trên trang giấy.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他在纸上画了一只可爱的小猫。', 'Tā zài zhǐ shang huà le yì zhī kě&#x27;ài de xiǎomāo.', 'Em ấy vẽ một chú mèo nhỏ đáng yêu trên trang giấy.', 'basic', 1),
      (v_id, '墙上挂着一幅中国山水画。', 'Qiáng shang guà zhe yì fú Zhōngguó shānshuǐhuà.', 'Trên tường có treo một bức tranh sơn thủy Trung Quốc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [坏] (huài) - hỏng, xấu, tệ [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '坏',
    'huài',
    'hỏng, xấu, tệ',
    'Tính từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我的手机坏了，需要去修。',
    'Wǒ de shǒujī huài le, xūyào qù xiū.',
    'Điện thoại của tôi bị hỏng rồi, cần phải đi sửa.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我的手机坏了，需要去修。', 'Wǒ de shǒujī huài le, xūyào qù xiū.', 'Điện thoại của tôi bị hỏng rồi, cần phải đi sửa.', 'basic', 1),
      (v_id, '牛奶放太久变坏了，千万不能喝。', 'Niúnǎi fàng tài jiǔ biàn huài le, qiānwàn bù néng hē.', 'Sữa để quá lâu bị hỏng rồi, tuyệt đối không được uống.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [回来] (huílai) - trở về, về đây [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '回来',
    'huílai',
    'trở về, về đây',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '爸爸什么时候回来？',
    'Bàba shénme shíhou huílai?',
    'Khi nào thì bố trở về vậy?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '爸爸什么时候回来？', 'Bàba shénme shíhou huílai?', 'Khi nào thì bố trở về vậy?', 'basic', 1),
      (v_id, '他出差一个月，今天下午终于回到家了。', 'Tā chūchāi yí ge yuè, jīntiān xiàwǔ zhōngyú huí dào jiā le.', 'Anh ấy đi công tác một tháng, chiều nay cuối cùng đã trở về đến nhà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [回去] (huíqù) - trở về, về đó [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '回去',
    'huíqù',
    'trở về, về đó',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '时间不早了，我们快回去吧。',
    'Shíjiān bù zǎo le, wǒmen kuài huíqù ba.',
    'Thời gian không còn sớm nữa rồi, chúng mình mau về thôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '时间不早了，我们快回去吧。', 'Shíjiān bù zǎo le, wǒmen kuài huíqù ba.', 'Thời gian không còn sớm nữa rồi, chúng mình mau về thôi.', 'basic', 1),
      (v_id, '天快黑了，你一个人回去路上要多加小心。', 'Tiān kuài hēi le, nǐ yí ge rén huíqù lù shang yào duōjiā xiǎoxīn.', 'Trời sắp tối rồi, bạn một mình về đường nhớ cẩn thận nhiều nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [机票] (jīpiào) - vé máy bay [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '机票',
    'jīpiào',
    'vé máy bay',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我已经订好下周去北京的机票了。',
    'Wǒ yǐjīng dìng hǎo xià zhōu qù Běijīng de jīpiào le.',
    'Tôi đã đặt xong vé máy bay đi Bắc Kinh vào tuần tới rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我已经订好下周去北京的机票了。', 'Wǒ yǐjīng dìng hǎo xià zhōu qù Běijīng de jīpiào le.', 'Tôi đã đặt xong vé máy bay đi Bắc Kinh vào tuần tới rồi.', 'basic', 1),
      (v_id, '提前一个月买机票通常会便宜很多。', 'Tíqián yí ge yuè mǎi jīpiào tōngcháng huì piányi hěn duō.', 'Mua vé máy bay trước một tháng thông thường sẽ rẻ hơn rất nhiều.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [记得] (jìde) - nhớ, còn nhớ [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '记得',
    'jìde',
    'nhớ, còn nhớ',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '你还记得他的电话号码吗？',
    'Nǐ hái jìde tā de diànhuà hàomǎ ma?',
    'Bạn còn nhớ số điện thoại của anh ấy không?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '你还记得他的电话号码吗？', 'Nǐ hái jìde tā de diànhuà hàomǎ ma?', 'Bạn còn nhớ số điện thoại của anh ấy không?', 'basic', 1),
      (v_id, '虽然过去了很多年，我依然记得老师讲过的话。', 'Suīrán guòqù le hěn duō nián, wǒ yīrán jìde lǎoshī jiǎng guo de huà.', 'Tuy rằng nhiều năm đã trôi qua, tôi vẫn nhớ như in lời thầy cô đã dạy.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [间] (jiān) - gian, căn (lượng từ cho phòng) [Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '间',
    'jiān',
    'gian, căn (lượng từ cho phòng)',
    'Lượng từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我家有三间卧室。',
    'Wǒ jiā yǒu sān jiān wòshì.',
    'Nhà tôi có ba căn phòng ngủ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我家有三间卧室。', 'Wǒ jiā yǒu sān jiān wòshì.', 'Nhà tôi có ba căn phòng ngủ.', 'basic', 1),
      (v_id, '学校新建了一间宽敞明亮的计算机教室。', 'Xuéxiào xīn jiàn le yì jiān kuānchang míngliàng de jìsuànjī jiàoshì.', 'Trường học vừa xây mới một phòng học tin học rộng rãi và sáng sủa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [教] (jiāo) - dạy, giảng dạy [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '教',
    'jiāo',
    'dạy, giảng dạy',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '王老师教我们中文。',
    'Wáng lǎoshī jiāo wǒmen Zhōngwén.',
    'Thầy Vương dạy chúng tôi tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '王老师教我们中文。', 'Wáng lǎoshī jiāo wǒmen Zhōngwén.', 'Thầy Vương dạy chúng tôi tiếng Trung.', 'basic', 1),
      (v_id, '你能教我怎么用这个电脑软件吗？', 'Nǐ néng jiāo wǒ zěnme yòng zhè ge diànnǎo ruǎnjiàn ma?', 'Bạn có thể chỉ cho tôi cách dùng phần mềm máy tính này không?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [进来] (jìnlai) - vào đây, bước vào [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '进来',
    'jìnlai',
    'vào đây, bước vào',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请进，外面冷，快进来坐。',
    'Qǐng jìn, wàimiàn lěng, kuài jìnlai zuò.',
    'Mời vào, bên ngoài lạnh lắm, mau vào trong ngồi đi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请进，外面冷，快进来坐。', 'Qǐng jìn, wàimiàn lěng, kuài jìnlai zuò.', 'Mời vào, bên ngoài lạnh lắm, mau vào trong ngồi đi.', 'basic', 1),
      (v_id, '他敲了敲门，然后推开门轻轻地走了进来。', 'Tā qiāo le qiāo mén, ránhòu tuīkāi mén qīngqīng de zǒu le jìnlai.', 'Anh ấy gõ gõ cửa, rồi đẩy cửa nhẹ nhàng bước vào.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [进去] (jìnqù) - đi vào trong, bước vào đó [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '进去',
    'jìnqù',
    'đi vào trong, bước vào đó',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '电影快开始了，我们快进去吧。',
    'Diànyǐng kuài kāishǐ le, wǒmen kuài jìnqù ba.',
    'Phim sắp chiếu rồi, chúng mình mau vào trong rạp thôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '电影快开始了，我们快进去吧。', 'Diànyǐng kuài kāishǐ le, wǒmen kuài jìnqù ba.', 'Phim sắp chiếu rồi, chúng mình mau vào trong rạp thôi.', 'basic', 1),
      (v_id, '图书馆里面很安静，请大家进去后不要大声说话。', 'Túshūguǎn lǐmiàn hěn ānjìng, qǐng dàjiā jìnqù hòu búyào dàshēng shuōhuà.', 'Bên trong thư viện rất yên tĩnh, xin mọi người sau khi vào chớ nói lớn tiếng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [经常] (jīngcháng) - thường xuyên, thường hay [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '经常',
    'jīngcháng',
    'thường xuyên, thường hay',
    'Phó từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我周末经常去图书馆看书。',
    'Wǒ zhōumò jīngcháng qù túshūguǎn kànshū.',
    'Cuối tuần tôi thường hay đến thư viện đọc sách.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我周末经常去图书馆看书。', 'Wǒ zhōumò jīngcháng qù túshūguǎn kànshū.', 'Cuối tuần tôi thường hay đến thư viện đọc sách.', 'basic', 1),
      (v_id, '经常锻炼身体有助于增强体质和预防疾病。', 'Jīngcháng duànliàn shēntǐ yǒu zhù yú zēngqiáng tǐzhì hé yùfáng jíbìng.', 'Thường xuyên rèn luyện thân thể giúp nâng cao thể chất và phòng ngừa bệnh tật.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [酒店] (jiǔdiàn) - khách sạn [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '酒店',
    'jiǔdiàn',
    'khách sạn',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这家酒店的环境很好。',
    'Zhè jiā jiǔdiàn de huánjìng hěn hǎo.',
    'Môi trường cảnh quan của khách sạn này rất tốt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这家酒店的环境很好。', 'Zhè jiā jiǔdiàn de huánjìng hěn hǎo.', 'Môi trường cảnh quan của khách sạn này rất tốt.', 'basic', 1),
      (v_id, '我们在网上预订了一家靠近海滩的度假酒店。', 'Wǒmen zài wǎngshang yùdìng le yì jiā kàojìn hǎitān de dùjià jiǔdiàn.', 'Chúng tôi đã đặt phòng trên mạng ở một khách sạn nghỉ dưỡng gần bãi biển.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [开学] (kāixué) - khai giảng, tựu trường [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '开学',
    'kāixué',
    'khai giảng, tựu trường',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '下个星期一我们就要开学了。',
    'Xià ge xīngqīyī wǒmen jiù yào kāixué le.',
    'Thứ hai tuần tới chúng mình sẽ tựu trường rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '下个星期一我们就要开学了。', 'Xià ge xīngqīyī wǒmen jiù yào kāixué le.', 'Thứ hai tuần tới chúng mình sẽ tựu trường rồi.', 'basic', 1),
      (v_id, '开学第一天，同学们兴奋地聚在一起分享假期趣事。', 'Kāixué dì-yī tiān, tóngxuémen xīngfèn de jù zài yìqǐ fēnxiǎng jiàqī qùshì.', 'Ngày đầu khai giảng, các bạn học hào hứng tụ tập chia sẻ những chuyện vui trong kỳ nghỉ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [考] (kǎo) - thi, kiểm tra [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '考',
    'kǎo',
    'thi, kiểm tra',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '明天我们要考汉语听力。',
    'Míngtiān wǒmen yào kǎo Hànyǔ tīnglì.',
    'Ngày mai chúng mình sẽ thi nghe tiếng Hán.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '明天我们要考汉语听力。', 'Míngtiān wǒmen yào kǎo Hànyǔ tīnglì.', 'Ngày mai chúng mình sẽ thi nghe tiếng Hán.', 'basic', 1),
      (v_id, '只要平时认真复习，考试就一定能考出好成绩。', 'Zhǐyào píngshí rènzhēn fùxí, kǎoshì jiù yídìng néng kǎo chū hǎo chéngjì.', 'Chỉ cần bình thường chăm chỉ ôn tập, khi đi thi nhất định sẽ đạt kết quả tốt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [裤子] (kùzi) - quần, chiếc quần [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '裤子',
    'kùzi',
    'quần, chiếc quần',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这条裤子太长了。',
    'Zhè tiáo kùzi tài cháng le.',
    'Chiếc quần này dài quá rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这条裤子太长了。', 'Zhè tiáo kùzi tài cháng le.', 'Chiếc quần này dài quá rồi.', 'basic', 1),
      (v_id, '他穿了一条深蓝色的牛仔裤，显得很精神。', 'Tā chuān le yì tiáo shēnlánsè de niúzǎikù, xiǎnde hěn jīngshen.', 'Anh ấy mặc một chiếc quần bò màu xanh đậm, trông rất khỏe khoắn và năng động.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [快要] (kuàiyào) - sắp, sắp sửa [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '快要',
    'kuàiyào',
    'sắp, sắp sửa',
    'Phó từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '天阴了，快要下雨了。',
    'Tiān yīn le, kuàiyào xiàyǔ le.',
    'Trời râm mát rồi, sắp sửa mưa to rồi đấy.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '天阴了，快要下雨了。', 'Tiān yīn le, kuàiyào xiàyǔ le.', 'Trời râm mát rồi, sắp sửa mưa to rồi đấy.', 'basic', 1),
      (v_id, '火车快要进站了，请大家拿好行李准备下车。', 'Huǒchē kuàiyào jìn zhàn le, qǐng dàjiā ná hǎo xíngli zhǔnbèi xiàchē.', 'Tàu hỏa sắp vào ga rồi, xin quý khách mang theo hành lý chuẩn bị xuống xe.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [篮球] (lánqiú) - bóng rổ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '篮球',
    'lánqiú',
    'bóng rổ',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '下课后我们去打篮球吧。',
    'Xiàkè hòu wǒmen qù dǎ lánqiú ba.',
    'Sau khi tan học chúng mình đi chơi bóng rổ nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '下课后我们去打篮球吧。', 'Xiàkè hòu wǒmen qù dǎ lánqiú ba.', 'Sau khi tan học chúng mình đi chơi bóng rổ nhé.', 'basic', 1),
      (v_id, '学校的篮球比赛吸引了许多师生前来观看。', 'Xuéxiào de lánqiú bǐsài xīyǐn le xǔduō shīshēng qiánlái guānkàn.', 'Trận thi đấu bóng rổ của trường thu hút đông đảo thầy cô và học sinh tới xem.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [里面] (lǐmiàn) - bên trong, phía trong [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '里面',
    'lǐmiàn',
    'bên trong, phía trong',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '书包里面有很多书。',
    'Shūbāo lǐmiàn yǒu hěn duō shū.',
    'Bên trong cặp sách có rất nhiều cuốn sách.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '书包里面有很多书。', 'Shūbāo lǐmiàn yǒu hěn duō shū.', 'Bên trong cặp sách có rất nhiều cuốn sách.', 'basic', 1),
      (v_id, '屋子里面开着暖气，一点儿也不觉得冷。', 'Wūzi lǐmiàn kāi zhe nuǎnqì, yìdiǎnr yě bù juéde lěng.', 'Bên trong căn phòng có bật máy sưởi, chẳng thấy lạnh chút nào.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [楼] (lóu) - tòa nhà, lầu, tầng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '楼',
    'lóu',
    'tòa nhà, lầu, tầng',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我们家住在五楼。',
    'Wǒmen jiā zhù zài wǔ lóu.',
    'Nhà của chúng tôi ở trên tầng năm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我们家住在五楼。', 'Wǒmen jiā zhù zài wǔ lóu.', 'Nhà của chúng tôi ở trên tầng năm.', 'basic', 1),
      (v_id, '穿过教学楼就是宽阔的操场和体育馆。', 'Chuānguò jiàoxuélóu jiù shì kuānkuò de cāochǎng hé tǐyùguǎn.', 'Đi xuyên qua tòa nhà giảng đường là đến sân vận động và nhà thi đấu rộng lớn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [路上] (lùshang) - trên đường, dọc đường [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '路上',
    'lùshang',
    'trên đường, dọc đường',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '上班路上车很多。',
    'Shàngbān lùshang chē hěn duō.',
    'Trên đường đi làm xe cộ rất đông đúc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '上班路上车很多。', 'Shàngbān lùshang chē hěn duō.', 'Trên đường đi làm xe cộ rất đông đúc.', 'basic', 1),
      (v_id, '下雨天路滑，开车在路上一定要注意安全。', 'Xiàyǔ tiān lù huá, kāichē zài lù shang yídìng yào zhùyì ānquán.', 'Ngày mưa đường trơn, lái xe lưu thông trên đường nhất định phải chú ý an toàn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [绿茶] (lǜchá) - trà xanh [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '绿茶',
    'lǜchá',
    'trà xanh',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '爷爷每天早上都喜欢泡一杯绿茶。',
    'Yéye měitiān zǎoshang dōu xǐhuan pào yì bēi lǜchá.',
    'Ông nội mỗi buổi sáng đều thích pha một tách trà xanh.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '爷爷每天早上都喜欢泡一杯绿茶。', 'Yéye měitiān zǎoshang dōu xǐhuan pào yì bēi lǜchá.', 'Ông nội mỗi buổi sáng đều thích pha một tách trà xanh.', 'basic', 1),
      (v_id, '中国龙井绿茶闻起来有一股清新的香味。', 'Zhōngguó Lóngjǐng lǜchá wén qǐlai yǒu yì gǔ qīngxīn de xiāngwèi.', 'Trà xanh Long Tỉnh Trung Quốc ngửi thấy có một hương thơm dịu mát thanh khiết.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [绿色] (lǜsè) - màu xanh lá cây [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '绿色',
    'lǜsè',
    'màu xanh lá cây',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '春天的树叶都是嫩绿色的。',
    'Chūntiān de shùyè dōu shì nènlǜsè de.',
    'Lá cây mùa xuân đều mang sắc xanh non mơn mởn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '春天的树叶都是嫩绿色的。', 'Chūntiān de shùyè dōu shì nènlǜsè de.', 'Lá cây mùa xuân đều mang sắc xanh non mơn mởn.', 'basic', 1),
      (v_id, '多看绿色的植物对缓解眼睛疲劳很有帮助。', 'Duō kàn lǜsè de zhíwù duì huǎnjiě yǎnjing píláo hěn yǒu bāngzhù.', 'Nhìn nhiều cây xanh thực vật rất có ích cho việc giảm bớt mỏi mắt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [没意思] (méiyìsi) - vô vị, tẻ nhạt, không có ý nghĩa [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '没意思',
    'méiyìsi',
    'vô vị, tẻ nhạt, không có ý nghĩa',
    'Tính từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这部电影太长了，真没意思。',
    'Zhè bù diànyǐng tài cháng le, zhēn méiyìsi.',
    'Bộ phim này dài quá, thực sự rất tẻ nhạt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这部电影太长了，真没意思。', 'Zhè bù diànyǐng tài cháng le, zhēn méiyìsi.', 'Bộ phim này dài quá, thực sự rất tẻ nhạt.', 'basic', 1),
      (v_id, '周末整天呆在家里打游戏挺没意思的，出去走走吧。', 'Zhōumò zhěngtiān dāi zài jiā lǐ dǎ yóuxì tǐng méiyìsi de, chūqù zǒuzou ba.', 'Cuối tuần cả ngày ru rú ở nhà chơi game rất vô vị, hãy ra ngoài dạo chơi đi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [门口] (ménkǒu) - cổng, cửa ra vào [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '门口',
    'ménkǒu',
    'cổng, cửa ra vào',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我们在学校门口见面吧。',
    'Wǒmen zài xuéxiào ménkǒu jiànmiàn ba.',
    'Chúng mình gặp nhau ở ngay cổng trường học nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我们在学校门口见面吧。', 'Wǒmen zài xuéxiào ménkǒu jiànmiàn ba.', 'Chúng mình gặp nhau ở ngay cổng trường học nhé.', 'basic', 1),
      (v_id, '超市门口停放着很多共享单车和电动车。', 'Chāoshì ménkǒu tíngfàng zhe hěn duō gòngxiǎng dānchē hé diàndòngchē.', 'Trước cửa siêu thị có đỗ rất nhiều xe đạp công cộng và xe máy điện.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [门票] (ménpiào) - vé vào cửa, vé vào cổng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '门票',
    'ménpiào',
    'vé vào cửa, vé vào cổng',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这个公园不需要买门票。',
    'Zhè ge gōngyuán bù xūyào mǎi ménpiào.',
    'Công viên này không cần mua vé vào cổng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这个公园不需要买门票。', 'Zhè ge gōngyuán bù xūyào mǎi ménpiào.', 'Công viên này không cần mua vé vào cổng.', 'basic', 1),
      (v_id, '故宫博物院的门票可以在手机上提前预约购买。', 'Gùgōng Bówùyuàn de ménpiào kěyǐ zài shǒujī shang tíqián yùyuē gòumǎi.', 'Vé tham quan Cố Cung có thể đặt trước trực tiếp trên điện thoại di động.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [面] (miàn) - phía, bên, mặt (hậu tố phương vị) [Hậu tố / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '面',
    'miàn',
    'phía, bên, mặt (hậu tố phương vị)',
    'Hậu tố / Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '前面有很多人在排队。',
    'Qiánmiàn yǒu hěn duō rén zài páiduì.',
    'Phía trước có rất nhiều người đang đứng xếp hàng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '前面有很多人在排队。', 'Qiánmiàn yǒu hěn duō rén zài páiduì.', 'Phía trước có rất nhiều người đang đứng xếp hàng.', 'basic', 1),
      (v_id, '大楼的东面是一个漂亮的人工湖。', 'Dàlóu de dōngmiàn shì yí ge piàoliang de réngōnghú.', 'Phía đông của tòa cao ốc là một hồ nước nhân tạo rất đẹp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [名] (míng) - người, vị (lượng từ); tên, danh [Lượng từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '名',
    'míng',
    'người, vị (lượng từ); tên, danh',
    'Lượng từ / Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我们班有一名新同学。',
    'Wǒmen bān yǒu yì míng xīn tóngxué.',
    'Lớp chúng tôi có một bạn học sinh mới.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我们班有一名新同学。', 'Wǒmen bān yǒu yì míng xīn tóngxué.', 'Lớp chúng tôi có một bạn học sinh mới.', 'basic', 1),
      (v_id, '他在这次中文演讲比赛中荣获了第一名。', 'Tā zài zhè cì Zhōngwén yǎnjiǎng bǐsài zhōng rónghuò le dì-yī míng.', 'Anh ấy đã vinh dự giành giải nhất trong cuộc thi hùng biện tiếng Trung lần này.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [拿] (ná) - cầm, lấy, mang [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '拿',
    'ná',
    'cầm, lấy, mang',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请帮我拿一下这本书。',
    'Qǐng bāng wǒ ná yíxià zhè běn shū.',
    'Xin hãy giúp tôi cầm hộ cuốn sách này một lát.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请帮我拿一下这本书。', 'Qǐng bāng wǒ ná yíxià zhè běn shū.', 'Xin hãy giúp tôi cầm hộ cuốn sách này một lát.', 'basic', 1),
      (v_id, '出门的时候别忘了拿钥匙和钱包。', 'Chūmén de shíhou bié wàng le ná yàoshi hé qiánbāo.', 'Khi ra khỏi nhà đừng quên mang theo chìa khóa và ví tiền nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [那么] (nàme) - như thế, đến thế, vậy thì [Đại từ / Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '那么',
    'nàme',
    'như thế, đến thế, vậy thì',
    'Đại từ / Liên từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '今天的天气怎么那么冷？',
    'Jīntiān de tiānqì zěnme nàme lěng?',
    'Hôm nay thời tiết sao mà lạnh đến thế chứ?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '今天的天气怎么那么冷？', 'Jīntiān de tiānqì zěnme nàme lěng?', 'Hôm nay thời tiết sao mà lạnh đến thế chứ?', 'basic', 1),
      (v_id, '既然你决定去北京，那么就好好做准备吧。', 'Jìrán nǐ juédìng qù Běijīng, nàme jiù hǎohāo zuò zhǔnbèi ba.', 'Nếu bạn đã quyết định đi Bắc Kinh, vậy thì hãy chuẩn bị cho thật tốt nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [那样] (nàyàng) - như thế, như vậy, kiểu đó [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '那样',
    'nàyàng',
    'như thế, như vậy, kiểu đó',
    'Đại từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我也想像他那样说一口流利的汉语。',
    'Wǒ yě xiǎng xiàng tā nàyàng shuō yì kǒu liúlì de Hànyǔ.',
    'Tôi cũng muốn nói một giọng tiếng Hán lưu loát giống như anh ấy.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我也想像他那样说一口流利的汉语。', 'Wǒ yě xiǎng xiàng tā nàyàng shuō yì kǒu liúlì de Hànyǔ.', 'Tôi cũng muốn nói một giọng tiếng Hán lưu loát giống như anh ấy.', 'basic', 1),
      (v_id, '做事不能那样马虎，必须认真负责。', 'Zuòshì bù néng nàyàng mǎhu, bìxū rènzhēn fùzé.', 'Làm việc không thể qua loa như thế được, cần phải nghiêm túc và có trách nhiệm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [奶茶] (nǎichá) - trà sữa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '奶茶',
    'nǎichá',
    'trà sữa',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '下午我想喝一杯珍珠奶茶。',
    'Xiàwǔ wǒ xiǎng hē yì bēi zhēnzhū nǎichá.',
    'Buổi chiều tôi muốn uống một ly trà sữa trân châu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '下午我想喝一杯珍珠奶茶。', 'Xiàwǔ wǒ xiǎng hē yì bēi zhēnzhū nǎichá.', 'Buổi chiều tôi muốn uống một ly trà sữa trân châu.', 'basic', 1),
      (v_id, '现在的年轻人都很喜欢相约在奶茶店聊天。', 'Xiànzài de niánqīngrén dōu hěn xǐhuan xiāngyuē zài nǎichádiàn liáotiān.', 'Giới trẻ hiện nay rất thích hẹn hò nhau ở quán trà sữa để trò chuyện.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [奶奶] (nǎinai) - bà nội [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '奶奶',
    'nǎinai',
    'bà nội',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我奶奶今年七十五岁了。',
    'Wǒ nǎinai jīnnián qīshíwǔ suì le.',
    'Bà nội tôi năm nay bảy mươi lăm tuổi rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我奶奶今年七十五岁了。', 'Wǒ nǎinai jīnnián qīshíwǔ suì le.', 'Bà nội tôi năm nay bảy mươi lăm tuổi rồi.', 'basic', 1),
      (v_id, '奶奶做的饭菜是全家最好吃的味道。', 'Nǎinai zuò de fàncài shì quánjiā zuì hǎochī de wèidao.', 'Món ăn bà nội nấu là hương vị thơm ngon nhất của cả gia đình.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [男孩儿] (nánháir) - bé trai, cậu bé [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '男孩儿',
    'nánháir',
    'bé trai, cậu bé',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '那个小男孩儿在公园里放风筝。',
    'Nà ge xiǎo nánháir zài gōngyuán lǐ fàng fēngzheng.',
    'Cậu bé kia đang thả diều trong công viên.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '那个小男孩儿在公园里放风筝。', 'Nà ge xiǎo nánháir zài gōngyuán lǐ fàng fēngzheng.', 'Cậu bé kia đang thả diều trong công viên.', 'basic', 1),
      (v_id, '他是一个性格阳光、乐于助人的懂事男孩儿。', 'Tā shì yí ge xìnggé yángguāng, lèyú zhùrén de dǒngshì nánháir.', 'Cậu ấy là một cậu bé hiểu chuyện, tính cách tươi sáng và rất hay giúp đỡ người khác.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [鸟] (niǎo) - con chim, loài chim [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '鸟',
    'niǎo',
    'con chim, loài chim',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '树上停着两只美丽的鸟。',
    'Shù shang tíng zhe liǎng zhī měilì de niǎo.',
    'Trên cành cây có hai chú chim xinh xắn đang đậu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '树上停着两只美丽的鸟。', 'Shù shang tíng zhe liǎng zhī měilì de niǎo.', 'Trên cành cây có hai chú chim xinh xắn đang đậu.', 'basic', 1),
      (v_id, '清晨森林里传来了各种小鸟清脆悦耳的叫声。', 'Qīngchén sēnlín lǐ chuánlái le gèzhǒng xiǎoniǎo qīngcuì yuè’ěr de jiàoshēng.', 'Sáng sớm trong rừng truyền lại tiếng chim hót líu lo trong trẻo êm tai.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [女孩儿] (nǚháir) - bé gái, cô bé [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '女孩儿',
    'nǚháir',
    'bé gái, cô bé',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '那个小女孩儿笑得很甜。',
    'Nà ge xiǎo nǚháir xiào de hěn tián.',
    'Cô bé kia cười trông rất ngọt ngào.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '那个小女孩儿笑得很甜。', 'Nà ge xiǎo nǚháir xiào de hěn tián.', 'Cô bé kia cười trông rất ngọt ngào.', 'basic', 1),
      (v_id, '穿红色裙子的小女孩儿正在认真地画画。', 'Chuān hóngsè qúnzi de xiǎo nǚháir zhèngzài rènzhēn de huàhuà.', 'Cô bé mặc chiếc váy màu đỏ đang chăm chú ngồi vẽ tranh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [跑] (pǎo) - chạy [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '跑',
    'pǎo',
    'chạy',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他每天早上都在操场跑步。',
    'Tā měitiān zǎoshang dōu zài cāochǎng pǎobù.',
    'Anh ấy mỗi sáng đều chạy bộ ở sân vận động.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他每天早上都在操场跑步。', 'Tā měitiān zǎoshang dōu zài cāochǎng pǎobù.', 'Anh ấy mỗi sáng đều chạy bộ ở sân vận động.', 'basic', 1),
      (v_id, '小狗看见主人回来，飞快地跑了过去。', 'Xiǎogǒu kànjiàn zhǔrén huílai, fēikuài de pǎo le guòqù.', 'Chú cún con thấy chủ về liền chạy vụt tới mừng rỡ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [起来] (qǐlai) - thức dậy; lên (bắt đầu hành động) [Động từ / Hậu tố]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '起来',
    'qǐlai',
    'thức dậy; lên (bắt đầu hành động)',
    'Động từ / Hậu tố',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '今天星期天，他起得很晚。',
    'Jīntiān xīngqītiān, tā qǐ de hěn wǎn.',
    'Hôm nay là chủ nhật, anh ấy ngủ dậy rất muộn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '今天星期天，他起得很晚。', 'Jīntiān xīngqītiān, tā qǐ de hěn wǎn.', 'Hôm nay là chủ nhật, anh ấy ngủ dậy rất muộn.', 'basic', 1),
      (v_id, '听到音乐声，大家都跟着跳起舞来。', 'Tīng dào yīnyuè shēng, dàjiā dōu gēnzhe tiào qǐ wǔ lai.', 'Nghe thấy tiếng nhạc vang lên, mọi người đều nhảy múa theo.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [球] (qiú) - quả bóng, trò chơi bóng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '球',
    'qiú',
    'quả bóng, trò chơi bóng',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '弟弟正在草地上踢球。',
    'Dìdi zhèngzài cǎodì shang tī qiú.',
    'Em trai đang đá bóng trên bãi cỏ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '弟弟正在草地上踢球。', 'Dìdi zhèngzài cǎodì shang tī qiú.', 'Em trai đang đá bóng trên bãi cỏ.', 'basic', 1),
      (v_id, '下课后操场上有很多打球和运动的学生。', 'Xiàkè hòu cāochǎng shang yǒu hěn duō dǎqiú hé yùndòng de xuésheng.', 'Sau giờ tan học trên sân có rất nhiều học sinh chơi bóng và vận động.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [肉] (ròu) - thịt [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '肉',
    'ròu',
    'thịt',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我今天买了一斤牛肉。',
    'Wǒ jīntiān mǎi le yì jīn niúròu.',
    'Hôm nay tôi đã mua nửa cân thịt bò.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我今天买了一斤牛肉。', 'Wǒ jīntiān mǎi le yì jīn niúròu.', 'Hôm nay tôi đã mua nửa cân thịt bò.', 'basic', 1),
      (v_id, '医生建议他平时多吃新鲜蔬菜，少吃油腻的肥肉。', 'Yīshēng jiànyì tā píngshí duō chī xīnxiān shūcài, shǎo chī yóunì de féiròu.', 'Bác sĩ khuyên anh ấy thường ngày nên ăn nhiều rau tươi, ít ăn thịt mỡ ngấy.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [商场] (shāngchǎng) - trung tâm thương mại, khu mua sắm [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '商场',
    'shāngchǎng',
    'trung tâm thương mại, khu mua sắm',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '周末很多市民去商场购物。',
    'Zhōumò hěn duō shìmín qù shāngchǎng gòuwù.',
    'Cuối tuần rất nhiều người dân đi trung tâm thương mại mua sắm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '周末很多市民去商场购物。', 'Zhōumò hěn duō shìmín qù shāngchǎng gòuwù.', 'Cuối tuần rất nhiều người dân đi trung tâm thương mại mua sắm.', 'basic', 1),
      (v_id, '这家新建的商场集餐饮、娱乐和购物于一体。', 'Zhè jiā xīn jiàn de shāngchǎng jí cānyǐn, yúlè hé gòuwù yú yītǐ.', 'Trung tâm mua sắm mới xây này tích hợp ăn uống, giải trí và mua sắm trong một.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [上来] (shànglai) - lên đây, bước lên [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '上来',
    'shànglai',
    'lên đây, bước lên',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '车来了，请大家按顺序上来。',
    'Chē lái le, qǐng dàjiā àn shùnxù shànglai.',
    'Xe tới rồi, xin mọi người lần lượt theo thứ tự bước lên xe.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '车来了，请大家按顺序上来。', 'Chē lái le, qǐng dàjiā àn shùnxù shànglai.', 'Xe tới rồi, xin mọi người lần lượt theo thứ tự bước lên xe.', 'basic', 1),
      (v_id, '我在楼上等你们，坐电梯直接上来吧。', 'Wǒ zài lóushang děng nǐmen, zuò diàntī zhíjiē shànglai ba.', 'Tôi đang ở trên lầu đợi các bạn, hãy đi thang máy thẳng lên đây nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [上面] (shàngmiàn) - bên trên, phía trên [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '上面',
    'shàngmiàn',
    'bên trên, phía trên',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '桌子上面放着一本汉语书。',
    'Zhuōzi shàngmiàn fàng zhe yì běn Hànyǔ shū.',
    'Trên mặt bàn có để một cuốn sách tiếng Hán.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '桌子上面放着一本汉语书。', 'Zhuōzi shàngmiàn fàng zhe yì běn Hànyǔ shū.', 'Trên mặt bàn có để một cuốn sách tiếng Hán.', 'basic', 1),
      (v_id, '货架上面摆放着最新生产的食品。', 'Huòjià shàngmiàn bǎifàng zhe zuìxīn shēngchǎn de shípǐn.', 'Phía trên kệ hàng bày bán những loại thực phẩm mới sản xuất nhất.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [上去] (shàngqù) - đi lên đó, bước lên trên [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '上去',
    'shàngqù',
    'đi lên đó, bước lên trên',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '山很高，我们爬得上去吗？',
    'Shān hěn gāo, wǒmen pá de shàngqù ma?',
    'Ngọn núi cao lắm, chúng mình có trèo lên tới đỉnh nổi không?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '山很高，我们爬得上去吗？', 'Shān hěn gāo, wǒmen pá de shàngqù ma?', 'Ngọn núi cao lắm, chúng mình có trèo lên tới đỉnh nổi không?', 'basic', 1),
      (v_id, '他提着沉重的行李，慢慢地走上了楼。', 'Tā tí zhe chénzhòng de xíngli, mànmàn de zǒu shàng le lóu.', 'Anh ấy xách chiếc vali nặng trĩu, chậm rãi bước lên lầu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [上网] (shàngwǎng) - lên mạng, lướt internet [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '上网',
    'shàngwǎng',
    'lên mạng, lướt internet',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我每天上网查阅学习资料。',
    'Wǒ měitiān shàngwǎng cháyuè xuéxí zīliào.',
    'Tôi mỗi ngày đều lên mạng tra cứu tài liệu học tập.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我每天上网查阅学习资料。', 'Wǒ měitiān shàngwǎng cháyuè xuéxí zīliào.', 'Tôi mỗi ngày đều lên mạng tra cứu tài liệu học tập.', 'basic', 1),
      (v_id, '现代人的日常生活几乎离不开手机上网。', 'Xiàndàirén de rìcháng shēnghuó jīhū lí bù kāi shǒujī shàngwǎng.', 'Cuộc sống thường nhật của con người hiện đại hầu như không thể tách rời việc lướt mạng bằng điện thoại.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [时] (shí) - khi, lúc, thời gian [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '时',
    'shí',
    'khi, lúc, thời gian',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '过马路时要看红绿灯。',
    'Guò mǎlù shí yào kàn hónglǜdēng.',
    'Lúc sang đường phải quan sát đèn giao thông.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '过马路时要看红绿灯。', 'Guò mǎlù shí yào kàn hónglǜdēng.', 'Lúc sang đường phải quan sát đèn giao thông.', 'basic', 1),
      (v_id, '遇到困难时，不要轻易放弃努力。', 'Yù dào kùnnan shí, búyào qīngyì fàngqì nǔlì.', 'Khi đối mặt với khó khăn thử thách, chớ dễ dàng từ bỏ nỗ lực.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [手] (shǒu) - tay, bàn tay [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '手',
    'shǒu',
    'tay, bàn tay',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '吃饭前请记得先洗手。',
    'Chīfàn qián qǐng jìde xiān xǐshǒu.',
    'Trước khi ăn cơm xin nhớ rửa tay sạch sẽ trước.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '吃饭前请记得先洗手。', 'Chīfàn qián qǐng jìde xiān xǐshǒu.', 'Trước khi ăn cơm xin nhớ rửa tay sạch sẽ trước.', 'basic', 1),
      (v_id, '天气太冷了，他的双手都冻得通红。', 'Tiānqì tài lěng le, tā de shuāngshǒu dōu dòng de tōnghóng.', 'Thời tiết buốt giá quá, đôi bàn tay của anh ấy đỏ ửng cả lên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [书包] (shūbāo) - cặp sách, balo học sinh [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '书包',
    'shūbāo',
    'cặp sách, balo học sinh',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我的书包是黑色的。',
    'Wǒ de shūbāo shì hēisè de.',
    'Cặp sách của tôi có màu đen.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我的书包是黑色的。', 'Wǒ de shūbāo shì hēisè de.', 'Cặp sách của tôi có màu đen.', 'basic', 1),
      (v_id, '小学生每天背着沉重的大书包去上学。', 'Xiǎoxuéshēng měitiān bēi zhe chénzhòng de dà shūbāo qù shàngxué.', 'Các em học sinh tiểu học mỗi ngày đều đeo chiếc cặp sách to nặng đến trường.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [舒服] (shūfu) - thoải mái, dễ chịu, khỏe khoắn [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '舒服',
    'shūfu',
    'thoải mái, dễ chịu, khỏe khoắn',
    'Tính từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '今天我身体不太舒服，想请假。',
    'Jīntiān wǒ shēntǐ bú tài shūfu, xiǎng qǐngjià.',
    'Hôm nay trong người tôi không được khỏe, muốn xin nghỉ phép.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '今天我身体不太舒服，想请假。', 'Jīntiān wǒ shēntǐ bú tài shūfu, xiǎng qǐngjià.', 'Hôm nay trong người tôi không được khỏe, muốn xin nghỉ phép.', 'basic', 1),
      (v_id, '坐在软软的沙发上喝热茶特别舒服。', 'Zuò zài ruǎnruǎn de shāfā shang hē rèchá tèbié shūfu.', 'Ngồi trên chiếc ghế sofa êm ái thưởng thức tách trà nóng vô cùng dễ chịu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [虽然] (suīrán) - tuy rằng, mặc dù [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '虽然',
    'suīrán',
    'tuy rằng, mặc dù',
    'Liên từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '虽然外面下着雨，但他还是出门了。',
    'Suīrán wàimiàn xià zhe yǔ, dàn tā háishì chūmén le.',
    'Tuy rằng ngoài trời đang mưa, anh ấy vẫn ra ngoài.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '虽然外面下着雨，但他还是出门了。', 'Suīrán wàimiàn xià zhe yǔ, dàn tā háishì chūmén le.', 'Tuy rằng ngoài trời đang mưa, anh ấy vẫn ra ngoài.', 'basic', 1),
      (v_id, '虽然学汉语并不容易，但他从未想过要放弃。', 'Suīrán xué Hànyǔ bìng bù róngyì, dàn tā cóngwèi xiǎng guo yào fàngqì.', 'Mặc dù học tiếng Hán chẳng hề dễ dàng, nhưng anh ấy chưa từng nghĩ tới việc bỏ cuộc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [所以] (suǒyǐ) - cho nên, vì vậy [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '所以',
    'suǒyǐ',
    'cho nên, vì vậy',
    'Liên từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '因为起晚了，所以我今天迟到了。',
    'Yīnwèi qǐ wǎn le, suǒyǐ wǒ jīntiān chídào le.',
    'Bởi vì dậy muộn, cho nên hôm nay tôi bị trễ giờ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '因为起晚了，所以我今天迟到了。', 'Yīnwèi qǐ wǎn le, suǒyǐ wǒ jīntiān chídào le.', 'Bởi vì dậy muộn, cho nên hôm nay tôi bị trễ giờ.', 'basic', 1),
      (v_id, '他平时学习特别用功，所以这次考试拿到满分。', 'Tā píngshí xuéxí tèbié yònggōng, suǒyǐ zhè cì kǎoshì ná dào mǎnfēn.', 'Bình thường cậu ấy học tập đặc biệt chăm chỉ, vì vậy kỳ thi này đã đạt điểm tối đa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [疼] (téng) - đau, đau nhức; yêu thương [Tính từ / Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '疼',
    'téng',
    'đau, đau nhức; yêu thương',
    'Tính từ / Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我肚子疼，想去医院看医生。',
    'Wǒ dùzi téng, xiǎng qù yīyuàn kàn yīshēng.',
    'Tôi bị đau bụng, muốn đến bệnh viện khám bác sĩ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我肚子疼，想去医院看医生。', 'Wǒ dùzi téng, xiǎng qù yīyuàn kàn yīshēng.', 'Tôi bị đau bụng, muốn đến bệnh viện khám bác sĩ.', 'basic', 1),
      (v_id, '昨晚没睡好，今天一整天头都隐隐作疼。', 'Zuówǎn méi shuì hǎo, jīntiān yì zhěngtiān tóu dōu yǐnyǐn zuòténg.', 'Đêm qua ngủ không ngon, hôm nay cả ngày đầu cứ đau âm ỉ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [踢] (tī) - đá [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '踢',
    'tī',
    'đá',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '男孩子们都很喜欢踢足球。',
    'Nánháizimen dōu hěn xǐhuan tī zúqiú.',
    'Các cậu bé đều rất thích đá bóng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '男孩子们都很喜欢踢足球。', 'Nánháizimen dōu hěn xǐhuan tī zúqiú.', 'Các cậu bé đều rất thích đá bóng.', 'basic', 1),
      (v_id, '走路时不小心踢到了路边的石头，脚趾好疼。', 'Zǒulù shí bù xiǎoxīn tī dào le lùbiān de shítou, jiǎozhǐ hǎo téng.', 'Lúc đi bộ lỡ đá phải hòn đá bên đường, ngón chân đau điếng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [条] (tiáo) - con, chiếc, sợi (lượng từ cho vật dài, hẹp) [Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '条',
    'tiáo',
    'con, chiếc, sợi (lượng từ cho vật dài, hẹp)',
    'Lượng từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '河里有很多条小鱼在游。',
    'Hé lǐ yǒu hěn duō tiáo xiǎoyú zài yóu.',
    'Dưới sông có rất nhiều chú cá nhỏ đang bơi lội.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '河里有很多条小鱼在游。', 'Hé lǐ yǒu hěn duō tiáo xiǎoyú zài yóu.', 'Dưới sông có rất nhiều chú cá nhỏ đang bơi lội.', 'basic', 1),
      (v_id, '这条新修的高速公路非常平坦宽阔。', 'Zhè tiáo xīn xiū de gāosù gōnglù fēicháng píngtǎn kuānkuò.', 'Tuyến đường cao tốc mới xây này rất bằng phẳng và thênh thang.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [头] (tóu) - đầu, mái đầu; con (lượng từ cho gia súc) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '头',
    'tóu',
    'đầu, mái đầu; con (lượng từ cho gia súc)',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他低下头认真地看书。',
    'Tā dī xià tóu rènzhēn de kànshū.',
    'Cậu ấy cúi đầu chăm chú đọc sách.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他低下头认真地看书。', 'Tā dī xià tóu rènzhēn de kànshū.', 'Cậu ấy cúi đầu chăm chú đọc sách.', 'basic', 1),
      (v_id, '农场里养着十几头健壮的奶牛。', 'Nóngchǎng lǐ yǎng zhe shí jǐ tóu jiànzhuàng de nǎiniú.', 'Trong nông trại có nuôi mười mấy con bò sữa khỏe mạnh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [外国] (wàiguó) - nước ngoài, ngoại quốc [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '外国',
    'wàiguó',
    'nước ngoài, ngoại quốc',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '他在外国生活了三年。',
    'Tā zài wàiguó shēnghuó le sān nián.',
    'Anh ấy đã sống ở nước ngoài được ba năm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '他在外国生活了三年。', 'Tā zài wàiguó shēnghuó le sān nián.', 'Anh ấy đã sống ở nước ngoài được ba năm.', 'basic', 1),
      (v_id, '很多外国留学生都喜欢体验中国的传统文化。', 'Hěn duō wàiguó liúxuéshēng dōu xǐhuan tǐyàn Zhōngguó de chuántǒng wénhuà.', 'Rất nhiều lưu học sinh nước ngoài đều thích trải nghiệm văn hóa truyền thống Trung Quốc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [外面] (wàimiàn) - bên ngoài, phía ngoài [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '外面',
    'wàimiàn',
    'bên ngoài, phía ngoài',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '外面风很大，多穿点衣服。',
    'Wàimiàn fēng hěn dà, duō chuān diǎnr yīfu.',
    'Bên ngoài gió to lắm, hãy mặc thêm áo ấm vào nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '外面风很大，多穿点衣服。', 'Wàimiàn fēng hěn dà, duō chuān diǎnr yīfu.', 'Bên ngoài gió to lắm, hãy mặc thêm áo ấm vào nhé.', 'basic', 1),
      (v_id, '窗户外面种着几棵郁郁葱葱的树。', 'Chuānghu wàimiàn zhòng zhe jǐ kē yùyùcōngcōng de shù.', 'Bên ngoài cửa sổ có trồng mấy cây xanh tươi tốt um tùm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [万] (wàn) - vạn, mười nghìn (10.000) [Số từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '万',
    'wàn',
    'vạn, mười nghìn (10.000)',
    'Số từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这辆汽车花了十万元。',
    'Zhè liàng qìchē huā le shí wàn yuán.',
    'Chiếc xe hơi này mua hết mười vạn tệ (100.000 NDT).'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这辆汽车花了十万元。', 'Zhè liàng qìchē huā le shí wàn yuán.', 'Chiếc xe hơi này mua hết mười vạn tệ (100.000 NDT).', 'basic', 1),
      (v_id, '这座图书馆藏书超过两百万册。', 'Zhè zuò túshūguǎn cángshū chāoguò liǎng bǎi wàn cè.', 'Thư viện này lưu trữ lượng sách vượt hơn hai triệu cuốn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [网上] (wǎngshang) - trên mạng internet [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '网上',
    'wǎngshang',
    'trên mạng internet',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我在网上买了一双鞋。',
    'Wǒ zài wǎngshang mǎi le yì shuāng xié.',
    'Tôi đã mua một đôi giày ở trên mạng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我在网上买了一双鞋。', 'Wǒ zài wǎngshang mǎi le yì shuāng xié.', 'Tôi đã mua một đôi giày ở trên mạng.', 'basic', 1),
      (v_id, '现在人们可以通过网上银行方便地办理转账业务。', 'Xiànzài rénmen kěyǐ tōngguò wǎngshang yínháng fāngbiàn de bànlǐ zhuǎnzhàng yèwù.', 'Ngày nay mọi người có thể thông qua ngân hàng trực tuyến thuận tiện chuyển tiền.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [忘] (wàng) - quên [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '忘',
    'wàng',
    'quên',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我忘了带雨伞。',
    'Wǒ wàng le dài yǔsǎn.',
    'Tôi quên mang theo ô rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我忘了带雨伞。', 'Wǒ wàng le dài yǔsǎn.', 'Tôi quên mang theo ô rồi.', 'basic', 1),
      (v_id, '请别忘了明天早上的班级会议。', 'Qǐng bié wàng le míngtiān zǎoshang de bānjí huìyì.', 'Xin chớ quên buổi họp lớp vào sáng ngày mai nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [位] (wèi) - vị, ngài (lượng từ lịch sự cho người) [Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '位',
    'wèi',
    'vị, ngài (lượng từ lịch sự cho người)',
    'Lượng từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请问有几位客人？',
    'Qǐngwèn yǒu jǐ wèi kèrén?',
    'Xin hỏi quý khách đi mấy vị ạ?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请问有几位客人？', 'Qǐngwèn yǒu jǐ wèi kèrén?', 'Xin hỏi quý khách đi mấy vị ạ?', 'basic', 1),
      (v_id, '这位老教授在医学领域享有极高的声誉。', 'Zhè wèi lǎo jiàoshòu zài yīxué lǐngyù xiǎngyǒu jí gāo de shēngyù.', 'Vị giáo sư già này có uy tín vô cùng cao trong lĩnh vực y học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [洗手间] (xǐshǒujiān) - nhà vệ sinh, phòng vệ sinh [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '洗手间',
    'xǐshǒujiān',
    'nhà vệ sinh, phòng vệ sinh',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请问洗手间在哪里？',
    'Qǐngwèn xǐshǒujiān zài nǎli?',
    'Xin hỏi nhà vệ sinh ở đâu vậy ạ?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请问洗手间在哪里？', 'Qǐngwèn xǐshǒujiān zài nǎli?', 'Xin hỏi nhà vệ sinh ở đâu vậy ạ?', 'basic', 1),
      (v_id, '饭馆的洗手间保持得很干净整洁。', 'Fànguǎn de xǐshǒujiān bǎochí de hěn gānjìng zhěngjié.', 'Nhà vệ sinh của quán ăn được giữ gìn rất sạch sẽ gọn gàng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [下来] (xiàlai) - xuống đây, đi xuống [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '下来',
    'xiàlai',
    'xuống đây, đi xuống',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '车停了，大家快下来吧。',
    'Chē tíng le, dàjiā kuài xiàlai ba.',
    'Xe đỗ rồi, mọi người mau xuống đây thôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '车停了，大家快下来吧。', 'Chē tíng le, dàjiā kuài xiàlai ba.', 'Xe đỗ rồi, mọi người mau xuống đây thôi.', 'basic', 1),
      (v_id, '他在树上摘苹果，我们在树下让他小心下来。', 'Tā zài shù shang zhāi píngguǒ, wǒmen zài shù xià ràng tā xiǎoxīn xiàlai.', 'Anh ấy trèo hái táo trên cây, chúng tôi ở dưới nhắc anh ấy cẩn thận bước xuống.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [下面] (xiàmiàn) - phía dưới, bên dưới [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '下面',
    'xiàmiàn',
    'phía dưới, bên dưới',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '小猫趴在椅子下面睡觉。',
    'Xiǎomāo pā zài yǐzi xiàmiàn shuìjiào.',
    'Mèo con đang nằm ngủ dưới gầm ghế.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '小猫趴在椅子下面睡觉。', 'Xiǎomāo pā zài yǐzi xiàmiàn shuìjiào.', 'Mèo con đang nằm ngủ dưới gầm ghế.', 'basic', 1),
      (v_id, '大树下面非常凉快，很多老人在那儿下棋。', 'Dàshù xiàmiàn fēicháng liángkuai, hěn duō lǎorén zài nàr xiàqí.', 'Dưới gốc cây lớn rất mát mẻ, nhiều cụ già ngồi đó chơi cờ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [下去] (xiàqù) - đi xuống đó, bước xuống [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '下去',
    'xiàqù',
    'đi xuống đó, bước xuống',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '电梯坏了，我们走楼梯下去吧。',
    'Diàntī huài le, wǒmen zǒu lóutī xiàqù ba.',
    'Thang máy hỏng rồi, chúng mình đi cầu thang bộ xuống nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '电梯坏了，我们走楼梯下去吧。', 'Diàntī huài le, wǒmen zǒu lóutī xiàqù ba.', 'Thang máy hỏng rồi, chúng mình đi cầu thang bộ xuống nhé.', 'basic', 1),
      (v_id, '太阳慢慢落了下去，夜幕降临了。', 'Tàiyáng mànmàn luò le xiàqù, yèmù jiànglín le.', 'Mặt trời từ từ lặn xuống dưới rặng núi, màn đêm buông xuống.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [小孩儿] (xiǎoháir) - trẻ con, đứa trẻ, em bé [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '小孩儿',
    'xiǎoháir',
    'trẻ con, đứa trẻ, em bé',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '公园里有很多小孩儿在玩游戏。',
    'Gōngyuán lǐ yǒu hěn duō xiǎoháir zài wán yóuxì.',
    'Trong công viên có rất nhiều trẻ con đang chơi đùa.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '公园里有很多小孩儿在玩游戏。', 'Gōngyuán lǐ yǒu hěn duō xiǎoháir zài wán yóuxì.', 'Trong công viên có rất nhiều trẻ con đang chơi đùa.', 'basic', 1),
      (v_id, '小孩子好奇心强，对新鲜事物总是问个不停。', 'Xiǎoháir hàoqíxīn qiáng, duì xīnxiān shìwù zǒng shì wèn ge bù tíng.', 'Trẻ nhỏ tính tò mò rất lớn, luôn miệng hỏi không ngừng về những điều mới lạ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [小时候] (xiǎoshíhou) - hồi nhỏ, khi còn bé [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '小时候',
    'xiǎoshíhou',
    'hồi nhỏ, khi còn bé',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '小时候我经常跟爷爷去钓鱼。',
    'Xiǎoshíhou wǒ jīngcháng gēn yéye qù diàoyú.',
    'Hồi bé tôi thường theo ông nội đi câu cá.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '小时候我经常跟爷爷去钓鱼。', 'Xiǎoshíhou wǒ jīngcháng gēn yéye qù diàoyú.', 'Hồi bé tôi thường theo ông nội đi câu cá.', 'basic', 1),
      (v_id, '小时候的快乐时光总是让人十分怀念。', 'Xiǎoshíhou de kuàilè shíguāng zǒng shì ràng rén shífēn huáiniàn.', 'Khoảng thời gian vui vẻ vô tư thời thơ ấu luôn khiến người ta bồi hồi thương nhớ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [姓名] (xìngmíng) - họ và tên [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '姓名',
    'xìngmíng',
    'họ và tên',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请在这张表上写下您的姓名。',
    'Qǐng zài zhè zhāng biǎo shang xiě xià nín de xìngmíng.',
    'Xin hãy viết họ và tên của bạn vào tờ phiếu này.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请在这张表上写下您的姓名。', 'Qǐng zài zhè zhāng biǎo shang xiě xià nín de xìngmíng.', 'Xin hãy viết họ và tên của bạn vào tờ phiếu này.', 'basic', 1),
      (v_id, '办理入住手续时需要核对身份证上的姓名和照片。', 'Bànlǐ rùzhù shǒuxù shí xūyào h किसानोंduì shēnfènzhèng shang de xìngmíng hé zhàopiàn.', 'Khi làm thủ tục nhận phòng cần đối chiếu họ tên và ảnh trên căn cước.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [药店] (yàodiàn) - hiệu thuốc, tiệm thuốc tây [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '药店',
    'yàodiàn',
    'hiệu thuốc, tiệm thuốc tây',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我家附近有一家二十四小时药店。',
    'Wǒ jiā fùjìn yǒu yì jiā èrshísì xiǎoshí yàodiàn.',
    'Gần nhà tôi có một tiệm thuốc mở cửa hai mươi tư trên hai mươi tư giờ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我家附近有一家二十四小时药店。', 'Wǒ jiā fùjìn yǒu yì jiā èrshísì xiǎoshí yàodiàn.', 'Gần nhà tôi có một tiệm thuốc mở cửa hai mươi tư trên hai mươi tư giờ.', 'basic', 1),
      (v_id, '他感冒了，下班顺路去药店买点感冒药。', 'Tā gǎnmào le, xiàbān shùnlù qù yàodiàn mǎi diǎnr gǎnmàoyào.', 'Anh ấy bị cảm rồi, sau giờ tan làm tiện đường tạt qua hiệu thuốc mua ít thuốc cảm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [爷爷] (yéye) - ông nội [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '爷爷',
    'yéye',
    'ông nội',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '爷爷每天早起散步打太极拳。',
    'Yéye měitiān zǎoqǐ sànbù dǎ tàijíquán.',
    'Ông nội mỗi ngày đều dậy sớm tản bộ và tập thái cực quyền.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '爷爷每天早起散步打太极拳。', 'Yéye měitiān zǎoqǐ sànbù dǎ tàijíquán.', 'Ông nội mỗi ngày đều dậy sớm tản bộ và tập thái cực quyền.', 'basic', 1),
      (v_id, '春节全家人聚在爷爷家吃了一顿丰盛的年夜饭。', 'Chūnjié quánjiā rén jù zài yéye jiā chī le yí dùn fēngshèng de niányèfàn.', 'Dịp tết nguyên đán cả nhà quây quần tại nhà ông nội ăn bữa cơm tất niên thịnh soạn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [一会儿] (yíhuìr) - một lát, một chốc, một lát nữa [Cụm từ / Số từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '一会儿',
    'yíhuìr',
    'một lát, một chốc, một lát nữa',
    'Cụm từ / Số từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请你在这里等我一会儿。',
    'Qǐng nǐ zài zhèlǐ děng wǒ yíhuìr.',
    'Xin hãy ở đây đợi tôi một lát nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请你在这里等我一会儿。', 'Qǐng nǐ zài zhèlǐ děng wǒ yíhuìr.', 'Xin hãy ở đây đợi tôi một lát nhé.', 'basic', 1),
      (v_id, '工作累了就站起来看远方休息一会儿。', 'Gōngzuò lèi le jiù zhàn qǐlai kàn yuǎnfāng xiūxi yíhuìr.', 'Làm việc mệt rồi thì đứng dậy phóng tầm mắt ra xa thư giãn một chốc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [因为] (yīnwèi) - bởi vì, do vì [Liên từ / Giới từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '因为',
    'yīnwèi',
    'bởi vì, do vì',
    'Liên từ / Giới từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '因为今天下雨，我们不出去玩了。',
    'Yīnwèi jīntiān xiàyǔ, wǒmen bù chūqù wán le.',
    'Bởi vì hôm nay trời mưa, chúng mình không ra ngoài chơi nữa.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '因为今天下雨，我们不出去玩了。', 'Yīnwèi jīntiān xiàyǔ, wǒmen bù chūqù wán le.', 'Bởi vì hôm nay trời mưa, chúng mình không ra ngoài chơi nữa.', 'basic', 1),
      (v_id, '他因为出色的工作表现受到了公司的表彰。', 'Tā yīnwèi chūsè de gōngzuò biǎoxiàn shòudào le gōngsī de biǎozhāng.', 'Anh ấy nhờ vào biểu hiện công tác xuất sắc mà được công ty tuyên dương khen thưởng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [游] (yóu) - bơi lội, du ngoạn [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '游',
    'yóu',
    'bơi lội, du ngoạn',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '夏天我和朋友们常去游泳馆游泳。',
    'Xiàtiān wǒ hé péngyoumen cháng qù yóuyǒngguǎn yóuyǒng.',
    'Mùa hè tôi cùng các bạn thường đến bể bơi để bơi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '夏天我和朋友们常去游泳馆游泳。', 'Xiàtiān wǒ hé péngyoumen cháng qù yóuyǒngguǎn yóuyǒng.', 'Mùa hè tôi cùng các bạn thường đến bể bơi để bơi.', 'basic', 1),
      (v_id, '鱼儿在清澈的小河里欢快地游来游去。', 'Yúr zài qīngchè de xiǎohé lǐ huānkuài de yóu lái yóu qù.', 'Đàn cá bơi lội tung tăng trong dòng sông nhỏ trong vắt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [有意思] (yǒuyìsi) - thú vị, có ý nghĩa, hay [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '有意思',
    'yǒuyìsi',
    'thú vị, có ý nghĩa, hay',
    'Tính từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这个汉语故事真有意思！',
    'Zhè ge Hànyǔ gùshi zhēn yǒuyìsi!',
    'Câu chuyện tiếng Hán này thực sự rất thú vị!'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这个汉语故事真有意思！', 'Zhè ge Hànyǔ gùshi zhēn yǒuyìsi!', 'Câu chuyện tiếng Hán này thực sự rất thú vị!', 'basic', 1),
      (v_id, '老师上课讲得很生动，大家都觉得学汉语很有意思。', 'Lǎoshī shàngkè jiǎng de hěn shēngdòng, dàjiā dōu juéde xué Hànyǔ hěn yǒuyìsi.', 'Thầy cô giảng bài rất sinh động, ai nấy đều cảm thấy học tiếng Hán vô cùng bổ ích và hay.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [有时] (yǒushí) - có lúc, đôi khi, thỉnh thoảng [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '有时',
    'yǒushí',
    'có lúc, đôi khi, thỉnh thoảng',
    'Phó từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我有时走路去上班。',
    'Wǒ yǒushí zǒulù qù shàngbān.',
    'Tôi thỉnh thoảng đi bộ đi làm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我有时走路去上班。', 'Wǒ yǒushí zǒulù qù shàngbān.', 'Tôi thỉnh thoảng đi bộ đi làm.', 'basic', 1),
      (v_id, '山里的天气变化莫测，有时晴朗，有时突然下起小雨。', 'Shān lǐ de tiānqì biànhuà mò cè, yǒushí qínglǎng, yǒushí tūrán xià qǐ xiǎoyǔ.', 'Thời tiết trong núi khó lường, có khi thì nắng ráo, có lúc lại bất chợt đổ mưa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [右] (yòu) - bên phải, phía hữu [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '右',
    'yòu',
    'bên phải, phía hữu',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '车站就在马路的右边。',
    'Chēzhàn jiù zài mǎlù de yòubian.',
    'Bến xe nằm ngay ở phía bên phải con đường.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '车站就在马路的右边。', 'Chēzhàn jiù zài mǎlù de yòubian.', 'Bến xe nằm ngay ở phía bên phải con đường.', 'basic', 1),
      (v_id, '走到路口请向右拐，然后再往前走一百米。', 'Zǒu dào lùkǒu qǐng xiàng yòu guǎi, ránhòu zài wǎng qián zǒu yìbǎi mǐ.', 'Đi tới ngã tư xin hãy rẽ phải, sau đó đi tiếp về phía trước một trăm mét.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [站] (zhàn) - trạm, bến, ga; đứng [Danh từ / Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '站',
    'zhàn',
    'trạm, bến, ga; đứng',
    'Danh từ / Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '下一站是天安门广场。',
    'Xià yí zhàn shì Tiān&#x27;ānmén Guǎngchǎng.',
    'Trạm tiếp theo là quảng trường Thiên An Môn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '下一站是天安门广场。', 'Xià yí zhàn shì Tiān&#x27;ānmén Guǎngchǎng.', 'Trạm tiếp theo là quảng trường Thiên An Môn.', 'basic', 1),
      (v_id, '公交车上没有空座位，他站了半个多小时。', 'Gōngjiāochē shang méiyǒu kōng zuòwèi, tā zhàn le bàn ge duō xiǎoshí.', 'Trên xe buýt không còn ghế trống, anh ấy đã đứng hơn nửa tiếng đồng hồ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [这么] (zhème) - như thế này, đến thế này [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '这么',
    'zhème',
    'như thế này, đến thế này',
    'Đại từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这个苹果怎么这么甜？',
    'Zhè ge píngguǒ zěnme zhème tián?',
    'Quả táo này sao mà ngọt đến thế này nhỉ?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这个苹果怎么这么甜？', 'Zhè ge píngguǒ zěnme zhème tián?', 'Quả táo này sao mà ngọt đến thế này nhỉ?', 'basic', 1),
      (v_id, '既然大家意见这么一致，那我们就这么决定了。', 'Jìrán dàjiā yìjiàn zhème yízhì, nà wǒmen jiù zhème juédìng le.', 'Nếu ý kiến mọi người đã nhất trí như thế này, vậy chúng ta quyết định như vậy nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [这样] (zhèyàng) - như thế này, kiểu này [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '这样',
    'zhèyàng',
    'như thế này, kiểu này',
    'Đại từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '这样做真的很有效。',
    'Zhèyàng zuò zhēn de hěn yǒuxiào.',
    'Làm theo cách này thực sự rất hiệu quả.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '这样做真的很有效。', 'Zhèyàng zuò zhēn de hěn yǒuxiào.', 'Làm theo cách này thực sự rất hiệu quả.', 'basic', 1),
      (v_id, '坚持每天练习半小时，这样中文水平才能稳步提高。', 'Jiānchí měitiān liànxí bàn xiǎoshí, zhèyàng Zhōngwén shuǐpíng cái néng wěnbù tígāo.', 'Kiên trì mỗi ngày luyện tập nửa giờ, có như vậy trình độ tiếng Trung mới tiến bộ vững chắc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [正] (zhèng) - đang, vừa đúng, chính [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '正',
    'zhèng',
    'đang, vừa đúng, chính',
    'Phó từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我正想给你打电话呢。',
    'Wǒ zhèng xiǎng gěi nǐ dǎ diànhuà ne.',
    'Tôi vừa đúng lúc đang định gọi điện thoại cho bạn này.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我正想给你打电话呢。', 'Wǒ zhèng xiǎng gěi nǐ dǎ diànhuà ne.', 'Tôi vừa đúng lúc đang định gọi điện thoại cho bạn này.', 'basic', 1),
      (v_id, '现在正是春暖花开、外出踏青的好时节。', 'Xiànzài zhèng shì chūnnuǎn huākāi, wàichū tàqīng de hǎo shíjié.', 'Bây giờ chính là tiết trời xuân ấm hoa nở, thời điểm tuyệt vời để du xuân.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [周] (zhōu) - tuần, tuần lễ, chu kỳ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '周',
    'zhōu',
    'tuần, tuần lễ, chu kỳ',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '下周我们要去上海参加展会。',
    'Xià zhōu wǒmen yào qù Shànghǎi cānjiā zhǎnhuì.',
    'Tuần tới chúng tôi sẽ tới Thượng Hải tham gia triển lãm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '下周我们要去上海参加展会。', 'Xià zhōu wǒmen yào qù Shànghǎi cānjiā zhǎnhuì.', 'Tuần tới chúng tôi sẽ tới Thượng Hải tham gia triển lãm.', 'basic', 1),
      (v_id, '开学已经三周了，大家都完全适应了校园生活。', 'Kāixué yǐjīng sān zhōu le, dàjiā dōu wánquán shìyìng le xiàoyuán shēnghuó.', 'Tựu trường đã được ba tuần rồi, ai nấy đều đã thích nghi hoàn toàn với đời sống học đường.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [自己] (zìjǐ) - tự mình, bản thân [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '自己',
    'zìjǐ',
    'tự mình, bản thân',
    'Đại từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '自己的事情要自己做。',
    'Zìjǐ de shìqing yào zìjǐ zuò.',
    'Chuyện của bản thân phải tự mình làm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '自己的事情要自己做。', 'Zìjǐ de shìqing yào zìjǐ zuò.', 'Chuyện của bản thân phải tự mình làm.', 'basic', 1),
      (v_id, '一个人在异国他乡生活，一定要好好照顾自己。', 'Yí ge rén zài yìguó tāxiāng shēnghuó, yídìng yào hǎohāo zhàogù zìjǐ.', 'Một mình sống nơi đất khách quê người, nhất định phải chăm sóc tốt cho bản thân nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [走路] (zǒulù) - đi bộ, tản bộ [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '走路',
    'zǒulù',
    'đi bộ, tản bộ',
    'Động từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '我家离学校很近，每天走路十分钟就到了。',
    'Wǒ jiā lí xuéxiào hěn jìn, měitiān zǒulù shí fēnzhōng jiù dào le.',
    'Nhà tôi cách trường rất gần, mỗi ngày đi bộ mười phút là tới.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '我家离学校很近，每天走路十分钟就到了。', 'Wǒ jiā lí xuéxiào hěn jìn, měitiān zǒulù shí fēnzhōng jiù dào le.', 'Nhà tôi cách trường rất gần, mỗi ngày đi bộ mười phút là tới.', 'basic', 1),
      (v_id, '晚饭后多走路散步对身体健康非常有好处。', 'Wǎnfàn hòu duō zǒulù sànbù duì shēntǐ jiànkāng fēicháng yǒu hǎochù.', 'Sau bữa tối đi bộ nhiều có lợi ích rất lớn đối với sức khỏe.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [足球] (zúqiú) - bóng đá, môn bóng đá [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '足球',
    'zúqiú',
    'bóng đá, môn bóng đá',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '今天下午操场有一场精彩的足球赛。',
    'Jīntiān xiàwǔ cāochǎng yǒu yì chǎng jīngcǎi de zúqiúsài.',
    'Chiều nay ngoài sân vận động có một trận bóng đá rất gay cấn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '今天下午操场有一场精彩的足球赛。', 'Jīntiān xiàwǔ cāochǎng yǒu yì chǎng jīngcǎi de zúqiúsài.', 'Chiều nay ngoài sân vận động có một trận bóng đá rất gay cấn.', 'basic', 1),
      (v_id, '他从小就是个超级足球迷，最喜欢看世界杯比赛。', 'Tā cóngxiǎo jiù shì ge chāojí zúqiúmí, zuì xǐhuan kàn Shìjièbēi bǐsài.', 'Từ nhỏ anh ấy đã là một fan bóng đá cuồng nhiệt, thích nhất là xem các trận World Cup.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [左] (zuǒ) - bên trái, phía tả [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '左',
    'zuǒ',
    'bên trái, phía tả',
    'Danh từ',
    'HSK 2',
    'HSK 2',
    'hsk3.0',
    '请向左看，图书馆就在那边。',
    'Qǐng xiàng zuǒ kàn, túshūguǎn jiù zài nàbiān.',
    'Xin hãy nhìn sang bên trái, thư viện ở ngay đằng đó.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 2',
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
      (v_id, '请向左看，图书馆就在那边。', 'Qǐng xiàng zuǒ kàn, túshūguǎn jiù zài nàbiān.', 'Xin hãy nhìn sang bên trái, thư viện ở ngay đằng đó.', 'basic', 1),
      (v_id, '中国道路交通规则是车辆靠右行驶，行人靠左注意避让。', 'Zhōngguó dàolù jiāotōng guīzé shì chēliàng kào yòu xíngshǐ, xíngrén kào zuǒ zhùyì bìràng.', 'Quy tắc giao thông là xe đi làn bên phải, người đi bộ quan sát chú ý nhường đường.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  RAISE NOTICE 'Đã bổ sung và đồng bộ thành công % từ vựng HSK 2 mới!', v_count;
END $$;
