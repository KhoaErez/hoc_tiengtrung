-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 14 (100 TỪ TIẾP THEO)
-- Phạm vi: #3302 [休闲] (xiūxián) -> #3401 [优质] (yōuzhì)
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
  -- [3302] [休闲] (xiūxián) - nghỉ ngơi, an dưỡng; thư giãn, giải trí [Động từ / Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '休闲' AND pinyin = 'xiūxián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '休闲' AND pinyin = 'xiūxián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '休闲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '休闲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ / Tính từ',
      pinyin = 'xiūxián',
      meaning_vi = 'nghỉ ngơi, an dưỡng; thư giãn, giải trí',
      example_hanzi = '经过一周紧张忙碌的工作，周末去郊野森林公园漫步是一种极好的休闲方式。',
      example_pinyin = 'Jīngguò yī zhōu jǐnzhāng mánglù de gōngzuò, zhōumò qù jiāoyě sēnlín gōngyuán mànbù shì yī zhǒng jí hǎo de xiūxián fāngshì.',
      example_vi = 'Trải qua một tuần làm việc căng thẳng và bận rộn, đi dạo ở công viên rừng ngoại ô vào dịp cuối tuần là một cách thư giãn giải trí vô cùng tuyệt vời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '休闲',
      'xiūxián',
      'nghỉ ngơi, an dưỡng; thư giãn, giải trí',
      'Động từ / Danh từ / Tính từ',
      'HSK 5',
      '经过一周紧张忙碌的工作，周末去郊野森林公园漫步是一种极好的休闲方式。',
      'Jīngguò yī zhōu jǐnzhāng mánglù de gōngzuò, zhōumò qù jiāoyě sēnlín gōngyuán mànbù shì yī zhǒng jí hǎo de xiūxián fāngshì.',
      'Trải qua một tuần làm việc căng thẳng và bận rộn, đi dạo ở công viên rừng ngoại ô vào dịp cuối tuần là một cách thư giãn giải trí vô cùng tuyệt vời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过一周紧张忙碌的工作，周末去郊野森林公园漫步是一种极好的休闲方式。', 'Jīngguò yī zhōu jǐnzhāng mánglù de gōngzuò, zhōumò qù jiāoyě sēnlín gōngyuán mànbù shì yī zhǒng jí hǎo de xiūxián fāngshì.', 'Trải qua một tuần làm việc căng thẳng và bận rộn, đi dạo ở công viên rừng ngoại ô vào dịp cuối tuần là một cách thư giãn giải trí vô cùng tuyệt vời.', 'basic', 1),
      (v_id, '随着国民消费结构持续优化升级，生态旅游、健康养生与户外探险等高品质现代休闲产业迎来广阔的发展机遇。', 'Suízhe guómín xiāofèi jiégòu chíxù yòuhuà shēngjí, shēngtài lǚyóu, jiànkāng yǎngshēng yǔ hùwài tànxiǎn děng gāopǐnzhì xiàndài xiūxián chǎnyè yínglái guǎngkuò de fāzhǎn jīyù.', 'Cùng với sự tối ưu hóa và nâng cấp liên tục của cơ cấu tiêu dùng quốc dân, các ngành công nghiệp giải trí hiện đại chất lượng cao như du lịch sinh thái, chăm sóc sức khỏe và thám hiểm ngoài trời đang đón nhận những cơ hội phát triển rộng mở.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3303] [需] (xū) - cần, đòi hỏi, yêu cầu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '需' AND pinyin = 'xū'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '需' AND pinyin = 'xū'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '需'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '需'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xū',
      meaning_vi = 'cần, đòi hỏi, yêu cầu',
      example_hanzi = '如需进一步咨询有关课程的具体安排，请随时拨打教务处办公室的热线电话。',
      example_pinyin = 'Rú xū jìnyībù zīxún yǒuguān kèchéng de jùtǐ ānpái, qǐng suíshí bōdǎ jiàowùchù bàngōngshì de rèxiàn diànhuà.',
      example_vi = 'Nếu cần tư vấn thêm về các sắp xếp cụ thể của khóa học, xin vui lòng gọi vào đường dây nóng của văn phòng phòng đào tạo bất cứ lúc nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '需',
      'xū',
      'cần, đòi hỏi, yêu cầu',
      'Động từ',
      'HSK 5',
      '如需进一步咨询有关课程的具体安排，请随时拨打教务处办公室的热线电话。',
      'Rú xū jìnyībù zīxún yǒuguān kèchéng de jùtǐ ānpái, qǐng suíshí bōdǎ jiàowùchù bàngōngshì de rèxiàn diànhuà.',
      'Nếu cần tư vấn thêm về các sắp xếp cụ thể của khóa học, xin vui lòng gọi vào đường dây nóng của văn phòng phòng đào tạo bất cứ lúc nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如需进一步咨询有关课程的具体安排，请随时拨打教务处办公室的热线电话。', 'Rú xū jìnyībù zīxún yǒuguān kèchéng de jùtǐ ānpái, qǐng suíshí bōdǎ jiàowùchù bàngōngshì de rèxiàn diànhuà.', 'Nếu cần tư vấn thêm về các sắp xếp cụ thể của khóa học, xin vui lòng gọi vào đường dây nóng của văn phòng phòng đào tạo bất cứ lúc nào.', 'basic', 1),
      (v_id, '先进制程高算力芯片研制需历经数万次物理仿真验证与严苛环境可靠性考核，方能满足航天级工业标准。', 'Xiānjìn zhìchéng gāo-suànlì xīnpiàn yánzhì xū lìjīng shù wàn cì wùlǐ fāngzhēn yànzhèng yǔ yánkē huánjìng kěkàoxìng kǎohé, fāng néng mǎnzú hángtiānjí gōngyè biāozhǔn.', 'Nghiên cứu chế tạo chip năng lực tính toán cao với quy trình tiên tiến đòi hỏi phải trải qua hàng vạn lần xác minh mô phỏng vật lý và khảo hạch độ tin cậy trong môi trường khắc nghiệt thì mới có thể đáp ứng được tiêu chuẩn công nghiệp cấp hàng không vũ trụ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3304] [需求] (xūqiú) - nhu cầu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '需求' AND pinyin = 'xūqiú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '需求' AND pinyin = 'xūqiú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '需求'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '需求'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xūqiú',
      meaning_vi = 'nhu cầu',
      example_hanzi = '企业研发新产品应当始终以市场为导向，深入了解并切实满足消费者的多元化需求。',
      example_pinyin = 'Qǐyè yánfā xīn chǎnpǐn yīngdāng shǐzhōng yǐ shìchǎng wéi dǎoxiàng, shēnrù liǎojiě bìng qièshí mǎnzú xiāofèizhě de duōyuánhuà xūqiú.',
      example_vi = 'Doanh nghiệp khi nghiên cứu phát triển sản phẩm mới cần luôn lấy thị trường làm định hướng, tìm hiểu sâu sắc và đáp ứng thiết thực các nhu cầu đa dạng hóa của người tiêu dùng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '需求',
      'xūqiú',
      'nhu cầu',
      'Danh từ',
      'HSK 5',
      '企业研发新产品应当始终以市场为导向，深入了解并切实满足消费者的多元化需求。',
      'Qǐyè yánfā xīn chǎnpǐn yīngdāng shǐzhōng yǐ shìchǎng wéi dǎoxiàng, shēnrù liǎojiě bìng qièshí mǎnzú xiāofèizhě de duōyuánhuà xūqiú.',
      'Doanh nghiệp khi nghiên cứu phát triển sản phẩm mới cần luôn lấy thị trường làm định hướng, tìm hiểu sâu sắc và đáp ứng thiết thực các nhu cầu đa dạng hóa của người tiêu dùng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '企业研发新产品应当始终以市场为导向，深入了解并切实满足消费者的多元化需求。', 'Qǐyè yánfā xīn chǎnpǐn yīngdāng shǐzhōng yǐ shìchǎng wéi dǎoxiàng, shēnrù liǎojiě bìng qièshí mǎnzú xiāofèizhě de duōyuánhuà xūqiú.', 'Doanh nghiệp khi nghiên cứu phát triển sản phẩm mới cần luôn lấy thị trường làm định hướng, tìm hiểu sâu sắc và đáp ứng thiết thực các nhu cầu đa dạng hóa của người tiêu dùng.', 'basic', 1),
      (v_id, '宏观调控部门围绕扩大有效投资与培育新型数字消费双向发力，切实解决国内有效需求不足的深层次结构性矛盾。', 'Hóngguān tiáokòng bùmén wéirào kuòdà yǒuxiào tóuzī yǔ péiyù xīnxíng shùzì xiāofèi shuāngxiàng fālì, qièshí jiějué guónèi yǒuxiào xūqiú bùzú de shēncéngcì jiégòuxìng máodùn.', 'Bộ phận điều tiết vĩ mô cùng lúc dồn lực vào việc mở rộng đầu tư hiệu quả và nuôi dưỡng tiêu dùng kỹ thuật số kiểu mới, giải quyết dứt điểm mâu thuẫn mang tính cơ cấu tầng sâu về việc thiếu hụt tổng cầu hiệu dụng trong nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3305] [虚心] (xūxīn) - khiêm tốn, cầu thị, biết lắng nghe [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '虚心' AND pinyin = 'xūxīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '虚心' AND pinyin = 'xūxīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '虚心'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '虚心'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'xūxīn',
      meaning_vi = 'khiêm tốn, cầu thị, biết lắng nghe',
      example_hanzi = '“虚心使人进步，骄傲使人落后”，青年人在学业与工作中必须始终保持谦虚谨慎的态度。',
      example_pinyin = '“Xūxīn shǐ rén jìnbù, jiāo’ào shǐ rén luòhòu”, qīngniánrén zài xuéyè yǔ gōngzuò zhōng bìxū shǐzhōng bǎochí qiānxū jǐnshèn de tàidù.',
      example_vi = '"Khiêm tốn giúp người ta tiến bộ, kiêu ngạo làm người ta tụt lùi", thanh niên trong học tập và công tác bắt buộc phải luôn giữ vững thái độ khiêm nhường và thận trọng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '虚心',
      'xūxīn',
      'khiêm tốn, cầu thị, biết lắng nghe',
      'Tính từ',
      'HSK 5',
      '“虚心使人进步，骄傲使人落后”，青年人在学业与工作中必须始终保持谦虚谨慎的态度。',
      '“Xūxīn shǐ rén jìnbù, jiāo’ào shǐ rén luòhòu”, qīngniánrén zài xuéyè yǔ gōngzuò zhōng bìxū shǐzhōng bǎochí qiānxū jǐnshèn de tàidù.',
      '"Khiêm tốn giúp người ta tiến bộ, kiêu ngạo làm người ta tụt lùi", thanh niên trong học tập và công tác bắt buộc phải luôn giữ vững thái độ khiêm nhường và thận trọng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '“虚心使人进步，骄傲使人落后”，青年人在学业与工作中必须始终保持谦虚谨慎的态度。', '“Xūxīn shǐ rén jìnbù, jiāo’ào shǐ rén luòhòu”, qīngniánrén zài xuéyè yǔ gōngzuò zhōng bìxū shǐzhōng bǎochí qiānxū jǐnshèn de tàidù.', '"Khiêm tốn giúp người ta tiến bộ, kiêu ngạo làm người ta tụt lùi", thanh niên trong học tập và công tác bắt buộc phải luôn giữ vững thái độ khiêm nhường và thận trọng.', 'basic', 1),
      (v_id, '顶尖科研团队领军学者始终秉持虚心求知的学术胸襟，积极吸纳跨学科创新思想并勇于打破传统科学认知藩篱。', 'Dǐngjiān kēyán tuánduì lǐngjūn xuézhě shǐzhōng bǐngchí xūxīn qiúzhī de xuéshù xiōngjīn, jījí xīnà kuà-xuékē chuàngxīn sīxiǎng bìng yǒngyú dǎpò chuántǒng kēxué rènzhī fānlí.', 'Học giả đầu ngành dẫn dắt đội ngũ nghiên cứu đỉnh cao luôn giữ vững tâm thế học thuật khiêm tốn cầu thị, tích cực tiếp thu các luồng tư tưởng đổi mới liên ngành và dũng cảm đập tan các rào cản nhận thức khoa học truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3306] [宣布] (xuānbù) - tuyên bố, công bố [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宣布' AND pinyin = 'xuānbù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宣布' AND pinyin = 'xuānbù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '宣布'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宣布'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xuānbù',
      meaning_vi = 'tuyên bố, công bố',
      example_hanzi = '校长在全校师生开学典礼上庄严宣布，本届校园科技文化节正式拉开帷幕。',
      example_pinyin = 'Xiàozhǎng zài quánxiào shīshēng kāixué diǎnlǐ shàng zhuāngyán xuānbù, běnjiè xiàoyuán kējì wénhuàjié zhèngshì lākāi wéimù.',
      example_vi = 'Hiệu trưởng tại buổi lễ khai giảng của toàn thể thầy trò nhà trường đã trang trọng tuyên bố, ngày hội văn hóa khoa học công nghệ học đường năm nay chính thức mở màn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宣布',
      'xuānbù',
      'tuyên bố, công bố',
      'Động từ',
      'HSK 5',
      '校长在全校师生开学典礼上庄严宣布，本届校园科技文化节正式拉开帷幕。',
      'Xiàozhǎng zài quánxiào shīshēng kāixué diǎnlǐ shàng zhuāngyán xuānbù, běnjiè xiàoyuán kējì wénhuàjié zhèngshì lākāi wéimù.',
      'Hiệu trưởng tại buổi lễ khai giảng của toàn thể thầy trò nhà trường đã trang trọng tuyên bố, ngày hội văn hóa khoa học công nghệ học đường năm nay chính thức mở màn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '校长在全校师生开学典礼上庄严宣布，本届校园科技文化节正式拉开帷幕。', 'Xiàozhǎng zài quánxiào shīshēng kāixué diǎnlǐ shàng zhuāngyán xuānbù, běnjiè xiàoyuán kējì wénhuàjié zhèngshì lākāi wéimù.', 'Hiệu trưởng tại buổi lễ khai giảng của toàn thể thầy trò nhà trường đã trang trọng tuyên bố, ngày hội văn hóa khoa học công nghệ học đường năm nay chính thức mở màn.', 'basic', 1),
      (v_id, '国际顶尖科学学会正式宣布，由我国科学家主导的深空探测团队在火星地下水冰层结构探测中取得了里程碑式的重大科学发现。', 'Guójì dǐngjí kēxué xuéhuì zhèngshì xuānbù, yóu wǒguó kēxuéjiā zhǔdǎo de shēnkōng tàncè tuánduì zài Huǒxīng dìxià shuǐbīngcéng jiégòu tàncè zhōng qǔdé le lǐchéngbēishì de zhòngdà kēxué fāxiàn.', 'Hiệp hội khoa học đỉnh cao quốc tế chính thức tuyên bố, đội ngũ thám trắc không gian sâu do các nhà khoa học nước ta dẫn đầu đã đạt được phát hiện khoa học trọng đại mang tính cột mốc trong việc thăm dò cấu trúc tầng băng nước ngầm trên Sao Hỏa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3307] [宣传] (xuānchuán) - tuyên truyền, quảng bá [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '宣传' AND pinyin = 'xuānchuán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宣传' AND pinyin = 'xuānchuán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '宣传'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '宣传'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xuānchuán',
      meaning_vi = 'tuyên truyền, quảng bá',
      example_hanzi = '社区志愿者通过在各个楼道张贴宣传海报和发放折页，积极向居民普及垃圾分类知识。',
      example_pinyin = 'Shèqū zhìyuànzhě tōngguò zài gègè lóudào zhāngtiē xuānchuán hǎibào hé fāfàng zhéyè, jījí xiàng jūmín pǔjí lājī fēnlèi zhīshi.',
      example_vi = 'Các tình nguyện viên cộng đồng thông qua việc dán áp phích tuyên truyền ở các hành lang tòa nhà và phát tờ gấp đã tích cực phổ biến kiến thức phân loại rác cho cư dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '宣传',
      'xuānchuán',
      'tuyên truyền, quảng bá',
      'Động từ / Danh từ',
      'HSK 5',
      '社区志愿者通过在各个楼道张贴宣传海报和发放折页，积极向居民普及垃圾分类知识。',
      'Shèqū zhìyuànzhě tōngguò zài gègè lóudào zhāngtiē xuānchuán hǎibào hé fāfàng zhéyè, jījí xiàng jūmín pǔjí lājī fēnlèi zhīshi.',
      'Các tình nguyện viên cộng đồng thông qua việc dán áp phích tuyên truyền ở các hành lang tòa nhà và phát tờ gấp đã tích cực phổ biến kiến thức phân loại rác cho cư dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '社区志愿者通过在各个楼道张贴宣传海报和发放折页，积极向居民普及垃圾分类知识。', 'Shèqū zhìyuànzhě tōngguò zài gègè lóudào zhāngtiē xuānchuán hǎibào hé fāfàng zhéyè, jījí xiàng jūmín pǔjí lājī fēnlèi zhīshi.', 'Các tình nguyện viên cộng đồng thông qua việc dán áp phích tuyên truyền ở các hành lang tòa nhà và phát tờ gấp đã tích cực phổ biến kiến thức phân loại rác cho cư dân.', 'basic', 1),
      (v_id, '国家卫生健康部门深入开展全国防灾减灾与健康素养宣传周活动，有力推动了突发公共卫生事件应急自救互救知识家喻户晓。', 'Guójiā wèishēng jiànkāng bùmén shēnrù kāizhǎn quánguó fángzāi-jiǎnzāi yǔ jiànkāng sùyǎng xuānchuánzhōu huódòng, yǒulì tuīdòng le tūfā gōnggòng wèishēng shìjiàn yìngjí zìjiù-hùjiù zhīshi jiāyù-hùxiǎo.', 'Cơ quan y tế và sức khỏe quốc gia đã triển khai sâu rộng tuần lễ tuyên truyền về phòng chống giảm nhẹ thiên tai và tố chất sức khỏe trên toàn quốc, thúc đẩy mạnh mẽ để kiến thức tự cứu và cứu giúp lẫn nhau trong các tình huống y tế công cộng khẩn cấp được mọi nhà mọi người thấu hiểu sâu sắc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3308] [选手] (xuǎnshǒu) - tuyển thủ, thí sinh tham gia thi đấu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '选手' AND pinyin = 'xuǎnshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '选手' AND pinyin = 'xuǎnshǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '选手'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '选手'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xuǎnshǒu',
      meaning_vi = 'tuyển thủ, thí sinh tham gia thi đấu',
      example_hanzi = '来自全国数十所高校的优秀青年选手在创新创业大赛全国总决赛中展开了激烈角逐。',
      example_pinyin = 'Láizì quánguó shù shí suǒ gāoxiào de yōuxiù qīngnián xuǎnshǒu zài chuàngxīn chuàngyè dàsài quánguó zǒngjuésài zhōng zhǎnkāi le jīliè juézhú.',
      example_vi = 'Các thí sinh thanh niên ưu tú đến từ hàng chục trường đại học trên cả nước đã mở màn cuộc tranh tài nảy lửa tại vòng chung kết toàn quốc cuộc thi đổi mới khởi nghiệp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '选手',
      'xuǎnshǒu',
      'tuyển thủ, thí sinh tham gia thi đấu',
      'Danh từ',
      'HSK 5',
      '来自全国数十所高校的优秀青年选手在创新创业大赛全国总决赛中展开了激烈角逐。',
      'Láizì quánguó shù shí suǒ gāoxiào de yōuxiù qīngnián xuǎnshǒu zài chuàngxīn chuàngyè dàsài quánguó zǒngjuésài zhōng zhǎnkāi le jīliè juézhú.',
      'Các thí sinh thanh niên ưu tú đến từ hàng chục trường đại học trên cả nước đã mở màn cuộc tranh tài nảy lửa tại vòng chung kết toàn quốc cuộc thi đổi mới khởi nghiệp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '来自全国数十所高校的优秀青年选手在创新创业大赛全国总决赛中展开了激烈角逐。', 'Láizì quánguó shù shí suǒ gāoxiào de yōuxiù qīngnián xuǎnshǒu zài chuàngxīn chuàngyè dàsài quánguó zǒngjuésài zhōng zhǎnkāi le jīliè juézhú.', 'Các thí sinh thanh niên ưu tú đến từ hàng chục trường đại học trên cả nước đã mở màn cuộc tranh tài nảy lửa tại vòng chung kết toàn quốc cuộc thi đổi mới khởi nghiệp.', 'basic', 1),
      (v_id, '经过严酷极限过载耐受、深水失重训练以及心理素质综合考核，数名优秀航天员选手入选载人登月关键工程飞行乘组梯队。', 'Jīngguò yánkù jíduān guòzài nàishòu, shēnshuǐ shīzhòng xùnliàn yǐjí xīnlǐ sùzhì zōnghé kǎohé, shù míng yōuxiù hángtiānyuán xuǎnshǒu rùxuǎn zàirén dēngyuè guānjiàn gōngchéng fēixíng chéngzǔ tīduì.', 'Trải qua các kỳ sát hạch tổng hợp về chịu đựng tải trọng quá mức cực đoan khắc nghiệt, huấn luyện không trọng lượng dưới nước sâu và phẩm chất tâm lý, nhiều tuyển thủ phi hành gia ưu tú đã trúng tuyển vào đội hình phi hành đoàn cho công trình trọng điểm đưa người đổ bộ lên mặt trăng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3309] [学分] (xuéfēn) - tín chỉ học tập, điểm học phần [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '学分' AND pinyin = 'xuéfēn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学分' AND pinyin = 'xuéfēn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '学分'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学分'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xuéfēn',
      meaning_vi = 'tín chỉ học tập, điểm học phần',
      example_hanzi = '本科生必须在规定的四至六年弹性学制之内，修满专业培养方案所要求的全部必修与选修学分。',
      example_pinyin = 'Běnkēshēng bìxū zài guīdìng de sì zhì liù nián tánxìng xuézhì zhīnèi, xiū mǎn zhuānyè péiyǎng fāng’àn suǒ yāoqiú de quánbù bìxiū yǔ xuǎnxiū xuéfēn.',
      example_vi = 'Sinh viên đại học chính quy bắt buộc phải tích lũy đủ toàn bộ số tín chỉ bắt buộc và tự chọn theo yêu cầu của chương trình đào tạo chuyên ngành trong khung thời gian đào tạo mềm dẻo từ 4 đến 6 năm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '学分',
      'xuéfēn',
      'tín chỉ học tập, điểm học phần',
      'Danh từ',
      'HSK 5',
      '本科生必须在规定的四至六年弹性学制之内，修满专业培养方案所要求的全部必修与选修学分。',
      'Běnkēshēng bìxū zài guīdìng de sì zhì liù nián tánxìng xuézhì zhīnèi, xiū mǎn zhuānyè péiyǎng fāng’àn suǒ yāoqiú de quánbù bìxiū yǔ xuǎnxiū xuéfēn.',
      'Sinh viên đại học chính quy bắt buộc phải tích lũy đủ toàn bộ số tín chỉ bắt buộc và tự chọn theo yêu cầu của chương trình đào tạo chuyên ngành trong khung thời gian đào tạo mềm dẻo từ 4 đến 6 năm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '本科生必须在规定的四至六年弹性学制之内，修满专业培养方案所要求的全部必修与选修学分。', 'Běnkēshēng bìxū zài guīdìng de sì zhì liù nián tánxìng xuézhì zhīnèi, xiū mǎn zhuānyè péiyǎng fāng’àn suǒ yāoqiú de quánbù bìxiū yǔ xuǎnxiū xuéfēn.', 'Sinh viên đại học chính quy bắt buộc phải tích lũy đủ toàn bộ số tín chỉ bắt buộc và tự chọn theo yêu cầu của chương trình đào tạo chuyên ngành trong khung thời gian đào tạo mềm dẻo từ 4 đến 6 năm.', 'basic', 1),
      (v_id, '一流大学联盟全面推行跨校跨学科课程资源互选与学分互认机制，为复合型基础拔尖科研人才的自由成长拆除专业壁垒。', 'Yīliú dàxué liánméng quánmiàn tuīxíng kuà-xiào kuà-xuékē kèchéng zīyuán hùxuǎn yǔ xuéfēn hùrèn jīzhì, wèi fùhéxíng jīchǔ bájiān kēyán réncái de zìyóu chéngzhǎng chāichú zhuānyè bìlěi.', 'Liên minh các trường đại học hàng đầu triển khai toàn diện cơ chế chọn môn học chéo giữa các trường và liên ngành cùng công nhận tín chỉ lẫn nhau, gỡ bỏ các rào cản chuyên ngành để các tài nhân nghiên cứu khoa học xuất sắc đa lĩnh vực phát triển tự do.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3310] [学科] (xuékē) - ngành học, môn học, bộ môn khoa học [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '学科' AND pinyin = 'xuékē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学科' AND pinyin = 'xuékē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '学科'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学科'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xuékē',
      meaning_vi = 'ngành học, môn học, bộ môn khoa học',
      example_hanzi = '他在大学期间主修软件工程，课余时间还自主选修了应用心理学与管理学等跨领域学科。',
      example_pinyin = 'Tā zài dàxué qījiān zhǔxiū ruǎnjiàn gōngchéng, kèyú shíjiān hái zìzhǔ xuǎnxiū le yìngyòng xīnlǐxué yǔ guǎnlǐxué děng kuà-lǐngyù xuékē.',
      example_vi = 'Thời đại học anh ấy theo học chuyên ngành chính là kỹ thuật phần mềm, thời gian ngoài giờ còn tự giác chọn học thêm các môn học liên lĩnh vực như tâm lý học ứng dụng và khoa học quản lý.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '学科',
      'xuékē',
      'ngành học, môn học, bộ môn khoa học',
      'Danh từ',
      'HSK 5',
      '他在大学期间主修软件工程，课余时间还自主选修了应用心理学与管理学等跨领域学科。',
      'Tā zài dàxué qījiān zhǔxiū ruǎnjiàn gōngchéng, kèyú shíjiān hái zìzhǔ xuǎnxiū le yìngyòng xīnlǐxué yǔ guǎnlǐxué děng kuà-lǐngyù xuékē.',
      'Thời đại học anh ấy theo học chuyên ngành chính là kỹ thuật phần mềm, thời gian ngoài giờ còn tự giác chọn học thêm các môn học liên lĩnh vực như tâm lý học ứng dụng và khoa học quản lý.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在大学期间主修软件工程，课余时间还自主选修了应用心理学与管理学等跨领域学科。', 'Tā zài dàxué qījiān zhǔxiū ruǎnjiàn gōngchéng, kèyú shíjiān hái zìzhǔ xuǎnxiū le yìngyòng xīnlǐxué yǔ guǎnlǐxué děng kuà-lǐngyù xuékē.', 'Thời đại học anh ấy theo học chuyên ngành chính là kỹ thuật phần mềm, thời gian ngoài giờ còn tự giác chọn học thêm các môn học liên lĩnh vực như tâm lý học ứng dụng và khoa học quản lý.', 'basic', 1),
      (v_id, '国家“双一流”战略全面统筹推进基础前沿学科、战略新兴交叉学科与关键急需工程学科的一体化协同发展与布局。', 'Guójiā “shuāng-yīliú” zhànlüè quánmiàn tǒngchóu tuījìn jīchǔ qiányán xuékē, zhànlüè xīnxīng jiāochā xuékē yǔ guānjiàn jíxū gōngchéng xuékē de yītǐhuà xiétóng fāzhǎn yǔ bùjú.', 'Chiến lược "Song nhất lưu" quốc gia quy hoạch điều phối toàn diện sự phát triển hiệp đồng và bố trí tích hợp giữa các ngành học cơ sở tiền duyên, ngành học giao thoa mới nổi mang tính chiến lược và các ngành kỹ thuật công trình trọng điểm cấp thiết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3311] [学历] (xuélì) - trình độ học vấn, văn bằng chứng chỉ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '学历' AND pinyin = 'xuélì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学历' AND pinyin = 'xuélì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '学历'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学历'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xuélì',
      meaning_vi = 'trình độ học vấn, văn bằng chứng chỉ',
      example_hanzi = '在选拔优秀人才时，用人单位既要考察应聘者的学历文凭，更要综合评估其实际工作技能与职业素养。',
      example_pinyin = 'Zài xuǎnbá yōuxiù réncái shí, yòngrén dānwèi jì yào kǎochá yìngpìnzhě de xuélì wénpíng, gèng yào zōnghé pínggū qí shíjì gōngzuò jìnéng yǔ zhíyè sùyǎng.',
      example_vi = 'Khi tuyển chọn nhân tài ưu tú, đơn vị tuyển dụng vừa cần xem xét văn bằng học vấn của ứng viên, lại càng phải đánh giá tổng hợp về kỹ năng làm việc thực tế và tố chất nghề nghiệp của họ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '学历',
      'xuélì',
      'trình độ học vấn, văn bằng chứng chỉ',
      'Danh từ',
      'HSK 5',
      '在选拔优秀人才时，用人单位既要考察应聘者的学历文凭，更要综合评估其实际工作技能与职业素养。',
      'Zài xuǎnbá yōuxiù réncái shí, yòngrén dānwèi jì yào kǎochá yìngpìnzhě de xuélì wénpíng, gèng yào zōnghé pínggū qí shíjì gōngzuò jìnéng yǔ zhíyè sùyǎng.',
      'Khi tuyển chọn nhân tài ưu tú, đơn vị tuyển dụng vừa cần xem xét văn bằng học vấn của ứng viên, lại càng phải đánh giá tổng hợp về kỹ năng làm việc thực tế và tố chất nghề nghiệp của họ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在选拔优秀人才时，用人单位既要考察应聘者的学历文凭，更要综合评估其实际工作技能与职业素养。', 'Zài xuǎnbá yōuxiù réncái shí, yòngrén dānwèi jì yào kǎochá yìngpìnzhě de xuélì wénpíng, gèng yào zōnghé pínggū qí shíjì gōngzuò jìnéng yǔ zhíyè sùyǎng.', 'Khi tuyển chọn nhân tài ưu tú, đơn vị tuyển dụng vừa cần xem xét văn bằng học vấn của ứng viên, lại càng phải đánh giá tổng hợp về kỹ năng làm việc thực tế và tố chất nghề nghiệp của họ.', 'basic', 1),
      (v_id, '现代科技人才评价改革坚决破除唯论文、唯帽子、唯职称、唯学历的固化痼疾，建立健全以实际创新贡献为核心的科学导向。', 'Xiàndài kējì réncái píngjià gǎigé jiānjué pòchú wéi lùnwén, wéi màozi, wéi zhíchēng, wéi xuélì de gùhuà gùjí, jiànlì jiànquán yǐ shíjì chuàngxīn gòngxiàn wéi héxīn de kēxué dǎoxiàng.', 'Cải cách đánh giá nhân tài khoa học công nghệ hiện đại kiên quyết xóa bỏ các căn bệnh cố hữu coi trọng duy nhất luận văn, học hàm, chức danh, bằng cấp học vấn, xây dựng hoàn thiện định hướng khoa học lấy đóng góp đổi mới sáng tạo thực tế làm hạt nhân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3312] [学年] (xuénián) - năm học, niên khóa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '学年' AND pinyin = 'xuénián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学年' AND pinyin = 'xuénián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '学年'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学年'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xuénián',
      meaning_vi = 'năm học, niên khóa',
      example_hanzi = '崭新的学年伊始，大学校园里迎来了数千名满怀青春理想与求知热忱的青年新生。',
      example_pinyin = 'Zhǎnxīn de xuénián yīshǐ, dàxué xiàoyuán lǐ yínglái le shù qiān míng mǎnhuái qīngchūn lǐxiǎng yǔ qiúzhī rèchén de qīngnián xīnshēng.',
      example_vi = 'Niên khóa mới toanh vừa bắt đầu, khuôn viên trường đại học đã đón chào hàng nghìn bạn tân sinh viên trẻ tuổi ngập tràn lý tưởng thanh xuân và nhiệt huyết cầu tri thức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '学年',
      'xuénián',
      'năm học, niên khóa',
      'Danh từ',
      'HSK 5',
      '崭新的学年伊始，大学校园里迎来了数千名满怀青春理想与求知热忱的青年新生。',
      'Zhǎnxīn de xuénián yīshǐ, dàxué xiàoyuán lǐ yínglái le shù qiān míng mǎnhuái qīngchūn lǐxiǎng yǔ qiúzhī rèchén de qīngnián xīnshēng.',
      'Niên khóa mới toanh vừa bắt đầu, khuôn viên trường đại học đã đón chào hàng nghìn bạn tân sinh viên trẻ tuổi ngập tràn lý tưởng thanh xuân và nhiệt huyết cầu tri thức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '崭新的学年伊始，大学校园里迎来了数千名满怀青春理想与求知热忱的青年新生。', 'Zhǎnxīn de xuénián yīshǐ, dàxué xiàoyuán lǐ yínglái le shù qiān míng mǎnhuái qīngchūn lǐxiǎng yǔ qiúzhī rèchén de qīngnián xīnshēng.', 'Niên khóa mới toanh vừa bắt đầu, khuôn viên trường đại học đã đón chào hàng nghìn bạn tân sinh viên trẻ tuổi ngập tràn lý tưởng thanh xuân và nhiệt huyết cầu tri thức.', 'basic', 1),
      (v_id, '高校在每一学年终了全面实施教学质量全要素常态化评估，紧密跟踪学科课程设置的实际前沿适应性与师生满意度。', 'Gāoxiào zài měi yī xuénián zhōngliǎo quánmiàn shíshī jiàoxué zhìliàng quán-yàosù chángtàihuà pínggū, jǐnmì gēnzōng xuékē kèchéng shèzhì de shíjì qiányán shìyìngxìng yǔ shī-shēng mǎnyìdù.', 'Các trường đại học khi kết thúc mỗi năm học đều thực thi toàn diện việc đánh giá thường thái hóa mọi yếu tố chất lượng giảng dạy, theo dõi sát sao tính thích ứng tiền duyên thực tế của chương trình môn học và mức độ hài lòng của giảng viên, sinh viên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3313] [学术] (xuéshù) - học thuật, nghiên cứu học thuật [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '学术' AND pinyin = 'xuéshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学术' AND pinyin = 'xuéshù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '学术'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学术'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xuéshù',
      meaning_vi = 'học thuật, nghiên cứu học thuật',
      example_hanzi = '这场高规格的国际学术研讨会汇聚了来自海内外数十所顶尖高校的权威教授与优秀学者。',
      example_pinyin = 'Zhè chǎng gāoguīgé de guójì xuéshù yántǎohuì huìjù le láizì hǎinèiwài shù shí suǒ dǐngjiān gāoxiào de quánwēi jiàoshòu yǔ yōuxiù xuézhě.',
      example_vi = 'Hội thảo học thuật quốc tế quy mô cao này quy tụ các giáo sư uy tín và học giả ưu tú đến từ hàng chục trường đại học hàng đầu trong và ngoài nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '学术',
      'xuéshù',
      'học thuật, nghiên cứu học thuật',
      'Danh từ',
      'HSK 5',
      '这场高规格的国际学术研讨会汇聚了来自海内外数十所顶尖高校的权威教授与优秀学者。',
      'Zhè chǎng gāoguīgé de guójì xuéshù yántǎohuì huìjù le láizì hǎinèiwài shù shí suǒ dǐngjiān gāoxiào de quánwēi jiàoshòu yǔ yōuxiù xuézhě.',
      'Hội thảo học thuật quốc tế quy mô cao này quy tụ các giáo sư uy tín và học giả ưu tú đến từ hàng chục trường đại học hàng đầu trong và ngoài nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这场高规格的国际学术研讨会汇聚了来自海内外数十所顶尖高校的权威教授与优秀学者。', 'Zhè chǎng gāoguīgé de guójì xuéshù yántǎohuì huìjù le láizì hǎinèiwài shù shí suǒ dǐngjiān gāoxiào de quánwēi jiàoshòu yǔ yōuxiù xuézhě.', 'Hội thảo học thuật quốc tế quy mô cao này quy tụ các giáo sư uy tín và học giả ưu tú đến từ hàng chục trường đại học hàng đầu trong và ngoài nước.', 'basic', 1),
      (v_id, '高等学术研究机构必须坚守严谨求实的科学精神与学术道德底线，对任何抄袭造假等学术不端行为实行一票否决制。', 'Gāoděng xuéshù yánjiū jīgòu bìxū jiānshǒu yánjǐn qiúshí de kēxué jīngshén yǔ xuéshù dàodé dǐxiàn, duì rènhé chāoxí zàojiǎ děng xuéshù bùduān xíngwéi shíxíng yīpiào fǒujuézhì.', 'Các viện cơ quan nghiên cứu học thuật bậc cao bắt buộc phải giữ vững tinh thần khoa học cẩn trọng thực tế và lằn ranh đỏ đạo đức học thuật, thực thi cơ chế một phiếu phủ quyết đối với mọi hành vi sai trái trong học thuật như đạo văn hay ngụy tạo số liệu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3314] [学者] (xuézhě) - học giả, nhà nghiên cứu [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '学者' AND pinyin = 'xuézhě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学者' AND pinyin = 'xuézhě'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '学者'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '学者'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xuézhě',
      meaning_vi = 'học giả, nhà nghiên cứu',
      example_hanzi = '这位德高望重的老学者毕生潜心于中国古代文史典籍的整理与考据，著作等身。',
      example_pinyin = 'Zhè wèi dégāo-wàngzhòng de lǎo xuézhě bìshēng qiǎnxīn yú Zhōngguó gǔdài wén-shǐ diǎnjí de zhěnglǐ yǔ kǎojù, zhùzuò-děngshēn.',
      example_vi = 'Vị học giả lão thành đức cao vọng trọng này cả đời dốc lòng cho công tác chỉnh lý và khảo chứng văn tịch lịch sử cổ đại Trung Hoa, tác phẩm xuất bản nhiều khôn xiết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '学者',
      'xuézhě',
      'học giả, nhà nghiên cứu',
      'Danh từ',
      'HSK 5',
      '这位德高望重的老学者毕生潜心于中国古代文史典籍的整理与考据，著作等身。',
      'Zhè wèi dégāo-wàngzhòng de lǎo xuézhě bìshēng qiǎnxīn yú Zhōngguó gǔdài wén-shǐ diǎnjí de zhěnglǐ yǔ kǎojù, zhùzuò-děngshēn.',
      'Vị học giả lão thành đức cao vọng trọng này cả đời dốc lòng cho công tác chỉnh lý và khảo chứng văn tịch lịch sử cổ đại Trung Hoa, tác phẩm xuất bản nhiều khôn xiết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位德高望重的老学者毕生潜心于中国古代文史典籍的整理与考据，著作等身。', 'Zhè wèi dégāo-wàngzhòng de lǎo xuézhě bìshēng qiǎnxīn yú Zhōngguó gǔdài wén-shǐ diǎnjí de zhěnglǐ yǔ kǎojù, zhùzuò-děngshēn.', 'Vị học giả lão thành đức cao vọng trọng này cả đời dốc lòng cho công tác chỉnh lý và khảo chứng văn tịch lịch sử cổ đại Trung Hoa, tác phẩm xuất bản nhiều khôn xiết.', 'basic', 1),
      (v_id, '国际宏观经济论坛邀请全球一流经济学家与资深战略学者开展跨界圆桌对话，为全球产业链供应链韧性提升贡献智慧方案。', 'Guójì hóngguān jīngjì lùntán yāoqǐng quánqiú yīliú jīngjìxuéjiā yǔ zīshēn zhànlüè xuézhě kāizhǎn kuàjiè yuánzhuō duìhuà, wèi quánqiú chǎnyèliàn gōngyìngliàn rènxìng tíshēng gòngxiàn zhìhuì fāng’àn.', 'Diễn đàn kinh tế vĩ mô quốc tế mời các nhà kinh tế học hạng nhất toàn cầu và các học giả chiến lược lâu năm mở màn cuộc đối thoại bàn tròn xuyên biên giới, đóng góp các phương án trí tuệ để nâng cao độ bền vững cho chuỗi cung ứng và chuỗi công nghiệp thế giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3315] [雪糕] (xuěgāo) - que kem, kem cây, kem que [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '雪糕' AND pinyin = 'xuěgāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '雪糕' AND pinyin = 'xuěgāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '雪糕'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '雪糕'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xuěgāo',
      meaning_vi = 'que kem, kem cây, kem que',
      example_hanzi = '炎热难耐的夏日午后，吃上一根清凉甜润的鲜奶雪糕总能让人瞬间感到无比惬意。',
      example_pinyin = 'Yánrè nánnài de xiàrì wǔhòu, chī shàng yī gēn qīngliáng tiánrùn de xiānnǎi xuěgāo zǒng néng ràng rén shùnjiān gǎndào wúbǐ qièyì.',
      example_vi = 'Buổi trưa hè nóng nực khó chịu, ăn một que kem sữa tươi thanh mát ngọt dịu luôn khiến người ta ngay lập tức cảm thấy vô cùng khoan khoái.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '雪糕',
      'xuěgāo',
      'que kem, kem cây, kem que',
      'Danh từ',
      'HSK 5',
      '炎热难耐的夏日午后，吃上一根清凉甜润的鲜奶雪糕总能让人瞬间感到无比惬意。',
      'Yánrè nánnài de xiàrì wǔhòu, chī shàng yī gēn qīngliáng tiánrùn de xiānnǎi xuěgāo zǒng néng ràng rén shùnjiān gǎndào wúbǐ qièyì.',
      'Buổi trưa hè nóng nực khó chịu, ăn một que kem sữa tươi thanh mát ngọt dịu luôn khiến người ta ngay lập tức cảm thấy vô cùng khoan khoái.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '炎热难耐的夏日午后，吃上一根清凉甜润的鲜奶雪糕总能让人瞬间感到无比惬意。', 'Yánrè nánnài de xiàrì wǔhòu, chī shàng yī gēn qīngliáng tiánrùn de xiānnǎi xuěgāo zǒng néng ràng rén shùnjiān gǎndào wúbǐ qièyì.', 'Buổi trưa hè nóng nực khó chịu, ăn một que kem sữa tươi thanh mát ngọt dịu luôn khiến người ta ngay lập tức cảm thấy vô cùng khoan khoái.', 'basic', 1),
      (v_id, '传统冷饮制造龙头企业深度融合天然草本果萃与现代低温锁鲜工艺，创新推出了多款富含益生菌且低糖低脂的健康文创国风雪糕。', 'Chuántǒng lěngyǐn zhìzào lóngtóu qǐyè shēndù rónghé tiānrán cǎoběn guǒcuì yǔ xiàndài dīwēn suǒxiān gōngyì, chuàngxīn tuīchū le duō kuǎn fùhán yìshēngjùn qiě dītáng dīzhī de jiànkāng wénchuàng guófēng xuěgāo.', 'Doanh nghiệp đầu ngành sản xuất đồ uống lạnh truyền thống kết hợp sâu sắc chiết xuất trái cây thảo mộc tự nhiên với công nghệ khóa tươi nhiệt độ thấp hiện đại, cho ra mắt nhiều mẫu kem que phong cách văn hóa truyền thống tốt cho sức khỏe giàu men vi sinh, ít đường và ít béo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3316] [询问] (xúnwèn) - hỏi thăm, tra hỏi, dò hỏi, thăm hỏi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '询问' AND pinyin = 'xúnwèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '询问' AND pinyin = 'xúnwèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '询问'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '询问'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xúnwèn',
      meaning_vi = 'hỏi thăm, tra hỏi, dò hỏi, thăm hỏi',
      example_hanzi = '初次到访这座陌生城市的游客走上前台，礼貌地向工作人员询问前往地铁枢纽的步行路线。',
      example_pinyin = 'Chūcì dàofǎng zhè zuò mòshēng chéngshì de yóukè zǒu shàng qiántái, lǐmào de xiàng gōngzuò rényuán xúnwèn qiánwǎng dìtiě shūniǔ de bùxíng lùxiàn.',
      example_vi = 'Du khách lần đầu tới thăm thành phố xa lạ này bước lên quầy tiếp tân, lịch sự hỏi thăm nhân viên về tuyến đường đi bộ đến đầu mối tàu điện ngầm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '询问',
      'xúnwèn',
      'hỏi thăm, tra hỏi, dò hỏi, thăm hỏi',
      'Động từ',
      'HSK 5',
      '初次到访这座陌生城市的游客走上前台，礼貌地向工作人员询问前往地铁枢纽的步行路线。',
      'Chūcì dàofǎng zhè zuò mòshēng chéngshì de yóukè zǒu shàng qiántái, lǐmào de xiàng gōngzuò rényuán xúnwèn qiánwǎng dìtiě shūniǔ de bùxíng lùxiàn.',
      'Du khách lần đầu tới thăm thành phố xa lạ này bước lên quầy tiếp tân, lịch sự hỏi thăm nhân viên về tuyến đường đi bộ đến đầu mối tàu điện ngầm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '初次到访这座陌生城市的游客走上前台，礼貌地向工作人员询问前往地铁枢纽的步行路线。', 'Chūcì dàofǎng zhè zuò mòshēng chéngshì de yóukè zǒu shàng qiántái, lǐmào de xiàng gōngzuò rényuán xúnwèn qiánwǎng dìtiě shūniǔ de bùxíng lùxiàn.', 'Du khách lần đầu tới thăm thành phố xa lạ này bước lên quầy tiếp tân, lịch sự hỏi thăm nhân viên về tuyến đường đi bộ đến đầu mối tàu điện ngầm.', 'basic', 1),
      (v_id, '临床资深专科主治医师在接诊罕见病患者时极其耐心细致地询问其家族遗传史与用药史，为制定个性化精准靶向治疗策略掌握一手依据。', 'Línchuáng zīshēn zhuānkē zhǔzhì yīshī zài jiēzhěn hǎnjiànbìng huànzhě shí jíqí nàixīn xìzhì de xúnwèn qí jiāzú yíchuánshǐ yǔ yòngyàoshǐ, wèi zhìdìng gèxìnghuà jīngzhǔn bǎxiàng zhìliáo cèlüè zhǎngwò yīshǒu yījù.', 'Bác sĩ chuyên khoa chính giàu kinh nghiệm lâm sàng khi tiếp nhận bệnh nhân mắc bệnh hiếm đã vô cùng kiên nhẫn và tỉ mỉ thăm hỏi về tiền sử di truyền gia đình và tiền sử dùng thuốc, nhằm nắm bắt căn cứ thực tế trực tiếp để đưa ra chiến lược điều trị đích chính xác mang tính cá nhân hóa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3317] [寻找] (xúnzhǎo) - tìm kiếm, tìm tòi [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '寻找' AND pinyin = 'xúnzhǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '寻找' AND pinyin = 'xúnzhǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '寻找'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '寻找'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xúnzhǎo',
      meaning_vi = 'tìm kiếm, tìm tòi',
      example_hanzi = '面对充满未知的职业生涯未来，青年人应当在踏实的社会实践中不断寻找属于自己的人生奋斗方向。',
      example_pinyin = 'Miànduì chōngmǎn wèizhī de zhíyè shēngyá wèilái, qīngniánrén yīngdāng zài tàshi de shèhuì shíjiàn zhōng bùduàn xúnzhǎo shǔyú zìjǐ de rénshēng fèndòu fāngxiàng.',
      example_vi = 'Trước tương lai sự nghiệp đầy những điều chưa biết, thanh niên nên liên tục tìm kiếm phương hướng phấn đấu cuộc đời thuộc về chính mình trong các hoạt động thực tiễn xã hội vững chắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '寻找',
      'xúnzhǎo',
      'tìm kiếm, tìm tòi',
      'Động từ',
      'HSK 5',
      '面对充满未知的职业生涯未来，青年人应当在踏实的社会实践中不断寻找属于自己的人生奋斗方向。',
      'Miànduì chōngmǎn wèizhī de zhíyè shēngyá wèilái, qīngniánrén yīngdāng zài tàshi de shèhuì shíjiàn zhōng bùduàn xúnzhǎo shǔyú zìjǐ de rénshēng fèndòu fāngxiàng.',
      'Trước tương lai sự nghiệp đầy những điều chưa biết, thanh niên nên liên tục tìm kiếm phương hướng phấn đấu cuộc đời thuộc về chính mình trong các hoạt động thực tiễn xã hội vững chắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对充满未知的职业生涯未来，青年人应当在踏实的社会实践中不断寻找属于自己的人生奋斗方向。', 'Miànduì chōngmǎn wèizhī de zhíyè shēngyá wèilái, qīngniánrén yīngdāng zài tàshi de shèhuì shíjiàn zhōng bùduàn xúnzhǎo shǔyú zìjǐ de rénshēng fèndòu fāngxiàng.', 'Trước tương lai sự nghiệp đầy những điều chưa biết, thanh niên nên liên tục tìm kiếm phương hướng phấn đấu cuộc đời thuộc về chính mình trong các hoạt động thực tiễn xã hội vững chắc.', 'basic', 1),
      (v_id, '射电天文学国际合作团队利用五百米口径球面射电望远镜，在浩瀚宇宙深处持续寻找并系统证认超高精度毫秒脉冲星。', 'Shèdiàn tiānwénxué guójì hézuò tuánduì lìyòng wǔbǎi mǐ kǒujìng qiúmiàn shèdiàn wàngyuǎnjìng, zài hàohàn yǔzhòu shēncù chíxù xúnzhǎo bìng xìtǒng zhèngrèn chāogāojīngdù háomiǎo màichōngxīng.', 'Đội ngũ hợp tác quốc tế về thiên văn vô tuyến tận dụng kính thiên văn vô tuyến hình cầu khẩu độ 500 mét (FAST) để liên tục tìm kiếm và kiểm chứng có hệ thống các pulsar mili giây độ chính xác siêu cao nơi sâu thẳm vũ trụ bao la.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3318] [训练] (xùnliàn) - huấn luyện, rèn luyện; bài tập huấn luyện [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '训练' AND pinyin = 'xùnliàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '训练' AND pinyin = 'xùnliàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '训练'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '训练'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xùnliàn',
      meaning_vi = 'huấn luyện, rèn luyện; bài tập huấn luyện',
      example_hanzi = '国家体育代表队选手每天清晨都会在运动场上坚持进行长达数小时的高强度体能与战术战役训练。',
      example_pinyin = 'Guójiā tǐyù dàibiǎoduì xuǎnshǒu měitiān qīngchén dōu huì zài yùndòngchǎng shàng jiānchí jìnxíng chángdá shù xiǎoshí de gāomiángdù tǐnéng yǔ zhànshù zhànyì xùnliàn.',
      example_vi = 'Các tuyển thủ đội tuyển thể thao quốc gia mỗi sáng sớm đều kiên trì rèn luyện thể lực cường độ cao và kỹ chiến thuật kéo dài nhiều giờ liền trên sân vận động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '训练',
      'xùnliàn',
      'huấn luyện, rèn luyện; bài tập huấn luyện',
      'Động từ / Danh từ',
      'HSK 5',
      '国家体育代表队选手每天清晨都会在运动场上坚持进行长达数小时的高强度体能与战术战役训练。',
      'Guójiā tǐyù dàibiǎoduì xuǎnshǒu měitiān qīngchén dōu huì zài yùndòngchǎng shàng jiānchí jìnxíng chángdá shù xiǎoshí de gāomiángdù tǐnéng yǔ zhànshù zhànyì xùnliàn.',
      'Các tuyển thủ đội tuyển thể thao quốc gia mỗi sáng sớm đều kiên trì rèn luyện thể lực cường độ cao và kỹ chiến thuật kéo dài nhiều giờ liền trên sân vận động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '国家体育代表队选手每天清晨都会在运动场上坚持进行长达数小时的高强度体能与战术战役训练。', 'Guójiā tǐyù dàibiǎoduì xuǎnshǒu měitiān qīngchén dōu huì zài yùndòngchǎng shàng jiānchí jìnxíng chángdá shù xiǎoshí de gāomiángdù tǐnéng yǔ zhànshù zhànyì xùnliàn.', 'Các tuyển thủ đội tuyển thể thao quốc gia mỗi sáng sớm đều kiên trì rèn luyện thể lực cường độ cao và kỹ chiến thuật kéo dài nhiều giờ liền trên sân vận động.', 'basic', 1),
      (v_id, '人工智能基础大模型研发团队依托万卡异构算力集群，通过千亿级高质量多模态语料对通用深度学习网络模型展开分布式预训练。', 'Réngōng zhìnéng jīchǔ dà móxíng yánfā tuánduì yītuō wànkǎ yìgòu suànlì jíqún, tōngguò qiān-yì jí gāozhìliàng duōmótài yǔliào duì tōngyòng shēndù xuéxí wǎngluò móxíng zhǎnkāi fēnbùshì yù-xùnliàn.', 'Đội ngũ R&D mô hình nền tảng trí tuệ nhân tạo lớn dựa vào cụm tính toán dị cấu hàng vạn GPU, sử dụng kho ngữ liệu đa phương thức chất lượng cao cấp hàng trăm tỷ để triển khai tiền huấn luyện phân tán cho mô hình mạng học sâu đa năng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3319] [迅速] (xùnsù) - nhanh chóng, mau lẹ, thần tốc [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '迅速' AND pinyin = 'xùnsù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迅速' AND pinyin = 'xùnsù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '迅速'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迅速'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'xùnsù',
      meaning_vi = 'nhanh chóng, mau lẹ, thần tốc',
      example_hanzi = '突发火情报警电话打响之后，专业消防救援支队迅速出警赶赴现场，仅用十多分钟就扑灭了火势。',
      example_pinyin = 'Tūfā huǒqíng bàojǐng diànhuà dǎxiǎng zhīhòu, zhuānyè xiāofáng jiùyuán zhīduì xùnsù chūjǐng gǎnfù xiànchǎng, jǐn yòng shí duō fēnzhōng jiù pūmiè le huǒshì.',
      example_vi = 'Sau khi cuộc gọi báo cháy khẩn cấp đổ chuông, chi đội cứu hỏa cứu nạn chuyên nghiệp đã nhanh chóng xuất kích tới hiện trường, chỉ mất hơn mười phút đã dập tắt ngọn lửa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '迅速',
      'xùnsù',
      'nhanh chóng, mau lẹ, thần tốc',
      'Tính từ / Phó từ',
      'HSK 5',
      '突发火情报警电话打响之后，专业消防救援支队迅速出警赶赴现场，仅用十多分钟就扑灭了火势。',
      'Tūfā huǒqíng bàojǐng diànhuà dǎxiǎng zhīhòu, zhuānyè xiāofáng jiùyuán zhīduì xùnsù chūjǐng gǎnfù xiànchǎng, jǐn yòng shí duō fēnzhōng jiù pūmiè le huǒshì.',
      'Sau khi cuộc gọi báo cháy khẩn cấp đổ chuông, chi đội cứu hỏa cứu nạn chuyên nghiệp đã nhanh chóng xuất kích tới hiện trường, chỉ mất hơn mười phút đã dập tắt ngọn lửa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '突发火情报警电话打响之后，专业消防救援支队迅速出警赶赴现场，仅用十多分钟就扑灭了火势。', 'Tūfā huǒqíng bàojǐng diànhuà dǎxiǎng zhīhòu, zhuānyè xiāofáng jiùyuán zhīduì xùnsù chūjǐng gǎnfù xiànchǎng, jǐn yòng shí duō fēnzhōng jiù pūmiè le huǒshì.', 'Sau khi cuộc gọi báo cháy khẩn cấp đổ chuông, chi đội cứu hỏa cứu nạn chuyên nghiệp đã nhanh chóng xuất kích tới hiện trường, chỉ mất hơn mười phút đã dập tắt ngọn lửa.', 'basic', 1),
      (v_id, '面对严峻复杂的全球产业链断供潜在风险，高科技制造领军企业迅速启动核心零部件多源冗余备份采购与国产化替代方案。', 'Miànduì yánjùn fùzá de quánqiú chǎnyèliàn duàngōng qiánzài fēngxiǎn, gāokējì zhìzào lǐngjūn qǐyè xùnsù qǐdòng héxīn língbùjiàn duōyuán rǒngyú bèifèn cǎigòu yǔ guóchǎnhuà tìdài fāng’àn.', 'Trước rủi ro tiềm ẩn đứt gãy chuỗi công nghiệp toàn cầu gay gắt phức tạp, doanh nghiệp dẫn đầu chế tạo công nghệ cao đã nhanh chóng kích hoạt phương án thu mua dự phòng đa nguồn linh kiện cốt lõi và lộ trình thay thế nội địa hóa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3320] [呀] (yā) - a, á, ôi (thán từ biểu thị ngạc nhiên, cảm thán) [Thán từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '呀' AND pinyin = 'yā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '呀' AND pinyin = 'yā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '呀'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '呀'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thán từ',
      pinyin = 'yā',
      meaning_vi = 'a, á, ôi (thán từ biểu thị ngạc nhiên, cảm thán)',
      example_hanzi = '呀，今天的清晨空气如此清新甜润，正是约上朋友去郊外绿道骑行的好时光！',
      example_pinyin = 'Yā, jīntiān de qīngchén kōngqì rúcǐ qīngxīn tiánrùn, zhèng shì yuē shàng péngyou qù jiāowài lǜdào qíxíng de hǎo shíguāng!',
      example_vi = 'A, không khí sáng sớm hôm nay trong lành và mát mẻ quá đỗi, đúng là khoảng thời gian tuyệt vời để hẹn bạn bè đạp xe trên đường xanh ngoại ô!'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '呀',
      'yā',
      'a, á, ôi (thán từ biểu thị ngạc nhiên, cảm thán)',
      'Thán từ',
      'HSK 5',
      '呀，今天的清晨空气如此清新甜润，正是约上朋友去郊外绿道骑行的好时光！',
      'Yā, jīntiān de qīngchén kōngqì rúcǐ qīngxīn tiánrùn, zhèng shì yuē shàng péngyou qù jiāowài lǜdào qíxíng de hǎo shíguāng!',
      'A, không khí sáng sớm hôm nay trong lành và mát mẻ quá đỗi, đúng là khoảng thời gian tuyệt vời để hẹn bạn bè đạp xe trên đường xanh ngoại ô!'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '呀，今天的清晨空气如此清新甜润，正是约上朋友去郊外绿道骑行的好时光！', 'Yā, jīntiān de qīngchén kōngqì rúcǐ qīngxīn tiánrùn, zhèng shì yuē shàng péngyou qù jiāowài lǜdào qíxíng de hǎo shíguāng!', 'A, không khí sáng sớm hôm nay trong lành và mát mẻ quá đỗi, đúng là khoảng thời gian tuyệt vời để hẹn bạn bè đạp xe trên đường xanh ngoại ô!', 'basic', 1),
      (v_id, '呀，实验舱的超快激光光谱反馈数值居然与经典理论模型存在显著量级跃迁偏差，科研人员当即决定连夜复核校准实验设备！', 'Yā, shíyàncāng de chāokuài jīguāng guāngpǔ fǎnkuì shùzhí jūrán yǔ jīngdiǎn lǐlùn móxíng cúnzài xiǎnzhù liàngjí yuèqiān piānchā, kēyán rényuán dāngjí juédìng liányè fùhé jiàozhǔn shíyàn shèbèi!', 'Á, chỉ số phản hồi quang phổ laser siêu nhanh trong khoang thí nghiệm vậy mà lại sai lệch một cấp độ đáng kể so với mô hình lý thuyết kinh điển, các nhà khoa học lập tức quyết định thức thâu đêm để kiểm tra lại và hiệu chuẩn thiết bị thí nghiệm!', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3321] [押金] (yājīn) - tiền đặt cọc, tiền thế chân [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '押金' AND pinyin = 'yājīn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '押金' AND pinyin = 'yājīn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '押金'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '押金'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yājīn',
      meaning_vi = 'tiền đặt cọc, tiền thế chân',
      example_hanzi = '在办理公寓租赁手续或租借户外骑行设备时，通常需要向管理方预先支付一定数额的押金。',
      example_pinyin = 'Zài bànlǐ gōngyù zūlìn shǒuxù huò zūjiè hùwài qíxíng shèbèi shí, tōngcháng xūyào xiàng guǎnlǐfāng yùxiān zhīfù yīdìng shù’é de yājīn.',
      example_vi = 'Khi làm thủ tục thuê căn hộ hoặc thuê dụng cụ đạp xe ngoài trời, thông thường cần phải trả trước một khoản tiền đặt cọc nhất định cho ban quản lý.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '押金',
      'yājīn',
      'tiền đặt cọc, tiền thế chân',
      'Danh từ',
      'HSK 5',
      '在办理公寓租赁手续或租借户外骑行设备时，通常需要向管理方预先支付一定数额的押金。',
      'Zài bànlǐ gōngyù zūlìn shǒuxù huò zūjiè hùwài qíxíng shèbèi shí, tōngcháng xūyào xiàng guǎnlǐfāng yùxiān zhīfù yīdìng shù’é de yājīn.',
      'Khi làm thủ tục thuê căn hộ hoặc thuê dụng cụ đạp xe ngoài trời, thông thường cần phải trả trước một khoản tiền đặt cọc nhất định cho ban quản lý.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在办理公寓租赁手续或租借户外骑行设备时，通常需要向管理方预先支付一定数额的押金。', 'Zài bànlǐ gōngyù zūlìn shǒuxù huò zūjiè hùwài qíxíng shèbèi shí, tōngcháng xūyào xiàng guǎnlǐfāng yùxiān zhīfù yīdìng shù’é de yājīn.', 'Khi làm thủ tục thuê căn hộ hoặc thuê dụng cụ đạp xe ngoài trời, thông thường cần phải trả trước một khoản tiền đặt cọc nhất định cho ban quản lý.', 'basic', 1),
      (v_id, '住房租赁行业综合治理法规明确规定，长租公寓运营机构向承租人收取的租金与押金必须全额存入指定商业银行的第三方专项监管账户。', 'Zhùfáng zūlìn hángyè zōnghé zhìlǐ fǎguī míngquè guīdìng, chángzū gōngyù yùnyíng jīgòu xiàng chéngzūrén shōuqǔ de zūjīn yǔ yājīn bìxū quán’é cúnrù zhǐdìng shāngyè yínháng de dìsānfāng zhuānxiàng jiānguǎn zhànghù.', 'Quy chuẩn pháp lý quản trị tổng hợp ngành cho thuê nhà ở quy định rõ ràng, tiền thuê và tiền cọc mà đơn vị vận hành căn hộ cho thuê dài hạn thu từ bên thuê bắt buộc phải nộp toàn bộ vào tài khoản giám sát chuyên dụng của bên thứ ba tại ngân hàng thương mại được chỉ định.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3322] [压岁钱] (yāsuìqián) - tiền mừng tuổi, tiền lì xì đầu năm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '压岁钱' AND pinyin = 'yāsuìqián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '压岁钱' AND pinyin = 'yāsuìqián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '压岁钱'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '压岁钱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yāsuìqián',
      meaning_vi = 'tiền mừng tuổi, tiền lì xì đầu năm',
      example_hanzi = '除夕夜吃完团圆年夜饭之后，长辈们按照传统习俗将崭新的压岁钱装在喜庆的红信封里送给孩子们。',
      example_pinyin = 'Chúxīyè chī wán tuányuán niányèfàn zhīhòu, zhǎngbèimen ànzhào chuántǒng xísú jiāng zhǎnxīn de yāsuìqián zhuāng zài xǐqìng de hóng xìnfēng lǐ sòng gěi háizimen.',
      example_vi = 'Đêm giao thừa sau khi ăn xong bữa cơm tất niên đoàn viên, các bậc tiền bối theo phong tục truyền thống bỏ những tờ tiền mừng tuổi mới tinh vào phong bao đỏ mừng vui gửi tặng cho các cháu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '压岁钱',
      'yāsuìqián',
      'tiền mừng tuổi, tiền lì xì đầu năm',
      'Danh từ',
      'HSK 5',
      '除夕夜吃完团圆年夜饭之后，长辈们按照传统习俗将崭新的压岁钱装在喜庆的红信封里送给孩子们。',
      'Chúxīyè chī wán tuányuán niányèfàn zhīhòu, zhǎngbèimen ànzhào chuántǒng xísú jiāng zhǎnxīn de yāsuìqián zhuāng zài xǐqìng de hóng xìnfēng lǐ sòng gěi háizimen.',
      'Đêm giao thừa sau khi ăn xong bữa cơm tất niên đoàn viên, các bậc tiền bối theo phong tục truyền thống bỏ những tờ tiền mừng tuổi mới tinh vào phong bao đỏ mừng vui gửi tặng cho các cháu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '除夕夜吃完团圆年夜饭之后，长辈们按照传统习俗将崭新的压岁钱装在喜庆的红信封里送给孩子们。', 'Chúxīyè chī wán tuányuán niányèfàn zhīhòu, zhǎngbèimen ànzhào chuántǒng xísú jiāng zhǎnxīn de yāsuìqián zhuāng zài xǐqìng de hóng xìnfēng lǐ sòng gěi háizimen.', 'Đêm giao thừa sau khi ăn xong bữa cơm tất niên đoàn viên, các bậc tiền bối theo phong tục truyền thống bỏ những tờ tiền mừng tuổi mới tinh vào phong bao đỏ mừng vui gửi tặng cho các cháu.', 'basic', 1),
      (v_id, '金融机构针对未成年人财商启蒙教育研发专属亲子理财定投账户，科学引导青少年将春节收到的压岁钱合理配置于长周期教育储蓄。', 'Jīnróng jīgòu zhènduì wèichéngniánrén cáishāng qǐméng jiàoyù yánfā zhuānshǔ qīnzǐ lǐcái dìngtóu zhànghù, kēxué yǐndǎo qīngshàonián jiāng Chúnjié shōudào de yāsuìqián hélǐ pèizhì yú cháng-zhōuqī jiàoyù chǔxù.', 'Các tổ chức tài chính đã nghiên cứu phát triển tài khoản đầu tư định kỳ quản lý tài chính cha mẹ - con cái chuyên biệt nhằm khai sáng giáo dục tư duy tài chính cho người chưa thành niên, hướng dẫn khoa học để thanh thiếu niên phân bổ hợp lý số tiền mừng tuổi nhận được trong dịp Tết vào các quỹ tiết kiệm giáo dục chu kỳ dài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3323] [鸭子] (yāzi) - con vịt [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '鸭子' AND pinyin = 'yāzi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '鸭子' AND pinyin = 'yāzi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '鸭子'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '鸭子'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yāzi',
      meaning_vi = 'con vịt',
      example_hanzi = '初春暖阳照耀下的湖面上水波粼粼，一群活泼可爱的小鸭子正欢快地在荷叶间游来游去觅食。',
      example_pinyin = 'Chūchūn nuǎnyáng zhàoyào xià de húmiàn shàng shuǐbō línlín, yī qún huópo kě’ài de xiǎo yāzi zhèng huānkuài de zài héyè jiān yóu lái yóu qù mìshí.',
      example_vi = 'Mặt hồ lấp lánh sóng nước dưới ánh nắng xuân ấm áp, một đàn vịt con hoạt bát đáng yêu đang tung tăng bơi qua bơi lại giữa các tán lá sen để kiếm mồi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '鸭子',
      'yāzi',
      'con vịt',
      'Danh từ',
      'HSK 5',
      '初春暖阳照耀下的湖面上水波粼粼，一群活泼可爱的小鸭子正欢快地在荷叶间游来游去觅食。',
      'Chūchūn nuǎnyáng zhàoyào xià de húmiàn shàng shuǐbō línlín, yī qún huópo kě’ài de xiǎo yāzi zhèng huānkuài de zài héyè jiān yóu lái yóu qù mìshí.',
      'Mặt hồ lấp lánh sóng nước dưới ánh nắng xuân ấm áp, một đàn vịt con hoạt bát đáng yêu đang tung tăng bơi qua bơi lại giữa các tán lá sen để kiếm mồi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '初春暖阳照耀下的湖面上水波粼粼，一群活泼可爱的小鸭子正欢快地在荷叶间游来游去觅食。', 'Chūchūn nuǎnyáng zhàoyào xià de húmiàn shàng shuǐbō línlín, yī qún huópo kě’ài de xiǎo yāzi zhèng huānkuài de zài héyè jiān yóu lái yóu qù mìshí.', 'Mặt hồ lấp lánh sóng nước dưới ánh nắng xuân ấm áp, một đàn vịt con hoạt bát đáng yêu đang tung tăng bơi qua bơi lại giữa các tán lá sen để kiếm mồi.', 'basic', 1),
      (v_id, '现代生态循环农业示范基地大力推行“稻鸭共生”高效生态农业模式，利用鸭子全天候啄食害虫与杂草，全面降低农药与化肥投入。', 'Xiàndài shēngtài xúnhuán nóngyè shìfàn jīdì dàlì tuīxíng “dào-yā gòngshēng” gāoxiào shēngtài nóngyè móshì, lìyòng yāzi quántiānhòu zhuóshí hàichóng yǔ záocǎo, quánmiàn jiàngdī nóngyào yǔ huàféi tóurù.', 'Khu căn cứ kiểu mẫu nông nghiệp tuần hoàn sinh thái hiện đại đẩy mạnh nhân rộng mô hình nông nghiệp sinh thái hiệu quả cao "lúa - vịt cùng sinh", tận dụng vịt ăn sâu bọ hại lúa và cỏ dại suốt ngày đêm, cắt giảm toàn diện lượng phân bón hóa học và thuốc bảo vệ thực vật đầu vào.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3324] [牙齿] (yáchǐ) - răng, hàm răng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '牙齿' AND pinyin = 'yáchǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '牙齿' AND pinyin = 'yáchǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '牙齿'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '牙齿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yáchǐ',
      meaning_vi = 'răng, hàm răng',
      example_hanzi = '每天早晚认真用软毛牙刷刷牙并配合使用牙线清洁牙缝，是保护牙齿健康、预防口腔疾病的根本方法。',
      example_pinyin = 'Měitiān zǎowǎn rènzhēn yòng ruǎnmáo yáshuā shuāyá bìng pèihé shǐyòng yáxiàn qīngjié yáfèng, shì bǎohù yáchǐ jiànkāng, yùfáng kǒuqiāng jíbìng de gēnběn fāngfǎ.',
      example_vi = 'Mỗi ngày sáng tối đánh răng kỹ lưỡng bằng bàn chải lông mềm và kết hợp dùng chỉ nha khoa làm sạch kẽ răng chính là phương pháp căn bản để bảo vệ sức khỏe hàm răng và phòng ngừa các bệnh răng miệng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '牙齿',
      'yáchǐ',
      'răng, hàm răng',
      'Danh từ',
      'HSK 5',
      '每天早晚认真用软毛牙刷刷牙并配合使用牙线清洁牙缝，是保护牙齿健康、预防口腔疾病的根本方法。',
      'Měitiān zǎowǎn rènzhēn yòng ruǎnmáo yáshuā shuāyá bìng pèihé shǐyòng yáxiàn qīngjié yáfèng, shì bǎohù yáchǐ jiànkāng, yùfáng kǒuqiāng jíbìng de gēnběn fāngfǎ.',
      'Mỗi ngày sáng tối đánh răng kỹ lưỡng bằng bàn chải lông mềm và kết hợp dùng chỉ nha khoa làm sạch kẽ răng chính là phương pháp căn bản để bảo vệ sức khỏe hàm răng và phòng ngừa các bệnh răng miệng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天早晚认真用软毛牙刷刷牙并配合使用牙线清洁牙缝，是保护牙齿健康、预防口腔疾病的根本方法。', 'Měitiān zǎowǎn rènzhēn yòng ruǎnmáo yáshuā shuāyá bìng pèihé shǐyòng yáxiàn qīngjié yáfèng, shì bǎohù yáchǐ jiànkāng, yùfáng kǒuqiāng jíbìng de gēnběn fāngfǎ.', 'Mỗi ngày sáng tối đánh răng kỹ lưỡng bằng bàn chải lông mềm và kết hợp dùng chỉ nha khoa làm sạch kẽ răng chính là phương pháp căn bản để bảo vệ sức khỏe hàm răng và phòng ngừa các bệnh răng miệng.', 'basic', 1),
      (v_id, '现代数字化口腔修复临床广泛应用口内高精度三维激光扫描与全瓷义齿微雕技术，实现了缺损牙齿的微创解剖形态重建与生物力学仿生。', 'Xiàndài shùzìhuà kǒuqiāng xiūfù línchuáng guǎngfàn yìngyòng kǒunèi gāojīngdù sānwéi jīguāng sǎomiáo yǔ quáncí yìchǐ wēidiāo jìshù, shíxiàn le quēsǔn yáchǐ de wēichuàng jiěpōu xíngtài chóngjiàn yǔ shēngwùlìxué fǎngshēng.', 'Lâm sàng phục hình răng miệng số hóa hiện đại ứng dụng rộng rãi công nghệ quét laser 3D độ chính xác cao trong khoang miệng và kỹ thuật vi điêu khắc răng giả toàn sứ, giúp hiện thực hóa việc tái tạo giải phẫu hình thái xâm lấn tối thiểu và phỏng sinh học cơ sinh học cho răng bị tổn khuyết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3325] [沿] (yán) - men theo, dọc theo; bờ, mép [Giới từ / Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '沿' AND pinyin = 'yán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沿' AND pinyin = 'yán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '沿'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '沿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Giới từ / Động từ / Danh từ',
      pinyin = 'yán',
      meaning_vi = 'men theo, dọc theo; bờ, mép',
      example_hanzi = '傍晚夕阳西下，三三两两的市民们喜欢沿风景秀美的江滨景观长廊悠闲散步。',
      example_pinyin = 'Bàngwǎn xīyáng xī xià, sānsānlǐǎnglǐǎng de shìmínmen xǐhuan yán fēngjǐng xiùměi de jiāngbīn jǐngguān chángláng yōuxián sànbù.',
      example_vi = 'Chiều tà bóng hoàng hôn dần lặn về tây, từng tốp hai ba người dân thành phố thích thú tản bộ dọc theo hành lang cảnh quan ven sông phong cảnh tú lệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '沿',
      'yán',
      'men theo, dọc theo; bờ, mép',
      'Giới từ / Động từ / Danh từ',
      'HSK 5',
      '傍晚夕阳西下，三三两两的市民们喜欢沿风景秀美的江滨景观长廊悠闲散步。',
      'Bàngwǎn xīyáng xī xià, sānsānlǐǎnglǐǎng de shìmínmen xǐhuan yán fēngjǐng xiùměi de jiāngbīn jǐngguān chángláng yōuxián sànbù.',
      'Chiều tà bóng hoàng hôn dần lặn về tây, từng tốp hai ba người dân thành phố thích thú tản bộ dọc theo hành lang cảnh quan ven sông phong cảnh tú lệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '傍晚夕阳西下，三三两两的市民们喜欢沿风景秀美的江滨景观长廊悠闲散步。', 'Bàngwǎn xīyáng xī xià, sānsānlǐǎnglǐǎng de shìmínmen xǐhuan yán fēngjǐng xiùměi de jiāngbīn jǐngguān chángláng yōuxián sànbù.', 'Chiều tà bóng hoàng hôn dần lặn về tây, từng tốp hai ba người dân thành phố thích thú tản bộ dọc theo hành lang cảnh quan ven sông phong cảnh tú lệ.', 'basic', 1),
      (v_id, '高水平对外开放战略深度赋能我国沿边沿海经济开放带建设，依托自贸试验区制度集成创新打造海陆内外联动的新发展格局。', 'Gāoshuǐpíng duìwài kāifàng zhànlüè shēndù fùnéng wǒguó yánbiān yánhǎi jīngjì kāifàngdài jiànshè, yītuō zìmào shìyànqū zhìdù jíchéng chuàngxīn dǎzào hǎilù nèiwài liándòng de xīn fāzhǎn géjú.', 'Chiến lược mở cửa đối ngoại tiêu chuẩn cao tạo động lực sâu sắc cho việc xây dựng vành đai mở cửa kinh tế ven biển ven biên giới của nước ta, dựa vào đổi mới tích hợp thể chế của khu thương mại tự do thí điểm để kiến tạo cục diện phát triển mới liên kết trong ngoài trên biển dưới đất liền.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3326] [延长] (yáncháng) - kéo dài, gia hạn, tăng thêm thời gian [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '延长' AND pinyin = 'yáncháng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '延长' AND pinyin = 'yáncháng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '延长'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '延长'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yáncháng',
      meaning_vi = 'kéo dài, gia hạn, tăng thêm thời gian',
      example_hanzi = '为了极大方便市民在重大节假日期间的夜间出行，城市公共交通部门决定将地铁末班车运营时间延长一小时。',
      example_pinyin = 'Wèile jídà biànlì shìmín zài zhòngdà jiérì qījiān de yèjiān chūxíng, chéngshì gōnggòng jiāotōng bùmén juédìng jiāng dìtiě mòbānchē yùnyíng shíjiān yáncháng yī xiǎoshí.',
      example_vi = 'Nhằm tạo thuận lợi tối đa cho việc đi lại ban đêm của người dân trong các dịp lễ tết trọng đại, cơ quan giao thông công cộng thành phố quyết định kéo dài thời gian vận hành chuyến tàu điện ngầm cuối cùng thêm một giờ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '延长',
      'yáncháng',
      'kéo dài, gia hạn, tăng thêm thời gian',
      'Động từ',
      'HSK 5',
      '为了极大方便市民在重大节假日期间的夜间出行，城市公共交通部门决定将地铁末班车运营时间延长一小时。',
      'Wèile jídà biànlì shìmín zài zhòngdà jiérì qījiān de yèjiān chūxíng, chéngshì gōnggòng jiāotōng bùmén juédìng jiāng dìtiě mòbānchē yùnyíng shíjiān yáncháng yī xiǎoshí.',
      'Nhằm tạo thuận lợi tối đa cho việc đi lại ban đêm của người dân trong các dịp lễ tết trọng đại, cơ quan giao thông công cộng thành phố quyết định kéo dài thời gian vận hành chuyến tàu điện ngầm cuối cùng thêm một giờ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了极大方便市民在重大节假日期间的夜间出行，城市公共交通部门决定将地铁末班车运营时间延长一小时。', 'Wèile jídà biànlì shìmín zài zhòngdà jiérì qījiān de yèjiān chūxíng, chéngshì gōnggòng jiāotōng bùmén juédìng jiāng dìtiě mòbānchē yùnyíng shíjiān yáncháng yī xiǎoshí.', 'Nhằm tạo thuận lợi tối đa cho việc đi lại ban đêm của người dân trong các dịp lễ tết trọng đại, cơ quan giao thông công cộng thành phố quyết định kéo dài thời gian vận hành chuyến tàu điện ngầm cuối cùng thêm một giờ.', 'basic', 1),
      (v_id, '国家知识产权行政主管机关依法批准，对用于治疗重大难治性疾病的自主原研创新靶向药物发明专利权给予最长五年的期限补偿延长。', 'Guójiā zhīshi chǎnquán xíngzhèng zhǔguǎn jīgòu yīfǎ pīzhǔn, duì yòng yú zhìliáo zhòngdà nánzhìxìng jíbìng de zìzhǔ yuányán chuàngxīn bǎxiàng yàowù fāmíng zhuānlìquán jǐyǔ zuì cháng wǔ nián de qīxiàn bǔcháng yáncháng.', 'Cơ quan quản lý hành chính sở hữu trí tuệ quốc gia căn cứ theo pháp luật phê chuẩn việc cấp bù gia hạn thời hạn bảo hộ quyền sáng chế tối đa năm năm cho các bằng sáng chế thuốc trúng đích đổi mới nguyên bản tự chủ dùng trong điều trị các căn bệnh nan y trọng đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3327] [研发] (yánfā) - nghiên cứu phát triển, R&D [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '研发' AND pinyin = 'yánfā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '研发' AND pinyin = 'yánfā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '研发'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '研发'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yánfā',
      meaning_vi = 'nghiên cứu phát triển, R&D',
      example_hanzi = '这家高科技企业每年都会将营业收入的百分之十五以上持续投入到核心技术研发中。',
      example_pinyin = 'Zhè jiā gāokējì qǐyè měinián dōu huì jiāng yíngyè shōurù de bǎifēnzhī shíwǔ yǐshàng chíxù tóurù dào héxīn jìshù yánfā zhōng.',
      example_vi = 'Doanh nghiệp công nghệ cao này hàng năm đều liên tục đầu tư trên 15% doanh thu kinh doanh vào hoạt động nghiên cứu phát triển công nghệ cốt lõi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '研发',
      'yánfā',
      'nghiên cứu phát triển, R&D',
      'Động từ / Danh từ',
      'HSK 5',
      '这家高科技企业每年都会将营业收入的百分之十五以上持续投入到核心技术研发中。',
      'Zhè jiā gāokējì qǐyè měinián dōu huì jiāng yíngyè shōurù de bǎifēnzhī shíwǔ yǐshàng chíxù tóurù dào héxīn jìshù yánfā zhōng.',
      'Doanh nghiệp công nghệ cao này hàng năm đều liên tục đầu tư trên 15% doanh thu kinh doanh vào hoạt động nghiên cứu phát triển công nghệ cốt lõi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家高科技企业每年都会将营业收入的百分之十五以上持续投入到核心技术研发中。', 'Zhè jiā gāokējì qǐyè měinián dōu huì jiāng yíngyè shōurù de bǎifēnzhī shíwǔ yǐshàng chíxù tóurù dào héxīn jìshù yánfā zhōng.', 'Doanh nghiệp công nghệ cao này hàng năm đều liên tục đầu tư trên 15% doanh thu kinh doanh vào hoạt động nghiên cứu phát triển công nghệ cốt lõi.', 'basic', 1),
      (v_id, '国家重点实验室围绕量子计算、类脑芯片与工业基础软件展开超高强度联合研发攻关，牢牢掌握全球未来科技竞争战略主动权。', 'Guójiā zhòngdiǎn shíyànshì wéirào liàngzǐ jìsuàn, lèinǎo xīnpiàn yǔ gōngyè jīchǔ ruǎnjiàn zhǎnkāi chāo-gāomiángdù liánhé yánfā gōngguān, láoláo zhǎngwò quánqiú wèilái kējì jìngzhēng zhànlüè zhǔdòngquán.', 'Phòng thí nghiệm trọng điểm quốc gia triển khai đột phá nghiên cứu phát triển liên hợp cường độ siêu cao xung quanh tính toán lượng tử, chip mô phỏng não bộ và phần mềm công nghiệp nền tảng, nắm chắc quyền chủ động chiến lược trong cuộc cạnh tranh công nghệ tương lai toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3328] [严肃] (yánsù) - nghiêm túc, nghiêm nghị, trang nghiêm; làm nghiêm túc [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '严肃' AND pinyin = 'yánsù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '严肃' AND pinyin = 'yánsù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '严肃'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '严肃'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'yánsù',
      meaning_vi = 'nghiêm túc, nghiêm nghị, trang nghiêm; làm nghiêm túc',
      example_hanzi = '班主任神情严肃地走进教室，对个别学生在自习课上随意喧哗的行为提出了严厉批评。',
      example_pinyin = 'Bānzhǔrèn shénqíng yánsù de zǒu jìn jiàoshì, duì gèbié xuéshēng zài zìxíkè shàng suíyì xuānhuá de xíngwéi tíchū le yánlì pīpíng.',
      example_vi = 'Thầy chủ nhiệm với nét mặt nghiêm nghị bước vào lớp học, đưa ra lời phê bình gay gắt đối với hành vi tùy tiện làm ồn trong giờ tự học của một vài bạn học sinh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '严肃',
      'yánsù',
      'nghiêm túc, nghiêm nghị, trang nghiêm; làm nghiêm túc',
      'Tính từ / Động từ',
      'HSK 5',
      '班主任神情严肃地走进教室，对个别学生在自习课上随意喧哗的行为提出了严厉批评。',
      'Bānzhǔrèn shénqíng yánsù de zǒu jìn jiàoshì, duì gèbié xuéshēng zài zìxíkè shàng suíyì xuānhuá de xíngwéi tíchū le yánlì pīpíng.',
      'Thầy chủ nhiệm với nét mặt nghiêm nghị bước vào lớp học, đưa ra lời phê bình gay gắt đối với hành vi tùy tiện làm ồn trong giờ tự học của một vài bạn học sinh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '班主任神情严肃地走进教室，对个别学生在自习课上随意喧哗的行为提出了严厉批评。', 'Bānzhǔrèn shénqíng yánsù de zǒu jìn jiàoshì, duì gèbié xuéshēng zài zìxíkè shàng suíyì xuānhuá de xíngwéi tíchū le yánlì pīpíng.', 'Thầy chủ nhiệm với nét mặt nghiêm nghị bước vào lớp học, đưa ra lời phê bình gay gắt đối với hành vi tùy tiện làm ồn trong giờ tự học của một vài bạn học sinh.', 'basic', 1),
      (v_id, '纪检监察机关严肃查处重大工程招投标与国有资本运营中的利益输送与失职渎职行为，坚决维护党纪国法的崇高权威。', 'Jìjiǎn jiānchá jīgòu yánsù cháchǔ zhòngdà gōngchéng zhāotóubiāo yǔ guóyǒu zīběn yùnyíng zhōng de lìyì shūsòng yǔ shīzhí-dúzhí xíngwéi, jiānjué wéihù dǎngjì guófǎ de chónggāo quánwēi.', 'Cơ quan kiểm tra giám sát kỷ luật nghiêm túc điều tra xử lý các hành vi móc ngoặc lợi ích và thiếu trách nhiệm lạm dụng chức quyền trong đấu thầu công trình trọng đại và vận hành vốn nhà nước, kiên quyết bảo vệ uy quyền cao cả của kỷ luật Đảng và pháp luật nhà nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3329] [研制] (yánzhì) - nghiên cứu chế tạo, nghiên cứu sản xuất [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '研制' AND pinyin = 'yánzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '研制' AND pinyin = 'yánzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '研制'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '研制'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yánzhì',
      meaning_vi = 'nghiên cứu chế tạo, nghiên cứu sản xuất',
      example_hanzi = '经过科研人员数年如一日的不懈奋战，这台具有自主知识产权的新型节能环保发动机终于成功研制出来。',
      example_pinyin = 'Jīngguò kēyán rényuán shù nián rú yī rì de bùxiè fènzhàn, zhè tái jùyǒu zìzhǔ zhīshi chǎnquán de xīnxíng jiénéng huánbǎo fādòngjī zhōngyú chénggōng yánzhì chūlái.',
      example_vi = 'Trải qua nhiều năm phấn đấu không mệt mỏi như một của các nhà nghiên cứu, cỗ động cơ tiết kiệm năng lượng thân thiện với môi trường kiểu mới có quyền sở hữu trí tuệ tự chủ này cuối cùng đã được nghiên cứu chế tạo thành công.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '研制',
      'yánzhì',
      'nghiên cứu chế tạo, nghiên cứu sản xuất',
      'Động từ',
      'HSK 5',
      '经过科研人员数年如一日的不懈奋战，这台具有自主知识产权的新型节能环保发动机终于成功研制出来。',
      'Jīngguò kēyán rényuán shù nián rú yī rì de bùxiè fènzhàn, zhè tái jùyǒu zìzhǔ zhīshi chǎnquán de xīnxíng jiénéng huánbǎo fādòngjī zhōngyú chénggōng yánzhì chūlái.',
      'Trải qua nhiều năm phấn đấu không mệt mỏi như một của các nhà nghiên cứu, cỗ động cơ tiết kiệm năng lượng thân thiện với môi trường kiểu mới có quyền sở hữu trí tuệ tự chủ này cuối cùng đã được nghiên cứu chế tạo thành công.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过科研人员数年如一日的不懈奋战，这台具有自主知识产权的新型节能环保发动机终于成功研制出来。', 'Jīngguò kēyán rényuán shù nián rú yī rì de bùxiè fènzhàn, zhè tái jùyǒu zìzhǔ zhīshi chǎnquán de xīnxíng jiénéng huánbǎo fādòngjī zhōngyú chénggōng yánzhì chūlái.', 'Trải qua nhiều năm phấn đấu không mệt mỏi như một của các nhà nghiên cứu, cỗ động cơ tiết kiệm năng lượng thân thiện với môi trường kiểu mới có quyền sở hữu trí tuệ tự chủ này cuối cùng đã được nghiên cứu chế tạo thành công.', 'basic', 1),
      (v_id, '我国完全自主研制的大型双发通用无人货运飞机成功完成高高原极端气象适航验证首飞，填补了高原复杂地理航空物流重型装备的空白。', 'Wǒguó wánquán zìzhǔ yánzhì de dàxíng shuāngfā tōngyòng wúrén huòyùn fēijī chénggōng wánchéng gāogāoyuán jíduān qìxiàng shìháng yànzhèng shǒufēi, tiánbǔ le gāoyuán fùzá dìlǐ hángkōng wùliú zhòngxíng zhuāngbèi de kòngbái.', 'Máy bay vận tải không người lái đa dụng hai động cơ cỡ lớn do nước ta hoàn toàn tự chủ nghiên cứu chế tạo đã hoàn thành xuất sắc chuyến bay đầu tiên xác minh khả năng đủ điều kiện bay trong khí tượng cực đoan vùng núi cao, lấp đầy khoảng trống trang thiết bị hạng nặng logistics hàng không địa lý phức tạp vùng cao nguyên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3330] [眼] (yǎn) - mắt; lỗ, giếng; một cái nhìn (lượng từ) [Danh từ / Lượng từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '眼' AND pinyin = 'yǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '眼' AND pinyin = 'yǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '眼'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '眼'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Lượng từ',
      pinyin = 'yǎn',
      meaning_vi = 'mắt; lỗ, giếng; một cái nhìn (lượng từ)',
      example_hanzi = '临别之际，老师转过身来深深地看了大家一眼，眼神中充满了无尽的期许与关怀。',
      example_pinyin = 'Línbié zhī jì, lǎoshī zhuǎn guò shēn lái shēnshēn de kàn le dàjiā yī yǎn, yǎnshén zhōng chōngmǎn le wújìn de qīxǔ yǔ guānhuái.',
      example_vi = 'Thời khắc chia tay, người thầy quay người lại nhìn sâu vào mọi người một cái, trong ánh mắt tràn đầy sự kỳ vọng và quan tâm vô bờ bến.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '眼',
      'yǎn',
      'mắt; lỗ, giếng; một cái nhìn (lượng từ)',
      'Danh từ / Lượng từ',
      'HSK 5',
      '临别之际，老师转过身来深深地看了大家一眼，眼神中充满了无尽的期许与关怀。',
      'Línbié zhī jì, lǎoshī zhuǎn guò shēn lái shēnshēn de kàn le dàjiā yī yǎn, yǎnshén zhōng chōngmǎn le wújìn de qīxǔ yǔ guānhuái.',
      'Thời khắc chia tay, người thầy quay người lại nhìn sâu vào mọi người một cái, trong ánh mắt tràn đầy sự kỳ vọng và quan tâm vô bờ bến.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '临别之际，老师转过身来深深地看了大家一眼，眼神中充满了无尽的期许与关怀。', 'Línbié zhī jì, lǎoshī zhuǎn guò shēn lái shēnshēn de kàn le dàjiā yī yǎn, yǎnshén zhōng chōngmǎn le wújìn de qīxǔ yǔ guānhuái.', 'Thời khắc chia tay, người thầy quay người lại nhìn sâu vào mọi người một cái, trong ánh mắt tràn đầy sự kỳ vọng và quan tâm vô bờ bến.', 'basic', 1),
      (v_id, '地质能源勘探科考队在茫茫沙漠腹地成功钻探出一眼深度超万米的超深科学探索井，为解析深地圈层演化提供了极其宝贵的岩芯样本。', 'Dìzhì néngyuán kāntàn kěkǎoduì zài mángmáng shāmò fùdì chénggōng zuāntàn chū yī yǎn shēndù chāo wàn mǐ de chāoshēn kēxué tànsuǒ jǐng, wèi jiěxī shēndì quāncéng yǎnhuà tígōng le jíqí bǎoguì de yánxīn yàngběn.', 'Đội khảo sát thăm dò năng lượng địa chất đã khoan thành công một giếng khoan thăm dò khoa học siêu sâu có độ sâu hơn vạn mét tại vùng lõi sa mạc mênh mông, cung cấp các mẫu lõi đá vô cùng quý giá để phân tích sự tiến hóa của các quyển lòng đất sâu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3331] [演讲] (yǎnjiǎng) - diễn thuyết, thuyết trình; bài diễn thuyết [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '演讲' AND pinyin = 'yǎnjiǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '演讲' AND pinyin = 'yǎnjiǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '演讲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '演讲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yǎnjiǎng',
      meaning_vi = 'diễn thuyết, thuyết trình; bài diễn thuyết',
      example_hanzi = '这位青年杰出学者在大学礼堂发表了一场题为“科技自立自强与青年时代担当”的精彩演讲。',
      example_pinyin = 'Zhè wèi qīngnián jiéchū xuézhě zài dàxué lǐtáng fābiǎo le yī chǎng tí wéi “kējì zìlì-zìqiáng yǔ qīngnián shídài dāndāng” de jīngcǎi yǎnjiǎng.',
      example_vi = 'Vị học giả trẻ kiệt xuất này đã phát biểu một bài diễn thuyết xuất sắc với chủ đề "Tự lực tự cường khoa học công nghệ và sự gánh vác thời đại của thanh niên" tại hội trường lớn trường đại học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '演讲',
      'yǎnjiǎng',
      'diễn thuyết, thuyết trình; bài diễn thuyết',
      'Động từ / Danh từ',
      'HSK 5',
      '这位青年杰出学者在大学礼堂发表了一场题为“科技自立自强与青年时代担当”的精彩演讲。',
      'Zhè wèi qīngnián jiéchū xuézhě zài dàxué lǐtáng fābiǎo le yī chǎng tí wéi “kējì zìlì-zìqiáng yǔ qīngnián shídài dāndāng” de jīngcǎi yǎnjiǎng.',
      'Vị học giả trẻ kiệt xuất này đã phát biểu một bài diễn thuyết xuất sắc với chủ đề "Tự lực tự cường khoa học công nghệ và sự gánh vác thời đại của thanh niên" tại hội trường lớn trường đại học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这位青年杰出学者在大学礼堂发表了一场题为“科技自立自强与青年时代担当”的精彩演讲。', 'Zhè wèi qīngnián jiéchū xuézhě zài dàxué lǐtáng fābiǎo le yī chǎng tí wéi “kējì zìlì-zìqiáng yǔ qīngnián shídài dāndāng” de jīngcǎi yǎnjiǎng.', 'Vị học giả trẻ kiệt xuất này đã phát biểu một bài diễn thuyết xuất sắc với chủ đề "Tự lực tự cường khoa học công nghệ và sự gánh vác thời đại của thanh niên" tại hội trường lớn trường đại học.', 'basic', 1),
      (v_id, '在联合国应对全球气候变化高级别领导人峰会上，国家特别代表发表重要主旨演讲，系统阐明了我国推动构建公平合理全球气候治理体系的中国主张。', 'Zài Liánhéguó yìngduì quánqiú qìhòu biànhuà gāojíbié lǐngdǎorén fēnghuì shàng, guójiā tèbié dàibiǎo fābiǎo zhòngyào zhǔzhǐ yǎnjiǎng, xìtǒng chǎnmíng le wǒguó tuīdòng gòujiàn gōngpíng hélǐ quánqiú qìhòu zhìlǐ tǐxì de Zhōngguó zhǔzhāng.', 'Tại hội nghị thượng đỉnh các nhà lãnh đạo cấp cao của Liên Hợp Quốc về ứng phó với biến đổi khí hậu toàn cầu, đặc phái viên quốc gia đã có bài diễn thuyết chủ đề quan trọng, làm sáng tỏ có hệ thống quan điểm của Trung Quốc trong việc thúc đẩy kiến tạo một hệ thống quản trị khí hậu toàn cầu công bằng và hợp lý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3332] [眼泪] (yǎnlèi) - nước mắt, giọt lệ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '眼泪' AND pinyin = 'yǎnlèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '眼泪' AND pinyin = 'yǎnlèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '眼泪'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '眼泪'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǎnlèi',
      meaning_vi = 'nước mắt, giọt lệ',
      example_hanzi = '听到儿子凭借优异成绩被国家顶尖科研机构录取的好消息，激动的母亲忍不住流下了喜悦的眼泪。',
      example_pinyin = 'Tīngdào érzi píngjiè yōuyì chéngjì bèi guójiā dǐngjiān kēyán jīgòu lùqǔ de hǎo xiāoxi, jīdòng de mǔqīn rěnbuzhù liú xià le xǐyuè de yǎnlèi.',
      example_vi = 'Nghe được tin vui con trai dựa vào thành tích xuất sắc đã được viện nghiên cứu khoa học đỉnh cao quốc gia tiếp nhận, người mẹ xúc động không kìm được đã rơi những giọt nước mắt vui sướng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '眼泪',
      'yǎnlèi',
      'nước mắt, giọt lệ',
      'Danh từ',
      'HSK 5',
      '听到儿子凭借优异成绩被国家顶尖科研机构录取的好消息，激动的母亲忍不住流下了喜悦的眼泪。',
      'Tīngdào érzi píngjiè yōuyì chéngjì bèi guójiā dǐngjiān kēyán jīgòu lùqǔ de hǎo xiāoxi, jīdòng de mǔqīn rěnbuzhù liú xià le xǐyuè de yǎnlèi.',
      'Nghe được tin vui con trai dựa vào thành tích xuất sắc đã được viện nghiên cứu khoa học đỉnh cao quốc gia tiếp nhận, người mẹ xúc động không kìm được đã rơi những giọt nước mắt vui sướng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听到儿子凭借优异成绩被国家顶尖科研机构录取的好消息，激动的母亲忍不住流下了喜悦的眼泪。', 'Tīngdào érzi píngjiè yōuyì chéngjì bèi guójiā dǐngjiān kēyán jīgòu lùqǔ de hǎo xiāoxi, jīdòng de mǔqīn rěnbuzhù liú xià le xǐyuè de yǎnlèi.', 'Nghe được tin vui con trai dựa vào thành tích xuất sắc đã được viện nghiên cứu khoa học đỉnh cao quốc gia tiếp nhận, người mẹ xúc động không kìm được đã rơi những giọt nước mắt vui sướng.', 'basic', 1),
      (v_id, '这部深情记录扎根戈壁荒漠数十载的几代治沙英雄感人事迹的纪录片，以朴素真实的镜头语言让现场所有观众为之动容并眼泪盈眶。', 'Zhè bù shēnqíng jìlù zhāgēn gēbì huángmò shù shí zǎi de jǐ dài zhìshā yīngxióng gǎnrén shìjì de jìlùpiàn, yǐ pǔsù zhēnshí de jìngtóu yǔyán ràng xiànchǎng suǒyǒu guānzhòng wéi zhī dòngróng bìng yǎnlèi yíngkuàng.', 'Bộ phim tài liệu ghi lại đầy xúc động về những chiến công lay động lòng người của nhiều thế hệ anh hùng trị sa bồi đầm mình nơi sa mạc hoang mạc gobi suốt hàng chục năm qua, bằng ngôn ngữ ống kính chân thực mộc mạc đã khiến tất cả khán giả tại hiện trường phải bùi ngùi xúc động lệ tràn bờ mi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3333] [阳台] (yángtái) - ban công [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '阳台' AND pinyin = 'yángtái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '阳台' AND pinyin = 'yángtái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '阳台'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '阳台'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yángtái',
      meaning_vi = 'ban công',
      example_hanzi = '宽敞的阳台上摆满了生机盎然的绿植盆栽，在温暖阳光的照耀下散发着沁人心脾的芬芳。',
      example_pinyin = 'Kuānchǎng de yángtái shàng bǎimǎn le shēngjī-àngrán de lǜzhí pénzāi, zài wēnnuǎn yángguāng de zhàoyào xià sànfā zhe qìnrénxīnpí de fēnfāng.',
      example_vi = 'Trên ban công rộng rãi bày đầy những chậu cây cảnh xanh tươi tràn trề sức sống, dưới ánh nắng ấm áp tỏa ra hương thơm dịu nhẹ ngất ngây lòng người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '阳台',
      'yángtái',
      'ban công',
      'Danh từ',
      'HSK 5',
      '宽敞的阳台上摆满了生机盎然的绿植盆栽，在温暖阳光的照耀下散发着沁人心脾的芬芳。',
      'Kuānchǎng de yángtái shàng bǎimǎn le shēngjī-àngrán de lǜzhí pénzāi, zài wēnnuǎn yángguāng de zhàoyào xià sànfā zhe qìnrénxīnpí de fēnfāng.',
      'Trên ban công rộng rãi bày đầy những chậu cây cảnh xanh tươi tràn trề sức sống, dưới ánh nắng ấm áp tỏa ra hương thơm dịu nhẹ ngất ngây lòng người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '宽敞的阳台上摆满了生机盎然的绿植盆栽，在温暖阳光的照耀下散发着沁人心脾的芬芳。', 'Kuānchǎng de yángtái shàng bǎimǎn le shēngjī-àngrán de lǜzhí pénzāi, zài wēnnuǎn yángguāng de zhàoyào xià sànfā zhe qìnrénxīnpí de fēnfāng.', 'Trên ban công rộng rãi bày đầy những chậu cây cảnh xanh tươi tràn trề sức sống, dưới ánh nắng ấm áp tỏa ra hương thơm dịu nhẹ ngất ngây lòng người.', 'basic', 1),
      (v_id, '现代近零能耗绿色建筑创新集成全景式光伏幕墙阳台与智能微气候微风置换系统，实现了家庭生活用能的高比例绿色电力就地消纳。', 'Xiàndài jìn-língnénghào lǜsè jiànzhù chuàngxīn jíchéng quánjǐngshì guāngfú mùqiáng yángtái yǔ zhìnéng wēiqìhòu wēifēng zhìhuàn xìtǒng, shíxiàn le jiātíng shēnghuó yòngnéng de gāo bǐlì lǜsè diànlì jiùdì xiāonà.', 'Công trình kiến trúc xanh tiêu thụ năng lượng gần bằng không hiện đại tích hợp sáng tạo ban công vách kính quang điện toàn cảnh với hệ thống điều hòa vi khí hậu gió thoảng thông minh, hiện thực hóa việc hấp thụ tại chỗ tỷ lệ cao điện sạch cho năng lượng sinh hoạt gia đình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3334] [样式] (yàngshì) - kiểu dáng, mẫu mã, quy cách [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '样式' AND pinyin = 'yàngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '样式' AND pinyin = 'yàngshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '样式'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '样式'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yàngshì',
      meaning_vi = 'kiểu dáng, mẫu mã, quy cách',
      example_hanzi = '这家传承百年的老字号服饰店手工缝制的传统旗袍样式典雅，深得海内外顾客的一致赞赏。',
      example_pinyin = 'Zhè jiā chuánchéng bǎinián de lǎozìhào fúshìdiàn shǒugōng féngzhì de chuántǒng qípáo yàngshì diǎnyǎ, shēn dé hǎinèiwài gùkè de yīzhì zànshǎng.',
      example_vi = 'Kiểu dáng sườn xám truyền thống may đo thủ công của hiệu may lâu đời trăm năm truyền thống này vô cùng trang nhã, nhận được sự khen ngợi đồng lòng từ khách hàng trong và ngoài nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '样式',
      'yàngshì',
      'kiểu dáng, mẫu mã, quy cách',
      'Danh từ',
      'HSK 5',
      '这家传承百年的老字号服饰店手工缝制的传统旗袍样式典雅，深得海内外顾客的一致赞赏。',
      'Zhè jiā chuánchéng bǎinián de lǎozìhào fúshìdiàn shǒugōng féngzhì de chuántǒng qípáo yàngshì diǎnyǎ, shēn dé hǎinèiwài gùkè de yīzhì zànshǎng.',
      'Kiểu dáng sườn xám truyền thống may đo thủ công của hiệu may lâu đời trăm năm truyền thống này vô cùng trang nhã, nhận được sự khen ngợi đồng lòng từ khách hàng trong và ngoài nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家传承百年的老字号服饰店手工缝制的传统旗袍样式典雅，深得海内外顾客的一致赞赏。', 'Zhè jiā chuánchéng bǎinián de lǎozìhào fúshìdiàn shǒugōng féngzhì de chuántǒng qípáo yàngshì diǎnyǎ, shēn dé hǎinèiwài gùkè de yīzhì zànshǎng.', 'Kiểu dáng sườn xám truyền thống may đo thủ công của hiệu may lâu đời trăm năm truyền thống này vô cùng trang nhã, nhận được sự khen ngợi đồng lòng từ khách hàng trong và ngoài nước.', 'basic', 1),
      (v_id, '工业设计专家提炼中国古代传统建筑中的斗拱榫卯与飞檐翘角几何样式，有机赋能现代高端智能终端产品的流线型外观工业美学。', 'Gōngyè shèjì zhuānjiā tíliàn Zhōngguó gǔdài chuántǒng jiànzhù zhōng de dǒugǒng sǔnmǎo yǔ fēiyán-qiàojiǎo jǐhé yàngshì, yǒujī fùnéng xiàndài gāoduān zhìnéng zhōngduān chǎnpǐn de liúxiànxíng wàiguān gōngyè měixué.', 'Các chuyên gia thiết kế công nghiệp chắt lọc mẫu mã hình học của đấu củng mộng ghép và góc mái vút cong trong kiến trúc truyền thống cổ đại Trung Hoa, tiếp sức hữu cơ cho mỹ học công nghiệp diện mạo khí động học của các sản phẩm đầu cuối thông minh cao cấp hiện đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3335] [腰] (yāo) - lưng, eo, thắt lưng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '腰' AND pinyin = 'yāo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '腰' AND pinyin = 'yāo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '腰'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '腰'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yāo',
      meaning_vi = 'lưng, eo, thắt lưng',
      example_hanzi = '长时间伏案对着电脑工作的办公室职员应当保持正确坐姿，定时站起来活动一下腰部与颈椎。',
      example_pinyin = 'Cháng shíjiān fú’àn duì zhe diànnǎo gōngzuò de bàngōngshì zhíyuán yīngdāng bǎochí zhèngquè zuòzī, dìngshí zhàn qǐlái huódòng yīxià yāobù yǔ jǐngzhuī.',
      example_vi = 'Nhân viên văn phòng ngồi làm việc trước máy tính cúi đầu trong thời gian dài nên giữ đúng tư thế ngồi, định kỳ đứng dậy vận động vùng thắt lưng và đốt sống cổ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '腰',
      'yāo',
      'lưng, eo, thắt lưng',
      'Danh từ',
      'HSK 5',
      '长时间伏案对着电脑工作的办公室职员应当保持正确坐姿，定时站起来活动一下腰部与颈椎。',
      'Cháng shíjiān fú’àn duì zhe diànnǎo gōngzuò de bàngōngshì zhíyuán yīngdāng bǎochí zhèngquè zuòzī, dìngshí zhàn qǐlái huódòng yīxià yāobù yǔ jǐngzhuī.',
      'Nhân viên văn phòng ngồi làm việc trước máy tính cúi đầu trong thời gian dài nên giữ đúng tư thế ngồi, định kỳ đứng dậy vận động vùng thắt lưng và đốt sống cổ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '长时间伏案对着电脑工作的办公室职员应当保持正确坐姿，定时站起来活动一下腰部与颈椎。', 'Cháng shíjiān fú’àn duì zhe diànnǎo gōngzuò de bàngōngshì zhíyuán yīngdāng bǎochí zhèngquè zuòzī, dìngshí zhàn qǐlái huódòng yīxià yāobù yǔ jǐngzhuī.', 'Nhân viên văn phòng ngồi làm việc trước máy tính cúi đầu trong thời gian dài nên giữ đúng tư thế ngồi, định kỳ đứng dậy vận động vùng thắt lưng và đốt sống cổ.', 'basic', 1),
      (v_id, '针对重型机械装配与智慧仓储繁重搬运工种，工效学团队研发出具备气动自适应支撑力反馈的轻量化工业级护腰动力外骨骼。', 'Zhènduì zhòngxíng jīxiè zhuāngpèi yǔ zhìhuì cāngchǔ fánzhòng bānyùn gōngzhǒng, gōngxiàoxué tuánduì yánfā chū jùbèi qìdòng zìshìyìng zhīchēnglì fǎnkuì de qīngliànghuà gōngyèjí hùyāo dònglì wàigǔgé.', 'Nhắm vào các ngành nghề khuân vác nặng nhọc trong lắp ráp cơ khí hạng nặng và kho bãi thông minh, nhóm công thái học đã nghiên cứu chế tạo ra khung xương ngoài trợ lực bảo vệ lưng cấp công nghiệp trọng lượng nhẹ có cơ chế phản hồi lực chống đỡ tự thích ứng bằng khí nén.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3336] [摇] (yáo) - lắc, lay, rung, vẫy [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '摇' AND pinyin = 'yáo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摇' AND pinyin = 'yáo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '摇'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '摇'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yáo',
      meaning_vi = 'lắc, lay, rung, vẫy',
      example_hanzi = '初夏的微风轻轻拂过平静的水面，岸边茂密的芦苇随着微风在阳光下轻轻摇曳。',
      example_pinyin = 'Chūxià de wēifēng qīngqīng fú guò píngjìng de shuǐmiàn, ànbiān màomì de lúwěi suízhe wēifēng zài yángguāng xià qīngqīng yáoyè.',
      example_vi = 'Gió nhẹ đầu hè thoảng qua mặt nước phẳng lặng, rặng lau sậy rậm rạp bên bờ khẽ đung đưa trong nắng ấm theo làn gió.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '摇',
      'yáo',
      'lắc, lay, rung, vẫy',
      'Động từ',
      'HSK 5',
      '初夏的微风轻轻拂过平静的水面，岸边茂密的芦苇随着微风在阳光下轻轻摇曳。',
      'Chūxià de wēifēng qīngqīng fú guò píngjìng de shuǐmiàn, ànbiān màomì de lúwěi suízhe wēifēng zài yángguāng xià qīngqīng yáoyè.',
      'Gió nhẹ đầu hè thoảng qua mặt nước phẳng lặng, rặng lau sậy rậm rạp bên bờ khẽ đung đưa trong nắng ấm theo làn gió.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '初夏的微风轻轻拂过平静的水面，岸边茂密的芦苇随着微风在阳光下轻轻摇曳。', 'Chūxià de wēifēng qīngqīng fú guò píngjìng de shuǐmiàn, ànbiān màomì de lúwěi suízhe wēifēng zài yángguāng xià qīngqīng yáoyè.', 'Gió nhẹ đầu hè thoảng qua mặt nước phẳng lặng, rặng lau sậy rậm rạp bên bờ khẽ đung đưa trong nắng ấm theo làn gió.', 'basic', 1),
      (v_id, '抗震工程国家重点实验室利用大型超高荷载三向六自由度地震模拟振动台，对超高层摩天大楼复杂节点在强震摇晃剧烈变形下的抗震韧性展开极限破坏试验。', 'Kàngzhèn gōngchéng guójiā zhòngdiǎn shíyànshì lìyòng dàxíng chāogāo hèzài sānxiàng liù-zìyóudù dìzhèn mónǐ zhèndòngtái, duì chāogāocéng mótiān-dàlóu fùzá jiédiǎn zài qiángzhèn yáohuàng jùliè biànxíng xià de kàngzhèn rènxìng zhǎnkāi jíxiàn pòhuài shìyàn.', 'Phòng thí nghiệm trọng điểm quốc gia về kỹ thuật kháng chấn sử dụng bàn rung mô phỏng động đất ba hướng sáu bậc tự do tải trọng siêu cao quy mô lớn, triển khai thí nghiệm phá hủy giới hạn về độ dẻo dai kháng chấn của các nút phức tạp trong tòa nhà chọc trời siêu cao tầng dưới tác động biến dạng lắc lư dữ dội của động đất mạnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3337] [咬] (yǎo) - cắn, gặm, ngoạm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '咬' AND pinyin = 'yǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '咬' AND pinyin = 'yǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '咬'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '咬'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yǎo',
      meaning_vi = 'cắn, gặm, ngoạm',
      example_hanzi = '小狗兴奋地在绿茵草坪上奔跑嬉戏，嘴里紧紧咬着主人刚刚扔出的一颗弹力球。',
      example_pinyin = 'Xiǎogǒu xīngfèn de zài lǜyīn cǎopíng shàng bēnpǎo xīxì, zuǐ lǐ jǐnjǐn yǎo zhe zhǔrén gānggāng rēng chū de yī kē tánlìqiú.',
      example_vi = 'Chú cún con phấn khởi chạy nhảy nô đùa trên thảm cỏ xanh mướt, trong miệng cắn chặt quả bóng nảy người chủ vừa ném ra.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '咬',
      'yǎo',
      'cắn, gặm, ngoạm',
      'Động từ',
      'HSK 5',
      '小狗兴奋地在绿茵草坪上奔跑嬉戏，嘴里紧紧咬着主人刚刚扔出的一颗弹力球。',
      'Xiǎogǒu xīngfèn de zài lǜyīn cǎopíng shàng bēnpǎo xīxì, zuǐ lǐ jǐnjǐn yǎo zhe zhǔrén gānggāng rēng chū de yī kē tánlìqiú.',
      'Chú cún con phấn khởi chạy nhảy nô đùa trên thảm cỏ xanh mướt, trong miệng cắn chặt quả bóng nảy người chủ vừa ném ra.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小狗兴奋地在绿茵草坪上奔跑嬉戏，嘴里紧紧咬着主人刚刚扔出的一颗弹力球。', 'Xiǎogǒu xīngfèn de zài lǜyīn cǎopíng shàng bēnpǎo xīxì, zuǐ lǐ jǐnjǐn yǎo zhe zhǔrén gānggāng rēng chū de yī kē tánlìqiú.', 'Chú cún con phấn khởi chạy nhảy nô đùa trên thảm cỏ xanh mướt, trong miệng cắn chặt quả bóng nảy người chủ vừa ném ra.', 'basic', 1),
      (v_id, '盾构机重型主驱动减速机采用微米级精密渐开线齿轮修形工艺，大幅消除了重载恶劣工况下齿轮高速咬合传动产生的局部应力集中与点蚀。', 'Dùngòujī zhòngxíng zhǔ qūdòng jiǎnsùjī cǎiyòng wēimǐjí jīngmì jiànkāixiàn chǐlún xiūxíng gōngyì, dàfú xiāochú le zhòngzǎi èliè gōngkuàng xià chǐlún gāosù yǎohé chuándòng chǎnshēng de júbù yìnglì jízhōng yǔ diǎnshí.', 'Hộp giảm tốc truyền động chính hạng nặng của máy đào hầm khiên đào TBM áp dụng công nghệ sửa biên dạng răng thân khai chính xác cấp micromet, triệt tiêu đáng kể sự tập trung ứng suất cục bộ và rỗ rỉ do các bánh răng cắn khớp truyền động tốc độ cao dưới điều kiện làm việc tải nặng khắc nghiệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3338] [要不] (yàobù) - nếu không thì, hay là [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '要不' AND pinyin = 'yàobù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '要不' AND pinyin = 'yàobù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '要不'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '要不'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'yàobù',
      meaning_vi = 'nếu không thì, hay là',
      example_hanzi = '今天窗外倾盆大雨一时半会儿停不下来，要不我们把原定的周末野餐改到下周吧？',
      example_pinyin = 'Jīntiān chuāngwài qīngpén-dàyǔ yīshíbànhuìr tíng bù xiàlái, yàobù wǒmen bǎ yuándìng de zhōumò yěcān gǎi dào xià zhōu ba?',
      example_vi = 'Hôm nay mưa như trút nước ngoài cửa sổ chốc lát chưa tạnh được, hay là chúng ta chuyển buổi dã ngoại dự định cuối tuần này sang tuần sau nhé?'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '要不',
      'yàobù',
      'nếu không thì, hay là',
      'Liên từ',
      'HSK 5',
      '今天窗外倾盆大雨一时半会儿停不下来，要不我们把原定的周末野餐改到下周吧？',
      'Jīntiān chuāngwài qīngpén-dàyǔ yīshíbànhuìr tíng bù xiàlái, yàobù wǒmen bǎ yuándìng de zhōumò yěcān gǎi dào xià zhōu ba?',
      'Hôm nay mưa như trút nước ngoài cửa sổ chốc lát chưa tạnh được, hay là chúng ta chuyển buổi dã ngoại dự định cuối tuần này sang tuần sau nhé?'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '今天窗外倾盆大雨一时半会儿停不下来，要不我们把原定的周末野餐改到下周吧？', 'Jīntiān chuāngwài qīngpén-dàyǔ yīshíbànhuìr tíng bù xiàlái, yàobù wǒmen bǎ yuándìng de zhōumò yěcān gǎi dào xià zhōu ba?', 'Hôm nay mưa như trút nước ngoài cửa sổ chốc lát chưa tạnh được, hay là chúng ta chuyển buổi dã ngoại dự định cuối tuần này sang tuần sau nhé?', 'basic', 1),
      (v_id, '如果现有的传统硅基半导体微缩制程确实遭遇了难以逾越的量子力学隧穿物理瓶颈，要不我们果断将研发布局切换至二维半导体与光电混合芯片前沿方向！', 'Rúguǒ xiànyǒu de chuántǒng guījī bàndǎotǐ wēisuō zhìchéng quēshí zāoyù le nányǐ yùyuè de liàngzǐ lìxué suìchuān wùlǐ píngjǐng, yàobù wǒmen guǒduàn jiāng yánfā bùjú qiēhuàn zhì èrwéi bàndǎotǐ yǔ guāng-diàn hùnhé xīnpiàn qiányán fāngxiàng!', 'Nếu quy trình thu nhỏ chất bán dẫn gốc silic truyền thống hiện nay quả thực vấp phải nút thắt cổ chai vật lý hiệu ứng xuyên hầm cơ học lượng tử khó lòng vượt qua, hay là chúng ta dứt khoát chuyển đổi bố cục R&D sang định hướng tiền duyên chip bán dẫn hai chiều và chip quang - điện hỗn hợp!', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3339] [要不是] (yàobúshì) - nếu không nhờ, nếu chẳng vì, nếu không phải là [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '要不是' AND pinyin = 'yàobúshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '要不是' AND pinyin = 'yàobúshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '要不是'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '要不是'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'yàobúshì',
      meaning_vi = 'nếu không nhờ, nếu chẳng vì, nếu không phải là',
      example_hanzi = '昨天下班路上要不是热心的同事借给我一把雨伞，我肯定会被突如其来的暴雨淋透。',
      example_pinyin = 'Zuótiān xiàbān lùshang yàobúshì rèxīn de tóngshì jiè gěi wǒ yī bǎ yǔsǎn, wǒ kěndìng huì bèi tūrúqílái de bàoyǔ líntòu.',
      example_vi = 'Trên đường tan làm hôm qua nếu không nhờ người đồng nghiệp nhiệt tình cho tôi mượn chiếc ô, chắc chắn tôi đã bị cơn mưa rào bất ngờ làm ướt sũng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '要不是',
      'yàobúshì',
      'nếu không nhờ, nếu chẳng vì, nếu không phải là',
      'Liên từ',
      'HSK 5',
      '昨天下班路上要不是热心的同事借给我一把雨伞，我肯定会被突如其来的暴雨淋透。',
      'Zuótiān xiàbān lùshang yàobúshì rèxīn de tóngshì jiè gěi wǒ yī bǎ yǔsǎn, wǒ kěndìng huì bèi tūrúqílái de bàoyǔ líntòu.',
      'Trên đường tan làm hôm qua nếu không nhờ người đồng nghiệp nhiệt tình cho tôi mượn chiếc ô, chắc chắn tôi đã bị cơn mưa rào bất ngờ làm ướt sũng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '昨天下班路上要不是热心的同事借给我一把雨伞，我肯定会被突如其来的暴雨淋透。', 'Zuótiān xiàbān lùshang yàobúshì rèxīn de tóngshì jiè gěi wǒ yī bǎ yǔsǎn, wǒ kěndìng huì bèi tūrúqílái de bàoyǔ líntòu.', 'Trên đường tan làm hôm qua nếu không nhờ người đồng nghiệp nhiệt tình cho tôi mượn chiếc ô, chắc chắn tôi đã bị cơn mưa rào bất ngờ làm ướt sũng.', 'basic', 1),
      (v_id, '要不是防汛抗旱应急水利枢纽工程在罕见历史特大洪峰过境时科学实施错峰调度与拦蓄削峰，下游平原特大城市的防洪堤坝很难承受如此巨大的水流冲击。', 'Yàobúshì fángxùn kànghàn yìngjí shuǐlì shūniǔ gōngchéng zài hǎnjiàn lìshǐ tèdà hóngfēng guòjìng shí kēxué shíshī cuòfēng diàodù yǔ lánxù xuēfēng, xiàyóu píngyuán tèdà chéngshì de fánghóng dībà hěn nán chéngshòu rúcǐ jùdà de shuǐliú chōngjī.', 'Nếu không nhờ công trình đầu mối thủy lợi khẩn cấp phòng chống lũ lụt hạn hán đã điều tiết lệch đỉnh lũ và tích nước cắt giảm đỉnh lũ một cách khoa học khi đỉnh lũ lịch sử đặc biệt lớn hiếm thấy tràn qua, đê điều chống lũ của các siêu đô thị vùng đồng bằng hạ lưu sẽ rất khó chống đỡ nổi sự va đập ghê gớm dường ấy của dòng nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3340] [药品] (yàopǐn) - dược phẩm, thuốc men [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '药品' AND pinyin = 'yàopǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '药品' AND pinyin = 'yàopǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '药品'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '药品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yàopǐn',
      meaning_vi = 'dược phẩm, thuốc men',
      example_hanzi = '生病服药时一定要仔细阅读药品包装上的说明书，严格遵照医嘱按时按量服用。',
      example_pinyin = 'Shēngbìng fúyào shí yīdìng yào zǐxì yuèdú yàopǐn bāozhuāng shàng de shuōmíngshū, yángé zūnzhào yīzhǔ ànshí ànliàng fúyòng.',
      example_vi = 'Khi bị ốm uống thuốc nhất định phải đọc kỹ tờ hướng dẫn sử dụng trên bao bì dược phẩm, tuân thủ nghiêm ngặt y lệnh uống đúng giờ đúng liều lượng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '药品',
      'yàopǐn',
      'dược phẩm, thuốc men',
      'Danh từ',
      'HSK 5',
      '生病服药时一定要仔细阅读药品包装上的说明书，严格遵照医嘱按时按量服用。',
      'Shēngbìng fúyào shí yīdìng yào zǐxì yuèdú yàopǐn bāozhuāng shàng de shuōmíngshū, yángé zūnzhào yīzhǔ ànshí ànliàng fúyòng.',
      'Khi bị ốm uống thuốc nhất định phải đọc kỹ tờ hướng dẫn sử dụng trên bao bì dược phẩm, tuân thủ nghiêm ngặt y lệnh uống đúng giờ đúng liều lượng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '生病服药时一定要仔细阅读药品包装上的说明书，严格遵照医嘱按时按量服用。', 'Shēngbìng fúyào shí yīdìng yào zǐxì yuèdú yàopǐn bāozhuāng shàng de shuōmíngshū, yángé zūnzhào yīzhǔ ànshí ànliàng fúyòng.', 'Khi bị ốm uống thuốc nhất định phải đọc kỹ tờ hướng dẫn sử dụng trên bao bì dược phẩm, tuân thủ nghiêm ngặt y lệnh uống đúng giờ đúng liều lượng.', 'basic', 1),
      (v_id, '国家药品监管总局全面构建覆盖全域的药品追溯电子监管体系，实现高风险注射剂与冷链生物制剂从生产车间到临床使用末端全链条闭环核查。', 'Guójiā yàopǐn jiānguǎn zǒngjú quánmiàn gòujiàn fùgài quányù de yàopǐn zhuīsù diànzǐ jiānguǎn tǐxì, shíxiàn gāofēngxiǎn zhùshèjì yǔ lěngliàn shēngwù zhìjì cóng shēngchǎn chējiān dào línchuáng shǐyòng mòduān quán-liàntiáo bìhuán héchá.', 'Tổng cục Quản lý Dược phẩm Quốc gia xây dựng toàn diện hệ thống giám sát điện tử truy xuất nguồn gốc dược phẩm bao phủ toàn diện, hiện thực hóa việc kiểm tra đối soát khép kín toàn chuỗi đối với thuốc tiêm có độ rủi ro cao và chế phẩm sinh học chuỗi lạnh từ phân xưởng sản xuất cho tới khâu sử dụng lâm sàng cuối cùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3341] [药物] (yàowù) - dược phẩm, chất thuốc, dược chất [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '药物' AND pinyin = 'yàowù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '药物' AND pinyin = 'yàowù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '药物'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '药物'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yàowù',
      meaning_vi = 'dược phẩm, chất thuốc, dược chất',
      example_hanzi = '保持合理的膳食结构与规律的作息时间，通常比长期依赖各种保健药物更能增强身体的免疫力。',
      example_pinyin = 'Bǎochí hélǐ de shànshí jiégòu yǔ guīlǜ de zuòxī shíjiān, tōngcháng bǐ chángqī yīlài gè zhǒng bǎojiàn yàowù gèng néng zēngqiáng shēntǐ de miǎnyìlì.',
      example_vi = 'Duy trì cơ cấu ăn uống hợp lý và thời gian sinh hoạt quy củ thông thường sẽ giúp tăng cường khả năng miễn dịch của cơ thể tốt hơn nhiều so với việc dựa dẫm lâu dài vào các loại thuốc bổ trợ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '药物',
      'yàowù',
      'dược phẩm, chất thuốc, dược chất',
      'Danh từ',
      'HSK 5',
      '保持合理的膳食结构与规律的作息时间，通常比长期依赖各种保健药物更能增强身体的免疫力。',
      'Bǎochí hélǐ de shànshí jiégòu yǔ guīlǜ de zuòxī shíjiān, tōngcháng bǐ chángqī yīlài gè zhǒng bǎojiàn yàowù gèng néng zēngqiáng shēntǐ de miǎnyìlì.',
      'Duy trì cơ cấu ăn uống hợp lý và thời gian sinh hoạt quy củ thông thường sẽ giúp tăng cường khả năng miễn dịch của cơ thể tốt hơn nhiều so với việc dựa dẫm lâu dài vào các loại thuốc bổ trợ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '保持合理的膳食结构与规律的作息时间，通常比长期依赖各种保健药物更能增强身体的免疫力。', 'Bǎochí hélǐ de shànshí jiégòu yǔ guīlǜ de zuòxī shíjiān, tōngcháng bǐ chángqī yīlài gè zhǒng bǎojiàn yàowù gèng néng zēngqiáng shēntǐ de miǎnyìlì.', 'Duy trì cơ cấu ăn uống hợp lý và thời gian sinh hoạt quy củ thông thường sẽ giúp tăng cường khả năng miễn dịch của cơ thể tốt hơn nhiều so với việc dựa dẫm lâu dài vào các loại thuốc bổ trợ.', 'basic', 1),
      (v_id, '新药研发科学家利用生成式人工智能算法开展分子结构反向虚拟筛选，将抗肿瘤小分子创新靶向药物的临床前研发周期大幅压缩。', 'Xīnyào yánfā kēxuéjiā lìyòng shēngchéngshì réngōng zhìnéng suànfǎ kāizhǎn fēnzǐ jiégòu fǎnxiàng xūnǐ shāixuǎn, jiāng kàng-zhǒngliú xiǎofēnzǐ chuàngxīn bǎxiàng yàowù de línchuángqián yánfā zhōuqī dàfú yāsuō.', 'Các nhà khoa học R&D thuốc mới sử dụng thuật toán trí tuệ nhân tạo tạo sinh để triển khai sàng lọc ảo ngược cấu trúc phân tử, rút ngắn mạnh mẽ chu kỳ nghiên cứu phát triển tiền lâm sàng của các loại thuốc trúng đích cải tiến phân tử nhỏ kháng khối u.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3342] [夜间] (yèjiān) - ban đêm, đêm tối, thời gian đêm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '夜间' AND pinyin = 'yèjiān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '夜间' AND pinyin = 'yèjiān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '夜间'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '夜间'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yèjiān',
      meaning_vi = 'ban đêm, đêm tối, thời gian đêm',
      example_hanzi = '夜间气温往往会急剧下降，睡觉前记得关好迎风面的窗户，以免受凉感冒。',
      example_pinyin = 'Yèjiān qìwēn wǎngwǎng huì jíjù xiàjiàng, shuìjiào qián jìde guān hǎo yíngfēngmiàn de chuānghu, yǐmiǎn shòuliáng gǎnmào.',
      example_vi = 'Nhiệt độ vào ban đêm thường hay hạ xuống rất nhanh, trước khi đi ngủ nhớ đóng chặt các cửa sổ ở phía đón gió để tránh bị nhiễm lạnh cảm cúm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '夜间',
      'yèjiān',
      'ban đêm, đêm tối, thời gian đêm',
      'Danh từ',
      'HSK 5',
      '夜间气温往往会急剧下降，睡觉前记得关好迎风面的窗户，以免受凉感冒。',
      'Yèjiān qìwēn wǎngwǎng huì jíjù xiàjiàng, shuìjiào qián jìde guān hǎo yíngfēngmiàn de chuānghu, yǐmiǎn shòuliáng gǎnmào.',
      'Nhiệt độ vào ban đêm thường hay hạ xuống rất nhanh, trước khi đi ngủ nhớ đóng chặt các cửa sổ ở phía đón gió để tránh bị nhiễm lạnh cảm cúm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夜间气温往往会急剧下降，睡觉前记得关好迎风面的窗户，以免受凉感冒。', 'Yèjiān qìwēn wǎngwǎng huì jíjù xiàjiàng, shuìjiào qián jìde guān hǎo yíngfēngmiàn de chuānghu, yǐmiǎn shòuliáng gǎnmào.', 'Nhiệt độ vào ban đêm thường hay hạ xuống rất nhanh, trước khi đi ngủ nhớ đóng chặt các cửa sổ ở phía đón gió để tránh bị nhiễm lạnh cảm cúm.', 'basic', 1),
      (v_id, '智能电网调度中心在夜间全网用电负荷低谷时段充分调度抽水蓄能电站与大规模工商业储能电站，高效平抑区域风光绿电出力波动。', 'Zhìnéng diànwǎng diàodù zhōngxīn zài yèjiān quán wǎng yòngdiàn fùhè dīgǔ shídùan chōngfèn diàodù chōushuǐ xùnéng diànzhàn yǔ dà-guīmó gōng-shāngyè chǔnéng diànzhàn, gāoxiào píngyì qūyù fēng-guāng lǜdiàn chūlì bōdòng.', 'Trung tâm điều độ lưới điện thông minh vào khung giờ phụ tải tiêu thụ điện ban đêm toàn mạng xuống đáy đã điều độ tối đa các nhà máy thủy điện tích năng và trạm lưu trữ năng lượng thương mại công nghiệp quy mô lớn, san phẳng một cách hiệu quả sự dao động phát điện của năng lượng xanh gió - mặt trời trong khu vực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3343] [夜市] (yèshì) - chợ đêm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '夜市' AND pinyin = 'yèshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '夜市' AND pinyin = 'yèshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '夜市'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '夜市'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yèshì',
      meaning_vi = 'chợ đêm',
      example_hanzi = '每逢夏夜降临，这条繁华步行街的特色夜市便灯火辉煌、人声鼎沸，汇聚了各种地道风味小吃。',
      example_pinyin = 'Měiféng xiàyè jiànglín, zhè tiáo fánhuá bùxíngjiē de tèsè yèshì biàn dēnghuǒ-huīhuáng, rénshēng-dǐngfèi, huìjù le gè zhǒng dìdao fēngwèi xiǎochī.',
      example_vi = 'Mỗi khi đêm hè buông xuống, khu chợ đêm đặc sắc trên con phố đi bộ phồn hoa này liền rực rỡ ánh đèn, người qua lại đông đúc như nêm, quy tụ đủ các món ăn vặt phong vị bản xứ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '夜市',
      'yèshì',
      'chợ đêm',
      'Danh từ',
      'HSK 5',
      '每逢夏夜降临，这条繁华步行街的特色夜市便灯火辉煌、人声鼎沸，汇聚了各种地道风味小吃。',
      'Měiféng xiàyè jiànglín, zhè tiáo fánhuá bùxíngjiē de tèsè yèshì biàn dēnghuǒ-huīhuáng, rénshēng-dǐngfèi, huìjù le gè zhǒng dìdao fēngwèi xiǎochī.',
      'Mỗi khi đêm hè buông xuống, khu chợ đêm đặc sắc trên con phố đi bộ phồn hoa này liền rực rỡ ánh đèn, người qua lại đông đúc như nêm, quy tụ đủ các món ăn vặt phong vị bản xứ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每逢夏夜降临，这条繁华步行街的特色夜市便灯火辉煌、人声鼎沸，汇聚了各种地道风味小吃。', 'Měiféng xiàyè jiànglín, zhè tiáo fánhuá bùxíngjiē de tèsè yèshì biàn dēnghuǒ-huīhuáng, rénshēng-dǐngfèi, huìjù le gè zhǒng dìdao fēngwèi xiǎochī.', 'Mỗi khi đêm hè buông xuống, khu chợ đêm đặc sắc trên con phố đi bộ phồn hoa này liền rực rỡ ánh đèn, người qua lại đông đúc như nêm, quy tụ đủ các món ăn vặt phong vị bản xứ.', 'basic', 1),
      (v_id, '城市综合管理部门出台一揽子夜间文旅消费扶持细则，引导传统市井夜市向汇聚非遗手工、文创市集与沉浸式演艺的新型夜经济地标升级。', 'Chéngshì zōnghé guǎnlǐ bùmén chūtái yī lǎn zi yèjiān wén-lǚ xiāofèi fúchí xìzé, yǐndǎo chuántǒng shìjǐng yèshì xiàng huìjù fēiyí shǒugōng, wénchuàng shìjí yǔ chénjìnshì yǎnyì de xīnxíng yè-jīngjì dìbiāo shēngjí.', 'Bộ phận quản lý tổng hợp đô thị đã ban hành gói quy định chi tiết hỗ trợ tiêu dùng văn hóa du lịch ban đêm, định hướng các chợ đêm phố thị truyền thống nâng cấp thành các biểu tượng kinh tế đêm kiểu mới quy tụ đồ thủ công phi vật thể, hội chợ sáng tạo văn hóa và nghệ thuật biểu diễn đắm chìm.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3344] [业务] (yèwù) - nghiệp vụ, hoạt động kinh doanh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '业务' AND pinyin = 'yèwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '业务' AND pinyin = 'yèwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '业务'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '业务'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yèwù',
      meaning_vi = 'nghiệp vụ, hoạt động kinh doanh',
      example_hanzi = '作为客户服务部门的新进员工，他不仅工作态度认真负责，而且利用业余时间刻苦钻研各项专业业务。',
      example_pinyin = 'Zuòwéi kèhù fúwù bùmén de xīnjìn yuángōng, tā bùjǐn gōngzuò tàidù rènzhēn fùzé, érqiě lìyòng yèyú shíjiān kèkǔ zuānyán gè xiàng zhuānyè yèwù.',
      example_vi = 'Là nhân viên mới vào của bộ phận dịch vụ khách hàng, anh ấy không chỉ có thái độ làm việc nghiêm túc trách nhiệm, mà còn tận dụng thời gian ngoài giờ khổ luyện nghiên cứu từng mảng nghiệp vụ chuyên môn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '业务',
      'yèwù',
      'nghiệp vụ, hoạt động kinh doanh',
      'Danh từ',
      'HSK 5',
      '作为客户服务部门的新进员工，他不仅工作态度认真负责，而且利用业余时间刻苦钻研各项专业业务。',
      'Zuòwéi kèhù fúwù bùmén de xīnjìn yuángōng, tā bùjǐn gōngzuò tàidù rènzhēn fùzé, érqiě lìyòng yèyú shíjiān kèkǔ zuānyán gè xiàng zhuānyè yèwù.',
      'Là nhân viên mới vào của bộ phận dịch vụ khách hàng, anh ấy không chỉ có thái độ làm việc nghiêm túc trách nhiệm, mà còn tận dụng thời gian ngoài giờ khổ luyện nghiên cứu từng mảng nghiệp vụ chuyên môn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '作为客户服务部门的新进员工，他不仅工作态度认真负责，而且利用业余时间刻苦钻研各项专业业务。', 'Zuòwéi kèhù fúwù bùmén de xīnjìn yuángōng, tā bùjǐn gōngzuò tàidù rènzhēn fùzé, érqiě lìyòng yèyú shíjiān kèkǔ zuānyán gè xiàng zhuānyè yèwù.', 'Là nhân viên mới vào của bộ phận dịch vụ khách hàng, anh ấy không chỉ có thái độ làm việc nghiêm túc trách nhiệm, mà còn tận dụng thời gian ngoài giờ khổ luyện nghiên cứu từng mảng nghiệp vụ chuyên môn.', 'basic', 1),
      (v_id, '跨国金融机构主动顺应跨境经贸数字化与数字人民币国际化发展大势，全方位重塑其离岸资金结算与供应链金融核心业务架构。', 'Kuàguó jīnróng jīgòu zhǔdòng shùnyìng kuàjìng jīngmào shùzìhuà yǔ shùzì rénmínbì guójìhuà fāzhǎn dàshì, quán-fāngwèi chóngsù qí lí’àn zījīn jiésuàn yǔ gōngyìngliàn jīnróng héxīn yèwù jiàgòu.', 'Định chế tài chính xuyên quốc gia chủ động thuận theo xu thế lớn của số hóa kinh tế thương mại xuyên biên giới và quốc tế hóa đồng nhân dân tệ kỹ thuật số, tái cấu trúc toàn diện kiến trúc nghiệp vụ cốt lõi về thanh quyết toán vốn ngoài khơi và tài chính chuỗi cung ứng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3345] [业余] (yèyú) - nghiệp dư, ngoài giờ làm việc; thời gian rảnh rỗi [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '业余' AND pinyin = 'yèyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '业余' AND pinyin = 'yèyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '业余'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '业余'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'yèyú',
      meaning_vi = 'nghiệp dư, ngoài giờ làm việc; thời gian rảnh rỗi',
      example_hanzi = '在紧张忙碌的工作之余，他的业余生活十分丰富多彩，热衷于书法篆刻与山地自行车运动。',
      example_pinyin = 'Zài jǐnzhāng mánglù de gōngzuò zhīyú, tā de yèyú shēnghuó shífēn fēngfù-duōcǎi, rèzhōng yú shūfǎ zhuànkè yǔ shāndì zìxíngchē yùndòng.',
      example_vi = 'Ngoài những lúc làm việc căng thẳng bận rộn, cuộc sống ngoài giờ của anh ấy vô cùng phong phú đa dạng, đam mê thư pháp khắc dấu và môn thể thao đạp xe leo núi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '业余',
      'yèyú',
      'nghiệp dư, ngoài giờ làm việc; thời gian rảnh rỗi',
      'Tính từ / Danh từ',
      'HSK 5',
      '在紧张忙碌的工作之余，他的业余生活十分丰富多彩，热衷于书法篆刻与山地自行车运动。',
      'Zài jǐnzhāng mánglù de gōngzuò zhīyú, tā de yèyú shēnghuó shífēn fēngfù-duōcǎi, rèzhōng yú shūfǎ zhuànkè yǔ shāndì zìxíngchē yùndòng.',
      'Ngoài những lúc làm việc căng thẳng bận rộn, cuộc sống ngoài giờ của anh ấy vô cùng phong phú đa dạng, đam mê thư pháp khắc dấu và môn thể thao đạp xe leo núi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在紧张忙碌的工作之余，他的业余生活十分丰富多彩，热衷于书法篆刻与山地自行车运动。', 'Zài jǐnzhāng mánglù de gōngzuò zhīyú, tā de yèyú shēnghuó shífēn fēngfù-duōcǎi, rèzhōng yú shūfǎ zhuànkè yǔ shāndì zìxíngchē yùndòng.', 'Ngoài những lúc làm việc căng thẳng bận rộn, cuộc sống ngoài giờ của anh ấy vô cùng phong phú đa dạng, đam mê thư pháp khắc dấu và môn thể thao đạp xe leo núi.', 'basic', 1),
      (v_id, '这位资深天文业余爱好者利用自主研发的高精度远程望远镜巡天系统，在河外星系旋臂边缘成功发现了一颗极具科研价值的超新星爆发。', 'Zhè wèi zīshēn tiānwén yèyú àihàozhě lìyòng zìzhǔ yánfā de gāojīngdù yuǎnchéng wàngyuǎnjìng xúntiān xìtǒng, zài héwài xīngxì xuánbì biānyuán chénggōng fāxiàn le yī kē jí jù kēyán jiàzhí de chāoxīnxīng bàofā.', 'Người đam mê thiên văn nghiệp dư lâu năm này sử dụng hệ thống kính thiên văn quan sát bầu trời từ xa độ chính xác cao tự nghiên cứu phát triển, đã phát hiện thành công một vụ nổ siêu tân tinh có giá trị nghiên cứu khoa học cực cao ở rìa nhánh xoắn ốc của thiên hà ngoài dải Ngân hà.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3346] [依据] (yījù) - căn cứ, cơ sở; dựa vào, theo [Danh từ / Giới từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '依据' AND pinyin = 'yījù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '依据' AND pinyin = 'yījù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '依据'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '依据'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Giới từ / Động từ',
      pinyin = 'yījù',
      meaning_vi = 'căn cứ, cơ sở; dựa vào, theo',
      example_hanzi = '在作出任何重大决策之前，项目团队必须以客观详实的数据与实地调研报告作为根本依据。',
      example_pinyin = 'Zài zuòchū rènhé zhòngdà juécè zhīqián, xiàngmù tuánduì bìxū yǐ kèguān xiángshí de shùjù yǔ shídì diàoyán bàogào zuòwéi gēnběn yījù.',
      example_vi = 'Trước khi đưa ra bất kỳ quyết sách trọng đại nào, đội ngũ dự án bắt buộc phải lấy dữ liệu khách quan tường tận và báo cáo khảo sát thực địa làm căn cứ căn bản.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '依据',
      'yījù',
      'căn cứ, cơ sở; dựa vào, theo',
      'Danh từ / Giới từ / Động từ',
      'HSK 5',
      '在作出任何重大决策之前，项目团队必须以客观详实的数据与实地调研报告作为根本依据。',
      'Zài zuòchū rènhé zhòngdà juécè zhīqián, xiàngmù tuánduì bìxū yǐ kèguān xiángshí de shùjù yǔ shídì diàoyán bàogào zuòwéi gēnběn yījù.',
      'Trước khi đưa ra bất kỳ quyết sách trọng đại nào, đội ngũ dự án bắt buộc phải lấy dữ liệu khách quan tường tận và báo cáo khảo sát thực địa làm căn cứ căn bản.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在作出任何重大决策之前，项目团队必须以客观详实的数据与实地调研报告作为根本依据。', 'Zài zuòchū rènhé zhòngdà juécè zhīqián, xiàngmù tuánduì bìxū yǐ kèguān xiángshí de shùjù yǔ shídì diàoyán bàogào zuòwéi gēnběn yījù.', 'Trước khi đưa ra bất kỳ quyết sách trọng đại nào, đội ngũ dự án bắt buộc phải lấy dữ liệu khách quan tường tận và báo cáo khảo sát thực địa làm căn cứ căn bản.', 'basic', 1),
      (v_id, '人民法院审理涉数据要素跨境流动与算法反垄断新型前沿案件时，严格依据民法典与反垄断法法定准则，依法保护各方正当合法权益。', 'Rénmín fǎyuàn shěnlǐ shè shùjù yàosù kuàjìng liúdòng yǔ suànfǎ fǎnlǒngduàn xīnxíng qiányán ànjiàn shí, yángé yījù Mínfǎdiǎn yǔ Fǎnlǒngduàn Fǎ fǎdìng zhǔnzé, yīfǎ bǎohù gèfāng zhèngdàng héfǎ quányì.', 'Tòa án nhân dân khi thụ lý xét xử các vụ án tiền duyên kiểu mới liên quan đến luân chuyển dữ liệu xuyên biên giới và chống độc quyền thuật toán, đã căn cứ nghiêm ngặt vào các chuẩn tắc pháp định của Bộ luật Dân sự và Luật Chống độc quyền để bảo vệ quyền lợi hợp pháp chính đáng của các bên theo pháp luật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3347] [依靠] (yīkào) - dựa vào, nương tựa; chỗ dựa [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '依靠' AND pinyin = 'yīkào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '依靠' AND pinyin = 'yīkào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '依靠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '依靠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yīkào',
      meaning_vi = 'dựa vào, nương tựa; chỗ dựa',
      example_hanzi = '青年人在走向社会的成长道路上应当自尊自立，凡事不能总习惯于单纯依靠家庭的资助。',
      example_pinyin = 'Qīngniánrén zài zǒuxiàng shèhuì de chéngzhǎng dàolù shàng yīngdāng zìzūn-zìlì, fánshì bùnéng zǒng xíguàn yú dānchún yīkào jiātíng de zīzhù.',
      example_vi = 'Thanh niên trên con đường trưởng thành bước ra ngoài xã hội cần phải tự trọng tự lập, phàm mọi việc không thể lúc nào cũng có thói quen đơn thuần trông cậy vào sự chu cấp của gia đình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '依靠',
      'yīkào',
      'dựa vào, nương tựa; chỗ dựa',
      'Động từ / Danh từ',
      'HSK 5',
      '青年人在走向社会的成长道路上应当自尊自立，凡事不能总习惯于单纯依靠家庭的资助。',
      'Qīngniánrén zài zǒuxiàng shèhuì de chéngzhǎng dàolù shàng yīngdāng zìzūn-zìlì, fánshì bùnéng zǒng xíguàn yú dānchún yīkào jiātíng de zīzhù.',
      'Thanh niên trên con đường trưởng thành bước ra ngoài xã hội cần phải tự trọng tự lập, phàm mọi việc không thể lúc nào cũng có thói quen đơn thuần trông cậy vào sự chu cấp của gia đình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年人在走向社会的成长道路上应当自尊自立，凡事不能总习惯于单纯依靠家庭的资助。', 'Qīngniánrén zài zǒuxiàng shèhuì de chéngzhǎng dàolù shàng yīngdāng zìzūn-zìlì, fánshì bùnéng zǒng xíguàn yú dānchún yīkào jiātíng de zīzhù.', 'Thanh niên trên con đường trưởng thành bước ra ngoài xã hội cần phải tự trọng tự lập, phàm mọi việc không thể lúc nào cũng có thói quen đơn thuần trông cậy vào sự chu cấp của gia đình.', 'basic', 1),
      (v_id, '实现高水平科技自立自强并突破关键核心技术瓶颈，根本上必须紧紧依靠我国完全自主培养的高水平战略科学家与青年领军人才。', 'Shíxiàn gāoshuǐpíng kējì zìlì-zìqiáng bìng tūpò guānjiàn héxīn jìshù píngjǐng, gēnběn shàng bìxū jǐnjǐn yīkào wǒguó wánquán zìzhǔ péiyǎng de gāoshuǐpíng zhànlüè kēxuéjiā yǔ qīngnián lǐngjūn réncái.', 'Hiện thực hóa việc tự lực tự cường khoa học công nghệ tiêu chuẩn cao và đột phá điểm nghẽn công nghệ then chốt cốt lõi, về căn bản bắt buộc phải dựa chặt chẽ vào đội ngũ các nhà khoa học chiến lược tiêu chuẩn cao và nhân tài trẻ dẫn đầu do chính nước ta hoàn toàn tự chủ bồi dưỡng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3348] [医疗] (yīliáo) - y tế, điều trị y tế [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '医疗' AND pinyin = 'yīliáo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '医疗' AND pinyin = 'yīliáo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '医疗'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '医疗'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'yīliáo',
      meaning_vi = 'y tế, điều trị y tế',
      example_hanzi = '随着基层社区卫生服务站设施的逐步完善，周边居民在家门口就能享受到优质便捷的初级医疗服务。',
      example_pinyin = 'Suízhe jīcéng shèqū wèishēng fúwùzhàn shèshī de zhúbù wánshàn, zhōubiān jūmín zài jiāménkǒu jiù néng xiǎngshòu dào yōuzhì biànjié de chūjí yīliáo fúwù.',
      example_vi = 'Cùng với sự hoàn thiện từng bước cơ sở vật chất của các trạm y tế dịch vụ cộng đồng cơ sở, người dân xung quanh có thể thụ hưởng dịch vụ y tế ban đầu thuận tiện chất lượng ngay tại cửa nhà mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '医疗',
      'yīliáo',
      'y tế, điều trị y tế',
      'Danh từ / Động từ',
      'HSK 5',
      '随着基层社区卫生服务站设施的逐步完善，周边居民在家门口就能享受到优质便捷的初级医疗服务。',
      'Suízhe jīcéng shèqū wèishēng fúwùzhàn shèshī de zhúbù wánshàn, zhōubiān jūmín zài jiāménkǒu jiù néng xiǎngshòu dào yōuzhì biànjié de chūjí yīliáo fúwù.',
      'Cùng với sự hoàn thiện từng bước cơ sở vật chất của các trạm y tế dịch vụ cộng đồng cơ sở, người dân xung quanh có thể thụ hưởng dịch vụ y tế ban đầu thuận tiện chất lượng ngay tại cửa nhà mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着基层社区卫生服务站设施的逐步完善，周边居民在家门口就能享受到优质便捷的初级医疗服务。', 'Suízhe jīcéng shèqū wèishēng fúwùzhàn shèshī de zhúbù wánshàn, zhōubiān jūmín zài jiāménkǒu jiù néng xiǎngshòu dào yōuzhì biànjié de chūjí yīliáo fúwù.', 'Cùng với sự hoàn thiện từng bước cơ sở vật chất của các trạm y tế dịch vụ cộng đồng cơ sở, người dân xung quanh có thể thụ hưởng dịch vụ y tế ban đầu thuận tiện chất lượng ngay tại cửa nhà mình.', 'basic', 1),
      (v_id, '国家统筹推进优质医疗资源扩容下沉与区域均衡布局，依托国家医学中心和区域医疗中心建设，从根本上纾解跨省异地就医难题。', 'Guójiā tǒngchóu tuījìn yōuzhì yīliáo zīyuán kuòróng xiàchén yǔ qūyù jūnhéng bùjú, yītuō guójiā yīxué zhōngxīn hé qūyù yīliáo zhōngxīn jiànshè, cóng gēnběn shàng shūjiě kuà-shěng yìdì jiùyī nántí.', 'Nhà nước điều phối thúc đẩy việc mở rộng dung lượng đưa nguồn lực y tế chất lượng cao xuống cơ sở và phân bổ đồng đều theo vùng miền, dựa vào việc xây dựng các trung tâm y học quốc gia và trung tâm y tế khu vực để tháo gỡ tận gốc bài toán khó khám chữa bệnh khác tỉnh trái tuyến.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3349] [依然] (yīrán) - vẫn, vẫn cứ, y nguyên như trước [Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '依然' AND pinyin = 'yīrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '依然' AND pinyin = 'yīrán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '依然'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '依然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ',
      pinyin = 'yīrán',
      meaning_vi = 'vẫn, vẫn cứ, y nguyên như trước',
      example_hanzi = '尽管大学毕业已经分别了二十多年，但老同学们重逢相聚时依然像当年在校园里那样无话不谈、亲密无间。',
      example_pinyin = 'Jǐnguǎn dàxué bìyè yǐjīng fēnbié le èrshí duō nián, dàn lǎo tóngxuémen chóngféng xiāngjù shí yīrán xiàng dāngnián zài xiàoyuán lǐ nàyàng wúhuà-bùtán, qīnmì-wújiān.',
      example_vi = 'Cho dù sau khi tốt nghiệp đại học đã xa cách hơn hai mươi năm, nhưng khi các bạn học cũ hội ngộ sum vầy vẫn như năm nào trên giảng đường, chuyện gì cũng có thể giãi bày, gắn bó thân thiết không khoảng cách.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '依然',
      'yīrán',
      'vẫn, vẫn cứ, y nguyên như trước',
      'Phó từ',
      'HSK 5',
      '尽管大学毕业已经分别了二十多年，但老同学们重逢相聚时依然像当年在校园里那样无话不谈、亲密无间。',
      'Jǐnguǎn dàxué bìyè yǐjīng fēnbié le èrshí duō nián, dàn lǎo tóngxuémen chóngféng xiāngjù shí yīrán xiàng dāngnián zài xiàoyuán lǐ nàyàng wúhuà-bùtán, qīnmì-wújiān.',
      'Cho dù sau khi tốt nghiệp đại học đã xa cách hơn hai mươi năm, nhưng khi các bạn học cũ hội ngộ sum vầy vẫn như năm nào trên giảng đường, chuyện gì cũng có thể giãi bày, gắn bó thân thiết không khoảng cách.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '尽管大学毕业已经分别了二十多年，但老同学们重逢相聚时依然像当年在校园里那样无话不谈、亲密无间。', 'Jǐnguǎn dàxué bìyè yǐjīng fēnbié le èrshí duō nián, dàn lǎo tóngxuémen chóngféng xiāngjù shí yīrán xiàng dāngnián zài xiàoyuán lǐ nàyàng wúhuà-bùtán, qīnmì-wújiān.', 'Cho dù sau khi tốt nghiệp đại học đã xa cách hơn hai mươi năm, nhưng khi các bạn học cũ hội ngộ sum vầy vẫn như năm nào trên giảng đường, chuyện gì cũng có thể giãi bày, gắn bó thân thiết không khoảng cách.', 'basic', 1),
      (v_id, '纵使历经国际风云激荡与外部极端制裁风浪洗礼，该高新技术实体企业依然展现出令世人瞩目的创新韧性与破浪前行的强大定力。', 'Zòngshǐ lìjīng guójì fēngyún jīdàng yǔ wàibù jíduān zhìcái fēnglàng xǐlǐ, gāi gāoxīnjìshù shítǐ qǐyè yīrán zhǎnxiàn chū lìng shìrén zhǔmù de chuàngxīn rènxìng yǔ pòlàng qiánxíng de qiángdà dìnglì.', 'Dẫu cho trải qua những biến động cuộn trào trên trường quốc tế và thử thách sóng gió của các biện pháp trừng phạt cực đoan từ bên ngoài, doanh nghiệp thực thể công nghệ cao này vẫn phô diễn tính bền bỉ đổi mới sáng tạo khiến thế giới phải dõi mắt khâm phục cùng bản lĩnh định lực mạnh mẽ rẽ sóng vươn lên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3350] [医学] (yīxué) - y học, ngành y khoa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '医学' AND pinyin = 'yīxué'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '医学' AND pinyin = 'yīxué'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '医学'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '医学'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yīxué',
      meaning_vi = 'y học, ngành y khoa',
      example_hanzi = '他从小在行医世家的熏陶下立志救死扶伤，高考毕业后毅然报考了著名医科大学的临床医学专业。',
      example_pinyin = 'Tā cóngxiǎo zài xíngyī shìjiā de xūntáo xià lìzhì jiùsǐ-fúshāng, gāokǎo bìyè hòu yìrán bàokǎo le zhùmíng yīkē dàxué de línchuáng yīxué zhuānyè.',
      example_vi = 'Từ nhỏ dưới sự hun đúc của gia đình nhiều đời làm nghề y anh ấy đã lập chí cứu người giúp đời, sau khi tốt nghiệp cấp ba đã kiên quyết đăng ký thi vào chuyên ngành y học lâm sàng của trường đại học y danh tiếng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '医学',
      'yīxué',
      'y học, ngành y khoa',
      'Danh từ',
      'HSK 5',
      '他从小在行医世家的熏陶下立志救死扶伤，高考毕业后毅然报考了著名医科大学的临床医学专业。',
      'Tā cóngxiǎo zài xíngyī shìjiā de xūntáo xià lìzhì jiùsǐ-fúshāng, gāokǎo bìyè hòu yìrán bàokǎo le zhùmíng yīkē dàxué de línchuáng yīxué zhuānyè.',
      'Từ nhỏ dưới sự hun đúc của gia đình nhiều đời làm nghề y anh ấy đã lập chí cứu người giúp đời, sau khi tốt nghiệp cấp ba đã kiên quyết đăng ký thi vào chuyên ngành y học lâm sàng của trường đại học y danh tiếng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他从小在行医世家的熏陶下立志救死扶伤，高考毕业后毅然报考了著名医科大学的临床医学专业。', 'Tā cóngxiǎo zài xíngyī shìjiā de xūntáo xià lìzhì jiùsǐ-fúshāng, gāokǎo bìyè hòu yìrán bàokǎo le zhùmíng yīkē dàxué de línchuáng yīxué zhuānyè.', 'Từ nhỏ dưới sự hun đúc của gia đình nhiều đời làm nghề y anh ấy đã lập chí cứu người giúp đời, sau khi tốt nghiệp cấp ba đã kiên quyết đăng ký thi vào chuyên ngành y học lâm sàng của trường đại học y danh tiếng.', 'basic', 1),
      (v_id, '分子医学与生物计算技术的融合跨越式推动了转化医学的发展，基于基因编辑与CAR-T细胞免疫疗法攻克恶性血液肿瘤取得了突破性进展。', 'Fēnzǐ yīxué yǔ shēngwù jìsuàn jìshù de rónghé kuàyuèshì tuīdòng le zhuǎnhuà yīxué de fāzhǎn, jīyú jīyīn biānjí yǔ CAR-T xìbāo miǎnyì liáofǎ gōngkè èxìng xuèyè zhǒngliú qǔdé le tūpòxìng jìnzhǎn.', 'Sự kết hợp giữa y học phân tử và công nghệ tính toán sinh học đã tạo bước nhảy vọt thúc đẩy sự phát triển của y học chuyển dịch, các phương pháp dựa trên chỉnh sửa gen và liệu pháp miễn dịch tế bào CAR-T nhằm khắc phục các khối u máu ác tính đã đạt được những tiến triển mang tính đột phá.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3351] [移] (yí) - di chuyển, dời đi, chuyển biến, dịch chuyển [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '移' AND pinyin = 'yí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '移' AND pinyin = 'yí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '移'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '移'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yí',
      meaning_vi = 'di chuyển, dời đi, chuyển biến, dịch chuyển',
      example_hanzi = '搬家师傅和房东一起小心翼翼地将客厅正中央沉重的实木茶几平稳地移到了靠墙的一侧。',
      example_pinyin = 'Bānjiā shīfu hé fángdōng yīqǐ xiǎoxīn-yìyì de jiāng kètīng zhèng zhōngyāng chénzhòng de shímù chájī píngwěn de yí dào le kào qiáng de yī cè.',
      example_vi = 'Bác thợ dọn nhà cùng chủ nhà cẩn thận khiêng bàn trà gỗ tự nhiên nặng trịch ở chính giữa phòng khách dịch chuyển êm thuận vào sát phía tường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '移',
      'yí',
      'di chuyển, dời đi, chuyển biến, dịch chuyển',
      'Động từ',
      'HSK 5',
      '搬家师傅和房东一起小心翼翼地将客厅正中央沉重的实木茶几平稳地移到了靠墙的一侧。',
      'Bānjiā shīfu hé fángdōng yīqǐ xiǎoxīn-yìyì de jiāng kètīng zhèng zhōngyāng chénzhòng de shímù chájī píngwěn de yí dào le kào qiáng de yī cè.',
      'Bác thợ dọn nhà cùng chủ nhà cẩn thận khiêng bàn trà gỗ tự nhiên nặng trịch ở chính giữa phòng khách dịch chuyển êm thuận vào sát phía tường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '搬家师傅和房东一起小心翼翼地将客厅正中央沉重的实木茶几平稳地移到了靠墙的一侧。', 'Bānjiā shīfu hé fángdōng yīqǐ xiǎoxīn-yìyì de jiāng kètīng zhèng zhōngyāng chénzhòng de shímù chájī píngwěn de yí dào le kào qiáng de yī cè.', 'Bác thợ dọn nhà cùng chủ nhà cẩn thận khiêng bàn trà gỗ tự nhiên nặng trịch ở chính giữa phòng khách dịch chuyển êm thuận vào sát phía tường.', 'basic', 1),
      (v_id, '自然资源地质灾害预警监测中心依托北斗毫米级高精度定位传感器，对突发暴雨区大型不稳定滑坡体实施三维蠕变位移全天候智能预警。', 'Zìrán zīyuán dìzhì zāihài yùjǐng jiāncè zhōngxīn yītuō Běidǒu háomǐjí gāojīngdù dìngwèi chuángǎnqì, duì tūfā bàoyǔqū dàxíng bù-wěndìng huápōtǐ shíshī sānwéi rùbiàn wèiyí quántiānhòu zhìnéng yùjǐng.', 'Trung tâm giám sát cảnh báo thiên tai địa chất tài nguyên thiên nhiên dựa vào cảm biến định vị độ chính xác cao cấp milimet của vệ tinh Bắc Đẩu, thực hiện cảnh báo thông minh suốt ngày đêm về sự dịch chuyển trượt biến dạng 3D của các khối trượt đất quy mô lớn không ổn định tại khu vực mưa lớn đột ngột.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3352] [一次性] (yícìxìng) - dùng một lần, một lần duy nhất [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '一次性' AND pinyin = 'yícìxìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一次性' AND pinyin = 'yícìxìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '一次性'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一次性'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yícìxìng',
      meaning_vi = 'dùng một lần, một lần duy nhất',
      example_hanzi = '为了减少塑料垃圾对生态环境的破坏，许多大型超市已经不再主动免费提供一次性塑料购物袋。',
      example_pinyin = 'Wèile jiǎnshǎo sùliào lājī duì shēngtài huánjìng de pòhuài, xǔduō dàxíng chāoshì yǐjīng bù zài zhǔdòng miǎnfèi tígōng yícìxìng sùliào gòuwùdài.',
      example_vi = 'Nhằm giảm bớt sự tàn phá của rác thải nhựa đối với môi trường sinh thái, nhiều siêu thị lớn đã không còn chủ động cung cấp miễn phí túi mua hàng bằng nhựa dùng một lần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '一次性',
      'yícìxìng',
      'dùng một lần, một lần duy nhất',
      'Tính từ',
      'HSK 5',
      '为了减少塑料垃圾对生态环境的破坏，许多大型超市已经不再主动免费提供一次性塑料购物袋。',
      'Wèile jiǎnshǎo sùliào lājī duì shēngtài huánjìng de pòhuài, xǔduō dàxíng chāoshì yǐjīng bù zài zhǔdòng miǎnfèi tígōng yícìxìng sùliào gòuwùdài.',
      'Nhằm giảm bớt sự tàn phá của rác thải nhựa đối với môi trường sinh thái, nhiều siêu thị lớn đã không còn chủ động cung cấp miễn phí túi mua hàng bằng nhựa dùng một lần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了减少塑料垃圾对生态环境的破坏，许多大型超市已经不再主动免费提供一次性塑料购物袋。', 'Wèile jiǎnshǎo sùliào lājī duì shēngtài huánjìng de pòhuài, xǔduō dàxíng chāoshì yǐjīng bù zài zhǔdòng miǎnfèi tígōng yícìxìng sùliào gòuwùdài.', 'Nhằm giảm bớt sự tàn phá của rác thải nhựa đối với môi trường sinh thái, nhiều siêu thị lớn đã không còn chủ động cung cấp miễn phí túi mua hàng bằng nhựa dùng một lần.', 'basic', 1),
      (v_id, '医疗器械监督管理部门严格规范一次性医用无菌耗材的集中招标采购、临床追溯使用与医疗危险废弃物无害化高温销毁全流程。', 'Yīliáo qìxiè jiāndū guǎnlǐ bùmén yángé guīfàn yícìxìng yīyòng wújūn hàocái de jízhōng zhāobiāo cǎigòu, línchuáng zhuīsù shǐyòng yǔ yīliáo wēixiǎn fèiqìwù wúhàihuà gāowēn xiāohuǐ quán-liúchéng.', 'Cơ quan giám sát quản lý trang thiết bị y tế quy chuẩn nghiêm ngặt toàn bộ quy trình từ đấu thầu mua sắm tập trung, truy xuất sử dụng lâm sàng đến tiêu hủy nhiệt độ cao vô hại hóa chất thải nguy hại y tế đối với vật tư tiêu hao vô trùng y tế dùng một lần.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3353] [一代] (yídài) - một thế hệ, một đời [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '一代' AND pinyin = 'yídài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一代' AND pinyin = 'yídài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '一代'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一代'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yídài',
      meaning_vi = 'một thế hệ, một đời',
      example_hanzi = '青年一代有理想、有担当，国家发展就有源源不断的前进动力，民族复兴就有坚实依靠。',
      example_pinyin = 'Qīngnián yídài yǒu lǐxiǎng, yǒu dāndāng, guójiā fāzhǎn jiù yǒu yuányuán-bùduàn de qiánjìn dònglì, mínzú fùxīng jiù yǒu jiānshí yīkào.',
      example_vi = 'Thế hệ thanh niên có lý tưởng, có tinh thần gánh vác trách nhiệm thì sự phát triển quốc gia sẽ có động lực tiến bước không ngừng, sự phục hưng dân tộc sẽ có điểm tựa vững chắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '一代',
      'yídài',
      'một thế hệ, một đời',
      'Danh từ',
      'HSK 5',
      '青年一代有理想、有担当，国家发展就有源源不断的前进动力，民族复兴就有坚实依靠。',
      'Qīngnián yídài yǒu lǐxiǎng, yǒu dāndāng, guójiā fāzhǎn jiù yǒu yuányuán-bùduàn de qiánjìn dònglì, mínzú fùxīng jiù yǒu jiānshí yīkào.',
      'Thế hệ thanh niên có lý tưởng, có tinh thần gánh vác trách nhiệm thì sự phát triển quốc gia sẽ có động lực tiến bước không ngừng, sự phục hưng dân tộc sẽ có điểm tựa vững chắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年一代有理想、有担当，国家发展就有源源不断的前进动力，民族复兴就有坚实依靠。', 'Qīngnián yídài yǒu lǐxiǎng, yǒu dāndāng, guójiā fāzhǎn jiù yǒu yuányuán-bùduàn de qiánjìn dònglì, mínzú fùxīng jiù yǒu jiānshí yīkào.', 'Thế hệ thanh niên có lý tưởng, có tinh thần gánh vác trách nhiệm thì sự phát triển quốc gia sẽ có động lực tiến bước không ngừng, sự phục hưng dân tộc sẽ có điểm tựa vững chắc.', 'basic', 1),
      (v_id, '新一代自主可控超级计算机依托高能效超大规模异构并行算力架构，为前沿基础科学研究与工业高端装备仿真提供了极其强大的战略算力底座。', 'Xīnyīdài zìzhǔ kěkòng chāojí jìsuànjī yītuō gāonéngxiào chāo-dà guīmó yìgòu bìngxíng suànlì jiàgòu, wèi qiányán jīchǔ kēxué yánjiū yǔ gōngyè gāoduān zhuāngbèi fāngzhēn tígōng le jíqí qiángdà de zhànlüè suànlì dǐzuò.', 'Siêu máy tính tự chủ kiểm soát thế hệ mới dựa trên kiến trúc năng lực tính toán song song dị cấu quy mô siêu lớn hiệu suất năng lượng cao, cung cấp nền tảng năng lực tính toán chiến lược vô cùng mạnh mẽ cho nghiên cứu khoa học cơ bản tiền duyên và mô phỏng thiết bị cao cấp công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3354] [一旦] (yídàn) - một khi, một ngày nào đó (thường dùng trong điều kiện giả định) [Phó từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '一旦' AND pinyin = 'yídàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一旦' AND pinyin = 'yídàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '一旦'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一旦'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Liên từ',
      pinyin = 'yídàn',
      meaning_vi = 'một khi, một ngày nào đó (thường dùng trong điều kiện giả định)',
      example_hanzi = '高山冰川生态系统的自然环境十分脆弱，生态平衡一旦遭到人为破坏便极难在短期内恢复。',
      example_pinyin = 'Gāoshān bīngchuān shēngtài xìtǒng de zìrán huánjìng shífēn cuìruò, shēngtài pínghéng yídàn zāodào rénwéi pòhuài biàn jí nán zài duǎnqī nèi huìfù.',
      example_vi = 'Môi trường tự nhiên của hệ sinh thái sông băng núi cao vô cùng mỏng manh, cân bằng sinh thái một khi bị con người phá hoại sẽ cực kỳ khó hồi phục lại trong thời gian ngắn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '一旦',
      'yídàn',
      'một khi, một ngày nào đó (thường dùng trong điều kiện giả định)',
      'Phó từ / Liên từ',
      'HSK 5',
      '高山冰川生态系统的自然环境十分脆弱，生态平衡一旦遭到人为破坏便极难在短期内恢复。',
      'Gāoshān bīngchuān shēngtài xìtǒng de zìrán huánjìng shífēn cuìruò, shēngtài pínghéng yídàn zāodào rénwéi pòhuài biàn jí nán zài duǎnqī nèi huìfù.',
      'Môi trường tự nhiên của hệ sinh thái sông băng núi cao vô cùng mỏng manh, cân bằng sinh thái một khi bị con người phá hoại sẽ cực kỳ khó hồi phục lại trong thời gian ngắn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '高山冰川生态系统的自然环境十分脆弱，生态平衡一旦遭到人为破坏便极难在短期内恢复。', 'Gāoshān bīngchuān shēngtài xìtǒng de zìrán huánjìng shífēn cuìruò, shēngtài pínghéng yídàn zāodào rénwéi pòhuài biàn jí nán zài duǎnqī nèi huìfù.', 'Môi trường tự nhiên của hệ sinh thái sông băng núi cao vô cùng mỏng manh, cân bằng sinh thái một khi bị con người phá hoại sẽ cực kỳ khó hồi phục lại trong thời gian ngắn.', 'basic', 1),
      (v_id, '现代金融安全防御体系必须严密防范流动性危机跨境传染，一旦国际资本市场发生剧烈波动须迅速触发央行多边本币互换应急救助机制。', 'Xiàndài jīnróng ānquán fángyù tǐxì bìxū yánmì fángfàn liúdòngxìng wēijī kuàjìng chuánrǎn, yídàn guójì zīběn shìchǎng fāshēng jùliè bōdòng xū xùnsù chùfā yāngháng duōbiān běnbì hùhuàn yìngjí jiùzhù jīzhì.', 'Hệ thống phòng thủ an ninh tài chính hiện đại bắt buộc phải phòng ngừa chặt chẽ sự lây lan khủng hoảng thanh khoản xuyên biên giới, một khi thị trường vốn quốc tế xảy ra biến động dữ dội phải nhanh chóng kích hoạt cơ chế cứu trợ khẩn cấp hoán đổi bản tệ đa phương của ngân hàng trung ương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3355] [移动] (yídòng) - di chuyển, dịch chuyển; di động [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '移动' AND pinyin = 'yídòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '移动' AND pinyin = 'yídòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '移动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '移动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'yídòng',
      meaning_vi = 'di chuyển, dịch chuyển; di động',
      example_hanzi = '参加正式的国际学术报告会议时，请大家将手机调至静音模式，在报告进行过程中不要随意走动。',
      example_pinyin = 'Cānjiā zhèngshì de guójì xuéshù bàogào huìyì shí, qǐng dàjiā jiāng shǒujī tiáo zhì jìngyīn móshì, zài bàogào jìnxíng guòchéng zhōng bùyào suíyì zǒudòng.',
      example_vi = 'Khi tham dự hội nghị báo cáo học thuật quốc tế trang trọng, xin mời mọi người chuyển điện thoại sang chế độ im lặng, không tùy tiện đi lại trong quá trình buổi báo cáo diễn ra.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '移动',
      'yídòng',
      'di chuyển, dịch chuyển; di động',
      'Động từ / Tính từ',
      'HSK 5',
      '参加正式的国际学术报告会议时，请大家将手机调至静音模式，在报告进行过程中不要随意走动。',
      'Cānjiā zhèngshì de guójì xuéshù bàogào huìyì shí, qǐng dàjiā jiāng shǒujī tiáo zhì jìngyīn móshì, zài bàogào jìnxíng guòchéng zhōng bùyào suíyì zǒudòng.',
      'Khi tham dự hội nghị báo cáo học thuật quốc tế trang trọng, xin mời mọi người chuyển điện thoại sang chế độ im lặng, không tùy tiện đi lại trong quá trình buổi báo cáo diễn ra.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '参加正式的国际学术报告会议时，请大家将手机调至静音模式，在报告进行过程中不要随意走动。', 'Cānjiā zhèngshì de guójì xuéshù bàogào huìyì shí, qǐng dàjiā jiāng shǒujī tiáo zhì jìngyīn móshì, zài bàogào jìnxíng guòchéng zhōng bùyào suíyì zǒudòng.', 'Khi tham dự hội nghị báo cáo học thuật quốc tế trang trọng, xin mời mọi người chuyển điện thoại sang chế độ im lặng, không tùy tiện đi lại trong quá trình buổi báo cáo diễn ra.', 'basic', 1),
      (v_id, '随着第六代移动通信技术的全球标准演进与低轨宽带卫星互联网密集组网，空天地海一体化无缝泛在移动互联时代正加速到来。', 'Suízhe dìliùdài yídòng tōngxìn jìshù de quánqiú biāozhǔn yǎnjìn yǔ dīguǐ kuāndài wèixīng hùliánwǎng mìjí zǔwǎng, kōng-tiān-dì-hǎi yītǐhuà wúfèng fànzài yídòng hùlián shídài zhèng jiāsù dàolái.', 'Cùng với sự tiến triển tiêu chuẩn toàn cầu của công nghệ thông tin di động thế hệ 6G và việc phóng mạng lưới vệ tinh internet băng thông rộng quỹ đạo thấp dày đặc, kỷ nguyên kết nối di động vạn vật liền mạch tích hợp không - vũ trụ - đất liền - biển khơi đang tăng tốc ùa đến.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3356] [遗憾] (yíhàn) - tiếc nuối, ân hận; đáng tiếc [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '遗憾' AND pinyin = 'yíhàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '遗憾' AND pinyin = 'yíhàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '遗憾'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '遗憾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'yíhàn',
      meaning_vi = 'tiếc nuối, ân hận; đáng tiếc',
      example_hanzi = '因临时被单位派往海外出差而未能亲自参加挚友的婚礼，他在电话中表达了由衷的遗憾与深深的祝福。',
      example_pinyin = 'Yīn línshí bèi dānwèi pài wǎng hǎiwài chūchāi ér wèinéng qīnzì cānjiā zhìyǒu de hūnlǐ, tā zài diànhuà zhōng biǎodá le yóuzhōng de yíhàn yǔ shēnshēn de zhùfú.',
      example_vi = 'Vì tạm thời được đơn vị cử đi công tác nước ngoài nên không thể đích thân tham dự hôn lễ của người bạn thân, anh ấy đã bày tỏ sự tiếc nuối chân thành cùng lời chúc phúc sâu sắc qua điện thoại.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '遗憾',
      'yíhàn',
      'tiếc nuối, ân hận; đáng tiếc',
      'Danh từ / Tính từ',
      'HSK 5',
      '因临时被单位派往海外出差而未能亲自参加挚友的婚礼，他在电话中表达了由衷的遗憾与深深的祝福。',
      'Yīn línshí bèi dānwèi pài wǎng hǎiwài chūchāi ér wèinéng qīnzì cānjiā zhìyǒu de hūnlǐ, tā zài diànhuà zhōng biǎodá le yóuzhōng de yíhàn yǔ shēnshēn de zhùfú.',
      'Vì tạm thời được đơn vị cử đi công tác nước ngoài nên không thể đích thân tham dự hôn lễ của người bạn thân, anh ấy đã bày tỏ sự tiếc nuối chân thành cùng lời chúc phúc sâu sắc qua điện thoại.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '因临时被单位派往海外出差而未能亲自参加挚友的婚礼，他在电话中表达了由衷的遗憾与深深的祝福。', 'Yīn línshí bèi dānwèi pài wǎng hǎiwài chūchāi ér wèinéng qīnzì cānjiā zhìyǒu de hūnlǐ, tā zài diànhuà zhōng biǎodá le yóuzhōng de yíhàn yǔ shēnshēn de zhùfú.', 'Vì tạm thời được đơn vị cử đi công tác nước ngoài nên không thể đích thân tham dự hôn lễ của người bạn thân, anh ấy đã bày tỏ sự tiếc nuối chân thành cùng lời chúc phúc sâu sắc qua điện thoại.', 'basic', 1),
      (v_id, '个别主要经济体单方面退出全球多边绿色环境治理协定，国际社会普遍对此深表遗憾并呼吁重回多边协商正轨。', 'Gèbié zhǔyào jīngjìtǐ dān fāngmiàn tuìchū quánqiú duōbiān lǜsè huánjìng zhìlǐ xiédìng, guójì shèhuì pǔbiàn duì cǐ shēn biǎo yíhàn bìng hūyù chóng huí duōbiān xiéshāng zhèngguǐ.', 'Một vài nền kinh tế chủ chốt đơn phương rút khỏi hiệp định quản trị môi trường xanh đa phương toàn cầu, cộng đồng quốc tế nhìn chung bày tỏ sự tiếc nuối sâu sắc và kêu gọi quay trở lại quỹ đạo đàm phán hiệp thương đa phương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3357] [一路] (yílù) - suốt chặng đường, suốt dọc đường; cùng một đường [Danh từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '一路' AND pinyin = 'yílù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一路' AND pinyin = 'yílù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '一路'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一路'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Phó từ',
      pinyin = 'yílù',
      meaning_vi = 'suốt chặng đường, suốt dọc đường; cùng một đường',
      example_hanzi = '高速列车飞驰在崇山峻岭之间，车厢内大家一路欢声笑语，不知不觉就抵达了风景秀丽的黄山。',
      example_pinyin = 'Gāosù lièchē fēichí zài chóngshān-jùnlǐng zhījiān, chēxiāng nèi dàjiā yílù huānshēng-xiàoyǔ, bùzhī-bùjué jiù dǐdá le fēngjǐng xiùlì de Huángshān.',
      example_vi = 'Đoàn tàu cao tốc lao vun vút giữa các rặng núi non trùng điệp, bên trong toa xe mọi người suốt dọc đường nói cười rộn rã, chẳng mấy chốc đã đến đỉnh Hoàng Sơn phong cảnh tú lệ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '一路',
      'yílù',
      'suốt chặng đường, suốt dọc đường; cùng một đường',
      'Danh từ / Phó từ',
      'HSK 5',
      '高速列车飞驰在崇山峻岭之间，车厢内大家一路欢声笑语，不知不觉就抵达了风景秀丽的黄山。',
      'Gāosù lièchē fēichí zài chóngshān-jùnlǐng zhījiān, chēxiāng nèi dàjiā yílù huānshēng-xiàoyǔ, bùzhī-bùjué jiù dǐdá le fēngjǐng xiùlì de Huángshān.',
      'Đoàn tàu cao tốc lao vun vút giữa các rặng núi non trùng điệp, bên trong toa xe mọi người suốt dọc đường nói cười rộn rã, chẳng mấy chốc đã đến đỉnh Hoàng Sơn phong cảnh tú lệ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '高速列车飞驰在崇山峻岭之间，车厢内大家一路欢声笑语，不知不觉就抵达了风景秀丽的黄山。', 'Gāosù lièchē fēichí zài chóngshān-jùnlǐng zhījiān, chēxiāng nèi dàjiā yílù huānshēng-xiàoyǔ, bùzhī-bùjué jiù dǐdá le fēngjǐng xiùlì de Huángshān.', 'Đoàn tàu cao tốc lao vun vút giữa các rặng núi non trùng điệp, bên trong toa xe mọi người suốt dọc đường nói cười rộn rã, chẳng mấy chốc đã đến đỉnh Hoàng Sơn phong cảnh tú lệ.', 'basic', 1),
      (v_id, '科技领军企业在高端工业母机核心零部件攻关道路上一路自强不息、攻坚克难，彻底打破了长期受制于人的技术封锁困局。', 'Kējì lǐngjūn qǐyè zài gāoduān gōngyè mǔjī héxīn língbùjiàn gōngguān dàolù shàng yílù zìqiáng-bùxī, gōngjiān-kènán, chèdǐ dǎpò le chángqī shòuzhì yú rén de jìshù fēngsuǒ kùnjú.', 'Doanh nghiệp công nghệ dẫn đầu trên chặng đường chinh phục các linh kiện then chốt của máy công cụ công nghiệp cao cấp đã suốt một hành trình không ngừng tự lực tự cường, vượt khó giải nan, đập tan triệt để thế bế tắc bị phong tỏa công nghệ phụ thuộc vào người khác suốt thời gian dài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3358] [一路顺风] (yílù-shùnfēng) - thuận buồm xuôi gió, thượng lộ bình an [Thành ngữ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '一路顺风' AND pinyin = 'yílù-shùnfēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一路顺风' AND pinyin = 'yílù-shùnfēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '一路顺风'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一路顺风'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thành ngữ',
      pinyin = 'yílù-shùnfēng',
      meaning_vi = 'thuận buồm xuôi gió, thượng lộ bình an',
      example_hanzi = '在高铁站安检进站口前，同窗好友们依依惜别，热情地挥手祝他前往新城市求学一路顺风。',
      example_pinyin = 'Zài gāotiězhàn ānjiǎn jìnzhànkǒu qián, tóngchuāng hǎoyǒumen yīyī-xībié, rèqíng de huīshǒu zhù tā qiánwǎng xīn chéngshì qiúxué yílù-shùnfēng.',
      example_vi = 'Trước cửa kiểm tra an ninh ga tàu cao tốc, các bạn học cùng lớp bịn rịn chia tay, nhiệt tình vẫy tay chúc bạn lên đường đến thành phố mới trúng tuyển thuận buồm xuôi gió.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '一路顺风',
      'yílù-shùnfēng',
      'thuận buồm xuôi gió, thượng lộ bình an',
      'Thành ngữ',
      'HSK 5',
      '在高铁站安检进站口前，同窗好友们依依惜别，热情地挥手祝他前往新城市求学一路顺风。',
      'Zài gāotiězhàn ānjiǎn jìnzhànkǒu qián, tóngchuāng hǎoyǒumen yīyī-xībié, rèqíng de huīshǒu zhù tā qiánwǎng xīn chéngshì qiúxué yílù-shùnfēng.',
      'Trước cửa kiểm tra an ninh ga tàu cao tốc, các bạn học cùng lớp bịn rịn chia tay, nhiệt tình vẫy tay chúc bạn lên đường đến thành phố mới trúng tuyển thuận buồm xuôi gió.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在高铁站安检进站口前，同窗好友们依依惜别，热情地挥手祝他前往新城市求学一路顺风。', 'Zài gāotiězhàn ānjiǎn jìnzhànkǒu qián, tóngchuāng hǎoyǒumen yīyī-xībié, rèqíng de huīshǒu zhù tā qiánwǎng xīn chéngshì qiúxué yílù-shùnfēng.', 'Trước cửa kiểm tra an ninh ga tàu cao tốc, các bạn học cùng lớp bịn rịn chia tay, nhiệt tình vẫy tay chúc bạn lên đường đến thành phố mới trúng tuyển thuận buồm xuôi gió.', 'basic', 1),
      (v_id, '礼宾司高级官员在首都国际机场国宾专用停机坪为结束正式国事访问的外国元首举行隆重欢送仪式，诚挚祝愿访问代表团一路顺风。', 'Lǐbīnsī gāojí guānyuán zài shǒudū guójì jīchǎng guóbīn zhuānyòng tíngjīpíng wèi jiéshù zhèngshì guóshì fǎngwèn de wàiguó yuánshǒu jǔxíng lóngzhòng huānsòng yíshì, chéngzhì zhùyuàn fǎngwèn dàibiǎotuán yílù-shùnfēng.', 'Quan chức cấp cao của Cục Lễ tân tại sân đỗ chuyên dụng đón nguyên thủ quốc gia ở sân bay quốc tế thủ đô đã tổ chức nghi lễ tiễn đưa long trọng cho vị nguyên thủ nước ngoài kết thúc chuyến thăm chính thức cấp nhà nước, chân thành chúc đoàn đại biểu thượng lộ bình an.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3359] [疑问] (yíwèn) - nghi vấn, thắc mắc, hoài nghi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '疑问' AND pinyin = 'yíwèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '疑问' AND pinyin = 'yíwèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '疑问'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '疑问'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yíwèn',
      meaning_vi = 'nghi vấn, thắc mắc, hoài nghi',
      example_hanzi = '同学们在自主阅读教材与实验指导书的过程中如果有任何疑问，随时都可以举手向任课老师请教。',
      example_pinyin = 'Tóngxuémen zài zìzhǔ yuèdú jiàocái yǔ shíyàn zhǐdǎoshū de guòchéng zhōng rúguǒ yǒu rènhé yíwèn, suíshí dōu kěyǐ jǔshǒu xiàng rènkè lǎoshī qǐngjiào.',
      example_vi = 'Các em học sinh trong quá trình tự đọc giáo trình và sách hướng dẫn thí nghiệm nếu có bất kỳ thắc mắc nào, bất cứ lúc nào cũng có thể giơ tay thỉnh giáo thầy cô phụ trách môn học.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '疑问',
      'yíwèn',
      'nghi vấn, thắc mắc, hoài nghi',
      'Danh từ',
      'HSK 5',
      '同学们在自主阅读教材与实验指导书的过程中如果有任何疑问，随时都可以举手向任课老师请教。',
      'Tóngxuémen zài zìzhǔ yuèdú jiàocái yǔ shíyàn zhǐdǎoshū de guòchéng zhōng rúguǒ yǒu rènhé yíwèn, suíshí dōu kěyǐ jǔshǒu xiàng rènkè lǎoshī qǐngjiào.',
      'Các em học sinh trong quá trình tự đọc giáo trình và sách hướng dẫn thí nghiệm nếu có bất kỳ thắc mắc nào, bất cứ lúc nào cũng có thể giơ tay thỉnh giáo thầy cô phụ trách môn học.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '同学们在自主阅读教材与实验指导书的过程中如果有任何疑问，随时都可以举手向任课老师请教。', 'Tóngxuémen zài zìzhǔ yuèdú jiàocái yǔ shíyàn zhǐdǎoshū de guòchéng zhōng rúguǒ yǒu rènhé yíwèn, suíshí dōu kěyǐ jǔshǒu xiàng rènkè lǎoshī qǐngjiào.', 'Các em học sinh trong quá trình tự đọc giáo trình và sách hướng dẫn thí nghiệm nếu có bất kỳ thắc mắc nào, bất cứ lúc nào cũng có thể giơ tay thỉnh giáo thầy cô phụ trách môn học.', 'basic', 1),
      (v_id, '刑事诉讼司法审判必须严格贯彻事实清楚、证据确实充分的法定原则，对关键指控事实中存在的未解疑问依法作出有利于被告人的裁判。', 'Xíngshì sùsòng sīfǎ shěnpàn bìxū yángé guànchè shìshí qīngchu, zhèngjù quèshí chōngfèn de fǎdìng yuánzé, duì guānjiàn zhǐkòng shìshí zhōng cúnzài de wèijiě yíwèn yīfǎ zuòchū yǒulì yú bèigàorén de cáipàn.', 'Xét xử tư pháp tố tụng hình sự bắt buộc phải quán triệt nghiêm ngặt nguyên tắc pháp định sự thật rõ ràng, chứng cứ xác thực đầy đủ, đối với những nghi vấn chưa được làm sáng tỏ trong các sự thật buộc tội then chốt sẽ đưa ra phán quyết có lợi cho bị cáo theo quy định của pháp luật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3360] [一致] (yízhì) - nhất trí, đồng thuận, nhất quán [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '一致' AND pinyin = 'yízhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一致' AND pinyin = 'yízhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '一致'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '一致'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'yízhì',
      meaning_vi = 'nhất trí, đồng thuận, nhất quán',
      example_hanzi = '经过全体教职工大会的充分民主研讨与投票，大家一致表决通过了新修订的校园绩效考核制度方案。',
      example_pinyin = 'Jīngguò quántǐ jiàozhígōng dàhuì de chōngfèn mínzhǔ yántǎo yǔ tóupiào, dàjiā yízhì biǎojué tōngguò le xīn xiūdìng de xiàoyuán jīxiào kǎohé zhìdù fāng’àn.',
      example_vi = 'Trải qua buổi thảo luận dân chủ và bỏ phiếu đầy đủ tại hội nghị toàn thể cán bộ giảng viên, mọi người đã nhất trí biểu quyết thông qua phương án chế độ đánh giá hiệu suất công tác học đường mới được tu chỉnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '一致',
      'yízhì',
      'nhất trí, đồng thuận, nhất quán',
      'Tính từ / Phó từ',
      'HSK 5',
      '经过全体教职工大会的充分民主研讨与投票，大家一致表决通过了新修订的校园绩效考核制度方案。',
      'Jīngguò quántǐ jiàozhígōng dàhuì de chōngfèn mínzhǔ yántǎo yǔ tóupiào, dàjiā yízhì biǎojué tōngguò le xīn xiūdìng de xiàoyuán jīxiào kǎohé zhìdù fāng’àn.',
      'Trải qua buổi thảo luận dân chủ và bỏ phiếu đầy đủ tại hội nghị toàn thể cán bộ giảng viên, mọi người đã nhất trí biểu quyết thông qua phương án chế độ đánh giá hiệu suất công tác học đường mới được tu chỉnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过全体教职工大会的充分民主研讨与投票，大家一致表决通过了新修订的校园绩效考核制度方案。', 'Jīngguò quántǐ jiàozhígōng dàhuì de chōngfèn mínzhǔ yántǎo yǔ tóupiào, dàjiā yízhì biǎojué tōngguò le xīn xiūdìng de xiàoyuán jīxiào kǎohé zhìdù fāng’àn.', 'Trải qua buổi thảo luận dân chủ và bỏ phiếu đầy đủ tại hội nghị toàn thể cán bộ giảng viên, mọi người đã nhất trí biểu quyết thông qua phương án chế độ đánh giá hiệu suất công tác học đường mới được tu chỉnh.', 'basic', 1),
      (v_id, '联合国多边气候变化大会全体缔约方在经历多轮艰苦博弈磋商后，终于在设立全球损失与损害资金机制核心议题上达成高度一致。', 'Liánhéguó duōbiān qìhòu biànhuà dàhuì quántǐ dìyuēfāng zài jīnglì duō lún jiānkǔ bóyì cuōshāng hòu, zhōngyú zài shèlì quánqiú sǔnshī yǔ sǔnhài zījīn jīzhì héxīn yìtí shàng dáchéng gāodù yízhì.', 'Toàn thể các bên tham gia Công ước khung Liên Hợp Quốc về biến đổi khí hậu sau nhiều vòng đàm phán cân não cam go, cuối cùng đã đạt được sự đồng thuận cao độ trên vấn đề cốt lõi về việc thiết lập cơ chế quỹ tổn thất và thiệt hại toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3361] [乙] (yǐ) - Ất, bên B, hạng hai (trong văn bản hợp đồng, thứ tự) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '乙' AND pinyin = 'yǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乙' AND pinyin = 'yǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '乙'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乙'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǐ',
      meaning_vi = 'Ất, bên B, hạng hai (trong văn bản hợp đồng, thứ tự)',
      example_hanzi = '在这份房屋买卖商业合同文本中，李先生代表买受人身份在“乙方”一栏郑重签署了自己的姓名。',
      example_pinyin = 'Zài zhè fèn fángwū mǎimài shāngyè hétong wénběn zhōng, Lǐ xiānsheng dàibiǎo mǎishòurén shēnfèn zài “Yǐfāng” yī lán zhèngzhòng qiānshǔ le zìjǐ de xìngmíng.',
      example_vi = 'Trong văn bản hợp đồng thương mại mua bán nhà ở này, ông Lý đại diện với tư cách bên mua đã trịnh trọng ký tên mình vào mục "Bên B".'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '乙',
      'yǐ',
      'Ất, bên B, hạng hai (trong văn bản hợp đồng, thứ tự)',
      'Danh từ',
      'HSK 5',
      '在这份房屋买卖商业合同文本中，李先生代表买受人身份在“乙方”一栏郑重签署了自己的姓名。',
      'Zài zhè fèn fángwū mǎimài shāngyè hétong wénběn zhōng, Lǐ xiānsheng dàibiǎo mǎishòurén shēnfèn zài “Yǐfāng” yī lán zhèngzhòng qiānshǔ le zìjǐ de xìngmíng.',
      'Trong văn bản hợp đồng thương mại mua bán nhà ở này, ông Lý đại diện với tư cách bên mua đã trịnh trọng ký tên mình vào mục "Bên B".'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在这份房屋买卖商业合同文本中，李先生代表买受人身份在“乙方”一栏郑重签署了自己的姓名。', 'Zài zhè fèn fángwū mǎimài shāngyè hétong wénběn zhōng, Lǐ xiānsheng dàibiǎo mǎishòurén shēnfèn zài “Yǐfāng” yī lán zhèngzhòng qiānshǔ le zìjǐ de xìngmíng.', 'Trong văn bản hợp đồng thương mại mua bán nhà ở này, ông Lý đại diện với tư cách bên mua đã trịnh trọng ký tên mình vào mục "Bên B".', 'basic', 1),
      (v_id, '专利交叉许可协议明确约定，甲方授权乙方在指定海外司法辖区内独占实施该前沿发明专利，乙方须按季度向甲方足额支付技术许可提成费。', 'Zhuānlì jiāochā xǔkě xiéyì míngquè yuēdìng, Jiǎfāng shòukuán Yǐfāng zài zhǐdìng hǎiwài sīfǎ xiáqū nèi dúzhàn shíshī gāi qiányán fāmíng zhuānlì, Yǐfāng xū àn jìdù xiàng Jiǎfāng zú’é zhīfù jìshù xǔkě tíchéngfèi.', 'Thỏa thuận cấp phép chéo bằng sáng chế quy định rõ ràng, bên A ủy quyền cho bên B độc quyền khai thác bằng sáng chế phát minh tiền duyên đó trong phạm vi quyền tài phán hải ngoại được chỉ định, bên B phải thanh toán đầy đủ phí hoa hồng cấp phép công nghệ theo từng quý cho bên A.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3362] [以] (yǐ) - lấy, dùng, căn cứ; để, mà [Giới từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '以' AND pinyin = 'yǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '以' AND pinyin = 'yǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '以'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '以'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Giới từ / Liên từ',
      pinyin = 'yǐ',
      meaning_vi = 'lấy, dùng, căn cứ; để, mà',
      example_hanzi = '青年人在人生的成长与奋斗历程中，应当以崇高的理想为引路灯塔，以踏实笃行的实践为坚实阶梯。',
      example_pinyin = 'Qīngniánrén zài rénshēng de chéngzhǎng yǔ fèndòu lìchéng zhōng, yīngdāng yǐ chónggāo de lǐxiǎng wéi yǐnlù dēngtǎ, yǐ tàshi dǔxíng de shíjiàn wéi jiānshí jiētī.',
      example_vi = 'Thanh niên trong hành trình trưởng thành và phấn đấu của đời người, nên lấy lý tưởng cao cả làm ngọn hải đăng dẫn lối, lấy thực tiễn hành động thiết thực làm bậc thang vững chắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '以',
      'yǐ',
      'lấy, dùng, căn cứ; để, mà',
      'Giới từ / Liên từ',
      'HSK 5',
      '青年人在人生的成长与奋斗历程中，应当以崇高的理想为引路灯塔，以踏实笃行的实践为坚实阶梯。',
      'Qīngniánrén zài rénshēng de chéngzhǎng yǔ fèndòu lìchéng zhōng, yīngdāng yǐ chónggāo de lǐxiǎng wéi yǐnlù dēngtǎ, yǐ tàshi dǔxíng de shíjiàn wéi jiānshí jiētī.',
      'Thanh niên trong hành trình trưởng thành và phấn đấu của đời người, nên lấy lý tưởng cao cả làm ngọn hải đăng dẫn lối, lấy thực tiễn hành động thiết thực làm bậc thang vững chắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年人在人生的成长与奋斗历程中，应当以崇高的理想为引路灯塔，以踏实笃行的实践为坚实阶梯。', 'Qīngniánrén zài rénshēng de chéngzhǎng yǔ fèndòu lìchéng zhōng, yīngdāng yǐ chónggāo de lǐxiǎng wéi yǐnlù dēngtǎ, yǐ tàshi dǔxíng de shíjiàn wéi jiānshí jiētī.', 'Thanh niên trong hành trình trưởng thành và phấn đấu của đời người, nên lấy lý tưởng cao cả làm ngọn hải đăng dẫn lối, lấy thực tiễn hành động thiết thực làm bậc thang vững chắc.', 'basic', 1),
      (v_id, '我国高水平对外开放以制度型开放为战略核心，以自由贸易试验区为先行先试载体，全面主动对接国际高标准经贸规则。', 'Wǒguó gāoshuǐpíng duìwài kāifàng yǐ zhìdùxíng kāifàng wéi zhànlüè héxīn, yǐ zìyóu màoyì shìyànqū wéi xiānxíng-xiānshì zàitǐ, quánmiàn zhǔdòng duìjiē guójì gāobiāozhǔn jīngmào guīzé.', 'Công cuộc mở cửa đối ngoại tiêu chuẩn cao của nước ta lấy mở cửa mang tính thể chế làm hạt nhân chiến lược, lấy các khu thương mại tự do thí điểm làm điểm tựa đi trước thử nghiệm, chủ động kết nối toàn diện với các quy tắc kinh tế thương mại chuẩn mực cao quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3363] [以及] (yǐjí) - cùng với, và, cũng như [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '以及' AND pinyin = 'yǐjí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '以及' AND pinyin = 'yǐjí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '以及'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '以及'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'yǐjí',
      meaning_vi = 'cùng với, và, cũng như',
      example_hanzi = '参加暑期研学夏令营的同学们需要备齐本人有效身份证件、适量换洗衣物以及常用的日常防暑药品。',
      example_pinyin = 'Cānjiā shǔqī yánxué xiàlìngyíng de tóngxuémen xūyào bèi qí běnrén yǒuxiào shēnfèn zhèngjiàn, shìliàng huànxǐ yīwù yǐjí chángyòng de rìcháng fángshǔ yàopǐn.',
      example_vi = 'Các em học sinh tham gia trại hè nghiên cứu học tập kỳ nghỉ hè cần chuẩn bị đầy đủ giấy tờ tùy thân còn hiệu lực, quần áo thay đổi vừa đủ cùng với các loại thuốc chống say nắng thông thường hàng ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '以及',
      'yǐjí',
      'cùng với, và, cũng như',
      'Liên từ',
      'HSK 5',
      '参加暑期研学夏令营的同学们需要备齐本人有效身份证件、适量换洗衣物以及常用的日常防暑药品。',
      'Cānjiā shǔqī yánxué xiàlìngyíng de tóngxuémen xūyào bèi qí běnrén yǒuxiào shēnfèn zhèngjiàn, shìliàng huànxǐ yīwù yǐjí chángyòng de rìcháng fángshǔ yàopǐn.',
      'Các em học sinh tham gia trại hè nghiên cứu học tập kỳ nghỉ hè cần chuẩn bị đầy đủ giấy tờ tùy thân còn hiệu lực, quần áo thay đổi vừa đủ cùng với các loại thuốc chống say nắng thông thường hàng ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '参加暑期研学夏令营的同学们需要备齐本人有效身份证件、适量换洗衣物以及常用的日常防暑药品。', 'Cānjiā shǔqī yánxué xiàlìngyíng de tóngxuémen xūyào bèi qí běnrén yǒuxiào shēnfèn zhèngjiàn, shìliàng huànxǐ yīwù yǐjí chángyòng de rìcháng fángshǔ yàopǐn.', 'Các em học sinh tham gia trại hè nghiên cứu học tập kỳ nghỉ hè cần chuẩn bị đầy đủ giấy tờ tùy thân còn hiệu lực, quần áo thay đổi vừa đủ cùng với các loại thuốc chống say nắng thông thường hàng ngày.', 'basic', 1),
      (v_id, '国家综合性科学中心大科学装置集群面向全球科研团队开放，重点支持量子纠缠测量、类脑计算架构以及新型超导材料的前沿交叉研究。', 'Guójiā zōnghéxìng kēxué zhōngxīn dà kēxué zhuāngzhì jíqún miànxiàng quánqiú kēyán tuánduì kāifàng, zhòngdiǎn zhīchí liàngzǐ jiūchán cèliáng, lèinǎo jìsuàn jiàgòu yǐjí xīnxíng chāodǎo cáiliào de qiányán jiāochā yánjiū.', 'Cụm thiết bị khoa học lớn của Trung tâm khoa học tổng hợp quốc gia mở cửa phục vụ các đội ngũ nghiên cứu toàn cầu, hỗ trợ trọng điểm cho các nghiên cứu giao thoa tiền duyên về đo đạc liên đới lượng tử, kiến trúc tính toán mô phỏng não bộ cũng như các vật liệu siêu dẫn kiểu mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3364] [以来] (yǐlái) - từ... đến nay, kể từ khi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '以来' AND pinyin = 'yǐlái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '以来' AND pinyin = 'yǐlái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '以来'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '以来'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǐlái',
      meaning_vi = 'từ... đến nay, kể từ khi',
      example_hanzi = '自从踏入大学校门以来，他不仅在专业课程学习中名列前茅，还积极投身各项公益助学志愿服务活动。',
      example_pinyin = 'Zìcóng tàrù dàxué xiàomén yǐlái, tā bùjǐn zài zhuānyè kèchéng xuéxí zhōng míngliè-qiánmáo, hái jījí tóushēn gè xiàng gōngyì zhùxué zhìyuàn fúwù huódòng.',
      example_vi = 'Kể từ khi bước chân vào cổng trường đại học đến nay, anh ấy không chỉ đứng đầu trong các môn học chuyên ngành mà còn tích cực dấn thân vào các hoạt động tình nguyện công ích tiếp sức đến trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '以来',
      'yǐlái',
      'từ... đến nay, kể từ khi',
      'Danh từ',
      'HSK 5',
      '自从踏入大学校门以来，他不仅在专业课程学习中名列前茅，还积极投身各项公益助学志愿服务活动。',
      'Zìcóng tàrù dàxué xiàomén yǐlái, tā bùjǐn zài zhuānyè kèchéng xuéxí zhōng míngliè-qiánmáo, hái jījí tóushēn gè xiàng gōngyì zhùxué zhìyuàn fúwù huódòng.',
      'Kể từ khi bước chân vào cổng trường đại học đến nay, anh ấy không chỉ đứng đầu trong các môn học chuyên ngành mà còn tích cực dấn thân vào các hoạt động tình nguyện công ích tiếp sức đến trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '自从踏入大学校门以来，他不仅在专业课程学习中名列前茅，还积极投身各项公益助学志愿服务活动。', 'Zìcóng tàrù dàxué xiàomén yǐlái, tā bùjǐn zài zhuānyè kèchéng xuéxí zhōng míngliè-qiánmáo, hái jījí tóushēn gè xiàng gōngyì zhùxué zhìyuàn fúwù huódòng.', 'Kể từ khi bước chân vào cổng trường đại học đến nay, anh ấy không chỉ đứng đầu trong các môn học chuyên ngành mà còn tích cực dấn thân vào các hoạt động tình nguyện công ích tiếp sức đến trường.', 'basic', 1),
      (v_id, '进入新时代以来，我国经济实力、科技研发实力与综合国力跃上崭新历史大台阶，为实现中华民族伟大复兴奠定了坚如磐石的物质基石。', 'Jìnrù xīn shídài yǐlái, wǒguó jīngjì shílì, kējì yánfā shílì yǔ zōnghé guólì yuè shàng zhǎnxīn lìshǐ dà táijiē, wèi shíxiàn Zhōnghuá mínzú wěidà fùxīng diàndìng le jiānrúpánshí de wùzhì jīshí.', 'Kể từ khi bước vào thời đại mới đến nay, thực lực kinh tế, thực lực nghiên cứu phát triển khoa học công nghệ và sức mạnh tổng hợp quốc gia của nước ta đã bước lên nấc thang lịch sử mới toanh, đặt nền móng vật chất vững như bàn thạch cho việc thực hiện sự phục hưng vĩ đại của dân tộc Trung Hoa.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3365] [亿] (yì) - ức, một trăm triệu (100.000.000) [Số từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '亿' AND pinyin = 'yì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亿' AND pinyin = 'yì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '亿'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '亿'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Số từ',
      pinyin = 'yì',
      meaning_vi = 'ức, một trăm triệu (100.000.000)',
      example_hanzi = '经过几代林业科研人员数十年的艰苦治沙造林，塞罕坝林场如今已累计蓄积了数亿立方米的优质木材资源。',
      example_pinyin = 'Jīngguò jǐ dài línyè kēyán rényuán shù shí nián de jiānkǔ zhìshā zàolín, Sàihǎnbà línchǎng rújīn yǐ lěijì xùjī le shù yì lìfāngmǐ de yōuzhì mùcái zīyuán.',
      example_vi = 'Trải qua nhiều thập kỷ cải tạo cát trồng rừng gian khổ của nhiều thế hệ cán bộ khoa học lâm nghiệp, nông trường rừng Saihanba nay đã tích lũy được hàng trăm triệu mét khối tài nguyên gỗ chất lượng cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '亿',
      'yì',
      'ức, một trăm triệu (100.000.000)',
      'Số từ',
      'HSK 5',
      '经过几代林业科研人员数十年的艰苦治沙造林，塞罕坝林场如今已累计蓄积了数亿立方米的优质木材资源。',
      'Jīngguò jǐ dài línyè kēyán rényuán shù shí nián de jiānkǔ zhìshā zàolín, Sàihǎnbà línchǎng rújīn yǐ lěijì xùjī le shù yì lìfāngmǐ de yōuzhì mùcái zīyuán.',
      'Trải qua nhiều thập kỷ cải tạo cát trồng rừng gian khổ của nhiều thế hệ cán bộ khoa học lâm nghiệp, nông trường rừng Saihanba nay đã tích lũy được hàng trăm triệu mét khối tài nguyên gỗ chất lượng cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过几代林业科研人员数十年的艰苦治沙造林，塞罕坝林场如今已累计蓄积了数亿立方米的优质木材资源。', 'Jīngguò jǐ dài línyè kēyán rényuán shù shí nián de jiānkǔ zhìshā zàolín, Sàihǎnbà línchǎng rújīn yǐ lěijì xùjī le shù yì lìfāngmǐ de yōuzhì mùcái zīyuán.', 'Trải qua nhiều thập kỷ cải tạo cát trồng rừng gian khổ của nhiều thế hệ cán bộ khoa học lâm nghiệp, nông trường rừng Saihanba nay đã tích lũy được hàng trăm triệu mét khối tài nguyên gỗ chất lượng cao.', 'basic', 1),
      (v_id, '我国拥有十四亿多人口的超大规模国内消费市场与完备的内需体系，为抵御外部风浪冲击提供了最可靠的战略纵深支撑。', 'Wǒguó yǒngyǒu shísì yì duō rénkǒu de chāo-dà guīmó guónèi xiāofèi shìchǎng yǔ wánbèi de nèixū tǐxì, wèi dǐyù wàibù fēnglàng chōngjī tígōng le zuì kěkào de zhànlüè zòngshēn zhīchēng.', 'Nước ta sở hữu thị trường tiêu dùng nội địa quy mô siêu lớn với hơn 1,4 tỷ dân cùng hệ thống nội nhu hoàn bị, cung cấp sự chống đỡ chiều sâu chiến lược đáng tin cậy nhất để chống lại các cú sốc sóng gió bên ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3366] [意识] (yìshí) - ý thức; nhận thức được [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '意识' AND pinyin = 'yìshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '意识' AND pinyin = 'yìshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '意识'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '意识'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'yìshí',
      meaning_vi = 'ý thức; nhận thức được',
      example_hanzi = '随着全民科学健身知识的普及，越来越多的年轻白领开始主动提升日常锻炼身体与规律作息的健康意识。',
      example_pinyin = 'Suízhe quánmín kēxué jiànshēn zhīshi de pǔjí, yuèláiyuè duō de niánqīng báilǐng kāishǐ zhǔdòng tíshēng rìcháng duànliàn shēntǐ yǔ guīlǜ zuòxī de jiànkāng yìshí.',
      example_vi = 'Cùng với sự phổ cập kiến thức rèn luyện thể chất khoa học toàn dân, ngày càng nhiều nhân viên văn phòng trẻ bắt đầu chủ động nâng cao ý thức sức khỏe về việc tập luyện thể thao hàng ngày và sinh hoạt điều độ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '意识',
      'yìshí',
      'ý thức; nhận thức được',
      'Danh từ / Động từ',
      'HSK 5',
      '随着全民科学健身知识的普及，越来越多的年轻白领开始主动提升日常锻炼身体与规律作息的健康意识。',
      'Suízhe quánmín kēxué jiànshēn zhīshi de pǔjí, yuèláiyuè duō de niánqīng báilǐng kāishǐ zhǔdòng tíshēng rìcháng duànliàn shēntǐ yǔ guīlǜ zuòxī de jiànkāng yìshí.',
      'Cùng với sự phổ cập kiến thức rèn luyện thể chất khoa học toàn dân, ngày càng nhiều nhân viên văn phòng trẻ bắt đầu chủ động nâng cao ý thức sức khỏe về việc tập luyện thể thao hàng ngày và sinh hoạt điều độ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着全民科学健身知识的普及，越来越多的年轻白领开始主动提升日常锻炼身体与规律作息的健康意识。', 'Suízhe quánmín kēxué jiànshēn zhīshi de pǔjí, yuèláiyuè duō de niánqīng báilǐng kāishǐ zhǔdòng tíshēng rìcháng duànliàn shēntǐ yǔ guīlǜ zuòxī de jiànkāng yìshí.', 'Cùng với sự phổ cập kiến thức rèn luyện thể chất khoa học toàn dân, ngày càng nhiều nhân viên văn phòng trẻ bắt đầu chủ động nâng cao ý thức sức khỏe về việc tập luyện thể thao hàng ngày và sinh hoạt điều độ.', 'basic', 1),
      (v_id, '面对高度复杂的跨境网络渗透攻击与勒索病毒风险，关键基础设施运营单位必须牢固树立底线防御意识并全面加固全流程态势感知防护网络。', 'Miànduì gāodù fùzá de kuàjìng wǎngluò shèntòu gōngjī yǔ lèsuǒ bìngdú fēngxiǎn, guānjiàn jīchǔ shèshī yùnyíng dānwèi bìxū láogù shùlì dǐxiàn fángyù yìshí bìng quánmiàn jiāgù quán-liúchéng tàishì gǎnzhī fánghù wǎngluò.', 'Đối mặt với các nguy cơ tấn công xâm nhập mạng xuyên biên giới và mã độc tống tiền có độ phức tạp cao, các đơn vị vận hành cơ sở hạ tầng trọng yếu bắt buộc phải xây dựng vững chắc ý thức phòng thủ lằn ranh đỏ và gia cố toàn diện mạng lưới phòng hộ nhận biết tình huống toàn quy trình.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3367] [意外] (yìwài) - ngoài ý muốn, bất ngờ; tai nạn bất ngờ [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '意外' AND pinyin = 'yìwài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '意外' AND pinyin = 'yìwài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '意外'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '意外'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'yìwài',
      meaning_vi = 'ngoài ý muốn, bất ngờ; tai nạn bất ngờ',
      example_hanzi = '他在旧书店淘书时意外发现了一册珍贵的早期手抄本文献，内心感到无比惊喜。',
      example_pinyin = 'Tā zài jiù shūdiàn táo shū shí yìwài fāxiàn le yī cè zhēnguì de zǎoqī shǒuchāoběn wénxiàn, nèixīn gǎndào wúbǐ jīngxǐ.',
      example_vi = 'Khi lục tìm sách ở hiệu sách cũ, anh ấy bất ngờ phát hiện ra một tập tài liệu văn hiến chép tay thời kỳ đầu vô cùng quý giá, trong lòng cảm thấy bất ngờ và vui mừng khôn xiết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '意外',
      'yìwài',
      'ngoài ý muốn, bất ngờ; tai nạn bất ngờ',
      'Tính từ / Danh từ',
      'HSK 5',
      '他在旧书店淘书时意外发现了一册珍贵的早期手抄本文献，内心感到无比惊喜。',
      'Tā zài jiù shūdiàn táo shū shí yìwài fāxiàn le yī cè zhēnguì de zǎoqī shǒuchāoběn wénxiàn, nèixīn gǎndào wúbǐ jīngxǐ.',
      'Khi lục tìm sách ở hiệu sách cũ, anh ấy bất ngờ phát hiện ra một tập tài liệu văn hiến chép tay thời kỳ đầu vô cùng quý giá, trong lòng cảm thấy bất ngờ và vui mừng khôn xiết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在旧书店淘书时意外发现了一册珍贵的早期手抄本文献，内心感到无比惊喜。', 'Tā zài jiù shūdiàn táo shū shí yìwài fāxiàn le yī cè zhēnguì de zǎoqī shǒuchāoběn wénxiàn, nèixīn gǎndào wúbǐ jīngxǐ.', 'Khi lục tìm sách ở hiệu sách cũ, anh ấy bất ngờ phát hiện ra một tập tài liệu văn hiến chép tay thời kỳ đầu vô cùng quý giá, trong lòng cảm thấy bất ngờ và vui mừng khôn xiết.', 'basic', 1),
      (v_id, '特高压输电走廊智能化巡检机器人集成双光融合视觉与超声波测厚传感器，能精准排查设备潜在绝缘放电缺陷，有效杜绝电网突发断电意外事故。', 'Tègāoyā shūdiàn zǒuláng zhìnénghuà xúnjiǎn jīqìrén jíchéng shuāngguāng rónghé shìjué yǔ chāoshēngbō cèhòu chuángǎnqì, néng jīngzhǔn páichá shèbèi qiánzài juéyuán fàngdiàn quēxiàn, yǒuxiào dùjué diànwǎng tūfā duàndiàn yìwài shìgù.', 'Robot tuần kiểm thông minh hành lang truyền tải điện siêu cao thế tích hợp thị giác kết hợp ánh sáng kép và cảm biến đo độ dày siêu âm, có thể rà soát chuẩn xác các khiếm khuyết phóng điện cách điện tiềm ẩn của thiết bị, ngăn ngừa hiệu quả các sự cố mất điện bất ngờ trên lưới điện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3368] [意味着] (yìwèizhe) - có nghĩa là, đồng nghĩa với, mang hàm ý là [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '意味着' AND pinyin = 'yìwèizhe'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '意味着' AND pinyin = 'yìwèizhe'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '意味着'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '意味着'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yìwèizhe',
      meaning_vi = 'có nghĩa là, đồng nghĩa với, mang hàm ý là',
      example_hanzi = '窗外树枝上吐出第一缕嫩绿的新芽，微风不再刺骨，这往往意味着寒冬已去、温暖的春季正悄然到来。',
      example_pinyin = 'Chuāngwài shùzhī shàng tǔchū dì-yī lǚ nènlǜ de xīnyá, wēifēng bù zài cìgǔ, zhè wǎngwǎng yìwèizhe hándōng yǐ qù, wēnnuǎn de chūnjì zhèng qiǎorán dàolái.',
      example_vi = 'Trên cành cây ngoài cửa sổ nhú ra những mầm non xanh mướt đầu tiên, gió nhẹ không còn buốt giá, điều này thường có nghĩa là mùa đông lạnh giá đã qua đi và mùa xuân ấm áp đang lặng lẽ tới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '意味着',
      'yìwèizhe',
      'có nghĩa là, đồng nghĩa với, mang hàm ý là',
      'Động từ',
      'HSK 5',
      '窗外树枝上吐出第一缕嫩绿的新芽，微风不再刺骨，这往往意味着寒冬已去、温暖的春季正悄然到来。',
      'Chuāngwài shùzhī shàng tǔchū dì-yī lǚ nènlǜ de xīnyá, wēifēng bù zài cìgǔ, zhè wǎngwǎng yìwèizhe hándōng yǐ qù, wēnnuǎn de chūnjì zhèng qiǎorán dàolái.',
      'Trên cành cây ngoài cửa sổ nhú ra những mầm non xanh mướt đầu tiên, gió nhẹ không còn buốt giá, điều này thường có nghĩa là mùa đông lạnh giá đã qua đi và mùa xuân ấm áp đang lặng lẽ tới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '窗外树枝上吐出第一缕嫩绿的新芽，微风不再刺骨，这往往意味着寒冬已去、温暖的春季正悄然到来。', 'Chuāngwài shùzhī shàng tǔchū dì-yī lǚ nènlǜ de xīnyá, wēifēng bù zài cìgǔ, zhè wǎngwǎng yìwèizhe hándōng yǐ qù, wēnnuǎn de chūnjì zhèng qiǎorán dàolái.', 'Trên cành cây ngoài cửa sổ nhú ra những mầm non xanh mướt đầu tiên, gió nhẹ không còn buốt giá, điều này thường có nghĩa là mùa đông lạnh giá đã qua đi và mùa xuân ấm áp đang lặng lẽ tới.', 'basic', 1),
      (v_id, '我国完全自主研制的大型民用客机实现高密度商业航线常态化安全运营，意味着我们在全球顶尖大飞机制造业核心领域已成功打破外部垄断。', 'Wǒguó wánquán zìzhǔ yánzhì de dàxíng mínyòng kèjī shíxiàn gāomìdù shāngyè hángxiàn chángtàihuà ānquán yùnyíng, yìwèizhe wǒmen zài quánqiú dǐngjiān dà-fēijī zhìzàoyè héxīn lǐngyù yǐ chénggōng dǎpò wàibù lǒngduàn.', 'Máy bay chở khách dân dụng cỡ lớn do nước ta hoàn toàn tự chủ nghiên cứu chế tạo hiện thực hóa vận hành an toàn thường thái hóa trên các đường bay thương mại mật độ cao, đồng nghĩa với việc chúng ta đã phá vỡ thành công thế độc quyền bên ngoài trong lĩnh vực cốt lõi chế tạo máy bay lớn đỉnh cao toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3369] [义务] (yìwù) - nghĩa vụ; tình nguyện, mang tính nghĩa vụ [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '义务' AND pinyin = 'yìwù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '义务' AND pinyin = 'yìwù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '义务'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '义务'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'yìwù',
      meaning_vi = 'nghĩa vụ; tình nguyện, mang tính nghĩa vụ',
      example_hanzi = '依照国家宪法和法律的相关规定，依法纳税是每一个公民必须履行的光荣法定义务。',
      example_pinyin = 'Yīzhào guójiā xiànfǎ hé fǎlǜ de xiāngguān guīdìng, yīfǎ nàshuì shì měi yī gè gōngmín bìxū lǚxíng de guāngróng fǎdìng yìwù.',
      example_vi = 'Chiếu theo các quy định liên quan của hiến pháp và pháp luật nhà nước, nộp thuế theo luật định là nghĩa vụ pháp lý vinh quang mà mỗi một công dân đều bắt buộc phải thực hiện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '义务',
      'yìwù',
      'nghĩa vụ; tình nguyện, mang tính nghĩa vụ',
      'Danh từ / Tính từ',
      'HSK 5',
      '依照国家宪法和法律的相关规定，依法纳税是每一个公民必须履行的光荣法定义务。',
      'Yīzhào guójiā xiànfǎ hé fǎlǜ de xiāngguān guīdìng, yīfǎ nàshuì shì měi yī gè gōngmín bìxū lǚxíng de guāngróng fǎdìng yìwù.',
      'Chiếu theo các quy định liên quan của hiến pháp và pháp luật nhà nước, nộp thuế theo luật định là nghĩa vụ pháp lý vinh quang mà mỗi một công dân đều bắt buộc phải thực hiện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '依照国家宪法和法律的相关规定，依法纳税是每一个公民必须履行的光荣法定义务。', 'Yīzhào guójiā xiànfǎ hé fǎlǜ de xiāngguān guīdìng, yīfǎ nàshuì shì měi yī gè gōngmín bìxū lǚxíng de guāngróng fǎdìng yìwù.', 'Chiếu theo các quy định liên quan của hiến pháp và pháp luật nhà nước, nộp thuế theo luật định là nghĩa vụ pháp lý vinh quang mà mỗi một công dân đều bắt buộc phải thực hiện.', 'basic', 1),
      (v_id, '国际多边环境条约所有缔约方必须切实履行共同但有区别的公约义务，发达国家应当率先兑现向发展中国家提供气候转型资金与技术援助的承诺。', 'Guójì duōbiān huánjìng tiáoyuē suǒyǒu dìyuēfāng bìxū qièshí lǚxíng gòngtóng dàn yǒu qūbié de gōngyuē yìwù, fādá guójiā yīngdāng shuàixiān duìxiàn xiàng fāzhǎnzhōng guójiā tígōng qìhòu zhuǎnxíng zījīn yǔ jìshù yuánzhù de chéngnuò.', 'Tất cả các bên tham gia điều ước môi trường đa phương quốc tế bắt buộc phải thực thi thiết thực các nghĩa vụ công ước chung nhưng có sự phân biệt, các nước phát triển cần đi đầu trong việc thực hiện cam kết cung cấp nguồn vốn chuyển đổi khí hậu và viện trợ kỹ thuật cho các nước đang phát triển.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3370] [意义] (yìyì) - ý nghĩa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '意义' AND pinyin = 'yìyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '意义' AND pinyin = 'yìyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '意义'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '意义'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yìyì',
      meaning_vi = 'ý nghĩa',
      example_hanzi = '青年人在大学时代多深入基层社区开展扶贫助学志愿服务，对于深化国情认知与树立奉献社会的人生价值观具有深远的现实意义。',
      example_pinyin = 'Qīngniánrén zài dàxué shídài duō shēnrù jīcéng shèqū kāizhǎn fúpín zhùxué zhìyuàn fúwù, duìyú shēnhuà guóqíng rènzhī yǔ shùlì fèngxiàn shèhuì de rénshēng jiàzhíguān jùyǒu shēnyuǎn de xiànshí yìyì.',
      example_vi = 'Thanh niên trong thời đại học đi sâu vào các cộng đồng cơ sở triển khai các hoạt động tình nguyện giúp đỡ học sinh nghèo có ý nghĩa thực tế sâu xa đối với việc thấu hiểu tình hình đất nước và xây dựng nhân sinh quan cống hiến cho xã hội.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '意义',
      'yìyì',
      'ý nghĩa',
      'Danh từ',
      'HSK 5',
      '青年人在大学时代多深入基层社区开展扶贫助学志愿服务，对于深化国情认知与树立奉献社会的人生价值观具有深远的现实意义。',
      'Qīngniánrén zài dàxué shídài duō shēnrù jīcéng shèqū kāizhǎn fúpín zhùxué zhìyuàn fúwù, duìyú shēnhuà guóqíng rènzhī yǔ shùlì fèngxiàn shèhuì de rénshēng jiàzhíguān jùyǒu shēnyuǎn de xiànshí yìyì.',
      'Thanh niên trong thời đại học đi sâu vào các cộng đồng cơ sở triển khai các hoạt động tình nguyện giúp đỡ học sinh nghèo có ý nghĩa thực tế sâu xa đối với việc thấu hiểu tình hình đất nước và xây dựng nhân sinh quan cống hiến cho xã hội.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年人在大学时代多深入基层社区开展扶贫助学志愿服务，对于深化国情认知与树立奉献社会的人生价值观具有深远的现实意义。', 'Qīngniánrén zài dàxué shídài duō shēnrù jīcéng shèqū kāizhǎn fúpín zhùxué zhìyuàn fúwù, duìyú shēnhuà guóqíng rènzhī yǔ shùlì fèngxiàn shèhuì de rénshēng jiàzhíguān jùyǒu shēnyuǎn de xiànshí yìyì.', 'Thanh niên trong thời đại học đi sâu vào các cộng đồng cơ sở triển khai các hoạt động tình nguyện giúp đỡ học sinh nghèo có ý nghĩa thực tế sâu xa đối với việc thấu hiểu tình hình đất nước và xây dựng nhân sinh quan cống hiến cho xã hội.', 'basic', 1),
      (v_id, '自主攻克极紫外光刻机核心光学系统与超高纯半导体基础原料制备工艺，对筑牢我国信息技术产业底层供应链安全底座具有里程碑式战略意义。', 'Zìzhǔ gōngkè jí-zǐwài guāngkèjī héxīn guāngxué xìtǒng yǔ chāogāochún bàndǎotǐ jīchǔ yuánliào zhìbèi gōngyì, duì zhù láo wǒguó xìnxī jìshù chǎnyè dǐcéng gōngyìngliàn ānquán dǐzuò jùyǒu lǐchéngbēishì zhànlüè yìyì.', 'Việc tự chủ chinh phục hệ thống quang học cốt lõi của máy quang khắc tia cực tím cực sâu EUV và quy trình điều chế nguyên liệu bán dẫn cơ bản siêu tinh khiết có ý nghĩa chiến lược mang tính cột mốc đối với việc đắp vững nền móng an toàn chuỗi cung ứng tầng đáy cho ngành công nghiệp công nghệ thông tin nước nhà.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3371] [因而] (yīn’ér) - cho nên, vì thế, do đó [Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '因而' AND pinyin = 'yīn’ér'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '因而' AND pinyin = 'yīn’ér'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '因而'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '因而'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Liên từ',
      pinyin = 'yīn’ér',
      meaning_vi = 'cho nên, vì thế, do đó',
      example_hanzi = '他在平时的日常实验操作中始终一丝不苟、严谨求实，因而所记录的每一个测试数据都深得指导导师与课题组同仁的高度信赖。',
      example_pinyin = 'Tā zài píngshí de rìcháng shíyàn cāozuò zhōng shǐzhōng yīsī-bùgǒu, yánjǐn qiúshí, yīn’ér suǒ jìlù de měi yī gè cèshì shùjù dōu shēn dé zhǐdǎo dǎoshī yǔ kètízǔ tóngrén de gāodù xìnlài.',
      example_vi = 'Trong các thao tác thí nghiệm hàng ngày anh ấy luôn cẩn thận tỉ mỉ, nghiêm cẩn thực tế, do đó từng số liệu thử nghiệm ghi lại đều nhận được sự tin tưởng cao độ từ người thầy hướng dẫn và các đồng nghiệp trong nhóm nghiên cứu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '因而',
      'yīn’ér',
      'cho nên, vì thế, do đó',
      'Liên từ',
      'HSK 5',
      '他在平时的日常实验操作中始终一丝不苟、严谨求实，因而所记录的每一个测试数据都深得指导导师与课题组同仁的高度信赖。',
      'Tā zài píngshí de rìcháng shíyàn cāozuò zhōng shǐzhōng yīsī-bùgǒu, yánjǐn qiúshí, yīn’ér suǒ jìlù de měi yī gè cèshì shùjù dōu shēn dé zhǐdǎo dǎoshī yǔ kètízǔ tóngrén de gāodù xìnlài.',
      'Trong các thao tác thí nghiệm hàng ngày anh ấy luôn cẩn thận tỉ mỉ, nghiêm cẩn thực tế, do đó từng số liệu thử nghiệm ghi lại đều nhận được sự tin tưởng cao độ từ người thầy hướng dẫn và các đồng nghiệp trong nhóm nghiên cứu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在平时的日常实验操作中始终一丝不苟、严谨求实，因而所记录的每一个测试数据都深得指导导师与课题组同仁的高度信赖。', 'Tā zài píngshí de rìcháng shíyàn cāozuò zhōng shǐzhōng yīsī-bùgǒu, yánjǐn qiúshí, yīn’ér suǒ jìlù de měi yī gè cèshì shùjù dōu shēn dé zhǐdǎo dǎoshī yǔ kètízǔ tóngrén de gāodù xìnlài.', 'Trong các thao tác thí nghiệm hàng ngày anh ấy luôn cẩn thận tỉ mỉ, nghiêm cẩn thực tế, do đó từng số liệu thử nghiệm ghi lại đều nhận được sự tin tưởng cao độ từ người thầy hướng dẫn và các đồng nghiệp trong nhóm nghiên cứu.', 'basic', 1),
      (v_id, '该新型轻质高强钛铝金属间化合物材料在千度极端高温下依然具备出色的抗氧化与耐蠕变性能，因而成为制造下一代超音速航空发动机热端部件的理想选材。', 'Gāi xīnxíng qīngzhì gāoxiáng tài-lǚ jīnshǔjiān huàhéwù cáiliào zài qiān dù jíduān gāowēn xià yīrán jùbèi chūsè de kàng-yǎnghuà yǔ nài-rúbiàn xìngnéng, yīn’ér chéngwéi zhìzào xiàyīdài chāoyīnsù hángkōng fādòngjī rèduān bùjiàn de lǐxiǎng xuǎncái.', 'Loại vật liệu hợp chất liên kim titan-nhôm cường độ cao trọng lượng nhẹ kiểu mới này ở nhiệt độ cực cao hàng nghìn độ vẫn sở hữu tính năng chống oxy hóa và chịu biến dạng dẻo xuất sắc, cho nên đã trở thành vật liệu lý tưởng để chế tạo các bộ phận đầu nóng của động cơ hàng không siêu thanh thế hệ tiếp theo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3372] [音量] (yīnliàng) - âm lượng, độ to của âm thanh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '音量' AND pinyin = 'yīnliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '音量' AND pinyin = 'yīnliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '音量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '音量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yīnliàng',
      meaning_vi = 'âm lượng, độ to của âm thanh',
      example_hanzi = '在图书馆自习室、医院候诊区等静音公共场所接打电话或使用多媒体设备时，请自觉佩戴耳机并将系统音量调至最低。',
      example_pinyin = 'Zài túshūguǎn zìxíshì, yīyuàn hòuzhěnqū děng jìngyīn gōnggòng chǎngsuǒ jiē-dǎ diànhuà huò shǐyòng duōméitǐ shèbèi shí, qǐng zìjué pèidài ěrjī bìng jiāng xìtǒng yīnliàng tiáo zhì zuìdī.',
      example_vi = 'Khi nghe gọi điện thoại hoặc sử dụng thiết bị đa phương tiện tại những nơi công cộng cần giữ yên tĩnh như phòng tự học thư viện, khu vực chờ khám bệnh viện, xin vui lòng tự giác đeo tai nghe và chỉnh âm lượng hệ thống xuống mức thấp nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '音量',
      'yīnliàng',
      'âm lượng, độ to của âm thanh',
      'Danh từ',
      'HSK 5',
      '在图书馆自习室、医院候诊区等静音公共场所接打电话或使用多媒体设备时，请自觉佩戴耳机并将系统音量调至最低。',
      'Zài túshūguǎn zìxíshì, yīyuàn hòuzhěnqū děng jìngyīn gōnggòng chǎngsuǒ jiē-dǎ diànhuà huò shǐyòng duōméitǐ shèbèi shí, qǐng zìjué pèidài ěrjī bìng jiāng xìtǒng yīnliàng tiáo zhì zuìdī.',
      'Khi nghe gọi điện thoại hoặc sử dụng thiết bị đa phương tiện tại những nơi công cộng cần giữ yên tĩnh như phòng tự học thư viện, khu vực chờ khám bệnh viện, xin vui lòng tự giác đeo tai nghe và chỉnh âm lượng hệ thống xuống mức thấp nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在图书馆自习室、医院候诊区等静音公共场所接打电话或使用多媒体设备时，请自觉佩戴耳机并将系统音量调至最低。', 'Zài túshūguǎn zìxíshì, yīyuàn hòuzhěnqū děng jìngyīn gōnggòng chǎngsuǒ jiē-dǎ diànhuà huò shǐyòng duōméitǐ shèbèi shí, qǐng zìjué pèidài ěrjī bìng jiāng xìtǒng yīnliàng tiáo zhì zuìdī.', 'Khi nghe gọi điện thoại hoặc sử dụng thiết bị đa phương tiện tại những nơi công cộng cần giữ yên tĩnh như phòng tự học thư viện, khu vực chờ khám bệnh viện, xin vui lòng tự giác đeo tai nghe và chỉnh âm lượng hệ thống xuống mức thấp nhất.', 'basic', 1),
      (v_id, '高端智能智能座舱依托分布式麦克风阵列与车内声学降噪算法，能实时感知车速与路面轮胎滚动噪音，毫秒级自适应动态调节导航语音播报音量。', 'Gāoduān zhìnéng zuòcāng yītuō fēnbùshì màikèfēng zhènliè yǔ chēnèi shēngxué jiàngzào suànfǎ, néng shíshí gǎnzhī chēsù yǔ lùmiàn lúntāi gǔndòng zàoyīn, háomiǎojí zìshìyìng dòngtài tiáojié dǎoháng yǔyīn bōbào yīnliàng.', 'Khoang lái thông minh cao cấp dựa trên mảng micrô phân tán và thuật toán giảm tiếng ồn âm học trong xe, có thể cảm nhận thời gian thực tốc độ xe và tiếng ồn lăn của lốp xe trên mặt đường, tự thích ứng điều chỉnh âm lượng phát thanh định vị giọng nói một cách linh hoạt ở cấp độ mili giây.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3373] [因素] (yīnsù) - nhân tố, yếu tố cấu thành [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '因素' AND pinyin = 'yīnsù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '因素' AND pinyin = 'yīnsù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '因素'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '因素'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yīnsù',
      meaning_vi = 'nhân tố, yếu tố cấu thành',
      example_hanzi = '均衡充足的营养摄入、科学规律的体育锻炼与积极阳光的心理状态，是青年人保持身心健康不可或缺的关键因素。',
      example_pinyin = 'Jūnhéng chōngzú de yíngyǎng shèrù, kēxué guīlǜ de tǐyù duànliàn yǔ jījí yángguāng de xīnlǐ zhuàngtài, shì qīngniánrén bǎochí shēnxīn jiànkāng bùkě-huòquē de guānjiàn yīnsù.',
      example_vi = 'Nạp đầy đủ cân bằng dinh dưỡng, rèn luyện thể thao quy củ khoa học và giữ trạng thái tâm lý tích cực lạc quan là những nhân tố then chốt không thể thiếu để thanh niên duy trì sức khỏe thể chất tinh thần.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '因素',
      'yīnsù',
      'nhân tố, yếu tố cấu thành',
      'Danh từ',
      'HSK 5',
      '均衡充足的营养摄入、科学规律的体育锻炼与积极阳光的心理状态，是青年人保持身心健康不可或缺的关键因素。',
      'Jūnhéng chōngzú de yíngyǎng shèrù, kēxué guīlǜ de tǐyù duànliàn yǔ jījí yángguāng de xīnlǐ zhuàngtài, shì qīngniánrén bǎochí shēnxīn jiànkāng bùkě-huòquē de guānjiàn yīnsù.',
      'Nạp đầy đủ cân bằng dinh dưỡng, rèn luyện thể thao quy củ khoa học và giữ trạng thái tâm lý tích cực lạc quan là những nhân tố then chốt không thể thiếu để thanh niên duy trì sức khỏe thể chất tinh thần.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '均衡充足的营养摄入、科学规律的体育锻炼与积极阳光的心理状态，是青年人保持身心健康不可或缺的关键因素。', 'Jūnhéng chōngzú de yíngyǎng shèrù, kēxué guīlǜ de tǐyù duànliàn yǔ jījí yángguāng de xīnlǐ zhuàngtài, shì qīngniánrén bǎochí shēnxīn jiànkāng bùkě-huòquē de guānjiàn yīnsù.', 'Nạp đầy đủ cân bằng dinh dưỡng, rèn luyện thể thao quy củ khoa học và giữ trạng thái tâm lý tích cực lạc quan là những nhân tố then chốt không thể thiếu để thanh niên duy trì sức khỏe thể chất tinh thần.', 'basic', 1),
      (v_id, '国家宏观经济金融系统性风险监测预警模型综合研判大宗商品价格波动、主权债务信用违约风险溢价等多重不确定性外部因素。', 'Guójiā hóngguān jīngjì jīnróng xìtǒngxìng fēngxiǎn jiāncè yùjǐng móxíng zōnghé yánpàn dàzōng shāngpǐn jiàgé bōdòng, zhǔquán zhàiwù xìnyòng wéiyuē fēngxiǎn yìjià děng duōchóng bù-quèdìngxìng wàibù yīnsù.', 'Mô hình giám sát cảnh báo rủi ro mang tính hệ thống tài chính kinh tế vĩ mô quốc gia đã nhận định tổng hợp nhiều yếu tố bên ngoài bất định như biến động giá cả hàng hóa cơ bản, mức bù rủi ro vỡ nợ tín dụng nợ công.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3374] [引进] (yǐnjìn) - tiếp thu, nhập về, thu hút, đưa vào [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '引进' AND pinyin = 'yǐnjìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '引进' AND pinyin = 'yǐnjìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '引进'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '引进'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yǐnjìn',
      meaning_vi = 'tiếp thu, nhập về, thu hút, đưa vào',
      example_hanzi = '现代高效生态农业示范园引进了国际先进的温室全自动无土立体栽培与智能滴灌施肥系统，农作物品质和产量大幅提高。',
      example_pinyin = 'Xiàndài gāoxiào shēngtài nóngyè shìfàn yuán yǐnjìn le guójì xiānjìn de wēnshì quán-zìdòng wútǔ lìtǐ zāipéi yǔ zhìnéng dīguàn shīféi xìtǒng, nóngzuòwù pǐnzhì hé chǎnliàng dàfú tígāo.',
      example_vi = 'Khu công viên trình diễn nông nghiệp sinh thái hiệu quả cao hiện đại đã đưa vào hệ thống canh tác ba chiều không cần đất tự động hoàn toàn trong nhà kính và tưới nhỏ giọt bón phân thông minh tiên tiến của quốc tế, chất lượng và sản lượng nông sản được nâng cao rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '引进',
      'yǐnjìn',
      'tiếp thu, nhập về, thu hút, đưa vào',
      'Động từ',
      'HSK 5',
      '现代高效生态农业示范园引进了国际先进的温室全自动无土立体栽培与智能滴灌施肥系统，农作物品质和产量大幅提高。',
      'Xiàndài gāoxiào shēngtài nóngyè shìfàn yuán yǐnjìn le guójì xiānjìn de wēnshì quán-zìdòng wútǔ lìtǐ zāipéi yǔ zhìnéng dīguàn shīféi xìtǒng, nóngzuòwù pǐnzhì hé chǎnliàng dàfú tígāo.',
      'Khu công viên trình diễn nông nghiệp sinh thái hiệu quả cao hiện đại đã đưa vào hệ thống canh tác ba chiều không cần đất tự động hoàn toàn trong nhà kính và tưới nhỏ giọt bón phân thông minh tiên tiến của quốc tế, chất lượng và sản lượng nông sản được nâng cao rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现代高效生态农业示范园引进了国际先进的温室全自动无土立体栽培与智能滴灌施肥系统，农作物品质和产量大幅提高。', 'Xiàndài gāoxiào shēngtài nóngyè shìfàn yuán yǐnjìn le guójì xiānjìn de wēnshì quán-zìdòng wútǔ lìtǐ zāipéi yǔ zhìnéng dīguàn shīféi xìtǒng, nóngzuòwù pǐnzhì hé chǎnliàng dàfú tígāo.', 'Khu công viên trình diễn nông nghiệp sinh thái hiệu quả cao hiện đại đã đưa vào hệ thống canh tác ba chiều không cần đất tự động hoàn toàn trong nhà kính và tưới nhỏ giọt bón phân thông minh tiên tiến của quốc tế, chất lượng và sản lượng nông sản được nâng cao rõ rệt.', 'basic', 1),
      (v_id, '国家级高新技术产业园区制定实施更加开放前瞻的全球顶尖人才引进新政，全方位支持跨国一流科研团队成建制归国创新创业。', 'Guójiājí gāoxīnjìshù chǎnyè yuánqū zhìdìng shíshī gèngjiā kāifàng qiánzhān de quánqiú dǐngjiān réncái yǐnjìn xīnjièng, quán-fāngwèi zhīchí kuàguó yīliú kēyán tuánduì chéngjiànzhì guīguó chuàngxīn chuàngyè.', 'Khu công nghiệp công nghệ cao cấp quốc gia xây dựng và thực thi chính sách mới thu hút nhân tài đỉnh cao toàn cầu cởi mở và nhìn xa trông rộng hơn, hỗ trợ toàn diện để các đội ngũ nghiên cứu khoa học hạng nhất xuyên quốc gia về nước theo quy mô bài bản nhằm đổi mới khởi nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3375] [饮食] (yǐnshí) - ẩm thực, ăn uống, khẩu phần ăn [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '饮食' AND pinyin = 'yǐnshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '饮食' AND pinyin = 'yǐnshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '饮食'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '饮食'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǐnshí',
      meaning_vi = 'ẩm thực, ăn uống, khẩu phần ăn',
      example_hanzi = '养成清淡少油少盐、荤素科学合理搭配的良好日常饮食习惯，对于预防中老年慢性心血管疾病至关重要。',
      example_pinyin = 'Yǎngchéng qīngdàn shǎo yóu shǎo yán, hūn-sù kēxué hélǐ dāpèi de liánghǎo rìcháng yǐnshí xíguàn, duìyú yùfáng zhōng-lǎonián mànxìng xīnxuèguǎn jíbìng zhìguān zhòngyào.',
      example_vi = 'Hình thành thói quen ăn uống thường nhật thanh đạm ít dầu ít muối, kết hợp món chay mặn một cách khoa học hợp lý là vô cùng quan trọng đối với việc phòng ngừa các bệnh tim mạch mãn tính ở người trung và cao tuổi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '饮食',
      'yǐnshí',
      'ẩm thực, ăn uống, khẩu phần ăn',
      'Danh từ',
      'HSK 5',
      '养成清淡少油少盐、荤素科学合理搭配的良好日常饮食习惯，对于预防中老年慢性心血管疾病至关重要。',
      'Yǎngchéng qīngdàn shǎo yóu shǎo yán, hūn-sù kēxué hélǐ dāpèi de liánghǎo rìcháng yǐnshí xíguàn, duìyú yùfáng zhōng-lǎonián mànxìng xīnxuèguǎn jíbìng zhìguān zhòngyào.',
      'Hình thành thói quen ăn uống thường nhật thanh đạm ít dầu ít muối, kết hợp món chay mặn một cách khoa học hợp lý là vô cùng quan trọng đối với việc phòng ngừa các bệnh tim mạch mãn tính ở người trung và cao tuổi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '养成清淡少油少盐、荤素科学合理搭配的良好日常饮食习惯，对于预防中老年慢性心血管疾病至关重要。', 'Yǎngchéng qīngdàn shǎo yóu shǎo yán, hūn-sù kēxué hélǐ dāpèi de liánghǎo rìcháng yǐnshí xíguàn, duìyú yùfáng zhōng-lǎonián mànxìng xīnxuèguǎn jíbìng zhìguān zhòngyào.', 'Hình thành thói quen ăn uống thường nhật thanh đạm ít dầu ít muối, kết hợp món chay mặn một cách khoa học hợp lý là vô cùng quan trọng đối với việc phòng ngừa các bệnh tim mạch mãn tính ở người trung và cao tuổi.', 'basic', 1),
      (v_id, '现代临床营养代谢前沿医学深入探究人类肠道微生态菌群与疾病谱演变关联，依托多组学数据为重症患者制定个体化特医饮食治疗路径。', 'Xiàndài línchuáng yíngyǎng dàixiè qiányán yīxué shēnrù tànjiū rénlèi chángdào wēishēngtài jūnqún yǔ jíbìngpǔ yǎnjiàn guānlián, yītuō duō-zǔxué shùjù wèi zhòngzhèng huànzhě zhìdìng gètǐhuà tèyī yǐnshí zhìliáo lùjìng.', 'Y học tiền duyên chuyển hóa dinh dưỡng lâm sàng hiện đại đi sâu khám phá mối liên quan giữa hệ vi sinh đường ruột của con người và sự tiến hóa của mô hình bệnh tật, dựa vào dữ liệu đa omics để lập nên lộ trình điều trị khẩu phần ăn y tế đặc biệt cá nhân hóa cho các bệnh nhân nặng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3376] [印刷] (yìnshuā) - in ấn; ngành in, kỹ thuật in [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '印刷' AND pinyin = 'yìnshuā'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '印刷' AND pinyin = 'yìnshuā'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '印刷'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '印刷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yìnshuā',
      meaning_vi = 'in ấn; ngành in, kỹ thuật in',
      example_hanzi = '这本最新出版的中国古代传统经典山水画册采用了高精密度环保水性油墨印刷，完美重现了传世名画的细腻神韵。',
      example_pinyin = 'Zhè běn zuìxīn chūbǎn de Zhōngguó gǔdài chuántǒng jīngdiǎn shānshuǐ huàcè cǎiyòng le gāojīngmìdù huánbǎo shuǐxìng yóumò yìnshuā, wánměi chóngxiàn le chuánshì mínghuà de xìnì shényùn.',
      example_vi = 'Tập tranh thủy mặc kinh điển truyền thống cổ đại Trung Quốc mới xuất bản này sử dụng kỹ thuật in mực gốc nước thân thiện với môi trường có độ chính xác cao, tái hiện hoàn hảo vẻ thần thái tinh tế của các bức danh họa lưu truyền ngàn đời.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '印刷',
      'yìnshuā',
      'in ấn; ngành in, kỹ thuật in',
      'Động từ / Danh từ',
      'HSK 5',
      '这本最新出版的中国古代传统经典山水画册采用了高精密度环保水性油墨印刷，完美重现了传世名画的细腻神韵。',
      'Zhè běn zuìxīn chūbǎn de Zhōngguó gǔdài chuántǒng jīngdiǎn shānshuǐ huàcè cǎiyòng le gāojīngmìdù huánbǎo shuǐxìng yóumò yìnshuā, wánměi chóngxiàn le chuánshì mínghuà de xìnì shényùn.',
      'Tập tranh thủy mặc kinh điển truyền thống cổ đại Trung Quốc mới xuất bản này sử dụng kỹ thuật in mực gốc nước thân thiện với môi trường có độ chính xác cao, tái hiện hoàn hảo vẻ thần thái tinh tế của các bức danh họa lưu truyền ngàn đời.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这本最新出版的中国古代传统经典山水画册采用了高精密度环保水性油墨印刷，完美重现了传世名画的细腻神韵。', 'Zhè běn zuìxīn chūbǎn de Zhōngguó gǔdài chuántǒng jīngdiǎn shānshuǐ huàcè cǎiyòng le gāojīngmìdù huánbǎo shuǐxìng yóumò yìnshuā, wánměi chóngxiàn le chuánshì mínghuà de xìnì shényùn.', 'Tập tranh thủy mặc kinh điển truyền thống cổ đại Trung Quốc mới xuất bản này sử dụng kỹ thuật in mực gốc nước thân thiện với môi trường có độ chính xác cao, tái hiện hoàn hảo vẻ thần thái tinh tế của các bức danh họa lưu truyền ngàn đời.', 'basic', 1),
      (v_id, '国家法定纸币印钞工艺全面集成高精度凹版微雕雕刻印刷、微型全息防伪开窗安全线与红外荧光编码等多重物理防伪尖端制造技术。', 'Guójiā fǎdìng zhǐbì yìnchāo gōngyì quánmiàn jíchéng gāojīngdù āobǎn wēidiāo diāokè yìnshuā, wēixíng quánxī fángwěi kāichuāng ānquánxiàn yǔ hóngwài yíngguāng biāomǎ děng duōchóng wùlǐ fángwěi jiānduān zhìzào jìshù.', 'Quy trình in tiền giấy theo luật định quốc gia tích hợp toàn diện công nghệ in khắc vi mô bản lõm độ chính xác cao, dải chỉ bảo an cửa sổ chống giả toàn ảnh vi mô cùng nhiều công nghệ chế tạo tiên tiến chống làm giả vật lý đa tầng như mã hóa huỳnh quang hồng ngoại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3377] [应当] (yīngdāng) - nên, phải, cần phải [Động từ năng nguyện]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '应当' AND pinyin = 'yīngdāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '应当' AND pinyin = 'yīngdāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '应当'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '应当'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ năng nguyện',
      pinyin = 'yīngdāng',
      meaning_vi = 'nên, phải, cần phải',
      example_hanzi = '青年人在求职面试时应当着装整洁得体，并以真诚从容、自信坦率的态度回答考官提出的专业提问。',
      example_pinyin = 'Qīngniánrén zài qiúzhí miànshì shí yīngdāng zhuózhuāng zhěngjié détǐ, bìng yǐ zhēnchéng cóngróng, zìxìn tǎnshuài de tàidù huídá kǎoguān tíchū de zhuānyè tíwèn.',
      example_vi = 'Thanh niên khi đi phỏng vấn xin việc nên ăn mặc gọn gàng chỉnh tề, đồng thời trả lời các câu hỏi chuyên môn của ban giám khảo với thái độ chân thành ung dung, tự tin và thẳng thắn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '应当',
      'yīngdāng',
      'nên, phải, cần phải',
      'Động từ năng nguyện',
      'HSK 5',
      '青年人在求职面试时应当着装整洁得体，并以真诚从容、自信坦率的态度回答考官提出的专业提问。',
      'Qīngniánrén zài qiúzhí miànshì shí yīngdāng zhuózhuāng zhěngjié détǐ, bìng yǐ zhēnchéng cóngróng, zìxìn tǎnshuài de tàidù huídá kǎoguān tíchū de zhuānyè tíwèn.',
      'Thanh niên khi đi phỏng vấn xin việc nên ăn mặc gọn gàng chỉnh tề, đồng thời trả lời các câu hỏi chuyên môn của ban giám khảo với thái độ chân thành ung dung, tự tin và thẳng thắn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年人在求职面试时应当着装整洁得体，并以真诚从容、自信坦率的态度回答考官提出的专业提问。', 'Qīngniánrén zài qiúzhí miànshì shí yīngdāng zhuózhuāng zhěngjié détǐ, bìng yǐ zhēnchéng cóngróng, zìxìn tǎnshuài de tàidù huídá kǎoguān tíchū de zhuānyè tíwèn.', 'Thanh niên khi đi phỏng vấn xin việc nên ăn mặc gọn gàng chỉnh tề, đồng thời trả lời các câu hỏi chuyên môn của ban giám khảo với thái độ chân thành ung dung, tự tin và thẳng thắn.', 'basic', 1),
      (v_id, '生成式人工智能算法模型在研发全生命周期中应当严格遵循科技伦理监管准则，确保算法决策透明、可解释且符合人类根本福祉。', 'Shēngchéngshì réngōng zhìnéng suànfǎ móxíng zài yánfā quán-shēngmìng zhōuqī zhōng yīngdāng yángé zūnxún kējì lúnlǐ jiānguǎn zhǔnzé, quèbǎo suànfǎ juécè tòumíng, kějiěshì qiě fúhé rénlèi gēnběn fúzhǐ.', 'Mô hình thuật toán trí tuệ nhân tạo tạo sinh trong toàn bộ vòng đời R&D cần phải tuân thủ nghiêm ngặt các chuẩn mực giám sát đạo đức khoa học công nghệ, bảo đảm quyết định thuật toán minh bạch, có thể giải thích được và phù hợp với phúc lợi căn bản của loài người.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3378] [迎] (yíng) - đón, nghênh tiếp, hướng về phía trước [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '迎' AND pinyin = 'yíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迎' AND pinyin = 'yíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '迎'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迎'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yíng',
      meaning_vi = 'đón, nghênh tiếp, hướng về phía trước',
      example_hanzi = '清晨，登山爱好者们迎着初升的朝阳与徐徐清凉的晨风，大步迈向高耸翠绿的山顶。',
      example_pinyin = 'Qīngchén, dēngshān àihàozhěmen yíng zhe chūshēng de zhāoyáng yǔ xúxú qīngliáng de chénfēng, dàbù mài xiàng gāosǒng cuìlǜ de shāndǐng.',
      example_vi = 'Sáng sớm, những người đam mê leo núi đón ánh mặt trời ban mai vừa ló rạng cùng làn gió sớm mát lành thong thả, rảo bước tiến về phía đỉnh núi cao sừng sững xanh tươi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '迎',
      'yíng',
      'đón, nghênh tiếp, hướng về phía trước',
      'Động từ',
      'HSK 5',
      '清晨，登山爱好者们迎着初升的朝阳与徐徐清凉的晨风，大步迈向高耸翠绿的山顶。',
      'Qīngchén, dēngshān àihàozhěmen yíng zhe chūshēng de zhāoyáng yǔ xúxú qīngliáng de chénfēng, dàbù mài xiàng gāosǒng cuìlǜ de shāndǐng.',
      'Sáng sớm, những người đam mê leo núi đón ánh mặt trời ban mai vừa ló rạng cùng làn gió sớm mát lành thong thả, rảo bước tiến về phía đỉnh núi cao sừng sững xanh tươi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '清晨，登山爱好者们迎着初升的朝阳与徐徐清凉的晨风，大步迈向高耸翠绿的山顶。', 'Qīngchén, dēngshān àihàozhěmen yíng zhe chūshēng de zhāoyáng yǔ xúxú qīngliáng de chénfēng, dàbù mài xiàng gāosǒng cuìlǜ de shāndǐng.', 'Sáng sớm, những người đam mê leo núi đón ánh mặt trời ban mai vừa ló rạng cùng làn gió sớm mát lành thong thả, rảo bước tiến về phía đỉnh núi cao sừng sững xanh tươi.', 'basic', 1),
      (v_id, '高科技领军企业在面对外部单边极端技术封锁与供应链断供逆流时迎难而上，依托自主研发坚决攻克关键核心工业设计软件底层壁垒。', 'Gāokējì lǐngjūn qǐyè zài miànduì wàibù dānbiān jíduān jìshù fēngsuǒ yǔ gōngyìngliàn duàngōng nìliú shí yíngnán-érshàng, yītuō zìzhǔ yánfā jiānjué gōngkè guānjiàn héxīn gōngyè shèjì ruǎnjiàn dǐcéng bìlěi.', 'Doanh nghiệp công nghệ cao hàng đầu khi đối mặt với các lệnh phong tỏa công nghệ cực đoan đơn phương từ bên ngoài và dòng nghịch lưu đứt gãy chuỗi cung ứng đã đón đầu khó khăn xốc tới, dựa vào tự chủ nghiên cứu phát triển kiên quyết chinh phục rào cản tầng đáy của phần mềm thiết kế công nghiệp then chốt cốt lõi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3379] [迎接] (yíngjiē) - đón tiếp, nghênh đón, đón chào [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '迎接' AND pinyin = 'yíngjiē'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迎接' AND pinyin = 'yíngjiē'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '迎接'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '迎接'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yíngjiē',
      meaning_vi = 'đón tiếp, nghênh đón, đón chào',
      example_hanzi = '在机场国际到达大厅出口处，师生代表们拉起热情洋溢的横幅，热烈迎接远道而来的海外学术交流团。',
      example_pinyin = 'Zài jīchǎng guójì dàodá dàtīng chūkǒuchù, shī-shēng dàibiǎomen lā qǐ rèqíng-yángyì de héngfú, rèliè yíngjiē yuǎndào-érlái de hǎiwài xuéshù jiāoliútuán.',
      example_vi = 'Tại cửa ra sảnh đến quốc tế sân bay, đại diện thầy trò đã giăng biểu ngữ tràn ngập nhiệt tình, nồng nhiệt đón chào đoàn giao lưu học thuật từ phương xa đến.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '迎接',
      'yíngjiē',
      'đón tiếp, nghênh đón, đón chào',
      'Động từ',
      'HSK 5',
      '在机场国际到达大厅出口处，师生代表们拉起热情洋溢的横幅，热烈迎接远道而来的海外学术交流团。',
      'Zài jīchǎng guójì dàodá dàtīng chūkǒuchù, shī-shēng dàibiǎomen lā qǐ rèqíng-yángyì de héngfú, rèliè yíngjiē yuǎndào-érlái de hǎiwài xuéshù jiāoliútuán.',
      'Tại cửa ra sảnh đến quốc tế sân bay, đại diện thầy trò đã giăng biểu ngữ tràn ngập nhiệt tình, nồng nhiệt đón chào đoàn giao lưu học thuật từ phương xa đến.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在机场国际到达大厅出口处，师生代表们拉起热情洋溢的横幅，热烈迎接远道而来的海外学术交流团。', 'Zài jīchǎng guójì dàodá dàtīng chūkǒuchù, shī-shēng dàibiǎomen lā qǐ rèqíng-yángyì de héngfú, rèliè yíngjiē yuǎndào-érlái de hǎiwài xuéshù jiāoliútuán.', 'Tại cửa ra sảnh đến quốc tế sân bay, đại diện thầy trò đã giăng biểu ngữ tràn ngập nhiệt tình, nồng nhiệt đón chào đoàn giao lưu học thuật từ phương xa đến.', 'basic', 1),
      (v_id, '面对新一轮以人工智能和量子计算为代表的颠覆性科技变革大潮，我国以更深层次的制度型开放与改革创新从容迎接全球新机遇与新挑战。', 'Miànduì xīn yī lún yǐ réngōng zhìnéng hé liàngzǐ jìsuàn wéi dàibiǎo de diānfùxìng kējì biàngé dàcháo, wǒguó yǐ gèng shēncéngcì de zhìdùxíng kāifàng yǔ gǎigé chuàngxīn cóngróng yíngjiē quánqiú xīn jīyù yǔ xīn tiǎozhàn.', 'Đối mặt với làn sóng biến đổi khoa học công nghệ mang tính đột phá vòng mới đại diện bởi AI và tính toán lượng tử, nước ta bằng việc mở cửa mang tính thể chế ở tầng sâu hơn cùng cải cách đổi mới sáng tạo đã ung dung đón chào những thời cơ và thách thức mới của toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3380] [营养] (yíngyǎng) - dinh dưỡng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '营养' AND pinyin = 'yíngyǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '营养' AND pinyin = 'yíngyǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '营养'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '营养'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yíngyǎng',
      meaning_vi = 'dinh dưỡng',
      example_hanzi = '新鲜纯牛奶、深海海鱼与绿色蔬菜富含优质蛋白质与微量元素，是青少年生长发育不可或缺的全面营养来源。',
      example_pinyin = 'Xīnxiān chúnniúnǎi, shēnhǎi hǎiyú yǔ lǜsè shūcài fùhán yōuzhì dànbáizhì yǔ wēiliàng yuánsù, shì qīngshàonián shēngzhǎng fāyù bùkě-huòquē de quánmiàn yíngyǎng láiyuán.',
      example_vi = 'Sữa tươi nguyên chất, cá biển sâu và rau xanh giàu protein chất lượng cao cùng các nguyên tố vi lượng, là nguồn dinh dưỡng toàn diện không thể thiếu đối với sự sinh trưởng phát triển của thanh thiếu niên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '营养',
      'yíngyǎng',
      'dinh dưỡng',
      'Danh từ',
      'HSK 5',
      '新鲜纯牛奶、深海海鱼与绿色蔬菜富含优质蛋白质与微量元素，是青少年生长发育不可或缺的全面营养来源。',
      'Xīnxiān chúnniúnǎi, shēnhǎi hǎiyú yǔ lǜsè shūcài fùhán yōuzhì dànbáizhì yǔ wēiliàng yuánsù, shì qīngshàonián shēngzhǎng fāyù bùkě-huòquē de quánmiàn yíngyǎng láiyuán.',
      'Sữa tươi nguyên chất, cá biển sâu và rau xanh giàu protein chất lượng cao cùng các nguyên tố vi lượng, là nguồn dinh dưỡng toàn diện không thể thiếu đối với sự sinh trưởng phát triển của thanh thiếu niên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '新鲜纯牛奶、深海海鱼与绿色蔬菜富含优质蛋白质与微量元素，是青少年生长发育不可或缺的全面营养来源。', 'Xīnxiān chúnniúnǎi, shēnhǎi hǎiyú yǔ lǜsè shūcài fùhán yōuzhì dànbáizhì yǔ wēiliàng yuánsù, shì qīngshàonián shēngzhǎng fāyù bùkě-huòquē de quánmiàn yíngyǎng láiyuán.', 'Sữa tươi nguyên chất, cá biển sâu và rau xanh giàu protein chất lượng cao cùng các nguyên tố vi lượng, là nguồn dinh dưỡng toàn diện không thể thiếu đối với sự sinh trưởng phát triển của thanh thiếu niên.', 'basic', 1),
      (v_id, '现代重症临床医学全面引入个性化微量营养元素代谢动态监测，依托全合一肠内营养乳剂精准维护重大创伤术后患者的免疫屏障功能。', 'Xiàndài zhòngzhèng línchuáng yīxué quánmiàn yǐnrù gèxìnghuà wēiliàng yíngyǎng yuánsù dàixiè dòngtài jiāncè, yītuō quán-hé-yī chángnèi yíngyǎng rǔjì jīngzhǔn wéihù zhòngdà chuāngshāng shùhòu huànzhě de miǎnyì píngzhàng gōngnéng.', 'Y học lâm sàng hồi sức tích cực hiện đại đưa vào toàn diện việc giám sát động thái chuyển hóa các nguyên tố vi lượng dinh dưỡng cá nhân hóa, dựa vào nhũ dịch dinh dưỡng qua đường ruột "tất cả trong một" để duy trì chuẩn xác chức năng hàng rào miễn dịch của bệnh nhân sau phẫu thuật chấn thương trọng đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3381] [营业] (yíngyè) - kinh doanh, buôn bán; mở cửa hoạt động [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '营业' AND pinyin = 'yíngyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '营业' AND pinyin = 'yíngyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '营业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '营业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yíngyè',
      meaning_vi = 'kinh doanh, buôn bán; mở cửa hoạt động',
      example_hanzi = '这家坐落在市中心核心商业街区的大型二十四小时书店全年无休正常营业，为都市夜读人群提供了温馨的精神驿站。',
      example_pinyin = 'Zhè jiā zuòluò zài shìzhōngxīn héxīn shāngyè jiēqū de dàxíng èrshísì xiǎoshí shūdiàn quánnián wúxiū zhèngcháng yíngyè, wèi dūshì yèdú rénqún tígōng le wēnxīn de jīngshén yìzhàn.',
      example_vi = 'Hiệu sách 24 giờ quy mô lớn tọa lạc tại khu phố thương mại cốt lõi trung tâm thành phố mở cửa kinh doanh bình thường không ngày nghỉ suốt cả năm, mang lại một trạm dừng chân tinh thần ấm cúng cho những người đọc sách đêm nơi đô thị.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '营业',
      'yíngyè',
      'kinh doanh, buôn bán; mở cửa hoạt động',
      'Động từ / Danh từ',
      'HSK 5',
      '这家坐落在市中心核心商业街区的大型二十四小时书店全年无休正常营业，为都市夜读人群提供了温馨的精神驿站。',
      'Zhè jiā zuòluò zài shìzhōngxīn héxīn shāngyè jiēqū de dàxíng èrshísì xiǎoshí shūdiàn quánnián wúxiū zhèngcháng yíngyè, wèi dūshì yèdú rénqún tígōng le wēnxīn de jīngshén yìzhàn.',
      'Hiệu sách 24 giờ quy mô lớn tọa lạc tại khu phố thương mại cốt lõi trung tâm thành phố mở cửa kinh doanh bình thường không ngày nghỉ suốt cả năm, mang lại một trạm dừng chân tinh thần ấm cúng cho những người đọc sách đêm nơi đô thị.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家坐落在市中心核心商业街区的大型二十四小时书店全年无休正常营业，为都市夜读人群提供了温馨的精神驿站。', 'Zhè jiā zuòluò zài shìzhōngxīn héxīn shāngyè jiēqū de dàxíng èrshísì xiǎoshí shūdiàn quánnián wúxiū zhèngcháng yíngyè, wèi dūshì yèdú rénqún tígōng le wēnxīn de jīngshén yìzhàn.', 'Hiệu sách 24 giờ quy mô lớn tọa lạc tại khu phố thương mại cốt lõi trung tâm thành phố mở cửa kinh doanh bình thường không ngày nghỉ suốt cả năm, mang lại một trạm dừng chân tinh thần ấm cúng cho những người đọc sách đêm nơi đô thị.', 'basic', 1),
      (v_id, '商业银行在严守风险审慎监管红线的前提下，积极拓展离岸跨国跨境贸易结算中心与人民币资本项下自营营业网点。', 'Shāngyè yínháng zài yánshǒu fēngxiǎn shěnshèn jiānguǎn hóngxiàn de qiántí xià, jījí tuòzhǎn lí’àn kuàguó kuàjìng màoyì jiésuàn zhōngxīn yǔ rénmínbì zīběn xiàngxià zìyíng yíngyè wǎngdiǎn.', 'Các ngân hàng thương mại dưới tiền đề tuân thủ nghiêm ngặt ranh giới đỏ quản lý giám sát thận trọng rủi ro đã tích cực mở rộng các trung tâm thanh toán thương mại xuyên biên giới đa quốc gia ngoài khơi và các điểm mạng lưới mở cửa hoạt động tự doanh dưới hạng mục vốn nhân dân tệ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3382] [影片] (yǐngpiàn) - bộ phim, cuốn phim [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '影片' AND pinyin = 'yǐngpiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '影片' AND pinyin = 'yǐngpiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '影片'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '影片'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǐngpiàn',
      meaning_vi = 'bộ phim, cuốn phim',
      example_hanzi = '这部在国际知名电影节上荣获最佳导演金奖的纪实故事影片，以其极其朴素真挚的情感表达深深打动了全场观众。',
      example_pinyin = 'Zhè bù zài guójì zhīmíng diànyǐngjié shàng rónghuò zuìjiā dǎoyǎn jīnjiǎng de jìshí gùshì yǐngpiàn, yǐ qí jíqí pǔsù zhēnzhì de qínggǎn biǎodá shēnshēn dǎdòng le quánchǎng guānzhòng.',
      example_vi = 'Bộ phim truyện mang tính hiện thực tài liệu đoạt giải vàng đạo diễn xuất sắc nhất tại liên hoan phim quốc tế nổi tiếng này bằng sự biểu đạt cảm xúc chân thành vô cùng mộc mạc đã làm lay động sâu sắc toàn thể khán giả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '影片',
      'yǐngpiàn',
      'bộ phim, cuốn phim',
      'Danh từ',
      'HSK 5',
      '这部在国际知名电影节上荣获最佳导演金奖的纪实故事影片，以其极其朴素真挚的情感表达深深打动了全场观众。',
      'Zhè bù zài guójì zhīmíng diànyǐngjié shàng rónghuò zuìjiā dǎoyǎn jīnjiǎng de jìshí gùshì yǐngpiàn, yǐ qí jíqí pǔsù zhēnzhì de qínggǎn biǎodá shēnshēn dǎdòng le quánchǎng guānzhòng.',
      'Bộ phim truyện mang tính hiện thực tài liệu đoạt giải vàng đạo diễn xuất sắc nhất tại liên hoan phim quốc tế nổi tiếng này bằng sự biểu đạt cảm xúc chân thành vô cùng mộc mạc đã làm lay động sâu sắc toàn thể khán giả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这部在国际知名电影节上荣获最佳导演金奖的纪实故事影片，以其极其朴素真挚的情感表达深深打动了全场观众。', 'Zhè bù zài guójì zhīmíng diànyǐngjié shàng rónghuò zuìjiā dǎoyǎn jīnjiǎng de jìshí gùshì yǐngpiàn, yǐ qí jíqí pǔsù zhēnzhì de qínggǎn biǎodá shēnshēn dǎdòng le quánchǎng guānzhòng.', 'Bộ phim truyện mang tính hiện thực tài liệu đoạt giải vàng đạo diễn xuất sắc nhất tại liên hoan phim quốc tế nổi tiếng này bằng sự biểu đạt cảm xúc chân thành vô cùng mộc mạc đã làm lay động sâu sắc toàn thể khán giả.', 'basic', 1),
      (v_id, '国家级数字影视科技产业基地全面采用环幕虚拟LED实时渲染摄制系统，大幅缩短了超写实科幻视效巨制史诗影片的拍摄周期与制作成本。', 'Guójiājí shùzì yǐngshì kējì chǎnyè jīdì quánmiàn cǎiyòng huánmù xūnǐ LED shíshí xuànrǎn shèzhì xìtǒng, dàfú suōduǎn le chāo-xiěshí kēhuàn shìxiào jùzhì shǐshī yǐngpiàn de pāishè zhōuqī yǔ zhìzuò chéngběn.', 'Khu căn cứ công nghiệp công nghệ điện ảnh truyền hình số cấp quốc gia áp dụng toàn diện hệ thống quay phim kết xuất hình ảnh thời gian thực LED ảo màn hình vòm, rút ngắn rất lớn chu kỳ quay và chi phí sản xuất của các bộ phim sử thi bom tấn hiệu ứng thị giác khoa học viễn tưởng siêu tả thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3383] [影视] (yǐngshì) - điện ảnh và truyền hình, phim ảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '影视' AND pinyin = 'yǐngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '影视' AND pinyin = 'yǐngshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '影视'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '影视'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǐngshì',
      meaning_vi = 'điện ảnh và truyền hình, phim ảnh',
      example_hanzi = '他从小就对动漫造型与影视后期特效合成表现出浓厚兴趣，大学毕业后顺利进入了一家业内领先的影视科技公司。',
      example_pinyin = 'Tā cóngxiǎo jiù duì dòngmàn zàoxíng yǔ yǐngshì hòuqī tèxiào héchéng biǎoxiàn chū nónghòu xìngqù, dàxué bìyè hòu shùnlì jìnrù le yī jiā yènèi lǐngxiān de yǐngshì kējì gōngsī.',
      example_vi = 'Từ nhỏ cậu ấy đã thể hiện niềm hứng thú sâu sắc với việc tạo hình hoạt hình và kỹ xảo hậu kỳ phim ảnh, sau khi tốt nghiệp đại học đã thuận lợi bước vào một công ty công nghệ điện ảnh truyền hình hàng đầu trong ngành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '影视',
      'yǐngshì',
      'điện ảnh và truyền hình, phim ảnh',
      'Danh từ',
      'HSK 5',
      '他从小就对动漫造型与影视后期特效合成表现出浓厚兴趣，大学毕业后顺利进入了一家业内领先的影视科技公司。',
      'Tā cóngxiǎo jiù duì dòngmàn zàoxíng yǔ yǐngshì hòuqī tèxiào héchéng biǎoxiàn chū nónghòu xìngqù, dàxué bìyè hòu shùnlì jìnrù le yī jiā yènèi lǐngxiān de yǐngshì kējì gōngsī.',
      'Từ nhỏ cậu ấy đã thể hiện niềm hứng thú sâu sắc với việc tạo hình hoạt hình và kỹ xảo hậu kỳ phim ảnh, sau khi tốt nghiệp đại học đã thuận lợi bước vào một công ty công nghệ điện ảnh truyền hình hàng đầu trong ngành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他从小就对动漫造型与影视后期特效合成表现出浓厚兴趣，大学毕业后顺利进入了一家业内领先的影视科技公司。', 'Tā cóngxiǎo jiù duì dòngmàn zàoxíng yǔ yǐngshì hòuqī tèxiào héchéng biǎoxiàn chū nónghòu xìngqù, dàxué bìyè hòu shùnlì jìnrù le yī jiā yènèi lǐngxiān de yǐngshì kējì gōngsī.', 'Từ nhỏ cậu ấy đã thể hiện niềm hứng thú sâu sắc với việc tạo hình hoạt hình và kỹ xảo hậu kỳ phim ảnh, sau khi tốt nghiệp đại học đã thuận lợi bước vào một công ty công nghệ điện ảnh truyền hình hàng đầu trong ngành.', 'basic', 1),
      (v_id, '国家广播电视与电影主管部门统筹推进现代影视文化精品创作工程，打造多部思想精深、艺术精湛的优秀影视巨作并在海外引发观影热潮。', 'Guójiā guǎngbō diànshì yǔ diànyǐng zhǔguǎn bùmén tǒngchóu tuījìn xiàndài yǐngshì wénhuà jīngpǐn chuàngzuò gōngchéng, dǎzào duō bù sīxiǎng jīngshēn, yìshù jīngzhàn de yōuxiù yǐngshì jùzuò bìng zài hǎiwài yǐnfā guānyǐng rècháo.', 'Cơ quan chủ quản phát thanh truyền hình và điện ảnh quốc gia điều phối thúc đẩy công trình sáng tác tác phẩm tinh hoa văn hóa phim ảnh hiện đại, tạo nên nhiều kiệt tác điện ảnh truyền hình ưu tú có tư tưởng sâu sắc, nghệ thuật tinh xảo và tạo nên làn sóng hâm mộ xem phim tại hải ngoại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3384] [硬] (yìng) - cứng, rắn; gượng gạo, bướng [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '硬' AND pinyin = 'yìng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '硬' AND pinyin = 'yìng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '硬'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '硬'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'yìng',
      meaning_vi = 'cứng, rắn; gượng gạo, bướng',
      example_hanzi = '这种深海天然金刚石的矿物硬度极高，即便用高强度的硬质合金刀具在其表面刻画，也留不下一丝细微划痕。',
      example_pinyin = 'Zhè zhǒng shēnhǎi tiānrán jīngāngshí de kuàngwù yìngdù jí gāo, jíbiàn yòng gāoqiángdù de yìngzhì héjīn dāojù zài qí biǎomiàn kèhuà, yě liú bù xià yī sī xìwēi huàhén.',
      example_vi = 'Độ cứng khoáng vật của loại kim cương tự nhiên biển sâu này cực kỳ cao, cho dù dùng dao cắt hợp kim cứng cường độ cao rạch lên bề mặt của nó cũng không để lại một vệt xước nhỏ nào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '硬',
      'yìng',
      'cứng, rắn; gượng gạo, bướng',
      'Tính từ / Phó từ',
      'HSK 5',
      '这种深海天然金刚石的矿物硬度极高，即便用高强度的硬质合金刀具在其表面刻画，也留不下一丝细微划痕。',
      'Zhè zhǒng shēnhǎi tiānrán jīngāngshí de kuàngwù yìngdù jí gāo, jíbiàn yòng gāoqiángdù de yìngzhì héjīn dāojù zài qí biǎomiàn kèhuà, yě liú bù xià yī sī xìwēi huàhén.',
      'Độ cứng khoáng vật của loại kim cương tự nhiên biển sâu này cực kỳ cao, cho dù dùng dao cắt hợp kim cứng cường độ cao rạch lên bề mặt của nó cũng không để lại một vệt xước nhỏ nào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这种深海天然金刚石的矿物硬度极高，即便用高强度的硬质合金刀具在其表面刻画，也留不下一丝细微划痕。', 'Zhè zhǒng shēnhǎi tiānrán jīngāngshí de kuàngwù yìngdù jí gāo, jíbiàn yòng gāoqiángdù de yìngzhì héjīn dāojù zài qí biǎomiàn kèhuà, yě liú bù xià yī sī xìwēi huàhén.', 'Độ cứng khoáng vật của loại kim cương tự nhiên biển sâu này cực kỳ cao, cho dù dùng dao cắt hợp kim cứng cường độ cao rạch lên bề mặt của nó cũng không để lại một vệt xước nhỏ nào.', 'basic', 1),
      (v_id, '深地万米极深井油气钻探工具采用微纳级碳化钨基超硬复合材料，有效解决了在极端高压坚硬地层钻进过程中的截齿剧烈磨损难题。', 'Shēndì wàn mǐ jíshēnjǐng yóuqì zuāntàn gōngjù cǎiyòng wēinàjí tànhuàwū jī chāoyìng fùhé cáiliào, yǒuxiào jiějué le zài jíduān gāoyā jiānyìng dìcéng zuānjìn guòchéng zhōng de jiécǐ jùliè mósǔn nántí.', 'Dụng cụ khoan thăm dò dầu khí giếng cực sâu vạn mét trong lòng đất sử dụng vật liệu composite siêu cứng gốc cacbua vonfram cấp vi nanomet, đã giải quyết hiệu quả bài toán khó về sự mài mòn răng cắt dữ dội trong quá trình khoan xuyên qua các tầng địa chất rắn đanh áp suất cực hạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3385] [应对] (yìngduì) - ứng phó, đối phó, đối đãi, xử lý [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '应对' AND pinyin = 'yìngduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '应对' AND pinyin = 'yìngduì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '应对'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '应对'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yìngduì',
      meaning_vi = 'ứng phó, đối phó, đối đãi, xử lý',
      example_hanzi = '日常生活中遇到突发停电停水或恶劣极端大风暴雨时，大家切勿慌乱失措，应当冷静沉着地积极寻找对策妥善应对。',
      example_pinyin = 'Rìcháng shēnghuó zhōng yù dào tūfā tíngdiàn tíngshuǐ huò èliè jíduān dàfēng bàoyǔ shí, dàjiā qièwù huāngluàn-shīcuò, yīngdāng lěngjìng chénzhuó de jījí xúnzhǎo duìcè tuǒshàn yìngduì.',
      example_vi = 'Trong cuộc sống hàng ngày khi gặp sự cố mất điện mất nước đột ngột hay mưa bão gió giật cực đoan dữ dội, mọi người đừng bao giờ hoảng loạn luống cuống, mà cần bình tĩnh điềm đạm tích cực tìm kiếm đối sách để ứng phó ổn thỏa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '应对',
      'yìngduì',
      'ứng phó, đối phó, đối đãi, xử lý',
      'Động từ',
      'HSK 5',
      '日常生活中遇到突发停电停水或恶劣极端大风暴雨时，大家切勿慌乱失措，应当冷静沉着地积极寻找对策妥善应对。',
      'Rìcháng shēnghuó zhōng yù dào tūfā tíngdiàn tíngshuǐ huò èliè jíduān dàfēng bàoyǔ shí, dàjiā qièwù huāngluàn-shīcuò, yīngdāng lěngjìng chénzhuó de jījí xúnzhǎo duìcè tuǒshàn yìngduì.',
      'Trong cuộc sống hàng ngày khi gặp sự cố mất điện mất nước đột ngột hay mưa bão gió giật cực đoan dữ dội, mọi người đừng bao giờ hoảng loạn luống cuống, mà cần bình tĩnh điềm đạm tích cực tìm kiếm đối sách để ứng phó ổn thỏa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '日常生活中遇到突发停电停水或恶劣极端大风暴雨时，大家切勿慌乱失措，应当冷静沉着地积极寻找对策妥善应对。', 'Rìcháng shēnghuó zhōng yù dào tūfā tíngdiàn tíngshuǐ huò èliè jíduān dàfēng bàoyǔ shí, dàjiā qièwù huāngluàn-shīcuò, yīngdāng lěngjìng chénzhuó de jījí xúnzhǎo duìcè tuǒshàn yìngduì.', 'Trong cuộc sống hàng ngày khi gặp sự cố mất điện mất nước đột ngột hay mưa bão gió giật cực đoan dữ dội, mọi người đừng bao giờ hoảng loạn luống cuống, mà cần bình tĩnh điềm đạm tích cực tìm kiếm đối sách để ứng phó ổn thỏa.', 'basic', 1),
      (v_id, '宏观经济政策调控部门不断充实和完善跨周期与逆周期调节储备政策工具箱，以充足的战略定力从容应对复杂严峻的外部冲击。', 'Hóngguān jīngjì zhèngcè tiáokòng bùmén bùduàn chōngshí hé wánshàn kuà-zhōuqī yǔ nì-zhōuqī tiáojié chǔbèi zhèngcè gōngjùxiāng, yǐ chōngzú de zhànlüè dìnglì cóngróng yìngduì fùzá yánjùn de wàibù chōngjī.', 'Bộ phận điều tiết chính sách kinh tế vĩ mô không ngừng bổ sung và hoàn thiện hộp công cụ chính sách dự phòng điều tiết nghịch chu kỳ và liên chu kỳ, bằng định lực chiến lược dồi dào ung dung ứng phó với những cú sốc gay gắt phức tạp từ bên ngoài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3386] [硬件] (yìngjiàn) - phần cứng (thiết bị máy tính, cơ sở vật chất) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '硬件' AND pinyin = 'yìngjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '硬件' AND pinyin = 'yìngjiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '硬件'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '硬件'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yìngjiàn',
      meaning_vi = 'phần cứng (thiết bị máy tính, cơ sở vật chất)',
      example_hanzi = '这台最新款图形图像处理专业电脑不仅机箱散热性能极佳，而且内部显卡与中央处理器等核心硬件配置十分强大。',
      example_pinyin = 'Zhè tái zuìxīn kuǎn túxíng túxiàng chǔlǐ zhuānyè diànnǎo bùjǐn jīxiāng sànrè xìngnéng jí jiā, érqiě nèibù xiǎnkǎ yǔ zhōngyāng chǔlǐqì děng héxīn yìngjiàn pèizhì shífēn qiángdà.',
      example_vi = 'Chiếc máy tính chuyên dụng xử lý đồ họa hình ảnh đời mới nhất này không chỉ có hiệu năng tản nhiệt vỏ máy cực tốt mà cấu hình phần cứng cốt lõi như card màn hình và bộ xử lý trung tâm bên trong cũng vô cùng mạnh mẽ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '硬件',
      'yìngjiàn',
      'phần cứng (thiết bị máy tính, cơ sở vật chất)',
      'Danh từ',
      'HSK 5',
      '这台最新款图形图像处理专业电脑不仅机箱散热性能极佳，而且内部显卡与中央处理器等核心硬件配置十分强大。',
      'Zhè tái zuìxīn kuǎn túxíng túxiàng chǔlǐ zhuānyè diànnǎo bùjǐn jīxiāng sànrè xìngnéng jí jiā, érqiě nèibù xiǎnkǎ yǔ zhōngyāng chǔlǐqì děng héxīn yìngjiàn pèizhì shífēn qiángdà.',
      'Chiếc máy tính chuyên dụng xử lý đồ họa hình ảnh đời mới nhất này không chỉ có hiệu năng tản nhiệt vỏ máy cực tốt mà cấu hình phần cứng cốt lõi như card màn hình và bộ xử lý trung tâm bên trong cũng vô cùng mạnh mẽ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这台最新款图形图像处理专业电脑不仅机箱散热性能极佳，而且内部显卡与中央处理器等核心硬件配置十分强大。', 'Zhè tái zuìxīn kuǎn túxíng túxiàng chǔlǐ zhuānyè diànnǎo bùjǐn jīxiāng sànrè xìngnéng jí jiā, érqiě nèibù xiǎnkǎ yǔ zhōngyāng chǔlǐqì děng héxīn yìngjiàn pèizhì shífēn qiángdà.', 'Chiếc máy tính chuyên dụng xử lý đồ họa hình ảnh đời mới nhất này không chỉ có hiệu năng tản nhiệt vỏ máy cực tốt mà cấu hình phần cứng cốt lõi như card màn hình và bộ xử lý trung tâm bên trong cũng vô cùng mạnh mẽ.', 'basic', 1),
      (v_id, '全面构建国家战略级人工智能安全算力底座，既要全力突破高性能通用GPU硬件芯片制造工艺，又要打造原生协同的底层异构编译软件生态。', 'Quánmiàn gòujiàn guójiā zhànlüèjí réngōng zhìnéng ānquán suànlì dǐzuò, jì yào quánlì tūpò gāoxìngnéng tōngyòng GPU yìngjiàn xīnpiàn zhìzào gōngyì, yòu yào dǎzào yuánshēng xiétóng de dǐcéng yìgòu biānyì ruǎnjiàn shēngtài.', 'Xây dựng toàn diện nền tảng sức mạnh tính toán an toàn trí tuệ nhân tạo cấp chiến lược quốc gia, vừa phải dốc toàn lực đột phá quy trình chế tạo chip phần cứng GPU đa năng hiệu năng cao, lại vừa phải tạo dựng hệ sinh thái phần mềm biên dịch dị cấu tầng đáy phối hợp nguyên bản.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3387] [应用] (yìngyòng) - ứng dụng; áp dụng, mang tính ứng dụng [Động từ / Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '应用' AND pinyin = 'yìngyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '应用' AND pinyin = 'yìngyòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '应用'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '应用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ / Tính từ',
      pinyin = 'yìngyòng',
      meaning_vi = 'ứng dụng; áp dụng, mang tính ứng dụng',
      example_hanzi = '掌握一门实用的外语不仅在日常跨文化交流中大有裨益，还能在未来的科研文献查阅与国际贸易中获得极其广泛的应用。',
      example_pinyin = 'Zhǎngwò yī mén shíyòng de wàiyǔ bùjǐn zài rìcháng kuà-wénhuà jiāoliú zhōng dàyǒu-bìyì, hái néng zài wèilái de kēyán wénxiàn cháyuè yǔ guójì màoyì zhōng huòdé jíqí guǎngfàn de yìngyòng.',
      example_vi = 'Nắm vững một ngoại ngữ thực dụng không chỉ đem lại lợi ích to lớn trong giao lưu xuyên văn hóa hàng ngày, mà còn có thể được ứng dụng vô cùng rộng rãi trong việc tra cứu tài liệu nghiên cứu khoa học và thương mại quốc tế trong tương lai.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '应用',
      'yìngyòng',
      'ứng dụng; áp dụng, mang tính ứng dụng',
      'Động từ / Danh từ / Tính từ',
      'HSK 5',
      '掌握一门实用的外语不仅在日常跨文化交流中大有裨益，还能在未来的科研文献查阅与国际贸易中获得极其广泛的应用。',
      'Zhǎngwò yī mén shíyòng de wàiyǔ bùjǐn zài rìcháng kuà-wénhuà jiāoliú zhōng dàyǒu-bìyì, hái néng zài wèilái de kēyán wénxiàn cháyuè yǔ guójì màoyì zhōng huòdé jíqí guǎngfàn de yìngyòng.',
      'Nắm vững một ngoại ngữ thực dụng không chỉ đem lại lợi ích to lớn trong giao lưu xuyên văn hóa hàng ngày, mà còn có thể được ứng dụng vô cùng rộng rãi trong việc tra cứu tài liệu nghiên cứu khoa học và thương mại quốc tế trong tương lai.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '掌握一门实用的外语不仅在日常跨文化交流中大有裨益，还能在未来的科研文献查阅与国际贸易中获得极其广泛的应用。', 'Zhǎngwò yī mén shíyòng de wàiyǔ bùjǐn zài rìcháng kuà-wénhuà jiāoliú zhōng dàyǒu-bìyì, hái néng zài wèilái de kēyán wénxiàn cháyuè yǔ guójì màoyì zhōng huòdé jíqí guǎngfàn de yìngyòng.', 'Nắm vững một ngoại ngữ thực dụng không chỉ đem lại lợi ích to lớn trong giao lưu xuyên văn hóa hàng ngày, mà còn có thể được ứng dụng vô cùng rộng rãi trong việc tra cứu tài liệu nghiên cứu khoa học và thương mại quốc tế trong tương lai.', 'basic', 1),
      (v_id, '国家大力推进大语言模型、空间计算与具身智能技术在前沿制造工业生产线中的深度融合应用，全面加速传统产业数智化重塑。', 'Guójiā dàlì tuījìn dà yǔyán móxíng, kōngjiān jìsuàn yǔ jùshēn zhìnéng jìshù zài qiányán zhìzào gōngyè shēngchǎnxiàn zhōng de shēndù rónghé yìngyòng, quánmiàn jiāsù chuántǒng chǎnyè shùzhìhuà chóngsù.', 'Nhà nước đẩy mạnh việc ứng dụng tích hợp sâu sắc mô hình ngôn ngữ lớn, tính toán không gian và công nghệ trí tuệ hiện thân trên các dây chuyền sản xuất công nghiệp chế tạo tiền duyên, tăng tốc toàn diện sự tái cấu trúc số hóa thông minh của các ngành công nghiệp truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3388] [拥抱] (yōngbào) - ôm, ôm chặt, đón nhận; vòng tay ôm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '拥抱' AND pinyin = 'yōngbào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拥抱' AND pinyin = 'yōngbào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '拥抱'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拥抱'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'yōngbào',
      meaning_vi = 'ôm, ôm chặt, đón nhận; vòng tay ôm',
      example_hanzi = '火车站出站闸机口处，阔别三年的母子俩紧紧拥抱在一起，眼眶中闪烁着幸福而激动的喜悦泪花。',
      example_pinyin = 'Huǒchēzhàn chūzhàn zhájīkǒu chù, kuòbié sān nián de mǔ-zǐ liǎ jǐnjǐn yōngbào zài yīqǐ, yǎnkuàng zhōng shǎnshuò zhe xìngfú ér jīdòng de xǐyuè lèihuā.',
      example_vi = 'Tại cửa soát vé ra ga xe lửa, hai mẹ con xa cách ba năm trời ôm chầm lấy nhau thật chặt, nơi khóe mắt lấp lánh những giọt lệ vui mừng hạnh phúc và nghẹn ngào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '拥抱',
      'yōngbào',
      'ôm, ôm chặt, đón nhận; vòng tay ôm',
      'Động từ / Danh từ',
      'HSK 5',
      '火车站出站闸机口处，阔别三年的母子俩紧紧拥抱在一起，眼眶中闪烁着幸福而激动的喜悦泪花。',
      'Huǒchēzhàn chūzhàn zhájīkǒu chù, kuòbié sān nián de mǔ-zǐ liǎ jǐnjǐn yōngbào zài yīqǐ, yǎnkuàng zhōng shǎnshuò zhe xìngfú ér jīdòng de xǐyuè lèihuā.',
      'Tại cửa soát vé ra ga xe lửa, hai mẹ con xa cách ba năm trời ôm chầm lấy nhau thật chặt, nơi khóe mắt lấp lánh những giọt lệ vui mừng hạnh phúc và nghẹn ngào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '火车站出站闸机口处，阔别三年的母子俩紧紧拥抱在一起，眼眶中闪烁着幸福而激动的喜悦泪花。', 'Huǒchēzhàn chūzhàn zhájīkǒu chù, kuòbié sān nián de mǔ-zǐ liǎ jǐnjǐn yōngbào zài yīqǐ, yǎnkuàng zhōng shǎnshuò zhe xìngfú ér jīdòng de xǐyuè lèihuā.', 'Tại cửa soát vé ra ga xe lửa, hai mẹ con xa cách ba năm trời ôm chầm lấy nhau thật chặt, nơi khóe mắt lấp lánh những giọt lệ vui mừng hạnh phúc và nghẹn ngào.', 'basic', 1),
      (v_id, '在通用人工智能深刻重塑全球实体产业链的关键历史风口，传统高耗能重工业领军企业必须破除路径依赖，以开放魄力主动拥抱全域绿色低碳转型。', 'Zài tōngyòng réngōng zhìnéng shēnkè chóngsù quánqiú shítǐ chǎnyèliàn de guānjiàn lìshǐ fēngkǒu, chuántǒng gāo-hàonéng zhònggōngyè lǐngjūn qǐyè bìxū pòchú lùjìng yīlài, yǐ kāifàng pòlì zhǔdòng yōngbào quányù lǜsè dītàn zhuǎnxíng.', 'Tại điểm bùng nổ lịch sử then chốt khi AI đa năng tái định hình sâu sắc chuỗi công nghiệp thực thể toàn cầu, các doanh nghiệp đầu ngành công nghiệp nặng tiêu hao nhiều năng lượng truyền thống bắt buộc phải phá bỏ sự phụ thuộc lối mòn, bằng dũng khí cởi mở chủ động đón nhận sự chuyển đổi xanh các-bon thấp trên toàn diện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3389] [拥有] (yōngyǒu) - sở hữu, có được, nắm giữ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '拥有' AND pinyin = 'yōngyǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拥有' AND pinyin = 'yōngyǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '拥有'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '拥有'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yōngyǒu',
      meaning_vi = 'sở hữu, có được, nắm giữ',
      example_hanzi = '这座有着两千多年历史的古城拥有众多保存完好的明清古代建筑群与国家级非物质文化遗产。',
      example_pinyin = 'Zhè zuò yǒu zhe liǎng qiān duō nián lìshǐ de gǔchéng yōngyǒu zhòngduō bǎocún wánhǎo de Míng-Qīng gǔdài jiànzhùqún yǔ guójiājí fēiwùzhì wénhuà yíchǎn.',
      example_vi = 'Cổ thành có bề dày hơn hai nghìn năm lịch sử này sở hữu rất nhiều quần thể kiến trúc cổ đại thời Minh Thanh được bảo tồn nguyên vẹn cùng các di sản văn hóa phi vật thể cấp quốc gia.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '拥有',
      'yōngyǒu',
      'sở hữu, có được, nắm giữ',
      'Động từ',
      'HSK 5',
      '这座有着两千多年历史的古城拥有众多保存完好的明清古代建筑群与国家级非物质文化遗产。',
      'Zhè zuò yǒu zhe liǎng qiān duō nián lìshǐ de gǔchéng yōngyǒu zhòngduō bǎocún wánhǎo de Míng-Qīng gǔdài jiànzhùqún yǔ guójiājí fēiwùzhì wénhuà yíchǎn.',
      'Cổ thành có bề dày hơn hai nghìn năm lịch sử này sở hữu rất nhiều quần thể kiến trúc cổ đại thời Minh Thanh được bảo tồn nguyên vẹn cùng các di sản văn hóa phi vật thể cấp quốc gia.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这座有着两千多年历史的古城拥有众多保存完好的明清古代建筑群与国家级非物质文化遗产。', 'Zhè zuò yǒu zhe liǎng qiān duō nián lìshǐ de gǔchéng yōngyǒu zhòngduō bǎocún wánhǎo de Míng-Qīng gǔdài jiànzhùqún yǔ guójiājí fēiwùzhì wénhuà yíchǎn.', 'Cổ thành có bề dày hơn hai nghìn năm lịch sử này sở hữu rất nhiều quần thể kiến trúc cổ đại thời Minh Thanh được bảo tồn nguyên vẹn cùng các di sản văn hóa phi vật thể cấp quốc gia.', 'basic', 1),
      (v_id, '我国拥有全球门类最齐全、产业配套最完备的制造业工业体系，在第四代核电与特高压柔性直流输电核心技术领域拥有毋庸置疑的国际话语权。', 'Wǒguó yōngyǒu quánqiú ménlèi zuì qíquán, chǎnyè pèitào zuì wánbèi de zhìzàoyè gōngyè tǐxì, zài dì-sì dài hédiàn yǔ tègāoyā róuxìng zhíliú shūdiàn héxīn jìshù lǐngyù yōngyǒu wúyōng-zhìyí de guójì huàyǔquán.', 'Nước ta sở hữu hệ thống công nghiệp chế tạo có đầy đủ danh mục nhất và chuỗi liên kết công nghiệp hoàn bị nhất toàn cầu, nắm giữ tiếng nói quốc tế không thể nghi ngờ trong lĩnh vực công nghệ cốt lõi điện hạt nhân thế hệ thứ 4 và truyền tải điện một chiều linh hoạt siêu cao thế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3390] [勇气] (yǒngqì) - dũng khí, lòng can đảm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '勇气' AND pinyin = 'yǒngqì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '勇气' AND pinyin = 'yǒngqì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '勇气'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '勇气'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yǒngqì',
      meaning_vi = 'dũng khí, lòng can đảm',
      example_hanzi = '在青春成长的道路上难免会遇到挫折与坎坷，我们要始终保持直面困难的勇气，永不轻言放弃。',
      example_pinyin = 'Zài qīngchūn chéngzhǎng de dàolù shàng nánmiǎn huì yù dào cuòzhé yǔ kǎnkě, wǒmen yào shǐzhōng bǎochí zhímiàn kùnnan de yǒngqì, yǒng bù qīngyán fàngqì.',
      example_vi = 'Trên con đường trưởng thành của tuổi trẻ khó tránh khỏi gặp phải những trắc trở gập ghềnh, chúng ta phải luôn giữ vững lòng dũng cảm đối diện thẳng thắn với khó khăn, vĩnh viễn không dễ dàng bỏ cuộc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '勇气',
      'yǒngqì',
      'dũng khí, lòng can đảm',
      'Danh từ',
      'HSK 5',
      '在青春成长的道路上难免会遇到挫折与坎坷，我们要始终保持直面困难的勇气，永不轻言放弃。',
      'Zài qīngchūn chéngzhǎng de dàolù shàng nánmiǎn huì yù dào cuòzhé yǔ kǎnkě, wǒmen yào shǐzhōng bǎochí zhímiàn kùnnan de yǒngqì, yǒng bù qīngyán fàngqì.',
      'Trên con đường trưởng thành của tuổi trẻ khó tránh khỏi gặp phải những trắc trở gập ghềnh, chúng ta phải luôn giữ vững lòng dũng cảm đối diện thẳng thắn với khó khăn, vĩnh viễn không dễ dàng bỏ cuộc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在青春成长的道路上难免会遇到挫折与坎坷，我们要始终保持直面困难的勇气，永不轻言放弃。', 'Zài qīngchūn chéngzhǎng de dàolù shàng nánmiǎn huì yù dào cuòzhé yǔ kǎnkě, wǒmen yào shǐzhōng bǎochí zhímiàn kùnnan de yǒngqì, yǒng bù qīngyán fàngqì.', 'Trên con đường trưởng thành của tuổi trẻ khó tránh khỏi gặp phải những trắc trở gập ghềnh, chúng ta phải luôn giữ vững lòng dũng cảm đối diện thẳng thắn với khó khăn, vĩnh viễn không dễ dàng bỏ cuộc.', 'basic', 1),
      (v_id, '敢于打破西方经典科学假说教条并勇闯基础理论“无人区”，展现出战略科学家敢为人先的学术胆识与开辟未知的非凡科学探索勇气。', 'Gǎnyú dǎpò Xīfāng jīngdiǎn kēxué jiǎshuō jiàotiáo bìng yǒng chuǎng jīchǔ lǐlùn “wúrénqū”, zhǎnxiàn chū zhànlüè kēxuéjiā gǎn-wéi-rén-xiān de xuéshù dǎnshí yǔ kāipì wèizhī de fēifán kēxué tànsuǒ yǒngqì.', 'Dám phá bỏ các giáo điều giả thuyết khoa học kinh điển phương Tây và dũng cảm xông pha vào "vùng đất trắng không bóng người" của lý thuyết nền tảng đã thể hiện bản lĩnh học thuật dám đi trước người khác của nhà khoa học chiến lược cùng lòng dũng cảm khám phá khoa học phi thường khai phá những điều chưa biết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3391] [用法] (yòngfǎ) - cách dùng, cách sử dụng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '用法' AND pinyin = 'yòngfǎ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用法' AND pinyin = 'yòngfǎ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '用法'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用法'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yòngfǎ',
      meaning_vi = 'cách dùng, cách sử dụng',
      example_hanzi = '购买智能家用电器之后，请务必在使用前仔细查阅产品说明书，熟悉各个功能按键的具体用法。',
      example_pinyin = 'Gòumǎi zhìnéng jiāyòng diànqì zhīhòu, qǐng wùbì zài shǐyòng qián zǐxì cháyuè chǎnpǐn shuōmíngshū, shúxī gègè gōngnéng ànjiàn de jùtǐ yòngfǎ.',
      example_vi = 'Sau khi mua đồ điện gia dụng thông minh, xin vui lòng đọc kỹ sách hướng dẫn sử dụng sản phẩm trước khi dùng, làm quen với cách dùng cụ thể của từng phím bấm chức năng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '用法',
      'yòngfǎ',
      'cách dùng, cách sử dụng',
      'Danh từ',
      'HSK 5',
      '购买智能家用电器之后，请务必在使用前仔细查阅产品说明书，熟悉各个功能按键的具体用法。',
      'Gòumǎi zhìnéng jiāyòng diànqì zhīhòu, qǐng wùbì zài shǐyòng qián zǐxì cháyuè chǎnpǐn shuōmíngshū, shúxī gègè gōngnéng ànjiàn de jùtǐ yòngfǎ.',
      'Sau khi mua đồ điện gia dụng thông minh, xin vui lòng đọc kỹ sách hướng dẫn sử dụng sản phẩm trước khi dùng, làm quen với cách dùng cụ thể của từng phím bấm chức năng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '购买智能家用电器之后，请务必在使用前仔细查阅产品说明书，熟悉各个功能按键的具体用法。', 'Gòumǎi zhìnéng jiāyòng diànqì zhīhòu, qǐng wùbì zài shǐyòng qián zǐxì cháyuè chǎnpǐn shuōmíngshū, shúxī gègè gōngnéng ànjiàn de jùtǐ yòngfǎ.', 'Sau khi mua đồ điện gia dụng thông minh, xin vui lòng đọc kỹ sách hướng dẫn sử dụng sản phẩm trước khi dùng, làm quen với cách dùng cụ thể của từng phím bấm chức năng.', 'basic', 1),
      (v_id, '临床专科医师与药剂专家在为危重症感染患者开具处方时，必须严格依据国家药典循证指引明确药品的配伍禁忌、给药途径与用法用量。', 'Línchuáng zhuānkē yīshī yǔ yàojì zhuānjiā zài wèi wēizhòngzhèng gǎnrǎn huànzhě kāijù chǔfāng shí, bìxū yángé yījù guójiā yàodiǎn xúnzhèng zhǐyǐn míngquè yàopǐn de pèiwǔ jìnjì, jǐyào tújìng yǔ yòngfǎ yòngliàng.', 'Bác sĩ chuyên khoa lâm sàng và chuyên gia dược sĩ khi kê đơn cho bệnh nhân nhiễm trùng nguy kịch bắt buộc phải căn cứ nghiêm ngặt vào các hướng dẫn y học chứng cứ của dược điển quốc gia để làm rõ tương kỵ phối ngũ, đường dùng thuốc cùng cách dùng liều lượng của thuốc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3392] [用户] (yònghù) - người dùng, khách hàng, thuê bao [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '用户' AND pinyin = 'yònghù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用户' AND pinyin = 'yònghù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '用户'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用户'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yònghù',
      meaning_vi = 'người dùng, khách hàng, thuê bao',
      example_hanzi = '这款移动办公软件凭借简洁直观的界面设计与流畅稳定的运行表现，赢得了海量用户的广泛好评。',
      example_pinyin = 'Zhè kuǎn yídòng bàngōng ruǎnjiàn píngjiè jiǎnjié zhíguān de jièmiàn shèjì yǔ liúchàng wěndìng de yùnxíng biǎoxiàn, yíngdé le hǎiliàng yònghù de guǎngfàn hǎopíng.',
      example_vi = 'Phần mềm văn phòng di động này nhờ vào thiết kế giao diện ngắn gọn trực quan và sự thể hiện vận hành mượt mà ổn định đã nhận được đánh giá tốt rộng khắp từ khối lượng người dùng khổng lồ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '用户',
      'yònghù',
      'người dùng, khách hàng, thuê bao',
      'Danh từ',
      'HSK 5',
      '这款移动办公软件凭借简洁直观的界面设计与流畅稳定的运行表现，赢得了海量用户的广泛好评。',
      'Zhè kuǎn yídòng bàngōng ruǎnjiàn píngjiè jiǎnjié zhíguān de jièmiàn shèjì yǔ liúchàng wěndìng de yùnxíng biǎoxiàn, yíngdé le hǎiliàng yònghù de guǎngfàn hǎopíng.',
      'Phần mềm văn phòng di động này nhờ vào thiết kế giao diện ngắn gọn trực quan và sự thể hiện vận hành mượt mà ổn định đã nhận được đánh giá tốt rộng khắp từ khối lượng người dùng khổng lồ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这款移动办公软件凭借简洁直观的界面设计与流畅稳定的运行表现，赢得了海量用户的广泛好评。', 'Zhè kuǎn yídòng bàngōng ruǎnjiàn píngjiè jiǎnjié zhíguān de jièmiàn shèjì yǔ liúchàng wěndìng de yùnxíng biǎoxiàn, yíngdé le hǎiliàng yònghù de guǎngfàn hǎopíng.', 'Phần mềm văn phòng di động này nhờ vào thiết kế giao diện ngắn gọn trực quan và sự thể hiện vận hành mượt mà ổn định đã nhận được đánh giá tốt rộng khắp từ khối lượng người dùng khổng lồ.', 'basic', 1),
      (v_id, '超大型云计算数据中心依托零信任架构与动态多因子生物认证机制，全方位筑牢超数亿移动互联网注册用户的核心敏感数据隐私防线。', 'Chāo-dàxíng yúnjìsuàn shùjù zhōngxīn yītuō líng-xìnrèn jiàgòu yǔ dòngtài duō-yīnzǐ shēngwù rènzhèng jīzhì, quán-fāngwèi zhù láo chāo shù yì yídòng hùliánwǎng zhùcè yònghù de héxīn mǐngǎn shùjù yǐnsī fángxiàn.', 'Trung tâm dữ liệu điện toán đám mây quy mô siêu lớn dựa vào kiến trúc Zero Trust và cơ chế xác thực sinh trắc học đa yếu tố động, xây đắp vững chãi toàn diện tuyến phòng thủ quyền riêng tư dữ liệu nhạy cảm cốt lõi của hơn hàng trăm triệu người dùng đăng ký internet di động.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3393] [用力] (yònglì) - dùng sức, gắng sức, phát lực [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '用力' AND pinyin = 'yònglì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用力' AND pinyin = 'yònglì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '用力'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用力'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'yònglì',
      meaning_vi = 'dùng sức, gắng sức, phát lực',
      example_hanzi = '在图书馆等安静的公共阅览室里出入时请轻轻关门，切勿用力过猛而发出刺耳的撞击声。',
      example_pinyin = 'Zài túshūguǎn děng ānjìng de gōnggòng yuèlǎnshì lǐ chūrù shí qǐng qīngqīng guānmén, qièwù yònglì guò měng ér fāchū cì’ěr de zhuàngjīshēng.',
      example_vi = 'Khi ra vào các phòng đọc công cộng yên tĩnh như thư viện xin hãy đóng cửa nhẹ nhàng, chớ dùng sức quá mạnh mà phát ra tiếng va đập chói tai.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '用力',
      'yònglì',
      'dùng sức, gắng sức, phát lực',
      'Động từ',
      'HSK 5',
      '在图书馆等安静的公共阅览室里出入时请轻轻关门，切勿用力过猛而发出刺耳的撞击声。',
      'Zài túshūguǎn děng ānjìng de gōnggòng yuèlǎnshì lǐ chūrù shí qǐng qīngqīng guānmén, qièwù yònglì guò měng ér fāchū cì’ěr de zhuàngjīshēng.',
      'Khi ra vào các phòng đọc công cộng yên tĩnh như thư viện xin hãy đóng cửa nhẹ nhàng, chớ dùng sức quá mạnh mà phát ra tiếng va đập chói tai.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在图书馆等安静的公共阅览室里出入时请轻轻关门，切勿用力过猛而发出刺耳的撞击声。', 'Zài túshūguǎn děng ānjìng de gōnggòng yuèlǎnshì lǐ chūrù shí qǐng qīngqīng guānmén, qièwù yònglì guò měng ér fāchū cì’ěr de zhuàngjīshēng.', 'Khi ra vào các phòng đọc công cộng yên tĩnh như thư viện xin hãy đóng cửa nhẹ nhàng, chớ dùng sức quá mạnh mà phát ra tiếng va đập chói tai.', 'basic', 1),
      (v_id, '深海万米作业型无人潜水器机械手依据末端六维触觉力传感器反馈数据，自主微调关节输出扭矩，确保在抓取脆性深海生物样本时平稳微度用力。', 'Shēnhǎi wàn mǐ zuòyèxíng wúrén qiánshuǐqì jīxièshǒu yījù mòduān liùwéi chùjué lì chuángǎnqì fǎnkuì shùjù, zìzhǔ wēitiáo guānjié shūchū niǔjù, quèbǎo zài zhuāqǔ cuìxìng shēnhǎi shēngwù yàngběn shí píngwěn wēidù yònglì.', 'Tay máy cơ học của tàu ngầm không người lái tác nghiệp ở độ sâu vạn mét dưới biển dựa trên dữ liệu phản hồi từ cảm biến lực xúc giác sáu chiều ở đầu ngón tay đã tự động vi chỉnh mô-men xoắn đầu ra của khớp, bảo đảm dùng lực nhẹ nhàng êm ái khi gắp các mẫu vật sinh vật biển sâu giòn dễ vỡ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3394] [用品] (yòngpǐn) - đồ dùng, vật dụng chuyên dùng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '用品' AND pinyin = 'yòngpǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用品' AND pinyin = 'yòngpǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '用品'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yòngpǐn',
      meaning_vi = 'đồ dùng, vật dụng chuyên dùng',
      example_hanzi = '出发前往高海拔雪山徒步探险之前，队员们务必全面清点随身携带的防寒装备与专业户外生存用品。',
      example_pinyin = 'Chūfā qiánwǎng gāohǎibá xuěshān túbù tànxiǎn zhīqián, duìyuánmen wùbì quánmiàn qīngdiǎn suíshēn xiédài de fánghán zhuāngbèi yǔ zhuānyè hùwài shēngcún yòngpǐn.',
      example_vi = 'Trước khi xuất phát đi bộ thám hiểm lên núi tuyết có độ cao lớn so với mặt nước biển, các đội viên nhất định phải kiểm tra kỹ càng toàn diện trang bị chống rét và đồ dùng sinh tồn ngoài trời chuyên nghiệp mang theo bên mình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '用品',
      'yòngpǐn',
      'đồ dùng, vật dụng chuyên dùng',
      'Danh từ',
      'HSK 5',
      '出发前往高海拔雪山徒步探险之前，队员们务必全面清点随身携带的防寒装备与专业户外生存用品。',
      'Chūfā qiánwǎng gāohǎibá xuěshān túbù tànxiǎn zhīqián, duìyuánmen wùbì quánmiàn qīngdiǎn suíshēn xiédài de fánghán zhuāngbèi yǔ zhuānyè hùwài shēngcún yòngpǐn.',
      'Trước khi xuất phát đi bộ thám hiểm lên núi tuyết có độ cao lớn so với mặt nước biển, các đội viên nhất định phải kiểm tra kỹ càng toàn diện trang bị chống rét và đồ dùng sinh tồn ngoài trời chuyên nghiệp mang theo bên mình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出发前往高海拔雪山徒步探险之前，队员们务必全面清点随身携带的防寒装备与专业户外生存用品。', 'Chūfā qiánwǎng gāohǎibá xuěshān túbù tànxiǎn zhīqián, duìyuánmen wùbì quánmiàn qīngdiǎn suíshēn xiédài de fánghán zhuāngbèi yǔ zhuānyè hùwài shēngcún yòngpǐn.', 'Trước khi xuất phát đi bộ thám hiểm lên núi tuyết có độ cao lớn so với mặt nước biển, các đội viên nhất định phải kiểm tra kỹ càng toàn diện trang bị chống rét và đồ dùng sinh tồn ngoài trời chuyên nghiệp mang theo bên mình.', 'basic', 1),
      (v_id, '面对人口老龄化国家战略需求，现代康复工程产业大力研发集成脑控轮椅、智能护理床以及认知康复训练系统等高端适老助残辅具用品。', 'Miànduì rénkǒu lǎolínghuà guójiā zhànlüè xūqiú, xiàndài kāngfù gōngchéng chǎnyè dàlì yánfā jíchéng nǎokòng lúnyǐ, zhìnéng hùlǐchuáng yǐjí rènzhī kāngfù xùnliàn xìtǒng děng gāoduān shìlǎo zhùcán fǔjù yòngpǐn.', 'Trước nhu cầu chiến lược quốc gia về già hóa dân số, ngành công nghiệp kỹ thuật phục hồi chức năng hiện đại đẩy mạnh nghiên cứu phát triển các vật dụng dụng cụ hỗ trợ cao cấp cho người cao tuổi và người khuyết tật tích hợp xe lăn điều khiển bằng sóng não, giường điều dưỡng thông minh cũng như hệ thống tập luyện phục hồi nhận thức.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3395] [用途] (yòngtú) - công dụng, mục đích sử dụng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '用途' AND pinyin = 'yòngtú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用途' AND pinyin = 'yòngtú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '用途'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '用途'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yòngtú',
      meaning_vi = 'công dụng, mục đích sử dụng',
      example_hanzi = '竹子在我国南方民间传统工艺中有着十分广泛的用途，既可以编织各种坚固耐用的生活器皿，也能用于建筑装饰。',
      example_pinyin = 'Zhúzi zài wǒguó nánfāng mínjiān chuántǒng gōngyì zhōng yǒu zhe shífēn guǎngfàn de yòngtú, jì kěyǐ biānzhī gè zhǒng jiāngù nàiyòng de shēnghuó qìmǐn, yě néng yòng yú jiànzhù zhuāngshì.',
      example_vi = 'Tre trúc trong các nghề thủ công truyền thống dân gian miền nam nước ta có công dụng vô cùng rộng rãi, vừa có thể đan lát đủ loại đồ dùng sinh hoạt bền chắc, lại vừa có thể dùng trong trang trí kiến trúc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '用途',
      'yòngtú',
      'công dụng, mục đích sử dụng',
      'Danh từ',
      'HSK 5',
      '竹子在我国南方民间传统工艺中有着十分广泛的用途，既可以编织各种坚固耐用的生活器皿，也能用于建筑装饰。',
      'Zhúzi zài wǒguó nánfāng mínjiān chuántǒng gōngyì zhōng yǒu zhe shífēn guǎngfàn de yòngtú, jì kěyǐ biānzhī gè zhǒng jiāngù nàiyòng de shēnghuó qìmǐn, yě néng yòng yú jiànzhù zhuāngshì.',
      'Tre trúc trong các nghề thủ công truyền thống dân gian miền nam nước ta có công dụng vô cùng rộng rãi, vừa có thể đan lát đủ loại đồ dùng sinh hoạt bền chắc, lại vừa có thể dùng trong trang trí kiến trúc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '竹子在我国南方民间传统工艺中有着十分广泛的用途，既可以编织各种坚固耐用的生活器皿，也能用于建筑装饰。', 'Zhúzi zài wǒguó nánfāng mínjiān chuántǒng gōngyì zhōng yǒu zhe shífēn guǎngfàn de yòngtú, jì kěyǐ biānzhī gè zhǒng jiāngù nàiyòng de shēnghuó qìmǐn, yě néng yòng yú jiànzhù zhuāngshì.', 'Tre trúc trong các nghề thủ công truyền thống dân gian miền nam nước ta có công dụng vô cùng rộng rãi, vừa có thể đan lát đủ loại đồ dùng sinh hoạt bền chắc, lại vừa có thể dùng trong trang trí kiến trúc.', 'basic', 1),
      (v_id, '超高纯度单晶碳化硅第三代宽禁带半导体材料具备耐高压、耐高温与高开关频率特性，在先进雷达发射机与电动汽车超充电源中具有无可替代的战略用途。', 'Chāogāochún dù dānjīng tànhuàguī dì-sān dài kuānjìndài bàndǎotǐ cáiliào jùbèi nài-gāoyā, nài-gāowēn yǔ gāo kāiguān pínglǜ xìngnéng, zài xiānjìn léidá fāshèjī yǔ diàndòng qìchē chāochōng diànyuán zhōng jùyǒu wúkětìdài de zhànlüè yòngtú.', 'Vật liệu bán dẫn vùng cấm rộng thế hệ thứ ba silic cacbua đơn tinh thể siêu tinh khiết sở hữu các đặc tính chịu điện áp cao, chịu nhiệt độ cao và tần số chuyển mạch cao, có công dụng chiến lược không thể thay thế trong máy phát radar tiên tiến và bộ nguồn sạc siêu nhanh của xe điện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3396] [优惠] (yōuhuì) - ưu đãi; giảm giá, khuyến mãi [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '优惠' AND pinyin = 'yōuhuì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优惠' AND pinyin = 'yōuhuì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '优惠'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优惠'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'yōuhuì',
      meaning_vi = 'ưu đãi; giảm giá, khuyến mãi',
      example_hanzi = '为了迎接新学期的到来，新华书店针对全国广大学生读者推出了全场教辅图书与文具八折的惠民优惠活动。',
      example_pinyin = 'Wèile yíngjiē xīn xuéqī de dàolái, Xīnhuá Shūdiàn zhènduì quánguó guǎngdà xuéshēng dúzhě tuīchū le quánchǎng jiàofǔ túshū yǔ wénjù bā zhé de huìmín yōuhuì huódòng.',
      example_vi = 'Để đón chào học kỳ mới tới, nhà sách Tân Hoa đã triển khai chương trình ưu đãi trợ giá giảm 20% toàn bộ sách tham khảo và văn phòng phẩm dành cho đông đảo bạn đọc học sinh trên cả nước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '优惠',
      'yōuhuì',
      'ưu đãi; giảm giá, khuyến mãi',
      'Tính từ / Danh từ',
      'HSK 5',
      '为了迎接新学期的到来，新华书店针对全国广大学生读者推出了全场教辅图书与文具八折的惠民优惠活动。',
      'Wèile yíngjiē xīn xuéqī de dàolái, Xīnhuá Shūdiàn zhènduì quánguó guǎngdà xuéshēng dúzhě tuīchū le quánchǎng jiàofǔ túshū yǔ wénjù bā zhé de huìmín yōuhuì huódòng.',
      'Để đón chào học kỳ mới tới, nhà sách Tân Hoa đã triển khai chương trình ưu đãi trợ giá giảm 20% toàn bộ sách tham khảo và văn phòng phẩm dành cho đông đảo bạn đọc học sinh trên cả nước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了迎接新学期的到来，新华书店针对全国广大学生读者推出了全场教辅图书与文具八折的惠民优惠活动。', 'Wèile yíngjiē xīn xuéqī de dàolái, Xīnhuá Shūdiàn zhènduì quánguó guǎngdà xuéshēng dúzhě tuīchū le quánchǎng jiàofǔ túshū yǔ wénjù bā zhé de huìmín yōuhuì huódòng.', 'Để đón chào học kỳ mới tới, nhà sách Tân Hoa đã triển khai chương trình ưu đãi trợ giá giảm 20% toàn bộ sách tham khảo và văn phòng phẩm dành cho đông đảo bạn đọc học sinh trên cả nước.', 'basic', 1),
      (v_id, '国家税务总局全面落实高新技术企业研发费用加计扣除与先进制造业增值税加计抵减税费优惠政策，实质性激发了高科技实体企业的创新活力。', 'Guójiā shuìwù zǒngjú quánmiàn luòshí gāoxīnjìshù qǐyè yánfā fèiyòng jiājì kòuchú yǔ xiānjìn zhìzàoyè zēngzhíshuì jiājì dǐjiǎn shuìfèi yōuhuì zhèngcè, shízhìxìng jīfā le gāokējì shítǐ qǐyè de chuàngxīn huólì.', 'Tổng cục Thuế Quốc gia thực thi toàn diện chính sách ưu đãi thuế phí về khấu trừ bổ sung chi phí R&D của doanh nghiệp công nghệ cao và khấu trừ tăng thêm thuế giá trị gia tăng ngành chế tạo tiên tiến, kích hoạt thực chất sức sống đổi mới sáng tạo của các doanh nghiệp thực thể công nghệ cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3397] [悠久] (yōujiǔ) - lâu đời, trường cửu, dài lâu [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '悠久' AND pinyin = 'yōujiǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '悠久' AND pinyin = 'yōujiǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '悠久'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '悠久'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yōujiǔ',
      meaning_vi = 'lâu đời, trường cửu, dài lâu',
      example_hanzi = '中华文明拥有五千多年绵延不绝的悠久历史，孕育了博大精深的传统哲学思想与璀璨绚丽的民族文化。',
      example_pinyin = 'Zhōnghuá wénmíng yōngyǒu wǔ qiān duō nián miányán-bùjué de yōujiǔ lìshǐ, yùnyù le bódà-jīngshēn de chuántǒng zhéxué sīxiǎng yǔ cuǐcàn-xuànlì de mínzú wénhuà.',
      example_vi = 'Nền văn minh Trung Hoa sở hữu bề dày lịch sử lâu đời kéo dài liên tục hơn năm nghìn năm, thai nghén nên tư tưởng triết học truyền thống uyên thâm sâu sắc và nền văn hóa dân tộc rực rỡ chói lọi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '悠久',
      'yōujiǔ',
      'lâu đời, trường cửu, dài lâu',
      'Tính từ',
      'HSK 5',
      '中华文明拥有五千多年绵延不绝的悠久历史，孕育了博大精深的传统哲学思想与璀璨绚丽的民族文化。',
      'Zhōnghuá wénmíng yōngyǒu wǔ qiān duō nián miányán-bùjué de yōujiǔ lìshǐ, yùnyù le bódà-jīngshēn de chuántǒng zhéxué sīxiǎng yǔ cuǐcàn-xuànlì de mínzú wénhuà.',
      'Nền văn minh Trung Hoa sở hữu bề dày lịch sử lâu đời kéo dài liên tục hơn năm nghìn năm, thai nghén nên tư tưởng triết học truyền thống uyên thâm sâu sắc và nền văn hóa dân tộc rực rỡ chói lọi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '中华文明拥有五千多年绵延不绝的悠久历史，孕育了博大精深的传统哲学思想与璀璨绚丽的民族文化。', 'Zhōnghuá wénmíng yōngyǒu wǔ qiān duō nián miányán-bùjué de yōujiǔ lìshǐ, yùnyù le bódà-jīngshēn de chuántǒng zhéxué sīxiǎng yǔ cuǐcàn-xuànlì de mínzú wénhuà.', 'Nền văn minh Trung Hoa sở hữu bề dày lịch sử lâu đời kéo dài liên tục hơn năm nghìn năm, thai nghén nên tư tưởng triết học truyền thống uyên thâm sâu sắc và nền văn hóa dân tộc rực rỡ chói lọi.', 'basic', 1),
      (v_id, '依托悠久深厚的京杭大运河千年活态水利水运遗产，运河沿线重点城市协同推进大运河国家文化公园标志性文化景观带保护建设。', 'Yītuō yōujiǔ shēnhòu de Jīng-Háng Dàyùnhé qiānnián huótài shuǐlì shuǐyùn yíchǎn, yùnhé yánxiàn zhòngdiǎn chéngshì xiétóng tuījìn Dàyùnhé guójiā wénhuà gōngyuán biāozhìxìng wénhuà jǐngguāndài bǎohù jiànshè.', 'Dựa trên di sản thủy lợi và vận tải thủy nghìn năm sống động lâu đời sâu sắc của kênh đào Kinh Hàng, các thành phố trọng điểm dọc tuyến kênh cùng phối hợp thúc đẩy công tác bảo tồn xây dựng dải cảnh quan văn hóa mang tính biểu tượng của Công viên văn hóa quốc gia Đại Vận Hà.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3398] [优良] (yōuliáng) - tốt đẹp, xuất sắc, ưu lương (phẩm chất, tác phong, giống nòi) [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '优良' AND pinyin = 'yōuliáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优良' AND pinyin = 'yōuliáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '优良'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优良'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yōuliáng',
      meaning_vi = 'tốt đẹp, xuất sắc, ưu lương (phẩm chất, tác phong, giống nòi)',
      example_hanzi = '这种经过农业科研人员精心繁育的新型杂交优质水稻优良品种，具有高产、稳产与抗病虫害等多重突出特性。',
      example_pinyin = 'Zhè zhǒng jīngguò nóngyè kēyán rényuán jīngxīn fányù de xīnxíng zájiāo yōuzhì shuǐdào yōuliáng pǐnzhǒng, jùyǒu gāochǎn, wěnchǎn yǔ kàng bìngchónghài děng duōchóng tūchū tèxìng.',
      example_vi = 'Giống lúa lai chất lượng cao ưu lương mới được các nhà khoa học nông nghiệp dày công lai tạo này có nhiều đặc tính nổi trội như năng suất cao, sản lượng ổn định và kháng sâu bệnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '优良',
      'yōuliáng',
      'tốt đẹp, xuất sắc, ưu lương (phẩm chất, tác phong, giống nòi)',
      'Tính từ',
      'HSK 5',
      '这种经过农业科研人员精心繁育的新型杂交优质水稻优良品种，具有高产、稳产与抗病虫害等多重突出特性。',
      'Zhè zhǒng jīngguò nóngyè kēyán rényuán jīngxīn fányù de xīnxíng zájiāo yōuzhì shuǐdào yōuliáng pǐnzhǒng, jùyǒu gāochǎn, wěnchǎn yǔ kàng bìngchónghài děng duōchóng tūchū tèxìng.',
      'Giống lúa lai chất lượng cao ưu lương mới được các nhà khoa học nông nghiệp dày công lai tạo này có nhiều đặc tính nổi trội như năng suất cao, sản lượng ổn định và kháng sâu bệnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这种经过农业科研人员精心繁育的新型杂交优质水稻优良品种，具有高产、稳产与抗病虫害等多重突出特性。', 'Zhè zhǒng jīngguò nóngyè kēyán rényuán jīngxīn fányù de xīnxíng zájiāo yōuzhì shuǐdào yōuliáng pǐnzhǒng, jùyǒu gāochǎn, wěnchǎn yǔ kàng bìngchónghài děng duōchóng tūchū tèxìng.', 'Giống lúa lai chất lượng cao ưu lương mới được các nhà khoa học nông nghiệp dày công lai tạo này có nhiều đặc tính nổi trội như năng suất cao, sản lượng ổn định và kháng sâu bệnh.', 'basic', 1),
      (v_id, '国家重大工程建设团队全面继承和发扬“特别能吃苦、特别能战斗、特别能攻关、特别能奉献”的优良作风，创造了令世人赞叹的工程奇迹。', 'Guójiā zhòngdà gōngchéng jiànshè tuánduì quánmiàn jìchéng hé fāyáng “tèbié néng chīkǔ, tèbié néng zhàndòu, tèbié néng gōngguān, tèbié néng fèngxiàn” de yōuliáng zuòfēng, chuàngzào le lìng shìrén zàntàn de gōngchéng qíjì.', 'Đoàn đội xây dựng công trình trọng đại quốc gia đã kế thừa và phát huy toàn diện tác phong tốt đẹp "đặc biệt biết chịu khổ, đặc biệt biết chiến đấu, đặc biệt biết công kích phá điểm nghẽn, đặc biệt biết cống hiến", tạo nên những kỳ tích công trình khiến cả thế giới phải ngợi khen.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3399] [优美] (yōuměi) - tươi đẹp, thanh nhã, duyên dáng, tuyệt mỹ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '优美' AND pinyin = 'yōuměi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优美' AND pinyin = 'yōuměi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '优美'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优美'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yōuměi',
      meaning_vi = 'tươi đẹp, thanh nhã, duyên dáng, tuyệt mỹ',
      example_hanzi = '伴随着悠扬动听的古典交响乐曲，舞台中央的青年芭蕾舞演员舒展身姿，跳出了极其优美的舞步。',
      example_pinyin = 'Bànsuí zhe yōuyáng dòngtīng de gǔdiǎn jiāoxiǎng yuèqǔ, wǔtái zhōngyāng de qīngnián bālěiwǔ yǎnyuán shūzhǎn shēnzī, tiào chū le jíqí yōuměi de wǔbù.',
      example_vi = 'Hòa cùng bản nhạc giao hưởng cổ điển du dương êm tai, diễn viên múa ba lê trẻ tuổi giữa sân khấu vươn mình nhẹ nhàng, lướt qua những bước nhảy vô cùng duyên dáng tuyệt mỹ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '优美',
      'yōuměi',
      'tươi đẹp, thanh nhã, duyên dáng, tuyệt mỹ',
      'Tính từ',
      'HSK 5',
      '伴随着悠扬动听的古典交响乐曲，舞台中央的青年芭蕾舞演员舒展身姿，跳出了极其优美的舞步。',
      'Bànsuí zhe yōuyáng dòngtīng de gǔdiǎn jiāoxiǎng yuèqǔ, wǔtái zhōngyāng de qīngnián bālěiwǔ yǎnyuán shūzhǎn shēnzī, tiào chū le jíqí yōuměi de wǔbù.',
      'Hòa cùng bản nhạc giao hưởng cổ điển du dương êm tai, diễn viên múa ba lê trẻ tuổi giữa sân khấu vươn mình nhẹ nhàng, lướt qua những bước nhảy vô cùng duyên dáng tuyệt mỹ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '伴随着悠扬动听的古典交响乐曲，舞台中央的青年芭蕾舞演员舒展身姿，跳出了极其优美的舞步。', 'Bànsuí zhe yōuyáng dòngtīng de gǔdiǎn jiāoxiǎng yuèqǔ, wǔtái zhōngyāng de qīngnián bālěiwǔ yǎnyuán shūzhǎn shēnzī, tiào chū le jíqí yōuměi de wǔbù.', 'Hòa cùng bản nhạc giao hưởng cổ điển du dương êm tai, diễn viên múa ba lê trẻ tuổi giữa sân khấu vươn mình nhẹ nhàng, lướt qua những bước nhảy vô cùng duyên dáng tuyệt mỹ.', 'basic', 1),
      (v_id, '深入践行“绿水青山就是金山银山”生态文明理念，统筹推进山水林田湖草沙一体化保护修护，为人民群众精心绘就天蓝水清地绿的优美生态家园。', 'Shēnrù jiànxíng “lǜshuǐ qīngshān jiùshì jīnshān yínshān” shēngtài wénmíng lǐniàn, tǒngchóu tuījìn shān-shuǐ-lín-tián-hú-cǎo-shā yītǐhuà bǎohù xiūfù, wèi rénmín qúnzhòng jīngxīn huì jiù tiān lán shuǐ qīng dì lǜ de yōuměi shēngtài jiāyuán.', 'Thực hành sâu sắc triết lý văn minh sinh thái "non xanh nước biếc chính là núi vàng núi bạc", điều phối thúc đẩy việc bảo vệ và phục hồi tích hợp núi, nước, rừng, ruộng, hồ, cỏ, cát, dày công vẽ nên cho quần chúng nhân dân mái nhà sinh thái tươi đẹp trời xanh nước trong đất ngát xanh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3400] [优势] (yōushì) - ưu thế, thế mạnh, vị thế vượt trội [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '优势' AND pinyin = 'yōushì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优势' AND pinyin = 'yōushì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '优势'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优势'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'yōushì',
      meaning_vi = 'ưu thế, thế mạnh, vị thế vượt trội',
      example_hanzi = '在激烈的跨国求职面试中，流畅地道的外语听说能力与扎实的计算机专业技能是他脱颖而出的显著竞争优势。',
      example_pinyin = 'Zài jīliè de kuàguó qiúzhí miànshì zhōng, liúchàng dìdao de wàiyǔ tīng-shuō nénglì yǔ zhāshi de jìsuànjī zhuānyè jìnéng shì tā tuōyǐng-érchū de xiǎnzhù jìngzhēng yōushì.',
      example_vi = 'Trong cuộc phỏng vấn tuyển dụng xuyên quốc gia khốc liệt, năng lực nghe nói ngoại ngữ lưu loát chuẩn xác cùng kỹ năng chuyên môn máy tính vững vàng chính là ưu thế cạnh tranh nổi bật giúp anh ấy nổi trội bứt phá.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '优势',
      'yōushì',
      'ưu thế, thế mạnh, vị thế vượt trội',
      'Danh từ',
      'HSK 5',
      '在激烈的跨国求职面试中，流畅地道的外语听说能力与扎实的计算机专业技能是他脱颖而出的显著竞争优势。',
      'Zài jīliè de kuàguó qiúzhí miànshì zhōng, liúchàng dìdao de wàiyǔ tīng-shuō nénglì yǔ zhāshi de jìsuànjī zhuānyè jìnéng shì tā tuōyǐng-érchū de xiǎnzhù jìngzhēng yōushì.',
      'Trong cuộc phỏng vấn tuyển dụng xuyên quốc gia khốc liệt, năng lực nghe nói ngoại ngữ lưu loát chuẩn xác cùng kỹ năng chuyên môn máy tính vững vàng chính là ưu thế cạnh tranh nổi bật giúp anh ấy nổi trội bứt phá.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在激烈的跨国求职面试中，流畅地道的外语听说能力与扎实的计算机专业技能是他脱颖而出的显著竞争优势。', 'Zài jīliè de kuàguó qiúzhí miànshì zhōng, liúchàng dìdao de wàiyǔ tīng-shuō nénglì yǔ zhāshi de jìsuànjī zhuānyè jìnéng shì tā tuōyǐng-érchū de xiǎnzhù jìngzhēng yōushì.', 'Trong cuộc phỏng vấn tuyển dụng xuyên quốc gia khốc liệt, năng lực nghe nói ngoại ngữ lưu loát chuẩn xác cùng kỹ năng chuyên môn máy tính vững vàng chính là ưu thế cạnh tranh nổi bật giúp anh ấy nổi trội bứt phá.', 'basic', 1),
      (v_id, '我国在动力电池全产业链能量密度、大模组底盘一体化压铸以及整车智能网联领域确立了引领全球新能源汽车行业的综合竞争新优势。', 'Wǒguó zài dònglì diànchí quán-chǎnyèliàn néngliàng mìdù, dà mózǔ dǐpán yītǐhuà yāzhù yǐjí zhěngchē zhìnéng wǎnglián lǐngyù quèlì le yǐnlǐng quánqiú xīnnéngyuán qìchē hángyè de zōnghé jìngzhēng xīn yōushì.', 'Nước ta trong mật độ năng lượng toàn chuỗi công nghiệp pin động lực, công nghệ đúc áp lực tích hợp khung gầm mô-đun lớn cũng như kết nối mạng thông minh toàn xe đã xác lập nên ưu thế cạnh tranh tổng hợp mới dẫn đầu ngành công nghiệp ô tô năng lượng mới toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3401] [优质] (yōuzhì) - chất lượng cao, thượng hạng, ưu chất [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '优质' AND pinyin = 'yōuzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优质' AND pinyin = 'yōuzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '优质'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '优质'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'yōuzhì',
      meaning_vi = 'chất lượng cao, thượng hạng, ưu chất',
      example_hanzi = '学校膳食管理委员会坚持从正规绿色有机农产品基地直采新鲜蔬菜与粮油，确保全校师生每天都能享受到安全健康的优质饭菜。',
      example_pinyin = 'Xuéxiào shànshí guǎnlǐ wěiyuánhuì jiānchí cóng zhèngguī lǜsè yǒujī nóngchǎnpǐn jīdì zhícǎi xīnxiān shūcài yǔ liángyóu, quèbǎo quánxiào shī-shēng měitiān dōu néng xiǎngshòu dào ānquán jiànkāng de yōuzhì fàncài.',
      example_vi = 'Hội đồng quản lý bữa ăn dinh dưỡng nhà trường kiên trì thu mua trực tiếp rau củ tươi cùng lương thực dầu ăn từ các căn cứ nông sản hữu cơ xanh chính quy, bảo đảm toàn thể giáo viên và học sinh mỗi ngày đều được thưởng thức những bữa cơm chất lượng cao an toàn lành mạnh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '优质',
      'yōuzhì',
      'chất lượng cao, thượng hạng, ưu chất',
      'Tính từ',
      'HSK 5',
      '学校膳食管理委员会坚持从正规绿色有机农产品基地直采新鲜蔬菜与粮油，确保全校师生每天都能享受到安全健康的优质饭菜。',
      'Xuéxiào shànshí guǎnlǐ wěiyuánhuì jiānchí cóng zhèngguī lǜsè yǒujī nóngchǎnpǐn jīdì zhícǎi xīnxiān shūcài yǔ liángyóu, quèbǎo quánxiào shī-shēng měitiān dōu néng xiǎngshòu dào ānquán jiànkāng de yōuzhì fàncài.',
      'Hội đồng quản lý bữa ăn dinh dưỡng nhà trường kiên trì thu mua trực tiếp rau củ tươi cùng lương thực dầu ăn từ các căn cứ nông sản hữu cơ xanh chính quy, bảo đảm toàn thể giáo viên và học sinh mỗi ngày đều được thưởng thức những bữa cơm chất lượng cao an toàn lành mạnh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '学校膳食管理委员会坚持从正规绿色有机农产品基地直采新鲜蔬菜与粮油，确保全校师生每天都能享受到安全健康的优质饭菜。', 'Xuéxiào shànshí guǎnlǐ wěiyuánhuì jiānchí cóng zhèngguī lǜsè yǒujī nóngchǎnpǐn jīdì zhícǎi xīnxiān shūcài yǔ liángyóu, quèbǎo quánxiào shī-shēng měitiān dōu néng xiǎngshòu dào ānquán jiànkāng de yōuzhì fàncài.', 'Hội đồng quản lý bữa ăn dinh dưỡng nhà trường kiên trì thu mua trực tiếp rau củ tươi cùng lương thực dầu ăn từ các căn cứ nông sản hữu cơ xanh chính quy, bảo đảm toàn thể giáo viên và học sinh mỗi ngày đều được thưởng thức những bữa cơm chất lượng cao an toàn lành mạnh.', 'basic', 1),
      (v_id, '国家级高新区全面推行全链条“极简审批”改革，以高水准知识产权综合保护与全生命周期的优质政务法治营商环境全面赋能硬科技实体企业裂变式发展。', 'Guójiājí gāoxīnqū quánmiàn tuīxíng quán-liàntiáo “jíjiǎn shěnpī” gǎigé, yǐ gāoshuǐzhǔn zhīshi chǎnquán zōnghé bǎohù yǔ quán-shēngmìng zhōuqī de yōuzhì zhèngwù fǎzhì yíngshāng huánjìng quánmiàn fùnéng yìngkējì shítǐ qǐyè lièbiànshì fāzhǎn.', 'Khu công nghệ cao cấp quốc gia triển khai toàn diện cải cách "thẩm định phê duyệt tối giản" toàn chuỗi, bằng công tác bảo hộ tổng hợp quyền sở hữu trí tuệ tiêu chuẩn cao cùng môi trường kinh doanh pháp quyền chính vụ chất lượng cao suốt vòng đời đã tiếp sức toàn diện cho sự phát triển phân nhánh bùng nổ của các doanh nghiệp thực thể công nghệ lõi cứng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn tất cập nhật HSK 5 - Batch 14! Tổng số từ đã xử lý: %', v_count;
END $$;
