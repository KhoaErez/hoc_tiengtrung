-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 6 (100 TỪ TIẾP THEO)
-- Phạm vi: #2502 [环节] (huánjié) -> #2601 [结构] (jiégòu)
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
  -- [2502] [环节] (huánjié) - khâu, mắt xích, phân đoạn (trong quy trình) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '环节' AND pinyin = 'huánjié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '环节' AND pinyin = 'huánjié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '环节'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '环节'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huánjié',
      meaning_vi = 'khâu, mắt xích, phân đoạn (trong quy trình)',
      example_hanzi = '质量检验是整个生产流程中最关键的一个环节。',
      example_pinyin = 'Zhìliàng jiǎnyàn shì zhěnggè shēngchǎn liúchéng zhōng zuì guānjiàn de yí gè huánjié.',
      example_vi = 'Kiểm tra chất lượng là một trong những mắt xích then chốt nhất trong toàn bộ quy trình sản xuất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '环节',
      'huánjié',
      'khâu, mắt xích, phân đoạn (trong quy trình)',
      'Danh từ',
      'HSK 5',
      '质量检验是整个生产流程中最关键的一个环节。',
      'Zhìliàng jiǎnyàn shì zhěnggè shēngchǎn liúchéng zhōng zuì guānjiàn de yí gè huánjié.',
      'Kiểm tra chất lượng là một trong những mắt xích then chốt nhất trong toàn bộ quy trình sản xuất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '质量检验是整个生产流程中最关键的一个环节。', 'Zhìliàng jiǎnyàn shì zhěnggè shēngchǎn liúchéng zhōng zuì guānjiàn de yí gè huánjié.', 'Kiểm tra chất lượng là một trong những mắt xích then chốt nhất trong toàn bộ quy trình sản xuất.', 'basic', 1),
      (v_id, '企业必须全面优化供应链上的每一个物流环节，才能有效压缩运营成本并提升客户履约满意度。', 'Qǐyè bìxū quánmiàn yōuhuà gōngyìngliàn shang de měi yí gè wùliú huánjié, cáinéng yǒuxiào yāsuō yùnyíng chéngběn bìng tíshēng kèhù lǚyuē mǎnyìdù.', 'Doanh nghiệp cần phải tối ưu hóa toàn diện từng khâu hậu cần trong chuỗi cung ứng thì mới có thể cắt giảm chi phí vận hành hiệu quả và nâng cao mức độ hài lòng về thực hiện đơn hàng cho khách.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2503] [缓解] (huǎnjiě) - xoa dịu, giảm nhẹ, giải tỏa (căng thẳng, cơn đau, khủng hoảng) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '缓解' AND pinyin = 'huǎnjiě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缓解' AND pinyin = 'huǎnjiě'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '缓解'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缓解'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'huǎnjiě',
      meaning_vi = 'xoa dịu, giảm nhẹ, giải tỏa (căng thẳng, cơn đau, khủng hoảng)',
      example_hanzi = '散步和听轻音乐有助于缓解工作一天带来的疲劳。',
      example_pinyin = 'Sànbù hé tīng qīngyīnyuè yǒuzhùyú huǎnjiě gōngzuò yì tiān dàilái de píláo.',
      example_vi = 'Đi dạo và nghe nhạc nhẹ giúp xoa dịu cảm giác mệt mỏi sau một ngày làm việc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '缓解',
      'huǎnjiě',
      'xoa dịu, giảm nhẹ, giải tỏa (căng thẳng, cơn đau, khủng hoảng)',
      'Động từ',
      'HSK 5',
      '散步和听轻音乐有助于缓解工作一天带来的疲劳。',
      'Sànbù hé tīng qīngyīnyuè yǒuzhùyú huǎnjiě gōngzuò yì tiān dàilái de píláo.',
      'Đi dạo và nghe nhạc nhẹ giúp xoa dịu cảm giác mệt mỏi sau một ngày làm việc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '散步和听轻音乐有助于缓解工作一天带来的疲劳。', 'Sànbù hé tīng qīngyīnyuè yǒuzhùyú huǎnjiě gōngzuò yì tiān dàilái de píláo.', 'Đi dạo và nghe nhạc nhẹ giúp xoa dịu cảm giác mệt mỏi sau một ngày làm việc.', 'basic', 1),
      (v_id, '央行通过降准降息等货币政策工具向市场注入流动性，以此缓解实体企业面临的融资困难。', 'Yāngháng tōngguò jiàngzhǔn jiàngxī děng huòbì zhèngcè gōngjù xiàng shìchǎng zhùrù liúdòngxìng, yǐcǐ huǎnjiě shítǐ qǐyè miànlín de róngzī kùnnán.', 'Ngân hàng Trung ương thông qua các công cụ chính sách tiền tệ như giảm tỷ lệ dự trữ bắt buộc và giảm lãi suất để bơm thanh khoản vào thị trường, qua đó xoa dịu những khó khăn tài chính mà các doanh nghiệp sản xuất kinh doanh gặp phải.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2504] [缓慢] (huǎnmàn) - chậm chạp, từ từ, chậm rãi [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '缓慢' AND pinyin = 'huǎnmàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缓慢' AND pinyin = 'huǎnmàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '缓慢'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '缓慢'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'huǎnmàn',
      meaning_vi = 'chậm chạp, từ từ, chậm rãi',
      example_hanzi = '爷爷由于上了年纪，走起路来脚步有些缓慢。',
      example_pinyin = 'Yéye yóuyú shàng le niánjì, zǒu qǐ lù lai jiǎobù yǒuxiē huǎnmàn.',
      example_vi = 'Do tuổi cao nên bước chân đi lại của ông có phần chậm rãi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '缓慢',
      'huǎnmàn',
      'chậm chạp, từ từ, chậm rãi',
      'Tính từ',
      'HSK 5',
      '爷爷由于上了年纪，走起路来脚步有些缓慢。',
      'Yéye yóuyú shàng le niánjì, zǒu qǐ lù lai jiǎobù yǒuxiē huǎnmàn.',
      'Do tuổi cao nên bước chân đi lại của ông có phần chậm rãi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '爷爷由于上了年纪，走起路来脚步有些缓慢。', 'Yéye yóuyú shàng le niánjì, zǒu qǐ lù lai jiǎobù yǒuxiē huǎnmàn.', 'Do tuổi cao nên bước chân đi lại của ông có phần chậm rãi.', 'basic', 1),
      (v_id, '受国际外需疲软及大宗商品价格波动影响，该国经济复苏进程比预想中更为缓慢。', 'Shòu guójì wàixū píruǎn jí dàzōng shāngpǐn jiàgé bōdòng yǐngxiǎng, gāi guó jīngjì fùsū jìnchéng bǐ yùxiǎng zhōng gèng wéi huǎnmàn.', 'Chịu ảnh hưởng bởi nhu cầu quốc tế suy yếu và giá hàng hóa cơ bản biến động, tiến trình phục hồi kinh tế của quốc gia này diễn ra chậm chạp hơn nhiều so với dự tính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2505] [黄瓜] (huángguā) - dưa chuột, dưa leo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '黄瓜' AND pinyin = 'huángguā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '黄瓜' AND pinyin = 'huángguā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '黄瓜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '黄瓜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huángguā',
      meaning_vi = 'dưa chuột, dưa leo',
      example_hanzi = '炎热的夏日里，一盘清脆可口的凉拌黄瓜深受大家的喜爱。',
      example_pinyin = 'Yánrè de xiàrì lǐ, yì pán qīngcuì kěkǒu de liángbàn huángguā shēnshòu dàjiā de xǐ’ài.',
      example_vi = 'Trong những ngày hè oi bức, một đĩa dưa chuột muối thanh mát giòn ngon rất được mọi người yêu thích.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '黄瓜',
      'huángguā',
      'dưa chuột, dưa leo',
      'Danh từ',
      'HSK 5',
      '炎热的夏日里，一盘清脆可口的凉拌黄瓜深受大家的喜爱。',
      'Yánrè de xiàrì lǐ, yì pán qīngcuì kěkǒu de liángbàn huángguā shēnshòu dàjiā de xǐ’ài.',
      'Trong những ngày hè oi bức, một đĩa dưa chuột muối thanh mát giòn ngon rất được mọi người yêu thích.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '炎热的夏日里，一盘清脆可口的凉拌黄瓜深受大家的喜爱。', 'Yánrè de xiàrì lǐ, yì pán qīngcuì kěkǒu de liángbàn huángguā shēnshòu dàjiā de xǐ’ài.', 'Trong những ngày hè oi bức, một đĩa dưa chuột muối thanh mát giòn ngon rất được mọi người yêu thích.', 'basic', 1),
      (v_id, '现代智能温室大棚采用无土栽培与水肥一体化技术，大幅提升了有机黄瓜的产量与营养品质。', 'Xiàndài zhìnéng wēnshì dàpéng cǎiyòng wútǔ zāipéi yǔ shuǐféi yītǐhuà jìshù, dàfú tíshēng le yǒujī huángguā de chǎnliàng yǔ yíngyǎng pǐnzhì.', 'Nhà kính thông minh hiện đại áp dụng kỹ thuật canh tác không dùng đất và tích hợp nước tưới - phân bón, nâng cao đáng kể sản lượng và phẩm chất dinh dưỡng của dưa leo hữu cơ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2506] [黄金] (huángjīn) - vàng; thời kỳ hoàng kim, cơ hội vàng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '黄金' AND pinyin = 'huángjīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '黄金' AND pinyin = 'huángjīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '黄金'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '黄金'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huángjīn',
      meaning_vi = 'vàng; thời kỳ hoàng kim, cơ hội vàng',
      example_hanzi = '不少人喜欢购买黄金饰品作为保值投资的一种途径。',
      example_pinyin = 'Bù shǎo rén xǐhuan gòumǎi huángjīn shìpǐn zuòwéi bǎozhí tóuzī de yì zhǒng tújìng.',
      example_vi = 'Khá nhiều người thích mua trang sức bằng vàng như một kênh đầu tư giữ giá trị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '黄金',
      'huángjīn',
      'vàng; thời kỳ hoàng kim, cơ hội vàng',
      'Danh từ',
      'HSK 5',
      '不少人喜欢购买黄金饰品作为保值投资的一种途径。',
      'Bù shǎo rén xǐhuan gòumǎi huángjīn shìpǐn zuòwéi bǎozhí tóuzī de yì zhǒng tújìng.',
      'Khá nhiều người thích mua trang sức bằng vàng như một kênh đầu tư giữ giá trị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '不少人喜欢购买黄金饰品作为保值投资的一种途径。', 'Bù shǎo rén xǐhuan gòumǎi huángjīn shìpǐn zuòwéi bǎozhí tóuzī de yì zhǒng tújìng.', 'Khá nhiều người thích mua trang sức bằng vàng như một kênh đầu tư giữ giá trị.', 'basic', 1),
      (v_id, '在国际金融市场波动加剧的背景下，黄金作为传统避险资产再次受到了全球机构投资者的青睐。', 'Zài guójì jīnróng shìchǎng bōdòng jiājù de bèijǐng xià, huángjīn zuòwéi chuántǒng bìxiǎn zīchǎn zàicì shòudào le quánqiú jīgòu tóuzīzhě de qīnglài.', 'Trong bối cảnh thị trường tài chính quốc tế biến động gia tăng, vàng với tư cách là tài sản trú ẩn an toàn truyền thống một lần nữa nhận được sự ưa chuộng của các nhà đầu tư tổ chức toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2507] [灰] (huī) - tro, tro tàn; bụi; màu xám; thất vọng, nản lòng [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '灰' AND pinyin = 'huī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '灰' AND pinyin = 'huī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '灰'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '灰'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'huī',
      meaning_vi = 'tro, tro tàn; bụi; màu xám; thất vọng, nản lòng',
      example_hanzi = '桌子几天没擦，上面落满了薄薄的一层灰。',
      example_pinyin = 'Zhuōzi jǐ tiān méi cā, shàngmiàn luòmǎn le báobáo de yì céng huī.',
      example_vi = 'Cái bàn mấy ngày không lau, trên mặt phủ đầy một lớp bụi mỏng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '灰',
      'huī',
      'tro, tro tàn; bụi; màu xám; thất vọng, nản lòng',
      'Danh từ / Tính từ',
      'HSK 5',
      '桌子几天没擦，上面落满了薄薄的一层灰。',
      'Zhuōzi jǐ tiān méi cā, shàngmiàn luòmǎn le báobáo de yì céng huī.',
      'Cái bàn mấy ngày không lau, trên mặt phủ đầy một lớp bụi mỏng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '桌子几天没擦，上面落满了薄薄的一层灰。', 'Zhuōzi jǐ tiān méi cā, shàngmiàn luòmǎn le báobáo de yì céng huī.', 'Cái bàn mấy ngày không lau, trên mặt phủ đầy một lớp bụi mỏng.', 'basic', 1),
      (v_id, '虽然接连遭遇了几次创业挫折，但他依然没有灰心丧气，而是重整旗鼓再次出发。', 'Suīrán jiēlián zāoyù le jǐ cì chuàngyè cuòzhé, dàn tā yīrán méiyǒu huīxīn-sàngqì, érshì chóngzhěng-qígǔ zàicì chūfā.', 'Tuy liên tiếp gặp phải vài lần vấp ngã khi khởi nghiệp, anh ấy vẫn không hề nản lòng thoái chí, mà chỉnh đốn lại đội ngũ để bắt đầu một chặng đường mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2508] [挥] (huī) - vẫy (tay), vung (kiếm/bút), xua đi; phát huy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '挥' AND pinyin = 'huī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挥' AND pinyin = 'huī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '挥'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挥'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'huī',
      meaning_vi = 'vẫy (tay), vung (kiếm/bút), xua đi; phát huy',
      example_hanzi = '列车缓缓开动时，站台上的朋友们都在热情地挥手告别。',
      example_pinyin = 'Lièchē huǎnhuǎn kāidòng shí, zhàntái shang de péngyoumen dōu zài rèqíng de huīshǒu gàobié.',
      example_vi = 'Khi đoàn tàu từ từ lăn bánh, bạn bè trên sân ga đều nhiệt tình vẫy tay từ biệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '挥',
      'huī',
      'vẫy (tay), vung (kiếm/bút), xua đi; phát huy',
      'Động từ',
      'HSK 5',
      '列车缓缓开动时，站台上的朋友们都在热情地挥手告别。',
      'Lièchē huǎnhuǎn kāidòng shí, zhàntái shang de péngyoumen dōu zài rèqíng de huīshǒu gàobié.',
      'Khi đoàn tàu từ từ lăn bánh, bạn bè trên sân ga đều nhiệt tình vẫy tay từ biệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '列车缓缓开动时，站台上的朋友们都在热情地挥手告别。', 'Lièchē huǎnhuǎn kāidòng shí, zhàntái shang de péngyoumen dōu zài rèqíng de huīshǒu gàobié.', 'Khi đoàn tàu từ từ lăn bánh, bạn bè trên sân ga đều nhiệt tình vẫy tay từ biệt.', 'basic', 1),
      (v_id, '指挥家在交响乐团面前充满激情地挥动指挥棒，引导全场音乐达到震撼人心的最高潮。', 'Zhǐhuījiā zài jiāoxiǎng yuètuán miànqián chōngmǎn jīqíng de huīdòng zhǐhuībàng, yǐndǎo quánchǎng yīnyuè dádào zhènhàn-rénxīn de zuì gāocháo.', 'Nhạc trưởng đầy nhiệt huyết vung cây gậy chỉ huy trước dàn nhạc giao hưởng, dẫn dắt giai điệu toàn khán phòng đạt đến cao trào lay động lòng người.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2509] [恢复] (huīfù) - khôi phục, phục hồi, lấy lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '恢复' AND pinyin = 'huīfù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '恢复' AND pinyin = 'huīfù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '恢复'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '恢复'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'huīfù',
      meaning_vi = 'khôi phục, phục hồi, lấy lại',
      example_hanzi = '经过医生的悉心调理，病人的健康状况已经完全恢复了。',
      example_pinyin = 'Jīngguò yīshēng de xīxīn tiáolǐ, bìngrén de jiànkāng zhuàngkuàng yǐjīng wánquán huīfù le.',
      example_vi = 'Qua sự chăm sóc tận tình của bác sĩ, tình trạng sức khỏe của bệnh nhân đã hoàn toàn hồi phục.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '恢复',
      'huīfù',
      'khôi phục, phục hồi, lấy lại',
      'Động từ',
      'HSK 5',
      '经过医生的悉心调理，病人的健康状况已经完全恢复了。',
      'Jīngguò yīshēng de xīxīn tiáolǐ, bìngrén de jiànkāng zhuàngkuàng yǐjīng wánquán huīfù le.',
      'Qua sự chăm sóc tận tình của bác sĩ, tình trạng sức khỏe của bệnh nhân đã hoàn toàn hồi phục.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过医生的悉心调理，病人的健康状况已经完全恢复了。', 'Jīngguò yīshēng de xīxīn tiáolǐ, bìngrén de jiànkāng zhuàngkuàng yǐjīng wánquán huīfù le.', 'Qua sự chăm sóc tận tình của bác sĩ, tình trạng sức khỏe của bệnh nhân đã hoàn toàn hồi phục.', 'basic', 1),
      (v_id, '随着多项提振内需的宏观政策相继落地，国内消费市场与文化旅游产业迅速恢复了往日的活力。', 'Suízhe duō xiàng tízhèn nèixū de hóngguān zhèngcè xiāngjì luòdì, guónèi xiāofèi shìchǎng yǔ wénhuà lǚyóu chǎnyè xùnsù huīfù le wǎngrì de huólì.', 'Cùng với sự đi vào đời sống của nhiều chính sách vĩ mô kích cầu tiêu dùng nội địa, thị trường tiêu dùng trong nước và ngành du lịch văn hóa đã nhanh chóng khôi phục lại sức sống như trước đây.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2510] [灰色] (huīsè) - màu xám; vùng xám (mơ hồ pháp lý, mờ ám) [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '灰色' AND pinyin = 'huīsè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '灰色' AND pinyin = 'huīsè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '灰色'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '灰色'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'huīsè',
      meaning_vi = 'màu xám; vùng xám (mơ hồ pháp lý, mờ ám)',
      example_hanzi = '他今天穿了一件浅灰色的羊毛开衫，看起来既儒雅又温暖。',
      example_pinyin = 'Tā jīntiān chuān le yí jiàn qiǎnhuīsè de yángmáo kāishān, kàn qǐlái jì rúyǎ yòu wēnnuǎn.',
      example_vi = 'Hôm nay anh ấy mặc một chiếc áo len cardigan màu xám nhạt, trông vừa nho nhã lại vừa ấm áp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '灰色',
      'huīsè',
      'màu xám; vùng xám (mơ hồ pháp lý, mờ ám)',
      'Danh từ / Tính từ',
      'HSK 5',
      '他今天穿了一件浅灰色的羊毛开衫，看起来既儒雅又温暖。',
      'Tā jīntiān chuān le yí jiàn qiǎnhuīsè de yángmáo kāishān, kàn qǐlái jì rúyǎ yòu wēnnuǎn.',
      'Hôm nay anh ấy mặc một chiếc áo len cardigan màu xám nhạt, trông vừa nho nhã lại vừa ấm áp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他今天穿了一件浅灰色的羊毛开衫，看起来既儒雅又温暖。', 'Tā jīntiān chuān le yí jiàn qiǎnhuīsè de yángmáo kāishān, kàn qǐlái jì rúyǎ yòu wēnnuǎn.', 'Hôm nay anh ấy mặc một chiếc áo len cardigan màu xám nhạt, trông vừa nho nhã lại vừa ấm áp.', 'basic', 1),
      (v_id, '监管部门正在全面清理互联网金融领域的灰色地带，坚决维护资本市场的健康秩序与投资者合法权益。', 'Jiānguǎn bùmén zhèngzài quánmiàn qīnglǐ hùliánwǎng jīnróng lǐngyù de huīsè dìdài, jiānjué wéihù zīběn shìchǎng de jiànkāng zhìxù yǔ tóuzīzhě héfǎ quányì.', 'Cơ quan quản lý đang tích cực rà soát và chấn chỉnh các vùng xám trong lĩnh vực tài chính Internet, kiên quyết bảo vệ trật tự lành mạnh của thị trường vốn và quyền lợi hợp pháp của các nhà đầu tư.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2511] [回收] (huíshōu) - thu hồi, tái chế [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '回收' AND pinyin = 'huíshōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '回收' AND pinyin = 'huíshōu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '回收'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '回收'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'huíshōu',
      meaning_vi = 'thu hồi, tái chế',
      example_hanzi = '社区里设置了专门的废旧纸箱与塑料瓶回收箱。',
      example_pinyin = 'Shèqū lǐ shèzhì le zhuānmén de fèijiù zhǐxiāng yǔ sùliàopíng huíshōu xiāng.',
      example_vi = 'Khu dân cư đã lắp đặt các thùng thu gom tái chế riêng biệt dành cho thùng carton cũ và chai nhựa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '回收',
      'huíshōu',
      'thu hồi, tái chế',
      'Động từ',
      'HSK 5',
      '社区里设置了专门的废旧纸箱与塑料瓶回收箱。',
      'Shèqū lǐ shèzhì le zhuānmén de fèijiù zhǐxiāng yǔ sùliàopíng huíshōu xiāng.',
      'Khu dân cư đã lắp đặt các thùng thu gom tái chế riêng biệt dành cho thùng carton cũ và chai nhựa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '社区里设置了专门的废旧纸箱与塑料瓶回收箱。', 'Shèqū lǐ shèzhì le zhuānmén de fèijiù zhǐxiāng yǔ sùliàopíng huíshōu xiāng.', 'Khu dân cư đã lắp đặt các thùng thu gom tái chế riêng biệt dành cho thùng carton cũ và chai nhựa.', 'basic', 1),
      (v_id, '新能源汽车产业的高速发展，使得退役动力电池的梯次利用与贵金属绿色回收成为了关键的环保议题。', 'Xīnnéngyuán qìchē chǎnyè de gāosù fāzhǎn, shǐde tuìyì dònglì diànchí de tīcì lìyòng yǔ guìjīnshǔ lǜsè huíshōu chéngwéi le guānjiàn de huánbǎo yìtí.', 'Sự phát triển vượt bậc của ngành xe điện mới khiến cho việc sử dụng tuần hoàn và tái chế xanh kim loại quý từ pin năng lượng hết niên hạn trở thành một chủ đề môi trường then chốt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2512] [汇率] (huìlǜ) - tỷ giá hối đoái, tỷ giá [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '汇率' AND pinyin = 'huìlǜ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '汇率' AND pinyin = 'huìlǜ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '汇率'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '汇率'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huìlǜ',
      meaning_vi = 'tỷ giá hối đoái, tỷ giá',
      example_hanzi = '出国旅游前，最好提前了解一下当地货币与本币的兑换汇率。',
      example_pinyin = 'Chūguó lǚyóu qián, zuìhǎo tíqián liǎojiě yíxià dāngdì huòbì yǔ běnbì de duìhuàn huìlǜ.',
      example_vi = 'Trước khi đi du lịch nước ngoài, tốt nhất nên tìm hiểu trước tỷ giá chuyển đổi giữa đồng tiền bản địa và nội tệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '汇率',
      'huìlǜ',
      'tỷ giá hối đoái, tỷ giá',
      'Danh từ',
      'HSK 5',
      '出国旅游前，最好提前了解一下当地货币与本币的兑换汇率。',
      'Chūguó lǚyóu qián, zuìhǎo tíqián liǎojiě yíxià dāngdì huòbì yǔ běnbì de duìhuàn huìlǜ.',
      'Trước khi đi du lịch nước ngoài, tốt nhất nên tìm hiểu trước tỷ giá chuyển đổi giữa đồng tiền bản địa và nội tệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出国旅游前，最好提前了解一下当地货币与本币的兑换汇率。', 'Chūguó lǚyóu qián, zuìhǎo tíqián liǎojiě yíxià dāngdì huòbì yǔ běnbì de duìhuàn huìlǜ.', 'Trước khi đi du lịch nước ngoài, tốt nhất nên tìm hiểu trước tỷ giá chuyển đổi giữa đồng tiền bản địa và nội tệ.', 'basic', 1),
      (v_id, '进出口外贸企业通常利用远期外汇合约等金融衍生品，来对冲国际汇率剧烈波动所带来的财务风险。', 'Jìn-chūkǒu wàimào qǐyè tōngcháng lìyòng yuǎnqī wàihuì héyuē děng jīnróng yǎnshēngpǐn, lái duìchōng guójì huìlǜ jùliè bōdòng suǒ dàilái de cáiwù fēngxiǎn.', 'Các doanh nghiệp ngoại thương xuất nhập khẩu thường vận dụng các công cụ phái sinh tài chính như hợp đồng ngoại hối kỳ hạn để phòng ngừa rủi ro tài chính do biến động tỷ giá quốc tế mạnh gây ra.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2513] [婚礼] (hūnlǐ) - hôn lễ, đám cưới [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '婚礼' AND pinyin = 'hūnlǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '婚礼' AND pinyin = 'hūnlǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '婚礼'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '婚礼'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hūnlǐ',
      meaning_vi = 'hôn lễ, đám cưới',
      example_hanzi = '亲朋好友齐聚一堂，共同见证并祝福这对新人的浪漫婚礼。',
      example_pinyin = 'Qīnpéng-hǎoyǒu qíjù-yìtáng, gòngtóng jiànzhèng bìng zhùfú zhè duì xīnrén de làngmàn hūnlǐ.',
      example_vi = 'Bạn bè và người thân tề tựu đông đủ để cùng nhau chứng kiến và chúc phúc cho hôn lễ lãng mạn của cặp đôi mới cưới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '婚礼',
      'hūnlǐ',
      'hôn lễ, đám cưới',
      'Danh từ',
      'HSK 5',
      '亲朋好友齐聚一堂，共同见证并祝福这对新人的浪漫婚礼。',
      'Qīnpéng-hǎoyǒu qíjù-yìtáng, gòngtóng jiànzhèng bìng zhùfú zhè duì xīnrén de làngmàn hūnlǐ.',
      'Bạn bè và người thân tề tựu đông đủ để cùng nhau chứng kiến và chúc phúc cho hôn lễ lãng mạn của cặp đôi mới cưới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '亲朋好友齐聚一堂，共同见证并祝福这对新人的浪漫婚礼。', 'Qīnpéng-hǎoyǒu qíjù-yìtáng, gòngtóng jiànzhèng bìng zhùfú zhè duì xīnrén de làngmàn hūnlǐ.', 'Bạn bè và người thân tề tựu đông đủ để cùng nhau chứng kiến và chúc phúc cho hôn lễ lãng mạn của cặp đôi mới cưới.', 'basic', 1),
      (v_id, '如今越来越多的年轻一代偏爱简约而富有文化内涵的中式传统婚礼，彰显出强烈的文化自信。', 'Rújīn yuèláiyuè duō de niánqīng yídài piān’ài jiǎnyuē ér fùyǒu wénhuà nèihán de zhōngshì chuántǒng hūnlǐ, zhāngxiǎn chū qiángliè de wénhuà zìxìn.', 'Ngày nay ngày càng nhiều bạn trẻ ưa chuộng những đám cưới truyền thống kiểu Trung Hoa tối giản mà đậm đà chiều sâu văn hóa, thể hiện niềm tự tin văn hóa sâu sắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2514] [伙] (huǒ) - tốp, nhóm, bọn (lượng từ); nhóm người, phường [Lượng từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '伙' AND pinyin = 'huǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伙' AND pinyin = 'huǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '伙'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伙'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Lượng từ / Danh từ',
      pinyin = 'huǒ',
      meaning_vi = 'tốp, nhóm, bọn (lượng từ); nhóm người, phường',
      example_hanzi = '公园的草坪上坐着一伙年轻人，正弹着吉他唱歌。',
      example_pinyin = 'Gōngyuán de cǎopíng shang zuò zhe yì huǒ niánqīngrén, zhèng tán zhe jítā chànggē.',
      example_vi = 'Trên bãi cỏ của công viên có một nhóm bạn trẻ đang ngồi vừa gảy đàn guitar vừa hát.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '伙',
      'huǒ',
      'tốp, nhóm, bọn (lượng từ); nhóm người, phường',
      'Lượng từ / Danh từ',
      'HSK 5',
      '公园的草坪上坐着一伙年轻人，正弹着吉他唱歌。',
      'Gōngyuán de cǎopíng shang zuò zhe yì huǒ niánqīngrén, zhèng tán zhe jítā chànggē.',
      'Trên bãi cỏ của công viên có một nhóm bạn trẻ đang ngồi vừa gảy đàn guitar vừa hát.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '公园的草坪上坐着一伙年轻人，正弹着吉他唱歌。', 'Gōngyuán de cǎopíng shang zuò zhe yì huǒ niánqīngrén, zhèng tán zhe jítā chànggē.', 'Trên bãi cỏ của công viên có một nhóm bạn trẻ đang ngồi vừa gảy đàn guitar vừa hát.', 'basic', 1),
      (v_id, '公安机关经过数月缜密侦查，成功打掉了一个跨区域伪造销售假冒注册商标的犯罪团伙。', 'Gōng’ān jīguān jīngguò shù yuè zhěnmì zhēnchá, chénggōng dǎdiào le yí gè kuà qūyù wěizào xiāoshòu jiǎmào zhùcè shāngbiāo de fànzuì tuánhuǒ.', 'Cơ quan công an qua nhiều tháng điều tra tỉ mỉ đã triệt phá thành công một băng nhóm tội phạm xuyên khu vực chuyên làm giả và tiêu thụ nhãn hiệu đăng ký thương mại giả mạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2515] [伙伴] (huǒbàn) - đối tác, bạn đồng hành, cộng sự [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '伙伴' AND pinyin = 'huǒbàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伙伴' AND pinyin = 'huǒbàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '伙伴'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '伙伴'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huǒbàn',
      meaning_vi = 'đối tác, bạn đồng hành, cộng sự',
      example_hanzi = '在求学道路上，能遇到志同道合的学习伙伴是一件很幸运的事。',
      example_pinyin = 'Zài qiúxué dàolù shang, néng yùdào zhìtóng-dàohé de xuéxí huǒbàn shì yí jiàn hěn xìngyùn de shì.',
      example_vi = 'Trên con đường học vấn, gặp được người bạn học cùng chung chí hướng là một điều vô cùng may mắn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '伙伴',
      'huǒbàn',
      'đối tác, bạn đồng hành, cộng sự',
      'Danh từ',
      'HSK 5',
      '在求学道路上，能遇到志同道合的学习伙伴是一件很幸运的事。',
      'Zài qiúxué dàolù shang, néng yùdào zhìtóng-dàohé de xuéxí huǒbàn shì yí jiàn hěn xìngyùn de shì.',
      'Trên con đường học vấn, gặp được người bạn học cùng chung chí hướng là một điều vô cùng may mắn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在求学道路上，能遇到志同道合的学习伙伴是一件很幸运的事。', 'Zài qiúxué dàolù shang, néng yùdào zhìtóng-dàohé de xuéxí huǒbàn shì yí jiàn hěn xìngyùn de shì.', 'Trên con đường học vấn, gặp được người bạn học cùng chung chí hướng là một điều vô cùng may mắn.', 'basic', 1),
      (v_id, '两国元首一致同意深化全面战略伙伴关系，推动经贸投资与人文交流合作迈上全新台阶。', 'Liǎng guó yuánshǒu yízhì tóngyì shēnhuà quánmiàn zhànlüè huǒbàn guānxì, tuīdòng jīngmào tóuzī yǔ rénwén jiāoliú hézuò mài shàng quánxīn táijiē.', 'Nguyên thủ hai nước nhất trí làm sâu sắc thêm quan hệ đối tác chiến lược toàn diện, thúc đẩy hợp tác đầu tư thương mại và giao lưu nhân văn bước lên tầm cao mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2516] [火锅] (huǒguō) - lẩu, món lẩu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '火锅' AND pinyin = 'huǒguō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '火锅' AND pinyin = 'huǒguō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '火锅'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '火锅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huǒguō',
      meaning_vi = 'lẩu, món lẩu',
      example_hanzi = '冬天天气寒冷的时候，全家人围坐在一起吃热气腾腾的火锅最惬意不过了。',
      example_pinyin = 'Dōngtiān tiānqì hánlěng de shíhou, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de huǒguō zuì qièyì búguò le.',
      example_vi = 'Khi tiết trời mùa đông se lạnh, cả nhà quây quần bên nhau ăn nồi lẩu bốc khói nghi ngút là điều sảng khoái nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '火锅',
      'huǒguō',
      'lẩu, món lẩu',
      'Danh từ',
      'HSK 5',
      '冬天天气寒冷的时候，全家人围坐在一起吃热气腾腾的火锅最惬意不过了。',
      'Dōngtiān tiānqì hánlěng de shíhou, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de huǒguō zuì qièyì búguò le.',
      'Khi tiết trời mùa đông se lạnh, cả nhà quây quần bên nhau ăn nồi lẩu bốc khói nghi ngút là điều sảng khoái nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬天天气寒冷的时候，全家人围坐在一起吃热气腾腾的火锅最惬意不过了。', 'Dōngtiān tiānqì hánlěng de shíhou, quán jiārén wéizuò zài yìqǐ chī rèqì-téngténg de huǒguō zuì qièyì búguò le.', 'Khi tiết trời mùa đông se lạnh, cả nhà quây quần bên nhau ăn nồi lẩu bốc khói nghi ngút là điều sảng khoái nhất.', 'basic', 1),
      (v_id, '川渝火锅凭借独特的麻辣风味和丰富的食材搭配，已成为中国餐饮文化走向全球的一张亮丽名片。', 'Chuān-Yú huǒguō píngjiè dútè de málà fēngwèi hé fēngfù de shícái dāpèi, yǐ chéngwéi Zhōngguó cānyǐn wénhuà zǒuxiàng quánqiú de yì zhāng liànglì míngpiàn.', 'Lẩu Tứ Xuyên - Trùng Khánh nhờ hương vị cay tê độc đáo và các nguyên liệu phối hợp phong phú đã trở thành tấm danh thiếp rạng rỡ đưa văn hóa ẩm thực Trung Hoa vươn ra thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2517] [或是] (huòshì) - hoặc là, hay là [Liên từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '或是' AND pinyin = 'huòshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '或是' AND pinyin = 'huòshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '或是'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '或是'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ / Phó từ',
      pinyin = 'huòshì',
      meaning_vi = 'hoặc là, hay là',
      example_hanzi = '周末我通常在家里静心看书，或是约上三两好友去郊外散步。',
      example_pinyin = 'Zhōumò wǒ tōngcháng zài jiālǐ jìngxīn kànshū, huòshì yuē shàng sān-liǎng hǎoyǒu qù jiāowài sànbù.',
      example_vi = 'Cuối tuần tôi thường ở nhà yên tĩnh đọc sách, hoặc là rủ dăm ba người bạn thân đi tản bộ ngoại ô.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '或是',
      'huòshì',
      'hoặc là, hay là',
      'Liên từ / Phó từ',
      'HSK 5',
      '周末我通常在家里静心看书，或是约上三两好友去郊外散步。',
      'Zhōumò wǒ tōngcháng zài jiālǐ jìngxīn kànshū, huòshì yuē shàng sān-liǎng hǎoyǒu qù jiāowài sànbù.',
      'Cuối tuần tôi thường ở nhà yên tĩnh đọc sách, hoặc là rủ dăm ba người bạn thân đi tản bộ ngoại ô.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末我通常在家里静心看书，或是约上三两好友去郊外散步。', 'Zhōumò wǒ tōngcháng zài jiālǐ jìngxīn kànshū, huòshì yuē shàng sān-liǎng hǎoyǒu qù jiāowài sànbù.', 'Cuối tuần tôi thường ở nhà yên tĩnh đọc sách, hoặc là rủ dăm ba người bạn thân đi tản bộ ngoại ô.', 'basic', 1),
      (v_id, '面对日益剧烈的市场竞争，传统企业或是加速数字化转型升级，或是将被行业变革浪潮无情淘汰。', 'Miànduì rìyì jùliè de shìchǎng jìngzhēng, chuántǒng qǐyè huòshì jiāsù shùzìhuà zhuǎnxíng shēngjí, huòshì jiāng bèi hángyè biàngé làngcháo wúqíng táotài.', 'Đối mặt với sự cạnh tranh thị trường ngày càng khốc liệt, các doanh nghiệp truyền thống hoặc là đẩy nhanh chuyển đổi nâng cấp số, hoặc là sẽ bị làn sóng cải cách ngành nghề đào thải không thương tiếc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2518] [货物] (huòwù) - hàng hóa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '货物' AND pinyin = 'huòwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '货物' AND pinyin = 'huòwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '货物'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '货物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huòwù',
      meaning_vi = 'hàng hóa',
      example_hanzi = '装卸工人们正动作熟练地将整箱货物搬运进大型卡车里。',
      example_pinyin = 'Zhuāngxiè gōngrénmen zhèng dòngzuò shúliàn de jiāng zhěng xiāng huòwù bānyùn jìn dàxíng kǎchē lǐ.',
      example_vi = 'Những công nhân bốc vác đang nhanh nhẹn bốc dỡ các thùng hàng nguyên đai nguyên kiện lên chiếc xe tải lớn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '货物',
      'huòwù',
      'hàng hóa',
      'Danh từ',
      'HSK 5',
      '装卸工人们正动作熟练地将整箱货物搬运进大型卡车里。',
      'Zhuāngxiè gōngrénmen zhèng dòngzuò shúliàn de jiāng zhěng xiāng huòwù bānyùn jìn dàxíng kǎchē lǐ.',
      'Những công nhân bốc vác đang nhanh nhẹn bốc dỡ các thùng hàng nguyên đai nguyên kiện lên chiếc xe tải lớn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '装卸工人们正动作熟练地将整箱货物搬运进大型卡车里。', 'Zhuāngxiè gōngrénmen zhèng dòngzuò shúliàn de jiāng zhěng xiāng huòwù bānyùn jìn dàxíng kǎchē lǐ.', 'Những công nhân bốc vác đang nhanh nhẹn bốc dỡ các thùng hàng nguyên đai nguyên kiện lên chiếc xe tải lớn.', 'basic', 1),
      (v_id, '中欧班列的高效常态化开行，为亚欧大陆之间高附加值货物的跨国联运提供了安全可靠的绿色通道。', 'Zhōng-Ōu bānliè de gāoxiào chángtàihuà kāixíng, wèi Yà-Ōu dàlù zhījiān gāo fùjiāzhí huòwù de kuàguó liányùn tígōng le ānquán kěkào de lǜsè tōngdào.', 'Tuyến tàu hàng liên vận Trung Quốc - châu Âu vận hành định kỳ hiệu quả cao đã cung cấp một hành lang xanh an toàn đáng tin cậy cho việc vận tải hàng hóa giá trị gia tăng cao giữa hai lục địa Á - Âu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2519] [或许] (huòxǔ) - có lẽ, có thể, biết đâu [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '或许' AND pinyin = 'huòxǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '或许' AND pinyin = 'huòxǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '或许'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '或许'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'huòxǔ',
      meaning_vi = 'có lẽ, có thể, biết đâu',
      example_hanzi = '他今天迟到了，或许是因为路上遇到了突发的交通堵塞。',
      example_pinyin = 'Tā jīntiān chídào le, huòxǔ shì yīnwèi lùshang yùdào le tūfā de jiāotōng dǔsè.',
      example_vi = 'Hôm nay anh ấy đến muộn, có lẽ là do trên đường gặp sự cố tắc đường đột xuất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '或许',
      'huòxǔ',
      'có lẽ, có thể, biết đâu',
      'Phó từ',
      'HSK 5',
      '他今天迟到了，或许是因为路上遇到了突发的交通堵塞。',
      'Tā jīntiān chídào le, huòxǔ shì yīnwèi lùshang yùdào le tūfā de jiāotōng dǔsè.',
      'Hôm nay anh ấy đến muộn, có lẽ là do trên đường gặp sự cố tắc đường đột xuất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他今天迟到了，或许是因为路上遇到了突发的交通堵塞。', 'Tā jīntiān chídào le, huòxǔ shì yīnwèi lùshang yùdào le tūfā de jiāotōng dǔsè.', 'Hôm nay anh ấy đến muộn, có lẽ là do trên đường gặp sự cố tắc đường đột xuất.', 'basic', 1),
      (v_id, '面对眼前的复杂困局，暂时放慢脚步从全局视角重新审视策略，或许能找到柳暗花明的突破口。', 'Miànduì yǎnqián de fùzá kùnjú, zànshí fàngmàn jiǎobù cóng quánjú shìjiǎo chóngxīn shěnshì cèlüè, huòxǔ néng zhǎodào liǔ’àn-huāmíng de tūpòkǒu.', 'Đứng trước tình thế khó khăn phức tạp trước mắt, tạm thời chậm lại một nhịp để nhìn nhận lại chiến lược từ góc nhìn toàn cục, biết đâu lại có thể tìm ra bước đột phá mở ra lối thoát mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2520] [机构] (jīgòu) - cơ cấu, cơ quan, tổ chức, thiết chế [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '机构' AND pinyin = 'jīgòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '机构' AND pinyin = 'jīgòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '机构'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '机构'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jīgòu',
      meaning_vi = 'cơ cấu, cơ quan, tổ chức, thiết chế',
      example_hanzi = '这所语言培训机构在外语教学方面拥有多年丰富的教学经验。',
      example_pinyin = 'Zhè suǒ yǔyán péixùn jīgòu zài wàiyǔ jiàoxué fāngmiàn yōngyǒu duō nián fēngfù de jiàoxué jīngyàn.',
      example_vi = 'Cơ sở đào tạo ngôn ngữ này có nhiều năm kinh nghiệm phong phú trong giảng dạy ngoại ngữ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '机构',
      'jīgòu',
      'cơ cấu, cơ quan, tổ chức, thiết chế',
      'Danh từ',
      'HSK 5',
      '这所语言培训机构在外语教学方面拥有多年丰富的教学经验。',
      'Zhè suǒ yǔyán péixùn jīgòu zài wàiyǔ jiàoxué fāngmiàn yōngyǒu duō nián fēngfù de jiàoxué jīngyàn.',
      'Cơ sở đào tạo ngôn ngữ này có nhiều năm kinh nghiệm phong phú trong giảng dạy ngoại ngữ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这所语言培训机构在外语教学方面拥有多年丰富的教学经验。', 'Zhè suǒ yǔyán péixùn jīgòu zài wàiyǔ jiàoxué fāngmiàn yōngyǒu duō nián fēngfù de jiàoxué jīngyàn.', 'Cơ sở đào tạo ngôn ngữ này có nhiều năm kinh nghiệm phong phú trong giảng dạy ngoại ngữ.', 'basic', 1),
      (v_id, '市政府联合多家权威科研机构与高校，共同组建了专注于前沿人工智能科技攻关的联合实验室。', 'Shì zhèngfǔ liánhé duō jiā quánwēi kēyán jīgòu yǔ gāoxiào, gòngtóng zǔjiàn le zhuānzhù yú qiányán réngōng zhìnéng kējì gōngguān de liánhé shíyànshì.', 'Chính quyền thành phố đã liên kết với nhiều viện nghiên cứu khoa học uy tín và các trường đại học để thành lập phòng thí nghiệm liên kết chuyên nghiên cứu đột phá công nghệ trí tuệ nhân tạo tiên phong.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2521] [激烈] (jīliè) - kịch liệt, quyết liệt, gay gắt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '激烈' AND pinyin = 'jīliè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '激烈' AND pinyin = 'jīliè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '激烈'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '激烈'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'jīliè',
      meaning_vi = 'kịch liệt, quyết liệt, gay gắt',
      example_hanzi = '两支强队在决赛中展开了一场十分激烈的争夺。',
      example_pinyin = 'Liǎng zhī qiángduì zài juésài zhōng zhǎnkāi le yì chǎng shífēn jīliè de zhēngduó.',
      example_vi = 'Hai đội mạnh đã có một màn tranh tài vô cùng quyết liệt trong trận chung kết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '激烈',
      'jīliè',
      'kịch liệt, quyết liệt, gay gắt',
      'Tính từ',
      'HSK 5',
      '两支强队在决赛中展开了一场十分激烈的争夺。',
      'Liǎng zhī qiángduì zài juésài zhōng zhǎnkāi le yì chǎng shífēn jīliè de zhēngduó.',
      'Hai đội mạnh đã có một màn tranh tài vô cùng quyết liệt trong trận chung kết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '两支强队在决赛中展开了一场十分激烈的争夺。', 'Liǎng zhī qiángduì zài juésài zhōng zhǎnkāi le yì chǎng shífēn jīliè de zhēngduó.', 'Hai đội mạnh đã có một màn tranh tài vô cùng quyết liệt trong trận chung kết.', 'basic', 1),
      (v_id, '面对全球新能源汽车市场白热化的激烈竞争，技术自主创新与卓越的用户体验是企业立于不败之地的根本基石。', 'Miànduì quánqiú xīnnéngyuán qìchē shìchǎng báirèhuà de jīliè jìngzhēng, jìshù zìzhǔ chuàngxīn yǔ zhuóyuè de yònghù tǐyàn shì qǐyè lìyú búbàizhīdì de gēnběn jīshí.', 'Đối mặt với sự cạnh tranh gay gắt đến mức đỉnh điểm trên thị trường xe điện toàn cầu, việc tự chủ đổi mới công nghệ và trải nghiệm khách hàng xuất sắc là nền tảng cốt lõi giúp doanh nghiệp đứng vững.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2522] [机器] (jīqì) - máy móc, cỗ máy [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '机器' AND pinyin = 'jīqì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '机器' AND pinyin = 'jīqì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '机器'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '机器'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jīqì',
      meaning_vi = 'máy móc, cỗ máy',
      example_hanzi = '工人们正在严格按照操作规程维护保养这台进口机器。',
      example_pinyin = 'Gōngrénmen zhèngzài yángé ànzhào cāozuò guīchéng wéihù bǎoyǎng zhè tái jìnkǒu jīqì.',
      example_vi = 'Các công nhân đang nghiêm túc tuân thủ quy trình thao tác để bảo trì cỗ máy nhập khẩu này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '机器',
      'jīqì',
      'máy móc, cỗ máy',
      'Danh từ',
      'HSK 5',
      '工人们正在严格按照操作规程维护保养这台进口机器。',
      'Gōngrénmen zhèngzài yángé ànzhào cāozuò guīchéng wéihù bǎoyǎng zhè tái jìnkǒu jīqì.',
      'Các công nhân đang nghiêm túc tuân thủ quy trình thao tác để bảo trì cỗ máy nhập khẩu này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '工人们正在严格按照操作规程维护保养这台进口机器。', 'Gōngrénmen zhèngzài yángé ànzhào cāozuò guīchéng wéihù bǎoyǎng zhè tái jìnkǒu jīqì.', 'Các công nhân đang nghiêm túc tuân thủ quy trình thao tác để bảo trì cỗ máy nhập khẩu này.', 'basic', 1),
      (v_id, '高精密度工业制造依赖于自动化数控机器的毫厘不差，任何微小误差都可能影响尖端元件的良品率。', 'Gāo jīngmìdù gōngyè zhìzào yīlài yú zìdònghuà shùkòng jīqì de háolí-bùchà, rènhé wéixiǎo wùchā dōu kěnéng yǐngxiǎng jiānduān yuánjiàn de liángpǐnlǜ.', 'Sản xuất công nghiệp độ chính xác cao phụ thuộc vào sự chuẩn xác từng li từng tí của máy CNC tự động, bất kỳ sai số nhỏ nào cũng có thể ảnh hưởng đến tỷ lệ đạt chuẩn của linh kiện cao cấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2523] [机器人] (jīqìrén) - người máy, robot [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '机器人' AND pinyin = 'jīqìrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '机器人' AND pinyin = 'jīqìrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '机器人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '机器人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jīqìrén',
      meaning_vi = 'người máy, robot',
      example_hanzi = '家里的扫地机器人每天定时清扫地面，帮我省去了很多做家务的时间。',
      example_pinyin = 'Jiā lǐ de sǎodì jīqìrén měi tiān dìngshí qīngsǎo dìmbiàn, bāng wǒ shěngqù le hěn duō zuò jiāwù de shíjiān.',
      example_vi = 'Robot hút bụi trong nhà mỗi ngày đều lau dọn sàn nhà theo giờ đã hẹn, giúp tôi tiết kiệm được rất nhiều thời gian làm việc nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '机器人',
      'jīqìrén',
      'người máy, robot',
      'Danh từ',
      'HSK 5',
      '家里的扫地机器人每天定时清扫地面，帮我省去了很多做家务的时间。',
      'Jiā lǐ de sǎodì jīqìrén měi tiān dìngshí qīngsǎo dìmbiàn, bāng wǒ shěngqù le hěn duō zuò jiāwù de shíjiān.',
      'Robot hút bụi trong nhà mỗi ngày đều lau dọn sàn nhà theo giờ đã hẹn, giúp tôi tiết kiệm được rất nhiều thời gian làm việc nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '家里的扫地机器人每天定时清扫地面，帮我省去了很多做家务的时间。', 'Jiā lǐ de sǎodì jīqìrén měi tiān dìngshí qīngsǎo dìmbiàn, bāng wǒ shěngqù le hěn duō zuò jiāwù de shíjiān.', 'Robot hút bụi trong nhà mỗi ngày đều lau dọn sàn nhà theo giờ đã hẹn, giúp tôi tiết kiệm được rất nhiều thời gian làm việc nhà.', 'basic', 1),
      (v_id, '医疗领域的手术辅助机器人凭借精准的操作控制，能够协助外科医生在微创条件下完成极为复杂的心脑血管手术。', 'Yīliáo lǐngyù de shǒushù fǔzhù jīqìrén píngjiè jīngzhǔn de cāozuò kòngzhì, nénggòu xiézhù wàikē yīshēng zài wēichuàng tiáojiàn xià wánchéng jíwéi fùzá de xīn-nǎoxiěguǎn shǒushù.', 'Robot hỗ trợ phẫu thuật trong lĩnh vực y tế nhờ khả năng thao tác điều khiển chính xác có thể trợ giúp các bác sĩ ngoại khoa thực hiện các ca phẫu thuật tim mạch và mạch máu não vô cùng phức tạp theo phương pháp xâm lấn tối thiểu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2524] [肌肉] (jīròu) - cơ bắp, cơ thịt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '肌肉' AND pinyin = 'jīròu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '肌肉' AND pinyin = 'jīròu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '肌肉'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '肌肉'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jīròu',
      meaning_vi = 'cơ bắp, cơ thịt',
      example_hanzi = '剧烈运动之后如果不做拉伸，很容易引起第二天肌肉酸痛。',
      example_pinyin = 'Jùliè yùndòng zhīhòu rúguǒ bú zuò lāshēn, hěn róngyì yǐnqǐ dì-èr tiān jīròu suāntòng.',
      example_vi = 'Sau khi vận động mạnh nếu không giãn cơ thì rất dễ dẫn đến việc đau nhức cơ bắp vào ngày hôm sau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '肌肉',
      'jīròu',
      'cơ bắp, cơ thịt',
      'Danh từ',
      'HSK 5',
      '剧烈运动之后如果不做拉伸，很容易引起第二天肌肉酸痛。',
      'Jùliè yùndòng zhīhòu rúguǒ bú zuò lāshēn, hěn róngyì yǐnqǐ dì-èr tiān jīròu suāntòng.',
      'Sau khi vận động mạnh nếu không giãn cơ thì rất dễ dẫn đến việc đau nhức cơ bắp vào ngày hôm sau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '剧烈运动之后如果不做拉伸，很容易引起第二天肌肉酸痛。', 'Jùliè yùndòng zhīhòu rúguǒ bú zuò lāshēn, hěn róngyì yǐnqǐ dì-èr tiān jīròu suāntòng.', 'Sau khi vận động mạnh nếu không giãn cơ thì rất dễ dẫn đến việc đau nhức cơ bắp vào ngày hôm sau.', 'basic', 1),
      (v_id, '科学的力量训练搭配高蛋白均衡营养膳食，能够有效促进骨骼肌纤维的修复与核心肌肉力量的增长。', 'Kēxué de lìliàng xùnliàn dāpèi gāo dànbái jūnhéng yíngyǎng shànshí, nénggòu yǒuxiào cùjìn gǔgéjī xiānwéi de xiūfù yǔ héxīn jīròu lìliàng de zēngzhǎng.', 'Rèn luyện sức mạnh khoa học kết hợp với chế độ ăn uống giàu protein cân bằng dinh dưỡng có thể thúc đẩy hiệu quả việc phục hồi các sợi cơ xương và gia tăng sức mạnh của nhóm cơ cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2525] [及] (jí) - và, cùng, cũng như [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '及' AND pinyin = 'jí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '及' AND pinyin = 'jí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '及'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '及'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'jí',
      meaning_vi = 'và, cùng, cũng như',
      example_hanzi = '请大家提前准备好身份证、护照及相关的证明材料。',
      example_pinyin = 'Qǐng dàjiā tíqián zhǔnbèi hǎo shēnfènzhèng, hùzhào jí xiāngguān de zhèngmíng cáiliào.',
      example_vi = 'Xin mọi người hãy chuẩn bị sẵn chứng minh thư, hộ chiếu cũng như các giấy tờ chứng minh có liên quan.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '及',
      'jí',
      'và, cùng, cũng như',
      'Liên từ',
      'HSK 5',
      '请大家提前准备好身份证、护照及相关的证明材料。',
      'Qǐng dàjiā tíqián zhǔnbèi hǎo shēnfènzhèng, hùzhào jí xiāngguān de zhèngmíng cáiliào.',
      'Xin mọi người hãy chuẩn bị sẵn chứng minh thư, hộ chiếu cũng như các giấy tờ chứng minh có liên quan.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请大家提前准备好身份证、护照及相关的证明材料。', 'Qǐng dàjiā tíqián zhǔnbèi hǎo shēnfènzhèng, hùzhào jí xiāngguān de zhèngmíng cáiliào.', 'Xin mọi người hãy chuẩn bị sẵn chứng minh thư, hộ chiếu cũng như các giấy tờ chứng minh có liên quan.', 'basic', 1),
      (v_id, '本公约旨在加强签约国在环境保护、生物多样性保护及绿色低碳技术转移领域的全面务实合作。', 'Běn gōngyuē zhǐzài jiāqiáng qiānyuēguó zài huánjìng bǎohù, shēngwù duōyàngxìng bǎohù jí lǜsè dītàn jìshù zhuǎnyí lǐngyù de quánmiàn wùshí hézuò.', 'Công ước này nhằm tăng cường sự hợp tác thiết thực toàn diện giữa các quốc gia ký kết trong các lĩnh vực bảo vệ môi trường, bảo tồn đa dạng sinh học và chuyển giao công nghệ xanh ít carbon.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2526] [级] (jí) - cấp bậc, hạng, lớp, mức độ; bậc (thang) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '级' AND pinyin = 'jí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '级' AND pinyin = 'jí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '级'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '级'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'jí',
      meaning_vi = 'cấp bậc, hạng, lớp, mức độ; bậc (thang)',
      example_hanzi = '他经过半年的努力备考，终于顺利通过了汉语水平考试五级。',
      example_pinyin = 'Tā jīngguò bàn nián de nǔlì bèikǎo, zhōngyú shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì Wǔ Jí.',
      example_vi = 'Qua nửa năm nỗ lực ôn thi, anh ấy cuối cùng đã thuận lợi thi đỗ kỳ thi Năng lực Hán ngữ cấp 5.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '级',
      'jí',
      'cấp bậc, hạng, lớp, mức độ; bậc (thang)',
      'Danh từ / Lượng từ',
      'HSK 5',
      '他经过半年的努力备考，终于顺利通过了汉语水平考试五级。',
      'Tā jīngguò bàn nián de nǔlì bèikǎo, zhōngyú shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì Wǔ Jí.',
      'Qua nửa năm nỗ lực ôn thi, anh ấy cuối cùng đã thuận lợi thi đỗ kỳ thi Năng lực Hán ngữ cấp 5.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他经过半年的努力备考，终于顺利通过了汉语水平考试五级。', 'Tā jīngguò bàn nián de nǔlì bèikǎo, zhōngyú shùnlì tōngguò le Hànyǔ Shuǐpíng Kǎoshì Wǔ Jí.', 'Qua nửa năm nỗ lực ôn thi, anh ấy cuối cùng đã thuận lợi thi đỗ kỳ thi Năng lực Hán ngữ cấp 5.', 'basic', 1),
      (v_id, '气象台发布了台风最高级别的红色预警信号，沿海各地已紧急启动防汛抗台一级应急响应机制。', 'Qìxiàngtái fābù le táifēng zuì gāo jíbié de hóngsè yùjǐng xìnhào, yánhǎi gèdì yǐ jǐnjí qǐdòng fángxùn-kàngtái yī jí yīngjí xiǎngyìng jīzhì.', 'Đài khí tượng đã phát tín hiệu cảnh báo bão cấp đỏ cao nhất, các địa phương ven biển đã khẩn trương kích hoạt cơ chế ứng phó khẩn cấp cấp độ một về phòng chống lụt bão.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2527] [集] (jí) - tập (phim, sách); chợ phiên, tập hợp [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '集' AND pinyin = 'jí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '集' AND pinyin = 'jí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '集'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '集'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'jí',
      meaning_vi = 'tập (phim, sách); chợ phiên, tập hợp',
      example_hanzi = '这部历史电视剧一共有四十集，剧情跌宕起伏引人入胜。',
      example_pinyin = 'Zhè bù lìshǐ diànshìjù yígòng yǒu sìshí jí, jùqíng diēdàng-qǐfú yǐnrén-rùshèng.',
      example_vi = 'Bộ phim truyền hình lịch sử này gồm tất cả 40 tập, tình tiết thăng trầm lôi cuốn người xem.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '集',
      'jí',
      'tập (phim, sách); chợ phiên, tập hợp',
      'Danh từ / Lượng từ',
      'HSK 5',
      '这部历史电视剧一共有四十集，剧情跌宕起伏引人入胜。',
      'Zhè bù lìshǐ diànshìjù yígòng yǒu sìshí jí, jùqíng diēdàng-qǐfú yǐnrén-rùshèng.',
      'Bộ phim truyền hình lịch sử này gồm tất cả 40 tập, tình tiết thăng trầm lôi cuốn người xem.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这部历史电视剧一共有四十集，剧情跌宕起伏引人入胜。', 'Zhè bù lìshǐ diànshìjù yígòng yǒu sìshí jí, jùqíng diēdàng-qǐfú yǐnrén-rùshèng.', 'Bộ phim truyền hình lịch sử này gồm tất cả 40 tập, tình tiết thăng trầm lôi cuốn người xem.', 'basic', 1),
      (v_id, '出版社精心编纂出版了这套学术论文集，全面展示了该学科近十年来的核心研究成果。', 'Chūbǎnshè jīngxīn biānzuǎn chūbǎn le zhè tào xuéshù lùnwénjí, quánmiàn zhǎnshì le gāi xuékē jìn shí nián lái de héxīn yánjiū chéngguǒ.', 'Nhà xuất bản đã biên soạn công phu và ấn hành tập kỷ yếu luận văn học thuật này, thể hiện toàn diện các thành quả nghiên cứu cốt lõi của ngành học trong suốt 10 năm qua.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2528] [疾病] (jíbìng) - bệnh tật, căn bệnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '疾病' AND pinyin = 'jíbìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '疾病' AND pinyin = 'jíbìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '疾病'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '疾病'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jíbìng',
      meaning_vi = 'bệnh tật, căn bệnh',
      example_hanzi = '保持良好的作息习惯和合理的饮食能够预防许多常见疾病。',
      example_pinyin = 'Bǎochí liánghǎo de zuòxī xíguàn hé hélǐ de yǐnshí nénggòu yùfáng xǔduō chángjiàn jíbìng.',
      example_vi = 'Duy trì thói quen sinh hoạt tốt và ăn uống hợp lý có thể phòng ngừa nhiều căn bệnh thường gặp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '疾病',
      'jíbìng',
      'bệnh tật, căn bệnh',
      'Danh từ',
      'HSK 5',
      '保持良好的作息习惯和合理的饮食能够预防许多常见疾病。',
      'Bǎochí liánghǎo de zuòxī xíguàn hé hélǐ de yǐnshí nénggòu yùfáng xǔduō chángjiàn jíbìng.',
      'Duy trì thói quen sinh hoạt tốt và ăn uống hợp lý có thể phòng ngừa nhiều căn bệnh thường gặp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '保持良好的作息习惯和合理的饮食能够预防许多常见疾病。', 'Bǎochí liánghǎo de zuòxī xíguàn hé hélǐ de yǐnshí nénggòu yùfáng xǔduō chángjiàn jíbìng.', 'Duy trì thói quen sinh hoạt tốt và ăn uống hợp lý có thể phòng ngừa nhiều căn bệnh thường gặp.', 'basic', 1),
      (v_id, '早期基因筛查与定期靶向体检，为慢性心血管疾病及恶性肿瘤的早发现、早干预提供了坚实的技术保障。', 'Zǎoqī jīyīn shāichá yǔ dìngqī bǎxiàng tǐjiǎn, wèi mànxìng xīn-xiěguǎn jíbìng jí èxìng zhǒngliú de zǎo fāxiàn, zǎo gānyù tígōng le jiānshí de jìshù bǎozhàng.', 'Tầm soát gen sớm và khám sức khỏe định kỳ có mục tiêu đã cung cấp bảo đảm kỹ thuật vững chắc cho việc phát hiện và can thiệp sớm các bệnh tim mạch mạn tính cũng như khối u ác tính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2529] [及格] (jígé) - đạt điểm chuẩn, đủ điểm đỗ, đạt yêu cầu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '及格' AND pinyin = 'jígé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '及格' AND pinyin = 'jígé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '及格'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '及格'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jígé',
      meaning_vi = 'đạt điểm chuẩn, đủ điểm đỗ, đạt yêu cầu',
      example_hanzi = '经过老师的辅导和自己的刻苦复习，他的期末数学成绩终于及格了。',
      example_pinyin = 'Jīngguò lǎoshī de fǔdǎo hé zìjǐ de kèkǔ fùxí, tā de qīmò shùxué chéngjì zhōngyú jígé le.',
      example_vi = 'Qua sự phụ đạo của thầy cô và sự nỗ lực ôn tập của bản thân, điểm môn Toán cuối kỳ của cậu ấy cuối cùng đã đạt điểm chuẩn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '及格',
      'jígé',
      'đạt điểm chuẩn, đủ điểm đỗ, đạt yêu cầu',
      'Động từ',
      'HSK 5',
      '经过老师的辅导和自己的刻苦复习，他的期末数学成绩终于及格了。',
      'Jīngguò lǎoshī de fǔdǎo hé zìjǐ de kèkǔ fùxí, tā de qīmò shùxué chéngjì zhōngyú jígé le.',
      'Qua sự phụ đạo của thầy cô và sự nỗ lực ôn tập của bản thân, điểm môn Toán cuối kỳ của cậu ấy cuối cùng đã đạt điểm chuẩn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过老师的辅导和自己的刻苦复习，他的期末数学成绩终于及格了。', 'Jīngguò lǎoshī de fǔdǎo hé zìjǐ de kèkǔ fùxí, tā de qīmò shùxué chéngjì zhōngyú jígé le.', 'Qua sự phụ đạo của thầy cô và sự nỗ lực ôn tập của bản thân, điểm môn Toán cuối kỳ của cậu ấy cuối cùng đã đạt điểm chuẩn.', 'basic', 1),
      (v_id, '对于高端制造业而言，合格率仅仅达到及格线是远远不够的，必须追求零缺陷与极致的工艺品质。', 'Duìyú gāoduān zhìzàoyè ér yán, hégélǜ jǐnjǐn dádào jígéxiàn shì yuǎnyuǎn bú gòu de, bìxū zhuīqiú líng quēxiàn yǔ jízhì de gōngyì pǐnzhì.', 'Đối với ngành chế tạo cao cấp mà nói, tỷ lệ hợp chuẩn chỉ đạt mức vừa đủ qua chuẩn là hoàn toàn không đủ, mà phải theo đuổi tỷ lệ không lỗi và phẩm chất gia công đỉnh cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2530] [集合] (jíhé) - tập hợp, tụ họp, tập trung lại [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '集合' AND pinyin = 'jíhé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '集合' AND pinyin = 'jíhé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '集合'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '集合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jíhé',
      meaning_vi = 'tập hợp, tụ họp, tập trung lại',
      example_hanzi = '明天早上七点半，全班同学在学校正大门口集合乘车。',
      example_pinyin = 'Míngtiān zǎoshang qī diǎn bàn, quán bān tóngxué zài xuéxiào zhèng dàménkǒu jíhé chéngchē.',
      example_vi = '7 giờ 30 sáng mai, cả lớp tập trung tại cổng chính của trường để lên xe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '集合',
      'jíhé',
      'tập hợp, tụ họp, tập trung lại',
      'Động từ',
      'HSK 5',
      '明天早上七点半，全班同学在学校正大门口集合乘车。',
      'Míngtiān zǎoshang qī diǎn bàn, quán bān tóngxué zài xuéxiào zhèng dàménkǒu jíhé chéngchē.',
      '7 giờ 30 sáng mai, cả lớp tập trung tại cổng chính của trường để lên xe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '明天早上七点半，全班同学在学校正大门口集合乘车。', 'Míngtiān zǎoshang qī diǎn bàn, quán bān tóngxué zài xuéxiào zhèng dàménkǒu jíhé chéngchē.', '7 giờ 30 sáng mai, cả lớp tập trung tại cổng chính của trường để lên xe.', 'basic', 1),
      (v_id, '应急指挥中心在接到重大灾情通报后，仅用二十分钟便迅速完成了专业救援人员与急救物资的集结整备。', 'Yìngjí zhǐhuī zhōngxīn zài jiēdào zhòngdà zāiqíng tōngbào hòu, jǐn yòng èrshí fēnzhōng biàn xùnsù wánchéng le zhuānyè jiùyuán rényuán yǔ jíjiù wùzī de jíjié zhěngbèi.', 'Trung tâm chỉ huy cứu hộ khẩn cấp sau khi nhận được thông báo thiên tai nghiêm trọng, chỉ mất đúng 20 phút đã nhanh chóng hoàn tất việc tập kết và chuẩn bị đội ngũ cứu hộ chuyên môn cùng vật tư cứu nạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2531] [即将] (jíjiāng) - sắp sửa, sắp tới, chuẩn bị [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '即将' AND pinyin = 'jíjiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '即将' AND pinyin = 'jíjiāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '即将'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '即将'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jíjiāng',
      meaning_vi = 'sắp sửa, sắp tới, chuẩn bị',
      example_hanzi = '大学生活即将结束，同学们都在忙着准备毕业论文和找工作。',
      example_pinyin = 'Dàxué shēnghuó jíjiāng jiéshù, tóngxuémen dōu zài máng zhe zhǔnbèi bìyè lùnwén hé zhǎo gōngzuò.',
      example_vi = 'Quãng đời sinh viên đại học sắp sửa kết thúc, các bạn học sinh đều đang bận rộn chuẩn bị khóa luận tốt nghiệp và tìm việc làm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '即将',
      'jíjiāng',
      'sắp sửa, sắp tới, chuẩn bị',
      'Phó từ',
      'HSK 5',
      '大学生活即将结束，同学们都在忙着准备毕业论文和找工作。',
      'Dàxué shēnghuó jíjiāng jiéshù, tóngxuémen dōu zài máng zhe zhǔnbèi bìyè lùnwén hé zhǎo gōngzuò.',
      'Quãng đời sinh viên đại học sắp sửa kết thúc, các bạn học sinh đều đang bận rộn chuẩn bị khóa luận tốt nghiệp và tìm việc làm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '大学生活即将结束，同学们都在忙着准备毕业论文和找工作。', 'Dàxué shēnghuó jíjiāng jiéshù, tóngxuémen dōu zài máng zhe zhǔnbèi bìyè lùnwén hé zhǎo gōngzuò.', 'Quãng đời sinh viên đại học sắp sửa kết thúc, các bạn học sinh đều đang bận rộn chuẩn bị khóa luận tốt nghiệp và tìm việc làm.', 'basic', 1),
      (v_id, '连接两座经济重镇的高铁干线即将全线开通运营，这对于促进区域协同发展具有极为深远的战略意义。', 'Liánjiē liǎng zuò jīngjì zhòngzhèn de gāotiě gànxiàn jíjiāng quánxiàn kāitōng yùnyíng, zhè duìyú cùjìn qūyù xiétóng fāzhǎn jùyǒu jíwéi shēnyuǎn de zhànlüè yìyì.', 'Tuyến đường sắt cao tốc huyết mạch nối liền hai trung tâm kinh tế trọng điểm sắp sửa được đưa vào vận hành toàn tuyến, điều này có ý nghĩa chiến lược vô cùng sâu rộng đối với việc thúc đẩy sự phát triển liên kết vùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2532] [急忙] (jímáng) - vội vã, cuống cuồng, hớt hải [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '急忙' AND pinyin = 'jímáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '急忙' AND pinyin = 'jímáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '急忙'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '急忙'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jímáng',
      meaning_vi = 'vội vã, cuống cuồng, hớt hải',
      example_hanzi = '眼看要下大雨了，行人们急忙收起摊位或者快步跑向屋檐下躲雨。',
      example_pinyin = 'Yǎnkàn yào xià dàyǔ le, xíngrénmen jímáng shōuqǐ tānwèi huòzhě kuàibù pǎoxiàng wūyán xià duǒyǔ.',
      example_vi = 'Trông thấy trời sắp đổ mưa rào, người đi đường vội vã thu dọn sạp hàng hoặc rảo bước chạy vào dưới mái hiên để trú mưa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '急忙',
      'jímáng',
      'vội vã, cuống cuồng, hớt hải',
      'Phó từ',
      'HSK 5',
      '眼看要下大雨了，行人们急忙收起摊位或者快步跑向屋檐下躲雨。',
      'Yǎnkàn yào xià dàyǔ le, xíngrénmen jímáng shōuqǐ tānwèi huòzhě kuàibù pǎoxiàng wūyán xià duǒyǔ.',
      'Trông thấy trời sắp đổ mưa rào, người đi đường vội vã thu dọn sạp hàng hoặc rảo bước chạy vào dưới mái hiên để trú mưa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '眼看要下大雨了，行人们急忙收起摊位或者快步跑向屋檐下躲雨。', 'Yǎnkàn yào xià dàyǔ le, xíngrénmen jímáng shōuqǐ tānwèi huòzhě kuàibù pǎoxiàng wūyán xià duǒyǔ.', 'Trông thấy trời sắp đổ mưa rào, người đi đường vội vã thu dọn sạp hàng hoặc rảo bước chạy vào dưới mái hiên để trú mưa.', 'basic', 1),
      (v_id, '在突发网络安全威胁通报发出后，系统工程师团队急忙登录云端服务器并连夜部署紧急补丁程序。', 'Zài tūfā wǎngluò ānquán wēixié tōngbào fāchū hòu, xìtǒng gōngchéngshī tuánduì jímáng dēnglù yúnduān fúwùqì bìng liányè bùshǔ jǐnjí bǔdīng chéngxù.', 'Sau khi thông báo về mối đe dọa an ninh mạng đột xuất được ban bố, đội ngũ kỹ sư hệ thống đã vội vã đăng nhập vào máy chủ đám mây và thức trắng đêm triển khai bản vá khẩn cấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2533] [极其] (jíqí) - cực kỳ, hết sức, vô cùng [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '极其' AND pinyin = 'jíqí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '极其' AND pinyin = 'jíqí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '极其'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '极其'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jíqí',
      meaning_vi = 'cực kỳ, hết sức, vô cùng',
      example_hanzi = '他在工作中极其认真负责，每一个细节都会仔细核实。',
      example_pinyin = 'Tā zài gōngzuò zhōng jíqí rènzhēn fùzé, měi yí gè xìjié dōu huì zǐxì héshí.',
      example_vi = 'Anh ấy cực kỳ nghiêm túc và có trách nhiệm trong công việc, từng chi tiết một đều được kiểm chứng kỹ lưỡng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '极其',
      'jíqí',
      'cực kỳ, hết sức, vô cùng',
      'Phó từ',
      'HSK 5',
      '他在工作中极其认真负责，每一个细节都会仔细核实。',
      'Tā zài gōngzuò zhōng jíqí rènzhēn fùzé, měi yí gè xìjié dōu huì zǐxì héshí.',
      'Anh ấy cực kỳ nghiêm túc và có trách nhiệm trong công việc, từng chi tiết một đều được kiểm chứng kỹ lưỡng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在工作中极其认真负责，每一个细节都会仔细核实。', 'Tā zài gōngzuò zhōng jíqí rènzhēn fùzé, měi yí gè xìjié dōu huì zǐxì héshí.', 'Anh ấy cực kỳ nghiêm túc và có trách nhiệm trong công việc, từng chi tiết một đều được kiểm chứng kỹ lưỡng.', 'basic', 1),
      (v_id, '深海科考探测处于高压、严寒与完全黑暗的极端物理环境下，对潜水器的耐压材质提出了极其苛刻的要求。', 'Shēnhǎi kěkǎo tàncè chǔyú gāoyā, yánhán yǔ wánquán hēi’àn de jíduān wùlǐ huánjìng xià, duì qiánshuǐqì de nàiyā cáizhì tíchū le jíqí kīkè de yāoqiú.', 'Hoạt động nghiên cứu thám hiểm biển sâu diễn ra trong môi trường vật lý cực đoan với áp suất cực lớn, giá lạnh và bóng tối hoàn toàn, đặt ra những yêu cầu hết sức khắt khe đối với vật liệu chịu áp suất của tàu lặn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2534] [集体] (jítǐ) - tập thể, đoàn thể [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '集体' AND pinyin = 'jítǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '集体' AND pinyin = 'jítǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '集体'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '集体'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jítǐ',
      meaning_vi = 'tập thể, đoàn thể',
      example_hanzi = '这次活动的成功举办，离不开全班集体的共同付出与紧密合作。',
      example_pinyin = 'Zhè cì huódòng de chénggōng jǔbàn, lìbùkāi quán bān jítǐ de gòngtóng fùchū yǔ jǐnmì hézuò.',
      example_vi = 'Sự tổ chức thành công của hoạt động lần này không thể tách rời sự đóng góp chung và phối hợp chặt chẽ của cả tập thể lớp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '集体',
      'jítǐ',
      'tập thể, đoàn thể',
      'Danh từ',
      'HSK 5',
      '这次活动的成功举办，离不开全班集体的共同付出与紧密合作。',
      'Zhè cì huódòng de chénggōng jǔbàn, lìbùkāi quán bān jítǐ de gòngtóng fùchū yǔ jǐnmì hézuò.',
      'Sự tổ chức thành công của hoạt động lần này không thể tách rời sự đóng góp chung và phối hợp chặt chẽ của cả tập thể lớp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这次活动的成功举办，离不开全班集体的共同付出与紧密合作。', 'Zhè cì huódòng de chénggōng jǔbàn, lìbùkāi quán bān jítǐ de gòngtóng fùchū yǔ jǐnmì hézuò.', 'Sự tổ chức thành công của hoạt động lần này không thể tách rời sự đóng góp chung và phối hợp chặt chẽ của cả tập thể lớp.', 'basic', 1),
      (v_id, '公司提倡将个人职业理想融入企业集体奋斗目标之中，依托集体智慧不断突破行业关键核心技术瓶颈。', 'Gōngsī tíchàng jiāng gèrén zhíyè lǐxiǎng róngrù qǐyè jítǐ fèndòu mùbiāo zhīzhōng, yītuō jítǐ zhìhuì búduàn tūpò hángyè guānjiàn héxīn jìshù píngjǐng.', 'Công ty chủ trương hòa quyện lý tưởng sự nghiệp cá nhân vào mục tiêu phấn đấu tập thể của doanh nghiệp, dựa vào trí tuệ tập thể để không ngừng đột phá những điểm nghẽn công nghệ cốt lõi của ngành.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2535] [急需] (jíxū) - rất cần, khẩn cấp cần đến [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '急需' AND pinyin = 'jíxū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '急需' AND pinyin = 'jíxū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '急需'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '急需'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jíxū',
      meaning_vi = 'rất cần, khẩn cấp cần đến',
      example_hanzi = '灾区群众目前急需帐篷、保暖棉被和干净的饮用水。',
      example_pinyin = 'Zāiqū qúnzhòng mùqián jíxū zhàngpeng, bǎonuǎn miánbèi hé gānjìng de yǐnyòngshuǐ.',
      example_vi = 'Bà con vùng thiên tai hiện tại đang rất cần lều bạt, chăn bông giữ ấm và nước uống sạch.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '急需',
      'jíxū',
      'rất cần, khẩn cấp cần đến',
      'Động từ',
      'HSK 5',
      '灾区群众目前急需帐篷、保暖棉被和干净的饮用水。',
      'Zāiqū qúnzhòng mùqián jíxū zhàngpeng, bǎonuǎn miánbèi hé gānjìng de yǐnyòngshuǐ.',
      'Bà con vùng thiên tai hiện tại đang rất cần lều bạt, chăn bông giữ ấm và nước uống sạch.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '灾区群众目前急需帐篷、保暖棉被和干净的饮用水。', 'Zāiqū qúnzhòng mùqián jíxū zhàngpeng, bǎonuǎn miánbèi hé gānjìng de yǐnyòngshuǐ.', 'Bà con vùng thiên tai hiện tại đang rất cần lều bạt, chăn bông giữ ấm và nước uống sạch.', 'basic', 1),
      (v_id, '随着半导体集成电路产业的加速升级，国内高精尖芯片设计与制造领域正急需大量具有实操经验的领军技术人才。', 'Suízhe bàndǎotǐ jíchéng diànlù chǎnyè de jiāsù shēngjí, guónèi gāojīngjiān xīanpiàn shèjì yǔ zhìzào lǐngyù zhèng jíxū dàliàng jùyǒu shícāo jīngyàn de lǐngjūn jìshù réncái.', 'Cùng với sự nâng cấp nhanh chóng của ngành mạch tích hợp bán dẫn, lĩnh vực thiết kế và sản xuất chip công nghệ cao trong nước đang rất cần lượng lớn các nhân tài kỹ thuật dẫn đầu có kinh nghiệm thực chiến.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2536] [急诊] (jízhěn) - cấp cứu, phòng cấp cứu; khám cấp cứu [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '急诊' AND pinyin = 'jízhěn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '急诊' AND pinyin = 'jízhěn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '急诊'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '急诊'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'jízhěn',
      meaning_vi = 'cấp cứu, phòng cấp cứu; khám cấp cứu',
      example_hanzi = '孩子突发高烧不退，爸爸赶紧开车送他去医院看急诊。',
      example_pinyin = 'Háizi tūfā gāoshāo bú tuì, bàba gǎnjǐn kāichē sòng tā qù yīyuàn kàn jízhěn.',
      example_vi = 'Đứa bé đột ngột sốt cao không hạ, người cha liền vội vã lái xe đưa con vào bệnh viện khám cấp cứu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '急诊',
      'jízhěn',
      'cấp cứu, phòng cấp cứu; khám cấp cứu',
      'Danh từ / Động từ',
      'HSK 5',
      '孩子突发高烧不退，爸爸赶紧开车送他去医院看急诊。',
      'Háizi tūfā gāoshāo bú tuì, bàba gǎnjǐn kāichē sòng tā qù yīyuàn kàn jízhěn.',
      'Đứa bé đột ngột sốt cao không hạ, người cha liền vội vã lái xe đưa con vào bệnh viện khám cấp cứu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '孩子突发高烧不退，爸爸赶紧开车送他去医院看急诊。', 'Háizi tūfā gāoshāo bú tuì, bàba gǎnjǐn kāichē sòng tā qù yīyuàn kàn jízhěn.', 'Đứa bé đột ngột sốt cao không hạ, người cha liền vội vã lái xe đưa con vào bệnh viện khám cấp cứu.', 'basic', 1),
      (v_id, '三甲医院建立了完善的胸痛与卒中绿色急诊通道，确保危急重症患者在黄金抢救时间内获得最高水平的多学科协同救治。', 'Sānjiǎ yīyuàn jiànlì le wánshàn de xiōngtòng yǔ cùzhòng lǜsè jízhěn tōngdào, quèbǎo wēijí-zhòngzhèng huànzhě zài huángjīn qiǎngjiù shíjiān nèi huòdé zuì gāo shuǐpíng de duōxuékē xiétóng jiùzhì.', 'Bệnh viện tuyến đầu đã thiết lập luồng cấp cứu xanh hoàn chỉnh cho các ca đau ngực và đột quỵ, bảo đảm bệnh nhân nguy kịch được điều trị phối hợp đa chuyên khoa ở trình độ cao nhất ngay trong thời gian vàng cấp cứu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2537] [集中] (jízhōng) - tập trung; dồn sức [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '集中' AND pinyin = 'jízhōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '集中' AND pinyin = 'jízhōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '集中'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '集中'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'jízhōng',
      meaning_vi = 'tập trung; dồn sức',
      example_hanzi = '上课的时候一定要集中注意力，认真听讲并做好笔记。',
      example_pinyin = 'Shàngkè de shíhou yídìng yào jízhōng zhùyìlì, rènzhēn tīngjiǎng bìng zuò hǎo bǐjì.',
      example_vi = 'Trong giờ học nhất định phải tập trung chú ý, chăm chú nghe giảng và ghi chép cẩn thận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '集中',
      'jízhōng',
      'tập trung; dồn sức',
      'Động từ / Tính từ',
      'HSK 5',
      '上课的时候一定要集中注意力，认真听讲并做好笔记。',
      'Shàngkè de shíhou yídìng yào jízhōng zhùyìlì, rènzhēn tīngjiǎng bìng zuò hǎo bǐjì.',
      'Trong giờ học nhất định phải tập trung chú ý, chăm chú nghe giảng và ghi chép cẩn thận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '上课的时候一定要集中注意力，认真听讲并做好笔记。', 'Shàngkè de shíhou yídìng yào jízhōng zhùyìlì, rènzhēn tīngjiǎng bìng zuò hǎo bǐjì.', 'Trong giờ học nhất định phải tập trung chú ý, chăm chú nghe giảng và ghi chép cẩn thận.', 'basic', 1),
      (v_id, '该经济特区实行集中审批与全流程数字监管模式，显著提升了招商引资项目落地建设的行政审批效率。', 'Gāi jīngjì tèqū shíxíng jízhōng shěnpī yǔ quánliúchéng shùzì jiānguǎn móshì, xiǎnzhù tíshēng le zhāoshāng yǐnzī xiàngmù luòdì jiànshè de xíngzhèng shěnpī xiàolǜ.', 'Khu đặc quyền kinh tế này thực thi mô hình thẩm định tập trung và giám sát số toàn bộ quy trình, nâng cao rõ rệt hiệu quả phê duyệt hành chính đối với việc triển khai xây dựng các dự án thu hút đầu tư.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2538] [挤] (jǐ) - chen chúc, chen lấn; vắt, ép; đông đúc, chật chội [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '挤' AND pinyin = 'jǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挤' AND pinyin = 'jǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '挤'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挤'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'jǐ',
      meaning_vi = 'chen chúc, chen lấn; vắt, ép; đông đúc, chật chội',
      example_hanzi = '早高峰时期的地铁车厢里总是挤满了赶着去上班的人群。',
      example_pinyin = 'Zǎogāofēng shíqī de dìtiě chēxiāng lǐ zǒngshì jǐmǎn le gǎn zhe qù shàngbān de rénqún.',
      example_vi = 'Trong toa tàu điện ngầm vào giờ cao điểm buổi sáng lúc nào cũng chật ních dòng người đang vội vã đi làm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '挤',
      'jǐ',
      'chen chúc, chen lấn; vắt, ép; đông đúc, chật chội',
      'Động từ / Tính từ',
      'HSK 5',
      '早高峰时期的地铁车厢里总是挤满了赶着去上班的人群。',
      'Zǎogāofēng shíqī de dìtiě chēxiāng lǐ zǒngshì jǐmǎn le gǎn zhe qù shàngbān de rénqún.',
      'Trong toa tàu điện ngầm vào giờ cao điểm buổi sáng lúc nào cũng chật ních dòng người đang vội vã đi làm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '早高峰时期的地铁车厢里总是挤满了赶着去上班的人群。', 'Zǎogāofēng shíqī de dìtiě chēxiāng lǐ zǒngshì jǐmǎn le gǎn zhe qù shàngbān de rénqún.', 'Trong toa tàu điện ngầm vào giờ cao điểm buổi sáng lúc nào cũng chật ních dòng người đang vội vã đi làm.', 'basic', 1),
      (v_id, '初创公司在巨头林立的红海市场中，必须依靠敏锐的市场洞察与差异化创新产品，才能成功挤出属于自己的一席之地。', 'Chūchuàng gōngsī zài jùtóu línlì de hónghǎi shìchǎng zhōng, bìxū yīkào mǐnruì de shìchǎng dòngchá yǔ chāyìhuà chuàngxīn chǎnpǐn, cáinéng chénggōng jǐ chū shǔyú zìjǐ de yì xí zhī dì.', 'Doanh nghiệp khởi nghiệp giữa thị trường biển đỏ đầy rẫy các ông lớn buộc phải dựa vào sự thấu thị thị trường nhạy bén và sản phẩm đổi mới khác biệt hóa thì mới có thể thành công chen chân tìm được một chỗ đứng cho riêng mình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2539] [系] (jì) - thắt, buộc, cài (dây an toàn, cà vạt, dây giày) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '系' AND pinyin = 'jì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '系' AND pinyin = 'jì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '系'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '系'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jì',
      meaning_vi = 'thắt, buộc, cài (dây an toàn, cà vạt, dây giày)',
      example_hanzi = '汽车行驶前，司机和乘车人员都应当自觉系好安全带。',
      example_pinyin = 'Qìchē xíngshǐ qián, sījī hé chéngchē rényuán dōu yīngdāng zìjué jì hǎo ānquándài.',
      example_vi = 'Trước khi xe lăn bánh, người lái và hành khách trên xe đều nên tự giác thắt dây an toàn cẩn thận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '系',
      'jì',
      'thắt, buộc, cài (dây an toàn, cà vạt, dây giày)',
      'Động từ',
      'HSK 5',
      '汽车行驶前，司机和乘车人员都应当自觉系好安全带。',
      'Qìchē xíngshǐ qián, sījī hé chéngchē rényuán dōu yīngdāng zìjué jì hǎo ānquándài.',
      'Trước khi xe lăn bánh, người lái và hành khách trên xe đều nên tự giác thắt dây an toàn cẩn thận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '汽车行驶前，司机和乘车人员都应当自觉系好安全带。', 'Qìchē xíngshǐ qián, sījī hé chéngchē rényuán dōu yīngdāng zìjué jì hǎo ānquándài.', 'Trước khi xe lăn bánh, người lái và hành khách trên xe đều nên tự giác thắt dây an toàn cẩn thận.', 'basic', 1),
      (v_id, '在高空作业与悬崖攀爬救援过程中，专业人员必须严格规范系牢主副双重安全绳锁以防发生意外。', 'Zài gāokōng zuòyè yǔ xuányá pānpá jiùyuán guòchéng zhōng, zhuānyè rényuán bìxū yángé guīfàn jì láo zhǔ-fù shuāngchóng ānquán shéngsuǒ yǐ fáng fāshēng yìwài.', 'Trong quá trình thi công trên cao và cứu hộ leo vách đá, nhân viên chuyên môn cần tuân thủ nghiêm ngặt quy định thắt chặt cả khóa dây an toàn chính lẫn phụ để đề phòng tai nạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2540] [季度] (jìdù) - quý (khoảng thời gian 3 tháng) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '季度' AND pinyin = 'jìdù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '季度' AND pinyin = 'jìdù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '季度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '季度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìdù',
      meaning_vi = 'quý (khoảng thời gian 3 tháng)',
      example_hanzi = '公司每个季度末都会组织各部门召开一次全面的业务总结大会。',
      example_pinyin = 'Gōngsī měi gè jìdù mò dōu huì zǔzhī gè bùmén zhàokāi yí cì quánmiàn de yèwù zǒngjié dàhuì.',
      example_vi = 'Vào cuối mỗi quý, công ty đều tổ chức cho các phòng ban họp đại hội tổng kết nghiệp vụ toàn diện một lần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '季度',
      'jìdù',
      'quý (khoảng thời gian 3 tháng)',
      'Danh từ',
      'HSK 5',
      '公司每个季度末都会组织各部门召开一次全面的业务总结大会。',
      'Gōngsī měi gè jìdù mò dōu huì zǔzhī gè bùmén zhàokāi yí cì quánmiàn de yèwù zǒngjié dàhuì.',
      'Vào cuối mỗi quý, công ty đều tổ chức cho các phòng ban họp đại hội tổng kết nghiệp vụ toàn diện một lần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '公司每个季度末都会组织各部门召开一次全面的业务总结大会。', 'Gōngsī měi gè jìdù mò dōu huì zǔzhī gè bùmén zhàokāi yí cì quánmiàn de yèwù zǒngjié dàhuì.', 'Vào cuối mỗi quý, công ty đều tổ chức cho các phòng ban họp đại hội tổng kết nghiệp vụ toàn diện một lần.', 'basic', 1),
      (v_id, '根据国家统计局公布的宏观数据，第三季度国内生产总值与对外贸易总额均实现了超预期的稳步增长。', 'Gēnjù guójiā tǒngjìjú gōngbù de hóngguān shùjù, dì-sān jìdù guónèi shēngchǎn zǒngzhí yǔ duìwài màoyì zǒng’é jūn shíxiàn le chāo yùqī de wěnbù zēngzhǎng.', 'Theo số liệu vĩ mô do Tổng cục Thống kê công bố, trong quý 3 cả tổng sản phẩm quốc nội lẫn kim ngạch ngoại thương đều đạt mức tăng trưởng vững chắc vượt dự kiến.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2541] [记录] (jìlù) - ghi chép, ghi lại; biên bản, nhật ký, bản ghi [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '记录' AND pinyin = 'jìlù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '记录' AND pinyin = 'jìlù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '记录'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '记录'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jìlù',
      meaning_vi = 'ghi chép, ghi lại; biên bản, nhật ký, bản ghi',
      example_hanzi = '秘书在会议上快速记录下每位领导发表的核心意见。',
      example_pinyin = 'Mìshū zài huìyì shang kuàisù jìlù xià měi wèi lǐngdǎo fābiǎo de héxīn yìjiàn.',
      example_vi = 'Thư ký trong cuộc họp nhanh chóng ghi lại những ý kiến cốt lõi do từng vị lãnh đạo phát biểu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '记录',
      'jìlù',
      'ghi chép, ghi lại; biên bản, nhật ký, bản ghi',
      'Động từ / Danh từ',
      'HSK 5',
      '秘书在会议上快速记录下每位领导发表的核心意见。',
      'Mìshū zài huìyì shang kuàisù jìlù xià měi wèi lǐngdǎo fābiǎo de héxīn yìjiàn.',
      'Thư ký trong cuộc họp nhanh chóng ghi lại những ý kiến cốt lõi do từng vị lãnh đạo phát biểu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '秘书在会议上快速记录下每位领导发表的核心意见。', 'Mìshū zài huìyì shang kuàisù jìlù xià měi wèi lǐngdǎo fābiǎo de héxīn yìjiàn.', 'Thư ký trong cuộc họp nhanh chóng ghi lại những ý kiến cốt lõi do từng vị lãnh đạo phát biểu.', 'basic', 1),
      (v_id, '实验人员必须详尽记录每一个化学反应阶段的温度、压力与物料配比参数，确保科学实验数据的完整性与可复现性。', 'Shíyàn rényuán bìxū xiángjìn jìlù měi yí gè huàxué fǎnyìng jiēduàn de wēndù, yālì yǔ wùliào pèibǐ cānshù, quèbǎo kēxué shíyàn shùjù de wánzhěngxìng yǔ kě fùxiànxìng.', 'Nhân viên thí nghiệm phải ghi chép chi tiết các thông số nhiệt độ, áp suất và tỷ lệ phối liệu trong từng giai đoạn phản ứng hóa học, bảo đảm tính toàn vẹn và khả năng tái lập của dữ liệu thí nghiệm khoa học.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2542] [纪录] (jìlù) - kỷ lục (thành tích cao nhất) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '纪录' AND pinyin = 'jìlù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纪录' AND pinyin = 'jìlù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '纪录'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纪录'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìlù',
      meaning_vi = 'kỷ lục (thành tích cao nhất)',
      example_hanzi = '他在百米赛跑中跑出了九秒九八的好成绩，打破了全校纪录。',
      example_pinyin = 'Tā zài bǎimǐ sàipǎo zhōng pǎochū le jiǔ miǎo jiǔ bā de hǎo chéngjì, dǎpò le quán xiào jìlù.',
      example_vi = 'Anh ấy đã đạt thành tích 9 giây 98 ở cự ly chạy 100m, phá vỡ kỷ lục của toàn trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '纪录',
      'jìlù',
      'kỷ lục (thành tích cao nhất)',
      'Danh từ',
      'HSK 5',
      '他在百米赛跑中跑出了九秒九八的好成绩，打破了全校纪录。',
      'Tā zài bǎimǐ sàipǎo zhōng pǎochū le jiǔ miǎo jiǔ bā de hǎo chéngjì, dǎpò le quán xiào jìlù.',
      'Anh ấy đã đạt thành tích 9 giây 98 ở cự ly chạy 100m, phá vỡ kỷ lục của toàn trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在百米赛跑中跑出了九秒九八的好成绩，打破了全校纪录。', 'Tā zài bǎimǐ sàipǎo zhōng pǎochū le jiǔ miǎo jiǔ bā de hǎo chéngjì, dǎpò le quán xiào jìlù.', 'Anh ấy đã đạt thành tích 9 giây 98 ở cự ly chạy 100m, phá vỡ kỷ lục của toàn trường.', 'basic', 1),
      (v_id, '这位短跑名将凭借顽强的毅力与科学的训练体系，在世界田径锦标赛上再次刷新了由自己保持的男子百米世界纪录。', 'Zhè wèi duǎnpǎo míngjiàng píngjiè wánqiáng de yìlì yǔ kēxué de xùnliàn tǐxì, zài shìjiè tiánjìng jǐnbiāosài shang zàicì shuāxīn le yóu zìjǐ bǎochí de nánzǐ bǎimǐ shìjiè jìlù.', 'Ngôi sao chạy cự ly ngắn này nhờ vào nghị lực ngoan cường cùng hệ thống huấn luyện khoa học, một lần nữa phá vỡ kỷ lục thế giới 100m nam do chính mình nắm giữ tại Giải vô địch Điền kinh thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2543] [纪录片] (jìlùpiàn) - phim tài liệu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '纪录片' AND pinyin = 'jìlùpiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纪录片' AND pinyin = 'jìlùpiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '纪录片'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纪录片'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìlùpiàn',
      meaning_vi = 'phim tài liệu',
      example_hanzi = '这部关于非洲野生动物生存现状的纪录片拍摄得非常震撼。',
      example_pinyin = 'Zhè bù guānyú Fēizhōu yěshēng dòngwù shēngcún xiànzhuàng de jìlùpiàn pāishè de fēicháng zhènhàn.',
      example_vi = 'Bộ phim tài liệu về thực trạng sinh tồn của động vật hoang dã châu Phi này được quay vô cùng ấn tượng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '纪录片',
      'jìlùpiàn',
      'phim tài liệu',
      'Danh từ',
      'HSK 5',
      '这部关于非洲野生动物生存现状的纪录片拍摄得非常震撼。',
      'Zhè bù guānyú Fēizhōu yěshēng dòngwù shēngcún xiànzhuàng de jìlùpiàn pāishè de fēicháng zhènhàn.',
      'Bộ phim tài liệu về thực trạng sinh tồn của động vật hoang dã châu Phi này được quay vô cùng ấn tượng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这部关于非洲野生动物生存现状的纪录片拍摄得非常震撼。', 'Zhè bù guānyú Fēizhōu yěshēng dòngwù shēngcún xiànzhuàng de jìlùpiàn pāishè de fēicháng zhènhàn.', 'Bộ phim tài liệu về thực trạng sinh tồn của động vật hoang dã châu Phi này được quay vô cùng ấn tượng.', 'basic', 1),
      (v_id, '大型人文历史纪录片《舌尖上的中国》以美食为生动载体，多维度呈现了中华农耕文明的博大精深与人间烟火温情。', 'Dàxíng rénwén lìshǐ jìlùpiàn 《Shéjiān shang de Zhōngguó》 yǐ měishí wéi shēngdòng zàitǐ, duō wéidù chéngxiàn le Zhōnghuá nónggēng wénmíng de bódà-jīngshēn yǔ rénjiān yānhuǒ wēnqíng.', 'Bộ phim tài liệu lịch sử nhân văn quy mô lớn "Mỹ vị Trung Hoa" lấy ẩm thực làm phương tiện chuyển tải sống động, tái hiện đa chiều sự uyên thâm của nền văn minh nông nghiệp Trung Hoa cùng hơi thở ấm áp đời thường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2544] [技能] (jìnéng) - kỹ năng, tay nghề [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '技能' AND pinyin = 'jìnéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '技能' AND pinyin = 'jìnéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '技能'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '技能'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìnéng',
      meaning_vi = 'kỹ năng, tay nghề',
      example_hanzi = '熟练掌握一门外语和计算机软件应用是一项非常有用的职业技能。',
      example_pinyin = 'Shúliàn zhǎngwò yì mén wàiyǔ hé jìsuànjī ruǎnjiàn yìngyòng shì yí xiàng fēicháng yǒuyòng de zhíyè jìnéng.',
      example_vi = 'Nắm vững thành thạo một ngoại ngữ và ứng dụng phần mềm máy tính là một kỹ năng nghề nghiệp vô cùng hữu ích.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '技能',
      'jìnéng',
      'kỹ năng, tay nghề',
      'Danh từ',
      'HSK 5',
      '熟练掌握一门外语和计算机软件应用是一项非常有用的职业技能。',
      'Shúliàn zhǎngwò yì mén wàiyǔ hé jìsuànjī ruǎnjiàn yìngyòng shì yí xiàng fēicháng yǒuyòng de zhíyè jìnéng.',
      'Nắm vững thành thạo một ngoại ngữ và ứng dụng phần mềm máy tính là một kỹ năng nghề nghiệp vô cùng hữu ích.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '熟练掌握一门外语和计算机软件应用是一项非常有用的职业技能。', 'Shúliàn zhǎngwò yì mén wàiyǔ hé jìsuànjī ruǎnjiàn yìngyòng shì yí xiàng fēicháng yǒuyòng de zhíyè jìnéng.', 'Nắm vững thành thạo một ngoại ngữ và ứng dụng phần mềm máy tính là một kỹ năng nghề nghiệp vô cùng hữu ích.', 'basic', 1),
      (v_id, '职业技术教育必须紧密对接现代产业体系转型需求，重点培养兼具深厚理论素养与卓越实操技能的复合型工匠人才。', 'Zhíyè jìshù jiàoyù bìxū jǐnmì duìjiē xiàndài chǎnyè tǐxì zhuǎnxíng xūqiú, zhòngdiǎn péiyǎng jiānjù shēnhòu lǐlùn sùyǎng yǔ zhuóyuè shícāo jìnéng de fùhéxíng gōngjiàng réncái.', 'Giáo dục kỹ thuật nghề nghiệp cần kết nối chặt chẽ với nhu cầu chuyển đổi hệ thống ngành nghề hiện đại, chú trọng bồi dưỡng đội ngũ nghệ nhân thợ lành nghề đa năng kết hợp tố chất lý thuyết vững vàng cùng kỹ năng thực hành xuất sắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2545] [纪念] (jìniàn) - kỷ niệm, tưởng nhớ; đồ lưu niệm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '纪念' AND pinyin = 'jìniàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纪念' AND pinyin = 'jìniàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '纪念'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纪念'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jìniàn',
      meaning_vi = 'kỷ niệm, tưởng nhớ; đồ lưu niệm',
      example_hanzi = '临别前，同学们相互赠送了精美的小礼品留作纪念。',
      example_pinyin = 'Línbié qián, tóngxuémen xiānghù zèngsòng le jīngměi de xiǎo lǐpǐn liú zuò jìniàn.',
      example_vi = 'Trước khi chia tay, các bạn học sinh tặng nhau những món quà nhỏ tinh xảo để làm kỷ niệm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '纪念',
      'jìniàn',
      'kỷ niệm, tưởng nhớ; đồ lưu niệm',
      'Động từ / Danh từ',
      'HSK 5',
      '临别前，同学们相互赠送了精美的小礼品留作纪念。',
      'Línbié qián, tóngxuémen xiānghù zèngsòng le jīngměi de xiǎo lǐpǐn liú zuò jìniàn.',
      'Trước khi chia tay, các bạn học sinh tặng nhau những món quà nhỏ tinh xảo để làm kỷ niệm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '临别前，同学们相互赠送了精美的小礼品留作纪念。', 'Línbié qián, tóngxuémen xiānghù zèngsòng le jīngměi de xiǎo lǐpǐn liú zuò jìniàn.', 'Trước khi chia tay, các bạn học sinh tặng nhau những món quà nhỏ tinh xảo để làm kỷ niệm.', 'basic', 1),
      (v_id, '社会各界代表在烈士纪念碑前肃立默哀并敬献花篮，深切纪念为国家独立和民族解放英勇献身的先烈们。', 'Shèhuì gèjiè dàibiǎo zài lièshì jìniànbēi qián sùlì mò’āi bìng jìngxiàn huālán, shēnqiè jìniàn wèi guójiā dúlì hé mínzú jiěfàng yīngyǒng xiànshēn de xiānlièmen.', 'Đại biểu các giới xã hội đứng trang nghiêm mặc niệm và dâng hoa trước bia tưởng niệm liệt sĩ, thành kính tưởng nhớ những bậc tiền bối anh dũng hy sinh vì độc lập dân tộc và tự do đất nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2546] [纪念日] (jìniànrì) - ngày kỷ niệm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '纪念日' AND pinyin = 'jìniànrì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纪念日' AND pinyin = 'jìniànrì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '纪念日'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '纪念日'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìniànrì',
      meaning_vi = 'ngày kỷ niệm',
      example_hanzi = '今天是他们结婚十周年的纪念日，全家人一起吃了一顿丰盛的晚餐。',
      example_pinyin = 'Jīntiān shì tāmen jiéhūn shí zhōunián de jìniànrì, quán jiārén yìqǐ chī le yí dùn fēngshèng de wǎncān.',
      example_vi = 'Hôm nay là ngày kỷ niệm 10 năm ngày cưới của họ, cả nhà cùng ăn một bữa tối thịnh soạn bên nhau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '纪念日',
      'jìniànrì',
      'ngày kỷ niệm',
      'Danh từ',
      'HSK 5',
      '今天是他们结婚十周年的纪念日，全家人一起吃了一顿丰盛的晚餐。',
      'Jīntiān shì tāmen jiéhūn shí zhōunián de jìniànrì, quán jiārén yìqǐ chī le yí dùn fēngshèng de wǎncān.',
      'Hôm nay là ngày kỷ niệm 10 năm ngày cưới của họ, cả nhà cùng ăn một bữa tối thịnh soạn bên nhau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天是他们结婚十周年的纪念日，全家人一起吃了一顿丰盛的晚餐。', 'Jīntiān shì tāmen jiéhūn shí zhōunián de jìniànrì, quán jiārén yìqǐ chī le yí dùn fēngshèng de wǎncān.', 'Hôm nay là ngày kỷ niệm 10 năm ngày cưới của họ, cả nhà cùng ăn một bữa tối thịnh soạn bên nhau.', 'basic', 1),
      (v_id, '在世界环境日与国际生物多样性纪念日来临之际，众多环保公益组织携手发起了一系列倡导低碳生活的大型公益宣传活动。', 'Zài Shìjiè Huánjìng Rì yǔ Guójì Shēngwù Duōyàngxìng Jìniànrì láilín zhījì, zhòngduō huánbǎo gōngyì zǔzhī xiéshǒu fāqǐ le yí xìliè chàngdǎo dītàn shēnghuó de dàxíng gōngyì xuānchuán huódòng.', 'Nhân dịp Ngày Môi trường Thế giới và Ngày Quốc tế Đa dạng sinh học, nhiều tổ chức bảo vệ môi trường đã chung tay phát động một chuỗi các hoạt động tuyên truyền cộng đồng quy mô lớn cổ vũ lối sống ít phát thải carbon.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2547] [计算] (jìsuàn) - tính toán, dự tính [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '计算' AND pinyin = 'jìsuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '计算' AND pinyin = 'jìsuàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '计算'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '计算'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jìsuàn',
      meaning_vi = 'tính toán, dự tính',
      example_hanzi = '请同学们用草稿纸仔细计算这道数学题的最终答案。',
      example_pinyin = 'Qǐng tóngxuémen yòng cǎogǎozhǐ zǐxì jìsuàn zhè dào shùxuétí de zuìzhōng dá’àn.',
      example_vi = 'Xin các bạn học sinh dùng giấy nháp tính toán thật cẩn thận đáp án cuối cùng của bài toán này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '计算',
      'jìsuàn',
      'tính toán, dự tính',
      'Động từ',
      'HSK 5',
      '请同学们用草稿纸仔细计算这道数学题的最终答案。',
      'Qǐng tóngxuémen yòng cǎogǎozhǐ zǐxì jìsuàn zhè dào shùxuétí de zuìzhōng dá’àn.',
      'Xin các bạn học sinh dùng giấy nháp tính toán thật cẩn thận đáp án cuối cùng của bài toán này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请同学们用草稿纸仔细计算这道数学题的最终答案。', 'Qǐng tóngxuémen yòng cǎogǎozhǐ zǐxì jìsuàn zhè dào shùxuétí de zuìzhōng dá’àn.', 'Xin các bạn học sinh dùng giấy nháp tính toán thật cẩn thận đáp án cuối cùng của bài toán này.', 'basic', 1),
      (v_id, '量子计算机利用量子叠加与纠缠原理，能够在极短时间内完成传统超级计算机需要耗费数百年才能算出的复杂高维矩阵计算。', 'Liàngzǐ jìsuànjī lìyòng liàngzǐ diéjiā yǔ jiūchán yuánlǐ, nénggòu zài jí duǎn shíjiān nèi wánchéng chuántǒng chāojí jìsuànjī xūyào hàofèi shù bǎi nián cáinéng suànchū de fùzá gāowéi jùzhèn jìsuàn.', 'Máy tính lượng tử ứng dụng nguyên lý chồng chập và rối lượng tử, có khả năng giải quyết trong nháy mắt những phép tính ma trận nhiều chiều phức tạp mà siêu máy tính truyền thống phải mất hàng trăm năm mới tính nổi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2548] [计算机] (jìsuànjī) - máy tính, máy vi tính [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '计算机' AND pinyin = 'jìsuànjī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '计算机' AND pinyin = 'jìsuànjī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '计算机'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '计算机'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jìsuànjī',
      meaning_vi = 'máy tính, máy vi tính',
      example_hanzi = '图书馆里配备了多台计算机，方便学生们查询各类图书资料。',
      example_pinyin = 'Túshūguǎn lǐ pèibèi le duō tái jìsuànjī, fāngbiàn xuéshengmen cháxún gèlèi túshū zīliào.',
      example_vi = 'Trong thư viện được trang bị nhiều dàn máy tính, tạo thuận tiện cho sinh viên tra cứu các loại tài liệu sách vở.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '计算机',
      'jìsuànjī',
      'máy tính, máy vi tính',
      'Danh từ',
      'HSK 5',
      '图书馆里配备了多台计算机，方便学生们查询各类图书资料。',
      'Túshūguǎn lǐ pèibèi le duō tái jìsuànjī, fāngbiàn xuéshengmen cháxún gèlèi túshū zīliào.',
      'Trong thư viện được trang bị nhiều dàn máy tính, tạo thuận tiện cho sinh viên tra cứu các loại tài liệu sách vở.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '图书馆里配备了多台计算机，方便学生们查询各类图书资料。', 'Túshūguǎn lǐ pèibèi le duō tái jìsuànjī, fāngbiàn xuéshengmen cháxún gèlèi túshū zīliào.', 'Trong thư viện được trang bị nhiều dàn máy tính, tạo thuận tiện cho sinh viên tra cứu các loại tài liệu sách vở.', 'basic', 1),
      (v_id, '高性能超级计算机群作为国家基础科研的重要战略重器，在气候模拟、航天工程动力学以及新药分子靶点筛选中发挥着无可替代的核心作用。', 'Gāo xìngnéng chāojí jìsuànjī qún zuòwéi guójiā jīchǔ kēyán de zhòngyào zhànlüè zhòngqì, zài qìhòu mónǐ, hángtiān gōngchéng dònglìxué yǐjí xīnyào fēnzǐ bǎdiǎn shāixuǎn zhōng fāhuī zhe wúkě tìdài de héxīn zuòyòng.', 'Hệ thống cụm siêu máy tính hiệu năng cao với tư cách là bảo bối chiến lược quan trọng của nghiên cứu khoa học cơ bản quốc gia, đóng vai trò cốt lõi không thể thay thế trong mô phỏng khí hậu, khí động lực học hàng không vũ trụ và sàng lọc phân tử đích phát triển thuốc mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2549] [记忆] (jìyì) - ký ức, trí nhớ; ghi nhớ [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '记忆' AND pinyin = 'jìyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '记忆' AND pinyin = 'jìyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '记忆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '记忆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'jìyì',
      meaning_vi = 'ký ức, trí nhớ; ghi nhớ',
      example_hanzi = '故乡门前的那条清澈小河，留下了我童年最美好的记忆。',
      example_pinyin = 'Gùxiāng ménqián de nà tiáo qīngchè xiǎohé, liúxià le wǒ tóngnián zuì měihǎo de jìyì.',
      example_vi = 'Dòng sông nhỏ trong vắt trước cửa quê nhà đã lưu giữ những ký ức tuổi thơ tươi đẹp nhất của tôi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '记忆',
      'jìyì',
      'ký ức, trí nhớ; ghi nhớ',
      'Danh từ / Động từ',
      'HSK 5',
      '故乡门前的那条清澈小河，留下了我童年最美好的记忆。',
      'Gùxiāng ménqián de nà tiáo qīngchè xiǎohé, liúxià le wǒ tóngnián zuì měihǎo de jìyì.',
      'Dòng sông nhỏ trong vắt trước cửa quê nhà đã lưu giữ những ký ức tuổi thơ tươi đẹp nhất của tôi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '故乡门前的那条清澈小河，留下了我童年最美好的记忆。', 'Gùxiāng ménqián de nà tiáo qīngchè xiǎohé, liúxià le wǒ tóngnián zuì měihǎo de jìyì.', 'Dòng sông nhỏ trong vắt trước cửa quê nhà đã lưu giữ những ký ức tuổi thơ tươi đẹp nhất của tôi.', 'basic', 1),
      (v_id, '神经科学研究表明，规律的深度睡眠和科学的联想记忆法，能显著增强大脑海马体对新信息的长时程记忆巩固。', 'Shénjīng kēxué yánjiū biǎomíng, guīlǜ de shēndù shuìmián hé kēxué de liánxiǎng jìyìfǎ, néng xiǎnzhù zēngqiáng dànǎo hǎimǎtǐ duì xīn xìnxī de chángshíchéng jìyì gǒnggù.', 'Nghiên cứu khoa học thần kinh chỉ ra rằng, giấc ngủ sâu điều độ và phương pháp liên tưởng ghi nhớ khoa học có thể nâng cao rõ rệt sự củng cố trí nhớ dài hạn của hồi hải mã não bộ đối với thông tin mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2550] [记载] (jìzǎi) - ghi chép lại, ghi vào sử sách; sách ghi chép [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '记载' AND pinyin = 'jìzǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '记载' AND pinyin = 'jìzǎi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '记载'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '记载'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jìzǎi',
      meaning_vi = 'ghi chép lại, ghi vào sử sách; sách ghi chép',
      example_hanzi = '这部地方县志里详细记载了该古镇数百年的历史变迁。',
      example_pinyin = 'Zhè bù dìfāng xiànzhì lǐ xiángxì jìzǎi le gāi gǔzhèn shù bǎi nián de lìshǐ biànqiān.',
      example_vi = 'Trong cuốn huyện chí địa phương này đã ghi chép chi tiết những đổi thay lịch sử suốt mấy trăm năm của thị trấn cổ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '记载',
      'jìzǎi',
      'ghi chép lại, ghi vào sử sách; sách ghi chép',
      'Động từ / Danh từ',
      'HSK 5',
      '这部地方县志里详细记载了该古镇数百年的历史变迁。',
      'Zhè bù dìfāng xiànzhì lǐ xiángxì jìzǎi le gāi gǔzhèn shù bǎi nián de lìshǐ biànqiān.',
      'Trong cuốn huyện chí địa phương này đã ghi chép chi tiết những đổi thay lịch sử suốt mấy trăm năm của thị trấn cổ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这部地方县志里详细记载了该古镇数百年的历史变迁。', 'Zhè bù dìfāng xiànzhì lǐ xiángxì jìzǎi le gāi gǔzhèn shù bǎi nián de lìshǐ biànqiān.', 'Trong cuốn huyện chí địa phương này đã ghi chép chi tiết những đổi thay lịch sử suốt mấy trăm năm của thị trấn cổ.', 'basic', 1),
      (v_id, '据古籍文献明确记载，早在两千多年前的汉代，古丝绸之路就已成为连接东西方商贸往来与文明互鉴的重要桥梁。', 'Jù gǔjí wénxiàn míngquè jìzǎi, zǎozài liǎng qiān duō nián qián de Hàndài, gǔ Sīchóu zhī Lù jiù yǐ chéngwéi liánjiē dōng-xīfāng shāngmào wǎnglái yǔ wénmíng hùjiàn de zhòngyào qiáoliáng.', 'Theo ghi chép rõ ràng trong các tài liệu cổ tịch, ngay từ thời nhà Hán hơn 2000 năm trước, Con đường Tơ lụa cổ đại đã trở thành chiếc cầu nối trọng yếu liên kết giao thương buôn bán và học hỏi lẫn nhau giữa các nền văn minh Đông - Tây.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2551] [嘉宾] (jiābīn) - khách quý, khách mời danh dự [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '嘉宾' AND pinyin = 'jiābīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '嘉宾' AND pinyin = 'jiābīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '嘉宾'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '嘉宾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiābīn',
      meaning_vi = 'khách quý, khách mời danh dự',
      example_hanzi = '晚会开始前，主持人和工作人员热情欢迎各位特邀嘉宾的到来。',
      example_pinyin = 'Wǎnhuì kāishǐ qián, zhǔchírén hé gōngzuò rényuán rèqíng huānyíng gèwèi tèyāo jiābīn de dàolái.',
      example_vi = 'Trước khi đêm hội bắt đầu, người dẫn chương trình và các nhân viên nhiệt tình chào đón sự hiện diện của các vị khách quý đặc biệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '嘉宾',
      'jiābīn',
      'khách quý, khách mời danh dự',
      'Danh từ',
      'HSK 5',
      '晚会开始前，主持人和工作人员热情欢迎各位特邀嘉宾的到来。',
      'Wǎnhuì kāishǐ qián, zhǔchírén hé gōngzuò rényuán rèqíng huānyíng gèwèi tèyāo jiābīn de dàolái.',
      'Trước khi đêm hội bắt đầu, người dẫn chương trình và các nhân viên nhiệt tình chào đón sự hiện diện của các vị khách quý đặc biệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '晚会开始前，主持人和工作人员热情欢迎各位特邀嘉宾的到来。', 'Wǎnhuì kāishǐ qián, zhǔchírén hé gōngzuò rényuán rèqíng huānyíng gèwèi tèyāo jiābīn de dàolái.', 'Trước khi đêm hội bắt đầu, người dẫn chương trình và các nhân viên nhiệt tình chào đón sự hiện diện của các vị khách quý đặc biệt.', 'basic', 1),
      (v_id, '本届国际人工智能高端峰会汇聚了来自联合国机构、世界顶尖高校及科技巨头的数百位重量级演讲嘉宾。', 'Běn jiè guójì réngōng zhìnéng gāoduān fēnghuì huìjù le láizì Liánhéguó jīgòu, shìjiè dǐngjiān gāoxiào jí kējì jùtóu de shù bǎi wèi zhòngliàngjí yǎnjiǎng jiābīn.', 'Hội nghị thượng đỉnh trí tuệ nhân tạo quốc tế kỳ này quy tụ hàng trăm vị diễn giả khách mời tầm cỡ đến từ các cơ quan Liên Hợp Quốc, các trường đại học hàng đầu thế giới cùng các gã khổng lồ công nghệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2552] [家电] (jiādiàn) - đồ điện gia dụng, thiết bị điện gia đình [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '家电' AND pinyin = 'jiādiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '家电' AND pinyin = 'jiādiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '家电'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '家电'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiādiàn',
      meaning_vi = 'đồ điện gia dụng, thiết bị điện gia đình',
      example_hanzi = '新搬进公寓后，我们添置了冰箱、洗衣机和微波炉等常用家电。',
      example_pinyin = 'Xīn bānjìn gōngyù hòu, wǒmen tiānzhì le bīngxiāng, xǐyījī hé wēibōlú děng chángyòng jiādiàn.',
      example_vi = 'Sau khi dọn về căn hộ mới, chúng tôi đã mua sắm thêm các đồ điện gia dụng quen thuộc như tủ lạnh, máy giặt và lò vi sóng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '家电',
      'jiādiàn',
      'đồ điện gia dụng, thiết bị điện gia đình',
      'Danh từ',
      'HSK 5',
      '新搬进公寓后，我们添置了冰箱、洗衣机和微波炉等常用家电。',
      'Xīn bānjìn gōngyù hòu, wǒmen tiānzhì le bīngxiāng, xǐyījī hé wēibōlú děng chángyòng jiādiàn.',
      'Sau khi dọn về căn hộ mới, chúng tôi đã mua sắm thêm các đồ điện gia dụng quen thuộc như tủ lạnh, máy giặt và lò vi sóng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新搬进公寓后，我们添置了冰箱、洗衣机和微波炉等常用家电。', 'Xīn bānjìn gōngyù hòu, wǒmen tiānzhì le bīngxiāng, xǐyījī hé wēibōlú děng chángyòng jiādiàn.', 'Sau khi dọn về căn hộ mới, chúng tôi đã mua sắm thêm các đồ điện gia dụng quen thuộc như tủ lạnh, máy giặt và lò vi sóng.', 'basic', 1),
      (v_id, '国家出台的绿色智能家电以旧换新补贴政策，有效激发了消费者的换机意愿，带动了绿色循环经济的发展。', 'Guójiā chūtái de lǜsè zhìnéng jiādiàn yǐjiù-huànxīn bǔtiē zhèngcè, yǒuxiào jīfā le xiāofèizhě de huànjī yìyuàn, dàidòng le lǜsè xúnhuán jīngjì de fāzhǎn.', 'Chính sách trợ cấp đổi đồ cũ lấy mới thiết bị điện gia dụng xanh và thông minh do nhà nước ban hành đã kích thích hiệu quả nhu cầu đổi mới của người tiêu dùng, thúc đẩy sự phát triển của nền kinh tế tuần hoàn xanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2553] [加工] (jiāgōng) - gia công, chế biến, chế tạo [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '加工' AND pinyin = 'jiāgōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '加工' AND pinyin = 'jiāgōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '加工'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '加工'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiāgōng',
      meaning_vi = 'gia công, chế biến, chế tạo',
      example_hanzi = '这些新鲜采摘的草莓将被直接运往食品厂加工成可口的果酱。',
      example_pinyin = 'Zhèxiē xīnxiān cǎizhāi de cǎoméi jiāng bèi zhíjiē yùnwǎng shípǐnchǎng jiāgōng chéng kěkǒu de guǒjiàng.',
      example_vi = 'Những quả dâu tây mới hái này sẽ được vận chuyển thẳng tới nhà máy thực phẩm để gia công thành mứt hoa quả thơm ngon.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '加工',
      'jiāgōng',
      'gia công, chế biến, chế tạo',
      'Động từ',
      'HSK 5',
      '这些新鲜采摘的草莓将被直接运往食品厂加工成可口的果酱。',
      'Zhèxiē xīnxiān cǎizhāi de cǎoméi jiāng bèi zhíjiē yùnwǎng shípǐnchǎng jiāgōng chéng kěkǒu de guǒjiàng.',
      'Những quả dâu tây mới hái này sẽ được vận chuyển thẳng tới nhà máy thực phẩm để gia công thành mứt hoa quả thơm ngon.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这些新鲜采摘的草莓将被直接运往食品厂加工成可口的果酱。', 'Zhèxiē xīnxiān cǎizhāi de cǎoméi jiāng bèi zhíjiē yùnwǎng shípǐnchǎng jiāgōng chéng kěkǒu de guǒjiàng.', 'Những quả dâu tây mới hái này sẽ được vận chuyển thẳng tới nhà máy thực phẩm để gia công thành mứt hoa quả thơm ngon.', 'basic', 1),
      (v_id, '该高新技术产业园区正致力于摆脱传统低附加值的来料加工模式，转向以高精尖工业母机精密机械加工为核心的高端价值链。', 'Gāi gāoxīnjìshù chǎnyè yuánqū zhèng zhìlìyú bǎituō chuántǒng dī fùjiāzhí de láiliào jiāgōng móshì, zhuǎnxiàng yǐ gāojīngjiān gōngyè mǔjī jīngmì jīxiè jiāgōng wéi héxīn de gāoduān jiàzhíliàn.', 'Khu công nghiệp công nghệ cao này đang nỗ lực thoát khỏi mô hình gia công nhận nguyên liệu truyền thống có giá trị gia tăng thấp, chuyển sang chuỗi giá trị cao cấp lấy gia công cơ khí chính xác của máy công cụ đầu ngành làm hạt nhân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2554] [加热] (jiārè) - làm nóng, hâm nóng, gia nhiệt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '加热' AND pinyin = 'jiārè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '加热' AND pinyin = 'jiārè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '加热'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '加热'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiārè',
      meaning_vi = 'làm nóng, hâm nóng, gia nhiệt',
      example_hanzi = '饭菜凉了，你放在微波炉里加热两分钟就可以吃了。',
      example_pinyin = 'Fàncài liáng le, nǐ fàng zài wēibōlú lǐ jiārè liǎng fēnzhōng jiù kěyǐ chī le.',
      example_vi = 'Cơm canh nguội rồi, cậu để vào lò vi sóng hâm nóng hai phút là có thể dùng được ngay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '加热',
      'jiārè',
      'làm nóng, hâm nóng, gia nhiệt',
      'Động từ',
      'HSK 5',
      '饭菜凉了，你放在微波炉里加热两分钟就可以吃了。',
      'Fàncài liáng le, nǐ fàng zài wēibōlú lǐ jiārè liǎng fēnzhōng jiù kěyǐ chī le.',
      'Cơm canh nguội rồi, cậu để vào lò vi sóng hâm nóng hai phút là có thể dùng được ngay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '饭菜凉了，你放在微波炉里加热两分钟就可以吃了。', 'Fàncài liáng le, nǐ fàng zài wēibōlú lǐ jiārè liǎng fēnzhōng jiù kěyǐ chī le.', 'Cơm canh nguội rồi, cậu để vào lò vi sóng hâm nóng hai phút là có thể dùng được ngay.', 'basic', 1),
      (v_id, '在特种合金钢冶炼过程中，必须通过高频电磁感应精准控制加热温度曲线，以确保金属晶粒组织的均匀致密。', 'Zài tèzhǒng héjīngāng yěliàn guòchéng zhōng, bìxū tōngguò gāopín diàncí gǎnyìng jīngzhǔn kòngzhì jiārè wēndù qūxiàn, yǐ quèbǎo jīnshǔ jīnglì zǔzhī de jūnyún zhìmì.', 'Trong quy trình luyện thép hợp kim đặc chủng, bắt buộc phải kiểm soát chuẩn xác đường cong nhiệt độ nung qua cảm ứng điện từ cao tần để bảo đảm cấu trúc hạt tinh thể kim loại đồng đều và chặt chẽ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2555] [加深] (jiāshēn) - làm sâu thêm, làm sâu sắc thêm, khắc sâu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '加深' AND pinyin = 'jiāshēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '加深' AND pinyin = 'jiāshēn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '加深'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '加深'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiāshēn',
      meaning_vi = 'làm sâu thêm, làm sâu sắc thêm, khắc sâu',
      example_hanzi = '通过这次面对面的坦诚沟通，我们彼此加深了了解与友谊。',
      example_pinyin = 'Tōngguò zhè cì miànduìmiàn de tǎnchéng gōutōng, wǒmen bǐcǐ jiāshēn le liǎojiě yǔ yǒuyì.',
      example_vi = 'Thông qua cuộc đối thoại trực diện chân thành lần này, chúng tôi đã hiểu biết sâu sắc hơn về nhau và gắn kết tình bạn thêm bền chặt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '加深',
      'jiāshēn',
      'làm sâu thêm, làm sâu sắc thêm, khắc sâu',
      'Động từ',
      'HSK 5',
      '通过这次面对面的坦诚沟通，我们彼此加深了了解与友谊。',
      'Tōngguò zhè cì miànduìmiàn de tǎnchéng gōutōng, wǒmen bǐcǐ jiāshēn le liǎojiě yǔ yǒuyì.',
      'Thông qua cuộc đối thoại trực diện chân thành lần này, chúng tôi đã hiểu biết sâu sắc hơn về nhau và gắn kết tình bạn thêm bền chặt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '通过这次面对面的坦诚沟通，我们彼此加深了了解与友谊。', 'Tōngguò zhè cì miànduìmiàn de tǎnchéng gōutōng, wǒmen bǐcǐ jiāshēn le liǎojiě yǔ yǒuyì.', 'Thông qua cuộc đối thoại trực diện chân thành lần này, chúng tôi đã hiểu biết sâu sắc hơn về nhau và gắn kết tình bạn thêm bền chặt.', 'basic', 1),
      (v_id, '两国外交代表团围绕地缘政治、能源安全等重大议题举行战略对话，进一步加深了双方在多边舞台上的互信与协作。', 'Liǎng guó wàijiāo dàibiǎotuán wéirào dìyuán zhèngzhì, néngyuán ānquán děng zhòngdà yìtí jǔxíng zhànlüè duìhuà, jìnyíbù jiāshēn le shuāngfāng zài duōbiān wǔtái shang de hùxìn yǔ xiézuò.', 'Đoàn đại biểu ngoại giao hai nước đã tiến hành đối thoại chiến lược xoay quanh các chủ đề trọng đại như địa chính trị và an ninh năng lượng, làm sâu sắc hơn nữa sự tin cậy lẫn nhau và phối hợp trên trường quốc tế đa phương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2556] [加速] (jiāsù) - gia tốc, tăng tốc, đẩy nhanh tiến độ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '加速' AND pinyin = 'jiāsù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '加速' AND pinyin = 'jiāsù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '加速'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '加速'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiāsù',
      meaning_vi = 'gia tốc, tăng tốc, đẩy nhanh tiến độ',
      example_hanzi = '司机踩下了油门，汽车开始在高速公路上加速向前飞驰。',
      example_pinyin = 'Sījī cǎixià le yóumén, qìchē kāishǐ zài gāosù gōnglù shang jiāsù xiàng qián fēichí.',
      example_vi = 'Tài xế nhấn chân ga, chiếc ô tô bắt đầu tăng tốc lao nhanh về phía trước trên đường cao tốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '加速',
      'jiāsù',
      'gia tốc, tăng tốc, đẩy nhanh tiến độ',
      'Động từ',
      'HSK 5',
      '司机踩下了油门，汽车开始在高速公路上加速向前飞驰。',
      'Sījī cǎixià le yóumén, qìchē kāishǐ zài gāosù gōnglù shang jiāsù xiàng qián fēichí.',
      'Tài xế nhấn chân ga, chiếc ô tô bắt đầu tăng tốc lao nhanh về phía trước trên đường cao tốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '司机踩下了油门，汽车开始在高速公路上加速向前飞驰。', 'Sījī cǎixià le yóumén, qìchē kāishǐ zài gāosù gōnglù shang jiāsù xiàng qián fēichí.', 'Tài xế nhấn chân ga, chiếc ô tô bắt đầu tăng tốc lao nhanh về phía trước trên đường cao tốc.', 'basic', 1),
      (v_id, '随着新一轮科技革命的到来，数字技术与实体经济深度融合正加速赋能传统产业转型升级。', 'Suízhe xīn yì lún kējì gémìng de dàolái, shùzì jìshù yǔ shítǐ jīngjì shēndù rónghé zhèng jiāsù fùnéng chuántǒng chǎnyè zhuǎnxíng shēngjí.', 'Cùng với sự xuất hiện của cuộc cách mạng khoa học công nghệ mới, sự hội nhập sâu rộng giữa công nghệ số và kinh tế thực thể đang tăng tốc trợ lực cho sự chuyển đổi và nâng cấp của các ngành công nghiệp truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2557] [家务] (jiāwù) - việc nhà, công việc nội trợ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '家务' AND pinyin = 'jiāwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '家务' AND pinyin = 'jiāwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '家务'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '家务'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiāwù',
      meaning_vi = 'việc nhà, công việc nội trợ',
      example_hanzi = '周末的时候，夫妻俩分工合作，一起打扫卫生、做家务。',
      example_pinyin = 'Zhōumò de shíhou, fūqī liǎ fēngōng hézuò, yìqǐ dǎsǎo wèishēng, zuò jiāwù.',
      example_vi = 'Vào cuối tuần, hai vợ chồng cùng phân công hợp tác, vừa quét dọn vệ sinh vừa làm các việc nội trợ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '家务',
      'jiāwù',
      'việc nhà, công việc nội trợ',
      'Danh từ',
      'HSK 5',
      '周末的时候，夫妻俩分工合作，一起打扫卫生、做家务。',
      'Zhōumò de shíhou, fūqī liǎ fēngōng hézuò, yìqǐ dǎsǎo wèishēng, zuò jiāwù.',
      'Vào cuối tuần, hai vợ chồng cùng phân công hợp tác, vừa quét dọn vệ sinh vừa làm các việc nội trợ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末的时候，夫妻俩分工合作，一起打扫卫生、做家务。', 'Zhōumò de shíhou, fūqī liǎ fēngōng hézuò, yìqǐ dǎsǎo wèishēng, zuò jiāwù.', 'Vào cuối tuần, hai vợ chồng cùng phân công hợp tác, vừa quét dọn vệ sinh vừa làm các việc nội trợ.', 'basic', 1),
      (v_id, '智能洗碗机、扫地机器人及烘干机等智能家电的普及，极大地减轻了现代职场家庭繁重的家务负担。', 'Zhìnéng xǐwǎnjī, sǎodì jīqìrén jí hōnggānjī děng zhìnéng jiādiàn de pǔjí, jídà de jiǎnqīng le xiàndài zhíchǎng jiātíng fánzhòng de jiāwù fùdān.', 'Việc phổ cập các thiết bị gia dụng thông minh như máy rửa bát, robot hút bụi và máy sấy quần áo đã giảm nhẹ đáng kể gánh nặng việc nhà bề bộn cho các gia đình công sở hiện đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2558] [甲] (jiǎ) - Giáp (thiên can thứ nhất), loại A, hạng nhất; bên A; áo giáp, móng (móng tay) [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '甲' AND pinyin = 'jiǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '甲' AND pinyin = 'jiǎ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '甲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '甲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'jiǎ',
      meaning_vi = 'Giáp (thiên can thứ nhất), loại A, hạng nhất; bên A; áo giáp, móng (móng tay)',
      example_hanzi = '在商务合作合同中，通常将出资方或者委托方称为甲方。',
      example_pinyin = 'Zài shāngwù hézuò hétong zhōng, tōngcháng jiāng chūzīfāng huòzhě wěituōfāng chēngwéi Jiǎfāng.',
      example_vi = 'Trong các hợp đồng hợp tác thương mại, bên cấp vốn hoặc bên ủy thác thường được gọi là Bên A.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '甲',
      'jiǎ',
      'Giáp (thiên can thứ nhất), loại A, hạng nhất; bên A; áo giáp, móng (móng tay)',
      'Danh từ / Tính từ',
      'HSK 5',
      '在商务合作合同中，通常将出资方或者委托方称为甲方。',
      'Zài shāngwù hézuò hétong zhōng, tōngcháng jiāng chūzīfāng huòzhě wěituōfāng chēngwéi Jiǎfāng.',
      'Trong các hợp đồng hợp tác thương mại, bên cấp vốn hoặc bên ủy thác thường được gọi là Bên A.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在商务合作合同中，通常将出资方或者委托方称为甲方。', 'Zài shāngwù hézuò hétong zhōng, tōngcháng jiāng chūzīfāng huòzhě wěituōfāng chēngwéi Jiǎfāng.', 'Trong các hợp đồng hợp tác thương mại, bên cấp vốn hoặc bên ủy thác thường được gọi là Bên A.', 'basic', 1),
      (v_id, '该医疗中心经过严谨的国家评审，成功获批成为具有最高综合诊疗水平的三级甲等综合医院。', 'Gāi yīliáo zhōngxīn jīngguò yánjǐn de guójiā píngshěn, chénggōng huòpī chéngwéi jùyǒu zuì gāo zōnghé zhěnliáo shuǐpíng de sān jí jiǎ děng zōnghé yīyuàn.', 'Trung tâm y tế này qua quá trình thẩm định nghiêm ngặt cấp quốc gia đã được phê duyệt thành công trở thành bệnh viện đa khoa tuyến 3 hạng A (cấp cao nhất) với năng lực khám chữa bệnh tổng hợp hàng đầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2559] [假如] (jiǎrú) - nếu như, giả sử, ví như [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '假如' AND pinyin = 'jiǎrú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '假如' AND pinyin = 'jiǎrú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '假如'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '假如'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'jiǎrú',
      meaning_vi = 'nếu như, giả sử, ví như',
      example_hanzi = '假如明天天气晴朗无风，我们就去郊外的森林公园露营。',
      example_pinyin = 'Jiǎrú míngtiān tiānqì qínglǎng wú fēng, wǒmen jiù qù jiāowài de sēnlín gōngyuán lùyíng.',
      example_vi = 'Nếu như ngày mai trời nắng đẹp không có gió, chúng ta sẽ đi cắm trại ở công viên rừng ngoại ô.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '假如',
      'jiǎrú',
      'nếu như, giả sử, ví như',
      'Liên từ',
      'HSK 5',
      '假如明天天气晴朗无风，我们就去郊外的森林公园露营。',
      'Jiǎrú míngtiān tiānqì qínglǎng wú fēng, wǒmen jiù qù jiāowài de sēnlín gōngyuán lùyíng.',
      'Nếu như ngày mai trời nắng đẹp không có gió, chúng ta sẽ đi cắm trại ở công viên rừng ngoại ô.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '假如明天天气晴朗无风，我们就去郊外的森林公园露营。', 'Jiǎrú míngtiān tiānqì qínglǎng wú fēng, wǒmen jiù qù jiāowài de sēnlín gōngyuán lùyíng.', 'Nếu như ngày mai trời nắng đẹp không có gió, chúng ta sẽ đi cắm trại ở công viên rừng ngoại ô.', 'basic', 1),
      (v_id, '假如不能在关键核心软硬件技术上实现真正的自主可控，企业在未来的国际产业链重构中就极易陷入受制于人的被动境地。', 'Jiǎrú bùnéng zài guānjiàn héxīn ruǎnyìngjiàn jìshù shang shíxiàn zhēnzhèng de zìzhǔ kěkòng, qǐyè zài wèilái de guójì chǎnyèliàn chónggòu zhōng jiù jí yì xiànrù shòuzhìyúrén de bèidòng jìngdì.', 'Giả sử không thể thực hiện được việc tự chủ kiểm soát thực chất ở các công nghệ phần cứng và phần mềm then chốt, doanh nghiệp trong tương lai sẽ rất dễ rơi vào thế bị động phụ thuộc khi chuỗi cung ứng công nghiệp toàn cầu tái cấu trúc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2560] [架] (jià) - giá, khung, giàn; bắc, gác; cỗ, chiếc (máy bay, piano); cãi lộn, đánh nhau [Danh từ / Động từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '架' AND pinyin = 'jià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '架' AND pinyin = 'jià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '架'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '架'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ / Lượng từ',
      pinyin = 'jià',
      meaning_vi = 'giá, khung, giàn; bắc, gác; cỗ, chiếc (máy bay, piano); cãi lộn, đánh nhau',
      example_hanzi = '书房的墙边整齐摆放着一个高大的实木书架。',
      example_pinyin = 'Shūfáng de qiángbiān zhěngqí bǎifàng zhe yí gè gāodà de shímù shūjià.',
      example_vi = 'Bên bức tường phòng sách bài trí ngay ngắn một chiếc giá sách gỗ thịt cao lớn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '架',
      'jià',
      'giá, khung, giàn; bắc, gác; cỗ, chiếc (máy bay, piano); cãi lộn, đánh nhau',
      'Danh từ / Động từ / Lượng từ',
      'HSK 5',
      '书房的墙边整齐摆放着一个高大的实木书架。',
      'Shūfáng de qiángbiān zhěngqí bǎifàng zhe yí gè gāodà de shímù shūjià.',
      'Bên bức tường phòng sách bài trí ngay ngắn một chiếc giá sách gỗ thịt cao lớn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '书房的墙边整齐摆放着一个高大的实木书架。', 'Shūfáng de qiángbiān zhěngqí bǎifàng zhe yí gè gāodà de shímù shūjià.', 'Bên bức tường phòng sách bài trí ngay ngắn một chiếc giá sách gỗ thịt cao lớn.', 'basic', 1),
      (v_id, '在这片崇山峻岭之间，桥梁工程师们凭借高超技术成功架设起了一座跨越千米深谷的特大型悬索大桥。', 'Zài zhè piàn chóngshān-jùnlǐng zhījiān, qiáoliáng gōngchéngshīmen píngjiè gāochāo jìshù chénggōng jiàshè qǐ le yí zuò kuàyuè qiān mǐ shēngǔ de tèdàxíng xuánsuǒ dàqiáo.', 'Giữa những dãy núi non trùng điệp này, các kỹ sư cầu đường bằng kỹ thuật siêu việt đã bắc dựng thành công một cây cầu treo dây võng cỡ siêu lớn bắc qua hẻm vực sâu hàng nghìn mét.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2561] [驾驶] (jiàshǐ) - lái xe, điều khiển, vận hành (phương tiện giao thông) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '驾驶' AND pinyin = 'jiàshǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '驾驶' AND pinyin = 'jiàshǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '驾驶'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '驾驶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiàshǐ',
      meaning_vi = 'lái xe, điều khiển, vận hành (phương tiện giao thông)',
      example_hanzi = '为了确保交通安全，驾驶员在开车途中严禁使用手机。',
      example_pinyin = 'Wèile quèbǎo jiāotōng ānquán, jiàshǐyuán zài kāichē túzhōng yánjìn shǐyòng shǒujī.',
      example_vi = 'Để bảo đảm an toàn giao thông, tài xế bị nghiêm cấm sử dụng điện thoại khi đang lái xe.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '驾驶',
      'jiàshǐ',
      'lái xe, điều khiển, vận hành (phương tiện giao thông)',
      'Động từ',
      'HSK 5',
      '为了确保交通安全，驾驶员在开车途中严禁使用手机。',
      'Wèile quèbǎo jiāotōng ānquán, jiàshǐyuán zài kāichē túzhōng yánjìn shǐyòng shǒujī.',
      'Để bảo đảm an toàn giao thông, tài xế bị nghiêm cấm sử dụng điện thoại khi đang lái xe.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了确保交通安全，驾驶员在开车途中严禁使用手机。', 'Wèile quèbǎo jiāotōng ānquán, jiàshǐyuán zài kāichē túzhōng yánjìn shǐyòng shǒujī.', 'Để bảo đảm an toàn giao thông, tài xế bị nghiêm cấm sử dụng điện thoại khi đang lái xe.', 'basic', 1),
      (v_id, '基于激光雷达与高精地图的L4级别自动驾驶汽车，已在国内多个先行先试智慧城市示范区展开常态化道路载客测试。', 'Jīyú jīguāng léidá yǔ gāojīng dìtú de L4 jíbié zìdòng jiàshǐ qìchē, yǐ zài guónèi duō gè xiānxíng-xiānshì zhìhuì chéngshì shìfànqū zhǎnkāi chángtàihuà dàolù zàikè cèshì.', 'Xe ô tô tự hành cấp độ L4 dựa trên cảm biến lidar và bản đồ độ chính xác cao đã bắt đầu triển khai thử nghiệm chở khách trên đường phố định kỳ tại nhiều khu đô thị thông minh thí điểm tiên phong trong nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2562] [驾照] (jiàzhào) - bằng lái xe, giấy phép lái xe [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '驾照' AND pinyin = 'jiàzhào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '驾照' AND pinyin = 'jiàzhào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '驾照'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '驾照'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiàzhào',
      meaning_vi = 'bằng lái xe, giấy phép lái xe',
      example_hanzi = '他经过三个月的刻苦练习，终于顺利考取了小型汽车驾照。',
      example_pinyin = 'Tā jīngguò sān gè yuè de kèkǔ liànxí, zhōngyú shùnlì kǎoqǔ le xiǎoxíng qìchē jiàzhào.',
      example_vi = 'Qua 3 tháng khổ luyện, anh ấy cuối cùng đã thuận lợi thi đỗ bằng lái xe ô tô con.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '驾照',
      'jiàzhào',
      'bằng lái xe, giấy phép lái xe',
      'Danh từ',
      'HSK 5',
      '他经过三个月的刻苦练习，终于顺利考取了小型汽车驾照。',
      'Tā jīngguò sān gè yuè de kèkǔ liànxí, zhōngyú shùnlì kǎoqǔ le xiǎoxíng qìchē jiàzhào.',
      'Qua 3 tháng khổ luyện, anh ấy cuối cùng đã thuận lợi thi đỗ bằng lái xe ô tô con.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他经过三个月的刻苦练习，终于顺利考取了小型汽车驾照。', 'Tā jīngguò sān gè yuè de kèkǔ liànxí, zhōngyú shùnlì kǎoqǔ le xiǎoxíng qìchē jiàzhào.', 'Qua 3 tháng khổ luyện, anh ấy cuối cùng đã thuận lợi thi đỗ bằng lái xe ô tô con.', 'basic', 1),
      (v_id, '公安交管部门全面推行电子驾照互认与网上年审服务，极大地方便了跨省市出差与租车出行的广大群众。', 'Gōng’ān jiāoguǎn bùmén quánmiàn tuīxíng diànzǐ jiàzhào hùrèn yǔ wǎngshang niánshěn fúwù, jídà de fāngbiàn le kuà shěng-shì chūchāi yǔ zūchē chūxíng de guǎngdà qúnzhòng.', 'Cơ quan quản lý giao thông công an đã triển khai toàn diện việc công nhận bằng lái xe điện tử liên tỉnh và dịch vụ kiểm định online, tạo thuận tiện rất lớn cho đông đảo người dân đi công tác và thuê xe đi lại liên tỉnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2563] [价值] (jiàzhí) - giá trị, ý nghĩa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '价值' AND pinyin = 'jiàzhí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '价值' AND pinyin = 'jiàzhí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '价值'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '价值'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiàzhí',
      meaning_vi = 'giá trị, ý nghĩa',
      example_hanzi = '这本古籍具有极高的历史文化研究价值。',
      example_pinyin = 'Zhè běn gǔjí jùyǒu jí gāo de lìshǐ wénhuà yánjiū jiàzhí.',
      example_vi = 'Cuốn sách cổ này có giá trị nghiên cứu lịch sử văn hóa vô cùng cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '价值',
      'jiàzhí',
      'giá trị, ý nghĩa',
      'Danh từ',
      'HSK 5',
      '这本古籍具有极高的历史文化研究价值。',
      'Zhè běn gǔjí jùyǒu jí gāo de lìshǐ wénhuà yánjiū jiàzhí.',
      'Cuốn sách cổ này có giá trị nghiên cứu lịch sử văn hóa vô cùng cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这本古籍具有极高的历史文化研究价值。', 'Zhè běn gǔjí jùyǒu jí gāo de lìshǐ wénhuà yánjiū jiàzhí.', 'Cuốn sách cổ này có giá trị nghiên cứu lịch sử văn hóa vô cùng cao.', 'basic', 1),
      (v_id, '企业不仅要追求短期的经济效益，更应当积极承担社会责任，从而为全体股东与社会各界创造可持续的长期综合价值。', 'Qǐyè bùjǐn yào zhuīqiú duǎnqī de jīngjì xiàoyì, gèng yīngdāng jījí chéngdān shèhuì zérèn, cóng’ér wèi quántǐ gǔdōng yǔ shèhuì gèjiè chuàngzào kěchíxù de chángqī zōnghé jiàzhí.', 'Doanh nghiệp không chỉ theo đuổi lợi ích kinh tế trước mắt, mà càng nên tích cực gánh vác trách nhiệm xã hội, qua đó kiến tạo giá trị tổng hợp lâu dài bền vững cho toàn thể cổ đông và cộng đồng xã hội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2564] [艰苦] (jiānkǔ) - gian khổ, gian nan, khó nhọc [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '艰苦' AND pinyin = 'jiānkǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '艰苦' AND pinyin = 'jiānkǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '艰苦'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '艰苦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'jiānkǔ',
      meaning_vi = 'gian khổ, gian nan, khó nhọc',
      example_hanzi = '老一辈建设者在十分艰苦的自然条件下开辟出了这片绿洲。',
      example_pinyin = 'Lǎoyíbèi jiànshèzhě zài shífēn jiānkǔ de zìrán tiáojiàn xià kāipì chū le zhè piàn lǜzhōu.',
      example_vi = 'Thế hệ những người kiến thiết đi trước đã khai phá nên ốc đảo này giữa những điều kiện tự nhiên vô cùng gian khổ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '艰苦',
      'jiānkǔ',
      'gian khổ, gian nan, khó nhọc',
      'Tính từ',
      'HSK 5',
      '老一辈建设者在十分艰苦的自然条件下开辟出了这片绿洲。',
      'Lǎoyíbèi jiànshèzhě zài shífēn jiānkǔ de zìrán tiáojiàn xià kāipì chū le zhè piàn lǜzhōu.',
      'Thế hệ những người kiến thiết đi trước đã khai phá nên ốc đảo này giữa những điều kiện tự nhiên vô cùng gian khổ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老一辈建设者在十分艰苦的自然条件下开辟出了这片绿洲。', 'Lǎoyíbèi jiànshèzhě zài shífēn jiānkǔ de zìrán tiáojiàn xià kāipì chū le zhè piàn lǜzhōu.', 'Thế hệ những người kiến thiết đi trước đã khai phá nên ốc đảo này giữa những điều kiện tự nhiên vô cùng gian khổ.', 'basic', 1),
      (v_id, '地质科研勘探队员们发扬艰苦奋斗、勇攀高峰的奉献精神，常年在海拔数千米的高原荒漠腹地开展矿产资源勘测。', 'Dìzhì kēyán kāntànduìyuánmen fāyáng jiānkǔ-fèndòu, yǒngpān-gāofēng de fèngxiàn jīngshén, chángnián zài hǎibá shù qiān mǐ de gāoyuán huāngmò fùdì kāizhǎn kuàngchǎn zīyuán kāncè.', 'Các thành viên đội thăm dò nghiên cứu địa chất đã phát huy tinh thần cống hiến gian khổ phấn đấu dũng cảm trèo lên đỉnh cao, quanh năm bám trụ sâu trong lòng sa mạc cao nguyên hàng nghìn mét so với mực nước biển để khảo sát tài nguyên khoáng sản.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2565] [坚强] (jiānqiáng) - kiên cường, bất khuất, vững vàng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '坚强' AND pinyin = 'jiānqiáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '坚强' AND pinyin = 'jiānqiáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '坚强'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '坚强'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'jiānqiáng',
      meaning_vi = 'kiên cường, bất khuất, vững vàng',
      example_hanzi = '她是一个坚强的女孩，面对生活中的挫折从不轻言放弃。',
      example_pinyin = 'Tā shì yí gè jiānqiáng de nǚhái, miànduì shēnghuó zhōng de cuòzhé cóngbù qīngyán fàngqì.',
      example_vi = 'Cô ấy là một cô gái kiên cường, đối mặt với những trắc trở trong cuộc sống không bao giờ dễ dàng buông xuôi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '坚强',
      'jiānqiáng',
      'kiên cường, bất khuất, vững vàng',
      'Tính từ',
      'HSK 5',
      '她是一个坚强的女孩，面对生活中的挫折从不轻言放弃。',
      'Tā shì yí gè jiānqiáng de nǚhái, miànduì shēnghuó zhōng de cuòzhé cóngbù qīngyán fàngqì.',
      'Cô ấy là một cô gái kiên cường, đối mặt với những trắc trở trong cuộc sống không bao giờ dễ dàng buông xuôi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '她是一个坚强的女孩，面对生活中的挫折从不轻言放弃。', 'Tā shì yí gè jiānqiáng de nǚhái, miànduì shēnghuó zhōng de cuòzhé cóngbù qīngyán fàngqì.', 'Cô ấy là một cô gái kiên cường, đối mặt với những trắc trở trong cuộc sống không bao giờ dễ dàng buông xuôi.', 'basic', 1),
      (v_id, '在抗击重大自然灾害的危急关头，党组织始终是凝聚各方力量、带领灾区群众战胜一切险阻的最坚强战斗堡垒。', 'Zài kàngjī zhòngdà zìrán zāihài de wēijí guāntóu, dǎngzǔzhī shǐzhōng shì níngjù gèfāng lìliàng, dàilǐng zāiqū qúnzhòng zhànshèng yíqiè xiǎnzǔ de zuì jiānqiáng zhàndòu bǎolěi.', 'Trong thời khắc hiểm nghèo chống chọi với thiên tai nghiêm trọng, tổ chức luôn là pháo đài chiến đấu kiên cường nhất quy tụ mọi nguồn lực, dẫn dắt đồng bào vùng thiên tai vượt qua mọi hiểm nguy trắc trở.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2566] [捡] (jiǎn) - nhặt, lượm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '捡' AND pinyin = 'jiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '捡' AND pinyin = 'jiǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '捡'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '捡'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiǎn',
      meaning_vi = 'nhặt, lượm',
      example_hanzi = '他在操场上跑步时，顺手捡起了一串别人不慎遗落的钥匙。',
      example_pinyin = 'Tā zài cǎochǎng shang pǎobù shí, shùnshǒu jiǎnqǐ le yí chuàn biérén búshèn yíluò de yàoshi.',
      example_vi = 'Khi chạy bộ trên sân thể dục, anh ấy tiện tay nhặt được một chùm chìa khóa do người khác sơ ý đánh rơi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '捡',
      'jiǎn',
      'nhặt, lượm',
      'Động từ',
      'HSK 5',
      '他在操场上跑步时，顺手捡起了一串别人不慎遗落的钥匙。',
      'Tā zài cǎochǎng shang pǎobù shí, shùnshǒu jiǎnqǐ le yí chuàn biérén búshèn yíluò de yàoshi.',
      'Khi chạy bộ trên sân thể dục, anh ấy tiện tay nhặt được một chùm chìa khóa do người khác sơ ý đánh rơi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在操场上跑步时，顺手捡起了一串别人不慎遗落的钥匙。', 'Tā zài cǎochǎng shang pǎobù shí, shùnshǒu jiǎnqǐ le yí chuàn biérén búshèn yíluò de yàoshi.', 'Khi chạy bộ trên sân thể dục, anh ấy tiện tay nhặt được một chùm chìa khóa do người khác sơ ý đánh rơi.', 'basic', 1),
      (v_id, '小学生们利用周末课余时间在海滩开展环保公益行动，弯腰捡起游客丢弃的塑料垃圾，以此唤醒公众的海洋环保意识。', 'Xiǎoxuéshēngmen lìyòng zhōumò kèyú shíjiān zài hǎitān kāizhǎn huánbǎo gōngyì xíngdòng, wānyāo jiǎnqǐ yóukè diūqì de sùliào lājī, yǐcǐ huànxǐng gōngzhòng de hǎiyáng huánbǎo yìshí.', 'Các em học sinh tiểu học đã tranh thủ thời gian rảnh rỗi cuối tuần tổ chức hoạt động công ích bảo vệ môi trường trên bờ biển, cúi người nhặt từng chiếc rác nhựa du khách vứt lại, qua đó đánh thức ý thức bảo vệ đại dương của cộng đồng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2567] [剪] (jiǎn) - cắt (bằng kéo), tỉa, xén [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '剪' AND pinyin = 'jiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '剪' AND pinyin = 'jiǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '剪'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '剪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiǎn',
      meaning_vi = 'cắt (bằng kéo), tỉa, xén',
      example_hanzi = '理发师正在专注而细致地为顾客修剪刘海。',
      example_pinyin = 'Lǐfàshī zhèngzài zhuānzhù ér xìzhì de wèi gùkè xiūjiǎn liúhǎi.',
      example_vi = 'Người thợ cắt tóc đang chăm chú và tỉ mỉ cắt tỉa phần tóc mái cho khách hàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '剪',
      'jiǎn',
      'cắt (bằng kéo), tỉa, xén',
      'Động từ',
      'HSK 5',
      '理发师正在专注而细致地为顾客修剪刘海。',
      'Lǐfàshī zhèngzài zhuānzhù ér xìzhì de wèi gùkè xiūjiǎn liúhǎi.',
      'Người thợ cắt tóc đang chăm chú và tỉ mỉ cắt tỉa phần tóc mái cho khách hàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '理发师正在专注而细致地为顾客修剪刘海。', 'Lǐfàshī zhèngzài zhuānzhù ér xìzhì de wèi gùkè xiūjiǎn liúhǎi.', 'Người thợ cắt tóc đang chăm chú và tỉ mỉ cắt tỉa phần tóc mái cho khách hàng.', 'basic', 1),
      (v_id, '作为国家级非物质文化遗产，剪纸艺人仅凭一把剪刀和一张红纸，便能灵巧地剪出惟妙惟肖、寓意吉祥的传统民俗图案。', 'Zuòwéi guójiājí fēiwùzhì wénhuà yíchǎn, jiǎnzhǐ yìrén jǐn píng yì bǎ jiǎndāo hé yì zhāng hóngzhǐ, biàn néng língqiǎo de jiǎn chū wéimiào-wéixiào, yùyì jíxiáng de chuántǒng mínsú tú’àn.', 'Là di sản văn hóa phi vật thể cấp quốc gia, nghệ nhân cắt giấy chỉ bằng một cây kéo và một tờ giấy đỏ đã có thể khéo léo cắt tỉa ra những hoa văn dân gian truyền thống sống động như thật mang ngụ ý cát tường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2568] [剪刀] (jiǎndāo) - cây kéo, cái kéo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '剪刀' AND pinyin = 'jiǎndāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '剪刀' AND pinyin = 'jiǎndāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '剪刀'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '剪刀'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiǎndāo',
      meaning_vi = 'cây kéo, cái kéo',
      example_hanzi = '做手工时请小心使用剪刀，注意不要划伤手指。',
      example_pinyin = 'Zuò shǒugōng shí qǐng xiǎoxīn shǐyòng jiǎndāo, zhùyì bú yào huáshāng shǒuzhǐ.',
      example_vi = 'Khi làm đồ thủ công xin hãy cẩn thận khi dùng kéo, chú ý không để cứa vào ngón tay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '剪刀',
      'jiǎndāo',
      'cây kéo, cái kéo',
      'Danh từ',
      'HSK 5',
      '做手工时请小心使用剪刀，注意不要划伤手指。',
      'Zuò shǒugōng shí qǐng xiǎoxīn shǐyòng jiǎndāo, zhùyì bú yào huáshāng shǒuzhǐ.',
      'Khi làm đồ thủ công xin hãy cẩn thận khi dùng kéo, chú ý không để cứa vào ngón tay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '做手工时请小心使用剪刀，注意不要划伤手指。', 'Zuò shǒugōng shí qǐng xiǎoxīn shǐyòng jiǎndāo, zhùyì bú yào huáshāng shǒuzhǐ.', 'Khi làm đồ thủ công xin hãy cẩn thận khi dùng kéo, chú ý không để cứa vào ngón tay.', 'basic', 1),
      (v_id, '现代外科手术所使用的高频超声手术剪刀，能够在精准分离人体细微软组织的同时实现快速止血，极大降低了术中风险。', 'Xiàndài wàikē shǒushù suǒ shǐyòng de gāopín chāoshēng shǒushù jiǎndāo, nénggòu zài jīngzhǔn fēnlí réntǐ xìwēi ruǎnzǔzhī de tóngshí shíxiàn kuàisù zhǐxiě, jídà jiàngdī le shùzhōng fēngxiǎn.', 'Kéo phẫu thuật siêu âm cao tần dùng trong phẫu thuật ngoại khoa hiện đại có thể cầm máu nhanh chóng đồng thời với việc bóc tách chính xác các mô mềm tinh vi của cơ thể người, giảm thiểu đáng kể rủi ro trong ca mổ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2569] [减肥] (jiǎnféi) - giảm cân, giảm béo [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '减肥' AND pinyin = 'jiǎnféi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '减肥' AND pinyin = 'jiǎnféi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '减肥'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '减肥'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiǎnféi',
      meaning_vi = 'giảm cân, giảm béo',
      example_hanzi = '健康减肥应当靠合理控制饮食搭配规律体育锻炼，切忌盲目节食。',
      example_pinyin = 'Jiànkāng jiǎnféi yīngdāng kào hélǐ kòngzhì yǐnshí dāpèi guīlǜ tǐyù duànliàn, qièjì mángmù jiéshí.',
      example_vi = 'Giảm cân lành mạnh nên dựa vào việc kiểm soát hợp lý chế độ ăn kết hợp rèn luyện thể dục thể thao đều đặn, tuyệt đối tránh nhịn ăn mù quáng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '减肥',
      'jiǎnféi',
      'giảm cân, giảm béo',
      'Động từ',
      'HSK 5',
      '健康减肥应当靠合理控制饮食搭配规律体育锻炼，切忌盲目节食。',
      'Jiànkāng jiǎnféi yīngdāng kào hélǐ kòngzhì yǐnshí dāpèi guīlǜ tǐyù duànliàn, qièjì mángmù jiéshí.',
      'Giảm cân lành mạnh nên dựa vào việc kiểm soát hợp lý chế độ ăn kết hợp rèn luyện thể dục thể thao đều đặn, tuyệt đối tránh nhịn ăn mù quáng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '健康减肥应当靠合理控制饮食搭配规律体育锻炼，切忌盲目节食。', 'Jiànkāng jiǎnféi yīngdāng kào hélǐ kòngzhì yǐnshí dāpèi guīlǜ tǐyù duànliàn, qièjì mángmù jiéshí.', 'Giảm cân lành mạnh nên dựa vào việc kiểm soát hợp lý chế độ ăn kết hợp rèn luyện thể dục thể thao đều đặn, tuyệt đối tránh nhịn ăn mù quáng.', 'basic', 1),
      (v_id, '医学专家指出，科学减重不仅是为了身材美观，更核心的意义在于通过降低体脂率与内脏脂肪，有效预防二型糖尿病和脂肪肝等代谢综合征。', 'Yīxué zhuānjiā zhǐchū, kēxué jiǎnzhòng bùjǐn shì wèile shēncái měiguān, gèng héxīn de yìyì zàiyú tōngguò jiàngdī tǐzhǐlǜ yǔ nèizàng zhīfáng, yǒuxiào yùfáng èr xíng tángniàobìng hé zhīfánggān děng dàixiè zōnghézhēng.', 'Các chuyên gia y học chỉ ra rằng, việc giảm cân khoa học không chỉ nhằm vóc dáng thẩm mỹ, mà ý nghĩa cốt lõi hơn là thông qua việc hạ thấp tỷ lệ mỡ cơ thể và mỡ nội tạng để phòng ngừa hiệu quả hội chứng chuyển hóa như tiểu đường tuýp 2 và gan nhiễm mỡ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2570] [简历] (jiǎnlì) - sơ yếu lý lịch, CV, hồ sơ xin việc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '简历' AND pinyin = 'jiǎnlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '简历' AND pinyin = 'jiǎnlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '简历'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '简历'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiǎnlì',
      meaning_vi = 'sơ yếu lý lịch, CV, hồ sơ xin việc',
      example_hanzi = '求职前，请把个人简历制作得简洁美观且重点突出。',
      example_pinyin = 'Qiúzhí qián, qǐng bǎ gèrén jiǎnlì zhìzuò de jiǎnjié měiguān qiě zhòngdiǎn tūchū.',
      example_vi = 'Trước khi đi xin việc, hãy chuẩn bị một bản sơ yếu lý lịch cá nhân thật ngắn gọn, thẩm mỹ và làm nổi bật những điểm trọng tâm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '简历',
      'jiǎnlì',
      'sơ yếu lý lịch, CV, hồ sơ xin việc',
      'Danh từ',
      'HSK 5',
      '求职前，请把个人简历制作得简洁美观且重点突出。',
      'Qiúzhí qián, qǐng bǎ gèrén jiǎnlì zhìzuò de jiǎnjié měiguān qiě zhòngdiǎn tūchū.',
      'Trước khi đi xin việc, hãy chuẩn bị một bản sơ yếu lý lịch cá nhân thật ngắn gọn, thẩm mỹ và làm nổi bật những điểm trọng tâm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '求职前，请把个人简历制作得简洁美观且重点突出。', 'Qiúzhí qián, qǐng bǎ gèrén jiǎnlì zhìzuò de jiǎnjié měiguān qiě zhòngdiǎn tūchū.', 'Trước khi đi xin việc, hãy chuẩn bị một bản sơ yếu lý lịch cá nhân thật ngắn gọn, thẩm mỹ và làm nổi bật những điểm trọng tâm.', 'basic', 1),
      (v_id, '在大型跨国企业的人才选拔中，人力资源部门通常利用智能化筛选系统对成千上万份求职简历进行多维度关键词匹配与量化评估。', 'Zài dàxíng kuàguó qǐyè de réncái xuǎnbá zhōng, rénlì zīyuán bùmén tōngcháng lìyòng zhìnénghuà shāixuǎn xìtǒng duì chéngqiān-shàngwàn fèn qiúzhí jiǎnlì jìnxíng duō wéidù guānjiàncí pǐpèi yǔ liànghuà pínggū.', 'Trong khâu tuyển chọn nhân tài của các doanh nghiệp đa quốc gia lớn, bộ phận nhân sự thường vận dụng hệ thống sàng lọc thông minh để đối sánh từ khóa đa chiều và đánh giá định lượng hàng vạn bản CV xin việc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2571] [简直] (jiǎnzhí) - quả là, gần như, tưởng chừng như, quả thật [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '简直' AND pinyin = 'jiǎnzhí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '简直' AND pinyin = 'jiǎnzhí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '简直'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '简直'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jiǎnzhí',
      meaning_vi = 'quả là, gần như, tưởng chừng như, quả thật',
      example_hanzi = '他能在这么短的时间内把任务完成得如此完美，简直令人难以置信。',
      example_pinyin = 'Tā néng zài zhème duǎn de shíjiān nèi bǎ rènwu wánchéng de rúcǐ wánměi, jiǎnzhí lìngrén nányǐ zhìxìn.',
      example_vi = 'Anh ấy có thể hoàn thành xuất sắc nhiệm vụ trong thời gian ngắn như vậy, quả thật khiến người ta khó mà tin nổi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '简直',
      'jiǎnzhí',
      'quả là, gần như, tưởng chừng như, quả thật',
      'Phó từ',
      'HSK 5',
      '他能在这么短的时间内把任务完成得如此完美，简直令人难以置信。',
      'Tā néng zài zhème duǎn de shíjiān nèi bǎ rènwu wánchéng de rúcǐ wánměi, jiǎnzhí lìngrén nányǐ zhìxìn.',
      'Anh ấy có thể hoàn thành xuất sắc nhiệm vụ trong thời gian ngắn như vậy, quả thật khiến người ta khó mà tin nổi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他能在这么短的时间内把任务完成得如此完美，简直令人难以置信。', 'Tā néng zài zhème duǎn de shíjiān nèi bǎ rènwu wánchéng de rúcǐ wánměi, jiǎnzhí lìngrén nányǐ zhìxìn.', 'Anh ấy có thể hoàn thành xuất sắc nhiệm vụ trong thời gian ngắn như vậy, quả thật khiến người ta khó mà tin nổi.', 'basic', 1),
      (v_id, '面对突如其来的全球供应链断裂危机，该企业凭借灵活的本土替代方案化险为夷，其应对速度简直创造了行业奇迹。', 'Miànduì tūrúqílái de quánqiú gōngyìngliàn duànliè wēijī, gāi qǐyè píngjiè línghuó de běntǔ tìdài fāng’àn huàxiǎnwéiyí, qí yìngduì sùdù jiǎnzhí chuàngzào le hángyè qíjì.', 'Đối mặt với cuộc khủng hoảng đứt gãy chuỗi cung ứng toàn cầu ập tới bất ngờ, doanh nghiệp này nhờ vào phương án thay thế nội địa linh hoạt đã chuyển nguy thành an, tốc độ phản ứng của họ tưởng chừng như đã tạo nên một kỳ tích trong ngành.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2572] [建] (jiàn) - xây, xây dựng, kiến thiết, dựng lập [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '建' AND pinyin = 'jiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建' AND pinyin = 'jiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '建'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiàn',
      meaning_vi = 'xây, xây dựng, kiến thiết, dựng lập',
      example_hanzi = '政府计划在城市东郊新建一所现代化的综合性大型医院。',
      example_pinyin = 'Zhèngfǔ jìhuà zài chéngshì dōngjiāo xīn jiàn yì suǒ xiàndàihuà de zōnghéxìng dàxíng yīyuàn.',
      example_vi = 'Chính quyền có kế hoạch xây dựng mới một bệnh viện đa khoa lớn hiện đại ở vùng ngoại ô phía đông thành phố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '建',
      'jiàn',
      'xây, xây dựng, kiến thiết, dựng lập',
      'Động từ',
      'HSK 5',
      '政府计划在城市东郊新建一所现代化的综合性大型医院。',
      'Zhèngfǔ jìhuà zài chéngshì dōngjiāo xīn jiàn yì suǒ xiàndàihuà de zōnghéxìng dàxíng yīyuàn.',
      'Chính quyền có kế hoạch xây dựng mới một bệnh viện đa khoa lớn hiện đại ở vùng ngoại ô phía đông thành phố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '政府计划在城市东郊新建一所现代化的综合性大型医院。', 'Zhèngfǔ jìhuà zài chéngshì dōngjiāo xīn jiàn yì suǒ xiàndàihuà de zōnghéxìng dàxíng yīyuàn.', 'Chính quyền có kế hoạch xây dựng mới một bệnh viện đa khoa lớn hiện đại ở vùng ngoại ô phía đông thành phố.', 'basic', 1),
      (v_id, '为深入推进全国统一大市场建设，有关部门加快构建高标准市场体系与多层次数字物流骨干网络。', 'Wèi shēnrù tuījìn quánguó tǒngyī dà shìchǎng jiànshè, yǒuguān bùmén jiākuài gòujiàn gāo biāozhǔn shìchǎng tǐxì yǔ duō céngcì shùzì wùliú gǔgàn wǎngluò.', 'Nhằm đẩy mạnh việc xây dựng thị trường lớn thống nhất toàn quốc, các ban ngành hữu quan đang tăng tốc thiết lập hệ thống thị trường tiêu chuẩn cao và mạng lưới vận tải số xương sống đa tầng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2573] [键] (jiàn) - phím (bàn phím), nút bấm; then chốt, mấu chốt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '键' AND pinyin = 'jiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '键' AND pinyin = 'jiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '键'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '键'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiàn',
      meaning_vi = 'phím (bàn phím), nút bấm; then chốt, mấu chốt',
      example_hanzi = '按一下电脑键盘上的回车键，就可以发送这条消息了。',
      example_pinyin = 'Àn yíxià diànnǎo jiànpán shang de huíchē jiàn, jiù kěyǐ fāsòng zhè tiáo xiāoxi le.',
      example_vi = 'Nhấn một cái vào phím Enter trên bàn phím máy tính là có thể gửi tin nhắn này đi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '键',
      'jiàn',
      'phím (bàn phím), nút bấm; then chốt, mấu chốt',
      'Danh từ',
      'HSK 5',
      '按一下电脑键盘上的回车键，就可以发送这条消息了。',
      'Àn yíxià diànnǎo jiànpán shang de huíchē jiàn, jiù kěyǐ fāsòng zhè tiáo xiāoxi le.',
      'Nhấn một cái vào phím Enter trên bàn phím máy tính là có thể gửi tin nhắn này đi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '按一下电脑键盘上的回车键，就可以发送这条消息了。', 'Àn yíxià diànnǎo jiànpán shang de huíchē jiàn, jiù kěyǐ fāsòng zhè tiáo xiāoxi le.', 'Nhấn một cái vào phím Enter trên bàn phím máy tính là có thể gửi tin nhắn này đi.', 'basic', 1),
      (v_id, '在现代网络通信加密技术中，高强度非对称公钥与私钥密钥对是确保跨境数据安全传输不可或缺的核心安全机制。', 'Zài xiàndài wǎngluò tōngxìn jiāmì jìshù zhōng, gāo qiángdù fēiduìchèn gōngyào yǔ sīyào mìyào duì shì quèbǎo kuàjìng shùjù ānquán chuānshū bùkě-huòquē de héxīn ānquán jīzhì.', 'Trong công nghệ mã hóa truyền thông mạng hiện đại, cặp khóa công khai và bí mật bất đối xứng cường độ cao là cơ chế an ninh cốt lõi không thể thiếu bảo đảm sự truyền dẫn an toàn cho dữ liệu xuyên biên giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2574] [渐渐] (jiànjiàn) - dần dần, từ từ [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '渐渐' AND pinyin = 'jiànjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '渐渐' AND pinyin = 'jiànjiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '渐渐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '渐渐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jiànjiàn',
      meaning_vi = 'dần dần, từ từ',
      example_hanzi = '春天来了，天气渐渐变暖，公园里的百花也竞相盛开。',
      example_pinyin = 'Chūntiān lái le, tiānqì jiànjiàn biàn nuǎn, gōngyuán lǐ de bǎihuā yě jìngxiāng shèngkāi.',
      example_vi = 'Mùa xuân đến rồi, tiết trời dần dần ấm lên, trăm hoa trong công viên đua nhau khoe sắc nở rộ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '渐渐',
      'jiànjiàn',
      'dần dần, từ từ',
      'Phó từ',
      'HSK 5',
      '春天来了，天气渐渐变暖，公园里的百花也竞相盛开。',
      'Chūntiān lái le, tiānqì jiànjiàn biàn nuǎn, gōngyuán lǐ de bǎihuā yě jìngxiāng shèngkāi.',
      'Mùa xuân đến rồi, tiết trời dần dần ấm lên, trăm hoa trong công viên đua nhau khoe sắc nở rộ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春天来了，天气渐渐变暖，公园里的百花也竞相盛开。', 'Chūntiān lái le, tiānqì jiànjiàn biàn nuǎn, gōngyuán lǐ de bǎihuā yě jìngxiāng shèngkāi.', 'Mùa xuân đến rồi, tiết trời dần dần ấm lên, trăm hoa trong công viên đua nhau khoe sắc nở rộ.', 'basic', 1),
      (v_id, '随着长期文化交融与经济互补，边境两国民众在日常生活与思想观念上的隔阂正渐渐消弭。', 'Suízhe chángqī wénhuà jiāoróng yǔ jīngjì hùbǔ, biānjìng liǎng guó mínzhòng zài rìcháng shēnghuó yǔ sīxiǎng guānniàn shang de géhé zhèng jiànjiàn xiāomǐ.', 'Cùng với sự giao thoa văn hóa lâu đời và bổ sung kinh tế cho nhau, những rào cản ngăn cách trong đời sống thường nhật và quan niệm tư tưởng của người dân hai nước vùng biên đang dần dần được xóa nhòa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2575] [建立] (jiànlì) - thành lập, xây dựng, xác lập, thiết lập [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '建立' AND pinyin = 'jiànlì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建立' AND pinyin = 'jiànlì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '建立'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建立'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiànlì',
      meaning_vi = 'thành lập, xây dựng, xác lập, thiết lập',
      example_hanzi = '两所大学正式签署合作办学协议，建立了长期稳定的学术交流机制。',
      example_pinyin = 'Liǎng suǒ dàxué zhèngshì qiānshǔ hézuò bànxué xiéyì, jiànlì le chángqī wěndìng de xuéshù jiāoliú jīzhì.',
      example_vi = 'Hai trường đại học chính thức ký kết thỏa thuận liên kết đào tạo, thiết lập cơ chế giao lưu học thuật lâu dài và ổn định.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '建立',
      'jiànlì',
      'thành lập, xây dựng, xác lập, thiết lập',
      'Động từ',
      'HSK 5',
      '两所大学正式签署合作办学协议，建立了长期稳定的学术交流机制。',
      'Liǎng suǒ dàxué zhèngshì qiānshǔ hézuò bànxué xiéyì, jiànlì le chángqī wěndìng de xuéshù jiāoliú jīzhì.',
      'Hai trường đại học chính thức ký kết thỏa thuận liên kết đào tạo, thiết lập cơ chế giao lưu học thuật lâu dài và ổn định.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '两所大学正式签署合作办学协议，建立了长期稳定的学术交流机制。', 'Liǎng suǒ dàxué zhèngshì qiānshǔ hézuò bànxué xiéyì, jiànlì le chángqī wěndìng de xuéshù jiāoliú jīzhì.', 'Hai trường đại học chính thức ký kết thỏa thuận liên kết đào tạo, thiết lập cơ chế giao lưu học thuật lâu dài và ổn định.', 'basic', 1),
      (v_id, '为防范化解金融系统性风险，监管机构加快建立起覆盖全面、穿透精准、响应迅速的宏观审慎金融监管框架。', 'Wèi fángfàn huàjiě jīnróng xìtǒngxìng fēngxiǎn, jiānguǎn jīgòu jiākuài jiànlì qǐ fùgài quánmiàn, chuāntòu jīngzhǔn, xiǎngyìng xùnsù de hóngguān shěnshèn jīnróng jiānguǎn kuàngjià.', 'Nhằm phòng ngừa và hóa giải rủi ro hệ thống tài chính, các cơ quan giám sát đang khẩn trương thiết lập khung giám sát tài chính cẩn trọng vĩ mô có độ bao phủ toàn diện, khả năng xuyên thấu chính xác và phản ứng nhanh nhạy.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2576] [键盘] (jiànpán) - bàn phím (máy tính, nhạc cụ) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '键盘' AND pinyin = 'jiànpán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '键盘' AND pinyin = 'jiànpán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '键盘'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '键盘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiànpán',
      meaning_vi = 'bàn phím (máy tính, nhạc cụ)',
      example_hanzi = '程序员每天长时间使用键盘敲代码，最好选用符合人体工学设计的机械键盘。',
      example_pinyin = 'Chéngxùyuán měi tiān cháng shíjiān shǐyòng jiànpán qiāo dàimǎ, zuìhǎo xuǎnyòng fúhé réntǐ gōngxué shèjì de jīxiè jiànpán.',
      example_vi = 'Lập trình viên mỗi ngày gõ code trong thời gian dài trên bàn phím, tốt nhất nên lựa chọn bàn phím cơ được thiết kế theo công thái học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '键盘',
      'jiànpán',
      'bàn phím (máy tính, nhạc cụ)',
      'Danh từ',
      'HSK 5',
      '程序员每天长时间使用键盘敲代码，最好选用符合人体工学设计的机械键盘。',
      'Chéngxùyuán měi tiān cháng shíjiān shǐyòng jiànpán qiāo dàimǎ, zuìhǎo xuǎnyòng fúhé réntǐ gōngxué shèjì de jīxiè jiànpán.',
      'Lập trình viên mỗi ngày gõ code trong thời gian dài trên bàn phím, tốt nhất nên lựa chọn bàn phím cơ được thiết kế theo công thái học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '程序员每天长时间使用键盘敲代码，最好选用符合人体工学设计的机械键盘。', 'Chéngxùyuán měi tiān cháng shíjiān shǐyòng jiànpán qiāo dàimǎ, zuìhǎo xuǎnyòng fúhé réntǐ gōngxué shèjì de jīxiè jiànpán.', 'Lập trình viên mỗi ngày gõ code trong thời gian dài trên bàn phím, tốt nhất nên lựa chọn bàn phím cơ được thiết kế theo công thái học.', 'basic', 1),
      (v_id, '随着无障碍信息技术的发展，支持盲文触觉反馈与眼球追踪的智能虚拟键盘为视障及残障人士顺畅使用数字设备带来了极大便利。', 'Suízhe wúzhàng’ài xìnxī jìshù de fāzhǎn, zhīchí mángwén chùjué fǎnduì yǔ yǎnqiú zhuīzōng de zhìnéng xūnǐ jiànpán wèi shìzhàng jí cánzhàng rénshì shùnchàng shǐyòng shùzì shèbèi dàilái le jídà biànlì.', 'Cùng với sự phát triển của công nghệ thông tin không rào cản, bàn phím ảo thông minh hỗ trợ xúc giác phản hồi chữ nổi Braille và theo dõi ánh mắt đã mang lại sự thuận tiện to lớn cho người khiếm thị và người khuyết tật khi tiếp cận các thiết bị số.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2577] [建设] (jiànshè) - xây dựng, kiến thiết; công cuộc xây dựng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '建设' AND pinyin = 'jiànshè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建设' AND pinyin = 'jiànshè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '建设'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建设'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiànshè',
      meaning_vi = 'xây dựng, kiến thiết; công cuộc xây dựng',
      example_hanzi = '全镇居民正齐心协力投入到美丽乡村的建设当中。',
      example_pinyin = 'Quán zhèn jūmín zhèng qíxīn-xiélì tóurù dào měilì xiāngcūn de jiànshè dāngzhōng.',
      example_vi = 'Toàn thể cư dân trong thị trấn đang đồng lòng chung sức dấn thân vào công cuộc xây dựng nông thôn tươi đẹp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '建设',
      'jiànshè',
      'xây dựng, kiến thiết; công cuộc xây dựng',
      'Động từ / Danh từ',
      'HSK 5',
      '全镇居民正齐心协力投入到美丽乡村的建设当中。',
      'Quán zhèn jūmín zhèng qíxīn-xiélì tóurù dào měilì xiāngcūn de jiànshè dāngzhōng.',
      'Toàn thể cư dân trong thị trấn đang đồng lòng chung sức dấn thân vào công cuộc xây dựng nông thôn tươi đẹp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '全镇居民正齐心协力投入到美丽乡村的建设当中。', 'Quán zhèn jūmín zhèng qíxīn-xiélì tóurù dào měilì xiāngcūn de jiànshè dāngzhōng.', 'Toàn thể cư dân trong thị trấn đang đồng lòng chung sức dấn thân vào công cuộc xây dựng nông thôn tươi đẹp.', 'basic', 1),
      (v_id, '国家统筹推进新型数字基础设施建设，加快布局第五代移动通信基站、超算中心与工业互联网平台。', 'Guójiā tǒngchóu tuījìn xīnxíng shùzì jīchǔ shèshī jiànshè, jiākuài bùjú dì-wǔ dài yídòng tōngxìn jīzhàn, chāosuàn zhōngxīn yǔ gōngyè hùliánwǎng píngtái.', 'Nhà nước quy hoạch tổng thể đẩy mạnh việc xây dựng hạ tầng cơ sở kỹ thuật số kiểu mới, đẩy nhanh bố trí các trạm phát sóng 5G, trung tâm siêu tính toán và nền tảng Internet công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2578] [建造] (jiànzào) - xây dựng, chế tạo, đóng (tàu, công trình) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '建造' AND pinyin = 'jiànzào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建造' AND pinyin = 'jiànzào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '建造'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建造'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiànzào',
      meaning_vi = 'xây dựng, chế tạo, đóng (tàu, công trình)',
      example_hanzi = '工人们仅用了半年时间就建造好了一座宽敞现代的体育场馆。',
      example_pinyin = 'Gōngrénmen jǐn yòng le bàn nián shíjiān jiù jiànzào hǎo le yí zuò kuānchǎng xiàndài de tǐyù chǎngguǎn.',
      example_vi = 'Các công nhân chỉ mất nửa năm đã thi công hoàn tất một sân vận động hiện đại và rộng rãi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '建造',
      'jiànzào',
      'xây dựng, chế tạo, đóng (tàu, công trình)',
      'Động từ',
      'HSK 5',
      '工人们仅用了半年时间就建造好了一座宽敞现代的体育场馆。',
      'Gōngrénmen jǐn yòng le bàn nián shíjiān jiù jiànzào hǎo le yí zuò kuānchǎng xiàndài de tǐyù chǎngguǎn.',
      'Các công nhân chỉ mất nửa năm đã thi công hoàn tất một sân vận động hiện đại và rộng rãi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '工人们仅用了半年时间就建造好了一座宽敞现代的体育场馆。', 'Gōngrénmen jǐn yòng le bàn nián shíjiān jiù jiànzào hǎo le yí zuò kuānchǎng xiàndài de tǐyù chǎngguǎn.', 'Các công nhân chỉ mất nửa năm đã thi công hoàn tất một sân vận động hiện đại và rộng rãi.', 'basic', 1),
      (v_id, '我国自主设计并建造的首艘国产大型豪华邮轮顺利交付，标志着高端海洋船舶建造工业实现了历史性突破。', 'Wǒ guó zìzhǔ shèjì bìng jiànzào de shǒu sōu guóchǎn dàxíng háohuá yóulún shùnlì jiāofù, biāozhì zhe gāoduān hǎiyáng chuánbó jiànzào gōngyè shíxiàn le lìshǐxìng tūpò.', 'Chiếc du thuyền siêu sang cỡ lớn nội địa đầu tiên do nước ta tự chủ thiết kế và đóng mới đã được bàn giao thuận lợi, đánh dấu ngành công nghiệp đóng tàu biển cao cấp đã đạt được bước đột phá mang tính lịch sử.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2579] [建筑] (jiànzhù) - kiến trúc, công trình kiến trúc; xây cất [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '建筑' AND pinyin = 'jiànzhù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建筑' AND pinyin = 'jiànzhù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '建筑'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '建筑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'jiànzhù',
      meaning_vi = 'kiến trúc, công trình kiến trúc; xây cất',
      example_hanzi = '漫步在上海外滩，可以看到许多风格独特的近代历史建筑。',
      example_pinyin = 'Mànbù zài Shànghǎi Wàitān, kěyǐ kàndào xǔduō fēnggé dútè de jìndài lìshǐ jiànzhù.',
      example_vi = 'Tản bộ trên Bến Thượng Hải, người ta có thể chiêm ngưỡng rất nhiều công trình kiến trúc lịch sử cận đại mang phong cách độc đáo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '建筑',
      'jiànzhù',
      'kiến trúc, công trình kiến trúc; xây cất',
      'Danh từ / Động từ',
      'HSK 5',
      '漫步在上海外滩，可以看到许多风格独特的近代历史建筑。',
      'Mànbù zài Shànghǎi Wàitān, kěyǐ kàndào xǔduō fēnggé dútè de jìndài lìshǐ jiànzhù.',
      'Tản bộ trên Bến Thượng Hải, người ta có thể chiêm ngưỡng rất nhiều công trình kiến trúc lịch sử cận đại mang phong cách độc đáo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '漫步在上海外滩，可以看到许多风格独特的近代历史建筑。', 'Mànbù zài Shànghǎi Wàitān, kěyǐ kàndào xǔduō fēnggé dútè de jìndài lìshǐ jiànzhù.', 'Tản bộ trên Bến Thượng Hải, người ta có thể chiêm ngưỡng rất nhiều công trình kiến trúc lịch sử cận đại mang phong cách độc đáo.', 'basic', 1),
      (v_id, '现代绿色生态建筑倡导将自然采光、雨水循环回收及太阳能光伏系统与建筑本体结构有机融为一体。', 'Xiàndài lǜsè shēngtài jiànzhù chàngdǎo jiāng zìrán cǎiguāng, yǔshuǐ xúnhuán huíshōu jí tàiyángnéng guāngfú xìtǒng yǔ jiànzhù běntǐ jiégòu yǒujī róng wéi yītǐ.', 'Kiến trúc sinh thái xanh hiện đại chủ trương dung hợp hữu cơ việc đón sáng tự nhiên, tuần hoàn tái sử dụng nước mưa và hệ thống điện mặt trời áp mái vào cùng kết cấu thân công trình kiến trúc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2580] [将近] (jiāngjìn) - gần, ngót, xấp xỉ, ngót nghét [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '将近' AND pinyin = 'jiāngjìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '将近' AND pinyin = 'jiāngjìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '将近'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '将近'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jiāngjìn',
      meaning_vi = 'gần, ngót, xấp xỉ, ngót nghét',
      example_hanzi = '他在外地工作了将近五年，终于调回老家与父母团聚。',
      example_pinyin = 'Tā zài wàidì gōngzuò le jiāngjìn wǔ nián, zhōngyú diàohuí lǎojiā yǔ fùmǔ tuánjù.',
      example_vi = 'Anh ấy làm việc ở nơi khác ngót nghét 5 năm, cuối cùng đã được điều chuyển về quê nhà sum vầy cùng bố mẹ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '将近',
      'jiāngjìn',
      'gần, ngót, xấp xỉ, ngót nghét',
      'Phó từ',
      'HSK 5',
      '他在外地工作了将近五年，终于调回老家与父母团聚。',
      'Tā zài wàidì gōngzuò le jiāngjìn wǔ nián, zhōngyú diàohuí lǎojiā yǔ fùmǔ tuánjù.',
      'Anh ấy làm việc ở nơi khác ngót nghét 5 năm, cuối cùng đã được điều chuyển về quê nhà sum vầy cùng bố mẹ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在外地工作了将近五年，终于调回老家与父母团聚。', 'Tā zài wàidì gōngzuò le jiāngjìn wǔ nián, zhōngyú diàohuí lǎojiā yǔ fùmǔ tuánjù.', 'Anh ấy làm việc ở nơi khác ngót nghét 5 năm, cuối cùng đã được điều chuyển về quê nhà sum vầy cùng bố mẹ.', 'basic', 1),
      (v_id, '该科研团队历经将近十年的潜心攻关与反复实验验证，终于攻克了关键芯片光刻胶配方的核心制备技术。', 'Gāi kēyán tuánduì lìjīng jiāngjìn shí nián de qiǎnxīn gōngguān yǔ fǎnfù shíyàn yànzhèng, zhōngyú gōngkè le guānjiàn xīnpiàn guāngkèjiāo pèifāng de héxīn zhìbèi jìshù.', 'Đội ngũ nghiên cứu khoa học này trải qua gần mười năm miệt mài nghiên cứu đột phá và kiểm chứng thực nghiệm lặp đi lặp lại, cuối cùng đã chinh phục được kỹ thuật bào chế cốt lõi của công thức chất cản quang cho chip then chốt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2581] [讲话] (jiǎnghuà) - nói chuyện, phát biểu; bài phát biểu, lời phát biểu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '讲话' AND pinyin = 'jiǎnghuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '讲话' AND pinyin = 'jiǎnghuà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '讲话'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '讲话'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiǎnghuà',
      meaning_vi = 'nói chuyện, phát biểu; bài phát biểu, lời phát biểu',
      example_hanzi = '在开学典礼上，校长发表了热情洋溢的讲话，勉励新生刻苦求知。',
      example_pinyin = 'Zài kāixué diǎnlǐ shang, xiàozhǎng fābiǎo le rèqíng-yángyì de jiǎnghuà, miǎnlì xīnshēng kèkǔ qiúzhī.',
      example_vi = 'Tại lễ khai giảng, hiệu trưởng đã có bài phát biểu tràn đầy nhiệt huyết, khích lệ tân sinh viên chăm chỉ học tập tìm tòi tri thức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '讲话',
      'jiǎnghuà',
      'nói chuyện, phát biểu; bài phát biểu, lời phát biểu',
      'Động từ / Danh từ',
      'HSK 5',
      '在开学典礼上，校长发表了热情洋溢的讲话，勉励新生刻苦求知。',
      'Zài kāixué diǎnlǐ shang, xiàozhǎng fābiǎo le rèqíng-yángyì de jiǎnghuà, miǎnlì xīnshēng kèkǔ qiúzhī.',
      'Tại lễ khai giảng, hiệu trưởng đã có bài phát biểu tràn đầy nhiệt huyết, khích lệ tân sinh viên chăm chỉ học tập tìm tòi tri thức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在开学典礼上，校长发表了热情洋溢的讲话，勉励新生刻苦求知。', 'Zài kāixué diǎnlǐ shang, xiàozhǎng fābiǎo le rèqíng-yángyì de jiǎnghuà, miǎnlì xīnshēng kèkǔ qiúzhī.', 'Tại lễ khai giảng, hiệu trưởng đã có bài phát biểu tràn đầy nhiệt huyết, khích lệ tân sinh viên chăm chỉ học tập tìm tòi tri thức.', 'basic', 1),
      (v_id, '国际货币基金组织总裁在年会开幕式上的主旨讲话中强调，各国必须加强多边政策协调以共同防范全球债务外溢风险。', 'Guójì Huòbì Jījīnzǔzhī zǒngcái zài niánhuì kāimùshì shang de zhǔzhǐ jiǎnghuà zhōng qiángdiào, gè guó bìxū jiāqiáng duōbiān zhèngcè xiétiáo yǐ gòngtóng fángfàn quánqiú zhàiwù wàiyì fēngxiǎn.', 'Tổng giám đốc Quỹ Tiền tệ Quốc tế trong bài phát biểu chủ đề tại lễ khai mạc hội nghị thường niên đã nhấn mạnh rằng, các quốc gia phải tăng cường điều phối chính sách đa phương nhằm cùng phòng ngừa rủi ro lan truyền nợ công toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2582] [讲究] (jiǎngjiu) - chú trọng, cầu kỳ, tinh tế; điều cần lưu ý [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '讲究' AND pinyin = 'jiǎngjiu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '讲究' AND pinyin = 'jiǎngjiu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '讲究'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '讲究'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'jiǎngjiu',
      meaning_vi = 'chú trọng, cầu kỳ, tinh tế; điều cần lưu ý',
      example_hanzi = '泡好一杯中国名茶，对水质、水温和冲泡手法都非常讲究。',
      example_pinyin = 'Pào hǎo yì bēi Zhōngguó míngchá, duì shuǐzhì, shuǐwēn hé chōngpào shǒufǎ dōu fēicháng jiǎngjiu.',
      example_vi = 'Để pha được một chén danh trà Trung Hoa ngon, người ta vô cùng chú trọng đến phẩm chất nước, nhiệt độ nước và thủ pháp pha trà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '讲究',
      'jiǎngjiu',
      'chú trọng, cầu kỳ, tinh tế; điều cần lưu ý',
      'Động từ / Tính từ',
      'HSK 5',
      '泡好一杯中国名茶，对水质、水温和冲泡手法都非常讲究。',
      'Pào hǎo yì bēi Zhōngguó míngchá, duì shuǐzhì, shuǐwēn hé chōngpào shǒufǎ dōu fēicháng jiǎngjiu.',
      'Để pha được một chén danh trà Trung Hoa ngon, người ta vô cùng chú trọng đến phẩm chất nước, nhiệt độ nước và thủ pháp pha trà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '泡好一杯中国名茶，对水质、水温和冲泡手法都非常讲究。', 'Pào hǎo yì bēi Zhōngguó míngchá, duì shuǐzhì, shuǐwēn hé chōngpào shǒufǎ dōu fēicháng jiǎngjiu.', 'Để pha được một chén danh trà Trung Hoa ngon, người ta vô cùng chú trọng đến phẩm chất nước, nhiệt độ nước và thủ pháp pha trà.', 'basic', 1),
      (v_id, '传统手工苏绣艺术不仅在丝线劈丝上极度讲究，其配色运针更是讲究虚实相映、气韵生动。', 'Chuántǒng shǒugōng Sūxiù yìshù bùjǐn zài sīxiàn pīsī shang jídù jiǎngjiu, qí pèisè yùnzhēn gèngshì jiǎngjiu xū-shí xiāngyìng, qìyùn shēngdòng.', 'Nghệ thuật thêu tay truyền thống Tô Châu không chỉ cực kỳ cầu kỳ trong thao tác tách tơ sợi, mà khâu phối màu và đường kim mũi chỉ càng chú trọng sự tương phản hư thực, khí vận sinh động.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2583] [奖励] (jiǎnglì) - khen thưởng, phần thưởng, giải thưởng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '奖励' AND pinyin = 'jiǎnglì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '奖励' AND pinyin = 'jiǎnglì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '奖励'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '奖励'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiǎnglì',
      meaning_vi = 'khen thưởng, phần thưởng, giải thưởng',
      example_hanzi = '学校对在本学期期末考试中成绩名列前茅的优秀学生给予了表彰和奖励。',
      example_pinyin = 'Xuéxiào duì zài běn xuéqī qīmò kǎoshì zhōng chéngjì míngliè-qiánmáo de yōuxiù xuésheng jǐyǔ le biǎozhāng hé jiǎnglì.',
      example_vi = 'Nhà trường đã tuyên dương và trao phần thưởng cho những học sinh xuất sắc đứng trong top đầu ở kỳ thi cuối kỳ đợt này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '奖励',
      'jiǎnglì',
      'khen thưởng, phần thưởng, giải thưởng',
      'Động từ / Danh từ',
      'HSK 5',
      '学校对在本学期期末考试中成绩名列前茅的优秀学生给予了表彰和奖励。',
      'Xuéxiào duì zài běn xuéqī qīmò kǎoshì zhōng chéngjì míngliè-qiánmáo de yōuxiù xuésheng jǐyǔ le biǎozhāng hé jiǎnglì.',
      'Nhà trường đã tuyên dương và trao phần thưởng cho những học sinh xuất sắc đứng trong top đầu ở kỳ thi cuối kỳ đợt này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校对在本学期期末考试中成绩名列前茅的优秀学生给予了表彰和奖励。', 'Xuéxiào duì zài běn xuéqī qīmò kǎoshì zhōng chéngjì míngliè-qiánmáo de yōuxiù xuésheng jǐyǔ le biǎozhāng hé jiǎnglì.', 'Nhà trường đã tuyên dương và trao phần thưởng cho những học sinh xuất sắc đứng trong top đầu ở kỳ thi cuối kỳ đợt này.', 'basic', 1),
      (v_id, '该高新技术企业建立了股权激励与科研转化特别奖励机制，重奖在关键核心算法攻坚中做出卓越贡献的技术带头人。', 'Gāi gāoxīnjìshù qǐyè jiànlì le gǔquán jīlì yǔ kēyán zhuǎnhuà tèbié jiǎnglì jīzhì, zhòngjiǎng zài guānjiàn héxīn suànfǎ gōngjiān zhōng zuòchū zhuóyuè gòngxiàn de jìshù dàitóurén.', 'Doanh nghiệp công nghệ cao này đã thiết lập cơ chế khích lệ bằng cổ phần và khen thưởng đặc biệt đối với việc chuyển hóa nghiên cứu khoa học, trọng thưởng cho các thủ lĩnh kỹ thuật có cống hiến vượt trội trong việc giải quyết thuật toán cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2584] [讲述] (jiǎngshù) - kể lại, thuật lại, trình bày [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '讲述' AND pinyin = 'jiǎngshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '讲述' AND pinyin = 'jiǎngshù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '讲述'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '讲述'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiǎngshù',
      meaning_vi = 'kể lại, thuật lại, trình bày',
      example_hanzi = '老红军爷爷神情动容地为少先队员们讲述当年的战斗故事。',
      example_pinyin = 'Lǎo hóngjūn yéye shénqíng dòngróng de wèi shàoxiān-duìyuánmen jiǎngshù dāngnián de zhàndòu gùshì.',
      example_vi = 'Người cựu chiến binh Hồng quân với nét mặt xúc động đã kể lại cho các bạn đội viên thiếu niên câu chuyện chiến đấu oanh liệt năm nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '讲述',
      'jiǎngshù',
      'kể lại, thuật lại, trình bày',
      'Động từ',
      'HSK 5',
      '老红军爷爷神情动容地为少先队员们讲述当年的战斗故事。',
      'Lǎo hóngjūn yéye shénqíng dòngróng de wèi shàoxiān-duìyuánmen jiǎngshù dāngnián de zhàndòu gùshì.',
      'Người cựu chiến binh Hồng quân với nét mặt xúc động đã kể lại cho các bạn đội viên thiếu niên câu chuyện chiến đấu oanh liệt năm nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老红军爷爷神情动容地为少先队员们讲述当年的战斗故事。', 'Lǎo hóngjūn yéye shénqíng dòngróng de wèi shàoxiān-duìyuánmen jiǎngshù dāngnián de zhàndòu gùshì.', 'Người cựu chiến binh Hồng quân với nét mặt xúc động đã kể lại cho các bạn đội viên thiếu niên câu chuyện chiến đấu oanh liệt năm nào.', 'basic', 1),
      (v_id, '纪录片生动讲述了三代塞罕坝务林人历经数十载风霜雨雪，将昔日飞沙走石的荒原变成万顷浩瀚林海的塞罕坝奇迹。', 'Jìlùpiàn shēngdòng jiǎngshù le sān dài Sàihǎnbà wùlínrén lìjīng shùshí zǎi fēngshuāng-yǔxuě, jiāng xīrì fēishā-zǒushí de huāngyuán biànchéng wànqǐng hàohàn línhǎi de Sàihǎnbà qíjì.', 'Bộ phim tài liệu đã thuật lại sinh động câu chuyện ba thế hệ người làm rừng Saihanba vượt qua hàng chục năm dãi dầu sương tuyết gió mưa, biến vùng hoang mạc sỏi cát bay ngày nào thành kỳ tích biển rừng bạt ngàn hàng vạn mẫu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2585] [讲座] (jiǎngzuò) - buổi tọa đàm, thuyết trình, bài giảng chuyên đề [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '讲座' AND pinyin = 'jiǎngzuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '讲座' AND pinyin = 'jiǎngzuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '讲座'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '讲座'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiǎngzuò',
      meaning_vi = 'buổi tọa đàm, thuyết trình, bài giảng chuyên đề',
      example_hanzi = '今天下午大学礼堂有一场关于跨文化交际的学术讲座，欢迎同学们积极参加。',
      example_pinyin = 'Jīntiān xiàwǔ dàxué lǐtáng yǒu yì chǎng guānyú kuà wénhuà jiāojì de xuéshù jiǎngzuò, huānyíng tóngxuémen jījí cānjiā.',
      example_vi = 'Chiều hôm nay tại giảng đường đại học có một buổi tọa đàm học thuật về giao tiếp liên văn hóa, hoan nghênh các bạn sinh viên tích cực tham gia.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '讲座',
      'jiǎngzuò',
      'buổi tọa đàm, thuyết trình, bài giảng chuyên đề',
      'Danh từ',
      'HSK 5',
      '今天下午大学礼堂有一场关于跨文化交际的学术讲座，欢迎同学们积极参加。',
      'Jīntiān xiàwǔ dàxué lǐtáng yǒu yì chǎng guānyú kuà wénhuà jiāojì de xuéshù jiǎngzuò, huānyíng tóngxuémen jījí cānjiā.',
      'Chiều hôm nay tại giảng đường đại học có một buổi tọa đàm học thuật về giao tiếp liên văn hóa, hoan nghênh các bạn sinh viên tích cực tham gia.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天下午大学礼堂有一场关于跨文化交际的学术讲座，欢迎同学们积极参加。', 'Jīntiān xiàwǔ dàxué lǐtáng yǒu yì chǎng guānyú kuà wénhuà jiāojì de xuéshù jiǎngzuò, huānyíng tóngxuémen jījí cānjiā.', 'Chiều hôm nay tại giảng đường đại học có một buổi tọa đàm học thuật về giao tiếp liên văn hóa, hoan nghênh các bạn sinh viên tích cực tham gia.', 'basic', 1),
      (v_id, '知名经济学家受邀走进商学院大师讲堂，开展了一场题为全球宏观经济重构与企业出海战略深度剖析的高端前沿讲座。', 'Zhīmíng jīngjìxuéjiā shòuyāo zǒujìn shāngxuéyuàn dàshī jiǎngtáng, kāizhǎn le yì chǎng tíwéi quánqiú hóngguān jīngjì chónggòu yǔ qǐyè chūhǎi zhànlüè shēndù pōuxī de gāoduān qiányán jiǎngzuò.', 'Nhà kinh tế học nổi tiếng được mời đến giảng đường bậc thầy của trường kinh doanh, đã thực hiện một buổi thuyết trình chuyên đề đỉnh cao phân tích sâu sắc về tái cấu trúc kinh tế vĩ mô toàn cầu và chiến lược vươn ra biển lớn của doanh nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2586] [降水] (jiàngshuǐ) - lượng mưa, giáng thủy (mưa tuyết rơi xuống) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '降水' AND pinyin = 'jiàngshuǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '降水' AND pinyin = 'jiàngshuǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '降水'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '降水'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiàngshuǐ',
      meaning_vi = 'lượng mưa, giáng thủy (mưa tuyết rơi xuống)',
      example_hanzi = '气象预报显示，本周末南方大部分地区将迎来新一轮明显降水天气。',
      example_pinyin = 'Qìxiàng yùbào xiǎnshì, běn zhōumò nánfāng dàbùfen dìqū jiāng yínglái xīn yì lún míngxiǎn jiàngshuǐ tiānqì.',
      example_vi = 'Dự báo khí tượng cho thấy cuối tuần này phần lớn các khu vực phía Nam sẽ đón nhận một đợt thời tiết có mưa rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '降水',
      'jiàngshuǐ',
      'lượng mưa, giáng thủy (mưa tuyết rơi xuống)',
      'Danh từ',
      'HSK 5',
      '气象预报显示，本周末南方大部分地区将迎来新一轮明显降水天气。',
      'Qìxiàng yùbào xiǎnshì, běn zhōumò nánfāng dàbùfen dìqū jiāng yínglái xīn yì lún míngxiǎn jiàngshuǐ tiānqì.',
      'Dự báo khí tượng cho thấy cuối tuần này phần lớn các khu vực phía Nam sẽ đón nhận một đợt thời tiết có mưa rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '气象预报显示，本周末南方大部分地区将迎来新一轮明显降水天气。', 'Qìxiàng yùbào xiǎnshì, běn zhōumò nánfāng dàbùfen dìqū jiāng yínglái xīn yì lún míngxiǎn jiàngshuǐ tiānqì.', 'Dự báo khí tượng cho thấy cuối tuần này phần lớn các khu vực phía Nam sẽ đón nhận một đợt thời tiết có mưa rõ rệt.', 'basic', 1),
      (v_id, '全球气候变暖导致极端天气事件发生频率上升，局部地区短时强降水极易诱发山洪暴发与城市内涝等次生衍生灾害。', 'Quánqiú qìhòu biànnuǎn dǎozhì jíduān tiānqì shìjiàn fāshēng pínlǜ shàngshēng, júbù dìqū duǎnshí qiáng jiàngshuǐ jí yì yòufā shānhóng bàofā yǔ chéngshì nèilào děng cìshēng yǎnshēng zāihài.', 'Biến đổi khí hậu nóng lên toàn cầu dẫn đến tần suất các hiện tượng thời tiết cực đoan gia tăng, mưa lớn ngắn hạn cục bộ rất dễ gây ra lũ quét vùng núi và ngập úng đô thị cùng các hiểm họa thứ cấp đi kèm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2587] [浇] (jiāo) - tưới (nước), dội, đúc (bê tông) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '浇' AND pinyin = 'jiāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '浇' AND pinyin = 'jiāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '浇'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '浇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiāo',
      meaning_vi = 'tưới (nước), dội, đúc (bê tông)',
      example_hanzi = '阳台上的这盆绿萝需要每隔两天给它浇一次水。',
      example_pinyin = 'Yángtái shang de zhè pén lǜluó xūyào měi gé liǎng tiān gěi tā jiāo yí cì shuǐ.',
      example_vi = 'Chậu trầu bà xanh trên ban công này cần cứ cách hai ngày lại tưới nước cho nó một lần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '浇',
      'jiāo',
      'tưới (nước), dội, đúc (bê tông)',
      'Động từ',
      'HSK 5',
      '阳台上的这盆绿萝需要每隔两天给它浇一次水。',
      'Yángtái shang de zhè pén lǜluó xūyào měi gé liǎng tiān gěi tā jiāo yí cì shuǐ.',
      'Chậu trầu bà xanh trên ban công này cần cứ cách hai ngày lại tưới nước cho nó một lần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '阳台上的这盆绿萝需要每隔两天给它浇一次水。', 'Yángtái shang de zhè pén lǜluó xūyào měi gé liǎng tiān gěi tā jiāo yí cì shuǐ.', 'Chậu trầu bà xanh trên ban công này cần cứ cách hai ngày lại tưới nước cho nó một lần.', 'basic', 1),
      (v_id, '在大桥主墩基础工程施工现场，工程技术人员冒着风雨连续作业十余个小时，顺利完成了特大承台混凝土的浇筑任务。', 'Zài dàqiáo zhǔdūn jīchǔ gōngchéng shīgōng xiànchǎng, gōngchéng jìshù rényuán màozhe fēngyǔ liánxù zuòyè shí yú gè xiǎoshí, shùnlì wánchéng le tèdà chéngtái hùnníngtǔ de jiāozhù rènwu.', 'Tại hiện trường thi công móng trụ chính của cây đại cầu, đội ngũ nhân viên kỹ thuật công trình đã đội mưa gió làm việc liên tục hơn mười tiếng đồng hồ, hoàn thành thuận lợi nhiệm vụ đổ bê tông bệ mố siêu lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2588] [交换] (jiāohuàn) - trao đổi, đổi chác, đổi chỗ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '交换' AND pinyin = 'jiāohuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '交换' AND pinyin = 'jiāohuàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '交换'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '交换'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiāohuàn',
      meaning_vi = 'trao đổi, đổi chác, đổi chỗ',
      example_hanzi = '会议休息期间，来自不同行业的参会代表们互相交换了名片并亲切交谈。',
      example_pinyin = 'Huìyì xiūxi qījiān, láizì bùtóng hángyè de cānhuì dàibiǎomen hùxiāng jiāohuàn le míngpiàn bìng qīnqiè jiāotán.',
      example_vi = 'Trong giờ nghỉ giải lao của hội nghị, các đại biểu tham dự đến từ các ngành nghề khác nhau đã trao đổi danh thiếp và trò chuyện thân mật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '交换',
      'jiāohuàn',
      'trao đổi, đổi chác, đổi chỗ',
      'Động từ',
      'HSK 5',
      '会议休息期间，来自不同行业的参会代表们互相交换了名片并亲切交谈。',
      'Huìyì xiūxi qījiān, láizì bùtóng hángyè de cānhuì dàibiǎomen hùxiāng jiāohuàn le míngpiàn bìng qīnqiè jiāotán.',
      'Trong giờ nghỉ giải lao của hội nghị, các đại biểu tham dự đến từ các ngành nghề khác nhau đã trao đổi danh thiếp và trò chuyện thân mật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '会议休息期间，来自不同行业的参会代表们互相交换了名片并亲切交谈。', 'Huìyì xiūxi qījiān, láizì bùtóng hángyè de cānhuì dàibiǎomen hùxiāng jiāohuàn le míngpiàn bìng qīnqiè jiāotán.', 'Trong giờ nghỉ giải lao của hội nghị, các đại biểu tham dự đến từ các ngành nghề khác nhau đã trao đổi danh thiếp và trò chuyện thân mật.', 'basic', 1),
      (v_id, '在两国元首会谈中，双方就国际多边治理、能源绿色转型以及双边经贸合作全面深入地交换了意见，达成了广泛战略共识。', 'Zài liǎng guó yuánshǒu huìtán zhōng, shuāngfāng jiù guójì duōbiān zhìlǐ, néngyuán lǜsè zhuǎnxíng yǐjí shuāngbiān jīngmào hézuò quánmiàn shēnrù de jiāohuàn le yìjiàn, dáchéng le guǎnfàn zhànlüè gòngshí.', 'Trong cuộc hội đàm giữa nguyên thủ hai nước, hai bên đã trao đổi ý kiến toàn diện sâu sắc về quản trị đa phương quốc tế, chuyển dịch năng lượng xanh và hợp tác kinh tế thương mại song phương, đạt được nhiều đồng thuận chiến lược rộng rãi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2589] [交往] (jiāowǎng) - giao thiệp, qua lại, tương tác, giao lưu [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '交往' AND pinyin = 'jiāowǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '交往' AND pinyin = 'jiāowǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '交往'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '交往'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiāowǎng',
      meaning_vi = 'giao thiệp, qua lại, tương tác, giao lưu',
      example_hanzi = '与人交往时，真诚与尊重是最能打动人心的品质。',
      example_pinyin = 'Yǔ rén jiāowǎng shí, zhēnchéng yǔ zūnzhòng shì zuì néng dǎdòng rénxīn de pǐnzhì.',
      example_vi = 'Khi giao tiếp qua lại với người khác, sự chân thành và tôn trọng là những phẩm chất dễ làm lay động lòng người nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '交往',
      'jiāowǎng',
      'giao thiệp, qua lại, tương tác, giao lưu',
      'Động từ / Danh từ',
      'HSK 5',
      '与人交往时，真诚与尊重是最能打动人心的品质。',
      'Yǔ rén jiāowǎng shí, zhēnchéng yǔ zūnzhòng shì zuì néng dǎdòng rénxīn de pǐnzhì.',
      'Khi giao tiếp qua lại với người khác, sự chân thành và tôn trọng là những phẩm chất dễ làm lay động lòng người nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '与人交往时，真诚与尊重是最能打动人心的品质。', 'Yǔ rén jiāowǎng shí, zhēnchéng yǔ zūnzhòng shì zuì néng dǎdòng rénxīn de pǐnzhì.', 'Khi giao tiếp qua lại với người khác, sự chân thành và tôn trọng là những phẩm chất dễ làm lay động lòng người nhất.', 'basic', 1),
      (v_id, '两国间频繁的民间文化交流与青年学者互访，为筑牢双边友好交往的民意基础发挥了极其重要的纽带作用。', 'Liǎng guó jiān pínfán de mínjiān wénhuà jiāoliú yǔ qīngnián xuézhě hùfǎng, wèi zhùláo shuāngbiān yǒuhǎo jiāowǎng de mínyì jīchǔ fāhuī le jíqí zhòngyào de niǔdài zuòyòng.', 'Những hoạt động giao lưu văn hóa dân gian và trao đổi học giả trẻ diễn ra thường xuyên giữa hai nước đã phát huy vai trò cầu nối hết sức quan trọng nhằm đắp bồi vững chắc nền tảng dư luận nhân dân cho mối bang giao hữu nghị song phương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2590] [交易] (jiāoyì) - giao dịch, mua bán [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '交易' AND pinyin = 'jiāoyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '交易' AND pinyin = 'jiāoyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '交易'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '交易'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jiāoyì',
      meaning_vi = 'giao dịch, mua bán',
      example_hanzi = '现在很多人都习惯通过手机应用完成日常的小额转账与线上交易。',
      example_pinyin = 'Xiànzài hěn duō rén dōu xíguàn tōngguò shǒujī yìngyòng wánchéng rìcháng de xiǎo’é zhuǎnzhàng yǔ xiànshàng jiāoyì.',
      example_vi = 'Hiện nay rất nhiều người đã quen chuyển khoản số tiền nhỏ và thực hiện các giao dịch mua sắm trực tuyến thông qua ứng dụng điện thoại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '交易',
      'jiāoyì',
      'giao dịch, mua bán',
      'Động từ / Danh từ',
      'HSK 5',
      '现在很多人都习惯通过手机应用完成日常的小额转账与线上交易。',
      'Xiànzài hěn duō rén dōu xíguàn tōngguò shǒujī yìngyòng wánchéng rìcháng de xiǎo’é zhuǎnzhàng yǔ xiànshàng jiāoyì.',
      'Hiện nay rất nhiều người đã quen chuyển khoản số tiền nhỏ và thực hiện các giao dịch mua sắm trực tuyến thông qua ứng dụng điện thoại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现在很多人都习惯通过手机应用完成日常的小额转账与线上交易。', 'Xiànzài hěn duō rén dōu xíguàn tōngguò shǒujī yìngyòng wánchéng rìcháng de xiǎo’é zhuǎnzhàng yǔ xiànshàng jiāoyì.', 'Hiện nay rất nhiều người đã quen chuyển khoản số tiền nhỏ và thực hiện các giao dịch mua sắm trực tuyến thông qua ứng dụng điện thoại.', 'basic', 1),
      (v_id, '全国碳排放权交易市场的上线与稳健扩容，通过市场化定价机制有效引导控排高耗能企业主动开展节能降碳改造。', 'Quánguó tàn páifàngquán jiāoyì shìchǎng de shàngxiàn yǔ wěnjiàn kuòróng, tōngguò shìchǎnghuà dìngjià jīzhì yǒuxiào yǐndǎo kòngpái gāo hàonéng qǐyè zhǔdòng kāizhǎn jiénéng-jiàngtàn gǎizào.', 'Sự ra mắt và mở rộng ổn định của thị trường giao dịch hạn ngạch phát thải carbon toàn quốc thông qua cơ chế định giá thị trường đã dẫn dắt hiệu quả các doanh nghiệp tiêu hao nhiều năng lượng chủ động cải tạo tiết kiệm năng lượng và giảm phát thải carbon.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2591] [脚步] (jiǎobù) - bước chân, nhịp bước, bước đi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '脚步' AND pinyin = 'jiǎobù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '脚步' AND pinyin = 'jiǎobù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '脚步'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '脚步'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiǎobù',
      meaning_vi = 'bước chân, nhịp bước, bước đi',
      example_hanzi = '听到门外传来熟悉的脚步声，孩子高兴地跑去开门。',
      example_pinyin = 'Tīngdào ménwài chuánlái shúxī de jiǎobù shēng, háizi gāoxìng de pǎo qù kāimén.',
      example_vi = 'Nghe thấy tiếng bước chân quen thuộc truyền lại ngoài cửa, đứa bé thích thú chạy ra mở cửa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '脚步',
      'jiǎobù',
      'bước chân, nhịp bước, bước đi',
      'Danh từ',
      'HSK 5',
      '听到门外传来熟悉的脚步声，孩子高兴地跑去开门。',
      'Tīngdào ménwài chuánlái shúxī de jiǎobù shēng, háizi gāoxìng de pǎo qù kāimén.',
      'Nghe thấy tiếng bước chân quen thuộc truyền lại ngoài cửa, đứa bé thích thú chạy ra mở cửa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听到门外传来熟悉的脚步声，孩子高兴地跑去开门。', 'Tīngdào ménwài chuánlái shúxī de jiǎobù shēng, háizi gāoxìng de pǎo qù kāimén.', 'Nghe thấy tiếng bước chân quen thuộc truyền lại ngoài cửa, đứa bé thích thú chạy ra mở cửa.', 'basic', 1),
      (v_id, '面对世界百年未有之大变局，我们必须紧跟时代发展的脉搏，决不能放慢自主创新与改革攻坚的脚步。', 'Miànduì shìjiè bǎi nián wèiyǒu zhī dà biànjú, wǒmen bìxū jǐngēn shídài fāzhǎn de màibó, jué bùnéng fàngmàn zìzhǔ chuàngxīn yǔ gǎigé gōngjiān de jiǎobù.', 'Đứng trước những biến đổi to lớn trăm năm chưa từng có của thế giới, chúng ta cần theo sát từng nhịp đập phát triển của thời đại, quyết không thể chậm lại bước chân đổi mới sáng tạo tự chủ và cải cách đột phá.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2592] [角度] (jiǎodù) - góc độ, góc nhìn, phương diện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '角度' AND pinyin = 'jiǎodù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '角度' AND pinyin = 'jiǎodù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '角度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '角度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiǎodù',
      meaning_vi = 'góc độ, góc nhìn, phương diện',
      example_hanzi = '遇到矛盾的时候，如果能换一个角度思考，问题往往会迎刃而解。',
      example_pinyin = 'Yùdào máodùn de shíhou, rúguǒ néng huàn yí gè jiǎodù sīkǎo, wèntí wǎngwǎng huì yíngrèn’érjiě.',
      example_vi = 'Khi gặp phải mâu thuẫn, nếu có thể đổi một góc độ khác để suy nghĩ thì vấn đề thường sẽ được giải quyết dễ dàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '角度',
      'jiǎodù',
      'góc độ, góc nhìn, phương diện',
      'Danh từ',
      'HSK 5',
      '遇到矛盾的时候，如果能换一个角度思考，问题往往会迎刃而解。',
      'Yùdào máodùn de shíhou, rúguǒ néng huàn yí gè jiǎodù sīkǎo, wèntí wǎngwǎng huì yíngrèn’érjiě.',
      'Khi gặp phải mâu thuẫn, nếu có thể đổi một góc độ khác để suy nghĩ thì vấn đề thường sẽ được giải quyết dễ dàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '遇到矛盾的时候，如果能换一个角度思考，问题往往会迎刃而解。', 'Yùdào máodùn de shíhou, rúguǒ néng huàn yí gè jiǎodù sīkǎo, wèntí wǎngwǎng huì yíngrèn’érjiě.', 'Khi gặp phải mâu thuẫn, nếu có thể đổi một góc độ khác để suy nghĩ thì vấn đề thường sẽ được giải quyết dễ dàng.', 'basic', 1),
      (v_id, '专家学者们从经济学、社会学以及生态法学等多学科交叉角度，深入剖析了绿色低碳转型中资源再分配的公平性问题。', 'Zhuānjiā xuézhěmen cóng jīngjìxué, shèhuìxué yǐjí shēngtài fǎxué děng duō xuékē jiāochā jiǎodù, shēnrù pōuxī le lǜsè dītàn zhuǎnxíng zhōng zīyuán zàifēnpèi de gōngpíngxìng wèntí.', 'Các chuyên gia và học giả từ góc nhìn giao thoa đa ngành như kinh tế học, xã hội học và luật học sinh thái đã mổ xẻ sâu sắc bài toán công bằng trong việc tái phân bổ nguồn lực trong tiến trình chuyển đổi xanh ít carbon.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2593] [较] (jiào) - khá, tương đối; so với (so sánh) [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '较' AND pinyin = 'jiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '较' AND pinyin = 'jiào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '较'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '较'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'jiào',
      meaning_vi = 'khá, tương đối; so với (so sánh)',
      example_hanzi = '今年春季当地的气温较往年同期明显偏高。',
      example_pinyin = 'Jīnnián chūnjì dāngdì de qìwēn jiào wǎngnián tóngqī míngxiǎn piāngāo.',
      example_vi = 'Nhiệt độ mùa xuân năm nay ở địa phương tương đối cao hơn rõ rệt so với cùng kỳ các năm trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '较',
      'jiào',
      'khá, tương đối; so với (so sánh)',
      'Phó từ',
      'HSK 5',
      '今年春季当地的气温较往年同期明显偏高。',
      'Jīnnián chūnjì dāngdì de qìwēn jiào wǎngnián tóngqī míngxiǎn piāngāo.',
      'Nhiệt độ mùa xuân năm nay ở địa phương tương đối cao hơn rõ rệt so với cùng kỳ các năm trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今年春季当地的气温较往年同期明显偏高。', 'Jīnnián chūnjì dāngdì de qìwēn jiào wǎngnián tóngqī míngxiǎn piāngāo.', 'Nhiệt độ mùa xuân năm nay ở địa phương tương đối cao hơn rõ rệt so với cùng kỳ các năm trước.', 'basic', 1),
      (v_id, '得益于精益生产管理与高度智能化的柔性流水线，该工厂的生产效率较传统车间提升了近百分之四十。', 'Déyì yú jīngyì shēngchǎn guǎnlǐ yǔ gāodù zhìnénghuà de róuxìng liúshuǐxiàn, gāi gōngchǎng de shēngchǎn xiàolǜ jiào chuántǒng chējiān tíshēng le jìn bǎifēnzhī sìshí.', 'Nhờ vào phương thức quản trị sản xuất tinh gọn và dây chuyền lắp ráp linh hoạt thông minh hóa cao độ, hiệu suất sản xuất của nhà máy này so với các phân xưởng truyền thống đã tăng lên gần 40%.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2594] [教材] (jiàocái) - giáo trình, tài liệu giảng dạy, sách giáo khoa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '教材' AND pinyin = 'jiàocái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '教材' AND pinyin = 'jiàocái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '教材'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '教材'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiàocái',
      meaning_vi = 'giáo trình, tài liệu giảng dạy, sách giáo khoa',
      example_hanzi = '新学期伊始，同学们都领到了印刷精美的新教材。',
      example_pinyin = 'Xīn xuéqī yīshǐ, tóngxuémen dōu lǐngdào le yìnshuā jīngměi de xīn jiàocái.',
      example_vi = 'Bắt đầu học kỳ mới, các bạn học sinh đều đã nhận được những cuốn sách giáo trình mới in ấn tinh mỹ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '教材',
      'jiàocái',
      'giáo trình, tài liệu giảng dạy, sách giáo khoa',
      'Danh từ',
      'HSK 5',
      '新学期伊始，同学们都领到了印刷精美的新教材。',
      'Xīn xuéqī yīshǐ, tóngxuémen dōu lǐngdào le yìnshuā jīngměi de xīn jiàocái.',
      'Bắt đầu học kỳ mới, các bạn học sinh đều đã nhận được những cuốn sách giáo trình mới in ấn tinh mỹ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新学期伊始，同学们都领到了印刷精美的新教材。', 'Xīn xuéqī yīshǐ, tóngxuémen dōu lǐngdào le yìnshuā jīngměi de xīn jiàocái.', 'Bắt đầu học kỳ mới, các bạn học sinh đều đã nhận được những cuốn sách giáo trình mới in ấn tinh mỹ.', 'basic', 1),
      (v_id, '教育部组织全国一流专家学者统一审定编写的高校思想政治理论课通用教材，体现了深厚的理论逻辑与鲜明的时代特征。', 'Jiàoyùbù zǔzhī quánguó yīliú zhuānjiā xuézhě tǒngyī shěndìng biānxiě de gāoxiào sīxiǎng zhèngzhì lǐlùnkè tōngyòng jiàocái, tǐxiàn le shēnhòu de lǐlùn luójí yǔ xiānmíng de shídài tèzhēng.', 'Bộ Giáo dục đã quy tụ các chuyên gia học giả hàng đầu cả nước thống nhất thẩm định biên soạn bộ giáo trình môn lý luận chính trị tư tưởng dùng chung cho các trường đại học, thể hiện tư duy lý luận sâu sắc cùng đặc trưng thời đại rõ nét.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2595] [接触] (jiēchù) - tiếp xúc, va chạm, tiếp cận, giao lưu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '接触' AND pinyin = 'jiēchù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '接触' AND pinyin = 'jiēchù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '接触'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '接触'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiēchù',
      meaning_vi = 'tiếp xúc, va chạm, tiếp cận, giao lưu',
      example_hanzi = '在日常人际交往中，他总是给人一种容易接触、平易近人的亲切感。',
      example_pinyin = 'Zài rìcháng rénjì jiāowǎng zhōng, tā zǒngshì gěi rén yì zhǒng róngyì jiēchù, píngyì-jìnrén de qīnqiègǎn.',
      example_vi = 'Trong giao tiếp hàng ngày giữa người với người, anh ấy luôn mang lại cho mọi người cảm giác dễ gần, dễ tiếp xúc và bình dị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '接触',
      'jiēchù',
      'tiếp xúc, va chạm, tiếp cận, giao lưu',
      'Động từ',
      'HSK 5',
      '在日常人际交往中，他总是给人一种容易接触、平易近人的亲切感。',
      'Zài rìcháng rénjì jiāowǎng zhōng, tā zǒngshì gěi rén yì zhǒng róngyì jiēchù, píngyì-jìnrén de qīnqiègǎn.',
      'Trong giao tiếp hàng ngày giữa người với người, anh ấy luôn mang lại cho mọi người cảm giác dễ gần, dễ tiếp xúc và bình dị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在日常人际交往中，他总是给人一种容易接触、平易近人的亲切感。', 'Zài rìcháng rénjì jiāowǎng zhōng, tā zǒngshì gěi rén yì zhǒng róngyì jiēchù, píngyì-jìnrén de qīnqiègǎn.', 'Trong giao tiếp hàng ngày giữa người với người, anh ấy luôn mang lại cho mọi người cảm giác dễ gần, dễ tiếp xúc và bình dị.', 'basic', 1),
      (v_id, '高校通过组织大学生深入偏远乡村与基层工厂开展社会实践，让他们更直接地接触真实的国情社情并强化责任担当。', 'Gāoxiào tōngguò zǔzhī dàxuésheng shēnrù piānyuǎn xiāngcūn yǔ jīcéng gōngchǎng kāizhǎn shèhuì shíjiàn, ràng tāmen gèng zhíjiē de jiēchù zhēnshí de guóqíng shèqíng bìng qiánghuà zérèn dāndāng.', 'Các trường đại học thông qua việc tổ chức cho sinh viên đi sâu về các làng quê hẻo lánh và nhà máy cơ sở để hoạt động thực tế xã hội, giúp các bạn tiếp xúc trực diện hơn với tình hình đất nước và xã hội thực tế, đồng thời tôi luyện tinh thần trách nhiệm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2596] [接待] (jiēdài) - tiếp đãi, đón tiếp, chiêu đãi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '接待' AND pinyin = 'jiēdài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '接待' AND pinyin = 'jiēdài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '接待'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '接待'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiēdài',
      meaning_vi = 'tiếp đãi, đón tiếp, chiêu đãi',
      example_hanzi = '前台工作人员礼貌热情地接待了前来咨询业务的每一位客户。',
      example_pinyin = 'Qiántái gōngzuò rényuán lǐmào rèqíng de jiēdài le qiánlái zīxún yèwù de měi yí wèi kèhù.',
      example_vi = 'Nhân viên lễ tân lịch thiệp và nhiệt tình đón tiếp từng khách hàng đến hỏi thông tin nghiệp vụ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '接待',
      'jiēdài',
      'tiếp đãi, đón tiếp, chiêu đãi',
      'Động từ',
      'HSK 5',
      '前台工作人员礼貌热情地接待了前来咨询业务的每一位客户。',
      'Qiántái gōngzuò rényuán lǐmào rèqíng de jiēdài le qiánlái zīxún yèwù de měi yí wèi kèhù.',
      'Nhân viên lễ tân lịch thiệp và nhiệt tình đón tiếp từng khách hàng đến hỏi thông tin nghiệp vụ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '前台工作人员礼貌热情地接待了前来咨询业务的每一位客户。', 'Qiántái gōngzuò rényuán lǐmào rèqíng de jiēdài le qiánlái zīxún yèwù de měi yí wèi kèhù.', 'Nhân viên lễ tân lịch thiệp và nhiệt tình đón tiếp từng khách hàng đến hỏi thông tin nghiệp vụ.', 'basic', 1),
      (v_id, '为保障跨国投资洽谈峰会的圆满举行，会务组精心制定了涵盖机场迎接、多语种翻译和外宾安保的高规格接待工作方案。', 'Wèi bǎozhàng kuàguó tóuzī qiàtán fēnghuì de yuánmǎn jǔxíng, huìwùzǔ jīngxīn zhìdìng le hángài jīchǎng yíngjiē, duō yǔzhǒng fānyì hé wàibīn ānbǎo de gāo guīgé jiēdài gōngzuò fāng’àn.', 'Nhằm đảm bảo hội nghị thượng đỉnh đàm phán đầu tư xuyên quốc gia diễn ra tốt đẹp, ban tổ chức hội nghị đã công phu xây dựng phương án đón tiếp chuẩn mực cao bao gồm đón rước tại sân bay, phiên dịch đa ngôn ngữ và bảo an cho khách quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2597] [阶段] (jiēduàn) - giai đoạn, thời kỳ, chặng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '阶段' AND pinyin = 'jiēduàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '阶段' AND pinyin = 'jiēduàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '阶段'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '阶段'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiēduàn',
      meaning_vi = 'giai đoạn, thời kỳ, chặng',
      example_hanzi = '这项大型科研攻关项目目前已经顺利进入了实质性的临床试验阶段。',
      example_pinyin = 'Zhè xiàng dàxíng kēyán gōngguān xiàngmù mùqián yǐjīng shùnlì jìnrù le shízhìxìng de línchuáng shìyàn jiēduàn.',
      example_vi = 'Dự án nghiên cứu khoa học quy mô lớn này hiện tại đã thuận lợi bước vào giai đoạn thử nghiệm lâm sàng thực chất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '阶段',
      'jiēduàn',
      'giai đoạn, thời kỳ, chặng',
      'Danh từ',
      'HSK 5',
      '这项大型科研攻关项目目前已经顺利进入了实质性的临床试验阶段。',
      'Zhè xiàng dàxíng kēyán gōngguān xiàngmù mùqián yǐjīng shùnlì jìnrù le shízhìxìng de línchuáng shìyàn jiēduàn.',
      'Dự án nghiên cứu khoa học quy mô lớn này hiện tại đã thuận lợi bước vào giai đoạn thử nghiệm lâm sàng thực chất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这项大型科研攻关项目目前已经顺利进入了实质性的临床试验阶段。', 'Zhè xiàng dàxíng kēyán gōngguān xiàngmù mùqián yǐjīng shùnlì jìnrù le shízhìxìng de línchuáng shìyàn jiēduàn.', 'Dự án nghiên cứu khoa học quy mô lớn này hiện tại đã thuận lợi bước vào giai đoạn thử nghiệm lâm sàng thực chất.', 'basic', 1),
      (v_id, '我国经济已由高速增长阶段转向高质量发展阶段，必须更加坚定不移地贯彻创新、协调、绿色、开放、共享的新发展理念。', 'Wǒ guó jīngjì yǐ yóu gāosù zēngzhǎng jiēduàn zhuǎnxiàng gāo zhìliàng fāzhǎn jiēduàn, bìxū gèngjiā jiāndìng-bùyí de guànchè chuàngxīn, xiétiáo, lǜsè, kāifàng, gòngxiǎng de xīn fāzhǎn lǐniàn.', 'Nền kinh tế nước ta đã chuyển từ giai đoạn tăng trưởng tốc độ cao sang giai đoạn phát triển chất lượng cao, cần phải kiên định quán triệt sâu sắc hơn nữa triết lý phát triển mới gồm đổi mới sáng tạo, hài hòa, xanh, cởi mở và chia sẻ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2598] [接近] (jiējìn) - tiếp cận, đến gần, xấp xỉ; gần gũi [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '接近' AND pinyin = 'jiējìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '接近' AND pinyin = 'jiējìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '接近'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '接近'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'jiējìn',
      meaning_vi = 'tiếp cận, đến gần, xấp xỉ; gần gũi',
      example_hanzi = '随着下班时间的渐渐接近，办公室里的气氛开始轻松起来。',
      example_pinyin = 'Suízhe xiàbān shíjiān de jiànjiàn jiējìn, bàngōngshì lǐ de qìfēn kāishǐ qīngsōng qǐlái.',
      example_vi = 'Cùng với thời điểm tan làm dần dần đến gần, bầu không khí trong văn phòng bắt đầu trở nên thoải mái hơn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '接近',
      'jiējìn',
      'tiếp cận, đến gần, xấp xỉ; gần gũi',
      'Động từ / Tính từ',
      'HSK 5',
      '随着下班时间的渐渐接近，办公室里的气氛开始轻松起来。',
      'Suízhe xiàbān shíjiān de jiànjiàn jiējìn, bàngōngshì lǐ de qìfēn kāishǐ qīngsōng qǐlái.',
      'Cùng với thời điểm tan làm dần dần đến gần, bầu không khí trong văn phòng bắt đầu trở nên thoải mái hơn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着下班时间的渐渐接近，办公室里的气氛开始轻松起来。', 'Suízhe xiàbān shíjiān de jiànjiàn jiējìn, bàngōngshì lǐ de qìfēn kāishǐ qīngsōng qǐlái.', 'Cùng với thời điểm tan làm dần dần đến gần, bầu không khí trong văn phòng bắt đầu trở nên thoải mái hơn.', 'basic', 1),
      (v_id, '最新统计报告表明，我国清洁能源消费占能源消费总量的比重已接近百分之三十，能源结构绿色转型成效显著。', 'Zuìxīn tǒngjì bàogào biǎomíng, wǒ guó qīngjié néngyuán xiāofèi zhàn néngyuán xiāofèi zǒngliàng de bǐzhòng yǐ jiējìn bǎifēnzhī sānshí, néngyuán jiégòu lǜsè zhuǎnxíng chéngxiào xiǎnzhù.', 'Báo cáo thống kê mới nhất chỉ ra rằng, tỷ trọng tiêu thụ năng lượng sạch trong tổng lượng tiêu thụ năng lượng của nước ta đã xấp xỉ 30%, hiệu quả chuyển dịch xanh trong cơ cấu năng lượng đạt kết quả rõ rệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2599] [接收] (jiēshōu) - tiếp nhận, nhận, thu nhận (tín hiệu, người, tài sản) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '接收' AND pinyin = 'jiēshōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '接收' AND pinyin = 'jiēshōu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '接收'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '接收'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'jiēshōu',
      meaning_vi = 'tiếp nhận, nhận, thu nhận (tín hiệu, người, tài sản)',
      example_hanzi = '由于山区信号较差，手机在这个深山峡谷里暂时无法接收到网络信号。',
      example_pinyin = 'Yóuyú shānqū xìnhào jiào chà, shǒujī zài zhè gè shēnshān xiágǔ lǐ zànshí wúfǎ jiēshōu dào wǎngluò xìnhào.',
      example_vi = 'Do tín hiệu vùng đồi núi khá kém, điện thoại di động tạm thời không thể nhận được sóng mạng trong hẻm núi sâu này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '接收',
      'jiēshōu',
      'tiếp nhận, nhận, thu nhận (tín hiệu, người, tài sản)',
      'Động từ',
      'HSK 5',
      '由于山区信号较差，手机在这个深山峡谷里暂时无法接收到网络信号。',
      'Yóuyú shānqū xìnhào jiào chà, shǒujī zài zhè gè shēnshān xiágǔ lǐ zànshí wúfǎ jiēshōu dào wǎngluò xìnhào.',
      'Do tín hiệu vùng đồi núi khá kém, điện thoại di động tạm thời không thể nhận được sóng mạng trong hẻm núi sâu này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '由于山区信号较差，手机在这个深山峡谷里暂时无法接收到网络信号。', 'Yóuyú shānqū xìnhào jiào chà, shǒujī zài zhè gè shēnshān xiágǔ lǐ zànshí wúfǎ jiēshōu dào wǎngluò xìnhào.', 'Do tín hiệu vùng đồi núi khá kém, điện thoại di động tạm thời không thể nhận được sóng mạng trong hẻm núi sâu này.', 'basic', 1),
      (v_id, '地面卫星测控站依靠大型高增益相控阵天线，能够全天候稳定接收深空探测器从数亿公里外传回的高清科学遥测数据。', 'Dìmiàn wèixīng cèkòngzhàn yīkào dàxíng gāo zēngyì xiāngkòngzhèn tiānxiàn, nénggòu quántiānhòu wěndìng jiēshōu shēnkōng tàncèqì cóng shù yì gōnglǐ wài chuánhuí de gāoqīng kēxué yáocè shùjù.', 'Trạm điều khiển đo lường vệ tinh mặt đất dựa vào ăng-ten mảng pha độ lợi cao quy mô lớn, có thể tiếp nhận ổn định suốt ngày đêm các dữ liệu đo xa khoa học độ nét cao truyền về từ tàu thăm dò không gian sâu cách xa hàng trăm triệu kilomet.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2600] [结] (jié) - thắt, buộc, kết (nút, tình bạn, quả); nút thắt, mối thắt [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '结' AND pinyin = 'jié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '结' AND pinyin = 'jié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '结'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '结'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'jié',
      meaning_vi = 'thắt, buộc, kết (nút, tình bạn, quả); nút thắt, mối thắt',
      example_hanzi = '小女孩的手很灵巧，用一条红丝带打了一个非常漂亮的蝴蝶结。',
      example_pinyin = 'Xiǎo nǚhái de shǒu hěn língqiǎo, yòng yì tiáo hóng sīdài dǎ le yí gè fēicháng piàoliang de húdiéjié.',
      example_vi = 'Đôi tay của cô bé rất khéo léo, đã dùng một sợi ruy băng đỏ thắt thành một chiếc nơ con bướm vô cùng xinh xắn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '结',
      'jié',
      'thắt, buộc, kết (nút, tình bạn, quả); nút thắt, mối thắt',
      'Động từ / Danh từ',
      'HSK 5',
      '小女孩的手很灵巧，用一条红丝带打了一个非常漂亮的蝴蝶结。',
      'Xiǎo nǚhái de shǒu hěn língqiǎo, yòng yì tiáo hóng sīdài dǎ le yí gè fēicháng piàoliang de húdiéjié.',
      'Đôi tay của cô bé rất khéo léo, đã dùng một sợi ruy băng đỏ thắt thành một chiếc nơ con bướm vô cùng xinh xắn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小女孩的手很灵巧，用一条红丝带打了一个非常漂亮的蝴蝶结。', 'Xiǎo nǚhái de shǒu hěn língqiǎo, yòng yì tiáo hóng sīdài dǎ le yí gè fēicháng piàoliang de húdiéjié.', 'Đôi tay của cô bé rất khéo léo, đã dùng một sợi ruy băng đỏ thắt thành một chiếc nơ con bướm vô cùng xinh xắn.', 'basic', 1),
      (v_id, '面对复杂的历史遗留纷争，唯有秉持求同存异、务实对话的政治智慧，才能真正解开困扰各方的死结并实现持久和平。', 'Miànduì fùzá de lìshǐ yíliú fēnzhēng, wéiyǒu bǐngchí qiútóng-cúnyì, wùshí duìhuà de zhèngzhì zhìhuì, cáinéng zhēnzhèng jiěkāi kùnrǎo gèfāng de sǐjié bìng shíxiàn chíchǐ hépíng.', 'Đối mặt với những tranh chấp phức tạp do lịch sử để lại, chỉ có giữ vững trí tuệ chính trị cầu đồng tồn dị và đối thoại thực chất mới có thể thực sự tháo gỡ nút thắt khó gỡ đang vướng bận các bên và hiện thực hóa nền hòa bình lâu dài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2601] [结构] (jiégòu) - kết cấu, cấu trúc, cơ cấu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '结构' AND pinyin = 'jiégòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '结构' AND pinyin = 'jiégòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '结构'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '结构'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'jiégòu',
      meaning_vi = 'kết cấu, cấu trúc, cơ cấu',
      example_hanzi = '这篇文章层次分明，逻辑十分严密，整体结构非常清晰。',
      example_pinyin = 'Zhè piān wénzhāng céngcì fēnmíng, luójí shífēn yánmì, zhěngtǐ jiégòu fēicháng qīngxī.',
      example_vi = 'Bài viết này các tầng lang mạch lạc, tư duy logic vô cùng chặt chẽ, cấu trúc tổng thể hết sức rõ ràng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '结构',
      'jiégòu',
      'kết cấu, cấu trúc, cơ cấu',
      'Danh từ',
      'HSK 5',
      '这篇文章层次分明，逻辑十分严密，整体结构非常清晰。',
      'Zhè piān wénzhāng céngcì fēnmíng, luójí shífēn yánmì, zhěngtǐ jiégòu fēicháng qīngxī.',
      'Bài viết này các tầng lang mạch lạc, tư duy logic vô cùng chặt chẽ, cấu trúc tổng thể hết sức rõ ràng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这篇文章层次分明，逻辑十分严密，整体结构非常清晰。', 'Zhè piān wénzhāng céngcì fēnmíng, luójí shífēn yánmì, zhěngtǐ jiégòu fēicháng qīngxī.', 'Bài viết này các tầng lang mạch lạc, tư duy logic vô cùng chặt chẽ, cấu trúc tổng thể hết sức rõ ràng.', 'basic', 1),
      (v_id, '为推动经济实现质的有效提升和量的合理增长，国家必须持续优化升级产业结构、能源结构与区域经济布局。', 'Wèi tuīdòng jīngjì shíxiàn zhì de yǒuxiào tíshēng hé liàng de hélǐ zēngzhǎng, guójiā bìxū chíxù yōuhuà shēngjí chǎnyè jiégòu, néngyuán jiégòu yǔ qūyù jīngjì bùjú.', 'Nhằm thúc đẩy nền kinh tế nâng cao hiệu quả về chất và tăng trưởng hợp lý về lượng, quốc gia cần liên tục tối ưu hóa và nâng cấp cơ cấu ngành nghề, cơ cấu năng lượng và phân bố không gian kinh tế vùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp Batch 6 HSK 5: % từ vựng đã được chuẩn hóa và thêm 200 câu ví dụ.', v_count;
END $$;
