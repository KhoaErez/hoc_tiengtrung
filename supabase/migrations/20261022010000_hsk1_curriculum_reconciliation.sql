-- ====================================================================
-- MIGRATION: ĐỒNG BỘ TOÀN DIỆN LỘ TRÌNH 18 BÀI HỌC HSK 1 (300 TỪ CHUẨN HSK 3.0)
-- 1. Khôi phục 3 mục từ HSK 1 bị ghi đè: [好] (hǎo), [看] (kàn), [喂] (wéi)
-- 2. Cập nhật 11 bài học hiện có + thêm 7 bài học mới (Tổng 18 bài học)
-- 3. Liên kết toàn bộ 300 từ vựng HSK 1 vào bài học qua lesson_vocabularies
-- Tuyệt đối bảo toàn 100% tiến độ người dùng trong user_vocabularies!
-- ====================================================================

DO $$
DECLARE
  v_id uuid;
BEGIN
  -- ------------------------------------------------------------------
  -- BƯỚC 1: KHÔI PHỤC VÀ ĐỒNG BỘ 3 MỤC TỪ HSK 1 [好], [看], [喂]
  -- ------------------------------------------------------------------

  -- [好] (hǎo) - tốt, đẹp, hay [Tính từ]
  IF NOT EXISTS (SELECT 1 FROM public.vocabularies WHERE hanzi = '好' AND pinyin = 'hǎo') THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi)
    VALUES ('好', 'hǎo', 'tốt, đẹp, hay, khỏe', 'Tính từ', 'HSK 1', '今天天气很好。', 'Jīntiān tiānqì hěn hǎo.', 'Hôm nay thời tiết rất đẹp.')
    RETURNING id INTO v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天天气很好。', 'Jīntiān tiānqì hěn hǎo.', 'Hôm nay thời tiết rất đẹp.', 'basic', 1),
      (v_id, '多吃新鲜水果对身体非常好。', 'Duō chī xīnxiān shuǐguǒ duì shēntǐ fēicháng hǎo.', 'Ăn nhiều hoa quả tươi rất tốt cho sức khỏe.', 'applied', 2);
  END IF;

  -- [看] (kàn) - nhìn, xem, đọc [Động từ]
  IF NOT EXISTS (SELECT 1 FROM public.vocabularies WHERE hanzi = '看' AND pinyin = 'kàn') THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi)
    VALUES ('看', 'kàn', 'nhìn, xem, đọc, trông', 'Động từ', 'HSK 1', '我喜欢在家看书。', 'Wǒ xǐhuan zài jiā kàn shū.', 'Tôi thích ở nhà đọc sách.')
    RETURNING id INTO v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我喜欢在家看书。', 'Wǒ xǐhuan zài jiā kàn shū.', 'Tôi thích ở nhà đọc sách.', 'basic', 1),
      (v_id, '周末我和朋友一起去电影院看新电影。', 'Zhōumò wǒ hé péngyou yìqǐ qù diànyǐngyuàn kàn xīn diànyǐng.', 'Cuối tuần tôi cùng bạn đi rạp chiếu phim xem phim mới.', 'applied', 2);
  END IF;

  -- [喂] (wéi) - alo, này [Thán từ]
  IF NOT EXISTS (SELECT 1 FROM public.vocabularies WHERE hanzi = '喂' AND pinyin = 'wéi') THEN
    INSERT INTO public.vocabularies (hanzi, pinyin, meaning_vi, word_type, hsk_level, example_hanzi, example_pinyin, example_vi)
    VALUES ('喂', 'wéi', 'alo, này (thán từ chào hỏi qua điện thoại)', 'Thán từ', 'HSK 1', '喂，请问张老师在吗？', 'Wéi, qǐngwèn Zhāng lǎoshī zài ma?', 'Alo, xin hỏi thầy Trương có ở đó không ạ?')
    RETURNING id INTO v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '喂，请问张老师在吗？', 'Wéi, qǐngwèn Zhāng lǎoshī zài ma?', 'Alo, xin hỏi thầy Trương có ở đó không ạ?', 'basic', 1),
      (v_id, '喂，李华，你现在在哪里呢？', 'Wéi, Lǐ Huá, nǐ xiànzài zài nǎlǐ ne?', 'Alo, Lý Hoa, bây giờ bạn đang ở đâu thế?', 'applied', 2);
  END IF;

  -- ------------------------------------------------------------------
  -- BƯỚC 2: CẬP NHẬT HOẶC CHÈN 18 BÀI HỌC HSK 1 VÀO PUBLIC.LESSONS
  -- ------------------------------------------------------------------

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('50e8242c-c6d2-40ba-b06c-0f64d83cbb08', 'Bài 1 - Xin chào và Xưng hô', 'Các mẫu câu chào hỏi, xưng hô lịch sự và giới thiệu tên cơ bản.', 'HSK 1', 1, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('dca2dd56-3813-4e89-aca8-53f216e32dd4', 'Bài 2 - Gia đình và Mối quan hệ', 'Nói về các thành viên trong gia đình, người thân và mối quan hệ bạn bè.', 'HSK 1', 2, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('7ae67e7b-d6e3-48ac-8167-0fd5caf4f596', 'Bài 3 - Chữ số và Lượng từ', 'Chữ số cơ bản từ 0 đến hàng ngàn cùng các lượng từ thông dụng.', 'HSK 1', 3, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('84dc955a-70c3-44d7-a669-c31daf2c622e', 'Bài 4 - Thời gian và Lịch trình', 'Cách diễn đạt giờ phút, các buổi trong ngày, thứ ngày tháng năm.', 'HSK 1', 4, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('15f0321b-860c-4d3d-9bd2-2fe0b30cce6b', 'Bài 5 - Trường học và Học tập', 'Từ vựng về trường lớp, thầy cô, bạn bè và kỹ năng học tiếng Trung.', 'HSK 1', 5, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('b8987ddc-b03b-4b50-a58b-21c536eaf4c3', 'Bài 6 - Mua sắm và Giá cả', 'Hỏi giá cả, mua bán đồ dùng cá nhân, siêu thị và thanh toán.', 'HSK 1', 6, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('3ea59185-76c9-4b6b-8937-4db233831a05', 'Bài 7 - Ẩm thực và Bữa ăn', 'Tên các món ăn, đồ uống phổ biến và thói quen ăn uống thường nhật.', 'HSK 1', 7, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('344b0aa4-e686-44c8-969a-7304fa0b93ef', 'Bài 8 - Phương hướng và Vị trí', 'Phương hướng, vị trí đồ vật trong nhà và các địa điểm quen thuộc.', 'HSK 1', 8, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('9f0805d0-b91d-44e1-8ff2-1248b16b9346', 'Bài 9 - Giao thông và Đi lại', 'Phương tiện giao thông, cách thức di chuyển và địa điểm thành phố.', 'HSK 1', 9, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('d23fb015-f289-4eb8-ba8e-f93f56e8fb23', 'Bài 10 - Giao tiếp hàng ngày', 'Lời cảm ơn, xin lỗi, nhìn nghe giao tiếp và các hành động quen thuộc.', 'HSK 1', 10, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('c2d7894d-9fcd-47ee-a6cf-04ef736902a0', 'Bài 11 - Thời tiết và Thiên nhiên', 'Mô tả thời tiết, mưa tuyết, màu sắc và cảm nhận thẩm mỹ.', 'HSK 1', 11, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('1a2b3c4d-0001-4000-8000-000000000012', 'Bài 12 - Sức khỏe và Thăm khám', 'Trạng thái cơ thể, khám bệnh, cảm giác và chăm sóc sức khỏe.', 'HSK 1', 12, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('1a2b3c4d-0001-4000-8000-000000000013', 'Bài 13 - Sinh hoạt và Nếp sống', 'Thức dậy, ngủ nghỉ, các bữa ăn và thời gian biểu sinh hoạt.', 'HSK 1', 13, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('1a2b3c4d-0001-4000-8000-000000000014', 'Bài 14 - Nghề nghiệp và Nơi làm việc', 'Công việc, công ty, thiết bị và đời sống thường nhật.', 'HSK 1', 14, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('1a2b3c4d-0001-4000-8000-000000000015', 'Bài 15 - Sở thích và Hoạt động', 'Ca hát, viết lách, chăm sóc thú cưng và đại từ nhân xưng số nhiều.', 'HSK 1', 15, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('1a2b3c4d-0001-4000-8000-000000000016', 'Bài 16 - Đại từ chỉ định và Lựa chọn', 'Các đại từ chỉ định này - kia, đây - đó và diễn đạt số lượng phiếm chỉ.', 'HSK 1', 16, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('1a2b3c4d-0001-4000-8000-000000000017', 'Bài 17 - Số lượng và Mức độ', 'Diễn tả số lượng ước chừng, mức độ tăng tiến và các phó từ chỉ mức độ.', 'HSK 1', 17, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  INSERT INTO public.lessons (id, title, subtitle, hsk_level, lesson_number, is_system)
  VALUES ('1a2b3c4d-0001-4000-8000-000000000018', 'Bài 18 - Phó từ, Liên từ và Trợ từ ngữ pháp', 'Năng lực, khả năng, sự tiếp diễn và các trợ từ ngữ khí căn bản HSK 1.', 'HSK 1', 18, true)
  ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    subtitle = EXCLUDED.subtitle,
    hsk_level = EXCLUDED.hsk_level,
    lesson_number = EXCLUDED.lesson_number,
    is_system = EXCLUDED.is_system,
    updated_at = now();

  -- ------------------------------------------------------------------
  -- BƯỚC 3: DỌN DẸP VÀ TÁI LIÊN KẾT BẢNG NỐI LESSON_VOCABULARIES
  -- ------------------------------------------------------------------
  DELETE FROM public.lesson_vocabularies
  WHERE lesson_id IN ('50e8242c-c6d2-40ba-b06c-0f64d83cbb08', 'dca2dd56-3813-4e89-aca8-53f216e32dd4', '7ae67e7b-d6e3-48ac-8167-0fd5caf4f596', '84dc955a-70c3-44d7-a669-c31daf2c622e', '15f0321b-860c-4d3d-9bd2-2fe0b30cce6b', 'b8987ddc-b03b-4b50-a58b-21c536eaf4c3', '3ea59185-76c9-4b6b-8937-4db233831a05', '344b0aa4-e686-44c8-969a-7304fa0b93ef', '9f0805d0-b91d-44e1-8ff2-1248b16b9346', 'd23fb015-f289-4eb8-ba8e-f93f56e8fb23', 'c2d7894d-9fcd-47ee-a6cf-04ef736902a0', '1a2b3c4d-0001-4000-8000-000000000012', '1a2b3c4d-0001-4000-8000-000000000013', '1a2b3c4d-0001-4000-8000-000000000014', '1a2b3c4d-0001-4000-8000-000000000015', '1a2b3c4d-0001-4000-8000-000000000016', '1a2b3c4d-0001-4000-8000-000000000017', '1a2b3c4d-0001-4000-8000-000000000018');

  -- Bài 1 - Xin chào và Xưng hô (16 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '50e8242c-c6d2-40ba-b06c-0f64d83cbb08',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('你', '好', '我', '叫', '名字', '认识', '高兴', '是', '先生', '女士', '谁', '什么', '吗', '呢', '您', '你好');

  -- Bài 2 - Gia đình và Mối quan hệ (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'dca2dd56-3813-4e89-aca8-53f216e32dd4',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('他', '她', '我们', '人', '家', '家人', '爸爸', '妈妈', '哥哥', '姐姐', '弟弟', '妹妹', '儿子', '女儿', '孩子', '朋友', '大家', '岁');

  -- Bài 3 - Chữ số và Lượng từ (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '7ae67e7b-d6e3-48ac-8167-0fd5caf4f596',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '百', '千', '两', '零', '个', '几', '口', '第');

  -- Bài 4 - Thời gian và Lịch trình (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '84dc955a-70c3-44d7-a669-c31daf2c622e',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('年', '月', '号', '日', '星期', '星期天', '星期日', '今天', '明天', '昨天', '今年', '明年', '去年', '现在', '点', '分', '分钟', '时候');

  -- Bài 5 - Trường học và Học tập (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '15f0321b-860c-4d3d-9bd2-2fe0b30cce6b',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('学校', '老师', '学生', '同学', '小学', '小学生', '中学', '中学生', '大学', '大学生', '中文', '汉语', '字', '汉字', '学习', '学', '书', '读书');

  -- Bài 6 - Mua sắm và Giá cả (16 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'b8987ddc-b03b-4b50-a58b-21c536eaf4c3',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('买', '卖', '钱', '元', '多少', '贵', '便宜', '东西', '店', '超市', '书店', '衣服', '件', '杯子', '电脑', '找');

  -- Bài 7 - Ẩm thực và Bữa ăn (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '3ea59185-76c9-4b6b-8937-4db233831a05',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('吃', '喝', '茶', '水', '饭', '菜', '米饭', '面条儿', '包子', '饺子', '面包', '鸡蛋', '苹果', '水果', '牛奶', '好吃', '饭店', '做饭');

  -- Bài 8 - Phương hướng và Vị trí (15 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '344b0aa4-e686-44c8-969a-7304fa0b93ef',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('在', '上', '下', '前', '后', '里', '外', '外边', '边', '桌子', '椅子', '房间', '这里', '那里', '哪里');

  -- Bài 9 - Giao thông và Đi lại (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '9f0805d0-b91d-44e1-8ff2-1248b16b9346',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('去', '来', '回', '到', '坐', '开', '开车', '车', '出租车', '飞机', '火车', '怎么', '怎么样', '住', '中国', '北京', '国');

  -- Bài 10 - Giao tiếp hàng ngày (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'd23fb015-f289-4eb8-ba8e-f93f56e8fb23',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('谢谢', '不客气', '对不起', '没关系', '没事', '再见', '请', '请问', '问', '问题', '对', '看', '看见', '听', '听见', '说', '读', '见');

  -- Bài 11 - Thời tiết và Thiên nhiên (16 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    'c2d7894d-9fcd-47ee-a6cf-04ef736902a0',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('天气', '下雨', '雨', '雪', '天', '冷', '热', '大', '小', '新', '漂亮', '好看', '好玩儿', '好听', '爱', '喜欢');

  -- Bài 12 - Sức khỏe và Thăm khám (13 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0001-4000-8000-000000000012',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('生病', '病', '看病', '医生', '医院', '休息', '穿', '觉得', '知道', '想', '要', '不要', '忙');

  -- Bài 13 - Sinh hoạt và Nếp sống (18 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0001-4000-8000-000000000013',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('起床', '睡', '睡觉', '上午', '早上', '早', '早饭', '白天', '中午', '午饭', '下午', '晚上', '晚', '晚饭', '小时', '时间', '上班', '下班');

  -- Bài 14 - Nghề nghiệp và Nơi làm việc (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0001-4000-8000-000000000014',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('工作', '公司', '事', '男', '女', '女朋友', '男朋友', '小朋友', '商店', '电影院', '电影', '电视', '手机', '电话', '打电话', '做', '玩');

  -- Bài 15 - Sở thích và Hoạt động (17 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0001-4000-8000-000000000015',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('唱', '歌', '写', '说话', '上学', '上课', '下课', '课', '狗', '猫', '它', '它们', '他们', '她们', '你们', '们', '些');

  -- Bài 16 - Đại từ chỉ định và Lựa chọn (16 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0001-4000-8000-000000000016',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('这', '这儿', '这个', '这些', '这边', '那', '那儿', '那个', '那些', '那边', '哪', '哪儿', '哪个', '哪些', '有的', '有些');

  -- Bài 17 - Số lượng và Mức độ (15 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0001-4000-8000-000000000017',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('多', '少', '半', '一半', '一点儿', '有点儿', '一下', '一些', '块', '很', '太', '真', '非常', '只', '也');

  -- Bài 18 - Phó từ, Liên từ và Trợ từ ngữ pháp (16 từ)
  INSERT INTO public.lesson_vocabularies (lesson_id, vocabulary_id, sort_order, is_selected)
  SELECT 
    '1a2b3c4d-0001-4000-8000-000000000018',
    v.id,
    row_number() OVER (ORDER BY v.pinyin ASC),
    true
  FROM public.vocabularies v
  WHERE v.hsk_level = 'HSK 1' AND v.hanzi IN ('不', '没有', '有', '能', '会', '可以', '给', '和', '都', '还', '再', '正在', '了', '的', '吧', '喂');

  RAISE NOTICE 'Hoàn tất đồng bộ 18 bài học HSK 1 với 300 từ vựng chuẩn HSK 3.0!';
END $$;
