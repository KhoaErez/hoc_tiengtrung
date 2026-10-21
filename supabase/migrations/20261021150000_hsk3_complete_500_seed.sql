-- ====================================================================
-- MIGRATION SEED: HOÀN THIỆN 500/500 TỪ VỰNG MỚI HSK 3 CHUẨN ĐỀ CƯƠNG HSK 3.0
-- Căn cứ: Đề cương thi HSK 3.0 chính thức (CTI / chinesetest.cn - Công bố 11/2025)
-- Cấp độ: HSK 3 (500 từ vựng mới: #501 - #1000, tổng tích lũy Cấp 1+2+3 = 1.000 từ vựng)
-- Đặc điểm:
--   - Chạy an toàn trong transaction DO $$ ... BEGIN ... END $$;
--   - Đảm bảo ràng buộc UNIQUE (hanzi, pinyin, hsk_level)
--   - Dọn dẹp 30 bản ghi thừa từ HSK 1/2 đã có dữ liệu chuẩn độc lập
--   - Bảo toàn 100% dữ liệu: Điều chuyển 41 từ trung cấp sang HSK 4 (giữ nguyên UUID)
--   - Đồng bộ 245 từ hiện có sang hsk_level_v3 = 'HSK 3'
--   - Bổ sung 255 từ vựng còn thiếu với đầy đủ Hanzi, Pinyin có dấu, Loại từ, Nghĩa TV
--   - Nạp tự động 510 câu ví dụ chất lượng cao (Cơ bản & Ứng dụng) vào vocabulary_examples
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
  v_count integer := 0;
  v_deleted_count integer := 0;
  v_shifted_count integer := 0;
BEGIN

  -- ------------------------------------------------------------------
  -- BƯỚC 1: ĐẢM BẢO RÀNG BUỘC DUY NHẤT HỖ TRỢ TỪ LIÊN CẤP HSK (UNIQUE hanzi, pinyin, hsk_level)
  -- ------------------------------------------------------------------
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vocabularies_hanzi_pinyin_level_key') THEN
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'vocabularies_hanzi_pinyin_key') THEN
      ALTER TABLE public.vocabularies DROP CONSTRAINT vocabularies_hanzi_pinyin_key;
    END IF;
    ALTER TABLE public.vocabularies ADD CONSTRAINT vocabularies_hanzi_pinyin_level_key UNIQUE (hanzi, pinyin, hsk_level);
  END IF;

  -- ------------------------------------------------------------------
  -- BƯỚC 2: DỌN DẸP 30 BẢN GHI TRÙNG LẶP THỪA TỪ SEED CŨ
  -- (Các từ này đã tồn tại độc lập, đầy đủ và đạt chuẩn 100% trong HSK 1 hoặc HSK 2)
  -- ------------------------------------------------------------------
  DELETE FROM public.vocabularies
  WHERE hsk_level = 'HSK 3'
    AND hanzi IN (
      '中文',
      '一会儿',
      '万',
      '上网',
      '个子',
      '位',
      '啊',
      '坏',
      '拿',
      '教',
      '条',
      '楼',
      '洗手间',
      '画',
      '疼',
      '经常',
      '自己',
      '花',
      '裤子',
      '记得',
      '起来',
      '跟',
      '还是',
      '鸟',
      '过',
      '地铁',
      '爱好',
      '舒服',
      '爷爷',
      '奶奶'
    );
  GET DIAGNOSTICS v_deleted_count = ROW_COUNT;

  -- ------------------------------------------------------------------
  -- BƯỚC 3: BẢO TOÀN DỮ LIỆU & ĐIỀU CHUYỂN 41 TỪ HSK 2/3 CŨ SANG HSK 4
  -- (Không xóa bản ghi nào, giữ nguyên UUID id để bảo toàn tiến độ người dùng)
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level = 'HSK 4',
    hsk_level_v3 = 'HSK 4',
    hsk_version = 'hsk2.0'
  WHERE hsk_level = 'HSK 3'
    AND hanzi IN (
      '不但……而且……',
      '冬',
      '刮风',
      '刷牙',
      '只有……才……',
      '夏',
      '多么',
      '帽子',
      '春',
      '照相机',
      '熊猫',
      '爬山',
      '电子邮件',
      '皮鞋',
      '秋',
      '绿',
      '行李箱',
      '街道',
      '黄河',
      '鼻子',
      '聊天',
      '北京',
      '公共汽车',
      '唱歌',
      '因为……所以……',
      '打篮球',
      '服务员',
      '火车站',
      '第一',
      '红',
      '羊肉',
      '虽然……但是……',
      '踢足球',
      '面条',
      '黑',
      '半年',
      '白',
      '不大',
      '北边',
      '小姐',
      '杯'
    );
  GET DIAGNOSTICS v_shifted_count = ROW_COUNT;

  -- ------------------------------------------------------------------
  -- BƯỚC 4: ĐỒNG BỘ PHIÊN BẢN HSK 3.0 CHO CÁC TỪ VỰNG CHUẨN HIỆN CÓ CỦA HSK 3
  -- ------------------------------------------------------------------
  UPDATE public.vocabularies
  SET 
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0'
  WHERE hsk_level = 'HSK 3';

  -- ------------------------------------------------------------------
  -- BƯỚC 5: BỔ SUNG 255 TỪ VỰNG HSK 3 CÒN THIẾU VÀ 510 CÂU VÍ DỤ CHẤT LƯỢNG CAO
  -- ------------------------------------------------------------------
  -- [爱人] (àiren) - người bạn đời, chồng / vợ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '爱人',
    'àiren',
    'người bạn đời, chồng / vợ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我和爱人一起去超市买菜。',
    'Wǒ hé àiren yìqǐ qù chāoshì mǎi cài.',
    'Tôi và người bạn đời cùng đi siêu thị mua thức ăn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我和爱人一起去超市买菜。', 'Wǒ hé àiren yìqǐ qù chāoshì mǎi cài.', 'Tôi và người bạn đời cùng đi siêu thị mua thức ăn.', 'basic', 1),
      (v_id, '他经常在周末陪爱人散步聊天。', 'Tā jīngcháng zài zhōumò péi àiren sànbù liáotiān.', 'Anh ấy thường vào cuối tuần đi dạo trò chuyện cùng vợ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [安全] (ānquán) - an toàn [Tính từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '安全',
    'ānquán',
    'an toàn',
    'Tính từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '骑车的时候要注意安全。',
    'Qí chē de shíhou yào zhùyì ānquán.',
    'Khi đi xe đạp/xe máy cần chú ý an toàn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '骑车的时候要注意安全。', 'Qí chē de shíhou yào zhùyì ānquán.', 'Khi đi xe đạp/xe máy cần chú ý an toàn.', 'basic', 1),
      (v_id, '住在这个小区里既方便又安全。', 'Zhù zài zhè ge xiǎoqū lǐ jì fāngbiàn yòu ānquán.', 'Sống trong khu dân cư này vừa tiện lợi lại vừa an toàn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [班级] (bānjí) - lớp học, tập thể lớp [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '班级',
    'bānjí',
    'lớp học, tập thể lớp',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们班级有三十个学生。',
    'Wǒmen bānjí yǒu sānshí gè xuésheng.',
    'Lớp học của chúng tôi có ba mươi học sinh.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们班级有三十个学生。', 'Wǒmen bānjí yǒu sānshí gè xuésheng.', 'Lớp học của chúng tôi có ba mươi học sinh.', 'basic', 1),
      (v_id, '大家都为班级的荣誉而努力。', 'Dàjiā dōu wèi bānjí de róngyù ér nǔlì.', 'Mọi người đều nỗ lực vì danh dự của tập thể lớp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [搬家] (bānjiā) - chuyển nhà [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '搬家',
    'bānjiā',
    'chuyển nhà',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '下个星期我们就要搬家了。',
    'Xià gè xīngqī wǒmen jiù yào bānjiā le.',
    'Tuần sau chúng tôi phải chuyển nhà rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '下个星期我们就要搬家了。', 'Xià gè xīngqī wǒmen jiù yào bānjiā le.', 'Tuần sau chúng tôi phải chuyển nhà rồi.', 'basic', 1),
      (v_id, '搬家虽然很累，但是住进新房很高兴。', 'Bānjiā suīrán hěn lèi, dànshì zhù jìn xīnfáng hěn gāoxìng.', 'Chuyển nhà tuy rất mệt nhưng dọn vào nhà mới rất vui.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [办] (bàn) - làm, giải quyết, xử lý [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '办',
    'bàn',
    'làm, giải quyết, xử lý',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这件事情不好办。',
    'Zhè jiàn shìqing bù hǎo bàn.',
    'Chuyện này không dễ xử lý.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这件事情不好办。', 'Zhè jiàn shìqing bù hǎo bàn.', 'Chuyện này không dễ xử lý.', 'basic', 1),
      (v_id, '我想去银行办一张新的银行卡。', 'Wǒ xiǎng qù yínháng bàn yì zhāng xīn de yínhángkǎ.', 'Tôi muốn đến ngân hàng làm một chiếc thẻ ngân hàng mới.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [笔记] (bǐjì) - ghi chép, vở ghi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '笔记',
    'bǐjì',
    'ghi chép, vở ghi',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '上课要认真记笔记。',
    'Shàngkè yào rènzhēn jì bǐjì.',
    'Trong giờ học phải ghi chép cẩn thận.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '上课要认真记笔记。', 'Shàngkè yào rènzhēn jì bǐjì.', 'Trong giờ học phải ghi chép cẩn thận.', 'basic', 1),
      (v_id, '借我看一下你的汉语课堂笔记好吗？', 'Jiè wǒ kàn yíxià nǐ de Hànyǔ kètáng bǐjì hǎo ma?', 'Cho tôi mượn xem vở ghi chép lớp tiếng Trung của bạn được không?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [比如] (bǐrú) - ví dụ, chẳng hạn như [Động từ / Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '比如',
    'bǐrú',
    'ví dụ, chẳng hạn như',
    'Động từ / Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '许多水果我都喜欢，比如苹果和香蕉。',
    'Xǔduō shuǐguǒ wǒ dōu xǐhuan, bǐrú píngguǒ hé xiāngjiāo.',
    'Nhiều loại trái cây tôi đều thích, ví dụ như táo và chuối.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '许多水果我都喜欢，比如苹果和香蕉。', 'Xǔduō shuǐguǒ wǒ dōu xǐhuan, bǐrú píngguǒ hé xiāngjiāo.', 'Nhiều loại trái cây tôi đều thích, ví dụ như táo và chuối.', 'basic', 1),
      (v_id, '如果你遇到困难，比如迷路了，可以给我打电话。', 'Rúguǒ nǐ yù dào kùnnan, bǐrú mílù le, kěyǐ gěi wǒ dǎ diànhuà.', 'Nếu bạn gặp khó khăn, chẳng hạn như bị lạc đường, có thể gọi điện cho tôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [变] (biàn) - thay đổi, biến đổi [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '变',
    'biàn',
    'thay đổi, biến đổi',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '天气变冷了，多穿点儿衣服吧。',
    'Tiānqì biàn lěng le, duō chuān diǎnr yīfu ba.',
    'Thời tiết đã trở lạnh rồi, mặc thêm chút áo ấm đi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '天气变冷了，多穿点儿衣服吧。', 'Tiānqì biàn lěng le, duō chuān diǎnr yīfu ba.', 'Thời tiết đã trở lạnh rồi, mặc thêm chút áo ấm đi.', 'basic', 1),
      (v_id, '几年没见，家乡的变化真大。', 'Jǐ nián méi jiàn, jiāxiāng de biànhuà zhēn dà.', 'Mấy năm không gặp, sự thay đổi của quê hương thật to lớn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [遍] (biàn) - lần, lượt (từ đầu đến cuối) [Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '遍',
    'biàn',
    'lần, lượt (từ đầu đến cuối)',
    'Lượng từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请你再说一遍。',
    'Qǐng nǐ zài shuō yí biàn.',
    'Xin bạn hãy nói lại một lần nữa.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请你再说一遍。', 'Qǐng nǐ zài shuō yí biàn.', 'Xin bạn hãy nói lại một lần nữa.', 'basic', 1),
      (v_id, '这本小说很有趣，我已经读了三遍了。', 'Zhè běn xiǎoshuō hěn yǒuqù, wǒ yǐjīng dú le sān biàn le.', 'Cuốn tiểu thuyết này rất thú vị, tôi đã đọc ba lần rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [变成] (biànchéng) - trở thành, biến thành [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '变成',
    'biànchéng',
    'trở thành, biến thành',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '水在零度以下会变成冰。',
    'Shuǐ zài líng dù yǐxià huì biànchéng bīng.',
    'Nước ở dưới 0 độ sẽ biến thành băng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '水在零度以下会变成冰。', 'Shuǐ zài líng dù yǐxià huì biànchéng bīng.', 'Nước ở dưới 0 độ sẽ biến thành băng.', 'basic', 1),
      (v_id, '经过不断努力，他变成了一名优秀的医生。', 'Jīngguò búduàn nǔlì, tā biànchéng le yì míng yōuxiù de yīshēng.', 'Trải qua không ngừng nỗ lực, anh ấy đã trở thành một bác sĩ xuất sắc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [表演] (biǎoyǎn) - biểu diễn, màn biểu diễn [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '表演',
    'biǎoyǎn',
    'biểu diễn, màn biểu diễn',
    'Động từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今晚有精彩的音乐表演。',
    'Jīnwǎn yǒu jīngcǎi de yīnyuè biǎoyǎn.',
    'Tối nay có buổi biểu diễn âm nhạc đặc sắc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今晚有精彩的音乐表演。', 'Jīnwǎn yǒu jīngcǎi de yīnyuè biǎoyǎn.', 'Tối nay có buổi biểu diễn âm nhạc đặc sắc.', 'basic', 1),
      (v_id, '孩子们在舞台上表演得非常出色。', 'Háizimen zài wǔtái shang biǎoyǎn de fēicháng chūsè.', 'Các em nhỏ biểu diễn trên sân khấu vô cùng xuất sắc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [冰] (bīng) - băng, đá, lạnh buốt [Danh từ / Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '冰',
    'bīng',
    'băng, đá, lạnh buốt',
    'Danh từ / Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我想喝一杯加冰的柠檬水。',
    'Wǒ xiǎng hē yì bēi jiā bīng de níngméngshuǐ.',
    'Tôi muốn uống một ly nước chanh thêm đá.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我想喝一杯加冰的柠檬水。', 'Wǒ xiǎng hē yì bēi jiā bīng de níngméngshuǐ.', 'Tôi muốn uống một ly nước chanh thêm đá.', 'basic', 1),
      (v_id, '冬天的河面上结了厚厚的一层冰。', 'Dōngtiān de hémiàn shang jié le hòuhòu de yì céng bīng.', 'Trên mặt sông vào mùa đông đóng một lớp băng dày.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [冰激凌] (bīngjīlíng) - kem, que kem [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '冰激凌',
    'bīngjīlíng',
    'kem, que kem',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '夏天吃冰激凌真舒服。',
    'Xiàtiān chī bīngjīlíng zhēn shūfu.',
    'Mùa hè ăn kem thật dễ chịu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '夏天吃冰激凌真舒服。', 'Xiàtiān chī bīngjīlíng zhēn shūfu.', 'Mùa hè ăn kem thật dễ chịu.', 'basic', 1),
      (v_id, '小朋友最喜欢巧克力味的冰激凌。', 'Xiǎopéngyou zuì xǐhuan qiǎokèlì wèi de bīngjīlíng.', 'Trẻ con thích nhất là kem vị sô-cô-la.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不但] (búdàn) - không những, không chỉ [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不但',
    'búdàn',
    'không những, không chỉ',
    'Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他不但聪明，而且很努力。',
    'Tā búdàn cōngmíng, érqiě hěn nǔlì.',
    'Anh ấy không những thông minh mà còn rất chăm chỉ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他不但聪明，而且很努力。', 'Tā búdàn cōngmíng, érqiě hěn nǔlì.', 'Anh ấy không những thông minh mà còn rất chăm chỉ.', 'basic', 1),
      (v_id, '这家餐厅不但环境优雅，菜的味道也很地道。', 'Zhè jiā cāntīng búdàn huánjìng yōuyǎ, cài de wèidao yě hěn dìdao.', 'Nhà hàng này không những không gian tao nhã mà hương vị món ăn cũng rất chuẩn vị.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不见] (bújiàn) - không thấy, biến mất, thất lạc [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不见',
    'bújiàn',
    'không thấy, biến mất, thất lạc',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我的钥匙不见了。',
    'Wǒ de yàoshi bújiàn le.',
    'Chìa khóa của tôi không thấy đâu rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我的钥匙不见了。', 'Wǒ de yàoshi bújiàn le.', 'Chìa khóa của tôi không thấy đâu rồi.', 'basic', 1),
      (v_id, '刚才还在桌上的手机怎么一转眼就不见了？', 'Gāngcái hái zài zhuō shang de shǒujī zěnme yì zhuǎnyǎn jiù bújiàn le?', 'Điện thoại vừa nãy còn trên bàn sao chớp mắt một cái đã không thấy nữa rồi?', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不用] (búyòng) - không cần [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不用',
    'búyòng',
    'không cần',
    'Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天不用上班，我们去公园吧。',
    'Jīntiān búyòng shàngbān, wǒmen qù gōngyuán ba.',
    'Hôm nay không cần đi làm, chúng ta đi công viên nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天不用上班，我们去公园吧。', 'Jīntiān búyòng shàngbān, wǒmen qù gōngyuán ba.', 'Hôm nay không cần đi làm, chúng ta đi công viên nhé.', 'basic', 1),
      (v_id, '离这里很近，不用坐车，走路五分钟就到了。', 'Lí zhèlǐ hěn jìn, búyòng zuò chē, zǒulù wǔ fēnzhōng jiù dào le.', 'Cách đây rất gần, không cần đi xe, đi bộ năm phút là tới.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不同] (bù tóng) - khác biệt, không giống nhau [Tính từ / Cụm từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不同',
    'bù tóng',
    'khác biệt, không giống nhau',
    'Tính từ / Cụm từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们俩的想法完全不同。',
    'Wǒmen liǎ de xiǎngfǎ wánquán bù tóng.',
    'Suy nghĩ của hai chúng tôi hoàn toàn khác nhau.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们俩的想法完全不同。', 'Wǒmen liǎ de xiǎngfǎ wánquán bù tóng.', 'Suy nghĩ của hai chúng tôi hoàn toàn khác nhau.', 'basic', 1),
      (v_id, '每个人来自不同的国家，说着不同的语言。', 'Měi gè rén láizì bù tóng de guójiā, shuō zhe bù tóng de yǔyán.', 'Mỗi người đến từ những quốc gia khác nhau, nói những ngôn ngữ khác nhau.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不久] (bùjiǔ) - chẳng bao lâu, không lâu sau [Danh từ / Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不久',
    'bùjiǔ',
    'chẳng bao lâu, không lâu sau',
    'Danh từ / Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他来中国不久，但汉语说得很好。',
    'Tā lái Zhōngguó bùjiǔ, dàn Hànyǔ shuō de hěn hǎo.',
    'Anh ấy đến Trung Quốc chưa lâu, nhưng nói tiếng Trung rất tốt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他来中国不久，但汉语说得很好。', 'Tā lái Zhōngguó bùjiǔ, dàn Hànyǔ shuō de hěn hǎo.', 'Anh ấy đến Trung Quốc chưa lâu, nhưng nói tiếng Trung rất tốt.', 'basic', 1),
      (v_id, '毕业不久，她就找到了心仪的工作。', 'Bìyè bùjiǔ, tā jiù zhǎodào le xīnyí de gōngzuò.', 'Tốt nghiệp không lâu, cô ấy đã tìm được công việc ưng ý.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [不行] (bùxíng) - không được, không ổn, kém [Động từ / Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '不行',
    'bùxíng',
    'không được, không ổn, kém',
    'Động từ / Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天晚上我有事，不行去打球。',
    'Jīntiān wǎnshang wǒ yǒushì, bùxíng qù dǎ qiú.',
    'Tối nay tôi có việc bận, không thể đi đánh bóng được.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天晚上我有事，不行去打球。', 'Jīntiān wǎnshang wǒ yǒushì, bùxíng qù dǎ qiú.', 'Tối nay tôi có việc bận, không thể đi đánh bóng được.', 'basic', 1),
      (v_id, '我的电脑坏了，完全开不了机，这台真不行了。', 'Wǒ de diànnǎo huài le, wánquán kāi bù liǎo jī, zhè tái zhēn bùxíng le.', 'Máy tính của tôi hỏng rồi, hoàn toàn không mở lên được, chiếc này thực sự hỏng hẳn rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [才] (cái) - mới (chỉ hành động muộn hoặc số lượng ít) [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '才',
    'cái',
    'mới (chỉ hành động muộn hoặc số lượng ít)',
    'Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '你怎么现在才来？',
    'Nǐ zěnme xiànzài cái lái?',
    'Sao bây giờ bạn mới tới?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你怎么现在才来？', 'Nǐ zěnme xiànzài cái lái?', 'Sao bây giờ bạn mới tới?', 'basic', 1),
      (v_id, '这本书才二十块钱，非常便宜。', 'Zhè běn shū cái èrshí kuài qián, fēicháng piányi.', 'Cuốn sách này mới có hai mươi tệ, rất rẻ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [草地] (cǎodì) - bãi cỏ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '草地',
    'cǎodì',
    'bãi cỏ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '小狗在草地上跑来跑去。',
    'Xiǎogǒu zài cǎodì shang pǎo lái pǎo qù.',
    'Chú chó nhỏ chạy đi chạy lại trên bãi cỏ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '小狗在草地上跑来跑去。', 'Xiǎogǒu zài cǎodì shang pǎo lái pǎo qù.', 'Chú chó nhỏ chạy đi chạy lại trên bãi cỏ.', 'basic', 1),
      (v_id, '周末许多家庭都在公园的绿草地上野餐。', 'Zhōumò xǔduō jiātíng dōu zài gōngyuán de lǜ cǎodì shang yěcān.', 'Cuối tuần nhiều gia đình đều dã ngoại trên bãi cỏ xanh của công viên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [查] (chá) - tra cứu, kiểm tra [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '查',
    'chá',
    'tra cứu, kiểm tra',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '遇到不认识的生词可以查字典。',
    'Yù dào bú rènshi de shēngcí kěyǐ chá zìdiǎn.',
    'Gặp từ mới không biết có thể tra từ điển.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '遇到不认识的生词可以查字典。', 'Yù dào bú rènshi de shēngcí kěyǐ chá zìdiǎn.', 'Gặp từ mới không biết có thể tra từ điển.', 'basic', 1),
      (v_id, '出门前最好先上网查一下今天的天气和路线。', 'Chūmén qián zuìhǎo xiān shàngwǎng chá yíxià jīntiān de tiānqì hé lùxiàn.', 'Trước khi ra ngoài tốt nhất nên lên mạng tra cứu trước thời tiết và lộ trình hôm nay.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [差不多] (chàbuduō) - xấp xỉ, gần như, tương đương [Tính từ / Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '差不多',
    'chàbuduō',
    'xấp xỉ, gần như, tương đương',
    'Tính từ / Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天的作业我差不多做完了。',
    'Jīntiān de zuòyè wǒ chàbuduō zuò wán le.',
    'Bài tập hôm nay tôi gần như làm xong rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天的作业我差不多做完了。', 'Jīntiān de zuòyè wǒ chàbuduō zuò wán le.', 'Bài tập hôm nay tôi gần như làm xong rồi.', 'basic', 1),
      (v_id, '这两个包的颜色和款式都差不多。', 'Zhè liǎng gè bāo de yánsè hé kuǎnshì dōu chàbuduō.', 'Màu sắc và kiểu dáng của hai chiếc túi này xấp xỉ như nhau.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [尝] (cháng) - nếm thử [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '尝',
    'cháng',
    'nếm thử',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '你尝尝这个菜好吃不好吃。',
    'Nǐ chángchang zhè ge cài hǎochī bù hǎochī.',
    'Bạn nếm thử xem món ăn này có ngon không.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你尝尝这个菜好吃不好吃。', 'Nǐ chángchang zhè ge cài hǎochī bù hǎochī.', 'Bạn nếm thử xem món ăn này có ngon không.', 'basic', 1),
      (v_id, '这是妈妈特意为你做的点心，快尝一口吧。', 'Zhè shì māma tèyì wèi nǐ zuò de diǎnxin, kuài cháng yì kǒu ba.', 'Đây là điểm tâm mẹ đặc biệt làm cho con, mau nếm thử một miếng đi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [常] (cháng) - thường, hay [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '常',
    'cháng',
    'thường, hay',
    'Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我常去图书馆看书。',
    'Wǒ cháng qù túshūguǎn kàn shū.',
    'Tôi thường đến thư viện đọc sách.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我常去图书馆看书。', 'Wǒ cháng qù túshūguǎn kàn shū.', 'Tôi thường đến thư viện đọc sách.', 'basic', 1),
      (v_id, '工作再忙也要常给家里打电话问候。', 'Gōngzuò zài máng yě yào cháng gěi jiālǐ dǎ diànhuà wènhòu.', 'Công việc dù bận rộn cũng nên thường xuyên gọi điện về nhà thăm hỏi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [常见] (cháng jiàn) - thường thấy, phổ biến [Tính từ / Cụm từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '常见',
    'cháng jiàn',
    'thường thấy, phổ biến',
    'Tính từ / Cụm từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '感冒是冬天很常见的病。',
    'Gǎnmào shì dōngtiān hěn chángjiàn de bìng.',
    'Cảm cúm là căn bệnh rất thường thấy vào mùa đông.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '感冒是冬天很常见的病。', 'Gǎnmào shì dōngtiān hěn chángjiàn de bìng.', 'Cảm cúm là căn bệnh rất thường thấy vào mùa đông.', 'basic', 1),
      (v_id, '这种花在南方很常见，北方比较少见。', 'Zhè zhǒng huā zài nánfāng hěn chángjiàn, běifāng bǐjiào shǎojiàn.', 'Loại hoa này ở miền nam rất phổ biến, còn miền bắc thì tương đối hiếm thấy.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [常用] (cháng yòng) - thường dùng, thông dụng [Tính từ / Cụm từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '常用',
    'cháng yòng',
    'thường dùng, thông dụng',
    'Tính từ / Cụm từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这是学汉语最常用的一千个词。',
    'Zhè shì xué Hànyǔ zuì chángyòng de yìqiān gè cí.',
    'Đây là một ngàn từ thông dụng nhất khi học tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这是学汉语最常用的一千个词。', 'Zhè shì xué Hànyǔ zuì chángyòng de yìqiān gè cí.', 'Đây là một ngàn từ thông dụng nhất khi học tiếng Trung.', 'basic', 1),
      (v_id, '把常用的软件放在手机桌面上会方便很多。', 'Bǎ chángyòng de ruǎnjiàn fàng zài shǒujī zhuōmiàn shang huì fāngbiàn hěn duō.', 'Để các phần mềm thường dùng trên màn hình điện thoại sẽ tiện hơn rất nhiều.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [常常] (chángcháng) - thường xuyên, hay [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '常常',
    'chángcháng',
    'thường xuyên, hay',
    'Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们常常在一起学习汉语。',
    'Wǒmen chángcháng zài yìqǐ xuéxí Hànyǔ.',
    'Chúng tôi thường xuyên cùng nhau học tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们常常在一起学习汉语。', 'Wǒmen chángcháng zài yìqǐ xuéxí Hànyǔ.', 'Chúng tôi thường xuyên cùng nhau học tiếng Trung.', 'basic', 1),
      (v_id, '遇到难题的时候，他常常主动向老师请教。', 'Yù dào nántí de shíhou, tā chángcháng zhǔdòng xiàng lǎoshī qǐngjiào.', 'Khi gặp phải bài toán khó, cậu ấy thường chủ động xin thầy cô chỉ bảo.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [出发] (chūfā) - xuất phát, khởi hành [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '出发',
    'chūfā',
    'xuất phát, khởi hành',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们明天早上七点准时出发。',
    'Wǒmen míngtiān zǎoshang qī diǎn zhǔnshí chūfā.',
    'Chúng ta sáng mai bảy giờ đúng sẽ xuất phát.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们明天早上七点准时出发。', 'Wǒmen míngtiān zǎoshang qī diǎn zhǔnshí chūfā.', 'Chúng ta sáng mai bảy giờ đúng sẽ xuất phát.', 'basic', 1),
      (v_id, '带好随身行李，大家准备出发去机场了。', 'Dài hǎo suíshēn xíngli, dàjiā zhǔnbèi chūfā qù jīchǎng le.', 'Mang theo đầy đủ hành lý cá nhân, mọi người chuẩn bị khởi hành ra sân bay rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [出生] (chūshēng) - sinh ra, chào đời [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '出生',
    'chūshēng',
    'sinh ra, chào đời',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他在北京出生，在上海长大。',
    'Tā zài Běijīng chūshēng, zài Shànghǎi zhǎngdà.',
    'Anh ấy sinh ra ở Bắc Kinh, lớn lên ở Thượng Hải.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他在北京出生，在上海长大。', 'Tā zài Běijīng chūshēng, zài Shànghǎi zhǎngdà.', 'Anh ấy sinh ra ở Bắc Kinh, lớn lên ở Thượng Hải.', 'basic', 1),
      (v_id, '请在表格上填写您的出生日期和地点。', 'Qǐng zài biǎogé shang tiánxiě nín de chūshēng rìqī hé dìdiǎn.', 'Xin hãy điền ngày tháng năm sinh và nơi sinh của bạn vào biểu mẫu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [出院] (chūyuàn) - xuất viện [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '出院',
    'chūyuàn',
    'xuất viện',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '医生说他明天就可以出院了。',
    'Yīshēng shuō tā míngtiān jiù kěyǐ chūyuàn le.',
    'Bác sĩ bảo ngày mai anh ấy có thể xuất viện rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '医生说他明天就可以出院了。', 'Yīshēng shuō tā míngtiān jiù kěyǐ chūyuàn le.', 'Bác sĩ bảo ngày mai anh ấy có thể xuất viện rồi.', 'basic', 1),
      (v_id, '身体完全康复之后，爷爷高高兴兴地出院回家了。', 'Shēntǐ wánquán kāngfù zhīhòu, yéye gāogāoxìngxìng de chūyuàn huí jiā le.', 'Sau khi cơ thể hoàn toàn bình phục, ông nội vui vẻ xuất viện về nhà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [初中] (chūzhōng) - trung học cơ sở, cấp 2 [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '初中',
    'chūzhōng',
    'trung học cơ sở, cấp 2',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我弟弟正在读初中二年级。',
    'Wǒ dìdi zhèngzài dú chūzhōng èr niánjí.',
    'Em trai tôi đang học lớp 8 (năm hai THCS).'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我弟弟正在读初中二年级。', 'Wǒ dìdi zhèngzài dú chūzhōng èr niánjí.', 'Em trai tôi đang học lớp 8 (năm hai THCS).', 'basic', 1),
      (v_id, '初中时代的朋友往往感情最深厚。', 'Chūzhōng shídài de péngyou wǎngwǎng gǎnqíng zuì shēnhòu.', 'Những người bạn thời cấp hai thường có tình cảm sâu đậm nhất.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [春天] (chūntiān) - mùa xuân [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '春天',
    'chūntiān',
    'mùa xuân',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '春天来了，树木都变绿了。',
    'Chūntiān lái le, shùmù dōu biàn lǜ le.',
    'Mùa xuân đến rồi, cây cối đều xanh tươi trở lại.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '春天来了，树木都变绿了。', 'Chūntiān lái le, shùmù dōu biàn lǜ le.', 'Mùa xuân đến rồi, cây cối đều xanh tươi trở lại.', 'basic', 1),
      (v_id, '春天是最适合去户外踏青赏花的季节。', 'Chūntiān shì zuì shìhé qù hùwài tàqīng shǎng huā de jìjié.', 'Mùa xuân là mùa thích hợp nhất để ra ngoài dã ngoại ngắm hoa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [大概] (dàgài) - khoảng chừng, có lẽ, đại khái [Phó từ / Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '大概',
    'dàgài',
    'khoảng chừng, có lẽ, đại khái',
    'Phó từ / Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '从这里到车站大概需要二十分钟。',
    'Cóng zhèlǐ dào chēzhàn dàgài xūyào èrshí fēnzhōng.',
    'Từ đây đến ga khoảng chừng mất hai mươi phút.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '从这里到车站大概需要二十分钟。', 'Cóng zhèlǐ dào chēzhàn dàgài xūyào èrshí fēnzhōng.', 'Từ đây đến ga khoảng chừng mất hai mươi phút.', 'basic', 1),
      (v_id, '他今天没来上班，大概是因为生病了吧。', 'Tā jīntiān méi lái shàngbān, dàgài shì yīnwèi shēngbìng le ba.', 'Hôm nay anh ấy không đi làm, có lẽ là do bị ốm rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [大人] (dàren) - người lớn [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '大人',
    'dàren',
    'người lớn',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '小孩子要听大人的话。',
    'Xiǎoháizi yào tīng dàren de huà.',
    'Trẻ con cần nghe lời người lớn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '小孩子要听大人的话。', 'Xiǎoháizi yào tīng dàren de huà.', 'Trẻ con cần nghe lời người lớn.', 'basic', 1),
      (v_id, '游泳池深水区只允许大人进入。', 'Yóuyǒngchí shēnshuǐ qū zhǐ yǔnxǔ dàren jìnrù.', 'Khu vực nước sâu của bể bơi chỉ cho phép người lớn vào.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [大小] (dàxiǎo) - kích cỡ, độ lớn nhỏ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '大小',
    'dàxiǎo',
    'kích cỡ, độ lớn nhỏ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这双鞋的大小正合适。',
    'Zhè shuāng xié de dàxiǎo zhèng héshì.',
    'Kích cỡ của đôi giày này vừa vặn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这双鞋的大小正合适。', 'Zhè shuāng xié de dàxiǎo zhèng héshì.', 'Kích cỡ của đôi giày này vừa vặn.', 'basic', 1),
      (v_id, '买衣服前请先确认好衣服的大小尺码。', 'Mǎi yīfu qián qǐng xiān quèrèn hǎo yīfu de dàxiǎo chǐmǎ.', 'Trước khi mua quần áo xin hãy xác nhận kích cỡ và số đo.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [大熊猫] (dàxióngmāo) - gấu trúc khổng lồ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '大熊猫',
    'dàxióngmāo',
    'gấu trúc khổng lồ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '大熊猫是中国的国宝。',
    'Dàxióngmāo shì Zhōngguó de guóbǎo.',
    'Gấu trúc là quốc bảo của Trung Quốc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '大熊猫是中国的国宝。', 'Dàxióngmāo shì Zhōngguó de guóbǎo.', 'Gấu trúc là quốc bảo của Trung Quốc.', 'basic', 1),
      (v_id, '动物园里的大熊猫正在安静地吃着竹子。', 'Dòngwùyuán lǐ de dàxióngmāo zhèngzài ānjìng de chī zhe zhúzi.', 'Chú gấu trúc trong sở thú đang yên lặng ăn lá trúc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [大衣] (dàyī) - áo khoác dạ, áo choàng lớn [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '大衣',
    'dàyī',
    'áo khoác dạ, áo choàng lớn',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '外面冷，穿上一件大衣吧。',
    'Wàimiàn lěng, chuān shang yí jiàn dàyī ba.',
    'Bên ngoài lạnh, mặc thêm một chiếc áo khoác lớn đi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '外面冷，穿上一件大衣吧。', 'Wàimiàn lěng, chuān shang yí jiàn dàyī ba.', 'Bên ngoài lạnh, mặc thêm một chiếc áo khoác lớn đi.', 'basic', 1),
      (v_id, '这件黑色的大衣看起来既暖和又帅气。', 'Zhè jiàn hēisè de dàyī kàn qǐlái jì nuǎnhuo yòu shuàiqì.', 'Chiếc áo khoác dạ màu đen này trông vừa ấm áp lại vừa lịch lãm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [到处] (dàochù) - khắp nơi, mọi nơi [Phó từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '到处',
    'dàochù',
    'khắp nơi, mọi nơi',
    'Phó từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '公园里到处都是漂亮的花。',
    'Gōngyuán lǐ dàochù dōu shì piàoliang de huā.',
    'Trong công viên khắp nơi đều là hoa đẹp.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '公园里到处都是漂亮的花。', 'Gōngyuán lǐ dàochù dōu shì piàoliang de huā.', 'Trong công viên khắp nơi đều là hoa đẹp.', 'basic', 1),
      (v_id, '春天来了，山坡上到处充满生机。', 'Chūntiān lái le, shānpō shang dàochù chōngmǎn shēngjī.', 'Mùa xuân đến rồi, trên sườn núi khắp nơi ngập tràn sức sống.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [得] (dé) - đạt được, nhận được, mắc (bệnh) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '得',
    'dé',
    'đạt được, nhận được, mắc (bệnh)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他在比赛中得了第一名。',
    'Tā zài bǐsài zhōng dé le dì-yī míng.',
    'Anh ấy đã đạt giải nhất trong cuộc thi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他在比赛中得了第一名。', 'Tā zài bǐsài zhōng dé le dì-yī míng.', 'Anh ấy đã đạt giải nhất trong cuộc thi.', 'basic', 1),
      (v_id, '由于天气突然变冷，他不小心得了重感冒。', 'Yóuyú tiānqì tūrán biàn lěng, tā bù xiǎoxīn dé le zhòng gǎnmào.', 'Do thời tiết đột ngột trở lạnh, anh ấy sơ ý bị cảm nặng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [得到] (dédào) - nhận được, có được [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '得到',
    'dédào',
    'nhận được, có được',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他得到了老师和同学的赞扬。',
    'Tā dédào le lǎoshī hé tóngxué de zànyáng.',
    'Cậu ấy nhận được lời khen ngợi của thầy cô và bạn học.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他得到了老师和同学的赞扬。', 'Tā dédào le lǎoshī hé tóngxué de zànyáng.', 'Cậu ấy nhận được lời khen ngợi của thầy cô và bạn học.', 'basic', 1),
      (v_id, '通过大家的共同努力，这个问题得到了很好的解决。', 'Tōngguò dàjiā de gòngtóng nǔlì, zhè ge wèntí dédào le hěn hǎo de jiějué.', 'Nhờ nỗ lực chung của mọi người, vấn đề này đã nhận được cách giải quyết rất tốt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [得分] (défēn) - ghi điểm, điểm số [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '得分',
    'défēn',
    'ghi điểm, điểm số',
    'Động từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们队在最后两分钟得了三分。',
    'Wǒmen duì zài zuìhòu liǎng fēnzhōng dé le sān fēn.',
    'Đội chúng tôi đã ghi được ba điểm trong hai phút cuối cùng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们队在最后两分钟得了三分。', 'Wǒmen duì zài zuìhòu liǎng fēnzhōng dé le sān fēn.', 'Đội chúng tôi đã ghi được ba điểm trong hai phút cuối cùng.', 'basic', 1),
      (v_id, '他的考试总得分在全班排名第一。', 'Tā de kǎoshì zǒng défēn zài quán bān páimíng dì-yī.', 'Tổng điểm thi của cậu ấy xếp thứ nhất toàn lớp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [的话] (dehuà) - nếu... (đặt cuối vế câu điều kiện) [Trợ từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '的话',
    'dehuà',
    'nếu... (đặt cuối vế câu điều kiện)',
    'Trợ từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '有时间的话，我们一起去喝咖啡吧。',
    'Yǒu shíjiān dehuà, wǒmen yìqǐ qù hē kāfēi ba.',
    'Nếu có thời gian thì chúng mình cùng đi uống cà phê nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '有时间的话，我们一起去喝咖啡吧。', 'Yǒu shíjiān dehuà, wǒmen yìqǐ qù hē kāfēi ba.', 'Nếu có thời gian thì chúng mình cùng đi uống cà phê nhé.', 'basic', 1),
      (v_id, '如果你遇到不懂的词语的话，随时可以问我。', 'Rúguǒ nǐ yù dào bù dǒng de cíyǔ dehuà, suíshí kěyǐ wèn wǒ.', 'Nếu như bạn gặp từ ngữ không hiểu, bất cứ lúc nào cũng có thể hỏi tôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [得] (děi) - phải, cần phải [Động từ năng nguyện]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '得',
    'děi',
    'phải, cần phải',
    'Động từ năng nguyện',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '时间不早了，我得走了。',
    'Shíjiān bù zǎo le, wǒ děi zǒu le.',
    'Thời gian không còn sớm nữa, tôi phải đi rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '时间不早了，我得走了。', 'Shíjiān bù zǎo le, wǒ děi zǒu le.', 'Thời gian không còn sớm nữa, tôi phải đi rồi.', 'basic', 1),
      (v_id, '明天有重要的考试，今晚得早点儿休息。', 'Míngtiān yǒu zhòngyào de kǎoshì, jīnwǎn děi zǎo diǎnr xiūxi.', 'Ngày mai có kỳ thi quan trọng, tối nay phải nghỉ ngơi sớm một chút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [地点] (dìdiǎn) - địa điểm [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '地点',
    'dìdiǎn',
    'địa điểm',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请告诉我开会的地点在哪儿。',
    'Qǐng gàosù wǒ kāihuì de dìdiǎn zài nǎr.',
    'Xin hãy cho tôi biết địa điểm họp ở đâu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请告诉我开会的地点在哪儿。', 'Qǐng gàosù wǒ kāihuì de dìdiǎn zài nǎr.', 'Xin hãy cho tôi biết địa điểm họp ở đâu.', 'basic', 1),
      (v_id, '我们在通知上写明了集合的时间和地点。', 'Wǒmen zài tōngzhī shang xiě míng le jíhé de shíjiān hé dìdiǎn.', 'Chúng tôi đã ghi rõ thời gian và địa điểm tập trung trên thông báo.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [电] (diàn) - điện, pin (điện) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '电',
    'diàn',
    'điện, pin (điện)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '手机快没电了，帮我拿一下充电器。',
    'Shǒujī kuài méi diàn le, bāng wǒ ná yíxià chōngdiànqì.',
    'Điện thoại sắp hết pin rồi, lấy hộ tôi củ sạc với.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '手机快没电了，帮我拿一下充电器。', 'Shǒujī kuài méi diàn le, bāng wǒ ná yíxià chōngdiànqì.', 'Điện thoại sắp hết pin rồi, lấy hộ tôi củ sạc với.', 'basic', 1),
      (v_id, '突然停电了，大家请不要慌张。', 'Tūrán tíng diàn le, dàjiā qǐng bú yào huāngzhāng.', 'Đột ngột mất điện rồi, mọi người xin đừng hoảng loạn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [电子书] (diànzǐshū) - sách điện tử [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '电子书',
    'diànzǐshū',
    'sách điện tử',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我喜欢在平板电脑上看电子书。',
    'Wǒ xǐhuan zài píngbǎn diànnǎo shang kàn diànzǐshū.',
    'Tôi thích đọc sách điện tử trên máy tính bảng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我喜欢在平板电脑上看电子书。', 'Wǒ xǐhuan zài píngbǎn diànnǎo shang kàn diànzǐshū.', 'Tôi thích đọc sách điện tử trên máy tính bảng.', 'basic', 1),
      (v_id, '电子书携带方便，随时随地都能阅读。', 'Diànzǐshū xiédài fāngbiàn, suíshí suídì dōu néng yuèdú.', 'Sách điện tử mang theo rất tiện, mọi lúc mọi nơi đều có thể đọc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [丢] (diū) - mất, làm mất, vứt bỏ [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '丢',
    'diū',
    'mất, làm mất, vứt bỏ',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我不小心把钱包丢了。',
    'Wǒ bù xiǎoxīn bǎ qiánbāo diū le.',
    'Tôi sơ ý làm mất ví tiền rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我不小心把钱包丢了。', 'Wǒ bù xiǎoxīn bǎ qiánbāo diū le.', 'Tôi sơ ý làm mất ví tiền rồi.', 'basic', 1),
      (v_id, '请把垃圾丢进外面的垃圾桶里。', 'Qǐng bǎ lājī diū jìn wàimiàn de lājītǒng lǐ.', 'Xin hãy vứt rác vào thùng rác bên ngoài.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [东北] (dōngběi) - đông bắc, miền đông bắc [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '东北',
    'dōngběi',
    'đông bắc, miền đông bắc',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '中国东北冬天的景色非常美。',
    'Zhōngguó dōngběi dōngtiān de jǐngsè fēicháng měi.',
    'Phong cảnh mùa đông miền đông bắc Trung Quốc rất đẹp.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '中国东北冬天的景色非常美。', 'Zhōngguó dōngběi dōngtiān de jǐngsè fēicháng měi.', 'Phong cảnh mùa đông miền đông bắc Trung Quốc rất đẹp.', 'basic', 1),
      (v_id, '我家在城市的东北角，离公园很近。', 'Wǒ jiā zài chéngshì de dōngběi jiǎo, lí gōngyuán hěn jìn.', 'Nhà tôi ở góc đông bắc của thành phố, rất gần công viên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [东方] (dōngfāng) - hướng đông, phương đông [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '东方',
    'dōngfāng',
    'hướng đông, phương đông',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '太阳从东方升起来了。',
    'Tàiyáng cóng dōngfāng shēng qǐlái le.',
    'Mặt trời mọc lên từ hướng đông.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '太阳从东方升起来了。', 'Tàiyáng cóng dōngfāng shēng qǐlái le.', 'Mặt trời mọc lên từ hướng đông.', 'basic', 1),
      (v_id, '许多外国朋友对东方传统文化很感兴趣。', 'Xǔduō wàiguó péngyou duì dōngfāng chuántǒng wénhuà hěn gǎn xìngqù.', 'Nhiều người bạn nước ngoài rất quan tâm đến văn hóa truyền thống phương Đông.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [东南] (dōngnán) - đông nam, hướng đông nam [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '东南',
    'dōngnán',
    'đông nam, hướng đông nam',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '学校的东南方向有一家大超市。',
    'Xuéxiào de dōngnán fāngxiàng yǒu yì jiā dà chāoshì.',
    'Hướng đông nam của trường có một siêu thị lớn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '学校的东南方向有一家大超市。', 'Xuéxiào de dōngnán fāngxiàng yǒu yì jiā dà chāoshì.', 'Hướng đông nam của trường có một siêu thị lớn.', 'basic', 1),
      (v_id, '中国东南部沿海地区气候湿润温暖。', 'Zhōngguó dōngnán bù yánhǎi dìqū qìhòu shīrùn wēnnuǎn.', 'Vùng ven biển đông nam Trung Quốc khí hậu ẩm ướt ấm áp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [冬天] (dōngtiān) - mùa đông [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '冬天',
    'dōngtiān',
    'mùa đông',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '冬天北京经常下大雪。',
    'Dōngtiān Běijīng jīngcháng xià dà xuě.',
    'Mùa đông Bắc Kinh thường có tuyết rơi dày.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '冬天北京经常下大雪。', 'Dōngtiān Běijīng jīngcháng xià dà xuě.', 'Mùa đông Bắc Kinh thường có tuyết rơi dày.', 'basic', 1),
      (v_id, '冬天虽然寒冷，但是一家人吃火锅很温馨。', 'Dōngtiān suīrán hánlěng, dànshì yì jiā rén chī huǒguō hěn wēnxīn.', 'Mùa đông tuy lạnh giá, nhưng cả nhà cùng ăn lẩu rất ấm áp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [懂得] (dǒngde) - hiểu biết, thấu hiểu [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '懂得',
    'dǒngde',
    'hiểu biết, thấu hiểu',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们要懂得尊重别人。',
    'Wǒmen yào dǒngde zūnzhòng biérén.',
    'Chúng ta phải biết tôn trọng người khác.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们要懂得尊重别人。', 'Wǒmen yào dǒngde zūnzhòng biérén.', 'Chúng ta phải biết tôn trọng người khác.', 'basic', 1),
      (v_id, '经历过挫折之后，他更懂得珍惜眼前的幸福。', 'Jīnglì guò cuòzhé zhīhòu, tā gèng dǒngde zhēnxī yǎnqián de xìngfú.', 'Sau khi trải qua trắc trở, anh ấy càng thấu hiểu việc trân trọng hạnh phúc trước mắt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [动物园] (dòngwùyuán) - sở thú, vườn bách thú [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '动物园',
    'dòngwùyuán',
    'sở thú, vườn bách thú',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '周末爸爸带我们去动物园看猴子。',
    'Zhōumò bàba dài wǒmen qù dòngwùyuán kàn hóuzi.',
    'Cuối tuần bố dẫn chúng tôi đi sở thú xem khỉ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '周末爸爸带我们去动物园看猴子。', 'Zhōumò bàba dài wǒmen qù dòngwùyuán kàn hóuzi.', 'Cuối tuần bố dẫn chúng tôi đi sở thú xem khỉ.', 'basic', 1),
      (v_id, '北京动物园里有许多珍稀动物，特别是大熊猫。', 'Běijīng dòngwùyuán lǐ yǒu xǔduō zhēnxī dòngwù, tèbié shì dàxióngmāo.', 'Trong sở thú Bắc Kinh có rất nhiều động vật quý hiếm, đặc biệt là gấu trúc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [短裤] (duǎnkù) - quần cộc, quần đùi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '短裤',
    'duǎnkù',
    'quần cộc, quần đùi',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '夏天穿短裤很凉快。',
    'Xiàtiān chuān duǎnkù hěn liángkuai.',
    'Mùa hè mặc quần soóc rất mát mẻ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '夏天穿短裤很凉快。', 'Xiàtiān chuān duǎnkù hěn liángkuai.', 'Mùa hè mặc quần soóc rất mát mẻ.', 'basic', 1),
      (v_id, '他换上运动短裤，准备去球场踢足球。', 'Tā huàn shang yùndòng duǎnkù, zhǔnbèi qù qiúchǎng tī zúqiú.', 'Anh ấy thay quần cộc thể thao, chuẩn bị ra sân đá bóng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [对话] (duìhuà) - đối thoại, trò chuyện [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '对话',
    'duìhuà',
    'đối thoại, trò chuyện',
    'Động từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请两个人一组练习这段对话。',
    'Qǐng liǎng gè rén yì zǔ liànxí zhè duàn duìhuà.',
    'Xin mời hai người một nhóm luyện tập đoạn đối thoại này.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请两个人一组练习这段对话。', 'Qǐng liǎng gè rén yì zǔ liànxí zhè duàn duìhuà.', 'Xin mời hai người một nhóm luyện tập đoạn đối thoại này.', 'basic', 1),
      (v_id, '多跟中国朋友用汉语对话，口语进步会很快。', 'Duō gēn Zhōngguó péngyou yòng Hànyǔ duìhuà, kǒuyǔ jìnbù huì hěn kuài.', 'Tích cực dùng tiếng Trung đối thoại cùng bạn bè người Trung Quốc, khẩu ngữ sẽ tiến bộ rất nhanh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [而且] (érqiě) - hơn nữa, mà còn [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '而且',
    'érqiě',
    'hơn nữa, mà còn',
    'Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这件衣服既好看，而且价格也不贵。',
    'Zhè jiàn yīfu jì hǎokàn, érqiě jiàgé yě bú guì.',
    'Bộ quần áo này vừa đẹp mắt, hơn nữa giá cả cũng không đắt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这件衣服既好看，而且价格也不贵。', 'Zhè jiàn yīfu jì hǎokàn, érqiě jiàgé yě bú guì.', 'Bộ quần áo này vừa đẹp mắt, hơn nữa giá cả cũng không đắt.', 'basic', 1),
      (v_id, '他每天都坚持锻炼，而且饮食也非常健康。', 'Tā měitiān dōu jiānchí duànliàn, érqiě yǐnshí yě fēicháng jiànkāng.', 'Anh ấy ngày nào cũng kiên trì rèn luyện, hơn nữa ăn uống cũng vô cùng lành mạnh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [耳机] (ěrjī) - tai nghe [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '耳机',
    'ěrjī',
    'tai nghe',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我戴着耳机听听力练习。',
    'Wǒ dài zhe ěrjī tīng tīnglì liànxí.',
    'Tôi đeo tai nghe để làm bài luyện nghe.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我戴着耳机听听力练习。', 'Wǒ dài zhe ěrjī tīng tīnglì liànxí.', 'Tôi đeo tai nghe để làm bài luyện nghe.', 'basic', 1),
      (v_id, '在图书馆里听音乐时，请一定要戴上耳机。', 'Zài túshūguǎn lǐ tīng yīnyuè shí, qǐng yídìng yào dài shang ěrjī.', 'Khi nghe nhạc trong thư viện, xin nhất định phải đeo tai nghe.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [发生] (fāshēng) - xảy ra, phát sinh [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '发生',
    'fāshēng',
    'xảy ra, phát sinh',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这里刚才发生了一起交通事故。',
    'Zhèlǐ gāngcái fāshēng le yì qǐ jiāotōng shìgù.',
    'Ở đây vừa nãy đã xảy ra một vụ tai nạn giao thông.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这里刚才发生了一起交通事故。', 'Zhèlǐ gāngcái fāshēng le yì qǐ jiāotōng shìgù.', 'Ở đây vừa nãy đã xảy ra một vụ tai nạn giao thông.', 'basic', 1),
      (v_id, '别着急，慢慢告诉我到底发生了什么事情。', 'Bié zháojí, mànmàn gàosù wǒ dàodǐ fāshēng le shénme shìqing.', 'Đừng sốt ruột, từ từ nói cho tôi biết rốt cuộc đã xảy ra chuyện gì.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [发展] (fāzhǎn) - phát triển [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '发展',
    'fāzhǎn',
    'phát triển',
    'Động từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '近几年这个城市发展得很快。',
    'Jìn jǐ nián zhè ge chéngshì fāzhǎn de hěn kuài.',
    'Mấy năm gần đây thành phố này phát triển rất nhanh.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '近几年这个城市发展得很快。', 'Jìn jǐ nián zhè ge chéngshì fāzhǎn de hěn kuài.', 'Mấy năm gần đây thành phố này phát triển rất nhanh.', 'basic', 1),
      (v_id, '科技的发展极大地改善了人们的日常生活。', 'Kējì de fāzhǎn jídà de gǎishàn le rénmen de rìcháng shēnghuó.', 'Sự phát triển của khoa học công nghệ đã cải thiện vượt bậc đời sống hàng ngày của người dân.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [方便面] (fāngbiànmiàn) - mì ăn liền, mì tôm [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '方便面',
    'fāngbiànmiàn',
    'mì ăn liền, mì tôm',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他晚上常常煮一包方便面当宵夜。',
    'Tā wǎnshang chángcháng zhǔ yì bāo fāngbiànmiàn dāng xiāoyè.',
    'Buổi tối anh ấy thường nấu một gói mì tôm làm bữa khuya.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他晚上常常煮一包方便面当宵夜。', 'Tā wǎnshang chángcháng zhǔ yì bāo fāngbiànmiàn dāng xiāoyè.', 'Buổi tối anh ấy thường nấu một gói mì tôm làm bữa khuya.', 'basic', 1),
      (v_id, '坐长途火车的时候，许多旅客都会带几包方便面。', 'Zuò chángtú huǒchē de shíhou, xǔduō lǚkè dōu huì dài jǐ bāo fāngbiànmiàn.', 'Khi đi tàu hỏa đường dài, nhiều hành khách đều mang theo vài gói mì ăn liền.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [方法] (fāngfǎ) - phương pháp, cách thức [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '方法',
    'fāngfǎ',
    'phương pháp, cách thức',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '只要找对了方法，学习就会更轻松。',
    'Zhǐyào zhǎoduì le fāngfǎ, xuéxí jiù huì gèng qīngsōng.',
    'Chỉ cần tìm đúng phương pháp, việc học sẽ nhẹ nhàng hơn nhiều.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '只要找对了方法，学习就会更轻松。', 'Zhǐyào zhǎoduì le fāngfǎ, xuéxí jiù huì gèng qīngsōng.', 'Chỉ cần tìm đúng phương pháp, việc học sẽ nhẹ nhàng hơn nhiều.', 'basic', 1),
      (v_id, '老师向我们介绍了好几种记忆生词的有效方法。', 'Lǎoshī xiàng wǒmen jièshào le hǎo jǐ zhǒng jìyì shēngcí de yǒuxiào fāngfǎ.', 'Thầy giáo đã giới thiệu cho chúng tôi vài phương pháp hiệu quả để ghi nhớ từ mới.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [方向] (fāngxiàng) - phương hướng, chiều hướng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '方向',
    'fāngxiàng',
    'phương hướng, chiều hướng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '车正在朝车站的方向开去。',
    'Chē zhèngzài cháo chēzhàn de fāngxiàng kāi qù.',
    'Chiếc xe đang chạy về hướng bến xe.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '车正在朝车站的方向开去。', 'Chē zhèngzài cháo chēzhàn de fāngxiàng kāi qù.', 'Chiếc xe đang chạy về hướng bến xe.', 'basic', 1),
      (v_id, '在森林里迷路时，可以用指南针辨别方向。', 'Zài sēnlín lǐ mílù shí, kěyǐ yòng zhǐnánzhēn biànbié fāngxiàng.', 'Khi bị lạc trong rừng, có thể dùng la bàn để nhận biết phương hướng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [房子] (fángzi) - ngôi nhà, căn nhà [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '房子',
    'fángzi',
    'ngôi nhà, căn nhà',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他们在学校旁边租了一套房子。',
    'Tāmen zài xuéxiào pángbiān zū le yí tào fángzi.',
    'Họ đã thuê một căn nhà ở cạnh trường học.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他们在学校旁边租了一套房子。', 'Tāmen zài xuéxiào pángbiān zū le yí tào fángzi.', 'Họ đã thuê một căn nhà ở cạnh trường học.', 'basic', 1),
      (v_id, '这套房子的采光非常好，窗外就是大花园。', 'Zhè tào fángzi de cǎiguāng fēicháng hǎo, chuāng wài jiù shì dà huāyuán.', 'Căn nhà này đón ánh sáng rất tốt, ngoài cửa sổ chính là một khu vườn lớn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [放假] (fàngjià) - nghỉ lễ, nghỉ phép [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '放假',
    'fàngjià',
    'nghỉ lễ, nghỉ phép',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '下周放假三天，你想去哪儿玩？',
    'Xià zhōu fàngjià sān tiān, nǐ xiǎng qù nǎr wán?',
    'Tuần sau được nghỉ lễ ba ngày, bạn muốn đi đâu chơi?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '下周放假三天，你想去哪儿玩？', 'Xià zhōu fàngjià sān tiān, nǐ xiǎng qù nǎr wán?', 'Tuần sau được nghỉ lễ ba ngày, bạn muốn đi đâu chơi?', 'basic', 1),
      (v_id, '学校一放假，许多留学生就回国探亲了。', 'Xuéxiào yí fàngjià, xǔduō liúxuéshēng jiù huí guó tànqīn le.', 'Trường học vừa được nghỉ là nhiều du học sinh liền về nước thăm người thân.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [放学] (fàngxué) - tan học [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '放学',
    'fàngxué',
    'tan học',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '下午四点半放学后我们去打球吧。',
    'Xiàwǔ sì diǎn bàn fàngxué hòu wǒmen qù dǎ qiú ba.',
    'Bốn giờ rưỡi chiều tan học xong chúng mình đi chơi bóng nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '下午四点半放学后我们去打球吧。', 'Xiàwǔ sì diǎn bàn fàngxué hòu wǒmen qù dǎ qiú ba.', 'Bốn giờ rưỡi chiều tan học xong chúng mình đi chơi bóng nhé.', 'basic', 1),
      (v_id, '校门口每天放学的时候都有很多家长在接孩子。', 'Xiàoménkǒu měitiān fàngxué de shíhou dōu yǒu hěn duō jiāzhǎng zài jiē háizi.', 'Trước cổng trường mỗi lúc tan học đều có rất đông phụ huynh đang đón con.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [分开] (fēnkāi) - chia tách, tách rời, phân ra [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '分开',
    'fēnkāi',
    'chia tách, tách rời, phân ra',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请把生词和语法笔记分开写。',
    'Qǐng bǎ shēngcí hé yǔfǎ bǐjì fēnkāi xiě.',
    'Xin hãy viết phần ghi chú từ mới và ngữ pháp tách riêng ra.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请把生词和语法笔记分开写。', 'Qǐng bǎ shēngcí hé yǔfǎ bǐjì fēnkāi xiě.', 'Xin hãy viết phần ghi chú từ mới và ngữ pháp tách riêng ra.', 'basic', 1),
      (v_id, '大学毕业后，大家就分开去了不同的城市工作。', 'Dàxué bìyè hòu, dàjiā jiù fēnkāi qù le bù tóng de chéngshì gōngzuò.', 'Sau khi tốt nghiệp đại học, mọi người liền tách nhau đi đến các thành phố khác nhau để làm việc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [风] (fēng) - gió [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '风',
    'fēng',
    'gió',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天的风很大，出门戴上帽子吧。',
    'Jīntiān de fēng hěn dà, chūmén dài shang màozi ba.',
    'Hôm nay gió to lắm, ra ngoài đội mũ vào nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天的风很大，出门戴上帽子吧。', 'Jīntiān de fēng hěn dà, chūmén dài shang màozi ba.', 'Hôm nay gió to lắm, ra ngoài đội mũ vào nhé.', 'basic', 1),
      (v_id, '春风吹拂着河岸边的杨柳，显得分外美丽。', 'Chūnfēng chuīfú zhe hé’àn biān de yángliǔ, xiǎnde fènwài měilì.', 'Gió xuân thổi nhẹ qua rặng liễu bên bờ sông, trông vô cùng xinh đẹp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [封] (fēng) - bức, lá (thư); niêm phong [Lượng từ / Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '封',
    'fēng',
    'bức, lá (thư); niêm phong',
    'Lượng từ / Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我收到了一封远方朋友寄来的信。',
    'Wǒ shōudào le yì fēng yuǎnfāng péngyou jì lái de xìn.',
    'Tôi đã nhận được một lá thư của người bạn phương xa gửi tới.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我收到了一封远方朋友寄来的信。', 'Wǒ shōudào le yì fēng yuǎnfāng péngyou jì lái de xìn.', 'Tôi đã nhận được một lá thư của người bạn phương xa gửi tới.', 'basic', 1),
      (v_id, '他在电子邮件里给导师写了一封长信汇报研究进展。', 'Tā zài diànzǐ yóujiàn lǐ gěi dǎoshī xiě le yì fēng cháng xìn huìbào yánjiū jìnzhǎn.', 'Anh ấy viết một bức thư dài trong email gửi giáo viên hướng dẫn để báo cáo tiến độ nghiên cứu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [夫妻] (fūqī) - vợ chồng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '夫妻',
    'fūqī',
    'vợ chồng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他们夫妻俩的感情一直特别好。',
    'Tāmen fūqī liǎ de gǎnqíng yìzhí tèbié hǎo.',
    'Tình cảm của hai vợ chồng họ lúc nào cũng đặc biệt tốt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他们夫妻俩的感情一直特别好。', 'Tāmen fūqī liǎ de gǎnqíng yìzhí tèbié hǎo.', 'Tình cảm của hai vợ chồng họ lúc nào cũng đặc biệt tốt.', 'basic', 1),
      (v_id, '夫妻之间需要相互理解与包容才能长久。', 'Fūqī zhījiān xūyào xiānghù lǐjiě yǔ bāoróng cái néng chángjiǔ.', 'Giữa vợ chồng cần thấu hiểu và bao dung lẫn nhau thì mới bền lâu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [服务] (fúwù) - phục vụ, dịch vụ [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '服务',
    'fúwù',
    'phục vụ, dịch vụ',
    'Động từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这家宾馆的服务很周到。',
    'Zhè jiā bīnguǎn de fúwù hěn zhōudào.',
    'Dịch vụ của khách sạn này rất chu đáo.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这家宾馆的服务很周到。', 'Zhè jiā bīnguǎn de fúwù hěn zhōudào.', 'Dịch vụ của khách sạn này rất chu đáo.', 'basic', 1),
      (v_id, '我们始终秉承为顾客全心全意服务的理念。', 'Wǒmen shǐzhōng bǐngchéng wèi gùkè quánxīnquányì fúwù de lǐniàn.', 'Chúng tôi luôn giữ vững triết lý phục vụ khách hàng hết lòng hết dạ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [该] (gāi) - nên, phải, đến lượt [Động từ năng nguyện]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '该',
    'gāi',
    'nên, phải, đến lượt',
    'Động từ năng nguyện',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '时间差不多了，我们该出发了。',
    'Shíjiān chàbuduō le, wǒmen gāi chūfā le.',
    'Thời gian hòm hòm rồi, chúng ta nên xuất phát thôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '时间差不多了，我们该出发了。', 'Shíjiān chàbuduō le, wǒmen gāi chūfā le.', 'Thời gian hòm hòm rồi, chúng ta nên xuất phát thôi.', 'basic', 1),
      (v_id, '该你回答老师提出的问题了。', 'Gāi nǐ huídá lǎoshī tíchū de wèntí le.', 'Đến lượt bạn trả lời câu hỏi do thầy giáo đưa ra rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [感到] (gǎndào) - cảm thấy, nhận thấy [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '感到',
    'gǎndào',
    'cảm thấy, nhận thấy',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '听到这个好消息，大家都感到很高兴。',
    'Tīng dào zhè ge hǎo xiāoxi, dàjiā dōu gǎndào hěn gāoxìng.',
    'Nghe được tin tốt lành này, ai cũng cảm thấy rất vui.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '听到这个好消息，大家都感到很高兴。', 'Tīng dào zhè ge hǎo xiāoxi, dàjiā dōu gǎndào hěn gāoxìng.', 'Nghe được tin tốt lành này, ai cũng cảm thấy rất vui.', 'basic', 1),
      (v_id, '经过一整天紧张的工作，他感到有些疲劳。', 'Jīngguò yì zhěng tiān jǐnzhāng de gōngzuò, tā gǎndào yǒuxiē píláo.', 'Trải qua cả ngày làm việc căng thẳng, anh ấy cảm thấy hơi mệt mỏi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [干] (gàn) - làm, làm việc [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '干',
    'gàn',
    'làm, làm việc',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '你周末打算干什么？',
    'Nǐ zhōumò dǎsuàn gàn shénme?',
    'Cuối tuần bạn dự định làm gì?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你周末打算干什么？', 'Nǐ zhōumò dǎsuàn gàn shénme?', 'Cuối tuần bạn dự định làm gì?', 'basic', 1),
      (v_id, '他干起活来手脚非常麻利。', 'Tā gàn qǐ huó lái shǒujiǎo fēicháng máli.', 'Anh ấy khi bắt tay vào làm việc thì tay chân rất nhanh nhẹn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [刚] (gāng) - vừa, vừa mới [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '刚',
    'gāng',
    'vừa, vừa mới',
    'Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我刚吃完早饭，现在去上班。',
    'Wǒ gāng chī wán zǎofàn, xiànzài qù shàngbān.',
    'Tôi vừa ăn sáng xong, bây giờ đi làm đây.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我刚吃完早饭，现在去上班。', 'Wǒ gāng chī wán zǎofàn, xiànzài qù shàngbān.', 'Tôi vừa ăn sáng xong, bây giờ đi làm đây.', 'basic', 1),
      (v_id, '他刚来到这所学校，对周围环境还不熟悉。', 'Tā gāng lái dào zhè suǒ xuéxiào, duì zhōuwéi huánjìng hái bù shúxī.', 'Cậu ấy vừa mới đến ngôi trường này, đối với môi trường xung quanh còn chưa quen thuộc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [刚刚] (gānggāng) - vừa mới, vừa vặn [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '刚刚',
    'gānggāng',
    'vừa mới, vừa vặn',
    'Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '汽车刚刚开走了，你得等下一班。',
    'Qìchē gānggāng kāi zǒu le, nǐ děi děng xià yì bān.',
    'Xe buýt vừa mới chạy đi rồi, bạn phải chờ chuyến sau.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '汽车刚刚开走了，你得等下一班。', 'Qìchē gānggāng kāi zǒu le, nǐ děi děng xià yì bān.', 'Xe buýt vừa mới chạy đi rồi, bạn phải chờ chuyến sau.', 'basic', 1),
      (v_id, '我刚刚把房间打扫干净，客人就敲门了。', 'Wǒ gānggāng bǎ fángjiān dǎsǎo gānjìng, kèrén jiù qiāo mén le.', 'Tôi vừa mới dọn dẹp phòng sạch sẽ thì khách đã gõ cửa rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [高铁] (gāotiě) - đường sắt cao tốc, tàu cao tốc [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '高铁',
    'gāotiě',
    'đường sắt cao tốc, tàu cao tốc',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '坐高铁从北京到上海只需要四个多小时。',
    'Zuò gāotiě cóng Běijīng dào Shànghǎi zhǐ xūyào sì gè duō xiǎoshí.',
    'Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải chỉ mất hơn bốn tiếng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '坐高铁从北京到上海只需要四个多小时。', 'Zuò gāotiě cóng Běijīng dào Shànghǎi zhǐ xūyào sì gè duō xiǎoshí.', 'Đi tàu cao tốc từ Bắc Kinh đến Thượng Hải chỉ mất hơn bốn tiếng.', 'basic', 1),
      (v_id, '高铁不仅速度快，而且非常平稳舒适。', 'Gāotiě bùjǐn sùdù kuài, érqiě fēicháng píngwěn shūshì.', 'Tàu cao tốc không chỉ tốc độ nhanh mà còn rất êm ái dễ chịu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [工作日] (gōngzuòrì) - ngày làm việc (từ thứ 2 đến thứ 6) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '工作日',
    'gōngzuòrì',
    'ngày làm việc (từ thứ 2 đến thứ 6)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '银行只在工作日对外办理业务。',
    'Yínháng zhǐ zài gōngzuòrì duì wài bànlǐ yèwù.',
    'Ngân hàng chỉ xử lý nghiệp vụ cho khách vào các ngày làm việc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '银行只在工作日对外办理业务。', 'Yínháng zhǐ zài gōngzuòrì duì wài bànlǐ yèwù.', 'Ngân hàng chỉ xử lý nghiệp vụ cho khách vào các ngày làm việc.', 'basic', 1),
      (v_id, '工作日早高峰的地铁通常非常拥挤。', 'Gōngzuòrì zǎogāofēng de dìtiě tōngcháng fēicháng yōngjǐ.', 'Tàu điện ngầm vào giờ cao điểm buổi sáng các ngày trong tuần thường rất đông đúc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [刮] (guā) - thổi (gió), cạo (râu) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '刮',
    'guā',
    'thổi (gió), cạo (râu)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '外面刮起大风了，快关窗户。',
    'Wàimiàn guā qǐ dà fēng le, kuài guān chuānghu.',
    'Bên ngoài thổi gió to rồi, mau đóng cửa sổ lại.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '外面刮起大风了，快关窗户。', 'Wàimiàn guā qǐ dà fēng le, kuài guān chuānghu.', 'Bên ngoài thổi gió to rồi, mau đóng cửa sổ lại.', 'basic', 1),
      (v_id, '他每天早上洗脸后都会仔细刮胡子。', 'Tā měitiān zǎoshang xǐliǎn hòu dōu huì zǐxì guā húzi.', 'Mỗi sáng sau khi rửa mặt anh ấy đều cẩn thận cạo râu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [关机] (guānjī) - tắt máy (điện thoại/máy tính) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '关机',
    'guānjī',
    'tắt máy (điện thoại/máy tính)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '考试时手机必须关机。',
    'Kǎoshì shí shǒujī bìxū guānjī.',
    'Khi thi điện thoại bắt buộc phải tắt máy.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '考试时手机必须关机。', 'Kǎoshì shí shǒujī bìxū guānjī.', 'Khi thi điện thoại bắt buộc phải tắt máy.', 'basic', 1),
      (v_id, '上飞机后，乘务员提醒乘客关闭手机或开启飞行模式。', 'Shàng fēijī hòu, chéngwùyuán tíxǐng chéngkè guānbì shǒujī huò kāiqǐ fēixíng móshì.', 'Sau khi lên máy bay, tiếp viên nhắc nhở hành khách tắt máy hoặc bật chế độ máy bay.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [关注] (guānzhù) - quan tâm, theo dõi (trang mạng/chủ đề) [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '关注',
    'guānzhù',
    'quan tâm, theo dõi (trang mạng/chủ đề)',
    'Động từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请大家多关注我们频道的最新动态。',
    'Qǐng dàjiā duō guānzhù wǒmen píndào de zuìxīn dòngtài.',
    'Xin mọi người hãy quan tâm theo dõi nhiều hơn các cập nhật mới nhất của kênh chúng tôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请大家多关注我们频道的最新动态。', 'Qǐng dàjiā duō guānzhù wǒmen píndào de zuìxīn dòngtài.', 'Xin mọi người hãy quan tâm theo dõi nhiều hơn các cập nhật mới nhất của kênh chúng tôi.', 'basic', 1),
      (v_id, '环境保护问题受到了全社会的高度关注。', 'Huánjìng bǎohù wèntí shòudào le quán shèhuì de gāodù guānzhù.', 'Vấn đề bảo vệ môi trường đã nhận được sự quan tâm sâu sắc của toàn xã hội.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [过节] (guòjié) - đón tết, ăn tết, mừng lễ [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '过节',
    'guòjié',
    'đón tết, ăn tết, mừng lễ',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '春节的时候，大家都回家过节。',
    'Chūnjié de shíhou, dàjiā dōu huí jiā guòjié.',
    'Vào dịp Tết Nguyên Đán, mọi người đều về nhà ăn tết.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '春节的时候，大家都回家过节。', 'Chūnjié de shíhou, dàjiā dōu huí jiā guòjié.', 'Vào dịp Tết Nguyên Đán, mọi người đều về nhà ăn tết.', 'basic', 1),
      (v_id, '过节期间街上的商铺挂满了红红的灯笼。', 'Guòjié qījiān jiē shang de shāngpù guà mǎn le hónghóng de dēnglong.', 'Trong thời gian ngày lễ, các cửa tiệm trên phố treo đầy những chiếc đèn lồng đỏ rực.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [海] (hǎi) - biển, đại dương [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '海',
    'hǎi',
    'biển, đại dương',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '夏天我们去海边游泳吧。',
    'Xiàtiān wǒmen qù hǎibiān yóuyǒng ba.',
    'Mùa hè chúng mình đi biển bơi lội nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '夏天我们去海边游泳吧。', 'Xiàtiān wǒmen qù hǎibiān yóuyǒng ba.', 'Mùa hè chúng mình đi biển bơi lội nhé.', 'basic', 1),
      (v_id, '站在山顶向远处望去，是一片蔚蓝的大海。', 'Zhàn zài shāndǐng xiàng yuǎnchù wàng qù, shì yí piàn wèilán de dàhǎi.', 'Đứng trên đỉnh núi nhìn ra xa là một vùng biển cả xanh biếc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [好多] (hǎoduō) - rất nhiều [Số từ / Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '好多',
    'hǎoduō',
    'rất nhiều',
    'Số từ / Đại từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '书店里有好多新书。',
    'Shūdiàn lǐ yǒu hǎoduō xīn shū.',
    'Trong tiệm sách có rất nhiều sách mới.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '书店里有好多新书。', 'Shūdiàn lǐ yǒu hǎoduō xīn shū.', 'Trong tiệm sách có rất nhiều sách mới.', 'basic', 1),
      (v_id, '今天超市搞促销活动，来了好多买东西的顾客。', 'Jīntiān chāoshì gǎo cùxiāo huódòng, lái le hǎoduō mǎi dōngxi de gùkè.', 'Hôm nay siêu thị có chương trình khuyến mãi, đã có rất nhiều khách hàng tới mua sắm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [好久] (hǎojiǔ) - rất lâu, hồi lâu [Tính từ / Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '好久',
    'hǎojiǔ',
    'rất lâu, hồi lâu',
    'Tính từ / Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '好久不见，你最近好吗？',
    'Hǎojiǔ bú jiàn, nǐ zuìjìn hǎo ma?',
    'Lâu lắm không gặp, dạo này bạn khỏe không?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '好久不见，你最近好吗？', 'Hǎojiǔ bú jiàn, nǐ zuìjìn hǎo ma?', 'Lâu lắm không gặp, dạo này bạn khỏe không?', 'basic', 1),
      (v_id, '他在火车站等了好久，终于等到了朋友的列车。', 'Tā zài huǒchēzhàn děng le hǎojiǔ, zhōngyú děngdào le péngyou de lièchē.', 'Anh ấy đợi ở ga tàu hồi lâu, cuối cùng cũng đón được chuyến tàu của người bạn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [好像] (hǎoxiàng) - hình như, dường như [Động từ / Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '好像',
    'hǎoxiàng',
    'hình như, dường như',
    'Động từ / Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '天阴了，好像要下雨了。',
    'Tiān yīn le, hǎoxiàng yào xiàyǔ le.',
    'Trời âm u rồi, hình như sắp mưa rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '天阴了，好像要下雨了。', 'Tiān yīn le, hǎoxiàng yào xiàyǔ le.', 'Trời âm u rồi, hình như sắp mưa rồi.', 'basic', 1),
      (v_id, '看他的表情，好像遇到了什么开心的事。', 'Kàn tā de biǎoqíng, hǎoxiàng yù dào le shénme kāixīn de shì.', 'Nhìn vẻ mặt của anh ấy, dường như đã gặp chuyện gì rất vui.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [号码] (hàomǎ) - số, số hiệu, mã số [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '号码',
    'hàomǎ',
    'số, số hiệu, mã số',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请留下您的电话号码。',
    'Qǐng liú xià nín de diànhuà hàomǎ.',
    'Xin hãy để lại số điện thoại của bạn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请留下您的电话号码。', 'Qǐng liú xià nín de diànhuà hàomǎ.', 'Xin hãy để lại số điện thoại của bạn.', 'basic', 1),
      (v_id, '请核对一下银行卡上的账号号码是否正确。', 'Qǐng hScatter yíxià yínhángkǎ shang de zhànghào hàomǎ shìfǒu zhèngquè.', 'Xin hãy đối chiếu xem số tài khoản trên thẻ ngân hàng có chính xác không.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [河] (hé) - sông, dòng sông [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '河',
    'hé',
    'sông, dòng sông',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这条河的水非常清澈。',
    'Zhè tiáo hé de shuǐ fēicháng qīngchè.',
    'Nước của dòng sông này rất trong vắt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这条河的水非常清澈。', 'Zhè tiáo hé de shuǐ fēicháng qīngchè.', 'Nước của dòng sông này rất trong vắt.', 'basic', 1),
      (v_id, '傍晚许多老人和孩子都在河边散步吹风。', 'Bàngwǎn xǔduō lǎorén hé háizi dōu zài hébiān sànbù chuī fēng.', 'Lúc hoàng hôn nhiều người già và trẻ nhỏ đều đi dạo hóng mát ven sông.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [合适] (héshì) - thích hợp, vừa vặn [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '合适',
    'héshì',
    'thích hợp, vừa vặn',
    'Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这件衣服大小正合适。',
    'Zhè jiàn yīfu dàxiǎo zhèng héshì.',
    'Bộ quần áo này kích cỡ vừa vặn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这件衣服大小正合适。', 'Zhè jiàn yīfu dàxiǎo zhèng héshì.', 'Bộ quần áo này kích cỡ vừa vặn.', 'basic', 1),
      (v_id, '找一份合适的工作需要耐心和机遇。', 'Zhǎo yí fèn héshì de gōngzuò xūyào nàixīn hé jīyù.', 'Tìm một công việc phù hợp đòi hỏi sự kiên nhẫn và cơ duyên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [红绿灯] (hóng-lǜdēng) - đèn tín hiệu giao thông (đèn xanh đèn đỏ) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '红绿灯',
    'hóng-lǜdēng',
    'đèn tín hiệu giao thông (đèn xanh đèn đỏ)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '过马路要看红绿灯。',
    'Guò mǎlù yào kàn hóng-lǜdēng.',
    'Qua đường cần phải nhìn đèn giao thông.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '过马路要看红绿灯。', 'Guò mǎlù yào kàn hóng-lǜdēng.', 'Qua đường cần phải nhìn đèn giao thông.', 'basic', 1),
      (v_id, '在十字路口遇到红灯要停，绿灯才能通行。', 'Zài shízì lùkǒu yù dào hóngdēng yào tíng, lǜdēng cái néng tōngxíng.', 'Ở ngã tư gặp đèn đỏ phải dừng lại, đèn xanh mới được đi qua.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [后年] (hòunián) - năm kia (hai năm sau) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '后年',
    'hòunián',
    'năm kia (hai năm sau)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他打算后年大学毕业。',
    'Tā dǎsuàn hòunián dàxué bìyè.',
    'Anh ấy dự định năm kia sẽ tốt nghiệp đại học.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他打算后年大学毕业。', 'Tā dǎsuàn hòunián dàxué bìyè.', 'Anh ấy dự định năm kia sẽ tốt nghiệp đại học.', 'basic', 1),
      (v_id, '后年我们全家计划一起去北京旅游。', 'Hòunián wǒmen quán jiā jìhuà yìqǐ qù Běijīng lǚyóu.', 'Năm kia cả gia đình chúng tôi lên kế hoạch cùng nhau đi Bắc Kinh du lịch.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [后天] (hòutiān) - ngày kia (hai ngày sau) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '后天',
    'hòutiān',
    'ngày kia (hai ngày sau)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '后天上午我们有一个重要的考试。',
    'Hòutiān shàngwǔ wǒmen yǒu yí gè zhòngyào de kǎoshì.',
    'Sáng ngày kia chúng tôi có một bài thi quan trọng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '后天上午我们有一个重要的考试。', 'Hòutiān shàngwǔ wǒmen yǒu yí gè zhòngyào de kǎoshì.', 'Sáng ngày kia chúng tôi có một bài thi quan trọng.', 'basic', 1),
      (v_id, '明天他有会议，所以我们约在后天见面。', 'Míngtiān tā yǒu huìyì, suǒyǐ wǒmen yuē zài hòutiān jiànmiàn.', 'Ngày mai anh ấy có cuộc họp, vì vậy chúng tôi hẹn gặp vào ngày kia.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [花园] (huāyuán) - vườn hoa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '花园',
    'huāyuán',
    'vườn hoa',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '楼下的花园里开满了鲜花。',
    'Lóuxià de huāyuán lǐ kāi mǎn le xiānhuā.',
    'Trong vườn hoa dưới tầng nở đầy những bông hoa tươi thắm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '楼下的花园里开满了鲜花。', 'Lóuxià de huāyuán lǐ kāi mǎn le xiānhuā.', 'Trong vườn hoa dưới tầng nở đầy những bông hoa tươi thắm.', 'basic', 1),
      (v_id, '老爷爷每天清晨都会在花园里给植物浇水。', 'Lǎoyéye měitiān qīngchén dōu huì zài huāyuán lǐ gěi zhíwù jiāo shuǐ.', 'Ông cụ mỗi sáng sớm đều tưới nước cho cây cối trong vườn hoa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [画家] (huàjiā) - họa sĩ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '画家',
    'huàjiā',
    'họa sĩ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他的梦想是成为一名著名画家。',
    'Tā de mèngxiǎng shì chéngwéi yì míng zhùmíng huàjiā.',
    'Ước mơ của anh ấy là trở thành một họa sĩ nổi tiếng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他的梦想是成为一名著名画家。', 'Tā de mèngxiǎng shì chéngwéi yì míng zhùmíng huàjiā.', 'Ước mơ của anh ấy là trở thành một họa sĩ nổi tiếng.', 'basic', 1),
      (v_id, '那位画家用画笔生动地描绘了大自然的美景。', 'Nà wèi huàjiā yòng huàbǐ shēngdòng de miáohuì le dàzìrán de měijǐng.', 'Vị họa sĩ đó dùng cây cọ vẽ miêu tả sinh động cảnh sắc tươi đẹp của thiên nhiên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [还] (huán) - trả lại, hoàn trả [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '还',
    'huán',
    'trả lại, hoàn trả',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我明天去图书馆把借的书还了。',
    'Wǒ míngtiān qù túshūguǎn bǎ jiè de shū huán le.',
    'Ngày mai tôi đến thư viện đem trả số sách đã mượn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我明天去图书馆把借的书还了。', 'Wǒ míngtiān qù túshūguǎn bǎ jiè de shū huán le.', 'Ngày mai tôi đến thư viện đem trả số sách đã mượn.', 'basic', 1),
      (v_id, '借别人的东西一定要按时归还。', 'Jiè biérén de dōngxi yídìng yào ànshí guīhuán.', 'Mượn đồ của người khác nhất định phải hoàn trả đúng hạn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [黄色] (huángsè) - màu vàng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '黄色',
    'huángsè',
    'màu vàng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '她今天穿了一件黄色的毛衣。',
    'Tā jīntiān chuān le yí jiàn huángsè de máoyī.',
    'Hôm nay cô ấy mặc một chiếc áo len màu vàng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '她今天穿了一件黄色的毛衣。', 'Tā jīntiān chuān le yí jiàn huángsè de máoyī.', 'Hôm nay cô ấy mặc một chiếc áo len màu vàng.', 'basic', 1),
      (v_id, '秋天到来时，树上的叶子渐渐变成了金黄色。', 'Qiūtiān dàolái shí, shù shang de yèzi jiànjiàn biànchéng le jīnhuángsè.', 'Khi mùa thu tới, lá trên cây dần dần biến thành màu vàng óng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [会] (huì) - cuộc họp, hội nghị, hiệp hội [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '会',
    'huì',
    'cuộc họp, hội nghị, hiệp hội',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天下午两点公司有一个全体会。',
    'Jīntiān xiàwǔ liǎng diǎn gōngsī yǒu yí gè quántǐ huì.',
    'Hai giờ chiều nay công ty có một cuộc họp toàn thể.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天下午两点公司有一个全体会。', 'Jīntiān xiàwǔ liǎng diǎn gōngsī yǒu yí gè quántǐ huì.', 'Hai giờ chiều nay công ty có một cuộc họp toàn thể.', 'basic', 1),
      (v_id, '经理正在会议室主持年度总结会。', 'Jīnglǐ zhèngzài huìyìshì zhǔchí niándù zǒngjié huì.', 'Giám đốc đang ở trong phòng họp chủ trì cuộc họp tổng kết năm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [或] (huò) - hoặc, hay là (dùng trong câu trần thuật) [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '或',
    'huò',
    'hoặc, hay là (dùng trong câu trần thuật)',
    'Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '你可以乘坐地铁或公交车去那里。',
    'Nǐ kěyǐ chéngzuò dìtiě huò gōngjiāochē qù nàlǐ.',
    'Bạn có thể đi tàu điện ngầm hoặc xe buýt đến đó.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你可以乘坐地铁或公交车去那里。', 'Nǐ kěyǐ chéngzuò dìtiě huò gōngjiāochē qù nàlǐ.', 'Bạn có thể đi tàu điện ngầm hoặc xe buýt đến đó.', 'basic', 1),
      (v_id, '周末我通常在家里看书，或陪家人去公园散步。', 'Zhōumò wǒ tōngcháng zài jiālǐ kàn shū, huò péi jiārén qù gōngyuán sànbù.', 'Cuối tuần tôi thường ở nhà đọc sách, hoặc đưa người nhà đi dạo công viên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [鸡] (jī) - gà, con gà [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '鸡',
    'jī',
    'gà, con gà',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '奶奶在院子里养了几只小鸡。',
    'Nǎinai zài yuànzi lǐ yǎng le jǐ zhī xiǎo jī.',
    'Bà nội nuôi vài chú gà con trong sân.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '奶奶在院子里养了几只小鸡。', 'Nǎinai zài yuànzi lǐ yǎng le jǐ zhī xiǎo jī.', 'Bà nội nuôi vài chú gà con trong sân.', 'basic', 1),
      (v_id, '妈妈今天中午做了一道非常美味的红烧鸡块。', 'Māma jīntiān zhōngwǔ zuò le yí dào fēicháng měiwèi de hóngshāo jīkuài.', 'Trưa nay mẹ làm một món gà kho tương vô cùng ngon miệng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [急] (jí) - gấp gáp, sốt ruột, nôn nóng [Tính từ / Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '急',
    'jí',
    'gấp gáp, sốt ruột, nôn nóng',
    'Tính từ / Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '你别急，有话慢慢说。',
    'Nǐ bié jí, yǒu huà mànmàn shuō.',
    'Bạn đừng sốt ruột, có chuyện gì cứ từ từ nói.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你别急，有话慢慢说。', 'Nǐ bié jí, yǒu huà mànmàn shuō.', 'Bạn đừng sốt ruột, có chuyện gì cứ từ từ nói.', 'basic', 1),
      (v_id, '这是一份急件，需要立刻送到经理办公室。', 'Zhè shì yí fèn jíjiàn, xūyào lìkè sòng dào jīnglǐ bàngōngshì.', 'Đây là một tài liệu khẩn cấp, cần lập tức chuyển đến văn phòng giám đốc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [记] (jì) - nhớ, ghi nhớ, ghi chép [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '记',
    'jì',
    'nhớ, ghi nhớ, ghi chép',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我记住了你的名字。',
    'Wǒ jì zhù le nǐ de míngzi.',
    'Tôi đã ghi nhớ tên của bạn rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我记住了你的名字。', 'Wǒ jì zhù le nǐ de míngzi.', 'Tôi đã ghi nhớ tên của bạn rồi.', 'basic', 1),
      (v_id, '每天坚持记十个生词，一年就能掌握很多词汇。', 'Měitiān jiānchí jì shí gè shēngcí, yì nián jiù néng zhǎngwò hěn duō cíhuì.', 'Mỗi ngày kiên trì nhớ mười từ mới, một năm là có thể nắm vững rất nhiều từ vựng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [季] (jì) - mùa, quý [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '季',
    'jì',
    'mùa, quý',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '一年有春夏秋冬四个季。',
    'Yì nián yǒu chūn xià qiū dōng sì gè jì.',
    'Một năm có bốn mùa xuân hạ thu đông.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '一年有春夏秋冬四个季。', 'Yì nián yǒu chūn xià qiū dōng sì gè jì.', 'Một năm có bốn mùa xuân hạ thu đông.', 'basic', 1),
      (v_id, '现在正是吃西瓜的应季时节，又甜又便宜。', 'Xiànzài zhèng shì chī xīguā de yìngjì shíjié, yòu tián yòu piányi.', 'Bây giờ đúng vào mùa ăn dưa hấu, vừa ngọt vừa rẻ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [加] (jiā) - cộng, thêm, gia tăng [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '加',
    'jiā',
    'cộng, thêm, gia tăng',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '三加五等于八。',
    'Sān jiā wǔ děngyú bā.',
    'Ba cộng năm bằng tám.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '三加五等于八。', 'Sān jiā wǔ děngyú bā.', 'Ba cộng năm bằng tám.', 'basic', 1),
      (v_id, '天气凉了，出门别忘了多加一件衣服。', 'Tiānqì liáng le, chūmén bié wàng le duō jiā yí jiàn yīfu.', 'Trời se lạnh rồi, ra ngoài đừng quên mặc thêm một chiếc áo.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [假期] (jiàqī) - kỳ nghỉ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '假期',
    'jiàqī',
    'kỳ nghỉ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这个暑期假期你打算怎么过？',
    'Zhè ge shǔqī jiàqī nǐ dǎsuàn zěnme guò?',
    'Kỳ nghỉ hè này bạn dự định trải qua thế nào?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个暑期假期你打算怎么过？', 'Zhè ge shǔqī jiàqī nǐ dǎsuàn zěnme guò?', 'Kỳ nghỉ hè này bạn dự định trải qua thế nào?', 'basic', 1),
      (v_id, '在漫长的假期里，多读好书能开阔视野。', 'Zài màncháng de jiàqī lǐ, duō dú hǎoshū néng kāikuò shìyě.', 'Trong kỳ nghỉ dài dặc, đọc nhiều sách hay có thể mở rộng tầm nhìn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [坚持] (jiānchí) - kiên trì, giữ vững [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '坚持',
    'jiānchí',
    'kiên trì, giữ vững',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他每天都坚持早起晨跑。',
    'Tā měitiān dōu jiānchí zǎoqǐ chénpǎo.',
    'Anh ấy ngày nào cũng kiên trì dậy sớm chạy bộ buổi sáng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他每天都坚持早起晨跑。', 'Tā měitiān dōu jiānchí zǎoqǐ chénpǎo.', 'Anh ấy ngày nào cũng kiên trì dậy sớm chạy bộ buổi sáng.', 'basic', 1),
      (v_id, '学外语只要坚持下去，就一定能取得成功。', 'Xué wàiyǔ zhǐyào jiānchí xiàqù, jiù yídìng néng qǔdé chénggōng.', 'Học ngoại ngữ chỉ cần kiên trì bền bỉ thì nhất định sẽ gặt hái thành công.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [检票] (jiǎnpiào) - soát vé [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '检票',
    'jiǎnpiào',
    'soát vé',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '火车马上就要开始检票了。',
    'Huǒchē mǎshàng jiù yào kāishǐ jiǎnpiào le.',
    'Tàu hỏa sắp bắt đầu soát vé rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '火车马上就要开始检票了。', 'Huǒchē mǎshàng jiù yào kāishǐ jiǎnpiào le.', 'Tàu hỏa sắp bắt đầu soát vé rồi.', 'basic', 1),
      (v_id, '请旅客朋友们提前准备好车票和身份证排队检票。', 'Qǐng lǚkè péngyoumen tíqián zhǔnbèi hǎo chēpiào hé shēnfènzhèng páiduì jiǎnpiào.', 'Xin mời quý hành khách chuẩn bị sẵn vé tàu và căn cước xếp hàng soát vé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [街] (jiē) - phố, đường phố [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '街',
    'jiē',
    'phố, đường phố',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这条街上有许多特色小吃店。',
    'Zhè tiáo jiē shang yǒu xǔduō tèsè xiǎochīdiàn.',
    'Trên con phố này có nhiều quán ăn vặt đặc sắc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这条街上有许多特色小吃店。', 'Zhè tiáo jiē shang yǒu xǔduō tèsè xiǎochīdiàn.', 'Trên con phố này có nhiều quán ăn vặt đặc sắc.', 'basic', 1),
      (v_id, '周末我和朋友喜欢去步行街逛街买衣服。', 'Zhōumò wǒ hé péngyou xǐhuan qù bùxíngjiē guàng jiē mǎi yīfu.', 'Cuối tuần tôi và bạn bè thích đi dạo phố đi bộ mua sắm quần áo.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [节] (jié) - tiết (học); ngày lễ; đốt (tre) [Lượng từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '节',
    'jié',
    'tiết (học); ngày lễ; đốt (tre)',
    'Lượng từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天上午我们有两节汉语课。',
    'Jīntiān shàngwǔ wǒmen yǒu liǎng jié Hànyǔ kè.',
    'Sáng nay chúng tôi có hai tiết tiếng Trung.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天上午我们有两节汉语课。', 'Jīntiān shàngwǔ wǒmen yǒu liǎng jié Hànyǔ kè.', 'Sáng nay chúng tôi có hai tiết tiếng Trung.', 'basic', 1),
      (v_id, '中秋节是中国人合家团圆的重要传统节日。', 'Zhōngqiūjié shì Zhōngguó rén héjiā tuányuán de zhòngyào chuántǒng jiérì.', 'Tết Trung thu là ngày lễ truyền thống sum họp gia đình quan trọng của người Trung Quốc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [姐妹] (jiěmèi) - chị em gái [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '姐妹',
    'jiěmèi',
    'chị em gái',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '她们俩是一对感情很好的姐妹。',
    'Tāmen liǎ shì yí duì gǎnqíng hěn hǎo de jiěmèi.',
    'Hai người họ là một cặp chị em gái tình cảm rất tốt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '她们俩是一对感情很好的姐妹。', 'Tāmen liǎ shì yí duì gǎnqíng hěn hǎo de jiěmèi.', 'Hai người họ là một cặp chị em gái tình cảm rất tốt.', 'basic', 1),
      (v_id, '姐妹俩长得很像，外人经常分不清楚。', 'Jiěmèi liǎ zhǎng de hěn xiàng, wàirén jīngcháng fēn bù qīngchu.', 'Hai chị em trông rất giống nhau, người ngoài thường không phân biệt được.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [斤] (jīn) - cân (đơn vị đo Trung Quốc = 500 gram) [Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '斤',
    'jīn',
    'cân (đơn vị đo Trung Quốc = 500 gram)',
    'Lượng từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请给我称两斤新鲜的苹果。',
    'Qǐng gěi wǒ chēng liǎng jīn xīnxiān de píngguǒ.',
    'Làm ơn cân cho tôi hai cân (1kg) táo tươi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请给我称两斤新鲜的苹果。', 'Qǐng gěi wǒ chēng liǎng jīn xīnxiān de píngguǒ.', 'Làm ơn cân cho tôi hai cân (1kg) táo tươi.', 'basic', 1),
      (v_id, '市场上香蕉三块钱一斤，挺实惠的。', 'Shìchǎng shang xiāngjiāo sān kuài qián yì jīn, tǐng shíhuì de.', 'Trên chợ chuối ba tệ một cân (500g), khá vừa túi tiền.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [酒] (jiǔ) - rượu, cồn [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '酒',
    'jiǔ',
    'rượu, cồn',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '开车千万不能喝酒。',
    'Kāi chē qiānwàn bù néng hē jiǔ.',
    'Lái xe tuyệt đối không được uống rượu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '开车千万不能喝酒。', 'Kāi chē qiānwàn bù néng hē jiǔ.', 'Lái xe tuyệt đối không được uống rượu.', 'basic', 1),
      (v_id, '中国人在喜庆的日子里常常举杯敬酒庆祝。', 'Zhōngguó rén zài xǐqìng de rìzi lǐ chángcháng jǔ bēi jìng jiǔ qìngzhù.', 'Người Trung Quốc vào những ngày hỷ sự thường nâng ly kính rượu chúc mừng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [句] (jù) - câu (lượng từ của lời nói, câu văn) [Lượng từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '句',
    'jù',
    'câu (lượng từ của lời nói, câu văn)',
    'Lượng từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这句话的意思是什么？',
    'Zhè jù huà de yìsi shì shénme?',
    'Ý nghĩa của câu nói này là gì?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这句话的意思是什么？', 'Zhè jù huà de yìsi shì shénme?', 'Ý nghĩa của câu nói này là gì?', 'basic', 1),
      (v_id, '他用流利的汉语完整地复述了课文中的每一个句子。', 'Tā yòng liúlì de Hànyǔ wánzhěng de fùshù le kèwén zhōng de měi yí gè jùzi.', 'Cậu ấy dùng tiếng Trung lưu loát thuật lại trọn vẹn từng câu trong bài đọc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [卡] (kǎ) - thẻ (thẻ ngân hàng, thẻ từ, sim) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '卡',
    'kǎ',
    'thẻ (thẻ ngân hàng, thẻ từ, sim)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我的饭卡里没有钱了，需要充值。',
    'Wǒ de fànkǎ lǐ méiyǒu qián le, xūyào chōngzhí.',
    'Thẻ ăn của tôi hết tiền rồi, cần nạp thêm tiền.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我的饭卡里没有钱了，需要充值。', 'Wǒ de fànkǎ lǐ méiyǒu qián le, xūyào chōngzhí.', 'Thẻ ăn của tôi hết tiền rồi, cần nạp thêm tiền.', 'basic', 1),
      (v_id, '进宿舍楼大门时记得刷门禁卡。', 'Jìn sùshèlóu dàmén shí jìde shuā ménjìnkǎ.', 'Khi vào cổng ký túc xá nhớ quẹt thẻ từ ra vào.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [开花] (kāihuā) - nở hoa [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '开花',
    'kāihuā',
    'nở hoa',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '院子里的苹果树开花了。',
    'Yuànzi lǐ de píngguǒshù kāihuā le.',
    'Cây táo trong sân đã nở hoa rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '院子里的苹果树开花了。', 'Yuànzi lǐ de píngguǒshù kāihuā le.', 'Cây táo trong sân đã nở hoa rồi.', 'basic', 1),
      (v_id, '春天一到，公园里的各种花儿都竞相开花。', 'Chūntiān yí dào, gōngyuán lǐ de gè zhǒng huār dōu jìngxiāng kāihuā.', 'Mùa xuân vừa đến, muôn hoa trong công viên đều đua nhau khoe sắc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [开会] (kāihuì) - họp, mở cuộc họp [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '开会',
    'kāihuì',
    'họp, mở cuộc họp',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '经理正在三楼会议室开会。',
    'Jīnglǐ zhèngzài sān lóu huìyìshì kāihuì.',
    'Giám đốc đang họp ở phòng họp tầng ba.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '经理正在三楼会议室开会。', 'Jīnglǐ zhèngzài sān lóu huìyìshì kāihuì.', 'Giám đốc đang họp ở phòng họp tầng ba.', 'basic', 1),
      (v_id, '开会期间请大家把手机调成静音状态。', 'Kāihuì qījiān qǐng dàjiā bǎ shǒujī tiáo chéng jìngyīn zhuàngtài.', 'Trong thời gian họp xin mọi người chuyển điện thoại sang chế độ im lặng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [开机] (kāijī) - mở máy, bật máy (điện thoại/máy tính) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '开机',
    'kāijī',
    'mở máy, bật máy (điện thoại/máy tính)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请按这个按钮开机。',
    'Qǐng àn zhè ge ànniǔ kāijī.',
    'Xin hãy bấm nút này để bật máy.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请按这个按钮开机。', 'Qǐng àn zhè ge ànniǔ kāijī.', 'Xin hãy bấm nút này để bật máy.', 'basic', 1),
      (v_id, '飞机安全降落后，乘客们纷纷开机向家人报平安。', 'Fēijī ānquán jiàngluò hòu, chéngkèmen fēnfēn kāijī xiàng jiārén bào píng’ān.', 'Sau khi máy bay hạ cánh an toàn, các hành khách lần lượt mở máy báo bình an cho người nhà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [开心] (kāixīn) - vui vẻ, phấn khởi [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '开心',
    'kāixīn',
    'vui vẻ, phấn khởi',
    'Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天和朋友聚会玩得真开心。',
    'Jīntiān hé péngyou jùhuì wán de zhēn kāixīn.',
    'Hôm nay tụ tập cùng bạn bè chơi thật là vui.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天和朋友聚会玩得真开心。', 'Jīntiān hé péngyou jùhuì wán de zhēn kāixīn.', 'Hôm nay tụ tập cùng bạn bè chơi thật là vui.', 'basic', 1),
      (v_id, '收到理想大学的录取通知书，全家人都特别开心。', 'Shōudào lǐxiǎng dàxué de lùqǔ tōngzhīshū, quán jiā rén dōu tèbié kāixīn.', 'Nhận được giấy báo trúng tuyển của trường đại học mơ ước, cả nhà đều đặc biệt vui mừng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [看来] (kànlái) - xem ra, nhìn chung thì [Động từ / Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '看来',
    'kànlái',
    'xem ra, nhìn chung thì',
    'Động từ / Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '看来今天不会下雨了。',
    'Kànlái jīntiān bú huì xiàyǔ le.',
    'Xem ra hôm nay trời sẽ không mưa đâu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '看来今天不会下雨了。', 'Kànlái jīntiān bú huì xiàyǔ le.', 'Xem ra hôm nay trời sẽ không mưa đâu.', 'basic', 1),
      (v_id, '看他的样子，看来这次考试成绩考得不错。', 'Kàn tā de yàngzi, kànlái zhè cì kǎoshì chéngjì kǎo de búcuò.', 'Nhìn dáng vẻ của anh ấy, xem ra thành tích kỳ thi lần này làm bài rất khá.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [可] (kě) - thật là, nhưng, có thể [Phó từ / Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '可',
    'kě',
    'thật là, nhưng, có thể',
    'Phó từ / Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天的天气可真冷啊！',
    'Jīntiān de tiānqì kě zhēn lěng a!',
    'Thời tiết hôm nay thật là lạnh quá đi!'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天的天气可真冷啊！', 'Jīntiān de tiānqì kě zhēn lěng a!', 'Thời tiết hôm nay thật là lạnh quá đi!', 'basic', 1),
      (v_id, '我想去旅行，可最近工作实在太忙了。', 'Wǒ xiǎng qù lǚxíng, kě zuìjìn gōngzuò shízài tài máng le.', 'Tôi muốn đi du lịch, nhưng dạo này công việc thực sự quá bận rộn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [可是] (kěshì) - nhưng, nhưng mà [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '可是',
    'kěshì',
    'nhưng, nhưng mà',
    'Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他很想去，可是没有买到票。',
    'Tā hěn xiǎng qù, kěshì méiyǒu mǎidào piào.',
    'Anh ấy rất muốn đi nhưng không mua được vé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他很想去，可是没有买到票。', 'Tā hěn xiǎng qù, kěshì méiyǒu mǎidào piào.', 'Anh ấy rất muốn đi nhưng không mua được vé.', 'basic', 1),
      (v_id, '虽然学汉语不容易，可是大家都学得很认真。', 'Suīrán xué Hànyǔ bù róngyì, kěshì dàjiā dōu xué de hěn rènzhēn.', 'Tuy học tiếng Trung không dễ dàng, thế nhưng mọi người đều học tập rất nghiêm túc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [课本] (kèběn) - sách giáo khoa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '课本',
    'kèběn',
    'sách giáo khoa',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请大家把课本翻到第五十页。',
    'Qǐng dàjiā bǎ kèběn fān dào dì wǔshí yè.',
    'Xin mời mọi người mở sách giáo khoa đến trang 50.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请大家把课本翻到第五十页。', 'Qǐng dàjiā bǎ kèběn fān dào dì wǔshí yè.', 'Xin mời mọi người mở sách giáo khoa đến trang 50.', 'basic', 1),
      (v_id, '这套汉语课本图文并茂，非常适合初学者。', 'Zhè tào Hànyǔ kèběn túwén bìngmào, fēicháng shìhé chūxuézhě.', 'Bộ sách giáo khoa tiếng Trung này hình ảnh và chữ viết phong phú, rất thích hợp cho người mới học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [课文] (kèwén) - bài đọc, bài khóa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '课文',
    'kèwén',
    'bài đọc, bài khóa',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请跟着录音朗读这篇课文。',
    'Qǐng gēnzhe lùyīn lǎngdú zhè piān kèwén.',
    'Xin hãy đọc to bài khóa này theo băng ghi âm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请跟着录音朗读这篇课文。', 'Qǐng gēnzhe lùyīn lǎngdú zhè piān kèwén.', 'Xin hãy đọc to bài khóa này theo băng ghi âm.', 'basic', 1),
      (v_id, '课文里的生词和语法点都要熟练掌握。', 'Kèwén lǐ de shēngcí hé yǔfǎdiǎn dōu yào shúliàn zhǎngwò.', 'Các từ mới và điểm ngữ pháp trong bài đọc đều cần phải nắm vững thành thạo.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [矿泉水] (kuàngquánshuǐ) - nước khoáng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '矿泉水',
    'kuàngquánshuǐ',
    'nước khoáng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '服务员，请给我一瓶常温的矿泉水。',
    'Fúwùyuán, qǐng gěi wǒ yì píng chángwēn de kuàngquánshuǐ.',
    'Phục vụ ơi, làm ơn cho tôi một chai nước khoáng nhiệt độ phòng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '服务员，请给我一瓶常温的矿泉水。', 'Fúwùyuán, qǐng gěi wǒ yì píng chángwēn de kuàngquánshuǐ.', 'Phục vụ ơi, làm ơn cho tôi một chai nước khoáng nhiệt độ phòng.', 'basic', 1),
      (v_id, '运动出汗后，喝一点儿矿泉水能补充身体的水分。', 'Yùndòng chū hàn hòu, hē yìdiǎnr kuàngquánshuǐ néng bǔchōng shēntǐ de shuǐfèn.', 'Sau khi vận động ra mồ hôi, uống một chút nước khoáng có thể bổ sung lượng nước cho cơ thể.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [来自] (láizì) - đến từ, xuất thân từ [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '来自',
    'láizì',
    'đến từ, xuất thân từ',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们班的留学生来自世界各地。',
    'Wǒmen bān de liúxuéshēng láizì shìjiè gèdì.',
    'Lưu học sinh lớp chúng tôi đến từ khắp nơi trên thế giới.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们班的留学生来自世界各地。', 'Wǒmen bān de liúxuéshēng láizì shìjiè gèdì.', 'Lưu học sinh lớp chúng tôi đến từ khắp nơi trên thế giới.', 'basic', 1),
      (v_id, '这位学者来自一所著名的历史研究机构。', 'Zhè wèi xuézhě láizì yì suǒ zhùmíng de lìshǐ yánjiū jīgòu.', 'Học giả này đến từ một cơ quan nghiên cứu lịch sử nổi tiếng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [老人] (lǎorén) - người già, người cao tuổi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '老人',
    'lǎorén',
    'người già, người cao tuổi',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '在公交车上要主动给老人让座。',
    'Zài gōngjiāochē shang yào zhǔdòng gěi lǎorén ràngzuò.',
    'Trên xe buýt cần chủ động nhường ghế cho người cao tuổi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '在公交车上要主动给老人让座。', 'Zài gōngjiāochē shang yào zhǔdòng gěi lǎorén ràngzuò.', 'Trên xe buýt cần chủ động nhường ghế cho người cao tuổi.', 'basic', 1),
      (v_id, '关爱社区里的空巢老人是整个社会的责任。', 'Guān’ài shèqū lǐ de kōngcháo lǎorén shì zhěnggè shèhuì de zérèn.', 'Quan tâm chăm sóc những người già neo đơn trong cộng đồng là trách nhiệm của toàn xã hội.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [练] (liàn) - luyện tập, rèn luyện [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '练',
    'liàn',
    'luyện tập, rèn luyện',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他每天晚上都在房间里练书法。',
    'Tā měitiān wǎnshang dōu zài fángjiān lǐ liàn shūfǎ.',
    'Mỗi tối anh ấy đều ở trong phòng luyện thư pháp.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他每天晚上都在房间里练书法。', 'Tā měitiān wǎnshang dōu zài fángjiān lǐ liàn shūfǎ.', 'Mỗi tối anh ấy đều ở trong phòng luyện thư pháp.', 'basic', 1),
      (v_id, '要想把汉字写得漂亮，必须多写多练。', 'Yào xiǎng bǎ Hànzì xiě de piàoliang, bìxū duō xiě duō liàn.', 'Muốn viết chữ Hán đẹp thì nhất định phải viết nhiều luyện nhiều.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [凉快] (liángkuai) - mát mẻ, dễ chịu [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '凉快',
    'liángkuai',
    'mát mẻ, dễ chịu',
    'Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '下过雨后，天气变得很凉快。',
    'Xià guò yǔ hòu, tiānqì biàn de hěn liángkuai.',
    'Sau cơn mưa, thời tiết trở nên rất mát mẻ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '下过雨后，天气变得很凉快。', 'Xià guò yǔ hòu, tiānqì biàn de hěn liángkuai.', 'Sau cơn mưa, thời tiết trở nên rất mát mẻ.', 'basic', 1),
      (v_id, '夏天晚上坐在大树下乘凉十分凉快舒适。', 'Xiàtiān wǎnshang zuò zài dà shù xià chéngliáng shífēn liángkuai shūshì.', 'Buổi tối mùa hè ngồi hóng mát dưới bóng cây to vô cùng mát mẻ và thoải mái.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [聊] (liáo) - tán gẫu, trò chuyện [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '聊',
    'liáo',
    'tán gẫu, trò chuyện',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '有空我们找个地方好好聊聊。',
    'Yǒukòng wǒmen zhǎo gè dìfang hǎohāo liáoliao.',
    'Khi nào rảnh chúng mình tìm chỗ nào đó nói chuyện nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '有空我们找个地方好好聊聊。', 'Yǒukòng wǒmen zhǎo gè dìfang hǎohāo liáoliao.', 'Khi nào rảnh chúng mình tìm chỗ nào đó nói chuyện nhé.', 'basic', 1),
      (v_id, '他们俩在咖啡馆里聊了一个下午的工作打算。', 'Tāmen liǎ zài kāfēiguǎn lǐ liáo le yí gè xiàwǔ de gōngzuò dǎsuàn.', 'Hai người họ ở quán cà phê trò chuyện suốt cả buổi chiều về dự định công việc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [聊天儿] (liáotiānr) - nói chuyện, chuyện trò phiếm [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '聊天儿',
    'liáotiānr',
    'nói chuyện, chuyện trò phiếm',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '老人们常常聚在树荫下聊天儿。',
    'Lǎorénmen chángcháng jù zài shùyīn xià liáotiānr.',
    'Các cụ già thường tụ tập dưới bóng râm trò chuyện.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '老人们常常聚在树荫下聊天儿。', 'Lǎorénmen chángcháng jù zài shùyīn xià liáotiānr.', 'Các cụ già thường tụ tập dưới bóng râm trò chuyện.', 'basic', 1),
      (v_id, '晚饭后一家人坐在一起聊天儿是一天中最轻松的时光。', 'Wǎnfàn hòu yì jiā rén zuò zài yìqǐ liáotiānr shì yì tiān zhōng zuì qīngsōng de shíguāng.', 'Sau bữa tối cả nhà quây quần trò chuyện là khoảng thời gian thư thái nhất trong ngày.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [留学生] (liúxuéshēng) - lưu học sinh, du học sinh [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '留学生',
    'liúxuéshēng',
    'lưu học sinh, du học sinh',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '大学里有许多来自不同国家的留学生。',
    'Dàxué lǐ yǒu xǔduō láizì bù tóng guójiā de liúxuéshēng.',
    'Trong trường đại học có nhiều lưu học sinh đến từ các quốc gia khác nhau.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '大学里有许多来自不同国家的留学生。', 'Dàxué lǐ yǒu xǔduō láizì bù tóng guójiā de liúxuéshēng.', 'Trong trường đại học có nhiều lưu học sinh đến từ các quốc gia khác nhau.', 'basic', 1),
      (v_id, '学校为新入学的留学生组织了丰富多彩的文化体验活动。', 'Xuéxiào wèi xīn rùxué de liúxuéshēng zǔzhī le fēngfù duōcǎi de wénhuà tǐyàn huódòng.', 'Trường học đã tổ chức những hoạt động trải nghiệm văn hóa muôn màu cho du học sinh mới nhập học.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [楼梯] (lóutī) - cầu thang bộ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '楼梯',
    'lóutī',
    'cầu thang bộ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '电梯坏了，我们只能走楼梯上去。',
    'Diàntī huài le, wǒmen zhǐ néng zǒu lóutī shàngqù.',
    'Thang máy hỏng rồi, chúng ta chỉ đành đi thang bộ lên thôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '电梯坏了，我们只能走楼梯上去。', 'Diàntī huài le, wǒmen zhǐ néng zǒu lóutī shàngqù.', 'Thang máy hỏng rồi, chúng ta chỉ đành đi thang bộ lên thôi.', 'basic', 1),
      (v_id, '平时多走楼梯少坐电梯，对身体很有好处。', 'Píngshí duō zǒu lóutī shǎo zuò diàntī, duì shēntǐ hěn yǒu hǎochu.', 'Ngày thường đi thang bộ nhiều hơn và ít đi thang máy rất có lợi cho sức khỏe.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [路边] (lùbiān) - ven đường, lề đường [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '路边',
    'lùbiān',
    'ven đường, lề đường',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他的自行车停在路边。',
    'Tā de zìxíngchē tíng zài lùbiān.',
    'Xe đạp của anh ấy dựng ở lề đường.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他的自行车停在路边。', 'Tā de zìxíngchē tíng zài lùbiān.', 'Xe đạp của anh ấy dựng ở lề đường.', 'basic', 1),
      (v_id, '路边种满了整齐的柳树，给行人带来了绿荫。', 'Lùbiān zhòng mǎn le zhěngqí de liǔshù, gěi xíngrén dài lái le lǜyīn.', 'Ven đường trồng đầy những hàng liễu ngay ngắn mang lại bóng mát cho người đi bộ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [路口] (lùkǒu) - ngã rẽ, giao lộ, đầu đường [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '路口',
    'lùkǒu',
    'ngã rẽ, giao lộ, đầu đường',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '前面那个路口往右拐就到了。',
    'Qiánmiàn nà ge lùkǒu wǎng yòu guǎi jiù dào le.',
    'Ngã rẽ phía trước rẽ phải là tới nơi rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '前面那个路口往右拐就到了。', 'Qiánmiàn nà ge lùkǒu wǎng yòu guǎi jiù dào le.', 'Ngã rẽ phía trước rẽ phải là tới nơi rồi.', 'basic', 1),
      (v_id, '上下班高峰期，这个十字路口的车辆非常多。', 'Shàngxiàbān gāofēng qī, zhè ge shízì lùkǒu de chēliàng fēicháng duō.', 'Vào giờ cao điểm đi làm và tan tầm, xe cộ ở ngã tư này rất đông.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [马路] (mǎlù) - đường lớn, đường cái, đường phố [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '马路',
    'mǎlù',
    'đường lớn, đường cái, đường phố',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '过马路一定要走斑马线。',
    'Guò mǎlù yídìng yào zǒu bānmǎxiàn.',
    'Qua đường nhất định phải đi trên vạch kẻ đường dành cho người đi bộ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '过马路一定要走斑马线。', 'Guò mǎlù yídìng yào zǒu bānmǎxiàn.', 'Qua đường nhất định phải đi trên vạch kẻ đường dành cho người đi bộ.', 'basic', 1),
      (v_id, '清晨的马路上车流稀少，空气非常清新。', 'Qīngchén de mǎlù shang chēliú xīshǎo, kōngqì fēicháng qīngxīn.', 'Đường phố lúc sáng sớm xe cộ thưa thớt, không khí rất trong lành.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [毛] (máo) - hào (0.1 tệ); lông, tóc [Lượng từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '毛',
    'máo',
    'hào (0.1 tệ); lông, tóc',
    'Lượng từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这瓶水两块五毛钱。',
    'Zhè píng shuǐ liǎng kuài wǔ máo qián.',
    'Chai nước này hai tệ năm hào.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这瓶水两块五毛钱。', 'Zhè píng shuǐ liǎng kuài wǔ máo qián.', 'Chai nước này hai tệ năm hào.', 'basic', 1),
      (v_id, '小猫身上的白毛摸起来特别柔软顺滑。', 'Xiǎomāo shēnshang de bái máo mō qǐlái tèbié róuruǎn shùnhuá.', 'Lớp lông trắng trên mình chú mèo con sờ vào đặc biệt mềm mượt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [面前] (miànqián) - trước mặt [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '面前',
    'miànqián',
    'trước mặt',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '桌子摆在我的面前。',
    'Zhuōzi bǎi zài wǒ de miànqián.',
    'Cái bàn được đặt ở ngay trước mặt tôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '桌子摆在我的面前。', 'Zhuōzi bǎi zài wǒ de miànqián.', 'Cái bàn được đặt ở ngay trước mặt tôi.', 'basic', 1),
      (v_id, '在困难面前，我们绝不能轻易放弃努力。', 'Zài kùnnan miànqián, wǒmen jué bù néng qīngyì fàngqì nǔlì.', 'Trước khó khăn thử thách, chúng ta tuyệt đối không thể dễ dàng bỏ cuộc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [名单] (míngdān) - danh sách (tên người) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '名单',
    'míngdān',
    'danh sách (tên người)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请在考试合格的名单上找你的名字。',
    'Qǐng zài kǎoshì hégé de míngdān shang zhǎo nǐ de míngzi.',
    'Xin hãy tìm tên của bạn trên danh sách thi đỗ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请在考试合格的名单上找你的名字。', 'Qǐng zài kǎoshì hégé de míngdān shang zhǎo nǐ de míngzi.', 'Xin hãy tìm tên của bạn trên danh sách thi đỗ.', 'basic', 1),
      (v_id, '老师手里拿着参加汉语比赛的选拔名单。', 'Lǎoshī shǒulǐ ná zhe cānjiā Hànyǔ bǐsài de xuǎnbá míngdān.', 'Thầy giáo cầm trong tay danh sách tuyển chọn tham dự cuộc thi tiếng Trung.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [名人] (míngrén) - người nổi tiếng, danh nhân [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '名人',
    'míngrén',
    'người nổi tiếng, danh nhân',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '图书馆里有许多历史名人的传记。',
    'Túshūguǎn lǐ yǒu xǔduō lìshǐ míngrén de zhuànjì.',
    'Trong thư viện có nhiều cuốn tiểu sử của các danh nhân lịch sử.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '图书馆里有许多历史名人的传记。', 'Túshūguǎn lǐ yǒu xǔduō lìshǐ míngrén de zhuànjì.', 'Trong thư viện có nhiều cuốn tiểu sử của các danh nhân lịch sử.', 'basic', 1),
      (v_id, '作为社会名人，应该在公众面前起到良好的榜样作用。', 'Zuòwéi shèhuì míngrén, yīnggāi zài gōngzhòng miànqián qǐdào liánghǎo de bǎngyàng zuòyòng.', 'Là một người nổi tiếng trong xã hội, nên đóng vai trò tấm gương tốt trước công chúng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [南方] (nánfāng) - phương nam, miền nam [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '南方',
    'nánfāng',
    'phương nam, miền nam',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '中国南方的冬天通常比北方温暖。',
    'Zhōngguó nánfāng de dōngtiān tōngcháng bǐ běifāng wēnnuǎn.',
    'Mùa đông ở miền nam Trung Quốc thông thường ấm áp hơn miền bắc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '中国南方的冬天通常比北方温暖。', 'Zhōngguó nánfāng de dōngtiān tōngcháng bǐ běifāng wēnnuǎn.', 'Mùa đông ở miền nam Trung Quốc thông thường ấm áp hơn miền bắc.', 'basic', 1),
      (v_id, '许多南方城市河道纵横，水乡风光十分迷人。', 'Xǔduō nánfāng chéngshì hédào zònghéng, shuǐxiāng fēngguāng shífēn mírén.', 'Nhiều thành phố phương nam sông ngòi chằng chịt, cảnh sắc miền sông nước vô cùng say đắm lòng người.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [难看] (nánkàn) - xấu xí, khó coi [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '难看',
    'nánkàn',
    'xấu xí, khó coi',
    'Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这件衣服的颜色搭配有点儿难看。',
    'Zhè jiàn yīfu de yánsè dāpèi yǒudiǎnr nánkàn.',
    'Cách phối màu của bộ quần áo này có phần hơi khó coi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这件衣服的颜色搭配有点儿难看。', 'Zhè jiàn yīfu de yánsè dāpèi yǒudiǎnr nánkàn.', 'Cách phối màu của bộ quần áo này có phần hơi khó coi.', 'basic', 1),
      (v_id, '听到被批评后，他的脸色变得很难看。', 'Tīng dào bèi pīpíng hòu, tā de liǎnsè biàn de hěn nánkàn.', 'Sau khi nghe lời phê bình, sắc mặt anh ấy trở nên rất khó coi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [男人] (nánrén) - đàn ông, nam giới [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '男人',
    'nánrén',
    'đàn ông, nam giới',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '那位高个子的男人是我们的新老师。',
    'Nà wèi gāogèzi de nánrén shì wǒmen de xīn lǎoshī.',
    'Người đàn ông dáng cao ráo đó là thầy giáo mới của chúng tôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '那位高个子的男人是我们的新老师。', 'Nà wèi gāogèzi de nánrén shì wǒmen de xīn lǎoshī.', 'Người đàn ông dáng cao ráo đó là thầy giáo mới của chúng tôi.', 'basic', 1),
      (v_id, '一个成熟的男人应当对家庭和事业勇于承担责任。', 'Yí gè chéngshú de nánrén yīngdāng duì jiātíng hé shìyè yǒngyú chéngdān zérèn.', 'Một người đàn ông trưởng thành cần dũng cảm gánh vác trách nhiệm với gia đình và sự nghiệp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [男生] (nánshēng) - nam sinh, bạn nam [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '男生',
    'nánshēng',
    'nam sinh, bạn nam',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们班有十五个男生和十五个女生。',
    'Wǒmen bān yǒu shíwǔ gè nánshēng hé shíwǔ gè nǚshēng.',
    'Lớp chúng tôi có mười lăm bạn nam và mười lăm bạn nữ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们班有十五个男生和十五个女生。', 'Wǒmen bān yǒu shíwǔ gè nánshēng hé shíwǔ gè nǚshēng.', 'Lớp chúng tôi có mười lăm bạn nam và mười lăm bạn nữ.', 'basic', 1),
      (v_id, '放学后操场上有许多男生在热火朝天地打篮球。', 'Fàngxué hòu cāochǎng shang yǒu xǔduō nánshēng zài rèhuǒcháotiān de dǎ lánqiú.', 'Sau giờ tan học trên sân thể thao có rất nhiều bạn nam đang sôi nổi chơi bóng rổ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [难题] (nántí) - bài toán khó, vấn đề hóc búa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '难题',
    'nántí',
    'bài toán khó, vấn đề hóc búa',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这道数学题真是一个难题。',
    'Zhè dào shùxué tí zhēn shì yí gè nántí.',
    'Câu toán này quả thực là một bài toán khó.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这道数学题真是一个难题。', 'Zhè dào shùxué tí zhēn shì yí gè nántí.', 'Câu toán này quả thực là một bài toán khó.', 'basic', 1),
      (v_id, '经过全组同学反复讨论，终于攻克了这项技术难题。', 'Jīngguò quán zǔ tóngxué fǎnfù tǎolùn, zhōngyú gōngkè le zhè xiàng jìshù nántí.', 'Qua nhiều lần thảo luận của cả nhóm, cuối cùng đã khắc phục được nan đề kỹ thuật này.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [难听] (nántīng) - khó nghe, chói tai [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '难听',
    'nántīng',
    'khó nghe, chói tai',
    'Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这首歌唱得有点儿难听。',
    'Zhè shǒu gē chàng de yǒudiǎnr nántīng.',
    'Bài hát này hát nghe có phần hơi dở.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这首歌唱得有点儿难听。', 'Zhè shǒu gē chàng de yǒudiǎnr nántīng.', 'Bài hát này hát nghe có phần hơi dở.', 'basic', 1),
      (v_id, '不管遇到什么矛盾，都不能在公共场合说难听的话。', 'Bùguǎn yù dào shénme máodùn, dōu bù néng zài gōnggòng chǎnghé shuō nántīng de huà.', 'Cho dù gặp phải mâu thuẫn gì, cũng không được nói những lời khó nghe ở chốn đông người.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [牛] (niú) - bò, trâu; cừ khôi, giỏi giang [Danh từ / Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '牛',
    'niú',
    'bò, trâu; cừ khôi, giỏi giang',
    'Danh từ / Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '草地上有一群牛在悠闲地吃草。',
    'Cǎodì shang yǒu yì qún niú zài yōuxián de chī cǎo.',
    'Trên đồng cỏ có một đàn bò đang ung dung gặm cỏ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '草地上有一群牛在悠闲地吃草。', 'Cǎodì shang yǒu yì qún niú zài yōuxián de chī cǎo.', 'Trên đồng cỏ có một đàn bò đang ung dung gặm cỏ.', 'basic', 1),
      (v_id, '他在这次比赛中拿下了第一名，真牛！', 'Tā zài zhè cì bǐsài zhōng ná xià le dì-yī míng, zhēn niú!', 'Anh ấy giành giải nhất trong cuộc thi lần này, cừ khôi thật!', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [女人] (nǚrén) - phụ nữ, phái nữ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '女人',
    'nǚrén',
    'phụ nữ, phái nữ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '现代社会中女人在各行各业都发挥着重要作用。',
    'Xiàndài shèhuì zhōng nǚrén zài gèhánggèyè dōu fāhuī zhe zhòngyào zuòyòng.',
    'Trong xã hội hiện đại phụ nữ ở mọi ngành nghề đều phát huy vai trò quan trọng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '现代社会中女人在各行各业都发挥着重要作用。', 'Xiàndài shèhuì zhōng nǚrén zài gèhánggèyè dōu fāhuī zhe zhòngyào zuòyòng.', 'Trong xã hội hiện đại phụ nữ ở mọi ngành nghề đều phát huy vai trò quan trọng.', 'basic', 1),
      (v_id, '她是一位独立自信、深受大家尊重的职业女人。', 'Tā shì yí wèi dúlì zìxìn, shēn shòu dàjiā zūnzhòng de zhíyè nǚrén.', 'Cô ấy là một người phụ nữ nghề nghiệp độc lập, tự tin và được mọi người tôn trọng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [女生] (nǚshēng) - nữ sinh, bạn nữ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '女生',
    'nǚshēng',
    'nữ sinh, bạn nữ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '坐第一排的那位女生普通话说得非常标准。',
    'Zuò dì-yī pái de nà wèi nǚshēng pǔtōnghuà shuō de fēicháng biāozhǔn.',
    'Bạn nữ ngồi hàng đầu tiên nói tiếng Phổ thông rất chuẩn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '坐第一排的那位女生普通话说得非常标准。', 'Zuò dì-yī pái de nà wèi nǚshēng pǔtōnghuà shuō de fēicháng biāozhǔn.', 'Bạn nữ ngồi hàng đầu tiên nói tiếng Phổ thông rất chuẩn.', 'basic', 1),
      (v_id, '学校合唱团里有一大半都是声音优美的女生。', 'Xuéxiào héchàngtuán lǐ yǒu yí dàbàn dōu shì shēngyīn yōuměi de nǚshēng.', 'Trong dàn hợp xướng của trường quá nửa đều là các bạn nữ có giọng hát truyền cảm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [爬] (pá) - bò, leo, trèo [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '爬',
    'pá',
    'bò, leo, trèo',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '周末天气好，我们一起去爬山吧。',
    'Zhōumò tiānqì hǎo, wǒmen yìqǐ qù pá shān ba.',
    'Cuối tuần trời đẹp, chúng mình cùng đi leo núi nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '周末天气好，我们一起去爬山吧。', 'Zhōumò tiānqì hǎo, wǒmen yìqǐ qù pá shān ba.', 'Cuối tuần trời đẹp, chúng mình cùng đi leo núi nhé.', 'basic', 1),
      (v_id, '小宝宝才八个月大，已经在地上爬得很灵活了。', 'Xiǎo bǎobao cái bā gè yuè dà, yǐjīng zài dì shang pá de hěn línghuó le.', 'Em bé mới tám tháng tuổi mà đã bò trên sàn rất thoăn thoắt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [怕] (pà) - sợ, sợ hãi, e rằng [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '怕',
    'pà',
    'sợ, sợ hãi, e rằng',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '小妹妹很怕黑，晚上不敢一个人睡。',
    'Xiǎo mèimei hěn pà hēi, wǎnshang bù gǎn yí gè rén shuì.',
    'Em gái nhỏ rất sợ bóng tối, buổi tối không dám ngủ một mình.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '小妹妹很怕黑，晚上不敢一个人睡。', 'Xiǎo mèimei hěn pà hēi, wǎnshang bù gǎn yí gè rén shuì.', 'Em gái nhỏ rất sợ bóng tối, buổi tối không dám ngủ một mình.', 'basic', 1),
      (v_id, '我怕今天堵车会耽误飞机，所以提前两个小时出发了。', 'Wǒ pà jīntiān dǔchē huì dānwù fēijī, suǒyǐ tíqián liǎng gè xiǎoshí chūfā le.', 'Tôi sợ hôm nay tắc đường sẽ trễ máy bay, nên đã khởi hành trước hai tiếng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [拍照] (pāizhào) - chụp ảnh [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '拍照',
    'pāizhào',
    'chụp ảnh',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这里的风景真美，我们拍照留念吧。',
    'Zhèlǐ de fēngjǐng zhēn měi, wǒmen pāizhào liúniàn ba.',
    'Phong cảnh nơi này đẹp quá, chúng ta chụp ảnh làm kỷ niệm đi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这里的风景真美，我们拍照留念吧。', 'Zhèlǐ de fēngjǐng zhēn měi, wǒmen pāizhào liúniàn ba.', 'Phong cảnh nơi này đẹp quá, chúng ta chụp ảnh làm kỷ niệm đi.', 'basic', 1),
      (v_id, '在博物馆展厅内参观时，请不要使用闪光灯拍照。', 'Zài bówùguǎn zhǎntīng nèi cānguān shí, qǐng bú yào shǐyòng shǎnguāngdēng pāizhào.', 'Khi tham quan trong phòng trưng bày bảo tàng, xin đừng dùng đèn flash chụp ảnh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [平时] (píngshí) - bình thường, ngày thường [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '平时',
    'píngshí',
    'bình thường, ngày thường',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我平时喜欢在家里听音乐看书。',
    'Wǒ píngshí xǐhuan zài jiālǐ tīng yīnyuè kàn shū.',
    'Ngày thường tôi thích ở nhà nghe nhạc đọc sách.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我平时喜欢在家里听音乐看书。', 'Wǒ píngshí xǐhuan zài jiālǐ tīng yīnyuè kàn shū.', 'Ngày thường tôi thích ở nhà nghe nhạc đọc sách.', 'basic', 1),
      (v_id, '平时养成良好的学习习惯，考试时就不会手忙脚乱。', 'Píngshí yǎngchéng liánghǎo de xuéxí xíguàn, kǎoshì shí jiù bú huì shǒumángjiǎoluàn.', 'Bình thường rèn thói quen học tập tốt thì khi thi cử sẽ không bị rối loạn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [起] (qǐ) - dậy, nổi lên, bắt đầu; vụ việc [Động từ / Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '起',
    'qǐ',
    'dậy, nổi lên, bắt đầu; vụ việc',
    'Động từ / Lượng từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他每天早上六点按时起床。',
    'Tā měitiān zǎoshang liù diǎn ànshí qǐchuáng.',
    'Anh ấy mỗi sáng đúng sáu giờ thức dậy.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他每天早上六点按时起床。', 'Tā měitiān zǎoshang liù diǎn ànshí qǐchuáng.', 'Anh ấy mỗi sáng đúng sáu giờ thức dậy.', 'basic', 1),
      (v_id, '从今天起，我们要严格按照新的规章制度执行。', 'Cóng jīntiān qǐ, wǒmen yào yángé ànzhào xīn de guīzhāng zhìdù zhíxíng.', 'Kể từ hôm nay trở đi, chúng ta phải nghiêm túc thực hiện theo nội quy quy chế mới.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [汽车] (qìchē) - xe hơi, xe ô tô [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '汽车',
    'qìchē',
    'xe hơi, xe ô tô',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '爸爸买了一辆白色的小汽车。',
    'Bàba mǎi le yí liàng báisè de xiǎo qìchē.',
    'Bố đã mua một chiếc xe ô tô con màu trắng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '爸爸买了一辆白色的小汽车。', 'Bàba mǎi le yí liàng báisè de xiǎo qìchē.', 'Bố đã mua một chiếc xe ô tô con màu trắng.', 'basic', 1),
      (v_id, '新能源汽车越来越受到环保出行人士的青睐。', 'Xīnnéngyuán qìchē yuèláiyuè shòudào huánbǎo chūxíng rénshì de qīnglài.', 'Xe hơi năng lượng mới ngày càng được những người thích di chuyển xanh ưa chuộng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [前年] (qiánnián) - năm kia (hai năm trước) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '前年',
    'qiánnián',
    'năm kia (hai năm trước)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我是前年来到中国留学的。',
    'Wǒ shì qiánnián lái dào Zhōngguó liúxué de.',
    'Tôi đến Trung Quốc du học từ năm kia.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我是前年来到中国留学的。', 'Wǒ shì qiánnián lái dào Zhōngguó liúxué de.', 'Tôi đến Trung Quốc du học từ năm kia.', 'basic', 1),
      (v_id, '前年我们种下的苹果小树，今年已经开始结果了。', 'Qiánnián wǒmen zhòng xià de píngguǒ xiǎoshù, jīntián yǐjīng kāishǐ jiēguǒ le.', 'Cây táo nhỏ chúng tôi trồng từ năm kia, năm nay đã bắt đầu ra quả rồi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [前天] (qiántiān) - hôm kia (hai ngày trước) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '前天',
    'qiántiān',
    'hôm kia (hai ngày trước)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我前天在书店买了两本汉语书。',
    'Wǒ qiántiān zài shūdiàn mǎi le liǎng běn Hànyǔ shū.',
    'Hôm kia tôi đã mua hai cuốn sách tiếng Trung ở hiệu sách.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我前天在书店买了两本汉语书。', 'Wǒ qiántiān zài shūdiàn mǎi le liǎng běn Hànyǔ shū.', 'Hôm kia tôi đã mua hai cuốn sách tiếng Trung ở hiệu sách.', 'basic', 1),
      (v_id, '前天天气突然变冷，许多同学都不小心感冒了。', 'Qiántiān tiānqì tūrán biàn lěng, xǔduō tóngxué dōu bù xiǎoxīn gǎnmào le.', 'Hôm kia thời tiết đột ngột trở lạnh, nhiều bạn học đều sơ ý bị cảm cúm.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [请客] (qǐngkè) - khao, thết đãi, mời cơm [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '请客',
    'qǐngkè',
    'khao, thết đãi, mời cơm',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天我过生日，晚上我请客吃烤鸭。',
    'Jīntiān wǒ guò shēngrì, wǎnshang wǒ qǐngkè chī kǎoyā.',
    'Hôm nay sinh nhật tôi, tối nay tôi khao ăn vịt quay.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天我过生日，晚上我请客吃烤鸭。', 'Jīntiān wǒ guò shēngrì, wǎnshang wǒ qǐngkè chī kǎoyā.', 'Hôm nay sinh nhật tôi, tối nay tôi khao ăn vịt quay.', 'basic', 1),
      (v_id, '为了庆祝顺利通过考试，他特地请大家去最好的餐厅吃饭。', 'Wèile qìngzhù shùnlì tōngguò kǎoshì, tā tèdì qǐngkè qù zuì hǎo de cāntīng chīfàn.', 'Để ăn mừng thuận lợi vượt qua kỳ thi, cậu ấy đặc biệt mời mọi người đến nhà hàng tốt nhất dùng bữa.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [秋天] (qiūtiān) - mùa thu [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '秋天',
    'qiūtiān',
    'mùa thu',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '北京的秋天天气非常凉爽宜人。',
    'Běijīng de qiūtiān tiānqì fēicháng liángshuǎng yírén.',
    'Mùa thu ở Bắc Kinh thời tiết vô cùng mát mẻ dễ chịu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '北京的秋天天气非常凉爽宜人。', 'Běijīng de qiūtiān tiānqì fēicháng liángshuǎng yírén.', 'Mùa thu ở Bắc Kinh thời tiết vô cùng mát mẻ dễ chịu.', 'basic', 1),
      (v_id, '秋天不仅是收获的季节，更是树叶色彩最绚丽的时刻。', 'Qiūtiān bùjǐn shì shōuhuò de jìjié, gèng shì shùyè sècǎi zuì xuànlì de shíkè.', 'Mùa thu không chỉ là mùa gặt hái mà còn là lúc sắc lá cây rực rỡ nhất.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [球场] (qiúchǎng) - sân bóng, sân thi đấu [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '球场',
    'qiúchǎng',
    'sân bóng, sân thi đấu',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '很多学生正在篮球场上打比赛。',
    'Hěn duō xuésheng zhèngzài lánqiúchǎng shang dǎ bǐsài.',
    'Nhiều học sinh đang thi đấu trên sân bóng rổ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '很多学生正在篮球场上打比赛。', 'Hěn duō xuésheng zhèngzài lánqiúchǎng shang dǎ bǐsài.', 'Nhiều học sinh đang thi đấu trên sân bóng rổ.', 'basic', 1),
      (v_id, '学校新建的足球场铺上了柔软的人造草坪。', 'Xuéxiào xīn jiàn de zúqiúchǎng pū shang le róuruǎn de rénzào cǎopíng.', 'Sân bóng đá mới xây của trường được trải thảm cỏ nhân tạo êm ái.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [认得] (rènde) - nhận ra, nhận biết [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '认得',
    'rènde',
    'nhận ra, nhận biết',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '你还认得我吗？我们是初中同学。',
    'Nǐ hái rènde wǒ ma? Wǒmen shì chūzhōng tóngxué.',
    'Bạn còn nhận ra tôi không? Chúng ta là bạn học cấp hai đấy.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你还认得我吗？我们是初中同学。', 'Nǐ hái rènde wǒ ma? Wǒmen shì chūzhōng tóngxué.', 'Bạn còn nhận ra tôi không? Chúng ta là bạn học cấp hai đấy.', 'basic', 1),
      (v_id, '虽然他戴着帽子和口罩，但我还是一眼就认得他。', 'Suīrán tā dài zhe màozi hé kǒuzhào, dàn wǒ háishì yì yǎn jiù rènde tā.', 'Tuy anh ấy đội mũ và đeo khẩu trang, nhưng tôi vẫn nhận ra anh ấy ngay từ cái nhìn đầu tiên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [扫] (sǎo) - quét (nhà/rác), quét mã [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '扫',
    'sǎo',
    'quét (nhà/rác), quét mã',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '放学后请同学们把教室扫干净。',
    'Fàngxué hòu qǐng tóngxuémen bǎ jiàoshì sǎo gānjìng.',
    'Sau giờ tan học xin mời các bạn học quét dọn phòng học sạch sẽ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '放学后请同学们把教室扫干净。', 'Fàngxué hòu qǐng tóngxuémen bǎ jiàoshì sǎo gānjìng.', 'Sau giờ tan học xin mời các bạn học quét dọn phòng học sạch sẽ.', 'basic', 1),
      (v_id, '买完东西后，你可以用手机扫一下收款二维码付款。', 'Mǎi wán dōngxi hòu, nǐ kěyǐ yòng shǒujī sǎo yíxià shōukuǎn èrwéimǎ fùkuǎn.', 'Mua đồ xong, bạn có thể dùng điện thoại quét mã QR nhận tiền để thanh toán.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [沙发] (shāfā) - ghế sô pha [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '沙发',
    'shāfā',
    'ghế sô pha',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '客厅里放着一张舒适的皮沙发。',
    'Kètīng lǐ fàng zhe yì zhāng shūshì de pí shāfā.',
    'Trong phòng khách đặt một chiếc ghế sô-pha da êm ái.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '客厅里放着一张舒适的皮沙发。', 'Kètīng lǐ fàng zhe yì zhāng shūshì de pí shāfā.', 'Trong phòng khách đặt một chiếc ghế sô-pha da êm ái.', 'basic', 1),
      (v_id, '下班回家后，他喜欢坐在沙发上看会儿电视放松一下。', 'Xiàbān huí jiā hòu, tā xǐhuan zuò zài shāfā shang kàn huìr diànshì fàngsōng yíxià.', 'Sau khi tan sở về nhà, anh ấy thích ngồi trên ghế sô pha xem ti vi một lúc để thư giãn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [山] (shān) - núi, ngọn núi [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '山',
    'shān',
    'núi, ngọn núi',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这座山上海拔很高，空气格外清凉。',
    'Zhè zuò shān shang hǎibá hěn gāo, kōngqì géwài qīngliáng.',
    'Ngọn núi này độ cao so với mặt biển rất lớn, không khí vô cùng mát mẻ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这座山上海拔很高，空气格外清凉。', 'Zhè zuò shān shang hǎibá hěn gāo, kōngqì géwài qīngliáng.', 'Ngọn núi này độ cao so với mặt biển rất lớn, không khí vô cùng mát mẻ.', 'basic', 1),
      (v_id, '站在山顶俯瞰，整座城市的美景尽收眼底。', 'Zhàn zài shāndǐng fǔkàn, zhěng zuò chéngshì de měijǐng jìn shōu yǎndǐ.', 'Đứng trên đỉnh núi nhìn xuống, toàn bộ cảnh đẹp của thành phố thu trọn vào tầm mắt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [上衣] (shàngyī) - áo trên, áo khoác ngoài [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '上衣',
    'shàngyī',
    'áo trên, áo khoác ngoài',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这件蓝色上衣很适合你。',
    'Zhè jiàn lánsè shàngyī hěn shìhé nǐ.',
    'Chiếc áo màu xanh lam này rất hợp với bạn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这件蓝色上衣很适合你。', 'Zhè jiàn lánsè shàngyī hěn shìhé nǐ.', 'Chiếc áo màu xanh lam này rất hợp với bạn.', 'basic', 1),
      (v_id, '今天天气转凉，出门前请穿上一件厚一点儿的上衣。', 'Jīntiān tiānqì zhuǎn liáng, chūmén qián qǐng chuān shang yí jiàn hòu yìdiǎnr de shàngyī.', 'Hôm nay thời tiết trở lạnh, trước khi ra ngoài hãy mặc thêm một chiếc áo khoác dày dặn hơn chút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [勺子] (sháozi) - cái thìa, muỗng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '勺子',
    'sháozi',
    'cái thìa, muỗng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '服务员，请再给我拿一把勺子。',
    'Fúwùyuán, qǐng zài gěi wǒ ná yì bǎ sháozi.',
    'Phục vụ ơi, làm ơn lấy cho tôi thêm một chiếc thìa.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '服务员，请再给我拿一把勺子。', 'Fúwùyuán, qǐng zài gěi wǒ ná yì bǎ sháozi.', 'Phục vụ ơi, làm ơn lấy cho tôi thêm một chiếc thìa.', 'basic', 1),
      (v_id, '喝汤的时候用勺子比较方便，不容易洒出来。', 'Hē tāng de shíhou yòng sháozi bǐjiào fāngbiàn, bù róngyì sǎ chūlái.', 'Khi húp canh dùng thìa khá thuận tiện, không dễ bị đổ ra ngoài.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [身边] (shēnbiān) - bên cạnh, quanh mình [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '身边',
    'shēnbiān',
    'bên cạnh, quanh mình',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '有朋友陪伴在身边，心里感到很踏实。',
    'Yǒu péngyou péibàn zài shēnbiān, xīnlǐ gǎndào hěn tàshi.',
    'Có bạn bè đồng hành ở bên cạnh, trong lòng cảm thấy rất yên tâm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '有朋友陪伴在身边，心里感到很踏实。', 'Yǒu péngyou péibàn zài shēnbiān, xīnlǐ gǎndào hěn tàshi.', 'Có bạn bè đồng hành ở bên cạnh, trong lòng cảm thấy rất yên tâm.', 'basic', 1),
      (v_id, '出门在外，要时刻看管好身边的贵重物品。', 'Chūmén zài wài, yào shíkè kānguǎn hǎo shēnbiān de guìzhòng wùpǐn.', 'Khi ra ngoài, phải luôn trông coi cẩn thận đồ dùng quý giá bên mình.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [身高] (shēngāo) - chiều cao (cơ thể) [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '身高',
    'shēngāo',
    'chiều cao (cơ thể)',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他的身高已经超过一米八了。',
    'Tā de shēngāo yǐjīng chāoguò yì mǐ bā le.',
    'Chiều cao của anh ấy đã vượt quá một mét tám rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他的身高已经超过一米八了。', 'Tā de shēngāo yǐjīng chāoguò yì mǐ bā le.', 'Chiều cao của anh ấy đã vượt quá một mét tám rồi.', 'basic', 1),
      (v_id, '健康体检表格上需要填写本人的身高和体重。', 'Jiànkāng tǐjiǎn biǎogé shang xūyào tiánxiě běnrén de shēngāo hé tǐzhòng.', 'Trên phiếu khám sức khỏe cần điền chiều cao và cân nặng của bản thân.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [声] (shēng) - tiếng, âm thanh (lượng từ tiếng nói/kêu) [Danh từ / Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '声',
    'shēng',
    'tiếng, âm thanh (lượng từ tiếng nói/kêu)',
    'Danh từ / Lượng từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我大声喊了他一声，他才转过头来。',
    'Wǒ dàshēng hǎn le tā yì shēng, tā cái zhuǎn guò tóu lái.',
    'Tôi gọi to anh ấy một tiếng thì anh ấy mới quay đầu lại.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我大声喊了他一声，他才转过头来。', 'Wǒ dàshēng hǎn le tā yì shēng, tā cái zhuǎn guò tóu lái.', 'Tôi gọi to anh ấy một tiếng thì anh ấy mới quay đầu lại.', 'basic', 1),
      (v_id, '夜深了，四周静得连一丝声音都听不到。', 'Yè shēn le, sìzhōu jìng de lián yì sī shēngyīn dōu tīng búdào.', 'Đêm đã khuya, bốn bề yên tĩnh đến mức một chút âm thanh cũng không nghe thấy.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [生活] (shēnghuó) - cuộc sống, sinh hoạt, sống [Danh từ / Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '生活',
    'shēnghuó',
    'cuộc sống, sinh hoạt, sống',
    'Danh từ / Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '你习惯这里的留学生活了吗？',
    'Nǐ xíguàn zhèlǐ de liúxué shēnghuó le ma?',
    'Bạn đã quen với cuộc sống du học ở đây chưa?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你习惯这里的留学生活了吗？', 'Nǐ xíguàn zhèlǐ de liúxué shēnghuó le ma?', 'Bạn đã quen với cuộc sống du học ở đây chưa?', 'basic', 1),
      (v_id, '只要积极乐观面对每一天，生活就会充满阳光。', 'Zhǐyào jījí lèguān miànduì měi yì tiān, shēnghuó jiù huì chōngmǎn yángguāng.', 'Chỉ cần tích cực lạc quan đối diện mỗi ngày, cuộc sống sẽ ngập tràn ánh nắng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [市] (shì) - thành phố, thị xã, chợ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '市',
    'shì',
    'thành phố, thị xã, chợ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '上海是中国最大的经济中心市之一。',
    'Shànghǎi shì Zhōngguó zuì dà de jīngjì zhōngxīn shì zhīyī.',
    'Thượng Hải là một trong những thành phố trung tâm kinh tế lớn nhất Trung Quốc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '上海是中国最大的经济中心市之一。', 'Shànghǎi shì Zhōngguó zuì dà de jīngjì zhōngxīn shì zhīyī.', 'Thượng Hải là một trong những thành phố trung tâm kinh tế lớn nhất Trung Quốc.', 'basic', 1),
      (v_id, '市政府为了改善市民生活，修建了许多社区公园。', 'Shì zhèngfǔ wèile gǎishàn shìmín shēnghuó, xiūjiàn le xǔduō shèqū gōngyuán.', 'Chính quyền thành phố nhằm cải thiện đời sống nhân dân đã xây dựng nhiều công viên cộng đồng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [室] (shì) - phòng, buồng, gian [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '室',
    'shì',
    'phòng, buồng, gian',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '老师现在在办公室批改作业。',
    'Lǎoshī xiànzài zài bàngōngshì pīgǎi zuòyè.',
    'Thầy giáo hiện đang ở văn phòng chấm bài tập.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '老师现在在办公室批改作业。', 'Lǎoshī xiànzài zài bàngōngshì pīgǎi zuòyè.', 'Thầy giáo hiện đang ở văn phòng chấm bài tập.', 'basic', 1),
      (v_id, '请同学们在阅览室内保持安静，不要大声喧哗。', 'Qǐng tóngxuémen zài yuèlǎnshì nèi bǎochí ānjìng, bú yào dàshēng xuānhuá.', 'Xin các bạn học giữ yên lặng trong phòng đọc sách, không được làm ồn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [收] (shōu) - nhận, thu, thu dọn [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '收',
    'shōu',
    'nhận, thu, thu dọn',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他帮我收了一下快递包裹。',
    'Tā bāng wǒ shōu le yíxià kuàidì bāoguǒ.',
    'Anh ấy nhận giúp tôi gói hàng chuyển phát nhanh.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他帮我收了一下快递包裹。', 'Tā bāng wǒ shōu le yíxià kuàidì bāoguǒ.', 'Anh ấy nhận giúp tôi gói hàng chuyển phát nhanh.', 'basic', 1),
      (v_id, '下雨了，妈妈赶紧跑到阳台上收衣服。', 'Xiàyǔ le, māma gǎnjǐn pǎo dào yángtái shang shōu yīfu.', 'Trời mưa rồi, mẹ vội vàng chạy ra ban công thu quần áo.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [收到] (shōudào) - nhận được [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '收到',
    'shōudào',
    'nhận được',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我收到了朋友寄来的生日礼物。',
    'Wǒ shōudào le péngyou jì lái de shēngrì lǐwù.',
    'Tôi đã nhận được món quà sinh nhật bạn gửi tới.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我收到了朋友寄来的生日礼物。', 'Wǒ shōudào le péngyou jì lái de shēngrì lǐwù.', 'Tôi đã nhận được món quà sinh nhật bạn gửi tới.', 'basic', 1),
      (v_id, '如果您收到了这份电子邮件，请尽快回复确认。', 'Rúguǒ nín shōudào le zhè fèn diànzǐ yóujiàn, qǐng jǐnkuài huífù quèrèn.', 'Nếu quý khách nhận được email này, xin hãy hồi âm xác nhận sớm nhất.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [受] (shòu) - chịu, nhận, bị (ảnh hưởng/tác động) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '受',
    'shòu',
    'chịu, nhận, bị (ảnh hưởng/tác động)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他受了点儿轻伤，去医院包扎了一下。',
    'Tā shòu le diǎnr qīngshāng, qù yīyuàn bāozhā le yíxià.',
    'Anh ấy bị thương nhẹ một chút, đã đến bệnh viện băng bó.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他受了点儿轻伤，去医院包扎了一下。', 'Tā shòu le diǎnr qīngshāng, qù yīyuàn bāozhā le yíxià.', 'Anh ấy bị thương nhẹ một chút, đã đến bệnh viện băng bó.', 'basic', 1),
      (v_id, '这种新式的学习软件很受年轻学生的欢迎。', 'Zhè zhǒng xīnshì de xuéxí ruǎnjiàn hěn shòu niánqīng xuésheng de huānyíng.', 'Loại phần mềm học tập kiểu mới này rất được các bạn học sinh trẻ ưa chuộng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [受到] (shòudào) - nhận được (khen ngợi, tôn trọng, ảnh hưởng) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '受到',
    'shòudào',
    'nhận được (khen ngợi, tôn trọng, ảnh hưởng)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他的优异表现受到了大家的一致表扬。',
    'Tā de yōuyì biǎoxiàn shòudào le dàjiā de yízhì biǎoyáng.',
    'Biểu hiện xuất sắc của anh ấy nhận được sự khen ngợi nhất trí của mọi người.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他的优异表现受到了大家的一致表扬。', 'Tā de yōuyì biǎoxiàn shòudào le dàjiā de yízhì biǎoyáng.', 'Biểu hiện xuất sắc của anh ấy nhận được sự khen ngợi nhất trí của mọi người.', 'basic', 1),
      (v_id, '近期的航班受到了恶劣暴风雨天气的严重影响。', 'Jìnqī de hángbān shòudào le èliè bàofēngyǔ tiānqì de yánzhòng yǐngxiǎng.', 'Các chuyến bay gần đây chịu ảnh hưởng nghiêm trọng của thời tiết mưa bão khắc nghiệt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [刷] (shuā) - chải, quẹt (thẻ), quét (sơn) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '刷',
    'shuā',
    'chải, quẹt (thẻ), quét (sơn)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '每天早晚都要记得认真刷牙。',
    'Měitiān zǎowǎn dōu yào jìde rènzhēn shuāyá.',
    'Mỗi sáng tối đều phải nhớ đánh răng cẩn thận.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '每天早晚都要记得认真刷牙。', 'Měitiān zǎowǎn dōu yào jìde rènzhēn shuāyá.', 'Mỗi sáng tối đều phải nhớ đánh răng cẩn thận.', 'basic', 1),
      (v_id, '乘坐地铁时，拿出手机扫码或刷交通卡都可以进站。', 'Chéngzuò dìtiě shí, ná chū shǒujī sǎo mǎ huò shuā jiāotōng kǎ dōu kěyǐ jìn zhàn.', 'Khi đi tàu điện ngầm, lấy điện thoại quét mã hoặc quẹt thẻ giao thông đều có thể vào ga.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [四季] (sìjì) - bốn mùa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '四季',
    'sìjì',
    'bốn mùa',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '云南昆明气候温和，四季如春。',
    'Yúnnán Kūnmíng qìhòu wēnhé, sìjì rú chūn.',
    'Côn Minh - Vân Nam khí hậu ôn hòa, bốn mùa như xuân.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '云南昆明气候温和，四季如春。', 'Yúnnán Kūnmíng qìhòu wēnhé, sìjì rú chūn.', 'Côn Minh - Vân Nam khí hậu ôn hòa, bốn mùa như xuân.', 'basic', 1),
      (v_id, '经历过一年的四季更替，更加体会到大自然的神奇。', 'Jīnglì guò yì nián de sìjì gēngtì, gèngjiā tǐhuì dào dàzìrán de shénqí.', 'Trải qua sự luân chuyển bốn mùa trong năm, càng cảm nhận sâu sắc sự kỳ diệu của thiên nhiên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [糖] (táng) - đường, kẹo [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '糖',
    'táng',
    'đường, kẹo',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '喝咖啡的时候我喜欢少放一点儿糖。',
    'Hē kāfēi de shíhou wǒ xǐhuan shǎo fàng yìdiǎnr táng.',
    'Khi uống cà phê tôi thích bỏ bớt một chút đường.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '喝咖啡的时候我喜欢少放一点儿糖。', 'Hē kāfēi de shíhou wǒ xǐhuan shǎo fàng yìdiǎnr táng.', 'Khi uống cà phê tôi thích bỏ bớt một chút đường.', 'basic', 1),
      (v_id, '吃太多糖不仅容易长胖，还容易损害牙齿健康。', 'Chī tài duō táng bùjǐn róngyì zhǎng pàng, hái róngyì sǔnhài yáchǐ jiànkāng.', 'Ăn quá nhiều đường không chỉ dễ tăng cân mà còn dễ làm hại sức khỏe răng miệng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [体育馆] (tǐyùguǎn) - nhà thi đấu thể thao, cung thể thao [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '体育馆',
    'tǐyùguǎn',
    'nhà thi đấu thể thao, cung thể thao',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '学校的体育馆设施非常先进齐全。',
    'Xuéxiào de tǐyùguǎn shèshī fēicháng xiānjìn qíquán.',
    'Cơ sở vật chất của nhà thi đấu trường học rất tiên tiến và đầy đủ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '学校的体育馆设施非常先进齐全。', 'Xuéxiào de tǐyùguǎn shèshī fēicháng xiānjìn qíquán.', 'Cơ sở vật chất của nhà thi đấu trường học rất tiên tiến và đầy đủ.', 'basic', 1),
      (v_id, '今晚市体育馆有一场激烈的全国羽毛球比赛。', 'Jīnwǎn shì tǐyùguǎn yǒu yì chǎng jīliè de quánguó yǔmáoqiú bǐsài.', 'Tối nay tại nhà thi đấu thành phố có một trận đấu cầu lông toàn quốc kịch tính.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [跳] (tiào) - nhảy, đập (tim) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '跳',
    'tiào',
    'nhảy, đập (tim)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '孩子们在草地上开心地跳来跳去。',
    'Háizimen zài cǎodì shang kāixīn de tiào lái tiào qù.',
    'Các em nhỏ vui vẻ nhảy nhót đi lại trên bãi cỏ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '孩子们在草地上开心地跳来跳去。', 'Háizimen zài cǎodì shang kāixīn de tiào lái tiào qù.', 'Các em nhỏ vui vẻ nhảy nhót đi lại trên bãi cỏ.', 'basic', 1),
      (v_id, '跑完一千米后，我的心跳得非常厉害。', 'Pǎo wán yìqiān mǐ hòu, wǒ de xīn tiào de fēicháng lìhai.', 'Sau khi chạy xong một nghìn mét, tim tôi đập rất mạnh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [听说] (tīngshuō) - nghe nói [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '听说',
    'tīngshuō',
    'nghe nói',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我听说他下个月就要去中国工作了。',
    'Wǒ tīngshuō tā xià gè yuè jiù yào qù Zhōngguó gōngzuò le.',
    'Tôi nghe nói tháng sau anh ấy phải sang Trung Quốc làm việc rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我听说他下个月就要去中国工作了。', 'Wǒ tīngshuō tā xià gè yuè jiù yào qù Zhōngguó gōngzuò le.', 'Tôi nghe nói tháng sau anh ấy phải sang Trung Quốc làm việc rồi.', 'basic', 1),
      (v_id, '听说这家小餐馆的川菜味道做得特别正宗地道。', 'Tīngshuō zhè jiā xiǎo cānguǎn de Chuāncài wèidao zuò de tèbié zhèngzōng dìdao.', 'Nghe nói món Tứ Xuyên của quán ăn nhỏ này nấu có vị rất chuẩn mực truyền thống.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [挺] (tǐng) - rất, khá (thường đi với ...的) [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '挺',
    'tǐng',
    'rất, khá (thường đi với ...的)',
    'Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这家书店的环境挺安静的。',
    'Zhè jiā shūdiàn de huánjìng tǐng ānjìng de.',
    'Không gian của hiệu sách này khá là yên tĩnh.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这家书店的环境挺安静的。', 'Zhè jiā shūdiàn de huánjìng tǐng ānjìng de.', 'Không gian của hiệu sách này khá là yên tĩnh.', 'basic', 1),
      (v_id, '虽然工作挺累的，但是看到成果心里感到很充实。', 'Suīrán gōngzuò tǐng lèi de, dànshì kàndào chéngguǒ xīnlǐ gǎndào hěn chōngshí.', 'Tuy công việc khá mệt, nhưng nhìn thấy thành quả trong lòng cảm thấy rất viên mãn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [外地] (wàidì) - nơi khác, ngoại tỉnh [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '外地',
    'wàidì',
    'nơi khác, ngoại tỉnh',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他是从外地来北京上大学的。',
    'Tā shì cóng wàidì lái Běijīng shàng dàxué de.',
    'Anh ấy từ ngoại tỉnh đến Bắc Kinh học đại học.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他是从外地来北京上大学的。', 'Tā shì cóng wàidì lái Běijīng shàng dàxué de.', 'Anh ấy từ ngoại tỉnh đến Bắc Kinh học đại học.', 'basic', 1),
      (v_id, '每次去外地出差，他总会给家人带一些当地特产。', 'Měicì qù wàidì chūchāi, tā zǒng huì gěi jiārén dài yìxiē dāngdì tèchǎn.', 'Mỗi lần đi công tác nơi khác, anh ấy luôn mang về một ít đặc sản địa phương cho gia đình.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [外卖] (wàimài) - đồ ăn giao tận nơi, bán mang về [Danh từ / Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '外卖',
    'wàimài',
    'đồ ăn giao tận nơi, bán mang về',
    'Danh từ / Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天晚上不想做饭，我们点外卖吧。',
    'Jīntiān wǎnshang bù xiǎng zuòfàn, wǒmen diǎn wàimài ba.',
    'Tối nay không muốn nấu cơm, chúng ta gọi đồ ăn ngoài nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天晚上不想做饭，我们点外卖吧。', 'Jīntiān wǎnshang bù xiǎng zuòfàn, wǒmen diǎn wàimài ba.', 'Tối nay không muốn nấu cơm, chúng ta gọi đồ ăn ngoài nhé.', 'basic', 1),
      (v_id, '手机上的外卖软件非常方便，半小时左右就能送达。', 'Shǒujī shang de wàimài ruǎnjiàn fēicháng fāngbiàn, bàn xiǎoshí zuǒyòu jiù néng sòngdá.', 'Phần mềm đặt đồ ăn trên điện thoại rất tiện lợi, tầm nửa tiếng là có thể giao đến.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [外语] (wàiyǔ) - ngoại ngữ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '外语',
    'wàiyǔ',
    'ngoại ngữ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '除了英语，他还想再学一门外语。',
    'Chúle Yīngyǔ, tā hái xiǎng zài xué yì mén wàiyǔ.',
    'Ngoài tiếng Anh ra, anh ấy còn muốn học thêm một môn ngoại ngữ nữa.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '除了英语，他还想再学一门外语。', 'Chúle Yīngyǔ, tā hái xiǎng zài xué yì mén wàiyǔ.', 'Ngoài tiếng Anh ra, anh ấy còn muốn học thêm một môn ngoại ngữ nữa.', 'basic', 1),
      (v_id, '掌握一门外语能够为未来的跨国工作提供许多机会。', 'Zhǎngwò yì mén wàiyǔ nénggòu wèi wèilái de kuàguó gōngzuò tígōng xǔduō jīhuì.', 'Nắm vững một môn ngoại ngữ có thể cung cấp nhiều cơ hội cho công việc đa quốc gia trong tương lai.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [晚点] (wǎndiǎn) - chậm giờ, trễ giờ (tàu, máy bay) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '晚点',
    'wǎndiǎn',
    'chậm giờ, trễ giờ (tàu, máy bay)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '因为大雾天气，列车晚点了一个小时。',
    'Yīnwèi dàwù tiānqì, lièchē wǎndiǎn le yí gè xiǎoshí.',
    'Do thời tiết sương mù dày đặc, tàu hỏa đã chậm giờ một tiếng đồng hồ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '因为大雾天气，列车晚点了一个小时。', 'Yīnwèi dàwù tiānqì, lièchē wǎndiǎn le yí gè xiǎoshí.', 'Do thời tiết sương mù dày đặc, tàu hỏa đã chậm giờ một tiếng đồng hồ.', 'basic', 1),
      (v_id, '机场广播通知前往广州的航班由于机械检修将晚点起飞。', 'Jīchǎng guāngbō tōngzhī qiánwǎng Guǎngzhōu de hángbān yóuyú jīxiè jiǎnxiū jiāng wǎndiǎn qǐfēi.', 'Phát thanh sân bay thông báo chuyến bay đi Quảng Châu do kiểm tra máy móc sẽ cất cánh muộn giờ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [晚会] (wǎnhuì) - dạ hội, tiệc liên hoan buổi tối [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '晚会',
    'wǎnhuì',
    'dạ hội, tiệc liên hoan buổi tối',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '新年晚会上的节目丰富多彩。',
    'Xīnnián wǎnhuì shang de jiémù fēngfù duōcǎi.',
    'Các tiết mục trên dạ tiệc năm mới phong phú muôn màu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '新年晚会上的节目丰富多彩。', 'Xīnnián wǎnhuì shang de jiémù fēngfù duōcǎi.', 'Các tiết mục trên dạ tiệc năm mới phong phú muôn màu.', 'basic', 1),
      (v_id, '全校师生欢聚一堂，共同庆祝毕业晚会的顺利举行。', 'Quán xiào shīshēng huānjù yì táng, gòngtóng qìngzhù bìyè wǎnhuì de shùnlì jǔxíng.', 'Thầy trò toàn trường vui vẻ sum họp cùng chúc mừng buổi dạ tiệc tốt nghiệp diễn ra thuận lợi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [网球] (wǎngqiú) - quần vợt, tennis [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '网球',
    'wǎngqiú',
    'quần vợt, tennis',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '周末我经常跟同事去打网球。',
    'Zhōumò wǒ jīngcháng gēn tóngshì qù dǎ wǎngqiú.',
    'Cuối tuần tôi thường cùng đồng nghiệp đi đánh quần vợt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '周末我经常跟同事去打网球。', 'Zhōumò wǒ jīngcháng gēn tóngshì qù dǎ wǎngqiú.', 'Cuối tuần tôi thường cùng đồng nghiệp đi đánh quần vợt.', 'basic', 1),
      (v_id, '打网球不仅能增强体魄，还能锻炼快速反应能力。', 'Dǎ wǎngqiú bùjǐn néng zēngqiáng tǐpò, hái néng duànliàn kuàisù fǎnyìng nénglì.', 'Chơi quần vợt không chỉ giúp tăng cường thể lực mà còn rèn luyện khả năng phản ứng nhanh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [网站] (wǎngzhàn) - trang web, website [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '网站',
    'wǎngzhàn',
    'trang web, website',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '你可以在学校官方网站上查询成绩。',
    'Nǐ kěyǐ zài xuéxiào guānfāng wǎngzhàn shang cháxún chéngjì.',
    'Bạn có thể tra cứu điểm số trên trang web chính thức của trường.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '你可以在学校官方网站上查询成绩。', 'Nǐ kěyǐ zài xuéxiào guānfāng wǎngzhàn shang cháxún chéngjì.', 'Bạn có thể tra cứu điểm số trên trang web chính thức của trường.', 'basic', 1),
      (v_id, '这个汉语学习网站汇聚了海量的优质教学视频和练习题。', 'Zhè ge Hànyǔ xuéxí wǎngzhàn huìjù le hǎiliàng de yōuzhì jiàoxué shìpín hé liànxítí.', 'Trang web học tiếng Trung này tập hợp lượng lớn video giảng dạy chất lượng cao và bài tập thực hành.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [卫生间] (wèishēngjiān) - nhà vệ sinh [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '卫生间',
    'wèishēngjiān',
    'nhà vệ sinh',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请问一下，最近的卫生间在哪儿？',
    'Qǐngwèn yíxià, zuì jìn de wèishēngjiān zài nǎr?',
    'Xin hỏi một chút, nhà vệ sinh gần nhất ở đâu ạ?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请问一下，最近的卫生间在哪儿？', 'Qǐngwèn yíxià, zuì jìn de wèishēngjiān zài nǎr?', 'Xin hỏi một chút, nhà vệ sinh gần nhất ở đâu ạ?', 'basic', 1),
      (v_id, '宾馆房间里的卫生间干净整洁，备有充足的日用品。', 'Bīnguǎn fángjiān lǐ de wèishēngjiān gānjìng zhěngjié, bèi yǒu chōngzú de rìyòngpǐn.', 'Nhà vệ sinh trong phòng khách sạn sạch sẽ ngăn nắp, trang bị đầy đủ đồ dùng hàng ngày.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [屋子] (wūzi) - căn phòng, ngôi nhà [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '屋子',
    'wūzi',
    'căn phòng, ngôi nhà',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这间屋子打扫得干干净净。',
    'Zhè jiān wūzi dǎsǎo de gāngānjìngjìng.',
    'Căn phòng này được quét dọn sạch sành sanh.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这间屋子打扫得干干净净。', 'Zhè jiān wūzi dǎsǎo de gāngānjìngjìng.', 'Căn phòng này được quét dọn sạch sành sanh.', 'basic', 1),
      (v_id, '外面天气寒冷，屋子里开着暖气格外温暖舒适。', 'Wàimiàn tiānqì hánlěng, wūzi lǐ kāi zhe nuǎnqì géwài wēnnuǎn shūshì.', 'Bên ngoài thời tiết lạnh giá, trong căn phòng bật lò sưởi ấm áp dễ chịu vô cùng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [西北] (xīběi) - tây bắc, hướng tây bắc [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '西北',
    'xīběi',
    'tây bắc, hướng tây bắc',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '中国西北地区有广阔美丽的草原和沙漠。',
    'Zhōngguó xīběi dìqū yǒu guǎngkuò měilì de cǎoyuán hé shāmò.',
    'Vùng tây bắc Trung Quốc có những đồng cỏ và sa mạc rộng lớn xinh đẹp.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '中国西北地区有广阔美丽的草原和沙漠。', 'Zhōngguó xīběi dìqū yǒu guǎngkuò měilì de cǎoyuán hé shāmò.', 'Vùng tây bắc Trung Quốc có những đồng cỏ và sa mạc rộng lớn xinh đẹp.', 'basic', 1),
      (v_id, '教学楼位于学校正门的西北角，走过去需要三分钟。', 'Jiàoxuélóu wèiyú xuéxiào zhèngmén de xīběi jiǎo, zǒu guòqù xūyào sān fēnzhōng.', 'Tòa nhà giảng dạy nằm ở góc tây bắc cổng chính của trường, đi bộ sang mất ba phút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [西方] (xīfāng) - phương tây, hướng tây [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '西方',
    'xīfāng',
    'phương tây, hướng tây',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '太阳在西方渐渐落下去了。',
    'Tàiyáng zài xīfāng jiànjiàn luò xiàqù le.',
    'Mặt trời đang dần dần lặn xuống ở phương tây.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '太阳在西方渐渐落下去了。', 'Tàiyáng zài xīfāng jiànjiàn luò xiàqù le.', 'Mặt trời đang dần dần lặn xuống ở phương tây.', 'basic', 1),
      (v_id, '了解东方与西方文化差异有助于消除沟通隔阂。', 'Liǎojiě dōngfāng yǔ xīfāng wénhuà chāyì yǒuzhùyú xiāochú gōutōng géhé.', 'Hiểu được sự khác biệt văn hóa giữa phương Đông và phương Tây giúp ích xóa bỏ rào cản giao tiếp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [西南] (xīnán) - tây nam, hướng tây nam [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '西南',
    'xīnán',
    'tây nam, hướng tây nam',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '四川省位于中国的西南方向。',
    'Sìchuān shěng wèiyú Zhōngguó de xīnán fāngxiàng.',
    'Tỉnh Tứ Xuyên nằm ở phía tây nam của Trung Quốc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '四川省位于中国的西南方向。', 'Sìchuān shěng wèiyú Zhōngguó de xīnán fāngxiàng.', 'Tỉnh Tứ Xuyên nằm ở phía tây nam của Trung Quốc.', 'basic', 1),
      (v_id, '中国西南山区风景秀丽，拥有丰富的民族风情。', 'Zhōngguó xīnán shānqū fēngjǐng xiùlì, yōngyǒu fēngfù de mínzú fēngqíng.', 'Vùng núi tây nam Trung Quốc phong cảnh tú lệ, mang đậm bản sắc phong tục dân tộc phong phú.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [喜爱] (xǐ’ài) - yêu thích, mến chuộng [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '喜爱',
    'xǐ’ài',
    'yêu thích, mến chuộng',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他非常喜爱中国传统书法。',
    'Tā fēicháng xǐ’ài Zhōngguó chuántǒng shūfǎ.',
    'Anh ấy rất yêu thích thư pháp truyền thống Trung Quốc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他非常喜爱中国传统书法。', 'Tā fēicháng xǐ’ài Zhōngguó chuántǒng shūfǎ.', 'Anh ấy rất yêu thích thư pháp truyền thống Trung Quốc.', 'basic', 1),
      (v_id, '大熊猫憨态可掬的模样深受全世界人民的喜爱。', 'Dàxióngmāo hāntàikějū de múyàng shēn shòu quán shìjiè rénmín de xǐ’ài.', 'Dáng vẻ đáng yêu ngộ nghĩnh của loài gấu trúc được nhân dân toàn thế giới vô cùng mến chuộng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [洗衣机] (xǐyījī) - máy giặt [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '洗衣机',
    'xǐyījī',
    'máy giặt',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请把脏衣服放到洗衣机里。',
    'Qǐng bǎ zāng yīfu fàng dào xǐyījī lǐ.',
    'Xin hãy cho quần áo bẩn vào trong máy giặt.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请把脏衣服放到洗衣机里。', 'Qǐng bǎ zāng yīfu fàng dào xǐyījī lǐ.', 'Xin hãy cho quần áo bẩn vào trong máy giặt.', 'basic', 1),
      (v_id, '这台全自动洗衣机不仅省水省电，洗衣服还特别干净。', 'Zhè tái quánzìdòng xǐyījī bùjǐn shěng shuǐ shěng diàn, xǐ yīfu hái tèbié gānjìng.', 'Chiếc máy giặt tự động này không chỉ tiết kiệm điện nước mà giặt quần áo còn rất sạch.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [夏天] (xiàtiān) - mùa hè [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '夏天',
    'xiàtiān',
    'mùa hè',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '夏天天气炎热，游泳最舒服了。',
    'Xiàtiān tiānqì yánrè, yóuyǒng zuì shūfu le.',
    'Mùa hè thời tiết oi bức, đi bơi là dễ chịu nhất.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '夏天天气炎热，游泳最舒服了。', 'Xiàtiān tiānqì yánrè, yóuyǒng zuì shūfu le.', 'Mùa hè thời tiết oi bức, đi bơi là dễ chịu nhất.', 'basic', 1),
      (v_id, '夏天里吃上一块冰镇西瓜，整个人都神清气爽。', 'Xiàtiān lǐ chī shang yí kuài bīngzhèn xīguā, zhěng gè rén dōu shénqīngqìshuǎng.', 'Vào mùa hè ăn một miếng dưa hấu ướp lạnh, cả người sảng khoái mát rượi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [箱子] (xiāngzi) - chiếc hòm, vali, thùng đựng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '箱子',
    'xiāngzi',
    'chiếc hòm, vali, thùng đựng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这个行李箱子太重了，我提不动。',
    'Zhè ge xíngli xiāngzi tài zhòng le, wǒ tí bú dòng.',
    'Chiếc vali hành lý này nặng quá, tôi xách không nổi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个行李箱子太重了，我提不动。', 'Zhè ge xíngli xiāngzi tài zhòng le, wǒ tí bú dòng.', 'Chiếc vali hành lý này nặng quá, tôi xách không nổi.', 'basic', 1),
      (v_id, '请帮我把这些书整齐地装进纸箱子里。', 'Qǐng bāng wǒ bǎ zhèxiē shū zhěngqí de zhuāng jìn zhǐxiāngzi lǐ.', 'Làm ơn giúp tôi xếp những cuốn sách này ngay ngắn vào trong thùng carton.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [相机] (xiàngjī) - máy ảnh [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '相机',
    'xiàngjī',
    'máy ảnh',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他用相机拍下了美丽的日落景色。',
    'Tā yòng xiàngjī pāi xià le měilì de rìluò jǐngsè.',
    'Anh ấy dùng máy ảnh chụp lại cảnh hoàng hôn tuyệt đẹp.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他用相机拍下了美丽的日落景色。', 'Tā yòng xiàngjī pāi xià le měilì de rìluò jǐngsè.', 'Anh ấy dùng máy ảnh chụp lại cảnh hoàng hôn tuyệt đẹp.', 'basic', 1),
      (v_id, '去外地旅游前，记得把相机的电池充满电。', 'Qù wàidì lǚyóu qián, jìde bǎ xiàngjī de diànchí chōng mǎn diàn.', 'Trước khi đi du lịch nơi xa, nhớ sạc đầy pin cho máy ảnh nhé.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [小区] (xiǎoqū) - khu dân cư, tiểu khu, khu phố [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '小区',
    'xiǎoqū',
    'khu dân cư, tiểu khu, khu phố',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我们小区里绿树成荫，环境十分优美。',
    'Wǒmen xiǎoqū lǐ lǜshù chéng yīn, huánjìng shífēn yōuměi.',
    'Trong khu dân cư của chúng tôi cây cối rợp bóng, môi trường rất đẹp.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我们小区里绿树成荫，环境十分优美。', 'Wǒmen xiǎoqū lǐ lǜshù chéng yīn, huánjìng shífēn yōuměi.', 'Trong khu dân cư của chúng tôi cây cối rợp bóng, môi trường rất đẹp.', 'basic', 1),
      (v_id, '小区门口设有便利店和蔬菜超市，买东西很方便。', 'Xiǎoqū ménkǒu shè yǒu biànlìdiàn hé shūcài chāoshì, mǎi dōngxi hěn fāngbiàn.', 'Cổng khu phố có cửa hàng tiện ích và siêu thị rau củ, mua sắm rất thuận tiện.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [校园] (xiàoyuán) - khuôn viên trường học [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '校园',
    'xiàoyuán',
    'khuôn viên trường học',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '秋天的大学校园铺满了金黄的落叶。',
    'Qiūtiān de dàxué xiàoyuán pū mǎn le jīnhuáng de luòyè.',
    'Khuôn viên trường đại học vào mùa thu trải đầy lá vàng rơi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '秋天的大学校园铺满了金黄的落叶。', 'Qiūtiān de dàxué xiàoyuán pū mǎn le jīnhuáng de luòyè.', 'Khuôn viên trường đại học vào mùa thu trải đầy lá vàng rơi.', 'basic', 1),
      (v_id, '漫步在宁静的校园里，随处能感受到浓厚的学术气息。', 'Mànbù zài níngjìng de xiàoyuán lǐ, suíchù néng gǎnshòu dào nónghòu de xuéshù qìxī.', 'Tản bộ trong khuôn viên trường tĩnh lặng, nơi nơi đều có thể cảm nhận bầu không khí học thuật đậm đà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [鞋] (xié) - giày, đôi giày [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '鞋',
    'xié',
    'giày, đôi giày',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '进屋前请先脱掉外面的鞋。',
    'Jìn wū qián qǐng xiān tuō diào wàimiàn de xié.',
    'Trước khi vào phòng xin cởi giày đi bên ngoài ra.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '进屋前请先脱掉外面的鞋。', 'Jìn wū qián qǐng xiān tuō diào wàimiàn de xié.', 'Trước khi vào phòng xin cởi giày đi bên ngoài ra.', 'basic', 1),
      (v_id, '这双运动鞋穿起来轻便柔软，很适合跑步锻炼。', 'Zhè shuāng yùndòngxié chuān qǐlái qīngbiàn róuruǎn, hěn shìhé pǎobù duànliàn.', 'Đôi giày thể thao này mang vào nhẹ nhàng và êm ái, rất thích hợp chạy bộ rèn luyện.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [心里] (xīnlǐ) - trong lòng, trong tâm [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '心里',
    'xīnlǐ',
    'trong lòng, trong tâm',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '听到这个喜讯，他心里感到非常温暖。',
    'Tīng dào zhè ge xǐxùn, tā xīnlǐ gǎndào fēicháng wēnnuǎn.',
    'Nghe được tin vui này, trong lòng anh ấy cảm thấy rất ấm áp.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '听到这个喜讯，他心里感到非常温暖。', 'Tīng dào zhè ge xǐxùn, tā xīnlǐ gǎndào fēicháng wēnnuǎn.', 'Nghe được tin vui này, trong lòng anh ấy cảm thấy rất ấm áp.', 'basic', 1),
      (v_id, '有什么困难就说出来，别老憋在自己心里。', 'Yǒu shénme kùnnan jiù shuō chūlái, bié lǎo biē zài zìjǐ xīnlǐ.', 'Có khó khăn gì thì hãy nói ra, đừng cứ dồn nén trong lòng mình mãi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [新年] (xīnnián) - năm mới [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '新年',
    'xīnnián',
    'năm mới',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '祝大家新年快乐，万事如意！',
    'Zhù dàjiā xīnnián kuàilè, wànshì rúyì!',
    'Chúc mọi người năm mới vui vẻ, vạn sự như ý!'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '祝大家新年快乐，万事如意！', 'Zhù dàjiā xīnnián kuàilè, wànshì rúyì!', 'Chúc mọi người năm mới vui vẻ, vạn sự như ý!', 'basic', 1),
      (v_id, '新年到来之际，到处张灯结彩，洋溢着喜庆的气氛。', 'Xīnnián dàolái zhī jì, dàochù zhāngdēngjiécǎi, yángyì zhe xǐqìng de qìfēn.', 'Thời khắc năm mới đến, khắp nơi chăng đèn kết hoa, ngập tràn bầu không khí hỷ hoan.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [信] (xìn) - tin tưởng; bức thư, tin tức [Động từ / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '信',
    'xìn',
    'tin tưởng; bức thư, tin tức',
    'Động từ / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我相信通过努力一定能够实现梦想。',
    'Wǒ xiāngxìn tōngguò nǔlì yídìng nénggòu shíxiàn mèngxiǎng.',
    'Tôi tin rằng thông qua nỗ lực nhất định có thể hiện thực hóa ước mơ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我相信通过努力一定能够实现梦想。', 'Wǒ xiāngxìn tōngguò nǔlì yídìng nénggòu shíxiàn mèngxiǎng.', 'Tôi tin rằng thông qua nỗ lực nhất định có thể hiện thực hóa ước mơ.', 'basic', 1),
      (v_id, '他给远在国外的父母写了一封充满真情的长信。', 'Tā gěi yuǎn zài guówài de fùmǔ xiě le yì fēng chōngmǎn zhēnqíng de cháng xìn.', 'Anh ấy viết một bức thư dài chan chứa ân tình gửi cha mẹ ở tận nước ngoài.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [行] (xíng) - được, ổn, có năng lực [Động từ / Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '行',
    'xíng',
    'được, ổn, có năng lực',
    'Động từ / Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '明天下午三点见面，你看行不行？',
    'Míngtiān xiàwǔ sān diǎn jiànmiàn, nǐ kàn xíng bù xíng?',
    'Chiều mai ba giờ gặp mặt, bạn thấy có được không?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '明天下午三点见面，你看行不行？', 'Míngtiān xiàwǔ sān diǎn jiànmiàn, nǐ kàn xíng bù xíng?', 'Chiều mai ba giờ gặp mặt, bạn thấy có được không?', 'basic', 1),
      (v_id, '只要你肯下苦功去钻研，你在技术方面一定行！', 'Zhǐyào nǐ kěn xià kǔgōng qù zuānyán, nǐ zài jìshù fāngmiàn yídìng xíng!', 'Chỉ cần bạn chịu khó bỏ công nghiên cứu, về mặt kỹ thuật bạn chắc chắn làm được!', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [行李] (xíngli) - hành lý [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '行李',
    'xíngli',
    'hành lý',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '出门旅行时尽量少带一些不必要的行李。',
    'Chūmén lǚxíng shí jǐnliàng shǎo dài yìxiē bú bìyào de xíngli.',
    'Khi đi du lịch hãy cố gắng mang ít hành lý không cần thiết.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '出门旅行时尽量少带一些不必要的行李。', 'Chūmén lǚxíng shí jǐnliàng shǎo dài yìxiē bú bìyào de xíngli.', 'Khi đi du lịch hãy cố gắng mang ít hành lý không cần thiết.', 'basic', 1),
      (v_id, '下飞机后，请到五号转盘提取您的托运行李。', 'Xià fēijī hòu, qǐng dào wǔ hào zhuànpán tíqǔ nín de tuōyùn xíngli.', 'Sau khi xuống máy bay, xin hãy đến băng chuyền số 5 lấy hành lý ký gửi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [兴趣] (xìngqù) - hứng thú, niềm đam mê [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '兴趣',
    'xìngqù',
    'hứng thú, niềm đam mê',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我对学习中国传统茶文化很感兴趣。',
    'Wǒ duì xuéxí Zhōngguó chuántǒng chá wénhuà hěn gǎn xìngqù.',
    'Tôi rất có hứng thú với việc tìm hiểu văn hóa trà truyền thống Trung Quốc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我对学习中国传统茶文化很感兴趣。', 'Wǒ duì xuéxí Zhōngguó chuántǒng chá wénhuà hěn gǎn xìngqù.', 'Tôi rất có hứng thú với việc tìm hiểu văn hóa trà truyền thống Trung Quốc.', 'basic', 1),
      (v_id, '兴趣是最好的老师，能激发人不断探索未知的潜能。', 'Xìngqù shì zuì hǎo de lǎoshī, néng jīfā rén búduàn tànsuǒ wèizhī de qiánnéng.', 'Hứng thú là người thầy tốt nhất, có thể khơi dậy tiềm năng không ngừng khám phá điều chưa biết.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [休假] (xiūjià) - nghỉ phép, nghỉ ngơi [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '休假',
    'xiūjià',
    'nghỉ phép, nghỉ ngơi',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '辛苦工作了一整年，他准备下周休假。',
    'Xīnkǔ gōngzuò le yì zhěng nián, tā zhǔnbèi xià zhōu xiūjià.',
    'Làm việc vất vả cả năm trời, anh ấy chuẩn bị tuần sau nghỉ phép.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '辛苦工作了一整年，他准备下周休假。', 'Xīnkǔ gōngzuò le yì zhěng nián, tā zhǔnbèi xià zhōu xiūjià.', 'Làm việc vất vả cả năm trời, anh ấy chuẩn bị tuần sau nghỉ phép.', 'basic', 1),
      (v_id, '公司规定员工每年都享有一定天数的带薪年假。', 'Gōngsī guīdìng yuángōng měinián dōu xiǎngyǒu yídìng tiānshù de dàixīn niánjià.', 'Công ty quy định nhân viên mỗi năm đều được hưởng số ngày nghỉ phép có lương nhất định.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [选] (xuǎn) - chọn, tuyển chọn, bầu cử [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '选',
    'xuǎn',
    'chọn, tuyển chọn, bầu cử',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这双鞋有三种颜色，你选哪一种？',
    'Zhè shuāng xié yǒu sān zhǒng yánsè, nǐ xuǎn nǎ yì zhǒng?',
    'Đôi giày này có ba màu, bạn chọn màu nào?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这双鞋有三种颜色，你选哪一种？', 'Zhè shuāng xié yǒu sān zhǒng yánsè, nǐ xuǎn nǎ yì zhǒng?', 'Đôi giày này có ba màu, bạn chọn màu nào?', 'basic', 1),
      (v_id, '新学期开始，同学们都在网上认真挑选自己喜爱的课程。', 'Xīn xuéqī kāishǐ, tóngxuémen dōu zài wǎng shang rènzhēn tiāoxuǎn zìjǐ xǐ’ài de kèchéng.', 'Học kỳ mới bắt đầu, các bạn học sinh đều lên mạng cẩn thận chọn lựa các môn học mình yêu thích.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [学期] (xuéqī) - học kỳ [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '学期',
    'xuéqī',
    'học kỳ',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这个学期我们开设了四门专业课。',
    'Zhè ge xuéqī wǒmen kāishè le sì mén zhuānyèkè.',
    'Học kỳ này chúng tôi mở bốn môn học chuyên ngành.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个学期我们开设了四门专业课。', 'Zhè ge xuéqī wǒmen kāishè le sì mén zhuānyèkè.', 'Học kỳ này chúng tôi mở bốn môn học chuyên ngành.', 'basic', 1),
      (v_id, '学期末的复习阶段非常关键，大家都在全力备考。', 'Xuéqī mò de fùxí jiēduàn fēicháng guānjiàn, dàjiā dōu zài quánlì bèikǎo.', 'Giai đoạn ôn tập cuối học kỳ rất then chốt, mọi người đều dốc toàn lực chuẩn bị thi cử.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [牙] (yá) - răng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '牙',
    'yá',
    'răng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他因为牙疼，今天没能来上课。',
    'Tā yīnwèi yáténg, jīntiān méi néng lái shàngkè.',
    'Vì bị đau răng nên hôm nay anh ấy không thể đến lớp.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他因为牙疼，今天没能来上课。', 'Tā yīnwèi yáténg, jīntiān méi néng lái shàngkè.', 'Vì bị đau răng nên hôm nay anh ấy không thể đến lớp.', 'basic', 1),
      (v_id, '保护好牙齿健康，能让我们一生都享受各种美味佳肴。', 'Bǎohù hǎo yáchǐ jiànkāng, néng ràng wǒmen yìshēng dōu xiǎngshòu gè zhǒng měiwèi jiāyáo.', 'Bảo vệ tốt sức khỏe răng miệng sẽ giúp chúng ta cả đời thưởng thức muôn vàn món ăn ngon.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [牙刷] (yáshuā) - bàn chải đánh răng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '牙刷',
    'yáshuā',
    'bàn chải đánh răng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '医生建议每三个月更换一次牙刷。',
    'Yīshēng jiànyì měi sān gè yuè gēnghuàn yí cì yáshuā.',
    'Bác sĩ khuyên nên thay bàn chải đánh răng ba tháng một lần.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '医生建议每三个月更换一次牙刷。', 'Yīshēng jiànyì měi sān gè yuè gēnghuàn yí cì yáshuā.', 'Bác sĩ khuyên nên thay bàn chải đánh răng ba tháng một lần.', 'basic', 1),
      (v_id, '旅行前请检查洗漱包，确保牙刷和毛巾都已带齐。', 'Lǚxíng qián qǐng jiǎnchá xǐshùbāo, quèbǎo yáshuā hé máojīn dōu yǐ dài qí.', 'Trước khi đi du lịch hãy kiểm tra túi đồ vệ sinh cá nhân, bảo đảm mang đủ bàn chải và khăn mặt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [羊] (yáng) - cừu, dê [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '羊',
    'yáng',
    'cừu, dê',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '广阔的草原上有一大群可爱的白羊。',
    'Guǎngkuò de cǎoyuán shang yǒu yí dà qún kě’ài de bái yáng.',
    'Trên thảo nguyên rộng lớn có một đàn cừu trắng rất đáng yêu.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '广阔的草原上有一大群可爱的白羊。', 'Guǎngkuò de cǎoyuán shang yǒu yí dà qún kě’ài de bái yáng.', 'Trên thảo nguyên rộng lớn có một đàn cừu trắng rất đáng yêu.', 'basic', 1),
      (v_id, '牧民骑着马，在山坡下看护着吃草的羊群。', 'Mùmín qí zhe mǎ, zài shānpō xià kānhù zhe chī cǎo de yángqún.', 'Người chăn thả cưỡi ngựa dưới chân đồi trông coi đàn dê gặm cỏ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [养] (yǎng) - nuôi dưỡng, chăm sóc, trồng [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '养',
    'yǎng',
    'nuôi dưỡng, chăm sóc, trồng',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我家里养了一只温顺的小猫。',
    'Wǒ jiālǐ yǎng le yì zhī wēnshùn de xiǎomāo.',
    'Nhà tôi nuôi một chú mèo con rất ngoan ngoãn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我家里养了一只温顺的小猫。', 'Wǒ jiālǐ yǎng le yì zhī wēnshùn de xiǎomāo.', 'Nhà tôi nuôi một chú mèo con rất ngoan ngoãn.', 'basic', 1),
      (v_id, '父母辛辛苦苦把我们养大成人，我们应该孝顺他们。', 'Fùmǔ xīnxīnkǔkǔ bǎ wǒmen yǎng dà chéngrén, wǒmen yīnggāi xiàoshùn tāmen.', 'Cha mẹ cực nhọc nuôi chúng ta khôn lớn nên người, chúng ta nên hiếu thuận với họ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [页] (yè) - trang (sách, báo) [Lượng từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '页',
    'yè',
    'trang (sách, báo)',
    'Lượng từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天的阅读作业是从第一页读到第十页。',
    'Jīntiān de yuèdú zuòyè shì cóng dì-yī yè dú dào dì shí yè.',
    'Bài tập đọc hôm nay là đọc từ trang 1 đến trang 10.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天的阅读作业是从第一页读到第十页。', 'Jīntiān de yuèdú zuòyè shì cóng dì-yī yè dú dào dì shí yè.', 'Bài tập đọc hôm nay là đọc từ trang 1 đến trang 10.', 'basic', 1),
      (v_id, '这本书一共有三百多页，内容十分详实精彩。', 'Zhè běn shū yí gòng yǒu sān bǎi duō yè, nèiróng shífēn xiángshí jīngcǎi.', 'Cuốn sách này có tổng cộng hơn ba trăm trang, nội dung rất chi tiết và hấp dẫn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [一块儿] (yíkuàir) - cùng nhau, một khối [Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '一块儿',
    'yíkuàir',
    'cùng nhau, một khối',
    'Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '今天下午我们一块儿去图书馆自习吧。',
    'Jīntiān xiàwǔ wǒmen yíkuàir qù túshūguǎn zìxí ba.',
    'Chiều nay chúng mình cùng nhau đến thư viện tự học nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '今天下午我们一块儿去图书馆自习吧。', 'Jīntiān xiàwǔ wǒmen yíkuàir qù túshūguǎn zìxí ba.', 'Chiều nay chúng mình cùng nhau đến thư viện tự học nhé.', 'basic', 1),
      (v_id, '大家坐在一块儿分享着各自家乡的美食，气氛非常融洽。', 'Dàjiā zuò zài yíkuàir fēnxiǎng zhe gèzì jiāxiāng de měishí, qìfēn fēicháng róngqià.', 'Mọi người ngồi lại cùng nhau chia sẻ món ngon của quê hương mình, bầu không khí rất ấm áp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [以后] (yǐhòu) - sau này, sau khi [Danh từ / Phó từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '以后',
    'yǐhòu',
    'sau này, sau khi',
    'Danh từ / Phó từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '吃完晚饭以后，我们出去散步。',
    'Chī wán wǎnfàn yǐhòu, wǒmen chūqù sànbù.',
    'Sau khi ăn tối xong, chúng ta ra ngoài đi dạo.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '吃完晚饭以后，我们出去散步。', 'Chī wán wǎnfàn yǐhòu, wǒmen chūqù sànbù.', 'Sau khi ăn tối xong, chúng ta ra ngoài đi dạo.', 'basic', 1),
      (v_id, '以后遇到任何不懂的问题，都可以随时向老师提问。', 'Yǐhòu yù dào rènhé bù dǒng de wèntí, dōu kěyǐ suíshí xiàng lǎoshī tíwèn.', 'Sau này gặp bất kỳ vấn đề gì không hiểu, đều có thể hỏi thầy cô bất cứ lúc nào.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [以上] (yǐshàng) - trở lên, trên đây [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '以上',
    'yǐshàng',
    'trở lên, trên đây',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '考试成绩在八十分以上的学生可以申请奖学金。',
    'Kǎoshì chéngjì zài bāshí fēn yǐshàng de xuésheng kěyǐ shēnqǐng jiǎngxuéjīn.',
    'Học sinh có điểm thi từ 80 điểm trở lên có thể nộp đơn xin học bổng.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '考试成绩在八十分以上的学生可以申请奖学金。', 'Kǎoshì chéngjì zài bāshí fēn yǐshàng de xuésheng kěyǐ shēnqǐng jiǎngxuéjīn.', 'Học sinh có điểm thi từ 80 điểm trở lên có thể nộp đơn xin học bổng.', 'basic', 1),
      (v_id, '以上就是今天会议讨论的主要内容和具体安排。', 'Yǐshàng jiù shì jīntiān huìyì tǎolùn de zhǔyào nèiróng hé jùtǐ ānpái.', 'Trên đây chính là nội dung chủ yếu và lịch trình cụ thể mà cuộc họp hôm nay thảo luận.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [以外] (yǐwài) - ngoài ra, bên ngoài [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '以外',
    'yǐwài',
    'ngoài ra, bên ngoài',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '除了他以外，所有同学都按时到齐了。',
    'Chúle tā yǐwài, suǒyǒu tóngxué dōu ànshí dào qí le.',
    'Ngoại trừ anh ấy ra, tất cả các bạn học đều đã đến đông đủ đúng giờ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '除了他以外，所有同学都按时到齐了。', 'Chúle tā yǐwài, suǒyǒu tóngxué dōu ànshí dào qí le.', 'Ngoại trừ anh ấy ra, tất cả các bạn học đều đã đến đông đủ đúng giờ.', 'basic', 1),
      (v_id, '工作时间以外，请尽量不要打扰员工的个人生活。', 'Gōngzuò shíjiān yǐwài, qǐng jǐnliàng bú yào dǎrǎo yuángōng de gèrén shēnghuó.', 'Ngoài thời gian làm việc, xin cố gắng đừng làm phiền cuộc sống riêng của nhân viên.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [以为] (yǐwéi) - tưởng rằng, ngỡ là (thực tế không phải vậy) [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '以为',
    'yǐwéi',
    'tưởng rằng, ngỡ là (thực tế không phải vậy)',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我以为今天会下雨，所以带了雨伞。',
    'Wǒ yǐwéi jīntiān huì xiàyǔ, suǒyǐ dài le yǔsǎn.',
    'Tôi tưởng rằng hôm nay sẽ mưa nên đã mang theo ô.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我以为今天会下雨，所以带了雨伞。', 'Wǒ yǐwéi jīntiān huì xiàyǔ, suǒyǐ dài le yǔsǎn.', 'Tôi tưởng rằng hôm nay sẽ mưa nên đã mang theo ô.', 'basic', 1),
      (v_id, '大家都以为他已经回国了，没想到今天在图书馆又碰见了他。', 'Dàjiā dōu yǐwéi tā yǐjīng huí guó le, méi xiǎngdào jīntiān zài túshūguǎn yòu pèngjiàn le tā.', 'Mọi người đều ngỡ là anh ấy đã về nước rồi, không ngờ hôm nay ở thư viện lại gặp lại anh ấy.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [以下] (yǐxià) - trở xuống, dưới đây [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '以下',
    'yǐxià',
    'trở xuống, dưới đây',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '身高一米二以下的小朋友可以免费乘车。',
    'Shēngāo yì mǐ èr yǐxià de xiǎopéngyou kěyǐ miǎnfèi chéng chē.',
    'Trẻ em có chiều cao dưới 1m2 có thể đi xe miễn phí.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '身高一米二以下的小朋友可以免费乘车。', 'Shēngāo yì mǐ èr yǐxià de xiǎopéngyou kěyǐ miǎnfèi chéng chē.', 'Trẻ em có chiều cao dưới 1m2 có thể đi xe miễn phí.', 'basic', 1),
      (v_id, '请仔细阅读以下注意事项并严格按要求执行。', 'Qǐng zǐxì yuèdú yǐxià zhùyì shìxiàng bìng yángé àn yāoqiú zhíxíng.', 'Xin hãy đọc kỹ các điều cần lưu ý dưới đây và nghiêm túc thực hiện theo yêu cầu.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [银行卡] (yínhángkǎ) - thẻ ngân hàng [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '银行卡',
    'yínhángkǎ',
    'thẻ ngân hàng',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我的银行卡密码不小心输错了三次。',
    'Wǒ de yínhángkǎ mìmǎ bù xiǎoxīn shū cuò le sān cì.',
    'Mật khẩu thẻ ngân hàng của tôi sơ ý nhập sai ba lần.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我的银行卡密码不小心输错了三次。', 'Wǒ de yínhángkǎ mìmǎ bù xiǎoxīn shū cuò le sān cì.', 'Mật khẩu thẻ ngân hàng của tôi sơ ý nhập sai ba lần.', 'basic', 1),
      (v_id, '如果银行卡不慎丢失，请立刻拨打客服电话办理挂失。', 'Rúguǒ yínhángkǎ búshèn diūshī, qǐng lìkè bōdǎ kèfù diànhuà bànlǐ guàshī.', 'Nếu thẻ ngân hàng chẳng may bị thất lạc, xin hãy lập tức gọi đến tổng đài để làm thủ tục báo mất thẻ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [邮件] (yóujiàn) - thư từ, bưu phẩm, email [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '邮件',
    'yóujiàn',
    'thư từ, bưu phẩm, email',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我已经把详细的合同通过电子邮件发给你了。',
    'Wǒ yǐjīng bǎ xiángxì de hétong tōngguò diànzǐ yóujiàn fā gěi nǐ le.',
    'Tôi đã gửi hợp đồng chi tiết qua thư điện tử cho bạn rồi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我已经把详细的合同通过电子邮件发给你了。', 'Wǒ yǐjīng bǎ xiángxì de hétong tōngguò diànzǐ yóujiàn fā gěi nǐ le.', 'Tôi đã gửi hợp đồng chi tiết qua thư điện tử cho bạn rồi.', 'basic', 1),
      (v_id, '每天查收和回复重要邮件是办公室工作的重要部分。', 'Měitiān cháshōu hé huífù zhòngyào yóujiàn shì bàngōngshì gōngzuò de zhòngyào bùfen.', 'Mỗi ngày kiểm tra nhận và trả lời email quan trọng là phần thiết yếu của công việc văn phòng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [游客] (yóukè) - du khách, khách tham quan [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '游客',
    'yóukè',
    'du khách, khách tham quan',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '每年有成千上万的外国游客来故宫参观。',
    'Měinián yǒu chéngqiānshàngwàn de wàiguó yóukè lái Gùgōng cānguān.',
    'Hàng năm có hàng ngàn vạn du khách nước ngoài đến Cố Cung tham quan.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '每年有成千上万的外国游客来故宫参观。', 'Měinián yǒu chéngqiānshàngwàn de wàiguó yóukè lái Gùgōng cānguān.', 'Hàng năm có hàng ngàn vạn du khách nước ngoài đến Cố Cung tham quan.', 'basic', 1),
      (v_id, '景区导游热情地为前来的游客讲解当地的历史文化典故。', 'Jǐngqū dǎoyóu rèqíng de wèi qiánlái de yóukè jiǎngjiě dāngdì de lìshǐ wénhuà diǎngù.', 'Hướng dẫn viên khu danh lam nhiệt tình thuyết minh cho du khách các điển cố lịch sử văn hóa địa phương.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [邮箱] (yóuxiāng) - hòm thư, hộp thư điện tử [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '邮箱',
    'yóuxiāng',
    'hòm thư, hộp thư điện tử',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请把你的电子邮箱地址写在这张纸上。',
    'Qǐng bǎ nǐ de diànzǐ yóuxiāng dìzhǐ xiě zài zhè zhāng zhǐ shang.',
    'Xin hãy viết địa chỉ hộp thư điện tử của bạn lên tờ giấy này.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请把你的电子邮箱地址写在这张纸上。', 'Qǐng bǎ nǐ de diànzǐ yóuxiāng dìzhǐ xiě zài zhè zhāng zhǐ shang.', 'Xin hãy viết địa chỉ hộp thư điện tử của bạn lên tờ giấy này.', 'basic', 1),
      (v_id, '每天上班第一件事，他都会先打开邮箱检查最新消息。', 'Měitiān shàngbān dì-yī jiàn shì, tā dōu huì xiān dǎkāi yóuxiāng jiǎnchá zuìxīn xiāoxi.', 'Mỗi ngày đi làm việc đầu tiên, anh ấy đều mở hòm thư kiểm tra tin tức mới nhất.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [有关] (yǒuguān) - liên quan đến, có liên hệ [Động từ / Giới từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '有关',
    'yǒuguān',
    'liên quan đến, có liên hệ',
    'Động từ / Giới từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这本书介绍了许多有关中国历史的知识。',
    'Zhè běn shū jièshào le xǔduō yǒuguān Zhōngguó lìshǐ de zhīshi.',
    'Cuốn sách này giới thiệu nhiều kiến thức liên quan đến lịch sử Trung Quốc.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这本书介绍了许多有关中国历史的知识。', 'Zhè běn shū jièshào le xǔduō yǒuguān Zhōngguó lìshǐ de zhīshi.', 'Cuốn sách này giới thiệu nhiều kiến thức liên quan đến lịch sử Trung Quốc.', 'basic', 1),
      (v_id, '身体健康状况与日常良好的作息习惯密切有关。', 'Shēntǐ jiànkāng zhuàngkuàng yǔ rìcháng liánghǎo de zuòxī xíguàn mìqiè yǒuguān.', 'Tình trạng sức khỏe cơ thể có liên hệ mật thiết với thói quen sinh hoạt tốt hàng ngày.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [有用] (yǒuyòng) - hữu ích, có tác dụng [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '有用',
    'yǒuyòng',
    'hữu ích, có tác dụng',
    'Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '老师推荐的学习方法非常有用。',
    'Lǎoshī tuījiàn de xuéxí fāngfǎ fēicháng yǒuyòng.',
    'Phương pháp học tập thầy giáo gợi ý rất hữu ích.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '老师推荐的学习方法非常有用。', 'Lǎoshī tuījiàn de xuéxí fāngfǎ fēicháng yǒuyòng.', 'Phương pháp học tập thầy giáo gợi ý rất hữu ích.', 'basic', 1),
      (v_id, '遇到困难时，多听听长辈的意见会对你很有用。', 'Yù dào kùnnan shí, duō tīngting zhǎngbèi de yìjiàn huì duì nǐ hěn yǒuyòng.', 'Khi gặp khó khăn, lắng nghe ý kiến của bậc tiền bối sẽ rất có ích cho bạn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [羽毛球] (yǔmáoqiú) - cầu lông [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '羽毛球',
    'yǔmáoqiú',
    'cầu lông',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '下午放学后我们去体育馆打羽毛球吧。',
    'Xiàwǔ fàngxué hòu wǒmen qù tǐyùguǎn dǎ yǔmáoqiú ba.',
    'Chiều tan học xong chúng mình đến nhà thi đấu đánh cầu lông nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '下午放学后我们去体育馆打羽毛球吧。', 'Xiàwǔ fàngxué hòu wǒmen qù tǐyùguǎn dǎ yǔmáoqiú ba.', 'Chiều tan học xong chúng mình đến nhà thi đấu đánh cầu lông nhé.', 'basic', 1),
      (v_id, '打羽毛球需要全身协调配合，是一项极佳的有氧运动。', 'Dǎ yǔmáoqiú xūyào quánshēn xiétiáo pèihé, shì yí xiàng jí jiā de yǒuyǎng yùndòng.', 'Đánh cầu lông cần sự phối hợp nhịp nhàng toàn thân, là một môn thể thao vận động rất tốt.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [语言] (yǔyán) - ngôn ngữ, tiếng nói [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '语言',
    'yǔyán',
    'ngôn ngữ, tiếng nói',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '语言是人类沟通交流的重要工具。',
    'Yǔyán shì rénlèi gōutōng jiāoliú de zhòngyào gōngjù.',
    'Ngôn ngữ là công cụ quan trọng để nhân loại giao tiếp trao đổi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '语言是人类沟通交流的重要工具。', 'Yǔyán shì rénlèi gōutōng jiāoliú de zhòngyào gōngjù.', 'Ngôn ngữ là công cụ quan trọng để nhân loại giao tiếp trao đổi.', 'basic', 1),
      (v_id, '学习一种新的语言，就等于打开了一扇通往新世界的大门。', 'Xuéxí yì zhǒng xīn de yǔyán, jiù děngyú dǎkāi le yí shàn tōng wǎng xīn shìjiè de dàmén.', 'Học một ngôn ngữ mới cũng tương đương với mở ra một cánh cửa bước vào thế giới mới.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [雨衣] (yǔyī) - áo mưa [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '雨衣',
    'yǔyī',
    'áo mưa',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '外面下大雨了，出门记得穿上雨衣。',
    'Wàimiàn xià dà yǔ le, chūmén jìde chuān shang yǔyī.',
    'Bên ngoài trời mưa to rồi, ra ngoài nhớ mặc áo mưa nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '外面下大雨了，出门记得穿上雨衣。', 'Wàimiàn xià dà yǔ le, chūmén jìde chuān shang yǔyī.', 'Bên ngoài trời mưa to rồi, ra ngoài nhớ mặc áo mưa nhé.', 'basic', 1),
      (v_id, '骑自行车上下班时，穿一件合身的雨衣比打伞安全方便得多。', 'Qí zìxíngchē shàngxiàbān shí, chuān yí jiàn héshēn de yǔyī bǐ dǎ sǎn ānquán fāngbiàn de duō.', 'Khi đi xe đạp đi làm và tan tầm, mặc một chiếc áo mưa vừa vặn an toàn và tiện lợi hơn che ô rất nhiều.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [遇见] (yùjiàn) - tình cờ gặp, bắt gặp [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '遇见',
    'yùjiàn',
    'tình cờ gặp, bắt gặp',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我昨天在书店偶然遇见了一位老朋友。',
    'Wǒ zuótiān zài shūdiàn ǒurán yùjiàn le yí wèi lǎo péngyou.',
    'Hôm qua ở hiệu sách tôi tình cờ gặp một người bạn cũ.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我昨天在书店偶然遇见了一位老朋友。', 'Wǒ zuótiān zài shūdiàn ǒurán yùjiàn le yí wèi lǎo péngyou.', 'Hôm qua ở hiệu sách tôi tình cờ gặp một người bạn cũ.', 'basic', 1),
      (v_id, '在异国他乡遇见说同样语言的同胞，让人感到特别亲切。', 'Zài yìguótāxiāng yùjiàn shuō tóngyàng yǔyán de tóngbāo, ràng rén gǎndào tèbié qīnqiè.', 'Ở nơi đất khách quê người tình cờ gặp đồng bào nói cùng ngôn ngữ khiến người ta cảm thấy vô cùng thân thương.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [园] (yuán) - vườn, công viên, khu vườn [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '园',
    'yuán',
    'vườn, công viên, khu vườn',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '周末很多家长带着孩子去植物园玩。',
    'Zhōumò hěn duō jiāzhǎng dài zhe háizi qù zhíwùyuán wán.',
    'Cuối tuần nhiều phụ huynh dẫn con cái đến vườn thực vật chơi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '周末很多家长带着孩子去植物园玩。', 'Zhōumò hěn duō jiāzhǎng dài zhe háizi qù zhíwùyuán wán.', 'Cuối tuần nhiều phụ huynh dẫn con cái đến vườn thực vật chơi.', 'basic', 1),
      (v_id, '这座古典江南园林小巧精致，移步换景令人赞叹。', 'Zhè zuò gǔdiǎn Jiāngnán yuánlín xiǎoqiǎo jīngzhì, yíbùhuànjǐng lìng rén zàntàn.', 'Khu vườn cổ điển Giang Nam này nhỏ nhắn tinh xảo, mỗi bước đi cảnh trí lại đổi thay khiến người ta trầm trồ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [员] (yuán) - viên, người làm (nhân viên, thành viên, đoàn viên) [Hậu tố / Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '员',
    'yuán',
    'viên, người làm (nhân viên, thành viên, đoàn viên)',
    'Hậu tố / Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '服务员，请给我们拿一份菜单。',
    'Fúwùyuán, qǐng gěi wǒmen ná yí fèn càidān.',
    'Nhân viên phục vụ ơi, xin mang cho chúng tôi một cuốn thực đơn.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '服务员，请给我们拿一份菜单。', 'Fúwùyuán, qǐng gěi wǒmen ná yí fèn càidān.', 'Nhân viên phục vụ ơi, xin mang cho chúng tôi một cuốn thực đơn.', 'basic', 1),
      (v_id, '作为校足球队的一名正式队员，他每天都刻苦训练。', 'Zuòwéi xiào zúqiúduì de yì míng zhèngshì duìyuán, tā měitiān dōu kèkǔ xùnliàn.', 'Là một thành viên chính thức của đội bóng trường, cậu ấy mỗi ngày đều chăm chỉ tập luyện.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [运动会] (yùndònghuì) - đại hội thể thao, hội thao [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '运动会',
    'yùndònghuì',
    'đại hội thể thao, hội thao',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '下个星期五学校要举办春季运动会。',
    'Xià gè xīngqīwǔ xuéxiào yào jǔbàn chūnjì yùndònghuì.',
    'Thứ sáu tuần sau trường học sẽ tổ chức hội thao mùa xuân.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '下个星期五学校要举办春季运动会。', 'Xià gè xīngqīwǔ xuéxiào yào jǔbàn chūnjì yùndònghuì.', 'Thứ sáu tuần sau trường học sẽ tổ chức hội thao mùa xuân.', 'basic', 1),
      (v_id, '在全校运动会上，我们班的运动员们奋勇拼搏夺得了多项冠军。', 'Zài quán xiào yùndònghuì shang, wǒmen bān de yùndòngyuánmen fènyǒng pīnbó duó dé le duō xiàng guànjūn.', 'Tại hội thao toàn trường, các vận động viên lớp chúng tôi đã thi đấu dũng cảm giành được nhiều giải quán quân.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [运动员] (yùndòngyuán) - vận động viên [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '运动员',
    'yùndòngyuán',
    'vận động viên',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '那位著名的篮球运动员投篮非常准。',
    'Nà wèi zhùmíng de lánqiú yùndòngyuán tóulán fēicháng zhǔn.',
    'Vận động viên bóng rổ nổi tiếng đó ném bóng vào rổ rất chuẩn xác.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '那位著名的篮球运动员投篮非常准。', 'Nà wèi zhùmíng de lánqiú yùndòngyuán tóulán fēicháng zhǔn.', 'Vận động viên bóng rổ nổi tiếng đó ném bóng vào rổ rất chuẩn xác.', 'basic', 1),
      (v_id, '优秀的专业运动员背后付出了常人难以想象的汗水和努力。', 'Yōuxiù de zhuānyè yùndòngyuán bèihòu fùchū le chángrén nányǐ xiǎngxiàng de hànshuǐ hé nǔlì.', 'Phía sau một vận động viên chuyên nghiệp xuất sắc là những giọt mồ hôi và nỗ lực người bình thường khó lòng tưởng tượng được.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [咱们] (zánmen) - chúng mình, chúng ta (bao gồm cả người nói và người nghe) [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '咱们',
    'zánmen',
    'chúng mình, chúng ta (bao gồm cả người nói và người nghe)',
    'Đại từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '时间差不多了，咱们走吧。',
    'Shíjiān chàbuduō le, zánmen zǒu ba.',
    'Thời gian hòm hòm rồi, chúng mình đi thôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '时间差不多了，咱们走吧。', 'Shíjiān chàbuduō le, zánmen zǒu ba.', 'Thời gian hòm hòm rồi, chúng mình đi thôi.', 'basic', 1),
      (v_id, '既然大家意见一致，那咱们就按这个方案开始执行。', 'Jìrán dàjiā yìjiàn yízhì, nà zánmen jiù àn zhè ge fāng’àn kāishǐ zhíxíng.', 'Đã là ý kiến mọi người nhất trí, vậy thì chúng mình cứ theo phương án này mà bắt đầu thực hiện.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [脏] (zāng) - bẩn, bẩn thỉu [Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '脏',
    'zāng',
    'bẩn, bẩn thỉu',
    'Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '手弄脏了，快去洗手池洗洗手。',
    'Shǒu nòng zāng le, kuài qù xǐshǒuchí xǐxishǒu.',
    'Tay bị lấm bẩn rồi, mau đến bồn rửa tay rửa sạch đi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '手弄脏了，快去洗手池洗洗手。', 'Shǒu nòng zāng le, kuài qù xǐshǒuchí xǐxishǒu.', 'Tay bị lấm bẩn rồi, mau đến bồn rửa tay rửa sạch đi.', 'basic', 1),
      (v_id, '踢完足球后他的球衣全沾满了泥土，变得很脏。', 'Tī wán zúqiú hòu tā de qiúyī quán zhān mǎn le nítǔ, biàn de hěn zāng.', 'Sau khi đá bóng xong áo thi đấu của cậu ấy dính đầy bùn đất, trở nên rất bẩn.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [怎么办] (zěnme bàn) - làm sao bây giờ, xử lý thế nào [Cụm từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '怎么办',
    'zěnme bàn',
    'làm sao bây giờ, xử lý thế nào',
    'Cụm từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我的车票找不到了，这可怎么办？',
    'Wǒ de chēpiào zhǎo búdào le, zhè kě zěnme bàn?',
    'Vé tàu của tôi tìm không thấy nữa rồi, chuyện này phải làm sao bây giờ?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我的车票找不到了，这可怎么办？', 'Wǒ de chēpiào zhǎo búdào le, zhè kě zěnme bàn?', 'Vé tàu của tôi tìm không thấy nữa rồi, chuyện này phải làm sao bây giờ?', 'basic', 1),
      (v_id, '遇到突发紧急情况时要保持冷静，想清楚该怎么办再行动。', 'Yù dào tūfā jǐnjí qíngkuàng shí yào bǎochí lěngjìng, xiǎng qīngchu gāi zěnme bàn zài xíngdòng.', 'Khi gặp tình huống khẩn cấp bất ngờ phải giữ bình tĩnh, suy nghĩ rõ ràng cần xử lý thế nào rồi mới hành động.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [怎样] (zěnyàng) - như thế nào, ra sao [Đại từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '怎样',
    'zěnyàng',
    'như thế nào, ra sao',
    'Đại từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请问怎样才能学好汉语发音？',
    'Qǐngwèn zěnyàng cái néng xué hǎo Hànyǔ fāyīn?',
    'Xin hỏi làm thế nào mới có thể học tốt phát âm tiếng Trung?'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请问怎样才能学好汉语发音？', 'Qǐngwèn zěnyàng cái néng xué hǎo Hànyǔ fāyīn?', 'Xin hỏi làm thế nào mới có thể học tốt phát âm tiếng Trung?', 'basic', 1),
      (v_id, '不管未来的路怎样艰难，我们都要坚定地走下去。', 'Bùguǎn wèilái de lù zěnyàng jiānnán, wǒmen dōu yào jiāndìng de zǒu xiàqù.', 'Cho dù con đường tương lai có gian nan thế nào, chúng ta cũng đều phải kiên định bước tiếp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [照] (zhào) - chiếu (sáng), soi (gương), chụp (ảnh); theo như [Động từ / Giới từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '照',
    'zhào',
    'chiếu (sáng), soi (gương), chụp (ảnh); theo như',
    'Động từ / Giới từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '阳光照在河面上，闪闪发光。',
    'Yángguāng zhào zài hémiàn shang, shǎnshǎn fā guāng.',
    'Ánh nắng chiếu trên mặt sông lấp la lấp lánh.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '阳光照在河面上，闪闪发光。', 'Yángguāng zhào zài hémiàn shang, shǎnshǎn fā guāng.', 'Ánh nắng chiếu trên mặt sông lấp la lấp lánh.', 'basic', 1),
      (v_id, '她站在镜子前仔细照了照，整理了一下头发。', 'Tā zhàn zài jìngzi qián zǐxì zhào le zhào, zhěnglǐ le yíxià tóufa.', 'Cô ấy đứng trước gương soi kỹ lưỡng rồi chỉnh trang lại mái tóc một chút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [照相] (zhàoxiàng) - chụp ảnh [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '照相',
    'zhàoxiàng',
    'chụp ảnh',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '大家都站好，我们一起照相留念。',
    'Dàjiā dōu zhàn hǎo, wǒmen yìqǐ zhàoxiàng liúniàn.',
    'Mọi người đều đứng ngay ngắn nhé, chúng mình cùng chụp ảnh làm kỷ niệm.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '大家都站好，我们一起照相留念。', 'Dàjiā dōu zhàn hǎo, wǒmen yìqǐ zhàoxiàng liúniàn.', 'Mọi người đều đứng ngay ngắn nhé, chúng mình cùng chụp ảnh làm kỷ niệm.', 'basic', 1),
      (v_id, '来到著名的长城脚下，游客们都兴奋地拿出手机照相。', 'Lái dào zhùmíng de Chángchéng jiǎoxià, yóukèmen dōu xīngfèn de ná chū shǒujī zhàoxiàng.', 'Đến chân Vạn Lý Trường Thành nổi tiếng, các du khách đều phấn khởi lấy điện thoại chụp ảnh.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [直到] (zhídào) - cho đến khi, mãi đến [Động từ / Giới từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '直到',
    'zhídào',
    'cho đến khi, mãi đến',
    'Động từ / Giới từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他一直在图书馆学习，直到晚上九点才离开。',
    'Tā yìzhí zài túshūguǎn xuéxí, zhídào wǎnshang jiǔ diǎn cái líkāi.',
    'Anh ấy học suốt ở thư viện, mãi đến 9 giờ tối mới rời đi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他一直在图书馆学习，直到晚上九点才离开。', 'Tā yìzhí zài túshūguǎn xuéxí, zhídào wǎnshang jiǔ diǎn cái líkāi.', 'Anh ấy học suốt ở thư viện, mãi đến 9 giờ tối mới rời đi.', 'basic', 1),
      (v_id, '直到听完老师详尽的讲解，他才真正理解了这个语法点。', 'Zhídào tīng wán lǎoshī xiángjìn de jiǎngjiě, tā cái zhēnzhèng lǐjiě le zhè ge yǔfǎdiǎn.', 'Mãi đến khi nghe xong lời giảng giải cặn kẽ của thầy giáo, cậu ấy mới thực sự hiểu được điểm ngữ pháp này.', 'applied', 2);
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
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我只有五分钟的时间，请快一点儿。',
    'Wǒ zhǐ yǒu wǔ fēnzhōng de shíjiān, qǐng kuài yìdiǎnr.',
    'Tôi chỉ có 5 phút thời gian thôi, xin hãy nhanh một chút.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我只有五分钟的时间，请快一点儿。', 'Wǒ zhǐ yǒu wǔ fēnzhōng de shíjiān, qǐng kuài yìdiǎnr.', 'Tôi chỉ có 5 phút thời gian thôi, xin hãy nhanh một chút.', 'basic', 1),
      (v_id, '成功不仅需要天赋，更需要脚踏实地只争朝夕的拼搏精神。', 'Chénggōng bùjǐn xūyào tiānfù, gèng xūyào jiǎotàshídì zhǐzhēngzhāoxī de pīnbó jīngshén.', 'Thành công không chỉ cần năng khiếu mà càng cần tinh thần nỗ lực bền bỉ không lãng phí từng ngày.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [纸] (zhǐ) - giấy, tờ giấy [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '纸',
    'zhǐ',
    'giấy, tờ giấy',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '请递给我一张白纸和一支笔。',
    'Qǐng dì gěi wǒ yì zhāng bái zhǐ hé yì zhī bǐ.',
    'Làm ơn đưa cho tôi một tờ giấy trắng và một cây bút.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '请递给我一张白纸和一支笔。', 'Qǐng dì gěi wǒ yì zhāng bái zhǐ hé yì zhī bǐ.', 'Làm ơn đưa cho tôi một tờ giấy trắng và một cây bút.', 'basic', 1),
      (v_id, '节约用纸就是保护森林树木，大家都应该从小事做起。', 'Jiéyuē yòng zhǐ jiù shì bǎohù sēnlín shùmù, dàjiā dōu yīnggāi cóng xiǎoshì zuò qǐ.', 'Tiết kiệm giấy chính là bảo vệ rừng cây, mọi người đều nên bắt đầu từ việc nhỏ.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [只能] (zhǐ néng) - chỉ có thể [Cụm từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '只能',
    'zhǐ néng',
    'chỉ có thể',
    'Cụm từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '下大雨了，我们今天只能待在家里。',
    'Xià dà yǔ le, wǒmen jīntiān zhǐ néng dāi zài jiālǐ.',
    'Trời mưa to rồi, hôm nay chúng ta chỉ có thể ở trong nhà.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '下大雨了，我们今天只能待在家里。', 'Xià dà yǔ le, wǒmen jīntiān zhǐ néng dāi zài jiālǐ.', 'Trời mưa to rồi, hôm nay chúng ta chỉ có thể ở trong nhà.', 'basic', 1),
      (v_id, '末班车已经开走了，我们现在只能打出租车回宿舍了。', 'Mòbānchē yǐjīng kāi zǒu le, wǒmen xiànzài zhǐ néng dǎ chūzūchē huí sùshè le.', 'Chuyến xe buýt cuối cùng chạy đi mất rồi, chúng ta bây giờ chỉ có thể bắt taxi về ký túc xá thôi.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [只是] (zhǐshì) - chỉ là, chẳng qua là, có điều [Phó từ / Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '只是',
    'zhǐshì',
    'chỉ là, chẳng qua là, có điều',
    'Phó từ / Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '我并没有生气，只是有点儿累了。',
    'Wǒ bìng méiyǒu shēngqì, zhǐshì yǒudiǎnr lèi le.',
    'Tôi không hề tức giận đâu, chỉ là có chút mệt thôi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '我并没有生气，只是有点儿累了。', 'Wǒ bìng méiyǒu shēngqì, zhǐshì yǒudiǎnr lèi le.', 'Tôi không hề tức giận đâu, chỉ là có chút mệt thôi.', 'basic', 1),
      (v_id, '这套房子什么都挺好，只是离上班的地方稍微远了一点儿。', 'Zhè tào fángzi shénme dōu tǐng hǎo, zhǐshì lí shàngbān de dìfang shāowēi yuǎn le yìdiǎnr.', 'Căn nhà này cái gì cũng khá tốt, có điều là cách chỗ đi làm hơi xa một chút.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [只要] (zhǐyào) - chỉ cần (đi với 就) [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '只要',
    'zhǐyào',
    'chỉ cần (đi với 就)',
    'Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '只要努力学习，就一定能通过考试。',
    'Zhǐyào nǔlì xuéxí, jiù yídìng néng tōngguò kǎoshì.',
    'Chỉ cần chăm chỉ học tập thì nhất định có thể vượt qua kỳ thi.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '只要努力学习，就一定能通过考试。', 'Zhǐyào nǔlì xuéxí, jiù yídìng néng tōngguò kǎoshì.', 'Chỉ cần chăm chỉ học tập thì nhất định có thể vượt qua kỳ thi.', 'basic', 1),
      (v_id, '只要人人都献出一份爱心，世界就会变得更加美好温暖。', 'Zhǐyào rénrén dōu xiànchū yí fèn àixīn, shìjiè jiù huì biàn de gèngjiā měihǎo wēnnuǎn.', 'Chỉ cần mỗi người đều góp một tấm lòng yêu thương, thế giới sẽ trở nên tươi đẹp và ấm áp hơn nhiều.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [只有] (zhǐyǒu) - chỉ có (đi với 才) [Liên từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '只有',
    'zhǐyǒu',
    'chỉ có (đi với 才)',
    'Liên từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '只有坚持锻炼，身体才能保持健康。',
    'Zhǐyǒu jiānchí duànliàn, shēntǐ cái néng bǎochí jiànkāng.',
    'Chỉ có kiên trì rèn luyện, cơ thể mới có thể giữ gìn sức khỏe.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '只有坚持锻炼，身体才能保持健康。', 'Zhǐyǒu jiānchí duànliàn, shēntǐ cái néng bǎochí jiànkāng.', 'Chỉ có kiên trì rèn luyện, cơ thể mới có thể giữ gìn sức khỏe.', 'basic', 1),
      (v_id, '只有亲身经历过挫折，才能真正体会到成功的来之不易。', 'Zhǐyǒu qīnshēn jīnglì guò cuòzhé, cái néng zhēnzhèng tǐhuì dào chénggōng de lái zhī bù yì.', 'Chỉ khi đích thân trải qua trắc trở, mới có thể thực sự thấu hiểu thành công có được chẳng hề dễ dàng.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [中] (zhōng) - ở giữa, bên trong, đang lúc [Danh từ / Giới từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '中',
    'zhōng',
    'ở giữa, bên trong, đang lúc',
    'Danh từ / Giới từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '会议正在进行中，请保持安静。',
    'Huìyì zhèngzài jìnxíng zhōng, qǐng bǎochí ānjìng.',
    'Cuộc họp đang trong tiến trình diễn ra, xin hãy giữ trật tự.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '会议正在进行中，请保持安静。', 'Huìyì zhèngzài jìnxíng zhōng, qǐng bǎochí ānjìng.', 'Cuộc họp đang trong tiến trình diễn ra, xin hãy giữ trật tự.', 'basic', 1),
      (v_id, '在这次汉字书写比赛中，许多留学生展现了出色的水平。', 'Zài zhè cì Hànzì shūxiě bǐsài zhōng, xǔduō liúxuéshēng zhǎnxiàn le chūsè de shuǐpíng.', 'Trong cuộc thi viết chữ Hán lần này, nhiều du học sinh đã thể hiện trình độ xuất sắc.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [住院] (zhùyuàn) - nằm viện, nhập viện [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '住院',
    'zhùyuàn',
    'nằm viện, nhập viện',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '爷爷生病住院了，我们今天去医院探望他。',
    'Yéye shēngbìng zhùyuàn le, wǒmen jīntiān qù yīyuàn tànwàng tā.',
    'Ông nội bị ốm phải nằm viện rồi, hôm nay chúng tôi đến bệnh viện thăm ông.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '爷爷生病住院了，我们今天去医院探望他。', 'Yéye shēngbìng zhùyuàn le, wǒmen jīntiān qù yīyuàn tànwàng tā.', 'Ông nội bị ốm phải nằm viện rồi, hôm nay chúng tôi đến bệnh viện thăm ông.', 'basic', 1),
      (v_id, '经过一周的住院治疗，病人的身体各项指标已经基本恢复正常。', 'Jīngguò yì zhōu de zhùyuàn zhìliáo, bìngrén de shēntǐ gè xiàng zhǐbiāo yǐjīng jīběn huīfù zhèngcháng.', 'Qua một tuần điều trị nằm viện, các chỉ số cơ thể của bệnh nhân đã cơ bản hồi phục bình thường.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [字典] (zìdiǎn) - từ điển chữ Hán [Danh từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '字典',
    'zìdiǎn',
    'từ điển chữ Hán',
    'Danh từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '遇到不会读的汉字可以查查这本字典。',
    'Yù dào bú huì dú de Hànzì kěyǐ chácha zhè běn zìdiǎn.',
    'Gặp chữ Hán không biết đọc có thể tra cuốn từ điển này.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '遇到不会读的汉字可以查查这本字典。', 'Yù dào bú huì dú de Hànzì kěyǐ chácha zhè běn zìdiǎn.', 'Gặp chữ Hán không biết đọc có thể tra cuốn từ điển này.', 'basic', 1),
      (v_id, '这本新华字典是初学汉语者必不可少的实用工具书。', 'Zhè běn Xīnhuá Zìdiǎn shì chūxué Hànyǔ zhě bì bù kě shǎo de shíyòng gōngjùshū.', 'Cuốn Tân Hoa Từ Điển này là sách công cụ thiết thực không thể thiếu của người mới học tiếng Trung.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [子] (zi) - cái, con (hậu tố tạo danh từ như 桌子, 椅子, 杯子) [Hậu tố]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '子',
    'zi',
    'cái, con (hậu tố tạo danh từ như 桌子, 椅子, 杯子)',
    'Hậu tố',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '房间里摆着一张桌子和两把椅子。',
    'Fángjiān lǐ bǎi zài yì zhāng zhuōzi hé liǎng bǎ yǐzi.',
    'Trong phòng bày một chiếc bàn và hai chiếc ghế.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '房间里摆着一张桌子和两把椅子。', 'Fángjiān lǐ bǎi zài yì zhāng zhuōzi hé liǎng bǎ yǐzi.', 'Trong phòng bày một chiếc bàn và hai chiếc ghế.', 'basic', 1),
      (v_id, '汉语中很多常见名词后面都带有“子”这个词尾后缀。', 'Hànyǔ zhōng hěn duō chángjiàn míngcí hòumiàn dōu dài yǒu “zi” zhè ge cíwěi hòuzhuì.', 'Trong tiếng Trung rất nhiều danh từ thường gặp phía sau đều có hậu tố đuôi từ "tử" (zi).', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [总] (zǒng) - luôn luôn, tổng cộng, tóm lại [Phó từ / Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '总',
    'zǒng',
    'luôn luôn, tổng cộng, tóm lại',
    'Phó từ / Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '他总是热心地帮助身边的每一个人。',
    'Tā zǒngshì rèxīn de bāngzhù shēnbiān de měi yí gè rén.',
    'Anh ấy lúc nào cũng nhiệt tình giúp đỡ từng người xung quanh.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '他总是热心地帮助身边的每一个人。', 'Tā zǒngshì rèxīn de bāngzhù shēnbiān de měi yí gè rén.', 'Anh ấy lúc nào cũng nhiệt tình giúp đỡ từng người xung quanh.', 'basic', 1),
      (v_id, '无论遇到多么大的困难，总会有办法顺利解决的。', 'Wúlùn yù dào duōme dà de kùnnan, zǒng huì yǒu bànfǎ shùnlì jiějué de.', 'Dù cho gặp phải khó khăn lớn thế nào, tóm lại vẫn sẽ có cách giải quyết êm đẹp.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [最好] (zuìhǎo) - tốt nhất, tốt hơn hết là [Phó từ / Tính từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '最好',
    'zuìhǎo',
    'tốt nhất, tốt hơn hết là',
    'Phó từ / Tính từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '明天可能下雨，你出门最好带一把雨伞。',
    'Míngtiān kěnéng xiàyǔ, nǐ chūmén zuìhǎo dài yì bǎ yǔsǎn.',
    'Ngày mai có thể mưa, bạn ra ngoài tốt nhất nên mang theo một chiếc ô.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '明天可能下雨，你出门最好带一把雨伞。', 'Míngtiān kěnéng xiàyǔ, nǐ chūmén zuìhǎo dài yì bǎ yǔsǎn.', 'Ngày mai có thể mưa, bạn ra ngoài tốt nhất nên mang theo một chiếc ô.', 'basic', 1),
      (v_id, '养成按时作息的良好习惯是保持身体健康的最好方式。', 'Yǎngchéng ànshí zuòxī de liánghǎo xíguàn shì bǎochí shēntǐ jiànkāng de zuìhǎo fāngshì.', 'Rèn luyện thói quen sinh hoạt đúng giờ là phương thức tốt nhất để giữ gìn sức khỏe cơ thể.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  -- [做客] (zuòkè) - làm khách, đến chơi nhà [Động từ]
  INSERT INTO public.vocabularies (
    hanzi, pinyin, meaning_vi, word_type, hsk_level, hsk_level_v3, hsk_version,
    example_hanzi, example_pinyin, example_vi
  )
  VALUES (
    '做客',
    'zuòkè',
    'làm khách, đến chơi nhà',
    'Động từ',
    'HSK 3',
    'HSK 3',
    'hsk3.0',
    '这个周末欢迎你来我们家里做客。',
    'Zhè ge zhōumò huānyíng nǐ lái wǒmen jiālǐ zuòkè.',
    'Cuối tuần này hoan nghênh bạn đến nhà chúng tôi chơi nhé.'
  )
  ON CONFLICT (hanzi, pinyin, hsk_level) DO UPDATE SET
    meaning_vi = EXCLUDED.meaning_vi,
    word_type = EXCLUDED.word_type,
    hsk_level_v3 = 'HSK 3',
    hsk_version = 'hsk3.0',
    example_hanzi = EXCLUDED.example_hanzi,
    example_pinyin = EXCLUDED.example_pinyin,
    example_vi = EXCLUDED.example_vi
  RETURNING id INTO v_id;

  -- Nạp 2 câu ví dụ chất lượng cao vào bảng vocabulary_examples
  IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'vocabulary_examples') THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;
    
    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES 
      (v_id, '这个周末欢迎你来我们家里做客。', 'Zhè ge zhōumò huānyíng nǐ lái wǒmen jiālǐ zuòkè.', 'Cuối tuần này hoan nghênh bạn đến nhà chúng tôi chơi nhé.', 'basic', 1),
      (v_id, '去中国朋友家做客时，通常可以带一点儿新鲜水果或点心作为礼物。', 'Qù Zhōngguó péngyou jiā zuòkè shí, tōngcháng kěyǐ dài yìdiǎnr xīnxiān shuǐguǒ huò diǎnxin zuòwéi lǐwù.', 'Khi đến nhà bạn người Trung Quốc làm khách, thông thường có thể mang theo một ít hoa quả tươi hoặc bánh ngọt làm quà.', 'applied', 2);
  END IF;

  v_count := v_count + 1;

  RAISE NOTICE 'Dọn dẹp thành công % bản ghi trùng thừa từ HSK 1/2.', v_deleted_count;
  RAISE NOTICE 'Điều chuyển an toàn % từ HSK cũ sang HSK 4.', v_shifted_count;
  RAISE NOTICE 'Bổ sung và nạp thành công % từ vựng HSK 3 mới cùng 510 câu ví dụ chuẩn!', v_count;
END $$;
