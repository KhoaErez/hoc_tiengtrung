-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 5 (100 TỪ TIẾP THEO)
-- Phạm vi: #2402 [各自] (gèzì) -> #2501 [化学] (huàxué)
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
  -- [2402] [各自] (gèzì) - mỗi người, mỗi bên, ai nấy, riêng phần mình [Đại từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '各自' AND pinyin = 'gèzì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '各自' AND pinyin = 'gèzì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '各自'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '各自'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ',
      pinyin = 'gèzì',
      meaning_vi = 'mỗi người, mỗi bên, ai nấy, riêng phần mình',
      example_hanzi = '散会之后，大家各自回到工作岗位上继续处理手头紧急的业务。',
      example_pinyin = 'Sànhuì zhīhòu, dàjiā gèzì huídào gōngzuò gǎngwèi shang jìxù chǔlǐ shǒutóu jǐnjí de yèwù.',
      example_vi = 'Sau khi tan họp, mọi người ai nấy đều trở về vị trí làm việc của mình để tiếp tục xử lý các nghiệp vụ khẩn cấp trong tay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '各自',
      'gèzì',
      'mỗi người, mỗi bên, ai nấy, riêng phần mình',
      'Đại từ',
      'HSK 5',
      '散会之后，大家各自回到工作岗位上继续处理手头紧急的业务。',
      'Sànhuì zhīhòu, dàjiā gèzì huídào gōngzuò gǎngwèi shang jìxù chǔlǐ shǒutóu jǐnjí de yèwù.',
      'Sau khi tan họp, mọi người ai nấy đều trở về vị trí làm việc của mình để tiếp tục xử lý các nghiệp vụ khẩn cấp trong tay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '散会之后，大家各自回到工作岗位上继续处理手头紧急的业务。', 'Sànhuì zhīhòu, dàjiā gèzì huídào gōngzuò gǎngwèi shang jìxù chǔlǐ shǒutóu jǐnjí de yèwù.', 'Sau khi tan họp, mọi người ai nấy đều trở về vị trí làm việc của mình để tiếp tục xử lý các nghiệp vụ khẩn cấp trong tay.', 'basic', 1),
      (v_id, '在跨国技术联合研发项目中，双方科学家团队充分发挥各自在软件算法与硬件架构领域的独特优势，实现了深度协同创新。', 'Zài kuàguó jìshù liánhé yánfā xiàngmù zhōng, shuāngfāng kēxuéjiā tuánduì chōngfèn fāhuī gèzì zài ruǎnjiàn suànfǎ yǔ yìngjiàn jiàgòu lǐngyù de dútè yōushì, shíxiàn le shēndù xiétóng chuàngxīn.', 'Trong dự án hợp tác nghiên cứu phát triển công nghệ xuyên quốc gia, đội ngũ các nhà khoa học của hai bên đã phát huy trọn vẹn thế mạnh độc đáo của mỗi bên trong lĩnh vực thuật toán phần mềm và kiến trúc phần cứng, hiện thực hóa sự đổi mới hiệp đồng sâu sắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2403] [根] (gēn) - rễ cây, cội nguồn; chiếc, sợi, cây (lượng từ) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '根' AND pinyin = 'gēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '根' AND pinyin = 'gēn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '根'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '根'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'gēn',
      meaning_vi = 'rễ cây, cội nguồn; chiếc, sợi, cây (lượng từ)',
      example_hanzi = '老树的根深深扎进泥土里，任凭狂风暴雨也依然屹立不倒。',
      example_pinyin = 'Lǎoshù de gēn shēnshēn zhājìn nítǔ lǐ, rènpíng kuángfēng-bàoyǔ yě yīrán yìlì-bùdǎo.',
      example_vi = 'Rễ của cây cổ thụ cắm sâu vào lòng đất, mặc cho mưa to gió lớn vẫn đứng sừng sững không hề ngã đổ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '根',
      'gēn',
      'rễ cây, cội nguồn; chiếc, sợi, cây (lượng từ)',
      'Danh từ / Lượng từ',
      'HSK 5',
      '老树的根深深扎进泥土里，任凭狂风暴雨也依然屹立不倒。',
      'Lǎoshù de gēn shēnshēn zhājìn nítǔ lǐ, rènpíng kuángfēng-bàoyǔ yě yīrán yìlì-bùdǎo.',
      'Rễ của cây cổ thụ cắm sâu vào lòng đất, mặc cho mưa to gió lớn vẫn đứng sừng sững không hề ngã đổ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老树的根深深扎进泥土里，任凭狂风暴雨也依然屹立不倒。', 'Lǎoshù de gēn shēnshēn zhājìn nítǔ lǐ, rènpíng kuángfēng-bàoyǔ yě yīrán yìlì-bùdǎo.', 'Rễ của cây cổ thụ cắm sâu vào lòng đất, mặc cho mưa to gió lớn vẫn đứng sừng sững không hề ngã đổ.', 'basic', 1),
      (v_id, '中华传统文化是海内外华夏儿女共同的精神之根，无论身在何方，深厚的家国情怀始终将大家紧紧凝聚在一起。', 'Zhōnghuá chuántǒng wénhuà shì hǎinèiwài Huáxià érnǚ gòngtóng de jīngshén zhī gēn, wúlùn shēn zài héfāng, shēnhòu de jiāguó qínghuái shǐzhōng jiāng dàjiā jǐnjǐn níngjù zài yìqǐ.', 'Văn hóa truyền thống Trung Hoa là cội rễ tinh thần chung của những người con đất Việt - Hoa trong và ngoài nước, dẫu ở bất cứ phương trời nào, tình cảm gia đình tổ quốc sâu đậm vẫn luôn gắn kết mọi người bền chặt bên nhau.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2404] [根本] (gēnběn) - căn bản, gốc rễ; hoàn toàn (không) [Danh từ / Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '根本' AND pinyin = 'gēnběn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '根本' AND pinyin = 'gēnběn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '根本'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '根本'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ / Phó từ',
      pinyin = 'gēnběn',
      meaning_vi = 'căn bản, gốc rễ; hoàn toàn (không)',
      example_hanzi = '他平时工作非常马虎，根本没有把领导提出的整改意见放在心上。',
      example_pinyin = 'Tā píngshí gōngzuò fēicháng mǎhu, gēnběn méiyǒu bǎ lǐngdǎo tíchū de zhěnggǎi yìjiàn fàng zài xīn shang.',
      example_vi = 'Ngày thường anh ấy làm việc rất cẩu thả, hoàn toàn không để tâm đến những ý kiến chấn chỉnh mà cấp trên đã đưa ra.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '根本',
      'gēnběn',
      'căn bản, gốc rễ; hoàn toàn (không)',
      'Danh từ / Tính từ / Phó từ',
      'HSK 5',
      '他平时工作非常马虎，根本没有把领导提出的整改意见放在心上。',
      'Tā píngshí gōngzuò fēicháng mǎhu, gēnběn méiyǒu bǎ lǐngdǎo tíchū de zhěnggǎi yìjiàn fàng zài xīn shang.',
      'Ngày thường anh ấy làm việc rất cẩu thả, hoàn toàn không để tâm đến những ý kiến chấn chỉnh mà cấp trên đã đưa ra.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他平时工作非常马虎，根本没有把领导提出的整改意见放在心上。', 'Tā píngshí gōngzuò fēicháng mǎhu, gēnběn méiyǒu bǎ lǐngdǎo tíchū de zhěnggǎi yìjiàn fàng zài xīn shang.', 'Ngày thường anh ấy làm việc rất cẩu thả, hoàn toàn không để tâm đến những ý kiến chấn chỉnh mà cấp trên đã đưa ra.', 'basic', 1),
      (v_id, '要从根本上化解水资源匮乏与生态环境脆弱的长期矛盾，必须坚持节水优先战略并大力发展循环经济模式。', 'Yào cóng gēnběn shang huàjiě shuǐzīyuán kuìfá yǔ shēngtài huánjìng cuìruò de chángqī máodùn, bìxū jiānchí jiéshuǐ yōuxiān zhànlüè bìng dàlì fāzhǎn xúnhuán jīngjì móshì.', 'Muốn hóa giải từ gốc rễ mâu thuẫn lâu dài giữa việc khan hiếm tài nguyên nước và môi trường sinh thái mỏng manh, bắt buộc phải kiên trì chiến lược ưu tiên tiết kiệm nước và phát triển mạnh mẽ mô hình kinh tế tuần hoàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2405] [更换] (gēnghuàn) - thay đổi, thay thế, đổi mới [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '更换' AND pinyin = 'gēnghuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '更换' AND pinyin = 'gēnghuàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '更换'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '更换'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gēnghuàn',
      meaning_vi = 'thay đổi, thay thế, đổi mới',
      example_hanzi = '为了保证行车安全，车主应该按照保养手册定期更换机油和磨损严重的轮胎。',
      example_pinyin = 'Wèile bǎozhèng xíngchē ānquán, chēzhǔ yīnggāi ànzhào bǎoyǎng shǒucè dìngqī gēnghuàn jīyóu hé mósǔn yánzhòng de lúntāi.',
      example_vi = 'Để đảm bảo an toàn khi lái xe, chủ xe nên định kỳ thay dầu máy và lốp xe bị mòn nghiêm trọng theo đúng sổ tay bảo dưỡng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '更换',
      'gēnghuàn',
      'thay đổi, thay thế, đổi mới',
      'Động từ',
      'HSK 5',
      '为了保证行车安全，车主应该按照保养手册定期更换机油和磨损严重的轮胎。',
      'Wèile bǎozhèng xíngchē ānquán, chēzhǔ yīnggāi ànzhào bǎoyǎng shǒucè dìngqī gēnghuàn jīyóu hé mósǔn yánzhòng de lúntāi.',
      'Để đảm bảo an toàn khi lái xe, chủ xe nên định kỳ thay dầu máy và lốp xe bị mòn nghiêm trọng theo đúng sổ tay bảo dưỡng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了保证行车安全，车主应该按照保养手册定期更换机油和磨损严重的轮胎。', 'Wèile bǎozhèng xíngchē ānquán, chēzhǔ yīnggāi ànzhào bǎoyǎng shǒucè dìngqī gēnghuàn jīyóu hé mósǔn yánzhòng de lúntāi.', 'Để đảm bảo an toàn khi lái xe, chủ xe nên định kỳ thay dầu máy và lốp xe bị mòn nghiêm trọng theo đúng sổ tay bảo dưỡng.', 'basic', 1),
      (v_id, '供电局在深夜负荷低谷期间组织施工人员对该老旧小区的地下老旧高压电缆与智能化变压器进行了全套更换。', 'Gōngdiànjú zài shēnyè fùhè dīgǔ qījiān zǔzhī shīgōng rényuán duì gāi lǎojiù xiǎoqū de dìxià lǎojiù gāoyā diànlǎn yǔ zhìnénghuà biànyāqì jìnxíng le quántào gēnghuàn.', 'Cục cấp điện đã tổ chức công nhân thi công vào thời điểm phụ tải thấp nhất lúc nửa đêm để tiến hành thay thế toàn bộ tuyến cáp điện ngầm cao áp cũ kỹ và máy biến áp thông minh hóa cho khu tập thể cũ này.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2406] [更新] (gēngxīn) - cập nhật, làm mới, đổi mới [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '更新' AND pinyin = 'gēngxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '更新' AND pinyin = 'gēngxīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '更新'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '更新'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'gēngxīn',
      meaning_vi = 'cập nhật, làm mới, đổi mới',
      example_hanzi = '手机系统提示有新版本发布，建议连接无线网络后立即下载更新。',
      example_pinyin = 'Shǒujī xìtǒng tíshì yǒu xīn bǎnběn fābù, jiànyì liánjiē wúxiàn wǎngluò hòu lìjí xiàzǎi gēngxīn.',
      example_vi = 'Hệ điều hành điện thoại nhắc nhở có phiên bản mới phát hành, kiến nghị kết nối mạng không dây rồi tải về cập nhật ngay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '更新',
      'gēngxīn',
      'cập nhật, làm mới, đổi mới',
      'Động từ / Danh từ',
      'HSK 5',
      '手机系统提示有新版本发布，建议连接无线网络后立即下载更新。',
      'Shǒujī xìtǒng tíshì yǒu xīn bǎnběn fābù, jiànyì liánjiē wúxiàn wǎngluò hòu lìjí xiàzǎi gēngxīn.',
      'Hệ điều hành điện thoại nhắc nhở có phiên bản mới phát hành, kiến nghị kết nối mạng không dây rồi tải về cập nhật ngay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '手机系统提示有新版本发布，建议连接无线网络后立即下载更新。', 'Shǒujī xìtǒng tíshì yǒu xīn bǎnběn fābù, jiànyì liánjiē wúxiàn wǎngluò hòu lìjí xiàzǎi gēngxīn.', 'Hệ điều hành điện thoại nhắc nhở có phiên bản mới phát hành, kiến nghị kết nối mạng không dây rồi tải về cập nhật ngay.', 'basic', 1),
      (v_id, '制造企业通过加快生产设备数字化转型与工艺技术迭代更新，显著提高了核心产品的技术壁垒与国际市场综合竞争力。', 'Zhìzào qǐyè tōngguò jiākuài shēngchǎn shèbèi shùzìhuà zhuǎnxíng yǔ gōngyì jìshù diédài gēngxīn, xiǎnzhù tígāo le héxīn chǎnpǐn de jìshù bìlěi yǔ guójì shìchǎng zōnghé jìngzhēnglì.', 'Doanh nghiệp sản xuất thông qua việc đẩy nhanh chuyển đổi số thiết bị sản xuất và đổi mới nâng cấp lặp lại công nghệ kỹ thuật, đã nâng cao rõ rệt rào cản kỹ thuật của các sản phẩm cốt lõi cùng sức cạnh tranh tổng hợp trên thị trường quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2407] [公布] (gōngbù) - công bố, ban bố [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '公布' AND pinyin = 'gōngbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '公布' AND pinyin = 'gōngbù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '公布'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '公布'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gōngbù',
      meaning_vi = 'công bố, ban bố',
      example_hanzi = '考试成绩预计将于明天上午十点准时在教育局官方网站上正式公布。',
      example_pinyin = 'Kǎoshì chéngjì yùjì jiāng yú míngtiān shàngwǔ shí diǎn zhǔnshí zài jiàoyùjú guānfāng wǎngzhàn shang zhèngshì gōngbù.',
      example_vi = 'Điểm thi dự kiến sẽ được công bố chính thức vào lúc mười giờ sáng mai trên trang web chính thức của sở giáo dục.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '公布',
      'gōngbù',
      'công bố, ban bố',
      'Động từ',
      'HSK 5',
      '考试成绩预计将于明天上午十点准时在教育局官方网站上正式公布。',
      'Kǎoshì chéngjì yùjì jiāng yú míngtiān shàngwǔ shí diǎn zhǔnshí zài jiàoyùjú guānfāng wǎngzhàn shang zhèngshì gōngbù.',
      'Điểm thi dự kiến sẽ được công bố chính thức vào lúc mười giờ sáng mai trên trang web chính thức của sở giáo dục.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '考试成绩预计将于明天上午十点准时在教育局官方网站上正式公布。', 'Kǎoshì chéngjì yùjì jiāng yú míngtiān shàngwǔ shí diǎn zhǔnshí zài jiàoyùjú guānfāng wǎngzhàn shang zhèngshì gōngbù.', 'Điểm thi dự kiến sẽ được công bố chính thức vào lúc mười giờ sáng mai trên trang web chính thức của sở giáo dục.', 'basic', 1),
      (v_id, '国家统计局依法公布了最新季度宏观经济核心运行指标，多项稳健回升的积极数据提振了海内外投资者对高质量发展的信心。', 'Guójiā tǒngjìjú yīfǎ gōngbù le zuìxīn jīdù hóngguān jīngjì héxīn yùnxíng zhǐbiāo, duō xiàng wěnjiàn huíshēng de jījí shùjù tízhèn le hǎinèiwài tóuzīzhě duì gāo zhìliàng fāzhǎn de xìnxīn.', 'Tổng cục Thống kê quốc gia đã công bố theo luật định các chỉ tiêu vận hành cốt lõi của nền kinh tế vĩ mô quý gần nhất, nhiều số liệu tích cực phục hồi vững chắc đã củng cố niềm tin của các nhà đầu tư trong và ngoài nước vào sự phát triển chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2408] [工程] (gōngchéng) - công trình, dự án kỹ thuật [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '工程' AND pinyin = 'gōngchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工程' AND pinyin = 'gōngchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '工程'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工程'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gōngchéng',
      meaning_vi = 'công trình, dự án kỹ thuật',
      example_hanzi = '这项大型跨海大桥建造工程历经五年艰苦施工，终于顺利实现全线合龙。',
      example_pinyin = 'Zhè xiàng dàxíng kuàhǎi dàqiáo jiànzào gōngchéng lìjīng wǔ nián jiānkǔ shīgōng, zhōngyú shùnlì shíxiàn quánxiàn hélóng.',
      example_vi = 'Công trình xây dựng cây cầu vượt biển quy mô lớn này đã trải qua năm năm thi công gian khổ, cuối cùng đã hợp long toàn tuyến thuận lợi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '工程',
      'gōngchéng',
      'công trình, dự án kỹ thuật',
      'Danh từ',
      'HSK 5',
      '这项大型跨海大桥建造工程历经五年艰苦施工，终于顺利实现全线合龙。',
      'Zhè xiàng dàxíng kuàhǎi dàqiáo jiànzào gōngchéng lìjīng wǔ nián jiānkǔ shīgōng, zhōngyú shùnlì shíxiàn quánxiàn hélóng.',
      'Công trình xây dựng cây cầu vượt biển quy mô lớn này đã trải qua năm năm thi công gian khổ, cuối cùng đã hợp long toàn tuyến thuận lợi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这项大型跨海大桥建造工程历经五年艰苦施工，终于顺利实现全线合龙。', 'Zhè xiàng dàxíng kuàhǎi dàqiáo jiànzào gōngchéng lìjīng wǔ nián jiānkǔ shīgōng, zhōngyú shùnlì shíxiàn quánxiàn hélóng.', 'Công trình xây dựng cây cầu vượt biển quy mô lớn này đã trải qua năm năm thi công gian khổ, cuối cùng đã hợp long toàn tuyến thuận lợi.', 'basic', 1),
      (v_id, '南水北调中线工程作为国家水网骨干工程，有效缓解了沿线数十座特大城市的生产生活用水紧缺局面，产生了巨大的社会经济效益。', 'Nánshuǐ Běidiào zhōngxiàn gōngchéng zuòwéi guójiā shuǐwǎng gǔgàn gōngchéng, yǒuxiào huǎnjiě le yánxiàn shù shí zuò tèdà chéngshì de shēngchǎn shēnghuó yòngshuǐ jǐnquē júmiàn, chǎnshēng le jùdà de shèhuì jīngjì xiàoyì.', 'Dự án chuyển nước từ Nam lên Bắc tuyến miền Trung với vai trò là công trình rường cột của mạng lưới cấp nước quốc gia, đã giảm bớt hiệu quả tình trạng khan hiếm nước sinh hoạt và sản xuất của hàng chục siêu đô thị dọc tuyến, tạo ra hiệu quả kinh tế xã hội to lớn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2409] [工程师] (gōngchéngshī) - kỹ sư [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '工程师' AND pinyin = 'gōngchéngshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工程师' AND pinyin = 'gōngchéngshī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '工程师'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工程师'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gōngchéngshī',
      meaning_vi = 'kỹ sư',
      example_hanzi = '他在一家知名的自动化机械制造公司担任高级软件工程师。',
      example_pinyin = 'Tā zài yì jiā zhīmíng de zìdònghuà jīxiè zhìzào gōngsī dānrèn gāojí ruǎnjiàn gōngchéngshī.',
      example_vi = 'Anh ấy đảm nhiệm vị trí kỹ sư phần mềm cao cấp tại một công ty chế tạo cơ khí tự động hóa nổi tiếng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '工程师',
      'gōngchéngshī',
      'kỹ sư',
      'Danh từ',
      'HSK 5',
      '他在一家知名的自动化机械制造公司担任高级软件工程师。',
      'Tā zài yì jiā zhīmíng de zìdònghuà jīxiè zhìzào gōngsī dānrèn gāojí ruǎnjiàn gōngchéngshī.',
      'Anh ấy đảm nhiệm vị trí kỹ sư phần mềm cao cấp tại một công ty chế tạo cơ khí tự động hóa nổi tiếng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在一家知名的自动化机械制造公司担任高级软件工程师。', 'Tā zài yì jiā zhīmíng de zìdònghuà jīxiè zhìzào gōngsī dānrèn gāojí ruǎnjiàn gōngchéngshī.', 'Anh ấy đảm nhiệm vị trí kỹ sư phần mềm cao cấp tại một công ty chế tạo cơ khí tự động hóa nổi tiếng.', 'basic', 1),
      (v_id, '航天系统总工程师带领由数百名青年骨干组成的研发攻关团队，攻克了深空探测器在极端宇宙环境下长周期自主导航定位的技术难关。', 'Hángtiān xìtǒng zǒng gōngchéngshī dàilǐng yóu shù bǎi míng qīngnián gǔgàn zǔchéng de yánfā gōngguān tuánduì, gōngkè le shēnkōng tàncèqì zài jíduān yǔzhòu huánjìng xià cháng zhōuqī zìzhǔ dǎoháng dìngwèi de jìshù nánguān.', 'Tổng công trình sư hệ thống hàng không vũ trụ đã dẫn dắt đội ngũ nghiên cứu đột phá gồm hàng trăm cán bộ nòng cốt trẻ tuổi, chinh phục cửa ải kỹ thuật khó khăn về định vị dẫn đường tự chủ chu kỳ dài của tàu thăm dò không gian sâu dưới môi trường vũ trụ khắc nghiệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2410] [工具] (gōngjù) - công cụ, phương tiện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '工具' AND pinyin = 'gōngjù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工具' AND pinyin = 'gōngjù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '工具'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工具'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gōngjù',
      meaning_vi = 'công cụ, phương tiện',
      example_hanzi = '修理自行车时必须准备好扳手、螺丝刀和打气筒等常用维修工具。',
      example_pinyin = 'Xiūlǐ zìxíngchē shí bìxū zhǔnbèi hǎo bānshǒu, luósīdāo hé dǎqìtǒng děng chángyòng wéixiū gōngjù.',
      example_vi = 'Khi sửa chữa xe đạp nhất định phải chuẩn bị sẵn các công cụ sửa chữa thông dụng như cờ lê, tua vít và ống bơm hơi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '工具',
      'gōngjù',
      'công cụ, phương tiện',
      'Danh từ',
      'HSK 5',
      '修理自行车时必须准备好扳手、螺丝刀和打气筒等常用维修工具。',
      'Xiūlǐ zìxíngchē shí bìxū zhǔnbèi hǎo bānshǒu, luósīdāo hé dǎqìtǒng děng chángyòng wéixiū gōngjù.',
      'Khi sửa chữa xe đạp nhất định phải chuẩn bị sẵn các công cụ sửa chữa thông dụng như cờ lê, tua vít và ống bơm hơi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '修理自行车时必须准备好扳手、螺丝刀和打气筒等常用维修工具。', 'Xiūlǐ zìxíngchē shí bìxū zhǔnbèi hǎo bānshǒu, luósīdāo hé dǎqìtǒng děng chángyòng wéixiū gōngjù.', 'Khi sửa chữa xe đạp nhất định phải chuẩn bị sẵn các công cụ sửa chữa thông dụng như cờ lê, tua vít và ống bơm hơi.', 'basic', 1),
      (v_id, '在以大语言模型为驱动的数字时代，人工智能编程助手已经成为现代软件开发人员提高代码编写与单元测试效率不可或缺的高效生产力工具。', 'Zài yǐ dà yǔyán móxíng wéi qūdòng de shùzì shídài, réngōng zhìnéng biānchéng zhùshǒu yǐjīng chéngwéi xiàndài ruǎnjiàn kāifā rényuán tígāo dàimǎ biānxiě yǔ dānyuán cèshì xiàolǜ bùkě huòquē de gāoxiào shēngchǎnlì gōngjù.', 'Trong kỷ nguyên số được thúc đẩy bởi mô hình ngôn ngữ lớn, trợ lý lập trình trí tuệ nhân tạo đã trở thành công cụ năng suất hiệu quả cao không thể thiếu giúp các lập trình viên phần mềm hiện đại nâng cao hiệu suất viết code và kiểm thử đơn vị.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2411] [功能] (gōngnéng) - chức năng, tính năng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '功能' AND pinyin = 'gōngnéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '功能' AND pinyin = 'gōngnéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '功能'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '功能'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gōngnéng',
      meaning_vi = 'chức năng, tính năng',
      example_hanzi = '这款新款智能手环不仅具备心率监测功能，还能实时记录用户的日常运动轨迹。',
      example_pinyin = 'Zhè kuǎn xīnkuǎn zhìnéng shǒuhuán bùjǐn jùbèi xīnlǜ jiāncè gōngnéng, hái néng shíshí jìlù yònghù de rìcháng yùndòng guǐjì.',
      example_vi = 'Chiếc vòng tay thông minh mẫu mới này không chỉ có chức năng theo dõi nhịp tim, mà còn có thể ghi lại quỹ đạo vận động thường ngày của người dùng theo thời gian thực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '功能',
      'gōngnéng',
      'chức năng, tính năng',
      'Danh từ',
      'HSK 5',
      '这款新款智能手环不仅具备心率监测功能，还能实时记录用户的日常运动轨迹。',
      'Zhè kuǎn xīnkuǎn zhìnéng shǒuhuán bùjǐn jùbèi xīnlǜ jiāncè gōngnéng, hái néng shíshí jìlù yònghù de rìcháng yùndòng guǐjì.',
      'Chiếc vòng tay thông minh mẫu mới này không chỉ có chức năng theo dõi nhịp tim, mà còn có thể ghi lại quỹ đạo vận động thường ngày của người dùng theo thời gian thực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这款新款智能手环不仅具备心率监测功能，还能实时记录用户的日常运动轨迹。', 'Zhè kuǎn xīnkuǎn zhìnéng shǒuhuán bùjǐn jùbèi xīnlǜ jiāncè gōngnéng, hái néng shíshí jìlù yònghù de rìcháng yùndòng guǐjì.', 'Chiếc vòng tay thông minh mẫu mới này không chỉ có chức năng theo dõi nhịp tim, mà còn có thể ghi lại quỹ đạo vận động thường ngày của người dùng theo thời gian thực.', 'basic', 1),
      (v_id, '城市湿地生态保护公园兼具蓄洪防旱、水质自然净化、调节局部微气候以及保护濒危水鸟栖息地等多重生态综合服务功能。', 'Chéngshì shīdì shēngtài bǎohù gōngyuán jiānjù xùhóng fánghàn, shuǐzhì zìrán jìnghuà, tiáojié júbù wēiqìhòu yǐjí bǎohù bīnwēi shuǐniǎo qīxīdì děng duōchóng shēngtài zōnghé fúwù gōngnéng.', 'Công viên bảo tồn sinh thái đất ngập nước đô thị tích hợp đa chức năng dịch vụ sinh thái tổng hợp như trữ lũ chống hạn, lọc sạch tự nhiên chất lượng nước, điều hòa vi khí hậu cục bộ cũng như bảo vệ nơi cư trú của các loài chim nước có nguy cơ tuyệt chủng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2412] [公平] (gōngpíng) - công bằng, bình đẳng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '公平' AND pinyin = 'gōngpíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '公平' AND pinyin = 'gōngpíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '公平'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '公平'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'gōngpíng',
      meaning_vi = 'công bằng, bình đẳng',
      example_hanzi = '体育比赛最宝贵的核心精神就在于遵守规则和维护公平公正的竞技环境。',
      example_pinyin = 'Tǐyù bǐsài zuì bǎoguì de héxīn jīngshén jiù zàiyú zūnshǒu guīzé hé wéihù gōngpíng gōngzhèng de jìngjì huánjìng.',
      example_vi = 'Tinh thần cốt lõi quý giá nhất của các trận thi đấu thể thao chính là tuân thủ luật lệ và bảo vệ môi trường tranh tài công bằng minh bạch.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '公平',
      'gōngpíng',
      'công bằng, bình đẳng',
      'Tính từ',
      'HSK 5',
      '体育比赛最宝贵的核心精神就在于遵守规则和维护公平公正的竞技环境。',
      'Tǐyù bǐsài zuì bǎoguì de héxīn jīngshén jiù zàiyú zūnshǒu guīzé hé wéihù gōngpíng gōngzhèng de jìngjì huánjìng.',
      'Tinh thần cốt lõi quý giá nhất của các trận thi đấu thể thao chính là tuân thủ luật lệ và bảo vệ môi trường tranh tài công bằng minh bạch.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '体育比赛最宝贵的核心精神就在于遵守规则和维护公平公正的竞技环境。', 'Tǐyù bǐsài zuì bǎoguì de héxīn jīngshén jiù zàiyú zūnshǒu guīzé hé wéihù gōngpíng gōngzhèng de jìngjì huánjìng.', 'Tinh thần cốt lõi quý giá nhất của các trận thi đấu thể thao chính là tuân thủ luật lệ và bảo vệ môi trường tranh tài công bằng minh bạch.', 'basic', 1),
      (v_id, '司法审判机关始终坚持以事实为依据、以法律为准绳，严格杜绝权力寻租与人情干扰，切实让人民群众在每一个司法案件中都感受到公平正义。', 'Sīfǎ shěnpàn jīgòu shǐzhōng jiānchí yǐ shìshí wéi yījù, yǐ fǎlǜ wéi zhǔnshéng, yángé dùjué quánlì xúnzū yǔ rénqíng gānrǎo, qièshí ràng rénmín qúnzhòng zài měi yí gè sīfǎ ànjiàn zhōng dōu gǎnshòudào gōngpíng zhèngyì.', 'Các cơ quan xét xử tư pháp luôn kiên trì lấy sự thật làm căn cứ, lấy pháp luật làm thước đo chuẩn mực, ngăn chặn nghiêm ngặt việc lạm quyền mưu lợi và can thiệp nể nang, làm cho quần chúng nhân dân cảm nhận được công lý công bằng trong từng vụ án tư pháp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2413] [公务员] (gōngwùyuán) - công chức, viên chức nhà nước [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '公务员' AND pinyin = 'gōngwùyuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '公务员' AND pinyin = 'gōngwùyuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '公务员'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '公务员'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gōngwùyuán',
      meaning_vi = 'công chức, viên chức nhà nước',
      example_hanzi = '许多大学毕业生为了追求稳定的职业发展平台，积极报名参加国家公务员录用考试。',
      example_pinyin = 'Xǔduō dàxué bìyèshēng wèile zhuīqiú wěndìng de zhíyè fāzhǎn píngtái, jījí bàomíng cānjiā guójiā gōngwùyuán lùyòng kǎoshì.',
      example_vi = 'Nhiều sinh viên tốt nghiệp đại học vì theo đuổi một bệ phóng nghề nghiệp ổn định nên đã tích cực đăng ký tham gia kỳ thi tuyển dụng công chức nhà nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '公务员',
      'gōngwùyuán',
      'công chức, viên chức nhà nước',
      'Danh từ',
      'HSK 5',
      '许多大学毕业生为了追求稳定的职业发展平台，积极报名参加国家公务员录用考试。',
      'Xǔduō dàxué bìyèshēng wèile zhuīqiú wěndìng de zhíyè fāzhǎn píngtái, jījí bàomíng cānjiā guójiā gōngwùyuán lùyòng kǎoshì.',
      'Nhiều sinh viên tốt nghiệp đại học vì theo đuổi một bệ phóng nghề nghiệp ổn định nên đã tích cực đăng ký tham gia kỳ thi tuyển dụng công chức nhà nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '许多大学毕业生为了追求稳定的职业发展平台，积极报名参加国家公务员录用考试。', 'Xǔduō dàxué bìyèshēng wèile zhuīqiú wěndìng de zhíyè fāzhǎn píngtái, jījí bàomíng cānjiā guójiā gōngwùyuán lùyòng kǎoshì.', 'Nhiều sinh viên tốt nghiệp đại học vì theo đuổi một bệ phóng nghề nghiệp ổn định nên đã tích cực đăng ký tham gia kỳ thi tuyển dụng công chức nhà nước.', 'basic', 1),
      (v_id, '作为一名扎根基层为人民服务的人民公务员，应当秉持勤政廉洁、务实担当的职业道德操守，全心全意为老百姓排忧解难办实事。', 'Zuòwéi yì míng zhāgēn jīcéng wèi rénmín fúwù de rénmín gōngwùyuán, yīngdāng bǐngchí qínzhèng liánjié, wùshí dāndāng de zhíyè dàodé cāoshǒu, quánxīn-quányì wèi lǎobǎixìng páiyōu-jiěnán bàn shíshì.', 'Là một công chức nhân dân cắm rễ ở cơ sở phục vụ nhân dân, cần giữ vững phẩm chất đạo đức nghề nghiệp siêng năng liêm khiết, thiết thực gánh vác trách nhiệm, hết lòng hết sức tháo gỡ khó khăn làm việc thực tế cho người dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2414] [恭喜] (gōngxǐ) - chúc mừng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '恭喜' AND pinyin = 'gōngxǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '恭喜' AND pinyin = 'gōngxǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '恭喜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '恭喜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gōngxǐ',
      meaning_vi = 'chúc mừng',
      example_hanzi = '听闻你顺利通过了这次高难度的外语专业八级考试，我由衷地向你表示恭喜！',
      example_pinyin = 'Tīngwén nǐ shùnlì tōngguò le zhè cì gāo nándù de wàiyǔ zhuānyè bājí kǎoshì, wǒ yóuzhōng de xiàng nǐ biǎoshì gōngxǐ!',
      example_vi = 'Nghe tin bạn đã thuận lợi vượt qua kỳ thi chuyên ngành ngoại ngữ cấp tám có độ khó cao này, tôi xin gửi lời chúc mừng chân thành nhất tới bạn!'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '恭喜',
      'gōngxǐ',
      'chúc mừng',
      'Động từ',
      'HSK 5',
      '听闻你顺利通过了这次高难度的外语专业八级考试，我由衷地向你表示恭喜！',
      'Tīngwén nǐ shùnlì tōngguò le zhè cì gāo nándù de wàiyǔ zhuānyè bājí kǎoshì, wǒ yóuzhōng de xiàng nǐ biǎoshì gōngxǐ!',
      'Nghe tin bạn đã thuận lợi vượt qua kỳ thi chuyên ngành ngoại ngữ cấp tám có độ khó cao này, tôi xin gửi lời chúc mừng chân thành nhất tới bạn!'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听闻你顺利通过了这次高难度的外语专业八级考试，我由衷地向你表示恭喜！', 'Tīngwén nǐ shùnlì tōngguò le zhè cì gāo nándù de wàiyǔ zhuānyè bājí kǎoshì, wǒ yóuzhōng de xiàng nǐ biǎoshì gōngxǐ!', 'Nghe tin bạn đã thuận lợi vượt qua kỳ thi chuyên ngành ngoại ngữ cấp tám có độ khó cao này, tôi xin gửi lời chúc mừng chân thành nhất tới bạn!', 'basic', 1),
      (v_id, '在新品全球发布会的庆功晚宴上，来自各大跨国合作伙伴的高管们纷纷举杯，恭喜研发团队在芯片关键核心技术上取得了划时代的巨大成功。', 'Zài xīnpǐn quánqiú fābùhuì de qìnggōng wǎnyàn shang, láizì gè dà kuàguó hézuò huǒbàn de gāoguǎn men fēnfēn jǔbēi, gōngxǐ yánfā tuánduì zài xīnpiàn guānjiàn héxīn jìshù shang qǔdé le huàshídài de jùdà chénggōng.', 'Tại buổi dạ tiệc mừng công của hội nghị ra mắt sản phẩm mới toàn cầu, các lãnh đạo cấp cao đến từ các đối tác đa quốc gia lớn đã đồng loạt nâng ly, chúc mừng đội ngũ nghiên cứu phát triển đã giành được thành công vang dội mang tính thời đại về công nghệ lõi the chốt của chip vi xử lý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2415] [工业] (gōngyè) - công nghiệp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '工业' AND pinyin = 'gōngyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工业' AND pinyin = 'gōngyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '工业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gōngyè',
      meaning_vi = 'công nghiệp',
      example_hanzi = '该地区依托丰富的煤炭资源，逐渐发展成为了一个以钢铁重工业为主的传统工业城市。',
      example_pinyin = 'Gāi dìqū yītuō fēngfù de méitàn zīyuán, zhújiàn fāzhǎn chéngwéi le yí gè yǐ gāngtiě zhòng gōngyè wéizhǔ de chuántǒng gōngyè chéngshì.',
      example_vi = 'Khu vực này dựa vào nguồn tài nguyên than đá phong phú đã dần phát triển thành một thành phố công nghiệp truyền thống lấy công nghiệp nặng luyện cán thép làm chủ đạo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '工业',
      'gōngyè',
      'công nghiệp',
      'Danh từ',
      'HSK 5',
      '该地区依托丰富的煤炭资源，逐渐发展成为了一个以钢铁重工业为主的传统工业城市。',
      'Gāi dìqū yītuō fēngfù de méitàn zīyuán, zhújiàn fāzhǎn chéngwéi le yí gè yǐ gāngtiě zhòng gōngyè wéizhǔ de chuántǒng gōngyè chéngshì.',
      'Khu vực này dựa vào nguồn tài nguyên than đá phong phú đã dần phát triển thành một thành phố công nghiệp truyền thống lấy công nghiệp nặng luyện cán thép làm chủ đạo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '该地区依托丰富的煤炭资源，逐渐发展成为了一个以钢铁重工业为主的传统工业城市。', 'Gāi dìqū yītuō fēngfù de méitàn zīyuán, zhújiàn fāzhǎn chéngwéi le yí gè yǐ gāngtiě zhòng gōngyè wéizhǔ de chuántǒng gōngyè chéngshì.', 'Khu vực này dựa vào nguồn tài nguyên than đá phong phú đã dần phát triển thành một thành phố công nghiệp truyền thống lấy công nghiệp nặng luyện cán thép làm chủ đạo.', 'basic', 1),
      (v_id, '中国拥有世界上规模最庞大、门类最齐全的现代化工业制造体系，为保障全球产业链与供应链的安全韧性发挥着压舱石的关键作用。', 'Zhōngguó yōngyǒu shìjiè shang guīmó zuì pángdà, ménlèi zuì qíquán de xiàndàihuà gōngyè zhìzào tǐxì, wèi bǎozhàng quánqiú chǎnyèliàn yǔ gōngyìngliàn de ānquán rènxìng fāhuī zhe yācāngshí de guānjiàn zuòyòng.', 'Trung Quốc sở hữu hệ thống sản xuất công nghiệp hiện đại có quy mô lớn nhất và đầy đủ ngành nghề nhất trên thế giới, đóng vai trò then chốt như hòn đá tảng giữ thăng bằng để bảo đảm tính an toàn và dẻo dai của chuỗi ngành nghề và chuỗi cung ứng toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2416] [工艺] (gōngyì) - công nghệ, quy trình chế tác, tay nghề thủ công [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '工艺' AND pinyin = 'gōngyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工艺' AND pinyin = 'gōngyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '工艺'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '工艺'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gōngyì',
      meaning_vi = 'công nghệ, quy trình chế tác, tay nghề thủ công',
      example_hanzi = '景德镇出产的传统青花瓷器造型优美、烧制工艺精湛，闻名遐迩。',
      example_pinyin = 'Jǐngdézhèn chūchǎn de chuántǒng qīnghuā cíqì zàoxíng yōuměi, shāozhì gōngyì jīngzhàn, wénmíng-xiá’ěr.',
      example_vi = 'Đồ gốm sứ hoa lam truyền thống xuất xứ từ Cảnh Đức Trấn có tạo hình đẹp mắt, quy trình nung chế tinh xảo tuyệt luân, nức tiếng gần xa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '工艺',
      'gōngyì',
      'công nghệ, quy trình chế tác, tay nghề thủ công',
      'Danh từ',
      'HSK 5',
      '景德镇出产的传统青花瓷器造型优美、烧制工艺精湛，闻名遐迩。',
      'Jǐngdézhèn chūchǎn de chuántǒng qīnghuā cíqì zàoxíng yōuměi, shāozhì gōngyì jīngzhàn, wénmíng-xiá’ěr.',
      'Đồ gốm sứ hoa lam truyền thống xuất xứ từ Cảnh Đức Trấn có tạo hình đẹp mắt, quy trình nung chế tinh xảo tuyệt luân, nức tiếng gần xa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '景德镇出产的传统青花瓷器造型优美、烧制工艺精湛，闻名遐迩。', 'Jǐngdézhèn chūchǎn de chuántǒng qīnghuā cíqì zàoxíng yōuměi, shāozhì gōngyì jīngzhàn, wénmíng-xiá’ěr.', 'Đồ gốm sứ hoa lam truyền thống xuất xứ từ Cảnh Đức Trấn có tạo hình đẹp mắt, quy trình nung chế tinh xảo tuyệt luân, nức tiếng gần xa.', 'basic', 1),
      (v_id, '先进半导体晶圆代工制造对光刻与薄膜沉积的纳米级加工工艺有着极其严苛的公差控制要求，容不得丝毫哪怕几纳米的微尘偏差。', 'Xiānjìn bàndǎotǐ jīngyuán dàigōng zhìzào duì guāngkè yǔ bómó chénjī de nàmǐjí jiāgōng gōngyì yǒuzhe jíqí yánkē de gōngchà kòngzhì yāoqiú, róng bùdé sīháo nǎpà jǐ nàmǐ de wēichén piānchā.', 'Chế tạo gia công tấm bán dẫn wafer tiên tiến có yêu cầu kiểm soát dung sai cực kỳ khắt khe đối với quy trình công nghệ gia công cấp độ nanomet của quang khắc và lắng đọng màng mỏng, không chấp nhận bất kỳ sai lệch nào dù chỉ vài nanomet bụi mịn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2417] [公寓] (gōngyù) - căn hộ chung cư, khu nhà tập thể [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '公寓' AND pinyin = 'gōngyù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '公寓' AND pinyin = 'gōngyù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '公寓'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '公寓'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gōngyù',
      meaning_vi = 'căn hộ chung cư, khu nhà tập thể',
      example_hanzi = '他在公司附近租了一间精装修的单身公寓，每天步行十分钟即可上下班。',
      example_pinyin = 'Tā zài gōngsī fùjìn zū le yì jiān jīngzhuāngxiū de dānshēn gōngyù, měitiān bùxíng shí fēnzhōng jíkě shàng-xiàbān.',
      example_vi = 'Anh ấy đã thuê một căn hộ chung cư đơn thân đầy đủ nội thất cao cấp ở gần công ty, mỗi ngày chỉ cần đi bộ mười phút là có thể đi làm và tan sở.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '公寓',
      'gōngyù',
      'căn hộ chung cư, khu nhà tập thể',
      'Danh từ',
      'HSK 5',
      '他在公司附近租了一间精装修的单身公寓，每天步行十分钟即可上下班。',
      'Tā zài gōngsī fùjìn zū le yì jiān jīngzhuāngxiū de dānshēn gōngyù, měitiān bùxíng shí fēnzhōng jíkě shàng-xiàbān.',
      'Anh ấy đã thuê một căn hộ chung cư đơn thân đầy đủ nội thất cao cấp ở gần công ty, mỗi ngày chỉ cần đi bộ mười phút là có thể đi làm và tan sở.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在公司附近租了一间精装修的单身公寓，每天步行十分钟即可上下班。', 'Tā zài gōngsī fùjìn zū le yì jiān jīngzhuāngxiū de dānshēn gōngyù, měitiān bùxíng shí fēnzhōng jíkě shàng-xiàbān.', 'Anh ấy đã thuê một căn hộ chung cư đơn thân đầy đủ nội thất cao cấp ở gần công ty, mỗi ngày chỉ cần đi bộ mười phút là có thể đi làm và tan sở.', 'basic', 1),
      (v_id, '大城市为吸引高层次海归科研人才与青年创业者，在核心商务科技园周边统一规划建设了配套齐全、租金补贴优惠的人才智慧青年公寓。', 'Dà chéngshì wèi xīyǐn gāo céngcì hǎiguī kēyán réncái yǔ qīngnián chuàngyèzhě, zài héxīn shāngwù kējìyuán zhōubiān tǒngyī guīhuà jiànshè le pèitào qíquán, zūjīn bǔtiē yōuhuì de réncái zhìhuì qīngnián gōngyù.', 'Các đô thị lớn nhằm thu hút nhân tài nghiên cứu khoa học du học về nước trình độ cao cùng các nhà khởi nghiệp trẻ, đã quy hoạch xây dựng đồng bộ các khu căn hộ chung cư thông minh dành cho nhân tài trẻ tuổi với tiện ích đầy đủ và chính sách trợ cấp tiền thuê nhà ưu đãi quanh các công viên khoa học thương mại cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2418] [贡献] (gòngxiàn) - cống hiến, đóng góp [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '贡献' AND pinyin = 'gòngxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '贡献' AND pinyin = 'gòngxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '贡献'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '贡献'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'gòngxiàn',
      meaning_vi = 'cống hiến, đóng góp',
      example_hanzi = '老科学家把自己一生的青春与心血都无私奉献给了祖国的农业育种科研事业。',
      example_pinyin = 'Lǎo kēxuéjiā bǎ zìjǐ yìshēng de qīngchūn yǔ xīnxuè dōu wúsī fèngxiàn gěi le zǔguó de nóngyè yùzhǒng kēyán shìyè.',
      example_vi = 'Nhà khoa học lão thành đã cống hiến vô tư cả tuổi xuân và tâm huyết cả đời mình cho sự nghiệp nghiên cứu khoa học lai tạo giống cây nông nghiệp của tổ quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '贡献',
      'gòngxiàn',
      'cống hiến, đóng góp',
      'Động từ / Danh từ',
      'HSK 5',
      '老科学家把自己一生的青春与心血都无私奉献给了祖国的农业育种科研事业。',
      'Lǎo kēxuéjiā bǎ zìjǐ yìshēng de qīngchūn yǔ xīnxuè dōu wúsī fèngxiàn gěi le zǔguó de nóngyè yùzhǒng kēyán shìyè.',
      'Nhà khoa học lão thành đã cống hiến vô tư cả tuổi xuân và tâm huyết cả đời mình cho sự nghiệp nghiên cứu khoa học lai tạo giống cây nông nghiệp của tổ quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '老科学家把自己一生的青春与心血都无私奉献给了祖国的农业育种科研事业。', 'Lǎo kēxuéjiā bǎ zìjǐ yìshēng de qīngchūn yǔ xīnxuè dōu wúsī fèngxiàn gěi le zǔguó de nóngyè yùzhǒng kēyán shìyè.', 'Nhà khoa học lão thành đã cống hiến vô tư cả tuổi xuân và tâm huyết cả đời mình cho sự nghiệp nghiên cứu khoa học lai tạo giống cây nông nghiệp của tổ quốc.', 'basic', 1),
      (v_id, '袁隆平院士一生潜心钻研杂交水稻杂交育种技术，不仅解决了数亿中国人的吃饭问题，更对保障全人类的全球粮食安全作出了不可磨灭的历史性重大贡献。', 'Yuán Lóngpíng yuànshì yìshēng qiánxīn zuānyán zájiāo shuǐdào zájiāo yùzhǒng jìshù, bùjǐn jiějué le shù yì Zhōngguórén de chīfàn wèntí, gèng duì bǎozhàng quán rénlèi de quánqiú liángshi ānquán zuòchū le bùkě mómìe de lìshǐxìng zhòngdà gòngxiàn.', 'Viện sĩ Viên Long Bình cả đời dốc lòng nghiên cứu công nghệ lai tạo giống lúa lai, không chỉ giải quyết bài toán lương thực cho hàng trăm triệu người dân Trung Quốc, mà còn tạo nên cống hiến lịch sử trọng đại không thể phai mờ đối với việc bảo đảm an ninh lương thực toàn cầu cho toàn nhân loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2419] [共享] (gòngxiǎng) - cùng hưởng, chia sẻ dùng chung [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '共享' AND pinyin = 'gòngxiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '共享' AND pinyin = 'gòngxiǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '共享'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '共享'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gòngxiǎng',
      meaning_vi = 'cùng hưởng, chia sẻ dùng chung',
      example_hanzi = '在繁华的地铁站出入口，摆放着许多整齐排列的共享单车供市民随时扫码骑行。',
      example_pinyin = 'Zài fánhuá de dìtiězhàn chūrùkǒu, bǎifàng zhe xǔduō zhěngqí páiliè de gòngxiǎng dānchē gōng shìmín suíshí sǎomǎ qíxíng.',
      example_vi = 'Tại các lối ra vào ga tàu điện ngầm sầm uất, có đặt rất nhiều xe đạp dùng chung xếp thành hàng ngay ngắn để người dân có thể quét mã đạp xe bất cứ lúc nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '共享',
      'gòngxiǎng',
      'cùng hưởng, chia sẻ dùng chung',
      'Động từ',
      'HSK 5',
      '在繁华的地铁站出入口，摆放着许多整齐排列的共享单车供市民随时扫码骑行。',
      'Zài fánhuá de dìtiězhàn chūrùkǒu, bǎifàng zhe xǔduō zhěngqí páiliè de gòngxiǎng dānchē gōng shìmín suíshí sǎomǎ qíxíng.',
      'Tại các lối ra vào ga tàu điện ngầm sầm uất, có đặt rất nhiều xe đạp dùng chung xếp thành hàng ngay ngắn để người dân có thể quét mã đạp xe bất cứ lúc nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在繁华的地铁站出入口，摆放着许多整齐排列的共享单车供市民随时扫码骑行。', 'Zài fánhuá de dìtiězhàn chūrùkǒu, bǎifàng zhe xǔduō zhěngqí páiliè de gòngxiǎng dānchē gōng shìmín suíshí sǎomǎ qíxíng.', 'Tại các lối ra vào ga tàu điện ngầm sầm uất, có đặt rất nhiều xe đạp dùng chung xếp thành hàng ngay ngắn để người dân có thể quét mã đạp xe bất cứ lúc nào.', 'basic', 1),
      (v_id, '推进区域经济一体化发展的核心举措之一，就是破除行政壁垒，实现跨区域公共医疗科研大数据、教育名师资源以及大型科研仪器设备的互联互通与开放共享。', 'Tuījìn qūyù jīngjì yītǐhuà fāzhǎn de héxīn jǔcuò zhīyī, jiùshì pòchú xíngzhèng bìlěi, shíxiàn kuà qūyù gōnggòng yīliáo kēyán dàshùjù, jiàoyù míngshī zīyuán yǐjí dàxíng kēyán yíqì shèbèi de hùlián-hùtōng yǔ kāifàng gòngxiǎng.', 'Một trong những biện pháp cốt lõi để thúc đẩy phát triển liên kết kinh tế vùng nhất thể hóa chính là phá bỏ rào cản hành chính, thực hiện kết nối liên thông và chia sẻ mở rộng các nguồn dữ liệu lớn nghiên cứu y tế công cộng, tài nguyên giáo viên giỏi cùng các thiết bị máy móc nghiên cứu khoa học cỡ lớn liên vùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2420] [沟通] (gōutōng) - giao tiếp, trao đổi, thông hiểu, gắn kết [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '沟通' AND pinyin = 'gōutōng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沟通' AND pinyin = 'gōutōng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '沟通'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沟通'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'gōutōng',
      meaning_vi = 'giao tiếp, trao đổi, thông hiểu, gắn kết',
      example_hanzi = '当朋友之间产生误会时，坦诚面对并及时沟通是化解矛盾最好的办法。',
      example_pinyin = 'Dāng péngyou zhījiān chǎnshēng wùhuì shí, tǎnchéng miànduì bìng jíshí gōutōng shì huàjiě máodùn zuì hǎo de bànfǎ.',
      example_vi = 'Khi giữa bạn bè nảy sinh hiểu lầm, đối mặt chân thành và kịp thời giao tiếp trao đổi là cách tốt nhất để hóa giải mâu thuẫn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '沟通',
      'gōutōng',
      'giao tiếp, trao đổi, thông hiểu, gắn kết',
      'Động từ / Danh từ',
      'HSK 5',
      '当朋友之间产生误会时，坦诚面对并及时沟通是化解矛盾最好的办法。',
      'Dāng péngyou zhījiān chǎnshēng wùhuì shí, tǎnchéng miànduì bìng jíshí gōutōng shì huàjiě máodùn zuì hǎo de bànfǎ.',
      'Khi giữa bạn bè nảy sinh hiểu lầm, đối mặt chân thành và kịp thời giao tiếp trao đổi là cách tốt nhất để hóa giải mâu thuẫn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '当朋友之间产生误会时，坦诚面对并及时沟通是化解矛盾最好的办法。', 'Dāng péngyou zhījiān chǎnshēng wùhuì shí, tǎnchéng miànduì bìng jíshí gōutōng shì huàjiě máodùn zuì hǎo de bànfǎ.', 'Khi giữa bạn bè nảy sinh hiểu lầm, đối mặt chân thành và kịp thời giao tiếp trao đổi là cách tốt nhất để hóa giải mâu thuẫn.', 'basic', 1),
      (v_id, '在跨文化跨学科的全球化大项目中，项目负责人必须具备高超的双语谈判技巧与同理心沟通协调能力，才能妥善平衡各方利益诉求并推动合作顺利落地。', 'Zài kuà wénhuà kuà xuékē de quánqiúhuà dà xiàngmù zhōng, xiàngmù fùzérén bìxū jùbèi gāochāo de shuāngyǔ tánpàn jìqiǎo yǔ tónglǐxīn gōutōng xiétiáo nénglì, cáinéng tuǒshàn pínghéng gèfāng lìyì sùqiú bìng tuīdòng hézuò shùnlì luòdì.', 'Trong các dự án toàn cầu hóa quy mô lớn liên văn hóa và liên ngành, người phụ trách dự án nhất định phải sở hữu kỹ năng đàm phán song ngữ điêu luyện cùng năng lực giao tiếp điều phối thấu cảm cao độ, mới có thể cân bằng thỏa đáng các yêu cầu lợi ích của các bên và thúc đẩy hợp tác đi vào thực tiễn thuận lợi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2421] [构成] (gòuchéng) - cấu thành, tạo thành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '构成' AND pinyin = 'gòuchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '构成' AND pinyin = 'gòuchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '构成'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '构成'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gòuchéng',
      meaning_vi = 'cấu thành, tạo thành',
      example_hanzi = '红花、绿草和清澈见底的溪流共同构成了春天山谷里一幅宁静优美的自然画卷。',
      example_pinyin = 'Hóng huā, lǜ cǎo hé qīngchè-jiàndǐ de xīliú gòngtóng gòuchéng le chūntiān shāngǔ lǐ yì fú níngjìng yōuměi de zìrán huàjuàn.',
      example_vi = 'Hoa đỏ, cỏ xanh và dòng suối trong vắt nhìn thấy tận đáy đã cùng nhau cấu thành nên một bức tranh thiên nhiên tĩnh lặng tươi đẹp nơi thung lũng mùa xuân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '构成',
      'gòuchéng',
      'cấu thành, tạo thành',
      'Động từ',
      'HSK 5',
      '红花、绿草和清澈见底的溪流共同构成了春天山谷里一幅宁静优美的自然画卷。',
      'Hóng huā, lǜ cǎo hé qīngchè-jiàndǐ de xīliú gòngtóng gòuchéng le chūntiān shāngǔ lǐ yì fú níngjìng yōuměi de zìrán huàjuàn.',
      'Hoa đỏ, cỏ xanh và dòng suối trong vắt nhìn thấy tận đáy đã cùng nhau cấu thành nên một bức tranh thiên nhiên tĩnh lặng tươi đẹp nơi thung lũng mùa xuân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '红花、绿草和清澈见底的溪流共同构成了春天山谷里一幅宁静优美的自然画卷。', 'Hóng huā, lǜ cǎo hé qīngchè-jiàndǐ de xīliú gòngtóng gòuchéng le chūntiān shāngǔ lǐ yì fú níngjìng yōuměi de zìrán huàjuàn.', 'Hoa đỏ, cỏ xanh và dòng suối trong vắt nhìn thấy tận đáy đã cùng nhau cấu thành nên một bức tranh thiên nhiên tĩnh lặng tươi đẹp nơi thung lũng mùa xuân.', 'basic', 1),
      (v_id, '法院在审理后依法认定，该企业在互联网平台公开发布虚假产品质量评测并诋毁同行商誉的行为，已经构成了不正当竞争与民事侵权。', 'Fǎyuàn zài shěnlǐ hòu yīfǎ rèndìng, gāi qǐyè zài hùliánwǎng píngtái gōngkāi fābù xūjiǎ chǎnpǐn zhìliàng píngcè bìng dǐhuǐ tóngháng shāngyù de xíngwéi, yǐjīng gòuchéng le bù zhèngdàng jìngzhēng yǔ mínshì qīnquán.', 'Tòa án sau khi xét xử đã nhận định theo luật rằng, hành vi doanh nghiệp này công khai đăng tải các bài đánh giá kiểm thử chất lượng sản phẩm giả mạo trên nền tảng mạng internet và bôi nhọ uy tín thương mại của đồng nghiệp trong ngành, đã cấu thành hành vi cạnh tranh không lành mạnh và xâm phạm dân sự.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2422] [古] (gǔ) - cổ, xưa, cổ kính, thời xưa [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '古' AND pinyin = 'gǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '古' AND pinyin = 'gǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '古'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '古'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'gǔ',
      meaning_vi = 'cổ, xưa, cổ kính, thời xưa',
      example_hanzi = '中国古诗讲究押韵与对仗，字里行间往往流露出深沉隽永的情感。',
      example_pinyin = 'Zhōngguó gǔshī jiǎngjiu yāyùn yǔ duìzhàng, zìlǐ-hángjiān wǎngwǎng liúlù chū shēnchén juànyǒng de qínggǎn.',
      example_vi = 'Thơ cổ Trung Quốc rất chú trọng gieo vần và phép đối ngẫu, giữa các hàng chữ thường bộc lộ cảm xúc sâu lắng ý vị dài lâu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '古',
      'gǔ',
      'cổ, xưa, cổ kính, thời xưa',
      'Tính từ / Danh từ',
      'HSK 5',
      '中国古诗讲究押韵与对仗，字里行间往往流露出深沉隽永的情感。',
      'Zhōngguó gǔshī jiǎngjiu yāyùn yǔ duìzhàng, zìlǐ-hángjiān wǎngwǎng liúlù chū shēnchén juànyǒng de qínggǎn.',
      'Thơ cổ Trung Quốc rất chú trọng gieo vần và phép đối ngẫu, giữa các hàng chữ thường bộc lộ cảm xúc sâu lắng ý vị dài lâu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中国古诗讲究押韵与对仗，字里行间往往流露出深沉隽永的情感。', 'Zhōngguó gǔshī jiǎngjiu yāyùn yǔ duìzhàng, zìlǐ-hángjiān wǎngwǎng liúlù chū shēnchén juànyǒng de qínggǎn.', 'Thơ cổ Trung Quốc rất chú trọng gieo vần và phép đối ngẫu, giữa các hàng chữ thường bộc lộ cảm xúc sâu lắng ý vị dài lâu.', 'basic', 1),
      (v_id, '学者通过对比研究古今汉语在语音演化、词义转移及句法结构方面的流变特征，清晰揭示了华夏语言文字数千年绵延不绝的生命力。', 'Xuézhě tōngguò duìbǐ yánjiū gǔ-jīn Hànyǔ zài yǔyīn yǎnhuà, cíyì zhuǎnyí jí jùfǎ jiégòu fāngmiàn de liúbiàn tèzhēng, qīngxī jiēshì le Huáxià yǔyán wénzì shù qiān nián miányán-bùjué de shēngmìnglì.', 'Các học giả thông qua việc nghiên cứu so sánh các đặc trưng biến đổi của tiếng Hán xưa và nay trên các phương diện diễn hóa ngữ âm, dịch chuyển nghĩa từ và cấu trúc cú pháp, đã làm sáng tỏ sức sống bền bỉ không dứt qua hàng nghìn năm của ngôn ngữ văn tự dân tộc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2423] [鼓] (gǔ) - cái trống; đánh trống, gõ, cổ vũ [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '鼓' AND pinyin = 'gǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '鼓' AND pinyin = 'gǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '鼓'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '鼓'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'gǔ',
      meaning_vi = 'cái trống; đánh trống, gõ, cổ vũ',
      example_hanzi = '在传统龙舟比赛中，船头的鼓手奋力击鼓，为全船奋勇划桨的队员们鼓舞士气。',
      example_pinyin = 'Zài chuántǒng lóngzhōu bǐsài zhōng, chuántóu de gǔshǒu fènlì jīgǔ, wèi quán chuán fènyǒng huájiǎng de duìyuán men gǔwǔ shìqì.',
      example_vi = 'Trong cuộc đua thuyền rồng truyền thống, người đánh trống ở đầu thuyền dốc sức gõ trống để cổ vũ sĩ khí cho các thành viên đang ra sức chèo mái chèo trên toàn thuyền.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '鼓',
      'gǔ',
      'cái trống; đánh trống, gõ, cổ vũ',
      'Danh từ / Động từ',
      'HSK 5',
      '在传统龙舟比赛中，船头的鼓手奋力击鼓，为全船奋勇划桨的队员们鼓舞士气。',
      'Zài chuántǒng lóngzhōu bǐsài zhōng, chuántóu de gǔshǒu fènlì jīgǔ, wèi quán chuán fènyǒng huájiǎng de duìyuán men gǔwǔ shìqì.',
      'Trong cuộc đua thuyền rồng truyền thống, người đánh trống ở đầu thuyền dốc sức gõ trống để cổ vũ sĩ khí cho các thành viên đang ra sức chèo mái chèo trên toàn thuyền.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在传统龙舟比赛中，船头的鼓手奋力击鼓，为全船奋勇划桨的队员们鼓舞士气。', 'Zài chuántǒng lóngzhōu bǐsài zhōng, chuántóu de gǔshǒu fènlì jīgǔ, wèi quán chuán fènyǒng huájiǎng de duìyuán men gǔwǔ shìqì.', 'Trong cuộc đua thuyền rồng truyền thống, người đánh trống ở đầu thuyền dốc sức gõ trống để cổ vũ sĩ khí cho các thành viên đang ra sức chèo mái chèo trên toàn thuyền.', 'basic', 1),
      (v_id, '每逢重大节日庆典，陕北威风锣鼓队气势磅礴的阵型与震天动地的鼓点声浪，生动展现出黄土高原人民豪迈热烈、昂扬向上的精神风貌。', 'Měiféng zhòngdà jiérì qìngdiǎn, Shǎnběi wēifēng luógǔduì qìshì pángbó de zhènxíng yǔ zhèntiān-dòngdì de gǔdiǎn shēnglàng, shēngdòng zhǎnxiàn chū huángtǔ gāoyuán rénmín háomài rèliè, ángyáng xiàngshàng de jīngshén fēngmào.', 'Mỗi dịp đại lễ kỷ niệm, đội chiêng trống uy phong đất Thiểm Bắc với đội hình khí thế bàng bạc và làn sóng tiếng trống rền vang rung chuyển trời đất, đã thể hiện sinh động diện mạo tinh thần hào sảng nhiệt huyết và luôn vươn lên của người dân vùng cao nguyên đất vàng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2424] [古代] (gǔdài) - thời cổ đại, thời xưa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '古代' AND pinyin = 'gǔdài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '古代' AND pinyin = 'gǔdài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '古代'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '古代'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gǔdài',
      meaning_vi = 'thời cổ đại, thời xưa',
      example_hanzi = '指南针、火药、造纸术和活字印刷术并称为中国古代享誉世界的“四大发明”。',
      example_pinyin = 'Zhǐnánzhēn, huǒyào, zàozhǐshù hé huózì yìnshuāshù bìngchēng wéi Zhōngguó gǔdài xiǎngyù shìjiè de “sì dà fāmíng”.',
      example_vi = 'La bàn, thuốc súng, kỹ thuật làm giấy và in ấn chữ rời được mệnh danh là "Tứ đại phát minh" vang danh thế giới của thời cổ đại Trung Quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '古代',
      'gǔdài',
      'thời cổ đại, thời xưa',
      'Danh từ',
      'HSK 5',
      '指南针、火药、造纸术和活字印刷术并称为中国古代享誉世界的“四大发明”。',
      'Zhǐnánzhēn, huǒyào, zàozhǐshù hé huózì yìnshuāshù bìngchēng wéi Zhōngguó gǔdài xiǎngyù shìjiè de “sì dà fāmíng”.',
      'La bàn, thuốc súng, kỹ thuật làm giấy và in ấn chữ rời được mệnh danh là "Tứ đại phát minh" vang danh thế giới của thời cổ đại Trung Quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '指南针、火药、造纸术和活字印刷术并称为中国古代享誉世界的“四大发明”。', 'Zhǐnánzhēn, huǒyào, zàozhǐshù hé huózì yìnshuāshù bìngchēng wéi Zhōngguó gǔdài xiǎngyù shìjiè de “sì dà fāmíng”.', 'La bàn, thuốc súng, kỹ thuật làm giấy và in ấn chữ rời được mệnh danh là "Tứ đại phát minh" vang danh thế giới của thời cổ đại Trung Quốc.', 'basic', 1),
      (v_id, '考古工作者在古代丝绸之路沿线的沙漠古城遗址中发掘出大量罗马金币、波斯织锦和汉代竹简，生动印证了古代东西方文明跨越千里的经贸文化繁荣交流。', 'Kǎogǔ gōngzuòzhě zài gǔdài Sīchóu zhī Lù yánxiàn de shāmò gǔchéng yízhǐ zhōng fājué chū dàliàng Luómǎ jīnbì, Bōsī zhījǐn hé Hàndài zhújiǎn, shēngdòng yìnzhèng le gǔdài dōng-xīfāng wénmíng kuàyuè qiān lǐ de jīngmào wénhuà fánróng jiāoliú.', 'Các nhà khảo cổ học tại di chỉ thành cổ giữa sa mạc dọc theo Con đường Tơ lụa thời cổ đại đã khai quật được lượng lớn tiền vàng La Mã, gấm dệt Ba Tư và thẻ tre thời Hán, chứng minh sinh động cho sự giao lưu thịnh vượng về văn hóa kinh tế thương mại vượt hàng nghìn dặm giữa các nền văn minh phương Đông và phương Tây thời cổ xưa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2425] [古老] (gǔlǎo) - cổ kính, lâu đời [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '古老' AND pinyin = 'gǔlǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '古老' AND pinyin = 'gǔlǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '古老'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '古老'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'gǔlǎo',
      meaning_vi = 'cổ kính, lâu đời',
      example_hanzi = '漫步在长城蜿蜒起伏的石阶上，人们无不为这处古老而伟大的世界文化遗产所震撼。',
      example_pinyin = 'Mànbù zài Chángchéng wānyán qǐfú de shíjiē shang, rénmín wúbù wèi zhè chù gǔlǎo ér wěidà de shìjiè wénhuà yíchǎn suǒ zhènhàn.',
      example_vi = 'Tản bộ trên những bậc đá uốn lượn nhấp nhô của Vạn Lý Trường Thành, không ai là không bị chấn động bởi di sản văn hóa thế giới cổ kính và vĩ đại này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '古老',
      'gǔlǎo',
      'cổ kính, lâu đời',
      'Tính từ',
      'HSK 5',
      '漫步在长城蜿蜒起伏的石阶上，人们无不为这处古老而伟大的世界文化遗产所震撼。',
      'Mànbù zài Chángchéng wānyán qǐfú de shíjiē shang, rénmín wúbù wèi zhè chù gǔlǎo ér wěidà de shìjiè wénhuà yíchǎn suǒ zhènhàn.',
      'Tản bộ trên những bậc đá uốn lượn nhấp nhô của Vạn Lý Trường Thành, không ai là không bị chấn động bởi di sản văn hóa thế giới cổ kính và vĩ đại này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '漫步在长城蜿蜒起伏的石阶上，人们无不为这处古老而伟大的世界文化遗产所震撼。', 'Mànbù zài Chángchéng wānyán qǐfú de shíjiē shang, rénmín wúbù wèi zhè chù gǔlǎo ér wěidà de shìjiè wénhuà yíchǎn suǒ zhènhàn.', 'Tản bộ trên những bậc đá uốn lượn nhấp nhô của Vạn Lý Trường Thành, không ai là không bị chấn động bởi di sản văn hóa thế giới cổ kính và vĩ đại này.', 'basic', 1),
      (v_id, '非物质文化遗产传承人凭借数十年如一日的匠心坚守，让古老的皮影戏和手工扎染技艺在现代年轻一代观众中重新焕发出生机与活力。', 'Fēi wùzhì wénhuà yíchǎn chuánchéngrén píngjiè shù shí nián rú yírì de jiàngxīn jiānshǒu, ràng gǔlǎo de píyǐngxì hé shǒugōng zānrǎn jìyì zài xiàndài niánqīng yídài guānzhòng zhōng chóngxīn huànfā chū shēngjī yǔ huólì.', 'Người truyền thừa di sản văn hóa phi vật thể nhờ sự kiên trì với tâm huyết người thợ mộc mạc suốt mấy chục năm như một, đã giúp cho nghệ thuật múa rối bóng và kỹ nghệ nhuộm buộc thủ công cổ xưa bừng sáng lại sức sống và sự tươi mới trong lòng thế hệ khán giả trẻ hiện đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2426] [鼓掌] (gǔzhǎng) - vỗ tay, hoan hô tán thưởng [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '鼓掌' AND pinyin = 'gǔzhǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '鼓掌' AND pinyin = 'gǔzhǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '鼓掌'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '鼓掌'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gǔzhǎng',
      meaning_vi = 'vỗ tay, hoan hô tán thưởng',
      example_hanzi = '当精彩的钢琴演奏落下最后一个优美的音符时，全场观众情不自禁地起立热烈鼓掌。',
      example_pinyin = 'Dāng jīngcǎi de gāngqín yǎnzòu luòxià zuìhòu yí gè yōuměi de yīnfú shí, quánchǎng guānzhòng qíngbùzìjìn de qǐlì rèliè gǔzhǎng.',
      example_vi = 'Khi nốt nhạc tuyệt đẹp cuối cùng của buổi diễn tấu dương cầm xuất sắc vừa dứt điểm, toàn thể khán giả trong khán phòng đã không kìm được đồng loạt đứng dậy vỗ tay nồng nhiệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '鼓掌',
      'gǔzhǎng',
      'vỗ tay, hoan hô tán thưởng',
      'Động từ',
      'HSK 5',
      '当精彩的钢琴演奏落下最后一个优美的音符时，全场观众情不自禁地起立热烈鼓掌。',
      'Dāng jīngcǎi de gāngqín yǎnzòu luòxià zuìhòu yí gè yōuměi de yīnfú shí, quánchǎng guānzhòng qíngbùzìjìn de qǐlì rèliè gǔzhǎng.',
      'Khi nốt nhạc tuyệt đẹp cuối cùng của buổi diễn tấu dương cầm xuất sắc vừa dứt điểm, toàn thể khán giả trong khán phòng đã không kìm được đồng loạt đứng dậy vỗ tay nồng nhiệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '当精彩的钢琴演奏落下最后一个优美的音符时，全场观众情不自禁地起立热烈鼓掌。', 'Dāng jīngcǎi de gāngqín yǎnzòu luòxià zuìhòu yí gè yōuměi de yīnfú shí, quánchǎng guānzhòng qíngbùzìjìn de qǐlì rèliè gǔzhǎng.', 'Khi nốt nhạc tuyệt đẹp cuối cùng của buổi diễn tấu dương cầm xuất sắc vừa dứt điểm, toàn thể khán giả trong khán phòng đã không kìm được đồng loạt đứng dậy vỗ tay nồng nhiệt.', 'basic', 1),
      (v_id, '经过长达三轮艰苦激烈的商务谈判，当双方首席代表在多边经贸战略合作框架协议上正式落笔签字时，会议室里爆发出了经久不息的热烈鼓掌与欢呼声。', 'Jīngguò cháng dá sān lún jiānkǔ jīliè de shāngwù tánpàn, dāng shuāngfāng shǒuxí dàibiǎo zài duōbiān jīngmào zhànlüè hézuò kuàngjià xiéyì shang zhèngshì luòbǐ qiānzì shí, huìyìshì lǐ bàofā chū le jīngjiǔ-bùxī de rèliè gǔzhǎng yǔ huānhū shēng.', 'Trải qua ba vòng đàm phán thương mại gian khổ và quyết liệt kéo dài, khi đại diện trưởng của hai bên chính thức đặt bút ký kết hiệp định khung hợp tác chiến lược kinh tế thương mại đa phương, trong phòng hội nghị đã bùng nổ những tràng pháo tay giòn giã và tiếng reo hò kéo dài không dứt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2427] [固定] (gùdìng) - cố định, làm cho vững chắc [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '固定' AND pinyin = 'gùdìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '固定' AND pinyin = 'gùdìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '固定'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '固定'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'gùdìng',
      meaning_vi = 'cố định, làm cho vững chắc',
      example_hanzi = '木工师傅用强力膨胀螺栓将书架牢牢固定在坚固的混凝土墙壁上。',
      example_pinyin = 'Mùgōng shīfu yòng qiánglì péngzhàng luóshuān jiāng shūjià láoláo gùdìng zài jiāngù de hùnníngtǔ qiángbì shang.',
      example_vi = 'Bác thợ mộc đã dùng bu lông nở chịu lực cường độ cao để cố định chặt chẽ giá sách lên bức tường bê tông vững chắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '固定',
      'gùdìng',
      'cố định, làm cho vững chắc',
      'Tính từ / Động từ',
      'HSK 5',
      '木工师傅用强力膨胀螺栓将书架牢牢固定在坚固的混凝土墙壁上。',
      'Mùgōng shīfu yòng qiánglì péngzhàng luóshuān jiāng shūjià láoláo gùdìng zài jiāngù de hùnníngtǔ qiángbì shang.',
      'Bác thợ mộc đã dùng bu lông nở chịu lực cường độ cao để cố định chặt chẽ giá sách lên bức tường bê tông vững chắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '木工师傅用强力膨胀螺栓将书架牢牢固定在坚固的混凝土墙壁上。', 'Mùgōng shīfu yòng qiánglì péngzhàng luóshuān jiāng shūjià láoláo gùdìng zài jiāngù de hùnníngtǔ qiángbì shang.', 'Bác thợ mộc đã dùng bu lông nở chịu lực cường độ cao để cố định chặt chẽ giá sách lên bức tường bê tông vững chắc.', 'basic', 1),
      (v_id, '为了防范宏观市场利率波动带来的现金流风险，跨国制造集团在筹集长期战略贷款时优先锁定了中长期的固定利率融资结构。', 'Wèile fángfàn hóngguān shìchǎng lìlǜ bōdòng dàilái de xiànjīnliú fēngxiǎn, kuàguó zhìzào jítuán zài chóují chángqī zhànlüè dàikuǎn shí yōuxiān suǒdìng le zhōng-chángqī de gùdìng lìlǜ róngzī jiégòu.', 'Để phòng ngừa rủi ro dòng tiền do biến động lãi suất thị trường vĩ mô mang lại, tập đoàn sản xuất đa quốc gia khi huy động khoản vay chiến lược dài hạn đã ưu tiên khóa cấu trúc huy động vốn bằng lãi suất cố định trung và dài hạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2428] [故乡] (gùxiāng) - quê hương, quê nhà, chốn cũ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '故乡' AND pinyin = 'gùxiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '故乡' AND pinyin = 'gùxiāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '故乡'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '故乡'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'gùxiāng',
      meaning_vi = 'quê hương, quê nhà, chốn cũ',
      example_hanzi = '离家多年后重新踏上故乡的土地，眼前的一切既熟悉又充满温馨。',
      example_pinyin = 'Líjiā duō nián hòu chóngxīn tà shàng gùxiāng de tǔdì, yǎnqián de yíqiè jì shúxī yòu chōngmǎn wēnxīn.',
      example_vi = 'Sau nhiều năm xa nhà đặt chân trở lại mảnh đất quê hương, mọi thứ trước mắt vừa thân quen lại vừa ngập tràn ấm áp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '故乡',
      'gùxiāng',
      'quê hương, quê nhà, chốn cũ',
      'Danh từ',
      'HSK 5',
      '离家多年后重新踏上故乡的土地，眼前的一切既熟悉又充满温馨。',
      'Líjiā duō nián hòu chóngxīn tà shàng gùxiāng de tǔdì, yǎnqián de yíqiè jì shúxī yòu chōngmǎn wēnxīn.',
      'Sau nhiều năm xa nhà đặt chân trở lại mảnh đất quê hương, mọi thứ trước mắt vừa thân quen lại vừa ngập tràn ấm áp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '离家多年后重新踏上故乡的土地，眼前的一切既熟悉又充满温馨。', 'Líjiā duō nián hòu chóngxīn tà shàng gùxiāng de tǔdì, yǎnqián de yíqiè jì shúxī yòu chōngmǎn wēnxīn.', 'Sau nhiều năm xa nhà đặt chân trở lại mảnh đất quê hương, mọi thứ trước mắt vừa thân quen lại vừa ngập tràn ấm áp.', 'basic', 1),
      (v_id, '漂泊海外几十载的爱国华侨始终心系故乡，晚年不仅慷慨捐资在故乡兴建现代化综合医院和希望小学，更推动了家乡特色农产品走向国际市场。', 'Piāobó hǎiwài jǐ shí zǎi de àiguó huáqiáo shǐzhōng xīn xì gùxiāng, wǎnnián bùjǐn kāngkǎi juānzī zài gùxiāng xīngjiàn xiàndàihuà zōnghé yīyuàn hé xīwàng xiǎoxué, gèng tuīdòng le jiāxiāng tèsè nóngchǎnpǐn zǒuxiàng guójì shìchǎng.', 'Vị kiều bào yêu nước bôn ba mấy chục năm nơi hải ngoại luôn hướng về quê hương, lúc tuổi già không chỉ hào phóng quyên góp kinh phí xây dựng bệnh viện đa khoa hiện đại và trường tiểu học hy vọng ở quê nhà, mà còn thúc đẩy nông sản đặc trưng quê hương vươn ra thị trường quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2429] [挂号] (guàhào) - đăng ký khám bệnh, gửi thư bảo đảm, lấy số [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '挂号' AND pinyin = 'guàhào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挂号' AND pinyin = 'guàhào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '挂号'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '挂号'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'guàhào',
      meaning_vi = 'đăng ký khám bệnh, gửi thư bảo đảm, lấy số',
      example_hanzi = '现在通过医院官方手机应用程序，患者足不出户就可以提前预约挂号专家门诊。',
      example_pinyin = 'Xiànzài tōngguò yīyuàn guānfāng shǒujī yìngyòng chéngxù, huànzhě zú bù chū hù jiù kěyǐ tíqián yùyuē guàhào zhuānjiā ménzhěn.',
      example_vi = 'Hiện nay thông qua ứng dụng di động chính thức của bệnh viện, bệnh nhân không cần bước chân ra khỏi cửa cũng có thể hẹn lịch đăng ký khám phòng khám chuyên gia trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '挂号',
      'guàhào',
      'đăng ký khám bệnh, gửi thư bảo đảm, lấy số',
      'Động từ',
      'HSK 5',
      '现在通过医院官方手机应用程序，患者足不出户就可以提前预约挂号专家门诊。',
      'Xiànzài tōngguò yīyuàn guānfāng shǒujī yìngyòng chéngxù, huànzhě zú bù chū hù jiù kěyǐ tíqián yùyuē guàhào zhuānjiā ménzhěn.',
      'Hiện nay thông qua ứng dụng di động chính thức của bệnh viện, bệnh nhân không cần bước chân ra khỏi cửa cũng có thể hẹn lịch đăng ký khám phòng khám chuyên gia trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现在通过医院官方手机应用程序，患者足不出户就可以提前预约挂号专家门诊。', 'Xiànzài tōngguò yīyuàn guānfāng shǒujī yìngyòng chéngxù, huànzhě zú bù chū hù jiù kěyǐ tíqián yùyuē guàhào zhuānjiā ménzhěn.', 'Hiện nay thông qua ứng dụng di động chính thức của bệnh viện, bệnh nhân không cần bước chân ra khỏi cửa cũng có thể hẹn lịch đăng ký khám phòng khám chuyên gia trước.', 'basic', 1),
      (v_id, '为了彻底铲除滋生医疗“黄牛”倒号卖号的灰色利益链条，三甲医院全面推行了实名制人脸识别分时段预约挂号与候诊溯源系统。', 'Wèile chèdǐ chǎnchú zīshēng yīliáo “huángniú” dǎohào màihào de huīsè lìyì lìngtiáo, sānjiǎ yīyuàn quánmiàn tuīxíng le shímíngzhì rénliǎn shíbié fēn-shíduàn yùyuē guàhào yǔ hòuzhěn sùyuán xìtǒng.', 'Để nhổ tận gốc chuỗi lợi ích ngầm sinh sôi của "cò mồi" đầu cơ phe vé bán số khám bệnh, bệnh viện hạng ba tuyến đầu đã triển khai toàn diện hệ thống lấy số đăng ký khám bệnh theo khung giờ bằng nhận diện khuôn mặt chính chủ và truy xuất nguồn gốc chờ khám.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2430] [怪] (guài) - kỳ quái; trách móc, đổ lỗi; rất, quá (phó từ) [Tính từ / Động từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '怪' AND pinyin = 'guài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '怪' AND pinyin = 'guài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '怪'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '怪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ / Phó từ',
      pinyin = 'guài',
      meaning_vi = 'kỳ quái; trách móc, đổ lỗi; rất, quá (phó từ)',
      example_hanzi = '这件事情完全是我自己粗心大意办砸的，你千万别怪小李。',
      example_pinyin = 'Zhè jiàn shìqing wánquán shì wǒ zìjǐ cūxīn-dàyì bàn zá de, nǐ qiānwàn bié guài Xiǎo Lǐ.',
      example_vi = 'Chuyện này hoàn toàn do bản thân tôi sơ suất bất cẩn làm hỏng, bạn tuyệt đối đừng trách Tiểu Lý nhé.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '怪',
      'guài',
      'kỳ quái; trách móc, đổ lỗi; rất, quá (phó từ)',
      'Tính từ / Động từ / Phó từ',
      'HSK 5',
      '这件事情完全是我自己粗心大意办砸的，你千万别怪小李。',
      'Zhè jiàn shìqing wánquán shì wǒ zìjǐ cūxīn-dàyì bàn zá de, nǐ qiānwàn bié guài Xiǎo Lǐ.',
      'Chuyện này hoàn toàn do bản thân tôi sơ suất bất cẩn làm hỏng, bạn tuyệt đối đừng trách Tiểu Lý nhé.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这件事情完全是我自己粗心大意办砸的，你千万别怪小李。', 'Zhè jiàn shìqing wánquán shì wǒ zìjǐ cūxīn-dàyì bàn zá de, nǐ qiānwàn bié guài Xiǎo Lǐ.', 'Chuyện này hoàn toàn do bản thân tôi sơ suất bất cẩn làm hỏng, bạn tuyệt đối đừng trách Tiểu Lý nhé.', 'basic', 1),
      (v_id, '在深海热泉火山口极端高压且不见天日的恶劣生态环境中，生活着许多形态极其古怪且代谢途径迥异于常态的嗜极微生物与奇异生物种群。', 'Zài shēnhǎi rèquán huǒshānkǒu jíduān gāoyā qiě bú jiàn tiānrì de èliè shēngtài huánjìng zhōng, shēnghuó zhe xǔduō xíngtài jíqí gǔguài qiě dàixiè tújìng jiǒngyì yú chángtài de shìjí wéishēngwù yǔ qíyì shēngwù zhǒngqún.', 'Trong môi trường sinh thái khắc nghiệt áp suất cực cao và tối tăm không ánh mặt trời của miệng núi lửa thủy nhiệt dưới đáy biển sâu, có rất nhiều loài vi sinh vật ưa cực và quần thể sinh vật kỳ lạ mang hình thái hết sức quái dị cùng con đường trao đổi chất khác xa trạng thái thông thường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2431] [关闭] (guānbì) - đóng lại, đóng cửa, ngừng hoạt động, tắt [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '关闭' AND pinyin = 'guānbì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '关闭' AND pinyin = 'guānbì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '关闭'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '关闭'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'guānbì',
      meaning_vi = 'đóng lại, đóng cửa, ngừng hoạt động, tắt',
      example_hanzi = '图书馆每天晚上九点半准时关闭阅览室大门，请读者提前收拾好个人物品。',
      example_pinyin = 'Túshūguǎn měitiān wǎnshang jiǔ diǎn bàn zhǔnshí guānbì yuèlǎnshì dàmén, qǐng dúzhě tíqián shōushi hǎo gèrén wùpǐn.',
      example_vi = 'Thư viện mỗi tối chín giờ rưỡi đều đóng cửa phòng đọc đúng giờ, xin mời quý độc giả dọn dẹp trước đồ đạc cá nhân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '关闭',
      'guānbì',
      'đóng lại, đóng cửa, ngừng hoạt động, tắt',
      'Động từ',
      'HSK 5',
      '图书馆每天晚上九点半准时关闭阅览室大门，请读者提前收拾好个人物品。',
      'Túshūguǎn měitiān wǎnshang jiǔ diǎn bàn zhǔnshí guānbì yuèlǎnshì dàmén, qǐng dúzhě tíqián shōushi hǎo gèrén wùpǐn.',
      'Thư viện mỗi tối chín giờ rưỡi đều đóng cửa phòng đọc đúng giờ, xin mời quý độc giả dọn dẹp trước đồ đạc cá nhân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '图书馆每天晚上九点半准时关闭阅览室大门，请读者提前收拾好个人物品。', 'Túshūguǎn měitiān wǎnshang jiǔ diǎn bàn zhǔnshí guānbì yuèlǎnshì dàmén, qǐng dúzhě tíqián shōushi hǎo gèrén wùpǐn.', 'Thư viện mỗi tối chín giờ rưỡi đều đóng cửa phòng đọc đúng giờ, xin mời quý độc giả dọn dẹp trước đồ đạc cá nhân.', 'basic', 1),
      (v_id, '为坚定践行国家碳达峰与碳中和绿色转型战略，能源重化工基地依法关停并永久关闭了数十座能耗超标且环保不达标的落后燃煤小机组。', 'Wèi jiāndìng jiànxíng guójiā tàndáfēng yǔ tànzhōnghé lǜsè zhuǎnxíng zhànlüè, néngyuán zhònghuàgōng jīdì yīfǎ guāntíng bìng yǒngjiǔ guānbì le shù shí zuò nénghào chāobiāo qiě huánbǎo bù dābiāo de luòhòu ránméi xiǎojīzǔ.', 'Nhằm kiên định thực thi chiến lược chuyển đổi xanh đạt đỉnh phát thải và trung hòa carbon của quốc gia, căn cứ hóa chất nặng năng lượng đã đình chỉ và đóng cửa vĩnh viễn hàng chục tổ máy đốt than lạc hậu cỡ nhỏ vượt mức tiêu hao năng lượng và không đạt tiêu chuẩn bảo vệ môi trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2432] [观察] (guānchá) - quan sát, theo dõi [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '观察' AND pinyin = 'guānchá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '观察' AND pinyin = 'guānchá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '观察'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '观察'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'guānchá',
      meaning_vi = 'quan sát, theo dõi',
      example_hanzi = '生物课上，同学们透过光学显微镜聚精会神地观察洋葱表皮细胞的结构。',
      example_pinyin = 'Shēngwùkè shang, tóngxué men tòuguò guāngxué xiǎnwéijìng jùjīng-huìshén de guānchá yángcōng biǎopí xìbāo de jiégòu.',
      example_vi = 'Trong giờ sinh học, các bạn học sinh chăm chú quan sát cấu trúc tế bào biểu bì củ hành tây qua kính hiển vi quang học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '观察',
      'guānchá',
      'quan sát, theo dõi',
      'Động từ / Danh từ',
      'HSK 5',
      '生物课上，同学们透过光学显微镜聚精会神地观察洋葱表皮细胞的结构。',
      'Shēngwùkè shang, tóngxué men tòuguò guāngxué xiǎnwéijìng jùjīng-huìshén de guānchá yángcōng biǎopí xìbāo de jiégòu.',
      'Trong giờ sinh học, các bạn học sinh chăm chú quan sát cấu trúc tế bào biểu bì củ hành tây qua kính hiển vi quang học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '生物课上，同学们透过光学显微镜聚精会神地观察洋葱表皮细胞的结构。', 'Shēngwùkè shang, tóngxué men tòuguò guāngxué xiǎnwéijìng jùjīng-huìshén de guānchá yángcōng biǎopí xìbāo de jiégòu.', 'Trong giờ sinh học, các bạn học sinh chăm chú quan sát cấu trúc tế bào biểu bì củ hành tây qua kính hiển vi quang học.', 'basic', 1),
      (v_id, '野生动物保护科考队在青藏高原高寒无人区扎营数月，利用超高清红外触发相机全天候严密观察国家一级保护动物雪豹的迁徙与繁育习性。', 'Yěshēng dòngwù bǎohù kēkǎoduì zài Qīng-Zàng Gāoyuán gāohán wúrénqū zhāyíng shù yuè, lìyòng chāogāoqīng hóngwài chùfā xiàngjī quántiānhòu yánmì guānchá guójiā yījí bǎohù dòngwù xuěbào de qiānxǐ yǔ fányù xíxìng.', 'Đội khảo sát bảo tồn động vật hoang dã đã cắm trại nhiều tháng ở vùng không người rét buốt trên cao nguyên Thanh Tạng, sử dụng bẫy ảnh hồng ngoại siêu nét để quan sát chặt chẽ tập tính di cư và sinh sản của báo tuyết - loài động vật bảo vệ cấp một quốc gia suốt ngày đêm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2433] [观点] (guāndiǎn) - quan điểm, góc nhìn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '观点' AND pinyin = 'guāndiǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '观点' AND pinyin = 'guāndiǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '观点'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '观点'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guāndiǎn',
      meaning_vi = 'quan điểm, góc nhìn',
      example_hanzi = '在学术小组讨论中，每个人都可以自由阐述自己对这个社会热点现象的独特观点。',
      example_pinyin = 'Zài xuéshù xiǎozǔ tǎolùn zhōng, měi gè rén dōu kěyǐ zìyóu chǎnshù zìjǐ duì zhè gè shèhuì rèdiǎn xiànxiàng de dútè guāndiǎn.',
      example_vi = 'Trong buổi thảo luận nhóm học thuật, mỗi người đều có thể tự do trình bày quan điểm độc đáo của riêng mình về hiện tượng nóng trong xã hội này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '观点',
      'guāndiǎn',
      'quan điểm, góc nhìn',
      'Danh từ',
      'HSK 5',
      '在学术小组讨论中，每个人都可以自由阐述自己对这个社会热点现象的独特观点。',
      'Zài xuéshù xiǎozǔ tǎolùn zhōng, měi gè rén dōu kěyǐ zìyóu chǎnshù zìjǐ duì zhè gè shèhuì rèdiǎn xiànxiàng de dútè guāndiǎn.',
      'Trong buổi thảo luận nhóm học thuật, mỗi người đều có thể tự do trình bày quan điểm độc đáo của riêng mình về hiện tượng nóng trong xã hội này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在学术小组讨论中，每个人都可以自由阐述自己对这个社会热点现象的独特观点。', 'Zài xuéshù xiǎozǔ tǎolùn zhōng, měi gè rén dōu kěyǐ zìyóu chǎnshù zìjǐ duì zhè gè shèhuì rèdiǎn xiànxiàng de dútè guāndiǎn.', 'Trong buổi thảo luận nhóm học thuật, mỗi người đều có thể tự do trình bày quan điểm độc đáo của riêng mình về hiện tượng nóng trong xã hội này.', 'basic', 1),
      (v_id, '著名经济学家在国际金融论坛上发表主题演讲，提出应当以长期动态的全球平衡发展观点来看待发展中国家汇率制度改革的渐进性与必要性。', 'Zhùmíng jīngjì xuéjiā zài guójì jīnróng lùntán shang fābiǎo zhǔtí yǎnjiǎng, tíchū yīngdāng yǐ chángqī dòngtài de quánqiú pínghéng fāzhǎn guāndiǎn lái kàndài fāzhǎnzhōng guójiā huìlǜ zhìdù gǎigé de jiànjìnxìng yǔ bìyàoxìng.', 'Nhà kinh tế học nổi tiếng phát biểu bài diễn văn chủ đề tại diễn đàn tài chính quốc tế, đề xuất cần nhìn nhận tính tiệm tiến và sự tất yếu của cải cách chế độ tỷ giá hối đoái ở các nước đang phát triển dưới quan điểm phát triển cân bằng toàn cầu mang tính động dài hạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2434] [观念] (guānniàn) - quan niệm, tư tưởng, ý thức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '观念' AND pinyin = 'guānniàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '观念' AND pinyin = 'guānniàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '观念'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '观念'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guānniàn',
      meaning_vi = 'quan niệm, tư tưởng, ý thức',
      example_hanzi = '随着现代文明的普及，男尊女卑等陈旧落后的传统观念已经逐渐被现代社会所摒弃。',
      example_pinyin = 'Suízhe xiàndài wénmíng de pǔjí, nánzūn-nǚbēi děng chénjiù luòhòu de chuántǒng guānniàn yǐjīng zhújiàn bèi xiàndài shèhuì suǒ bǐngqì.',
      example_vi = 'Cùng với sự phổ biến của văn minh hiện đại, các quan niệm truyền thống cũ kỹ lạc hậu như trọng nam khinh nữ đã dần dần bị xã hội ngày nay từ bỏ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '观念',
      'guānniàn',
      'quan niệm, tư tưởng, ý thức',
      'Danh từ',
      'HSK 5',
      '随着现代文明的普及，男尊女卑等陈旧落后的传统观念已经逐渐被现代社会所摒弃。',
      'Suízhe xiàndài wénmíng de pǔjí, nánzūn-nǚbēi děng chénjiù luòhòu de chuántǒng guānniàn yǐjīng zhújiàn bèi xiàndài shèhuì suǒ bǐngqì.',
      'Cùng với sự phổ biến của văn minh hiện đại, các quan niệm truyền thống cũ kỹ lạc hậu như trọng nam khinh nữ đã dần dần bị xã hội ngày nay từ bỏ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着现代文明的普及，男尊女卑等陈旧落后的传统观念已经逐渐被现代社会所摒弃。', 'Suízhe xiàndài wénmíng de pǔjí, nánzūn-nǚbēi děng chénjiù luòhòu de chuántǒng guānniàn yǐjīng zhújiàn bèi xiàndài shèhuì suǒ bǐngqì.', 'Cùng với sự phổ biến của văn minh hiện đại, các quan niệm truyền thống cũ kỹ lạc hậu như trọng nam khinh nữ đã dần dần bị xã hội ngày nay từ bỏ.', 'basic', 1),
      (v_id, '推动绿色低碳转型不仅需要产业结构的深度调整，更需要全社会树立起尊重自然、顺应自然、人与自然和谐共生的新型生态文明价值观念。', 'Tuīdòng lǜsè dītàn zhuǎnxíng bùjǐn xūyào chǎnyè jiégòu de shēndù tiáozhěng, gèng xūyào quán shèhuì shùlì qǐ zūnzhòng zìrán, shùnyìng zìrán, rén yǔ zìrán héxié gòngshēng de xīnxíng shēngtài wénmíng jiàzhí guānniàn.', 'Thúc đẩy chuyển đổi xanh phát thải thấp không chỉ đòi hỏi sự điều chỉnh sâu sắc về cơ cấu ngành nghề, mà càng cần toàn xã hội xác lập hệ giá trị quan niệm văn minh sinh thái kiểu mới biết tôn trọng tự nhiên, thuận theo tự nhiên và con người sống cộng sinh hài hòa với thiên nhiên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2435] [冠军] (guànjūn) - quán quân, chức vô địch, nhà vô địch [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '冠军' AND pinyin = 'guànjūn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '冠军' AND pinyin = 'guànjūn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '冠军'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '冠军'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guànjūn',
      meaning_vi = 'quán quân, chức vô địch, nhà vô địch',
      example_hanzi = '中国国家女子排球队凭借顽强拼搏的精神，再次夺得了世界锦标赛的冠军奖杯。',
      example_pinyin = 'Zhōngguó guójiā nǚzǐ páiqiúduì píngjiè wánqiáng pīnbó de jīngshén, zàicì duódé le shìjiè jǐnbiāosài de guànjūn jiǎngbēi.',
      example_vi = 'Đội tuyển bóng chuyền nữ quốc gia Trung Quốc dựa vào tinh thần chiến đấu kiên cường bất khuất, đã một lần nữa đoạt được cúp vô địch của giải vô địch thế giới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '冠军',
      'guànjūn',
      'quán quân, chức vô địch, nhà vô địch',
      'Danh từ',
      'HSK 5',
      '中国国家女子排球队凭借顽强拼搏的精神，再次夺得了世界锦标赛的冠军奖杯。',
      'Zhōngguó guójiā nǚzǐ páiqiúduì píngjiè wánqiáng pīnbó de jīngshén, zàicì duódé le shìjiè jǐnbiāosài de guànjūn jiǎngbēi.',
      'Đội tuyển bóng chuyền nữ quốc gia Trung Quốc dựa vào tinh thần chiến đấu kiên cường bất khuất, đã một lần nữa đoạt được cúp vô địch của giải vô địch thế giới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中国国家女子排球队凭借顽强拼搏的精神，再次夺得了世界锦标赛的冠军奖杯。', 'Zhōngguó guójiā nǚzǐ páiqiúduì píngjiè wánqiáng pīnbó de jīngshén, zàicì duódé le shìjiè jǐnbiāosài de guànjūn jiǎngbēi.', 'Đội tuyển bóng chuyền nữ quốc gia Trung Quốc dựa vào tinh thần chiến đấu kiên cường bất khuất, đã một lần nữa đoạt được cúp vô địch của giải vô địch thế giới.', 'basic', 1),
      (v_id, '这位年仅十八岁的年轻小将顶住了决胜局落后的巨大心理压力，凭借最后一跳几近完美的超高难度动作逆风翻盘，加冕奥运会跳水单人项目金牌冠军。', 'Zhè wèi nián jǐn shíbā suì de niánqīng xiǎojiàng dǐngzhù le juéshèngjú luòhòu de jùdà xīnlǐ yālì, píngjiè zuìhòu yí tiào jǐjìn wánměi de chāogāo nándù dòngzuò nìfēng fānpán, jiāmiǎn Àoyùnhuì tiàoshuǐ dānrén xiàngmù jīnpái guànjūn.', 'Vận động viên trẻ mới tròn mười tám tuổi này đã chịu đựng áp lực tâm lý khổng lồ khi bị dẫn trước ở hiệp quyết định, nhờ động tác độ khó siêu cao gần như hoàn mỹ ở cú nhảy cuối cùng đã lội ngược dòng ngoạn mục, đăng quang ngôi vị quán quân huy chương vàng nội dung nhảy cầu đơn tại Thế vận hội.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2436] [光临] (guānglín) - quang lâm, ghé thăm, tới dự (lời nói lịch sự) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '光临' AND pinyin = 'guānglín'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '光临' AND pinyin = 'guānglín'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '光临'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '光临'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'guānglín',
      meaning_vi = 'quang lâm, ghé thăm, tới dự (lời nói lịch sự)',
      example_hanzi = '欢迎各位贵宾光临本届国际书画艺术博览会，祝大家观展愉快！',
      example_pinyin = 'Huānyíng gèwèi guìbīn guānglín běnjiè guójì shūhuà yìshù bólǎnhuì, zhù dàjiā guānzhǎn yúkuài!',
      example_vi = 'Chào mừng quý quan khách quang lâm hội chợ triển lãm nghệ thuật thư họa quốc tế lần này, chúc mọi người thưởng lãm vui vẻ!'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '光临',
      'guānglín',
      'quang lâm, ghé thăm, tới dự (lời nói lịch sự)',
      'Động từ',
      'HSK 5',
      '欢迎各位贵宾光临本届国际书画艺术博览会，祝大家观展愉快！',
      'Huānyíng gèwèi guìbīn guānglín běnjiè guójì shūhuà yìshù bólǎnhuì, zhù dàjiā guānzhǎn yúkuài!',
      'Chào mừng quý quan khách quang lâm hội chợ triển lãm nghệ thuật thư họa quốc tế lần này, chúc mọi người thưởng lãm vui vẻ!'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '欢迎各位贵宾光临本届国际书画艺术博览会，祝大家观展愉快！', 'Huānyíng gèwèi guìbīn guānglín běnjiè guójì shūhuà yìshù bólǎnhuì, zhù dàjiā guānzhǎn yúkuài!', 'Chào mừng quý quan khách quang lâm hội chợ triển lãm nghệ thuật thư họa quốc tế lần này, chúc mọi người thưởng lãm vui vẻ!', 'basic', 1),
      (v_id, '在百年校庆庆祝盛典上，大学校长代表全校师生发表了热情洋溢的致辞，对海内外校友与各界政商学界领袖的莅临光临表示由衷的崇高敬意。', 'Zài bǎinián xiàoqìng qìngzhù shèngdiǎn shang, dàxué xiàozhǎng dàibiǎo quánxiào shīshēng fābiǎo le rèqíng yángyì de zhìcí, duì hǎinèiwài xiàoyǒu yǔ gèjiè zhèng-shāng-xuéjiè lǐngxiù de lìlín guānglín biǎoshì yóuzhōng de chónggāo jìngyì.', 'Tại đại lễ kỷ niệm một trăm năm ngày thành lập trường, hiệu trưởng trường đại học đã thay mặt toàn thể thầy trò đọc bài diễn văn nồng nhiệt, bày tỏ lòng kính trọng sâu sắc tới sự quang lâm hiện diện của các cựu sinh viên trong và ngoài nước cùng các nhà lãnh đạo chính trị, kinh doanh và học thuật các giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2437] [光明] (guāngmíng) - quang minh, tươi sáng, xán lạn, ánh sáng [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '光明' AND pinyin = 'guāngmíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '光明' AND pinyin = 'guāngmíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '光明'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '光明'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'guāngmíng',
      meaning_vi = 'quang minh, tươi sáng, xán lạn, ánh sáng',
      example_hanzi = '只要心中怀揣着对美好生活的坚定信念，前方的道路就一定充满了希望与光明。',
      example_pinyin = 'Zhǐyào xīnzhōng huáichuǎizhe duì měihǎo shēnghuó de jiāndìng xìnniàn, qiánfāng de dàolù jiù yídìng chōngmǎn le xīwàng yǔ guāngmíng.',
      example_vi = 'Chỉ cần trong lòng ôm ấp niềm tin kiên định vào cuộc sống tốt đẹp, thì con đường phía trước nhất định sẽ tràn đầy hy vọng và ánh sáng tươi đẹp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '光明',
      'guāngmíng',
      'quang minh, tươi sáng, xán lạn, ánh sáng',
      'Tính từ / Danh từ',
      'HSK 5',
      '只要心中怀揣着对美好生活的坚定信念，前方的道路就一定充满了希望与光明。',
      'Zhǐyào xīnzhōng huáichuǎizhe duì měihǎo shēnghuó de jiāndìng xìnniàn, qiánfāng de dàolù jiù yídìng chōngmǎn le xīwàng yǔ guāngmíng.',
      'Chỉ cần trong lòng ôm ấp niềm tin kiên định vào cuộc sống tốt đẹp, thì con đường phía trước nhất định sẽ tràn đầy hy vọng và ánh sáng tươi đẹp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只要心中怀揣着对美好生活的坚定信念，前方的道路就一定充满了希望与光明。', 'Zhǐyào xīnzhōng huáichuǎizhe duì měihǎo shēnghuó de jiāndìng xìnniàn, qiánfāng de dàolù jiù yídìng chōngmǎn le xīwàng yǔ guāngmíng.', 'Chỉ cần trong lòng ôm ấp niềm tin kiên định vào cuộc sống tốt đẹp, thì con đường phía trước nhất định sẽ tràn đầy hy vọng và ánh sáng tươi đẹp.', 'basic', 1),
      (v_id, '作为国家公职人员与司法工作人员，做人做事必须光明磊落、大公无私，自觉抵制形形色色的利益诱惑与潜规则干扰。', 'Zuòwéi guójiā gōngzhí rényuán yǔ sīfǎ gōngzuò rényuán, zuòrén zuòshì bìxū guāngmíng-lěiluò, dàgōng-wúsī, zìjué dǐzhì xíngxíng-sèsè de lìyì yòuhuò yǔ qiánguīzé gānrǎo.', 'Là công chức nhà nước và nhân viên công tác tư pháp, làm người làm việc nhất định phải quang minh lỗi lạc, chí công vô tư, tự giác bài trừ mọi cám dỗ lợi ích muôn hình vạn trạng và sự can thiệp của luật ngầm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2438] [光线] (guāngxiàn) - ánh sáng, tia sáng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '光线' AND pinyin = 'guāngxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '光线' AND pinyin = 'guāngxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '光线'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '光线'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guāngxiàn',
      meaning_vi = 'ánh sáng, tia sáng',
      example_hanzi = '看书写字时室内的光线不能太暗也不能太强，以免引起眼睛过度疲劳。',
      example_pinyin = 'Kànshū xiězì shí shìnèi de guāngxiàn bù néng tài àn yě bù néng tài qiáng, yǐmiǎn yǐnqǐ yǎnjing guòdù píláo.',
      example_vi = 'Khi đọc sách viết chữ ánh sáng trong phòng không thể quá tối cũng không thể quá gắt, để tránh gây mỏi mắt quá mức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '光线',
      'guāngxiàn',
      'ánh sáng, tia sáng',
      'Danh từ',
      'HSK 5',
      '看书写字时室内的光线不能太暗也不能太强，以免引起眼睛过度疲劳。',
      'Kànshū xiězì shí shìnèi de guāngxiàn bù néng tài àn yě bù néng tài qiáng, yǐmiǎn yǐnqǐ yǎnjing guòdù píláo.',
      'Khi đọc sách viết chữ ánh sáng trong phòng không thể quá tối cũng không thể quá gắt, để tránh gây mỏi mắt quá mức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '看书写字时室内的光线不能太暗也不能太强，以免引起眼睛过度疲劳。', 'Kànshū xiězì shí shìnèi de guāngxiàn bù néng tài àn yě bù néng tài qiáng, yǐmiǎn yǐnqǐ yǎnjing guòdù píláo.', 'Khi đọc sách viết chữ ánh sáng trong phòng không thể quá tối cũng không thể quá gắt, để tránh gây mỏi mắt quá mức.', 'basic', 1),
      (v_id, '专业摄影师在拍摄人文风光大片时，十分擅长捕捉黎明与黄昏黄金时刻柔和漫射的自然光线，以营造出层次丰富且富有诗意的光影画面。', 'Zhuānyè shèyǐngshī zài pāishè rénwén fēngguāng dàpiàn shí, shífēn shàncháng bǔzhuō límíng yǔ huánghūn huángjīn shíkè róuhé mànshè de zìrán guāngxiàn, yǐ yíngzào chū céngcì fēngfù qiě fùyǒu shīyì de guāngyǐng huàmiàn.', 'Các nhiếp ảnh gia chuyên nghiệp khi chụp các thước phim phong cảnh nhân văn, rất giỏi bắt trọn thứ ánh sáng tự nhiên khuếch tán dịu nhẹ vào khoảnh khắc vàng lúc bình minh và hoàng hôn, nhằm tạo nên khung hình quang cảnh giàu tầng bậc và đậm chất thơ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2439] [广] (guǎng) - rộng, rộng lớn; mở rộng [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '广' AND pinyin = 'guǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '广' AND pinyin = 'guǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '广'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '广'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'guǎng',
      meaning_vi = 'rộng, rộng lớn; mở rộng',
      example_hanzi = '他在大学期间涉猎广泛，兴趣爱好非常广，结识了许多志同道合的好朋友。',
      example_pinyin = 'Tā zài dàxué qījiān shèliè guǎngfàn, xìngqù àihào fēicháng guǎng, jiéshí le xǔduō zhìtóng-dàohé de hǎo péngyou.',
      example_vi = 'Thời đại học anh ấy tìm hiểu rất rộng rãi, sở thích vô cùng phong phú, làm quen được nhiều bạn tốt cùng chung chí hướng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '广',
      'guǎng',
      'rộng, rộng lớn; mở rộng',
      'Tính từ / Động từ',
      'HSK 5',
      '他在大学期间涉猎广泛，兴趣爱好非常广，结识了许多志同道合的好朋友。',
      'Tā zài dàxué qījiān shèliè guǎngfàn, xìngqù àihào fēicháng guǎng, jiéshí le xǔduō zhìtóng-dàohé de hǎo péngyou.',
      'Thời đại học anh ấy tìm hiểu rất rộng rãi, sở thích vô cùng phong phú, làm quen được nhiều bạn tốt cùng chung chí hướng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在大学期间涉猎广泛，兴趣爱好非常广，结识了许多志同道合的好朋友。', 'Tā zài dàxué qījiān shèliè guǎngfàn, xìngqù àihào fēicháng guǎng, jiéshí le xǔduō zhìtóng-dàohé de hǎo péngyou.', 'Thời đại học anh ấy tìm hiểu rất rộng rãi, sở thích vô cùng phong phú, làm quen được nhiều bạn tốt cùng chung chí hướng.', 'basic', 1),
      (v_id, '企业不仅要深耕国内核心市场，更应广开海外经贸合作渠道，以开放包容的胸襟广纳天下英才，提升跨国全球化经营格局。', 'Qǐyè bùjǐn yào shēngēng guónèi héxīn shìchǎng, gèng yīng guǎng kāi hǎiwài jīngmào hézuò qúdào, yǐ kāifàng bāoróng de xiōngjīn guǎng nà tiānxià yīngcái, tíshēng kuàguó quánqiúhuà jīngyíng gégú.', 'Doanh nghiệp không chỉ cần bám rễ sâu ở thị trường cốt lõi trong nước, mà càng cần phải mở rộng kênh hợp tác kinh tế thương mại hải ngoại, lấy tấm lòng cởi mở bao dung thu nạp rộng khắp hiền tài thiên hạ, nâng cao tầm vóc kinh doanh toàn cầu hóa xuyên quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2440] [广场] (guǎngchǎng) - quảng trường [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '广场' AND pinyin = 'guǎngchǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '广场' AND pinyin = 'guǎngchǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '广场'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '广场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guǎngchǎng',
      meaning_vi = 'quảng trường',
      example_hanzi = '每天傍晚，许多市民都会来到社区中心的文化广场散步健身、跳广场舞。',
      example_pinyin = 'Měitiān bàngwǎn, xǔduō shìmín dōu huì láidào shèqū zhōngxīn de wénhuà guǎngchǎng sànbù jiànshēn, tiào guǎngchǎngwǔ.',
      example_vi = 'Mỗi buổi chiều tà, nhiều người dân thành phố đều sẽ tới quảng trường văn hóa ở trung tâm cộng đồng để đi dạo rèn luyện sức khỏe và nhảy khiêu vũ quảng trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '广场',
      'guǎngchǎng',
      'quảng trường',
      'Danh từ',
      'HSK 5',
      '每天傍晚，许多市民都会来到社区中心的文化广场散步健身、跳广场舞。',
      'Měitiān bàngwǎn, xǔduō shìmín dōu huì láidào shèqū zhōngxīn de wénhuà guǎngchǎng sànbù jiànshēn, tiào guǎngchǎngwǔ.',
      'Mỗi buổi chiều tà, nhiều người dân thành phố đều sẽ tới quảng trường văn hóa ở trung tâm cộng đồng để đi dạo rèn luyện sức khỏe và nhảy khiêu vũ quảng trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天傍晚，许多市民都会来到社区中心的文化广场散步健身、跳广场舞。', 'Měitiān bàngwǎn, xǔduō shìmín dōu huì láidào shèqū zhōngxīn de wénhuà guǎngchǎng sànbù jiànshēn, tiào guǎngchǎngwǔ.', 'Mỗi buổi chiều tà, nhiều người dân thành phố đều sẽ tới quảng trường văn hóa ở trung tâm cộng đồng để đi dạo rèn luyện sức khỏe và nhảy khiêu vũ quảng trường.', 'basic', 1),
      (v_id, '天安门广场作为举行国家重大外事迎宾与阅兵庆典的庄严政治地标，见证了中华民族从百废待兴走向伟大复兴的光辉历程。', 'Tiān’ānmén Guǎngchǎng zuòwéi jǔxíng guójiā zhòngdà wàishì yíngbīn yǔ yuèbīng qìngdiǎn de zhuāngyán zhèngzhì dìbiāo, jiànzhèng le Zhōnghuá mínzú cóng bǎifèi-dàixīng zǒuxiàng wěidà fùxīng de guānghuī lìchéng.', 'Quảng trường Thiên An Môn với tư cách là biểu tượng chính trị trang nghiêm tổ chức các đại lễ duyệt binh và đón tiếp ngoại giao trọng đại của quốc gia, đã chứng kiến chặng đường vinh quang của dân tộc Trung Hoa từ hoang tàn đổ nát bước tới phục hưng vĩ đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2441] [广大] (guǎngdà) - rộng lớn, đông đảo (quần chúng, nhân dân) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '广大' AND pinyin = 'guǎngdà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '广大' AND pinyin = 'guǎngdà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '广大'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '广大'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'guǎngdà',
      meaning_vi = 'rộng lớn, đông đảo (quần chúng, nhân dân)',
      example_hanzi = '这项教育普惠政策的顺利推行，受到了广大乡村师生与学生家长的一致欢迎。',
      example_pinyin = 'Zhè xiàng jiàoyù pǔhuì zhèngcè de shùnlì tuīxíng, shòudào le guǎngdà xiāngcūn shīshēng yǔ xuésheng jiāzhǎng de yízhì huānyíng.',
      example_vi = 'Việc triển khai thuận lợi chính sách giáo dục phổ cập này đã nhận được sự hoan nghênh nhất trí của đông đảo thầy trò vùng nông thôn cùng các bậc phụ huynh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '广大',
      'guǎngdà',
      'rộng lớn, đông đảo (quần chúng, nhân dân)',
      'Tính từ',
      'HSK 5',
      '这项教育普惠政策的顺利推行，受到了广大乡村师生与学生家长的一致欢迎。',
      'Zhè xiàng jiàoyù pǔhuì zhèngcè de shùnlì tuīxíng, shòudào le guǎngdà xiāngcūn shīshēng yǔ xuésheng jiāzhǎng de yízhì huānyíng.',
      'Việc triển khai thuận lợi chính sách giáo dục phổ cập này đã nhận được sự hoan nghênh nhất trí của đông đảo thầy trò vùng nông thôn cùng các bậc phụ huynh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这项教育普惠政策的顺利推行，受到了广大乡村师生与学生家长的一致欢迎。', 'Zhè xiàng jiàoyù pǔhuì zhèngcè de shùnlì tuīxíng, shòudào le guǎngdà xiāngcūn shīshēng yǔ xuésheng jiāzhǎng de yízhì huānyíng.', 'Việc triển khai thuận lợi chính sách giáo dục phổ cập này đã nhận được sự hoan nghênh nhất trí của đông đảo thầy trò vùng nông thôn cùng các bậc phụ huynh.', 'basic', 1),
      (v_id, '政策制定者必须深入工厂车间和田间地头倾听广大基层劳动群众的急难愁盼，切实保障广大工农阶层的合法劳动报酬与社会保障权益。', 'Zhèngcè zhìdìngzhě bìxū shēnrù gōngchǎng chējiān hé tiánjiān-dìtóu qīngtīng guǎngdà jīcéng láodòng qúnzhòng de jínán-chóupàn, qièshí bǎozhàng guǎngdà gōng-nóng jiēcéng de héfǎ láodòng bàochou yǔ shèhuì bǎozhàng quányì.', 'Những người hoạch định chính sách nhất định phải đi sâu vào các phân xưởng nhà máy và ruộng đồng bờ bãi để lắng nghe những âu lo bức thiết của đông đảo quần chúng lao động cơ sở, bảo đảm thiết thực quyền lợi thù lao lao động hợp pháp và an sinh xã hội của đông đảo giai cấp công nông.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2442] [广泛] (guǎngfàn) - rộng rãi, phổ biến, bao quát nhiều mặt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '广泛' AND pinyin = 'guǎngfàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '广泛' AND pinyin = 'guǎngfàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '广泛'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '广泛'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'guǎngfàn',
      meaning_vi = 'rộng rãi, phổ biến, bao quát nhiều mặt',
      example_hanzi = '这种性能稳定且价格低廉的新材料，目前已经在包装与建筑领域得到了广泛的应用。',
      example_pinyin = 'Zhè zhǒng xìngnéng wěndìng qiě jiàgé dīlián de xīn cáiliào, mùqián yǐjīng zài bāozhuāng yǔ jiànzhù lǐngyù dédào le guǎngfàn de yìngyòng.',
      example_vi = 'Loại vật liệu mới có tính năng ổn định và giá thành rẻ này hiện đã được ứng dụng rộng rãi trong các lĩnh vực đóng gói và xây dựng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '广泛',
      'guǎngfàn',
      'rộng rãi, phổ biến, bao quát nhiều mặt',
      'Tính từ',
      'HSK 5',
      '这种性能稳定且价格低廉的新材料，目前已经在包装与建筑领域得到了广泛的应用。',
      'Zhè zhǒng xìngnéng wěndìng qiě jiàgé dīlián de xīn cáiliào, mùqián yǐjīng zài bāozhuāng yǔ jiànzhù lǐngyù dédào le guǎngfàn de yìngyòng.',
      'Loại vật liệu mới có tính năng ổn định và giá thành rẻ này hiện đã được ứng dụng rộng rãi trong các lĩnh vực đóng gói và xây dựng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这种性能稳定且价格低廉的新材料，目前已经在包装与建筑领域得到了广泛的应用。', 'Zhè zhǒng xìngnéng wěndìng qiě jiàgé dīlián de xīn cáiliào, mùqián yǐjīng zài bāozhuāng yǔ jiànzhù lǐngyù dédào le guǎngfàn de yìngyòng.', 'Loại vật liệu mới có tính năng ổn định và giá thành rẻ này hiện đã được ứng dụng rộng rãi trong các lĩnh vực đóng gói và xây dựng.', 'basic', 1),
      (v_id, '全国人大在制定重大民生法律草案过程中，通过网络平台公开征求社会各界广泛意见，汇聚各方智慧，使立法更加符合最广大人民群众的根本福祉。', 'Quánguó Réndà zài zhìdìng zhòngdà mínshēng fǎlǜ cǎo’àn guòchéng zhōng, tōngguò wǎngluò píngtái gōngkāi zhēngqiú shèhuì gèjiè guǎngfàn yìjiàn, huìjù gèfāng zhìhuì, shǐ lìfǎ gèngjiā fúhé zuì guǎngdà rénmín qúnzhòng de gēnběn fúzhǐ.', 'Nhân đại toàn quốc trong quá trình soạn thảo dự thảo luật dân sinh trọng đại, đã công khai lấy ý kiến rộng rãi của các giới trong xã hội qua nền tảng mạng, tập hợp trí tuệ muôn phương, làm cho việc lập pháp càng thêm phù hợp với phúc lợi căn bản của đông đảo quần chúng nhân dân nhất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2443] [规律] (guīlǜ) - quy luật [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '规律' AND pinyin = 'guīlǜ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '规律' AND pinyin = 'guīlǜ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '规律'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '规律'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guīlǜ',
      meaning_vi = 'quy luật',
      example_hanzi = '一年四季春夏秋冬的交替更迭，是自然界永恒不变的基本运行规律。',
      example_pinyin = 'Yì nián sìjì chūn-xià-qiū-dōng de jiāotì gēngdié, shì zìránjiè yǒnghéng-búbiàn de jīběn yùnxíng guīlǜ.',
      example_vi = 'Sự luân chuyển thay đổi bốn mùa xuân hạ thu đông trong một năm là quy luật vận hành cơ bản vĩnh hằng không đổi của giới tự nhiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '规律',
      'guīlǜ',
      'quy luật',
      'Danh từ',
      'HSK 5',
      '一年四季春夏秋冬的交替更迭，是自然界永恒不变的基本运行规律。',
      'Yì nián sìjì chūn-xià-qiū-dōng de jiāotì gēngdié, shì zìránjiè yǒnghéng-búbiàn de jīběn yùnxíng guīlǜ.',
      'Sự luân chuyển thay đổi bốn mùa xuân hạ thu đông trong một năm là quy luật vận hành cơ bản vĩnh hằng không đổi của giới tự nhiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '一年四季春夏秋冬的交替更迭，是自然界永恒不变的基本运行规律。', 'Yì nián sìjì chūn-xià-qiū-dōng de jiāotì gēngdié, shì zìránjiè yǒnghéng-búbiàn de jīběn yùnxíng guīlǜ.', 'Sự luân chuyển thay đổi bốn mùa xuân hạ thu đông trong một năm là quy luật vận hành cơ bản vĩnh hằng không đổi của giới tự nhiên.', 'basic', 1),
      (v_id, '宏观经济政策调控必须深刻把握市场经济与产业周期的客观规律，科学预见潜在外部冲击，防范大水漫灌导致的产能过剩与债务杠杆攀升。', 'Hóngguān jīngjì zhèngcè tiáokòng bìxū shēnkè bǎwò shìchǎng jīngjì yǔ chǎnyè zhōuqī de kèguān guīlǜ, kēxué yùjiàn qiánzài wàibù chōngjī, fángfàn dàshuǐ-mànguàn dǎozhì de chǎnnéng guòshèng yǔ zhàiwù gànggǎn pānshēng.', 'Điều tiết chính sách kinh tế vĩ mô nhất định phải nắm bắt sâu sắc quy luật khách quan của nền kinh tế thị trường và chu kỳ ngành nghề, dự báo khoa học những cú sốc bên ngoài tiềm ẩn, phòng ngừa tình trạng dư thừa công suất và đòn bẩy nợ leo thang do bơm tiền ồ ạt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2444] [规模] (guīmó) - quy mô [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '规模' AND pinyin = 'guīmó'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '规模' AND pinyin = 'guīmó'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '规模'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '规模'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guīmó',
      meaning_vi = 'quy mô',
      example_hanzi = '随着业务订单的持续快速增长，这家外贸公司的员工规模已经扩大到了五百余人。',
      example_pinyin = 'Suízhe yèwù dìngdān de chíxù kuàisù zēngzhǎng, zhè jiā wàimào gōngsī de yuángōng guīmó yǐjīng kuòdà dào le wǔ bǎi yú rén.',
      example_vi = 'Cùng với sự gia tăng liên tục nhanh chóng của các đơn hàng nghiệp vụ, quy mô nhân viên của công ty ngoại thương này đã mở rộng lên hơn năm trăm người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '规模',
      'guīmó',
      'quy mô',
      'Danh từ',
      'HSK 5',
      '随着业务订单的持续快速增长，这家外贸公司的员工规模已经扩大到了五百余人。',
      'Suízhe yèwù dìngdān de chíxù kuàisù zēngzhǎng, zhè jiā wàimào gōngsī de yuángōng guīmó yǐjīng kuòdà dào le wǔ bǎi yú rén.',
      'Cùng với sự gia tăng liên tục nhanh chóng của các đơn hàng nghiệp vụ, quy mô nhân viên của công ty ngoại thương này đã mở rộng lên hơn năm trăm người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着业务订单的持续快速增长，这家外贸公司的员工规模已经扩大到了五百余人。', 'Suízhe yèwù dìngdān de chíxù kuàisù zēngzhǎng, zhè jiā wàimào gōngsī de yuángōng guīmó yǐjīng kuòdà dào le wǔ bǎi yú rén.', 'Cùng với sự gia tăng liên tục nhanh chóng của các đơn hàng nghiệp vụ, quy mô nhân viên của công ty ngoại thương này đã mở rộng lên hơn năm trăm người.', 'basic', 1),
      (v_id, '我国已建成全球规模最大、技术领先的5G移动通信与千兆光纤宽带基础设施网络，为赋能千行百业数字化高质量发展奠定了坚实的数字底座。', 'Wǒguó yǐ jiànchéng quánqiú guīmó zuì dà, jìshù lǐngxiān de 5G yídòng tōngxìn yǔ qiānzhào guāngxiān kuāndài jīchǔ shèshī wǎngluò, wèi fùnéng qiān háng bǎi yè shùzìhuà gāo zhìliàng fāzhǎn diàndìng le jiānshí de shùzì dǐzuò.', 'Nước ta đã xây dựng xong mạng lưới cơ sở hạ tầng thông tin di động 5G và băng thông rộng cáp quang gigabit có quy mô lớn nhất và công nghệ dẫn đầu toàn cầu, đặt nền móng số vững chắc để tiếp thêm sức mạnh chuyển đổi số chất lượng cao cho hàng nghìn ngành nghề.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2445] [规则] (guīzé) - quy tắc, quy chuẩn, luật lệ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '规则' AND pinyin = 'guīzé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '规则' AND pinyin = 'guīzé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '规则'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '规则'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guīzé',
      meaning_vi = 'quy tắc, quy chuẩn, luật lệ',
      example_hanzi = '无论是司机还是行人，在路上行走时都必须严格遵守交通信号灯和交通安全规则。',
      example_pinyin = 'Wúlùn shì sījī háishì xíngrén, zài lù shang xíngzǒu shí dōu bìxū yángé zūnshǒu jiāotōng xìnhàodēng hé jiāotōng ānquán guīzé.',
      example_vi = 'Dù là tài xế hay người đi bộ, khi lưu thông trên đường đều phải tuân thủ nghiêm ngặt đèn tín hiệu giao thông và quy tắc an toàn giao thông.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '规则',
      'guīzé',
      'quy tắc, quy chuẩn, luật lệ',
      'Danh từ',
      'HSK 5',
      '无论是司机还是行人，在路上行走时都必须严格遵守交通信号灯和交通安全规则。',
      'Wúlùn shì sījī háishì xíngrén, zài lù shang xíngzǒu shí dōu bìxū yángé zūnshǒu jiāotōng xìnhàodēng hé jiāotōng ānquán guīzé.',
      'Dù là tài xế hay người đi bộ, khi lưu thông trên đường đều phải tuân thủ nghiêm ngặt đèn tín hiệu giao thông và quy tắc an toàn giao thông.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论是司机还是行人，在路上行走时都必须严格遵守交通信号灯和交通安全规则。', 'Wúlùn shì sījī háishì xíngrén, zài lù shang xíngzǒu shí dōu bìxū yángé zūnshǒu jiāotōng xìnhàodēng hé jiāotōng ānquán guīzé.', 'Dù là tài xế hay người đi bộ, khi lưu thông trên đường đều phải tuân thủ nghiêm ngặt đèn tín hiệu giao thông và quy tắc an toàn giao thông.', 'basic', 1),
      (v_id, '在推动多边世贸组织机制改革中，中国积极倡导维护以联合国宪章宗旨原则为基础的国际法和公认的国际多边经贸贸易投资规则体系。', 'Zài tuīdòng duōbiān Shìmào Zǔzhī jīzhì gǎigé zhōng, Zhōngguó jījí chàngdǎo wéihù yǐ Liánhéguó Xiànzhāng zōngzhǐ yuánzé wéi jīchǔ de guójìfǎ hé gōngrèn de guójì duōbiān jīngmào màoyì tóuzī guīzé tǐxì.', 'Trong việc thúc đẩy cải cách cơ chế của Tổ chức Thương mại Thế giới WTO đa phương, Trung Quốc tích cực khởi xướng bảo vệ luật pháp quốc tế dựa trên tôn chỉ nguyên tắc của Hiến chương Liên Hợp Quốc và hệ thống quy tắc thương mại đầu tư kinh tế đa phương quốc tế được công nhận chung.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2446] [贵姓] (guìxìng) - quý tính, quý danh, họ của ngài (kính ngữ) [Đại từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '贵姓' AND pinyin = 'guìxìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '贵姓' AND pinyin = 'guìxìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '贵姓'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '贵姓'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Đại từ / Danh từ',
      pinyin = 'guìxìng',
      meaning_vi = 'quý tính, quý danh, họ của ngài (kính ngữ)',
      example_hanzi = '请问先生您贵姓？我该如何称呼您才好？',
      example_pinyin = 'Qǐngwèn xiānsheng nín guìxìng? Wǒ gāi rúhé chēnghu nín cái hǎo?',
      example_vi = 'Xin hỏi tiên sinh mang quý tính là gì ạ? Tôi nên xưng hô với ngài thế nào cho tiện?'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '贵姓',
      'guìxìng',
      'quý tính, quý danh, họ của ngài (kính ngữ)',
      'Đại từ / Danh từ',
      'HSK 5',
      '请问先生您贵姓？我该如何称呼您才好？',
      'Qǐngwèn xiānsheng nín guìxìng? Wǒ gāi rúhé chēnghu nín cái hǎo?',
      'Xin hỏi tiên sinh mang quý tính là gì ạ? Tôi nên xưng hô với ngài thế nào cho tiện?'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请问先生您贵姓？我该如何称呼您才好？', 'Qǐngwèn xiānsheng nín guìxìng? Wǒ gāi rúhé chēnghu nín cái hǎo?', 'Xin hỏi tiên sinh mang quý tính là gì ạ? Tôi nên xưng hô với ngài thế nào cho tiện?', 'basic', 1),
      (v_id, '初次拜访商业合作伙伴时，商务秘书礼貌递上名片并用标准的商务礼仪敬问对方贵姓与所属职能部门，给外宾留下了彬彬有礼的极佳第一印象。', 'Chūcì bàifǎng shāngyè hézuò huǒbàn shí, shāngwù mìshū lǐmào dì shàng míngpiàn bìng yòng biāozhǔn de shāngwù lǐyí jìngwèn duìfāng guìxìng yǔ suǒshǔ zhínéng bùmén, gěi wàibīn liúxià le bīnbīn-yǒulǐ de jí jiā dì-yī yìnxiàng.', 'Khi lần đầu tới thăm đối tác hợp tác kinh doanh, thư ký thương mại đã lịch sự đưa danh thiếp bằng hai tay và dùng lễ nghi kinh doanh chuẩn mực kính cẩn hỏi quý tính cùng phòng ban chức năng của đối phương, để lại ấn tượng ban đầu cực kỳ tốt đẹp nho nhã lịch thiệp cho quan khách nước ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2447] [柜子] (guìzi) - cái tủ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '柜子' AND pinyin = 'guìzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '柜子' AND pinyin = 'guìzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '柜子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '柜子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guìzi',
      meaning_vi = 'cái tủ',
      example_hanzi = '妈妈把洗干净晾干的冬季厚衣服整整齐齐地叠好放进了卧室的大衣柜子里。',
      example_pinyin = 'Māma bǎ xǐ gānjìng liàng gān de dōngjì hòu yīfu zhěngzhěng-qíqí de dié hǎo fàngjìn le wòshì de dàyī guìzi lǐ.',
      example_vi = 'Mẹ đã gấp gọn gàng những bộ quần áo mùa đông dày dặn đã giặt sạch phơi khô cất vào trong chiếc tủ quần áo lớn của phòng ngủ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '柜子',
      'guìzi',
      'cái tủ',
      'Danh từ',
      'HSK 5',
      '妈妈把洗干净晾干的冬季厚衣服整整齐齐地叠好放进了卧室的大衣柜子里。',
      'Māma bǎ xǐ gānjìng liàng gān de dōngjì hòu yīfu zhěngzhěng-qíqí de dié hǎo fàngjìn le wòshì de dàyī guìzi lǐ.',
      'Mẹ đã gấp gọn gàng những bộ quần áo mùa đông dày dặn đã giặt sạch phơi khô cất vào trong chiếc tủ quần áo lớn của phòng ngủ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '妈妈把洗干净晾干的冬季厚衣服整整齐齐地叠好放进了卧室的大衣柜子里。', 'Māma bǎ xǐ gānjìng liàng gān de dōngjì hòu yīfu zhěngzhěng-qíqí de dié hǎo fàngjìn le wòshì de dàyī guìzi lǐ.', 'Mẹ đã gấp gọn gàng những bộ quần áo mùa đông dày dặn đã giặt sạch phơi khô cất vào trong chiếc tủ quần áo lớn của phòng ngủ.', 'basic', 1),
      (v_id, '在档案馆核心恒温恒湿机密库房内，所有涉及重要历史事件的原始绝密纸质档案均被妥善封存在具备防磁防火防爆功能的智能特种保险柜子里。', 'Zài dàng’ànguǎn héxīn héngwēn-héngshī jìmì kùfáng nèi, suǒyǒu shèjí zhòngdà lìshǐ shìjiàn de yuánshǐ juémì zhǐzhì dàng’àn jūn bèi tuǒshàn fēngcún zài jùbèi fángcí fánghuǒ fángbào gōngnéng de zhìnéng tèzhǒng bǎoxiǎnguìzi lǐ.', 'Bên trong phòng kho bảo mật nhiệt độ và độ ẩm không đổi cốt lõi của cục lưu trữ, toàn bộ hồ sơ giấy tờ tuyệt mật nguyên bản liên quan tới các sự kiện lịch sử trọng đại đều được niêm phong lưu giữ cẩn thận trong những chiếc tủ sắt bảo hiểm đặc chủng thông minh có tính năng chống từ, chống cháy và chống nổ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2448] [滚] (gǔn) - lăn, cuộn, cuồn cuộn; cút đi; sôi sùng sục [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '滚' AND pinyin = 'gǔn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '滚' AND pinyin = 'gǔn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '滚'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '滚'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'gǔn',
      meaning_vi = 'lăn, cuộn, cuồn cuộn; cút đi; sôi sùng sục',
      example_hanzi = '皮球顺着陡峭的草坡一直往下滚，骨碌碌地掉进了清澈的小池塘里。',
      example_pinyin = 'Píqiú shùnzhe dǒuqiào de cǎopō yìzhí wǎng xià gǔn, gūlūlū de diàojìn le qīngchè de xiǎo chítáng lǐ.',
      example_vi = 'Quả bóng da lăn thẳng một mạch xuống con dốc cỏ cheo leo, lăn tròn lông lốc rơi tõm vào hồ nước nhỏ trong vắt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '滚',
      'gǔn',
      'lăn, cuộn, cuồn cuộn; cút đi; sôi sùng sục',
      'Động từ',
      'HSK 5',
      '皮球顺着陡峭的草坡一直往下滚，骨碌碌地掉进了清澈的小池塘里。',
      'Píqiú shùnzhe dǒuqiào de cǎopō yìzhí wǎng xià gǔn, gūlūlū de diàojìn le qīngchè de xiǎo chítáng lǐ.',
      'Quả bóng da lăn thẳng một mạch xuống con dốc cỏ cheo leo, lăn tròn lông lốc rơi tõm vào hồ nước nhỏ trong vắt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '皮球顺着陡峭的草坡一直往下滚，骨碌碌地掉进了清澈的小池塘里。', 'Píqiú shùnzhe dǒuqiào de cǎopō yìzhí wǎng xià gǔn, gūlūlū de diàojìn le qīngchè de xiǎo chítáng lǐ.', 'Quả bóng da lăn thẳng một mạch xuống con dốc cỏ cheo leo, lăn tròn lông lốc rơi tõm vào hồ nước nhỏ trong vắt.', 'basic', 1),
      (v_id, '滚滚长江东逝水，浪花淘尽英雄；在中华浩瀚的历史长河中，惟有那些为国家民族命运舍生取义的志士仁人方能名垂青史。', 'Gǔngǔn Cháng Jiāng dōng shì shuǐ, lànghuā táo jìn yīngxióng; zài Zhōnghuá hàohàn de lìshǐ chánghé zhōng, wéiyǒu nàxiē wèi guójiā mínzú mìngyùn shěshēng-qǔyì de zhìshì-rénrén fāng néng míngchuí-qīngshǐ.', 'Cuồn cuộn Trường Giang dòng nước chảy về đông, bọt sóng vùi dập hết thảy anh hùng; giữa dòng sông lịch sử mênh mông của Trung Hoa, chỉ có những bậc chí sĩ nhân nhân xả thân vì đại nghĩa của vận mệnh dân tộc đất nước mới có thể lưu danh thiên cổ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2449] [锅] (guō) - cái nồi, cái chảo [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '锅' AND pinyin = 'guō'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '锅' AND pinyin = 'guō'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '锅'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '锅'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guō',
      meaning_vi = 'cái nồi, cái chảo',
      example_hanzi = '严寒的冬天里，全家人围坐在一起吃一顿热气腾腾的麻辣火锅，感到无比温暖。',
      example_pinyin = 'Yánhán de dōngtiān lǐ, quánjiā rén wéizuò zài yìqǐ chī yí dùn rèqì-téngténg de málà huǒguō, gǎndào wúbǐ wēnnuǎn.',
      example_vi = 'Trong mùa đông giá rét, cả nhà quây quần ngồi bên nhau ăn một bữa lẩu cay tê bốc khói nghi ngút, cảm thấy ấm áp vô cùng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '锅',
      'guō',
      'cái nồi, cái chảo',
      'Danh từ',
      'HSK 5',
      '严寒的冬天里，全家人围坐在一起吃一顿热气腾腾的麻辣火锅，感到无比温暖。',
      'Yánhán de dōngtiān lǐ, quánjiā rén wéizuò zài yìqǐ chī yí dùn rèqì-téngténg de málà huǒguō, gǎndào wúbǐ wēnnuǎn.',
      'Trong mùa đông giá rét, cả nhà quây quần ngồi bên nhau ăn một bữa lẩu cay tê bốc khói nghi ngút, cảm thấy ấm áp vô cùng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '严寒的冬天里，全家人围坐在一起吃一顿热气腾腾的麻辣火锅，感到无比温暖。', 'Yánhán de dōngtiān lǐ, quánjiā rén wéizuò zài yìqǐ chī yí dùn rèqì-téngténg de málà huǒguō, gǎndào wúbǐ wēnnuǎn.', 'Trong mùa đông giá rét, cả nhà quây quần ngồi bên nhau ăn một bữa lẩu cay tê bốc khói nghi ngút, cảm thấy ấm áp vô cùng.', 'basic', 1),
      (v_id, '火力发电厂锅炉核心机组采用超临界高温蒸汽循环燃烧技术，有效将燃煤热能转化率提升至国际顶尖水准，极大地减少了单位发电污染排放。', 'Huǒlì fādiànchǎng guōlú héxīn jīzǔ cǎiyòng chāolínjiè gāowēn zhēngqì xúnhuán ránshāo jìshù, yǒuxiào jiāng ránméi rènéng zhuǎnhuàlǜ tíshēng zhì guójì dǐngjiān shuǐzhǔn, jídà de jiǎnshǎo le dānwèi fādiàn wūrǎn páifàng.', 'Tổ máy nồi hơi cốt lõi của nhà máy nhiệt điện sử dụng công nghệ đốt cháy tuần hoàn hơi nước nhiệt độ cao siêu tới hạn, nâng cao hiệu quả tỷ lệ chuyển hóa nhiệt năng của than đốt lên mức đỉnh cao quốc tế, giảm thiểu rất lớn lượng phát thải ô nhiễm trên một đơn vị phát điện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2450] [国画] (guóhuà) - tranh thủy mặc, quốc họa Trung Quốc [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '国画' AND pinyin = 'guóhuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '国画' AND pinyin = 'guóhuà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '国画'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '国画'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guóhuà',
      meaning_vi = 'tranh thủy mặc, quốc họa Trung Quốc',
      example_hanzi = '李老师从小研习国画，尤其擅长用浓淡相宜的水墨勾勒栩栩如生的奔马与荷花。',
      example_pinyin = 'Lǐ lǎoshī cóngxiǎo yánxí guóhuà, yóuqí shàncháng yòng nóngdàn-xiāngyí de shuǐmò gōulè xǔxǔ-rúshēng de bènmǎ yǔ héhuā.',
      example_vi = 'Thầy Lý từ nhỏ đã nghiên tập quốc họa, đặc biệt sở trường dùng nét mực nước đậm nhạt hài hòa để phác họa đàn ngựa phi nước đại và hoa sen sống động như thật.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '国画',
      'guóhuà',
      'tranh thủy mặc, quốc họa Trung Quốc',
      'Danh từ',
      'HSK 5',
      '李老师从小研习国画，尤其擅长用浓淡相宜的水墨勾勒栩栩如生的奔马与荷花。',
      'Lǐ lǎoshī cóngxiǎo yánxí guóhuà, yóuqí shàncháng yòng nóngdàn-xiāngyí de shuǐmò gōulè xǔxǔ-rúshēng de bènmǎ yǔ héhuā.',
      'Thầy Lý từ nhỏ đã nghiên tập quốc họa, đặc biệt sở trường dùng nét mực nước đậm nhạt hài hòa để phác họa đàn ngựa phi nước đại và hoa sen sống động như thật.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '李老师从小研习国画，尤其擅长用浓淡相宜的水墨勾勒栩栩如生的奔马与荷花。', 'Lǐ lǎoshī cóngxiǎo yánxí guóhuà, yóuqí shàncháng yòng nóngdàn-xiāngyí de shuǐmò gōulè xǔxǔ-rúshēng de bènmǎ yǔ héhuā.', 'Thầy Lý từ nhỏ đã nghiên tập quốc họa, đặc biệt sở trường dùng nét mực nước đậm nhạt hài hòa để phác họa đàn ngựa phi nước đại và hoa sen sống động như thật.', 'basic', 1),
      (v_id, '中国传统国画艺术博大精深，通过水墨留白、气韵生动以及诗书画印浑然一体的意境营造，集中体现了东方美学对天人合一哲学思想的至高追求。', 'Zhōngguó chuántǒng guóhuà yìshù bódà-jīngshēn, tōngguò shuǐmò liúbái, qìyùn shēngdòng yǐjí shī-shū-huà-yìn húnrán-yìtǐ de yìjìng yíngzào, jízhōng tǐxiàn le dōngfāng měixué duì tiān-rén-hé-yī zhéxué sīxiǎng de zhìgāo zhuīqiú.', 'Nghệ thuật quốc họa truyền thống Trung Hoa uyên thâm bác đại, thông qua việc để khoảng trắng trong thủy mặc, khí vận sinh động cùng sự hòa quyện tự nhiên của thi - thư - họa - ấn tạo nên ý cảnh nghệ thuật, thể hiện tập trung sự theo đuổi tối cao của mỹ học phương Đông đối với tư tưởng triết học thiên nhân hợp nhất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2451] [国庆] (guóqìng) - quốc khánh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '国庆' AND pinyin = 'guóqìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '国庆' AND pinyin = 'guóqìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '国庆'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '国庆'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guóqìng',
      meaning_vi = 'quốc khánh',
      example_hanzi = '每逢十月一日国庆节假期，全国各大知名旅游景点和商业街区都迎来了庞大的客流高峰。',
      example_pinyin = 'Měiféng shí yuè yī rì Guóqìngjié jiàqī, quánguó gè dà zhīmíng lǚyóu jǐngdiǎn hé shāngyè jiēqū dōu yínglái le pángdà de kèliú gāofēng.',
      example_vi = 'Mỗi dịp kỳ nghỉ lễ Quốc khánh ngày mùng một tháng mười, các điểm tham quan du lịch nổi tiếng và khu phố thương mại lớn trên cả nước đều đón lượng khách khổng lồ đạt đỉnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '国庆',
      'guóqìng',
      'quốc khánh',
      'Danh từ',
      'HSK 5',
      '每逢十月一日国庆节假期，全国各大知名旅游景点和商业街区都迎来了庞大的客流高峰。',
      'Měiféng shí yuè yī rì Guóqìngjié jiàqī, quánguó gè dà zhīmíng lǚyóu jǐngdiǎn hé shāngyè jiēqū dōu yínglái le pángdà de kèliú gāofēng.',
      'Mỗi dịp kỳ nghỉ lễ Quốc khánh ngày mùng một tháng mười, các điểm tham quan du lịch nổi tiếng và khu phố thương mại lớn trên cả nước đều đón lượng khách khổng lồ đạt đỉnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每逢十月一日国庆节假期，全国各大知名旅游景点和商业街区都迎来了庞大的客流高峰。', 'Měiféng shí yuè yī rì Guóqìngjié jiàqī, quánguó gè dà zhīmíng lǚyóu jǐngdiǎn hé shāngyè jiēqū dōu yínglái le pángdà de kèliú gāofēng.', 'Mỗi dịp kỳ nghỉ lễ Quốc khánh ngày mùng một tháng mười, các điểm tham quan du lịch nổi tiếng và khu phố thương mại lớn trên cả nước đều đón lượng khách khổng lồ đạt đỉnh.', 'basic', 1),
      (v_id, '在国庆招待招待招待会上，国家领导人发表重要讲话，回顾总结了共和国风雨兼程取得的历史性辉煌成就，并向全国各族人民及海外侨胞致以最美好的节日祝愿。', 'Zài guóqìng zhāodàihuì shang, guójiā lǐngdǎorén fābiǎo zhòngyào jiǎnghuà, huígù zǒngjié le gònghéguó fēngyǔ-jiānchéng qǔdé de lìshǐxìng huīhuáng chéngjiù, bìng xiàng quánguó gè zú rénmín jí hǎiwài qiáobāo zhìyǐ zuì měihǎo de jiérì zhùyuàn.', 'Tại buổi chiêu đãi Quốc khánh, các nhà lãnh đạo quốc gia đã phát biểu bài nói quan trọng, ôn lại và tổng kết những thành tựu huy hoàng mang tính lịch sử mà nước cộng hòa đã dầm mưa dãi gió giành được, đồng thời gửi lời chúc mừng ngày lễ tốt đẹp nhất tới nhân dân các dân tộc trên cả nước cùng kiều bào hải ngoại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2452] [果然] (guǒrán) - quả nhiên, đúng như dự đoán [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '果然' AND pinyin = 'guǒrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '果然' AND pinyin = 'guǒrán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '果然'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '果然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'guǒrán',
      meaning_vi = 'quả nhiên, đúng như dự đoán',
      example_hanzi = '天气预报说傍晚会有雷阵雨，到了下班时间外面果然雷声阵阵、大雨倾盆。',
      example_pinyin = 'Tiānqì yùbào shuō bàngwǎn huì yǒu léizhènyǔ, dào le xiàbān shíjiān wàimiàn guǒrán léishēng zhènzhèn, dàyǔ qīngpén.',
      example_vi = 'Dự báo thời tiết nói chiều tối sẽ có mưa dông, đến lúc tan làm bên ngoài quả nhiên sấm chớp ầm ầm, mưa đổ như trút nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '果然',
      'guǒrán',
      'quả nhiên, đúng như dự đoán',
      'Phó từ',
      'HSK 5',
      '天气预报说傍晚会有雷阵雨，到了下班时间外面果然雷声阵阵、大雨倾盆。',
      'Tiānqì yùbào shuō bàngwǎn huì yǒu léizhènyǔ, dào le xiàbān shíjiān wàimiàn guǒrán léishēng zhènzhèn, dàyǔ qīngpén.',
      'Dự báo thời tiết nói chiều tối sẽ có mưa dông, đến lúc tan làm bên ngoài quả nhiên sấm chớp ầm ầm, mưa đổ như trút nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天气预报说傍晚会有雷阵雨，到了下班时间外面果然雷声阵阵、大雨倾盆。', 'Tiānqì yùbào shuō bàngwǎn huì yǒu léizhènyǔ, dào le xiàbān shíjiān wàimiàn guǒrán léishēng zhènzhèn, dàyǔ qīngpén.', 'Dự báo thời tiết nói chiều tối sẽ có mưa dông, đến lúc tan làm bên ngoài quả nhiên sấm chớp ầm ầm, mưa đổ như trút nước.', 'basic', 1),
      (v_id, '经过科研团队连续数月的严密推导与反复试验，实验数据结果果然完全验证了最初关于新型超导材料在极低温下临界电阻归零的理论假说。', 'Jīngguò kēyán tuánduì liánxù shù yuè de yánmì tuīdǎo yǔ fǎnfù shìyàn, shíyàn shùjù jiéguǒ guǒrán wánquán yànzhèng le zuìchū guānyú xīnxíng chāodǎo cáiliào zài jí dīwēn xià línjiè diànzǔ guīlíng de lǐlùn jiǎshuō.', 'Trải qua nhiều tháng liên tục suy diễn chặt chẽ và thử nghiệm lặp đi lặp lại của đội ngũ nghiên cứu khoa học, kết quả số liệu thực nghiệm quả nhiên đã kiểm chứng hoàn toàn giả thuyết lý thuyết ban đầu về việc điện trở tới hạn của vật liệu siêu dẫn kiểu mới trở về không ở nhiệt độ cực thấp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2453] [果实] (guǒshí) - quả, trái cây; thành quả [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '果实' AND pinyin = 'guǒshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '果实' AND pinyin = 'guǒshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '果实'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '果实'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'guǒshí',
      meaning_vi = 'quả, trái cây; thành quả',
      example_hanzi = '金秋十月，果园里的苹果树上挂满了红彤彤、沉甸甸的甜美果实。',
      example_pinyin = 'Jīnqiū shí yuè, guǒyuán lǐ de píngguǒshù shang guàmǎn le hóngtōngtōng, chéndiàndiàn de tiánměi guǒshí.',
      example_vi = 'Tháng mười mùa thu vàng, trên những cây táo trong vườn quả treo trĩu cành những trái ngọt đỏ au và nặng trĩu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '果实',
      'guǒshí',
      'quả, trái cây; thành quả',
      'Danh từ',
      'HSK 5',
      '金秋十月，果园里的苹果树上挂满了红彤彤、沉甸甸的甜美果实。',
      'Jīnqiū shí yuè, guǒyuán lǐ de píngguǒshù shang guàmǎn le hóngtōngtōng, chéndiàndiàn de tiánměi guǒshí.',
      'Tháng mười mùa thu vàng, trên những cây táo trong vườn quả treo trĩu cành những trái ngọt đỏ au và nặng trĩu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '金秋十月，果园里的苹果树上挂满了红彤彤、沉甸甸的甜美果实。', 'Jīnqiū shí yuè, guǒyuán lǐ de píngguǒshù shang guàmǎn le hóngtōngtōng, chéndiàndiàn de tiánměi guǒshí.', 'Tháng mười mùa thu vàng, trên những cây táo trong vườn quả treo trĩu cành những trái ngọt đỏ au và nặng trĩu.', 'basic', 1),
      (v_id, '全面建成小康社会是全体人民矢志不渝、共同奋斗结出的伟大果实，广大人民群众共同享有这一历史性奋斗成果。', 'Quánmiàn jiànchéng xiǎokāng shèhuì shì quántǐ rénmín shǐzhì-bùyú, gòngtóng fèndòu jiēchū de wěidà guǒshí, guǎngdà rénmín qúnzhòng gòngtóng xiǎngyǒu zhè yí lìshǐxìng fèndòu chéngguǒ.', 'Việc hoàn thành xây dựng toàn diện xã hội khá giả là thành quả vĩ đại kết tinh từ sự phấn đấu chung chí hướng không đổi của toàn thể nhân dân, đông đảo quần chúng nhân dân cùng chung hưởng thành quả phấn đấu mang tính lịch sử này.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2454] [过度] (guòdù) - quá mức, quá độ [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '过度' AND pinyin = 'guòdù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过度' AND pinyin = 'guòdù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '过度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'guòdù',
      meaning_vi = 'quá mức, quá độ',
      example_hanzi = '经常长时间熬夜玩手机和过度用眼，很容易导致视力急剧下降与偏头痛。',
      example_pinyin = 'Chángcháng cháng shíjiān áoyè wán shǒujī hé guòdù yòngyǎn, hěn róngyì dǎozhì shìlì jíjù xiàjiàng yǔ piāntóutòng.',
      example_vi = 'Thường xuyên thức khuya chơi điện thoại trong thời gian dài và sử dụng mắt quá độ rất dễ dẫn đến thị lực suy giảm nhanh chóng và đau nửa đầu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '过度',
      'guòdù',
      'quá mức, quá độ',
      'Tính từ / Phó từ',
      'HSK 5',
      '经常长时间熬夜玩手机和过度用眼，很容易导致视力急剧下降与偏头痛。',
      'Chángcháng cháng shíjiān áoyè wán shǒujī hé guòdù yòngyǎn, hěn róngyì dǎozhì shìlì jíjù xiàjiàng yǔ piāntóutòng.',
      'Thường xuyên thức khuya chơi điện thoại trong thời gian dài và sử dụng mắt quá độ rất dễ dẫn đến thị lực suy giảm nhanh chóng và đau nửa đầu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经常长时间熬夜玩手机和过度用眼，很容易导致视力急剧下降与偏头痛。', 'Chángcháng cháng shíjiān áoyè wán shǒujī hé guòdù yòngyǎn, hěn róngyì dǎozhì shìlì jíjù xiàjiàng yǔ piāntóutòng.', 'Thường xuyên thức khuya chơi điện thoại trong thời gian dài và sử dụng mắt quá độ rất dễ dẫn đến thị lực suy giảm nhanh chóng và đau nửa đầu.', 'basic', 1),
      (v_id, '金融监管部门严肃查处互联网金融平台针对在校大学生群体诱导过度借贷、滥设高额服务费与违规暴力催收的恶劣金融违法行为。', 'Jīnróng jiānguǎn bùmén yánsù cháchǔ hùliánwǎng jīnróng píngtái zhēnduì zàixiào dàxuésheng qúntǐ yòudǎo guòdù jièdài, làn shè gāo’é fúwùfèi yǔ wéiguī bàolì cuīshōu de èliè jīnróng wéifǎ xíngwéi.', 'Cơ quan giám sát tài chính đã nghiêm túc điều tra xử lý các hành vi vi phạm pháp luật tài chính nghiêm trọng của các sàn tài chính internet như dụ dỗ nhóm đối tượng sinh viên đại học vay mượn quá mức, tùy tiện đặt mức phí dịch vụ cao ngất ngưởng và đòi nợ bạo lực trái quy định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2455] [过分] (guòfèn) - quá đáng, quá trớn [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '过分' AND pinyin = 'guòfèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过分' AND pinyin = 'guòfèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '过分'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过分'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'guòfèn',
      meaning_vi = 'quá đáng, quá trớn',
      example_hanzi = '他在公共场合对服务员大声呵斥指责，周围的顾客都觉得他实在太过分了。',
      example_pinyin = 'Tā zài gōnggòng chǎnghé duì fúwùyuán dàshēng hēchì zhǐzé, zhōuwéi de gùkè dōu juéde tā shízài tài guòfèn le.',
      example_vi = 'Anh ta lớn tiếng quát tháo chỉ trích nhân viên phục vụ nơi công cộng, các thực khách xung quanh đều cảm thấy anh ta thực sự quá đáng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '过分',
      'guòfèn',
      'quá đáng, quá trớn',
      'Tính từ / Phó từ',
      'HSK 5',
      '他在公共场合对服务员大声呵斥指责，周围的顾客都觉得他实在太过分了。',
      'Tā zài gōnggòng chǎnghé duì fúwùyuán dàshēng hēchì zhǐzé, zhōuwéi de gùkè dōu juéde tā shízài tài guòfèn le.',
      'Anh ta lớn tiếng quát tháo chỉ trích nhân viên phục vụ nơi công cộng, các thực khách xung quanh đều cảm thấy anh ta thực sự quá đáng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在公共场合对服务员大声呵斥指责，周围的顾客都觉得他实在太过分了。', 'Tā zài gōnggòng chǎnghé duì fúwùyuán dàshēng hēchì zhǐzé, zhōuwéi de gùkè dōu juéde tā shízài tài guòfèn le.', 'Anh ta lớn tiếng quát tháo chỉ trích nhân viên phục vụ nơi công cộng, các thực khách xung quanh đều cảm thấy anh ta thực sự quá đáng.', 'basic', 1),
      (v_id, '在外商投资商务谈判中，我方代表严正驳回了外资巨头提出的索要核心技术底层源代码的过分要求，坚决捍卫了国家核心知识产权与经济自主权。', 'Zài wàishāng tóuzī shāngwù tánpàn zhōng, wǒfāng dàibiǎo yánzhèng bóhuí le wàizī jùtóu tíchū de suǒyào héxīn jìshù dǐcéng yuándàimǎ de guòfèn yāoqiú, jiānjué hànwèi le guójiā héxīn zhīshi chǎnquán yǔ jīngjì zìzhǔquán.', 'Trong đàm phán thương mại đầu tư nước ngoài, đại diện phía chúng tôi đã nghiêm khắc bác bỏ yêu cầu quá đáng của tập đoàn khổng lồ nước ngoài đòi chuyển giao mã nguồn tầng dưới của công nghệ lõi, kiên quyết bảo vệ quyền sở hữu trí tuệ cốt lõi và quyền tự chủ kinh tế quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2456] [过敏] (guòmǐn) - dị ứng, mẫn cảm [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '过敏' AND pinyin = 'guòmǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过敏' AND pinyin = 'guòmǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '过敏'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过敏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'guòmǐn',
      meaning_vi = 'dị ứng, mẫn cảm',
      example_hanzi = '他对芒果和海鲜严重过敏，外出就餐点菜时总是要格外仔细询问食材配料。',
      example_pinyin = 'Tā duì mángguǒ hé hǎixiān yánzhòng guòmǐn, wàichū jiùcān diǎncài shí zǒngshì yào géwài zǐxì xùnwèn shícái pèiliào.',
      example_vi = 'Anh ấy bị dị ứng nghiêm trọng với xoài và hải sản, khi ra ngoài dùng bữa gọi món luôn phải hỏi han nguyên liệu cực kỳ cẩn thận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '过敏',
      'guòmǐn',
      'dị ứng, mẫn cảm',
      'Động từ / Tính từ',
      'HSK 5',
      '他对芒果和海鲜严重过敏，外出就餐点菜时总是要格外仔细询问食材配料。',
      'Tā duì mángguǒ hé hǎixiān yánzhòng guòmǐn, wàichū jiùcān diǎncài shí zǒngshì yào géwài zǐxì xùnwèn shícái pèiliào.',
      'Anh ấy bị dị ứng nghiêm trọng với xoài và hải sản, khi ra ngoài dùng bữa gọi món luôn phải hỏi han nguyên liệu cực kỳ cẩn thận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他对芒果和海鲜严重过敏，外出就餐点菜时总是要格外仔细询问食材配料。', 'Tā duì mángguǒ hé hǎixiān yánzhòng guòmǐn, wàichū jiùcān diǎncài shí zǒngshì yào géwài zǐxì xùnwèn shícái pèiliào.', 'Anh ấy bị dị ứng nghiêm trọng với xoài và hải sản, khi ra ngoài dùng bữa gọi món luôn phải hỏi han nguyên liệu cực kỳ cẩn thận.', 'basic', 1),
      (v_id, '儿科临床医生指出，春季花粉柳絮漫天飞舞易诱发易感婴幼儿群体出现过敏性鼻炎、哮喘发作及皮肤湿疹等复杂的变态反应性免疫疾病。', 'Érkē línchuáng yīshēng zhǐchū, chūnjì huāfěn liǔxù màntiān fēiwǔ yì yòufā yìgǎn yīng-yòu’ér qúntǐ chūxiàn guòmǐnxìng bíyán, xiàochuǎn fāzuò jí pífū shīzhěn děng fùzá de biàntài fǎnyìngxìng miǎnyì jíbìng.', 'Bác sĩ lâm sàng nhi khoa chỉ ra rằng, phấn hoa và tơ liễu bay rợp trời vào mùa xuân rất dễ kích phát nhóm trẻ sơ sinh và trẻ nhỏ có cơ địa mẫn cảm xuất hiện các bệnh lý miễn dịch phản ứng dị ứng phức tạp như viêm mũi dị ứng, cơn hen suyễn bộc phát và chàm da.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2457] [过期] (guòqī) - quá hạn, hết hạn [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '过期' AND pinyin = 'guòqī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过期' AND pinyin = 'guòqī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '过期'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过期'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'guòqī',
      meaning_vi = 'quá hạn, hết hạn',
      example_hanzi = '购买瓶装牛奶时一定要查看生产日期，千万不要饮用已经过期的奶制品。',
      example_pinyin = 'Gòumǎi píngzhuāng niúnǎi shí yídìng yào chákàn shēngchǎn rìqī, qiānwàn bú yào yǐnyòng yǐjīng guòqī de nǎizhìpǐn.',
      example_vi = 'Khi mua sữa bò đóng chai nhất định phải kiểm tra ngày sản xuất, tuyệt đối không được uống các chế phẩm từ sữa đã hết hạn sử dụng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '过期',
      'guòqī',
      'quá hạn, hết hạn',
      'Động từ',
      'HSK 5',
      '购买瓶装牛奶时一定要查看生产日期，千万不要饮用已经过期的奶制品。',
      'Gòumǎi píngzhuāng niúnǎi shí yídìng yào chákàn shēngchǎn rìqī, qiānwàn bú yào yǐnyòng yǐjīng guòqī de nǎizhìpǐn.',
      'Khi mua sữa bò đóng chai nhất định phải kiểm tra ngày sản xuất, tuyệt đối không được uống các chế phẩm từ sữa đã hết hạn sử dụng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '购买瓶装牛奶时一定要查看生产日期，千万不要饮用已经过期的奶制品。', 'Gòumǎi píngzhuāng niúnǎi shí yídìng yào chákàn shēngchǎn rìqī, qiānwàn bú yào yǐnyòng yǐjīng guòqī de nǎizhìpǐn.', 'Khi mua sữa bò đóng chai nhất định phải kiểm tra ngày sản xuất, tuyệt đối không được uống các chế phẩm từ sữa đã hết hạn sử dụng.', 'basic', 1),
      (v_id, '市场监督管理部门依法对某大型连锁超市在冷库内非法篡改冷冻肉制品生产保质期标签并公然销售过期变质食品的严重违规行为立案查处。', 'Shìchǎng jiāndū guǎnlǐ bùmén yīfǎ duì mǒu dàxíng liánsuǒ chāoshì zài lěngkù nèi fēifǎ cuàngǎi lěngdòng ròuzhìpǐn shēngchǎn bǎozhìqī biāoqiān bìng gōngrán xiāoshòu guòqī biànzhì shípǐn de yánzhòng wéiguī xíngwéi lì’àn cháchǔ.', 'Cơ quan quản lý giám sát thị trường đã lập án điều tra xử phạt theo luật định đối với hành vi vi phạm nghiêm trọng của một siêu thị chuỗi lớn vì hành vi sửa nhãn hạn sử dụng thịt đông lạnh trong kho lạnh và công khai bán thực phẩm biến chất quá hạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2458] [过于] (guòyú) - quá, quá đỗi [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '过于' AND pinyin = 'guòyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过于' AND pinyin = 'guòyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '过于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '过于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'guòyú',
      meaning_vi = 'quá, quá đỗi',
      example_hanzi = '面对重大的升学和就业考试，保持平常心即可，不必过于紧张焦虑。',
      example_pinyin = 'Miànduì zhòngdà de shēngxué hé jiùyè kǎoshì, bǎochí píngchángxīn jíkě, búbì guòyú jǐnzhāng jiāolǜ.',
      example_vi = 'Đối mặt với những kỳ thi chuyển cấp và xin việc trọng đại, chỉ cần giữ tâm lý bình thường là được, không cần phải quá đỗi căng thẳng lo âu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '过于',
      'guòyú',
      'quá, quá đỗi',
      'Phó từ',
      'HSK 5',
      '面对重大的升学和就业考试，保持平常心即可，不必过于紧张焦虑。',
      'Miànduì zhòngdà de shēngxué hé jiùyè kǎoshì, bǎochí píngchángxīn jíkě, búbì guòyú jǐnzhāng jiāolǜ.',
      'Đối mặt với những kỳ thi chuyển cấp và xin việc trọng đại, chỉ cần giữ tâm lý bình thường là được, không cần phải quá đỗi căng thẳng lo âu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对重大的升学和就业考试，保持平常心即可，不必过于紧张焦虑。', 'Miànduì zhòngdà de shēngxué hé jiùyè kǎoshì, bǎochí píngchángxīn jíkě, búbì guòyú jǐnzhāng jiāolǜ.', 'Đối mặt với những kỳ thi chuyển cấp và xin việc trọng đại, chỉ cần giữ tâm lý bình thường là được, không cần phải quá đỗi căng thẳng lo âu.', 'basic', 1),
      (v_id, '货币政策决策委员会在评估宏观通胀预期时强调，既要防止政策转向过于迟缓滞后，也要警惕过度紧缩对实体制造业复苏带来次生负面冲击。', 'Huòbì zhèngcè juécè wěiyuánhuì zài pínggū hóngguān tōngzhàng yùqī shí qiángdiào, jì yào fángzhǐ zhèngcè zhuǎnxiàng guòyú chíhuǎn zhìhòu, yě yào jǐngtì guòdù jǐnsuō duì shítǐ zhìzàoyè fùsū dàilái cìshēng fùmiàn chōngjī.', 'Ủy ban hoạch định chính sách tiền tệ khi đánh giá kỳ vọng lạm phát vĩ mô đã nhấn mạnh rằng, vừa phải đề phòng việc xoay trục chính sách quá đỗi chậm trễ tụt hậu, vừa phải cảnh giác việc thắt chặt quá mức gây ra cú sốc tiêu cực thứ cấp đối với sự phục hồi của ngành sản xuất kinh tế thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2459] [哈] (hā) - hà hơi; ha ha (tiếng cười vui vẻ) [Thán từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '哈' AND pinyin = 'hā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哈' AND pinyin = 'hā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '哈'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '哈'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thán từ / Động từ',
      pinyin = 'hā',
      meaning_vi = 'hà hơi; ha ha (tiếng cười vui vẻ)',
      example_hanzi = '冬天的早晨天气寒冷，小女孩对着冻僵的小手哈了一口热气取暖。',
      example_pinyin = 'Dōngtiān de zǎochén tiānqì hánlěng, xiǎo nǚhái duì zhe dòngjiāng de xiǎoshǒu hā le yì kǒu rèqì qǔnuǎn.',
      example_vi = 'Buổi sáng mùa đông thời tiết giá rét, cô bé hà một hơi ấm vào đôi bàn tay nhỏ đang cóng lạnh để sưởi ấm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '哈',
      'hā',
      'hà hơi; ha ha (tiếng cười vui vẻ)',
      'Thán từ / Động từ',
      'HSK 5',
      '冬天的早晨天气寒冷，小女孩对着冻僵的小手哈了一口热气取暖。',
      'Dōngtiān de zǎochén tiānqì hánlěng, xiǎo nǚhái duì zhe dòngjiāng de xiǎoshǒu hā le yì kǒu rèqì qǔnuǎn.',
      'Buổi sáng mùa đông thời tiết giá rét, cô bé hà một hơi ấm vào đôi bàn tay nhỏ đang cóng lạnh để sưởi ấm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬天的早晨天气寒冷，小女孩对着冻僵的小手哈了一口热气取暖。', 'Dōngtiān de zǎochén tiānqì hánlěng, xiǎo nǚhái duì zhe dòngjiāng de xiǎoshǒu hā le yì kǒu rèqì qǔnuǎn.', 'Buổi sáng mùa đông thời tiết giá rét, cô bé hà một hơi ấm vào đôi bàn tay nhỏ đang cóng lạnh để sưởi ấm.', 'basic', 1),
      (v_id, '这部由著名喜剧演员领衔主演的贺岁喜剧幽默风趣、包袱不断，引得影院内全场观众开怀大笑、哈哈声经久不绝。', 'Zhè bù yóu zhùmíng xǐjù yǎnyuán lǐngxián zhǔyǎn de hèsuì xǐjù yōumò fēngqù, bāofu búduàn, yǐn dé yǐngyuàn nèi quánchǎng guānzhòng kāihuái dàxiào, hāhā shēng jīngjiǔ-bùjué.', 'Bộ phim hài chiếu Tết do diễn viên hài kịch nổi tiếng đóng chính có nội dung dí dỏm hài hước, miếng hài liên tục, khiến toàn bộ khán giả trong rạp cười nắc nẻ sảng khoái, tiếng cười ha ha vang lên không ngớt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2460] [海关] (hǎiguān) - hải quan [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '海关' AND pinyin = 'hǎiguān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '海关' AND pinyin = 'hǎiguān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '海关'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '海关'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hǎiguān',
      meaning_vi = 'hải quan',
      example_hanzi = '乘坐国际航班抵达目的地机场后，旅客必须携带有效护照前往海关边检查验通道。',
      example_pinyin = 'Chéngzuò guójì hángbān dǐdá mùdìdì jīchǎng hòu, lǚkè bìxū xiédài yǒuxiào hùzhào qiánwǎng hǎiguān biānjiǎn cháyàn tōngdào.',
      example_vi = 'Sau khi đáp chuyến bay quốc tế đến sân bay điểm đến, hành khách bắt buộc phải mang hộ chiếu còn hiệu lực tới lối kiểm tra của hải quan và biên phòng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '海关',
      'hǎiguān',
      'hải quan',
      'Danh từ',
      'HSK 5',
      '乘坐国际航班抵达目的地机场后，旅客必须携带有效护照前往海关边检查验通道。',
      'Chéngzuò guójì hángbān dǐdá mùdìdì jīchǎng hòu, lǚkè bìxū xiédài yǒuxiào hùzhào qiánwǎng hǎiguān biānjiǎn cháyàn tōngdào.',
      'Sau khi đáp chuyến bay quốc tế đến sân bay điểm đến, hành khách bắt buộc phải mang hộ chiếu còn hiệu lực tới lối kiểm tra của hải quan và biên phòng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '乘坐国际航班抵达目的地机场后，旅客必须携带有效护照前往海关边检查验通道。', 'Chéngzuò guójì hángbān dǐdá mùdìdì jīchǎng hòu, lǚkè bìxū xiédài yǒuxiào hùzhào qiánwǎng hǎiguān biānjiǎn cháyàn tōngdào.', 'Sau khi đáp chuyến bay quốc tế đến sân bay điểm đến, hành khách bắt buộc phải mang hộ chiếu còn hiệu lực tới lối kiểm tra của hải quan và biên phòng.', 'basic', 1),
      (v_id, '国家海关总署大力推行“单一窗口”全流程通关无纸化改革与人工智能智能审图系统，将进出口货物口岸通关放行时间压缩了百分之四十以上。', 'Guójiā Hǎiguān Zǒngshǔ dàlì tuīxíng “dānyī chuāngkǒu” quán liúchéng tōngguān wúzhǐhuà gǎigé yǔ réngōng zhìnéng zhìnéng shěntú xìtǒng, jiāng jìn-chūkǒu huòwù kǒu’àn tōngguān fàngxíng shíjiān yāsuō le bǎifēnzhī sìshí yǐshàng.', 'Tổng cục Hải quan quốc gia đẩy mạnh triển khai cải cách phi giấy tờ hóa thông quan toàn quy trình "một cửa" và hệ thống soi quét hình ảnh thông minh bằng trí tuệ nhân tạo, rút ngắn hơn bốn mươi phần trăm thời gian thông quan thông luồng hàng hóa xuất nhập khẩu tại các cửa khẩu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2461] [海外] (hǎiwài) - hải ngoại, nước ngoài, ngoài nước [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '海外' AND pinyin = 'hǎiwài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '海外' AND pinyin = 'hǎiwài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '海外'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '海外'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hǎiwài',
      meaning_vi = 'hải ngoại, nước ngoài, ngoài nước',
      example_hanzi = '这家国产智能新能源汽车品牌正全力拓展欧洲和东南亚等海外消费市场。',
      example_pinyin = 'Zhè jiā guóchǎn zhìnéng xīnnéngyuán qìchē pǐnpái zhèng quánlì tuòzhǎn Ōuzhōu hé Dōngnányà děng hǎiwài xiāofèi shìchǎng.',
      example_vi = 'Thương hiệu ô tô năng lượng mới thông minh sản xuất trong nước này đang dốc toàn lực mở rộng các thị trường tiêu dùng hải ngoại như châu Âu và Đông Nam Á.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '海外',
      'hǎiwài',
      'hải ngoại, nước ngoài, ngoài nước',
      'Danh từ',
      'HSK 5',
      '这家国产智能新能源汽车品牌正全力拓展欧洲和东南亚等海外消费市场。',
      'Zhè jiā guóchǎn zhìnéng xīnnéngyuán qìchē pǐnpái zhèng quánlì tuòzhǎn Ōuzhōu hé Dōngnányà děng hǎiwài xiāofèi shìchǎng.',
      'Thương hiệu ô tô năng lượng mới thông minh sản xuất trong nước này đang dốc toàn lực mở rộng các thị trường tiêu dùng hải ngoại như châu Âu và Đông Nam Á.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家国产智能新能源汽车品牌正全力拓展欧洲和东南亚等海外消费市场。', 'Zhè jiā guóchǎn zhìnéng xīnnéngyuán qìchē pǐnpái zhèng quánlì tuòzhǎn Ōuzhōu hé Dōngnányà děng hǎiwài xiāofèi shìchǎng.', 'Thương hiệu ô tô năng lượng mới thông minh sản xuất trong nước này đang dốc toàn lực mở rộng các thị trường tiêu dùng hải ngoại như châu Âu và Đông Nam Á.', 'basic', 1),
      (v_id, '中国企业在积极参与海外重点能源交通基础设施特许经营权竞标时，高度重视契合东道国劳动环保法律法规与履行当地社会ESG社会责任。', 'Zhōngguó qǐyè zài jījí cānyù hǎiwài zhòngdiǎn néngyuán jiāotōng jīchǔ shèshī tèxǔ jīngyíngquán jìngbiāo shí, gāodù zhòngshì qìhé dōngdàoguó láodòng huánbǎo fǎlǜ fǎguī yǔ lǚxíng dāngdì shèhuì ESG shèhuì zérèn.', 'Các doanh nghiệp Trung Quốc khi tích cực tham gia đấu thầu quyền nhượng quyền khai thác cơ sở hạ tầng giao thông năng lượng trọng điểm ở hải ngoại, rất coi trọng việc phù hợp với luật định lao động và môi trường của nước sở tại và thực thi trách nhiệm xã hội ESG tại địa phương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2462] [海鲜] (hǎixiān) - hải sản, đồ biển [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '海鲜' AND pinyin = 'hǎixiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '海鲜' AND pinyin = 'hǎixiān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '海鲜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '海鲜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hǎixiān',
      meaning_vi = 'hải sản, đồ biển',
      example_hanzi = '来到美丽的海滨城市旅游度假，品尝新鲜捕捞的美味海鲜是大饱口福的最佳选择。',
      example_pinyin = 'Láidào měilì de hǎibīn chéngshì lǚyóu dùjià, pǐncháng xīnxiān bǔlāo de měiwèi hǎixiān shì dàbǎo-kǒufú de zuì jiǎ xuǎnzé.',
      example_vi = 'Đến thành phố ven biển xinh đẹp du lịch nghỉ dưỡng, thưởng thức hải sản tươi ngon vừa đánh bắt là sự lựa chọn tuyệt vời nhất để thỏa mãn vị giác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '海鲜',
      'hǎixiān',
      'hải sản, đồ biển',
      'Danh từ',
      'HSK 5',
      '来到美丽的海滨城市旅游度假，品尝新鲜捕捞的美味海鲜是大饱口福的最佳选择。',
      'Láidào měilì de hǎibīn chéngshì lǚyóu dùjià, pǐncháng xīnxiān bǔlāo de měiwèi hǎixiān shì dàbǎo-kǒufú de zuì jiǎ xuǎnzé.',
      'Đến thành phố ven biển xinh đẹp du lịch nghỉ dưỡng, thưởng thức hải sản tươi ngon vừa đánh bắt là sự lựa chọn tuyệt vời nhất để thỏa mãn vị giác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '来到美丽的海滨城市旅游度假，品尝新鲜捕捞的美味海鲜是大饱口福的最佳选择。', 'Láidào měilì de hǎibīn chéngshì lǚyóu dùjià, pǐncháng xīnxiān bǔlāo de měiwèi hǎixiān shì dàbǎo-kǒufú de zuì jiǎ xuǎnzé.', 'Đến thành phố ven biển xinh đẹp du lịch nghỉ dưỡng, thưởng thức hải sản tươi ngon vừa đánh bắt là sự lựa chọn tuyệt vời nhất để thỏa mãn vị giác.', 'basic', 1),
      (v_id, '依托现代化全程冷链物流航空专线与活鲜温控暂养技术，大西洋深海捕捞的珍贵活体海鲜仅需短短四十八小时即可摆上内陆消费者的餐桌。', 'Yītuō xiàndàihuà quánchéng lěngliàn wùliú hángkōng zhuānxiàn yǔ huóxiān wēnkòng zànyǎng jìshù, Dàxīyáng shēnhǎi bǔlāo de zhēnguì huótǐ hǎixiān jǐn xū duǎnduǎn sìshíbā xiǎoshí jíkě bǎi shàng nèilù xiāofèizhě de cānzhuō.', 'Nhờ vào tuyến chuyên cơ logistics chuỗi cung ứng lạnh toàn trình hiện đại và công nghệ nuôi nhốt tạm thời kiểm soát nhiệt độ hải sản sống, những loại hải sản sống quý giá đánh bắt từ vùng biển sâu Đại Tây Dương chỉ cần vỏn vẹn bốn mươi tám giờ là có thể dọn lên bàn ăn của người tiêu dùng vùng nội địa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2463] [含] (hán) - ngậm; chứa, bao hàm, ngụ ý [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '含' AND pinyin = 'hán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '含' AND pinyin = 'hán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '含'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '含'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'hán',
      meaning_vi = 'ngậm; chứa, bao hàm, ngụ ý',
      example_hanzi = '嗓子干咳疼痛时，可以在嘴里含一片润喉糖来有效缓解咽喉不适。',
      example_pinyin = 'Sǎngzi gānké téngtòng shí, kěyǐ zài zuǐ lǐ hán yí piàn rùnhóutáng lái yǒuxiào huǎnjiě yānhóu bùshì.',
      example_vi = 'Khi cổ họng ho khan đau rát, có thể ngậm một viên kẹo ngậm bổ họng trong miệng để làm dịu cảm giác khó chịu ở vòm họng một cách hiệu quả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '含',
      'hán',
      'ngậm; chứa, bao hàm, ngụ ý',
      'Động từ',
      'HSK 5',
      '嗓子干咳疼痛时，可以在嘴里含一片润喉糖来有效缓解咽喉不适。',
      'Sǎngzi gānké téngtòng shí, kěyǐ zài zuǐ lǐ hán yí piàn rùnhóutáng lái yǒuxiào huǎnjiě yānhóu bùshì.',
      'Khi cổ họng ho khan đau rát, có thể ngậm một viên kẹo ngậm bổ họng trong miệng để làm dịu cảm giác khó chịu ở vòm họng một cách hiệu quả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '嗓子干咳疼痛时，可以在嘴里含一片润喉糖来有效缓解咽喉不适。', 'Sǎngzi gānké téngtòng shí, kěyǐ zài zuǐ lǐ hán yí piàn rùnhóutáng lái yǒuxiào huǎnjiě yānhóu bùshì.', 'Khi cổ họng ho khan đau rát, có thể ngậm một viên kẹo ngậm bổ họng trong miệng để làm dịu cảm giác khó chịu ở vòm họng một cách hiệu quả.', 'basic', 1),
      (v_id, '老教授两眼含着欣慰的泪水，紧紧握住攻克了国家重大科研难题的年轻博士生的双手，久久不愿松开。', 'Lǎo jiàoshòu liǎngyǎn hán zhe xīnwèi de lèishuǐ, jǐnjǐn wòzhù gōngkè le guójiā zhòngdà kēyán nántí de niánqīng bóshìshēng de shuāngshǒu, jiǔjiǔ bú yuàn sōngkāi.', 'Vị giáo sư già hai mắt ngấn lệ xúc động vì tự hào, nắm chặt lấy đôi tay của nghiên cứu sinh tiến sĩ trẻ vừa chinh phục thành công bài toán khoa học trọng đại của quốc gia, hồi lâu không nỡ buông ra.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2464] [含量] (hánliàng) - hàm lượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '含量' AND pinyin = 'hánliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '含量' AND pinyin = 'hánliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '含量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '含量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hánliàng',
      meaning_vi = 'hàm lượng',
      example_hanzi = '新鲜橙子和猕猴桃中维生素C的含量非常丰富，经常食用能增强人体免疫力。',
      example_pinyin = 'Xīnxiān chéngzi hé míhóutáo zhōng wéishēngsù C de hánliàng fēicháng fēngfù, chángcháng shíyòng néng zēngqiáng réntǐ miǎnyìlì.',
      example_vi = 'Hàm lượng vitamin C trong cam tươi và quả kiwi vô cùng phong phú, thường xuyên ăn có thể tăng cường sức đề kháng miễn dịch của cơ thể con người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '含量',
      'hánliàng',
      'hàm lượng',
      'Danh từ',
      'HSK 5',
      '新鲜橙子和猕猴桃中维生素C的含量非常丰富，经常食用能增强人体免疫力。',
      'Xīnxiān chéngzi hé míhóutáo zhōng wéishēngsù C de hánliàng fēicháng fēngfù, chángcháng shíyòng néng zēngqiáng réntǐ miǎnyìlì.',
      'Hàm lượng vitamin C trong cam tươi và quả kiwi vô cùng phong phú, thường xuyên ăn có thể tăng cường sức đề kháng miễn dịch của cơ thể con người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新鲜橙子和猕猴桃中维生素C的含量非常丰富，经常食用能增强人体免疫力。', 'Xīnxiān chéngzi hé míhóutáo zhōng wéishēngsù C de hánliàng fēicháng fēngfù, chángcháng shíyòng néng zēngqiáng réntǐ miǎnyìlì.', 'Hàm lượng vitamin C trong cam tươi và quả kiwi vô cùng phong phú, thường xuyên ăn có thể tăng cường sức đề kháng miễn dịch của cơ thể con người.', 'basic', 1),
      (v_id, '地质矿产勘探队在深层岩芯取样中惊喜发现，该超大型伴生稀土矿床关键战略战略稀有金属的平均品位含量远超全球同类矿山均值。', 'Dìzhì kuàngchǎn kāntànduì zài shēncéng yánxīn qǔyàng zhōng jīngxǐ fāxiàn, gāi chāodàxíng bànshēng xītǔ kuàngchuáng guānjiàn zhànlüè xīyǒu jīnshǔ de píngjūn pǐnwèi hánliàng yuǎn chāo quánqiú tónglèi kuàngshān jūnzhí.', 'Đội thăm dò địa chất khoáng sản trong mẫu khoan lõi đá sâu bất ngờ phát hiện, hàm lượng phẩm vị trung bình của các kim loại hiếm chiến lược then chốt tại mỏ đất hiếm đi kèm siêu lớn này vượt xa giá trị bình quân của các mỏ tương tự trên toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2465] [含有] (hányǒu) - chứa, có chứa, hàm chứa [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '含有' AND pinyin = 'hányǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '含有' AND pinyin = 'hányǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '含有'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '含有'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'hányǒu',
      meaning_vi = 'chứa, có chứa, hàm chứa',
      example_hanzi = '深海鱼油中含有丰富的不饱和脂肪酸，对维护人体心脑血管健康大有裨益。',
      example_pinyin = 'Shēnhǎi yúyóu zhōng hányǒu fēngfù de bù bǎohé zhīfángsuān, duì wéihù réntǐ xīn-nǎoxiěguǎn jiànkāng dà yǒu bìyì.',
      example_vi = 'Dầu cá biển sâu có chứa phong phú các axit béo không bão hòa, mang lại lợi ích rất lớn đối với việc bảo vệ sức khỏe tim mạch và mạch máu não của con người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '含有',
      'hányǒu',
      'chứa, có chứa, hàm chứa',
      'Động từ',
      'HSK 5',
      '深海鱼油中含有丰富的不饱和脂肪酸，对维护人体心脑血管健康大有裨益。',
      'Shēnhǎi yúyóu zhōng hányǒu fēngfù de bù bǎohé zhīfángsuān, duì wéihù réntǐ xīn-nǎoxiěguǎn jiànkāng dà yǒu bìyì.',
      'Dầu cá biển sâu có chứa phong phú các axit béo không bão hòa, mang lại lợi ích rất lớn đối với việc bảo vệ sức khỏe tim mạch và mạch máu não của con người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '深海鱼油中含有丰富的不饱和脂肪酸，对维护人体心脑血管健康大有裨益。', 'Shēnhǎi yúyóu zhōng hányǒu fēngfù de bù bǎohé zhīfángsuān, duì wéihù réntǐ xīn-nǎoxiěguǎn jiànkāng dà yǒu bìyì.', 'Dầu cá biển sâu có chứa phong phú các axit béo không bão hòa, mang lại lợi ích rất lớn đối với việc bảo vệ sức khỏe tim mạch và mạch máu não của con người.', 'basic', 1),
      (v_id, '环境监测中心抽样化验报告证实，某化工企业违规偷排的工业废水中含有严重超标的高毒性重金属铅、镉及难降解有机污染物。', 'Huánjìng jiāncè zhōngxīn chōuyàng huàyàn bàogào zhèngshí, mǒu huàgōng qǐyè wéiguī tōupái de gōngyè fèishuǐ zhōng hányǒu yánzhòng chāobiāo de gāo dúxìng zhòngjīnshǔ qiān, gé jí nán jiàngjiě yǒujī wūrǎnwù.', 'Báo cáo kiểm nghiệm lấy mẫu của trung tâm quan trắc môi trường chứng thực, trong nước thải công nghiệp do một doanh nghiệp hóa chất xả trộm trái phép có chứa lượng kim loại nặng có độc tính cao như chì, cadimi và chất ô nhiễm hữu cơ khó phân hủy vượt chuẩn nghiêm trọng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2466] [汗水] (hànshuǐ) - mồ hôi, công sức, giọt mồ hôi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '汗水' AND pinyin = 'hànshuǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '汗水' AND pinyin = 'hànshuǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '汗水'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '汗水'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hànshuǐ',
      meaning_vi = 'mồ hôi, công sức, giọt mồ hôi',
      example_hanzi = '在激烈的篮球对抗赛结束后，球员们个个浑身湿透，脸上挂满了晶莹的汗水。',
      example_pinyin = 'Zài jīliè de lánqiú duìkàngsài jiéshù hòu, qiúyuán men gègè húnshēn shītòu, liǎn shang guàmǎn le jīngyíng de hànshuǐ.',
      example_vi = 'Sau khi trận thi đấu bóng rổ quyết liệt kết thúc, các cầu thủ ai nấy đều ướt đẫm toàn thân, trên gương mặt đọng đầy những giọt mồ hôi lấp lánh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '汗水',
      'hànshuǐ',
      'mồ hôi, công sức, giọt mồ hôi',
      'Danh từ',
      'HSK 5',
      '在激烈的篮球对抗赛结束后，球员们个个浑身湿透，脸上挂满了晶莹的汗水。',
      'Zài jīliè de lánqiú duìkàngsài jiéshù hòu, qiúyuán men gègè húnshēn shītòu, liǎn shang guàmǎn le jīngyíng de hànshuǐ.',
      'Sau khi trận thi đấu bóng rổ quyết liệt kết thúc, các cầu thủ ai nấy đều ướt đẫm toàn thân, trên gương mặt đọng đầy những giọt mồ hôi lấp lánh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在激烈的篮球对抗赛结束后，球员们个个浑身湿透，脸上挂满了晶莹的汗水。', 'Zài jīliè de lánqiú duìkàngsài jiéshù hòu, qiúyuán men gègè húnshēn shītòu, liǎn shang guàmǎn le jīngyíng de hànshuǐ.', 'Sau khi trận thi đấu bóng rổ quyết liệt kết thúc, các cầu thủ ai nấy đều ướt đẫm toàn thân, trên gương mặt đọng đầy những giọt mồ hôi lấp lánh.', 'basic', 1),
      (v_id, '每一项闪耀世界舞台的国家级重大科技攻关成果，无不凝结着几代科学家与大国工匠长年累月默默奉献付出的智慧、心血与辛勤汗水。', 'Měi yí xiàng shǎnyào shìjiè wǔtái de guójiājí zhòngdà kējì gōngguān chéngguǒ, wúbù níngjié zhe jǐ dài kēxuéjiā yǔ dàguó gōngjiàng chángnián-lěiyuè mòmò fèngxiàn fùchū de zhìhuì, xīnxuè yǔ xīnqín hànshuǐ.', 'Mỗi một thành quả đột phá khoa học công nghệ trọng đại cấp quốc gia tỏa sáng trên võ đài thế giới, đều kết tinh trí tuệ, tâm huyết và những giọt mồ hôi cần cù cống hiến âm thầm năm này qua tháng khác của nhiều thế hệ nhà khoa học và các nghệ nhân quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2467] [行] (háng) - hàng, dãy; ngành nghề, nghề nghiệp (đọc háng) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '行' AND pinyin = 'háng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行' AND pinyin = 'háng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '行'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'háng',
      meaning_vi = 'hàng, dãy; ngành nghề, nghề nghiệp (đọc háng)',
      example_hanzi = '俗话说“三百六十行，行行出状元”，只要踏实肯干，在任何岗位都能成就一番事业。',
      example_pinyin = 'Súhuà shuō “sānbǎi liùshí háng, hángháng chū zhuàngyuan”, zhǐyào tāshi kěn gàn, zài rènhé gǎngwèi dōu néng chéngjiù yì fān shìyè.',
      example_vi = 'Tục ngữ có câu "ba trăm sáu mươi nghề, nghề nào cũng có trạng nguyên", chỉ cần làm việc chắc chắn chịu khó, thì ở bất kỳ cương vị nào cũng có thể tạo dựng nên sự nghiệp vẻ vang.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '行',
      'háng',
      'hàng, dãy; ngành nghề, nghề nghiệp (đọc háng)',
      'Danh từ / Lượng từ',
      'HSK 5',
      '俗话说“三百六十行，行行出状元”，只要踏实肯干，在任何岗位都能成就一番事业。',
      'Súhuà shuō “sānbǎi liùshí háng, hángháng chū zhuàngyuan”, zhǐyào tāshi kěn gàn, zài rènhé gǎngwèi dōu néng chéngjiù yì fān shìyè.',
      'Tục ngữ có câu "ba trăm sáu mươi nghề, nghề nào cũng có trạng nguyên", chỉ cần làm việc chắc chắn chịu khó, thì ở bất kỳ cương vị nào cũng có thể tạo dựng nên sự nghiệp vẻ vang.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '俗话说“三百六十行，行行出状元”，只要踏实肯干，在任何岗位都能成就一番事业。', 'Súhuà shuō “sānbǎi liùshí háng, hángháng chū zhuàngyuan”, zhǐyào tāshi kěn gàn, zài rènhé gǎngwèi dōu néng chéngjiù yì fān shìyè.', 'Tục ngữ có câu "ba trăm sáu mươi nghề, nghề nào cũng có trạng nguyên", chỉ cần làm việc chắc chắn chịu khó, thì ở bất kỳ cương vị nào cũng có thể tạo dựng nên sự nghiệp vẻ vang.', 'basic', 1),
      (v_id, '随着移动互联网浪潮的深度重塑，不少传统实体零售巨头由于未能跟上时代前进步伐而纷纷面临跨界颠覆，不得不选择关店转型甚至无奈转行。', 'Suízhe yídòng hùliánwǎng làngcháo de shēndù chóngsù, bù shǎo chuántǒng shítǐ língshòu jùtóu yóuyú wèi néng gēnshàng shídài qiánjìn bùfá ér fēnfēn miànlín kuàjiè diānfù, bùdébù xuǎnzé guāndiàn zhuǎnxíng shènzhì wúnài zhuǎnháng.', 'Cùng với sự tái định hình sâu sắc của làn sóng internet di động, không ít gã khổng lồ bán lẻ truyền thống do không kịp theo kịp bước tiến của thời đại nên đều phải đối mặt với sự đảo lộn xuyên ngành, buộc lòng phải chọn đóng cửa chuyển đổi mô hình thậm chí ngậm ngùi chuyển nghề.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2468] [行业] (hángyè) - ngành nghề, lĩnh vực kinh doanh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '行业' AND pinyin = 'hángyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行业' AND pinyin = 'hángyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '行业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hángyè',
      meaning_vi = 'ngành nghề, lĩnh vực kinh doanh',
      example_hanzi = '随着全球对环境保护的重视，新能源与节能环保已经成为了当下最具发展前景的朝阳行业。',
      example_pinyin = 'Suízhe quánqiú duì huánjìng bǎohù de zhòngshì, xīnnéngyuán yǔ jiénéng huánbǎo yǐjīng chéngwéi le dāngxià zuì jù fāzhǎn qiánjǐng de zhāoyáng hángyè.',
      example_vi = 'Cùng với sự coi trọng của toàn cầu đối với bảo vệ môi trường, năng lượng mới và tiết kiệm năng lượng bảo vệ môi trường đã trở thành ngành nghề bình minh có triển vọng phát triển nhất hiện nay.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '行业',
      'hángyè',
      'ngành nghề, lĩnh vực kinh doanh',
      'Danh từ',
      'HSK 5',
      '随着全球对环境保护的重视，新能源与节能环保已经成为了当下最具发展前景的朝阳行业。',
      'Suízhe quánqiú duì huánjìng bǎohù de zhòngshì, xīnnéngyuán yǔ jiénéng huánbǎo yǐjīng chéngwéi le dāngxià zuì jù fāzhǎn qiánjǐng de zhāoyáng hángyè.',
      'Cùng với sự coi trọng của toàn cầu đối với bảo vệ môi trường, năng lượng mới và tiết kiệm năng lượng bảo vệ môi trường đã trở thành ngành nghề bình minh có triển vọng phát triển nhất hiện nay.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着全球对环境保护的重视，新能源与节能环保已经成为了当下最具发展前景的朝阳行业。', 'Suízhe quánqiú duì huánjìng bǎohù de zhòngshì, xīnnéngyuán yǔ jiénéng huánbǎo yǐjīng chéngwéi le dāngxià zuì jù fāzhǎn qiánjǐng de zhāoyáng hángyè.', 'Cùng với sự coi trọng của toàn cầu đối với bảo vệ môi trường, năng lượng mới và tiết kiệm năng lượng bảo vệ môi trường đã trở thành ngành nghề bình minh có triển vọng phát triển nhất hiện nay.', 'basic', 1),
      (v_id, '国家工信部与行业协会联合颁布了智能网联新能源汽车行业技术准入安全标准，旨在规范引导行业从低水平无序价格战走向高质量技术创新引领。', 'Guójiā Gōngxìnbù yǔ hángyè xiéhuì liánhé bānbù le zhìnéng wǎnglián xīnnéngyuán qìchē hángyè jìshù zhǔnrù ānquán biāozhǔn, zhǐzài guīfàn yǐndǎo hángyè cóng dī shuǐpíng wúxù jiàgézhàn zǒuxiàng gāo zhìliàng jìshù chuàngxīn yǐnlǐng.', 'Bộ Công nghiệp và Công nghệ thông tin cùng hiệp hội ngành nghề đã phối hợp ban hành tiêu chuẩn an toàn gia nhập kỹ thuật ngành ô tô năng lượng mới kết nối mạng thông minh, nhằm chuẩn hóa định hướng toàn ngành từ cuộc chiến giảm giá vô trật tự trình độ thấp bước sang dẫn dắt bằng đổi mới công nghệ chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2469] [好评] (hǎopíng) - đánh giá tốt, khen ngợi, phản hồi tích cực [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '好评' AND pinyin = 'hǎopíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好评' AND pinyin = 'hǎopíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '好评'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好评'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'hǎopíng',
      meaning_vi = 'đánh giá tốt, khen ngợi, phản hồi tích cực',
      example_hanzi = '这部由著名作家长篇小说改编而成的历史话剧在国家大剧院首演后，获得了现场观众的一致好评。',
      example_pinyin = 'Zhè bù yóu zhùmíng zuòjiā chángpiān xiǎoshuō gǎibiān ér chéng de lìshǐ huàjù zài guójiā dà jùyuàn shǒuyǎn hòu, huòdé le xiànchǎng guānzhòng de yízhì hǎopíng.',
      example_vi = 'Vở kịch nói lịch sử được chuyển thể từ tiểu thuyết dài tập của nhà văn nổi tiếng sau khi công diễn tại Nhà hát Lớn Quốc gia đã nhận được sự đánh giá tốt nhất trí của khán giả có mặt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '好评',
      'hǎopíng',
      'đánh giá tốt, khen ngợi, phản hồi tích cực',
      'Danh từ / Động từ',
      'HSK 5',
      '这部由著名作家长篇小说改编而成的历史话剧在国家大剧院首演后，获得了现场观众的一致好评。',
      'Zhè bù yóu zhùmíng zuòjiā chángpiān xiǎoshuō gǎibiān ér chéng de lìshǐ huàjù zài guójiā dà jùyuàn shǒuyǎn hòu, huòdé le xiànchǎng guānzhòng de yízhì hǎopíng.',
      'Vở kịch nói lịch sử được chuyển thể từ tiểu thuyết dài tập của nhà văn nổi tiếng sau khi công diễn tại Nhà hát Lớn Quốc gia đã nhận được sự đánh giá tốt nhất trí của khán giả có mặt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这部由著名作家长篇小说改编而成的历史话剧在国家大剧院首演后，获得了现场观众的一致好评。', 'Zhè bù yóu zhùmíng zuòjiā chángpiān xiǎoshuō gǎibiān ér chéng de lìshǐ huàjù zài guójiā dà jùyuàn shǒuyǎn hòu, huòdé le xiànchǎng guānzhòng de yízhì hǎopíng.', 'Vở kịch nói lịch sử được chuyển thể từ tiểu thuyết dài tập của nhà văn nổi tiếng sau khi công diễn tại Nhà hát Lớn Quốc gia đã nhận được sự đánh giá tốt nhất trí của khán giả có mặt.', 'basic', 1),
      (v_id, '该跨境电商品牌凭借严苛的品控标准、二十四小时极速售后退换货保障以及人性化的多语言客服体系，在海外主流电商平台长期保持着高达百分之九十九的用户好评率。', 'Gāi kuàjìng diànshāng pǐnpái píngjiè yánkē de pǐnkòng biāozhǔn, èrshísì xiǎoshí jísù shòuhòu tuì-huànhuò bǎozhàng yǐjí rénxìnghuà de duō yǔyán kèfù tǐxì, zài hǎiwài zhǔliú diànshāng píngtái chángqī bǎochí zhe gāo dá bǎifēnzhī jiǔshíjiǔ de yònghù hǎopínglǜ.', 'Thương hiệu thương mại điện tử xuyên biên giới này dựa vào tiêu chuẩn kiểm soát chất lượng khắt khe, cam kết đổi trả hàng sau bán siêu tốc trong hai mươi bốn giờ cùng hệ thống chăm sóc khách hàng đa ngôn ngữ nhân văn, đã duy trì tỷ lệ đánh giá tốt của người dùng lên tới chín mươi chín phần trăm trong thời gian dài trên các sàn thương mại điện tử lớn ở nước ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2470] [好运] (hǎoyùn) - vận may, may mắn, điềm lành [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '好运' AND pinyin = 'hǎoyùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好运' AND pinyin = 'hǎoyùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '好运'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好运'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hǎoyùn',
      meaning_vi = 'vận may, may mắn, điềm lành',
      example_hanzi = '明天你就要走进全国研究生招生考试的考场了，祝你一切顺利、好运相伴！',
      example_pinyin = 'Míngtiān nǐ jiù yào zǒujìn quánguó yánjiūshēng zhāoshēng kǎoshì de kǎochǎng le, zhù nǐ yíqiè shùnlì, hǎoyùn xiāngbàn!',
      example_vi = 'Ngày mai bạn đã bước vào phòng thi của kỳ thi tuyển sinh nghiên cứu sinh toàn quốc rồi, chúc bạn mọi sự thuận lợi và luôn gặp may mắn!'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '好运',
      'hǎoyùn',
      'vận may, may mắn, điềm lành',
      'Danh từ',
      'HSK 5',
      '明天你就要走进全国研究生招生考试的考场了，祝你一切顺利、好运相伴！',
      'Míngtiān nǐ jiù yào zǒujìn quánguó yánjiūshēng zhāoshēng kǎoshì de kǎochǎng le, zhù nǐ yíqiè shùnlì, hǎoyùn xiāngbàn!',
      'Ngày mai bạn đã bước vào phòng thi của kỳ thi tuyển sinh nghiên cứu sinh toàn quốc rồi, chúc bạn mọi sự thuận lợi và luôn gặp may mắn!'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '明天你就要走进全国研究生招生考试的考场了，祝你一切顺利、好运相伴！', 'Míngtiān nǐ jiù yào zǒujìn quánguó yánjiūshēng zhāoshēng kǎoshì de kǎochǎng le, zhù nǐ yíqiè shùnlì, hǎoyùn xiāngbàn!', 'Ngày mai bạn đã bước vào phòng thi của kỳ thi tuyển sinh nghiên cứu sinh toàn quốc rồi, chúc bạn mọi sự thuận lợi và luôn gặp may mắn!', 'basic', 1),
      (v_id, '成功的创业者深知，所谓的好运从来不是凭空降临的偶然馈赠，而是日复一日坚韧不拔的苦功积累与当重大时代风口机遇来临时能够敏锐捕获的必然回馈。', 'Chénggōng de chuàngyèzhě shēnzhī, suǒwèi de hǎoyùn cónglái bú shì píngkōng jiànglín de ǒurán kuìzèng, ér shì rì fù yí rì jiānrèn-bùbá de kǔgōng jīlěi yǔ dāng zhòngdà shídài fēngkǒu jīyù láilín shí nénggòu mǐnruì bǔhuò de bìrán huíkuì.', 'Các nhà khởi nghiệp thành công hiểu sâu sắc rằng, cái gọi là vận may chưa bao giờ là món quà ngẫu nhiên từ trên trời rơi xuống, mà là sự đền đáp tất yếu từ sự tích lũy công phu kiên định ngày qua ngày cùng khả năng nhạy bén bắt trọn khi cơ hội đón đầu làn sóng thời đại trọng đại ùa tới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2471] [好转] (hǎozhuǎn) - chuyển biến tốt, khởi sắc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '好转' AND pinyin = 'hǎozhuǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好转' AND pinyin = 'hǎozhuǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '好转'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好转'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'hǎozhuǎn',
      meaning_vi = 'chuyển biến tốt, khởi sắc',
      example_hanzi = '在按时服用医生开具的抗生素并卧床充分休息之后，他的高烧病情已经大有好转。',
      example_pinyin = 'Zài ànshí fúyòng yīshēng kāijù de kàngshēngsù bìng wòchuáng chōngfèn xiūxi zhīhòu, tā de gāoshāo bìngqíng yǐjīng dà yǒu hǎozhuǎn.',
      example_vi = 'Sau khi uống thuốc kháng sinh do bác sĩ kê đơn đúng giờ và nằm nghỉ ngơi đầy đủ, bệnh tình sốt cao của anh ấy đã chuyển biến tốt lên rất nhiều.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '好转',
      'hǎozhuǎn',
      'chuyển biến tốt, khởi sắc',
      'Động từ',
      'HSK 5',
      '在按时服用医生开具的抗生素并卧床充分休息之后，他的高烧病情已经大有好转。',
      'Zài ànshí fúyòng yīshēng kāijù de kàngshēngsù bìng wòchuáng chōngfèn xiūxi zhīhòu, tā de gāoshāo bìngqíng yǐjīng dà yǒu hǎozhuǎn.',
      'Sau khi uống thuốc kháng sinh do bác sĩ kê đơn đúng giờ và nằm nghỉ ngơi đầy đủ, bệnh tình sốt cao của anh ấy đã chuyển biến tốt lên rất nhiều.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在按时服用医生开具的抗生素并卧床充分休息之后，他的高烧病情已经大有好转。', 'Zài ànshí fúyòng yīshēng kāijù de kàngshēngsù bìng wòchuáng chōngfèn xiūxi zhīhòu, tā de gāoshāo bìngqíng yǐjīng dà yǒu hǎozhuǎn.', 'Sau khi uống thuốc kháng sinh do bác sĩ kê đơn đúng giờ và nằm nghỉ ngơi đầy đủ, bệnh tình sốt cao của anh ấy đã chuyển biến tốt lên rất nhiều.', 'basic', 1),
      (v_id, '得益于央行适时实施降准降息组合拳与地方政府出台的一揽子稳楼市促消费政策，全国房地产市场预期与核心城市商品住宅成交量呈现出积极的好转势头。', 'Déyì yú yāngháng shìshí shíshī jiàngzhǔn jiàngxī zǔhéquán yǔ dìfāng zhèngfǔ chūtái de yìlǎnzi wěn lóushì cù xiāofèi zhèngcè, quánguó fángdìchǎn shìchǎng yùqī yǔ héxīn chéngshì shāngpǐn zhùzhái chéngjiāoliàng chéngxiàn chū jījí de hǎozhuǎn shìtóu.', 'Nhờ vào việc ngân hàng trung ương kịp thời thực thi đòn bẩy kết hợp hạ tỷ lệ dự trữ bắt buộc và giảm lãi suất cùng gói chính sách ổn định thị trường bất động sản kích cầu tiêu dùng của chính quyền địa phương, kỳ vọng thị trường bất động sản toàn quốc và lượng giao dịch nhà ở thương mại tại các đô thị trọng điểm đã xuất hiện đà chuyển biến khởi sắc tích cực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2472] [好] (hào) - thích, chuộng, đam mê (đọc hào) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '好' AND pinyin = 'hào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好' AND pinyin = 'hào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '好'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'hào',
      meaning_vi = 'thích, chuộng, đam mê (đọc hào)',
      example_hanzi = '他从小好动好问，对大自然中各种各样的昆虫和花草充满了浓厚的好奇心。',
      example_pinyin = 'Tā cóngxiǎo hào dòng hào wèn, duì dàzìrán zhōng gèzhǒng-gèyàng de kūnchóng hé huācǎo chōngmǎn le nónghòu de hàoqíxīn.',
      example_vi = 'Từ nhỏ anh ấy đã hiếu động và thích hỏi, luôn tràn đầy lòng hiếu kỳ nồng nhiệt đối với muôn vàn loài côn trùng và hoa cỏ trong thế giới tự nhiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '好',
      'hào',
      'thích, chuộng, đam mê (đọc hào)',
      'Động từ',
      'HSK 5',
      '他从小好动好问，对大自然中各种各样的昆虫和花草充满了浓厚的好奇心。',
      'Tā cóngxiǎo hào dòng hào wèn, duì dàzìrán zhōng gèzhǒng-gèyàng de kūnchóng hé huācǎo chōngmǎn le nónghòu de hàoqíxīn.',
      'Từ nhỏ anh ấy đã hiếu động và thích hỏi, luôn tràn đầy lòng hiếu kỳ nồng nhiệt đối với muôn vàn loài côn trùng và hoa cỏ trong thế giới tự nhiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他从小好动好问，对大自然中各种各样的昆虫和花草充满了浓厚的好奇心。', 'Tā cóngxiǎo hào dòng hào wèn, duì dàzìrán zhōng gèzhǒng-gèyàng de kūnchóng hé huācǎo chōngmǎn le nónghòu de hàoqíxīn.', 'Từ nhỏ anh ấy đã hiếu động và thích hỏi, luôn tràn đầy lòng hiếu kỳ nồng nhiệt đối với muôn vàn loài côn trùng và hoa cỏ trong thế giới tự nhiên.', 'basic', 1),
      (v_id, '这位学贯中西的资深国学大师生平雅好金石书画古籍善本，不仅精于考据辨伪，更将毕生珍藏的数百件宋元珍品无偿捐献给了故宫博物院。', 'Zhè wèi xuéguàn-zhōngxī de zīshēn guóxué dàshī shēngpíng yǎhào jīnshí shūhuà gǔjí shànběn, bùjǐn jīng yú kǎojù biànwěi, gèng jiāng bìshēng zhēncáng de shù bǎi jiàn Sòng-Yuán zhēnpǐn wúcháng juānxiàn gěi le Gùgōng Bówùyuàn.', 'Vị đại sư quốc học kỳ cựu học rộng thông hiểu cả văn hóa Trung Hoa lẫn phương Tây này cả đời có thú tao nhã chuộng kim thạch thư họa cùng sách cổ quý hiếm, không chỉ tinh thông khảo chứng phân biệt thật giả, mà còn đem hàng trăm món đồ trân quý thời Tống Nguyên tích lũy cả đời hiến tặng vô điều kiện cho Viện bảo tàng Cố Cung.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2473] [好奇] (hàoqí) - tò mò, hiếu kỳ [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '好奇' AND pinyin = 'hàoqí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好奇' AND pinyin = 'hàoqí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '好奇'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '好奇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'hàoqí',
      meaning_vi = 'tò mò, hiếu kỳ',
      example_hanzi = '天真烂漫的小朋友们怀着强烈的好奇心，目不转睛地看着魔术师在舞台上变出各种戏法。',
      example_pinyin = 'Tiānzhēn-lànmàn de xiǎopéngyou men huáizhe qiángliè de hàoqíxīn, mùbùzhuǎnjīng de kànzhe móshùshī zài wǔtái shang biàn chū gèzhǒng xìfǎ.',
      example_vi = 'Các bạn nhỏ ngây thơ hồn nhiên ôm lòng tò mò mãnh liệt, chăm chú không chớp mắt nhìn nhà ảo thuật biểu diễn đủ các trò biến hóa trên sân khấu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '好奇',
      'hàoqí',
      'tò mò, hiếu kỳ',
      'Tính từ / Danh từ',
      'HSK 5',
      '天真烂漫的小朋友们怀着强烈的好奇心，目不转睛地看着魔术师在舞台上变出各种戏法。',
      'Tiānzhēn-lànmàn de xiǎopéngyou men huáizhe qiángliè de hàoqíxīn, mùbùzhuǎnjīng de kànzhe móshùshī zài wǔtái shang biàn chū gèzhǒng xìfǎ.',
      'Các bạn nhỏ ngây thơ hồn nhiên ôm lòng tò mò mãnh liệt, chăm chú không chớp mắt nhìn nhà ảo thuật biểu diễn đủ các trò biến hóa trên sân khấu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天真烂漫的小朋友们怀着强烈的好奇心，目不转睛地看着魔术师在舞台上变出各种戏法。', 'Tiānzhēn-lànmàn de xiǎopéngyou men huáizhe qiángliè de hàoqíxīn, mùbùzhuǎnjīng de kànzhe móshùshī zài wǔtái shang biàn chū gèzhǒng xìfǎ.', 'Các bạn nhỏ ngây thơ hồn nhiên ôm lòng tò mò mãnh liệt, chăm chú không chớp mắt nhìn nhà ảo thuật biểu diễn đủ các trò biến hóa trên sân khấu.', 'basic', 1),
      (v_id, '对浩瀚未知宇宙与微观量子世界的纯粹好奇心与探索欲，始终是推动人类基础科学研究不断冲破认知边界、实现划时代突破的最根本原始驱动力。', 'Duì hàohàn wèizhī yǔzhòu yǔ wēiguān liàngzǐ shìjiè de chúncuì hàoqíxīn yǔ tànsuǒyù, shǐzhōng shì tuīdòng rénlèi jīchǔ kēxué yánjiū búduàn chōngpò rènzhī biānjiè, shíxiàn huàshídài tūpò de zuì gēnběn yuánshǐ qūdònglì.', 'Lòng hiếu kỳ thuần túy và khát khao khám phá đối với vũ trụ bao la chưa biết cùng thế giới lượng tử vi mô, luôn là động lực nguyên bản căn bản nhất thúc đẩy nghiên cứu khoa học cơ bản của nhân loại không ngừng phá vỡ ranh giới nhận thức và thực hiện những bước đột phá mang tính thời đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2474] [合] (hé) - hợp, khép lại, gộp lại, tương xứng, phù hợp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '合' AND pinyin = 'hé'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合' AND pinyin = 'hé'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '合'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'hé',
      meaning_vi = 'hợp, khép lại, gộp lại, tương xứng, phù hợp',
      example_hanzi = '读完这本令人深思的哲学名著后，他缓缓合上书本，静静地闭目思考良久。',
      example_pinyin = 'Dú wán zhè běn lìngrén shēnsī de zhéxué míngzhù hòu, tā huǎnhuǎn hé shàng shūběn, jìngjìng de bìmù sīkǎo liángjiǔ.',
      example_vi = 'Sau khi đọc xong cuốn danh tác triết học khiến người ta phải suy ngẫm sâu sắc này, anh ấy từ từ khép cuốn sách lại, lặng lẽ nhắm mắt trầm ngâm suy nghĩ hồi lâu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '合',
      'hé',
      'hợp, khép lại, gộp lại, tương xứng, phù hợp',
      'Động từ',
      'HSK 5',
      '读完这本令人深思的哲学名著后，他缓缓合上书本，静静地闭目思考良久。',
      'Dú wán zhè běn lìngrén shēnsī de zhéxué míngzhù hòu, tā huǎnhuǎn hé shàng shūběn, jìngjìng de bìmù sīkǎo liángjiǔ.',
      'Sau khi đọc xong cuốn danh tác triết học khiến người ta phải suy ngẫm sâu sắc này, anh ấy từ từ khép cuốn sách lại, lặng lẽ nhắm mắt trầm ngâm suy nghĩ hồi lâu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '读完这本令人深思的哲学名著后，他缓缓合上书本，静静地闭目思考良久。', 'Dú wán zhè běn lìngrén shēnsī de zhéxué míngzhù hòu, tā huǎnhuǎn hé shàng shūběn, jìngjìng de bìmù sīkǎo liángjiǔ.', 'Sau khi đọc xong cuốn danh tác triết học khiến người ta phải suy ngẫm sâu sắc này, anh ấy từ từ khép cuốn sách lại, lặng lẽ nhắm mắt trầm ngâm suy nghĩ hồi lâu.', 'basic', 1),
      (v_id, '在全球气候治理与绿色发展多边谈判中，各国代表求同存异、相向而行，最终达成了完全符合联合国气候变化框架公约精神的里程碑式联合协议。', 'Zài quánqiú qìhòu zhìlǐ yǔ lǜsè fāzhǎn duōbiān tánpàn zhōng, gè guó dàibiǎo qiútóng-cúnyì, xiāngxiàng-érxíng, zuìzhōng dáchéng le wánquán fúhé Liánhéguó Qìhòu Biànhuà Kuàngjià Gōngyuē jīngshén de lǐchéngbēishì liánhé xiéyì.', 'Trong đàm phán đa phương về quản trị khí hậu toàn cầu và phát triển xanh, đại diện các nước đã tìm kiếm điểm chung gác lại bất đồng, cùng đi về một hướng, cuối cùng đã đạt được hiệp định liên hiệp mang tính cột mốc hoàn toàn phù hợp với tinh thần của Công ước khung Liên Hợp Quốc về Biến đổi Khí hậu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2475] [合法] (héfǎ) - hợp pháp, đúng pháp luật [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '合法' AND pinyin = 'héfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合法' AND pinyin = 'héfǎ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '合法'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'héfǎ',
      meaning_vi = 'hợp pháp, đúng pháp luật',
      example_hanzi = '劳动合同法旨在依法保护用人单位与劳动者双方平等的合法劳动权益。',
      example_pinyin = 'Láodòng Hétong Fǎ zhǐzài yīfǎ bǎohù yòngrén dānwèi yǔ láodòngzhě shuāngfāng píngděng de héfǎ láodòng quányì.',
      example_vi = 'Luật Hợp đồng lao động nhằm mục đích bảo vệ theo pháp luật quyền lợi lao động hợp pháp bình đẳng của cả đơn vị sử dụng lao động và người lao động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '合法',
      'héfǎ',
      'hợp pháp, đúng pháp luật',
      'Tính từ',
      'HSK 5',
      '劳动合同法旨在依法保护用人单位与劳动者双方平等的合法劳动权益。',
      'Láodòng Hétong Fǎ zhǐzài yīfǎ bǎohù yòngrén dānwèi yǔ láodòngzhě shuāngfāng píngděng de héfǎ láodòng quányì.',
      'Luật Hợp đồng lao động nhằm mục đích bảo vệ theo pháp luật quyền lợi lao động hợp pháp bình đẳng của cả đơn vị sử dụng lao động và người lao động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '劳动合同法旨在依法保护用人单位与劳动者双方平等的合法劳动权益。', 'Láodòng Hétong Fǎ zhǐzài yīfǎ bǎohù yòngrén dānwèi yǔ láodòngzhě shuāngfāng píngděng de héfǎ láodòng quányì.', 'Luật Hợp đồng lao động nhằm mục đích bảo vệ theo pháp luật quyền lợi lao động hợp pháp bình đẳng của cả đơn vị sử dụng lao động và người lao động.', 'basic', 1),
      (v_id, '在推动跨境数据流动与数字贸易便利化过程中，监管部门明确要求跨境电商与跨国云服务企业必须在严格遵循驻在国数据安全法律法规的前提下合法合规开展经营。', 'Zài tuīdòng kuàjìng shùjù liúdòng yǔ shùzì màoyì biànlìhuà guòchéng zhōng, jiānguǎn bùmén míngquè yāoqiú kuàjìng diànshāng yǔ kuàguó yúnfúwù qǐyè bìxū zài yángé zūnxún zhùzàiguó shùjù ānquán fǎlǜ fǎguī de qiántí xià héfǎ hégūi kāizhǎn jīngyíng.', 'Trong quá trình thúc đẩy dòng chảy dữ liệu xuyên biên giới và tạo thuận lợi cho thương mại số, các cơ quan giám sát đã yêu cầu rõ ràng các doanh nghiệp thương mại điện tử xuyên biên giới và dịch vụ đám mây đa quốc gia phải triển khai kinh doanh hợp pháp hợp quy dưới tiền đề tuân thủ nghiêm ngặt các quy định pháp luật về an toàn dữ liệu của nước sở tại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2476] [盒饭] (héfàn) - cơm hộp, suất cơm hộp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '盒饭' AND pinyin = 'héfàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '盒饭' AND pinyin = 'héfàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '盒饭'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '盒饭'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'héfàn',
      meaning_vi = 'cơm hộp, suất cơm hộp',
      example_hanzi = '中午工作太忙没有时间外出就餐，他和同事们便在办公室里吃了一份快餐盒饭。',
      example_pinyin = 'Zhōngwǔ gōngzuò tài máng méiyǒu shíjiān wàichū jiùcān, tā hé tóngshì men biàn zài bàngōngshì lǐ chī le yí fèn kuàicān héfàn.',
      example_vi = 'Buổi trưa công việc quá bận rộn không có thời gian ra ngoài dùng bữa, anh ấy và các đồng nghiệp liền ăn một suất cơm hộp thức ăn nhanh ngay tại văn phòng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '盒饭',
      'héfàn',
      'cơm hộp, suất cơm hộp',
      'Danh từ',
      'HSK 5',
      '中午工作太忙没有时间外出就餐，他和同事们便在办公室里吃了一份快餐盒饭。',
      'Zhōngwǔ gōngzuò tài máng méiyǒu shíjiān wàichū jiùcān, tā hé tóngshì men biàn zài bàngōngshì lǐ chī le yí fèn kuàicān héfàn.',
      'Buổi trưa công việc quá bận rộn không có thời gian ra ngoài dùng bữa, anh ấy và các đồng nghiệp liền ăn một suất cơm hộp thức ăn nhanh ngay tại văn phòng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中午工作太忙没有时间外出就餐，他和同事们便在办公室里吃了一份快餐盒饭。', 'Zhōngwǔ gōngzuò tài máng méiyǒu shíjiān wàichū jiùcān, tā hé tóngshì men biàn zài bàngōngshì lǐ chī le yí fèn kuàicān héfàn.', 'Buổi trưa công việc quá bận rộn không có thời gian ra ngoài dùng bữa, anh ấy và các đồng nghiệp liền ăn một suất cơm hộp thức ăn nhanh ngay tại văn phòng.', 'basic', 1),
      (v_id, '高速铁路客运部门在长途复兴号高铁列车上推出了多款营养均衡、明码标价的现烹热链平价特色盒饭，极大地改善了旅客长途旅途中的用餐体验。', 'Gāosù tiělù kèyùn bùmén zài chángtú Fùxīnghào gāotiě lièchē shang tuīchū le duō kuǎn yíngyǎng jūnhéng, míngmǎ-biāojià de xiàn pēng rèliàn píngjià tèsè héfàn, jídà de gǎishàn le lǚkè chángtú lǚtú zhōng de yòngcān tǐyàn.', 'Bộ phận vận tải hành khách đường sắt cao tốc đã cho ra mắt nhiều mẫu cơm hộp đặc sản bình dân chuỗi nóng nấu tươi niêm yết giá rõ ràng và dinh dưỡng cân bằng trên các chuyến tàu cao tốc Phục Hưng đường dài, cải thiện rất lớn trải nghiệm ăn uống trong chuyến hành trình dài của hành khách.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2477] [合理] (hélǐ) - hợp lý, chính đáng [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '合理' AND pinyin = 'hélǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合理' AND pinyin = 'hélǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '合理'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'hélǐ',
      meaning_vi = 'hợp lý, chính đáng',
      example_hanzi = '制定学习计划时一定要结合自身的实际水平，合理安排每天的复习与休息时间。',
      example_pinyin = 'Zhìdìng xuéxí jìhuà shí yídìng yào jiéhé zìshēn de shíjì shuǐpíng, hélǐ ānpái měitiān de fùxí yǔ xiūxi shíjiān.',
      example_vi = 'Khi lập kế hoạch học tập nhất định phải kết hợp với trình độ thực tế của bản thân, sắp xếp hợp lý thời gian ôn tập và nghỉ ngơi mỗi ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '合理',
      'hélǐ',
      'hợp lý, chính đáng',
      'Tính từ',
      'HSK 5',
      '制定学习计划时一定要结合自身的实际水平，合理安排每天的复习与休息时间。',
      'Zhìdìng xuéxí jìhuà shí yídìng yào jiéhé zìshēn de shíjì shuǐpíng, hélǐ ānpái měitiān de fùxí yǔ xiūxi shíjiān.',
      'Khi lập kế hoạch học tập nhất định phải kết hợp với trình độ thực tế của bản thân, sắp xếp hợp lý thời gian ôn tập và nghỉ ngơi mỗi ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '制定学习计划时一定要结合自身的实际水平，合理安排每天的复习与休息时间。', 'Zhìdìng xuéxí jìhuà shí yídìng yào jiéhé zìshēn de shíjì shuǐpíng, hélǐ ānpái měitiān de fùxí yǔ xiūxi shíjiān.', 'Khi lập kế hoạch học tập nhất định phải kết hợp với trình độ thực tế của bản thân, sắp xếp hợp lý thời gian ôn tập và nghỉ ngơi mỗi ngày.', 'basic', 1),
      (v_id, '物价监管部门依据成本调查与社会承受能力测算，指导城市供暖与公共交通企业制定出更加科学合理、兼顾公益与可持续运营的阶梯收费标准。', 'Wùjià jiānguǎn bùmén yījù chéngběn diàochá yǔ shèhuì chéngshòu nénglì cèsuàn, zhǐdǎo chéngshì gōngnuǎn yǔ gōnggòng jiāotōng qǐyè zhìdìng chū gèngjiā kēxué hélǐ, jiāngù gōngyì yǔ kěchíxù yùnyíng de jiētī shōufèi biāozhǔn.', 'Cơ quan quản lý giá cả dựa trên khảo sát chi phí và tính toán khả năng chi trả của xã hội, đã hướng dẫn các doanh nghiệp cấp nhiệt sưởi ấm và giao thông công cộng đô thị xây dựng khung tiêu chuẩn thu phí bậc thang khoa học hợp lý hơn, vừa đảm bảo tính công ích vừa duy trì vận hành bền vững.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2478] [河流] (héliú) - sông, dòng sông, lưu vực sông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '河流' AND pinyin = 'héliú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '河流' AND pinyin = 'héliú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '河流'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '河流'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'héliú',
      meaning_vi = 'sông, dòng sông, lưu vực sông',
      example_hanzi = '长江和黄河是发源于青藏高原、奔流向东横贯华夏大地的两条著名河流。',
      example_pinyin = 'Cháng Jiāng hé Huáng Hé shì fāyuán yú Qīng-Zàng Gāoyuán, bēnliú xiàng dōng héngguàn Huáxià dàdì de liǎng tiáo zhùmíng héliú.',
      example_vi = 'Trường Giang và Hoàng Hà là hai con sông nổi tiếng bắt nguồn từ cao nguyên Thanh Tạng, cuồn cuộn chảy về hướng đông vắt ngang qua mảnh đất Trung Hoa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '河流',
      'héliú',
      'sông, dòng sông, lưu vực sông',
      'Danh từ',
      'HSK 5',
      '长江和黄河是发源于青藏高原、奔流向东横贯华夏大地的两条著名河流。',
      'Cháng Jiāng hé Huáng Hé shì fāyuán yú Qīng-Zàng Gāoyuán, bēnliú xiàng dōng héngguàn Huáxià dàdì de liǎng tiáo zhùmíng héliú.',
      'Trường Giang và Hoàng Hà là hai con sông nổi tiếng bắt nguồn từ cao nguyên Thanh Tạng, cuồn cuộn chảy về hướng đông vắt ngang qua mảnh đất Trung Hoa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长江和黄河是发源于青藏高原、奔流向东横贯华夏大地的两条著名河流。', 'Cháng Jiāng hé Huáng Hé shì fāyuán yú Qīng-Zàng Gāoyuán, bēnliú xiàng dōng héngguàn Huáxià dàdì de liǎng tiáo zhùmíng héliú.', 'Trường Giang và Hoàng Hà là hai con sông nổi tiếng bắt nguồn từ cao nguyên Thanh Tạng, cuồn cuộn chảy về hướng đông vắt ngang qua mảnh đất Trung Hoa.', 'basic', 1),
      (v_id, '沿江省市全面推行河长制并实施长江十年禁渔计划，狠抓流域上下游水污染协同治理，使得这条母亲河流域的水生生物多样性得到了显著恢复。', 'Yánjiāng shěng-shì quánmiàn tuīxíng hézhǎngzhì bìng shíshī Cháng Jiāng shí nián jìnyú jìhuà, hěnzhuā liúyù shàng-xiàyóu shuǐwūrǎn xiétóng zhìlǐ, shǐdé zhè tiáo mǔqīn hé liúyù de shuǐshēng shēngwù duōyàngxìng dédào le xiǎnzhù huīfù.', 'Các tỉnh thành phố ven sông đã triển khai toàn diện chế độ trưởng sông và thực thi kế hoạch cấm đánh bắt cá mười năm trên sông Trường Giang, tập trung xử lý đồng bộ ô nhiễm nguồn nước ở cả thượng lưu và hạ lưu lưu vực, giúp cho tính đa dạng sinh vật thủy sinh trong lưu vực con sông mẹ này được phục hồi rõ rệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2479] [合同] (hétong) - hợp đồng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '合同' AND pinyin = 'hétong'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合同' AND pinyin = 'hétong'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '合同'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合同'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hétong',
      meaning_vi = 'hợp đồng',
      example_hanzi = '新员工在正式入职之前，应当认真阅读并亲自签署用工劳动合同。',
      example_pinyin = 'Xīn yuángōng zài zhèngshì rùzhí zhīqián, yīngdāng rènzhēn yuèdú bìng qīnzì qiānshǔ yònggōng láodòng hétong.',
      example_vi = 'Nhân viên mới trước khi chính thức nhận việc, nên đọc kỹ và tự mình ký kết hợp đồng lao động tuyển dụng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '合同',
      'hétong',
      'hợp đồng',
      'Danh từ',
      'HSK 5',
      '新员工在正式入职之前，应当认真阅读并亲自签署用工劳动合同。',
      'Xīn yuángōng zài zhèngshì rùzhí zhīqián, yīngdāng rènzhēn yuèdú bìng qīnzì qiānshǔ yònggōng láodòng hétong.',
      'Nhân viên mới trước khi chính thức nhận việc, nên đọc kỹ và tự mình ký kết hợp đồng lao động tuyển dụng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新员工在正式入职之前，应当认真阅读并亲自签署用工劳动合同。', 'Xīn yuángōng zài zhèngshì rùzhí zhīqián, yīngdāng rènzhēn yuèdú bìng qīnzì qiānshǔ yònggōng láodòng hétong.', 'Nhân viên mới trước khi chính thức nhận việc, nên đọc kỹ và tự mình ký kết hợp đồng lao động tuyển dụng.', 'basic', 1),
      (v_id, '在大型跨国能源工程采购招标中，双方总法律顾问对不可抗力免责条款、违约赔偿上限以及国际商事仲裁管辖权进行了长达数周的严谨合同条款会商。', 'Zài dàxíng kuàguó néngyuán gōngchéng cǎigòu zhāobiāo zhōng, shuāngfāng zǒng fǎlǜ gùwèn duì bùkěkànglì miǎnzé tiáokuǎn, wéiyuē péicháng shàngxiàn yǐjí guójì shāngshì zhòngcái guǎnxiáquán jìnxíng le cháng dá shù zhōu de yánjǐn hétong tiáokuǎn huìshāng.', 'Trong cuộc đấu thầu mua sắm công trình năng lượng xuyên quốc gia quy mô lớn, tổng cố vấn pháp lý của hai bên đã tiến hành hội đàm điều khoản hợp đồng nghiêm ngặt kéo dài nhiều tuần về các điều khoản miễn trừ do bất khả kháng, mức trần bồi thường vi phạm hợp đồng cũng như quyền tài phán trọng tài thương mại quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2480] [合影] (héyǐng) - chụp ảnh chung, chụp hình lưu niệm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '合影' AND pinyin = 'héyǐng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合影' AND pinyin = 'héyǐng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '合影'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合影'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'héyǐng',
      meaning_vi = 'chụp ảnh chung, chụp hình lưu niệm',
      example_hanzi = '在大学毕业典礼上，全班同学身穿学士服在图书馆门前留下了一张难忘的毕业合影。',
      example_pinyin = 'Zài dàxué bìyè diǎnlǐ shang, quánbān tóngxué shēnchuān xuéshìfú zài túshūguǎn ménqián liúxià le yì zhāng nánwàng de bìyè héyǐng.',
      example_vi = 'Tại lễ tốt nghiệp đại học, tất cả sinh viên trong lớp mặc áo cử nhân đã lưu lại một bức ảnh chụp chung tốt nghiệp khó quên trước cửa thư viện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '合影',
      'héyǐng',
      'chụp ảnh chung, chụp hình lưu niệm',
      'Động từ / Danh từ',
      'HSK 5',
      '在大学毕业典礼上，全班同学身穿学士服在图书馆门前留下了一张难忘的毕业合影。',
      'Zài dàxué bìyè diǎnlǐ shang, quánbān tóngxué shēnchuān xuéshìfú zài túshūguǎn ménqián liúxià le yì zhāng nánwàng de bìyè héyǐng.',
      'Tại lễ tốt nghiệp đại học, tất cả sinh viên trong lớp mặc áo cử nhân đã lưu lại một bức ảnh chụp chung tốt nghiệp khó quên trước cửa thư viện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在大学毕业典礼上，全班同学身穿学士服在图书馆门前留下了一张难忘的毕业合影。', 'Zài dàxué bìyè diǎnlǐ shang, quánbān tóngxué shēnchuān xuéshìfú zài túshūguǎn ménqián liúxià le yì zhāng nánwàng de bìyè héyǐng.', 'Tại lễ tốt nghiệp đại học, tất cả sinh viên trong lớp mặc áo cử nhân đã lưu lại một bức ảnh chụp chung tốt nghiệp khó quên trước cửa thư viện.', 'basic', 1),
      (v_id, '在国际科技创新峰会圆满闭幕之际，多国政要、诺贝尔奖得主与全球知名高科技企业家共同走上舞台合影留念，定格了深化全球数字合作的历史时刻。', 'Zài guójì kējì chuàngxīn fēnghuì yuánmǎn bìmù zhījì, duō guó zhèngyào, Nuòbèi’ěr jiǎng dézhǔ yǔ quánqiú zhīmíng gāokējì qǐyèjiā gòngtóng zǒushàng wǔtái héyǐng liúniàn, dìnggé le shēnhuà quánqiú shùzì hézuò de lìshǐ shíkè.', 'Vào thời khắc hội nghị thượng đỉnh đổi mới khoa học công nghệ quốc tế bế mạc thành công tốt đẹp, chính khách nhiều nước, các nhà khoa học đoạt giải Nobel cùng các doanh nhân công nghệ cao nổi tiếng toàn cầu đã cùng bước lên sân khấu chụp ảnh lưu niệm chung, ghi lại khoảnh khắc lịch sử làm sâu sắc hợp tác số toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2481] [合作] (hézuò) - hợp tác, phối hợp làm việc [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '合作' AND pinyin = 'hézuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合作' AND pinyin = 'hézuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '合作'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '合作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'hézuò',
      meaning_vi = 'hợp tác, phối hợp làm việc',
      example_hanzi = '只有团队成员之间齐心协力、密切合作，才能高效完成这项复杂的科研攻关任务。',
      example_pinyin = 'Zhǐyào tuánduì chéngyuán zhījiān qíxīn-xiélì, mìqiè hézuò, cáinéng gāoxiào wánchéng zhè xiàng fùzá de kēyán gōngguān rènwu.',
      example_vi = 'Chỉ khi giữa các thành viên trong nhóm đồng tâm hiệp lực, hợp tác chặt chẽ, mới có thể hoàn thành nhiệm vụ đột phá nghiên cứu khoa học phức tạp này một cách hiệu quả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '合作',
      'hézuò',
      'hợp tác, phối hợp làm việc',
      'Động từ / Danh từ',
      'HSK 5',
      '只有团队成员之间齐心协力、密切合作，才能高效完成这项复杂的科研攻关任务。',
      'Zhǐyào tuánduì chéngyuán zhījiān qíxīn-xiélì, mìqiè hézuò, cáinéng gāoxiào wánchéng zhè xiàng fùzá de kēyán gōngguān rènwu.',
      'Chỉ khi giữa các thành viên trong nhóm đồng tâm hiệp lực, hợp tác chặt chẽ, mới có thể hoàn thành nhiệm vụ đột phá nghiên cứu khoa học phức tạp này một cách hiệu quả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '只有团队成员之间齐心协力、密切合作，才能高效完成这项复杂的科研攻关任务。', 'Zhǐyào tuánduì chéngyuán zhījiān qíxīn-xiélì, mìqiè hézuò, cáinéng gāoxiào wánchéng zhè xiàng fùzá de kēyán gōngguān rènwu.', 'Chỉ khi giữa các thành viên trong nhóm đồng tâm hiệp lực, hợp tác chặt chẽ, mới có thể hoàn thành nhiệm vụ đột phá nghiên cứu khoa học phức tạp này một cách hiệu quả.', 'basic', 1),
      (v_id, '两国在高端绿色低碳能源、空间探测和跨境数字经济基础设施领域不断深化多边战略务实合作，携手构建互利共赢的经贸共同体。', 'Liǎng guó zài gāoduān lǜsè dītàn néngyuán, kōngjiān tàncè hé kuàjìng shùzì jīngjì jīchǔ shèshī lǐngyù bùduàn shēnhuà duōbiān zhànlüè wùshí hézuò, xiéshǒu gòujiàn hùlì gòngyíng de jīngmào gòngtóngtǐ.', 'Hai nước không ngừng làm sâu sắc thêm hợp tác thiết thực chiến lược đa phương trong các lĩnh vực năng lượng phát thải thấp xanh cao cấp, thăm dò không gian và cơ sở hạ tầng kinh tế số xuyên biên giới, chung tay xây dựng cộng đồng kinh tế thương mại đôi bên cùng có lợi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2482] [黑] (hēi) - đen, tối tăm; mờ ám, bí mật; bôi xấu, tấn công mạng [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '黑' AND pinyin = 'hēi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '黑' AND pinyin = 'hēi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '黑'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '黑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'hēi',
      meaning_vi = 'đen, tối tăm; mờ ám, bí mật; bôi xấu, tấn công mạng',
      example_hanzi = '天色渐渐黑了下来，街边的路灯准时次第亮起，照亮了行人回家的道路。',
      example_pinyin = 'Tiānsè jiànjiàn hēi le xiàlái, jiēbiān de lùdēng zhǔnshí cìdì liàng qǐ, zhàoliàng le xíngrén huíjiā de dàolù.',
      example_vi = 'Trời dần dần tối sầm lại, những ngọn đèn đường bên hè phố lần lượt thắp sáng đúng giờ, soi tỏ con đường trở về nhà cho người đi đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '黑',
      'hēi',
      'đen, tối tăm; mờ ám, bí mật; bôi xấu, tấn công mạng',
      'Tính từ / Động từ',
      'HSK 5',
      '天色渐渐黑了下来，街边的路灯准时次第亮起，照亮了行人回家的道路。',
      'Tiānsè jiànjiàn hēi le xiàlái, jiēbiān de lùdēng zhǔnshí cìdì liàng qǐ, zhàoliàng le xíngrén huíjiā de dàolù.',
      'Trời dần dần tối sầm lại, những ngọn đèn đường bên hè phố lần lượt thắp sáng đúng giờ, soi tỏ con đường trở về nhà cho người đi đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '天色渐渐黑了下来，街边的路灯准时次第亮起，照亮了行人回家的道路。', 'Tiānsè jiànjiàn hēi le xiàlái, jiēbiān de lùdēng zhǔnshí cìdì liàng qǐ, zhàoliàng le xíngrén huíjiā de dàolù.', 'Trời dần dần tối sầm lại, những ngọn đèn đường bên hè phố lần lượt thắp sáng đúng giờ, soi tỏ con đường trở về nhà cho người đi đường.', 'basic', 1),
      (v_id, '国家网络空间安全应急中心成功挫败了一起由境外黑客组织发起的分布式拒绝服务网络攻击，有力保障了国家关键金融枢纽系统的稳定运行。', 'Guójiā wǎngluò kōngjiān ānquán yìngjí zhōngxīn chénggōng cuòbài le yì qǐ yóu jìngwài hēikè zǔzhī fāqǐ de fēnbùshì jùjué fúwù wǎngluò gōngjī, yǒulì bǎozhàng le guójiā guānjiàn jīnróng shūniǔ xìtǒng de wěndìng yùnxíng.', 'Trung tâm Ứng cứu khẩn cấp an toàn không gian mạng quốc gia đã đập tan thành công một vụ tấn công mạng từ chối dịch vụ phân tán do tổ chức tin tặc nước ngoài phát động, bảo vệ vững chắc cho sự vận hành ổn định của hệ thống đầu mối tài chính then chốt quốc gia.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2483] [红] (hóng) - đỏ; hồng hào; nổi tiếng, được ưa chuộng, phát đạt [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '红' AND pinyin = 'hóng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '红' AND pinyin = 'hóng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '红'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '红'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'hóng',
      meaning_vi = 'đỏ; hồng hào; nổi tiếng, được ưa chuộng, phát đạt',
      example_hanzi = '深秋时节，漫山遍野的枫叶变得像火一样红，吸引了成千上万名登山摄影爱好者。',
      example_pinyin = 'Shēnqiū shíjié, mànshān-biànyě de fēngyè biànde xiàng huǒ yíyàng hóng, xīyǐn le chéngqiān-shàngwàn míng dēngshān shèyǐng àihàozhě.',
      example_vi = 'Tiết trời cuối thu, lá phong khắp núi non đồi bãi chuyển sang màu đỏ rực như lửa, thu hút hàng vạn người đam mê leo núi chụp ảnh tìm về.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '红',
      'hóng',
      'đỏ; hồng hào; nổi tiếng, được ưa chuộng, phát đạt',
      'Tính từ',
      'HSK 5',
      '深秋时节，漫山遍野的枫叶变得像火一样红，吸引了成千上万名登山摄影爱好者。',
      'Shēnqiū shíjié, mànshān-biànyě de fēngyè biànde xiàng huǒ yíyàng hóng, xīyǐn le chéngqiān-shàngwàn míng dēngshān shèyǐng àihàozhě.',
      'Tiết trời cuối thu, lá phong khắp núi non đồi bãi chuyển sang màu đỏ rực như lửa, thu hút hàng vạn người đam mê leo núi chụp ảnh tìm về.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '深秋时节，漫山遍野的枫叶变得像火一样红，吸引了成千上万名登山摄影爱好者。', 'Shēnqiū shíjié, mànshān-biànyě de fēngyè biànde xiàng huǒ yíyàng hóng, xīyǐn le chéngqiān-shàngwàn míng dēngshān shèyǐng àihàozhě.', 'Tiết trời cuối thu, lá phong khắp núi non đồi bãi chuyển sang màu đỏ rực như lửa, thu hút hàng vạn người đam mê leo núi chụp ảnh tìm về.', 'basic', 1),
      (v_id, '该高新技术企业凭借原创自主研发的智能算力芯片在国际消费电子展上一炮而红，并在短短半年内斩获了来自数十家科技巨头的巨额采购订单。', 'Gāi gāoxīn jìshù qǐyè píngjiè yuánchuàng zìzhǔ yánfā de zhìnéng suànlì xīnpiàn zài guójì xiāofèi diànzǐzhǎn shang yípào’érhóng, bìng zài duǎnduǎn bàn nián nèi zhǎnhuò le láizì shù shí jiā kējì jùtóu de jù’é cǎigòu dìngdān.', 'Doanh nghiệp công nghệ cao này nhờ con chip năng lực tính toán thông minh tự chủ nghiên cứu phát triển độc bản đã nổi tiếng vang dội chỉ sau một đêm tại Triển lãm Điện tử tiêu dùng quốc tế, và chỉ trong nửa năm ngắn ngủi đã giành được những đơn đặt hàng mua sắm khổng lồ từ hàng chục gã khổng lồ công nghệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2484] [猴子] (hóuzi) - con khỉ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '猴子' AND pinyin = 'hóuzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '猴子' AND pinyin = 'hóuzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '猴子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '猴子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hóuzi',
      meaning_vi = 'con khỉ',
      example_hanzi = '动物园里的猴子十分聪明机灵，经常在假山树枝之间荡秋千，逗得围观的小朋友哈哈大笑。',
      example_pinyin = 'Dòngwùyuán lǐ de hóuzi shífēn cōngmíng jīling, chángcháng zài jiǎshān shùzhī zhījiān dàng qiūqiān, dòu dé wéiguān de xiǎopéngyou hāhā dàxiào.',
      example_vi = 'Những chú khỉ trong vườn bách thú vô cùng thông minh lanh lợi, thường xuyên đu xà đánh đu giữa các cành cây trên hòn non bộ, chọc cho các bạn nhỏ đứng xem cười ha ha thích thú.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '猴子',
      'hóuzi',
      'con khỉ',
      'Danh từ',
      'HSK 5',
      '动物园里的猴子十分聪明机灵，经常在假山树枝之间荡秋千，逗得围观的小朋友哈哈大笑。',
      'Dòngwùyuán lǐ de hóuzi shífēn cōngmíng jīling, chángcháng zài jiǎshān shùzhī zhījiān dàng qiūqiān, dòu dé wéiguān de xiǎopéngyou hāhā dàxiào.',
      'Những chú khỉ trong vườn bách thú vô cùng thông minh lanh lợi, thường xuyên đu xà đánh đu giữa các cành cây trên hòn non bộ, chọc cho các bạn nhỏ đứng xem cười ha ha thích thú.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '动物园里的猴子十分聪明机灵，经常在假山树枝之间荡秋千，逗得围观的小朋友哈哈大笑。', 'Dòngwùyuán lǐ de hóuzi shífēn cōngmíng jīling, chángcháng zài jiǎshān shùzhī zhījiān dàng qiūqiān, dòu dé wéiguān de xiǎopéngyou hāhā dàxiào.', 'Những chú khỉ trong vườn bách thú vô cùng thông minh lanh lợi, thường xuyên đu xà đánh đu giữa các cành cây trên hòn non bộ, chọc cho các bạn nhỏ đứng xem cười ha ha thích thú.', 'basic', 1),
      (v_id, '中国科研人员利用高精度红外遥感无人机与基因组测序技术，对栖息在横断山脉高海拔原始森林中国家一级保护濒危野生动物滇金丝猴种群进行了长周期的科学监测与遗传多样性保护。', 'Zhōngguó kēyán rényuán lìyòng gāojīngdù hóngwài yáogǎn wúrénjī yǔ jīyīnzǔ cèxù jìshù, duì qīxī zài Héngduàn Shānmài gāo hǎibá yuánshǐ sēnlín zhōng guójiā yījí bǎohù bīnwēi yěshēng dòngwù Diān jīnsīhóu zhǒngqún jìnxíng le cháng zhōuqī de kēxué jiāncè yǔ yíchuán duōyàngxìng bǎohù.', 'Các nhân viên nghiên cứu khoa học Trung Quốc đã sử dụng thiết bị bay không người lái viễn thám hồng ngoại độ chính xác cao cùng kỹ thuật giải trình tự bộ gen, tiến hành quan trắc khoa học chu kỳ dài và bảo tồn tính đa dạng di truyền cho quần thể voọc mũi hếch Vân Nam - loài động vật hoang dã nguy cấp được bảo vệ cấp một quốc gia đang cư trú trong các khu rừng nguyên sinh độ cao lớn của dãy núi Hoành Đoán.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2485] [厚度] (hòudù) - độ dày, bề dày [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '厚度' AND pinyin = 'hòudù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '厚度' AND pinyin = 'hòudù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '厚度'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '厚度'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hòudù',
      meaning_vi = 'độ dày, bề dày',
      example_hanzi = '严冬时节，北方湖泊结成的坚硬冰层厚度已经达到了三十厘米，完全可以承受行人的重量。',
      example_pinyin = 'Yándōng shíjié, běifāng húpō jiéchéng de jiānyìng bīngcéng hòudù yǐjīng dádào le sānshí límǐ, wánquán kěyǐ chéngshòu xíngrén de zhòngliàng.',
      example_vi = 'Tiết trời đông giá, bề dày tầng băng cứng đông kết trên các hồ nước phương Bắc đã đạt tới ba mươi centimet, hoàn toàn có thể chịu được trọng lượng của người đi lại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '厚度',
      'hòudù',
      'độ dày, bề dày',
      'Danh từ',
      'HSK 5',
      '严冬时节，北方湖泊结成的坚硬冰层厚度已经达到了三十厘米，完全可以承受行人的重量。',
      'Yándōng shíjié, běifāng húpō jiéchéng de jiānyìng bīngcéng hòudù yǐjīng dádào le sānshí límǐ, wánquán kěyǐ chéngshòu xíngrén de zhòngliàng.',
      'Tiết trời đông giá, bề dày tầng băng cứng đông kết trên các hồ nước phương Bắc đã đạt tới ba mươi centimet, hoàn toàn có thể chịu được trọng lượng của người đi lại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '严冬时节，北方湖泊结成的坚硬冰层厚度已经达到了三十厘米，完全可以承受行人的重量。', 'Yándōng shíjié, běifāng húpō jiéchéng de jiānyìng bīngcéng hòudù yǐjīng dádào le sānshí límǐ, wánquán kěyǐ chéngshòu xíngrén de zhòngliàng.', 'Tiết trời đông giá, bề dày tầng băng cứng đông kết trên các hồ nước phương Bắc đã đạt tới ba mươi centimet, hoàn toàn có thể chịu được trọng lượng của người đi lại.', 'basic', 1),
      (v_id, '极地破冰科学考察船在执行南北极科考任务时，其船体首部采用了特殊特种高强度低温合金钢，具有抵御超过两米厚度多年极地海冰正面剧烈挤压冲击的卓越抗裂性能。', 'Jídì pòbīng kēxué kǎocháchuán zài zhíxíng nán-běijí kēkǎo rènwu shí, qí chuántǐ shǒubù cǎiyòng le tèshū tèzhǒng gāo qiángdù dīwēn héjīngāng, jùyǒu dǐyù chāoguò liǎng mǐ hòudù duōnián jídì hǎibīng zhèngmiàn jùliè jǐyā chōngjī de zhuóyuè kàngliè xìngnéng.', 'Tàu khảo sát khoa học phá băng vùng cực khi thực thi nhiệm vụ nghiên cứu Nam Cực và Bắc Cực, phần mũi thân tàu sử dụng thép hợp kim nhiệt độ thấp cường độ cao đặc chủng chuyên dụng, sở hữu tính năng chống nứt xuất chúng chống chọi được sự va đập chèn ép dữ dội trực diện của băng biển vùng cực nhiều năm có độ dày vượt quá hai mét.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2486] [后果] (hòuguǒ) - hậu quả [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '后果' AND pinyin = 'hòuguǒ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '后果' AND pinyin = 'hòuguǒ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '后果'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '后果'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hòuguǒ',
      meaning_vi = 'hậu quả',
      example_hanzi = '开车时注意力分散看手机极易引发追尾交通事故，造成令人痛心的严重后果。',
      example_pinyin = 'Kāichē shí zhùyìlì fēnsǎn kàn shǒujī jí yì yǐnfā zhuīwěi jiāotōng shìgù, zàochéng lìngrén tòngxīn de yánzhòng hòuguǒ.',
      example_vi = 'Lái xe mà phân tán chú ý nhìn vào điện thoại rất dễ gây ra tai nạn giao thông đâm va từ phía sau, để lại những hậu quả nghiêm trọng đau lòng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '后果',
      'hòuguǒ',
      'hậu quả',
      'Danh từ',
      'HSK 5',
      '开车时注意力分散看手机极易引发追尾交通事故，造成令人痛心的严重后果。',
      'Kāichē shí zhùyìlì fēnsǎn kàn shǒujī jí yì yǐnfā zhuīwěi jiāotōng shìgù, zàochéng lìngrén tòngxīn de yánzhòng hòuguǒ.',
      'Lái xe mà phân tán chú ý nhìn vào điện thoại rất dễ gây ra tai nạn giao thông đâm va từ phía sau, để lại những hậu quả nghiêm trọng đau lòng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '开车时注意力分散看手机极易引发追尾交通事故，造成令人痛心的严重后果。', 'Kāichē shí zhùyìlì fēnsǎn kàn shǒujī jí yì yǐnfā zhuīwěi jiāotōng shìgù, zàochéng lìngrén tòngxīn de yánzhòng hòuguǒ.', 'Lái xe mà phân tán chú ý nhìn vào điện thoại rất dễ gây ra tai nạn giao thông đâm va từ phía sau, để lại những hậu quả nghiêm trọng đau lòng.', 'basic', 1),
      (v_id, '跨国工业企业如果在高危化学品生产贮存环节肆意违规操作忽视环保安监，必将承担吊销经营执照甚至追究刑事法律责任的灾难性严重后果。', 'Kuàguó gōngyè qǐyè rúguǒ zài gāowēi huàxuépǐn shēngchǎn zhùcún huánjié sìyì wéiguī cāozuò hūshì huánbǎo ānjiān, bìjiāng chéngdān diàoxiāo jīngyíng zhízhào shènzhì zhuījiū xíngshì fǎlǜ zérèn de zāinànxìng yánzhòng hòuguǒ.', 'Nếu doanh nghiệp công nghiệp đa quốc gia ngang nhiên thao tác sai quy định phớt lờ giám sát an toàn môi trường ở khâu sản xuất và lưu trữ hóa chất nguy hiểm cao, ắt sẽ phải gánh chịu hậu quả nghiêm trọng thảm khốc như bị thu hồi giấy phép kinh doanh thậm chí bị truy cứu trách nhiệm hình sự.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2487] [忽视] (hūshì) - xem nhẹ, phớt lờ, bỏ qua [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '忽视' AND pinyin = 'hūshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '忽视' AND pinyin = 'hūshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '忽视'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '忽视'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'hūshì',
      meaning_vi = 'xem nhẹ, phớt lờ, bỏ qua',
      example_hanzi = '在努力拼搏工作和事业的同时，绝不能忽视日常身体健康与心理调节。',
      example_pinyin = 'Zài nǔlì pīnbó gōngzuò hé shìyè de tóngshí, jué bù néng hūshì rìcháng shēntǐ jiànkāng yǔ xīnlǐ tiáojié.',
      example_vi = 'Cùng lúc nỗ lực phấn đấu cho công việc và sự nghiệp, tuyệt đối không được xem nhẹ sức khỏe thể chất và sự điều dưỡng tâm lý hàng ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '忽视',
      'hūshì',
      'xem nhẹ, phớt lờ, bỏ qua',
      'Động từ',
      'HSK 5',
      '在努力拼搏工作和事业的同时，绝不能忽视日常身体健康与心理调节。',
      'Zài nǔlì pīnbó gōngzuò hé shìyè de tóngshí, jué bù néng hūshì rìcháng shēntǐ jiànkāng yǔ xīnlǐ tiáojié.',
      'Cùng lúc nỗ lực phấn đấu cho công việc và sự nghiệp, tuyệt đối không được xem nhẹ sức khỏe thể chất và sự điều dưỡng tâm lý hàng ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在努力拼搏工作和事业的同时，绝不能忽视日常身体健康与心理调节。', 'Zài nǔlì pīnbó gōngzuò hé shìyè de tóngshí, jué bù néng hūshì rìcháng shēntǐ jiànkāng yǔ xīnlǐ tiáojié.', 'Cùng lúc nỗ lực phấn đấu cho công việc và sự nghiệp, tuyệt đối không được xem nhẹ sức khỏe thể chất và sự điều dưỡng tâm lý hàng ngày.', 'basic', 1),
      (v_id, '大模型算法开发团队在片面追求参数规模与响应生成速度的同时，决不可忽视数据伦理合规、隐私边界保护以及消除潜在算法偏见等根本性原则。', 'Dà móxíng suànfǎ kāifā tuánduì zài piànmiàn zhuīqiú cānshù guīmó yǔ xiǎngyìng shēngchéng sùdù de tóngshí, jué bùkě hūshì shùjù lúnlǐ hégūi, yǐnsī biānjiè bǎohù yǐjí xiāochú qiánzài suànfǎ piānjiàn děng gēnběnxìng yuánzé.', 'Đội ngũ phát triển thuật toán mô hình lớn khi phiến diện theo đuổi quy mô tham số và tốc độ phản hồi tạo lập, tuyệt đối không được xem nhẹ các nguyên tắc căn bản như tuân thủ đạo đức dữ liệu, bảo vệ ranh giới quyền riêng tư cũng như xóa bỏ những định kiến thuật toán tiềm ẩn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2488] [呼吸] (hūxī) - hô hấp, hít thở [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '呼吸' AND pinyin = 'hūxī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '呼吸' AND pinyin = 'hūxī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '呼吸'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '呼吸'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'hūxī',
      meaning_vi = 'hô hấp, hít thở',
      example_hanzi = '清晨漫步在绿树成荫的森林公园里，大口呼吸着饱含负氧离子的清新空气，顿感心旷神怡。',
      example_pinyin = 'Qīngchén mànbù zài lǜshù-chéngyīn de sēnlín gōngyuán lǐ, dàkǒu hūxī zhe bǎohán fùyǎnglízǐ de qīngxīn kōngqì, dùn gǎn xīnkuàng-shényí.',
      example_vi = 'Sáng sớm tản bộ trong công viên rừng cây xanh tỏa bóng mát, hít thở từng hơi thật sâu bầu không khí trong lành ngập tràn ion oxy âm, lập tức cảm thấy tinh thần sảng khoái thư thái.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '呼吸',
      'hūxī',
      'hô hấp, hít thở',
      'Động từ / Danh từ',
      'HSK 5',
      '清晨漫步在绿树成荫的森林公园里，大口呼吸着饱含负氧离子的清新空气，顿感心旷神怡。',
      'Qīngchén mànbù zài lǜshù-chéngyīn de sēnlín gōngyuán lǐ, dàkǒu hūxī zhe bǎohán fùyǎnglízǐ de qīngxīn kōngqì, dùn gǎn xīnkuàng-shényí.',
      'Sáng sớm tản bộ trong công viên rừng cây xanh tỏa bóng mát, hít thở từng hơi thật sâu bầu không khí trong lành ngập tràn ion oxy âm, lập tức cảm thấy tinh thần sảng khoái thư thái.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '清晨漫步在绿树成荫的森林公园里，大口呼吸着饱含负氧离子的清新空气，顿感心旷神怡。', 'Qīngchén mànbù zài lǜshù-chéngyīn de sēnlín gōngyuán lǐ, dàkǒu hūxī zhe bǎohán fùyǎnglízǐ de qīngxīn kōngqì, dùn gǎn xīnkuàng-shényí.', 'Sáng sớm tản bộ trong công viên rừng cây xanh tỏa bóng mát, hít thở từng hơi thật sâu bầu không khí trong lành ngập tràn ion oxy âm, lập tức cảm thấy tinh thần sảng khoái thư thái.', 'basic', 1),
      (v_id, '登山运动员在攀登海拔超过八千米的极高险峰时，由于空气极其稀薄且气压骤降，必须依靠专业便携式供氧装备辅助呼吸以防止严重高原肺水肿发生。', 'Dēngshān yùndòngyuán zài pāndēng hǎibá chāoguò bāqiān mǐ de jí gāo xiǎnfēng shí, yóuyú kōngqì jíqí xībó qiě qìyā zhòujiàng, bìxū yīkào zhuānyè biànxiéshì gōngyǎng zhuāngbèi fǔzhù hūxī yǐ fángzhǐ yánzhòng gāoyuán fèishuǐzhǒng fāshēng.', 'Vận động viên leo núi khi leo lên những đỉnh núi hiểm trở cực cao có độ cao trên tám nghìn mét so với mực nước biển, do không khí cực kỳ loãng và áp suất khí quyển giảm đột ngột, bắt buộc phải dựa vào trang thiết bị cung cấp oxy xách tay chuyên dụng để hỗ trợ hít thở nhằm ngăn ngừa chứng phù phổi cao nguyên nghiêm trọng phát sinh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2489] [湖] (hú) - hồ, cái hồ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '湖' AND pinyin = 'hú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '湖' AND pinyin = 'hú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '湖'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '湖'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hú',
      meaning_vi = 'hồ, cái hồ',
      example_hanzi = '西湖四周山色空蒙、湖水碧波荡漾，自古以来就是文人墨客流连忘返的旅游胜地。',
      example_pinyin = 'Xī Hú sìzhōu shānsè kōngméng, húshuǐ bìbō dàngyàng, zìgǔ yǐlái jiùshì wénrén-mòkè liúlián-wàngfǎn de lǚyóu shèngdì.',
      example_vi = 'Bốn phía Tây Hồ sắc núi mờ ảo, mặt nước hồ gợn sóng biếc dập dờn, từ xưa đến nay luôn là danh thắng du lịch khiến tao nhân mặc khách say mê quên cả lối về.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '湖',
      'hú',
      'hồ, cái hồ',
      'Danh từ',
      'HSK 5',
      '西湖四周山色空蒙、湖水碧波荡漾，自古以来就是文人墨客流连忘返的旅游胜地。',
      'Xī Hú sìzhōu shānsè kōngméng, húshuǐ bìbō dàngyàng, zìgǔ yǐlái jiùshì wénrén-mòkè liúlián-wàngfǎn de lǚyóu shèngdì.',
      'Bốn phía Tây Hồ sắc núi mờ ảo, mặt nước hồ gợn sóng biếc dập dờn, từ xưa đến nay luôn là danh thắng du lịch khiến tao nhân mặc khách say mê quên cả lối về.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '西湖四周山色空蒙、湖水碧波荡漾，自古以来就是文人墨客流连忘返的旅游胜地。', 'Xī Hú sìzhōu shānsè kōngméng, húshuǐ bìbō dàngyàng, zìgǔ yǐlái jiùshì wénrén-mòkè liúlián-wàngfǎn de lǚyóu shèngdì.', 'Bốn phía Tây Hồ sắc núi mờ ảo, mặt nước hồ gợn sóng biếc dập dờn, từ xưa đến nay luôn là danh thắng du lịch khiến tao nhân mặc khách say mê quên cả lối về.', 'basic', 1),
      (v_id, '作为中国最大的内陆咸水湖，青海湖通过实施周边退牧还湿与流域生态水网综合治理，湖区面积持续稳步扩大，成为数十万只珍稀候鸟停歇繁衍的生态绿洲。', 'Zuòwéi Zhōngguó zuì dà de nèilù xiánshuǐhú, Qīnghǎi Hú tōngguò shíshī zhōubiān tuìmù-huánshī yǔ liúyù shēngtài shuǐwǎng zōnghé zhìlǐ, húqū miànjī chíxù wěnbù kuòdà, chéngwéi shù shí wàn zhī zhēnxī hòuniǎo tíngxiē fányǎn de shēngtài lǜzhōu.', 'Với tư cách là hồ nước mặn nội địa lớn nhất Trung Quốc, hồ Thanh Hải thông qua việc thực thi trả đất chăn thả về vùng ngập nước và xử lý tổng thể mạng lưới nước sinh thái lưu vực xung quanh, diện tích vùng hồ đã liên tục mở rộng vững chắc, trở thành ốc đảo sinh thái cho hàng chục vạn cá thể chim di cư quý hiếm dừng chân sinh sôi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2490] [蝴蝶] (húdié) - con bướm, bươm bướm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '蝴蝶' AND pinyin = 'húdié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '蝴蝶' AND pinyin = 'húdié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '蝴蝶'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '蝴蝶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'húdié',
      meaning_vi = 'con bướm, bươm bướm',
      example_hanzi = '色彩斑斓的蝴蝶在盛开的花丛中轻盈地翩翩起舞，构成了春日田园里一道美丽的风景。',
      example_pinyin = 'Sècǎi-bānlán de húdié zài shèngkāi de huācóng zhōng qīngyíng de piānpiān-qǐwǔ, gòuchéng le chūnrì tiányuán lǐ yí dào měilì de fēngjǐng.',
      example_vi = 'Những cánh bướm rực rỡ sắc màu bay lượn nhẹ nhàng uyển chuyển giữa những bụi hoa nở rộ, tạo nên một phong cảnh tuyệt đẹp giữa đồng quê ngày xuân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '蝴蝶',
      'húdié',
      'con bướm, bươm bướm',
      'Danh từ',
      'HSK 5',
      '色彩斑斓的蝴蝶在盛开的花丛中轻盈地翩翩起舞，构成了春日田园里一道美丽的风景。',
      'Sècǎi-bānlán de húdié zài shèngkāi de huācóng zhōng qīngyíng de piānpiān-qǐwǔ, gòuchéng le chūnrì tiányuán lǐ yí dào měilì de fēngjǐng.',
      'Những cánh bướm rực rỡ sắc màu bay lượn nhẹ nhàng uyển chuyển giữa những bụi hoa nở rộ, tạo nên một phong cảnh tuyệt đẹp giữa đồng quê ngày xuân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '色彩斑斓的蝴蝶在盛开的花丛中轻盈地翩翩起舞，构成了春日田园里一道美丽的风景。', 'Sècǎi-bānlán de húdié zài shèngkāi de huācóng zhōng qīngyíng de piānpiān-qǐwǔ, gòuchéng le chūnrì tiányuán lǐ yí dào měilì de fēngjǐng.', 'Những cánh bướm rực rỡ sắc màu bay lượn nhẹ nhàng uyển chuyển giữa những bụi hoa nở rộ, tạo nên một phong cảnh tuyệt đẹp giữa đồng quê ngày xuân.', 'basic', 1),
      (v_id, '在热带雨林原始保护区深处，生物学家发现了展翅宽度可达三十厘米的罕见濒危鸟翼蝴蝶活体样本，为研究热带鳞翅目昆虫的物种分化提供了无价的科研活化石。', 'Zài rèdài yǔlín yuánshǐ bǎohùqū shēnchù, shēngwù xuéjiā fāxiàn le zhǎnchì kuāndù kě dá sānshí límǐ de hǎnjiàn bīnwēi niǎoyì húdié huótǐ yàngběn, wèi yánjiū rèdài línchìmù kūnchóng de wùzhǒng fēnhuà tígōng le wújià de kēyán huóhuàshí.', 'Sâu trong khu bảo tồn nguyên sinh rừng mưa nhiệt đới, các nhà sinh vật học đã phát hiện ra mẫu vật sống của loài bướm cánh chim quý hiếm có nguy cơ tuyệt chủng với sải cánh rộng tới ba mươi centimet, mang lại hóa thạch sống nghiên cứu khoa học vô giá cho việc tìm hiểu sự phân hóa loài của côn trùng bộ cánh vảy nhiệt đới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2491] [胡同] (hútòng) - ngõ hẻm, ngõ nhỏ truyền thống (Bắc Kinh) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '胡同' AND pinyin = 'hútòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胡同' AND pinyin = 'hútòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '胡同'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '胡同'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hútòng',
      meaning_vi = 'ngõ hẻm, ngõ nhỏ truyền thống (Bắc Kinh)',
      example_hanzi = '骑着自行车穿梭在老北京曲折宁静的胡同深处，能够深切感受到这座古老皇城的浓郁市井烟火气息。',
      example_pinyin = 'Qí zhe zìxíngchē chuānsuō zài lǎo Běijīng qūzhé níngjìng de hútòng shēnchù, nénggòu shēnqiè gǎnshòudào zhè zuò gǔlǎo huángchéng de nóngyù shìjǐng yānhuǒ qìxī.',
      example_vi = 'Đạp xe len lỏi sâu trong những con ngõ hẻm ngoằn ngoèo yên tĩnh của Bắc Kinh xưa, ta có thể cảm nhận sâu sắc bầu không khí khói lửa phố thị đậm đà của hoàng thành cổ kính này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '胡同',
      'hútòng',
      'ngõ hẻm, ngõ nhỏ truyền thống (Bắc Kinh)',
      'Danh từ',
      'HSK 5',
      '骑着自行车穿梭在老北京曲折宁静的胡同深处，能够深切感受到这座古老皇城的浓郁市井烟火气息。',
      'Qí zhe zìxíngchē chuānsuō zài lǎo Běijīng qūzhé níngjìng de hútòng shēnchù, nénggòu shēnqiè gǎnshòudào zhè zuò gǔlǎo huángchéng de nóngyù shìjǐng yānhuǒ qìxī.',
      'Đạp xe len lỏi sâu trong những con ngõ hẻm ngoằn ngoèo yên tĩnh của Bắc Kinh xưa, ta có thể cảm nhận sâu sắc bầu không khí khói lửa phố thị đậm đà của hoàng thành cổ kính này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '骑着自行车穿梭在老北京曲折宁静的胡同深处，能够深切感受到这座古老皇城的浓郁市井烟火气息。', 'Qí zhe zìxíngchē chuānsuō zài lǎo Běijīng qūzhé níngjìng de hútòng shēnchù, nénggòu shēnqiè gǎnshòudào zhè zuò gǔlǎo huángchéng de nóngyù shìjǐng yānhuǒ qìxī.', 'Đạp xe len lỏi sâu trong những con ngõ hẻm ngoằn ngoèo yên tĩnh của Bắc Kinh xưa, ta có thể cảm nhận sâu sắc bầu không khí khói lửa phố thị đậm đà của hoàng thành cổ kính này.', 'basic', 1),
      (v_id, '城市历史文化风貌街区更新修缮工程坚持“修旧如旧、保留文脉”的保护原则，精心修复了砖雕灰瓦与传统四合院门楼，让历经沧桑的百年老胡同焕发出新时代的人文生机。', 'Chéngshì lìshǐ wénhuà fēngmào jiēqū gēngxīn xiūshàn gōngchéng jiānchí “xiū jiù rú jiù, bǎoliú wénmài” de bǎohù yuánzé, jīngxīn xiūfù le zhuāndiāo huīwǎ yǔ chuántǒng sìhéyuàn ménlóu, ràng lìjīng cāngsāng de bǎinián lǎo hútòng huànfā chū xīn shídài de rénwén shēngjī.', 'Dự án tu bổ chỉnh trang khu phố mang diện mạo văn hóa lịch sử đô thị kiên trì nguyên tắc bảo tồn "sửa cũ như cũ, lưu giữ mạch nguồn văn hóa", đã phục hồi tỉ mỉ gạch chạm ngói xám cùng cổng lầu tứ hợp viện truyền thống, giúp con ngõ nhỏ trăm năm trải qua bao thăng trầm bừng sáng lên sức sống nhân văn thời đại mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2492] [互动] (hùdòng) - tương tác [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '互动' AND pinyin = 'hùdòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '互动' AND pinyin = 'hùdòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '互动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '互动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'hùdòng',
      meaning_vi = 'tương tác',
      example_hanzi = '这位优秀的青年教师在课堂上非常注重与学生的互动交流，课堂气氛生动活泼。',
      example_pinyin = 'Zhè wèi yōuxiù de qīngnián jiàoshī zài kètáng shang fēicháng zhùzhòng yǔ xuésheng de hùdòng jiāoliú, kètáng qìfēn shēngdòng huópo.',
      example_vi = 'Người giáo viên trẻ xuất sắc này trên lớp học rất coi trọng việc giao lưu tương tác với học sinh, không khí lớp học rất sôi nổi sinh động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '互动',
      'hùdòng',
      'tương tác',
      'Động từ / Danh từ',
      'HSK 5',
      '这位优秀的青年教师在课堂上非常注重与学生的互动交流，课堂气氛生动活泼。',
      'Zhè wèi yōuxiù de qīngnián jiàoshī zài kètáng shang fēicháng zhùzhòng yǔ xuésheng de hùdòng jiāoliú, kètáng qìfēn shēngdòng huópo.',
      'Người giáo viên trẻ xuất sắc này trên lớp học rất coi trọng việc giao lưu tương tác với học sinh, không khí lớp học rất sôi nổi sinh động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位优秀的青年教师在课堂上非常注重与学生的互动交流，课堂气氛生动活泼。', 'Zhè wèi yōuxiù de qīngnián jiàoshī zài kètáng shang fēicháng zhùzhòng yǔ xuésheng de hùdòng jiāoliú, kètáng qìfēn shēngdòng huópo.', 'Người giáo viên trẻ xuất sắc này trên lớp học rất coi trọng việc giao lưu tương tác với học sinh, không khí lớp học rất sôi nổi sinh động.', 'basic', 1),
      (v_id, '新一代混合现实沉浸式博物馆展厅依托空间手势识别与增强现实追踪技术，让观众能够与两千年前出土的青铜国宝实现触觉级的超逼真三维虚实互动体验。', 'Xīn yídài hùnhé xiànshí chénjìnshì bówùguǎn zhǎntīng yītuō kōngjiān shǒushì shíbié yǔ zēngqiáng xiànshí zhuīzōng jìshù, ràng guānzhòng nénggòu yǔ liǎngqiān nián qián chūtǔ de qīngtóng guóbǎo shíxiàn chùjuéjí de chāo bīzhēn sānwéi xū-shí hùdòng tǐyàn.', 'Gian triển lãm bảo tàng đắm chìm thực tế hỗn hợp thế hệ mới nhờ vào công nghệ nhận diện cử chỉ không gian và theo dõi thực tế tăng cường, đã cho phép người xem có được trải nghiệm tương tác ảo - thực không gian ba chiều siêu chân thực cấp độ xúc giác với những quốc bảo đồ đồng khai quật từ hai nghìn năm trước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2493] [户外] (hùwài) - ngoài trời, dã ngoại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '户外' AND pinyin = 'hùwài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '户外' AND pinyin = 'hùwài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '户外'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '户外'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'hùwài',
      meaning_vi = 'ngoài trời, dã ngoại',
      example_hanzi = '周末只要天气晴好，爸爸妈妈就会带着孩子们去郊外公园参加各种户外体育活动。',
      example_pinyin = 'Zhōumò zhǐyào tiānqì qínghǎo, bàba māma jiù huì dài zhe háizi men qù jiāowài gōngyuán cānjiā gèzhǒng hùwài tǐyù huódòng.',
      example_vi = 'Cuối tuần chỉ cần thời tiết đẹp trời, bố mẹ sẽ dẫn các con tới công viên ngoại ô tham gia các hoạt động thể thao ngoài trời đa dạng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '户外',
      'hùwài',
      'ngoài trời, dã ngoại',
      'Danh từ',
      'HSK 5',
      '周末只要天气晴好，爸爸妈妈就会带着孩子们去郊外公园参加各种户外体育活动。',
      'Zhōumò zhǐyào tiānqì qínghǎo, bàba māma jiù huì dài zhe háizi men qù jiāowài gōngyuán cānjiā gèzhǒng hùwài tǐyù huódòng.',
      'Cuối tuần chỉ cần thời tiết đẹp trời, bố mẹ sẽ dẫn các con tới công viên ngoại ô tham gia các hoạt động thể thao ngoài trời đa dạng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末只要天气晴好，爸爸妈妈就会带着孩子们去郊外公园参加各种户外体育活动。', 'Zhōumò zhǐyào tiānqì qínghǎo, bàba māma jiù huì dài zhe háizi men qù jiāowài gōngyuán cānjiā gèzhǒng hùwài tǐyù huódòng.', 'Cuối tuần chỉ cần thời tiết đẹp trời, bố mẹ sẽ dẫn các con tới công viên ngoại ô tham gia các hoạt động thể thao ngoài trời đa dạng.', 'basic', 1),
      (v_id, '随着大众健康生活理念的普及，高山徒步、山地自行车与野外露营等专业户外探险运动蓬勃兴起，强力带动了高性能专业户外功能性服饰与装备制造产业的快速增长。', 'Suízhe dàzhòng jiànkāng shēnghuó lǐniàn de pǔjí, gāoshān túbù, shāndì zìxíngchē yǔ yěwài lùyíng děng zhuānyè hùwài tànxiǎn yùndòng péngbó xīngqǐ, qiánglì dàidòng le gāo xìngnéng zhuānyè hùwài gōngnéngxìng fúshì yǔ zhuāngbèi zhìzào chǎnyè de kuàisù zēngzhǎng.', 'Cùng với sự phổ biến quan niệm lối sống khỏe mạnh của đại chúng, các môn thể thao thám hiểm dã ngoại chuyên nghiệp như đi bộ đường dài núi cao, đạp xe leo núi và cắm trại ngoài thiên nhiên đang nở rộ mạnh mẽ, thúc đẩy mạnh mẽ sự gia tăng nhanh chóng của ngành sản xuất trang thiết bị và trang phục tính năng ngoài trời chuyên nghiệp hiệu năng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2494] [花费] (huāfèi) - tiêu tốn, chi tiêu; chi phí [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '花费' AND pinyin = 'huāfèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '花费' AND pinyin = 'huāfèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '花费'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '花费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'huāfèi',
      meaning_vi = 'tiêu tốn, chi tiêu; chi phí',
      example_hanzi = '为了顺利考取理想大学的研究生，他在图书馆里花费了整整一年的心血刻苦攻读。',
      example_pinyin = 'Wèile shùnlì kǎoqǔ lǐxiǎng dàxué de yánjiūshēng, tā zài túshūguǎn lǐ huāfèi le zhěngzhěng yì nián de xīnxuè kèkǔ gōngdú.',
      example_vi = 'Để thi đỗ nghiên cứu sinh của trường đại học lý tưởng một cách thuận lợi, anh ấy đã tiêu tốn trọn vẹn một năm tâm huyết miệt mài học tập trong thư viện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '花费',
      'huāfèi',
      'tiêu tốn, chi tiêu; chi phí',
      'Động từ / Danh từ',
      'HSK 5',
      '为了顺利考取理想大学的研究生，他在图书馆里花费了整整一年的心血刻苦攻读。',
      'Wèile shùnlì kǎoqǔ lǐxiǎng dàxué de yánjiūshēng, tā zài túshūguǎn lǐ huāfèi le zhěngzhěng yì nián de xīnxuè kèkǔ gōngdú.',
      'Để thi đỗ nghiên cứu sinh của trường đại học lý tưởng một cách thuận lợi, anh ấy đã tiêu tốn trọn vẹn một năm tâm huyết miệt mài học tập trong thư viện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了顺利考取理想大学的研究生，他在图书馆里花费了整整一年的心血刻苦攻读。', 'Wèile shùnlì kǎoqǔ lǐxiǎng dàxué de yánjiūshēng, tā zài túshūguǎn lǐ huāfèi le zhěngzhěng yì nián de xīnxuè kèkǔ gōngdú.', 'Để thi đỗ nghiên cứu sinh của trường đại học lý tưởng một cách thuận lợi, anh ấy đã tiêu tốn trọn vẹn một năm tâm huyết miệt mài học tập trong thư viện.', 'basic', 1),
      (v_id, '在国家大型高能物理粒子对撞机前瞻科研工程立项审批过程中，专家委员会对项目的总体基建投资总额与长期运维花费预算进行了极其审慎严谨的技术可行性论证。', 'Zài guójiā dàxíng gāonéng wùlǐ lìzǐ duìzhuàngjī qiánzhān kēyán gōngchéng lìxiàng shěnpī guòchéng zhōng, zhuānjiā wěiyuánhuì duì xiàngmù de zǒngtǐ jījiàn tóuzī zǒng’é yǔ chángqī yùnwéi huāfèi yùsuàn jìnxíng le jíqí shěnshèn yánjǐn de jìshù kěxíngxìng lùnzhèng.', 'Trong quá trình xét duyệt lập dự án công trình nghiên cứu khoa học tiền trạm máy va chạm hạt vật lý năng lượng cao cỡ lớn quốc gia, ủy ban chuyên gia đã tiến hành thẩm định tính khả thi kỹ thuật cực kỳ thận trọng nghiêm ngặt đối với tổng mức đầu tư xây dựng cơ bản tổng thể và dự toán chi phí vận hành bảo trì dài hạn của dự án.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2495] [滑] (huá) - trơn, trượt; giảo hoạt, lém lỉnh [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '滑' AND pinyin = 'huá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '滑' AND pinyin = 'huá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '滑'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '滑'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'huá',
      meaning_vi = 'trơn, trượt; giảo hoạt, lém lỉnh',
      example_hanzi = '刚下过冬雪的路面结了一层薄薄的透明冰层，非常湿滑，行人走路一定要格外小心。',
      example_pinyin = 'Gāng xià guò dōngxuě de lùmiàn jié le yì céng báobáo de tòumíng bīngcéng, fēicháng shīhuá, xíngrén zǒulù yídìng yào géwài xiǎoxīn.',
      example_vi = 'Mặt đường sau cơn tuyết mùa đông vừa đóng một lớp băng trong suốt mỏng manh, vô cùng trơn trượt, người đi bộ khi bước đi nhất định phải hết sức cẩn thận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '滑',
      'huá',
      'trơn, trượt; giảo hoạt, lém lỉnh',
      'Tính từ / Động từ',
      'HSK 5',
      '刚下过冬雪的路面结了一层薄薄的透明冰层，非常湿滑，行人走路一定要格外小心。',
      'Gāng xià guò dōngxuě de lùmiàn jié le yì céng báobáo de tòumíng bīngcéng, fēicháng shīhuá, xíngrén zǒulù yídìng yào géwài xiǎoxīn.',
      'Mặt đường sau cơn tuyết mùa đông vừa đóng một lớp băng trong suốt mỏng manh, vô cùng trơn trượt, người đi bộ khi bước đi nhất định phải hết sức cẩn thận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '刚下过冬雪的路面结了一层薄薄的透明冰层，非常湿滑，行人走路一定要格外小心。', 'Gāng xià guò dōngxuě de lùmiàn jié le yì céng báobáo de tòumíng bīngcéng, fēicháng shīhuá, xíngrén zǒulù yídìng yào géwài xiǎoxīn.', 'Mặt đường sau cơn tuyết mùa đông vừa đóng một lớp băng trong suốt mỏng manh, vô cùng trơn trượt, người đi bộ khi bước đi nhất định phải hết sức cẩn thận.', 'basic', 1),
      (v_id, '国家冬季两项滑雪运动员在陡峭结冰的高速回转赛道上风驰电掣、疾驰滑行，展现出令人叹为观止的高超控板平衡技巧与顽强过人的意志品格。', 'Guójiā dōngjì liǎngxiàng huáxuě yùndòngyuán zài dǒuqiào jiébīng de gāosù huízhuǎn sàidào shang fēngchí-diànchè, jíchí huáxíng, zhǎnxiàn chū lìngrén tànwéiguānzhǐ de gāochāo kòngbǎn pínghéng jìqiǎo yǔ wánqiáng guòrén de yìzhì pǐngé.', 'Vận động viên trượt tuyết hai môn phối hợp mùa đông quốc gia lướt đi vun vút trượt băng xé gió trên đường đua ngoằn ngoèo dốc đứng đóng băng tốc độ cao, thể hiện kỹ năng giữ thăng bằng điều khiển ván trượt điêu luyện khiến người ta trầm trồ thán phục cùng phẩm chất ý chí kiên cường hơn người.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2496] [划] (huá) - chèo (thuyền); rạch, xước; tính toán, có lợi (đọc huá / huà) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '划' AND pinyin = 'huá'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '划' AND pinyin = 'huá'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '划'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '划'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'huá',
      meaning_vi = 'chèo (thuyền); rạch, xước; tính toán, có lợi (đọc huá / huà)',
      example_hanzi = '微风轻拂的周末下午，游人们租了一条小木船，在水波荡漾的公园湖面上惬意地划桨荡舟。',
      example_pinyin = 'Wēifēng qīngfú de zhōumò xiàwǔ, yóurén men zū le yì tiáo xiǎo mùchuán, zài shuǐbō dàngyàng de gōngyuán húmiàn shang qièyì de huájiǎng dàngzhōu.',
      example_vi = 'Chiều cuối tuần gió nhẹ hiu hiu thổi, du khách thuê một chiếc thuyền gỗ nhỏ, khoan thai khua mái chèo dạo thuyền trên mặt hồ công viên gợn sóng lăn tăn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '划',
      'huá',
      'chèo (thuyền); rạch, xước; tính toán, có lợi (đọc huá / huà)',
      'Động từ',
      'HSK 5',
      '微风轻拂的周末下午，游人们租了一条小木船，在水波荡漾的公园湖面上惬意地划桨荡舟。',
      'Wēifēng qīngfú de zhōumò xiàwǔ, yóurén men zū le yì tiáo xiǎo mùchuán, zài shuǐbō dàngyàng de gōngyuán húmiàn shang qièyì de huájiǎng dàngzhōu.',
      'Chiều cuối tuần gió nhẹ hiu hiu thổi, du khách thuê một chiếc thuyền gỗ nhỏ, khoan thai khua mái chèo dạo thuyền trên mặt hồ công viên gợn sóng lăn tăn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '微风轻拂的周末下午，游人们租了一条小木船，在水波荡漾的公园湖面上惬意地划桨荡舟。', 'Wēifēng qīngfú de zhōumò xiàwǔ, yóurén men zū le yì tiáo xiǎo mùchuán, zài shuǐbō dàngyàng de gōngyuán húmiàn shang qièyì de huájiǎng dàngzhōu.', 'Chiều cuối tuần gió nhẹ hiu hiu thổi, du khách thuê một chiếc thuyền gỗ nhỏ, khoan thai khua mái chèo dạo thuyền trên mặt hồ công viên gợn sóng lăn tăn.', 'basic', 1),
      (v_id, '自然资源规划部门在生态红线保护勘界工作中，严格依规科学划定了重要水源涵养地与国家级自然保护区的永久核心管控红线边界。', 'Zìrán zīyuán guīhuà bùmén zài shēngtài hóngxiàn bǎohù kānjiè gōngzuò zhōng, yángé yīguī kēxué huàdìng le zhòngyào shuǐyuán hányǎngdì yǔ guójiājí zìrán bǎohùqū de yǒngjiǔ héxīn guǎnkòng hóngxiàn biānjiè.', 'Bộ phận quy hoạch tài nguyên thiên nhiên trong công tác cắm mốc ranh giới bảo vệ đường đỏ sinh thái, đã phân định ranh giới lằn ranh đỏ quản chế cốt lõi vĩnh viễn của các khu vực nuôi dưỡng nguồn nước trọng điểm và các khu bảo tồn thiên nhiên cấp quốc gia một cách khoa học và đúng quy chuẩn nghiêm ngặt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2497] [化] (huà) - biến hóa, làm cho thành; tan rã, tan chảy; (-hóa: hậu tố tạo từ) [Động từ / Hậu tố]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '化' AND pinyin = 'huà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '化' AND pinyin = 'huà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '化'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '化'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Hậu tố',
      pinyin = 'huà',
      meaning_vi = 'biến hóa, làm cho thành; tan rã, tan chảy; (-hóa: hậu tố tạo từ)',
      example_hanzi = '春回大地，暖暖的阳光照耀着山坡，洁白的积雪正悄无声息地慢慢融化。',
      example_pinyin = 'Chūn huí dàdì, nuǎnnuǎn de yángguāng zhàoyào zhe shānpō, jiébái de jīxuě zhèng qiāowúshēngxī de mànmàn rónghuà.',
      example_vi = 'Mùa xuân trở lại trên mặt đất bao la, ánh nắng ấm áp rọi chiếu triền núi, tuyết trắng đọng lại đang lặng lẽ từ từ tan chảy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '化',
      'huà',
      'biến hóa, làm cho thành; tan rã, tan chảy; (-hóa: hậu tố tạo từ)',
      'Động từ / Hậu tố',
      'HSK 5',
      '春回大地，暖暖的阳光照耀着山坡，洁白的积雪正悄无声息地慢慢融化。',
      'Chūn huí dàdì, nuǎnnuǎn de yángguāng zhàoyào zhe shānpō, jiébái de jīxuě zhèng qiāowúshēngxī de mànmàn rónghuà.',
      'Mùa xuân trở lại trên mặt đất bao la, ánh nắng ấm áp rọi chiếu triền núi, tuyết trắng đọng lại đang lặng lẽ từ từ tan chảy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春回大地，暖暖的阳光照耀着山坡，洁白的积雪正悄无声息地慢慢融化。', 'Chūn huí dàdì, nuǎnnuǎn de yángguāng zhàoyào zhe shānpō, jiébái de jīxuě zhèng qiāowúshēngxī de mànmàn rónghuà.', 'Mùa xuân trở lại trên mặt đất bao la, ánh nắng ấm áp rọi chiếu triền núi, tuyết trắng đọng lại đang lặng lẽ từ từ tan chảy.', 'basic', 1),
      (v_id, '制造业推进全流程自动化、数字化与智能化升级改造，不仅大幅降低了企业用工成本，更是从根本上化解了传统工厂产能过剩与产品同质化竞争的严峻困局。', 'Zhìzàoyè tuījìn quán liúchéng zìdònghuà, shùzìhuà yǔ zhìnénghuà shēngjí gǎizào, bùjǐn dàfú jiàngdī le qǐyè yònggōng chéngběn, gèng shì cóng gēnběn shang huàjiě le chuántǒng gōngchǎng chǎnnéng guòshèng yǔ chǎnpǐn tóngzhìhuà jìngzhēng de yánjùn kùnjú.', 'Ngành sản xuất đẩy mạnh cải tạo nâng cấp tự động hóa, số hóa và thông minh hóa toàn quy trình, không chỉ giảm mạnh chi phí nhân công cho doanh nghiệp, mà càng là giải tỏa tận gốc cục diện khó khăn gay gắt về dư thừa công suất và cạnh tranh sản phẩm đồng dạng hóa của các nhà máy truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2498] [话费] (huàfèi) - cước điện thoại, tiền cước viễn thông [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '话费' AND pinyin = 'huàfèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '话费' AND pinyin = 'huàfèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '话费'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '话费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huàfèi',
      meaning_vi = 'cước điện thoại, tiền cước viễn thông',
      example_hanzi = '手机短信提示话费余额不足十元，他在网上营业厅里通过移动支付瞬间完成了充值。',
      example_pinyin = 'Shǒujī duǎnxìn tíshì huàfèi yú’é bùzú shí yuán, tā zài wǎngshàng yíngyètīng lǐ tōngguò yídòng zhīfù shùnjiān wánchéng le chōngzhí.',
      example_vi = 'Tin nhắn điện thoại nhắc số dư cước điện thoại còn chưa đầy mười tệ, anh ấy liền nạp tiền thành công trong tích tắc qua thanh toán di động trên điểm giao dịch trực tuyến.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '话费',
      'huàfèi',
      'cước điện thoại, tiền cước viễn thông',
      'Danh từ',
      'HSK 5',
      '手机短信提示话费余额不足十元，他在网上营业厅里通过移动支付瞬间完成了充值。',
      'Shǒujī duǎnxìn tíshì huàfèi yú’é bùzú shí yuán, tā zài wǎngshàng yíngyètīng lǐ tōngguò yídòng zhīfù shùnjiān wánchéng le chōngzhí.',
      'Tin nhắn điện thoại nhắc số dư cước điện thoại còn chưa đầy mười tệ, anh ấy liền nạp tiền thành công trong tích tắc qua thanh toán di động trên điểm giao dịch trực tuyến.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '手机短信提示话费余额不足十元，他在网上营业厅里通过移动支付瞬间完成了充值。', 'Shǒujī duǎnxìn tíshì huàfèi yú’é bùzú shí yuán, tā zài wǎngshàng yíngyètīng lǐ tōngguò yídòng zhīfù shùnjiān wánchéng le chōngzhí.', 'Tin nhắn điện thoại nhắc số dư cước điện thoại còn chưa đầy mười tệ, anh ấy liền nạp tiền thành công trong tích tắc qua thanh toán di động trên điểm giao dịch trực tuyến.', 'basic', 1),
      (v_id, '国家三大电信基础运营商积极响应提速降费惠民号召，全面取消了国内长途漫游费，并针对中小微企业与老年群体推出了多项大幅减免月度话费与宽带资费的暖心专项套餐。', 'Guójiā sān dà diànxìn jīchǔ yùnyíngshāng jījí xiǎngyìng tísù-jiàngfèi huìmín hàozhào, quánmiàn qǔxiāo le guónèi chángtú mànyóufèi, bìng zhēnduì zhōng-xiǎo-wēi qǐyè yǔ lǎonián qúntǐ tuīchū le duō xiàng dàfú jiǎnmiǎn yuèdù huàfèi yǔ kuāndài zīfèi de nuǎnxīn zhuānxiàng tàocān.', 'Ba nhà mạng viễn thông hạ tầng lớn của quốc gia tích cực hưởng ứng lời kêu gọi tăng tốc độ giảm cước phí vì lợi ích của nhân dân, đã bãi bỏ hoàn toàn cước chuyển vùng đường dài nội địa, đồng thời hướng tới các doanh nghiệp vừa, nhỏ và siêu nhỏ cùng nhóm người cao tuổi đưa ra nhiều gói cước chuyên đề ấm lòng giảm trừ mạnh cước phí điện thoại và cước internet băng thông rộng hàng tháng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2499] [画面] (huàmiàn) - khung cảnh, hình ảnh, bức tranh, cảnh tượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '画面' AND pinyin = 'huàmiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '画面' AND pinyin = 'huàmiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '画面'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '画面'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huàmiàn',
      meaning_vi = 'khung cảnh, hình ảnh, bức tranh, cảnh tượng',
      example_hanzi = '这部高清自然纪录片的画面清晰细腻，将辽阔非洲大草原上动物迁徙的壮观景象展露无遗。',
      example_pinyin = 'Zhè bù gāoqīng zìrán jìlùpiàn de huàmiàn qīngxī xìnì, jiāng liáokuò Fēizhōu dà cǎoyuán shang dòngwù qiānxǐ de zhuàngguān jǐngxiàng zhǎnlù-wúyí.',
      example_vi = 'Khung hình của bộ phim tài liệu tự nhiên độ nét cao này vô cùng rõ nét và tinh tế, phơi bày trọn vẹn cảnh tượng hùng tráng của cuộc đại di cư động vật trên thảo nguyên châu Phi bao la.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '画面',
      'huàmiàn',
      'khung cảnh, hình ảnh, bức tranh, cảnh tượng',
      'Danh từ',
      'HSK 5',
      '这部高清自然纪录片的画面清晰细腻，将辽阔非洲大草原上动物迁徙的壮观景象展露无遗。',
      'Zhè bù gāoqīng zìrán jìlùpiàn de huàmiàn qīngxī xìnì, jiāng liáokuò Fēizhōu dà cǎoyuán shang dòngwù qiānxǐ de zhuàngguān jǐngxiàng zhǎnlù-wúyí.',
      'Khung hình của bộ phim tài liệu tự nhiên độ nét cao này vô cùng rõ nét và tinh tế, phơi bày trọn vẹn cảnh tượng hùng tráng của cuộc đại di cư động vật trên thảo nguyên châu Phi bao la.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这部高清自然纪录片的画面清晰细腻，将辽阔非洲大草原上动物迁徙的壮观景象展露无遗。', 'Zhè bù gāoqīng zìrán jìlùpiàn de huàmiàn qīngxī xìnì, jiāng liáokuò Fēizhōu dà cǎoyuán shang dòngwù qiānxǐ de zhuàngguān jǐngxiàng zhǎnlù-wúyí.', 'Khung hình của bộ phim tài liệu tự nhiên độ nét cao này vô cùng rõ nét và tinh tế, phơi bày trọn vẹn cảnh tượng hùng tráng của cuộc đại di cư động vật trên thảo nguyên châu Phi bao la.', 'basic', 1),
      (v_id, '导演巧妙运用长镜头与冷暖色调的戏剧性交织对比，在电影大银幕上定格下一幕幕直击人心、兼具强烈视觉张力与深刻人文关怀的史诗级战争历史画面。', 'Dǎoyǎn qiǎomiào yùnyòng chángjìngtóu yǔ lěng-nuǎn sèdiào de xìjùxìng jiāozhī duìbǐ, zài diànyǐng dàyínmù shang dìnggé xià yímùmù zhíjī-rénxīn, jiānjù qiángliè shìjué zhānglì yǔ shēnkè rénwén guānhuái de shǐshījí zhànzhēng lìshǐ huàmiàn.', 'Đạo diễn khéo léo vận dụng các cú máy dài kết hợp cùng sự đan xen tương phản đầy tính kịch của tông màu nóng lạnh, đã đóng khung trên màn ảnh rộng rạp chiếu phim những thước phim lịch sử chiến tranh cấp độ sử thi chạm thẳng vào trái tim, vừa giàu sức căng thị giác mãnh liệt lại vừa đậm đà sự trắc ẩn quan tâm nhân văn sâu sắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2500] [话题] (huàtí) - chủ đề câu chuyện, đề tài đàm luận [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '话题' AND pinyin = 'huàtí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '话题' AND pinyin = 'huàtí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '话题'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '话题'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huàtí',
      meaning_vi = 'chủ đề câu chuyện, đề tài đàm luận',
      example_hanzi = '聚会时只要一聊起足球和美食，大家就会有说不完的共同话题。',
      example_pinyin = 'Jùhuì shí zhǐyào yì liáo qǐ zúqiú hé měishí, dàjiā jiù huì yǒu shuō bù wán de gòngtóng huàtí.',
      example_vi = 'Khi tụ họp chỉ cần vừa nhắc tới bóng đá và ẩm thực, mọi người liền sẽ có những chủ đề chung nói mãi không hết chuyện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '话题',
      'huàtí',
      'chủ đề câu chuyện, đề tài đàm luận',
      'Danh từ',
      'HSK 5',
      '聚会时只要一聊起足球和美食，大家就会有说不完的共同话题。',
      'Jùhuì shí zhǐyào yì liáo qǐ zúqiú hé měishí, dàjiā jiù huì yǒu shuō bù wán de gòngtóng huàtí.',
      'Khi tụ họp chỉ cần vừa nhắc tới bóng đá và ẩm thực, mọi người liền sẽ có những chủ đề chung nói mãi không hết chuyện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '聚会时只要一聊起足球和美食，大家就会有说不完的共同话题。', 'Jùhuì shí zhǐyào yì liáo qǐ zúqiú hé měishí, dàjiā jiù huì yǒu shuō bù wán de gòngtóng huàtí.', 'Khi tụ họp chỉ cần vừa nhắc tới bóng đá và ẩm thực, mọi người liền sẽ có những chủ đề chung nói mãi không hết chuyện.', 'basic', 1),
      (v_id, '人工智能大模型如何重塑未来教育形态与保障数字时代个人数据隐私，已成为当今全球高等教育国际论坛与跨国科技峰会上各方学者高度聚焦的热门核心议题。', 'Réngōng zhìnéng dà móxíng rúhé chóngsù wèilái jiàoyù xíngtài yǔ bǎozhàng shùzì shídài gèrén shùjù yǐnsī, yǐ chéngwéi dāngjīn quánqiú gāoděng jiàoyù guójì lùntán yǔ kuàguó kējì fēnghuì shang gèfāng xuézhě gāodù jùjiāo de rèmén héxīn yìtí.', 'Làm thế nào để mô hình lớn trí tuệ nhân tạo tái định hình diện mạo giáo dục tương lai và bảo đảm quyền riêng tư dữ liệu cá nhân trong thời đại số, đã trở thành chủ đề cốt lõi nóng bỏng được các học giả các bên đặc biệt quan tâm hàng đầu tại các diễn đàn quốc tế giáo dục đại học và hội nghị thượng đỉnh công nghệ đa quốc gia toàn cầu ngày nay.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [2501] [化学] (huàxué) - hóa học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '化学' AND pinyin = 'huàxué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '化学' AND pinyin = 'huàxué'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '化学'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '化学'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'huàxué',
      meaning_vi = 'hóa học',
      example_hanzi = '做化学实验时必须严格遵守实验室安全操作规范，佩戴好防护眼镜和白色实验服。',
      example_pinyin = 'Zuò huàxué shíyàn shí bìxū yángé zūnshǒu shíyànshì ānquán cāozuò guīfàn, pèidài hǎo fánghù yǎnjìng hé báisè shíyànfú.',
      example_vi = 'Khi làm thí nghiệm hóa học nhất định phải tuân thủ nghiêm ngặt quy phạm thao tác an toàn phòng thí nghiệm, đeo kính bảo hộ và mặc áo blouse trắng thí nghiệm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '化学',
      'huàxué',
      'hóa học',
      'Danh từ',
      'HSK 5',
      '做化学实验时必须严格遵守实验室安全操作规范，佩戴好防护眼镜和白色实验服。',
      'Zuò huàxué shíyàn shí bìxū yángé zūnshǒu shíyànshì ānquán cāozuò guīfàn, pèidài hǎo fánghù yǎnjìng hé báisè shíyànfú.',
      'Khi làm thí nghiệm hóa học nhất định phải tuân thủ nghiêm ngặt quy phạm thao tác an toàn phòng thí nghiệm, đeo kính bảo hộ và mặc áo blouse trắng thí nghiệm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '做化学实验时必须严格遵守实验室安全操作规范，佩戴好防护眼镜和白色实验服。', 'Zuò huàxué shíyàn shí bìxū yángé zūnshǒu shíyànshì ānquán cāozuò guīfàn, pèidài hǎo fánghù yǎnjìng hé báisè shíyànfú.', 'Khi làm thí nghiệm hóa học nhất định phải tuân thủ nghiêm ngặt quy phạm thao tác an toàn phòng thí nghiệm, đeo kính bảo hộ và mặc áo blouse trắng thí nghiệm.', 'basic', 1),
      (v_id, '科学家通过将现代绿色化学合成理念与先进纳米催化技术深度融合，成功开发出一种能够在常温常压下高效降解工业微塑料废弃物的新型光化学催化剂。', 'Kēxuéjiā tōngguò jiāng xiàndài lǜsè huàxué héchéng lǐniàn yǔ xiānjìn nàmǐ cuīhuà jìshù shēndù rónghé, chénggōng kāifā chū yì zhǒng nénggòu zài chángwēn chángyā xià gāoxiào jiàngjiě gōngyè wēisùliào fèiqìwù de xīnxíng guāng huàxué cuīhuàjì.', 'Các nhà khoa học thông qua việc dung hợp sâu sắc quan niệm tổng hợp hóa học xanh hiện đại với công nghệ xúc tác nano tiên tiến, đã phát triển thành công một loại chất xúc tác quang hóa kiểu mới có khả năng phân hủy hiệu quả cao các rác thải vi nhựa công nghiệp ở nhiệt độ phòng và áp suất thường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn thành nạp Batch 5 HSK 5: % từ vựng đã được chuẩn hóa và thêm 200 câu ví dụ.', v_count;
END $$;
