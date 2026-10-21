-- ====================================================================
-- MIGRATION: BỔ SUNG CÂU VÍ DỤ CHẤT LƯỢNG CAO CHO HSK 5 - BATCH 13 (100 TỪ TIẾP THEO)
-- Phạm vi: #3202 [问卷] (wènjuàn) -> #3301 [修建] (xiūjiàn)
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
  -- [3202] [问卷] (wènjuàn) - phiếu điều tra, bảng khảo sát [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '问卷' AND pinyin = 'wènjuàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '问卷' AND pinyin = 'wènjuàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '问卷'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '问卷'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wènjuàn',
      meaning_vi = 'phiếu điều tra, bảng khảo sát',
      example_hanzi = '请您抽出两分钟时间，协助我们填写一份关于售后满意度的问卷。',
      example_pinyin = 'Qǐng nín chōuchū liǎng fēnzhōng shíjiān, xiézhù wǒmen tiánxiě yī fèn guānyú shòuhòu mǎnyìdù de wènjuàn.',
      example_vi = 'Xin quý khách bớt chút hai phút thời gian giúp chúng tôi điền một bản khảo sát về mức độ hài lòng sau bán hàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '问卷',
      'wènjuàn',
      'phiếu điều tra, bảng khảo sát',
      'Danh từ',
      'HSK 5',
      '请您抽出两分钟时间，协助我们填写一份关于售后满意度的问卷。',
      'Qǐng nín chōuchū liǎng fēnzhōng shíjiān, xiézhù wǒmen tiánxiě yī fèn guānyú shòuhòu mǎnyìdù de wènjuàn.',
      'Xin quý khách bớt chút hai phút thời gian giúp chúng tôi điền một bản khảo sát về mức độ hài lòng sau bán hàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请您抽出两分钟时间，协助我们填写一份关于售后满意度的问卷。', 'Qǐng nín chōuchū liǎng fēnzhōng shíjiān, xiézhù wǒmen tiánxiě yī fèn guānyú shòuhòu mǎnyìdù de wènjuàn.', 'Xin quý khách bớt chút hai phút thời gian giúp chúng tôi điền một bản khảo sát về mức độ hài lòng sau bán hàng.', 'basic', 1),
      (v_id, '市场研究团队采用双盲随机抽样方法发放并回收了逾万份问卷，为新产品研发与精准定位提供了翔实客观的量化数据支撑。', 'Shìchǎng yánjiū tuánduì cǎiyòng shuāngmáng suíjī chōuyàng fāngfǎ fāfàng bìng huíshōu le yú wàn fèn wènjuàn, wèi xīn chǎnpǐn yánfā yǔ jīngzhǔn dìngwèi tígōng le xiángshí kèguān de liànghuà shùjù zhīchēng.', 'Đội ngũ nghiên cứu thị trường áp dụng phương pháp lấy mẫu ngẫu nhiên mù đôi để phát ra và thu hồi hơn mười nghìn bảng khảo sát, cung cấp điểm tựa dữ liệu định lượng chuẩn xác và khách quan cho hoạt động R&D và định vị chuẩn xác sản phẩm mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3203] [握] (wò) - nắm, giữ, cầm chắc [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '握' AND pinyin = 'wò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '握' AND pinyin = 'wò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '握'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '握'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wò',
      meaning_vi = 'nắm, giữ, cầm chắc',
      example_hanzi = '母亲紧紧握着孩子娇嫩的小手，一步步走过车流如织的十字路口。',
      example_pinyin = 'Mǔqīn jǐnjǐn wò zhe háizi jiāonèn de xiǎoshǒu, yībùbù zǒu guò chēliú rù zhī de shízì lùkǒu.',
      example_vi = 'Người mẹ nắm chặt bàn tay nhỏ nhắn mềm mại của đứa con, từng bước dắt con băng qua ngã tư xe cộ qua lại như mắc cửi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '握',
      'wò',
      'nắm, giữ, cầm chắc',
      'Động từ',
      'HSK 5',
      '母亲紧紧握着孩子娇嫩的小手，一步步走过车流如织的十字路口。',
      'Mǔqīn jǐnjǐn wò zhe háizi jiāonèn de xiǎoshǒu, yībùbù zǒu guò chēliú rù zhī de shízì lùkǒu.',
      'Người mẹ nắm chặt bàn tay nhỏ nhắn mềm mại của đứa con, từng bước dắt con băng qua ngã tư xe cộ qua lại như mắc cửi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '母亲紧紧握着孩子娇嫩的小手，一步步走过车流如织的十字路口。', 'Mǔqīn jǐnjǐn wò zhe háizi jiāonèn de xiǎoshǒu, yībùbù zǒu guò chēliú rù zhī de shízì lùkǒu.', 'Người mẹ nắm chặt bàn tay nhỏ nhắn mềm mại của đứa con, từng bước dắt con băng qua ngã tư xe cộ qua lại như mắc cửi.', 'basic', 1),
      (v_id, '机长全神贯注地握紧主操纵杆，在突发强侧风气流扰动下沉着稳健地引导飞机平稳降落于跑道。', 'Jīzhǎng quánshén-guànzhù de wò jǐn zhǔ cāozònggān, zài tūfā qiáng cèfēng qìliú rǎodòng xià chénzhuó wěnjiàn de yǐndǎo fēijī píngwěn jiàngluò yú pǎodào.', 'Cơ trưởng tập trung cao độ nắm chặt cần điều khiển chính, bình tĩnh và vững vàng điều khiển máy bay hạ cánh êm thuận xuống đường băng trong điều kiện luồng gió giật ngang đột ngột.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3204] [卧室] (wòshì) - phòng ngủ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '卧室' AND pinyin = 'wòshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '卧室' AND pinyin = 'wòshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '卧室'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '卧室'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wòshì',
      meaning_vi = 'phòng ngủ',
      example_hanzi = '这套两居室公寓的主卧室朝南，采光极佳且配有独立的卫生间。',
      example_pinyin = 'Zhè tào liǎng jū shì gōngyù de zhǔ wòshì cháo nán, cǎiguāng jí jiā qiě pèi yǒu dúlì de wèishēngjiān.',
      example_vi = 'Phòng ngủ chính của căn hộ hai phòng ngủ này quay về hướng nam, đón ánh sáng rất tốt và có nhà vệ sinh khép kín.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '卧室',
      'wòshì',
      'phòng ngủ',
      'Danh từ',
      'HSK 5',
      '这套两居室公寓的主卧室朝南，采光极佳且配有独立的卫生间。',
      'Zhè tào liǎng jū shì gōngyù de zhǔ wòshì cháo nán, cǎiguāng jí jiā qiě pèi yǒu dúlì de wèishēngjiān.',
      'Phòng ngủ chính của căn hộ hai phòng ngủ này quay về hướng nam, đón ánh sáng rất tốt và có nhà vệ sinh khép kín.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这套两居室公寓的主卧室朝南，采光极佳且配有独立的卫生间。', 'Zhè tào liǎng jū shì gōngyù de zhǔ wòshì cháo nán, cǎiguāng jí jiā qiě pèi yǒu dúlì de wèishēngjiān.', 'Phòng ngủ chính của căn hộ hai phòng ngủ này quay về hướng nam, đón ánh sáng rất tốt và có nhà vệ sinh khép kín.', 'basic', 1),
      (v_id, '室内健康环境设计规范明确要求，主卧室必须保持良好的新风自然置换与隔音阻尼降噪性能，以切实保障深度睡眠品质。', 'Shìnèi jiànkāng huánjìng shèjì guīfàn míngquè yāoqiú, zhǔ wòshì bìxū bǎochí liánghǎo de xīnfēng zìrán zhìhuàn yǔ géyīn zǔní jiàngzào xìngnéng, yǐ qièshí bǎozhàng shēndù shuìmián pǐnzhì.', 'Quy chuẩn thiết kế môi trường lành mạnh trong nhà yêu cầu rõ ràng, phòng ngủ chính bắt buộc phải duy trì sự lưu thông khí tươi tự nhiên tốt cùng hiệu năng cách âm giảm chấn tiêu âm để bảo đảm thiết thực chất lượng giấc ngủ sâu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3205] [握手] (wòshǒu) - bắt tay [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '握手' AND pinyin = 'wòshǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '握手' AND pinyin = 'wòshǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '握手'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '握手'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'wòshǒu',
      meaning_vi = 'bắt tay',
      example_hanzi = '会议圆满结束后，双方代表热情握手并互致最诚挚的问候。',
      example_pinyin = 'Huìyì yuánmǎn jiéshù hòu, shuāngfāng dàibiǎo rèqíng wòshǒu bìng hù zhì zuì chéngzhì de wènhòu.',
      example_vi = 'Sau khi hội nghị kết thúc tốt đẹp, đại diện hai bên đã nhiệt tình bắt tay và gửi tới nhau những lời thăm hỏi chân thành nhất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '握手',
      'wòshǒu',
      'bắt tay',
      'Động từ',
      'HSK 5',
      '会议圆满结束后，双方代表热情握手并互致最诚挚的问候。',
      'Huìyì yuánmǎn jiéshù hòu, shuāngfāng dàibiǎo rèqíng wòshǒu bìng hù zhì zuì chéngzhì de wènhòu.',
      'Sau khi hội nghị kết thúc tốt đẹp, đại diện hai bên đã nhiệt tình bắt tay và gửi tới nhau những lời thăm hỏi chân thành nhất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '会议圆满结束后，双方代表热情握手并互致最诚挚的问候。', 'Huìyì yuánmǎn jiéshù hòu, shuāngfāng dàibiǎo rèqíng wòshǒu bìng hù zhì zuì chéngzhì de wènhòu.', 'Sau khi hội nghị kết thúc tốt đẹp, đại diện hai bên đã nhiệt tình bắt tay và gửi tới nhau những lời thăm hỏi chân thành nhất.', 'basic', 1),
      (v_id, '两国元首在红地毯迎宾厅亲切握手合影，这一历史性瞬间标志着双边全面战略合作伙伴关系翻开了崭新篇章。', 'Liǎng guó yuánshǒu zài hóng dǐtǎn yíngbīntīng qīnqiè wòshǒu héyǐng, zhè yī lìshǐxìng shùnjiān biāozhì zhe shuāngbiān quánmiàn zhànlüè hézuò huǒbàn guānxì fānkāi le zhǎnxīn piānzhāng.', 'Nguyên thủ hai nước thân mật bắt tay chụp ảnh lưu niệm tại sảnh đón trải thảm đỏ, khoảnh khắc lịch sử này đánh dấu quan hệ đối tác hợp tác chiến lược toàn diện song phương bước sang trang mới rạng rỡ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3206] [无关] (wúguān) - không liên quan, vô can [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '无关' AND pinyin = 'wúguān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无关' AND pinyin = 'wúguān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '无关'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无关'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'wúguān',
      meaning_vi = 'không liên quan, vô can',
      example_hanzi = '请大家在学术研讨中紧扣核心议题发言，不要提及与会议主题无关的内容。',
      example_pinyin = 'Qǐng dàjiā zài xuéshù yántǎo zhōng jǐnkòu héxīn yìtí fāyán, bùyào tíjí yǔ huìyì zhǔtí wúguān de nèiróng.',
      example_vi = 'Xin mời mọi người trong buổi tọa đàm học thuật hãy bám sát chủ đề cốt lõi để phát biểu, không đề cập đến những nội dung không liên quan đến chủ đề cuộc họp.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '无关',
      'wúguān',
      'không liên quan, vô can',
      'Động từ / Tính từ',
      'HSK 5',
      '请大家在学术研讨中紧扣核心议题发言，不要提及与会议主题无关的内容。',
      'Qǐng dàjiā zài xuéshù yántǎo zhōng jǐnkòu héxīn yìtí fāyán, bùyào tíjí yǔ huìyì zhǔtí wúguān de nèiróng.',
      'Xin mời mọi người trong buổi tọa đàm học thuật hãy bám sát chủ đề cốt lõi để phát biểu, không đề cập đến những nội dung không liên quan đến chủ đề cuộc họp.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '请大家在学术研讨中紧扣核心议题发言，不要提及与会议主题无关的内容。', 'Qǐng dàjiā zài xuéshù yántǎo zhōng jǐnkòu héxīn yìtí fāyán, bùyào tíjí yǔ huìyì zhǔtí wúguān de nèiróng.', 'Xin mời mọi người trong buổi tọa đàm học thuật hãy bám sát chủ đề cốt lõi để phát biểu, không đề cập đến những nội dung không liên quan đến chủ đề cuộc họp.', 'basic', 1),
      (v_id, '司法审判机关严格遵循排除合理怀疑的法定证明标准，任何与案件关键事实认定无关的推测性证言均不具有法律效力。', 'Sīfǎ shěnpàn jīgòu yángé zūnxún páichú hélǐ huáiyí de fǎdìng zhèngmíng biāozhǔn, rènhé yǔ ànjiàn guānjiàn shìshí rèndìng wúguān de tuīcèxìng zhèngyán jūn bù jùyǒu fǎlǜ xiàolì.', 'Cơ quan xét xử tư pháp tuân thủ nghiêm ngặt chuẩn mực chứng minh theo luật định loại trừ mọi nghi ngờ hợp lý, bất kỳ lời khai mang tính suy đoán nào không liên quan đến việc xác định sự thật trọng yếu của vụ án đều không có giá trị pháp lý.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3207] [无奈] (wúnài) - bất lực, đành chịu, không còn cách nào; ngặt nỗi [Tính từ / Liên từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '无奈' AND pinyin = 'wúnài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无奈' AND pinyin = 'wúnài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '无奈'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无奈'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Liên từ',
      pinyin = 'wúnài',
      meaning_vi = 'bất lực, đành chịu, không còn cách nào; ngặt nỗi',
      example_hanzi = '面对突如其来的倾盆大雨，没有带伞的游客们只能无奈地站在屋檐下避雨。',
      example_pinyin = 'Miànduì tūrúqílái de qīngpén dàyǔ, méiyǒu dài sǎn de yóukèmen zhǐ néng wúnài de zhàn zài wūyán xià bìyǔ.',
      example_vi = 'Đối mặt với cơn mưa như trút nước bất ngờ ập đến, các du khách không mang theo ô chỉ đành bất lực đứng dưới mái hiên trú mưa.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '无奈',
      'wúnài',
      'bất lực, đành chịu, không còn cách nào; ngặt nỗi',
      'Tính từ / Liên từ',
      'HSK 5',
      '面对突如其来的倾盆大雨，没有带伞的游客们只能无奈地站在屋檐下避雨。',
      'Miànduì tūrúqílái de qīngpén dàyǔ, méiyǒu dài sǎn de yóukèmen zhǐ néng wúnài de zhàn zài wūyán xià bìyǔ.',
      'Đối mặt với cơn mưa như trút nước bất ngờ ập đến, các du khách không mang theo ô chỉ đành bất lực đứng dưới mái hiên trú mưa.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对突如其来的倾盆大雨，没有带伞的游客们只能无奈地站在屋檐下避雨。', 'Miànduì tūrúqílái de qīngpén dàyǔ, méiyǒu dài sǎn de yóukèmen zhǐ néng wúnài de zhàn zài wūyán xià bìyǔ.', 'Đối mặt với cơn mưa như trút nước bất ngờ ập đến, các du khách không mang theo ô chỉ đành bất lực đứng dưới mái hiên trú mưa.', 'basic', 1),
      (v_id, '面对严峻的外部供应链断供风险与不可抗力关税壁垒，跨国实体企业不得不做出无奈的产能区域重组抉择。', 'Miànduì yánjùn de wàibù gōngyìngliàn duàngōng fēngxiǎn yǔ bùkěkànglì guānshuì bìlěi, kuàguó shítǐ qǐyè bùdébù zuòchū wúnài de chǎnnéng qūyù chóngzǔ juézé.', 'Đối mặt với rủi ro đứt gãy chuỗi cung ứng bên ngoài gay gắt và các rào cản thuế quan bất khả kháng, các doanh nghiệp thực thể đa quốc gia buộc phải đưa ra lựa chọn tái cơ cấu năng lực sản xuất khu vực đầy bất đắc dĩ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3208] [无数] (wúshù) - vô số, vô vàn, không đếm xuể [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '无数' AND pinyin = 'wúshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无数' AND pinyin = 'wúshù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '无数'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无数'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'wúshù',
      meaning_vi = 'vô số, vô vàn, không đếm xuể',
      example_hanzi = '仰望晴朗的夏夜星空，无数颗璀璨的繁星在深蓝色的天幕中闪烁。',
      example_pinyin = 'Yǎngwàng qínglǎng de xiàyè xīngkōng, wúshù kē cuǐcàn de fánxīng zài shēnlánsè de tiānmù zhōng shǎnshuò.',
      example_vi = 'Ngước nhìn bầu trời sao mùa hè trong trẻo, vô số vì sao lấp lánh tỏa sáng trên nền trời xanh thẫm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '无数',
      'wúshù',
      'vô số, vô vàn, không đếm xuể',
      'Tính từ',
      'HSK 5',
      '仰望晴朗的夏夜星空，无数颗璀璨的繁星在深蓝色的天幕中闪烁。',
      'Yǎngwàng qínglǎng de xiàyè xīngkōng, wúshù kē cuǐcàn de fánxīng zài shēnlánsè de tiānmù zhōng shǎnshuò.',
      'Ngước nhìn bầu trời sao mùa hè trong trẻo, vô số vì sao lấp lánh tỏa sáng trên nền trời xanh thẫm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '仰望晴朗的夏夜星空，无数颗璀璨的繁星在深蓝色的天幕中闪烁。', 'Yǎngwàng qínglǎng de xiàyè xīngkōng, wúshù kē cuǐcàn de fánxīng zài shēnlánsè de tiānmù zhōng shǎnshuò.', 'Ngước nhìn bầu trời sao mùa hè trong trẻo, vô số vì sao lấp lánh tỏa sáng trên nền trời xanh thẫm.', 'basic', 1),
      (v_id, '每一项国之重器与重大基础工程的成功问世，背后都凝聚着无数一线科研攻关人员夜以继日的奋斗心血。', 'Měi yī xiàng guózhīzhòngqì yǔ zhòngdà jīchǔ gōngchéng de chénggōng wènshì, bèihòu dōu níngjù zhe wúshù yīxiàn kēyán gōngguān rényuán yèyǐjìrì de fèndòu xīnxuè.', 'Mỗi một vũ khí trọng khí quốc gia và công trình hạ tầng trọng đại ra đời thành công, phía sau đều kết tinh tâm huyết phấn đấu ngày đêm không ngừng nghỉ của vô số cán bộ nghiên cứu khoa học trực tiếp nơi tiền tuyến.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3209] [无限] (wúxiàn) - vô hạn, vô cùng, không giới hạn [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '无限' AND pinyin = 'wúxiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无限' AND pinyin = 'wúxiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '无限'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无限'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'wúxiàn',
      meaning_vi = 'vô hạn, vô cùng, không giới hạn',
      example_hanzi = '科学探索的过程充满了未知的奥秘，也给青年学生带来了无限的想象空间。',
      example_pinyin = 'Kēxué tànsuǒ de guòchéng chōngmǎn le wèizhī de àomì, yě gěi qīngnián xuéshēng dài lái le wúxiàn de xiǎngxiàng kōngjiān.',
      example_vi = 'Quá trình thám hiểm khoa học tràn ngập những bí ẩn chưa biết, đồng thời cũng mang lại cho các bạn học sinh trẻ không gian tưởng tượng vô tận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '无限',
      'wúxiàn',
      'vô hạn, vô cùng, không giới hạn',
      'Tính từ',
      'HSK 5',
      '科学探索的过程充满了未知的奥秘，也给青年学生带来了无限的想象空间。',
      'Kēxué tànsuǒ de guòchéng chōngmǎn le wèizhī de àomì, yě gěi qīngnián xuéshēng dài lái le wúxiàn de xiǎngxiàng kōngjiān.',
      'Quá trình thám hiểm khoa học tràn ngập những bí ẩn chưa biết, đồng thời cũng mang lại cho các bạn học sinh trẻ không gian tưởng tượng vô tận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '科学探索的过程充满了未知的奥秘，也给青年学生带来了无限的想象空间。', 'Kēxué tànsuǒ de guòchéng chōngmǎn le wèizhī de àomì, yě gěi qīngnián xuéshēng dài lái le wúxiàn de xiǎngxiàng kōngjiān.', 'Quá trình thám hiểm khoa học tràn ngập những bí ẩn chưa biết, đồng thời cũng mang lại cho các bạn học sinh trẻ không gian tưởng tượng vô tận.', 'basic', 1),
      (v_id, '随着生成式人工智能与空间计算技术的加速深度融合，未来数字文化创意产业展现出无限广阔的商业应用潜能。', 'Suízhe shēngchéngshì réngōng zhìnéng yǔ kōngjiān jìsuàn jìshù de jiāsù shēndù rónghé, wèilái shùzì wénhuà chuàngyì chǎnyè zhǎnxiàn chū wúxiàn guǎngkuò de shāngyè yìngyòng qiánnéng.', 'Cùng với sự tích hợp sâu rộng và tăng tốc của AI tạo sinh và công nghệ tính toán không gian, ngành công nghiệp sáng tạo văn hóa số trong tương lai phô diễn tiềm năng ứng dụng thương mại vô cùng rộng mở.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3210] [无效] (wúxiào) - vô hiệu, không có tác dụng, mất hiệu lực [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '无效' AND pinyin = 'wúxiào'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无效' AND pinyin = 'wúxiào'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '无效'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '无效'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'wúxiào',
      meaning_vi = 'vô hiệu, không có tác dụng, mất hiệu lực',
      example_hanzi = '如果没有加盖公章或缺少法定代表人签字，这份商业协议将被视作无效。',
      example_pinyin = 'Rúguǒ méiyǒu jiāgài gōngzhāng huò quēshǎo fǎdìng dàibiǎorén qiānzì, zhè fèn shāngyè xiéyì jiāng bèi shìzuò wúxiào.',
      example_vi = 'Nếu không đóng dấu mộc công ty hoặc thiếu chữ ký của người đại diện theo pháp luật, thỏa thuận thương mại này sẽ bị coi là vô hiệu.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '无效',
      'wúxiào',
      'vô hiệu, không có tác dụng, mất hiệu lực',
      'Tính từ / Động từ',
      'HSK 5',
      '如果没有加盖公章或缺少法定代表人签字，这份商业协议将被视作无效。',
      'Rúguǒ méiyǒu jiāgài gōngzhāng huò quēshǎo fǎdìng dàibiǎorén qiānzì, zhè fèn shāngyè xiéyì jiāng bèi shìzuò wúxiào.',
      'Nếu không đóng dấu mộc công ty hoặc thiếu chữ ký của người đại diện theo pháp luật, thỏa thuận thương mại này sẽ bị coi là vô hiệu.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '如果没有加盖公章或缺少法定代表人签字，这份商业协议将被视作无效。', 'Rúguǒ méiyǒu jiāgài gōngzhāng huò quēshǎo fǎdìng dàibiǎorén qiānzì, zhè fèn shāngyè xiéyì jiāng bèi shìzuò wúxiào.', 'Nếu không đóng dấu mộc công ty hoặc thiếu chữ ký của người đại diện theo pháp luật, thỏa thuận thương mại này sẽ bị coi là vô hiệu.', 'basic', 1),
      (v_id, '劳动人事争议仲裁委员会依法作出裁决，用人单位单方面制定的排除劳动者法定社保待遇的免责格式条款自始无效。', 'Láodòng rénshì zhēngyì zhòngcái wěiyuánhuì yīfǎ zuòchū cáijué, yòngrén dānwèi dān fāngmiàn zhìdìng de páichú láodòngzhě fǎdìng shèbǎo dàiyù de miǎnzé géshì tiáokuǎn zìshǐ wúxiào.', 'Hội đồng trọng tài tranh chấp lao động ra phán quyết theo luật định, điều khoản biểu mẫu miễn trừ do người sử dụng lao động đơn phương lập ra nhằm loại trừ chế độ bảo hiểm xã hội hợp pháp của người lao động là hoàn toàn vô hiệu ngay từ đầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3211] [舞蹈] (wǔdǎo) - vũ đạo, điệu múa, khiêu vũ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '舞蹈' AND pinyin = 'wǔdǎo'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舞蹈' AND pinyin = 'wǔdǎo'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '舞蹈'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舞蹈'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wǔdǎo',
      meaning_vi = 'vũ đạo, điệu múa, khiêu vũ',
      example_hanzi = '她从小练习中国古典舞蹈，优美轻盈的舞姿总能赢得观众阵阵热烈的掌声。',
      example_pinyin = 'Tā cóngxiǎo liànxí Zhōngguó gǔdiǎn wǔdǎo, yōuměi qīngyíng de wǔzī zǒng néng yíngdé guānzhòng zhènzhèn rèliè de zhǎngshēng.',
      example_vi = 'Cô ấy từ nhỏ đã rèn luyện vũ đạo cổ điển Trung Quốc, dáng múa thanh thoát uyển chuyển luôn nhận được từng tràng pháo tay nồng nhiệt từ khán giả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '舞蹈',
      'wǔdǎo',
      'vũ đạo, điệu múa, khiêu vũ',
      'Danh từ',
      'HSK 5',
      '她从小练习中国古典舞蹈，优美轻盈的舞姿总能赢得观众阵阵热烈的掌声。',
      'Tā cóngxiǎo liànxí Zhōngguó gǔdiǎn wǔdǎo, yōuměi qīngyíng de wǔzī zǒng néng yíngdé guānzhòng zhènzhèn rèliè de zhǎngshēng.',
      'Cô ấy từ nhỏ đã rèn luyện vũ đạo cổ điển Trung Quốc, dáng múa thanh thoát uyển chuyển luôn nhận được từng tràng pháo tay nồng nhiệt từ khán giả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '她从小练习中国古典舞蹈，优美轻盈的舞姿总能赢得观众阵阵热烈的掌声。', 'Tā cóngxiǎo liànxí Zhōngguó gǔdiǎn wǔdǎo, yōuměi qīngyíng de wǔzī zǒng néng yíngdé guānzhòng zhènzhèn rèliè de zhǎngshēng.', 'Cô ấy từ nhỏ đã rèn luyện vũ đạo cổ điển Trung Quốc, dáng múa thanh thoát uyển chuyển luôn nhận được từng tràng pháo tay nồng nhiệt từ khán giả.', 'basic', 1),
      (v_id, '这部大型原创民族舞剧融汇了当代先锋舞台美学与非遗传统舞蹈语汇，在国际艺术节巡演中获得了极高的声誉。', 'Zhè bù dàxíng yuánchuàng mínzú wǔjù rónghuì le dāngdài xiānfēng wǔtái měixué yǔ fēiyí chuántǒng wǔdǎo yǔhuì, zài guójì yìshùjié xúnyǎn zhōng huòdé le jí gāo de shēngyù.', 'Vở kịch múa dân tộc nguyên tác quy mô lớn này kết hợp mỹ học sân khấu tiên phong đương đại với ngôn ngữ vũ đạo truyền thống di sản phi vật thể, đã giành được uy tín rất cao trong các chuyến lưu diễn tại các liên hoan nghệ thuật quốc tế.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3212] [武术] (wǔshù) - võ thuật [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '武术' AND pinyin = 'wǔshù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '武术' AND pinyin = 'wǔshù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '武术'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '武术'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wǔshù',
      meaning_vi = 'võ thuật',
      example_hanzi = '练习中国传统武术不仅能强身健体，还能锤炼坚韧不拔的意志品质。',
      example_pinyin = 'Liànxí Zhōngguó chuántǒng wǔshù bùjǐn néng qiángshēn jiàntǐ, hái néng chuíliàn jiānrèn bùbá de yìzhì pǐnzhì.',
      example_vi = 'Luyện tập võ thuật truyền thống Trung Hoa không chỉ giúp cường thân kiện thể, mà còn tôi luyện phẩm chất ý chí kiên định kiên cường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '武术',
      'wǔshù',
      'võ thuật',
      'Danh từ',
      'HSK 5',
      '练习中国传统武术不仅能强身健体，还能锤炼坚韧不拔的意志品质。',
      'Liànxí Zhōngguó chuántǒng wǔshù bùjǐn néng qiángshēn jiàntǐ, hái néng chuíliàn jiānrèn bùbá de yìzhì pǐnzhì.',
      'Luyện tập võ thuật truyền thống Trung Hoa không chỉ giúp cường thân kiện thể, mà còn tôi luyện phẩm chất ý chí kiên định kiên cường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '练习中国传统武术不仅能强身健体，还能锤炼坚韧不拔的意志品质。', 'Liànxí Zhōngguó chuántǒng wǔshù bùjǐn néng qiángshēn jiàntǐ, hái néng chuíliàn jiānrèn bùbá de yìzhì pǐnzhì.', 'Luyện tập võ thuật truyền thống Trung Hoa không chỉ giúp cường thân kiện thể, mà còn tôi luyện phẩm chất ý chí kiên định kiên cường.', 'basic', 1),
      (v_id, '国际武术联合会正全力推进武术套路与散打竞技规则的标准化与国际化表达，助力武术运动早日列入夏季奥运会正式比赛项目。', 'Guójì wǔshù liánhéhuì zhèng quánlì tuījìn wǔshù tàolù yǔ sǎndǎ jìngjì guīzé de biāozhǔnhuà yǔ guójìhuà biǎodá, zhùlì wǔshù yùndòng zǎorì liè rù xiàjì Àoyùnhuì zhèngshì bǐsài xiàngmù.', 'Liên đoàn Võ thuật Quốc tế đang nỗ lực thúc đẩy tiêu chuẩn hóa và diễn đạt quốc tế hóa các quy tắc thi đấu quyền thuật và đối kháng tán thủ, trợ lực để môn võ thuật sớm được đưa vào danh mục thi đấu chính thức của Thế vận hội Mùa hè.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3213] [舞台] (wǔtái) - sân khấu, vũ đài [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '舞台' AND pinyin = 'wǔtái'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舞台' AND pinyin = 'wǔtái'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '舞台'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '舞台'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wǔtái',
      meaning_vi = 'sân khấu, vũ đài',
      example_hanzi = '聚光灯照亮了舞台中央，年轻的钢琴家从容自信地走上台向观众鞠躬致意。',
      example_pinyin = 'Jùguāngdēng zhàoliàng le wǔtái zhōngyāng, niánqīng de gāngqínjiā cóngróng zìxìn de zǒu shàng tái xiàng guānzhòng jūgōng zhìyì.',
      example_vi = 'Ánh đèn rọi sáng bừng chính giữa sân khấu, nghệ sĩ dương cầm trẻ tuổi ung dung tự tin bước lên sân khấu cúi chào cảm ơn khán giả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '舞台',
      'wǔtái',
      'sân khấu, vũ đài',
      'Danh từ',
      'HSK 5',
      '聚光灯照亮了舞台中央，年轻的钢琴家从容自信地走上台向观众鞠躬致意。',
      'Jùguāngdēng zhàoliàng le wǔtái zhōngyāng, niánqīng de gāngqínjiā cóngróng zìxìn de zǒu shàng tái xiàng guānzhòng jūgōng zhìyì.',
      'Ánh đèn rọi sáng bừng chính giữa sân khấu, nghệ sĩ dương cầm trẻ tuổi ung dung tự tin bước lên sân khấu cúi chào cảm ơn khán giả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '聚光灯照亮了舞台中央，年轻的钢琴家从容自信地走上台向观众鞠躬致意。', 'Jùguāngdēng zhàoliàng le wǔtái zhōngyāng, niánqīng de gāngqínjiā cóngróng zìxìn de zǒu shàng tái xiàng guānzhòng jūgōng zhìyì.', 'Ánh đèn rọi sáng bừng chính giữa sân khấu, nghệ sĩ dương cầm trẻ tuổi ung dung tự tin bước lên sân khấu cúi chào cảm ơn khán giả.', 'basic', 1),
      (v_id, '更加开放包容的发展格局正推动本土高新科技企业昂首阔步走向世界经济大舞台，深度参与全球产业技术标准的制定。', 'Gèngjiā kāifàng bāoróng de fāzhǎn géjú zhèng tuīdòng běntǔ gāoxīn kējì qǐyè ángshǒu-kuòbù zǒuxiàng shìjiè jīngjì dà wǔtái, shēndù cānyù quánqiú chǎnyè jìshù biāozhǔn de zhìdìng.', 'Cục diện phát triển ngày càng cởi mở và bao dung đang thúc đẩy các doanh nghiệp công nghệ cao bản địa hiên ngang sải bước vươn ra vũ đài kinh tế thế giới rộng lớn, tham gia sâu sắc vào việc thiết lập các tiêu chuẩn kỹ thuật công nghiệp toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3214] [五颜六色] (wǔyán-liùsè) - ngũ nhan lục sắc, đủ màu sắc sặc sỡ, rực rỡ sắc màu [Thành ngữ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '五颜六色' AND pinyin = 'wǔyán-liùsè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '五颜六色' AND pinyin = 'wǔyán-liùsè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '五颜六色'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '五颜六色'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Thành ngữ / Tính từ',
      pinyin = 'wǔyán-liùsè',
      meaning_vi = 'ngũ nhan lục sắc, đủ màu sắc sặc sỡ, rực rỡ sắc màu',
      example_hanzi = '春天到了，公园的花坛里盛开着五颜六色的鲜花，吸引了成群的蜜蜂和蝴蝶。',
      example_pinyin = 'Chūntiān dào le, gōngyuán de huātán lǐ shèngkāi zhe wǔyán-liùsè de xiānhuā, xīyǐn le chéngqún de mìfēng hé húdié.',
      example_vi = 'Mùa xuân đã đến, trong các bồn hoa của công viên nở rộ những bông hoa tươi đủ màu sắc sặc sỡ, thu hút từng đàn ong bướm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '五颜六色',
      'wǔyán-liùsè',
      'ngũ nhan lục sắc, đủ màu sắc sặc sỡ, rực rỡ sắc màu',
      'Thành ngữ / Tính từ',
      'HSK 5',
      '春天到了，公园的花坛里盛开着五颜六色的鲜花，吸引了成群的蜜蜂和蝴蝶。',
      'Chūntiān dào le, gōngyuán de huātán lǐ shèngkāi zhe wǔyán-liùsè de xiānhuā, xīyǐn le chéngqún de mìfēng hé húdié.',
      'Mùa xuân đã đến, trong các bồn hoa của công viên nở rộ những bông hoa tươi đủ màu sắc sặc sỡ, thu hút từng đàn ong bướm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '春天到了，公园的花坛里盛开着五颜六色的鲜花，吸引了成群的蜜蜂和蝴蝶。', 'Chūntiān dào le, gōngyuán de huātán lǐ shèngkāi zhe wǔyán-liùsè de xiānhuā, xīyǐn le chéngqún de mìfēng hé húdié.', 'Mùa xuân đã đến, trong các bồn hoa của công viên nở rộ những bông hoa tươi đủ màu sắc sặc sỡ, thu hút từng đàn ong bướm.', 'basic', 1),
      (v_id, '漫步于民族传统手工艺博览会，展厅内陈列的五颜六色的非遗扎染刺绣艺术品，展现出多民族文化的绚丽魅力。', 'Mànbù yú mínzú chuántǒng shǒugōngyì bólǎnhuì, zhǎntīng nèi chénliè de wǔyán-liùsè de fēiyí zhārǎn cìxiù yìshùpǐn, zhǎnxiàn chū duō mínzú wénhuà de xuànlì mèilì.', 'Dạo bước tại Hội chợ triển lãm thủ công mỹ nghệ truyền thống dân tộc, các tác phẩm nghệ thuật thêu thùa nhuộm buộc di sản phi vật thể đa sắc màu rực rỡ trưng bày trong gian phòng phô diễn sức quyến rũ hoa lệ của nền văn hóa đa dân tộc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3215] [雾] (wù) - sương mù, khói mù [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '雾' AND pinyin = 'wù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '雾' AND pinyin = 'wù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '雾'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '雾'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wù',
      meaning_vi = 'sương mù, khói mù',
      example_hanzi = '冬天的清晨常常会起大雾，高速公路能见度较低，驾驶机动车时必须减速慢行。',
      example_pinyin = 'Dōngtiān de qīngchén chángcháng huì qǐ dà wù, gāosù gōnglù néngjiàndù jiào dī, jiàshǐ jīdòngchē shí bìxū jiǎnsù mànxíng.',
      example_vi = 'Sáng sớm mùa đông thường hay xuất hiện sương mù dày đặc, tầm nhìn trên đường cao tốc khá thấp, khi lái xe cơ giới nhất định phải giảm tốc độ đi chậm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '雾',
      'wù',
      'sương mù, khói mù',
      'Danh từ',
      'HSK 5',
      '冬天的清晨常常会起大雾，高速公路能见度较低，驾驶机动车时必须减速慢行。',
      'Dōngtiān de qīngchén chángcháng huì qǐ dà wù, gāosù gōnglù néngjiàndù jiào dī, jiàshǐ jīdòngchē shí bìxū jiǎnsù mànxíng.',
      'Sáng sớm mùa đông thường hay xuất hiện sương mù dày đặc, tầm nhìn trên đường cao tốc khá thấp, khi lái xe cơ giới nhất định phải giảm tốc độ đi chậm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '冬天的清晨常常会起大雾，高速公路能见度较低，驾驶机动车时必须减速慢行。', 'Dōngtiān de qīngchén chángcháng huì qǐ dà wù, gāosù gōnglù néngjiàndù jiào dī, jiàshǐ jīdòngchē shí bìxū jiǎnsù mànxíng.', 'Sáng sớm mùa đông thường hay xuất hiện sương mù dày đặc, tầm nhìn trên đường cao tốc khá thấp, khi lái xe cơ giới nhất định phải giảm tốc độ đi chậm.', 'basic', 1),
      (v_id, '气象水文科研监测团队利用微波辐射计与激光雷达探空技术，对近海海雾的生消演化规律开展高时空分辨率数值模拟与预警。', 'Qìxiàng shuǐwén kēyán jiāncè tuánduì lìyòng wēibō fúshèjì yǔ jīguāng léidá tànkōng jìshù, duì jìnhǎi hǎiwù de shēng-xiāo yǎnhuà guīlǜ kāizhǎn gāo shíkōng fēnbànlǜ shùzhí mónǐ yǔ yùjǐng.', 'Đội ngũ nghiên cứu giám sát khí tượng thủy văn tận dụng máy đo bức xạ vi sóng và kỹ thuật lidar thám trắc không gian để thực hiện mô phỏng số và cảnh báo độ phân giải cao theo không gian - thời gian về quy luật hình thành, tiêu tan của sương mù trên vùng biển ven bờ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3216] [物价] (wùjià) - vật giá, giá cả hàng hóa tiêu dùng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '物价' AND pinyin = 'wùjià'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物价' AND pinyin = 'wùjià'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '物价'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物价'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wùjià',
      meaning_vi = 'vật giá, giá cả hàng hóa tiêu dùng',
      example_hanzi = '近年来粮油、蔬菜和肉类等民生物价保持平稳，极大便利了居民的日常生活。',
      example_pinyin = 'Jìnniánlái liángyóu, shūcài hé ròulèi děng mínshēng wùjià bǎochí píngwěn, jídà biànlì le jūmín de rìcháng shēnghuó.',
      example_vi = 'Những năm gần đây giá cả các mặt hàng dân sinh như lương thực thực phẩm, rau củ và thịt luôn giữ mức bình ổn, tạo thuận lợi lớn cho đời sống thường ngày của người dân.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '物价',
      'wùjià',
      'vật giá, giá cả hàng hóa tiêu dùng',
      'Danh từ',
      'HSK 5',
      '近年来粮油、蔬菜和肉类等民生物价保持平稳，极大便利了居民的日常生活。',
      'Jìnniánlái liángyóu, shūcài hé ròulèi děng mínshēng wùjià bǎochí píngwěn, jídà biànlì le jūmín de rìcháng shēnghuó.',
      'Những năm gần đây giá cả các mặt hàng dân sinh như lương thực thực phẩm, rau củ và thịt luôn giữ mức bình ổn, tạo thuận lợi lớn cho đời sống thường ngày của người dân.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '近年来粮油、蔬菜和肉类等民生物价保持平稳，极大便利了居民的日常生活。', 'Jìnniánlái liángyóu, shūcài hé ròulèi děng mínshēng wùjià bǎochí píngwěn, jídà biànlì le jūmín de rìcháng shēnghuó.', 'Những năm gần đây giá cả các mặt hàng dân sinh như lương thực thực phẩm, rau củ và thịt luôn giữ mức bình ổn, tạo thuận lợi lớn cho đời sống thường ngày của người dân.', 'basic', 1),
      (v_id, '面对严峻复杂的外部输入性通胀压力，宏观调控部门多措并举畅通大宗商品供给链，全力维持总体物价水平基本平稳。', 'Miànduì yánjùn fùzá de wàibù shūrùxìng tōngzhàng yālì, hóngguān tiáokòng bùmén duō cuò bìng jǔ chàngtōng dàzōng shāngpǐn gōngjǐliàn, quánlì wéichí zǒngtǐ wùjià shuǐpíng jīběn píngwěn.', 'Đối mặt với áp lực lạm phát nhập khẩu từ bên ngoài gay gắt phức tạp, các cơ quan điều tiết vĩ mô triển khai đồng bộ nhiều giải pháp khơi thông chuỗi cung ứng hàng hóa cơ bản, dốc toàn lực duy trì mặt bằng vật giá tổng thể cơ bản bình ổn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3217] [物理] (wùlǐ) - vật lý, môn vật lý; nguyên lý cơ học vật chất [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '物理' AND pinyin = 'wùlǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物理' AND pinyin = 'wùlǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '物理'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wùlǐ',
      meaning_vi = 'vật lý, môn vật lý; nguyên lý cơ học vật chất',
      example_hanzi = '他在中学阶段就对物理实验产生了浓厚兴趣，课余时间经常动手制作简易电路模型。',
      example_pinyin = 'Tā zài zhōngxué jiēduàn jiù duì wùlǐ shíyàn chǎnshēng le nónghòu xìngqù, kèyú shíjiān chángcháng dòngshǒu zhìzuò jiǎnyì diànlù móxíng.',
      example_vi = 'Cậu ấy ngay từ thời trung học đã nảy sinh niềm say mê sâu sắc với các thí nghiệm vật lý, thời gian ngoài giờ học thường tự tay chế tạo các mô hình mạch điện đơn giản.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '物理',
      'wùlǐ',
      'vật lý, môn vật lý; nguyên lý cơ học vật chất',
      'Danh từ',
      'HSK 5',
      '他在中学阶段就对物理实验产生了浓厚兴趣，课余时间经常动手制作简易电路模型。',
      'Tā zài zhōngxué jiēduàn jiù duì wùlǐ shíyàn chǎnshēng le nónghòu xìngqù, kèyú shíjiān chángcháng dòngshǒu zhìzuò jiǎnyì diànlù móxíng.',
      'Cậu ấy ngay từ thời trung học đã nảy sinh niềm say mê sâu sắc với các thí nghiệm vật lý, thời gian ngoài giờ học thường tự tay chế tạo các mô hình mạch điện đơn giản.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他在中学阶段就对物理实验产生了浓厚兴趣，课余时间经常动手制作简易电路模型。', 'Tā zài zhōngxué jiēduàn jiù duì wùlǐ shíyàn chǎnshēng le nónghòu xìngqù, kèyú shíjiān chángcháng dòngshǒu zhìzuò jiǎnyì diànlù móxíng.', 'Cậu ấy ngay từ thời trung học đã nảy sinh niềm say mê sâu sắc với các thí nghiệm vật lý, thời gian ngoài giờ học thường tự tay chế tạo các mô hình mạch điện đơn giản.', 'basic', 1),
      (v_id, '凝聚态物理与拓扑量子物态的前沿理论突破，为下一代低能耗室温超导芯片与量子计算机硬件的研制开辟了全新路径。', 'Níngjùtài wùlǐ yǔ tuòpū liàngzǐ wùtài de qiányán lǐlùn tūpò, wèi xiàyīdài dīnénghào shìwēn chāodǎo xīnpiàn yǔ liàngzǐ jìsuànjī yìngjiàn de yánzhì kāipì le quánxīn lùjìng.', 'Những đột phá lý thuyết tiền duyên trong vật lý chất ngưng tụ và trạng thái lượng tử tô-pô đã mở ra con đường hoàn toàn mới cho việc nghiên cứu chế tạo chip siêu dẫn nhiệt độ phòng tiêu hao năng lượng thấp và phần cứng máy tính lượng tử thế hệ tiếp theo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3218] [物品] (wùpǐn) - vật phẩm, đồ đạc, hàng hóa [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '物品' AND pinyin = 'wùpǐn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物品' AND pinyin = 'wùpǐn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '物品'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物品'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wùpǐn',
      meaning_vi = 'vật phẩm, đồ đạc, hàng hóa',
      example_hanzi = '乘客乘坐公共交通工具出行时，必须将随身携带的行李物品放置在安检机上接受检查。',
      example_pinyin = 'Chéngkè chéngzuò gōnggòng jiāotōng gōngjù chūxíng shí, bìxū jiāng suíshēn xiédài de xínglǐ wùpǐn fàngzhì zài ānjiǎnjī shàng jiēshòu jiǎnchá.',
      example_vi = 'Hành khách khi đi lại bằng phương tiện giao thông công cộng bắt buộc phải đặt đồ đạc hành lý mang theo bên mình lên máy soi an ninh để tiếp nhận kiểm tra.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '物品',
      'wùpǐn',
      'vật phẩm, đồ đạc, hàng hóa',
      'Danh từ',
      'HSK 5',
      '乘客乘坐公共交通工具出行时，必须将随身携带的行李物品放置在安检机上接受检查。',
      'Chéngkè chéngzuò gōnggòng jiāotōng gōngjù chūxíng shí, bìxū jiāng suíshēn xiédài de xínglǐ wùpǐn fàngzhì zài ānjiǎnjī shàng jiēshòu jiǎnchá.',
      'Hành khách khi đi lại bằng phương tiện giao thông công cộng bắt buộc phải đặt đồ đạc hành lý mang theo bên mình lên máy soi an ninh để tiếp nhận kiểm tra.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '乘客乘坐公共交通工具出行时，必须将随身携带的行李物品放置在安检机上接受检查。', 'Chéngkè chéngzuò gōnggòng jiāotōng gōngjù chūxíng shí, bìxū jiāng suíshēn xiédài de xínglǐ wùpǐn fàngzhì zài ānjiǎnjī shàng jiēshòu jiǎnchá.', 'Hành khách khi đi lại bằng phương tiện giao thông công cộng bắt buộc phải đặt đồ đạc hành lý mang theo bên mình lên máy soi an ninh để tiếp nhận kiểm tra.', 'basic', 1),
      (v_id, '现代智慧物流园区依托物联网射频识别与区块链溯源技术，实现高附加值医药物资和冷链食品物品的全流程闭环监管。', 'Xiàndài zhìhuì wùliú yuánqū yītuō wùliánwǎng shèpín shíbié yǔ qūkuàiliàn sùyuán jìshù, shíxiàn gāofùjiāzhí yīyào wùzī hé lěngliàn shípǐn wùpǐn de quán-liúchéng bìhuán jiānguǎn.', 'Khu công viên logistics thông minh hiện đại dựa trên công nghệ nhận dạng qua tần số vô tuyến RFID và truy xuất nguồn gốc blockchain để thực hiện việc giám sát khép kín toàn bộ quy trình các vật phẩm thực phẩm chuỗi lạnh và vật tư y tế giá trị gia tăng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3219] [物业] (wùyè) - quản lý tòa nhà, ban quản lý bất động sản/nhà đất [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '物业' AND pinyin = 'wùyè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物业' AND pinyin = 'wùyè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '物业'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物业'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wùyè',
      meaning_vi = 'quản lý tòa nhà, ban quản lý bất động sản/nhà đất',
      example_hanzi = '小区的物业管理非常规范，不仅保安人员全天巡逻，公共区域的绿化与卫生保洁也十分到位。',
      example_pinyin = 'Xiǎoqū de wùyè guǎnlǐ fēicháng guīfàn, bùjǐn bǎo’ān rényuán quántiān xúnluó, gōnggòng qūyù de lǜhuà yǔ wèishēng bǎojié yě shífēn dàowèi.',
      example_vi = 'Ban quản lý tòa nhà khu dân cư rất quy củ, không chỉ nhân viên bảo vệ tuần tra suốt ngày đêm, mà mảng cây xanh và vệ sinh làm sạch khu vực công cộng cũng rất chu đáo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '物业',
      'wùyè',
      'quản lý tòa nhà, ban quản lý bất động sản/nhà đất',
      'Danh từ',
      'HSK 5',
      '小区的物业管理非常规范，不仅保安人员全天巡逻，公共区域的绿化与卫生保洁也十分到位。',
      'Xiǎoqū de wùyè guǎnlǐ fēicháng guīfàn, bùjǐn bǎo’ān rényuán quántiān xúnluó, gōnggòng qūyù de lǜhuà yǔ wèishēng bǎojié yě shífēn dàowèi.',
      'Ban quản lý tòa nhà khu dân cư rất quy củ, không chỉ nhân viên bảo vệ tuần tra suốt ngày đêm, mà mảng cây xanh và vệ sinh làm sạch khu vực công cộng cũng rất chu đáo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小区的物业管理非常规范，不仅保安人员全天巡逻，公共区域的绿化与卫生保洁也十分到位。', 'Xiǎoqū de wùyè guǎnlǐ fēicháng guīfàn, bùjǐn bǎo’ān rényuán quántiān xúnluó, gōnggòng qūyù de lǜhuà yǔ wèishēng bǎojié yě shífēn dàowèi.', 'Ban quản lý tòa nhà khu dân cư rất quy củ, không chỉ nhân viên bảo vệ tuần tra suốt ngày đêm, mà mảng cây xanh và vệ sinh làm sạch khu vực công cộng cũng rất chu đáo.', 'basic', 1),
      (v_id, '住房和城乡建设部门积极推动智慧物业融入基层社区精细化治理，依托移动端数字工单闭环提升物业应急维修响应效能。', 'Zhùfáng hé chéng-xiāng jiànshè bùmén jījí tuīdòng zhìhuì wùyè róngrù jīcéng shèqū jīngxìhuà zhìlǐ, yītuō yídòngduān shùzì gōngdān bìhuán tíshēng wùyè yìngjí wéixiū xiǎngyìng xiàonéng.', 'Bộ Xây dựng nhà ở và đô thị - nông thôn tích cực thúc đẩy ban quản lý tòa nhà thông minh hòa nhập vào quản trị tinh gọn cộng đồng cơ sở, dựa vào chu trình phiếu công tác số hóa trên thiết bị di động để nâng cao hiệu năng phản ứng sửa chữa khẩn cấp của bộ phận quản lý bất động sản.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3220] [物质] (wùzhì) - vật chất, chất thể; điều kiện vật chất [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '物质' AND pinyin = 'wùzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物质' AND pinyin = 'wùzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '物质'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '物质'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'wùzhì',
      meaning_vi = 'vật chất, chất thể; điều kiện vật chất',
      example_hanzi = '随着国民经济的稳步持续增长，人民群众的物质生活水平得到了显著提高。',
      example_pinyin = 'Suízhe guómín jīngjì de wěnbù chíxù zēngzhǎng, rénmín qúnzhòng de wùzhì shēnghuó shuǐpíng dédào le xiǎnzhù tígāo.',
      example_vi = 'Cùng với sự tăng trưởng ổn định bền vững của nền kinh tế quốc dân, mức sống vật chất của quần chúng nhân dân đã được nâng cao rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '物质',
      'wùzhì',
      'vật chất, chất thể; điều kiện vật chất',
      'Danh từ',
      'HSK 5',
      '随着国民经济的稳步持续增长，人民群众的物质生活水平得到了显著提高。',
      'Suízhe guómín jīngjì de wěnbù chíxù zēngzhǎng, rénmín qúnzhòng de wùzhì shēnghuó shuǐpíng dédào le xiǎnzhù tígāo.',
      'Cùng với sự tăng trưởng ổn định bền vững của nền kinh tế quốc dân, mức sống vật chất của quần chúng nhân dân đã được nâng cao rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着国民经济的稳步持续增长，人民群众的物质生活水平得到了显著提高。', 'Suízhe guómín jīngjì de wěnbù chíxù zēngzhǎng, rénmín qúnzhòng de wùzhì shēnghuó shuǐpíng dédào le xiǎnzhù tígāo.', 'Cùng với sự tăng trưởng ổn định bền vững của nền kinh tế quốc dân, mức sống vật chất của quần chúng nhân dân đã được nâng cao rõ rệt.', 'basic', 1),
      (v_id, '高能物理大科学装置通过粒子高速对撞实验，致力于深入探索微观物质的基本结构与宇宙暗物质的神秘本质。', 'Gāonéng wùlǐ dà kēxué zhuāngzhì tōngguò lìzǐ gāosù duìzhuàng shíyàn, zhìlì yú shēnrù tànsuǒ wēiguān wùzhì de jīběn jiégòu yǔ yǔzhòu ànwùzhì de shénmì běnzhì.', 'Thiết bị khoa học lớn vật lý năng lượng cao thông qua các thí nghiệm va chạm hạt tốc độ cao dốc sức đi sâu khám phá cấu trúc cơ bản của vật chất vi mô và bản chất thần bí của vật chất tối trong vũ trụ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3221] [西餐] (xīcān) - món ăn phương Tây, đồ ăn Tây [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '西餐' AND pinyin = 'xīcān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '西餐' AND pinyin = 'xīcān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '西餐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '西餐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xīcān',
      meaning_vi = 'món ăn phương Tây, đồ ăn Tây',
      example_hanzi = '周末晚上，一家人来到市中心的一家法式餐厅享用精致美味的西餐。',
      example_pinyin = 'Zhōumò wǎnshang, yījiārén lái dào shìzhōngxīn de yī jiā Fǎshì cāntīng xiǎngyòng jīngzhì měiwèi de xīcān.',
      example_vi = 'Tối cuối tuần, cả gia đình đến một nhà hàng Pháp ở trung tâm thành phố để thưởng thức bữa đồ ăn Tây tinh tế và thơm ngon.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '西餐',
      'xīcān',
      'món ăn phương Tây, đồ ăn Tây',
      'Danh từ',
      'HSK 5',
      '周末晚上，一家人来到市中心的一家法式餐厅享用精致美味的西餐。',
      'Zhōumò wǎnshang, yījiārén lái dào shìzhōngxīn de yī jiā Fǎshì cāntīng xiǎngyòng jīngzhì měiwèi de xīcān.',
      'Tối cuối tuần, cả gia đình đến một nhà hàng Pháp ở trung tâm thành phố để thưởng thức bữa đồ ăn Tây tinh tế và thơm ngon.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末晚上，一家人来到市中心的一家法式餐厅享用精致美味的西餐。', 'Zhōumò wǎnshang, yījiārén lái dào shìzhōngxīn de yī jiā Fǎshì cāntīng xiǎngyòng jīngzhì měiwèi de xīcān.', 'Tối cuối tuần, cả gia đình đến một nhà hàng Pháp ở trung tâm thành phố để thưởng thức bữa đồ ăn Tây tinh tế và thơm ngon.', 'basic', 1),
      (v_id, '国际星级酒店餐饮行政总厨将东方传统草本香料与现代西餐低温慢煮分子料理技法相融合，打造出独具匠心的跨界美馔。', 'Guójì xīngjí jiǔdiàn cānyǐn xíngzhèng zǒngchú jiāng Dōngfāng chuántǒng cǎoběn xiāngliào yǔ xiàndài xīcān dīwēn mànzhǔ fēnzǐ liàolǐ jìfǎ xiāng rónghé, dǎzào chū dújù-jiàngxīn de kuàjiè měizhuàn.', 'Bếp trưởng điều hành ẩm thực của khách sạn đẳng cấp quốc tế kết hợp các loại hương liệu thảo mộc truyền thống phương Đông với kỹ thuật ẩm thực phân tử nấu chậm nhiệt độ thấp của món Tây hiện đại, tạo nên những món mỹ vị giao thoa độc đáo đầy sáng tạo.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3222] [吸管] (xīguǎn) - ống hút [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '吸管' AND pinyin = 'xīguǎn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '吸管' AND pinyin = 'xīguǎn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '吸管'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '吸管'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xīguǎn',
      meaning_vi = 'ống hút',
      example_hanzi = '为了减少白色塑料污染，越来越多的奶茶店和咖啡馆开始主动向顾客提供纸质吸管。',
      example_pinyin = 'Wèile jiǎnshǎo báisè sùliào wūrǎn, yuèláiyuè duō de nǎichádiàn hé kāfēiguǎn kāishǐ zhǔdòng xiàng gùkè tígōng zhǐzhì xīguǎn.',
      example_vi = 'Để giảm bớt ô nhiễm rác thải nhựa trắng, ngày càng nhiều quán trà sữa và quán cà phê bắt đầu chủ động cung cấp ống hút giấy cho khách hàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '吸管',
      'xīguǎn',
      'ống hút',
      'Danh từ',
      'HSK 5',
      '为了减少白色塑料污染，越来越多的奶茶店和咖啡馆开始主动向顾客提供纸质吸管。',
      'Wèile jiǎnshǎo báisè sùliào wūrǎn, yuèláiyuè duō de nǎichádiàn hé kāfēiguǎn kāishǐ zhǔdòng xiàng gùkè tígōng zhǐzhì xīguǎn.',
      'Để giảm bớt ô nhiễm rác thải nhựa trắng, ngày càng nhiều quán trà sữa và quán cà phê bắt đầu chủ động cung cấp ống hút giấy cho khách hàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '为了减少白色塑料污染，越来越多的奶茶店和咖啡馆开始主动向顾客提供纸质吸管。', 'Wèile jiǎnshǎo báisè sùliào wūrǎn, yuèláiyuè duō de nǎichádiàn hé kāfēiguǎn kāishǐ zhǔdòng xiàng gùkè tígōng zhǐzhì xīguǎn.', 'Để giảm bớt ô nhiễm rác thải nhựa trắng, ngày càng nhiều quán trà sữa và quán cà phê bắt đầu chủ động cung cấp ống hút giấy cho khách hàng.', 'basic', 1),
      (v_id, '为积极贯彻国家“限塑禁塑”环保政策，食品包装制造企业加速规模化生产以聚乳酸为基材的全生物降解环保吸管。', 'Wèi jījí guànchè guójiā “xiànsù jīnsù” huánbǎo zhèngcè, shípǐn bāozhuāng zhìzào qǐyè jiāsù guīmóhuà shēngchǎn yǐ jùrǔsuān wéi jīcái de quán-shēngwù jiàngjiě huánbǎo xīguǎn.', 'Nhằm quán triệt tích cực chính sách bảo vệ môi trường "hạn chế và cấm đồ nhựa" của quốc gia, các doanh nghiệp sản xuất bao bì thực phẩm đẩy nhanh sản xuất quy mô lớn ống hút thân thiện với môi trường tự phân hủy sinh học hoàn toàn trên nền chất liệu axit polylactic (PLA).', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3223] [吸收] (xīshōu) - hấp thu, tiếp thu, hút, thu nạp [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '吸收' AND pinyin = 'xīshōu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '吸收' AND pinyin = 'xīshōu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '吸收'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '吸收'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xīshōu',
      meaning_vi = 'hấp thu, tiếp thu, hút, thu nạp',
      example_hanzi = '绿色植物通过光合作用吸收空气中的二氧化碳，并释放出维持生命所必需的氧气。',
      example_pinyin = 'Lǜsè zhíwù tōngguò guānghé zuòyòng xīshōu kōngqì zhōng de èryǎnghuàtàn, bìng shìfàng chū wéichí shēngmìng suǒ bìxū de yǎngqì.',
      example_vi = 'Cây xanh thông qua quá trình quang hợp hấp thu khí CO2 trong không khí và giải phóng ra lượng khí oxy cần thiết duy trì sự sống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '吸收',
      'xīshōu',
      'hấp thu, tiếp thu, hút, thu nạp',
      'Động từ',
      'HSK 5',
      '绿色植物通过光合作用吸收空气中的二氧化碳，并释放出维持生命所必需的氧气。',
      'Lǜsè zhíwù tōngguò guānghé zuòyòng xīshōu kōngqì zhōng de èryǎnghuàtàn, bìng shìfàng chū wéichí shēngmìng suǒ bìxū de yǎngqì.',
      'Cây xanh thông qua quá trình quang hợp hấp thu khí CO2 trong không khí và giải phóng ra lượng khí oxy cần thiết duy trì sự sống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '绿色植物通过光合作用吸收空气中的二氧化碳，并释放出维持生命所必需的氧气。', 'Lǜsè zhíwù tōngguò guānghé zuòyòng xīshōu kōngqì zhōng de èryǎnghuàtàn, bìng shìfàng chū wéichí shēngmìng suǒ bìxū de yǎngqì.', 'Cây xanh thông qua quá trình quang hợp hấp thu khí CO2 trong không khí và giải phóng ra lượng khí oxy cần thiết duy trì sự sống.', 'basic', 1),
      (v_id, '高新区科技孵化平台积极支持本土高新技术企业在消化吸收引进的先进技术基础上，实施全链条自主知识产权再创新。', 'Gāoxīnqū kējì fūhuà píngtái jījí zhīchí běntǔ gāoxīnjìshù qǐyè zài xiāohuà xīshōu yǐnjìn de xiānjìn jìshù jīchǔ shàng, shíshī quán-liàntiáo zìzhǔ zhīshi chǎnquán zàichuàngxīn.', 'Nền tảng ươm tạo công nghệ khu công nghệ cao tích cực ủng hộ các doanh nghiệp công nghệ cao bản địa trên cơ sở tiêu hóa hấp thụ công nghệ tiên tiến nhập khẩu thực hiện tái đổi mới sáng tạo sở hữu trí tuệ tự chủ toàn diện theo chuỗi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3224] [西装] (xīzhuāng) - âu phục, bộ com-lê, áo vest [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '西装' AND pinyin = 'xīzhuāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '西装' AND pinyin = 'xīzhuāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '西装'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '西装'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xīzhuāng',
      meaning_vi = 'âu phục, bộ com-lê, áo vest',
      example_hanzi = '参加正式的国际学术交流会议时，男士通常需要穿着整洁得体的西装。',
      example_pinyin = 'Cānjiā zhèngshì de guójì xuéshù jiāoliú huìyì shí, nánshì tōngcháng xūyào chuānzhuó zhěngjié détǐ de xīzhuāng.',
      example_vi = 'Khi tham gia hội nghị giao lưu học thuật quốc tế trang trọng, nam giới thông thường cần mặc bộ âu phục gọn gàng và chỉnh tề.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '西装',
      'xīzhuāng',
      'âu phục, bộ com-lê, áo vest',
      'Danh từ',
      'HSK 5',
      '参加正式的国际学术交流会议时，男士通常需要穿着整洁得体的西装。',
      'Cānjiā zhèngshì de guójì xuéshù jiāoliú huìyì shí, nánshì tōngcháng xūyào chuānzhuó zhěngjié détǐ de xīzhuāng.',
      'Khi tham gia hội nghị giao lưu học thuật quốc tế trang trọng, nam giới thông thường cần mặc bộ âu phục gọn gàng và chỉnh tề.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '参加正式的国际学术交流会议时，男士通常需要穿着整洁得体的西装。', 'Cānjiā zhèngshì de guójì xuéshù jiāoliú huìyì shí, nánshì tōngcháng xūyào chuānzhuó zhěngjié détǐ de xīzhuāng.', 'Khi tham gia hội nghị giao lưu học thuật quốc tế trang trọng, nam giới thông thường cần mặc bộ âu phục gọn gàng và chỉnh tề.', 'basic', 1),
      (v_id, '高级定制服饰工坊甄选进口顶级纯天然羊绒面料，结合传统手工全麻衬工艺，为商界领袖量身剪裁挺括舒适的高端商务西装。', 'Gāojí dìngzhì fúshì gōngfāng zhēnxuǎn jìnkǒu dǐngjí chún-tiānrán yángróng miànliào, jiéhé chuántǒng shǒugōng quán-máchèn gōngyì, wèi shāngjiè lǐngxiù liángshēn jiǎncái tǐngguò shūshì de gāoduān shāngwù xīzhuāng.', 'Xưởng may phục trang cao cấp tuyển chọn vải cashmere thuần tự nhiên thượng hạng nhập khẩu, kết hợp kỹ thuật may lót canvas hoàn toàn thủ công truyền thống để cắt may đo ni đóng giày những bộ vest doanh nhân cao cấp đứng dáng và êm ái cho các nhà lãnh đạo thương giới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3225] [戏] (xì) - vở kịch, tuồng, sân khấu kịch; trêu đùa, diễn trò [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '戏' AND pinyin = 'xì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '戏' AND pinyin = 'xì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '戏'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '戏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'xì',
      meaning_vi = 'vở kịch, tuồng, sân khấu kịch; trêu đùa, diễn trò',
      example_hanzi = '周末爷爷总喜欢坐在老藤椅上，一边喝着热茶一边听收音机里播放的传统京剧戏曲。',
      example_pinyin = 'Zhōumò yéye zǒng xǐhuan zuò zài lǎo téngyǐ shàng, yībiān hē zhe rèchá yībiān tīng shōuyīnjī lǐ bōfàng de chuántǒng Jīngjù xìqǔ.',
      example_vi = 'Cuối tuần ông nội luôn thích ngồi trên chiếc ghế mây cũ, vừa nhâm nhi chén trà nóng vừa nghe những vở tuồng kinh kịch truyền thống phát trên radio.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '戏',
      'xì',
      'vở kịch, tuồng, sân khấu kịch; trêu đùa, diễn trò',
      'Danh từ / Động từ',
      'HSK 5',
      '周末爷爷总喜欢坐在老藤椅上，一边喝着热茶一边听收音机里播放的传统京剧戏曲。',
      'Zhōumò yéye zǒng xǐhuan zuò zài lǎo téngyǐ shàng, yībiān hē zhe rèchá yībiān tīng shōuyīnjī lǐ bōfàng de chuántǒng Jīngjù xìqǔ.',
      'Cuối tuần ông nội luôn thích ngồi trên chiếc ghế mây cũ, vừa nhâm nhi chén trà nóng vừa nghe những vở tuồng kinh kịch truyền thống phát trên radio.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '周末爷爷总喜欢坐在老藤椅上，一边喝着热茶一边听收音机里播放的传统京剧戏曲。', 'Zhōumò yéye zǒng xǐhuan zuò zài lǎo téngyǐ shàng, yībiān hē zhe rèchá yībiān tīng shōuyīnjī lǐ bōfàng de chuántǒng Jīngjù xìqǔ.', 'Cuối tuần ông nội luôn thích ngồi trên chiếc ghế mây cũ, vừa nhâm nhi chén trà nóng vừa nghe những vở tuồng kinh kịch truyền thống phát trên radio.', 'basic', 1),
      (v_id, '传统戏剧院团通过数字化全息舞台投影与现代跨界剧场叙事，让古老的地方戏重新焕发出时代活力并成功吸引广大年轻观众。', 'Chuántǒng xìjù yuàntuán tōngguò shùzìhuà quánxī wǔtái tóuyǐng yǔ xiàndài kuàjiè jùchǎng xùshì, ràng gǔlǎo de dìfāngxì chóngxīn huànfā chū shídài huólì bìng chénggōng xīyǐn guǎngdà niánqīng guānzhòng.', 'Đoàn kịch nghệ truyền thống thông qua công nghệ trình chiếu sân khấu hologram kỹ thuật số và lối tự sự nhà hát giao thoa hiện đại, đã giúp cho những vở tuồng địa phương cổ xưa hồi sinh mạnh mẽ sức sống thời đại và thu hút thành công đông đảo khán giả trẻ tuổi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3226] [系] (xì) - khoa (đại học), hệ thống; thắt, buộc [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '系' AND pinyin = 'xì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '系' AND pinyin = 'xì'
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
      word_type = 'Danh từ / Động từ',
      pinyin = 'xì',
      meaning_vi = 'khoa (đại học), hệ thống; thắt, buộc',
      example_hanzi = '他大学毕业于计算机软件工程系，随后进入了一家知名科技企业从事系统架构研发。',
      example_pinyin = 'Tā dàxué bìyè yú jìsuànjī ruǎnjiàn gōngchéng xì, suíhòu jìnrù le yī jiā zhīmíng kējì qǐyè cóngshì xìtǒng jiàgòu yánfā.',
      example_vi = 'Anh ấy tốt nghiệp đại học khoa kỹ thuật phần mềm máy tính, sau đó vào làm việc tại một doanh nghiệp công nghệ nổi tiếng phụ trách nghiên cứu phát triển kiến trúc hệ thống.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '系',
      'xì',
      'khoa (đại học), hệ thống; thắt, buộc',
      'Danh từ / Động từ',
      'HSK 5',
      '他大学毕业于计算机软件工程系，随后进入了一家知名科技企业从事系统架构研发。',
      'Tā dàxué bìyè yú jìsuànjī ruǎnjiàn gōngchéng xì, suíhòu jìnrù le yī jiā zhīmíng kējì qǐyè cóngshì xìtǒng jiàgòu yánfā.',
      'Anh ấy tốt nghiệp đại học khoa kỹ thuật phần mềm máy tính, sau đó vào làm việc tại một doanh nghiệp công nghệ nổi tiếng phụ trách nghiên cứu phát triển kiến trúc hệ thống.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '他大学毕业于计算机软件工程系，随后进入了一家知名科技企业从事系统架构研发。', 'Tā dàxué bìyè yú jìsuànjī ruǎnjiàn gōngchéng xì, suíhòu jìnrù le yī jiā zhīmíng kējì qǐyè cóngshì xìtǒng jiàgòu yánfā.', 'Anh ấy tốt nghiệp đại học khoa kỹ thuật phần mềm máy tính, sau đó vào làm việc tại một doanh nghiệp công nghệ nổi tiếng phụ trách nghiên cứu phát triển kiến trúc hệ thống.', 'basic', 1),
      (v_id, '无论乘坐私家车还是长途客车出行，乘车人员全员全程规范系好安全带是防范交通意外伤亡最直接有效的生命防线。', 'Wúlùn chéngzuò sījiāchē háishi chángtú kèchē chūxíng, chéngchē rényuán quányuán quánchéng guīfàn xì hǎo ānquándài shì fángfàn jiāotōng yìwài shāngwáng zuì zhíjiē yǒuxiào de shēngmìng fángxiàn.', 'Dù đi lại bằng xe con riêng hay xe khách đường dài, toàn bộ người ngồi trên xe thắt dây an toàn đúng quy cách trong suốt hành trình chính là tuyến phòng thủ sự sống hữu hiệu và trực tiếp nhất để ngăn ngừa thương vong tai nạn giao thông.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3227] [细节] (xìjié) - chi tiết, tiểu tiết [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '细节' AND pinyin = 'xìjié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '细节' AND pinyin = 'xìjié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '细节'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '细节'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xìjié',
      meaning_vi = 'chi tiết, tiểu tiết',
      example_hanzi = '“细节决定成败”，在撰写求职简历或商业策划书时一定要仔细核对每一个关键细节。',
      example_pinyin = '“Xìjié juédìng chéngbài”, zài zhuànxiě qiúzhí jiǎnlì huò shāngyè cèhuàshū shí yīdìng yào zǐxì héduì měi yī gè guānjiàn xìjié.',
      example_vi = '"Chi tiết quyết định thành bại", khi viết sơ yếu lý lịch xin việc hoặc đề án thương mại nhất định phải kiểm tra kỹ lưỡng từng chi tiết then chốt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '细节',
      'xìjié',
      'chi tiết, tiểu tiết',
      'Danh từ',
      'HSK 5',
      '“细节决定成败”，在撰写求职简历或商业策划书时一定要仔细核对每一个关键细节。',
      '“Xìjié juédìng chéngbài”, zài zhuànxiě qiúzhí jiǎnlì huò shāngyè cèhuàshū shí yīdìng yào zǐxì héduì měi yī gè guānjiàn xìjié.',
      '"Chi tiết quyết định thành bại", khi viết sơ yếu lý lịch xin việc hoặc đề án thương mại nhất định phải kiểm tra kỹ lưỡng từng chi tiết then chốt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '“细节决定成败”，在撰写求职简历或商业策划书时一定要仔细核对每一个关键细节。', '“Xìjié juédìng chéngbài”, zài zhuànxiě qiúzhí jiǎnlì huò shāngyè cèhuàshū shí yīdìng yào zǐxì héduì měi yī gè guānjiàn xìjié.', '"Chi tiết quyết định thành bại", khi viết sơ yếu lý lịch xin việc hoặc đề án thương mại nhất định phải kiểm tra kỹ lưỡng từng chi tiết then chốt.', 'basic', 1),
      (v_id, '高精度航空发动机叶片制造工艺对三维型面公差尺寸与微观晶体结构的细节控制严苛到了微米级别。', 'Gāojīngdù hángkōng fādòngjī yèpiàn zhìzào gōngyì duì sānwéi xíngmiàn gōngchà chǐcunn yǔ wēiguān jīngtǐ jiégòu de xìjié kòngzhì yánkē dào le wēimǐ jíbié.', 'Quy trình chế tạo cánh tuabin động cơ hàng không độ chính xác cao kiểm soát các chi tiết về kích thước dung sai biên dạng 3D và cấu trúc vi tinh thể nghiêm ngặt tới từng micromet.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3228] [戏剧] (xìjù) - kịch, sân khấu kịch, nghệ thuật kịch [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '戏剧' AND pinyin = 'xìjù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '戏剧' AND pinyin = 'xìjù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '戏剧'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '戏剧'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xìjù',
      meaning_vi = 'kịch, sân khấu kịch, nghệ thuật kịch',
      example_hanzi = '这所艺术学院的戏剧表演系每年都会面向全国公开选拔极具潜力的青年话剧演员。',
      example_pinyin = 'Zhè suǒ yìshù xuéyuàn de xìjù biǎoyǎn xì měinián dōu huì miànxiàng quánguó gōngkāi xuǎnbá jí jù qiánlì de qīngnián huàjù yǎnyuán.',
      example_vi = 'Khoa diễn xuất kịch nghệ của học viện nghệ thuật này hàng năm đều tuyển chọn công khai trên toàn quốc các diễn viên kịch nói trẻ tuổi đầy tiềm năng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '戏剧',
      'xìjù',
      'kịch, sân khấu kịch, nghệ thuật kịch',
      'Danh từ',
      'HSK 5',
      '这所艺术学院的戏剧表演系每年都会面向全国公开选拔极具潜力的青年话剧演员。',
      'Zhè suǒ yìshù xuéyuàn de xìjù biǎoyǎn xì měinián dōu huì miànxiàng quánguó gōngkāi xuǎnbá jí jù qiánlì de qīngnián huàjù yǎnyuán.',
      'Khoa diễn xuất kịch nghệ của học viện nghệ thuật này hàng năm đều tuyển chọn công khai trên toàn quốc các diễn viên kịch nói trẻ tuổi đầy tiềm năng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这所艺术学院的戏剧表演系每年都会面向全国公开选拔极具潜力的青年话剧演员。', 'Zhè suǒ yìshù xuéyuàn de xìjù biǎoyǎn xì měinián dōu huì miànxiàng quánguó gōngkāi xuǎnbá jí jù qiánlì de qīngnián huàjù yǎnyuán.', 'Khoa diễn xuất kịch nghệ của học viện nghệ thuật này hàng năm đều tuyển chọn công khai trên toàn quốc các diễn viên kịch nói trẻ tuổi đầy tiềm năng.', 'basic', 1),
      (v_id, '现代实验先锋戏剧通过打破传统镜框式舞台的第四堵墙，实现了演员与台下观众沉浸式的情感互动与哲思共鸣。', 'Xiàndài shíyàn xiānfēng xìjù tōngguò dǎpò chuántǒng jìngkuàngshì wǔtái de dì sì dǔ qiáng, shíxiàn le yǎnyuán yǔ táixià guānzhòng chénjìnshì de qínggǎn hùdòng yǔ zhésī gòngmíng.', 'Nghệ thuật kịch tiên phong thể nghiệm hiện đại thông qua việc phá vỡ "bức tường thứ tư" của sân khấu khung truyền thống, đã hiện thực hóa sự tương tác cảm xúc và đồng cảm triết học đắm chìm giữa diễn viên và khán giả dưới khán đài.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3229] [系统] (xìtǒng) - hệ thống; có tính hệ thống [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '系统' AND pinyin = 'xìtǒng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '系统' AND pinyin = 'xìtǒng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '系统'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '系统'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'xìtǒng',
      meaning_vi = 'hệ thống; có tính hệ thống',
      example_hanzi = '经过信息技术部门的全面维护升级，公司的内部办公自动化系统运行更加稳定流畅。',
      example_pinyin = 'Jīngguò xìnxī jìshù bùmén de quánmiàn wéihù shēngjí, gōngsī de nèibù bàngōng zìdònghuà xìtǒng yùnxíng gèngjiā wěndìng liúchàng.',
      example_vi = 'Sau khi được phòng công nghệ thông tin nâng cấp và bảo trì toàn diện, hệ thống tự động hóa văn phòng nội bộ của công ty vận hành ổn định và trơn tru hơn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '系统',
      'xìtǒng',
      'hệ thống; có tính hệ thống',
      'Danh từ / Tính từ',
      'HSK 5',
      '经过信息技术部门的全面维护升级，公司的内部办公自动化系统运行更加稳定流畅。',
      'Jīngguò xìnxī jìshù bùmén de quánmiàn wéihù shēngjí, gōngsī de nèibù bàngōng zìdònghuà xìtǒng yùnxíng gèngjiā wěndìng liúchàng.',
      'Sau khi được phòng công nghệ thông tin nâng cấp và bảo trì toàn diện, hệ thống tự động hóa văn phòng nội bộ của công ty vận hành ổn định và trơn tru hơn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过信息技术部门的全面维护升级，公司的内部办公自动化系统运行更加稳定流畅。', 'Jīngguò xìnxī jìshù bùmén de quánmiàn wéihù shēngjí, gōngsī de nèibù bàngōng zìdònghuà xìtǒng yùnxíng gèngjiā wěndìng liúchàng.', 'Sau khi được phòng công nghệ thông tin nâng cấp và bảo trì toàn diện, hệ thống tự động hóa văn phòng nội bộ của công ty vận hành ổn định và trơn tru hơn.', 'basic', 1),
      (v_id, '研发团队采用云原生微服务架构与分布式容灾多活机制，成功构建了支撑亿级并发吞吐量的实时金融交易核心系统。', 'Yánfā tuánduì cǎiyòng yún yuánshēng wēifúwù jiàgòu yǔ fēnbùshì róngzāi duōhuó jīzhì, chénggōng gòujiàn le zhīchēng yì jí bīngfā tūtùliàng de shíshí jīnróng jiāoyì héxīn xìtǒng.', 'Đội ngũ R&D áp dụng kiến trúc microservices thuần đám mây và cơ chế phòng chống thảm họa đa trung tâm phân tán, xây dựng thành công hệ thống lõi giao dịch tài chính thời gian thực đáp ứng khối lượng xử lý đồng thời hàng trăm triệu lượt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3230] [下载] (xiàzài) - tải xuống, download [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '下载' AND pinyin = 'xiàzài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '下载' AND pinyin = 'xiàzài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '下载'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '下载'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiàzài',
      meaning_vi = 'tải xuống, download',
      example_hanzi = '您只需在手机应用商城中搜索并点击下载，即可免费体验最新版的移动办公软件。',
      example_pinyin = 'Nín zhǐ xū zài shǒujī yìngyòng shāngchéng zhōng sōusuǒ bìng diǎnjī xiàzài, jíkě miǎnfèi tǐyàn zuìxīn bǎn de yídòng bàngōng ruǎnjiàn.',
      example_vi = 'Quý khách chỉ cần tìm kiếm và bấm tải xuống trên cửa hàng ứng dụng điện thoại là có thể trải nghiệm miễn phí phiên bản mới nhất của phần mềm văn phòng di động.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '下载',
      'xiàzài',
      'tải xuống, download',
      'Động từ',
      'HSK 5',
      '您只需在手机应用商城中搜索并点击下载，即可免费体验最新版的移动办公软件。',
      'Nín zhǐ xū zài shǒujī yìngyòng shāngchéng zhōng sōusuǒ bìng diǎnjī xiàzài, jíkě miǎnfèi tǐyàn zuìxīn bǎn de yídòng bàngōng ruǎnjiàn.',
      'Quý khách chỉ cần tìm kiếm và bấm tải xuống trên cửa hàng ứng dụng điện thoại là có thể trải nghiệm miễn phí phiên bản mới nhất của phần mềm văn phòng di động.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '您只需在手机应用商城中搜索并点击下载，即可免费体验最新版的移动办公软件。', 'Nín zhǐ xū zài shǒujī yìngyòng shāngchéng zhōng sōusuǒ bìng diǎnjī xiàzài, jíkě miǎnfèi tǐyàn zuìxīn bǎn de yídòng bàngōng ruǎnjiàn.', 'Quý khách chỉ cần tìm kiếm và bấm tải xuống trên cửa hàng ứng dụng điện thoại là có thể trải nghiệm miễn phí phiên bản mới nhất của phần mềm văn phòng di động.', 'basic', 1),
      (v_id, '用户在公共无线开放网络环境中下载第三方应用程序或未知可执行附件时，必须保持高度警惕并开启实时安全防护查杀。', 'Yònghù zài gōnggòng wúxiàn kāifàng wǎngluò huánjìng zhōng xiàzài dìsānfāng yìngyòng chéngxù huò wèizhī kězhíxíng fùjiàn shí, bìxū bǎochí gāodù jǐngtì bìng kāiqǐ shíshí ānquán fánghù chāshā.', 'Người dùng khi tải xuống ứng dụng của bên thứ ba hoặc tệp đính kèm thực thi không rõ nguồn gốc trong môi trường mạng không dây công cộng mở bắt buộc phải nâng cao cảnh giác và bật tính năng quét bảo vệ an ninh thời gian thực.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3231] [先后] (xiānhòu) - trước sau, lần lượt, kế tiếp [Phó từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '先后' AND pinyin = 'xiānhòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '先后' AND pinyin = 'xiānhòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '先后'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '先后'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Danh từ',
      pinyin = 'xiānhòu',
      meaning_vi = 'trước sau, lần lượt, kế tiếp',
      example_hanzi = '研讨会正式开始后，与会的多位行业资深专家先后就人工智能未来的发展趋势发表了主题演讲。',
      example_pinyin = 'Yántǎohuì zhèngshì kāishǐ hòu, yùhuì de duō wèi hángyè zīshēn zhuānjiā xiānhòu jiù réngōng zhìnéng wèilái de fāzhǎn qūshì fābiǎo le zhǔtí yǎnjiǎng.',
      example_vi = 'Sau khi hội thảo chính thức bắt đầu, nhiều chuyên gia lâu năm trong ngành tham dự đã lần lượt phát biểu diễn thuyết chủ đề về xu thế phát triển tương lai của trí tuệ nhân tạo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '先后',
      'xiānhòu',
      'trước sau, lần lượt, kế tiếp',
      'Phó từ / Danh từ',
      'HSK 5',
      '研讨会正式开始后，与会的多位行业资深专家先后就人工智能未来的发展趋势发表了主题演讲。',
      'Yántǎohuì zhèngshì kāishǐ hòu, yùhuì de duō wèi hángyè zīshēn zhuānjiā xiānhòu jiù réngōng zhìnéng wèilái de fāzhǎn qūshì fābiǎo le zhǔtí yǎnjiǎng.',
      'Sau khi hội thảo chính thức bắt đầu, nhiều chuyên gia lâu năm trong ngành tham dự đã lần lượt phát biểu diễn thuyết chủ đề về xu thế phát triển tương lai của trí tuệ nhân tạo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '研讨会正式开始后，与会的多位行业资深专家先后就人工智能未来的发展趋势发表了主题演讲。', 'Yántǎohuì zhèngshì kāishǐ hòu, yùhuì de duō wèi hángyè zīshēn zhuānjiā xiānhòu jiù réngōng zhìnéng wèilái de fāzhǎn qūshì fābiǎo le zhǔtí yǎnjiǎng.', 'Sau khi hội thảo chính thức bắt đầu, nhiều chuyên gia lâu năm trong ngành tham dự đã lần lượt phát biểu diễn thuyết chủ đề về xu thế phát triển tương lai của trí tuệ nhân tạo.', 'basic', 1),
      (v_id, '该科研团队在量子精密测量与量子计算芯片核心领域深耕十余载，先后攻克了十多项国家级关键技术重大攻关课题。', 'Gāi kēyán tuánduì zài liàngzǐ jīngmì cèliáng yǔ liàngzǐ jìsuàn xīnpiàn héxīn lǐngyù shēngēng shí yú zǎi, xiānhòu gōngkè le shí duō xiàng guójiājí guānjiàn jìshù zhòngdà gōngguān kètí.', 'Đội ngũ nghiên cứu khoa học này miệt mài nghiên cứu hơn mười năm trong lĩnh vực cốt lõi đo lường lượng tử chính xác và chip tính toán lượng tử, đã lần lượt chinh phục hơn mười đề tài nghiên cứu trọng đại cấp quốc gia về kỹ thuật then chốt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3232] [先进] (xiānjìn) - tiên tiến, hiện đại; điển hình tiên tiến [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '先进' AND pinyin = 'xiānjìn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '先进' AND pinyin = 'xiānjìn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '先进'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '先进'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'xiānjìn',
      meaning_vi = 'tiên tiến, hiện đại; điển hình tiên tiến',
      example_hanzi = '这家现代制造工厂引进了国际先进的机器人全自动化装配流水线，生产效率大幅提升。',
      example_pinyin = 'Zhè jiā xiàndài zhìzào gōngchǎng yǐnjìn le guójì xiānjìn de jīqìrén quán-zìdònghuà zhuāngpèi liúshuǐxiàn, shēngchǎn xiàolǜ dàfú tíshēng.',
      example_vi = 'Nhà máy chế tạo hiện đại này đã nhập khẩu dây chuyền lắp ráp tự động hóa hoàn toàn bằng robot tiên tiến của quốc tế, hiệu suất sản xuất được nâng cao rõ rệt.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '先进',
      'xiānjìn',
      'tiên tiến, hiện đại; điển hình tiên tiến',
      'Tính từ / Danh từ',
      'HSK 5',
      '这家现代制造工厂引进了国际先进的机器人全自动化装配流水线，生产效率大幅提升。',
      'Zhè jiā xiàndài zhìzào gōngchǎng yǐnjìn le guójì xiānjìn de jīqìrén quán-zìdònghuà zhuāngpèi liúshuǐxiàn, shēngchǎn xiàolǜ dàfú tíshēng.',
      'Nhà máy chế tạo hiện đại này đã nhập khẩu dây chuyền lắp ráp tự động hóa hoàn toàn bằng robot tiên tiến của quốc tế, hiệu suất sản xuất được nâng cao rõ rệt.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这家现代制造工厂引进了国际先进的机器人全自动化装配流水线，生产效率大幅提升。', 'Zhè jiā xiàndài zhìzào gōngchǎng yǐnjìn le guójì xiānjìn de jīqìrén quán-zìdònghuà zhuāngpèi liúshuǐxiàn, shēngchǎn xiàolǜ dàfú tíshēng.', 'Nhà máy chế tạo hiện đại này đã nhập khẩu dây chuyền lắp ráp tự động hóa hoàn toàn bằng robot tiên tiến của quốc tế, hiệu suất sản xuất được nâng cao rõ rệt.', 'basic', 1),
      (v_id, '对标国际最先进水平并加速突破超高纯电子级基础原材料制造工艺，是实现我国集成电路产业自立自强的战略基石。', 'Duìbiāo guójì zuì xiānjìn shuǐpíng bìng jiāsù tūpò chāogāochún diànzǐjí jīchǔ yuáncáiliào zhìzào gōngyì, shì shíxiàn wǒguó jíchéng diànlù chǎnyè zìlì-zìqiáng de zhànlüè jīshí.', 'Đối chuẩn với trình độ tiên tiến nhất quốc tế và đẩy nhanh đột phá quy trình chế tạo nguyên vật liệu cơ bản cấp điện tử siêu tinh khiết chính là nền tảng chiến lược để ngành công nghiệp vi mạch bán dẫn tự lực tự cường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3233] [闲] (xián) - rảnh rỗi, nhàn hạ, để không, nhàn rỗi [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '闲' AND pinyin = 'xián'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '闲' AND pinyin = 'xián'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '闲'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '闲'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'xián',
      meaning_vi = 'rảnh rỗi, nhàn hạ, để không, nhàn rỗi',
      example_hanzi = '平日里工作节奏非常紧张，周末闲下来的时候他最喜欢在阳台静静地品茶看书。',
      example_pinyin = 'Píngrì lǐ gōngzuò jiézòu fēicháng jǐnzhāng, zhōumò xián xiàlái de shíhou tā zuì xǐhuan zài yángtái jìngjìng de pǐnchá kànshū.',
      example_vi = 'Ngày thường nhịp điệu công việc vô cùng căng thẳng, lúc rảnh rỗi vào cuối tuần anh ấy thích nhất là ngồi yên tĩnh trên ban công nhâm nhi chén trà và đọc sách.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '闲',
      'xián',
      'rảnh rỗi, nhàn hạ, để không, nhàn rỗi',
      'Tính từ',
      'HSK 5',
      '平日里工作节奏非常紧张，周末闲下来的时候他最喜欢在阳台静静地品茶看书。',
      'Píngrì lǐ gōngzuò jiézòu fēicháng jǐnzhāng, zhōumò xián xiàlái de shíhou tā zuì xǐhuan zài yángtái jìngjìng de pǐnchá kànshū.',
      'Ngày thường nhịp điệu công việc vô cùng căng thẳng, lúc rảnh rỗi vào cuối tuần anh ấy thích nhất là ngồi yên tĩnh trên ban công nhâm nhi chén trà và đọc sách.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '平日里工作节奏非常紧张，周末闲下来的时候他最喜欢在阳台静静地品茶看书。', 'Píngrì lǐ gōngzuò jiézòu fēicháng jǐnzhāng, zhōumò xián xiàlái de shíhou tā zuì xǐhuan zài yángtái jìngjìng de pǐnchá kànshū.', 'Ngày thường nhịp điệu công việc vô cùng căng thẳng, lúc rảnh rỗi vào cuối tuần anh ấy thích nhất là ngồi yên tĩnh trên ban công nhâm nhi chén trà và đọc sách.', 'basic', 1),
      (v_id, '工业互联网共享制造平台通过智能匹配调度算法，有效盘活了制造产业园区内大量长期闲置的高端数控机床与仓储算力资源。', 'Gōngyè hùliánwǎng gòngxiǎng zhìzào píngtái tōngguò zhìnéng pǐpèi diàodù suànfǎ, yǒuxiào pánhuó le zhìzào chǎnyè yuánqū nèi dàliàng chángqī xiánzhì de gāoduān shùkòng jīchuáng yǔ cāngchǔ suànlì zīyuán.', 'Nền tảng chế tạo chia sẻ internet công nghiệp thông qua thuật toán điều độ khớp lệnh thông minh đã khơi thông hiệu quả khối lượng lớn máy công cụ CNC cao cấp và tài nguyên tính toán kho bãi bị nhàn rỗi lâu ngày trong khu công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3234] [显得] (xiǎnde) - lộ vẻ, có vẻ, tỏ ra [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '显得' AND pinyin = 'xiǎnde'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '显得' AND pinyin = 'xiǎnde'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '显得'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '显得'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiǎnde',
      meaning_vi = 'lộ vẻ, có vẻ, tỏ ra',
      example_hanzi = '穿上这套剪裁得体的深色商务西装后，他整个人都显得格外精神干练。',
      example_pinyin = 'Chuān shàng zhè tào jiǎncái détǐ de shēnsè shāngwù xīzhuāng hòu, tā zhěngrén dōu xiǎnde géwài jīngshén gànliàn.',
      example_vi = 'Sau khi khoác lên mình bộ vest công sở màu sẫm cắt may vừa vặn này, cả con người anh ấy trông có vẻ đặc biệt hoạt bát và tháo vát.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '显得',
      'xiǎnde',
      'lộ vẻ, có vẻ, tỏ ra',
      'Động từ',
      'HSK 5',
      '穿上这套剪裁得体的深色商务西装后，他整个人都显得格外精神干练。',
      'Chuān shàng zhè tào jiǎncái détǐ de shēnsè shāngwù xīzhuāng hòu, tā zhěngrén dōu xiǎnde géwài jīngshén gànliàn.',
      'Sau khi khoác lên mình bộ vest công sở màu sẫm cắt may vừa vặn này, cả con người anh ấy trông có vẻ đặc biệt hoạt bát và tháo vát.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '穿上这套剪裁得体的深色商务西装后，他整个人都显得格外精神干练。', 'Chuān shàng zhè tào jiǎncái détǐ de shēnsè shāngwù xīzhuāng hòu, tā zhěngrén dōu xiǎnde géwài jīngshén gànliàn.', 'Sau khi khoác lên mình bộ vest công sở màu sẫm cắt may vừa vặn này, cả con người anh ấy trông có vẻ đặc biệt hoạt bát và tháo vát.', 'basic', 1),
      (v_id, '在瞬息万变的全球宏观金融动荡中，始终坚守长期主义战略定力与合规底线的实体企业，显得更加从容与稳健。', 'Zài shùnxī-wànbiàn de quánqiú hóngguān jīnróng dòngdàng zhōng, shǐzhōng jiānshǒu chángqī zhǔyì zhànlüè dìnglì yǔ hégūi dǐxiàn de shítǐ qǐyè, xiǎnde gèngjiā cóngróng yǔ wěnjiàn.', 'Trong cơn biến động tài chính vĩ mô toàn cầu biến đổi khôn lường trong chớp mắt, các doanh nghiệp thực thể luôn kiên định giữ vững định lực chiến lược chủ nghĩa dài hạn và lằn ranh đỏ tuân thủ pháp lý tỏ ra ung dung và vững vàng hơn rất nhiều.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3235] [显然] (xiǎnrán) - rõ ràng, hiển nhiên, thấy rõ [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '显然' AND pinyin = 'xiǎnrán'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '显然' AND pinyin = 'xiǎnrán'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '显然'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '显然'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'xiǎnrán',
      meaning_vi = 'rõ ràng, hiển nhiên, thấy rõ',
      example_hanzi = '听完导师深入浅出的耐心点拨，大家显然已经彻底弄懂了这个复杂的技术难点。',
      example_pinyin = 'Tīng wán dǎoshī shēnrù-qiǎnchū de nàixīn diǎnbō, dàjiā xiǎnrán yǐjīng chèdǐ nòng dǒng le zhè gè fùzá de jìshù nándiǎn.',
      example_vi = 'Sau khi nghe lời chỉ bảo kiên nhẫn sâu sắc dễ hiểu của thầy hướng dẫn, mọi người rõ ràng đã hiểu thấu hoàn toàn điểm khó kỹ thuật phức tạp này.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '显然',
      'xiǎnrán',
      'rõ ràng, hiển nhiên, thấy rõ',
      'Tính từ / Phó từ',
      'HSK 5',
      '听完导师深入浅出的耐心点拨，大家显然已经彻底弄懂了这个复杂的技术难点。',
      'Tīng wán dǎoshī shēnrù-qiǎnchū de nàixīn diǎnbō, dàjiā xiǎnrán yǐjīng chèdǐ nòng dǒng le zhè gè fùzá de jìshù nándiǎn.',
      'Sau khi nghe lời chỉ bảo kiên nhẫn sâu sắc dễ hiểu của thầy hướng dẫn, mọi người rõ ràng đã hiểu thấu hoàn toàn điểm khó kỹ thuật phức tạp này.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '听完导师深入浅出的耐心点拨，大家显然已经彻底弄懂了这个复杂的技术难点。', 'Tīng wán dǎoshī shēnrù-qiǎnchū de nàixīn diǎnbō, dàjiā xiǎnrán yǐjīng chèdǐ nòng dǒng le zhè gè fùzá de jìshù nándiǎn.', 'Sau khi nghe lời chỉ bảo kiên nhẫn sâu sắc dễ hiểu của thầy hướng dẫn, mọi người rõ ràng đã hiểu thấu hoàn toàn điểm khó kỹ thuật phức tạp này.', 'basic', 1),
      (v_id, '仅仅依赖低附加值贴牌代工模式，显然已经无法适应全球高新技术产业链高端化、智能化与绿色化的转型升级要求。', 'Jǐnjǐn yīlài dī fùjiāzhí tiēpái dàigōng móshì, xiǎnrán yǐjīng wúfǎ shìyìng quánqiú gāoxīnjìshù chǎnyèliàn gāoduānhuà, zhìnénghuà yǔ lǜsèhuà de zhuǎnxíng shēngjí yāoqiú.', 'Nếu chỉ dựa dẫm vào mô hình gia công OEM giá trị gia tăng thấp thì rõ ràng đã không còn có thể thích nghi được với các yêu cầu chuyển đổi nâng cấp theo hướng cao cấp hóa, thông minh hóa và xanh hóa của chuỗi công nghiệp công nghệ cao toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3236] [显示] (xiǎnshì) - hiển thị, cho thấy, biểu hiện, biểu thị [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '显示' AND pinyin = 'xiǎnshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '显示' AND pinyin = 'xiǎnshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '显示'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '显示'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiǎnshì',
      meaning_vi = 'hiển thị, cho thấy, biểu hiện, biểu thị',
      example_hanzi = '汽车仪表盘上的数字指示屏清晰显示，车辆目前的剩余油量足以支撑继续行驶两百公里。',
      example_pinyin = 'Qìchē yíbiǎopán shàng de shùzì zhǐshìpíng qīngxī xiǎnshì, chēliàng mùqián de shèngyú yóuliàng zúyǐ zhīchēng jìxù xíngshǐ liǎng bǎi gōnglǐ.',
      example_vi = 'Màn hình hiển thị số trên bảng điều khiển xe ô tô cho thấy rõ ràng, lượng xăng còn lại hiện tại của xe đủ để chạy tiếp hai trăm kilomet.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '显示',
      'xiǎnshì',
      'hiển thị, cho thấy, biểu hiện, biểu thị',
      'Động từ',
      'HSK 5',
      '汽车仪表盘上的数字指示屏清晰显示，车辆目前的剩余油量足以支撑继续行驶两百公里。',
      'Qìchē yíbiǎopán shàng de shùzì zhǐshìpíng qīngxī xiǎnshì, chēliàng mùqián de shèngyú yóuliàng zúyǐ zhīchēng jìxù xíngshǐ liǎng bǎi gōnglǐ.',
      'Màn hình hiển thị số trên bảng điều khiển xe ô tô cho thấy rõ ràng, lượng xăng còn lại hiện tại của xe đủ để chạy tiếp hai trăm kilomet.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '汽车仪表盘上的数字指示屏清晰显示，车辆目前的剩余油量足以支撑继续行驶两百公里。', 'Qìchē yíbiǎopán shàng de shùzì zhǐshìpíng qīngxī xiǎnshì, chēliàng mùqián de shèngyú yóuliàng zúyǐ zhīchēng jìxù xíngshǐ liǎng bǎi gōnglǐ.', 'Màn hình hiển thị số trên bảng điều khiển xe ô tô cho thấy rõ ràng, lượng xăng còn lại hiện tại của xe đủ để chạy tiếp hai trăm kilomet.', 'basic', 1),
      (v_id, '国家统计局公布的最新宏观经济运行数据显示，高技术制造业投资与新兴服务业营收强劲回升，展现出国民经济强大的发展韧性。', 'Guójiā tǒngjìjú gōngbù de zuìxīn hóngguān jīngjì yùnxíng shùjù xiǎnshì, gāojìshù zhìzàoyè tóuzī yǔ xīnxīng fúwùyè yíngshōu qiángjìn huíshēng, zhǎnxiàn chū guómín jīngjì qiángdà de fāzhǎn rènxìng.', 'Dữ liệu vận hành kinh tế vĩ mô mới nhất do Cục Thống kê Quốc gia công bố cho thấy, đầu tư ngành chế tạo công nghệ cao và doanh thu ngành dịch vụ mới nổi đã phục hồi mạnh mẽ, thể hiện khả năng thích ứng phát triển mạnh mẽ của nền kinh tế quốc dân.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3237] [县] (xiàn) - huyện (đơn vị hành chính) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '县' AND pinyin = 'xiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '县' AND pinyin = 'xiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '县'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '县'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiàn',
      meaning_vi = 'huyện (đơn vị hành chính)',
      example_hanzi = '这座美丽古朴的小县城坐落于青山绿水之间，清新的空气与悠闲的生活节奏吸引了众多自驾游爱好者。',
      example_pinyin = 'Zhè suǒ měilì gǔpǔ de xiǎo xiànchéng zuòluò yú qīngshān lǜshuǐ zhījiān, qīngxīn de kōngqì yǔ yōuxián de shēnghuó jiézòu xīyǐn le zhòngduō zìjiàyóu àihàozhě.',
      example_vi = 'Thị trấn huyện nhỏ xinh đẹp cổ kính này tọa lạc giữa non xanh nước biếc, không khí trong lành cùng nhịp sống thảnh thơi đã thu hút đông đảo những người yêu thích du lịch tự lái.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '县',
      'xiàn',
      'huyện (đơn vị hành chính)',
      'Danh từ',
      'HSK 5',
      '这座美丽古朴的小县城坐落于青山绿水之间，清新的空气与悠闲的生活节奏吸引了众多自驾游爱好者。',
      'Zhè suǒ měilì gǔpǔ de xiǎo xiànchéng zuòluò yú qīngshān lǜshuǐ zhījiān, qīngxīn de kōngqì yǔ yōuxián de shēnghuó jiézòu xīyǐn le zhòngduō zìjiàyóu àihàozhě.',
      'Thị trấn huyện nhỏ xinh đẹp cổ kính này tọa lạc giữa non xanh nước biếc, không khí trong lành cùng nhịp sống thảnh thơi đã thu hút đông đảo những người yêu thích du lịch tự lái.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这座美丽古朴的小县城坐落于青山绿水之间，清新的空气与悠闲的生活节奏吸引了众多自驾游爱好者。', 'Zhè suǒ měilì gǔpǔ de xiǎo xiànchéng zuòluò yú qīngshān lǜshuǐ zhījiān, qīngxīn de kōngqì yǔ yōuxián de shēnghuó jiézòu xīyǐn le zhòngduō zìjiàyóu àihàozhě.', 'Thị trấn huyện nhỏ xinh đẹp cổ kính này tọa lạc giữa non xanh nước biếc, không khí trong lành cùng nhịp sống thảnh thơi đã thu hút đông đảo những người yêu thích du lịch tự lái.', 'basic', 1),
      (v_id, '国家积极推进以县城为重要载体的城镇化建设，因地制宜培育特色优势产业集群，全面激活县域经济内生增长动能。', 'Guójiā jījí tuījìn yǐ xiànchéng wéi zhòngyào zàitǐ de chéngzhènhuà jiànshè, yīndì-zhìyí péiyù tèsè yòushì chǎnyè jíqún, quánmiàn jīhuó xiànyù jīngjì nèishēng zēngzhǎng dòngnéng.', 'Nhà nước tích cực thúc đẩy xây dựng đô thị hóa lấy huyện lỵ làm điểm tựa trọng yếu, bám sát tình hình thực tế địa phương nuôi dưỡng cụm ngành công nghiệp thế mạnh đặc sắc, kích hoạt toàn diện động năng tăng trưởng nội sinh của nền kinh tế cấp huyện.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3238] [现场] (xiànchǎng) - hiện trường, tại chỗ, trực tiếp [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '现场' AND pinyin = 'xiànchǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现场' AND pinyin = 'xiànchǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '现场'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现场'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiànchǎng',
      meaning_vi = 'hiện trường, tại chỗ, trực tiếp',
      example_hanzi = '突发火警警报拉响之后，专业消防救援队伍仅用了不到五分钟就迅速抵达事故现场展开灭火救援。',
      example_pinyin = 'Tūfā huǒjǐng jǐngbào lāxiǎng zhīhòu, zhuānyè xiāofáng jiùyuán duìwu jǐn yòng le bù dào wǔ fēnzhōng jiù xùnsù dǐdá shìgù xiànchǎng zhǎnkāi mièhuǒ jiùyuán.',
      example_vi = 'Sau khi chuông báo cháy bất ngờ vang lên, đội cứu hỏa cứu nạn chuyên nghiệp chỉ mất chưa đầy năm phút đã nhanh chóng có mặt tại hiện trường vụ tai nạn triển khai dập lửa cứu người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '现场',
      'xiànchǎng',
      'hiện trường, tại chỗ, trực tiếp',
      'Danh từ',
      'HSK 5',
      '突发火警警报拉响之后，专业消防救援队伍仅用了不到五分钟就迅速抵达事故现场展开灭火救援。',
      'Tūfā huǒjǐng jǐngbào lāxiǎng zhīhòu, zhuānyè xiāofáng jiùyuán duìwu jǐn yòng le bù dào wǔ fēnzhōng jiù xùnsù dǐdá shìgù xiànchǎng zhǎnkāi mièhuǒ jiùyuán.',
      'Sau khi chuông báo cháy bất ngờ vang lên, đội cứu hỏa cứu nạn chuyên nghiệp chỉ mất chưa đầy năm phút đã nhanh chóng có mặt tại hiện trường vụ tai nạn triển khai dập lửa cứu người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '突发火警警报拉响之后，专业消防救援队伍仅用了不到五分钟就迅速抵达事故现场展开灭火救援。', 'Tūfā huǒjǐng jǐngbào lāxiǎng zhīhòu, zhuānyè xiāofáng jiùyuán duìwu jǐn yòng le bù dào wǔ fēnzhōng jiù xùnsù dǐdá shìgù xiànchǎng zhǎnkāi mièhuǒ jiùyuán.', 'Sau khi chuông báo cháy bất ngờ vang lên, đội cứu hỏa cứu nạn chuyên nghiệp chỉ mất chưa đầy năm phút đã nhanh chóng có mặt tại hiện trường vụ tai nạn triển khai dập lửa cứu người.', 'basic', 1),
      (v_id, '国家重大超级工程施工现场严格推行“智慧工地”数字孪生管控体系，实现对施工质量、进度与人员安全作业的全天候全方位监管。', 'Guójiā zhòngdà chāojí gōngchéng shīgōng xiànchǎng yángé tuīxíng “zhìhuì gōngdì” shùzì luànshēng guǎnkòng tǐxì, shíxiàn duì shīgōng zhìliàng, jìndù yǔ rényuán ānquán zuòyè de quántiānhòu quán-fāngwèi jiānguǎn.', 'Hiện trường thi công siêu công trình trọng điểm quốc gia triển khai nghiêm ngặt hệ sinh thái điều phối bản sao số "công trường thông minh", thực hiện giám sát toàn diện mọi lúc mọi nơi về chất lượng thi công, tiến độ và thao tác an toàn của nhân viên.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3239] [现代] (xiàndài) - hiện đại, thời hiện đại [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '现代' AND pinyin = 'xiàndài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现代' AND pinyin = 'xiàndài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '现代'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现代'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'xiàndài',
      meaning_vi = 'hiện đại, thời hiện đại',
      example_hanzi = '现代都市人的生活节奏越来越快，学会合理调节工作压力与维护身心健康显得格外重要。',
      example_pinyin = 'Xiàndài dūshìrén de shēnghuó jiézòu yuèláiyuè kuài, xuéhuì hélǐ tiáojié gōngzuò yālì yǔ wéihù shēnxīn jiànkāng xiǎnde géwài zhòngyào.',
      example_vi = 'Nhịp sống của cư dân đô thị hiện đại ngày càng nhanh, việc học cách điều tiết hợp lý áp lực công việc và duy trì sức khỏe thể chất tinh thần tỏ ra đặc biệt quan trọng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '现代',
      'xiàndài',
      'hiện đại, thời hiện đại',
      'Danh từ / Tính từ',
      'HSK 5',
      '现代都市人的生活节奏越来越快，学会合理调节工作压力与维护身心健康显得格外重要。',
      'Xiàndài dūshìrén de shēnghuó jiézòu yuèláiyuè kuài, xuéhuì hélǐ tiáojié gōngzuò yālì yǔ wéihù shēnxīn jiànkāng xiǎnde géwài zhòngyào.',
      'Nhịp sống của cư dân đô thị hiện đại ngày càng nhanh, việc học cách điều tiết hợp lý áp lực công việc và duy trì sức khỏe thể chất tinh thần tỏ ra đặc biệt quan trọng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现代都市人的生活节奏越来越快，学会合理调节工作压力与维护身心健康显得格外重要。', 'Xiàndài dūshìrén de shēnghuó jiézòu yuèláiyuè kuài, xuéhuì hélǐ tiáojié gōngzuò yālì yǔ wéihù shēnxīn jiànkāng xiǎnde géwài zhòngyào.', 'Nhịp sống của cư dân đô thị hiện đại ngày càng nhanh, việc học cách điều tiết hợp lý áp lực công việc và duy trì sức khỏe thể chất tinh thần tỏ ra đặc biệt quan trọng.', 'basic', 1),
      (v_id, '加快构建现代化产业体系并完善中国特色现代企业制度，是推动国有领军实体企业提升全球核心竞争力的关键制度保障。', 'Jiākuài gòujiàn xiàndàihuà chǎnyè tǐxì bìng wánshàn Zhōngguó tèsè xiàndài qǐyè zhìdù, shì tuīdòng guóyǒu lǐngjūn shítǐ qǐyè tíshēng quánqiú héxīn jìngzhēnglì de guānjiàn zhìdù bǎozhàng.', 'Đẩy nhanh kiến tạo hệ thống công nghiệp hiện đại hóa và hoàn thiện chế độ doanh nghiệp hiện đại mang đặc sắc Trung Quốc chính là bảo đảm thể chế then chốt để thúc đẩy các doanh nghiệp thực thể dẫn đầu nhà nước nâng tầm năng lực cạnh tranh cốt lõi toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3240] [现代化] (xiàndàihuà) - hiện đại hóa, sự hiện đại hóa [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '现代化' AND pinyin = 'xiàndàihuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现代化' AND pinyin = 'xiàndàihuà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '现代化'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现代化'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xiàndàihuà',
      meaning_vi = 'hiện đại hóa, sự hiện đại hóa',
      example_hanzi = '随着信息技术的飞速普及，乡村中小学也基本实现了多媒体教学设施与智慧校园的现代化。',
      example_pinyin = 'Suízhe xìnxī jìshù de fēisù pǔjí, xiāngcūn zhōng-xiǎoxué yě jīběn shíxiàn le duōméitǐ jiàoxué shèshī yǔ zhìhuì xiàoyuán de xiàndàihuà.',
      example_vi = 'Cùng với sự phổ cập nhanh chóng của công nghệ thông tin, các trường tiểu học và trung học nông thôn cũng cơ bản hiện thực hóa sự hiện đại hóa về trang thiết bị giảng dạy đa phương tiện và khuôn viên thông minh.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '现代化',
      'xiàndàihuà',
      'hiện đại hóa, sự hiện đại hóa',
      'Động từ / Danh từ',
      'HSK 5',
      '随着信息技术的飞速普及，乡村中小学也基本实现了多媒体教学设施与智慧校园的现代化。',
      'Suízhe xìnxī jìshù de fēisù pǔjí, xiāngcūn zhōng-xiǎoxué yě jīběn shíxiàn le duōméitǐ jiàoxué shèshī yǔ zhìhuì xiàoyuán de xiàndàihuà.',
      'Cùng với sự phổ cập nhanh chóng của công nghệ thông tin, các trường tiểu học và trung học nông thôn cũng cơ bản hiện thực hóa sự hiện đại hóa về trang thiết bị giảng dạy đa phương tiện và khuôn viên thông minh.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着信息技术的飞速普及，乡村中小学也基本实现了多媒体教学设施与智慧校园的现代化。', 'Suízhe xìnxī jìshù de fēisù pǔjí, xiāngcūn zhōng-xiǎoxué yě jīběn shíxiàn le duōméitǐ jiàoxué shèshī yǔ zhìhuì xiàoyuán de xiàndàihuà.', 'Cùng với sự phổ cập nhanh chóng của công nghệ thông tin, các trường tiểu học và trung học nông thôn cũng cơ bản hiện thực hóa sự hiện đại hóa về trang thiết bị giảng dạy đa phương tiện và khuôn viên thông minh.', 'basic', 1),
      (v_id, '以中国式现代化全面推进中华民族伟大复兴，必须牢牢把握高质量发展首要任务，完整、准确、全面贯彻新发展理念。', 'Yǐ Zhōngguóshì xiàndàihuà quánmiàn tuījìn Zhōnghuá mínzú wěidà fùxīng, bìxū láoláo bǎwò gāozhìliàng fāzhǎn shǒuyào rènwù, wánzhěng, zhǔnquè, quánmiàn guànchè xīn fāzhǎn lǐniàn.', 'Dùng hiện đại hóa kiểu Trung Quốc thúc đẩy toàn diện sự phục hưng vĩ đại của dân tộc Trung Hoa bắt buộc phải nắm chắc nhiệm vụ hàng đầu là phát triển chất lượng cao, quán triệt đầy đủ, chuẩn xác và toàn diện quan niệm phát triển mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3241] [线路] (xiànlù) - tuyến đường, đường dây, mạch điện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '线路' AND pinyin = 'xiànlù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '线路' AND pinyin = 'xiànlù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '线路'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '线路'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiànlù',
      meaning_vi = 'tuyến đường, đường dây, mạch điện',
      example_hanzi = '这条新开通的地铁线路贯穿了城市东西两端，极大缓解了上下班高峰期的路面交通拥堵。',
      example_pinyin = 'Zhè tiáo xīn kāitōng de dìtiě xiànlù guànchuān le chéngshì dōng-xī liǎngduān, jídà huǎnjiě le shàng-xiàbān gāofēngqī de lùmiàn jiāotōng yōngdǔ.',
      example_vi = 'Tuyến đường tàu điện ngầm mới khai thông này chạy xuyên suốt hai đầu đông tây của thành phố, giảm tải rất lớn tình trạng ùn tắc giao thông đường bộ vào giờ cao điểm đi làm và tan sở.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '线路',
      'xiànlù',
      'tuyến đường, đường dây, mạch điện',
      'Danh từ',
      'HSK 5',
      '这条新开通的地铁线路贯穿了城市东西两端，极大缓解了上下班高峰期的路面交通拥堵。',
      'Zhè tiáo xīn kāitōng de dìtiě xiànlù guànchuān le chéngshì dōng-xī liǎngduān, jídà huǎnjiě le shàng-xiàbān gāofēngqī de lùmiàn jiāotōng yōngdǔ.',
      'Tuyến đường tàu điện ngầm mới khai thông này chạy xuyên suốt hai đầu đông tây của thành phố, giảm tải rất lớn tình trạng ùn tắc giao thông đường bộ vào giờ cao điểm đi làm và tan sở.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这条新开通的地铁线路贯穿了城市东西两端，极大缓解了上下班高峰期的路面交通拥堵。', 'Zhè tiáo xīn kāitōng de dìtiě xiànlù guànchuān le chéngshì dōng-xī liǎngduān, jídà huǎnjiě le shàng-xiàbān gāofēngqī de lùmiàn jiāotōng yōngdǔ.', 'Tuyến đường tàu điện ngầm mới khai thông này chạy xuyên suốt hai đầu đông tây của thành phố, giảm tải rất lớn tình trạng ùn tắc giao thông đường bộ vào giờ cao điểm đi làm và tan sở.', 'basic', 1),
      (v_id, '特高压电网运维工程师在复杂高原地理环境下，利用搭载红外热成像仪的工业无人机对超高压输电线路开展全自主智能巡检巡查。', 'Tègāoyā diànwǎng yùnwéi gōngchéngshī zài fùzá gāoyuán dìlǐ huánjìng xià, lìyòng dàizài hóngwài rèchéngxiàngyí de gōngyè wúrénjī duì chāogāoyā shūdiàn xiànlù kāizhǎn quán-zìzhǔ zhìnéng xúnjiǎn xúnchá.', 'Kỹ sư vận hành bảo trì lưới điện siêu cao thế trong môi trường địa lý cao nguyên phức tạp đã sử dụng máy bay không người lái công nghiệp gắn camera chụp ảnh nhiệt hồng ngoại để tiến hành tuần tra kiểm tra thông minh hoàn toàn tự động đối với các tuyến đường dây truyền tải điện siêu cao áp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3242] [现实] (xiànshí) - hiện thực, thực tế [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '现实' AND pinyin = 'xiànshí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现实' AND pinyin = 'xiànshí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '现实'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现实'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'xiànshí',
      meaning_vi = 'hiện thực, thực tế',
      example_hanzi = '无论崇高的理想多么远大，我们都要立足现实，一步一个脚印地去踏实努力奋斗。',
      example_pinyin = 'Wúlùn chónggāo de lǐxiǎng duōme yuǎndà, wǒmen dōu yào lìzú xiànshí, yībù yī gè jiǎoyìn de qù tàshi nǔlì fèndòu.',
      example_vi = 'Bất kể lý tưởng cao cả có xa rộng đến đâu, chúng ta đều phải đứng vững trên thực tế, nỗ lực phấn đấu thiết thực từng bước từng bước vững chắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '现实',
      'xiànshí',
      'hiện thực, thực tế',
      'Danh từ / Tính từ',
      'HSK 5',
      '无论崇高的理想多么远大，我们都要立足现实，一步一个脚印地去踏实努力奋斗。',
      'Wúlùn chónggāo de lǐxiǎng duōme yuǎndà, wǒmen dōu yào lìzú xiànshí, yībù yī gè jiǎoyìn de qù tàshi nǔlì fèndòu.',
      'Bất kể lý tưởng cao cả có xa rộng đến đâu, chúng ta đều phải đứng vững trên thực tế, nỗ lực phấn đấu thiết thực từng bước từng bước vững chắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论崇高的理想多么远大，我们都要立足现实，一步一个脚印地去踏实努力奋斗。', 'Wúlùn chónggāo de lǐxiǎng duōme yuǎndà, wǒmen dōu yào lìzú xiànshí, yībù yī gè jiǎoyìn de qù tàshi nǔlì fèndòu.', 'Bất kể lý tưởng cao cả có xa rộng đến đâu, chúng ta đều phải đứng vững trên thực tế, nỗ lực phấn đấu thiết thực từng bước từng bước vững chắc.', 'basic', 1),
      (v_id, '面对全球气候急剧变暖与极端恶劣灾害天气频发的严峻现实，国际社会必须摒弃地缘分歧，切实履行共同但有区别的减排减碳责任。', 'Miànduì quánqiú qìhòu jíjù biànnuǎn yǔ jíduān èliè zāihài tiānqì pínfā de yánjùn xiànshí, guójì shèhuì bìxū bǐngqì dìyuán fēnqí, qièshí lǚxíng gòngtóng dàn yǒu qūbié de jiǎnpái jiǎntàn zérèn.', 'Trước hiện thực nghiệt ngã của tình trạng biến đổi khí hậu toàn cầu nóng lên nhanh chóng và thời tiết thiên tai cực đoan xảy ra thường xuyên, cộng đồng quốc tế bắt buộc phải gạt bỏ bất đồng địa chính trị, thực thi trách nhiệm giảm phát thải carbon chung nhưng có phân biệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3243] [现象] (xiànxiàng) - hiện tượng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '现象' AND pinyin = 'xiànxiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现象' AND pinyin = 'xiànxiàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '现象'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现象'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiànxiàng',
      meaning_vi = 'hiện tượng',
      example_hanzi = '潮汐是受月球和太阳引力作用而引起的海水周期性涨落，是一种非常典型的自然物理现象。',
      example_pinyin = 'Cháoxī shì shòu yuèqiú hé tàiyáng yǐnlì zuòyòng ér yǐnqǐ de hǎishuǐ zhōuqīxìng zhǎngluò, shì yī zhǒng fēicháng diǎnxíng de zìrán wùlǐ xiànxiàng.',
      example_vi = 'Thủy triều là hiện tượng nước biển dâng hạ theo chu kỳ do chịu tác động của lực hấp dẫn từ mặt trăng và mặt trời, là một hiện tượng vật lý tự nhiên hết sức điển hình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '现象',
      'xiànxiàng',
      'hiện tượng',
      'Danh từ',
      'HSK 5',
      '潮汐是受月球和太阳引力作用而引起的海水周期性涨落，是一种非常典型的自然物理现象。',
      'Cháoxī shì shòu yuèqiú hé tàiyáng yǐnlì zuòyòng ér yǐnqǐ de hǎishuǐ zhōuqīxìng zhǎngluò, shì yī zhǒng fēicháng diǎnxíng de zìrán wùlǐ xiànxiàng.',
      'Thủy triều là hiện tượng nước biển dâng hạ theo chu kỳ do chịu tác động của lực hấp dẫn từ mặt trăng và mặt trời, là một hiện tượng vật lý tự nhiên hết sức điển hình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '潮汐是受月球和太阳引力作用而引起的海水周期性涨落，是一种非常典型的自然物理现象。', 'Cháoxī shì shòu yuèqiú hé tàiyáng yǐnlì zuòyòng ér yǐnqǐ de hǎishuǐ zhōuqīxìng zhǎngluò, shì yī zhǒng fēicháng diǎnxíng de zìrán wùlǐ xiànxiàng.', 'Thủy triều là hiện tượng nước biển dâng hạ theo chu kỳ do chịu tác động của lực hấp dẫn từ mặt trăng và mặt trời, là một hiện tượng vật lý tự nhiên hết sức điển hình.', 'basic', 1),
      (v_id, '社会学课题研究组深入调研了平台经济时代青年就业观念的深刻变迁，科学揭示了新就业形态灵活就业现象背后的内在规律。', 'Shèhuìxué kètí yánjiūzǔ shēnrù diàoyán le píngtái jīngjì shídài qīngnián jiùyè guānniàn de shēnkè biànqiān, kēxué jiēshì le xīn jiùyè xíngtài línghuó jiùyè xiànxiàng bèihòu de nèizài guīlǜ.', 'Nhóm nghiên cứu đề tài xã hội học đã điều tra sâu sắc về sự biến chuyển mạnh mẽ trong quan niệm việc làm của giới trẻ trong kỷ nguyên kinh tế nền tảng số, hé lộ một cách khoa học quy luật nội tại đằng sau hiện tượng việc làm linh hoạt của các hình thái việc làm mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3244] [限制] (xiànzhì) - hạn chế, giới hạn, kiềm chế; sự ràng buộc [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '限制' AND pinyin = 'xiànzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '限制' AND pinyin = 'xiànzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '限制'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '限制'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xiànzhì',
      meaning_vi = 'hạn chế, giới hạn, kiềm chế; sự ràng buộc',
      example_hanzi = '出于严格保护古建筑与文物的需要，石窟景区管理处每天严格限制接待入场游客的人数上限。',
      example_pinyin = 'Chūyú yángé bǎohù gǔ jiànzhù yǔ wénwù de xūyào, shíkū jǐngqū guǎnlǐchù měitiān yángé xiànzhì jiēdài rùchǎng yóukè de rénshù shàngxiàn.',
      example_vi = 'Xuất phát từ nhu cầu bảo tồn nghiêm ngặt di tích văn hóa và kiến trúc cổ, ban quản lý khu danh thắng hang đá hàng ngày giới hạn nghiêm ngặt số lượng khách du lịch tối đa được đón tiếp vào tham quan.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '限制',
      'xiànzhì',
      'hạn chế, giới hạn, kiềm chế; sự ràng buộc',
      'Động từ / Danh từ',
      'HSK 5',
      '出于严格保护古建筑与文物的需要，石窟景区管理处每天严格限制接待入场游客的人数上限。',
      'Chūyú yángé bǎohù gǔ jiànzhù yǔ wénwù de xūyào, shíkū jǐngqū guǎnlǐchù měitiān yángé xiànzhì jiēdài rùchǎng yóukè de rénshù shàngxiàn.',
      'Xuất phát từ nhu cầu bảo tồn nghiêm ngặt di tích văn hóa và kiến trúc cổ, ban quản lý khu danh thắng hang đá hàng ngày giới hạn nghiêm ngặt số lượng khách du lịch tối đa được đón tiếp vào tham quan.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '出于严格保护古建筑与文物的需要，石窟景区管理处每天严格限制接待入场游客的人数上限。', 'Chūyú yángé bǎohù gǔ jiànzhù yǔ wénwù de xūyào, shíkū jǐngqū guǎnlǐchù měitiān yángé xiànzhì jiēdài rùchǎng yóukè de rénshù shàngxiàn.', 'Xuất phát từ nhu cầu bảo tồn nghiêm ngặt di tích văn hóa và kiến trúc cổ, ban quản lý khu danh thắng hang đá hàng ngày giới hạn nghiêm ngặt số lượng khách du lịch tối đa được đón tiếp vào tham quan.', 'basic', 1),
      (v_id, '国际贸易法律框架明确规定，世贸成员国不得滥用国家安全例外条款单方面实施歧视性的关键技术出口管制与跨境投资限制。', 'Guójì màoyì fǎlǜ kuàngjià míngquè guīdìng, Shìmào chéngyuánguó bùdé lànyòng guójiā ānquán lìwài tiáokuǎn dān fāngmiàn shíshī qíshìxìng de guānjiàn jìshù chūkǒu guǎnzhì yǔ kuàjìng tóuzī xiànzhì.', 'Khung pháp lý thương mại quốc tế quy định rõ ràng, các nước thành viên WTO không được lạm dụng các điều khoản ngoại lệ an ninh quốc gia để đơn phương thực thi các biện pháp kiểm soát xuất khẩu công nghệ then chốt và giới hạn đầu tư xuyên biên giới mang tính phân biệt đối xử.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3245] [现状] (xiànzhuàng) - hiện trạng, tình trạng hiện tại [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '现状' AND pinyin = 'xiànzhuàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现状' AND pinyin = 'xiànzhuàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '现状'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '现状'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiànzhuàng',
      meaning_vi = 'hiện trạng, tình trạng hiện tại',
      example_hanzi = '青年人在职业生涯初期不应安于现状、固步自封，而应主动学习新知识、勇敢迎接新变革。',
      example_pinyin = 'Qīngniánrén zài zhíyè shēngyá chūqī bù yīng ān yú xiànzhuàng, gùbù-zìfēng, ér yīng zhǔdòng xuéxí xīn zhīshi, yǒnggǎn yíngjiē xīn biàngé.',
      example_vi = 'Thanh niên trong giai đoạn đầu của sự nghiệp không nên bằng lòng với hiện trạng, an phận khép kín, mà nên chủ động học hỏi tri thức mới và dũng cảm đón nhận những đổi thay mới.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '现状',
      'xiànzhuàng',
      'hiện trạng, tình trạng hiện tại',
      'Danh từ',
      'HSK 5',
      '青年人在职业生涯初期不应安于现状、固步自封，而应主动学习新知识、勇敢迎接新变革。',
      'Qīngniánrén zài zhíyè shēngyá chūqī bù yīng ān yú xiànzhuàng, gùbù-zìfēng, ér yīng zhǔdòng xuéxí xīn zhīshi, yǒnggǎn yíngjiē xīn biàngé.',
      'Thanh niên trong giai đoạn đầu của sự nghiệp không nên bằng lòng với hiện trạng, an phận khép kín, mà nên chủ động học hỏi tri thức mới và dũng cảm đón nhận những đổi thay mới.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '青年人在职业生涯初期不应安于现状、固步自封，而应主动学习新知识、勇敢迎接新变革。', 'Qīngniánrén zài zhíyè shēngyá chūqī bù yīng ān yú xiànzhuàng, gùbù-zìfēng, ér yīng zhǔdòng xuéxí xīn zhīshi, yǒnggǎn yíngjiē xīn biàngé.', 'Thanh niên trong giai đoạn đầu của sự nghiệp không nên bằng lòng với hiện trạng, an phận khép kín, mà nên chủ động học hỏi tri thức mới và dũng cảm đón nhận những đổi thay mới.', 'basic', 1),
      (v_id, '行业智库发布的产业白皮书客观深入地剖析了我国工业母机与高端数控系统产业链的发展现状、技术短板及突破路径。', 'Hángyè zhìkù fābù de chǎnyè báipíshū kèguān shēnrù de pōuxī le wǒguó gōngyè mǔjī yǔ gāoduān shùkòng xìtǒng chǎnyèliàn de fāzhǎn xiànzhuàng, jìshù duǎnbǎn jí tūpò lùjìng.', 'Sách trắng ngành do viện nghiên cứu chính sách công bố đã phân tích khách quan sâu sắc hiện trạng phát triển, điểm yếu công nghệ và lộ trình bứt phá của chuỗi công nghiệp máy công cụ công nghiệp và hệ thống điều khiển số cao cấp của nước nhà.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3246] [乡] (xiāng) - xã (đơn vị hành chính nông thôn); quê hương, thôn quê [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '乡' AND pinyin = 'xiāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乡' AND pinyin = 'xiāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '乡'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乡'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiāng',
      meaning_vi = 'xã (đơn vị hành chính nông thôn); quê hương, thôn quê',
      example_hanzi = '每逢春节来临之际，常年在繁华大都市打拼的游子们都会满怀思乡之情返回故乡探望年迈的父母。',
      example_pinyin = 'Měiféng Chúnjié láilín zhī jì, chángnián zài fánhuá dà dūshì dǎpīn de yóuzǐmen dōu huì mǎnhuái sīxiāng zhī qíng fǎnhuí gùxiāng tànwàng niánmài de fùmǔ.',
      example_vi = 'Mỗi khi dịp Tết Nguyên đán cận kề, những người con xa xứ bươn chải quanh năm nơi đô thị phồn hoa đều mang trọn nỗi niềm nhớ quê hương trở về quê nhà thăm nom cha mẹ già.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '乡',
      'xiāng',
      'xã (đơn vị hành chính nông thôn); quê hương, thôn quê',
      'Danh từ',
      'HSK 5',
      '每逢春节来临之际，常年在繁华大都市打拼的游子们都会满怀思乡之情返回故乡探望年迈的父母。',
      'Měiféng Chúnjié láilín zhī jì, chángnián zài fánhuá dà dūshì dǎpīn de yóuzǐmen dōu huì mǎnhuái sīxiāng zhī qíng fǎnhuí gùxiāng tànwàng niánmài de fùmǔ.',
      'Mỗi khi dịp Tết Nguyên đán cận kề, những người con xa xứ bươn chải quanh năm nơi đô thị phồn hoa đều mang trọn nỗi niềm nhớ quê hương trở về quê nhà thăm nom cha mẹ già.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每逢春节来临之际，常年在繁华大都市打拼的游子们都会满怀思乡之情返回故乡探望年迈的父母。', 'Měiféng Chúnjié láilín zhī jì, chángnián zài fánhuá dà dūshì dǎpīn de yóuzǐmen dōu huì mǎnhuái sīxiāng zhī qíng fǎnhuí gùxiāng tànwàng niánmài de fùmǔ.', 'Mỗi khi dịp Tết Nguyên đán cận kề, những người con xa xứ bươn chải quanh năm nơi đô thị phồn hoa đều mang trọn nỗi niềm nhớ quê hương trở về quê nhà thăm nom cha mẹ già.', 'basic', 1),
      (v_id, '地方政府充分依托革命老区深厚的红色文化底蕴与生态资源，大力培育农旅文融合特色示范乡，走出了一条乡村振兴的新路子。', 'Dìfāng zhèngfǔ chōngfèn yītuō gémìng lǎoqū shēnhòu de hóngsè wénhuà dǐyùn yǔ shēngtài zīyuán, dàlì péiyù nóng-lǚ-wén rónghé tèsè shìfàn xiāng, zǒu chū le yī tiáo xiāngcūn zhènxīng de xīn lùzi.', 'Chính quyền địa phương dựa chắc vào nền tảng văn hóa cách mạng cách mạng sâu sắc và tài nguyên sinh thái của căn cứ kháng chiến cũ, dốc sức nuôi dưỡng xã điểm kiểu mẫu đặc sắc kết hợp nông nghiệp - du lịch - văn hóa, mở ra con đường mới cho chấn hưng nông thôn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3247] [相处] (xiāngchǔ) - chung sống, hòa thuận, đối xử với nhau, ăn ở với nhau [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '相处' AND pinyin = 'xiāngchǔ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相处' AND pinyin = 'xiāngchǔ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '相处'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相处'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiāngchǔ',
      meaning_vi = 'chung sống, hòa thuận, đối xử với nhau, ăn ở với nhau',
      example_hanzi = '同事之间在日常工作中应当坦诚沟通、互相尊重，保持融洽友善的相处关系。',
      example_pinyin = 'Tóngshì zhījiān zài rìcháng gōngzuò zhōng yīngdāng tǎnchéng gōutōng, hùxiāng zūnzhòng, bǎochí róngqià yǒushàn de xiāngchǔ guānxì.',
      example_vi = 'Đồng nghiệp với nhau trong công việc hàng ngày cần trao đổi thẳng thắn chân thành, tôn trọng lẫn nhau, duy trì mối quan hệ đối xử chan hòa thân thiện.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '相处',
      'xiāngchǔ',
      'chung sống, hòa thuận, đối xử với nhau, ăn ở với nhau',
      'Động từ',
      'HSK 5',
      '同事之间在日常工作中应当坦诚沟通、互相尊重，保持融洽友善的相处关系。',
      'Tóngshì zhījiān zài rìcháng gōngzuò zhōng yīngdāng tǎnchéng gōutōng, hùxiāng zūnzhòng, bǎochí róngqià yǒushàn de xiāngchǔ guānxì.',
      'Đồng nghiệp với nhau trong công việc hàng ngày cần trao đổi thẳng thắn chân thành, tôn trọng lẫn nhau, duy trì mối quan hệ đối xử chan hòa thân thiện.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '同事之间在日常工作中应当坦诚沟通、互相尊重，保持融洽友善的相处关系。', 'Tóngshì zhījiān zài rìcháng gōngzuò zhōng yīngdāng tǎnchéng gōutōng, hùxiāng zūnzhòng, bǎochí róngqià yǒushàn de xiāngchǔ guānxì.', 'Đồng nghiệp với nhau trong công việc hàng ngày cần trao đổi thẳng thắn chân thành, tôn trọng lẫn nhau, duy trì mối quan hệ đối xử chan hòa thân thiện.', 'basic', 1),
      (v_id, '跨国工程项目海外派驻团队必须深刻尊重并理解东道国的多元民俗信仰与法律文化，在求同存异中与当地社区居民和谐相处。', 'Kuàguó gōngchéng xiàngmù hǎiwài pàizhù tuánduì bìxū shēnkè zūnzhòng bìng lǐjiě dōngdàoguó de duōyuán mínsú xìnyǎng yǔ fǎlǜ wénhuà, zài qiútóng-cúnyì zhōng yǔ dāngdì shèqū jūmín héxié xiāngchǔ.', 'Đoàn công tác biệt phái ở nước ngoài của dự án công trình xuyên quốc gia bắt buộc phải tôn trọng sâu sắc và thấu hiểu tín ngưỡng phong tục tập quán đa dạng cùng văn hóa pháp luật của nước sở tại, chung sống hài hòa với cư dân cộng đồng địa phương trên cơ sở tìm kiếm điểm tương đồng và bảo lưu dị biệt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3248] [乡村] (xiāngcūn) - nông thôn, làng quê, thôn xóm [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '乡村' AND pinyin = 'xiāngcūn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乡村' AND pinyin = 'xiāngcūn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '乡村'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '乡村'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiāngcūn',
      meaning_vi = 'nông thôn, làng quê, thôn xóm',
      example_hanzi = '乡村的清晨宁静而美好，远处传来的公鸡啼鸣与袅袅炊烟交织成一幅动人的田园画卷。',
      example_pinyin = 'Xiāngcūn de qīngchén níngjìng ér měihǎo, yuǎnchù chuánlái de gōngjī tímíng yǔ niǎoniǎo chuīyān jiāozhī chéng yī fú dòngrén de tiányuán huàjuàn.',
      example_vi = 'Buổi sớm nơi thôn quê yên bình và tươi đẹp, tiếng gà trống gáy từ xa vọng lại quyện cùng làn khói bếp bảng lảng dệt nên một bức tranh điền viên lay động lòng người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '乡村',
      'xiāngcūn',
      'nông thôn, làng quê, thôn xóm',
      'Danh từ',
      'HSK 5',
      '乡村的清晨宁静而美好，远处传来的公鸡啼鸣与袅袅炊烟交织成一幅动人的田园画卷。',
      'Xiāngcūn de qīngchén níngjìng ér měihǎo, yuǎnchù chuánlái de gōngjī tímíng yǔ niǎoniǎo chuīyān jiāozhī chéng yī fú dòngrén de tiányuán huàjuàn.',
      'Buổi sớm nơi thôn quê yên bình và tươi đẹp, tiếng gà trống gáy từ xa vọng lại quyện cùng làn khói bếp bảng lảng dệt nên một bức tranh điền viên lay động lòng người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '乡村的清晨宁静而美好，远处传来的公鸡啼鸣与袅袅炊烟交织成一幅动人的田园画卷。', 'Xiāngcūn de qīngchén níngjìng ér měihǎo, yuǎnchù chuánlái de gōngjī tímíng yǔ niǎoniǎo chuīyān jiāozhī chéng yī fú dòngrén de tiányuán huàjuàn.', 'Buổi sớm nơi thôn quê yên bình và tươi đẹp, tiếng gà trống gáy từ xa vọng lại quyện cùng làn khói bếp bảng lảng dệt nên một bức tranh điền viên lay động lòng người.', 'basic', 1),
      (v_id, '扎实有序推进宜居宜业和美乡村建设，关键在于因地制宜做大做强特色富民产业，全面提升农村现代人居环境与公共服务水准。', 'Zhāshi yǒuxù tuījìn yíjū-yíyè héměi xiāngcūn jiànshè, guānjiàn zàiyú yīndì-zhìyí zuò dà zuò qiáng tèsè fùmín chǎnyè, quánmiàn tíshēng nóngcūn xiàndài rénjū huánjìng yǔ gōnggòng fúwù shuǐzhǔn.', 'Đẩy mạnh xây dựng nông thôn tươi đẹp hài hòa đáng sống đáng làm việc một cách vững chắc có trật tự, then chốt nằm ở việc bám sát đặc điểm địa phương để mở rộng và phát triển mạnh mẽ các ngành kinh tế đặc thù làm giàu cho dân, nâng tầm toàn diện môi trường sống hiện đại và chuẩn mực dịch vụ công cộng nông thôn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3249] [相当] (xiāngdāng) - khá, tương đối; tương đương, ngang ngửa [Phó từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '相当' AND pinyin = 'xiāngdāng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相当' AND pinyin = 'xiāngdāng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '相当'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相当'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Phó từ / Động từ',
      pinyin = 'xiāngdāng',
      meaning_vi = 'khá, tương đối; tương đương, ngang ngửa',
      example_hanzi = '这台最新款专业微单相机的拍摄画质和高速对焦性能相当出色，深受广大摄影爱好者青睐。',
      example_pinyin = 'Zhè tái zuìxīn kuǎn zhuānyè wēidān xiàngjī de pāishè huàzhì hé gāosù duìjiāo xìngnéng xiāngdāng chūsè, shēnshòu guǎngdà shèyǐng àihàozhě qīnglài.',
      example_vi = 'Chất lượng hình ảnh chụp và hiệu năng lấy nét tốc độ cao của chiếc máy ảnh không gương lật chuyên nghiệp đời mới nhất này khá xuất sắc, rất được đông đảo người đam mê nhiếp ảnh ưa chuộng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '相当',
      'xiāngdāng',
      'khá, tương đối; tương đương, ngang ngửa',
      'Phó từ / Động từ',
      'HSK 5',
      '这台最新款专业微单相机的拍摄画质和高速对焦性能相当出色，深受广大摄影爱好者青睐。',
      'Zhè tái zuìxīn kuǎn zhuānyè wēidān xiàngjī de pāishè huàzhì hé gāosù duìjiāo xìngnéng xiāngdāng chūsè, shēnshòu guǎngdà shèyǐng àihàozhě qīnglài.',
      'Chất lượng hình ảnh chụp và hiệu năng lấy nét tốc độ cao của chiếc máy ảnh không gương lật chuyên nghiệp đời mới nhất này khá xuất sắc, rất được đông đảo người đam mê nhiếp ảnh ưa chuộng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这台最新款专业微单相机的拍摄画质和高速对焦性能相当出色，深受广大摄影爱好者青睐。', 'Zhè tái zuìxīn kuǎn zhuānyè wēidān xiàngjī de pāishè huàzhì hé gāosù duìjiāo xìngnéng xiāngdāng chūsè, shēnshòu guǎngdà shèyǐng àihàozhě qīnglài.', 'Chất lượng hình ảnh chụp và hiệu năng lấy nét tốc độ cao của chiếc máy ảnh không gương lật chuyên nghiệp đời mới nhất này khá xuất sắc, rất được đông đảo người đam mê nhiếp ảnh ưa chuộng.', 'basic', 1),
      (v_id, '面对严峻复杂的全球宏观经济环境考验，该先进制造业产业集群仍旧展现出了相当强劲的发展韧性与抗风险综合实力。', 'Miànduì yánjùn fùzá de quánqiú hóngguān jīngjì huánjìng kǎoyàn, gāi xiānjìn zhìzàoyè chǎnyè jíqún réngjiù zhǎnxiàn chū le xiāngdāng qiángjìn de fāzhǎn rènxìng yǔ kàng-fēngxiǎn zōnghé shílì.', 'Trước những thử thách khắt khe phức tạp của môi trường kinh tế vĩ mô toàn cầu, cụm ngành chế tạo tiên tiến này vẫn phô diễn tính linh hoạt dẻo dai phát triển và thực lực tổng hợp kháng cự rủi ro tương đối mạnh mẽ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3250] [相对] (xiāngduì) - tương đối; đối diện, đối lập [Tính từ / Phó từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '相对' AND pinyin = 'xiāngduì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相对' AND pinyin = 'xiāngduì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '相对'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相对'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Phó từ',
      pinyin = 'xiāngduì',
      meaning_vi = 'tương đối; đối diện, đối lập',
      example_hanzi = '与喧闹繁忙的商业步行街相比，藏身于绿树胡同深处的这家老书店环境显得相对清幽安谧。',
      example_pinyin = 'Yǔ xuānnào fánmáng de shāngyè bùxíngjiē xiāngbǐ, cángshēn yú lǜshù hútòng shēndù de zhè jiā lǎo shūdiàn huánjìng xiǎnde xiāngduì qīngyōu ānmì.',
      example_vi = 'So với con phố đi bộ thương mại huyên náo tấp nập, không gian của tiệm sách cũ ẩn mình sâu trong con ngõ rợp bóng cây xanh trông có vẻ tương đối thanh tĩnh và êm ả.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '相对',
      'xiāngduì',
      'tương đối; đối diện, đối lập',
      'Tính từ / Phó từ',
      'HSK 5',
      '与喧闹繁忙的商业步行街相比，藏身于绿树胡同深处的这家老书店环境显得相对清幽安谧。',
      'Yǔ xuānnào fánmáng de shāngyè bùxíngjiē xiāngbǐ, cángshēn yú lǜshù hútòng shēndù de zhè jiā lǎo shūdiàn huánjìng xiǎnde xiāngduì qīngyōu ānmì.',
      'So với con phố đi bộ thương mại huyên náo tấp nập, không gian của tiệm sách cũ ẩn mình sâu trong con ngõ rợp bóng cây xanh trông có vẻ tương đối thanh tĩnh và êm ả.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '与喧闹繁忙的商业步行街相比，藏身于绿树胡同深处的这家老书店环境显得相对清幽安谧。', 'Yǔ xuānnào fánmáng de shāngyè bùxíngjiē xiāngbǐ, cángshēn yú lǜshù hútòng shēndù de zhè jiā lǎo shūdiàn huánjìng xiǎnde xiāngduì qīngyōu ānmì.', 'So với con phố đi bộ thương mại huyên náo tấp nập, không gian của tiệm sách cũ ẩn mình sâu trong con ngõ rợp bóng cây xanh trông có vẻ tương đối thanh tĩnh và êm ả.', 'basic', 1),
      (v_id, '现代理论物理学中的狭义相对论深刻揭示了时空结构的相对性原理，彻底重塑了人类对物质运动与引力本质的认知体系。', 'Xiàndài lǐlùn wùlǐxué zhōng de xiáyì xiāngduìlùn shēnkè jiēshì le shíkōng jiégòu de xiāngduìxìng yuánlǐ, chèdǐ chóngsù le rénlèi duì wùzhì yùndòng yǔ yǐnlì běnzhì de rènzhī tǐxì.', 'Thuyết tương đối hẹp trong vật lý lý thuyết hiện đại đã hé lộ sâu sắc nguyên lý tương đối của cấu trúc không - thời gian, tái định hình triệt để hệ thống nhận thức của loài người về chuyển động vật chất và bản chất của lực hấp dẫn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3251] [相关] (xiāngguān) - liên quan, có tương quan [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '相关' AND pinyin = 'xiāngguān'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相关' AND pinyin = 'xiāngguān'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '相关'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相关'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'xiāngguān',
      meaning_vi = 'liên quan, có tương quan',
      example_hanzi = '在正式提交科研项目申报材料之前，请务必仔细研读官方网站上发布的申报指南及相关政策文件。',
      example_pinyin = 'Zài zhèngshì tíjiāo kēyán xiàngmù shēnbào cáiliào zhīqián, qǐng wùbì zǐxì yándú guānfāng wǎngzhàn shàng fābù de shēnbào zhǐnán jí xiāngguān zhèngcè wénjiàn.',
      example_vi = 'Trước khi chính thức nộp hồ sơ đăng ký đề tài nghiên cứu khoa học, xin quý vị nhất định phải đọc kỹ bản hướng dẫn đăng ký và các văn bản chính sách liên quan được đăng tải trên trang web chính thức.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '相关',
      'xiāngguān',
      'liên quan, có tương quan',
      'Tính từ / Động từ',
      'HSK 5',
      '在正式提交科研项目申报材料之前，请务必仔细研读官方网站上发布的申报指南及相关政策文件。',
      'Zài zhèngshì tíjiāo kēyán xiàngmù shēnbào cáiliào zhīqián, qǐng wùbì zǐxì yándú guānfāng wǎngzhàn shàng fābù de shēnbào zhǐnán jí xiāngguān zhèngcè wénjiàn.',
      'Trước khi chính thức nộp hồ sơ đăng ký đề tài nghiên cứu khoa học, xin quý vị nhất định phải đọc kỹ bản hướng dẫn đăng ký và các văn bản chính sách liên quan được đăng tải trên trang web chính thức.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在正式提交科研项目申报材料之前，请务必仔细研读官方网站上发布的申报指南及相关政策文件。', 'Zài zhèngshì tíjiāo kēyán xiàngmù shēnbào cáiliào zhīqián, qǐng wùbì zǐxì yándú guānfāng wǎngzhàn shàng fābù de shēnbào zhǐnán jí xiāngguān zhèngcè wénjiàn.', 'Trước khi chính thức nộp hồ sơ đăng ký đề tài nghiên cứu khoa học, xin quý vị nhất định phải đọc kỹ bản hướng dẫn đăng ký và các văn bản chính sách liên quan được đăng tải trên trang web chính thức.', 'basic', 1),
      (v_id, '反垄断审查执法机关依法对相关商品市场与相关地域市场的竞争结构开展严密量化评估，坚决遏制滥用市场支配地位行为。', 'Fǎnlǒngduàn shěnchá zhífǎ jīgòu yīfǎ duì xiāngguān shāngpǐn shìchǎng yǔ xiāngguān dìyù shìchǎng de jìngzhēng jiégòu kāizhǎn yánmì liànghuà pínggū, jiānjué èzhì lànyòng shìchǎng zhīpèi dìwèi xíngwéi.', 'Cơ quan thực thi pháp luật thẩm tra chống độc quyền căn cứ theo pháp luật thực hiện đánh giá định lượng chặt chẽ đối với cơ cấu cạnh tranh của thị trường sản phẩm liên quan và thị trường địa lý liên quan, kiên quyết ngăn chặn hành vi lạm dụng vị trí thống lĩnh thị trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3252] [相似] (xiāngsì) - tương tự, giống nhau [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '相似' AND pinyin = 'xiāngsì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相似' AND pinyin = 'xiāngsì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '相似'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相似'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'xiāngsì',
      meaning_vi = 'tương tự, giống nhau',
      example_hanzi = '这对双胞胎姐妹不仅容貌极其相似，连说话时的语气和神态都十分接近。',
      example_pinyin = 'Zhè duì shuāngbāotāi jiěmèi bùjǐn róngmào jíqí xiāngsì, lián shuōhuà shí de yǔqì hé shéntài dōu shífēn jiējìn.',
      example_vi = 'Cặp chị em sinh đôi này không chỉ dung mạo vô cùng giống nhau, mà đến cả ngữ khí và thần thái khi trò chuyện cũng rất đỗi tương đồng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '相似',
      'xiāngsì',
      'tương tự, giống nhau',
      'Tính từ',
      'HSK 5',
      '这对双胞胎姐妹不仅容貌极其相似，连说话时的语气和神态都十分接近。',
      'Zhè duì shuāngbāotāi jiěmèi bùjǐn róngmào jíqí xiāngsì, lián shuōhuà shí de yǔqì hé shéntài dōu shífēn jiējìn.',
      'Cặp chị em sinh đôi này không chỉ dung mạo vô cùng giống nhau, mà đến cả ngữ khí và thần thái khi trò chuyện cũng rất đỗi tương đồng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这对双胞胎姐妹不仅容貌极其相似，连说话时的语气和神态都十分接近。', 'Zhè duì shuāngbāotāi jiěmèi bùjǐn róngmào jíqí xiāngsì, lián shuōhuà shí de yǔqì hé shéntài dōu shífēn jiējìn.', 'Cặp chị em sinh đôi này không chỉ dung mạo vô cùng giống nhau, mà đến cả ngữ khí và thần thái khi trò chuyện cũng rất đỗi tương đồng.', 'basic', 1),
      (v_id, '生物信息学全基因组比对算法表明，该新型变异毒株在受体结合结构域的氨基酸序列与已知毒株存在极高的结构相似性。', 'Shēngwù xìnxīxué quán-jīyīnzǔ bǐduì suànfǎ biǎomíng, gāi xīnxíng biànyì dúzhū zài shòutǐ jiéhé jiégòuyù de ānjīsuān xùliè yǔ yǐzhī dúzhū cúnzài jí gāo de jiégòu xiāngsìxìng.', 'Thuật toán so khớp toàn bộ hệ gen của tin sinh học chỉ ra rằng, chuỗi axit amin trong miền liên kết thụ thể của chủng virus biến dị mới này có độ tương đồng cấu trúc cực cao với các chủng đã biết.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3253] [想念] (xiǎngniàn) - nhớ nhung, tưởng nhớ, hoài niệm [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '想念' AND pinyin = 'xiǎngniàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '想念' AND pinyin = 'xiǎngniàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '想念'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '想念'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiǎngniàn',
      meaning_vi = 'nhớ nhung, tưởng nhớ, hoài niệm',
      example_hanzi = '独自身在异国他乡求学，每当夜幕降临他都会格外想念家乡的亲人和朋友。',
      example_pinyin = 'Dúzì shēn zài yìguó-tāxiāng qiúxué, měidāng yèmù jiànglín tā dōu huì géwài xiǎngniàn jiāxiāng de qīnrén hé péngyou.',
      example_vi = 'Một mình nơi đất khách quê người học tập, mỗi khi màn đêm buông xuống anh ấy đều đặc biệt nhớ nhung người thân và bạn bè nơi quê nhà.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '想念',
      'xiǎngniàn',
      'nhớ nhung, tưởng nhớ, hoài niệm',
      'Động từ',
      'HSK 5',
      '独自身在异国他乡求学，每当夜幕降临他都会格外想念家乡的亲人和朋友。',
      'Dúzì shēn zài yìguó-tāxiāng qiúxué, měidāng yèmù jiànglín tā dōu huì géwài xiǎngniàn jiāxiāng de qīnrén hé péngyou.',
      'Một mình nơi đất khách quê người học tập, mỗi khi màn đêm buông xuống anh ấy đều đặc biệt nhớ nhung người thân và bạn bè nơi quê nhà.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '独自身在异国他乡求学，每当夜幕降临他都会格外想念家乡的亲人和朋友。', 'Dúzì shēn zài yìguó-tāxiāng qiúxué, měidāng yèmù jiànglín tā dōu huì géwài xiǎngniàn jiāxiāng de qīnrén hé péngyou.', 'Một mình nơi đất khách quê người học tập, mỗi khi màn đêm buông xuống anh ấy đều đặc biệt nhớ nhung người thân và bạn bè nơi quê nhà.', 'basic', 1),
      (v_id, '广大海外侨胞虽身处万里重洋之外，却始终深切想念着祖国的繁荣发展，并以赤子之心积极投身祖国现代化建设与慈善公益。', 'Guǎngdà hǎiwài qiáobāo suī shēnchǔ wànlǐ chóngyáng zhī wài, què shǐzhōng shēnqiè xiǎngniàn zhe zǔguó de fánróng fāzhǎn, bìng yǐ chìzǐ zhī xīn jījí tóushēn zǔguó xiàndàihuà jiànshè yǔ cìshàn gōngyì.', 'Đông đảo kiều bào ở nước ngoài tuy cách xa vạn dặm trùng dương, song luôn tha thiết hướng về sự phát triển phồn vinh của tổ quốc, dốc trọn tấm lòng người con đất Việt tích cực tham gia vào công cuộc hiện đại hóa và hoạt động từ thiện công ích của quê hương.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3254] [响声] (xiǎngshēng) - tiếng vang, âm thanh, tiếng động [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '响声' AND pinyin = 'xiǎngshēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '响声' AND pinyin = 'xiǎngshēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '响声'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '响声'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiǎngshēng',
      meaning_vi = 'tiếng vang, âm thanh, tiếng động',
      example_hanzi = '夜深人静的时候，窗外突然传来一阵清脆的玻璃破碎响声，惊醒了熟睡中的邻居。',
      example_pinyin = 'Yèshēn-rénjìng de shíhou, chuāngwài tūrán chuánlái yī zhèn qīngcuì de bōli pòsuì xiǎngshēng, jīngxǐng le shúshuì zhōng de línjū.',
      example_vi = 'Vào lúc đêm khuya thanh vắng, bên ngoài cửa sổ bỗng truyền đến một chuỗi âm thanh kính vỡ loảng xoảng, đánh thức người hàng xóm đang ngủ say.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '响声',
      'xiǎngshēng',
      'tiếng vang, âm thanh, tiếng động',
      'Danh từ',
      'HSK 5',
      '夜深人静的时候，窗外突然传来一阵清脆的玻璃破碎响声，惊醒了熟睡中的邻居。',
      'Yèshēn-rénjìng de shíhou, chuāngwài tūrán chuánlái yī zhèn qīngcuì de bōli pòsuì xiǎngshēng, jīngxǐng le shúshuì zhōng de línjū.',
      'Vào lúc đêm khuya thanh vắng, bên ngoài cửa sổ bỗng truyền đến một chuỗi âm thanh kính vỡ loảng xoảng, đánh thức người hàng xóm đang ngủ say.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '夜深人静的时候，窗外突然传来一阵清脆的玻璃破碎响声，惊醒了熟睡中的邻居。', 'Yèshēn-rénjìng de shíhou, chuāngwài tūrán chuánlái yī zhèn qīngcuì de bōli pòsuì xiǎngshēng, jīngxǐng le shúshuì zhōng de línjū.', 'Vào lúc đêm khuya thanh vắng, bên ngoài cửa sổ bỗng truyền đến một chuỗi âm thanh kính vỡ loảng xoảng, đánh thức người hàng xóm đang ngủ say.', 'basic', 1),
      (v_id, '高速动车组车载声学振动传感器实时捕捉车轮踏面与轨道接触面的异常撞击响声，实现关键走行部件机械微裂纹早期智能诊断。', 'Gāosù dòngchēzǔ chēzài shēngxué zhèndòng chuángǎnqì shíshí bǔzhuō chēlún tàmiàn yǔ guǐdào jiēchùmiàn de yìcháng zhuàngjī xiǎngshēng, shíxiàn guānjiàn zǒuxíng bùjiàn jīxiè wēilièwén zǎoqī zhìnéng zhěnduàn.', 'Cảm biến rung động âm học trên đoàn tàu cao tốc EMU bắt giữ thời gian thực những âm thanh va đập bất thường giữa mặt lăn bánh xe và bề mặt tiếp xúc đường ray, giúp chẩn đoán thông minh sớm các vết nứt vi mô cơ học của các bộ phận di chuyển trọng yếu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3255] [享受] (xiǎngshòu) - hưởng thụ, tận hưởng; sự hưởng thụ [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '享受' AND pinyin = 'xiǎngshòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '享受' AND pinyin = 'xiǎngshòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '享受'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '享受'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xiǎngshòu',
      meaning_vi = 'hưởng thụ, tận hưởng; sự hưởng thụ',
      example_hanzi = '忙碌了一整周之后，在周末和家人一起去郊外露营野餐是一件极其享受的事情。',
      example_pinyin = 'Mánglù le yī zhěng zhōu zhīhòu, zài zhōumò hé jiārén yīqǐ qù jiāowài lùyíng yěcān shì yī jiàn jíqí xiǎngshòu de shìqing.',
      example_vi = 'Sau khi bận rộn suốt cả tuần lễ, cùng gia đình đi cắm trại dã ngoại ở ngoại ô vào dịp cuối tuần là một điều vô cùng đáng tận hưởng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '享受',
      'xiǎngshòu',
      'hưởng thụ, tận hưởng; sự hưởng thụ',
      'Động từ / Danh từ',
      'HSK 5',
      '忙碌了一整周之后，在周末和家人一起去郊外露营野餐是一件极其享受的事情。',
      'Mánglù le yī zhěng zhōu zhīhòu, zài zhōumò hé jiārén yīqǐ qù jiāowài lùyíng yěcān shì yī jiàn jíqí xiǎngshòu de shìqing.',
      'Sau khi bận rộn suốt cả tuần lễ, cùng gia đình đi cắm trại dã ngoại ở ngoại ô vào dịp cuối tuần là một điều vô cùng đáng tận hưởng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '忙碌了一整周之后，在周末和家人一起去郊外露营野餐是一件极其享受的事情。', 'Mánglù le yī zhěng zhōu zhīhòu, zài zhōumò hé jiārén yīqǐ qù jiāowài lùyíng yěcān shì yī jiàn jíqí xiǎngshòu de shìqing.', 'Sau khi bận rộn suốt cả tuần lễ, cùng gia đình đi cắm trại dã ngoại ở ngoại ô vào dịp cuối tuần là một điều vô cùng đáng tận hưởng.', 'basic', 1),
      (v_id, '大力推进优质基本公共服务均等化与社会保障提标扩面，让广大人民群众公平充分享受高质量改革发展带来的丰硕红利。', 'Dàlì tuījìn yōuzhì jīběn gōnggòng fúwù jūnděnghuà yǔ shèhuì bǎozhàng tíbiāo kuòmiàn, ràng guǎngdà rénmín qúnzhòng gōngpíng chōngfèn xiǎngshòu gāozhìliàng gǎigé fāzhǎn dài lái de fēngshuò hónglì.', 'Nỗ lực thúc đẩy bình đẳng hóa các dịch vụ công cộng cơ bản chất lượng cao và nâng cao chuẩn mức mở rộng diện bao phủ bảo hiểm xã hội, để đông đảo quần chúng nhân dân được thụ hưởng công bằng và trọn vẹn những cổ tức dồi dào từ cải cách phát triển chất lượng cao mang lại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3256] [想象] (xiǎngxiàng) - tưởng tượng; sự tưởng tượng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '想象' AND pinyin = 'xiǎngxiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '想象' AND pinyin = 'xiǎngxiàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '想象'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '想象'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xiǎngxiàng',
      meaning_vi = 'tưởng tượng; sự tưởng tượng',
      example_hanzi = '现代数字科技的迅猛发展已经远远超出了半个世纪前科幻作家们的最前卫想象。',
      example_pinyin = 'Xiàndài shùzì kējì de xùnměng fāzhǎn yǐjīng yuǎnyuǎn chāochū le bàn gè shìjì qián kēhuàn zuòjiāmen de zuì qiánwèi xiǎngxiàng.',
      example_vi = 'Sự phát triển vũ bão của công nghệ số hiện đại đã vượt xa sức tưởng tượng tiên phong nhất của các nhà văn khoa học viễn tưởng nửa thế kỷ trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '想象',
      'xiǎngxiàng',
      'tưởng tượng; sự tưởng tượng',
      'Động từ / Danh từ',
      'HSK 5',
      '现代数字科技的迅猛发展已经远远超出了半个世纪前科幻作家们的最前卫想象。',
      'Xiàndài shùzì kējì de xùnměng fāzhǎn yǐjīng yuǎnyuǎn chāochū le bàn gè shìjì qián kēhuàn zuòjiāmen de zuì qiánwèi xiǎngxiàng.',
      'Sự phát triển vũ bão của công nghệ số hiện đại đã vượt xa sức tưởng tượng tiên phong nhất của các nhà văn khoa học viễn tưởng nửa thế kỷ trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '现代数字科技的迅猛发展已经远远超出了半个世纪前科幻作家们的最前卫想象。', 'Xiàndài shùzì kējì de xùnměng fāzhǎn yǐjīng yuǎnyuǎn chāochū le bàn gè shìjì qián kēhuàn zuòjiāmen de zuì qiánwèi xiǎngxiàng.', 'Sự phát triển vũ bão của công nghệ số hiện đại đã vượt xa sức tưởng tượng tiên phong nhất của các nhà văn khoa học viễn tưởng nửa thế kỷ trước.', 'basic', 1),
      (v_id, '人类探索浩瀚宇宙未知深空的伟大科学征程，既需要基于严密物理实证的数理推演，更离不开勇于突破认知边界的宏大科学想象力。', 'Rénlèi tànsuǒ hàohàn yǔzhòu wèizhī shēnkōng de wěidà kēxué zhēngchéng, jì xūyào jīyú yánmì wùlǐ shízhèng de shùlǐ tuīyǎn, gèng lí bù kāi yǒngyú tūpò rènzhī biānjiè de hóngdà kēxué xiǎngxiànglì.', 'Hành trình khoa học vĩ đại của loài người khám phá không gian sâu thẳm chưa biết trong vũ trụ bao la, vừa cần suy luận toán lý dựa trên chứng thực vật lý chặt chẽ, lại vừa không thể thiếu trí tưởng tượng khoa học to lớn dám bứt phá ranh giới nhận thức.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3257] [相册] (xiàngcè) - cuốn album ảnh, tập ảnh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '相册' AND pinyin = 'xiàngcè'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相册' AND pinyin = 'xiàngcè'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '相册'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '相册'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiàngcè',
      meaning_vi = 'cuốn album ảnh, tập ảnh',
      example_hanzi = '奶奶小心翼翼地翻开泛黄的家庭老相册，指着黑白旧照片微笑着回忆过去的岁月。',
      example_pinyin = 'Nǎinai xiǎoxīn-yìyì de fānkāi fànhuáng de jiātíng lǎo xiàngcè, zhǐ zhe hēibái jiù zhàopiàn wēixiào zhe huíyì guòqù de suìyuè.',
      example_vi = 'Bà cẩn thận lật mở cuốn album ảnh cũ của gia đình đã ố vàng, mỉm cười chỉ vào những bức ảnh đen trắng xưa cũ nhớ lại những năm tháng đã qua.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '相册',
      'xiàngcè',
      'cuốn album ảnh, tập ảnh',
      'Danh từ',
      'HSK 5',
      '奶奶小心翼翼地翻开泛黄的家庭老相册，指着黑白旧照片微笑着回忆过去的岁月。',
      'Nǎinai xiǎoxīn-yìyì de fānkāi fànhuáng de jiātíng lǎo xiàngcè, zhǐ zhe hēibái jiù zhàopiàn wēixiào zhe huíyì guòqù de suìyuè.',
      'Bà cẩn thận lật mở cuốn album ảnh cũ của gia đình đã ố vàng, mỉm cười chỉ vào những bức ảnh đen trắng xưa cũ nhớ lại những năm tháng đã qua.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '奶奶小心翼翼地翻开泛黄的家庭老相册，指着黑白旧照片微笑着回忆过去的岁月。', 'Nǎinai xiǎoxīn-yìyì de fānkāi fànhuáng de jiātíng lǎo xiàngcè, zhǐ zhe hēibái jiù zhàopiàn wēixiào zhe huíyì guòqù de suìyuè.', 'Bà cẩn thận lật mở cuốn album ảnh cũ của gia đình đã ố vàng, mỉm cười chỉ vào những bức ảnh đen trắng xưa cũ nhớ lại những năm tháng đã qua.', 'basic', 1),
      (v_id, '智能终端移动操作系统依托深度神经网络人脸聚类与场景语义分析算法，自动为用户聚合生成极具温情的时光主题数字相册。', 'Zhìnéng zhōngduān yídòng cāozuò xìtǒng yītuō shēndù shénjīng wǎngluò rénliǎn jùlèi yǔ chǎngjǐng yǔyì fēnxī suànfǎ, zìdòng wèi yònghù jùhé shēngchéng jí jù wēnqíng de shíguāng zhǔtí shùzì xiàngcè.', 'Hệ điều hành di động trên thiết bị thông minh dựa vào mạng nơ-ron sâu phân cụm khuôn mặt và thuật toán phân tích ngữ nghĩa bối cảnh để tự động tổng hợp tạo ra các album ảnh kỹ thuật số theo chủ đề thời gian ngập tràn ấm áp cho người dùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3258] [项目] (xiàngmù) - hạng mục, dự án, đề án [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '项目' AND pinyin = 'xiàngmù'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '项目' AND pinyin = 'xiàngmù'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '项目'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '项目'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiàngmù',
      meaning_vi = 'hạng mục, dự án, đề án',
      example_hanzi = '我们研发团队负责的软件架构重构项目进展十分顺利，预计将于下月中旬正式交付上线。',
      example_pinyin = 'Wǒmen yánfā tuánduì fùzé de ruǎnjiàn jiàgòu chónggòu xiàngmù jìnzhǎn shífēn shùnlì, yùjì jiāng yú xiàyuè zhōngxún zhèngshì jiāofù shàngxiàn.',
      example_vi = 'Dự án tái cấu trúc kiến trúc phần mềm do đội ngũ R&D chúng tôi phụ trách đang tiến triển vô cùng thuận lợi, dự kiến sẽ chính thức bàn giao vận hành vào giữa tháng sau.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '项目',
      'xiàngmù',
      'hạng mục, dự án, đề án',
      'Danh từ',
      'HSK 5',
      '我们研发团队负责的软件架构重构项目进展十分顺利，预计将于下月中旬正式交付上线。',
      'Wǒmen yánfā tuánduì fùzé de ruǎnjiàn jiàgòu chónggòu xiàngmù jìnzhǎn shífēn shùnlì, yùjì jiāng yú xiàyuè zhōngxún zhèngshì jiāofù shàngxiàn.',
      'Dự án tái cấu trúc kiến trúc phần mềm do đội ngũ R&D chúng tôi phụ trách đang tiến triển vô cùng thuận lợi, dự kiến sẽ chính thức bàn giao vận hành vào giữa tháng sau.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '我们研发团队负责的软件架构重构项目进展十分顺利，预计将于下月中旬正式交付上线。', 'Wǒmen yánfā tuánduì fùzé de ruǎnjiàn jiàgòu chónggòu xiàngmù jìnzhǎn shífēn shùnlì, yùjì jiāng yú xiàyuè zhōngxún zhèngshì jiāofù shàngxiàn.', 'Dự án tái cấu trúc kiến trúc phần mềm do đội ngũ R&D chúng tôi phụ trách đang tiến triển vô cùng thuận lợi, dự kiến sẽ chính thức bàn giao vận hành vào giữa tháng sau.', 'basic', 1),
      (v_id, '国家发展改革委联合多个部委批准实施一批具备重大战略引领效应的新型基础设施与清洁能源超级工程项目。', 'Guójiā fāzhǎn gǎigéwěi liánhé duō gè bùwěi pīzhǔn shíshī yī pī jùbèi zhòngdà zhànlüè yǐnlǐng xiàoyìng de xīnxíng jīchǔ shèshī yǔ qīngjié néngyuán chāojí gōngchéng xiàngmù.', 'Ủy ban Cải cách và Phát triển Quốc gia phối hợp với nhiều bộ ngành phê duyệt triển khai một loạt dự án siêu công trình năng lượng sạch và hạ tầng mới có hiệu ứng dẫn dắt chiến lược trọng đại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3259] [橡皮] (xiàngpí) - cục tẩy, cục gôm, cao su [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '橡皮' AND pinyin = 'xiàngpí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '橡皮' AND pinyin = 'xiàngpí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '橡皮'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '橡皮'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiàngpí',
      meaning_vi = 'cục tẩy, cục gôm, cao su',
      example_hanzi = '小学生在文具盒里整齐地摆放着铅笔、直尺和一块带有果香味的白色橡皮。',
      example_pinyin = 'Xiǎoxuéshēng zài wénjùhé lǐ zhěngqí de bǎifàng zhe qiānbǐ, zhíchǐ hé yī kuài dài yǒu guǒxiāngwèi de báisè xiàngpí.',
      example_vi = 'Học sinh tiểu học xếp ngay ngắn bút chì, thước kẻ và một cục tẩy màu trắng có hương thơm hoa quả vào trong hộp bút.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '橡皮',
      'xiàngpí',
      'cục tẩy, cục gôm, cao su',
      'Danh từ',
      'HSK 5',
      '小学生在文具盒里整齐地摆放着铅笔、直尺和一块带有果香味的白色橡皮。',
      'Xiǎoxuéshēng zài wénjùhé lǐ zhěngqí de bǎifàng zhe qiānbǐ, zhíchǐ hé yī kuài dài yǒu guǒxiāngwèi de báisè xiàngpí.',
      'Học sinh tiểu học xếp ngay ngắn bút chì, thước kẻ và một cục tẩy màu trắng có hương thơm hoa quả vào trong hộp bút.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '小学生在文具盒里整齐地摆放着铅笔、直尺和一块带有果香味的白色橡皮。', 'Xiǎoxuéshēng zài wénjùhé lǐ zhěngqí de bǎifàng zhe qiānbǐ, zhíchǐ hé yī kuài dài yǒu guǒxiāngwèi de báisè xiàngpí.', 'Học sinh tiểu học xếp ngay ngắn bút chì, thước kẻ và một cục tẩy màu trắng có hương thơm hoa quả vào trong hộp bút.', 'basic', 1),
      (v_id, '工业设计师在进行手绘精密机械概念草图创作时，巧妙借助专业高光素描橡皮擦拭出金属部件富有立体感的反光与过渡层次。', 'Gōngyè shèjìshī zài jìnxíng shǒuhuì jīngmì jīxiè gàiniàn cǎotú chuàngzuò shí, qiǎomiào jièzhù zhuānyè gāoguāng sùmiáo xiàngpí cāshì chū jīnshǔ bùjiàn fùyǒu lìtǐgǎn de fǎnguāng yǔ guòdù céngcì.', 'Nhà thiết kế công nghiệp khi vẽ phác thảo tay ý tưởng cơ khí chính xác đã khéo léo dùng cục tẩy phác họa tạo vệt sáng chuyên dụng để tẩy ra các vệt phản quang và tầng lớp chuyển tiếp tràn đầy cảm giác không gian 3D của linh kiện kim loại.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3260] [向上] (xiàngshàng) - hướng lên, vươn lên, cầu tiến [Động từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '向上' AND pinyin = 'xiàngshàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '向上' AND pinyin = 'xiàngshàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '向上'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '向上'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Tính từ',
      pinyin = 'xiàngshàng',
      meaning_vi = 'hướng lên, vươn lên, cầu tiến',
      example_hanzi = '无论身处怎样的人生逆境，青年人都应当保持一种积极乐观、昂扬向上的精神风貌。',
      example_pinyin = 'Wúlùn shēnchǔ zěnyàng de rénshēng nìjìng, qīngniánrén dōu yīngdāng bǎochí yī zhǒng jījí lèguān, ángyáng xiàngshàng de jīngshén fēngmào.',
      example_vi = 'Dù ở trong nghịch cảnh cuộc đời nào, thanh niên đều nên giữ vững một diện mạo tinh thần tích cực lạc quan, luôn hăng hái vươn lên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '向上',
      'xiàngshàng',
      'hướng lên, vươn lên, cầu tiến',
      'Động từ / Tính từ',
      'HSK 5',
      '无论身处怎样的人生逆境，青年人都应当保持一种积极乐观、昂扬向上的精神风貌。',
      'Wúlùn shēnchǔ zěnyàng de rénshēng nìjìng, qīngniánrén dōu yīngdāng bǎochí yī zhǒng jījí lèguān, ángyáng xiàngshàng de jīngshén fēngmào.',
      'Dù ở trong nghịch cảnh cuộc đời nào, thanh niên đều nên giữ vững một diện mạo tinh thần tích cực lạc quan, luôn hăng hái vươn lên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '无论身处怎样的人生逆境，青年人都应当保持一种积极乐观、昂扬向上的精神风貌。', 'Wúlùn shēnchǔ zěnyàng de rénshēng nìjìng, qīngniánrén dōu yīngdāng bǎochí yī zhǒng jījí lèguān, ángyáng xiàngshàng de jīngshén fēngmào.', 'Dù ở trong nghịch cảnh cuộc đời nào, thanh niên đều nên giữ vững một diện mạo tinh thần tích cực lạc quan, luôn hăng hái vươn lên.', 'basic', 1),
      (v_id, '在百年变局与逆全球化逆风冲击下，我国高端装备制造业投资增速与高新技术产品外贸出口依然保持稳健向上的昂扬发展态势。', 'Zài bǎinián biànjú yǔ nì-quánqiúhuà nìfēng chōngjī xià, wǒguó gāoduān zhuāngbèi zhìzàoyè tóuzī zēngsù yǔ gāoxīnjìshù chǎnpǐn wàimào chūkǒu yīrán bǎochí wěnjiàn xiàngshàng de ángyáng fāzhǎn tàishì.', 'Dưới tác động của biến cục trăm năm và những luồng gió ngược chống toàn cầu hóa, tốc độ tăng trưởng đầu tư ngành chế tạo thiết bị cao cấp và kim ngạch xuất khẩu sản phẩm công nghệ cao của nước nhà vẫn duy trì đà phát triển vươn lên ổn định và mạnh mẽ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3261] [象征] (xiàngzhēng) - tượng trưng; biểu tượng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '象征' AND pinyin = 'xiàngzhēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '象征' AND pinyin = 'xiàngzhēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '象征'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '象征'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xiàngzhēng',
      meaning_vi = 'tượng trưng; biểu tượng',
      example_hanzi = '在中国传统民俗文化中，傲雪凌霜的红梅向来是坚强不屈与崇高品格的象征。',
      example_pinyin = 'Zài Zhōngguó chuántǒng mínsú wénhuà zhōng, àoxuě-língshuāng de hóngméi xiànglái shì jiānqiáng bùqū yǔ chónggāo pǐngé de xiàngzhēng.',
      example_vi = 'Trong văn hóa phong tục truyền thống Trung Hoa, hoa mai đỏ hiên ngang trong tuyết sương từ xưa tới nay luôn là biểu tượng của tinh thần kiên cường bất khuất và phẩm cách thanh cao.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '象征',
      'xiàngzhēng',
      'tượng trưng; biểu tượng',
      'Động từ / Danh từ',
      'HSK 5',
      '在中国传统民俗文化中，傲雪凌霜的红梅向来是坚强不屈与崇高品格的象征。',
      'Zài Zhōngguó chuántǒng mínsú wénhuà zhōng, àoxuě-língshuāng de hóngméi xiànglái shì jiānqiáng bùqū yǔ chónggāo pǐngé de xiàngzhēng.',
      'Trong văn hóa phong tục truyền thống Trung Hoa, hoa mai đỏ hiên ngang trong tuyết sương từ xưa tới nay luôn là biểu tượng của tinh thần kiên cường bất khuất và phẩm cách thanh cao.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在中国传统民俗文化中，傲雪凌霜的红梅向来是坚强不屈与崇高品格的象征。', 'Zài Zhōngguó chuántǒng mínsú wénhuà zhōng, àoxuě-língshuāng de hóngméi xiànglái shì jiānqiáng bùqū yǔ chónggāo pǐngé de xiàngzhēng.', 'Trong văn hóa phong tục truyền thống Trung Hoa, hoa mai đỏ hiên ngang trong tuyết sương từ xưa tới nay luôn là biểu tượng của tinh thần kiên cường bất khuất và phẩm cách thanh cao.', 'basic', 1),
      (v_id, '两国正式签署双边本币互换协议与自贸协定升级议定书，象征着双边多领域全方位务实战略经贸合作迈上了崭新台阶。', 'Liǎng guó zhèngshì qiānshǔ shuāngbiān běnbì hùhuàn xiéyì yǔ zìmào xiéyì shēngjí yìdìngshū, xiàngzhēng zhe shuāngbiān duō lǐngyù quán-fāngwèi wùshí zhànlüè jīngmào hézuò mài shàng le zhǎnxīn táijiē.', 'Hai nước chính thức ký kết thỏa thuận hoán đổi đồng nội tệ song phương và nghị định thư nâng cấp hiệp định thương mại tự do, tượng trưng cho sự hợp tác kinh tế thương mại chiến lược thực chất toàn diện đa lĩnh vực song phương đã bước lên nấc thang mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3262] [消费] (xiāofèi) - tiêu dùng, chi tiêu; sức mua [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '消费' AND pinyin = 'xiāofèi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消费' AND pinyin = 'xiāofèi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '消费'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消费'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xiāofèi',
      meaning_vi = 'tiêu dùng, chi tiêu; sức mua',
      example_hanzi = '随着居民收入水平的稳步提升，人们在文旅休闲、健康体育等高品质服务领域的消费支出占比逐步扩大。',
      example_pinyin = 'Suízhe jūmín shōurù shuǐpíng de wěnbù tíshēng, rénmen zài wén-lǚ xiūxián, jiànkāng tǐyù děng gāopǐnzhì fúwù lǐngyù de xiāofèi zhīchū zhànbǐ zhúbù kuòdà.',
      example_vi = 'Cùng với sự gia tăng ổn định của mức thu nhập người dân, tỷ trọng chi tiêu tiêu dùng của mọi người trong các lĩnh vực dịch vụ chất lượng cao như du lịch văn hóa nghỉ dưỡng, thể thao chăm sóc sức khỏe từng bước được mở rộng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '消费',
      'xiāofèi',
      'tiêu dùng, chi tiêu; sức mua',
      'Động từ / Danh từ',
      'HSK 5',
      '随着居民收入水平的稳步提升，人们在文旅休闲、健康体育等高品质服务领域的消费支出占比逐步扩大。',
      'Suízhe jūmín shōurù shuǐpíng de wěnbù tíshēng, rénmen zài wén-lǚ xiūxián, jiànkāng tǐyù děng gāopǐnzhì fúwù lǐngyù de xiāofèi zhīchū zhànbǐ zhúbù kuòdà.',
      'Cùng với sự gia tăng ổn định của mức thu nhập người dân, tỷ trọng chi tiêu tiêu dùng của mọi người trong các lĩnh vực dịch vụ chất lượng cao như du lịch văn hóa nghỉ dưỡng, thể thao chăm sóc sức khỏe từng bước được mở rộng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '随着居民收入水平的稳步提升，人们在文旅休闲、健康体育等高品质服务领域的消费支出占比逐步扩大。', 'Suízhe jūmín shōurù shuǐpíng de wěnbù tíshēng, rénmen zài wén-lǚ xiūxián, jiànkāng tǐyù děng gāopǐnzhì fúwù lǐngyù de xiāofèi zhīchū zhànbǐ zhúbù kuòdà.', 'Cùng với sự gia tăng ổn định của mức thu nhập người dân, tỷ trọng chi tiêu tiêu dùng của mọi người trong các lĩnh vực dịch vụ chất lượng cao như du lịch văn hóa nghỉ dưỡng, thể thao chăm sóc sức khỏe từng bước được mở rộng.', 'basic', 1),
      (v_id, '宏观政策组合拳着力激发潜在内需，通过发放数字消费券与推动耐用消费品以旧换新，全面激发大宗消费与新型绿色消费活力。', 'Hóngguān zhèngcè zǔhéquán zhuólì jīfā qiánzài nèixū, tōngguò fāfàng shùzì xiāofèiquàn yǔ tuīdòng nàiyòng xiāofèipǐn yǐjiù-huànxīn, quánmiàn jīfā dàzōng xiāofèi yǔ xīnxíng lǜsè xiāofèi huólì.', 'Gói giải pháp chính sách vĩ mô tập trung kích thích nội nhu tiềm năng, thông qua việc phát phiếu mua sắm kỹ thuật số và đẩy mạnh chương trình đổi hàng tiêu dùng lâu bền cũ lấy mới, kích hoạt toàn diện sức sống tiêu dùng quy mô lớn và tiêu dùng xanh kiểu mới.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3263] [消费者] (xiāofèizhě) - người tiêu dùng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '消费者' AND pinyin = 'xiāofèizhě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消费者' AND pinyin = 'xiāofèizhě'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '消费者'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消费者'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiāofèizhě',
      meaning_vi = 'người tiêu dùng',
      example_hanzi = '电子商务交易平台应当严格遵守法律法规，切实保障广大消费者的知情权与公平交易权。',
      example_pinyin = 'Diànzǐ shāngwù jiāoyì píngtái yīngdāng yángé zūnshǒu fǎlǜ fǎguī, qièshí bǎozhàng guǎngdà xiāofèizhě de zhīqíngquán yǔ gōngpíng jiāoyìquán.',
      example_vi = 'Các nền tảng giao dịch thương mại điện tử cần tuân thủ nghiêm ngặt pháp luật và quy định, bảo vệ thiết thực quyền được thông tin và quyền giao dịch công bằng của đông đảo người tiêu dùng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '消费者',
      'xiāofèizhě',
      'người tiêu dùng',
      'Danh từ',
      'HSK 5',
      '电子商务交易平台应当严格遵守法律法规，切实保障广大消费者的知情权与公平交易权。',
      'Diànzǐ shāngwù jiāoyì píngtái yīngdāng yángé zūnshǒu fǎlǜ fǎguī, qièshí bǎozhàng guǎngdà xiāofèizhě de zhīqíngquán yǔ gōngpíng jiāoyìquán.',
      'Các nền tảng giao dịch thương mại điện tử cần tuân thủ nghiêm ngặt pháp luật và quy định, bảo vệ thiết thực quyền được thông tin và quyền giao dịch công bằng của đông đảo người tiêu dùng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '电子商务交易平台应当严格遵守法律法规，切实保障广大消费者的知情权与公平交易权。', 'Diànzǐ shāngwù jiāoyì píngtái yīngdāng yángé zūnshǒu fǎlǜ fǎguī, qièshí bǎozhàng guǎngdà xiāofèizhě de zhīqíngquán yǔ gōngpíng jiāoyìquán.', 'Các nền tảng giao dịch thương mại điện tử cần tuân thủ nghiêm ngặt pháp luật và quy định, bảo vệ thiết thực quyền được thông tin và quyền giao dịch công bằng của đông đảo người tiêu dùng.', 'basic', 1),
      (v_id, '市场监督管理部门畅通在线消费纠纷多元化解通道，依法严厉惩处虚假商业宣传与大数据杀熟，全方位捍卫消费者合法权益。', 'Shìchǎng jiāndū guǎnlǐ bùmén chàngtōng zàixiàn xiāofèi jiūfēn duōyuán huàjiě tōngdào, yīfǎ yánlì chéngchǔ xūjiǎ shāngyè xuānchuán yǔ dàshùjù shāshú, quán-fāngwèi hànwèi xiāofèizhě héfǎ quányì.', 'Cơ quan quản lý giám sát thị trường khơi thông các kênh giải quyết đa dạng tranh chấp tiêu dùng trực tuyến, trừng phạt nghiêm khắc theo pháp luật đối với hành vi quảng cáo gian dối và thuật toán phân biệt giá người dùng cũ bằng dữ liệu lớn, bảo vệ toàn diện quyền lợi hợp pháp của người tiêu dùng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3264] [消化] (xiāohuà) - tiêu hóa, tiếp thu, lĩnh hội, thấu hiểu [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '消化' AND pinyin = 'xiāohuà'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消化' AND pinyin = 'xiāohuà'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '消化'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消化'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiāohuà',
      meaning_vi = 'tiêu hóa, tiếp thu, lĩnh hội, thấu hiểu',
      example_hanzi = '吃完晚饭后不宜立即进行剧烈运动，慢步走上半小时更有利于胃肠道的正常消化。',
      example_pinyin = 'Chī wán wǎnfàn hòu bù yí lìjí jìnxíng jùliè yùndòng, mànbù zǒu shàng bàn xiǎoshí gèng yǒulì yú wèichángdào de zhèngcháng xiāohuà.',
      example_vi = 'Sau khi ăn xong bữa tối không nên lập tức vận động mạnh, đi bộ thong thả khoảng nửa tiếng đồng hồ sẽ có lợi hơn cho sự tiêu hóa bình thường của đường ruột và dạ dày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '消化',
      'xiāohuà',
      'tiêu hóa, tiếp thu, lĩnh hội, thấu hiểu',
      'Động từ',
      'HSK 5',
      '吃完晚饭后不宜立即进行剧烈运动，慢步走上半小时更有利于胃肠道的正常消化。',
      'Chī wán wǎnfàn hòu bù yí lìjí jìnxíng jùliè yùndòng, mànbù zǒu shàng bàn xiǎoshí gèng yǒulì yú wèichángdào de zhèngcháng xiāohuà.',
      'Sau khi ăn xong bữa tối không nên lập tức vận động mạnh, đi bộ thong thả khoảng nửa tiếng đồng hồ sẽ có lợi hơn cho sự tiêu hóa bình thường của đường ruột và dạ dày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '吃完晚饭后不宜立即进行剧烈运动，慢步走上半小时更有利于胃肠道的正常消化。', 'Chī wán wǎnfàn hòu bù yí lìjí jìnxíng jùliè yùndòng, mànbù zǒu shàng bàn xiǎoshí gèng yǒulì yú wèichángdào de zhèngcháng xiāohuà.', 'Sau khi ăn xong bữa tối không nên lập tức vận động mạnh, đi bộ thong thả khoảng nửa tiếng đồng hồ sẽ có lợi hơn cho sự tiêu hóa bình thường của đường ruột và dạ dày.', 'basic', 1),
      (v_id, '高科技实体企业在引进国际先进技术成果的同时，必须加大自主研发投入力度，切实做好消化吸收与底层二次集成创新。', 'Gāokējì shítǐ qǐyè zài yǐnjìn guójì xiānjìn jìshù chéngguǒ de tóngshí, bìxū jiādà zìzhǔ yánfā tóurù lìdù, qièshí zuò hǎo xiāohuà xīshōu yǔ dǐcéng èrcì jíchéng chuàngxīn.', 'Doanh nghiệp thực thể công nghệ cao trong khi nhập khẩu thành quả công nghệ tiên tiến quốc tế bắt buộc phải gia tăng đầu tư R&D tự chủ, làm tốt việc tiếp thu tiêu hóa và đổi mới sáng tạo tích hợp tầng đáy lần hai.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3265] [消极] (xiāojí) - tiêu cực, bi quan, thụ động [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '消极' AND pinyin = 'xiāojí'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消极' AND pinyin = 'xiāojí'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '消极'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消极'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'xiāojí',
      meaning_vi = 'tiêu cực, bi quan, thụ động',
      example_hanzi = '在工作中遇到困难和挫折时，消极抱怨无济于事，唯有积极寻找解决途径才能破局。',
      example_pinyin = 'Zài gōngzuò zhōng yù dào kùnnan hé cuòzhé shí, xiāojí bàoyuàn wújìyúshì, wéiyǒu jījí xúnzhǎo jiějué tújìng cáinéng pòjú.',
      example_vi = 'Khi gặp khó khăn và trắc trở trong công việc, oán trách tiêu cực cũng chẳng giúp ích được gì, chỉ có chủ động tìm kiếm con đường giải quyết mới có thể phá vỡ bế tắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '消极',
      'xiāojí',
      'tiêu cực, bi quan, thụ động',
      'Tính từ',
      'HSK 5',
      '在工作中遇到困难和挫折时，消极抱怨无济于事，唯有积极寻找解决途径才能破局。',
      'Zài gōngzuò zhōng yù dào kùnnan hé cuòzhé shí, xiāojí bàoyuàn wújìyúshì, wéiyǒu jījí xúnzhǎo jiějué tújìng cáinéng pòjú.',
      'Khi gặp khó khăn và trắc trở trong công việc, oán trách tiêu cực cũng chẳng giúp ích được gì, chỉ có chủ động tìm kiếm con đường giải quyết mới có thể phá vỡ bế tắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在工作中遇到困难和挫折时，消极抱怨无济于事，唯有积极寻找解决途径才能破局。', 'Zài gōngzuò zhōng yù dào kùnnan hé cuòzhé shí, xiāojí bàoyuàn wújìyúshì, wéiyǒu jījí xúnzhǎo jiějué tújìng cáinéng pòjú.', 'Khi gặp khó khăn và trắc trở trong công việc, oán trách tiêu cực cũng chẳng giúp ích được gì, chỉ có chủ động tìm kiếm con đường giải quyết mới có thể phá vỡ bế tắc.', 'basic', 1),
      (v_id, '企事业单位推进组织机构深层次改革中，必须坚决摒弃消极避责与被动观望心态，以积极担当作为的精神打破利益固化藩篱。', 'Qǐ-shìyè dānwèi tuījìn zǔzhī jīgòu shēncéngcì gǎigé zhōng, bìxū jiānjué bǐngqì xiāojí bìzé yǔ bèidòng guānwàng xīntài, yǐ jījí dāndāng zuòwéi de jīngshén dǎpò lìyì gùhuà fānlí.', 'Các đơn vị doanh nghiệp và sự nghiệp khi đẩy mạnh cải cách cơ cấu tổ chức tầng sâu bắt buộc phải kiên quyết loại bỏ tâm lý trốn tránh trách nhiệm tiêu cực và thụ động nghe ngóng, dùng tinh thần tích cực gánh vác hành động để phá vỡ rào cản lợi ích cố hữu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3266] [销量] (xiāoliàng) - doanh số bán ra, sản lượng tiêu thụ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '销量' AND pinyin = 'xiāoliàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '销量' AND pinyin = 'xiāoliàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '销量'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '销量'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiāoliàng',
      meaning_vi = 'doanh số bán ra, sản lượng tiêu thụ',
      example_hanzi = '这款性能优异且性价比极高的新款智能手机，在发布上市首月就创下了全国单品销量第一的好成绩。',
      example_pinyin = 'Zhè kuǎn xìngnéng yōuyì qiě xìngjiàbǐ jí gāo de xīnkuǎn zhìnéng shǒujī, zài fābù shàngshì shǒuyuè jiù chuàngxià le quánguó dānpǐn xiāoliàng dì-yī de hǎo chéngjì.',
      example_vi = 'Mẫu điện thoại thông minh đời mới với hiệu năng vượt trội và tỷ lệ hiệu năng trên giá thành cực cao này, ngay trong tháng đầu tiên mở bán đã lập nên thành tích tốt với sản lượng tiêu thụ đơn sản phẩm đứng đầu toàn quốc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '销量',
      'xiāoliàng',
      'doanh số bán ra, sản lượng tiêu thụ',
      'Danh từ',
      'HSK 5',
      '这款性能优异且性价比极高的新款智能手机，在发布上市首月就创下了全国单品销量第一的好成绩。',
      'Zhè kuǎn xìngnéng yōuyì qiě xìngjiàbǐ jí gāo de xīnkuǎn zhìnéng shǒujī, zài fābù shàngshì shǒuyuè jiù chuàngxià le quánguó dānpǐn xiāoliàng dì-yī de hǎo chéngjì.',
      'Mẫu điện thoại thông minh đời mới với hiệu năng vượt trội và tỷ lệ hiệu năng trên giá thành cực cao này, ngay trong tháng đầu tiên mở bán đã lập nên thành tích tốt với sản lượng tiêu thụ đơn sản phẩm đứng đầu toàn quốc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这款性能优异且性价比极高的新款智能手机，在发布上市首月就创下了全国单品销量第一的好成绩。', 'Zhè kuǎn xìngnéng yōuyì qiě xìngjiàbǐ jí gāo de xīnkuǎn zhìnéng shǒujī, zài fābù shàngshì shǒuyuè jiù chuàngxià le quánguó dānpǐn xiāoliàng dì-yī de hǎo chéngjì.', 'Mẫu điện thoại thông minh đời mới với hiệu năng vượt trội và tỷ lệ hiệu năng trên giá thành cực cao này, ngay trong tháng đầu tiên mở bán đã lập nên thành tích tốt với sản lượng tiêu thụ đơn sản phẩm đứng đầu toàn quốc.', 'basic', 1),
      (v_id, '新能源汽车龙头企业依托全栈自研的核心三电技术与垂直整合产业链，连续多个季度蝉联全球新能源汽车单车型销量冠军宝座。', 'Xīnnéngyuán qìchē lóngtóu qǐyè yītuō quánzhàn zìyán de héxīn sāndiàn jìshù yǔ chuízhí zhěnghé chǎnyèliàn, liánxù duō gè jìdù chánlián quánqiú xīnnéngyuán qìchē dān chēxíng xiāoliàng guànjūn bǎozuò.', 'Doanh nghiệp đầu ngành xe năng lượng mới nhờ vào công nghệ ba hệ thống điện cốt lõi tự nghiên cứu toàn diện và chuỗi công nghiệp tích hợp dọc, đã liên tiếp nhiều quý giữ vững ngôi quán quân về sản lượng bán ra của mẫu xe đơn năng lượng mới trên toàn cầu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3267] [消失] (xiāoshī) - biến mất, tiêu tan, mất hút [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '消失' AND pinyin = 'xiāoshī'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消失' AND pinyin = 'xiāoshī'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '消失'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '消失'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiāoshī',
      meaning_vi = 'biến mất, tiêu tan, mất hút',
      example_hanzi = '清晨的第一缕朝阳穿透薄雾，原本笼罩在平静湖面上的白色水汽很快就彻底消失了。',
      example_pinyin = 'Qīngchén de dì-yī lǚ zhāoyáng chuāntòu báowù, yuánběn lǒngzhào zài píngjìng húmiàn shàng de báisè shuǐqì hěn kuài jiù chèdǐ xiāoshī le.',
      example_vi = 'Tia nắng ban mai đầu tiên xuyên qua làn sương mỏng, lớp hơi nước trắng xóa vốn bao phủ trên mặt hồ phẳng lặng rất nhanh đã hoàn toàn biến mất.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '消失',
      'xiāoshī',
      'biến mất, tiêu tan, mất hút',
      'Động từ',
      'HSK 5',
      '清晨的第一缕朝阳穿透薄雾，原本笼罩在平静湖面上的白色水汽很快就彻底消失了。',
      'Qīngchén de dì-yī lǚ zhāoyáng chuāntòu báowù, yuánběn lǒngzhào zài píngjìng húmiàn shàng de báisè shuǐqì hěn kuài jiù chèdǐ xiāoshī le.',
      'Tia nắng ban mai đầu tiên xuyên qua làn sương mỏng, lớp hơi nước trắng xóa vốn bao phủ trên mặt hồ phẳng lặng rất nhanh đã hoàn toàn biến mất.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '清晨的第一缕朝阳穿透薄雾，原本笼罩在平静湖面上的白色水汽很快就彻底消失了。', 'Qīngchén de dì-yī lǚ zhāoyáng chuāntòu báowù, yuánběn lǒngzhào zài píngjìng húmiàn shàng de báisè shuǐqì hěn kuài jiù chèdǐ xiāoshī le.', 'Tia nắng ban mai đầu tiên xuyên qua làn sương mỏng, lớp hơi nước trắng xóa vốn bao phủ trên mặt hồ phẳng lặng rất nhanh đã hoàn toàn biến mất.', 'basic', 1),
      (v_id, '依托生态水网工程连通与流域严格禁牧休耕举措，科研人员成功遏制并逆转了干旱内陆尾闾湖泊濒临干涸消失的严峻生态危机。', 'Yītuō shēngtài shuǐwǎng gōngchéng liántōng yǔ liùyù yángé jìnmù xiūgēng jǔcuò, kēyán rényuán chénggōng èzhì bìng nìzhuǎn le gānhàn nèilù wěilǘ húpō bīnlín gānhé xiāoshī de yánjùn shēngtài wēijī.', 'Dựa vào công trình liên thông mạng lưới nước sinh thái và các biện pháp cấm chăn thả cho đất nghỉ nghiêm ngặt của lưu vực, các nhà khoa học đã ngăn chặn và đảo ngược thành công cuộc khủng hoảng sinh thái nghiêm trọng khi hồ nước đuôi sông vùng nội địa khô hạn đứng trước bờ vực cạn khô và biến mất.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3268] [销售] (xiāoshòu) - bán hàng, tiêu thụ; nghiệp vụ bán hàng [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '销售' AND pinyin = 'xiāoshòu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '销售' AND pinyin = 'xiāoshòu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '销售'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '销售'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xiāoshòu',
      meaning_vi = 'bán hàng, tiêu thụ; nghiệp vụ bán hàng',
      example_hanzi = '凭借诚恳耐心的服务态度和扎实的产品专业知识，他连续三个月被评为部门的“优秀销售标兵”。',
      example_pinyin = 'Píngjiè chéngkěn nàixīn de fúwù tàidù hé zhāshi de chǎnpǐn zhuānyè zhīshi, tā liánxù sān gè yuè bèi píng wéi bùmén de “yōuxiù xiāoshòu biāobīng”.',
      example_vi = 'Nhờ vào thái độ phục vụ chân thành kiên nhẫn và vốn kiến thức chuyên môn sản phẩm vững vàng, anh ấy đã ba tháng liên tiếp được bình chọn là "người gương mẫu bán hàng xuất sắc" của bộ phận.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '销售',
      'xiāoshòu',
      'bán hàng, tiêu thụ; nghiệp vụ bán hàng',
      'Động từ / Danh từ',
      'HSK 5',
      '凭借诚恳耐心的服务态度和扎实的产品专业知识，他连续三个月被评为部门的“优秀销售标兵”。',
      'Píngjiè chéngkěn nàixīn de fúwù tàidù hé zhāshi de chǎnpǐn zhuānyè zhīshi, tā liánxù sān gè yuè bèi píng wéi bùmén de “yōuxiù xiāoshòu biāobīng”.',
      'Nhờ vào thái độ phục vụ chân thành kiên nhẫn và vốn kiến thức chuyên môn sản phẩm vững vàng, anh ấy đã ba tháng liên tiếp được bình chọn là "người gương mẫu bán hàng xuất sắc" của bộ phận.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '凭借诚恳耐心的服务态度和扎实的产品专业知识，他连续三个月被评为部门的“优秀销售标兵”。', 'Píngjiè chéngkěn nàixīn de fúwù tàidù hé zhāshi de chǎnpǐn zhuānyè zhīshi, tā liánxù sān gè yuè bèi píng wéi bùmén de “yōuxiù xiāoshòu biāobīng”.', 'Nhờ vào thái độ phục vụ chân thành kiên nhẫn và vốn kiến thức chuyên môn sản phẩm vững vàng, anh ấy đã ba tháng liên tiếp được bình chọn là "người gương mẫu bán hàng xuất sắc" của bộ phận.', 'basic', 1),
      (v_id, '跨国医药实体企业在全球范围内规范构建处方药品全生命周期合规营销网络，全方位提升直营与分销体系的销售合规风控水准。', 'Kuàguó yīyào shítǐ qǐyè zài quánqiú fànwéi nèi guīfàn gòujiàn chǔfāng yàopǐn quán-shēngmìng zhōuqī hégūi yíngxiāo wǎngluò, quán-fāngwèi tíshēng zhíyíng yǔ fēnxiāo tǐxì de xiāoshòu hégūi fēngkòng shuǐzhǔn.', 'Doanh nghiệp dược phẩm thực thể đa quốc gia chuẩn hóa việc xây dựng mạng lưới tiếp thị tuân thủ quy chuẩn toàn bộ vòng đời của thuốc theo đơn trên phạm vi toàn cầu, nâng cao toàn diện mức độ kiểm soát rủi ro tuân thủ pháp lý trong bán hàng của hệ thống trực doanh và phân phối.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3269] [小姐] (xiǎojiě) - tiểu thư, cô gái, cô (cách xưng hô lịch sự) [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '小姐' AND pinyin = 'xiǎojiě'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '小姐' AND pinyin = 'xiǎojiě'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '小姐'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '小姐'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiǎojiě',
      meaning_vi = 'tiểu thư, cô gái, cô (cách xưng hô lịch sự)',
      example_hanzi = '前台接待人员礼貌地微笑着询问：“这位小姐，请问您提前预约了哪一位专家的咨询服务？”',
      example_pinyin = 'Qiántái jiēdài rényuán lǐmào de wēixiào zhe xùnwèn: “Zhè wèi xiǎojiě, qǐngwèn nín tíqián yùyuē le nǎ yī wèi zhuānjiā de zīxún fúwù?”',
      example_vi = 'Nhân viên lễ tân mỉm cười lịch thiệp hỏi: "Thưa cô, xin hỏi cô đã đặt lịch hẹn trước với chuyên gia tư vấn nào ạ?"'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '小姐',
      'xiǎojiě',
      'tiểu thư, cô gái, cô (cách xưng hô lịch sự)',
      'Danh từ',
      'HSK 5',
      '前台接待人员礼貌地微笑着询问：“这位小姐，请问您提前预约了哪一位专家的咨询服务？”',
      'Qiántái jiēdài rényuán lǐmào de wēixiào zhe xùnwèn: “Zhè wèi xiǎojiě, qǐngwèn nín tíqián yùyuē le nǎ yī wèi zhuānjiā de zīxún fúwù?”',
      'Nhân viên lễ tân mỉm cười lịch thiệp hỏi: "Thưa cô, xin hỏi cô đã đặt lịch hẹn trước với chuyên gia tư vấn nào ạ?"'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '前台接待人员礼貌地微笑着询问：“这位小姐，请问您提前预约了哪一位专家的咨询服务？”', 'Qiántái jiēdài rényuán lǐmào de wēixiào zhe xùnwèn: “Zhè wèi xiǎojiě, qǐngwèn nín tíqián yùyuē le nǎ yī wèi zhuānjiā de zīxún fúwù?”', 'Nhân viên lễ tân mỉm cười lịch thiệp hỏi: "Thưa cô, xin hỏi cô đã đặt lịch hẹn trước với chuyên gia tư vấn nào ạ?"', 'basic', 1),
      (v_id, '涉外商务礼仪培训明确规范了国际社交场合的称谓礼仪，强调在正式政商交往中应精准采用职衔称谓以示专业与尊重。', 'Shèwài shāngwù lǐyí péixùn míngquè guīfàn le guójì shèjiāo chǎnghé de chēngwèi lǐyí, qiángdiào zài zhèngshì zhèng-shāng jiāowǎng zhōng yīng jīngzhǔn cǎiyòng zhíxián chēngwèi yǐ shì zhuānyè yǔ zūnzhòng.', 'Khóa đào tạo nghi thức kinh doanh đối ngoại chuẩn hóa rõ ràng các quy tắc xưng hô trong giao thiệp quốc tế, nhấn mạnh trong các cuộc tiếp xúc chính khách - doanh nhân trang trọng cần dùng chuẩn xác chức danh để thể hiện sự tôn trọng và tính chuyên nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3270] [小型] (xiǎoxíng) - loại nhỏ, cỡ nhỏ, mini, quy mô nhỏ [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '小型' AND pinyin = 'xiǎoxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '小型' AND pinyin = 'xiǎoxíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '小型'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '小型'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'xiǎoxíng',
      meaning_vi = 'loại nhỏ, cỡ nhỏ, mini, quy mô nhỏ',
      example_hanzi = '这款小型家用空气净化器机身小巧轻便，非常适合摆放在书房桌角或床头柜上使用。',
      example_pinyin = 'Zhè kuǎn xiǎoxíng jiāyòng kōngqì jìnghuàqì jīshēn xiǎoqiǎo qīngbiàn, fēicháng shìhé bǎifàng zài shūfáng zhuōjiǎo huò chuángtóuguì shàng shǐyòng.',
      example_vi = 'Chiếc máy lọc không khí gia đình loại nhỏ này thân máy nhỏ gọn nhẹ nhàng, rất thích hợp để đặt ở góc bàn làm việc trong phòng đọc sách hoặc trên tủ đầu giường sử dụng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '小型',
      'xiǎoxíng',
      'loại nhỏ, cỡ nhỏ, mini, quy mô nhỏ',
      'Tính từ',
      'HSK 5',
      '这款小型家用空气净化器机身小巧轻便，非常适合摆放在书房桌角或床头柜上使用。',
      'Zhè kuǎn xiǎoxíng jiāyòng kōngqì jìnghuàqì jīshēn xiǎoqiǎo qīngbiàn, fēicháng shìhé bǎifàng zài shūfáng zhuōjiǎo huò chuángtóuguì shàng shǐyòng.',
      'Chiếc máy lọc không khí gia đình loại nhỏ này thân máy nhỏ gọn nhẹ nhàng, rất thích hợp để đặt ở góc bàn làm việc trong phòng đọc sách hoặc trên tủ đầu giường sử dụng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这款小型家用空气净化器机身小巧轻便，非常适合摆放在书房桌角或床头柜上使用。', 'Zhè kuǎn xiǎoxíng jiāyòng kōngqì jìnghuàqì jīshēn xiǎoqiǎo qīngbiàn, fēicháng shìhé bǎifàng zài shūfáng zhuōjiǎo huò chuángtóuguì shàng shǐyòng.', 'Chiếc máy lọc không khí gia đình loại nhỏ này thân máy nhỏ gọn nhẹ nhàng, rất thích hợp để đặt ở góc bàn làm việc trong phòng đọc sách hoặc trên tủ đầu giường sử dụng.', 'basic', 1),
      (v_id, '海洋科研团队成功研制出具备深海毫米级高精度避障感知能力的小型仿生水下机器人，可广泛应用于水下深窄管道缺陷无损检测。', 'Hǎiyáng kēyán tuánduì chénggōng yánzhì chū jùbèi shēnhǎi háomǐjí gāojīngdù bìzhàng gǎnzhī nénglì de xiǎoxíng fǎngshēng shuǐxià jīqìrén, kě guǎngfàn yìngyòng yú shuǐxià shēnzǎi guǎndào quēxiàn wúsǔn jiǎncè.', 'Đội ngũ nghiên cứu khoa học hải dương đã chế tạo thành công robot phỏng sinh học dưới nước cỡ nhỏ có năng lực cảm biến tránh vật cản độ chính xác cao cỡ milimet ở biển sâu, có thể ứng dụng rộng rãi vào việc dò tìm khuyết tật không phá hủy trong các đường ống ngầm hẹp sâu dưới nước.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3271] [小于] (xiǎoyú) - nhỏ hơn, ít hơn (<) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '小于' AND pinyin = 'xiǎoyú'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '小于' AND pinyin = 'xiǎoyú'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '小于'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '小于'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiǎoyú',
      meaning_vi = 'nhỏ hơn, ít hơn (<)',
      example_hanzi = '在平面几何运算中，如果一个锐角的度数严格小于九十度，它就属于典型的第一象限角。',
      example_pinyin = 'Zài píngmiàn jǐhé yùnsuàn zhōng, rúguǒ yī gè ruìjiǎo de dùshù yángé xiǎoyú jiǔshí dù, tā jiù shǔyú diǎnxíng de dì-yī xiàngxiàn jiǎo.',
      example_vi = 'Trong toán học hình học phẳng, nếu số đo của một góc nhọn nghiêm ngặt nhỏ hơn chín mươi độ, nó sẽ thuộc về góc góc phần tư thứ nhất điển hình.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '小于',
      'xiǎoyú',
      'nhỏ hơn, ít hơn (<)',
      'Động từ',
      'HSK 5',
      '在平面几何运算中，如果一个锐角的度数严格小于九十度，它就属于典型的第一象限角。',
      'Zài píngmiàn jǐhé yùnsuàn zhōng, rúguǒ yī gè ruìjiǎo de dùshù yángé xiǎoyú jiǔshí dù, tā jiù shǔyú diǎnxíng de dì-yī xiàngxiàn jiǎo.',
      'Trong toán học hình học phẳng, nếu số đo của một góc nhọn nghiêm ngặt nhỏ hơn chín mươi độ, nó sẽ thuộc về góc góc phần tư thứ nhất điển hình.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在平面几何运算中，如果一个锐角的度数严格小于九十度，它就属于典型的第一象限角。', 'Zài píngmiàn jǐhé yùnsuàn zhōng, rúguǒ yī gè ruìjiǎo de dùshù yángé xiǎoyú jiǔshí dù, tā jiù shǔyú diǎnxíng de dì-yī xiàngxiàn jiǎo.', 'Trong toán học hình học phẳng, nếu số đo của một góc nhọn nghiêm ngặt nhỏ hơn chín mươi độ, nó sẽ thuộc về góc góc phần tư thứ nhất điển hình.', 'basic', 1),
      (v_id, '超大规模集成电路光刻洁净车间对环境微粒控制极度苛刻，要求空气中粒径小于零点一微米的颗粒物数量严格达标国际顶级标准。', 'Chāo-dà guīmó jíchéng diànlù guāngkè jiéjìng chējiān duì huánjìng wēilì kòngzhì jídù kèkē, yāoqiú kōngqì zhōng lìjìng xiǎoyú líng diǎn yī wēimǐ de kēlìwù shùliàng yángé dābiāo guójì dǐngjí biāozhǔn.', 'Phòng sạch quang khắc vi mạch tích hợp quy mô siêu lớn kiểm soát cực kỳ nghiêm ngặt các hạt bụi vi mô môi trường, yêu cầu số lượng hạt có kích thước nhỏ hơn 0,1 micromet trong không khí phải đáp ứng chuẩn mực đỉnh cao quốc tế một cách nghiêm ngặt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3272] [效率] (xiàolǜ) - hiệu suất, năng suất [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '效率' AND pinyin = 'xiàolǜ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '效率' AND pinyin = 'xiàolǜ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '效率'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '效率'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xiàolǜ',
      meaning_vi = 'hiệu suất, năng suất',
      example_hanzi = '掌握科学高效的时间管理方法并保持高度专注，能够大幅提高平时的课业复习效率。',
      example_pinyin = 'Zhǎngwò kēxué gāoxiào de shíjiān guǎnlǐ fāngfǎ bìng bǎochí gāodù zhuānzhù, nénggòu dàfú tígāo píngshí de kèyè fùxí xiàolǜ.',
      example_vi = 'Nắm vững phương pháp quản lý thời gian khoa học hiệu quả cao và duy trì sự tập trung cao độ có thể nâng cao rất lớn hiệu suất ôn tập bài vở thường ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '效率',
      'xiàolǜ',
      'hiệu suất, năng suất',
      'Danh từ',
      'HSK 5',
      '掌握科学高效的时间管理方法并保持高度专注，能够大幅提高平时的课业复习效率。',
      'Zhǎngwò kēxué gāoxiào de shíjiān guǎnlǐ fāngfǎ bìng bǎochí gāodù zhuānzhù, nénggòu dàfú tígāo píngshí de kèyè fùxí xiàolǜ.',
      'Nắm vững phương pháp quản lý thời gian khoa học hiệu quả cao và duy trì sự tập trung cao độ có thể nâng cao rất lớn hiệu suất ôn tập bài vở thường ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '掌握科学高效的时间管理方法并保持高度专注，能够大幅提高平时的课业复习效率。', 'Zhǎngwò kēxué gāoxiào de shíjiān guǎnlǐ fāngfǎ bìng bǎochí gāodù zhuānzhù, nénggòu dàfú tígāo píngshí de kèyè fùxí xiàolǜ.', 'Nắm vững phương pháp quản lý thời gian khoa học hiệu quả cao và duy trì sự tập trung cao độ có thể nâng cao rất lớn hiệu suất ôn tập bài vở thường ngày.', 'basic', 1),
      (v_id, '依托工业互联网平台与全自主移动物流机器人协同作业，全球智能制造“灯塔工厂”的综合生产效率与良品率提升了近百分之四十。', 'Yītuō gōngyè hùliánwǎng píngtái yǔ quán-zìzhǔ yídòng wùliú jīqìrén xiétóng zuòyè, quánqiú zhìnéng zhìzào “dēngtǎ gōngchǎng” de zōnghé shēngchǎn xiàolǜ yǔ liángpǐnlǜ tíshēng le jìn bǎifēnzhī sìshí.', 'Dựa vào nền tảng internet công nghiệp và sự phối hợp tác nghiệp của robot logistics di động hoàn toàn tự hành, hiệu suất sản xuất tổng hợp và tỷ lệ sản phẩm đạt chuẩn của "nhà máy ngọn hải đăng" sản xuất thông minh toàn cầu đã tăng gần 40%.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3273] [斜] (xié) - nghiêng, xiên, chéo; làm nghiêng [Tính từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '斜' AND pinyin = 'xié'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '斜' AND pinyin = 'xié'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '斜'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '斜'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Động từ',
      pinyin = 'xié',
      meaning_vi = 'nghiêng, xiên, chéo; làm nghiêng',
      example_hanzi = '午后的温和阳光透过落地窗斜斜地洒在木地板上，给整个宽敞的客厅染上了一层金黄色。',
      example_pinyin = 'Wǔhòu de wēnhé yángguāng tòuguò luòdìchuāng xiéxié de sǎ zài mù dìbǎn shàng, gěi zhěng gè kuānchǎng de kètīng rǎn shàng le yī céng jīnhuángsè.',
      example_vi = 'Ánh nắng ấm áp ban chiều xuyên qua ô cửa sổ sát đất chiếu nghiêng nghiêng lên sàn gỗ, nhuộm một lớp màu vàng óng ả lên cả phòng khách rộng rãi.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '斜',
      'xié',
      'nghiêng, xiên, chéo; làm nghiêng',
      'Tính từ / Động từ',
      'HSK 5',
      '午后的温和阳光透过落地窗斜斜地洒在木地板上，给整个宽敞的客厅染上了一层金黄色。',
      'Wǔhòu de wēnhé yángguāng tòuguò luòdìchuāng xiéxié de sǎ zài mù dìbǎn shàng, gěi zhěng gè kuānchǎng de kètīng rǎn shàng le yī céng jīnhuángsè.',
      'Ánh nắng ấm áp ban chiều xuyên qua ô cửa sổ sát đất chiếu nghiêng nghiêng lên sàn gỗ, nhuộm một lớp màu vàng óng ả lên cả phòng khách rộng rãi.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '午后的温和阳光透过落地窗斜斜地洒在木地板上，给整个宽敞的客厅染上了一层金黄色。', 'Wǔhòu de wēnhé yángguāng tòuguò luòdìchuāng xiéxié de sǎ zài mù dìbǎn shàng, gěi zhěng gè kuānchǎng de kètīng rǎn shàng le yī céng jīnhuángsè.', 'Ánh nắng ấm áp ban chiều xuyên qua ô cửa sổ sát đất chiếu nghiêng nghiêng lên sàn gỗ, nhuộm một lớp màu vàng óng ả lên cả phòng khách rộng rãi.', 'basic', 1),
      (v_id, '土木工程监测专家利用高精度激光测距仪与三维姿态传感器，对经历强震冲击后的千年古塔斜度位移开展全天候微米级健康监测。', 'Tǔmù gōngchéng jiāncè zhuānjiā lìyòng gāojīngdù jīguāng cèjùyí yǔ sānwéi zìtài chuángǎnqì, duì jīnglì qiángzhèn chōngjī hòu de qiānnián gǔtǎ xiédù wèiyí kāizhǎn quántiānhòu wēimǐjí jiànkāng jiāncè.', 'Các chuyên gia giám sát công trình xây dựng dân dụng sử dụng máy đo khoảng cách laser độ chính xác cao và cảm biến tư thế 3D để thực hiện giám sát trạng thái an toàn cấp micromet suốt ngày đêm về độ nghiêng dịch chuyển của ngọn tháp cổ ngàn năm sau cơn chấn động mạnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3274] [协议] (xiéyì) - hiệp định, thỏa thuận, văn bản cam kết; hiệp thương [Danh từ / Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '协议' AND pinyin = 'xiéyì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '协议' AND pinyin = 'xiéyì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '协议'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '协议'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Động từ',
      pinyin = 'xiéyì',
      meaning_vi = 'hiệp định, thỏa thuận, văn bản cam kết; hiệp thương',
      example_hanzi = '经过多轮友好而务实的商务谈判，两家高科技领军企业在会议大厅正式签署了战略合作框架协议。',
      example_pinyin = 'Jīngguò duō lún yǒuhǎo ér wùshí de shāngwù tánpàn, liǎng jiā gāokējì lǐngjūn qǐyè zài huìyì dàtīng zhèngshì qiānshǔ le zhànlüè hézuò kuàngjià xiéyì.',
      example_vi = 'Trải qua nhiều vòng đàm phán thương mại hữu nghị và thực chất, hai doanh nghiệp công nghệ cao hàng đầu đã chính thức ký kết thỏa thuận khung hợp tác chiến lược tại hội trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '协议',
      'xiéyì',
      'hiệp định, thỏa thuận, văn bản cam kết; hiệp thương',
      'Danh từ / Động từ',
      'HSK 5',
      '经过多轮友好而务实的商务谈判，两家高科技领军企业在会议大厅正式签署了战略合作框架协议。',
      'Jīngguò duō lún yǒuhǎo ér wùshí de shāngwù tánpàn, liǎng jiā gāokējì lǐngjūn qǐyè zài huìyì dàtīng zhèngshì qiānshǔ le zhànlüè hézuò kuàngjià xiéyì.',
      'Trải qua nhiều vòng đàm phán thương mại hữu nghị và thực chất, hai doanh nghiệp công nghệ cao hàng đầu đã chính thức ký kết thỏa thuận khung hợp tác chiến lược tại hội trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过多轮友好而务实的商务谈判，两家高科技领军企业在会议大厅正式签署了战略合作框架协议。', 'Jīngguò duō lún yǒuhǎo ér wùshí de shāngwù tánpàn, liǎng jiā gāokējì lǐngjūn qǐyè zài huìyì dàtīng zhèngshì qiānshǔ le zhànlüè hézuò kuàngjià xiéyì.', 'Trải qua nhiều vòng đàm phán thương mại hữu nghị và thực chất, hai doanh nghiệp công nghệ cao hàng đầu đã chính thức ký kết thỏa thuận khung hợp tác chiến lược tại hội trường.', 'basic', 1),
      (v_id, '《区域全面经济伙伴关系协定》（RCEP）的高水平全面实施，大幅削减了区域成员国间的关税壁垒并达成了高规格的服务贸易便利化协议。', '《Qūyù Quánmiàn Jīngjì Huǒbàn Guānxì Xiéyì》（RCEP）de gāoshuǐpíng quánmiàn shíshī, dàfú xuējiǎn le qūyù chéngyuánguó jiān de guānshuì bìlěi bìng dáchéng le gāoguīgé de fúwù màoyì biànlìhuà xiéyì.', 'Việc thực thi toàn diện tiêu chuẩn cao của Hiệp định Đối tác Kinh tế Toàn diện Khu vực (RCEP) đã cắt giảm mạnh mẽ các rào cản thuế quan giữa các quốc gia thành viên trong khu vực và đạt được các hiệp định tạo thuận lợi thương mại dịch vụ chuẩn mực cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3275] [写作] (xiězuò) - viết văn, sáng tác; việc viết lách [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '写作' AND pinyin = 'xiězuò'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '写作' AND pinyin = 'xiězuò'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '写作'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '写作'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xiězuò',
      meaning_vi = 'viết văn, sáng tác; việc viết lách',
      example_hanzi = '语文老师经常鼓励同学们广泛阅读古今中外文学名著，以此来丰富词汇积累并提高写作表达水平。',
      example_pinyin = 'Yǔwén lǎoshī chángcháng gǔlì tóngxuémen guǎngfàn yuèdú gǔjīn-zhōngwài wénxué míngzhù, yǐcǐ lái fēngfù cíhuì jīlěi bìng tígāo xiězuò biǎodá shuǐpíng.',
      example_vi = 'Giáo viên dạy ngữ văn thường xuyên khuyến khích các em học sinh đọc rộng rãi các danh tác văn học đông tây kim cổ để làm phong phú vốn tích lũy từ vựng và nâng cao trình độ diễn đạt khi viết văn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '写作',
      'xiězuò',
      'viết văn, sáng tác; việc viết lách',
      'Động từ / Danh từ',
      'HSK 5',
      '语文老师经常鼓励同学们广泛阅读古今中外文学名著，以此来丰富词汇积累并提高写作表达水平。',
      'Yǔwén lǎoshī chángcháng gǔlì tóngxuémen guǎngfàn yuèdú gǔjīn-zhōngwài wénxué míngzhù, yǐcǐ lái fēngfù cíhuì jīlěi bìng tígāo xiězuò biǎodá shuǐpíng.',
      'Giáo viên dạy ngữ văn thường xuyên khuyến khích các em học sinh đọc rộng rãi các danh tác văn học đông tây kim cổ để làm phong phú vốn tích lũy từ vựng và nâng cao trình độ diễn đạt khi viết văn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '语文老师经常鼓励同学们广泛阅读古今中外文学名著，以此来丰富词汇积累并提高写作表达水平。', 'Yǔwén lǎoshī chángcháng gǔlì tóngxuémen guǎngfàn yuèdú gǔjīn-zhōngwài wénxué míngzhù, yǐcǐ lái fēngfù cíhuì jīlěi bìng tígāo xiězuò biǎodá shuǐpíng.', 'Giáo viên dạy ngữ văn thường xuyên khuyến khích các em học sinh đọc rộng rãi các danh tác văn học đông tây kim cổ để làm phong phú vốn tích lũy từ vựng và nâng cao trình độ diễn đạt khi viết văn.', 'basic', 1),
      (v_id, '这位著名当代剧作家历经七载深入基层采风调研，以严谨细腻的历史考据笔触完成了多部具有史诗般崇高美感的宏篇戏剧写作。', 'Zhè wèi zhùmíng dāngdài jùzuòjiā lìjīng qī zǎi shēnrù jīcéng cǎifēng diàoyán, yǐ yánjǐn xìnì de lìshǐ kǎojù bǐchù wánchéng le duō bù jùyǒu shǐshībān chónggāo měigǎn de hóngpiān xìjù xiězuò.', 'Nhà biên kịch đương đại nổi tiếng này đã trải qua bảy năm đi sâu vào cơ sở tìm hiểu thực tế, bằng ngòi bút khảo chứng lịch sử nghiêm cẩn tinh tế đã hoàn thành việc sáng tác nhiều vở kịch vĩ đại mang vẻ đẹp cao cả như những bản trường ca sử thi.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3276] [新郎] (xīnláng) - chú rể, tân lang [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '新郎' AND pinyin = 'xīnláng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '新郎' AND pinyin = 'xīnláng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '新郎'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '新郎'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xīnláng',
      meaning_vi = 'chú rể, tân lang',
      example_hanzi = '悠扬欢快的婚礼进行曲响起，西装革履的新郎面带幸福的微笑，挽着美丽新娘的手缓缓步入礼堂。',
      example_pinyin = 'Yōuyáng huānkuài de hūnlǐ jìnxíngqǔ xiǎngqǐ, xīzhuāng-gélǚ de xīnláng miàndài xìngfú de wēixiào, wǎn zhe měilì xīnniáng de shǒu huǎnhuǎn bùrù lǐtáng.',
      example_vi = 'Khúc nhạc hành hôn lễ du dương vui tươi vang lên, chú rể trong bộ vest giày da tươm tất với nụ cười hạnh phúc trên môi khoác tay cô dâu xinh đẹp từ từ bước vào lễ đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '新郎',
      'xīnláng',
      'chú rể, tân lang',
      'Danh từ',
      'HSK 5',
      '悠扬欢快的婚礼进行曲响起，西装革履的新郎面带幸福的微笑，挽着美丽新娘的手缓缓步入礼堂。',
      'Yōuyáng huānkuài de hūnlǐ jìnxíngqǔ xiǎngqǐ, xīzhuāng-gélǚ de xīnláng miàndài xìngfú de wēixiào, wǎn zhe měilì xīnniáng de shǒu huǎnhuǎn bùrù lǐtáng.',
      'Khúc nhạc hành hôn lễ du dương vui tươi vang lên, chú rể trong bộ vest giày da tươm tất với nụ cười hạnh phúc trên môi khoác tay cô dâu xinh đẹp từ từ bước vào lễ đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '悠扬欢快的婚礼进行曲响起，西装革履的新郎面带幸福的微笑，挽着美丽新娘的手缓缓步入礼堂。', 'Yōuyáng huānkuài de hūnlǐ jìnxíngqǔ xiǎngqǐ, xīzhuāng-gélǚ de xīnláng miàndài xìngfú de wēixiào, wǎn zhe měilì xīnniáng de shǒu huǎnhuǎn bùrù lǐtáng.', 'Khúc nhạc hành hôn lễ du dương vui tươi vang lên, chú rể trong bộ vest giày da tươm tất với nụ cười hạnh phúc trên môi khoác tay cô dâu xinh đẹp từ từ bước vào lễ đường.', 'basic', 1),
      (v_id, '当代传统中式婚礼的复兴彰显出博大精深的礼乐文化底蕴，身着华贵传统汉服吉服的新郎与新娘在赞礼官主持下庄严行传统沃盥对拜之礼。', 'Dāngdài chuántǒng Zhōngshì hūnlǐ de fùxīng zhāngxiǎn chū bódà-jīngshēn de lǐyuè wénhuà dǐyùn, shēnzhù huáguì chuántǒng hànfú jífú de xīnláng yǔ xīnniáng zài zànlǐguān zhǔchí xià zhuāngyán xíng chuántǒng wòguàn duìbài zhī lǐ.', 'Sự phục hưng hôn lễ truyền thống Trung Hoa đương đại tôn vinh chiều sâu văn hóa lễ nhạc uyên thâm, chú rể và cô dâu trong trang phục cát phục truyền thống lộng lẫy dưới sự chủ trì của quan tán lễ đã trang nghiêm thực hiện nghi thức rửa tay bái lạy truyền thống.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3277] [心理] (xīnlǐ) - tâm lý, trạng thái tâm lý [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '心理' AND pinyin = 'xīnlǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '心理' AND pinyin = 'xīnlǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '心理'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '心理'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xīnlǐ',
      meaning_vi = 'tâm lý, trạng thái tâm lý',
      example_hanzi = '面对重大的升学考试或激烈的职场面试，保持平和沉着的心理状态往往能够发挥出真实水平。',
      example_pinyin = 'Miànduì zhòngdà de shēngxué kǎoshì huò jīliè de zhíchǎng miànshì, bǎochí pínghé chénzhuó de xīnlǐ zhuàngtài wǎngwǎng nénggòu fāhuī chū zhēnshí shuǐpíng.',
      example_vi = 'Đối mặt với các kỳ thi chuyển cấp trọng đại hay buổi phỏng vấn tuyển dụng khốc liệt, duy trì trạng thái tâm lý bình hòa điềm tĩnh thường có thể phát huy được đúng thực lực.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '心理',
      'xīnlǐ',
      'tâm lý, trạng thái tâm lý',
      'Danh từ',
      'HSK 5',
      '面对重大的升学考试或激烈的职场面试，保持平和沉着的心理状态往往能够发挥出真实水平。',
      'Miànduì zhòngdà de shēngxué kǎoshì huò jīliè de zhíchǎng miànshì, bǎochí pínghé chénzhuó de xīnlǐ zhuàngtài wǎngwǎng nénggòu fāhuī chū zhēnshí shuǐpíng.',
      'Đối mặt với các kỳ thi chuyển cấp trọng đại hay buổi phỏng vấn tuyển dụng khốc liệt, duy trì trạng thái tâm lý bình hòa điềm tĩnh thường có thể phát huy được đúng thực lực.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对重大的升学考试或激烈的职场面试，保持平和沉着的心理状态往往能够发挥出真实水平。', 'Miànduì zhòngdà de shēngxué kǎoshì huò jīliè de zhíchǎng miànshì, bǎochí pínghé chénzhuó de xīnlǐ zhuàngtài wǎngwǎng nénggòu fāhuī chū zhēnshí shuǐpíng.', 'Đối mặt với các kỳ thi chuyển cấp trọng đại hay buổi phỏng vấn tuyển dụng khốc liệt, duy trì trạng thái tâm lý bình hòa điềm tĩnh thường có thể phát huy được đúng thực lực.', 'basic', 1),
      (v_id, '认知心理学与神经生物学多中心临床研究证实，持续的正念减压训练能够显著提升航天员应对极端封闭太空环境的心理韧性。', 'Rènzhī xīnlǐxué yǔ shénjīng shēngwùxué duō-zhōngxīn línchuáng yánjiū zhèngshí, chíxù de zhèngniàn jiǎnyā xùnliàn nénggòu xiǎnzhù tíshēng hángtiānyuán yìngduì jíduān fēngbì tàikōng huánjìng de xīnlǐ rènxìng.', 'Nghiên cứu lâm sàng đa trung tâm của tâm lý học nhận thức và sinh học thần kinh chứng minh rằng, việc huấn luyện giảm căng thẳng chánh niệm liên tục có thể nâng cao rõ rệt độ dẻo dai tâm lý của các phi hành gia khi ứng phó với môi trường không gian vũ trụ khép kín cực đoan.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3278] [新娘] (xīnniáng) - cô dâu, tân nương [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '新娘' AND pinyin = 'xīnniáng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '新娘' AND pinyin = 'xīnniáng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '新娘'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '新娘'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xīnniáng',
      meaning_vi = 'cô dâu, tân nương',
      example_hanzi = '身披洁白雅致婚纱的新娘手捧鲜艳的花束，脸上洋溢着幸福而甜美的笑容。',
      example_pinyin = 'Shēn pī jiébái yǎzhì hūnshā de xīnniáng shǒu pěng xiānyàn de huāshù, liǎn shàng yángyì zhe xìngfú ér tiánměi de xiàoróng.',
      example_vi = 'Cô dâu khoác lên mình chiếc váy cưới trắng tinh khôi trang nhã hai tay ôm bó hoa tươi thắm, trên gương mặt ngập tràn nụ cười hạnh phúc ngọt ngào.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '新娘',
      'xīnniáng',
      'cô dâu, tân nương',
      'Danh từ',
      'HSK 5',
      '身披洁白雅致婚纱的新娘手捧鲜艳的花束，脸上洋溢着幸福而甜美的笑容。',
      'Shēn pī jiébái yǎzhì hūnshā de xīnniáng shǒu pěng xiānyàn de huāshù, liǎn shàng yángyì zhe xìngfú ér tiánměi de xiàoróng.',
      'Cô dâu khoác lên mình chiếc váy cưới trắng tinh khôi trang nhã hai tay ôm bó hoa tươi thắm, trên gương mặt ngập tràn nụ cười hạnh phúc ngọt ngào.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '身披洁白雅致婚纱的新娘手捧鲜艳的花束，脸上洋溢着幸福而甜美的笑容。', 'Shēn pī jiébái yǎzhì hūnshā de xīnniáng shǒu pěng xiānyàn de huāshù, liǎn shàng yángyì zhe xìngfú ér tiánměi de xiàoróng.', 'Cô dâu khoác lên mình chiếc váy cưới trắng tinh khôi trang nhã hai tay ôm bó hoa tươi thắm, trên gương mặt ngập tràn nụ cười hạnh phúc ngọt ngào.', 'basic', 1),
      (v_id, '婚纱礼服高级定制品牌甄选非遗苏绣面料与法式立体手工剪裁，为每一位追求东方美学韵味的新娘量身缝制独一无二的高定嫁衣。', 'Hūnshā lǐfú gāojí dìngzhì pǐnpái zhēnxuǎn fēiyí Sūxiù miànliào yǔ Fǎshì lìtǐ shǒugōng jiǎncái, wèi měi yī wèi zhuīqiú Dōngfāng měixué yùnwèi de xīnniáng liángshēn féngzhì dú-yī-wú-èr de gāodìng jiàyī.', 'Thương hiệu áo cưới cao cấp tuyển chọn chất liệu thêu Tô Châu di sản phi vật thể và đường cắt may thủ công 3D kiểu Pháp, may đo riêng bộ áo cưới cao cấp độc nhất vô nhị cho mỗi cô dâu theo đuổi vẻ đẹp thẩm mỹ phương Đông.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3279] [新人] (xīnrén) - người mới, tân binh; cặp đôi mới cưới [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '新人' AND pinyin = 'xīnrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '新人' AND pinyin = 'xīnrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '新人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '新人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xīnrén',
      meaning_vi = 'người mới, tân binh; cặp đôi mới cưới',
      example_hanzi = '作为刚刚步入职场的技术新人，应当虚心向前辈请教，尽快熟悉团队的项目研发流程。',
      example_pinyin = 'Zuòwéi gānggāng bùrù zhíchǎng de jìshù xīnrén, yīngdāng xūxīn xiàng qiánbèi qǐngjiào, jǐnkuài shúxī tuánduì de xiàngmù yánfā liúchéng.',
      example_vi = 'Là một tân binh kỹ thuật vừa mới bước chân vào chốn công sở, cần phải khiêm tốn học hỏi các bậc tiền bối, nhanh chóng làm quen với quy trình R&D dự án của đội ngũ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '新人',
      'xīnrén',
      'người mới, tân binh; cặp đôi mới cưới',
      'Danh từ',
      'HSK 5',
      '作为刚刚步入职场的技术新人，应当虚心向前辈请教，尽快熟悉团队的项目研发流程。',
      'Zuòwéi gānggāng bùrù zhíchǎng de jìshù xīnrén, yīngdāng xūxīn xiàng qiánbèi qǐngjiào, jǐnkuài shúxī tuánduì de xiàngmù yánfā liúchéng.',
      'Là một tân binh kỹ thuật vừa mới bước chân vào chốn công sở, cần phải khiêm tốn học hỏi các bậc tiền bối, nhanh chóng làm quen với quy trình R&D dự án của đội ngũ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '作为刚刚步入职场的技术新人，应当虚心向前辈请教，尽快熟悉团队的项目研发流程。', 'Zuòwéi gānggāng bùrù zhíchǎng de jìshù xīnrén, yīngdāng xūxīn xiàng qiánbèi qǐngjiào, jǐnkuài shúxī tuánduì de xiàngmù yánfā liúchéng.', 'Là một tân binh kỹ thuật vừa mới bước chân vào chốn công sở, cần phải khiêm tốn học hỏi các bậc tiền bối, nhanh chóng làm quen với quy trình R&D dự án của đội ngũ.', 'basic', 1),
      (v_id, '高科技领军企业健全全链条“双导师青蓝工程”，助力名校毕业的校招技术新人快速成长为各关键底层架构攻关的核心骨干。', 'Gāokējì lǐngjūn qǐyè jiànquán quán-liàntiáo “shuāng-dǎoshī qīng-lán gōngchéng”, zhùlì míngxiào bìyè de xiàozhāo jìshù xīnrén kuàisù chéngzhǎng wéi gè guānjiàn dǐcéng jiàgòu gōngguān de héxīn gǔgàn.', 'Doanh nghiệp dẫn đầu công nghệ cao hoàn thiện đề án "thầy dắt trò - song cố vấn" toàn diện theo chuỗi, trợ lực cho những nhân tài kỹ thuật mới tuyển từ các trường đại học danh tiếng nhanh chóng trưởng thành thành rường cột cốt lõi chinh phục các kiến trúc tầng đáy trọng yếu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3280] [欣赏] (xīnshǎng) - thưởng thức, tán thưởng, ngưỡng mộ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '欣赏' AND pinyin = 'xīnshǎng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '欣赏' AND pinyin = 'xīnshǎng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '欣赏'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '欣赏'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xīnshǎng',
      meaning_vi = 'thưởng thức, tán thưởng, ngưỡng mộ',
      example_hanzi = '游客们漫步在西湖苏堤之上，驻足静静欣赏着秀丽的湖光山色与微风拂柳的美景。',
      example_pinyin = 'Yóukèmen mànbù zài Xīhú Sūdī zhī shàng, zhùzú jìngjìng xīnshǎng zhe xiùlì de húguāng-shānsè yǔ wēifēng fú liǔ de měijǐng.',
      example_vi = 'Du khách tản bộ trên bờ đê Tô Đông Pha ở Tây Hồ, dừng bước lặng ngắm thưởng thức cảnh đẹp non xanh nước biếc tú lệ cùng rặng liễu đu đưa trong làn gió thoảng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '欣赏',
      'xīnshǎng',
      'thưởng thức, tán thưởng, ngưỡng mộ',
      'Động từ',
      'HSK 5',
      '游客们漫步在西湖苏堤之上，驻足静静欣赏着秀丽的湖光山色与微风拂柳的美景。',
      'Yóukèmen mànbù zài Xīhú Sūdī zhī shàng, zhùzú jìngjìng xīnshǎng zhe xiùlì de húguāng-shānsè yǔ wēifēng fú liǔ de měijǐng.',
      'Du khách tản bộ trên bờ đê Tô Đông Pha ở Tây Hồ, dừng bước lặng ngắm thưởng thức cảnh đẹp non xanh nước biếc tú lệ cùng rặng liễu đu đưa trong làn gió thoảng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '游客们漫步在西湖苏堤之上，驻足静静欣赏着秀丽的湖光山色与微风拂柳的美景。', 'Yóukèmen mànbù zài Xīhú Sūdī zhī shàng, zhùzú jìngjìng xīnshǎng zhe xiùlì de húguāng-shānsè yǔ wēifēng fú liǔ de měijǐng.', 'Du khách tản bộ trên bờ đê Tô Đông Pha ở Tây Hồ, dừng bước lặng ngắm thưởng thức cảnh đẹp non xanh nước biếc tú lệ cùng rặng liễu đu đưa trong làn gió thoảng.', 'basic', 1),
      (v_id, '国家数字艺术馆运用三维光场重建与全景沉浸式交互显示技术，引导海内外观众全息多维欣赏传世国宝名画的精妙笔触与神韵。', 'Guójiā shùzì yìshùguǎn yùnyòng sānwéi guāngchǎng chóngjiàn yǔ quánjǐng chénjìnshì jiāohù xiǎnshì jìshù, yǐndǎo hǎinèiwài guānzhòng quánxī duōwéi xīnshǎng chuánshì guóbǎo mínghuà de jīngmiào bǐchù yǔ shényùn.', 'Bảo tàng nghệ thuật kỹ thuật số quốc gia ứng dụng công nghệ tái tạo trường ánh sáng 3D và hiển thị tương tác đắm chìm toàn cảnh, dẫn dắt công chúng trong và ngoài nước thưởng thức trọn vẹn đa chiều bằng hình ảnh hologram về nét bút tinh diệu và thần thái của những bức danh họa quốc bảo lưu truyền ngàn đời.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3281] [心态] (xīntài) - tâm thế, tâm thái, thái độ tinh thần [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '心态' AND pinyin = 'xīntài'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '心态' AND pinyin = 'xīntài'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '心态'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '心态'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xīntài',
      meaning_vi = 'tâm thế, tâm thái, thái độ tinh thần',
      example_hanzi = '人生不可能总是一帆风顺，学会以坦然豁达的心态面对得失是心智走向成熟的标志。',
      example_pinyin = 'Rénshēng bù kěnéng zǒngshì yīfān-fēngshùn, xuéhuì yǐ tǎnrán huòdá de xīntài miànduì déshī shì xīnlì zǒuxiàng chéngshú de biāozhì.',
      example_vi = 'Đời người không thể lúc nào cũng thuận buồm xuôi gió, học được cách dùng tâm thế thản nhiên khoáng đạt đối diện với được mất chính là dấu mốc của sự trưởng thành về tâm trí.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '心态',
      'xīntài',
      'tâm thế, tâm thái, thái độ tinh thần',
      'Danh từ',
      'HSK 5',
      '人生不可能总是一帆风顺，学会以坦然豁达的心态面对得失是心智走向成熟的标志。',
      'Rénshēng bù kěnéng zǒngshì yīfān-fēngshùn, xuéhuì yǐ tǎnrán huòdá de xīntài miànduì déshī shì xīnlì zǒuxiàng chéngshú de biāozhì.',
      'Đời người không thể lúc nào cũng thuận buồm xuôi gió, học được cách dùng tâm thế thản nhiên khoáng đạt đối diện với được mất chính là dấu mốc của sự trưởng thành về tâm trí.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '人生不可能总是一帆风顺，学会以坦然豁达的心态面对得失是心智走向成熟的标志。', 'Rénshēng bù kěnéng zǒngshì yīfān-fēngshùn, xuéhuì yǐ tǎnrán huòdá de xīntài miànduì déshī shì xīnlì zǒuxiàng chéngshú de biāozhì.', 'Đời người không thể lúc nào cũng thuận buồm xuôi gió, học được cách dùng tâm thế thản nhiên khoáng đạt đối diện với được mất chính là dấu mốc của sự trưởng thành về tâm trí.', 'basic', 1),
      (v_id, '面对严峻复杂的全球产业链重塑与颠覆性科技竞争，实体科技企业家必须保持敏锐前瞻而又理性沉稳的战略心态，在变局中开新局。', 'Miànduì yánjùn fùzá de quánqiú chǎnyèliàn chóngsù yǔ diānfùxìng kējì jìngzhēng, shítǐ kējì qǐyèjiā bìxū bǎochí mǐnruì qiánzhān ér yòu lǐxìng chénwěn de zhànlüè xīntài, zài biànjú zhōng kāi xīnjú.', 'Đối mặt với việc tái cấu trúc chuỗi công nghiệp toàn cầu gay gắt phức tạp và cạnh tranh công nghệ mang tính đột phá, các nhà doanh nghiệp công nghệ thực thể bắt buộc phải duy trì tâm thái chiến lược nhạy bén nhìn xa trông rộng nhưng cũng đầy lý tính trầm tĩnh, mở ra cục diện mới ngay trong biến cuộc.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3282] [新型] (xīnxíng) - kiểu mới, mẫu mới, tân tiến [Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '新型' AND pinyin = 'xīnxíng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '新型' AND pinyin = 'xīnxíng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '新型'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '新型'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ',
      pinyin = 'xīnxíng',
      meaning_vi = 'kiểu mới, mẫu mới, tân tiến',
      example_hanzi = '这款新型电动汽车搭载了高安全固态电池，在严寒天气下的续航表现较上一代产品显著提升。',
      example_pinyin = 'Zhè kuǎn xīnxíng diàndòng qìchē dàizài le gāo ānquán gùtài diànchí, zài yánhán tiānqì xià de xùháng biǎoxiàn jiào shàngyīdài chǎnpǐn xiǎnzhù tíshēng.',
      example_vi = 'Mẫu xe ô tô điện kiểu mới này trang bị pin thể rắn độ an toàn cao, hiệu suất cự ly di chuyển trong thời tiết giá rét được nâng cao rõ rệt so với thế hệ sản phẩm trước.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '新型',
      'xīnxíng',
      'kiểu mới, mẫu mới, tân tiến',
      'Tính từ',
      'HSK 5',
      '这款新型电动汽车搭载了高安全固态电池，在严寒天气下的续航表现较上一代产品显著提升。',
      'Zhè kuǎn xīnxíng diàndòng qìchē dàizài le gāo ānquán gùtài diànchí, zài yánhán tiānqì xià de xùháng biǎoxiàn jiào shàngyīdài chǎnpǐn xiǎnzhù tíshēng.',
      'Mẫu xe ô tô điện kiểu mới này trang bị pin thể rắn độ an toàn cao, hiệu suất cự ly di chuyển trong thời tiết giá rét được nâng cao rõ rệt so với thế hệ sản phẩm trước.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '这款新型电动汽车搭载了高安全固态电池，在严寒天气下的续航表现较上一代产品显著提升。', 'Zhè kuǎn xīnxíng diàndòng qìchē dàizài le gāo ānquán gùtài diànchí, zài yánhán tiānqì xià de xùháng biǎoxiàn jiào shàngyīdài chǎnpǐn xiǎnzhù tíshēng.', 'Mẫu xe ô tô điện kiểu mới này trang bị pin thể rắn độ an toàn cao, hiệu suất cự ly di chuyển trong thời tiết giá rét được nâng cao rõ rệt so với thế hệ sản phẩm trước.', 'basic', 1),
      (v_id, '国家加快培育壮大战略性新兴产业与前沿未来产业，大力构建以新型工业化为导向的新质生产力现代产业创新生态圈。', 'Guójiā jiākuài péiyù zhuàngdà zhànlüèxìng xīnxīng chǎnyè yǔ qiányán wèilái chǎnyè, dàlì gòujiàn yǐ xīnxíng gōngyèhuà wéi dǎoxiàng de xīnzhì shēngchǎnlì xiàndài chǎnyè chuàngxīn shēngtàiquān.', 'Nhà nước đẩy nhanh nuôi dưỡng phát triển lớn mạnh các ngành công nghiệp mới nổi mang tính chiến lược và các ngành công nghiệp tương lai tiền duyên, dốc sức xây dựng hệ sinh thái đổi mới công nghiệp hiện đại của lực lượng sản xuất chất lượng mới lấy công nghiệp hóa kiểu mới làm định hướng.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3283] [信封] (xìnfēng) - phong bì, phong thư, bì thư [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '信封' AND pinyin = 'xìnfēng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '信封' AND pinyin = 'xìnfēng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '信封'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '信封'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xìnfēng',
      meaning_vi = 'phong bì, phong thư, bì thư',
      example_hanzi = '爷爷将亲笔写好的家书工整地装入牛皮纸信封，贴上邮票后投进了街角的邮筒。',
      example_pinyin = 'Yéye jiāng qīnbǐ xiě hǎo de jiāshū gōngzhěng de zhuāng rù niúpíjǐ xìnfēng, tiē shàng yóupiào hòu tóu jìn le jiējiǎo de yóutǒng.',
      example_vi = 'Ông nội xếp ngay ngắn bức thư nhà tự tay viết vào phong bì giấy xi măng, sau khi dán tem liền bỏ vào hòm thư ở góc phố.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '信封',
      'xìnfēng',
      'phong bì, phong thư, bì thư',
      'Danh từ',
      'HSK 5',
      '爷爷将亲笔写好的家书工整地装入牛皮纸信封，贴上邮票后投进了街角的邮筒。',
      'Yéye jiāng qīnbǐ xiě hǎo de jiāshū gōngzhěng de zhuāng rù niúpíjǐ xìnfēng, tiē shàng yóupiào hòu tóu jìn le jiējiǎo de yóutǒng.',
      'Ông nội xếp ngay ngắn bức thư nhà tự tay viết vào phong bì giấy xi măng, sau khi dán tem liền bỏ vào hòm thư ở góc phố.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '爷爷将亲笔写好的家书工整地装入牛皮纸信封，贴上邮票后投进了街角的邮筒。', 'Yéye jiāng qīnbǐ xiě hǎo de jiāshū gōngzhěng de zhuāng rù niúpíjǐ xìnfēng, tiē shàng yóupiào hòu tóu jìn le jiējiǎo de yóutǒng.', 'Ông nội xếp ngay ngắn bức thư nhà tự tay viết vào phong bì giấy xi măng, sau khi dán tem liền bỏ vào hòm thư ở góc phố.', 'basic', 1),
      (v_id, '涉外机要档案在流转交换过程中，必须采用具备光学防伪水印与防拆卸电子自毁铅封的特制高密级信封予以封装。', 'Shèwài jīyào dàng’àn zài liúzhuǎn jiāohuàn guòchéng zhōng, bìxū cǎiyòng jùbèi guāngxué fángwěi shuǐyìn yǔ fáng-chāixiè diànzǐ zìhuǐ qiānfēng de tèzhì gāo-mìjí xìnfēng yǔyǐ fēngzhuāng.', 'Hồ sơ tài liệu mật cơ yếu đối ngoại trong quá trình luân chuyển trao đổi bắt buộc phải sử dụng phong bì cấp độ mật cao đặc chế có hình mờ chống giả quang học và niêm phong điện tử tự hủy chống tháo gỡ để đóng gói niêm phong.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3284] [信任] (xìnrèn) - tín nhiệm, tin tưởng; sự tín nhiệm [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '信任' AND pinyin = 'xìnrèn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '信任' AND pinyin = 'xìnrèn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '信任'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '信任'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xìnrèn',
      meaning_vi = 'tín nhiệm, tin tưởng; sự tín nhiệm',
      example_hanzi = '朋友之间最珍贵的就是彼此真诚坦荡的相待与毫无保留的相互信任。',
      example_pinyin = 'Péngyou zhījiān zuì zhēnguì de jiùshì bǐcǐ zhēnchéng tǎndàng de xiāngdài yǔ háowú-bǎoliú de xiānghù xìnrèn.',
      example_vi = 'Điều quý giá nhất giữa bạn bè với nhau chính là đối xử với nhau chân thành ngay thẳng và tin tưởng lẫn nhau mà không chút giữ kẽ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '信任',
      'xìnrèn',
      'tín nhiệm, tin tưởng; sự tín nhiệm',
      'Động từ / Danh từ',
      'HSK 5',
      '朋友之间最珍贵的就是彼此真诚坦荡的相待与毫无保留的相互信任。',
      'Péngyou zhījiān zuì zhēnguì de jiùshì bǐcǐ zhēnchéng tǎndàng de xiāngdài yǔ háowú-bǎoliú de xiānghù xìnrèn.',
      'Điều quý giá nhất giữa bạn bè với nhau chính là đối xử với nhau chân thành ngay thẳng và tin tưởng lẫn nhau mà không chút giữ kẽ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '朋友之间最珍贵的就是彼此真诚坦荡的相待与毫无保留的相互信任。', 'Péngyou zhījiān zuì zhēnguì de jiùshì bǐcǐ zhēnchéng tǎndàng de xiāngdài yǔ háowú-bǎoliú de xiānghù xìnrèn.', 'Điều quý giá nhất giữa bạn bè với nhau chính là đối xử với nhau chân thành ngay thẳng và tin tưởng lẫn nhau mà không chút giữ kẽ.', 'basic', 1),
      (v_id, '构建基于区块链多节点分布式账本与智能合约的可验证互信体系，为多边跨境贸易金融与数据资产交易奠定了底层数字信任基石。', 'Gòujiàn jīyú qūkuàiliàn duō-jiédiǎn fēnbùshì zhàngběn yǔ zhìnéng héyuē de kěyànzhèng hùxìn tǐxì, wèi duōbiān kuàjìng màoyì jīnróng yǔ shùjù zīchǎn jiāoyì diàndìng le dǐcéng shùzì xìnrèn jīshí.', 'Kiến tạo hệ thống tương hỗ tin cậy có thể kiểm chứng dựa trên sổ cái phân tán đa nút và hợp đồng thông minh blockchain đã đặt nền móng niềm tin kỹ thuật số tầng đáy cho tài chính thương mại xuyên biên giới đa phương và giao dịch tài sản dữ liệu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3285] [信用] (xìnyòng) - tín dụng, uy tín, chữ tín trong kinh doanh [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '信用' AND pinyin = 'xìnyòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '信用' AND pinyin = 'xìnyòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '信用'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '信用'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xìnyòng',
      meaning_vi = 'tín dụng, uy tín, chữ tín trong kinh doanh',
      example_hanzi = '在现代市场经济活动中，恪守契约精神并保持良好的个人信用记录是个人立业的根本。',
      example_pinyin = 'Zài xiàndài shìchǎng jīngjì huódòng zhōng, kèshǒu qìyuē jīngshén bìng bǎochí liánghǎo de gèrén xìnyòng jìlù shì gèrén lìyè de gēnběn.',
      example_vi = 'Trong các hoạt động kinh tế thị trường hiện đại, tuân thủ nghiêm ngặt tinh thần giao ước và duy trì lịch sử tín dụng cá nhân tốt đẹp chính là gốc rễ lập nghiệp của mỗi người.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '信用',
      'xìnyòng',
      'tín dụng, uy tín, chữ tín trong kinh doanh',
      'Danh từ',
      'HSK 5',
      '在现代市场经济活动中，恪守契约精神并保持良好的个人信用记录是个人立业的根本。',
      'Zài xiàndài shìchǎng jīngjì huódòng zhōng, kèshǒu qìyuē jīngshén bìng bǎochí liánghǎo de gèrén xìnyòng jìlù shì gèrén lìyè de gēnběn.',
      'Trong các hoạt động kinh tế thị trường hiện đại, tuân thủ nghiêm ngặt tinh thần giao ước và duy trì lịch sử tín dụng cá nhân tốt đẹp chính là gốc rễ lập nghiệp của mỗi người.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在现代市场经济活动中，恪守契约精神并保持良好的个人信用记录是个人立业的根本。', 'Zài xiàndài shìchǎng jīngjì huódòng zhōng, kèshǒu qìyuē jīngshén bìng bǎochí liánghǎo de gèrén xìnyòng jìlù shì gèrén lìyè de gēnběn.', 'Trong các hoạt động kinh tế thị trường hiện đại, tuân thủ nghiêm ngặt tinh thần giao ước và duy trì lịch sử tín dụng cá nhân tốt đẹp chính là gốc rễ lập nghiệp của mỗi người.', 'basic', 1),
      (v_id, '金融监管部门协同推进全国统一社会信用信息共享平台建设，完善守信联合激励与严重失信联合惩戒机制，夯实市场经济信用基石。', 'Jīnróng jiānguǎn bùmén xiétóng tuījìn quánguó tǒngyī shèhuì xìnyòng xìnxī gòngxiǎng píngtái jiànshè, wánshàn shǒuxìn liánhé jīlì yǔ yánzhòng shīxìn liánhé chéngjiè jīzhì, hāngshí shìchǎng jīngjì xìnyòng jīshí.', 'Cơ quan giám sát tài chính phối hợp thúc đẩy xây dựng nền tảng chia sẻ thông tin tín dụng xã hội thống nhất trên toàn quốc, hoàn thiện cơ chế khen thưởng liên ngành người giữ chữ tín và trừng phạt liên ngành đối với các hành vi vi phạm chữ tín nghiêm trọng, củng cố nền tảng tín dụng của nền kinh tế thị trường.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3286] [行程] (xíngchéng) - hành trình, lịch trình chuyến đi [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '行程' AND pinyin = 'xíngchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行程' AND pinyin = 'xíngchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '行程'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行程'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xíngchéng',
      meaning_vi = 'hành trình, lịch trình chuyến đi',
      example_hanzi = '在出发前往风景优美的自然保护区之前，我们全家人一起商定了为期五天的详细旅行行程。',
      example_pinyin = 'Zài chūfā qiánwǎng fēngjǐng yōuměi de zìrán bǎohùqū zhīqián, wǒmen quánjiārén yīqǐ shāngdìng le wéiqī wǔ tiān de xiángxì lǚxíng xíngchéng.',
      example_vi = 'Trước khi lên đường đến khu bảo tồn thiên nhiên phong cảnh tươi đẹp, cả gia đình chúng tôi đã cùng nhau bàn định một lịch trình du lịch chi tiết kéo dài năm ngày.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '行程',
      'xíngchéng',
      'hành trình, lịch trình chuyến đi',
      'Danh từ',
      'HSK 5',
      '在出发前往风景优美的自然保护区之前，我们全家人一起商定了为期五天的详细旅行行程。',
      'Zài chūfā qiánwǎng fēngjǐng yōuměi de zìrán bǎohùqū zhīqián, wǒmen quánjiārén yīqǐ shāngdìng le wéiqī wǔ tiān de xiángxì lǚxíng xíngchéng.',
      'Trước khi lên đường đến khu bảo tồn thiên nhiên phong cảnh tươi đẹp, cả gia đình chúng tôi đã cùng nhau bàn định một lịch trình du lịch chi tiết kéo dài năm ngày.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在出发前往风景优美的自然保护区之前，我们全家人一起商定了为期五天的详细旅行行程。', 'Zài chūfā qiánwǎng fēngjǐng yōuměi de zìrán bǎohùqū zhīqián, wǒmen quánjiārén yīqǐ shāngdìng le wéiqī wǔ tiān de xiángxì lǚxíng xíngchéng.', 'Trước khi lên đường đến khu bảo tồn thiên nhiên phong cảnh tươi đẹp, cả gia đình chúng tôi đã cùng nhau bàn định một lịch trình du lịch chi tiết kéo dài năm ngày.', 'basic', 1),
      (v_id, '外交礼宾司根据双边首脑会晤工作方案，周密部署并精准执行了代表团正式国事访问期间每一场双边会谈与考察的礼宾行程。', 'Wàijiāo lǐbīnsī gēnjù shuāngbiān shǒunǎo huìwù gōngzuò fāng’àn, zhōumì bùshǔ bìng jīngzhǔn zhíxíng le dàibiǎotuán zhèngshì guóshì fǎngwèn qījiān měi yī chǎng shuāngbiān huìtán yǔ kǎochá de lǐbīn xíngchéng.', 'Cục Lễ tân Ngoại giao căn cứ vào phương án công tác hội đàm cấp cao song phương đã bố trí chu đáo và thực thi chuẩn xác lịch trình lễ tân của từng cuộc hội đàm song phương và khảo sát trong suốt chuyến thăm cấp nhà nước chính thức của đoàn đại biểu.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3287] [形成] (xíngchéng) - hình thành, tạo thành, cấu thành [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '形成' AND pinyin = 'xíngchéng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形成' AND pinyin = 'xíngchéng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '形成'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形成'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xíngchéng',
      meaning_vi = 'hình thành, tạo thành, cấu thành',
      example_hanzi = '经过千百年来流水的冲刷与风力的侵蚀，大自然在这里形成了气势磅礴的地质峡谷奇观。',
      example_pinyin = 'Jīngguò qiān-bǎi nián lái liúshuǐ de chōngshuā yǔ fēnglì de qīnshí, zìrán zài zhèlǐ xíngchéng le qìshì pángbó de dìzhì xiágǔ qíguān.',
      example_vi = 'Trải qua hàng ngàn năm nước chảy xối mòn và sức gió bào mòn, mẹ thiên nhiên đã kiến tạo nên tại nơi đây một kỳ quan hẻm núi địa chất tráng lệ hùng vĩ.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '形成',
      'xíngchéng',
      'hình thành, tạo thành, cấu thành',
      'Động từ',
      'HSK 5',
      '经过千百年来流水的冲刷与风力的侵蚀，大自然在这里形成了气势磅礴的地质峡谷奇观。',
      'Jīngguò qiān-bǎi nián lái liúshuǐ de chōngshuā yǔ fēnglì de qīnshí, zìrán zài zhèlǐ xíngchéng le qìshì pángbó de dìzhì xiágǔ qíguān.',
      'Trải qua hàng ngàn năm nước chảy xối mòn và sức gió bào mòn, mẹ thiên nhiên đã kiến tạo nên tại nơi đây một kỳ quan hẻm núi địa chất tráng lệ hùng vĩ.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过千百年来流水的冲刷与风力的侵蚀，大自然在这里形成了气势磅礴的地质峡谷奇观。', 'Jīngguò qiān-bǎi nián lái liúshuǐ de chōngshuā yǔ fēnglì de qīnshí, zìrán zài zhèlǐ xíngchéng le qìshì pángbó de dìzhì xiágǔ qíguān.', 'Trải qua hàng ngàn năm nước chảy xối mòn và sức gió bào mòn, mẹ thiên nhiên đã kiến tạo nên tại nơi đây một kỳ quan hẻm núi địa chất tráng lệ hùng vĩ.', 'basic', 1),
      (v_id, '依托超大规模国内市场需求与门类齐全的完备工业制造体系，我国在绿色低碳与高端装备制造领域已形成显著的综合竞争优势。', 'Yītuō chāo-dà guīmó guónèi shìchǎng xūqiú yǔ ménlèi qíquán de wánbèi gōngyè zhìzào tǐxì, wǒguó zài lǜsè dītàn yǔ gāoduān zhuāngbèi zhìzào lǐngyù yǐ xíngchéng xiǎnzhù de zōnghé jìngzhēng yòushì.', 'Dựa trên nhu cầu thị trường nội địa quy mô siêu lớn và hệ thống chế tạo công nghiệp đầy đủ đồng bộ các ngành nghề, nước ta trong lĩnh vực các-bon thấp xanh và chế tạo thiết bị cao cấp đã hình thành nên lợi thế cạnh tranh tổng hợp nổi bật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3288] [行动] (xíngdòng) - hành động; sự hành động, hoạt động [Động từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '行动' AND pinyin = 'xíngdòng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行动' AND pinyin = 'xíngdòng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '行动'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行动'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ / Danh từ',
      pinyin = 'xíngdòng',
      meaning_vi = 'hành động; sự hành động, hoạt động',
      example_hanzi = '“言必信，行必果”，青年人在制定了崇高的人生目标之后，必须立即付诸脚踏实地的行动。',
      example_pinyin = '“Yán bì xìn, xíng bì guǒ”, qīngniánrén zài zhìdìng le chónggāo de rénshēng mùbiāo zhīhòu, bìxū lìjí fùzhū jiǎotà-shídì de xíngdòng.',
      example_vi = '"Lời nói tất giữ tín, việc làm tất có kết quả", thanh niên sau khi đã xác lập mục tiêu cuộc đời cao đẹp nhất định phải lập tức biến nó thành hành động thiết thực vững vàng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '行动',
      'xíngdòng',
      'hành động; sự hành động, hoạt động',
      'Động từ / Danh từ',
      'HSK 5',
      '“言必信，行必果”，青年人在制定了崇高的人生目标之后，必须立即付诸脚踏实地的行动。',
      '“Yán bì xìn, xíng bì guǒ”, qīngniánrén zài zhìdìng le chónggāo de rénshēng mùbiāo zhīhòu, bìxū lìjí fùzhū jiǎotà-shídì de xíngdòng.',
      '"Lời nói tất giữ tín, việc làm tất có kết quả", thanh niên sau khi đã xác lập mục tiêu cuộc đời cao đẹp nhất định phải lập tức biến nó thành hành động thiết thực vững vàng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '“言必信，行必果”，青年人在制定了崇高的人生目标之后，必须立即付诸脚踏实地的行动。', '“Yán bì xìn, xíng bì guǒ”, qīngniánrén zài zhìdìng le chónggāo de rénshēng mùbiāo zhīhòu, bìxū lìjí fùzhū jiǎotà-shídì de xíngdòng.', '"Lời nói tất giữ tín, việc làm tất có kết quả", thanh niên sau khi đã xác lập mục tiêu cuộc đời cao đẹp nhất định phải lập tức biến nó thành hành động thiết thực vững vàng.', 'basic', 1),
      (v_id, '国际社会各方必须以高度的政治远见将全球应对气候变暖的框架共识迅速转化为切实有力的全产业链减排脱碳联合行动。', 'Guójì shèhuì gèfāng bìxū yǐ gāodù de zhèngzhì yuǎnjiàn jiāng quánqiú yìngduì qìhòu biànnuǎn de kuàngjià gòngshí xùnsù zhuǎnhuà wéi qièshí yǒulì de quán-chǎnyèliàn jiǎnpái tuōtàn liánhé xíngdòng.', 'Các bên trong cộng đồng quốc tế bắt buộc phải phát huy tầm nhìn chính trị cao độ để nhanh chóng chuyển hóa đồng thuận khung về ứng phó với biến đổi khí hậu toàn cầu thành những hành động liên kết giảm phát thải khử carbon thực chất và mạnh mẽ trên toàn chuỗi công nghiệp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3289] [行人] (xíngrén) - người đi bộ [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '行人' AND pinyin = 'xíngrén'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行人' AND pinyin = 'xíngrén'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '行人'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行人'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xíngrén',
      meaning_vi = 'người đi bộ',
      example_hanzi = '汽车驾驶员在行经人行横道斑马线时应当减速慢行，遇到正在过马路的行人必须主动停车礼让。',
      example_pinyin = 'Qìchē jiàshǐyuán zài xíngjīng rénxíng héngdào bānmǎxiàn shí yīngdāng jiǎnsù mànxíng, yù dào zhèngzài guò mǎlù de xíngrén bìxū zhǔdòng tíngchē lǐràng.',
      example_vi = 'Người điều khiển xe ô tô khi đi qua vạch sang đường dành cho người đi bộ phải giảm tốc độ đi chậm, khi gặp người đi bộ đang qua đường bắt buộc phải chủ động dừng xe nhường đường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '行人',
      'xíngrén',
      'người đi bộ',
      'Danh từ',
      'HSK 5',
      '汽车驾驶员在行经人行横道斑马线时应当减速慢行，遇到正在过马路的行人必须主动停车礼让。',
      'Qìchē jiàshǐyuán zài xíngjīng rénxíng héngdào bānmǎxiàn shí yīngdāng jiǎnsù mànxíng, yù dào zhèngzài guò mǎlù de xíngrén bìxū zhǔdòng tíngchē lǐràng.',
      'Người điều khiển xe ô tô khi đi qua vạch sang đường dành cho người đi bộ phải giảm tốc độ đi chậm, khi gặp người đi bộ đang qua đường bắt buộc phải chủ động dừng xe nhường đường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '汽车驾驶员在行经人行横道斑马线时应当减速慢行，遇到正在过马路的行人必须主动停车礼让。', 'Qìchē jiàshǐyuán zài xíngjīng rénxíng héngdào bānmǎxiàn shí yīngdāng jiǎnsù mànxíng, yù dào zhèngzài guò mǎlù de xíngrén bìxū zhǔdòng tíngchē lǐràng.', 'Người điều khiển xe ô tô khi đi qua vạch sang đường dành cho người đi bộ phải giảm tốc độ đi chậm, khi gặp người đi bộ đang qua đường bắt buộc phải chủ động dừng xe nhường đường.', 'basic', 1),
      (v_id, '智慧城市交通枢纽采用毫米波雷达与AI视觉多源融合感知算法，动态优化十字路口信号配时并保障无障碍行人安全立体过街。', 'Zhìhuì chéngshì jiāotōng shūniǔ cǎiyòng háomǐbō léidá yǔ AI shìjué duōyuán rónghé gǎnzhī suànfǎ, dòngtài yòuhuà shízì lùkǒu xìnhào pèishí bìng bǎozhàng wúzhàng’ài xíngrén ānquán lìtǐ guòjiē.', 'Đầu mối giao thông đô thị thông minh áp dụng thuật toán cảm biến kết hợp đa nguồn giữa radar sóng milimet và thị giác máy tính AI để tối ưu hóa linh hoạt thời lượng đèn tín hiệu ngã tư và bảo đảm an toàn qua đường đa tầng không rào cản cho người đi bộ.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3290] [形容] (xíngróng) - hình dung, miêu tả, diễn tả [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '形容' AND pinyin = 'xíngróng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形容' AND pinyin = 'xíngróng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '形容'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形容'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xíngróng',
      meaning_vi = 'hình dung, miêu tả, diễn tả',
      example_hanzi = '漓江两岸山水奇峰秀丽、碧波如镜，那如诗如画的人间仙境简直无法用简单的语言来形容。',
      example_pinyin = 'Líjiāng liǎng’àn shānshuǐ qífēng xiùlì, bìbō rú jìng, nà rúshī-rúhuà de rénjiān xiānjìng jiǎnzhí wúfǎ yòng jiǎndān de yǔyán lái xíngróng.',
      example_vi = 'Cảnh sắc non nước đôi bờ sông Ly non ngút ngàn tú lệ, làn nước biếc phẳng lặng như gương, chốn bồng lai tiên cảnh đẹp như thơ như họa ấy quả thực không thể dùng lời lẽ giản đơn để diễn tả hết.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '形容',
      'xíngróng',
      'hình dung, miêu tả, diễn tả',
      'Động từ',
      'HSK 5',
      '漓江两岸山水奇峰秀丽、碧波如镜，那如诗如画的人间仙境简直无法用简单的语言来形容。',
      'Líjiāng liǎng’àn shānshuǐ qífēng xiùlì, bìbō rú jìng, nà rúshī-rúhuà de rénjiān xiānjìng jiǎnzhí wúfǎ yòng jiǎndān de yǔyán lái xíngróng.',
      'Cảnh sắc non nước đôi bờ sông Ly non ngút ngàn tú lệ, làn nước biếc phẳng lặng như gương, chốn bồng lai tiên cảnh đẹp như thơ như họa ấy quả thực không thể dùng lời lẽ giản đơn để diễn tả hết.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '漓江两岸山水奇峰秀丽、碧波如镜，那如诗如画的人间仙境简直无法用简单的语言来形容。', 'Líjiāng liǎng’àn shānshuǐ qífēng xiùlì, bìbō rú jìng, nà rúshī-rúhuà de rénjiān xiānjìng jiǎnzhí wúfǎ yòng jiǎndān de yǔyán lái xíngróng.', 'Cảnh sắc non nước đôi bờ sông Ly non ngút ngàn tú lệ, làn nước biếc phẳng lặng như gương, chốn bồng lai tiên cảnh đẹp như thơ như họa ấy quả thực không thể dùng lời lẽ giản đơn để diễn tả hết.', 'basic', 1),
      (v_id, '权威文艺评论家以“大漠孤烟、气象万千”八个字，精辟形容了这部史诗级交响组曲所蕴含的壮阔历史画卷与崇高哲学精神。', 'Quánwēi wényì pínglùnjiā yǐ “dàmò gūyān, qìxiàng wànqiān” bā gè zì, jīngpì xíngróng le zhè bù shǐshījí jiāoxiǎng zǔqǔ suǒ yùnhán de zhuàngkuò lìshǐ huàjuàn yǔ chónggāo zhéxué jīngshén.', 'Nhà phê bình văn học nghệ thuật uy tín đã dùng tám chữ "khói tỏa sa mạc, muôn hình vạn trạng" để miêu tả một cách sâu sắc bức tranh lịch sử hoành tráng và tinh thần triết học cao cả kết tinh trong bản tổ khúc giao hưởng đậm chất sử thi này.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3291] [形式] (xíngshì) - hình thức, cách thức, thể thức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '形式' AND pinyin = 'xíngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形式' AND pinyin = 'xíngshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '形式'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形式'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xíngshì',
      meaning_vi = 'hình thức, cách thức, thể thức',
      example_hanzi = '任何文化普及与科普宣传活动都不能仅仅流于表面形式，而应当注重取得润物无声的实际成效。',
      example_pinyin = 'Rènhé wénhuà pǔjí yǔ kēpǔ xuānchuán huódòng dōu bùnéng jǐnjǐn liú yú biǎomiàn xíngshì, ér yīngdāng zhùzhòng qǔdé rùnwù-wúshēng de shíjì chéngxiào.',
      example_vi = 'Mọi hoạt động phổ biến văn hóa và tuyên truyền phổ biến khoa học đều không được chỉ chạy theo hình thức bên ngoài bề mặt, mà cần phải chú trọng đạt được hiệu quả thiết thực lan tỏa sâu sắc.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '形式',
      'xíngshì',
      'hình thức, cách thức, thể thức',
      'Danh từ',
      'HSK 5',
      '任何文化普及与科普宣传活动都不能仅仅流于表面形式，而应当注重取得润物无声的实际成效。',
      'Rènhé wénhuà pǔjí yǔ kēpǔ xuānchuán huódòng dōu bùnéng jǐnjǐn liú yú biǎomiàn xíngshì, ér yīngdāng zhùzhòng qǔdé rùnwù-wúshēng de shíjì chéngxiào.',
      'Mọi hoạt động phổ biến văn hóa và tuyên truyền phổ biến khoa học đều không được chỉ chạy theo hình thức bên ngoài bề mặt, mà cần phải chú trọng đạt được hiệu quả thiết thực lan tỏa sâu sắc.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '任何文化普及与科普宣传活动都不能仅仅流于表面形式，而应当注重取得润物无声的实际成效。', 'Rènhé wénhuà pǔjí yǔ kēpǔ xuānchuán huódòng dōu bùnéng jǐnjǐn liú yú biǎomiàn xíngshì, ér yīngdāng zhùzhòng qǔdé rùnwù-wúshēng de shíjì chéngxiào.', 'Mọi hoạt động phổ biến văn hóa và tuyên truyền phổ biến khoa học đều không được chỉ chạy theo hình thức bên ngoài bề mặt, mà cần phải chú trọng đạt được hiệu quả thiết thực lan tỏa sâu sắc.', 'basic', 1),
      (v_id, '基层党政机关必须坚决整治形式主义、官僚主义突出问题，切实精简会议文件，激励广大干部扑下身子真抓实干。', 'Jīcéng dǎng-zhèng jīgòu bìxū jiānjué zhěngzhì xíngshì zhǔyì, guānliáo zhǔyì tūchū wèntí, qièshí jīngjiǎn huìyì wénjiàn, jīlì guǎngdà gànbù pū xià shēnzi zhēn zhuā shí gàn.', 'Các cơ quan đảng chính quyền cơ sở bắt buộc phải kiên quyết chấn chỉnh những vấn đề nổi cộm của chủ nghĩa hình thức và quan liêu, tinh gọn thiết thực các văn bản hội họp, khích lệ đông đảo cán bộ xắn tay áo làm thật làm chuẩn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3292] [形势] (xíngshì) - hình thế, tình hình, cục diện [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '形势' AND pinyin = 'xíngshì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形势' AND pinyin = 'xíngshì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '形势'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形势'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xíngshì',
      meaning_vi = 'hình thế, tình hình, cục diện',
      example_hanzi = '面对严峻复杂的毕业生就业竞争形势，大学生应当提前做好职业规划并不断提升跨学科综合素养。',
      example_pinyin = 'Miànduì yánjùn fùzá de bìyèshēng jiùyè jìngzhēng xíngshì, dàxuéshēng yīngdāng tíqián zuò hǎo zhíyè guīhuà bìng bùduàn tíshēng kuà-xuékē zōnghé sùyǎng.',
      example_vi = 'Đối mặt với tình hình cạnh tranh việc làm của sinh viên tốt nghiệp gay gắt phức tạp, sinh viên đại học cần chuẩn bị kế hoạch phát triển sự nghiệp từ sớm và không ngừng trau dồi phẩm chất năng lực tổng hợp liên ngành.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '形势',
      'xíngshì',
      'hình thế, tình hình, cục diện',
      'Danh từ',
      'HSK 5',
      '面对严峻复杂的毕业生就业竞争形势，大学生应当提前做好职业规划并不断提升跨学科综合素养。',
      'Miànduì yánjùn fùzá de bìyèshēng jiùyè jìngzhēng xíngshì, dàxuéshēng yīngdāng tíqián zuò hǎo zhíyè guīhuà bìng bùduàn tíshēng kuà-xuékē zōnghé sùyǎng.',
      'Đối mặt với tình hình cạnh tranh việc làm của sinh viên tốt nghiệp gay gắt phức tạp, sinh viên đại học cần chuẩn bị kế hoạch phát triển sự nghiệp từ sớm và không ngừng trau dồi phẩm chất năng lực tổng hợp liên ngành.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '面对严峻复杂的毕业生就业竞争形势，大学生应当提前做好职业规划并不断提升跨学科综合素养。', 'Miànduì yánjùn fùzá de bìyèshēng jiùyè jìngzhēng xíngshì, dàxuéshēng yīngdāng tíqián zuò hǎo zhíyè guīhuà bìng bùduàn tíshēng kuà-xuékē zōnghé sùyǎng.', 'Đối mặt với tình hình cạnh tranh việc làm của sinh viên tốt nghiệp gay gắt phức tạp, sinh viên đại học cần chuẩn bị kế hoạch phát triển sự nghiệp từ sớm và không ngừng trau dồi phẩm chất năng lực tổng hợp liên ngành.', 'basic', 1),
      (v_id, '面对风云变幻的国际地缘政治博弈与全球经济增长乏力形势，国家宏观决策层沉着研判大势，牢牢把握高质量发展的战略主动权。', 'Miànduì fēngyún-biànhuàn de guójì dìyuán zhèngzhì bóyì yǔ quánqiú jīngjì zēngzhǎng fálì xíngshì, guójiā hóngguān juécècéng chénzhuó yánpàn dàshì, láoláo bǎwò gāozhìliàng fāzhǎn de zhànlüè zhǔdòngquán.', 'Đối mặt với cục diện cạnh tranh địa chính trị quốc tế biến đổi khôn lường và tăng trưởng kinh tế toàn cầu ảm đạm, cấp ra quyết định vĩ mô quốc gia đã bình tĩnh nhận định xu thế lớn, nắm chắc quyền chủ động chiến lược phát triển chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3293] [行驶] (xíngshǐ) - chạy, lăn bánh, lưu thông (xe, tàu bè) [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '行驶' AND pinyin = 'xíngshǐ'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行驶' AND pinyin = 'xíngshǐ'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '行驶'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行驶'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xíngshǐ',
      meaning_vi = 'chạy, lăn bánh, lưu thông (xe, tàu bè)',
      example_hanzi = '雨雪恶劣天气导致路面结冰湿滑，司机在高速公路上行驶时必须严格控制车速并保持安全车距。',
      example_pinyin = 'Yǔxuě èliè tiānqì dǎozhì lùmiàn jiébīng shīhuá, sījī zài gāosù gōnglù shàng xíngshǐ shí bìxū yángé kòngzhì chēsù bìng bǎochí ānquán chējù.',
      example_vi = 'Thời tiết mưa tuyết khắc nghiệt khiến mặt đường đóng băng trơn trượt, tài xế khi cho xe chạy trên đường cao tốc bắt buộc phải kiểm soát nghiêm ngặt tốc độ và giữ khoảng cách an toàn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '行驶',
      'xíngshǐ',
      'chạy, lăn bánh, lưu thông (xe, tàu bè)',
      'Động từ',
      'HSK 5',
      '雨雪恶劣天气导致路面结冰湿滑，司机在高速公路上行驶时必须严格控制车速并保持安全车距。',
      'Yǔxuě èliè tiānqì dǎozhì lùmiàn jiébīng shīhuá, sījī zài gāosù gōnglù shàng xíngshǐ shí bìxū yángé kòngzhì chēsù bìng bǎochí ānquán chējù.',
      'Thời tiết mưa tuyết khắc nghiệt khiến mặt đường đóng băng trơn trượt, tài xế khi cho xe chạy trên đường cao tốc bắt buộc phải kiểm soát nghiêm ngặt tốc độ và giữ khoảng cách an toàn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '雨雪恶劣天气导致路面结冰湿滑，司机在高速公路上行驶时必须严格控制车速并保持安全车距。', 'Yǔxuě èliè tiānqì dǎozhì lùmiàn jiébīng shīhuá, sījī zài gāosù gōnglù shàng xíngshǐ shí bìxū yángé kòngzhì chēsù bìng bǎochí ānquán chējù.', 'Thời tiết mưa tuyết khắc nghiệt khiến mặt đường đóng băng trơn trượt, tài xế khi cho xe chạy trên đường cao tốc bắt buộc phải kiểm soát nghiêm ngặt tốc độ và giữ khoảng cách an toàn.', 'basic', 1),
      (v_id, '具备高等级自动驾驶能力的智能无人重型集卡，在全自动化码头与港口物流园区内实现了全天候安全平稳行驶与毫米级精准对位装卸。', 'Jùbèi gāoděngjí zìdòng jiàshǐ nénglì de zhìnéng wúrén zhòngxíng jíkǎ, zài quán-zìdònghuà mǎtóu yǔ gǎngkǒu wùliú yuánqū nèi shíxiàn le quántiānhòu ānquán píngwěn xíngshǐ yǔ háomǐjí jīngzhǔn duìwèi zhuāngxiè.', 'Xe tải chở container hạng nặng tự hành thông minh có năng lực lái tự động cấp độ cao đã hiện thực hóa việc chạy xe an toàn êm thuận mọi lúc mọi nơi và xếp dỡ chuẩn xác đến từng milimet trong khu vực cảng biển tự động hóa hoàn toàn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3294] [行为] (xíngwéi) - hành vi, ứng xử, tư cách đạo đức [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '行为' AND pinyin = 'xíngwéi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行为' AND pinyin = 'xíngwéi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '行为'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行为'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xíngwéi',
      meaning_vi = 'hành vi, ứng xử, tư cách đạo đức',
      example_hanzi = '在公共图书馆等安静场所大声接听电话与随地乱扔垃圾，是不尊重他人权益的不文明行为。',
      example_pinyin = 'Zài gōnggòng túshūguǎn děng ānjìng chǎngsuǒ dàshēng jiētīng diànhuà yǔ suídì luàn rēng lājī, shì bù zūnzhòng tārén quányì de bù wénmíng xíngwéi.',
      example_vi = 'Nghe điện thoại to tiếng và vứt rác bừa bãi tại những nơi yên tĩnh như thư viện công cộng là hành vi thiếu văn minh không tôn trọng quyền lợi của người khác.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '行为',
      'xíngwéi',
      'hành vi, ứng xử, tư cách đạo đức',
      'Danh từ',
      'HSK 5',
      '在公共图书馆等安静场所大声接听电话与随地乱扔垃圾，是不尊重他人权益的不文明行为。',
      'Zài gōnggòng túshūguǎn děng ānjìng chǎngsuǒ dàshēng jiētīng diànhuà yǔ suídì luàn rēng lājī, shì bù zūnzhòng tārén quányì de bù wénmíng xíngwéi.',
      'Nghe điện thoại to tiếng và vứt rác bừa bãi tại những nơi yên tĩnh như thư viện công cộng là hành vi thiếu văn minh không tôn trọng quyền lợi của người khác.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在公共图书馆等安静场所大声接听电话与随地乱扔垃圾，是不尊重他人权益的不文明行为。', 'Zài gōnggòng túshūguǎn děng ānjìng chǎngsuǒ dàshēng jiētīng diànhuà yǔ suídì luàn rēng lājī, shì bù zūnzhòng tārén quányì de bù wénmíng xíngwéi.', 'Nghe điện thoại to tiếng và vứt rác bừa bãi tại những nơi yên tĩnh như thư viện công cộng là hành vi thiếu văn minh không tôn trọng quyền lợi của người khác.', 'basic', 1),
      (v_id, '证券监督管理机构依法从严查处上市公司财务造假、操纵市场行情与内幕交易等严重侵害中小投资者权益的资本市场违法违规行为。', 'Zhèngquàn jiāndū guǎnlǐ jīgòu yīfǎ cóngyán cháchǔ shàngshì gōngsī cáiwù zàojiǎ, cāozòng shìchǎng hángqíng yǔ nèimù jiāoyì děng yánzhòng qīnhài zhōng-xiǎo tóuzīzhě quányì de zīběn shìchǎng wéifǎ wéiguī xíngwéi.', 'Cơ quan quản lý giám sát chứng khoán điều tra xử lý nghiêm khắc theo pháp luật đối với các hành vi vi phạm pháp luật và quy chế trên thị trường vốn xâm phạm nghiêm trọng đến quyền lợi nhà đầu tư nhỏ lẻ như làm giả báo cáo tài chính của công ty niêm yết, thao túng thị trường và giao dịch nội gián.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3295] [形象] (xíngxiàng) - hình tượng, hình ảnh; sinh động trực quan [Danh từ / Tính từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '形象' AND pinyin = 'xíngxiàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形象' AND pinyin = 'xíngxiàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '形象'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形象'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ / Tính từ',
      pinyin = 'xíngxiàng',
      meaning_vi = 'hình tượng, hình ảnh; sinh động trực quan',
      example_hanzi = '优秀的人民教师在讲台上传授知识时，善于运用生动幽默的比喻将抽象深奥的概念形象地展现出来。',
      example_pinyin = 'Yōuxiù de rénmín jiàoshī zài jiǎngtái shàng chuánshòu zhīshi shí, shànyú yùnyòng shēngdòng yōumò de bǐyù jiāng chōuxiàng shēn’ào de gàiniàn xíngxiàng de zhǎnxiàn chūlái.',
      example_vi = 'Người thầy giáo nhân dân ưu tú khi truyền thụ kiến thức trên bục giảng rất giỏi sử dụng các phép ẩn dụ sinh động hài hước để diễn giải những khái niệm trừu tượng thâm sâu một cách vô cùng hình tượng.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '形象',
      'xíngxiàng',
      'hình tượng, hình ảnh; sinh động trực quan',
      'Danh từ / Tính từ',
      'HSK 5',
      '优秀的人民教师在讲台上传授知识时，善于运用生动幽默的比喻将抽象深奥的概念形象地展现出来。',
      'Yōuxiù de rénmín jiàoshī zài jiǎngtái shàng chuánshòu zhīshi shí, shànyú yùnyòng shēngdòng yōumò de bǐyù jiāng chōuxiàng shēn’ào de gàiniàn xíngxiàng de zhǎnxiàn chūlái.',
      'Người thầy giáo nhân dân ưu tú khi truyền thụ kiến thức trên bục giảng rất giỏi sử dụng các phép ẩn dụ sinh động hài hước để diễn giải những khái niệm trừu tượng thâm sâu một cách vô cùng hình tượng.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '优秀的人民教师在讲台上传授知识时，善于运用生动幽默的比喻将抽象深奥的概念形象地展现出来。', 'Yōuxiù de rénmín jiàoshī zài jiǎngtái shàng chuánshòu zhīshi shí, shànyú yùnyòng shēngdòng yōumò de bǐyù jiāng chōuxiàng shēn’ào de gàiniàn xíngxiàng de zhǎnxiàn chūlái.', 'Người thầy giáo nhân dân ưu tú khi truyền thụ kiến thức trên bục giảng rất giỏi sử dụng các phép ẩn dụ sinh động hài hước để diễn giải những khái niệm trừu tượng thâm sâu một cách vô cùng hình tượng.', 'basic', 1),
      (v_id, '国家软实力传播工程深入挖掘中华优秀传统文化的时代精神内核，向世界立体展现可信、可爱、可敬的现代东方大国文明形象。', 'Guójiā ruǎnshílì chuánbō gōngchéng shēnrù wājué Zhōnghuá yōuxiù chuántǒng wénhuà de shídài jīngshén nèihé, xiàng shìjiè lìtǐ zhǎnxiàn kěxìn, kě’ài, kějìng de xiàndài Dōngfāng dàguó wénmíng xíngxiàng.', 'Đề án truyền thông sức mạnh mềm quốc gia khai thác sâu sắc cốt lõi tinh thần thời đại của văn hóa truyền thống ưu tú Trung Hoa, khắc họa đa chiều trước thế giới hình ảnh một nền văn minh nước lớn phương Đông hiện đại đáng tin, đáng yêu và đáng kính.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3296] [形状] (xíngzhuàng) - hình dáng, hình dạng [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '形状' AND pinyin = 'xíngzhuàng'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形状' AND pinyin = 'xíngzhuàng'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '形状'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '形状'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xíngzhuàng',
      meaning_vi = 'hình dáng, hình dạng',
      example_hanzi = '仰望天空中随风变幻的白云，它们的形状千姿百态，有的像奔腾的骏马，有的宛如险峻的山峰。',
      example_pinyin = 'Yǎngwàng tiānkōng zhōng suí fēng biànhuàn de báiyún, tāmen de xíngzhuàng qiānzī-bǎitài, yǒu de xiàng bēnténg de jùnmǎ, yǒu de wǎnrú xiǎnjùn de shānfēng.',
      example_vi = 'Ngước nhìn những đám mây trắng biến ảo theo làn gió trên nền trời, hình dáng của chúng thiên hình vạn trạng, có đám như tuấn mã phi nước đại, có đám tựa đỉnh núi hiểm trở cheo leo.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '形状',
      'xíngzhuàng',
      'hình dáng, hình dạng',
      'Danh từ',
      'HSK 5',
      '仰望天空中随风变幻的白云，它们的形状千姿百态，有的像奔腾的骏马，有的宛如险峻的山峰。',
      'Yǎngwàng tiānkōng zhōng suí fēng biànhuàn de báiyún, tāmen de xíngzhuàng qiānzī-bǎitài, yǒu de xiàng bēnténg de jùnmǎ, yǒu de wǎnrú xiǎnjùn de shānfēng.',
      'Ngước nhìn những đám mây trắng biến ảo theo làn gió trên nền trời, hình dáng của chúng thiên hình vạn trạng, có đám như tuấn mã phi nước đại, có đám tựa đỉnh núi hiểm trở cheo leo.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '仰望天空中随风变幻的白云，它们的形状千姿百态，有的像奔腾的骏马，有的宛如险峻的山峰。', 'Yǎngwàng tiānkōng zhōng suí fēng biànhuàn de báiyún, tāmen de xíngzhuàng qiānzī-bǎitài, yǒu de xiàng bēnténg de jùnmǎ, yǒu de wǎnrú xiǎnjùn de shānfēng.', 'Ngước nhìn những đám mây trắng biến ảo theo làn gió trên nền trời, hình dáng của chúng thiên hình vạn trạng, có đám như tuấn mã phi nước đại, có đám tựa đỉnh núi hiểm trở cheo leo.', 'basic', 1),
      (v_id, '航空复合材料力学实验室利用超快激光干涉仪与高分辨率显微断层扫描，精确测量复杂异形机翼蒙皮在极端气动载荷下的微观形变形状。', 'Hángkōng fùhé cáiliào lìxué shíyànshì lìyòng chāokuài jīguāng gānshèyí yǔ gāofēnbànlǜ xiǎnwēi duàncéng sǎomiáo, jīngquè cèliáng fùzá yìxíng jīyì méngpí zài jíduān qìdòng zàihè xià de wēiguān xíngbiàn xíngzhuàng.', 'Phòng thí nghiệm cơ học vật liệu composite hàng không sử dụng giao thoa kế laser siêu nhanh và máy quét vi cắt lớp phân giải cao để đo đạc chuẩn xác hình dạng biến dạng vi mô của lớp vỏ cánh máy bay dị hình phức tạp dưới tải trọng khí động học cực hạn.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3297] [行走] (xíngzǒu) - bước đi, đi lại, di chuyển bộ [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '行走' AND pinyin = 'xíngzǒu'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行走' AND pinyin = 'xíngzǒu'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '行走'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '行走'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xíngzǒu',
      meaning_vi = 'bước đi, đi lại, di chuyển bộ',
      example_hanzi = '每天晚餐后在空气清新的湖畔绿道上快步行走半小时，是一种经济环保且极佳的有氧健身方式。',
      example_pinyin = 'Měitiān wǎncān hòu zài kōngqì qīngxīn de húpàn lǜdào shàng kuàibù xíngzǒu bàn xiǎoshí, shì yī zhǒng jīngjì huánbǎo qiě jíjiā de yǒuyǎng jiànshēn fāngshì.',
      example_vi = 'Mỗi ngày sau bữa tối đi bộ nhanh nửa tiếng trên con đường xanh ven hồ không khí trong lành là một cách rèn luyện thể lực hiếu khí vô cùng tuyệt vời, vừa kinh tế lại thân thiện với môi trường.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '行走',
      'xíngzǒu',
      'bước đi, đi lại, di chuyển bộ',
      'Động từ',
      'HSK 5',
      '每天晚餐后在空气清新的湖畔绿道上快步行走半小时，是一种经济环保且极佳的有氧健身方式。',
      'Měitiān wǎncān hòu zài kōngqì qīngxīn de húpàn lǜdào shàng kuàibù xíngzǒu bàn xiǎoshí, shì yī zhǒng jīngjì huánbǎo qiě jíjiā de yǒuyǎng jiànshēn fāngshì.',
      'Mỗi ngày sau bữa tối đi bộ nhanh nửa tiếng trên con đường xanh ven hồ không khí trong lành là một cách rèn luyện thể lực hiếu khí vô cùng tuyệt vời, vừa kinh tế lại thân thiện với môi trường.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '每天晚餐后在空气清新的湖畔绿道上快步行走半小时，是一种经济环保且极佳的有氧健身方式。', 'Měitiān wǎncān hòu zài kōngqì qīngxīn de húpàn lǜdào shàng kuàibù xíngzǒu bàn xiǎoshí, shì yī zhǒng jīngjì huánbǎo qiě jíjiā de yǒuyǎng jiànshēn fāngshì.', 'Mỗi ngày sau bữa tối đi bộ nhanh nửa tiếng trên con đường xanh ven hồ không khí trong lành là một cách rèn luyện thể lực hiếu khí vô cùng tuyệt vời, vừa kinh tế lại thân thiện với môi trường.', 'basic', 1),
      (v_id, '智能医疗康复工程团队成功研制出基于脑机接口感知的柔性下肢外骨骼机器人，精准辅助中风偏瘫患者恢复独立站立与协调行走能力。', 'Zhìnéng yīliáo kāngfù gōngchéng tuánduì chénggōng yánzhì chū jīyú nǎojī jiēkǒu gǎnzhī de róuxìng xiàzhī wàigǔgé jīqìrén, jīngzhǔn fùzhù zhòngfēng piāntān huànzhě huìfù dúlì zhànlì yǔ xiétóng xíngzǒu nénglì.', 'Đội ngũ kỹ thuật phục hồi chức năng y tế thông minh đã nghiên cứu chế tạo thành công robot khung xương ngoài chi dưới mềm dẻo dựa trên cảm biến giao diện não - máy tính BCI, hỗ trợ chuẩn xác cho bệnh nhân tai biến liệt nửa người hồi phục khả năng đứng độc lập và bước đi phối hợp.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3298] [幸运] (xìngyùn) - may mắn; vận may, sự may mắn [Tính từ / Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '幸运' AND pinyin = 'xìngyùn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '幸运' AND pinyin = 'xìngyùn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '幸运'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '幸运'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Tính từ / Danh từ',
      pinyin = 'xìngyùn',
      meaning_vi = 'may mắn; vận may, sự may mắn',
      example_hanzi = '能够在青春年华遇到一位言传身教、循循善诱的好导师，是他整个求学求索道路上最幸运的收获。',
      example_pinyin = 'Nénggòu zài qīngchūn niánhuá yù dào yī wèi yánchuán-shēnjiào, xúnxún-shànyòu de hǎo dǎoshī, shì tā zhěng gè qiúxué qiúsuǒ dàolù shàng zuì xìngyùn de shōuhuò.',
      example_vi = 'Có thể gặp gỡ một người thầy tốt dùng lời hay gương sáng chỉ bảo từng bước trong những năm tháng tuổi trẻ chính là thành quả may mắn nhất trên suốt con đường học tập tìm tòi của cậu ấy.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '幸运',
      'xìngyùn',
      'may mắn; vận may, sự may mắn',
      'Tính từ / Danh từ',
      'HSK 5',
      '能够在青春年华遇到一位言传身教、循循善诱的好导师，是他整个求学求索道路上最幸运的收获。',
      'Nénggòu zài qīngchūn niánhuá yù dào yī wèi yánchuán-shēnjiào, xúnxún-shànyòu de hǎo dǎoshī, shì tā zhěng gè qiúxué qiúsuǒ dàolù shàng zuì xìngyùn de shōuhuò.',
      'Có thể gặp gỡ một người thầy tốt dùng lời hay gương sáng chỉ bảo từng bước trong những năm tháng tuổi trẻ chính là thành quả may mắn nhất trên suốt con đường học tập tìm tòi của cậu ấy.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '能够在青春年华遇到一位言传身教、循循善诱的好导师，是他整个求学求索道路上最幸运的收获。', 'Nénggòu zài qīngchūn niánhuá yù dào yī wèi yánchuán-shēnjiào, xúnxún-shànyòu de hǎo dǎoshī, shì tā zhěng gè qiúxué qiúsuǒ dàolù shàng zuì xìngyùn de shōuhuò.', 'Có thể gặp gỡ một người thầy tốt dùng lời hay gương sáng chỉ bảo từng bước trong những năm tháng tuổi trẻ chính là thành quả may mắn nhất trên suốt con đường học tập tìm tòi của cậu ấy.', 'basic', 1),
      (v_id, '卓越的高科技创新创业先锋深刻懂得，商业世界中所谓的“幸运”契机，永远只垂青于那些数十年如一日深耕关键核心底层技术的笃行者。', 'Zhuóyuè de gāokējì chuàngxīn chuàngyè xiānfēng shēnkè dǒngde, shāngyè shìjiè zhōng suǒwèi de “xìngyùn” qìjī, yǒngyuǎn zhǐ chuíqīng yú nàxiē shù shí nián rú yī rì shēngēng guānjiàn héxīn dǐcéng jìshù de dǔxíngzhě.', 'Những người tiên phong đổi mới khởi nghiệp công nghệ cao xuất sắc hiểu sâu sắc rằng, cái gọi là thời cơ "may mắn" trong thế giới kinh doanh sẽ luôn chỉ ưu ái những người kiên trì hành động bền bỉ, hàng chục năm như một miệt mài gieo mầm nơi công nghệ tầng đáy cốt lõi then chốt.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3299] [性质] (xìngzhì) - tính chất, bản chất [Danh từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '性质' AND pinyin = 'xìngzhì'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '性质' AND pinyin = 'xìngzhì'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '性质'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '性质'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Danh từ',
      pinyin = 'xìngzhì',
      meaning_vi = 'tính chất, bản chất',
      example_hanzi = '物理性质与化学性质是自然科学课程中用来系统鉴别不同纯净物质的两个基本属性范畴。',
      example_pinyin = 'Wùlǐ xìngzhì yǔ huàxué xìngzhì shì zìrán kēxué kèchéng zhōng yòng lái xìtǒng jiànbié bùtóng chúnjìng wùzhì de liǎng gè jīběn shǔxìng fànchóu.',
      example_vi = 'Tính chất vật lý và tính chất hóa học là hai phạm trù thuộc tính cơ bản được dùng để nhận biết một cách có hệ thống các chất tinh khiết khác nhau trong chương trình khoa học tự nhiên.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '性质',
      'xìngzhì',
      'tính chất, bản chất',
      'Danh từ',
      'HSK 5',
      '物理性质与化学性质是自然科学课程中用来系统鉴别不同纯净物质的两个基本属性范畴。',
      'Wùlǐ xìngzhì yǔ huàxué xìngzhì shì zìrán kēxué kèchéng zhōng yòng lái xìtǒng jiànbié bùtóng chúnjìng wùzhì de liǎng gè jīběn shǔxìng fànchóu.',
      'Tính chất vật lý và tính chất hóa học là hai phạm trù thuộc tính cơ bản được dùng để nhận biết một cách có hệ thống các chất tinh khiết khác nhau trong chương trình khoa học tự nhiên.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '物理性质与化学性质是自然科学课程中用来系统鉴别不同纯净物质的两个基本属性范畴。', 'Wùlǐ xìngzhì yǔ huàxué xìngzhì shì zìrán kēxué kèchéng zhōng yòng lái xìtǒng jiànbié bùtóng chúnjìng wùzhì de liǎng gè jīběn shǔxìng fànchóu.', 'Tính chất vật lý và tính chất hóa học là hai phạm trù thuộc tính cơ bản được dùng để nhận biết một cách có hệ thống các chất tinh khiết khác nhau trong chương trình khoa học tự nhiên.', 'basic', 1),
      (v_id, '司法审判机关在审理涉及新型金融衍生品交易纠纷案件时，必须穿透复杂的商业交易外观，依法准确认定其民商事实质与法律行为性质。', 'Sīfǎ shěnpàn jīgòu zài shěnlǐ shèjí xīnxíng jīnróng yǎnshēngpǐn jiāoyì jiūfēn ànjiàn shí, bìxū chuāntòu fùzá de shāngyè jiāoyì wàiguān, yīfǎ zhǔnquè rèndìng qí mín-shāngshì shízhì yǔ fǎlǜ xíngwéi xìngzhì.', 'Cơ quan xét xử tư pháp khi thụ lý xét xử các vụ án tranh chấp giao dịch phái sinh tài chính kiểu mới bắt buộc phải nhìn xuyên qua vẻ bề ngoài giao dịch thương mại phức tạp, xác định chuẩn xác bản chất dân sự - thương mại thực tế và tính chất hành vi pháp lý của chúng theo pháp luật.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3300] [修改] (xiūgǎi) - sửa đổi, chỉnh sửa, tu chỉnh [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '修改' AND pinyin = 'xiūgǎi'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '修改' AND pinyin = 'xiūgǎi'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '修改'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '修改'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiūgǎi',
      meaning_vi = 'sửa đổi, chỉnh sửa, tu chỉnh',
      example_hanzi = '在正式提交学术毕业论文之前，请务必按照评审专家提出的建设性反馈意见反复推敲并认真修改。',
      example_pinyin = 'Zài zhèngshì tíjiāo xuéshù bìyè lùnwén zhīqián, qǐng wùbì ànzhào píngshěn zhuānjiā tíchū de jiànshèxìng fǎnkuì yìjiàn fǎnfù tuīqiāo bìng rènzhēn xiūgǎi.',
      example_vi = 'Trước khi chính thức nộp luận văn tốt nghiệp học thuật, xin nhất định phải cân nhắc kỹ lưỡng và nghiêm túc chỉnh sửa theo những ý kiến phản hồi mang tính xây dựng của các chuyên gia chấm điểm.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '修改',
      'xiūgǎi',
      'sửa đổi, chỉnh sửa, tu chỉnh',
      'Động từ',
      'HSK 5',
      '在正式提交学术毕业论文之前，请务必按照评审专家提出的建设性反馈意见反复推敲并认真修改。',
      'Zài zhèngshì tíjiāo xuéshù bìyè lùnwén zhīqián, qǐng wùbì ànzhào píngshěn zhuānjiā tíchū de jiànshèxìng fǎnkuì yìjiàn fǎnfù tuīqiāo bìng rènzhēn xiūgǎi.',
      'Trước khi chính thức nộp luận văn tốt nghiệp học thuật, xin nhất định phải cân nhắc kỹ lưỡng và nghiêm túc chỉnh sửa theo những ý kiến phản hồi mang tính xây dựng của các chuyên gia chấm điểm.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '在正式提交学术毕业论文之前，请务必按照评审专家提出的建设性反馈意见反复推敲并认真修改。', 'Zài zhèngshì tíjiāo xuéshù bìyè lùnwén zhīqián, qǐng wùbì ànzhào píngshěn zhuānjiā tíchū de jiànshèxìng fǎnkuì yìjiàn fǎnfù tuīqiāo bìng rènzhēn xiūgǎi.', 'Trước khi chính thức nộp luận văn tốt nghiệp học thuật, xin nhất định phải cân nhắc kỹ lưỡng và nghiêm túc chỉnh sửa theo những ý kiến phản hồi mang tính xây dựng của các chuyên gia chấm điểm.', 'basic', 1),
      (v_id, '全国人大常委会法工委广泛吸纳社会各界立法建言，对涉及数字经济知识产权保护与反不正当竞争的法律条文作出了系统性修改与完善。', 'Quánguó Réndà Chángwěihuì fǎgōngwěi guǎngfàn xīnà shèhuì gèjiè lìfǎ jiànyán, duì shèjí shùzì jīngjì zhīshi chǎnquán bǎohù yǔ fǎn-bùzhèngdàng jìngzhēng de fǎlǜ tiáowén zuòchū le xìtǒngxìng xiūgǎi yǔ wánshàn.', 'Ban Công tác Lập pháp thuộc Ủy ban Thường vụ Đại hội Đại biểu Nhân dân Toàn quốc đã tiếp thu rộng rãi các đề xuất lập pháp từ các giới xã hội, tiến hành sửa đổi và hoàn thiện một cách có hệ thống các điều khoản luật liên quan đến bảo vệ sở hữu trí tuệ kinh tế số và chống cạnh tranh không lành mạnh.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  -- [3301] [修建] (xiūjiàn) - xây dựng, thi công, kiến thiết [Động từ]
  SELECT id INTO v_id FROM public.vocabularies 
  WHERE hsk_level = 'HSK 5' AND hanzi = '修建' AND pinyin = 'xiūjiàn'
  LIMIT 1;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '修建' AND pinyin = 'xiūjiàn'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hsk_level = 'HSK 5' AND hanzi = '修建'
    LIMIT 1;
  END IF;

  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM public.vocabularies 
    WHERE hanzi = '修建'
    LIMIT 1;
  END IF;

  IF v_id IS NOT NULL THEN
    UPDATE public.vocabularies
    SET 
      hsk_level = 'HSK 5',
      word_type = 'Động từ',
      pinyin = 'xiūjiàn',
      meaning_vi = 'xây dựng, thi công, kiến thiết',
      example_hanzi = '经过建设者们历时两年的艰苦奋战，横跨大江两岸的现代化双向六车道斜拉大桥终于提前修建完成。',
      example_pinyin = 'Jīngguò jiànshèzhěmen lìshí liǎng nián de jiānkǔ fènzhàn, héngkuà dàjiāng liǎng’àn de xiàndàihuà shuāngxiàng liù chēdào xiélā dàqiáo zhōngyú tíqián xiūjiàn wánchéng.',
      example_vi = 'Sau hai năm chiến đấu gian khổ của các người thợ xây dựng, cây cầu dây văng hiện đại sáu làn xe hai chiều bắc qua hai bờ sông lớn cuối cùng đã được thi công xây dựng hoàn thành trước thời hạn.'
    WHERE id = v_id;
  ELSE
    INSERT INTO public.vocabularies (
      hanzi, pinyin, meaning_vi, word_type, hsk_level, 
      example_hanzi, example_pinyin, example_vi
    )
    VALUES (
      '修建',
      'xiūjiàn',
      'xây dựng, thi công, kiến thiết',
      'Động từ',
      'HSK 5',
      '经过建设者们历时两年的艰苦奋战，横跨大江两岸的现代化双向六车道斜拉大桥终于提前修建完成。',
      'Jīngguò jiànshèzhěmen lìshí liǎng nián de jiānkǔ fènzhàn, héngkuà dàjiāng liǎng’àn de xiàndàihuà shuāngxiàng liù chēdào xiélā dàqiáo zhōngyú tíqián xiūjiàn wánchéng.',
      'Sau hai năm chiến đấu gian khổ của các người thợ xây dựng, cây cầu dây văng hiện đại sáu làn xe hai chiều bắc qua hai bờ sông lớn cuối cùng đã được thi công xây dựng hoàn thành trước thời hạn.'
    )
    RETURNING id INTO v_id;
  END IF;

  IF v_id IS NOT NULL THEN
    DELETE FROM public.vocabulary_examples WHERE vocabulary_id = v_id;

    INSERT INTO public.vocabulary_examples (vocabulary_id, chinese, pinyin, meaning_vi, difficulty_level, order_index)
    VALUES
      (v_id, '经过建设者们历时两年的艰苦奋战，横跨大江两岸的现代化双向六车道斜拉大桥终于提前修建完成。', 'Jīngguò jiànshèzhěmen lìshí liǎng nián de jiānkǔ fènzhàn, héngkuà dàjiāng liǎng’àn de xiàndàihuà shuāngxiàng liù chēdào xiélā dàqiáo zhōngyú tíqián xiūjiàn wánchéng.', 'Sau hai năm chiến đấu gian khổ của các người thợ xây dựng, cây cầu dây văng hiện đại sáu làn xe hai chiều bắc qua hai bờ sông lớn cuối cùng đã được thi công xây dựng hoàn thành trước thời hạn.', 'basic', 1),
      (v_id, '我国在终年高原冻土带与极端地质断裂带攻克世界级工程技术难题，成功修建建成高标准、高质量的战略高原电气化铁路大通道。', 'Wǒguó zài zhōngnián gāoyuán dòngtǔdài yǔ jíduān dìzhì duànlièdài gōngkè shìjièjí gōngchéng jìshù nándiǎn, chénggōng xiūjiàn jiànchéng gāobiāozhǔn, gāozhìliàng de zhànlüè gāoyuán diànqìhuà tiělù dà tōngdào.', 'Nước ta đã khắc phục những vấn đề kỹ thuật công trình tầm cỡ thế giới trên vùng đất đóng băng vĩnh cửu cao nguyên và đới đứt gãy địa chất cực đoan, thi công xây dựng thành công đại hành lang đường sắt điện khí hóa cao nguyên chiến lược đạt chuẩn cao và chất lượng cao.', 'applied', 2);

    v_count := v_count + 1;
  END IF;

  RAISE NOTICE 'Hoàn tất cập nhật HSK 5 - Batch 13! Tổng số từ đã xử lý: %', v_count;
END $$;
